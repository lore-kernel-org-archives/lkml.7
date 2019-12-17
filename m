Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3057EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCFB2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJmV12Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfLQMRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:17:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfLQMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:17:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so11059773wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVqcfTgjqDIP2wy7JDCyl9+vrKLd49ALRMx75DX6+Wc=;
        b=FJmV12Z9o79SLdhEWr5+T6LjN72YQvI8I5rXdPbm2D1C8KFHb4r2UtTdawkgvN6Ltr
         u/qyJFDz5dZLFIBXDlt4QcICzRDXUTg0hHw636UCf3Trav1QxVYX7FcNk7heMWHF5kUO
         pZfnNZrl/H4kFCPeCu0LceG83AVqU+2HNMcKBk2HafX3IdSz09RjjlnhbI9+oAPzomp1
         Sg/9nNGomHJyWnBV56dsDdX4AjrrU5Gr9gqracEpPdWb8wiqIvHDhFfdG0vruRZM263H
         QlGZU//Z7L58oXXY3afMyOOKjBCQppKBJfkDlzt+g7M5QEgySkBI/229dfSnRTCz6AcA
         Hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVqcfTgjqDIP2wy7JDCyl9+vrKLd49ALRMx75DX6+Wc=;
        b=rejMUbxhXnp2nrsus64ulkxdLkS0W7o1Na8HqyDqbD6NXXrDQWhcnPkm4d7R6XOh5L
         Rd0jlMD8Ve0D6G7qUDQ3aYITuTmpf3nxAIklwk+bBih+8m1oBYcipqNolO1BLAJaLr0C
         oP9tUZYV1ZYwnRUuv04F5oZddUvnEcZKdxhxnsTIhHXDnMCrwAyvSxDd2oNKd+5xsWNp
         4cW2eKLII/1j1RQzkVqxexwtExiUQ2GVMte3eosowQVYFnrqrR3ure/IRZWylwyFQ/dt
         XjnxSrz+rTJYeMQ0iU7QiiZI1lrfA3jaFgCafHOvge7NCXeTc/DJLYMIz/ya+3NIO56b
         aSOA==
X-Gm-Message-State: APjAAAVssRXcR2Eg/uaUpn3UWZMRuegTFon7qj0FRJkFod39FsLexKxn
        S9JI0nEgVpQJdmrBL84xP5LoNw==
X-Google-Smtp-Source: APXvYqxI8zjRqAqvVE2CT5mmoo1tSkKgcBWGCL6qkh/AcQp+7aMawPDnKwJbbrI37VoCCKTPuzhmpg==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr36111061wrx.393.1576585031908;
        Tue, 17 Dec 2019 04:17:11 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:17:11 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 09/11] gpio: wcd934x: Add support to wcd934x gpio controller
Date:   Tue, 17 Dec 2019 12:16:40 +0000
Message-Id: <20191217121642.28534-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to wcd934x gpio block found in
WCD9340/WC9341 Audio codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/gpio/Kconfig        |   8 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-wcd934x.c | 104 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/gpio/gpio-wcd934x.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8adffd42f8cb..3da3e228c221 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -613,6 +613,14 @@ config GPIO_VX855
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config GPIO_WCD934X
+	tristate "Qualcomm Technologies Inc WCD9340/WCD9341 gpio controller driver"
+	depends on MFD_WCD934X && OF_GPIO
+	select GPIO_GENERIC
+	help
+         This driver is to supprot GPIO block found on the Qualcomm Technologies
+	 Inc WCD9340/WCD9341 Audio Codec.
+
 config GPIO_XGENE
 	bool "APM X-Gene GPIO controller support"
 	depends on ARM64 && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 34eb8b2b12dd..116133f905e7 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -157,6 +157,7 @@ obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VR41XX)		+= gpio-vr41xx.o
 obj-$(CONFIG_GPIO_VX855)		+= gpio-vx855.o
+obj-$(CONFIG_GPIO_WCD934X)		+= gpio-wcd934x.o
 obj-$(CONFIG_GPIO_WHISKEY_COVE)		+= gpio-wcove.o
 obj-$(CONFIG_GPIO_WINBOND)		+= gpio-winbond.o
 obj-$(CONFIG_GPIO_WM831X)		+= gpio-wm831x.o
diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
new file mode 100644
index 000000000000..0aac33235c5f
--- /dev/null
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019, Linaro Limited
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+
+#define WCD_PIN_MASK(p) BIT(p - 1)
+#define WCD_REG_DIR_CTL_OFFSET 0x42
+#define WCD_REG_VAL_CTL_OFFSET 0x43
+#define WCD934X_NPINS		5
+
+struct wcd_gpio_data {
+	struct regmap *map;
+	struct gpio_chip chip;
+};
+
+static int wcd_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+
+	return regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+				  WCD_PIN_MASK(pin), 0);
+}
+
+static int wcd_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
+				     int val)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+
+	regmap_update_bits(data->map, WCD_REG_DIR_CTL_OFFSET,
+			   WCD_PIN_MASK(pin), WCD_PIN_MASK(pin));
+
+	return regmap_update_bits(data->map, WCD_REG_VAL_CTL_OFFSET,
+				  WCD_PIN_MASK(pin),
+				  val ? WCD_PIN_MASK(pin) : 0);
+}
+
+static int wcd_gpio_get(struct gpio_chip *chip, unsigned int pin)
+{
+	struct wcd_gpio_data *data = gpiochip_get_data(chip);
+	int value;
+
+	regmap_read(data->map, WCD_REG_VAL_CTL_OFFSET, &value);
+
+	return !!(value && WCD_PIN_MASK(pin));
+}
+
+static void wcd_gpio_set(struct gpio_chip *chip, unsigned int pin, int val)
+{
+	wcd_gpio_direction_output(chip, pin, val);
+}
+
+static int wcd_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct wcd_gpio_data *data;
+	struct gpio_chip *chip;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->map = dev_get_regmap(dev->parent, NULL);
+	if (!data->map) {
+		dev_err(dev, "%s: failed to get regmap\n", __func__);
+		return  -EINVAL;
+	}
+
+	chip = &data->chip;
+	chip->direction_input  = wcd_gpio_direction_input;
+	chip->direction_output = wcd_gpio_direction_output;
+	chip->get = wcd_gpio_get;
+	chip->set = wcd_gpio_set;
+	chip->parent = dev;
+	chip->base = -1;
+	chip->ngpio = WCD934X_NPINS;
+	chip->label = dev_name(dev);
+	chip->of_gpio_n_cells = 2;
+	chip->can_sleep = false;
+
+	return devm_gpiochip_add_data(dev, chip, data);
+}
+
+static const struct of_device_id wcd_gpio_of_match[] = {
+	{ .compatible = "qcom,wcd9340-gpio" },
+	{ .compatible = "qcom,wcd9341-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wcd_gpio_of_match);
+
+static struct platform_driver wcd_gpio_driver = {
+	.driver = {
+		   .name = "wcd934x-gpio",
+		   .of_match_table = wcd_gpio_of_match,
+	},
+	.probe = wcd_gpio_probe,
+};
+
+module_platform_driver(wcd_gpio_driver);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc WCD GPIO control driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

