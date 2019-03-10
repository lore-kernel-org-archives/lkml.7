Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC692084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLFxicqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfCJSbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:31:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33857 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfCJS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id o10so12369223wmc.1;
        Sun, 10 Mar 2019 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2cUHDz9DPyk8eZFVidvQzicAeEey9f30+H0fEi9pZGA=;
        b=pLFxicqG7ew6UtGnK5KZiGNYTIRFcAPIpQOfmHsurVzMnBL4I2w21ghMF5O5SdH7PP
         EPGO0KjKFlqbMYEVxaFkbdsts8Pf+FcVcikRLkoZIesD9YQ97YN/0N3SZ4HbZyQYt+Nc
         YbKOcfBfoyVVdpnkpigezWFvyt779LjhAgvitTKWoUTzcGj6W44wZcYsrdDUR2QXt2AT
         i7+YABIXrSvEWsGGXcA/0OO1X3/LW2sSHGxUw6yPrpgWJlKgX0PlJlaPib7Vzehn5iU6
         JBA1xc8agk9nrCIpupDtbVN/wprligpz3Us1AnKlDlg64+MTLRjkjxoLJxVtDjWDFHTs
         yjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2cUHDz9DPyk8eZFVidvQzicAeEey9f30+H0fEi9pZGA=;
        b=XnO3Py4Gla805QhvJXgEYyMzFttfh9OaSYwDdHSueyvcqP665U48WaX+CNUs9QPOib
         dmbTJ2KVPTWvK/IyQsnjG/DAx0SKuPURxm/pD7wA43CN8GZMUMldqAHyHgbWdf6kzm1J
         VCZQApIgu1Gf8bvUmCTEW05Rk/jpEcT8Nt9bLkvPzPH5ztL5gqxYnsZ2Qhj48uvds9dL
         ea5Ml46a7tlsWRatfm5dfGiQ8+teX+EPZLGHqOxrWE+cEamNkd8aDYSUGR+cJ8zLBMcA
         B35IE6pGY9+JB1SxnGldwQJU/w27D/dHzswIDkDhgEOF0sFgT0KbKkO58mpP7erLdS+d
         jVsA==
X-Gm-Message-State: APjAAAW4AdNVcztg+KgKvJZmyIHRr69lirBXGp0P78aXSuPFeGvY0Hsy
        4tufFGDCFB+dj4S1ayFqaBzVMlZW
X-Google-Smtp-Source: APXvYqxeQnoW3lwfPqu+v1jo5W6O76hJdmw4ofZlu9jgRJa+A1JS5CwtzAoU3B91jkJb9SBFy6IxCg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr14343208wmk.47.1552242546366;
        Sun, 10 Mar 2019 11:29:06 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:05 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 07/25] leds: sc27xx-blt: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:18 +0100
Message-Id: <20190310182836.20841-8-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-sc27xx-bltc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index fecf27fb1cdc..cc93e3797a08 100644
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
@@ -249,19 +248,25 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 
 	for (i = 0; i < SC27XX_LEDS_MAX; i++) {
 		struct sc27xx_led *led = &priv->leds[i];
+		struct led_init_data init_data = { led->fwnode };
 
 		if (!led->active)
 			continue;
 
+		err = led_compose_name(led->fwnode, "sc27xx", ":",
+				       init_data.name);
+		if (err)
+			return err;
+
 		led->line = i;
 		led->priv = priv;
-		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
 		led->ldev.pattern_set = sc27xx_led_pattern_set;
 		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
 		led->ldev.default_trigger = "pattern";
 
-		err = devm_led_classdev_register(dev, &led->ldev);
+		err = devm_led_classdev_register_ext(dev, &led->ldev,
+						     &init_data);
 		if (err)
 			return err;
 	}
@@ -274,7 +279,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node, *child;
 	struct sc27xx_led_priv *priv;
-	const char *str;
 	u32 base, count, reg;
 	int err;
 
@@ -316,15 +320,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
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

