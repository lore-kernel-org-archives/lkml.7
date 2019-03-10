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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A4A20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbd8DSEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfCJS3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfCJS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2so2666578wrw.8;
        Sun, 10 Mar 2019 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wGHWm6Eb/CJnWIPjw9B7FHEk4fQHOl9O5NsClGKYlsg=;
        b=Lbd8DSEseGHgC/KWg0pnJqkQHz9NvLBKGE8h0Sm/vPmo8Qlggqm9IL3EGmk66V00bG
         ZXXZrENYSt1fMzvc3dMeiduUNXdLirmuw2IS3nwHwFF7+NqWxvSK2aQNse3+eKOrsI1C
         k3R4arj4sK3DM8V2pepGdG01as0zZ2XVScxmtElI9mffE4xyLKoZYtbDtC0QSOJnC4l7
         JWTicQTJjR1u14QXxg49Sla6kqesw2op6qW2WUh5ZhSBI/DLIZc30Rh9hBdibV5ZXaHw
         /Z4p/BaJ9CtNoHtqT/mTbJo8fsWWDW5n/sQK1DLxI1Oeo3XT93pxfByZOisNEvdTMNIO
         7Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wGHWm6Eb/CJnWIPjw9B7FHEk4fQHOl9O5NsClGKYlsg=;
        b=N+NUDMiMdWEDd5mLJb9LxUs6Yv9JgTL1icw9SoRuAGYZSGoirr5XQp2BbudbRtkR1R
         Ek7LsUDP++afZL9MSbC3zeHh9dLiBzQGg27CwnyvPCwOLql9OKCe0n0G+oZwszW1P4sh
         3F8fqamrDIIvbKVp7CGq2JjnVeYrSC/CWK3/sO6Y5rtjX7wZQXfwDqDXQKz3i4IXeyyL
         mZn3vvPe0t51tu/4kO7JQaqIJYvZpic6nBsEDVt/G9ItufVNQd3HuOL2PdtKgBSW5dxN
         92tEgP8njT1CbznOOQ+wLe331vr8a4cq4ihZJQKL+NHrcOQxkd5jzSlVBd+9lfdWgEmi
         6ZOA==
X-Gm-Message-State: APjAAAV2OjDKxE8uLS0r4v1OMXgXP0/FVgnjWeiS/UC9q6eBk3ZR2i2l
        U0Xwh7xseYfTtgQeBQM4pSDyj5uOB5g=
X-Google-Smtp-Source: APXvYqx/zdUhS0fhjKGT/4ltGeCJn4hVwGX3xirdaCghSBOFP5B7BM2PTxcIzNoipngiX2aFleRsFw==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr17541972wrh.132.1552242551453;
        Sun, 10 Mar 2019 11:29:11 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:10 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 11/25] leds: lp8860: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:22 +0100
Message-Id: <20190310182836.20841-12-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

While at it, avoid iterating through available child of nodes
in favor of obtaining single expected child node using single
call to of_get_next_available_child().

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 39c72a908f3b..7c12ccdc1f2f 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -22,7 +22,6 @@
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LP8860_DISP_CL1_BRT_MSB		0x00
 #define LP8860_DISP_CL1_BRT_LSB		0x01
@@ -87,6 +86,8 @@
 
 #define LP8860_CLEAR_FAULTS		0x01
 
+#define LP8860_NAME			"lp8860"
+
 /**
  * struct lp8860_led -
  * @lock - Lock for reading/writing the device
@@ -96,7 +97,6 @@
  * @eeprom_regmap - EEPROM register map
  * @enable_gpio - VDDIO/EN gpio to enable communication interface
  * @regulator - LED supply regulator pointer
- * @label - LED label
  */
 struct lp8860_led {
 	struct mutex lock;
@@ -106,7 +106,6 @@ struct lp8860_led {
 	struct regmap *eeprom_regmap;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	char label[LED_MAX_NAME_SIZE];
 };
 
 struct lp8860_eeprom_reg {
@@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
 	struct lp8860_led *led;
 	struct device_node *np = client->dev.of_node;
 	struct device_node *child_node;
-	const char *name;
+	struct led_init_data init_data;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child_node) {
-		led->led_dev.default_trigger = of_get_property(child_node,
-						    "linux,default-trigger",
-						    NULL);
-
-		ret = of_property_read_string(child_node, "label", &name);
-		if (!ret)
-			snprintf(led->label, sizeof(led->label), "%s:%s",
-				 id->name, name);
-		else
-			snprintf(led->label, sizeof(led->label),
-				"%s::display_cluster", id->name);
-	}
+	child_node = of_get_next_available_child(np, NULL);
+	if (!child_node)
+		return -EINVAL;
+
+	init_data.fwnode = of_fwnode_handle(child_node),
+
+	led->led_dev.default_trigger = of_get_property(child_node,
+					    "linux,default-trigger",
+					    NULL);
+
+	ret = led_compose_name(init_data.fwnode, LP8860_NAME,
+			       ":display_cluster", init_data.name);
+	if (ret)
+		return ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
 						   "enable", GPIOD_OUT_LOW);
@@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
 		led->regulator = NULL;
 
 	led->client = client;
-	led->led_dev.name = led->label;
 	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
 
 	mutex_init(&led->lock);
@@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
+	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&client->dev, "led register err: %d\n", ret);
 		return ret;
-- 
2.11.0

