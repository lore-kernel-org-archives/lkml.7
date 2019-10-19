Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97977CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56759222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Jk5EBmYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfJSIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35934 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfJSIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so7989282wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qycHXMO6hwxhUdb3jdVqS6gIVNXR0dtaUr+q4ZsWEBE=;
        b=Jk5EBmYa+f25dVL0ytlmaRtf8WAVFhl1TWLYulD/cjGDX1wCaySBwWD/vh2NWZbHVD
         5niPb2mYSBspLggl0tema5K8Qd8+JzAAcvvu2lPy3+1NRihUAq2JxJ+U490BS8+w0udd
         t4XfieezI2QS399OfGYDN0hIKV10tM5OK2EICaKM2qjVBAoJ4TJWV1ckCVAhKi4xVHVR
         QrENWpsMNxsrVai6eEP6BAsNmRZHafdwOW+Q7Y1XYH+rqy2dJEVhPp/9PkmRjJrViH5x
         tQvWbNZ6yFRV4KParbooJKpz3bzQ20Mn0F+ULmYO5KMaC4yAG2FyBZfAd3ofmJEjIwBm
         IcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qycHXMO6hwxhUdb3jdVqS6gIVNXR0dtaUr+q4ZsWEBE=;
        b=IMQOtq/9DC8gJuMM6Ee0inwL/36LP6V/CXrIq7b3/CIkgxzP2dblPM6nRaL0PvAVvy
         YGTo2Sys8TA/KZWNnamsJxr9LuORGJpT2aVYxeUW3ovTKut6SCX3NwiJOcbO+3aCMufb
         qBIFNfwPkCLv8Fvs8gDG6x3qxPcXcbhB+T4lERu2lXAZsl11Ck8z38QDBvkCmZDkq+kM
         ZSAY5MZ/eeOBIJEdZ52mYMp2gQvfvT0EvHtq3nnoDOJ3ENX8c19qrYbaV5jLpeSMS/+W
         avuLxMTmqnoXdwX/YkUIXG6EuqX1AB2CUQntcqa7B9OVM/okIOI81Q6SSPy8VCwjqvND
         fPZw==
X-Gm-Message-State: APjAAAWlslKe6MTe/tyPxr0ZTkFqd/DhSd8Ng0qQw2xCS6rvCqnfeJg3
        yAy2La22ZB40v/9ZdEibgYp3hQ==
X-Google-Smtp-Source: APXvYqxL4ngNwJD3Ia6U3FUSz7NI06K8MQss3MsCYJfxqtNfTF2X+Kq18B1s3ij+8TKee2gNA8Mvcg==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr10803495wrs.37.1571474182248;
        Sat, 19 Oct 2019 01:36:22 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:21 -0700 (PDT)
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
Subject: [PATCH v6 9/9] backlight: gpio: pull gpio_backlight_initial_power_state() into probe
Date:   Sat, 19 Oct 2019 10:35:56 +0200
Message-Id: <20191019083556.19466-10-brgl@bgdev.pl>
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

The probe function in the gpio-backlight driver is quite short. If we
pull gpio_backlight_initial_power_state() into probe we can drop two
more fields from struct gpio_backlight and shrink the driver code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 38 +++++++++---------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 7b411f6ee15a..4336db6bf6b5 100644
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
 
 static int gpio_backlight_get_curr_brightness(struct backlight_device *bl)
@@ -60,41 +57,24 @@ static const struct backlight_ops gpio_backlight_ops = {
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
-	if (gpiod_get_direction(gbl->gpiod) == 0 &&
-	    gpiod_get_value_cansleep(gbl->gpiod) == 0)
-		return FB_BLANK_POWERDOWN;
-
-	return FB_BLANK_UNBLANK;
-}
-
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node *of_node = dev->of_node;
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
-	int ret, init_brightness;
+	int ret, init_brightness, def_value;
 
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
@@ -115,7 +95,17 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.power = gpio_backlight_initial_power_state(gbl);
+	/* Set the initial power state */
+	if (!of_node || !of_node->phandle)
+		/* Not booted with device tree or no phandle link to the node */
+		bl->props.power = def_value ? FB_BLANK_UNBLANK
+					    : FB_BLANK_POWERDOWN;
+	else if (gpiod_get_direction(gbl->gpiod) == 0 &&
+		 gpiod_get_value_cansleep(gbl->gpiod) == 0)
+		bl->props.power = FB_BLANK_POWERDOWN;
+	else
+		bl->props.power = FB_BLANK_UNBLANK;
+
 	bl->props.brightness = 1;
 
 	init_brightness = gpio_backlight_get_curr_brightness(bl);
-- 
2.23.0

