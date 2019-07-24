Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B1AC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F0229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A9RjNrSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfGXIZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGXIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so30938134wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VOxOTv40kWNEJHTWrrT/jLtfVvkKD73o3YTvSQ9LmQ=;
        b=A9RjNrSpXlzPhVNZCXaDwouPHTi7TIFzDls2JACrq3+/shRWFCWrnrspTHTM4I91jH
         ezoziNRBN2DQ5bIkHzan2QY0fid7sIZpj+W90xAKtLRzy5mL1NxRp24QUfHTwrqT1rfx
         SeS/Go55UuBU+CS4L/Z9MgOIcU0MpICJL3kpXsMK1FqUwUkjm3pjrjKWnN9Wcb/W1ITz
         G9DtjzD0Z+mZOITUKKR0MLN6FYml6GeYFEJSF41qOE9P9NAI8NWDod7eDWBSAbqQDWCm
         XQPYIUVcqWdPPTBMLGe1uOA9+MXjiuCeZ8xuvV22AGuAK2GA0lLZDJAdjh9VDaF/qDO+
         a/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VOxOTv40kWNEJHTWrrT/jLtfVvkKD73o3YTvSQ9LmQ=;
        b=j/LUM7cHzeQc56bEgWrQGZdu0ScrUb95u9IJa0TzjQ/4PsCBtGJFGBf5w2ipkBcmNe
         tJzyjlq9UA0Z6bxJDYtqtaF9OZRXTQtxObkFMaAC/OZKD8Ih6+fZc+5iTJfrR9iwKYv2
         XsWjEbwt51bgKXpKGgfNCR8SacLR+5f3p+MMSWbAa8RPiVWlQyjP4DTG4nQ7mxriUgb/
         TVn2yYorYDd2nyPX60F1kAxr4pDibCog8k4q0LUpZpuGzUIO4xN9JY4+p0PyfxV+ZL6L
         TDqREhtSYgPQXaBE+F0nJzcR9H6oNmxTmv83CL93PwAa78HCKosA/dLt30vZAzcmmVqZ
         axug==
X-Gm-Message-State: APjAAAXcBLhvP3ZVMR0Oi4oCQkARonLSfeFaVNpjcsQ9DeD0OvyzvkT5
        LJH2HoWsRgaixLT/Ir4SW7c=
X-Google-Smtp-Source: APXvYqylEG+5UwTbcaSwczxEISEgX+vxsc2ZxbxeF0HClQcWNGuQkAApx11b3CnWSJnzqEygUClIyQ==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr53138350wre.226.1563956714814;
        Wed, 24 Jul 2019 01:25:14 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z7sm42393880wrh.67.2019.07.24.01.25.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:25:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/7] backlight: gpio: simplify the platform data handling
Date:   Wed, 24 Jul 2019 10:25:03 +0200
Message-Id: <20190724082508.27617-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724082508.27617-1-brgl@bgdev.pl>
References: <20190724082508.27617-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Now that the last user of platform data (sh ecovec24) defines a proper
GPIO lookup and sets the 'default-on' device property, we can drop the
platform_data-specific GPIO handling and unify a big chunk of code.

The only field used from the platform data is now the fbdev pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 64 +++++-------------------
 1 file changed, 13 insertions(+), 51 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e84f3087e29f..01262186fa1e 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -55,30 +55,6 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
-static int gpio_backlight_probe_dt(struct platform_device *pdev,
-				   struct gpio_backlight *gbl)
-{
-	struct device *dev = &pdev->dev;
-	enum gpiod_flags flags;
-	int ret;
-
-	gbl->def_value = device_property_read_bool(dev, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-
-	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
-	if (IS_ERR(gbl->gpiod)) {
-		ret = PTR_ERR(gbl->gpiod);
-
-		if (ret != -EPROBE_DEFER) {
-			dev_err(dev,
-				"Error: The gpios parameter is missing or invalid.\n");
-		}
-		return ret;
-	}
-
-	return 0;
-}
-
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct gpio_backlight_platform_data *pdata =
@@ -86,6 +62,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
+	enum gpiod_flags flags;
 	int ret;
 
 	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
@@ -94,35 +71,20 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	gbl->dev = &pdev->dev;
 
-	if (pdev->dev.fwnode) {
-		ret = gpio_backlight_probe_dt(pdev, gbl);
-		if (ret)
-			return ret;
-	} else if (pdata) {
-		/*
-		 * Legacy platform data GPIO retrieveal. Do not expand
-		 * the use of this code path, currently only used by one
-		 * SH board.
-		 */
-		unsigned long flags = GPIOF_DIR_OUT;
-
+	if (pdata)
 		gbl->fbdev = pdata->fbdev;
-		gbl->def_value = pdata->def_value;
-		flags |= gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
-
-		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
-					    pdata ? pdata->name : "backlight");
-		if (ret < 0) {
-			dev_err(&pdev->dev, "unable to request GPIO\n");
-			return ret;
+
+	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
+	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
+	if (IS_ERR(gbl->gpiod)) {
+		ret = PTR_ERR(gbl->gpiod);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(&pdev->dev,
+				"Error: The gpios parameter is missing or invalid.\n");
 		}
-		gbl->gpiod = gpio_to_desc(pdata->gpio);
-		if (!gbl->gpiod)
-			return -EINVAL;
-	} else {
-		dev_err(&pdev->dev,
-			"failed to find platform data or device tree node.\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	memset(&props, 0, sizeof(props));
-- 
2.21.0

