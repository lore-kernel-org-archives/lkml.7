Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA508CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833A9222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qeOCviH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfJSIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 04:36:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42516 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfJSIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:36:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so8535040wrw.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ksGbh2X5I7ivactCI4jvvNOH5FLCJouedGn4qvIRcNU=;
        b=qeOCviH9003fSdmW3/WDVHuU60mlmScEI6hXW5V2tWsOYH2Z4L87RI3RE1zmNsjFpz
         HU/WC9cjHVDL0FKV3NBNOJIKPKlaNzplvhQ0GWgwxpCJkm2beIaNXRkvTzCIPiO5dOhI
         qP1saqHI/GypMHBl7SCYCSGsxJD3CTqvrHoRgxMpibdKCppYCOa2+xrnocMVE+7bRgHZ
         b4NvHCz0m/hig86Pi2rwAIiHwPjXrj7PdZQLDxWmXA8QZihX0I5T92Gla+rWCWCScrpC
         WfjxCm5QKFuvKG62W/GiP41uYibEfNhmWh/7WQrePCdGYVmbtl5/1+HmURyjDw+EHdKK
         obtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ksGbh2X5I7ivactCI4jvvNOH5FLCJouedGn4qvIRcNU=;
        b=WsvzNesVT+kQGh1MUTqgpqsswj7/55f6zFAfGtZ7Ty3RK6p1NWgddUIFfydsAFqrkx
         R8z1Zl3rEeLGsfPutxZ26XewXCRMwIEkQSUlGWNAiR60LheqRH/qr0p1MpXQ7EZSBhIp
         FKoP5rnVPm9xcdNvfbdcQgWn1IGjRWMn15owwNV6XZ7zGo8j6knXNjIiiayJgKX5OO/I
         ZYqQNxQn1fcHRpqfoUrufSrxOkw53k2Qyd3h5su1sW0Y4iegeAeYmvF+hxcnPKenTFV9
         ObYrBOT0C0oGEixdJos8A1EhMHer8zF/2XMr86Q2uf67W5HLC+tqZ86BDvBXBzRXe+du
         +pTw==
X-Gm-Message-State: APjAAAX82D6iAMVNAFdW2HnNO05arwrCcIlrFtiQ1L11ckM45Cy4eWBh
        HRXCyDavT7hhbgyIt5eFQqsTyA==
X-Google-Smtp-Source: APXvYqzhnMfMaC2te5kIWP+ytu4oY/8aZLqHAo+n+DgYWHtp3A8jMe6Heme4rvVnO3syXrWNgDgWzQ==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr441610wrx.254.1571474176300;
        Sat, 19 Oct 2019 01:36:16 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u1sm7242627wmc.38.2019.10.19.01.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 01:36:15 -0700 (PDT)
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
Subject: [PATCH v6 5/9] backlight: gpio: simplify the platform data handling
Date:   Sat, 19 Oct 2019 10:35:52 +0200
Message-Id: <20191019083556.19466-6-brgl@bgdev.pl>
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

Now that the last user of platform data (sh ecovec24) defines a proper
GPIO lookup and sets the 'default-on' device property, we can drop the
platform_data-specific GPIO handling and unify a big chunk of code.

The only field used from the platform data is now the fbdev pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 62 +++++-------------------
 1 file changed, 11 insertions(+), 51 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index a36ac3a45b81..c829b82f5372 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -6,7 +6,6 @@
 #include <linux/backlight.h>
 #include <linux/err.h>
 #include <linux/fb.h>
-#include <linux/gpio.h> /* Only for legacy support */
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -61,28 +60,6 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
-static int gpio_backlight_probe_dt(struct platform_device *pdev,
-				   struct gpio_backlight *gbl)
-{
-	struct device *dev = &pdev->dev;
-	int ret;
-
-	gbl->def_value = device_property_read_bool(dev, "default-on");
-
-	gbl->gpiod = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
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
 static int gpio_backlight_initial_power_state(struct gpio_backlight *gbl)
 {
 	struct device_node *node = gbl->dev->of_node;
@@ -114,35 +91,18 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
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
-		}
-		gbl->gpiod = gpio_to_desc(pdata->gpio);
-		if (!gbl->gpiod)
-			return -EINVAL;
-	} else {
-		dev_err(&pdev->dev,
-			"failed to find platform data or device tree node.\n");
-		return -ENODEV;
+
+	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
+
+	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_ASIS);
+	if (IS_ERR(gbl->gpiod)) {
+		ret = PTR_ERR(gbl->gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Error: The gpios parameter is missing or invalid.\n");
+		return ret;
 	}
 
 	memset(&props, 0, sizeof(props));
-- 
2.23.0

