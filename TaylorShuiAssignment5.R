# Taylor Shui (tss7)
# DSCI 304 - Assignment 5

# Load in data:

movies_data <- read.csv("blockbuster-top_ten_movies_per_year_DFE.csv")


# Load necessary packages:

library(ggplot2)
library(gifski)
library(png)
library(gganimate)
library(plotly)
library(scales)
library(tidyverse)
library(htmlwidgets)
library(crosstalk)

# Problem 1:

movies_data <- movies_data[movies_data$year >= 1990 & movies_data$year <= 2014, ]
movies_data <- movies_data %>% filter(grepl('Action', Genre_1) | grepl('Comedy', Genre_1) | grepl('Drama', Genre_1) | 
                                        grepl('Romance', Genre_1) | grepl('Sci-Fi', Genre_1))

movies_data$worldwide_gross_numeric <-as.numeric(gsub('[$,]', '', movies_data$worldwide_gross))
  



plot1 <-ggplot(movies_data, aes(x = year, y = worldwide_gross_numeric, group = Genre_1, color = Genre_1)) +
  geom_line() +
  labs(color = "Genre", x = "Year", y = "Worldwide Gross", subtitle = '{frame_along}') +
  ggtitle("Total Worldwide Gross by Movie Genre (1990-2014)") +
  theme(plot.title = element_text(hjust = 0.5, size = 20)) +
  theme(axis.text.x = element_text(angle = 90))

 
plot1_animated <- plot1 + transition_reveal(year)
animate(plot1_animated, renderer = gifski_renderer())
 

# Problem 2:

movies_data$year2 <- movies_data$year
movies_data$worlwide_gross_numeric2 <- movies_data$worldwide_gross_numeric

plot2 <- ggplot(movies_data, aes(x = year, y = worldwide_gross_numeric, group = Genre_1, color = Genre_1, frame = Genre_1)) +
  geom_point(aes(text = title, text2 = year2, text3 = worlwide_gross_numeric2)) +
  geom_line() +
  labs(color = "Genre", x = "Year", y = "Worldwide Gross") +
  ggtitle("Total Worldwide Gross by Movie Genre (1990-2014)") +
  theme(plot.title = element_text(hjust = 0.5, size = 20)) +
  theme(axis.text.x = element_text(angle = 90))

 
ggplotly(plot2, tooltip = c("text", "text2", "text3"))
