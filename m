Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC32C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB62054F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYqoi651"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfLHW5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 17:57:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35166 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfLHW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 17:57:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so4982795plp.2;
        Sun, 08 Dec 2019 14:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7FH57UyCjRv3EGR8pcDZv8hlyVyJOdyf47Tfk6wa4ao=;
        b=hYqoi6515DZlyo6CajLAhCTntvAeXla8/rVjKcAr1DR+4/Yj0SqlCgra1U3jjjmkbQ
         p2ubPdSckEqU02Sm59ywcmEYoIFdINWrEiYRrNePwf9nqX5LCdBaHjyrQ+/i74n+FEtT
         2+CqWxPNHfaBkwgE5FrxNsIG4hk07hfsf8Hf+mnAc6MGi8SMlco9MbL1PQSnMMdLxle/
         x3jg7pOQ03uNaVX5JJvmzDUS7ChSDo44QG5PUShy3sZaRRHvwwz8etKOfnxLTh+cYlz1
         u25yP6ro66WU0Muqgfz3H+LSG7V18hrCRIqwr3CbWuLSIt0zJnA+O1smPKHJkn7fF7Qy
         lLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7FH57UyCjRv3EGR8pcDZv8hlyVyJOdyf47Tfk6wa4ao=;
        b=HgP9AAMm79PbZd2DUOzFp2bLdeJaKPOURZFmvW58Jo8NhcvzrDnEnuOSkFr1Z+Q5UK
         zubH/ysEdD8wom6ct8k/7RraXnNKASUCj3DuTWJNGYQX8v4q4CnbKQ0JdNWXDLF4Y2NL
         V+9b/GlyKqUcyhke1AQpu8bnYq/B1qZq6lUNdLxqyW9iLWoVPD6cQKWsxOgnuRlYf56A
         4/9tXsddFlCLTlGxqu2RVQTD4gKpvuULUuRSpRcuoxfQPG8l95iyRkrxefLP2zIx4GVF
         Ae48AuprcgXvf4WPwKEhAiAzDqTgfE79VxoQ8HBluVBJwnfnGysEyi8RNv5yva6hT6AR
         tWoQ==
X-Gm-Message-State: APjAAAUlXyixCYfSgNit3hu0DxW1XCsdrW9QUc7vwo/Qjs52T9A+Gotx
        /GOqVNu5YI/Ex1BSl38mp9Sv6sFV
X-Google-Smtp-Source: APXvYqxhRjBgnoXI1CtJCQIlhL3T3qHIQcndLdxfiGrIK/kvqQc4Iw+Zne2qeZaYHMD5r6OlTxCs4w==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr28156050pjw.126.1575845824479;
        Sun, 08 Dec 2019 14:57:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v7sm9882040pjs.2.2019.12.08.14.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Dec 2019 14:57:03 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, peterlundgren@google.com,
        kunyi@google.com, devjitg@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: Driver for MAX31730
Date:   Sun,  8 Dec 2019 14:57:01 -0800
Message-Id: <20191208225701.1993-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX31730 is a 3-Channel Remote Temperature Sensor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch needs to be applied on top of
	https://patchwork.kernel.org/patch/11277603/

 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/max31730.rst |  44 ++++
 drivers/hwmon/Kconfig            |  12 +-
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/max31730.c         | 440 +++++++++++++++++++++++++++++++
 5 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hwmon/max31730.rst
 create mode 100644 drivers/hwmon/max31730.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 43cc605741ea..b91da3acccb9 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -108,6 +108,7 @@ Hardware Monitoring Kernel Drivers
    max197
    max20751
    max31722
+   max31730
    max31785
    max31790
    max34440
diff --git a/Documentation/hwmon/max31730.rst b/Documentation/hwmon/max31730.rst
new file mode 100644
index 000000000000..def0de19dbd2
--- /dev/null
+++ b/Documentation/hwmon/max31730.rst
@@ -0,0 +1,44 @@
+Kernel driver max31790
+======================
+
+Supported chips:
+
+  * Maxim MAX31730
+
+    Prefix: 'max31730'
+
+    Addresses scanned: 0x1c, 0x1d, 0x1e, 0x1f, 0x4c, 0x4d, 0x4e, 0x4f
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31730.pdf
+
+Author: Guenter Roeck <linux@roeck-us.net>
+
+
+Description
+-----------
+
+This driver implements support for Maxim MAX31730.
+
+The MAX31730 temperature sensor monitors its own temperature and the
+temperatures of three external diode-connected transistors. The operating
+supply voltage is from 3.0V to 3.6V. Resistance cancellation compensates
+for high series resistance in circuit-board traces and the external thermal
+diode, while beta compensation corrects for temperature-measurement
+errors due to low-beta sensing transistors.
+
+
+Sysfs entries
+-------------
+
+=================== == =======================================================
+temp[1-4]_enable    RW Temperature enable/disable
+                       Set to 0 to enable channel, 0 to disable
+temp[1-4]_input     RO Temperature input
+temp[2-4]_fault     RO Fault indicator for remote channels
+temp[1-4]_max       RW Maximum temperature
+temp[1-4]_max_alarm RW Maximum temperature alarm
+temp[1-4]_min       RW Minimum temperature. Common for all channels.
+                       Only temp1_min is writeable.
+temp[1-4]_min_alarm RO Minimum temperature alarm
+temp[2-4]_offset    RW Temperature offset for remote channels
+=================== == =======================================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 23dfe848979a..54e1b9cbc0b9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -889,7 +889,7 @@ config SENSORS_MAX197
 	  will be called max197.
 
 config SENSORS_MAX31722
