Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16012068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zufUBsJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfK0Nf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51147 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfK0NfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so7141783wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMGWdghs7WZhxPpptxQGrZdPfirAzMk9gNZC1ILuwUo=;
        b=zufUBsJmnKFAgWNU55JroU36UiAZtzn5inpDMPCItaMQMgP1jXvY45bkDH9oJzp4Uf
         Q9wy54HQxm+xwcUJQ+pu0HrvnlahGLmUobv1C3MJZujIwX6g5yigboxCM6PnAG+LiW+M
         k8n5nwEFhLeHvHQIgkguYxI3tyPb79O3skASJ+Ht4gscaTuonaRyjEuWAOISKeX20HLx
         5zzbtWlDY6TqBBOzMXPq1QZhP6gGaG+VKqZ+NFv8rEEAMREmPe6rX/zoL5z6YO0dEfuk
         6XPBhUWWxfNmAW4wIOHLrfgaubQOQwpOziG/Zd14/vIUi8LBc8d8SpYOF7aZqr/UpSiG
         3akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMGWdghs7WZhxPpptxQGrZdPfirAzMk9gNZC1ILuwUo=;
        b=BrTqDTc4nrxXBb13kqbd5FUjTPf4Z3SbaPlJSehMpqOot85DIEBcBmAS44XLnyDr8t
         SNykZjkkzi1LzHhQnhV1aoqoQShlzmTG9oCWBIVgzDiWEymp64MG7vA5vKr8qaa6+wGV
         YRSXPQ0WcyX6FvCG28BsH/iGJ1W/2r4/jrH/LeCewEjL1y2DG5HHRfrqK7j6IKJoXn8n
         68nwswweg07j1CVdkHt3t/KPjxKUBJnattxqgPRzUFpoauPAHxPwyEcJ6eCX6LT8sRY1
         +51WSqK2cTdydRd+p6X4FjuWwXBJ78Ct72Z4q6FJrX3VqbPM8TAWQE3LyNEXlyXj/K4t
         AcuQ==
X-Gm-Message-State: APjAAAXWVcNiCzgyy4CKj5nVAkiaQUFEP7atokN4xwvNpCJ5D/D1RFn8
        kngeYWNt16NxFDeE0YHBRQUk5g==
X-Google-Smtp-Source: APXvYqxyVgDbg/QQsqwSOz+dkHv/xHkBjG0vMayFRkDCiatdPitUxQ1agp0E6/MyQR1tCEeoSgAJTg==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr4315729wme.168.1574861722096;
        Wed, 27 Nov 2019 05:35:22 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/8] gpiolib: have a single place of calling set_config()
Date:   Wed, 27 Nov 2019 14:35:04 +0100
Message-Id: <20191127133510.10614-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Instead of calling the gpiochip's set_config() callback directly and
checking its existence every time - just add a new routine that performs
this check internally. Call it in gpio_set_config() and
gpiod_set_transitory(). Also call it in gpiod_set_debounce() and drop
the check for chip->set() as it's irrelevant to this config option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a31797fe78fa..72211407469f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3042,6 +3042,15 @@ EXPORT_SYMBOL_GPL(gpiochip_free_own_desc);
  * rely on gpio_request() having been called beforehand.
  */
 
+static int gpio_do_set_config(struct gpio_chip *gc, unsigned int offset,
+			      enum pin_config_param mode)
+{
+	if (!gc->set_config)
+		return -ENOTSUPP;
+
+	return gc->set_config(gc, offset, mode);
+}
+
 static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			   enum pin_config_param mode)
 {
@@ -3060,7 +3069,7 @@ static int gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 	}
 
 	config = PIN_CONF_PACKED(mode, arg);
-	return gc->set_config ? gc->set_config(gc, offset, config) : -ENOTSUPP;
+	return gpio_do_set_config(gc, offset, mode);
 }
 
 static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
@@ -3294,15 +3303,9 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 
 	VALIDATE_DESC(desc);
 	chip = desc->gdev->chip;
-	if (!chip->set || !chip->set_config) {
-		gpiod_dbg(desc,
-			  "%s: missing set() or set_config() operations\n",
-			  __func__);
-		return -ENOTSUPP;
-	}
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return chip->set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
@@ -3339,7 +3342,7 @@ int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
 	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
 					  !transitory);
 	gpio = gpio_chip_hwgpio(desc);
-	rc = chip->set_config(chip, gpio, packed);
+	rc = gpio_do_set_config(chip, gpio, packed);
 	if (rc == -ENOTSUPP) {
 		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
 				gpio);
-- 
2.23.0

