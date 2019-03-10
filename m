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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1068C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81732084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfOjRNxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCJS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfCJS31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2so2666906wrw.8;
        Sun, 10 Mar 2019 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=elnuCixH/JLy5iO00B9mGD4m620hIcjPft9DF/b8PPQ=;
        b=NfOjRNxGW06UC+AsQ5R2CJxYKg3LeIcIwMH7Htko+MyX2ljn1mBzTCq/EoAczEMf7S
         uvTX1AE5PMRCKcDnI8d1NjEyJFAiPLQQ4ZSH8ZH9YLhd/m/oegFp5WxDNY0CsiPvuZl7
         eF5Sbycx9KRZb8XrZcgBAxWX+Hq0Jp5rCQcq0dSPF3ydkOEoiaOPmXYKKooU4o3yAAy9
         ODhHyjeKvdeB+UgJYm3hAqVs5B8Bg07ZYMW3dANbFoa0W8RPAbyzCgmbk44+QcOhYviW
         me9e8230dRpNvFtNv84Zz66MlXs9CFQBSIy6mPH45t2C7/upL1lq6WLlre0U1yxg/RxO
         9X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=elnuCixH/JLy5iO00B9mGD4m620hIcjPft9DF/b8PPQ=;
        b=T5mJrKa8FaE9+Pqp+vMGLS2ZVmEXTulWA3pz58hYIogcW1Av/4YLyRqCTSdc6prZ1H
         YC8dOAw7llq6Pl1dQ0/GMmmvXPTE2XHK5W+OE8+xNOy32edtJmc4ey7U6tB10KcsVxlG
         qSoe/fs3bq0+JFp4M7wG6wV0UqArx8/wcVQms29pGjz3XVXZZDnwFOfh6/doRoiZKAYk
         8TcVr0me02d7dU/sF9H4/uQdi9mFQG9N4xnezZsEvqgmbUbgnWhxfH5+snsBMJa9SWwy
         Pxi97BCUf7UQwsg+a2GJ3vA3rzZkZFRVV/Ig56Nu6PD+PRqpus/x63nNfqVxFzlNXefa
         F5Uw==
X-Gm-Message-State: APjAAAXN5eRHRze0oZ6iJr0CNPbhAdtU/fXsOWAWXVDeMaa6BUSPAvoe
        iwHOgnemPUnZTbFfuwCimeOMPcFq6I8=
X-Google-Smtp-Source: APXvYqwwB6a7anRBrX7NvqCVux1uLEmodzrz7vQ3jGpbRUMC99edZ1esHX3ZIpvwy+2TeY+bYVVyWQ==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr18839843wrx.231.1552242564618;
        Sun, 10 Mar 2019 11:29:24 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:24 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 21/25] leds: as3645a: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:32 +0100
Message-Id: <20190310182836.20841-22-jacek.anaszewski@gmail.com>
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
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-as3645a.c | 73 ++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index b0df514992e1..a6c087e5491a 100644
--- a/drivers/leds/leds-as3645a.c
+++ b/drivers/leds/leds-as3645a.c
@@ -132,11 +132,6 @@ struct as3645a_config {
 	u32 peak;
 };
 
