Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13495C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DF821873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDkAU8rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfCaRzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34493 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731672AbfCaRzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so8928908wrq.1;
        Sun, 31 Mar 2019 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yA/S5l84jv1H+ABadAdEdjpS5F0s0NRElsbMkyS5Xfg=;
        b=BDkAU8rRyWgwO6UoEodr4T/GI53P8ax+V0pkKE+UvDbYIiYrQ+QGguYOq5TzIc23Wi
         33NxI+rZN1pQgNtnMBRbrRwuciDft6GKod2L0J21Fu6h2Cqd2h8nD4kYgk9pEmGH2es8
         c+sbLx+Gj70AiOH2c/QstzO9/3+1xyjgS3x4PLKVcxnRy8DdkicTgZk6GO8VWmVKY326
         pE1tzP4t10b3V+zsCztwINjbHJ8sKuq7Us3tw9ftM4F8+/NbvqcWKsB+0kSerVOaeA7s
         PsCf4zNOP6NOYP9i6DR1V+LYYcg5jsdao2Rs3Lcv6CdJZXPKEsUNHZuRBnqna/QOSoHt
         esFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yA/S5l84jv1H+ABadAdEdjpS5F0s0NRElsbMkyS5Xfg=;
        b=nmJuW+8TAklTYSk4p92SFieaADg9lZIhcBs9g1CB+S+JGS+p9+DunyzJnX1tLEKzF7
         GQSmPzwx1Hn09AQIdMSv65cRV21xu9sT0DAOf8x8XDuctcMvSIsdtAKaclBjvkYFsgrW
         Mzwwtue0uuJBzFjOT32i7MZKdP9DB2KW9ScLmlf9aysOkUbBy3DGw9JeRkwqBPNS8DxW
         imirYOj7zFEebIuFV44f7SLi+/2/ol2r1iHBhNsVX23duqBPRkAYTQWfWVAmIW3F7QsS
         vkZjn8drqxSOzYhpEPA2v8DGIR2jAv3zoyxVApkYnRq9nJGJWAe7+XI7TCy9qNO9mIPx
         V03Q==
X-Gm-Message-State: APjAAAVsdCJD1+SbqMnYP9AB1HJnqwNzAbioPWbVOEyMujSFR/Cp1gjq
        SFJPWShlCD3hYV94EKCPG5BAciIzMs4=
X-Google-Smtp-Source: APXvYqxH0jraN5RL9zm1CODbcv4HW+ZynlRAIpNMVd0FJ0mcTOOHOITOvLejp+Bk/LqB4O1SzSXqTw==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr28085357wrw.103.1554054947533;
        Sun, 31 Mar 2019 10:55:47 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:46 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 21/25] leds: as3645a: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:57 +0200
Message-Id: <20190331175501.23471-22-jacek.anaszewski@gmail.com>
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
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-as3645a.c | 69 ++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index b0df514992e1..fa339e3ecdd5 100644
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
+	init_data.led_hw_name = AS_NAME;
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
+	init_data.led_hw_name = AS_NAME;
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

