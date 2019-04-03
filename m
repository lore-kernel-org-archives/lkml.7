Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0BC20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GCIrdWW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDCJB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:01:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33012 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfDCJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:01:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so20256608wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGw5YilbSP88yNY2O1thS+S3CD6jvEmYujvzOlhreok=;
        b=GCIrdWW/SjR698tUSSyfH/GEQmMym72ZeiZpq3/W8gYRvCMPARAdpK6/wjAlbJ88ag
         qhhm2Ld+VxZF/MsOH/Hed1JS3llJd5yj1ORSNsNL8FQJFebZJyVVY7IX392M/xuIi9TD
         lKEJIxr4ktmmimMHY/r3ZQ3/xiqarJrQCYF/hdWj8mmq6BEeOSNn6hp1n8XM9Y2Q1k6T
         H0nUcGcJO9MTKhFEoza/+DJmzkIzONEZLLSIPtUYxpGtGp7znF0p/eum3POZqeShV/cl
         QmEf5bNYaHSEb+OEA+JFyxZPA5oU8xca02iUqrjW/v6vAR1FWHC4aLo2lHnyg/MqIQcV
         mLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGw5YilbSP88yNY2O1thS+S3CD6jvEmYujvzOlhreok=;
        b=AfJlg6jUf1YQcFtUH4WhYpp8vc5e2AIjiXWSm+po5IsJlFN+zSa2L/2IJP1t0Kckgn
         AeZOjHlY+fVLAQhvCRjliiEQa1Hcc8Gxvv/PrePvMkTc1zsAcSDtAtWTp1q/XloRgM5f
         YoP34jDi0S4DzLzKy/YLork2U5yg5886PuJB4rpp2XnH/7OwdF3pDspOmgpi3p4R2yC9
         DmfvBzrO1R5OJUlpODED4+p6b3YTxqILJS8JFvknqR6hrAt2mILyvFPayY5PsWEvhYcS
         ScKlAXc0qKvIad8M29p7b42du1rqlazFDysMtxBuz7OZ444+UQNKAzbk/+3dDqCmMjoi
         lZnw==
X-Gm-Message-State: APjAAAUwPpWx54VoPQeyHVSs3VQvceKaYSi/ues3rC30AD+zNRZ2+ao/
        DDlnCirTjCmoqteM/ArvLelQXw==
X-Google-Smtp-Source: APXvYqxDEKAdLY/7B29PdXYPAqoUuI8Ocl0AFyebpymyqOy0AT1zfpbQWL8pUzcukavntFJ6w7AfHg==
X-Received: by 2002:adf:e692:: with SMTP id r18mr51756759wrm.231.1554282090732;
        Wed, 03 Apr 2019 02:01:30 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v16sm23981998wru.76.2019.04.03.02.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:01:30 -0700 (PDT)
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
Subject: [PATCH v8 08/11] gpio: max77650: add GPIO support
Date:   Wed,  3 Apr 2019 11:01:05 +0200
Message-Id: <20190403090108.24788-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403090108.24788-1-brgl@bgdev.pl>
References: <20190403090108.24788-1-brgl@bgdev.pl>
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
2.21.0

