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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D32217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddQYn3f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbfDQUz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbfDQUz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so19949539lfm.0;
        Wed, 17 Apr 2019 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPtOeAFGcjG69CNffp85oXTQnu6Cl/PZEig489cVDuE=;
        b=ddQYn3f69p1x3puHu7a3Dmbcb+wKHZ6qzvrQWKV+OYxBMxY7J97l9IJ97rxDj039Dn
         biyOTJnjc2tbmrODIwb/iVqEGQVfGP81PpmaQ12TpYgjmsjIepppl+odgewBMlUEoMpQ
         SdUBZE2A0rMIKEFtqKgmmZ/mNzIGkg7EW3bgRyIsmevPJRKgoLiXasMQdVveF38Ahxc0
         9qvK+AQCMOss7DZv0khXwnIVpJXnU6r4VuMPA/7bpOB7cKIn0GH+W7/AH2aKuBRtFoVT
         7PG5tHX6jp/MR9hxs+r96wEcjNyYnjodd0rZeaYoR8VNoEOPzUQFm5sBI+1/yno3Fk+G
         zHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPtOeAFGcjG69CNffp85oXTQnu6Cl/PZEig489cVDuE=;
        b=um5OlRbo7NtPW5RkJV8WvxNV535IbcLltiM5oxC5TeasWL8VLAuhwD9cCjeq7osLXx
         xloIYls1TMUJNv4C0AuiM66IfTYSxEBRHoJjRgxzvjJPgQ7xUPTEpAismKlkUCB2mK78
         hmeRXPyEAeQv4/Sz/vxLFYfMARBPBGz/xLMfA+tcmEHPcDQztCHQcgnRYl7LNW98nt9o
         67IC6UQbrYaup5OtzauUtYRGk9vKKNxQnR1swES9YwkqPMiswhNWqMOlcEQ6AZZucUGk
         Q1d66ut8hbO0jE7iYwIIMKIM/GiuWxn/GD2d80WKq/lYVkSm2uw/z/Wb4NgCgji40t26
         uOtg==
X-Gm-Message-State: APjAAAXD0oqGKlSFNA17j+nDZp0J5sonwDWEU9Ze9joGZsNGT473zqMW
        i8TYM2jxgzwzpm0bv8ullbKIjKjX7Hw=
X-Google-Smtp-Source: APXvYqzCYTrHcKReLfN3IyB58j3dMKCRb/UFpYYDfXOkO/U9HWc7BNvTkMRriKuX3lNiZNc4ZQXqTQ==
X-Received: by 2002:a19:428c:: with SMTP id p134mr3908077lfa.108.1555534523830;
        Wed, 17 Apr 2019 13:55:23 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:23 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 16/26] leds: lm3601x: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:29 +0200
Message-Id: <20190417205439.17685-17-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3601x.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index 081aa71e43a3..6a1a0e75f3ec 100644
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
+	init_data.devicename = led->client->name;
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

