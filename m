Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78954C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D657208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rgxXlRAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfFYQe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:34:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34357 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfFYQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:34:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so18662752wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iezztZquUE7VOJu2VvhRUb2IfrZ8cIwgoI4gm0DrkM=;
        b=rgxXlRAaV6xZXnZFHal/gjCfi7ThDBTYi4zQlerr90dKuypsYo0mb+p33lydeL4eKn
         2Cg8TDpnk1TQyWRPgE7auXmAdnsrV7xq0CkHwBoS14Z8stdjg5sO1sgEu4CXM0obe8GT
         HtDtgDT/yuWJ/6FSenaU3s3kQIgEWAOjiCDWUhU8Pfhoj3WCpQG547MgKdHM7a0QE2ml
         oMYIbV67RK1VeetSwtj5yG0Sb0iifz24h/amsfYK1tn89rbBjiyJy6Dq7HfJ6k7U1O2X
         NjWCVLOG8O2PA2zG7LLOXV9LLX5jw93wHA6dgCylVM+dJAI+sj7QPNmJX6O7U4MR7nGO
         8GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iezztZquUE7VOJu2VvhRUb2IfrZ8cIwgoI4gm0DrkM=;
        b=uFNxwlozesrI6PuG6giqfSdO68GdNnTZqi+8C1yeC/Y0Q0GXb3tm4ULNo4Wqh8mzrB
         x9/Te+6Fy0oHK3GW+H8CO+NNuFCULx7YN5Ng++U8Hox0dH8UCgiqphiVd4n005L0+wPG
         hIuNJlJhpOS5h1aECRvnCRk1D6Tt4vmd+hIPFNI8BwbHdILC7gI5DM34ADYTFIt1s7dp
         bpNIzfU3QjPPGUmlUoMvP6PGyDu/sPABViRuAypbwS1gJTSSyNTHr1PCObbWsr3f8JbY
         pyAfHy8fqZUsmHlNAg+VKAaEpd11to7uFZBbVGAxmiU7W7Cxp+H8ogxhTb3t8BKQqBGv
         mlrw==
X-Gm-Message-State: APjAAAV1lO5u8J2cs6rFqq+4lWIlOss2yNEFUlJ2bByyPB/FQNE15nDz
        DAb7qxEjnp9fQYWe+zmo+NDjDw==
X-Google-Smtp-Source: APXvYqzDDJRCAp4r9gihTWEjB9YUiMxhVdwQYB5zhog7hsqmsGPPt4gRXpZAivYIHwx1NdMTVydW+w==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr110996508wra.261.1561480494146;
        Tue, 25 Jun 2019 09:34:54 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/12] backlight: gpio: use a helper variable for &pdev->dev
Date:   Tue, 25 Jun 2019 18:34:24 +0200
Message-Id: <20190625163434.13620-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
References: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of dereferencing pdev each time, use a helper variable for
the associated device pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 654c19d3a81d..8adbc8d75097 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -83,15 +83,16 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	struct gpio_backlight_platform_data *pdata =
 		dev_get_platdata(&pdev->dev);
 	struct backlight_properties props;
+	struct device *dev = &pdev->dev;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	int ret;
 
-	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
+	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
 		return -ENOMEM;
 
-	gbl->dev = &pdev->dev;
+	gbl->dev = dev;
 
 	if (pdata) {
 		/*
@@ -108,7 +109,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(gbl->dev, pdata->gpio, flags,
 					    pdata ? pdata->name : "backlight");
 		if (ret < 0) {
-			dev_err(&pdev->dev, "unable to request GPIO\n");
+			dev_err(dev, "unable to request GPIO\n");
 			return ret;
 		}
 		gbl->gpiod = gpio_to_desc(pdata->gpio);
@@ -123,11 +124,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = 1;
-	bl = devm_backlight_device_register(&pdev->dev, dev_name(&pdev->dev),
-					&pdev->dev, gbl, &gpio_backlight_ops,
-					&props);
+	bl = devm_backlight_device_register(dev, dev_name(dev), dev, gbl,
+					    &gpio_backlight_ops, &props);
 	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
+		dev_err(dev, "failed to register backlight\n");
 		return PTR_ERR(bl);
 	}
 
-- 
2.21.0

