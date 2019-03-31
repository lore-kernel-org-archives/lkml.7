Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211B1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01DA21841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qw9qAy+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfCaRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45661 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfCaRzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so8882652wra.12;
        Sun, 31 Mar 2019 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LsrI8QC19cQVbRDxesu2QTnH8ehclsbdU4XV1+qOMUA=;
        b=qw9qAy+1s8rZmDgIy9NJxB2nIiabISbTp6FAeWvGEqHC2++ysyUS3CLqLnH9pnJNeY
         VLQvHqjv3WBHfjBFVENAj3I7c3YgJ8txM8rZswMEoHe7Bxz65lShb8dQqecvHpp0oDAm
         4yzwUoz5kIfNERy/NYVa5pullhDbKSpLUW/kz7IZJ/1AqKbh2ReI71SrOXoDWjugA/Jr
         nwF1KNpYmWzzX7raMJ8LjseqLAAatnWSuXUu5dyU2HHzH9qVHA1V0+uyV2TSSTfc0XSZ
         tb5MtSZ4b66x/6VcC4cJgcp+IlXm9li7YSwNQ358TRerCjs8RRRxr+/APROUGefOjp/I
         5nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LsrI8QC19cQVbRDxesu2QTnH8ehclsbdU4XV1+qOMUA=;
        b=pD5pYkbUymzceYtYomuqP5LyU5LYG3NQV/saQ7dZp/pZ6GxYGbBenU/4kZRMSPjKWu
         KXN34CShnjf4bAk+QXkEYY5gWYfSz855wOQKe0JxYDC3yliE5jx8a7ju2eKHQ216j1TN
         e/+20IFSjl2l5T5HHvhoksTQbuiwmBfUZ0icJiL370ivd2z68g7Z77RR0s/zyVQ4k8KV
         zSGXsSIUjwSpGvd99xjKVOGu+YxiReavV4S7F0DbHCI5VV6Hx154lHUxezRGqR8U5vSE
         EfV8ZMvEmkOobByp+aKrmIutnsnSSlc3VTi0Xc4t1OvYVadII2wOO3C5XbDxkFzkmmrs
         xCLA==
X-Gm-Message-State: APjAAAXeECh/InSI3TDElS7FIOBOMp/SkSzPdJDUbQnSjhIWWs//0Cmr
        gMDGYuQ3ScXgrfv0pFwE8O9Z3nUuRg0=
X-Google-Smtp-Source: APXvYqxu56sWrWsXV7lRnGwQVnrKD9NZMIZR6WJzIMON0q9HI9O/NXpt/uXA9fv5i3W8kReNc2U8aQ==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr36744915wrn.120.1554054937815;
        Sun, 31 Mar 2019 10:55:37 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:37 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 15/25] leds: lm3601x: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:51 +0200
Message-Id: <20190331175501.23471-16-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3601x.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index 081aa71e43a3..d81884c406c3 100644
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
 
@@ -322,10 +319,12 @@ static const struct led_flash_ops flash_ops = {
 	.fault_get		= lm3601x_flash_fault_get,
 };
 
-static int lm3601x_register_leds(struct lm3601x_led *led)
+static int lm3601x_register_leds(struct lm3601x_led *led,
+				 struct fwnode_handle *fwnode)
 {
 	struct led_classdev *led_cdev;
 	struct led_flash_setting *setting;
+	struct led_init_data init_data;
 
 	led->fled_cdev.ops = &flash_ops;
 
@@ -342,20 +341,25 @@ static int lm3601x_register_leds(struct lm3601x_led *led)
 	setting->val = led->flash_current_max;
 
 	led_cdev = &led->fled_cdev.led_cdev;
-	led_cdev->name = led->led_name;
 	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
 	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
 						LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
-	return led_classdev_flash_register(&led->client->dev, &led->fled_cdev);
+	init_data.fwnode = fwnode;
+	init_data.led_hw_name = led->client->name;
+	init_data.default_label = (led->led_mode == LM3601X_LED_TORCH) ?
+					"torch" : "infrared";
+
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
@@ -376,17 +380,6 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
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
@@ -411,6 +404,8 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 		goto out_err;
 	}
 
+	*fwnode = child;
+
 out_err:
 	fwnode_handle_put(child);
 	return ret;
@@ -419,6 +414,7 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 static int lm3601x_probe(struct i2c_client *client)
 {
 	struct lm3601x_led *led;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
@@ -428,7 +424,7 @@ static int lm3601x_probe(struct i2c_client *client)
 	led->client = client;
 	i2c_set_clientdata(client, led);
 
-	ret = lm3601x_parse_node(led);
+	ret = lm3601x_parse_node(led, &fwnode);
 	if (ret)
 		return -ENODEV;
 
@@ -442,7 +438,7 @@ static int lm3601x_probe(struct i2c_client *client)
 
 	mutex_init(&led->lock);
 
-	return lm3601x_register_leds(led);
+	return lm3601x_register_leds(led, fwnode);
 }
 
 static int lm3601x_remove(struct i2c_client *client)
-- 
2.11.0

