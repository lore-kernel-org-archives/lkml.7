Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6735206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l4VRd/0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfCZRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:32:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34034 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbfCZRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:32:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so2907573wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Gleiq5zYvfhbfRDS1ZCmgnxZSMTFcmrIEjqZlAkQOE=;
        b=l4VRd/0TNpuwX1rWSpPoLRJZdt+kr4Y5+Dyg3mDvIZwdCfcXxc6VJ9aLVQW6KLe1bS
         OcpYGLxHcWjGVjtza779xnsF7Ujp3DngHhdFHN9tlzEXYsCsuw6e/9GnLpPaHkyoPcjR
         DdDqeoyvrTdcJ6VAVIW+0SLpGvlaXTY4RQS8ZmMj6F5QbM48vjR6TWzorg0sNVEBQguu
         Af457RYxCpIp6utlZYMP/tec59h8trWg+D35V7DNm/oiNIrJJU6xBKU3f60DvPT91WEL
         LOPPbSIvuqLZUHxP4JGrz4ig3/fpEfr5cu6v5DPGK6zKiBM7gdEyILMq+yfkyGh4Y2da
         tGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Gleiq5zYvfhbfRDS1ZCmgnxZSMTFcmrIEjqZlAkQOE=;
        b=bZ9pokbaw489KsI3v/a/1yEqZGvbkqcsacocFLMUbsP/GlnOazYV0ydT1V6Pu85PIv
         bL2CG8WB45AUmrT+u+0Z3JV9+G4xL8trALQo7StmuXXDpwup6FCRRLW4Pm2odNTP72Ng
         OEbUlZDa7Gzo/THHI6eSKeC8AxyDgXOkKECB9WHtdSVQTrWdp49IowcVb35yAd5xW2U9
         A/1GIE+WnlV59zWtnt69MwJ8+z9cKJF7umZF7Kxr7kRAxI171bgt5CJvY1Y5AABnb8NK
         1bjUV0yAsR5r9OsA1FXXM0okNNRzd1+NJVSLpXRTrvLlyhYD1lz7wKlheWWDtPT5w9M2
         Iskg==
X-Gm-Message-State: APjAAAU4Oo+g0iDE1FmhzqyVskBHZf2+c9FvwsX1fIsAnzp0oRrojBRx
        WntcUry6YdYiEq5Jaj5SQC4sUw==
X-Google-Smtp-Source: APXvYqydLOP/3jys95z3dx6hU9n2OvnLUC/RZwtjMKwNOe2sBry+8hF57PcA4Os3glfOfBJgaqtPRw==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr10318474wmi.117.1553621552654;
        Tue, 26 Mar 2019 10:32:32 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 4sm2534541wmg.12.2019.03.26.10.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:32:31 -0700 (PDT)
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
Subject: [PATCH v7 08/11] gpio: max77650: add GPIO support
Date:   Tue, 26 Mar 2019 18:32:05 +0100
Message-Id: <20190326173208.30614-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
References: <20190326173208.30614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add GPIO support for max77650 mfd device. This PMIC exposes a single
GPIO line.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/Kconfig         |   7 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-max77650.c | 190 +++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/gpio/gpio-max77650.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526a771f..c4f912104440 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1112,6 +1112,13 @@ config GPIO_MAX77620
 	  driver also provides interrupt support for each of the gpios.
 	  Say yes here to enable the max77620 to be used as gpio controller.
 
+config GPIO_MAX77650
+	tristate "Maxim MAX77650/77651 GPIO support"
+	depends on MFD_MAX77650
+	help
+	  GPIO driver for MAX77650/77651 PMIC from Maxim Semiconductor.
+	  These chips have a single pin that can be configured as GPIO.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 54d55274b93a..075722d8317d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
 obj-$(CONFIG_GPIO_MAX732X)	+= gpio-max732x.o
 obj-$(CONFIG_GPIO_MAX77620)	+= gpio-max77620.o
+obj-$(CONFIG_GPIO_MAX77650)	+= gpio-max77650.o
 obj-$(CONFIG_GPIO_MB86S7X)	+= gpio-mb86s7x.o
 obj-$(CONFIG_GPIO_MENZ127)	+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)	+= gpio-merrifield.o
diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
new file mode 100644
index 000000000000..3f03f4e8956c
--- /dev/null
+++ b/drivers/gpio/gpio-max77650.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 BayLibre SAS
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// GPIO driver for MAXIM 77650/77651 charger/power-supply.
+
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max77650.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77650_GPIO_DIR_MASK		BIT(0)
+#define MAX77650_GPIO_INVAL_MASK	BIT(1)
+#define MAX77650_GPIO_DRV_MASK		BIT(2)
+#define MAX77650_GPIO_OUTVAL_MASK	BIT(3)
+#define MAX77650_GPIO_DEBOUNCE_MASK	BIT(4)
+
+#define MAX77650_GPIO_DIR_OUT		0x00
+#define MAX77650_GPIO_DIR_IN		BIT(0)
+#define MAX77650_GPIO_OUT_LOW		0x00
+#define MAX77650_GPIO_OUT_HIGH		BIT(3)
+#define MAX77650_GPIO_DRV_OPEN_DRAIN	0x00
+#define MAX77650_GPIO_DRV_PUSH_PULL	BIT(2)
+#define MAX77650_GPIO_DEBOUNCE		BIT(4)
+
+#define MAX77650_GPIO_DIR_BITS(_reg) \
+		((_reg) & MAX77650_GPIO_DIR_MASK)
+#define MAX77650_GPIO_INVAL_BITS(_reg) \
+		(((_reg) & MAX77650_GPIO_INVAL_MASK) >> 1)
+
+struct max77650_gpio_chip {
+	struct regmap *map;
+	struct gpio_chip gc;
+	int irq;
+};
+
+static int max77650_gpio_direction_input(struct gpio_chip *gc,
+					 unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO,
+				  MAX77650_GPIO_DIR_MASK,
+				  MAX77650_GPIO_DIR_IN);
+}
+
+static int max77650_gpio_direction_output(struct gpio_chip *gc,
+					  unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int mask, regval;
+
+	mask = MAX77650_GPIO_DIR_MASK | MAX77650_GPIO_OUTVAL_MASK;
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+	regval |= MAX77650_GPIO_DIR_OUT;
+
+	return regmap_update_bits(chip->map,
+				  MAX77650_REG_CNFG_GPIO, mask, regval);
+}
+
+static void max77650_gpio_set_value(struct gpio_chip *gc,
+				    unsigned int offset, int value)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	int rv, regval;
+
+	regval = value ? MAX77650_GPIO_OUT_HIGH : MAX77650_GPIO_OUT_LOW;
+
+	rv = regmap_update_bits(chip->map, MAX77650_REG_CNFG_GPIO,
+				MAX77650_GPIO_OUTVAL_MASK, regval);
+	if (rv)
+		dev_err(gc->parent, "cannot set GPIO value: %d\n", rv);
+}
+
+static int max77650_gpio_get_value(struct gpio_chip *gc,
+				   unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_INVAL_BITS(val);
+}
+
+static int max77650_gpio_get_direction(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	unsigned int val;
+	int rv;
+
+	rv = regmap_read(chip->map, MAX77650_REG_CNFG_GPIO, &val);
+	if (rv)
+		return rv;
+
+	return MAX77650_GPIO_DIR_BITS(val);
+}
+
+static int max77650_gpio_set_config(struct gpio_chip *gc,
+				    unsigned int offset, unsigned long cfg)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	switch (pinconf_to_config_param(cfg)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_OPEN_DRAIN);
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DRV_MASK,
+					  MAX77650_GPIO_DRV_PUSH_PULL);
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return regmap_update_bits(chip->map,
+					  MAX77650_REG_CNFG_GPIO,
+					  MAX77650_GPIO_DEBOUNCE_MASK,
+					  MAX77650_GPIO_DEBOUNCE);
+	default:
+		return -ENOTSUPP;
+	}
+}
+
+static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+
+	return chip->irq;
+}
+
+static int max77650_gpio_probe(struct platform_device *pdev)
+{
+	struct max77650_gpio_chip *chip;
+	struct device *dev, *parent;
+	struct i2c_client *i2c;
+
+	dev = &pdev->dev;
+	parent = dev->parent;
+	i2c = to_i2c_client(parent);
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->map = dev_get_regmap(parent, NULL);
+	if (!chip->map)
+		return -ENODEV;
+
+	chip->irq = platform_get_irq_byname(pdev, "GPI");
+	if (chip->irq < 0)
+		return chip->irq;
+
+	chip->gc.base = -1;
+	chip->gc.ngpio = 1;
+	chip->gc.label = i2c->name;
+	chip->gc.parent = dev;
+	chip->gc.owner = THIS_MODULE;
+	chip->gc.can_sleep = true;
+
+	chip->gc.direction_input = max77650_gpio_direction_input;
+	chip->gc.direction_output = max77650_gpio_direction_output;
+	chip->gc.set = max77650_gpio_set_value;
+	chip->gc.get = max77650_gpio_get_value;
+	chip->gc.get_direction = max77650_gpio_get_direction;
+	chip->gc.set_config = max77650_gpio_set_config;
+	chip->gc.to_irq = max77650_gpio_to_irq;
+
+	return devm_gpiochip_add_data(dev, &chip->gc, chip);
+}
+
+static struct platform_driver max77650_gpio_driver = {
+	.driver = {
+		.name = "max77650-gpio",
+	},
+	.probe = max77650_gpio_probe,
+};
+module_platform_driver(max77650_gpio_driver);
+
+MODULE_DESCRIPTION("MAXIM 77650/77651 GPIO driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

