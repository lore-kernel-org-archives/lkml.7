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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE355C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BF620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic1vuLYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbfDQUzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45037 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfDQUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so23727252ljg.11;
        Wed, 17 Apr 2019 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQm+dQoa6Z4QxEYhErOugU9hMmlOU6xxOdfbG6jluOQ=;
        b=Ic1vuLYHzUP7mLdNG/+LSyqqGWm5AJXA5XMJCAZcR0LjqrSmzdEIBfU5pU9sXmgZy0
         BV31LL33zgN71h56/Fy5tbpUGxaKzVnPcWDSsJ1yuylfxIrc2t5WQGlE/vv0PrdrroI4
         MM7+4JWRbS5XXpldx0BgGW9fBOfGRckepQBlvbCn+67oF+E4RsH9feyxhMqx7KJOPuB1
         0FI25l9gT+/KtONtZZpqpq2F6R+aQ+uBQiLk7f5QUnNdhVNTQnlCxu7JH3Zyi+/H2DZ7
         j9lUSa4aAoRh7lfuYK41HdlCKUgrcy75duqlgZ+vCPyr5ZfapnaNp03z/ESHWAPtRsVl
         2H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rQm+dQoa6Z4QxEYhErOugU9hMmlOU6xxOdfbG6jluOQ=;
        b=kV53sD4+MyiWYy1tI1kNsBmhRTAMoMWzZDxe1RNPui3n4FZPFVsKKxF2MpXVEeqopO
         cnSwsUpykDIfBnP+DJhhjN/T+E/9TJr2Bo3VF1l58hgm3i/CGU8JBe40tm+2Yk2k9SQU
         MfE1p/N8SoG1Wqyv+00ht9B8YTjzEwiox7BvxLjK7PcVKU6rQMUdntGI1K4vN69dsWZv
         GXxL1/vPNFCwS8Pbm3Lv/N+eAkr8bfDiFCNjS0IbWdFEfaePFJUvR0NV/CLcTa6gGDor
         Dj0nEUu9+5ri2zOdtz7BfuyVzrpXClW48BmxT4R1+8heJPjnNUbel8XKZGawpF4VB/GF
         Br/A==
X-Gm-Message-State: APjAAAX0oNtkh2+NRqBvKv5uMmlBFfvWPWrcBVSVgpe5XK+4qvDWGcVb
        GwCRlnB6p7cjXqYxfPkOhVJsf+baGGg=
X-Google-Smtp-Source: APXvYqy1qTI1VByVf6DBs4WkW6wpg3xwSkTJQAsOBSSbuS/EDGAc36MI2w5Eyb1RxZg4/LhpnYwojw==
X-Received: by 2002:a2e:924f:: with SMTP id v15mr1107771ljg.195.1555534512748;
        Wed, 17 Apr 2019 13:55:12 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:12 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 10/26] leds: lt3593: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:23 +0200
Message-Id: <20190417205439.17685-11-jacek.anaszewski@gmail.com>
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
Cc: Daniel Mack <daniel@zonque.org>
---
 drivers/leds/leds-lt3593.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index 83e8e58d81cb..9fe12e9ce38d 100644
--- a/drivers/leds/leds-lt3593.c
+++ b/drivers/leds/leds-lt3593.c
@@ -10,10 +10,10 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <uapi/linux/uleds.h>
+
+#define LED_LT3593_NAME "lt3593"
 
 struct lt3593_led_data {
-	char name[LED_MAX_NAME_SIZE];
 	struct led_classdev cdev;
 	struct gpio_desc *gpiod;
 };
@@ -66,6 +66,7 @@ static int lt3593_led_probe(struct platform_device *pdev)
 	struct lt3593_led_data *led_data;
 	struct fwnode_handle *child;
 	int ret, state = LEDS_GPIO_DEFSTATE_OFF;
+	struct led_init_data init_data;
 	const char *tmp;
 
 	if (!dev->of_node)
@@ -86,14 +87,6 @@ static int lt3593_led_probe(struct platform_device *pdev)
 
 	child = device_get_next_child_node(dev, NULL);
 
-	ret = fwnode_property_read_string(child, "label", &tmp);
-	if (ret < 0)
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593::");
-	else
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593:%s", tmp);
-
 	fwnode_property_read_string(child, "linux,default-trigger",
 				    &led_data->cdev.default_trigger);
 
@@ -102,11 +95,14 @@ static int lt3593_led_probe(struct platform_device *pdev)
 			state = LEDS_GPIO_DEFSTATE_ON;
 	}
 
-	led_data->cdev.name = led_data->name;
 	led_data->cdev.brightness_set_blocking = lt3593_led_set;
 	led_data->cdev.brightness = state ? LED_FULL : LED_OFF;
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	init_data.fwnode = child;
+	init_data.devicename = LED_LT3593_NAME;
+	init_data.default_label = ":";
+
+	ret = devm_led_classdev_register_ext(dev, &led_data->cdev, &init_data);
 	if (ret < 0) {
 		fwnode_handle_put(child);
 		return ret;
-- 
2.11.0

