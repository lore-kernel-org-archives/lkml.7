Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D11C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988F921907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR43bnh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfIRP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:27:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39934 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfIRP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:27:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id 72so6015621lfh.6;
        Wed, 18 Sep 2019 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7kdDzBkxjwMqVk3SYkXYkX2ruGJ9wrgVvGs/tigGtMU=;
        b=pR43bnh6C2LA6+hpy/41kQJsm+jhwKpZn2AxQp5/ed8JMiUjA1bhBhVSpmDGoepOc2
         17yRvM/MIGGfy3PK0QzCJswn3ILwV0jfi0cmKeKYq0otqkoePoxRvF8SSnJlijxzuBZu
         GfG6g6+gONKkPC9vufK9s3m5oggiXR0mYiIYeSBfkzptLjhDNAA89FTKy8lWygk2s7Ci
         e2/Wi94pz0K48w2iveHFDoWlrPvH2XjgZo8cfVCbqnQatBL0rWOeNg8bU8IM80j91HiC
         bjT2TeC+neY5LeWY3mFGZqLzWxe4VuxEp9l41c4j9/SNscDSlhh1npKQYH5qgwuvwyMW
         e18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7kdDzBkxjwMqVk3SYkXYkX2ruGJ9wrgVvGs/tigGtMU=;
        b=Qc6LMqS1YOh5zmp9a5vMoDhJulxwCDDTRkvYQ4/vYNJrj018ZeKQsrJga8TxmIj4bf
         Z2we1LK7hSMixkE6FGwkx36qEd8I9Yj1Fb5bBCOQQuzLs85pfCT73VmYIkxv13xwHReb
         FjZiZZqORP7IdtY2eibhsSil03Bwkm/72ADLZb+zMrcexYl5NLy+JpGYeszV+64DbSXL
         3f00ahBGHLPZeWLy7PGDaRbhzVAAv038t6aAFhOlOD9ZHwd4u5lNhyMwb/TYkYEASveG
         yHvzSx58rjkq9i6tOck+lPDYUJ9T8e71UAQvieJrr5jeoCO2dU0qFBzTEkeJMRW1Zo5r
         xwqg==
X-Gm-Message-State: APjAAAXBKwzn2pSKkm06Gzc5l3OdRLF98Si9P3YSrHRbDnB07qxNfvak
        OHKWQ39Gnxb/seA9Ih09VqU=
X-Google-Smtp-Source: APXvYqzs0pvPySIZlm9w0OycmZe5C1qEBFXhcqLtzvZYpmlGknsab9ImllItt4LlylTyHFgicjVrvQ==
X-Received: by 2002:ac2:43a1:: with SMTP id t1mr2149808lfl.164.1568820430348;
        Wed, 18 Sep 2019 08:27:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-vpdn-93-125-15-224.telecom.by. [93.125.15.224])
        by smtp.gmail.com with ESMTPSA id c10sm1068599lfp.65.2019.09.18.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:27:09 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAbrG-0000rV-Rl; Wed, 18 Sep 2019 18:27:06 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v3 1/1] platform/x86/intel_cht_int33fe: Split code to USB Micro-B and Type-C variants
Date:   Wed, 18 Sep 2019 18:27:05 +0300
Message-Id: <20190918152705.3267-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190918152705.3267-1-jekhor@gmail.com>
References: <20190918152705.3267-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
hardware has Type-C connector and register related devices described as
I2C connections in the _CRS resource.

There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with Micro-B
USB connector exists. It has INT33FE device in the DSDT table but
there are only two I2C connection described: PMIC and BQ27452 battery
fuel gauge.

Splitting existing INT33FE driver allow to maintain code for USB Micro-B
(AB) connector variant separately and make it simpler.

