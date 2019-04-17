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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D422DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F678217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilEFF/+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfDQUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39890 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbfDQUzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so23749190ljg.6;
        Wed, 17 Apr 2019 13:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WzCRqcpc36fGWzb0XPlN3O9Rcnr0PCaXzzYL/r5weaQ=;
        b=ilEFF/+vLZIU3q3hWJLLRyNfuUE6ikw0SKNKeNnCWCPn3DDUMGQYBpWbSqlolgVE/5
         qpH9jzQIM+t5DkNoR7LVEEeGRr+tRXDyUIsirgE3HZ7FomJMrxVOm9q6RwlzlkQmgJ0c
         467bL6FQW8fuuLieiu6hNGri+VPRanBsa0Q6ZpDKlVPgIA8oHXn0T4c2Kjo831ID+FSw
         QeqS5cAMxJsBN0BHUWMdTIzmaUIzfeSpYDkXx5UV0AHi/ZMogUD1Pk+BfixDuVygFSmD
         yQm9jzBvVfTYLHme8bgng6gitcFfwsyaE4rZ0UspGKuFVAmhFUUgUyD6oifF/2N4wJFf
         m+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WzCRqcpc36fGWzb0XPlN3O9Rcnr0PCaXzzYL/r5weaQ=;
        b=Mt3tzRjTJbm+cRZl24MzYnmhN7s1NFVAe9PO3qxM6ZKj7S9k0RCRJcYXYxACbQ5LWD
         894LGVRZJuPGtOio3saFW3wF9ZYhojH6EYVENAbB7vlcG5ii2UxFAmxvc/6qL+KUwA9Q
         GPy9RsgIYg2CYDEEsT23jCdeZkitbtz9t3rwXCEZ8gFkLAqbWYPlp0+ONQLU0+hOzbzN
         eibV7jYq9TRv8BMvrwFqlG10YI/acvFVxKwr7NBt5JMNciLufwZ05nfBjY+SH0IgXR8C
         JOEvDTl+orHJmg4LvxSYPzTQLdtxDBEjM5gutZpVb1b7K8gNkHbtqk/d7hAqENqYZbbe
         zdSQ==
X-Gm-Message-State: APjAAAWTy9EojA3P7SzVDL/+sREgG8oBdYUDhiYVFZ7hryzqRU7SJgQv
        8Tm4BFi6sjQc+nV7EPPvxEjsH3Svqpk=
X-Google-Smtp-Source: APXvYqx4QaMhjNhrHXYlW+EkfH87DgTh/9EtQ3Wp0MzHPidHvz28J4FBIy943Q08MKGSyscR69xLBQ==
X-Received: by 2002:a05:651c:c3:: with SMTP id 3mr39690052ljr.8.1555534516358;
        Wed, 17 Apr 2019 13:55:16 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:15 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 12/26] leds: lp8860: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:25 +0200
Message-Id: <20190417205439.17685-13-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
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
index 39c72a908f3b..0d3f6b237aac 100644
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
+	init_data.devicename = LP8860_NAME;
+	init_data.default_label = ":display_cluster";
+
+	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&client->dev, "led register err: %d\n", ret);
 		return ret;
-- 
2.11.0

