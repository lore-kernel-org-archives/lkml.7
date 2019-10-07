Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79679C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B88217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VEhWSNZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJGDcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:32:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfJGDcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:32:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so7749691pfw.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 20:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4a+pKVTYSrGaRJIHf88S7PAjoi+WG4Wfk9hIUcxXSg=;
        b=VEhWSNZoLO5WHHbpp9caxeGXuImosevibbsBdB/CmdKiB1x1QaJiw3PM+vtD47onTj
         YnRJWOaxfiYOZMGKnNbIAnpk+Lkq3FitSuXfKNWTeVjsYnLhroWVQs+X9ZiUO38IcwTd
         rYYrkk7IaNSq5w6fCEOUfRmZ9UZ8BXM1z/VvKLUdDa5+ITtgJ6i795wC/Ax32hcUvskA
         5XpcsN84YILPA2nLpfRifCQHKvAQu0rAFy8Ro1p1OrvG8Ax57GMGJEO+PYc96po6eCAp
         6cQLwl1Rsh7FmaNNg7cNvfCg8BiyO0ggdLaZlKDi4Ouwzk9EVF/CUd28ES5S5X3zjTX3
         ccJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4a+pKVTYSrGaRJIHf88S7PAjoi+WG4Wfk9hIUcxXSg=;
        b=XCnpewz71gXA6AzegQFNKkAfl8Tq7ftxcet8rfgTUbmm4Ix8AA0uirViYsjMqBZ7eu
         OOaXMaL9pmtbD0d62YxcdFHPpCdArWKIWq2j9VAb/B9VmO1ZvrOTtdOkNdoz5GQ9gB53
         m20+4U6jVvt9BlE6GEPzFJvtMYcSnyPxUxrPKtdmJTl/Ks9VZNILBYv7/gTtjJc6pHO9
         brXsFDb0jKCIp7882hMWultBSqThk9XAGEdSs3YD9ENIuXmXHiwFEIctv2JTiuwcg7yw
         lKn94mS/BK/zlTZVdWBeRYcX8eVcAvJEIuGCL1DmTVPBeC6D+t8z7pWN8dYm/XQb/N9d
         rGHQ==
X-Gm-Message-State: APjAAAWtM45KqSfj4+xx1f8ZvkI/xXQqOZSpvWHfzy4E3cYK1NsjdmV7
        XIQBfGf4rSoUUvBMGi9frxUNIQ==
X-Google-Smtp-Source: APXvYqxJi6Cn38KU2ldDEqD3uN4eN8sBJwkVwzMxJCScyN7v5yPIeq7dl+xAxIUxlchljuW1E7ZgqA==
X-Received: by 2002:a63:705b:: with SMTP id a27mr27756444pgn.136.1570419132502;
        Sun, 06 Oct 2019 20:32:12 -0700 (PDT)
Received: from debian-brgl.local (96-95-220-76-static.hfc.comcastbusiness.net. [96.95.220.76])
        by smtp.gmail.com with ESMTPSA id x10sm16377720pfr.44.2019.10.06.20.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 20:32:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 7/7] backlight: gpio: pull gpio_backlight_initial_power_state() into probe
Date:   Mon,  7 Oct 2019 05:32:00 +0200
Message-Id: <20191007033200.13443-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007033200.13443-1-brgl@bgdev.pl>
References: <20191007033200.13443-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The probe function in the gpio-backlight driver is quite short. If we
pull gpio_backlight_initial_power_state() into probe we can drop two
more fields from struct gpio_backlight and shrink the driver code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 37 +++++++++---------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 6247687b6330..407d4eaafc5c 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -17,11 +17,8 @@
 #include <linux/slab.h>
 
 struct gpio_backlight {
-	struct device *dev;
 	struct device *fbdev;
-
 	struct gpio_desc *gpiod;
-	int def_value;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
@@ -53,41 +50,24 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
-static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
-{
-	struct device_node *node = gbl->dev->of_node;
-
-	/* Not booted with device tree or no phandle link to the node */
-	if (!node || !node->phandle)
-		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
-
-	/* if the enable GPIO is disabled, do not enable the backlight */
-	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
-		return FB_BLANK_POWERDOWN;
-
-	return FB_BLANK_UNBLANK;
-}
-
-
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node *of_node = dev->of_node;
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
-	int ret;
+	int ret, def_value;
 
 	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
 		return -ENOMEM;
 
-	gbl->dev = dev;
-
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-	gbl->def_value = device_property_read_bool(dev, "default-on");
+	def_value = device_property_read_bool(dev, "default-on");
 
 	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
 	if (IS_ERR(gbl->gpiod)) {
@@ -109,7 +89,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	/* Set the initial power state */
+	if (!of_node || !of_node->phandle)
+		/* Not booted with device tree or no phandle link to the node */
+		bl->props.power = def_value ? FB_BLANK_UNBLANK
+					    : FB_BLANK_POWERDOWN;
+	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
+		bl->props.power = FB_BLANK_POWERDOWN;
+	else
+		bl->props.power = FB_BLANK_UNBLANK;
+
 	bl->props.brightness = 1;
 
 	backlight_update_status(bl);
-- 
2.23.0

