Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90C3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4E120870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7dDUoif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfCaR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39079 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbfCaRzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so8619544wmk.4;
        Sun, 31 Mar 2019 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tr8uWMJv6XnZgyxSDIsJKHw0Ef41uy0BwbR3PjuDXq8=;
        b=W7dDUoifyyzBeUIQ+ezpBI9Bf5t+9DJ+C1IaKUKWmL3rAy8CWZd0jFyFo3sg4ysF/C
         NE5c8qs/pCiN/uKfOUzkJlTzEB0gdWrr0fPdT2QVOJ8mf4ufQ2+Dt8VJ1ozCVpgt748L
         dkqvHt5CN4z4dn8DzoVYDXtqhaG9I/AZAMLAnTICXiqqd8P7ihjsDoSue8LQzGsmlex8
         5FeMcKTadv+rKhn3kebO8hM6gq2d8EmbO7pHmzCFjcU3/ZgDof4P8gEfPds+cq1O3x8f
         wQC5KQKZ5GijVv/1y3zDFHkC5Srz0uw6TBlLBz5qNfw7nZoa3BlkG+QBzyNtFH88UM8h
         PRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tr8uWMJv6XnZgyxSDIsJKHw0Ef41uy0BwbR3PjuDXq8=;
        b=dCzpvvgCyxpcgFl+mK3YAGg+f3za9bdIJYwbViuRXPnHm/EUKHWX3DVsnj4bf+AkkB
         2gCw9mMbA2SjUfFCsGxCDJzVaLXyZbNYN0cWeJSUkrwdlF7eVJy86tEGlWDUKUNHAfjI
         YKkFHZAV9GmgSRKGI6CoBAyfyxX7Ckc8gN4NeEC51u1nqlZWwnjMLJO39r8Z8bE8CN5w
         LYsf2AfKPCP58opABNx0aknQmFZrwf3iFoIdjNB4dpx8gjutExfAt2wX0htEqrTKDFjn
         V2SGeJ56mjGIt8LvDQ7ptl+r0ggXNW1tgNFz28t6wz8u0SxQHdqSDdHHImrtvsgD7B5p
         H2gA==
X-Gm-Message-State: APjAAAWz+OuTBRafr/VLow8yRfU9k9/JdgY6vEIwzi74LpVZU3JmmWj5
        rWoOc3+SxyCNOd1VjA72jU50DZMU06M=
X-Google-Smtp-Source: APXvYqyrcjPophkRiNCr4jAxmdIWkjRGqV7Yhe1EtrQ/inKuwvgs/Pu4e2R7iuPKIl5KBitqKea+Uw==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr9839586wmi.138.1554054931357;
        Sun, 31 Mar 2019 10:55:31 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:30 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 11/25] leds: lp8860: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:47 +0200
Message-Id: <20190331175501.23471-12-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
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
 drivers/leds/leds-lp8860.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 39c72a908f3b..10364068da53 100644
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
@@ -387,25 +386,19 @@ static int lp8860_probe(struct i2c_client *client,
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
+	led->led_dev.default_trigger = of_get_property(child_node,
+					    "linux,default-trigger",
+					    NULL);
 
 	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
 						   "enable", GPIOD_OUT_LOW);
@@ -420,7 +413,6 @@ static int lp8860_probe(struct i2c_client *client,
 		led->regulator = NULL;
 
 	led->client = client;
-	led->led_dev.name = led->label;
 	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
 
 	mutex_init(&led->lock);
@@ -447,7 +439,12 @@ static int lp8860_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
+	init_data.fwnode = of_fwnode_handle(child_node);
+	init_data.led_hw_name = LP8860_NAME;
+	init_data.default_label = ":display_cluster";
+
+	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&client->dev, "led register err: %d\n", ret);
 		return ret;
-- 
2.11.0

