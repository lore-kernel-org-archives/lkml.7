Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76856C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4522168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lwjSsLjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfIBMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:35:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52363 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbfIBMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:35:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so14412979wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBLJsFDHxwQO5fDJ/0XiJk/ChmWyJTLddlv7y7zlKto=;
        b=lwjSsLjUer1VFsgWsDkSA4eN6sALaf4s+oUA+k3XyXbOV0PLVLfHF1wEBKgjAUsM7B
         FqlsuujinuKAzlU/2L38daWRY1ekKA01/UqW69QBIURMfm6KK9bUojE4BNJvIZx0HFpC
         ISx/AmjTBTU9c30Fsu48V5cGMES1/BdDcqgBSsXZxUErSspRTJFgFwwYlOz+PnigdkOL
         eUPhvmAOL418pfzBbbfsKKpec96TNxLRjPJvpmP98sRtW2XO5kIoPn17kwq9sN/SQMjj
         6B5pZamHMxUOAXR2CtMRs3dkTOVI/fxhmBZ0DPZW4nxgFnmr9naHl2XEp7Z20DmqMXUs
         UQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBLJsFDHxwQO5fDJ/0XiJk/ChmWyJTLddlv7y7zlKto=;
        b=VNRRrR18NJm0mqfL2KEyKgPOe90FTO9rtk3/hKjpF4YKnn8t2nLvAitvcKiEklu+hU
         tAUc11DM2PkIQoTIUfkTMMDOER28EXBwZedNDPm8OhM5VQ7wMjSDxQmHkGFWDoGK0uZF
         zMr4Dmis0nEisvA/Z+2ky/pUcNldtJifJ7e1nhNNU+K7UqXiDUIxhPTjsngUyaAETt/2
         GsGoH5E83gqvemsUk81wNBHdn1WiLoE28D4SK3KRO2ykrk2VEf5cvfgLspkRUN74Nzqw
         f5YyUvRQ95N5uGK/6vpDH3EmY2jj7zmKvaB2tKAdRkDvRyUpiQjf/3bm55DLkordehtB
         2dGA==
X-Gm-Message-State: APjAAAW4eBvIbGUVYhQfiPbWtf5vn8xrw4DCcBkos01HAjZux8FEkWGU
        lo/9CgsWwfgOOjZaEkKigT3zeA==
X-Google-Smtp-Source: APXvYqwuZajd1J/NSYA/QGRzkfcMxV+ED2cD7wbF0dc30G/G6uOz9gOEoa4lQU/BcyHW3BPU/kspoA==
X-Received: by 2002:a1c:f103:: with SMTP id p3mr34157179wmh.18.1567427699432;
        Mon, 02 Sep 2019 05:34:59 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id k9sm22645759wrd.7.2019.09.02.05.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 05:34:58 -0700 (PDT)
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
Subject: [RESEND PATCH v3 6/7] backlight: gpio: remove def_value from struct gpio_backlight
Date:   Mon,  2 Sep 2019 14:34:43 +0200
Message-Id: <20190902123444.19924-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902123444.19924-1-brgl@bgdev.pl>
References: <20190902123444.19924-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is unused outside of probe(). There's no need to store it.
We can make it into a local variable.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/gpio_backlight.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 70882556f047..cd6a75bca9cc 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -21,7 +21,6 @@
 struct gpio_backlight {
 	struct device *fbdev;
 	struct gpio_desc *gpiod;
-	int def_value;
 };
 
 static int gpio_backlight_update_status(struct backlight_device *bl)
@@ -61,7 +60,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	enum gpiod_flags flags;
-	int ret;
+	int ret, def_value;
 
 	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
@@ -70,8 +69,8 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-	gbl->def_value = device_property_read_bool(&pdev->dev, "default-on");
-	flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+	def_value = device_property_read_bool(&pdev->dev, "default-on");
+	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
 	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
 	if (IS_ERR(gbl->gpiod)) {
@@ -94,7 +93,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.brightness = def_value;
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
2.21.0

