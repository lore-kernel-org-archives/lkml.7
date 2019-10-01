Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C2ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6711D2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Mj8KL/3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfJAM7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:59:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55140 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbfJAM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:59:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so3274525wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AptOB7aQMzupkvqKi0d1i4i7uXh0E5N7gRvX5FWeAOU=;
        b=Mj8KL/3yO/+8pQR6hKmMxjehp8UsaQmJXB+50w4JFC0Jbpw/bv2KHHtQqu6BYcbZ0s
         GnstolGS0HMZooKY2nCYemYIsdaW8nlkyXolNB7aBZ2wQgg3+tC6mtqu6pxs7bjcCWXy
         7cPPNplvd38z+flfRXABRtkSJsSPiN7w4B2Z5mXYR4SNSpvQjEYEP05z6/up9NkcTA3h
         r36ddCNTZVeEErft7TF+UYk0jwcNEJCYfaFm1PMfMF+x+dFlzVYdG6Dlz00VIYzPoksO
         1NiE+Kx8avaQAi9fzsQecRgxXfikJ7hT2QJFzwEMqauBQWPwUJyenh0Ni5myYPeN0+5a
         veOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AptOB7aQMzupkvqKi0d1i4i7uXh0E5N7gRvX5FWeAOU=;
        b=Ncj0aPNnwmQstFuWz2cM0Hsj/TeBgZBo0H/VMSvHlx8nNFMJXdZMYzHbyxqN3lal1H
         LeU+Nn/fba608XcRhJcggAiwn6f14La+yfJhzCXZ42cYO3AZHadFofET+GjEj1kVElKg
         s8dz3Frrb8hOwGC8YLjSHxN2nAbBLwB+qn3pfniRDGadK2BEtwU8oKRjIa6BPn7LDSGn
         EKXT15PPlYvmXc6h4kYFE8RxF9PSKvTInHRLc3hG+ZCDFcuCo8haj3Wx7vn5nUm9pLDS
         90ZY38tXkg2zdmA69Gk5Y91ygDvbt2xVZgjmD0HSPMjieV4Rmimy9bEBasSLjXelXlPj
         TECg==
X-Gm-Message-State: APjAAAWISnfzjqc+Y8tyet4hzh7LATC8g4/YwE56CEjlGiQ8N0i3tLeU
        O1EXNLg8Z+7TUQChnZItOnJIuQ==
X-Google-Smtp-Source: APXvYqx3q+9sUGs6+xirhCygiJCG0L1MJfnhI1dmSdWZ8G1s1CHPmFRdObGuXQg/gt02Yp/yvI/WGg==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr3594356wmc.141.1569934773015;
        Tue, 01 Oct 2019 05:59:33 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id 3sm3561400wmo.22.2019.10.01.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:59:32 -0700 (PDT)
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
Subject: [PATCH v4 7/7] backlight: gpio: pull gpio_backlight_initial_power_state() into probe
Date:   Tue,  1 Oct 2019 14:58:37 +0200
Message-Id: <20191001125837.4472-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001125837.4472-1-brgl@bgdev.pl>
References: <20191001125837.4472-1-brgl@bgdev.pl>
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
 drivers/video/backlight/gpio_backlight.c | 36 ++++++++----------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 6247687b6330..37ec184f0c5c 100644
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
@@ -109,7 +89,15 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	/* Not booted with device tree or no phandle link to the node */
+	if (!of_node || !of_node->phandle)
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

