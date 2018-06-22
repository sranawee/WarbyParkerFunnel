---survey completion rate, quiz funnel--- 
 
 SELECT question, COUNT (DISTINCT user_id)
 FROM survey
 GROUP BY question;


---tables in home try-on---
 SELECT *
 FROM quiz
 LIMIT 5;
 
 SELECT *
 FROM home_try_on
 LIMIT 5;
 
 SELECT *
 FROM purchase
 LIMIT 5;



---total purchase---
 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(DISTINCT user_id)
FROM warby_parker
WHERE is_purchase = 1;

---total users---

 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(DISTINCT user_id)
FROM warby_parker;


---users who purchased---

 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(DISTINCT user_id)
FROM warby_parker
WHERE is_purchase = 1;


---5 pairs---
 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(user_id)
FROM warby_parker
WHERE number_of_pairs = "5 pairs"
	AND is_purchase = 1;


---3 pairs---
 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(user_id)
FROM warby_parker
WHERE number_of_pairs = "3 pairs"
	AND is_purchase = 1;



---most purchased by number of pairs and price---
SELECT COUNT(p.user_id), p.price, number_of_pairs
FROM purchase AS p
JOIN home_try_on AS h
	ON p.user_id = h.user_id
GROUP BY price
ORDER BY 1 DESC;


---conversion within funnel---
 WITH warby_parker AS (
   SELECT DISTINCT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
  ON p.user_id = q.user_id)
  
SELECT COUNT(*) AS 'num_quiz_takers',
   SUM(is_home_try_on) AS 'num_try_on',
   SUM(is_purchase) AS 'num_purchased',
   1.0 * SUM(is_home_try_on) / COUNT(user_id) AS 'browse_to_try_on',
   1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'try_on_to_purchase'
FROM warby_parker;

---most purchased model---

 SELECT COUNT(DISTINCT user_id),model_name
 FROM purchase
 GROUP BY model_name;

---preferred shape---
 SELECT COUNT(DISTINCT user_id), shape
 FROM quiz
 GROUP BY shape
 ORDER BY 1 DESC;
 
 
 ---preferred color---
 SELECT COUNT(DISTINCT user_id), color
 FROM quiz
 GROUP BY color
 ORDER BY 1 DESC;
 