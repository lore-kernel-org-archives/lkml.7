Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81278C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474D22184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BEuXvzvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDKMnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:43:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39631 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDKMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so6493089wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPfsZHOrFhAluR8d0b1i0AQn5YZ9ojyzTFq/9FNkWfw=;
        b=BEuXvzvtArU2MgwWXuk+kWMXMpoztuYwDIBDakwi2LBTTP2iZrckOH5SWFxvbltapr
         MaYK7lfxIwNtdm7Uwo3dAFESIEzMI8I6P9aO3Y39U9bFl4inKpHS9y+Hk/1GcqP5QE66
         26/ivuEm5th+mks4SX87NOlnAlzzUZHh1L6L/BpV/ooAsMv5eWUagHW3MVTOgq0WrKHu
         aACSzLpyjL9B9yUgvmu+EZIyzvnGcIDi4o1nheaEqqKQSgWTHGoCWkXqmgUJhqndAIeN
         PIqOqG09bbACd89Da6shRBw+xw+Dr4lqyM88Y+OhqvUEm8AROJYoTVKxr1jzp2qfdt0e
         pKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPfsZHOrFhAluR8d0b1i0AQn5YZ9ojyzTFq/9FNkWfw=;
        b=AlJ0n1sZesH8/mi8T/bMV0PhYF/UbRyQm4B/Yd+vm6b9zcpcFqnjwD0bVkhiwJoU05
         N1OH4rrr0aEsKVhqsrOF5ZgC2Gkemo+mGAABDUiHEdXpA5xhRP8mjRboTlbyHI28YAPy
         XMKHHkd77uuSx/2KH2S8NowO4OUt9i0dfjf/LtGie/tFtZY39M6oyLq8VD56XSg1FsGO
         1bbl8XrSYJ47vnsMMW67rpurBd/huwvEhs4FlP5vOc1PMPudQNw5qHyYlRhpyn5veasv
         X14Iw8Tme6paobw0K7rHtTUw37p90edGXRmj/0Mn1P2xLvDq5KhdbWm7ZfPWFFhvHoKY
         r3pg==
X-Gm-Message-State: APjAAAUiMFMeuKNd2P4HRlBj1LrDFGYkz783wBk4ajEvne28X0sOxAbF
        316/8qc10Qmz095vGLFZD1T+Gw==
X-Google-Smtp-Source: APXvYqyBrPHTKS6sCkWtr0qHUhJIP9IeW1d3yZ0oAhESLof/8IGL+slZNQrhX0JdBugodXVZ62Bghg==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr6273020wmh.138.1554986553536;
        Thu, 11 Apr 2019 05:42:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id d4sm32894510wrv.42.2019.04.11.05.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 05:42:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v9 09/11] leds: max77650: add LEDs support
Date:   Thu, 11 Apr 2019 14:42:10 +0200
Message-Id: <20190411124212.7612-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411124212.7612-1-brgl@bgdev.pl>
References: <20190411124212.7612-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This adds basic support for LEDs for the max77650 PMIC. The device has
three current sinks for driving LEDs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/Kconfig         |   6 ++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77650.c | 147 +++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/leds/leds-max77650.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a72f97fca57b..d8c70cc6a714 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -608,6 +608,12 @@ config LEDS_TLC591XX
 	  This option enables support for Texas Instruments TLC59108
 	  and TLC59116 LED controllers.
 
+config LEDS_MAX77650
+	tristate "LED support for Maxim MAX77650 PMIC"
+	depends on LEDS_CLASS && MFD_MAX77650
+	help
+	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
+
 config LEDS_MAX77693
 	tristate "LED support for MAX77693 Flash"
 	depends on LEDS_CLASS_FLASH
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4c1b0054f379..f48b2404dbb7 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
 obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
 obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
+obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX77693)		+= leds-max77693.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
new file mode 100644
index 000000000000..6b74ce9cac12
--- /dev/null
+++ b/drivers/leds/leds-max77650.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// LED driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_LED_NUM_LEDS		3
+
+#define MAX77650_LED_A_BASE		0x40
+#define MAX77650_LED_B_BASE		0x43
+
+#define MAX77650_LED_BR_MASK		GENMASK(4, 0)
+#define MAX77650_LED_EN_MASK		GENMASK(7, 6)
+
+#define MAX77650_LED_MAX_BRIGHTNESS	MAX77650_LED_BR_MASK
+
+/* Enable EN_LED_MSTR. */
+#define MAX77650_LED_TOP_DEFAULT	BIT(0)
+
+#define MAX77650_LED_ENABLE		GENMASK(7, 6)
+#define MAX77650_LED_DISABLE		0x00
+
+#define MAX77650_LED_A_DEFAULT		MAX77650_LED_DISABLE
+/* 100% on duty */
+#define MAX77650_LED_B_DEFAULT		GENMASK(3, 0)
+
+struct max77650_led {
+	struct led_classdev cdev;
+	struct regmap *map;
+	unsigned int regA;
+	unsigned int regB;
+};
+
+static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct max77650_led, cdev);
+}
+
+static int max77650_led_brightness_set(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct max77650_led *led = max77650_to_led(cdev);
+	int val, mask;
+
+	mask = MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
+
+	if (brightness == LED_OFF)
+		val = MAX77650_LED_DISABLE;
+	else
+		val = MAX77650_LED_ENABLE | brightness;
+
+	return regmap_update_bits(led->map, led->regA, mask, val);
+}
+
+static int max77650_led_probe(struct platform_device *pdev)
+{
+	struct device_node *of_node, *child;
+	struct max77650_led *leds, *led;
+	struct device *parent;
+	struct device *dev;
+	struct regmap *map;
+	const char *label;
+	int rv, num_leds;
+	u32 reg;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	of_node = dev->of_node;
+
+	if (!of_node)
+		return -ENODEV;
+
+	leds = devm_kcalloc(dev, sizeof(*leds),
+			    MAX77650_LED_NUM_LEDS, GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	map = dev_get_regmap(dev->parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	num_leds = of_get_child_count(of_node);
+	if (!num_leds || num_leds > MAX77650_LED_NUM_LEDS)
+		return -ENODEV;
+
+	for_each_child_of_node(of_node, child) {
+		rv = of_property_read_u32(child, "reg", &reg);
+		if (rv || reg >= MAX77650_LED_NUM_LEDS)
+			return -EINVAL;
+
+		led = &leds[reg];
+		led->map = map;
+		led->regA = MAX77650_LED_A_BASE + reg;
+		led->regB = MAX77650_LED_B_BASE + reg;
+		led->cdev.brightness_set_blocking = max77650_led_brightness_set;
+		led->cdev.max_brightness = MAX77650_LED_MAX_BRIGHTNESS;
+
+		label = of_get_property(child, "label", NULL);
+		if (!label) {
+			led->cdev.name = "max77650::";
+		} else {
+			led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
+							"max77650:%s", label);
+			if (!led->cdev.name)
+				return -ENOMEM;
+		}
+
+		of_property_read_string(child, "linux,default-trigger",
+					&led->cdev.default_trigger);
+
+		rv = devm_of_led_classdev_register(dev, child, &led->cdev);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(map, led->regA, MAX77650_LED_A_DEFAULT);
+		if (rv)
+			return rv;
+
+		rv = regmap_write(map, led->regB, MAX77650_LED_B_DEFAULT);
+		if (rv)
+			return rv;
+	}
+
+	return regmap_write(map,
+			    MAX77650_REG_CNFG_LED_TOP,
+			    MAX77650_LED_TOP_DEFAULT);
+}
+
+static struct platform_driver max77650_led_driver = {
+	.driver = {
+		.name = "max77650-led",
+	},
+	.probe = max77650_led_probe,
+};
+module_platform_driver(max77650_led_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

