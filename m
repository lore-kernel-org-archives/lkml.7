Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA021855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OGRYZfuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfDEO4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:56:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33316 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfDEOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:55:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35EtsjY105067;
        Fri, 5 Apr 2019 09:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554476154;
        bh=AKa+U/TawWkjTQEM6Wa0ywxCRzJ60DjmR5NjaxW0ARk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OGRYZfuuZF5JD2TeSWmDcj7PGQvBw3zpdQad0isl8GIwMtwdw+y3P7WwvVmRxNnAv
         rPzkyTYnTbfgooF0WqijEWoaIdbdLfc0QCSNtTDTxlcJPP2AaqTeY636M2Rexh7qG4
         2AvNVIkQzC0WTOK1KsaJl5N3jh8E85AeeOXQUa/Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35Etrhh121253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:55:54 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:55:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:55:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35EtrDp081088;
        Fri, 5 Apr 2019 09:55:53 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 6/6] leds: lm36274: Introduce the TI LM36274 LED driver
Date:   Fri, 5 Apr 2019 09:55:40 -0500
Message-ID: <20190405145540.27703-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405145540.27703-1-dmurphy@ti.com>
References: <20190405145540.27703-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the LM36274 LED driver.  This driver uses the ti-lmu
MFD driver to probe this LED driver.  The driver configures only the
LED registers and enables the outputs according to the config file.

The driver utilizes the ti-lmu-led-common framework to set the brightness
bits.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig        |   9 +-
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-lm36274.c | 174 ++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/leds-lm36274.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 2d1576f4d5d6..c0bf59544886 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -783,12 +783,19 @@ config LEDS_LM3697
 	  Say Y to enable the LM3697 LED driver for TI LMU devices.
 	  This supports the LED device LM3697.
 
+config LEDS_LM36274
+	tristate "LED driver for LM36274"
+	depends on LEDS_TI_LMU_COMMON
+	help
+	  Say Y to enable the LM36274 LED driver for TI LMU devices.
+	  This supports the LED device LM36274.
+
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
 	help
           Say Y to enable the LED driver for TI LMU devices.
           This supports common features between the TI LM3532, LM3631, LM3632,
-	  LM3633, LM3695 and LM3697.
+	  LM3633, LM3695, LM3697 and LM36274
 
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 2eb0225d8dc6..7ff67215b38c 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
 obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
