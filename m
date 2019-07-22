Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7784C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F0121951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nmW74zEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfGVPDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:03:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfGVPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:03:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so39864565wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAL0aUWAYM6zj0vm1GZ+TQ+tEc0Krf1eM+2DJqAl5SM=;
        b=nmW74zEr5VJ6NZvm1xuolQHLV0V7JgfFdkjukAjIIj5RNLT84lt5xHJ0PLzrUJ6/ie
         RmshckVdtRD0zHSnm/JFKySIhGn9lZ2csoJYK8GGTLrpZYKGDFXm1O4UzIVaOn6wT8n+
         chPm6jnC6JBpeSfYWVmpy9xzw0ALdoGU0NGnuQGvytC2iIybCom/3uAlMfxOdEEaK5is
         Cd+Wu0BM+CzQQJq670P51jIIg8jJN+ZLA4mzlt+Ou356KV4WZV4ZhqcfU3aa+vZzLCxy
         lICAekCDmFT5JKXRYetIaIyTKTQIkoTZKT/ciUHheKR5Fsu7MGdWEjsq1YjAP1YGsQUl
         gfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAL0aUWAYM6zj0vm1GZ+TQ+tEc0Krf1eM+2DJqAl5SM=;
        b=YNGHNR7MKjqZd+4H/MYWhF5AeRgZUWJn986d7snfZ5GAAKdmC4aRBxdMC5EihdyMqz
         QFTTxoCEHlRB5kpDF+/mcaRkb16Yd59d+v7hpuJqnhSIaONRZ7s7aCQtZB933mohwh0+
         v1ET+yFfpDsafy/y5FjsvVg9gOfQLDIdcAEyiNI8Z221pZYmTIgJgoChL7ll3Wqsxf4X
         FQlP9L5VicUEMIMOsg0pccTbpRQp14T6pydU2wycCQCpjyoxJLxWhCvWyekpxAgKY+Ch
         tRRIhN81Y2Lu18oynxw6oNZCKckmxqig8+9MvoW9S6pDgWXpzcdeZJU1D0jX6Q+XVBve
         DKZQ==
X-Gm-Message-State: APjAAAWlYp3cDuVHbr3YGV1wr0Y7g4kfiLo7N4ppF91rGDTWIlfv9f8V
        IikiZBFV9Of+245+Bnux1D0=
X-Google-Smtp-Source: APXvYqzv1tIQlpKco//60WYuLTW7z1oxQjMycV6JNoP/lHrYCqfsfsZK6oF4LOSUVD30btuEywALkw==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr30852781wrv.167.1563807803620;
        Mon, 22 Jul 2019 08:03:23 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id v23sm36310460wmj.32.2019.07.22.08.03.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 08:03:23 -0700 (PDT)
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
Subject: [PATCH v2 7/7] backlight: gpio: use a helper variable for &pdev->dev
Date:   Mon, 22 Jul 2019 17:03:02 +0200
Message-Id: <20190722150302.29526-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722150302.29526-1-brgl@bgdev.pl>
References: <20190722150302.29526-1-brgl@bgdev.pl>
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
 drivers/video/backlight/gpio_backlight.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index cd6a75bca9cc..091ff799659a 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -54,29 +54,32 @@ static const struct backlight_ops gpio_backlight_ops = {
 
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
-	struct gpio_backlight_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct gpio_backlight_platform_data *pdata;
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	enum gpiod_flags flags;
+	struct device *dev;
 	int ret, def_value;
 
-	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
 	if (gbl == NULL)
 		return -ENOMEM;
 
 	if (pdata)
 		gbl->fbdev = pdata->fbdev;
 
-	def_value = device_property_read_bool(&pdev->dev, "default-on");
+	def_value = device_property_read_bool(dev, "default-on");
 	flags = def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
 
-	gbl->gpiod = devm_gpiod_get(&pdev->dev, NULL, flags);
+	gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
 	if (IS_ERR(gbl->gpiod)) {
 		ret = PTR_ERR(gbl->gpiod);
 		if (ret != -EPROBE_DEFER) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Error: The gpios parameter is missing or invalid.\n");
 		}
 		return ret;
@@ -85,11 +88,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
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

