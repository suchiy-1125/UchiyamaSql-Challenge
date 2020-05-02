-- DROP TABLE IF EXISTS employees
-- DROP TABLE IF EXISTS dept_manager

--Data Enginnering

CREATE TABLE employees (
	emp_no int PRIMARY KEY
	, birth_date date NOT NULL
	, first_name VARCHAR NOT NULL
	, last_name VARCHAR NOT NULL
	, gender VARCHAR(1) NOT NULL
	, hire_date date NOT NULL
);

SELECT *
FROM employees

CREATE TABLE department (
	dept_no VARCHAR PRIMARY KEY
	, dept_name VARCHAR NOT NULL
);

SELECT *
FROM department
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL
	, emp_no int NOT NULL
	, from_date date NOT NULL
	, to_date date NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
		FOREIGN KEY (dept_no) REFERENCES department(dept_no)
);
SELECT *
FROM dept_manager

CREATE TABLE dept_employee (
	emp_no int NOT NULL
	, dept_no VARCHAR NOT NULL
	, from_date date NOT NULL
	, to_date date NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
		FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT *
FROM dept_employee

CREATE TABLE salaries (
	emp_no int NOT NULL
	, salary int NOT NULL
	, from_date date NOT NULL
	, to_date date NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM salaries
CREATE TABLE titles (
	emp_no int NOT NULL
	, title VARCHAR NOT NULL
	, from_date date NOT NULL
	, to_date date NOT NULL,
		FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM titles



--Data Analysis
-- --1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT 
	employees.emp_no
	,last_name
	,first_name
	,gender
	,salary
FROM employees
INNER JOIN 
	salaries
ON employees.emp_no = salaries.emp_no;

-- 2. List employees who were hired in 1986.
SELECT emp_no, first_name, last_name, hire_date 
FROM Employees
WHERE hire_date >= '1985-12-31'
AND hire_date < '1987-01-01';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no
	, department.dept_name
	, dept_manager.emp_no
	, employees.last_name
	, employees.first_name
	, dept_manager.from_date
	, dept_manager.to_date 
FROM dept_manager
INNER JOIN department
ON dept_manager.dept_no = department.dept_no
INNER JOIN employees 
ON dept_manager.emp_no = employees.emp_no; 

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no
	, employees.last_name
	, employees.first_name
	, department.dept_name
FROM employees
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN department
ON dept_manager.dept_no = department.dept_no
		
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name = 'Hercules' 
AND last_name like 'B%'; 

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no
	, employees.last_name
	, employees.first_name
	, department.dept_name
FROM employees
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN department
ON dept_manager.dept_no = department.dept_no
WHERE dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no
	, employees.last_name
	, employees.first_name
	, department.dept_name
FROM employees
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
INNER JOIN department
ON dept_manager.dept_no = department.dept_no
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name
	, COUNT(last_name) 
FROM employees
GROUP BY last_name
ORDER BY count(last_name) desc;
