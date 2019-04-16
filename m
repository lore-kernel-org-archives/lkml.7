Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F7F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="dugd2/wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfDPTAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:00:55 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:12388 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfDPTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8124; q=dns/txt; s=iport;
  t=1555441249; x=1556650849;
  h=from:to:cc:subject:date:message-id;
  bh=jUbctrdZPohE1FhZjMvHq+JgvCU+PKzQN5Ta0x/P5Yw=;
  b=dugd2/wc9drEe7etxHfxkW/JweBiNal83cKRV0Xbs/f7CQaS9zatPVgq
   0w83qDczrx+CUqMjuupMHpaKP0tUSqQmjvr3yflUQmIcSiIDMIowT4jTs
   MKjl/vDQr1WlCeXVBqjTh2Ni/pXLrxLRDgSoP987qaug/9yV7Is41Tzat
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BqAABrJLZc/4gNJK1mGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZYIRgTkzKJgSinyPFoFnEIF4gnWGCSM4EwEDAQEKAQIBAm0?=
 =?us-ascii?q?ohXhSKQeBDgESgyKBdRSrTTOKMBSBHoZ0hFYXeIEHhGGBBIMFFQoRhWwDil8?=
 =?us-ascii?q?Shw6BC5JZUwmCCJINDBuUdotplEWBZiGBVjMaCBsVgyeCFgwLjj8fAzCOIYJ?=
 =?us-ascii?q?RAQE?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="329420946"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:53:33 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIrUMp020521;
        Tue, 16 Apr 2019 18:53:33 GMT
From:   Ruslan Babayev <fib@cisco.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Ruslan Babayev <ruslan@babayev.com>, xe-linux-external@cisco.com,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwmon: (pmbus) add support for IR35215
Date:   Tue, 16 Apr 2019 11:45:45 -0700
Message-Id: <20190416184547.40128-3-fib@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>

Provide support for Infineon Dual Output Digital Multi-Phase Buck
Controllers IR35215 and IR3570B.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
---
 Documentation/hwmon/ir35215   | 98 +++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig   | 10 ++++
 drivers/hwmon/pmbus/Makefile  |  1 +
 drivers/hwmon/pmbus/ir35215.c | 91 ++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 Documentation/hwmon/ir35215
 create mode 100644 drivers/hwmon/pmbus/ir35215.c

diff --git a/Documentation/hwmon/ir35215 b/Documentation/hwmon/ir35215
new file mode 100644
index 000000000000..b77481340006
--- /dev/null
+++ b/Documentation/hwmon/ir35215
@@ -0,0 +1,98 @@
+Kernel driver ir35215
+=====================
+
+Supported chips:
+  * Infinion IR35215
+    Prefix: 'ir35215'
+    Addresses scanned: -
+    Datasheet: Datasheet is not publicly available.
+  * Infinion IR3570B
+    Prefix: 'ir3570b'
+    Addresses scanned: -
+    Datasheet: Datasheet is not publicly available.
+
+Author: Ruslan Babayev <ruslan@babayev.com>
+
+
+Description
+-----------
+
+IR35215 is a Dual Output Digital Multi-Phase Controller
+
+
+Usage Notes
+-----------
+
+This driver does not probe for PMBus devices. You will have to instantiate
+devices explicitly.
+
+Example: the following commands will load the driver for an IR35215
+at address 0x40 on I2C bus #4:
+
+# modprobe ir35215
+# echo ir35215 0x40 > /sys/bus/i2c/devices/i2c-4/new_device
+
+
+Sysfs attributes
+----------------
+
+curr[1-2]_label		"iin[1-2]"
+curr[1-2]_input		Measured input current
+curr[1-2]_max		Maximum current for
+curr[1-2]_max_alarm	Current high alarm
+
+curr[3-4]_label		"iout[3-4]"
+curr[3-4]_input		Measured output current
+curr[3-4]_crit		Critical maximum current
+curr[3-4]_crit_alarm	Current critical high alarm
+curr[3-4]_highest	Highest output current
+curr[3-4]_lowest	Lowest output current
+curr[3-4]_max		Maximum current
+curr[3-4]_max_alarm	Current high alarm
+
+in[1-2]_label		"vin[1-2]"
+in[1-2]_input		Measured input voltage
+in[1-2]_crit		Critical maximum input voltage
+in[1-2]_crit_alarm	Input voltage critical high alarm
+in[1-2]_highest		Highest input voltage
+in[1-2]_lowest		Lowest input voltage
+in[1-2]_min		Minimum input voltage
+in[1-2]_min_alarm	Input voltage low alarm
+
+in[3-4]_label		"vout[3-4]"
+in[3-4]_input		Measured output voltage
+in[3-4]_lcrit		Critical minimum output voltage
+in[3-4]_lcrit_alarm	Output voltage critical low alarm
+in[3-4]_crit		Critical maximum output voltage
+in[3-4]_crit_alarm	Output voltage critical high alarm
+in[3-4]_highest		Highest output voltage
+in[3-4]_lowest		Lowest output voltage
+in[3-4]_max		Maximum output voltage
+in[3-4]_max_alarm	Output voltage high alarm
+in[3-4]_min		Minimum output voltage
+in[3-4]_min_alarm	Output voltage low alarm
+
+out[1-2]_command	Commanded output voltage
+out[1-2]_margin_high	Output voltage when operation is set to "high"
+out[1-2]_margin_low	Output voltage when operation is set to "low"
+out[1-2]_max		Maximum output voltage
+out[1-2]_max_alarm	Output voltage high alarm
+out[1-2]_operation	Set the output voltage to "on", "off", "high" or "low"
+
+power1_label		"pin"
+power1_input		Measured input power
+power1_alarm		Input power high alarm
+power1_max		Input power limit
+
+power[2-3]_label	"pout[1-2]"
+power[2-3]_input	Measured output power
+power[2-3]_max		Output power limit
+power[2-3]_max_alarm	Output power high alarm
+
+temp[1-2]_input		Measured temperature
+temp[1-2]_crit		Critical high temperature
+temp[1-2]_crit_alarm	Chip temperature critical high alarm
+temp[1-2]_highest	Highest temperature
+temp[1-2]_lowest	Lowest temperature
+temp[1-2]_max		Maximum temperature
+temp[1-2]_max_alarm	Chip temperature high alarm
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 629cb45f8557..a7dd5e606061 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -45,6 +45,16 @@ config SENSORS_IBM_CFFPS
 	  This driver can also be built as a module. If so, the module will
 	  be called ibm-cffps.
 
