Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE4CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E947222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0LLfhTrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfJSIgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfJSIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so1183063wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+S1F9dGo/ErbKc+5MFUBRKg7ZKdxaGhAR9G3FlyzzL8=;
        b=0LLfhTrcJfkDD2KAFAf2MOHq0yJVpuFZpKnviLv848iy8t7hqY+CGdVLo3/g5BzAnP
         Vmh1RNwwivxdx6HOxcryCtVTIx1NP3zdU3hhJF4LXX8poyhw6UbZy12/dERrSdt7b5L9
         TGO6h+x33e73YSGHYwVFplerlB38wTr663PRMwBBzMcgU2gIDpuQSYG5VDCkuoQh0T21
         l4Tbe6CyZ6122rckrz/yK1AQZfrsa2U/DC2+ep4qqNVIvr2TqG5o4XGlnLdguOBzftfm
         DWBdQAc/YGRkHAthUyAoIVEN+OfKp5K8t/sUuhPJqeDIclC6LBHEW6SutvjPGJ3KyY7n
         K0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+S1F9dGo/ErbKc+5MFUBRKg7ZKdxaGhAR9G3FlyzzL8=;
        b=F0RgoyzrbDg82Qw6Dj/aVqSGOK/oXwZIZEyaqxBFwiImawv9GmJB9Ns4bY91XmJUgQ
         ublEid2X+nDnpQxfn4KdC7ZUhIIrauG7/GKEpnFylCifdg/r+vGxqgHwBVp+imS+Ghmo
         G5JATp6ngbzMIokeF/B7NL1U3O09fAV6Wv5AL3s5NpCyVIUd8BYnbxWRkLulWmZRnWQE
         qZa3g8AlsmQDH/n4NudcNOCoW+emv1rT0MFh2ntwZqIFER4ssq20Y2PlIq6Nw5l4Ft2F
         YH8FU9U8dhhNCI2/xtv3WaTZLrlH5LfXDM964Z1izgcYEms6k11T3aYXkUdi14LZ8X9S
         ATbw==
X-Gm-Message-State: APjAAAXP0CINUKWhnI85/DEUaL29ymgrh2zsHLQUI85ns0tDZvczJIx2
        Glc1FQpbB0Rsw08HaitG8xD10A==
X-Google-Smtp-Source: APXvYqyGbXOURlCI3MAwmOrcJg5aZDgiyvPwiSPVXZJ2NBbEzH3nY7FwT+floFDAlMGcDtVWgxKA1w==
X-Received: by 2002:a1c:8157:: with SMTP id c84mr10602738wmd.56.1571474173411;
        Sat, 19 Oct 2019 01:36:13 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:12 -0700 (PDT)
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
Subject: [PATCH v6 3/9] backlight: gpio: explicitly set the direction of the GPIO
Date:   Sat, 19 Oct 2019 10:35:50 +0200
Message-Id: <20191019083556.19466-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019083556.19466-1-brgl@bgdev.pl>
References: <20191019083556.19466-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The GPIO backlight driver currently requests the line 'as is', without
acively setting its direction. This can lead to problems: if the line
is in input mode by default, we won't be able to drive it later when
updating the status and also reading its initial value doesn't make
sense for backlight setting.

Request the line 'as is' initially, so that we can read its value
without affecting it but then change the direction to output explicitly
when setting the initial brightness.

Also: check the current direction and only read the value if it's output.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 3955b513f2f8..a36ac3a45b81 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -25,9 +25,8 @@ struct gpio_backlight {
 	int def_value;
 };
 
-static int gpio_backlight_update_status(struct backlight_device *bl)
+static int gpio_backlight_get_curr_brightness(struct backlight_device *bl)
 {
-	struct gpio_backlight *gbl = bl_get_data(bl);
 	int brightness = bl->props.brightness;
 
 	if (bl->props.power != FB_BLANK_UNBLANK ||
@@ -35,6 +34,14 @@ static int gpio_backlight_update_status(struct backlight_device *bl)
 	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
 		brightness = 0;
 
+	return brightness;
+}
+
+static int gpio_backlight_update_status(struct backlight_device *bl)
+{
+	struct gpio_backlight *gbl = bl_get_data(bl);
+	int brightness = gpio_backlight_get_curr_brightness(bl);
+
 	gpiod_set_value_cansleep(gbl->gpiod, brightness);
 
 	return 0;
@@ -85,7 +92,8 @@ static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
 		return gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
 
 	/* if the enable GPIO is disabled, do not enable the backlight */
-	if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
+	if (gpiod_get_direction(gbl->gpiod) == 0 &&
+	    gpiod_get_value_cansleep(gbl->gpiod) == 0)
 		return FB_BLANK_POWERDOWN;
 
 	return FB_BLANK_UNBLANK;
@@ -98,7 +106,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
-	int ret;
+	int ret, init_brightness;
 
 	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
@@ -151,7 +159,12 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	bl->props.power = gpio_backlight_initial_power_state(gbl);
 	bl->props.brightness = 1;
 
-	backlight_update_status(bl);
+	init_brightness = gpio_backlight_get_curr_brightness(bl);
+	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set initial brightness\n");
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, bl);
 	return 0;
-- 
2.23.0

