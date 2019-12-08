Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98206C2D0BF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0CF20692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLHNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:44:54 -0500
Received: from segapp02.wistron.com ([103.200.3.19]:60065 "EHLO
        segapp03.wistron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbfLHNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:44:54 -0500
Received: from EXCHAPP04.whq.wistron (unverified [10.37.38.27]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tdbf3e18e9dc0a81672177c@TWNHUMSW4.wistron.com>;
 Sun, 8 Dec 2019 21:44:43 +0800
Received: from EXCHAPP02.whq.wistron (10.37.38.25) by EXCHAPP04.whq.wistron
 (10.37.38.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 8 Dec 2019
 21:44:42 +0800
Received: from gitserver.wistron.com (10.37.38.233) by EXCHAPP02.whq.wistron
 (10.37.38.25) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 8 Dec 2019 21:44:42 +0800
From:   Ben Pai <Ben_Pai@wistron.com>
To:     <linux@roeck-us.net>
CC:     <robh+dt@kernel.org>, <jdelvare@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <corbet@lwn.net>,
        <wangat@tw.ibm.com>, <Andy_YF_Wang@wistron.com>,
        <Claire_Ku@wistron.com>, Ben Pai <Ben_Pai@wistron.com>
Subject: [ v2] hwmon: (pmbus) Add Wistron power supply pmbus driver
Date:   Sun, 8 Dec 2019 21:44:38 +0800
Message-ID: <20191208134438.12925-1-Ben_Pai@wistron.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4DCD986404BE546FCECB58BFAA75AE1C5717B5025D110C3AEC5545EFF08BF4222000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver to monitor Wisreon power supplies with hwmon over pmbus.

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 .../devicetree/bindings/hwmon/wistron-wps.txt |  30 +++
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/wistron-wps.c             | 176 ++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/wistron-wps.txt
 create mode 100644 drivers/hwmon/pmbus/wistron-wps.c

diff --git a/Documentation/devicetree/bindings/hwmon/wistron-wps.txt b/Documentation/devicetree/bindings/hwmon/wistron-wps.txt
new file mode 100644
index 000000000000..aacb2e66736e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/wistron-wps.txt
@@ -0,0 +1,30 @@
+ver ibm-cffps
+=======================
+
+Supported chips:
+
+  * Wistron Common Form Factor power supply(wps).
+
+Author: Ben Pai <Ben_Pai@wistron.com>
+
+Description
+-----------
+
+Our company name is Wistron, so this driver is written to supports 
+Wistron Common Form Factor power supplies(wps). This driver
+is a client to the core PMBus driver. Read information from psu, 
+and create debug-files and write information to them via driver.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+Information of the data read
+---------------------
+FRU : name of psu manufacturer.
+PN : part_number of psu.
+SN : serial_number of psu.
+mfr_date : Date of psu's manufacture.
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index d62d69bb7e49..ebb7024e58ab 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -219,6 +219,15 @@ config SENSORS_UCD9200
 	  This driver can also be built as a module. If so, the module will
 	  be called ucd9200.
 
+config SENSORS_WISTRON_WPS
+	tristate "Wistron Power Supply"
+	help
+	  If you say yes here you get hardware monitoring support for the Wistron
+	  power supply.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called wistron-wps.
+
 config SENSORS_ZL6100
 	tristate "Intersil ZL6100 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 03bacfcfd660..cad38f99e8c5 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -25,4 +25,5 @@ obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
+obj-$(CONFIG_SENSORS_WISTRON_WPS) += wistron-wps.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
diff --git a/drivers/hwmon/pmbus/wistron-wps.c b/drivers/hwmon/pmbus/wistron-wps.c
new file mode 100644
index 000000000000..4e2649e7b3f2
--- /dev/null
+++ b/drivers/hwmon/pmbus/wistron-wps.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2019 Wistron Corp.
+ */
+
+#include <linux/bitops.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+
+#include "pmbus.h"
+
+#define WPS_FRU_CMD	   0x99
+#define WPS_PN_CMD         0x9A
+#define WPS_FW_CMD	   0x9B
+#define WPS_DATE_CMD       0x9D
+#define WPS_SN_CMD	   0x9E
+
+enum {
+	WPS_DEBUGFS_FRU,
+	WPS_DEBUGFS_PN,
+	WPS_DEBUGFS_SN,
+	WPS_DEBUGFS_FW,
+	WPS_DEBUGFS_DATE,
+	WPS_DEBUGFS_NUM_ENTRIES
+};
+
+struct wistron_wps {
+	struct i2c_client *client;
+	int debugfs_entries[WPS_DEBUGFS_NUM_ENTRIES];
+};
+
+#define to_psu(x, y) container_of(x, struct wistron_wps, debugfs_entries[y])
+
+static ssize_t wistron_wps_debugfs_op(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	u8 cmd;
+	int rc;
+	int *idxp = file->private_data;
+	int idx = *idxp;
+	struct wistron_wps *psu = to_psu(idxp, idx);
+	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
+
+	pmbus_set_page(psu->client, 0);
+	switch (idx) {
+	case WPS_DEBUGFS_FRU:
+		cmd = WPS_FRU_CMD;
+		break;
+	case WPS_DEBUGFS_PN:
+		cmd = WPS_PN_CMD;
+		break;
+	case WPS_DEBUGFS_SN:
+		cmd = WPS_SN_CMD;
+		break;
+	case WPS_DEBUGFS_FW:
+		cmd = WPS_FW_CMD;
+		break;
+	case WPS_DEBUGFS_DATE:
+		cmd = WPS_DATE_CMD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
+	if (rc < 0)
+		return rc;
+
+done:
+	data[rc] = '\n';
+	rc += 2;
+
+	return simple_read_from_buffer(buf, count, ppos, data, rc);
+}
+
+static const struct file_operations wistron_wps_fops = {
+
+	.llseek = noop_llseek,
+	.read = wistron_wps_debugfs_op,
+	.open = simple_open,
+};
+
+static struct pmbus_driver_info wistron_wps_info = {
+	.pages = 1,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+		PMBUS_HAVE_PIN | PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12 |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
+		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
+		PMBUS_HAVE_STATUS_FAN12,
+};
+
+static struct pmbus_platform_data wistron_wps_pdata = {
+	.flags = PMBUS_SKIP_STATUS_CHECK,
+};
+
+static int wistron_wps_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	int i, rc;
+	struct dentry *debugfs;
+	struct dentry *wistron_wps_dir;
+	struct wistron_wps *psu;
+
+	client->dev.platform_data = &wistron_wps_pdata;
+	rc = pmbus_do_probe(client, id, &wistron_wps_info);
+	if (rc)
+		return rc;
+
+	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
+	if (!psu)
+		return 0;
+
+	psu->client = client;
+
+	debugfs = pmbus_get_debugfs_dir(client);
+	if (!debugfs)
+		return 0;
+
+	wistron_wps_dir = debugfs_create_dir(client->name, debugfs);
+	if (!wistron_wps_dir)
+		return 0;
+
+	for (i = 0; i < WPS_DEBUGFS_NUM_ENTRIES; ++i)
+		psu->debugfs_entries[i] = i;
+
+	debugfs_create_file("fru", 0444, wistron_wps_dir,
+			    &psu->debugfs_entries[WPS_DEBUGFS_FRU],
+			    &wistron_wps_fops);
+	debugfs_create_file("part_number", 0444, wistron_wps_dir,
+			    &psu->debugfs_entries[WPS_DEBUGFS_PN],
+			    &wistron_wps_fops);
+	debugfs_create_file("serial_number", 0444, wistron_wps_dir,
+			    &psu->debugfs_entries[WPS_DEBUGFS_SN],
+			    &wistron_wps_fops);
+	debugfs_create_file("fw_version", 0444, wistron_wps_dir,
+			    &psu->debugfs_entries[WPS_DEBUGFS_FW],
+			    &wistron_wps_fops);
+	debugfs_create_file("mfr_date", 0444, wistron_wps_dir,
+			    &psu->debugfs_entries[WPS_DEBUGFS_DATE],
+			    &wistron_wps_fops);
+
+	return 0;
+}
+
+static const struct i2c_device_id wistron_wps_id[] = {
+	{ "wistron_wps", 1 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, wistron_wps_id);
+
+static const struct of_device_id wistron_wps_of_match[] = {
+	{ .compatible = "wistron, wps" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, wistron_wps_of_match);
+
+static struct i2c_driver wistron_wps_driver = {
+	.driver = {
+		.name = "wistron-wps",
+		.of_match_table = wistron_wps_of_match,
+	},
+	.probe = wistron_wps_probe,
+	.remove = pmbus_do_remove,
+	.id_table = wistron_wps_id,
+};
+
+module_i2c_driver(wistron_wps_driver);
+
+MODULE_AUTHOR("Ben Pai");
+MODULE_DESCRIPTION("PMBus driver for Wistron power supplies");
+MODULE_LICENSE("GPL");
-- 
2.17.1

