Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24ADC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF8B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8wdD4HJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfDQU4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:56:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387522AbfDQUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so2347252ljq.7;
        Wed, 17 Apr 2019 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZaChgjtc7Og2IApfzzkwYIJM2Uc0zrlIPquJvR3MjI=;
        b=H8wdD4HJXX5Cd38SLzUhQj4b3Fc+yC3w6ZiSk+qBGSXU03zTNRtn8olH4/bKTtoEk5
         bXUZ55xA1d9oxfpG+3T1cmf5p9oDwio30xBOlCAlCLb80KpdLzJAZ5i9NpXjjzqLp3NH
         sVN9X1M0BjKpEuHJfH53nqTTmpEmeT3bBE+2N7cvZDHWgdRogKlHZdp2dQu1AvsW2mq+
         woSnPIyjphcTH2oRfeCgo/g0JoaV6pLMxHUx7RgyUb7MxsDQmag62lGHefTdnvVQ9RUv
         s1EKuL7gI1UMXCYrYmaCsfXsq5BCObG0DGqKUhof9zs8nWXcr/MrI5l8B66h4ccblOP+
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZaChgjtc7Og2IApfzzkwYIJM2Uc0zrlIPquJvR3MjI=;
        b=pJiX4lTgSJCMxtGqHbE/zn9EwgnV/odmcmVnohI5DqXmzA6cnxsTjHDe6qsXe2iMCV
         0ld2W9mR6VWIX4CucjU1HtPqYpd5jdnpcO3yML1o+XNVGeSfBk876UEXcunjSfNFz3xz
         55YbHssZRwTfCJvpU0nalG8yADO+1pQvu3n0eZhT7KGMdubKvNXQHw90v89cxIE9LIh7
         W3JdG8t5e1qweOv+J+/piFnE/B0PRLfCoOg0eLXbyX5T1g5tDp4bZxKT8n0361Y5dmWe
         lcxd0iiTgA9d2XVvQrgjuCNNWzonJk2WLHR4aQRMWrsaZZzSPsQ73cvSaFbphRZVAnJA
         novg==
X-Gm-Message-State: APjAAAWwEnAajxbvSunCT92OtRBS+rAYpeqcAbjt4iW6rALA9u1FpvhZ
        bVR/Zg/d7nTWJmvdr45lXdt53yy6xew=
X-Google-Smtp-Source: APXvYqyzBjWU9vpJZ8EKpfB6+mO2YX3Gh8lssx3cD/FZrexbjsaOec7hLDN5JLvP3nv4AkkIZLm5gA==
X-Received: by 2002:a2e:8550:: with SMTP id u16mr6179863ljj.11.1555534520182;
        Wed, 17 Apr 2019 13:55:20 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:19 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 14/26] leds: lm3692x: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:27 +0200
Message-Id: <20190417205439.17685-15-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

At this occassion remove initialization of struct led_classdev's
dev->of_node property in the driver, since now it will be taken from
fwnode assigned to struct led_init_data and passed to the new
devm_led_classdev_register_ext() API.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 4f413a7c5f05..f25ac6a98125 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -13,7 +13,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LM36922_MODEL	0
 #define LM36923_MODEL	1
@@ -103,7 +102,6 @@
  * @regmap - Devices register map
  * @enable_gpio - VDDIO/EN gpio to enable communication interface
  * @regulator - LED supply regulator pointer
- * @label - LED label
  * @led_enable - LED sync to be enabled
  * @model_id - Current device model ID enumerated
  */
@@ -114,7 +112,6 @@ struct lm3692x_led {
 	struct regmap *regmap;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	char label[LED_MAX_NAME_SIZE];
 	int led_enable;
 	int model_id;
 };
@@ -325,7 +322,7 @@ static int lm3692x_init(struct lm3692x_led *led)
 static int lm3692x_probe_dt(struct lm3692x_led *led)
 {
 	struct fwnode_handle *child = NULL;
-	const char *name;
+	struct led_init_data init_data;
 	int ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
@@ -350,30 +347,23 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 	fwnode_property_read_string(child, "linux,default-trigger",
 				    &led->led_dev.default_trigger);
 
-	ret = fwnode_property_read_string(child, "label", &name);
-	if (ret)
-		snprintf(led->label, sizeof(led->label),
-			"%s::", led->client->name);
-	else
-		snprintf(led->label, sizeof(led->label),
-			 "%s:%s", led->client->name, name);
-
 	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
 	if (ret) {
 		dev_err(&led->client->dev, "reg DT property missing\n");
 		return ret;
 	}
 
-	led->led_dev.name = led->label;
+	init_data.fwnode = child;
+	init_data.devicename = led->client->name;
+	init_data.default_label = ":";
 
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
 
-- 
2.11.0

