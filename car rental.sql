/* Car Rental Database */

/* Vehicle */
CREATE TABLE Vehicle (
  vehicleNumber CHAR(7),  -- including the dash in the number plate.
  makeAndModel VARCHAR(100),
  engineNumber CHAR(10),
  chassisNumber CHAR(6),
  fuelType VARCHAR(10),

  CONSTRAINT vehiclePk PRIMARY KEY (vehicleNumber),
  CONSTRAINT checkFuelType CHECK (fuelType = 'petrol' OR fuelType = 'diesel')
);


/* Rate */
CREATE TABLE Rate (
  vehicleNumber CHAR(7),
  dailyRate DOUBLE NOT NULL,
  weeklyRate DOUBLE NOT NULL,
  monthlyRate DOUBLE NOT NULL,
  allowedKmPerDay DOUBLE NOT NULL,
  costPerExtraKm DOUBLE NOT NULL,

  CONSTRAINT ratePk PRIMARY KEY (vehicleNumber),
  CONSTRAINT rateVehicleFk FOREIGN KEY (vehicleNumber) REFERENCES Vehicle(vehicleNumber)
);


/* Constraint */
CREATE TABLE Customer (
  customerNic CHAR(10), -- 123456789V
  licenseNumber CHAR(8) NOT NULL,
  customerName VARCHAR(100),
  homeAddress VARCHAR(200),
  officeAddress VARCHAR(200),
  homePhone CHAR(10),
  officePhone CHAR(10),
  mobilePhone CHAR(10),


  CONSTRAINT customerPk PRIMARY KEY (customerNic) ,
  CONSTRAINT customerNicCheck CHECK (customerNic LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][a-zA-Z]'),
  CONSTRAINT homePhoneCheck CHECK (homePhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT officePhoneCheck CHECK (officePhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT mobilePhoneCheck CHECK (mobilePhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);


/* Rent */
CREATE TABLE Rent (
  rentId INT AUTO_INCREMENT,
  customerNic CHAR(10),  -- 123456789V
  startDateTime DATETIME NOT NULL,
  endDateTime DATETIME NOT NULL,
  duration INT,
  deposit DOUBLE,
  rentalAmount DOUBLE,
  deliveryCharges DOUBLE,
  totalAmount DOUBLE,

  CONSTRAINT rentPk PRIMARY KEY (rentId, customerNic),
  CONSTRAINT rentCustomerFk FOREIGN KEY (customerNic) REFERENCES Customer(customerNic)
);


/* Rent Guarantor */
-- For customers that have to present a guarantor.
CREATE TABLE Guarantor (
  rentId INT,
  guarantorNic CHAR(10),
  guarantorName VARCHAR(100) NOT NULL,
  guarantorMobilePhone CHAR(10),
  guarantorLandPhone CHAR(10),
  guarantorHomeAddress VARCHAR(200),
  guarantorOfficeAddress VARCHAR(200),

  CONSTRAINT guarantorPk PRIMARY KEY (rentId, guarantorNic),
  CONSTRAINT guarantorRentFk FOREIGN KEY (rentId) REFERENCES Rent(rentId),
  CONSTRAINT guarantorNicCheck CHECK (guarantorNic LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][a-zA-Z]'),
  CONSTRAINT guarantorMobilePhoneCheck CHECK (guarantorMobilePhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT guarantorLandPhoneCheck CHECK (guarantorLandPhone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);


/* Invoice */
CREATE TABLE Invoice (
  invoiceId INT AUTO_INCREMENT,
  rentId INT,
  totalAmountPaid DOUBLE NOT NULL,

  CONSTRAINT invoicePk PRIMARY KEY (invoiceId),
  CONSTRAINT invoiceRentFk FOREIGN KEY (rentId) REFERENCES Rent(rentId)
);
