Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB14C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFF120818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VfbB38ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfDOW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:28:12 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:55049 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:28:12 -0400
Received: by mail-yw1-f74.google.com with SMTP id b131so14115428ywe.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pBC2TgvbGrGf0oBEqdoDV5H6EH9nM72bScimiFRtJZI=;
        b=VfbB38ETCcqlgLVuVHaFSVZDNAdsTSS6QsMNkgGW1WMM6ITUCkT4mR8bWayZ/JBufo
         +azso+VRm9fo55sFnUmeBqWJvsSY8XJ/yaXpVqaFgzQVOMIjccm9LMMB54YuSH88Vg6U
         f1igRnEEbhoINkHs6KevO2Z12DV70MgEutlndWC56RAi+sWLijeEr95mo+HRGcVnAfT6
         WWe16Y88OMcSoZZ7TVQbruxWXadzian4okgwpJnRyoEJrUshuPcilmP+eZpi3oizn9IA
         dgAW2VASs0GKCHjjw4toR+W7HkyOg3MjbptINwBuvyqPQIZhT4vWMZnCWnl/3DhCPajD
         dXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pBC2TgvbGrGf0oBEqdoDV5H6EH9nM72bScimiFRtJZI=;
        b=s5iJe60g2hEqxZTgoUWl3ynTHfADCbFzvqmXGSnw/r8sBgDMlbL2o9XXk33wiA5+1D
         P0s+Ud7Lq1lz9wWdvMCX0m0MzkbMCP+h8r+BEuUFUDcDijHW5/OpZZwKCZrLaVgkoQqX
         DUTLXmE9u2MmQ3MtnDHOtY0G3PbV2gffo2cNtIOfkLDAGLc9YvBh4JtSGkkoj3uS9d/l
         ujiBvHsqPCzfgSZ2+v7oPYkVFgDgL3JfKYEJRetj3BlgYKB+RDqomBnNAYdeI8/9msAd
         VMukR5qkREkkFFfmhJv7SWruTCcaACDQG5xTr9CptyPi2rM9dH12oRP1V+9WsF8SjgiK
         4eGA==
X-Gm-Message-State: APjAAAX0bX8AKZDQnlt7Pz+pKJ4LCjao9i+/tvI7nrWaK3Fps9eTYk+z
        V9ap0vwZElArs5UVL37tB0ZyDZ16xeFe
X-Google-Smtp-Source: APXvYqyqMr5xOE4eTi0Dh82Yl9QMGUfpVu15xQ0bvhFFCfiNYeyeMbDJ4uIupQ57lZBtTkDrFdESc6kVVDOY
X-Received: by 2002:a25:6dd7:: with SMTP id i206mr13620970ybc.97.1555367291016;
 Mon, 15 Apr 2019 15:28:11 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:28:07 -0700
Message-Id: <20190415222807.134104-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6] hwmon: (pmbus/isl68137): Add driver for Intersil ISL68137
 PWM Controller
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, linux@roeck-us.net, jdelvare@suse.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     Maxim Sloyko <maxims@google.com>, kunyi@google.com,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Lippert <rlippert@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Sloyko <maxims@google.com>

Intersil ISL68137 is a digital output 7-phase configurable PWM
controller with an AVSBus interface.

Signed-off-by: Maxim Sloyko <maxims@google.com>
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
v6:
 Fix reversed logic bug.
v5:
 Drop extra parens
 Drop extra parameter check
v4:
 Use kstrtobool
 Cleanup parens
 Use rc instead of temporary int
 Delete unnecessary coment
 Add remove to driver structure
v3:
 Added missing driver documentation
 Cleaned up goto statements.
 Add missing error check on pmbus_read_word_data
 Transitioned to use SENSOR_DEVICE_ATTR_RW
 Renamed enabled attribute to enable
 Set up an attribute_group for the enable attribute and added to pmbus_info
 Removed the boilerplate driver remove method
v2:
 Fixed bad header ordering.
v1:
 Original new patchset with fixes from Rob Lippert.
---
 Documentation/hwmon/isl68137   |  72 ++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |   9 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/isl68137.c | 169 +++++++++++++++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/hwmon/isl68137
 create mode 100644 drivers/hwmon/pmbus/isl68137.c

