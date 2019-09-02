Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF0C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4253321881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ix2RLbgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfIBMfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:35:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44199 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfIBMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:35:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id 30so2910984wrk.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jAAQVre0ugDaUipQgqAVWSbxc2RrUvIHMN/mo5I6Jk=;
        b=ix2RLbgRG+/MjkM1kHz/0CXUG+C5ZIK5V64NA/yDf8xWlkJ4nTutymQGoPCwn476MX
         QXnJ5G0wXg3iB0Z4oVOp1Fg9IF7rmCU24zFapX9nuNXsKCIyzOSR+ELh6CK177dlLV3p
         IbtSs2c6+mOp0J4Qg2WnET15lEKl3g/BPWztmy9be0IQiAH5qV8Fs3GYmQGjow3GTwdZ
         77nl9rDpzIJuaxNNfSJe3LyACtKBt3cuB53O2TpphtrZ52yJjxFytYCLcCUcxuAnoN2J
         0IMhGJfREq3FqBDrhOm1266/WCKLM1kqXAM8TnhvADcIcWigXhae1L6iap5xxZRkGnWD
         bcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jAAQVre0ugDaUipQgqAVWSbxc2RrUvIHMN/mo5I6Jk=;
        b=IgnBWHuE8qXUUt9Io85sGyKIyP+N/ZhMqoPuVe93acWDTeX8b3zXqM4CePnjvqPBON
         QewbbU06kWzdUrDpA7GvY3tfGDF+79lfUTw0YRjTq85KiikNRMX/7YarPGTXeDuGqoK/
         fJO9/ZGsPOi+uTt5mJt9DXJleSZrBaEfDiM+qImGYIZPU9N/r+I+gx0BG2RbgTPtrngD
         fRF7n6w6QaxWsbZnhqrTogzys6oUYBWZF8YxbRhi1kiYP/wV40eGzwK63WSlfelmu2dK
         rjyKGSWh2tSioaqnHwCo1eAeIebIEctDZbTbnXy9sWq0HMGdO6SQj7cNQuJx2/Cg9wSK
         wgCQ==
X-Gm-Message-State: APjAAAW9/y7Jz/IgFOEdWbKOJoXx224v0uRfIFb7gAer04Qs+8ndbeaL
        QpyTGmTwpPlv7dXVTIRex5EXgg==
X-Google-Smtp-Source: APXvYqwj4ObCHBjkI+G6B9G9wba9BtxdUwO5yxmXy1uG3RpakaYj27cBRQ5d9KFAlmxR7q5FsHOggg==
X-Received: by 2002:a5d:5612:: with SMTP id l18mr18125016wrv.177.1567427700581;
        Mon, 02 Sep 2019 05:35:00 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id k9sm22645759wrd.7.2019.09.02.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 05:35:00 -0700 (PDT)
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
Subject: [RESEND PATCH v3 7/7] backlight: gpio: use a helper variable for &pdev->dev
Date:   Mon,  2 Sep 2019 14:34:44 +0200
Message-Id: <20190902123444.19924-8-brgl@bgdev.pl>
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

Instead of dereferencing pdev each time, use a helper variable for
the associated device pointer.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/backlight/gpio_backlight.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index cd6a75bca9cc..7dc4f90d926b 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -54,29 +54,29 @@ static const struct backlight_ops gpio_backlight_ops = {
 
 static int gpio_backlight_probe(struct platform_device *pdev)
 {
-	struct gpio_backlight_platform_data *pdata =
-		dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
 	enum gpiod_flags flags;
 	int ret, def_value;
 
-	gbl = devm_kzalloc(&pdev->dev, sizeof(*gbl), GFP_KERNEL);
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
@@ -85,11 +85,10 @@ static int gpio_backlight_probe(struct platform_device *pdev)
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

