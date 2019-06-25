Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB095208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hn0sJGMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfFYQfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:35:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfFYQe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:34:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so18601161wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9jHnEFpHn7uzznoO3/dgHPquJFVDhGL7Sa3AB/IK/o8=;
        b=hn0sJGMrU38ycKfPEcke4oemjMf5nF19She6rrogMdb5v0F2pBQBNKFb+k/+2MJbvv
         x0AL7iJN38li9VNodfle2pG9gu9d2FJ3tvO7WCdfFllzJdndvifHLTLjRDM4aDml+Kuj
         ARXR5bllOgDLUQO3pl4c5PKCRuEuqrBRd/sgqgOD1M5Honf1Q9rxMnOT9Gtrbba1Pc6q
         WCixZR6JX0xgDU+5eMlm3aDNlNwAqfajTgyiKEnyZ2eYijvvzNfmrix4ZFYvnBzoboQW
         vWSvbCOsW9ZdQYXrDXj4UOEBCHTBJKcTLpDkXcvPZbiDAcrZsqeJshpkE3iV/v/oMDyN
         QHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9jHnEFpHn7uzznoO3/dgHPquJFVDhGL7Sa3AB/IK/o8=;
        b=fxu56WlzoCH+1h//ncqQRt2rO4W34iRRyn34xIKdhRN2pK8JiQA4WT5pHoL6HJarQW
         POS/r183LGb/KBit45ojd42fN5gSOthmMlm5sJctxoxK59VDwuywCy0oD5TkNDQ9ygsZ
         nrYCljuJsC/zYdOlP6jNeFZNd4RdRXBrGDbGVyELsukeKMoCDF22Y/t/aVGJwUPfIs3J
         orlgrduG25cCJjdPzRirnBGgcQ5RQHhOGCQOcpjGkA4HXoTGpxI+LDkhX66+JQaEY1cl
         awilOQnp5RwFUdf4x9LiEUJHMYtjO/P6J0dUh4BOVBeDqvnDwNMyIXh4d2GIN/ZQYJN0
         TWiA==
X-Gm-Message-State: APjAAAU9s7x5M3ioXY2Bh786bMr8q/4aI8CJtSjZEzd98mi5Co56/CNa
        hpuQyiczq6lDNDXgp/n4h9A9yw==
X-Google-Smtp-Source: APXvYqwy7zacb5a2dIAzBH+DNPJmE7Ud9HzGmZ8XgxvKZbiQHoYeDIvLxGo471H1Sy/xZiRyc+Eftg==
X-Received: by 2002:a5d:4fc8:: with SMTP id h8mr26465755wrw.124.1561480495518;
        Tue, 25 Jun 2019 09:34:55 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g8sm2683795wme.20.2019.06.25.09.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:34:54 -0700 (PDT)
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
Subject: [PATCH 03/12] backlight: gpio: pull the non-pdata device probing code into probe()
Date:   Tue, 25 Jun 2019 18:34:25 +0200
Message-Id: <20190625163434.13620-4-brgl@bgdev.pl>
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

There's no good reason to have the generic probing code in a separate
routine. This function is short and is inlined by the compiler anyway.
Move it into probe under the pdata-specific part.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/backlight/gpio_backlight.c | 39 ++++++++----------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 8adbc8d75097..89e10bccfd3c 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -54,30 +54,6 @@ static const struct backlight_ops gpio_backlight_ops = {
 	.check_fb	= gpio_backlight_check_fb,
 };
 
-static int gpio_backlight_probe_prop(struct platform_device *pdev,
-				     struct gpio_backlight *gbl)
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
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bl;
 	struct gpio_backlight *gbl;
+	enum gpiod_flags flags;
 	int ret;
 
 	gbl = devm_kzalloc(dev, sizeof(*gbl), GFP_KERNEL);
@@ -116,9 +93,19 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		if (!gbl->gpiod)
 			return -EINVAL;
 	} else {
-		ret = gpio_backlight_probe_prop(pdev, gbl);
-		if (ret)
+		gbl->def_value = device_property_read_bool(dev, "default-on");
+		flags = gbl->def_value ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+		gbl->gpiod = devm_gpiod_get(dev, NULL, flags);
+		if (IS_ERR(gbl->gpiod)) {
+			ret = PTR_ERR(gbl->gpiod);
+
+			if (ret != -EPROBE_DEFER) {
+				dev_err(dev,
+					"Error: The gpios parameter is missing or invalid.\n");
+			}
 			return ret;
+		}
 	}
 
 	memset(&props, 0, sizeof(props));
-- 
2.21.0

