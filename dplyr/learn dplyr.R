library(dplyr)
library(hflights)
library(ggplot2)

# filter : 관측치 접근
# select : 변수 접근
# arrange : 정렬
# mutate : 새로운 변수 만들기 (새로 만든 변수로 또 새로운 변수 만들기 가능)
# group_by : 그룹화
# summerise : 통계량 접근 가능 (전체 또는 그룹에 대하여)

hflights_df <- hflights %>% tbl_df() # 이렇게 하면 출력 때 용이함.
hflights_df


hflights_df %>% filter(Month == 5,
                       DayofMonth == 31)

hflights_df %>% select(CancellationCode) %>% unique()
hflights_df %>% select(CancellationCode) %>% distinct()

all_delay <- hflights_df %>% select(Origin, Dest, ArrDelay, DepDelay) %>%
                             mutate(All_Delay = ArrDelay + DepDelay)

all_delay %>% arrange(desc(All_Delay)) 

all_delay %>% group_by(Origin, Dest) %>%
              summarise(delay_mean = mean(All_Delay, na.rm = T)) %>%
              arrange(delay_mean)

all_delay %>% group_by(Origin, Dest) %>%
              summarise(delay_mean = mean(All_Delay, na.rm = T)) %>%
              arrange(desc(delay_mean))


a <- hflights_df %>% filter(Month == 5,
                       DayofMonth == 31) %>%
                     select(ArrDelay, DepDelay, Origin)

a %>% ggplot(aes(ArrDelay, DepDelay, group=Origin, color=Origin)) +
      geom_point(alpha = 0.3) +
      geom_smooth()