-tristate "MAX31722 temperature sensor"
+	tristate "MAX31722 temperature sensor"
 	depends on SPI
 	help
 	  Support for the Maxim Integrated MAX31722/MAX31723 digital
@@ -898,6 +898,16 @@ tristate "MAX31722 temperature sensor"
 	  This driver can also be built as a module. If so, the module
 	  will be called max31722.
 
+config SENSORS_MAX31730
+	tristate "MAX31730 temperature sensor"
+	depends on I2C
+	help
+	  Support for the Maxim Integrated MAX31730 3-Channel Remote
+	  Temperature Sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max31730.
+
 config SENSORS_MAX6621
 	tristate "Maxim MAX6621 sensor chip"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 6db5db9cdc29..226a1182967a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
 obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
 obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
+obj-$(CONFIG_SENSORS_MAX31730)	+= max31730.o
 obj-$(CONFIG_SENSORS_MAX6621)	+= max6621.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
new file mode 100644
index 000000000000..eb22a34dc36b
--- /dev/null
+++ b/drivers/hwmon/max31730.c
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MAX31730 3-Channel Remote Temperature Sensor
+ *
+ * Copyright (c) 2019 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+/* Addresses scanned */
+static const unsigned short normal_i2c[] = { 0x1c, 0x1d, 0x1e, 0x1f, 0x4c,
+					     0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
+
+/* The MAX31730 registers */
+#define MAX31730_REG_TEMP		0x00
+#define MAX31730_REG_CONF		0x13
+#define  MAX31730_STOP			BIT(7)
+#define  MAX31730_EXTRANGE		BIT(1)
+#define MAX31730_REG_TEMP_OFFSET	0x16
+#define  MAX31730_TEMP_OFFSET_BASELINE	0x77
+#define MAX31730_REG_OFFSET_ENABLE	0x17
+#define MAX31730_REG_TEMP_MAX		0x20
+#define MAX31730_REG_TEMP_MIN		0x30
+#define MAX31730_REG_STATUS_HIGH	0x32
+#define MAX31730_REG_STATUS_LOW		0x33
+#define MAX31730_REG_CHANNEL_ENABLE	0x35
+#define MAX31730_REG_TEMP_FAULT		0x36
+
+#define MAX31730_REG_MFG_ID		0x50
+#define  MAX31730_MFG_ID		0x4d
+#define MAX31730_REG_MFG_REV		0x51
+#define  MAX31730_MFG_REV		0x01
+
+#define MAX31730_TEMP_MIN		(-128000)
+#define MAX31730_TEMP_MAX		127937
+
+/* Each client has this additional data */
+struct max31730_data {
+	struct i2c_client	*client;
+	u8			orig_conf;
+	u8			current_conf;
+	u8			offset_enable;
+	u8			channel_enable;
+};
+
+/*-----------------------------------------------------------------------*/
+
+static inline long max31730_reg_to_mc(s16 temp)
+{
+	return DIV_ROUND_CLOSEST((temp >> 4) * 1000, 16);
+}
+
+static int max31730_write_config(struct max31730_data *data, u8 set_mask,
+				 u8 clr_mask)
+{
+	u8 value;
+
+	clr_mask |= MAX31730_EXTRANGE;
+	value = data->current_conf & ~clr_mask;
+	value |= set_mask;
+
+	if (data->current_conf != value) {
+		s32 err;
+
+		err = i2c_smbus_write_byte_data(data->client, MAX31730_REG_CONF,
+						value);
+		if (err)
+			return err;
+		data->current_conf = value;
+	}
+	return 0;
+}
+
+static int max31730_set_enable(struct i2c_client *client, int reg,
+			       u8 *confdata, int channel, bool enable)
+{
+	u8 regval = *confdata;
+	int err;
+
+	if (enable)
+		regval |= BIT(channel);
+	else
+		regval &= ~BIT(channel);
+
+	if (regval != *confdata) {
+		err = i2c_smbus_write_byte_data(client, reg, regval);
+		if (err)
+			return err;
+		*confdata = regval;
+	}
+	return 0;
+}
+
+static int max31730_set_offset_enable(struct max31730_data *data, int channel,
+				      bool enable)
+{
+	return max31730_set_enable(data->client, MAX31730_REG_OFFSET_ENABLE,
+				   &data->offset_enable, channel, enable);
+}
+
+static int max31730_set_channel_enable(struct max31730_data *data, int channel,
+				       bool enable)
+{
+	return max31730_set_enable(data->client, MAX31730_REG_CHANNEL_ENABLE,
+				   &data->channel_enable, channel, enable);
+}
+
+static int max31730_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct max31730_data *data = dev_get_drvdata(dev);
+	int regval, reg, offset;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		if (!(data->channel_enable & BIT(channel)))
+			return -ENODATA;
+		reg = MAX31730_REG_TEMP + (channel * 2);
+		break;
+	case hwmon_temp_max:
+		reg = MAX31730_REG_TEMP_MAX + (channel * 2);
+		break;
+	case hwmon_temp_min:
+		reg = MAX31730_REG_TEMP_MIN;
+		break;
+	case hwmon_temp_enable:
+		*val = !!(data->channel_enable & BIT(channel));
+		return 0;
+	case hwmon_temp_offset:
+		if (!channel)
+			return -EINVAL;
+		if (!(data->offset_enable & BIT(channel))) {
+			*val = 0;
+			return 0;
+		}
+		offset = i2c_smbus_read_byte_data(data->client,
+						  MAX31730_REG_TEMP_OFFSET);
+		if (offset < 0)
+			return offset;
+		*val = (offset - MAX31730_TEMP_OFFSET_BASELINE) * 125;
+		return 0;
+	case hwmon_temp_fault:
+		regval = i2c_smbus_read_byte_data(data->client,
+						  MAX31730_REG_TEMP_FAULT);
+		if (regval < 0)
+			return regval;
+		*val = !!(regval & BIT(channel));
+		return 0;
+	case hwmon_temp_min_alarm:
+		regval = i2c_smbus_read_byte_data(data->client,
+						  MAX31730_REG_STATUS_LOW);
+		if (regval < 0)
+			return regval;
+		*val = !!(regval & BIT(channel));
+		return 0;
+	case hwmon_temp_max_alarm:
+		regval = i2c_smbus_read_byte_data(data->client,
+						  MAX31730_REG_STATUS_HIGH);
+		if (regval < 0)
+			return regval;
+		*val = !!(regval & BIT(channel));
+		return 0;
+	default:
+		return -EINVAL;
+	}
+	regval = i2c_smbus_read_word_swapped(data->client, reg);
+	if (regval < 0)
+		return regval;
+
+	*val = max31730_reg_to_mc(regval);
+
+	return 0;
+}
+
+static int max31730_write(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long val)
+{
+	struct max31730_data *data = dev_get_drvdata(dev);
+	int reg, err;
+
+	if (type != hwmon_temp)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_temp_max:
+		reg = MAX31730_REG_TEMP_MAX + channel * 2;
+		break;
+	case hwmon_temp_min:
+		reg = MAX31730_REG_TEMP_MIN;
+		break;
+	case hwmon_temp_enable:
+		if (val != 0 && val != 1)
+			return -EINVAL;
+		return max31730_set_channel_enable(data, channel, val);
+	case hwmon_temp_offset:
+		val = clamp_val(val, -14875, 17000) + 14875;
+		val = DIV_ROUND_CLOSEST(val, 125);
+		err = max31730_set_offset_enable(data, channel,
+					val != MAX31730_TEMP_OFFSET_BASELINE);
+		if (err)
+			return err;
+		return i2c_smbus_write_byte_data(data->client,
+						 MAX31730_REG_TEMP_OFFSET, val);
+	default:
+		return -EINVAL;
+	}
+
+	val = clamp_val(val, MAX31730_TEMP_MIN, MAX31730_TEMP_MAX);
+	val = DIV_ROUND_CLOSEST(val << 4, 1000) << 4;
+
+	return i2c_smbus_write_word_swapped(data->client, reg, (u16)val);
+}
+
+static umode_t max31730_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_min_alarm:
+		case hwmon_temp_max_alarm:
+		case hwmon_temp_fault:
+			return 0444;
+		case hwmon_temp_min:
+			return channel ? 0444 : 0644;
+		case hwmon_temp_offset:
+		case hwmon_temp_enable:
+		case hwmon_temp_max:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info *max31730_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM |
+			   HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM |
+			   HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_OFFSET | HWMON_T_ENABLE |
+			   HWMON_T_MIN_ALARM | HWMON_T_MAX_ALARM |
+			   HWMON_T_FAULT
+			   ),
+	NULL
+};
+
+static const struct hwmon_ops max31730_hwmon_ops = {
+	.is_visible = max31730_is_visible,
+	.read = max31730_read,
+	.write = max31730_write,
+};
+
+static const struct hwmon_chip_info max31730_chip_info = {
+	.ops = &max31730_hwmon_ops,
+	.info = max31730_info,
+};
+
+static void max31730_remove(void *data)
+{
+	struct max31730_data *max31730 = data;
+	struct i2c_client *client = max31730->client;
+
+	i2c_smbus_write_byte_data(client, MAX31730_REG_CONF,
+				  max31730->orig_conf);
+}
+
+static int
+max31730_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct max31730_data *data;
+	int status, err;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EIO;
+
+	data = devm_kzalloc(dev, sizeof(struct max31730_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+
+	/* Cache original configuration and enable status */
+	status = i2c_smbus_read_byte_data(client, MAX31730_REG_CHANNEL_ENABLE);
+	if (status < 0)
+		return status;
+	data->channel_enable = status;
+
+	status = i2c_smbus_read_byte_data(client, MAX31730_REG_OFFSET_ENABLE);
+	if (status < 0)
+		return status;
+	data->offset_enable = status;
+
+	status = i2c_smbus_read_byte_data(client, MAX31730_REG_CONF);
+	if (status < 0)
+		return status;
+	data->orig_conf = status;
+	data->current_conf = status;
+
+	err = max31730_write_config(data,
+				    data->channel_enable ? 0 : MAX31730_STOP,
+				    data->channel_enable ? MAX31730_STOP : 0);
+	if (err)
+		return err;
+
+	dev_set_drvdata(dev, data);
+
+	err = devm_add_action_or_reset(dev, max31730_remove, data);
+	if (err)
+		return err;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data,
+							 &max31730_chip_info,
+							 NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id max31730_ids[] = {
+	{ "max31730", 0, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max31730_ids);
+
+static const struct of_device_id __maybe_unused max31730_of_match[] = {
+	{
+		.compatible = "maxim,max31730",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max31730_of_match);
+
+static bool max31730_check_reg_temp(struct i2c_client *client,
+				    int reg)
+{
+	int regval;
+
+	regval = i2c_smbus_read_byte_data(client, reg + 1);
+	return regval < 0 || (regval & 0x0f);
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int max31730_detect(struct i2c_client *client,
+			   struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int regval;
+	int i;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_byte_data(client, MAX31730_REG_MFG_ID);
+	if (regval != MAX31730_MFG_ID)
+		return -ENODEV;
+	regval = i2c_smbus_read_byte_data(client, MAX31730_REG_MFG_REV);
+	if (regval != MAX31730_MFG_REV)
+		return -ENODEV;
+
+	/* lower 4 bit of temperature and limit registers must be 0 */
+	if (max31730_check_reg_temp(client, MAX31730_REG_TEMP_MIN))
+		return -ENODEV;
+
+	for (i = 0; i < 4; i++) {
+		if (max31730_check_reg_temp(client, MAX31730_REG_TEMP + i * 2))
+			return -ENODEV;
+		if (max31730_check_reg_temp(client,
+					    MAX31730_REG_TEMP_MAX + i * 2))
+			return -ENODEV;
+	}
+
+	strlcpy(info->type, "max31730", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int __maybe_unused max31730_suspend(struct device *dev)
+{
+	struct max31730_data *data = dev_get_drvdata(dev);
+
+	return max31730_write_config(data, MAX31730_STOP, 0);
+}
+
+static int __maybe_unused max31730_resume(struct device *dev)
+{
+	struct max31730_data *data = dev_get_drvdata(dev);
+
+	return max31730_write_config(data, 0, MAX31730_STOP);
+}
+
+static SIMPLE_DEV_PM_OPS(max31730_pm_ops, max31730_suspend, max31730_resume);
+
+static struct i2c_driver max31730_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "max31730",
+		.of_match_table = of_match_ptr(max31730_of_match),
+		.pm	= &max31730_pm_ops,
+	},
+	.probe		= max31730_probe,
+	.id_table	= max31730_ids,
+	.detect		= max31730_detect,
+	.address_list	= normal_i2c,
+};
+
+module_i2c_driver(max31730_driver);
+
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("MAX31730 driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

