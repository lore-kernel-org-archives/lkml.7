Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822EA20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIleqv7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCJSaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39042 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfCJS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id z84so2203806wmg.4;
        Sun, 10 Mar 2019 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGQDWyma+GhZiBdm68Y5tUzUMDR8Rtr1pyGMz5SS5cY=;
        b=OIleqv7bXZfViWYLo4CGldb35WU6R08dEBESVk7Ky+/tXl70t8n3RZPtyLZzSoZ0tJ
         rabOeLQzHonsCkxQAvSTGeHK5RXr53O0P+9mRWkmOR3MkGXOnnZhf4XHD58B9ojfKRr/
         KvSbFTfuSdkDlqoYQ30i/cB1PVkxmzn7N2NqyCmlFNwUg0fEqTdUNdw4ZxgviD8kcE3a
         I+RRzf+bmAxoKbqEyPPJpo4BEJMG2H80/adEZegAE/d8ABxX5b443B3BveTbL+ym0Oh/
         J/dNw/ZkKVOSvmShxRZfOX6FUClo/JPN1DPX6DhEupZ7ois95pTce1tqzZ0q/NoHKAvg
         D/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGQDWyma+GhZiBdm68Y5tUzUMDR8Rtr1pyGMz5SS5cY=;
        b=lUhIVnYGzExEtyCdEm8L4/EeivMMiR/hQX114ewRc/16hNXxPjbuk46eZMh+XiKhg2
         MI2MEnSEKgT5Y2R5bG9crMPjz8RtuK2sMdGbKa+VILqrzG32MxuD3kXV/PItAp0JGbCR
         P9xek8z7Zike9Z+oBpODwIuqH9HloJBbX+r5LGZjXT6x7/XMtux9Wv0X1SZwPuhDTifn
         eYK3J96XLGkPaa5Tcy4OGkq7ZhEtj9ZsylnSEWkVYB7F7ZFgJLlKDaavMP3+Hw/OC+eJ
         zd6J/oVyvvNv0567XYZKMX1pN+MX3d7ZmOcx/GC5KKSW4eqdghKvwezCaaW860fdcNTf
         f9oQ==
X-Gm-Message-State: APjAAAV2yJ1mfjnjks7BWWzQiS9mpL25BRZV5Zv4M2LSQJRj1C8lGbeU
        KFvlY/jKlZshtyqEJR0fEXgwfuJdwH4=
X-Google-Smtp-Source: APXvYqzA/wmJLTL9eqt11B4ysv20zXjraRD6bqFLq09cFYPX00+077j1nHp+OJqfEnGcMP49kOc4UQ==
X-Received: by 2002:a1c:9c04:: with SMTP id f4mr14940751wme.149.1552242556738;
        Sun, 10 Mar 2019 11:29:16 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:16 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 15/25] leds: lm3601x: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:26 +0100
Message-Id: <20190310182836.20841-16-jacek.anaszewski@gmail.com>
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
Acked-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3601x.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index 081aa71e43a3..91ea65217d48 100644
--- a/drivers/leds/leds-lm3601x.c
+++ b/drivers/leds/leds-lm3601x.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LM3601X_LED_IR		0x0
 #define LM3601X_LED_TORCH	0x1
@@ -90,8 +89,6 @@ struct lm3601x_led {
 	struct regmap *regmap;
 	struct mutex lock;
 
-	char led_name[LED_MAX_NAME_SIZE];
-
 	unsigned int flash_timeout;
 	unsigned int last_flag;
 
@@ -322,10 +319,24 @@ static const struct led_flash_ops flash_ops = {
 	.fault_get		= lm3601x_flash_fault_get,
 };
 
-static int lm3601x_register_leds(struct lm3601x_led *led)
+static int lm3601x_register_leds(struct lm3601x_led *led,
+				 struct fwnode_handle *fwnode)
 {
 	struct led_classdev *led_cdev;
 	struct led_flash_setting *setting;
+	struct led_init_data init_data = { fwnode };
+	char *mode_name;
+	int ret;
+
+	if (led->led_mode == LM3601X_LED_TORCH)
+		mode_name = "torch";
+	else
+		mode_name = "infrared";
+
+	ret = led_compose_name(fwnode, led->client->name, mode_name,
+			       init_data.name);
+	if (ret < 0)
+		return ret;
 
 	led->fled_cdev.ops = &flash_ops;
 
@@ -342,20 +353,20 @@ static int lm3601x_register_leds(struct lm3601x_led *led)
 	setting->val = led->flash_current_max;
 
 	led_cdev = &led->fled_cdev.led_cdev;
-	led_cdev->name = led->led_name;
 	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
 	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
 						LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
-	return led_classdev_flash_register(&led->client->dev, &led->fled_cdev);
+	return led_classdev_flash_register_ext(&led->client->dev,
+						&led->fled_cdev, &init_data);
 }
 
-static int lm3601x_parse_node(struct lm3601x_led *led)
+static int lm3601x_parse_node(struct lm3601x_led *led,
+			      struct fwnode_handle **fwnode)
 {
 	struct fwnode_handle *child = NULL;
 	int ret = -ENODEV;
-	const char *name;
 
 	child = device_get_next_child_node(&led->client->dev, child);
 	if (!child) {
@@ -376,17 +387,6 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 		goto out_err;
 	}
 
-	ret = fwnode_property_read_string(child, "label", &name);
-	if (ret) {
-		if (led->led_mode == LM3601X_LED_TORCH)
-			name = "torch";
-		else
-			name = "infrared";
-	}
-
-	snprintf(led->led_name, sizeof(led->led_name),
-		"%s:%s", led->client->name, name);
-
 	ret = fwnode_property_read_u32(child, "led-max-microamp",
 					&led->torch_current_max);
 	if (ret) {
@@ -411,6 +411,8 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 		goto out_err;
 	}
 
+	*fwnode = child;
+
 out_err:
 	fwnode_handle_put(child);
 	return ret;
@@ -419,6 +421,7 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 static int lm3601x_probe(struct i2c_client *client)
 {
 	struct lm3601x_led *led;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
@@ -428,7 +431,7 @@ static int lm3601x_probe(struct i2c_client *client)
 	led->client = client;
 	i2c_set_clientdata(client, led);
 
-	ret = lm3601x_parse_node(led);
+	ret = lm3601x_parse_node(led, &fwnode);
 	if (ret)
 		return -ENODEV;
 
@@ -442,7 +445,7 @@ static int lm3601x_probe(struct i2c_client *client)
 
 	mutex_init(&led->lock);
 
-	return lm3601x_register_leds(led);
+	return lm3601x_register_leds(led, fwnode);
 }
 
 static int lm3601x_remove(struct i2c_client *client)
-- 
2.11.0