-struct as3645a_names {
-	char flash[32];
-	char indicator[32];
-};
-
 struct as3645a {
 	struct i2c_client *client;
 
@@ -492,12 +487,10 @@ static int as3645a_detect(struct as3645a *flash)
 }
 
 static int as3645a_parse_node(struct as3645a *flash,
-			      struct as3645a_names *names,
 			      struct fwnode_handle *fwnode)
 {
 	struct as3645a_config *cfg = &flash->cfg;
 	struct fwnode_handle *child;
-	const char *name;
 	int rval;
 
 	fwnode_for_each_child_node(fwnode, child) {
@@ -525,17 +518,6 @@ static int as3645a_parse_node(struct as3645a *flash,
 		return -ENODEV;
 	}
 
-	rval = fwnode_property_read_string(flash->flash_node, "label", &name);
-	if (!rval) {
-		strlcpy(names->flash, name, sizeof(names->flash));
-	} else if (is_of_node(fwnode)) {
-		snprintf(names->flash, sizeof(names->flash),
-			 "%pOFn:flash", to_of_node(fwnode));
-	} else {
-		dev_err(&flash->client->dev, "flash node has no label!\n");
-		return -EINVAL;
-	}
-
 	rval = fwnode_property_read_u32(flash->flash_node, "flash-timeout-us",
 					&cfg->flash_timeout_us);
 	if (rval < 0) {
@@ -573,17 +555,6 @@ static int as3645a_parse_node(struct as3645a *flash,
 		goto out_err;
 	}
 
-	rval = fwnode_property_read_string(flash->indicator_node, "label",
-					   &name);
-	if (!rval) {
-		strlcpy(names->indicator, name, sizeof(names->indicator));
-	} else if (is_of_node(fwnode)) {
-		snprintf(names->indicator, sizeof(names->indicator),
-			 "%pOFn:indicator", to_of_node(fwnode));
-	} else {
-		dev_err(&flash->client->dev, "indicator node has no label!\n");
-		return -EINVAL;
-	}
 
 	rval = fwnode_property_read_u32(flash->indicator_node,
 					"led-max-microamp",
@@ -603,21 +574,27 @@ static int as3645a_parse_node(struct as3645a *flash,
 	return rval;
 }
 
-static int as3645a_led_class_setup(struct as3645a *flash,
-				   struct as3645a_names *names)
+static int as3645a_led_class_setup(struct as3645a *flash)
 {
 	struct led_classdev *fled_cdev = &flash->fled.led_cdev;
 	struct led_classdev *iled_cdev = &flash->iled_cdev;
+	struct led_init_data init_data;
 	struct led_flash_setting *cfg;
 	int rval;
 
-	iled_cdev->name = names->indicator;
+	init_data.fwnode = flash->indicator_node;
+	rval = led_compose_name(init_data.fwnode, AS_NAME, "indicator",
+				init_data.name);
+	if (rval < 0)
+		return rval;
+
 	iled_cdev->brightness_set_blocking = as3645a_set_indicator_brightness;
 	iled_cdev->max_brightness =
 		flash->cfg.indicator_max_ua / AS_INDICATOR_INTENSITY_STEP;
 	iled_cdev->flags = LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_register(&flash->client->dev, iled_cdev);
+	rval = led_classdev_register_ext(&flash->client->dev, iled_cdev,
+					 &init_data);
 	if (rval < 0)
 		return rval;
 
@@ -635,7 +612,12 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 
 	flash->fled.ops = &as3645a_led_flash_ops;
 
-	fled_cdev->name = names->flash;
+	init_data.fwnode = flash->flash_node;
+	rval = led_compose_name(init_data.fwnode, AS_NAME, "flash",
+				init_data.name);
+	if (rval < 0)
+		goto out_err;
+
 	fled_cdev->brightness_set_blocking = as3645a_set_assist_brightness;
 	/* Value 0 is off in LED class. */
 	fled_cdev->max_brightness =
@@ -643,14 +625,18 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 				       flash->cfg.assist_max_ua) + 1;
 	fled_cdev->flags = LED_DEV_CAP_FLASH | LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_flash_register(&flash->client->dev, &flash->fled);
-	if (rval) {
-		led_classdev_unregister(iled_cdev);
-		dev_err(&flash->client->dev,
-			"led_classdev_flash_register() failed, error %d\n",
-			rval);
-	}
+	rval = led_classdev_flash_register_ext(&flash->client->dev,
+					       &flash->fled, &init_data);
+	if (rval)
+		goto out_err;
+
+	return rval;
 
+out_err:
+	led_classdev_unregister(iled_cdev);
+	dev_err(&flash->client->dev,
+		"led_classdev_flash_register() failed, error %d\n",
+		rval);
 	return rval;
 }
 
@@ -697,7 +683,6 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
 
 static int as3645a_probe(struct i2c_client *client)
 {
-	struct as3645a_names names;
 	struct as3645a *flash;
 	int rval;
 
@@ -710,7 +695,7 @@ static int as3645a_probe(struct i2c_client *client)
 
 	flash->client = client;
 
-	rval = as3645a_parse_node(flash, &names, dev_fwnode(&client->dev));
+	rval = as3645a_parse_node(flash, dev_fwnode(&client->dev));
 	if (rval < 0)
 		return rval;
 
@@ -725,7 +710,7 @@ static int as3645a_probe(struct i2c_client *client)
 	if (rval)
 		goto out_mutex_destroy;
 
-	rval = as3645a_led_class_setup(flash, &names);
+	rval = as3645a_led_class_setup(flash);
 	if (rval)
 		goto out_mutex_destroy;
 
-- 
2.11.0