Split driver to intel_cht_int33fe_common.c and
intel_cht_int33fe_{typeb,typec}.c. Compile all this sources to one .ko
module to make user experience easier.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/platform/x86/Kconfig                  |  12 +-
 drivers/platform/x86/Makefile                 |   4 +
 .../platform/x86/intel_cht_int33fe_common.c   | 147 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_common.h   |  41 +++++
 .../platform/x86/intel_cht_int33fe_microb.c   |  63 ++++++++
 ...ht_int33fe.c => intel_cht_int33fe_typec.c} |  78 +---------
 6 files changed, 272 insertions(+), 73 deletions(-)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_microb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (82%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1b67bb578f9f..2537885c933f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -926,18 +926,24 @@ config INTEL_CHT_INT33FE
 	depends on CHARGER_BQ24190=y || (CHARGER_BQ24190=m && m)
 	depends on USB_ROLES_INTEL_XHCI=y || (USB_ROLES_INTEL_XHCI=m && m)
 	depends on TYPEC_MUX_PI3USB30532=y || (TYPEC_MUX_PI3USB30532=m && m)
-	---help---
+	help
 	  This driver add support for the INT33FE ACPI device found on
 	  some Intel Cherry Trail devices.
 
+	  There are two kinds of INT33FE ACPI device possible: for hardware
+	  with USB Type-C and Micro-B connectors. This driver supports both.
+
 	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
-	  resources for 3 devices: Maxim MAX17047 Fuel Gauge Controller,
+	  resources for Fuel Gauge Controller and (in the Type-C variant)
 	  FUSB302 USB Type-C Controller and PI3USB30532 USB switch.
 	  This driver instantiates i2c-clients for these, so that standard
 	  i2c drivers for these chips can bind to the them.
 
 	  If you enable this driver it is advised to also select
-	  CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m.
+	  CONFIG_BATTERY_BQ27XXX=m and CONFIG_BATTERY_BQ27XXX_I2C=m for Micro-B
+	  device and CONFIG_TYPEC_FUSB302=m and CONFIG_BATTERY_MAX17042=m
+	  for Type-C device.
+
 
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 415104033060..216d3b6fd6a7 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -61,6 +61,10 @@ obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+= toshiba_bluetooth.o
 obj-$(CONFIG_TOSHIBA_HAPS)	+= toshiba_haps.o
 obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
 obj-$(CONFIG_INTEL_CHT_INT33FE)	+= intel_cht_int33fe.o
+intel_cht_int33fe-objs		:= intel_cht_int33fe_common.o \
+				   intel_cht_int33fe_typec.o \
+				   intel_cht_int33fe_microb.o
+
 obj-$(CONFIG_INTEL_INT0002_VGPIO) += intel_int0002_vgpio.o
 obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
 obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
diff --git a/drivers/platform/x86/intel_cht_int33fe_common.c b/drivers/platform/x86/intel_cht_int33fe_common.c
new file mode 100644
index 000000000000..42dd11623f56
--- /dev/null
+++ b/drivers/platform/x86/intel_cht_int33fe_common.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common code for Intel Cherry Trail ACPI INT33FE pseudo device drivers
+ * (USB Micro-B and Type-C connector variants).
+ *
+ * Copyright (c) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "intel_cht_int33fe_common.h"
+
+#define EXPECTED_PTYPE		4
+
+static int cht_int33fe_i2c_res_filter(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_i2c_serialbus *sb;
+	int *count = data;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb))
+		(*count)++;
+
+	return 1;
+}
+
+static int cht_int33fe_count_i2c_clients(struct device *dev)
+{
+	struct acpi_device *adev;
+	LIST_HEAD(resource_list);
+	int count = 0;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return -EINVAL;
+
+	acpi_dev_get_resources(adev, &resource_list,
+			       cht_int33fe_i2c_res_filter, &count);
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	return count;
+}
+
+static int cht_int33fe_check_hw_type(struct device *dev)
+{
+	unsigned long long ptyp;
+	acpi_status status;
+	int ret;
+
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Error getting PTYPE\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * The same ACPI HID is used for different configurations check PTYP
+	 * to ensure that we are dealing with the expected config.
+	 */
+	if (ptyp != EXPECTED_PTYPE)
+		return -ENODEV;
+
+	/* Check presence of INT34D3 (hardware-rev 3) expected for ptype == 4 */
+	if (!acpi_dev_present("INT34D3", "1", 3)) {
+		dev_err(dev, "Error PTYPE == %d, but no INT34D3 device\n",
+			EXPECTED_PTYPE);
+		return -ENODEV;
+	}
+
+	ret = cht_int33fe_count_i2c_clients(dev);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case 2:
+		return INT33FE_HW_MICROB;
+	case 4:
+		return INT33FE_HW_TYPEC;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int cht_int33fe_probe(struct platform_device *pdev)
+{
+	struct cht_int33fe_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = cht_int33fe_check_hw_type(dev);
+	if (ret < 0)
+		return ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	switch (ret) {
+	case INT33FE_HW_MICROB:
+		data->probe = cht_int33fe_microb_probe;
+		data->remove = cht_int33fe_microb_remove;
+		break;
+
+	case INT33FE_HW_TYPEC:
+		data->probe = cht_int33fe_typec_probe;
+		data->remove = cht_int33fe_typec_remove;
+		break;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return data->probe(data);
+}
+
+static int cht_int33fe_remove(struct platform_device *pdev)
+{
+	struct cht_int33fe_data *data = platform_get_drvdata(pdev);
+
+	return data->remove(data);
+}
+
+static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
+	{ "INT33FE", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
+
+static struct platform_driver cht_int33fe_driver = {
+	.driver	= {
+		.name = "Intel Cherry Trail ACPI INT33FE driver",
+		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
+	},
+	.probe = cht_int33fe_probe,
+	.remove = cht_int33fe_remove,
+};
+
+module_platform_driver(cht_int33fe_driver);
+
+MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver");
+MODULE_AUTHOR("Yauhen Kharuzhy <jekhor@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel_cht_int33fe_common.h b/drivers/platform/x86/intel_cht_int33fe_common.h
new file mode 100644
index 000000000000..03cd45f4e8cb
--- /dev/null
+++ b/drivers/platform/x86/intel_cht_int33fe_common.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common code for Intel Cherry Trail ACPI INT33FE pseudo device drivers
+ * (USB Micro-B and Type-C connector variants), header file
+ *
+ * Copyright (c) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
+ */
+
+#ifndef _INTEL_CHT_INT33FE_COMMON_H
+#define _INTEL_CHT_INT33FE_COMMON_H
+
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/i2c.h>
+
+enum int33fe_hw_type {
+	INT33FE_HW_MICROB,
+	INT33FE_HW_TYPEC,
+};
+
+struct cht_int33fe_data {
+	struct device *dev;
+
+	int (*probe)(struct cht_int33fe_data *data);
+	int (*remove)(struct cht_int33fe_data *data);
+
+	struct i2c_client *battery_fg;
+
+	/* Type-C only */
+	struct i2c_client *fusb302;
+	struct i2c_client *pi3usb30532;
+
+	struct fwnode_handle *dp;
+};
+
+int cht_int33fe_microb_probe(struct cht_int33fe_data *data);
+int cht_int33fe_microb_remove(struct cht_int33fe_data *data);
+int cht_int33fe_typec_probe(struct cht_int33fe_data *data);
+int cht_int33fe_typec_remove(struct cht_int33fe_data *data);
+
+#endif /* _INTEL_CHT_INT33FE_COMMON_H */
diff --git a/drivers/platform/x86/intel_cht_int33fe_microb.c b/drivers/platform/x86/intel_cht_int33fe_microb.c
new file mode 100644
index 000000000000..6b3f66065d5c
--- /dev/null
+++ b/drivers/platform/x86/intel_cht_int33fe_microb.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Cherry Trail ACPI INT33FE pseudo device driver for devices with
+ * USB Micro-B connector (e.g. without of FUSB302 USB Type-C controller)
+ *
+ * Copyright (C) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
+ *
+ * At least one Intel Cherry Trail based device which ship with Windows 10
+ * (Lenovo YogaBook YB1-X91L/F tablet), have this weird INT33FE ACPI device
+ * with a CRS table with 2 I2cSerialBusV2 resources, for 2 different chips
+ * attached to various i2c busses:
+ * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
+ * 2. TI BQ27542 Fuel Gauge Controller
+ *
+ * So this driver is a stub / pseudo driver whose only purpose is to
+ * instantiate i2c-client for battery fuel gauge, so that standard i2c driver
+ * for these chip can bind to the it.
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/usb/pd.h>
+
+#include "intel_cht_int33fe_common.h"
+
+static const char * const bq27xxx_suppliers[] = { "bq25890-charger" };
+
+static const struct property_entry bq27xxx_props[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq27xxx_suppliers),
+	{ }
+};
+
+int cht_int33fe_microb_probe(struct cht_int33fe_data *data)
+{
+	struct device *dev = data->dev;
+	struct i2c_board_info board_info;
+
+	memset(&board_info, 0, sizeof(board_info));
+	strscpy(board_info.type, "bq27542", ARRAY_SIZE(board_info.type));
+	board_info.dev_name = "bq27542";
+	board_info.properties = bq27xxx_props;
+	data->battery_fg = i2c_acpi_new_device(dev, 1, &board_info);
+
+	if (IS_ERR(data->battery_fg)) {
+		dev_err(dev, "Failed to register battery fuel gauge: %ld\n",
+			PTR_ERR(data->battery_fg));
+		return PTR_ERR(data->battery_fg);
+	}
+
+	return 0;
+}
+
+int cht_int33fe_microb_remove(struct cht_int33fe_data *data)
+{
+	i2c_unregister_device(data->battery_fg);
+
+	return 0;
+}
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
similarity index 82%
rename from drivers/platform/x86/intel_cht_int33fe.c
rename to drivers/platform/x86/intel_cht_int33fe_typec.c
index 1d5d877b9582..2d097fc2dd46 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -17,17 +17,15 @@
  * for these chips can bind to the them.
  */
 
-#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/usb/pd.h>
 
-#define EXPECTED_PTYPE		4
+#include "intel_cht_int33fe_common.h"
 
 enum {
 	INT33FE_NODE_FUSB302,
@@ -38,14 +36,6 @@ enum {
 	INT33FE_NODE_MAX,
 };
 
-struct cht_int33fe_data {
-	struct i2c_client *max17047;
-	struct i2c_client *fusb302;
-	struct i2c_client *pi3usb30532;
-
-	struct fwnode_handle *dp;
-};
-
 static const struct software_node nodes[];
 
 static const struct software_node_ref_args pi3usb30532_ref = {
@@ -251,43 +241,20 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
 	board_info.dev_name = "max17047";
 	board_info.fwnode = fwnode;
-	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	data->battery_fg = i2c_acpi_new_device(dev, 1, &board_info);
 
-	return PTR_ERR_OR_ZERO(data->max17047);
+	return PTR_ERR_OR_ZERO(data->battery_fg);
 }
 
-static int cht_int33fe_probe(struct platform_device *pdev)
+int cht_int33fe_typec_probe(struct cht_int33fe_data *data)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = data->dev;
 	struct i2c_board_info board_info;
-	struct cht_int33fe_data *data;
 	struct fwnode_handle *fwnode;
 	struct regulator *regulator;
-	unsigned long long ptyp;
-	acpi_status status;
 	int fusb302_irq;
 	int ret;
 
-	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "Error getting PTYPE\n");
-		return -ENODEV;
-	}
-
-	/*
-	 * The same ACPI HID is used for different configurations check PTYP
-	 * to ensure that we are dealing with the expected config.
-	 */
-	if (ptyp != EXPECTED_PTYPE)
-		return -ENODEV;
-
-	/* Check presence of INT34D3 (hardware-rev 3) expected for ptype == 4 */
-	if (!acpi_dev_present("INT34D3", "1", 3)) {
-		dev_err(dev, "Error PTYPE == %d, but no INT34D3 device\n",
-			EXPECTED_PTYPE);
-		return -ENODEV;
-	}
-
 	/*
 	 * We expect the WC PMIC to be paired with a TI bq24292i charger-IC.
 	 * We check for the bq24292i vbus regulator here, this has 2 purposes:
@@ -317,10 +284,6 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		return fusb302_irq;
 	}
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	ret = cht_int33fe_add_nodes(data);
 	if (ret)
 		return ret;
@@ -365,15 +328,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		goto out_unregister_fusb302;
 	}
 
-	platform_set_drvdata(pdev, data);
-
 	return 0;
 
 out_unregister_fusb302:
 	i2c_unregister_device(data->fusb302);
 
 out_unregister_max17047:
-	i2c_unregister_device(data->max17047);
+	i2c_unregister_device(data->battery_fg);
 
 out_remove_nodes:
 	cht_int33fe_remove_nodes(data);
@@ -381,36 +342,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cht_int33fe_remove(struct platform_device *pdev)
+int cht_int33fe_typec_remove(struct cht_int33fe_data *data)
 {
-	struct cht_int33fe_data *data = platform_get_drvdata(pdev);
-
 	i2c_unregister_device(data->pi3usb30532);
 	i2c_unregister_device(data->fusb302);
-	i2c_unregister_device(data->max17047);
+	i2c_unregister_device(data->battery_fg);
 
 	cht_int33fe_remove_nodes(data);
 
 	return 0;
 }
-
-static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
-	{ "INT33FE", },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
-
-static struct platform_driver cht_int33fe_driver = {
-	.driver	= {
-		.name = "Intel Cherry Trail ACPI INT33FE driver",
-		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
-	},
-	.probe = cht_int33fe_probe,
-	.remove = cht_int33fe_remove,
-};
-
-module_platform_driver(cht_int33fe_driver);
-
-MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver");
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.23.0.rc1

