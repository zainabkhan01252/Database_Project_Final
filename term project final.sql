CREATE TABLE university_professors (
    firstname TEXT,
    lastname TEXT,
    university TEXT,
    university_shortname TEXT,
    university_city TEXT,
    function TEXT,
    organization TEXT,
    organization_sector TEXT
);
--import university_professors.csv into the above created table
 
-- relationship and creation of table
-- Professors
CREATE TABLE professors (
    id SERIAL PRIMARY KEY,
    firstname TEXT,
    lastname TEXT,
    university_shortname TEXT
);

-- Universities
CREATE TABLE universities (
    university_shortname TEXT PRIMARY KEY,
    university TEXT,
    university_city TEXT
);

-- Organizations
CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    organization TEXT,
    organization_sector TEXT
);


-- Affiliations
CREATE TABLE affiliations (
    id SERIAL PRIMARY KEY,
    professor_id INT REFERENCES professors(id),
    organization_id INT REFERENCES organizations(id),
    function TEXT
);

-- insertion of data 
INSERT INTO universities (university_shortname, university, university_city)
SELECT DISTINCT university_shortname, university, university_city
FROM university_professors;

INSERT INTO professors (firstname, lastname, university_shortname)
SELECT DISTINCT first_name, lastname, university_shortname
FROM university_professors;

INSERT INTO organizations (organization, organization_sector)
SELECT DISTINCT organization, organization_sector
FROM university_professors;

INSERT INTO affiliations (professor_id, organization_id, function)
SELECT
    p.id,
    o.id,
    up.function
FROM university_professors up
JOIN professors p ON p.firstname = up.first_name AND p.lastname = up.lastname
JOIN organizations o ON o.organization = up.organization;



ALTER TABLE professors
ADD CONSTRAINT fk_university FOREIGN KEY (university_shortname)
REFERENCES universities (university_shortname);

