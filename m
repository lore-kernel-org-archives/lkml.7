Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B5C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD38E208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RKbWobwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF1KDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:03:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33013 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfF1KDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:03:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so8997190wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MIsV0iC74yf/kLB48zP5Mu3PghPcknjMYE++qerELQ=;
        b=RKbWobwqHCIrkwBTlOa2hdgmXhCQq1JvHVtNEOm0X33A/V3lRp6rBHwJTZOS2ZlrsC
         D/JTSQ4w5KTYhNV7l4mm1L9tL+8Zv5GX6ZX01CI+2pG2sbWZU2YGEk/dBx9zz50MHA5t
         fGLjObyRZ8ialJJ9Ujpck3pa0VCU+xs/7VClJN4UFUf2LPq4xfUkko0QaDjNN5EJwXDp
         8koiUs4eI/hXyoZIHCY3WcCI5QQOhM2wYhdYEmHzm0aWdgYpa0xpfF3eVQ9lrv708D5D
         PCpptKKMn0a/FEuX2WMu3OkGWWHI69qpmuwM5vMFKoPbKnuxudAFGMZQcI/SHE5jz99U
         5Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MIsV0iC74yf/kLB48zP5Mu3PghPcknjMYE++qerELQ=;
        b=ZEpGR09g5ryrP7nqO89nrbsgFyBt/5B6v2GXUnNPCqqFjUFxq5hK4i6Pdx4MF5W/zL
         HKP9R9lWSCuux7lkcLaFn/e6JisIoIZM9rjJqn6i5gpaK65pVA1/79qC0duu8LPr9uUq
         KNcx7kTBfIloBCR/FLBSeNRI3mEJHvtGn+CAKUNlWmIxzD3efwS9CZm/4+ovirPZNJ2W
         KzxsiwpgiBEMAqRzZvLaFZGi2eBF/34DC4wnLT/piNWHQz14q2qcCRz2zMvIupymCkxm
         VeW2lS3XZEE7GErFFVkrZx0TUjB7FM9rpodl6xTjXHAyOuq8agC6NN+XkJJvqFEfXDi3
         ei7w==
X-Gm-Message-State: APjAAAU4eN4zRBd2PX8yLXY3TspkLHHUhmo57aTjpunyFKeXiK61x3Jc
        dNiq2N1Z1TNcfiNG/Cvh/7ny0Q==
X-Google-Smtp-Source: APXvYqxMlO8Fzv7j1/DeSmWZz7jyRkBp7z4c54hGgmLMAGP1WzXIA6YdHeK1AoOXmA8GXduiCgXd+g==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr6197653wmh.60.1561716185658;
        Fri, 28 Jun 2019 03:03:05 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l124sm1628874wmf.36.2019.06.28.03.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:03:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFT 2/4] backlight: gpio: simplify the platform data handling
Date:   Fri, 28 Jun 2019 12:02:51 +0200
Message-Id: <20190628100253.8385-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628100253.8385-1-brgl@bgdev.pl>
References: <20190628100253.8385-1-brgl@bgdev.pl>
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
 drivers/video/backlight/gpio_backlight.c | 46 +++++++-----------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 89e10bccfd3c..b20d2d5d5190 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -71,41 +71,21 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	gbl->dev = dev;
 
-	if (pdata) {
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
-			dev_err(dev, "unable to request GPIO\n");
-			return ret;
-		}
-		gbl->gpiod = gpio_to_desc(pdata->gpio);
-		if (!gbl->gpiod)
-			return -EINVAL;
-	} else {
-		gbl->def_value = device_property_read_bool(dev, "default-on");
-		flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
-
-		gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
-		if (IS_ERR(gbl->gpiod)) {
-			ret = PTR_ERR(gbl->gpiod);
-
-			if (ret != -EPROBE_DEFER) {
-				dev_err(dev,
-					"Error: The gpios parameter is missing or invalid.\n");
-			}
-			return ret;
+
+	gbl->def_value = device_property_read_bool(dev, "default-on");
+	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+	if (IS_ERR(gbl->gpiod)) {
+		ret = PTR_ERR(gbl->gpiod);
+
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev,
+				"Error: The gpios parameter is missing or invalid.\n");
 		}
+		return ret;
 	}
 
 	memset(&props, 0, sizeof(props));
-- 
2.21.0

