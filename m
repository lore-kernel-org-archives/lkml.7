Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E8DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF1B20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghkvl8n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCJSat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53366 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfCJS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id e74so2234646wmg.3;
        Sun, 10 Mar 2019 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M69UQQEld1O1UIDLKGPYzM3r73RYBJcVks/kCSbudYI=;
        b=ghkvl8n3HWKLa3pPf7zlH4YrghYKF6OOFwyPegwqqEcAEyn7ku3vf2dgEEBsqu/yAc
         5DgCqgejabWzzLdSaBcl8pQJLR3nqWfEQW03edCCBVMcoGNHyoXwkytuF/w0gtU57qKz
         CHKNbBkxEn0Qaq6gbGpyzypNbscrvSNMZOE/tR/+qzE9hFJokvZtpNxsOYPpUaFtonyN
         PRNJWfdejofXivZ+dL1PRzB/3g3Ssvw7jzymBqJ8Mc1sC/zkJuk6GLhQhgVXvRKV29b5
         iGfc+7NlUlzCcjIZWjP44j5b/3Vl1CxEMmadKtY/8RetffB6SskyPyxvybrGt5WyaFJX
         USKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M69UQQEld1O1UIDLKGPYzM3r73RYBJcVks/kCSbudYI=;
        b=YUc5Fr/6a2tGiO0fAH/z1tqZfQJ4WrV4IXn6W8mc+eGFaw/4NPvSvQAeEAoidRUAPl
         c0kV9Vl/N3z7P/N2F1gQhvpMXwPbgWMNwMnvKVqo6NFrqyq/Wa7zrYz+6n5ulcXUSphP
         uz8H4bnU3bvdE54vVqxn2/aTW4KSHHlDD4otP+sjqtmXNpTTt5peBamHyL5lm4ruabkr
         uLVC/1EN9xvuxoowAW8ZMax687FbQFQrxaxLdz5vKNiAJTcdXH+NtzC9ffU98zxwu+PK
         S54yjIGbblNFqvcKGB/UO9aRMRHxBL+xZMtCmZAbkLYLZ5Bfh5XwVPa3nMW28iT3ChLb
         cnZw==
X-Gm-Message-State: APjAAAWcYpjcmWXCGqE8zvY5MsN7nn/kZnNP9KJKiMfHctPYZjikJDZj
        2KqBn9EQ2U/K9u2vw7b5P8ADChYP
X-Google-Smtp-Source: APXvYqzLjGTpT+9EtVCCYQ4H11fTG6lBIwlzzdjWHrVOmxZ6AP9v/bC1pV+JLHwx9Rtthb46mUsRgg==
X-Received: by 2002:a1c:7809:: with SMTP id t9mr14417760wmc.78.1552242548901;
        Sun, 10 Mar 2019 11:29:08 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:08 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 09/25] leds: lt3593: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:20 +0100
Message-Id: <20190310182836.20841-10-jacek.anaszewski@gmail.com>
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
Acked-by: Daniel Mack <daniel@zonque.org>
---
 drivers/leds/leds-lt3593.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index de3623e0d094..d005abcf4743 100644
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
@@ -111,6 +111,7 @@ static int lt3593_led_probe(struct platform_device *pdev)
 	struct fwnode_handle *child;
 	int ret, state = LEDS_GPIO_DEFSTATE_OFF;
 	enum gpiod_flags flags = GPIOD_OUT_LOW;
+	struct led_init_data init_data;
 	const char *tmp;
 
 	if (dev_get_platdata(dev)) {
@@ -138,14 +139,11 @@ static int lt3593_led_probe(struct platform_device *pdev)
 		return PTR_ERR(led_data->gpiod);
 
 	child = device_get_next_child_node(dev, NULL);
+	init_data.fwnode = child;
 
-	ret = fwnode_property_read_string(child, "label", &tmp);
-	if (ret < 0)
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593::");
-	else
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593:%s", tmp);
+	ret = led_compose_name(child, LED_LT3593_NAME, ":", init_data.name);
+	if (ret)
+		return ret;
 
 	fwnode_property_read_string(child, "linux,default-trigger",
 				    &led_data->cdev.default_trigger);
@@ -160,11 +158,10 @@ static int lt3593_led_probe(struct platform_device *pdev)
 		}
 	}
 
-	led_data->cdev.name = led_data->name;
 	led_data->cdev.brightness_set_blocking = lt3593_led_set;
 	led_data->cdev.brightness = state ? LED_FULL : LED_OFF;
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	ret = devm_led_classdev_register_ext(dev, &led_data->cdev, &init_data);
 	if (ret < 0) {
 		fwnode_handle_put(child);
 		return ret;
-- 
2.11.0

