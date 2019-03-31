Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D389CC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6365218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXaRH2lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfCaRz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbfCaRz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so8926602wrp.0;
        Sun, 31 Mar 2019 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xD1ykRVmKPkOJzK3ZdZUz6YJfjTGPkDtJUq/dwC93t8=;
        b=uXaRH2lIUIuygzHa16qv1nCxF8oJ4zVaR8k8+pJ90/2FlNquGB5QtCX5N56sWamfZj
         t/lSmn0/NTkNS74M2IRTurAXLvHwjghvFeALLY/Sw/i1KuAR8+Ts0n6Tja5Q/VWHpLJX
         DfIAAxnX5yNAjGDYsZr5MYUEVFAEn7JLDq2pO+aPlUjCwBb656Hx5GxmQ25gXgpikYlY
         1DW1ggk3hpH4/32V59qqGJxFsqQiNQZ8npPaHh9R2wRM2KQ4gNZO7k+i5KhSlpwjPnGL
         qIjRy5JXq0RyrmghOruoovaWzNpbOZqw5Jcih/DQUk2+S331IQM5gvnXuo8NE+NfYJmE
         hE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xD1ykRVmKPkOJzK3ZdZUz6YJfjTGPkDtJUq/dwC93t8=;
        b=BGpFnlVXumObPikoU4w3bRkv2Lw9fxe8Gz6m2UZs3+UB7Xy5KszdJb0QzycSZ5AvNB
         tgdGSuJ53AB/bWDEvkiG8OWbQSL/tzcFHwRmZ+uoJ/8Vzjv9KZNuwdYXsN7TE3k30cA9
         gVyoHve4NGu3Ux+TXHkyDGnzcqRTzxXYUfycr9/JX3crGr4NTOJhgY8wkM4UutTrCeKs
         4SUxTQ3cHG8bLJvj0OgKy/oukNg5RYdG0Ueey3XOtAPSYlb2uPGiOZHqKwW4KAhnzFAa
         /3R/QdKq4swtAh6IkvbPovF+nIokDDiDjtrg8o1rhT0Scw7fYJ8CMnBbY/+5c0m/Kqki
         HSrQ==
X-Gm-Message-State: APjAAAWOW00p/fxxVhvHXQUrwUQJA5ccr+j6kD1yQxHmWjGbj38FZuvV
        TMYVMmyfwPuygL+7f/eD8zdCuEE0
X-Google-Smtp-Source: APXvYqy8nm1/tdJSOV5/P0RCcSCVyZY05la549WRN6t/IXsD+eAI4RmsM0FLyRsVHO2YOXz1mb5Nrg==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr37306173wru.11.1554054924533;
        Sun, 31 Mar 2019 10:55:24 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:23 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 07/25] leds: sc27xx-blt: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:43 +0200
Message-Id: <20190331175501.23471-8-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
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
index fecf27fb1cdc..7cd754588e58 100644
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
+		init_data.led_hw_name = "sc27xx";
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

