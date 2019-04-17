Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D48C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE9218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2ArnyMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfDQU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:56:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37450 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbfDQUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so15582746lfl.4;
        Wed, 17 Apr 2019 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Psb7qTxHJkXEjjcBXoRE5aT/gBqH6f9JHZF9o40TL5I=;
        b=O2ArnyMKJkDIq26N9sqHziQxAqwEcSq9TDcWBWgUk4RI1vzvnApc4sDcI7AM/4vTTM
         v02ArrdgIHy3KA2H1p+hNAs9zHRkw73Dekmiz8yeptHGR+3qMDuKzlTChIWxlGW9WAyb
         +siyAc+GDICe16PS9QnWE7yuhrOmlq9yxD2Fbf/vkRW6HyjDtySYjgUp0YrGv2oIJiUK
         gDd1qVlULLll2G5Ixk8w5RmTmZK3u5wTuJFI1Xc4lcBw0neR0j2ouAIS0oN85twNGs1S
         L8Cv0iLGNvQpBUYfglzLYn1AvZGWITAxSlSdFmpm9oS9OuhEPg02DnsXW1RGhExNJ5wN
         ML6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Psb7qTxHJkXEjjcBXoRE5aT/gBqH6f9JHZF9o40TL5I=;
        b=UrGqwZwJkF7B++1aM+/rAnwlh5xCu/SaxfIeuUO83ynxzbgEKdRw4K6Ks+moTNBCuO
         rJRXxWpYptvf4pXIygkg6cwMmiEH/ano350AtqIJGBXlCVLScYthhlk6ux9j/CEP3Av2
         TsOaHxTu7qZClvSg3iQHYC42mQeVbDYffJxzTnQDDa1fCIYKWgbdvRbC4ps3TNBF6U7s
         nlSPSEDX1sXnzO/quUcC4kNmzT39dm7eXjOKBYGkvv1APsrqj8q+RgUGoJF8u2vvoAlV
         LE6DzLzlf4X7x9yWNzoFnTAs8tNycEeokTiFqTRG+0u3sRtoRTL9sLp3Xrw+d5U1CJJT
         m2jA==
X-Gm-Message-State: APjAAAWwjdV4Ju2kefTR3q3Cd8UGfnlPy5AXcRCAYMUcbejaLDA6PbbV
        4U7t6PUJbwGZkixxwhR+6uVb4mm+YMg=
X-Google-Smtp-Source: APXvYqwWUIjdxpZ3gkeaD/XmFde2Pygmqjaf6f5PBbzh1NJqMh9BWiJnFJJ/w1Ag3Rz1MULu3bv0FA==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr16167540lfk.45.1555534534660;
        Wed, 17 Apr 2019 13:55:34 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:33 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 22/26] leds: as3645a: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:35 +0200
Message-Id: <20190417205439.17685-23-jacek.anaszewski@gmail.com>
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
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-as3645a.c | 69 ++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index b0df514992e1..52a7426e26d4 100644
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
@@ -603,21 +574,25 @@ static int as3645a_parse_node(struct as3645a *flash,
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
 	iled_cdev->brightness_set_blocking = as3645a_set_indicator_brightness;
 	iled_cdev->max_brightness =
 		flash->cfg.indicator_max_ua / AS_INDICATOR_INTENSITY_STEP;
 	iled_cdev->flags = LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_register(&flash->client->dev, iled_cdev);
+	init_data.fwnode = flash->indicator_node;
+	init_data.devicename = AS_NAME;
+	init_data.default_label = "indicator";
+
+	rval = led_classdev_register_ext(&flash->client->dev, iled_cdev,
+					 &init_data);
 	if (rval < 0)
 		return rval;
 
@@ -635,7 +610,6 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 
 	flash->fled.ops = &as3645a_led_flash_ops;
 
-	fled_cdev->name = names->flash;
 	fled_cdev->brightness_set_blocking = as3645a_set_assist_brightness;
 	/* Value 0 is off in LED class. */
 	fled_cdev->max_brightness =
@@ -643,15 +617,23 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 				       flash->cfg.assist_max_ua) + 1;
 	fled_cdev->flags = LED_DEV_CAP_FLASH | LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_flash_register(&flash->client->dev, &flash->fled);
-	if (rval) {
-		led_classdev_unregister(iled_cdev);
-		dev_err(&flash->client->dev,
-			"led_classdev_flash_register() failed, error %d\n",
-			rval);
-	}
+	init_data.fwnode = flash->flash_node;
+	init_data.devicename = AS_NAME;
+	init_data.default_label = "flash";
+
+	rval = led_classdev_flash_register_ext(&flash->client->dev,
+					       &flash->fled, &init_data);
+	if (rval)
+		goto out_err;
 
 	return rval;
+
+out_err:
+	led_classdev_unregister(iled_cdev);
+	dev_err(&flash->client->dev,
+		"led_classdev_flash_register() failed, error %d\n",
+		rval);
+	return rval;
 }
 
 static int as3645a_v4l2_setup(struct as3645a *flash)
@@ -697,7 +679,6 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
 
 static int as3645a_probe(struct i2c_client *client)
 {
-	struct as3645a_names names;
 	struct as3645a *flash;
 	int rval;
 
@@ -710,7 +691,7 @@ static int as3645a_probe(struct i2c_client *client)
 
 	flash->client = client;
 
-	rval = as3645a_parse_node(flash, &names, dev_fwnode(&client->dev));
+	rval = as3645a_parse_node(flash, dev_fwnode(&client->dev));
 	if (rval < 0)
 		return rval;
 
@@ -725,7 +706,7 @@ static int as3645a_probe(struct i2c_client *client)
 	if (rval)
 		goto out_mutex_destroy;
 
-	rval = as3645a_led_class_setup(flash, &names);
+	rval = as3645a_led_class_setup(flash);
 	if (rval)
 		goto out_mutex_destroy;
 
-- 
2.11.0