diff --git a/Documentation/hwmon/isl68137 b/Documentation/hwmon/isl68137
new file mode 100644
index 0000000000000..92e5c5fc5b777
--- /dev/null
+++ b/Documentation/hwmon/isl68137
@@ -0,0 +1,72 @@
+Kernel driver isl68137
+======================
+
+Supported chips:
+  * Intersil ISL68137
+    Prefix: 'isl68137'
+    Addresses scanned: -
+    Datasheet: Publicly available at the Intersil website
+      https://www.intersil.com/content/dam/Intersil/documents/isl6/isl68137.pdf
+
+Authors:
+        Maxim Sloyko <maxims@google.com>
+        Robert Lippert <rlippert@google.com>
+        Patrick Venture <venture@google.com>
+
+Description
+-----------
+
+Intersil ISL68137 is a digital output 7-phase configurable PWM
+controller with an AVSBus interface.
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantiate
+devices explicitly.
+
+The ISL68137 AVS operation mode must be enabled/disabled at runtime.
+
+Beyond the normal sysfs pmbus attributes, the driver exposes a control attribute.
+
+Additional Sysfs attributes
+---------------------------
+
+avs(0|1)_enable		Controls the AVS state of each rail.
+
+curr1_label		"iin"
+curr1_input		Measured input current
+curr1_crit		Critical maximum current
+curr1_crit_alarm	Current critical high alarm
+
+curr[2-3]_label		"iout[1-2]"
+curr[2-3]_input		Measured output current
+curr[2-3]_crit		Critical maximum current
+curr[2-3]_crit_alarm	Current critical high alarm
+
+in1_label		"vin"
+in1_input		Measured input voltage
+in1_lcrit		Critical minimum input voltage
+in1_lcrit_alarm		Input voltage critical low alarm
+in1_crit		Critical maximum input voltage
+in1_crit_alarm		Input voltage critical high alarm
+
+in[2-3]_label		"vout[1-2]"
+in[2-3]_input		Measured output voltage
+in[2-3]_lcrit		Critical minimum output voltage
+in[2-3]_lcrit_alarm	Output voltage critical low alarm
+in[2-3]_crit		Critical maximum output voltage
+in[2-3]_crit_alarm	Output voltage critical high alarm
+
+power1_label		"pin"
+power1_input		Measured input power
+power1_alarm		Input power high alarm
+
+power[2-3]_label	"pout[1-2]"
+power[2-3]_input	Measured output power
+
+temp[1-3]_input		Measured temperature
+temp[1-3]_crit		Critical high temperature
+temp[1-3]_crit_alarm	Chip temperature critical high alarm
+temp[1-3]_max		Maximum temperature
+temp[1-3]_max_alarm	Chip temperature high alarm
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index de87abab990e5..7edab7e30eaf9 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -63,6 +63,15 @@ config SENSORS_IR38064
 	  This driver can also be built as a module. If so, the module will
 	  be called ir38064.
 
+config SENSORS_ISL68137
+	tristate "Intersil ISL68137"
+	help
+	  If you say yes here you get hardware monitoring support for Intersil
+	  ISL68137.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called isl68137.
+
 config SENSORS_LM25066
 	tristate "National Semiconductor LM25066 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 7d1fa6b3c8c93..2219b93003167 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
 obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
+obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
 obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
 obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
 obj-$(CONFIG_SENSORS_LTC3815)	+= ltc3815.o
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
new file mode 100644
index 0000000000000..515596c92fe1c
--- /dev/null
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Intersil ISL68137
+ *
+ * Copyright (c) 2017 Google Inc
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include "pmbus.h"
+
+#define ISL68137_VOUT_AVS	0x30
+
+static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
+					     int page,
+					     char *buf)
+{
+	int val = pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+
+	return sprintf(buf, "%d\n",
+		       (val & ISL68137_VOUT_AVS) == ISL68137_VOUT_AVS ? 1 : 0);
+}
+
+static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,
+					      int page,
+					      const char *buf, size_t count)
+{
+	int rc, op_val;
+	bool result;
+
+	rc = kstrtobool(buf, &result);
+	if (rc)
+		return rc;
+
+	op_val = result ? ISL68137_VOUT_AVS : 0;
+
+	/*
+	 * Writes to VOUT setpoint over AVSBus will persist after the VRM is
+	 * switched to PMBus control. Switching back to AVSBus control
+	 * restores this persisted setpoint rather than re-initializing to
+	 * PMBus VOUT_COMMAND. Writing VOUT_COMMAND first over PMBus before
+	 * enabling AVS control is the workaround.
+	 */
+	if (op_val == ISL68137_VOUT_AVS) {
+		rc = pmbus_read_word_data(client, page, PMBUS_VOUT_COMMAND);
+		if (rc < 0)
+			return rc;
+
+		rc = pmbus_write_word_data(client, page, PMBUS_VOUT_COMMAND,
+					   rc);
+		if (rc < 0)
+			return rc;
+	}
+
+	rc = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
+				    ISL68137_VOUT_AVS, op_val);
+
+	return (rc < 0) ? rc : count;
+}
+
+static ssize_t isl68137_avs_enable_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return isl68137_avs_enable_show_page(client, attr->index, buf);
+}
+
+static ssize_t isl68137_avs_enable_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return isl68137_avs_enable_store_page(client, attr->index, buf, count);
+}
+
+static SENSOR_DEVICE_ATTR_RW(avs0_enable, isl68137_avs_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(avs1_enable, isl68137_avs_enable, 1);
+
+static struct attribute *enable_attrs[] = {
+	&sensor_dev_attr_avs0_enable.dev_attr.attr,
+	&sensor_dev_attr_avs1_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group enable_group = {
+	.attrs = enable_attrs,
+};
+
+static const struct attribute_group *attribute_groups[] = {
+	&enable_group,
+	NULL,
+};
+
+static struct pmbus_driver_info isl68137_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_VOLTAGE_IN] = 1,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 3,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.m[PSC_CURRENT_IN] = 1,
+	.b[PSC_CURRENT_IN] = 0,
+	.R[PSC_CURRENT_IN] = 2,
+	.m[PSC_CURRENT_OUT] = 1,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 1,
+	.m[PSC_POWER] = 1,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 0,
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
+	    | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+	    | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
+	.groups = attribute_groups,
+};
+
+static int isl68137_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &isl68137_info);
+}
+
+static const struct i2c_device_id isl68137_id[] = {
+	{"isl68137", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, isl68137_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver isl68137_driver = {
+	.driver = {
+		   .name = "isl68137",
+		   },
+	.probe = isl68137_probe,
+	.remove = pmbus_do_remove,
+	.id_table = isl68137_id,
+};
+
+module_i2c_driver(isl68137_driver);
+
+MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
+MODULE_DESCRIPTION("PMBus driver for Intersil ISL68137");
+MODULE_LICENSE("GPL");
-- 
2.21.0.392.gf8f6787159e-goog

