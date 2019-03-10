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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F43C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A02084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow/nm98G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfCJS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfCJS3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so2234769wmg.3;
        Sun, 10 Mar 2019 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+viWTw3S+MFF9gay0+kMKzR9mBVfWqisnW6eKVxS44A=;
        b=Ow/nm98GY9cMvwJyLbydGFQdpyrGoA0FHFJ56eCtU23DSrUeq86+hc+roMwyL/TZ8X
         qF0vC3FsjN0sCi5ioP7Jc3KKSnpgtPGrc/kB9xe7iDt0v5sdgpJS8a6H39k1gA7vjRsU
         +QazGmtVGQ8E1oFmgrW/+Te/HlhuDb/gm0mu1APFd3GFSZ0hlsP7n7qvIP1Y7HN3/Gxc
         oFEUarqfoMxFEwS8ry+jKkzYLYH0tOiBt4tIyy/xdlRYv0ss57nYyDBMxgHuE799n4S5
         3p7Qag4t3mgtWxKrKZi5GFyzDMJneZXicTnl+F8BJil2yxiwCpYapSNoVxUFwcAmbCug
         4ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+viWTw3S+MFF9gay0+kMKzR9mBVfWqisnW6eKVxS44A=;
        b=GGBqYx4BtXfdPaCtNYIiAKjMPp2HDqxI6FERiRfWYFQfFTLs6FTnucCPC+eK2osVAU
         jtd1GejPdZ7thEGHuyZwPFXRwTv5HFh/ZszOY0gudHbtMq+Q8Yj+JfBCJ9P0pTyCk2f3
         fzkfhpMoxtwL6g92VyFM3l196EYU9nqCzJFfH6ZzYq7kMWEcc4sJ2lGnOzHxiYx7ja8B
         h7limkvMbDvEJnb5Tpq5Olk16TcKrOFSQYsinia3nirvJFx+kcZpUBwnuMdTI3LLrC2B
         hVaLFd6VsrLmDMmKYuwyirGbfc2s/cMdwfJwR9Uem94rLkdVSm/y9zN8ICv5LWqY8/2F
         YzGw==
X-Gm-Message-State: APjAAAWQZVAJD5vwVxBkhb+EXJQ9Y5kULTR4UfVqCObkfNTWqVQWHQ5I
        P/fkWB1sXG+87WEVCzrCeZCS3fFEjv4=
X-Google-Smtp-Source: APXvYqxR5Ov7Z1DG4Gx74Zg4+NPYkma9wcqdUdUaS0GmrFHtA6TuT+/Mvm5HSbqaRi/clPIuhw6M7g==
X-Received: by 2002:a1c:64c1:: with SMTP id y184mr14966493wmb.0.1552242554227;
        Sun, 10 Mar 2019 11:29:14 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:13 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 13/25] leds: lm3692x: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:24 +0100
Message-Id: <20190310182836.20841-14-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Since the same device strings would be used in two places,
then add macros LM36922_NAME and LM36922_NAME for use in
lm3692x_probe_dt(() and lm3692x_id array.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 4f413a7c5f05..9dfc0f28a9c8 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -13,7 +13,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LM36922_MODEL	0
 #define LM36923_MODEL	1
@@ -95,6 +94,9 @@
 #define LM3692X_FAULT_FLAG_SHRT BIT(3)
 #define LM3692X_FAULT_FLAG_OPEN BIT(4)
 
+#define LM36922_NAME "lm36922"
+#define LM36923_NAME "lm36923"
+
 /**
  * struct lm3692x_led -
  * @lock - Lock for reading/writing the device
@@ -103,7 +105,6 @@
  * @regmap - Devices register map
  * @enable_gpio - VDDIO/EN gpio to enable communication interface
  * @regulator - LED supply regulator pointer
- * @label - LED label
  * @led_enable - LED sync to be enabled
  * @model_id - Current device model ID enumerated
  */
@@ -114,7 +115,6 @@ struct lm3692x_led {
 	struct regmap *regmap;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	char label[LED_MAX_NAME_SIZE];
 	int led_enable;
 	int model_id;
 };
@@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
 static int lm3692x_probe_dt(struct lm3692x_led *led)
 {
 	struct fwnode_handle *child = NULL;
-	const char *name;
+	struct led_init_data init_data;
+	char *model_name;
 	int ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
@@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		dev_err(&led->client->dev, "No LED Child node\n");
 		return -ENODEV;
 	}
+	init_data.fwnode = child;
 
-	fwnode_property_read_string(child, "linux,default-trigger",
-				    &led->led_dev.default_trigger);
+	if (led->model_id == LM36922_MODEL)
+		model_name =  LM36922_NAME;
+	else
+		model_name =  LM36923_NAME;
 
-	ret = fwnode_property_read_string(child, "label", &name);
+	ret = led_compose_name(child, model_name, ":backlight_cluster",
+			       init_data.name);
 	if (ret)
-		snprintf(led->label, sizeof(led->label),
-			"%s::", led->client->name);
-	else
-		snprintf(led->label, sizeof(led->label),
-			 "%s:%s", led->client->name, name);
+		return ret;
+
+	fwnode_property_read_string(child, "linux,default-trigger",
+				    &led->led_dev.default_trigger);
 
 	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
 	if (ret) {
@@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		return ret;
 	}
 
-	led->led_dev.name = led->label;
-
-	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
+	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&led->client->dev, "led register err: %d\n", ret);
 		return ret;
 	}
 
-	led->led_dev.dev->of_node = to_of_node(child);
-
 	return 0;
 }
 
@@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3692x_id[] = {
-	{ "lm36922", LM36922_MODEL },
-	{ "lm36923", LM36923_MODEL },
+	{ LM36922_NAME, LM36922_MODEL },
+	{ LM36923_NAME, LM36923_MODEL },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm3692x_id);
-- 
2.11.0