+config SENSORS_IR35215
+	tristate "Infineon IR35215"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for the
+	  Infineon IR35215 controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ir35215.
+
 config SENSORS_IR35221
 	tristate "Infineon IR35221"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index ea0e39518c21..48643e3bab42 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
+obj-$(CONFIG_SENSORS_IR35215)	+= ir35215.o
 obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
 obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
 obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
diff --git a/drivers/hwmon/pmbus/ir35215.c b/drivers/hwmon/pmbus/ir35215.c
new file mode 100644
index 000000000000..e50ee465a42d
--- /dev/null
+++ b/drivers/hwmon/pmbus/ir35215.c
@@ -0,0 +1,91 @@
+/*
+ * Hardware monitoring driver for Infineon IR35215
+ *
+ * Copyright (c) 2019 Cisco Systems.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+#define COMMON_FUNCS	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT	\
+			 | PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT	\
+			 | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT	\
+			 | PMBUS_HAVE_TEMP			\
+			 | PMBUS_HAVE_STATUS_VOUT		\
+			 | PMBUS_HAVE_STATUS_IOUT		\
+			 | PMBUS_HAVE_STATUS_INPUT		\
+			 | PMBUS_HAVE_STATUS_TEMP		\
+			 | PMBUS_HAVE_VOUT_MARGIN_HIGH		\
+			 | PMBUS_HAVE_VOUT_MARGIN_LOW		\
+			)
+
+
+#define IR35215_FUNCS	(COMMON_FUNCS | PMBUS_HAVE_VOUT_COMMAND)
+#define IR3570B_FUNCS	(COMMON_FUNCS | PMBUS_HAVE_TEMP2)
+
+static struct pmbus_driver_info ir35215_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = IR35215_FUNCS,
+	.func[1] = IR35215_FUNCS,
+};
+
+static struct pmbus_driver_info ir3570b_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = IR3570B_FUNCS,
+	.func[1] = IR3570B_FUNCS,
+};
+
+static int ir35215_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, (void *)id->driver_data);
+}
+
+static const struct i2c_device_id ir35215_id[] = {
+	{"ir35215", (kernel_ulong_t)&ir35215_info},
+	{"ir3570b", (kernel_ulong_t)&ir3570b_info},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ir35215_id);
+
+static struct i2c_driver ir35215_driver = {
+	.driver = {
+		.name = "ir35215",
+	},
+	.probe = ir35215_probe,
+	.remove = pmbus_do_remove,
+	.id_table = ir35215_id,
+};
+
+module_i2c_driver(ir35215_driver);
+
+MODULE_AUTHOR("Ruslan Babayev <ruslan@babayev.com>");
+MODULE_DESCRIPTION("PMBus driver for IR35215");
+MODULE_LICENSE("GPL");
-- 
2.17.1