+obj-$(CONFIG_LEDS_LM36274)		+= leds-lm36274.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-lm36274.c b/drivers/leds/leds-lm36274.c
new file mode 100644
index 000000000000..6a419c47c47f
--- /dev/null
+++ b/drivers/leds/leds-lm36274.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LM36274 LED chip family driver
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/ti-lmu-led-common.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/ti-lmu.h>
+#include <linux/mfd/ti-lmu-register.h>
+
+#include <uapi/linux/uleds.h>
+
+#define LM36274_MAX_STRINGS	4
+#define LM36274_BL_EN		BIT(4)
+
+/**
+ * struct lm36274
+ * @pdev: platform device
+ * @led_dev: led class device
+ * @lmu_data: Register and setting values for common code
+ * @regmap: Devices register map
+ * @dev: Pointer to the devices device struct
+ * @led_sources - The LED strings supported in this array
+ * @num_leds - Number of LED strings are supported in this array
+ */
+struct lm36274 {
+	struct platform_device *pdev;
+	struct led_classdev led_dev;
+	struct ti_lmu_bank lmu_data;
+	struct regmap *regmap;
+	struct device *dev;
+
+	u32 led_sources[LM36274_MAX_STRINGS];
+	int num_leds;
+};
+
+static int lm36274_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lm36274 *led = container_of(led_cdev, struct lm36274, led_dev);
+
+	return ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
+}
+
+static int lm36274_init(struct lm36274 *lm36274_data)
+{
+	int enable_val = 0;
+	int i;
+
+	for (i = 0; i < lm36274_data->num_leds; i++)
+		enable_val |= (1 << lm36274_data->led_sources[i]);
+
+	if (!enable_val) {
+		dev_err(lm36274_data->dev, "No LEDs were enabled\n");
+		return -EINVAL;
+	}
+
+	enable_val |= LM36274_BL_EN;
+
+	return regmap_write(lm36274_data->regmap, LM36274_REG_BL_EN,
+			    enable_val);
+}
+
+static int lm36274_parse_dt(struct lm36274 *lm36274_data)
+{
+	struct fwnode_handle *child = NULL;
+	char label[LED_MAX_NAME_SIZE];
+	struct device *dev = &lm36274_data->pdev->dev;
+	const char *name;
+	int child_cnt;
+	int ret = -EINVAL;
+
+	/* There should only be 1 node */
+	child_cnt = device_get_child_node_count(dev);
+	if (child_cnt != 1)
+		return ret;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret)
+			snprintf(label, sizeof(label),
+				"%s::", lm36274_data->pdev->name);
+		else
+			snprintf(label, sizeof(label),
+				 "%s:%s", lm36274_data->pdev->name, name);
+
+		lm36274_data->num_leds = fwnode_property_read_u32_array(child,
+							  "led-sources",
+							  NULL, 0);
+		if (lm36274_data->num_leds <= 0)
+			return -ENODEV;
+
+		ret = fwnode_property_read_u32_array(child, "led-sources",
+						     lm36274_data->led_sources,
+						     lm36274_data->num_leds);
+		if (ret) {
+			dev_err(dev, "led-sources property missing\n");
+			return -EINVAL;
+		}
+
+		fwnode_property_read_string(child, "linux,default-trigger",
+					&lm36274_data->led_dev.default_trigger);
+
+	}
+
+	lm36274_data->lmu_data.regmap = lm36274_data->regmap;
+	lm36274_data->lmu_data.max_brightness = MAX_BRIGHTNESS_11BIT;
+	lm36274_data->lmu_data.msb_brightness_reg = LM36274_REG_BRT_MSB;
+	lm36274_data->lmu_data.lsb_brightness_reg = LM36274_REG_BRT_LSB;
+
+	lm36274_data->led_dev.name = label;
+	lm36274_data->led_dev.max_brightness = MAX_BRIGHTNESS_11BIT;
+	lm36274_data->led_dev.brightness_set_blocking = lm36274_brightness_set;
+
+	return ret;
+}
+
+static int lm36274_probe(struct platform_device *pdev)
+{
+	struct ti_lmu *lmu = dev_get_drvdata(pdev->dev.parent);
+	struct lm36274 *lm36274_data;
+	int ret;
+
+	lm36274_data = devm_kzalloc(&pdev->dev, sizeof(*lm36274_data),
+				    GFP_KERNEL);
+	if (!lm36274_data) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	lm36274_data->pdev = pdev;
+	lm36274_data->dev = lmu->dev;
+	lm36274_data->regmap = lmu->regmap;
+	dev_set_drvdata(&pdev->dev, lm36274_data);
+
+	ret = lm36274_parse_dt(lm36274_data);
+	if (ret) {
+		dev_err(lm36274_data->dev, "Failed to parse DT node\n");
+		return ret;
+	}
+
+	ret = lm36274_init(lm36274_data);
+	if (ret) {
+		dev_err(lm36274_data->dev, "Failed to init the device\n");
+		return ret;
+	}
+
+	return devm_led_classdev_register(lm36274_data->dev,
+					 &lm36274_data->led_dev);
+}
+
+static const struct of_device_id of_lm36274_leds_match[] = {
+	{ .compatible = "ti,lm36274-backlight", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lm36274_leds_match);
+
+static struct platform_driver lm36274_driver = {
+	.probe  = lm36274_probe,
+	.driver = {
+		.name = "lm36274-leds",
+	},
+};
+module_platform_driver(lm36274_driver)
+
+MODULE_DESCRIPTION("Texas Instruments LM36274 LED driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

