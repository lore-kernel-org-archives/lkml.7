Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95411C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCDC2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KNuxG3aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfJBRC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:02:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36487 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:02:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so20536195wrd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtSPNig1ms9qonkm00W4u3LTk/rJpQxZEt50bultrPA=;
        b=KNuxG3aE6nOukio7lmJ5sljTpGvgk7ZA8T+/oECKpldoWO/D3KZgzS8hr50+9lG2mX
         iTCGqZmuZyAF1IKgZJPo9KQtErAx9E0KIZcgMB85UXMtGJmx8Oo1Qd+Xa4lBbJ/uYWup
         3r0rGUOwrjcDHQKeoYKfWGhFraLkSapL0x/t9zl/tuCIRha19r3mJeJoa0Suusk2JpcF
         YUs4tGDbJFGrLjTX1zVNnIM0qkeAqxy2gQjP9wZwXtqVb6LS2RLfK2JVhbx1mgyb2wIM
         Bq8GTd4fBBUpHd/NwKI9w3M23zZLOno6wE2oqzuaYAwbY6RnKt2qoVeemo9nNZX9QZbP
         w/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtSPNig1ms9qonkm00W4u3LTk/rJpQxZEt50bultrPA=;
        b=iQug0M8xUcvdu8DkgrzTynn3qCmOnwqMzSrWtu5m4pW5s3vxEIFt9AyzFea1VPGvj9
         z2g94eEMknHOXhg6rGLF7ZUdNAYNUaFhc9DHRNosS92V9VGdXYNn8ANmq+lNfURCUdY9
         /FH6mzbKn3PumOKm8wtSTZMt1YMV/Thj3sbQCZol7/kh9Z5xL7JJpMBNJ9EU8xLUvAbc
         Gou5luXyTnlWTgX2RXSkb/3XkBakzrFjlbAthOEkLNxf8qAJOnpH56FhaJ4X8wol+NWY
         16Ps6cX2vivyX+y5oNM2J1r5v12bikmTfMqxYx+H06guwAlFvhvXEk/7KGtSU7+uow1d
         KZ2g==
X-Gm-Message-State: APjAAAUba+3e5j+hBJ40H9sHOt5fbNI30d+AxNRH6l6ErIFu0rH5NNKM
        EOjb+Ttsjo/IQfSfXYulxlGDlw==
X-Google-Smtp-Source: APXvYqzNbi2tQhUutrh0PDR6+GL71tBbUlCTKYzIweDtOM53Qle0E8W8yAJXMLrVkQItccbrZNGUMQ==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr3784184wrs.223.1570035777609;
        Wed, 02 Oct 2019 10:02:57 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b62sm11188575wmc.13.2019.10.02.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:02:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/6] gpio: xgene: remove redundant error message
Date:   Wed,  2 Oct 2019 19:02:44 +0200
Message-Id: <20191002170249.17366-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002170249.17366-1-brgl@bgdev.pl>
References: <20191002170249.17366-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need to emit an error message on probe failure unless we're
printing some meaningful info. Otherwise the core driver code will
inform us about a probe error.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-xgene.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-xgene.c b/drivers/gpio/gpio-xgene.c
index 2918363884de..900b38a7dba8 100644
--- a/drivers/gpio/gpio-xgene.c
+++ b/drivers/gpio/gpio-xgene.c
@@ -160,23 +160,17 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 	int err = 0;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
-	if (!gpio) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!gpio)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (!res)
+		return -EINVAL;
 
 	gpio->base = devm_ioremap_nocache(&pdev->dev, res->start,
 							resource_size(res));
-	if (!gpio->base) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!gpio->base)
+		return -ENOMEM;
 
 	gpio->chip.ngpio = XGENE_MAX_GPIOS;
 
@@ -196,14 +190,11 @@ static int xgene_gpio_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"failed to register gpiochip.\n");
-		goto err;
+		return err;
 	}
 
 	dev_info(&pdev->dev, "X-Gene GPIO driver registered.\n");
 	return 0;
-err:
-	dev_err(&pdev->dev, "X-Gene GPIO driver registration failed.\n");
-	return err;
 }
 
 static const struct of_device_id xgene_gpio_of_match[] = {
-- 
2.23.0

