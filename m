Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67683C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3457B217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb4LHu6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfDQUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37430 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfDQUzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so15581936lfl.4;
        Wed, 17 Apr 2019 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sOTCaOMw3ZQQM4Lv7n5akHnpyhFcupQsTLjHOraZDPg=;
        b=Cb4LHu6w0XaUET6GBLQiAhMlBRvOyuEw9izpJKngJf5MT+DhxNW0jU/9QDZofbfnuD
         xKofmHbubSBp6xtEgtV8F8p7jIQymsSoZl/AbRdMFw9J3K4TqNWIEUAA8n7RSwISJnI+
         xidcaHMguH/evHxNNjtwjlcYIuPjA1dhijpEnVt83VY7UTUhNIR6BrC2+29ZwlbWXSlv
         BPL9BDZQuw2oM9O+U/GAG06TzQSgbY3w7j/aOHGPXmdCEE5HFKPvdwpmd3RdQSrS/RCe
         pfYvQy/D1G8PpO65soIL/C5Ql7R45bz87A3YZ+5JLVz93cXbJ07/UgwPI6qYLqbHHbvr
         gbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sOTCaOMw3ZQQM4Lv7n5akHnpyhFcupQsTLjHOraZDPg=;
        b=tt6BKwtaOPrNb4hAgtjVVGBMIGcbpM8r+FgapFk7lGE9J+Hfes8eWWmFrv5csLaxqq
         XIklPMiwyLxN/vROmOOOl+8d7xZYPjDwZ1NnyMg9i5C8psoUSNhX2brHM6u20W682JyG
         qYiq+kRkIlWN0OFk2083GVT/RS+PmYOygE4r5qRV88ns9icVsbpArHOV4DtKANM4c0hh
         yhC/zC/sF5FNB3mu/nVQzYFJZejUtjBB2X+oVDyoTkUgO14SWiE00iN2Z048Fmg3i6t/
         9vFvwLgjWi3P3HjCxzksxPNUI2vMA4gudHP8+RAOuym0wximpvK4L1wasFkn61m3aRnJ
         j6rQ==
X-Gm-Message-State: APjAAAU2GifuXonODzIQziXykEU4KXS5B63k2uO3P7VRcKKyvHMzB+HD
        ODobx5Gg1aoYh6o/hiyAAMSn+/m6Sq4=
X-Google-Smtp-Source: APXvYqzaarPQEvn3arJg6TTFo8wshtXwjpTFE3OJ6kYi8GDHEQCtLjrkXBMEN4UcB+Sr/rureUMnHg==
X-Received: by 2002:ac2:5381:: with SMTP id g1mr1351634lfh.130.1555534508785;
        Wed, 17 Apr 2019 13:55:08 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:08 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 08/26] leds: sc27xx-blt: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:21 +0200
Message-Id: <20190417205439.17685-9-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/leds/leds-sc27xx-bltc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index fecf27fb1cdc..1c542380d080 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -6,7 +6,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <uapi/linux/uleds.h>
 
 /* PMIC global control register definition */
 #define SC27XX_MODULE_EN0	0xc08
@@ -46,7 +45,7 @@
 #define SC27XX_DELTA_T_MAX	(SC27XX_LEDS_STEP * 255)
 
 struct sc27xx_led {
-	char name[LED_MAX_NAME_SIZE];
+	struct fwnode_handle *fwnode;
 	struct led_classdev ldev;
 	struct sc27xx_led_priv *priv;
 	u8 line;
@@ -249,19 +248,24 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 
 	for (i = 0; i < SC27XX_LEDS_MAX; i++) {
 		struct sc27xx_led *led = &priv->leds[i];
+		struct led_init_data init_data;
 
 		if (!led->active)
 			continue;
 
 		led->line = i;
 		led->priv = priv;
-		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
 		led->ldev.pattern_set = sc27xx_led_pattern_set;
 		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
 		led->ldev.default_trigger = "pattern";
 
-		err = devm_led_classdev_register(dev, &led->ldev);
+		init_data.fwnode = led->fwnode;
+		init_data.devicename = "sc27xx";
+		init_data.default_label = ":";
+
+		err = devm_led_classdev_register_ext(dev, &led->ldev,
+						     &init_data);
 		if (err)
 			return err;
 	}
@@ -274,7 +278,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node, *child;
 	struct sc27xx_led_priv *priv;
-	const char *str;
 	u32 base, count, reg;
 	int err;
 
@@ -316,15 +319,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
+		priv->leds[reg].fwnode = of_fwnode_handle(child);
 		priv->leds[reg].active = true;
-
-		err = of_property_read_string(child, "label", &str);
-		if (err)
-			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
-				 "sc27xx::");
-		else
-			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
-				 "sc27xx:%s", str);
 	}
 
 	err = sc27xx_led_register(dev, priv);
-- 
2.11.0

