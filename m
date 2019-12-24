Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0916C2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A90206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CNgMgsKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLXMH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:07:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53902 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfLXMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:07:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so2258014wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9TsUyN+oyyXjUb/qESjsq0NNsFP2a1lN8TwiMljoxE=;
        b=CNgMgsKNVBvdwio7z9GBftsi4FUdPBTsQmUtyMMh2unY2Wrze+jvvC12BLSoV2y71p
         4U5iQegTgYvrlIBdk+vs2cy3Ub9kp8Kbzlx32AvzK9mDtDk2+YtjcdkVFBo/x22I4ueC
         KF3p1HK6wwk842g7keyhHp5oG8lpOEc2tEtY5TRUbd01xSVwBw30vdTKfaLBsmQ2AY2B
         Pe8Qfuc3ei3zHD4NaegaUY/rBTuW65HrXxBP0C3VR8WbdsZgqOLj5Zsz/1HQ2OauaDj3
         u6CH/0TNiwH+pLVRhRnfeUvtqIYkAW3+lgbcBfhr6jMKdzJgCMxuxX3v/CD4XdAGzbgs
         Eitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9TsUyN+oyyXjUb/qESjsq0NNsFP2a1lN8TwiMljoxE=;
        b=GvrWPMGRX/VoR+peACv9MEo9jTi+coI5xtp/j4RY5UQJTU1mAtnRkxLEp4SSV2IsCR
         zaft7Ujq7wNrMCG9tVScKmn1HhF6xLrI7MoA6TawKf8yy8z0Tu1KueUxlMQgctoeXy6l
         AxBlCp42+D5ImwiFeVux2W84+R6FcNPkVC0+t24vS+5223bsJV8y3FZpsAhkagQu1744
         QxCdBiUV3VwRyrlvZleYoHcQc7JYUF3G3Dh/YutkitY3/Xi3ijyd/Q2t1LnXKX8NWP4v
         VP0UvMEtQ1wW/8fn6GjERbEiPbVkh0NPj7O6cgF7qAp5QX4rEzPbM7HmX0jh6aUXJUDD
         w3vw==
X-Gm-Message-State: APjAAAXfJbN15Wc9Mf0wEraixjNDnFVk7nAMHKh/p8pKyFBGToKoo6c+
        a8msFKpYWZM2LUdwSAssBUVJ3g==
X-Google-Smtp-Source: APXvYqwq1Rl4z4uHKTjbOWY20i9s6CbDtWGXW98Z/KC90gYdVkkq9X+0qHERy681I5WOtboTw7wMxA==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4075908wmk.50.1577189239313;
        Tue, 24 Dec 2019 04:07:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm23829210wrw.12.2019.12.24.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:07:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 02/13] gpiolib: have a single place of calling set_config()
Date:   Tue, 24 Dec 2019 13:06:58 +0100
Message-Id: <20191224120709.18247-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191224120709.18247-1-brgl@bgdev.pl>
References: <20191224120709.18247-1-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5d101ee9ada..616e431039fc 100644
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

