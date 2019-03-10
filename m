Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124C120657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBFyf27a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCJSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34085 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfCJS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so2682510wrg.1;
        Sun, 10 Mar 2019 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tg37H4PlN/bqdOccnQeO0dT/TNj/gqtm00niLZ/0McY=;
        b=pBFyf27av//ewdxrpZay4wz6ZRftzYpvTjHAV7zFSTOnfyp8gVaUR6jR/GbwSCmFB3
         7d//uNiCNhTO5YNce6s7tLlgQa/Na4vaYD+drq/ysybSV9IgFI3tf5bqAWU0rr54N/OD
         LdP5BRyj61hpEi+Cyat2gcjEwK2wLRhJOpmMtHwpNiRw9RjfZZmJ7QwSYxKiVNbCm7F+
         IqXy9SWJlEmBDF0Z5NmJrONSzu/d67xazpDJtHhB8Mc+vbwDhLd2X40M1KkBi5A16zAP
         2ewATJAyysFiX1Zf12J2e8S9eChezeJpx50EvE6Ij6nv3Qk5/PQzPGRbTS5Ra+tkVnCS
         kQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tg37H4PlN/bqdOccnQeO0dT/TNj/gqtm00niLZ/0McY=;
        b=KKtHrISIF7dlrCyprYr5LpUMjlELpq0MIFGG8Dmo68Wk+UhakTkCUs5S2HPMEXzEHW
         J22gh6x+4EfJjiJBwJByIsUwkXscJHxiRO49LJnFhJHVtXcGpq287Zr5Ga75V/scQnTL
         v6HID+y8LnubEYEhNy4unXQb2GwcwZkJibbalzgYwicPUfOpW9YGWcjtYiO/ZCqoIbOW
         YW1n9VDH52RfuPKK2VYUFYSkXfkT2gecKPTIUIuK+AZbBxtLZc8QVU65rC4lL2rsmfSr
         zlNRk34HvNM0uBy1uqqVJO0ijX5XYjJkhDHjO/sS6kAvnMvc2CwLAfRqTIUCvSn1uSYe
         b+1g==
X-Gm-Message-State: APjAAAUA6gVnKf2KFtRxoe2OTrvaFCBRIbuv19RayP0bs5RG1QWZTzP0
        kUycG8tHRTmdDYU6264t+Zq9+d9TuUE=
X-Google-Smtp-Source: APXvYqytADsc1ODQ033QSnr4XTOfJLIpWzKA/qCTMmcO3ee0a4kdGE4ZysPHRsZOpGF5aLrZdkMWDA==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr19360833wrw.245.1552242559413;
        Sun, 10 Mar 2019 11:29:19 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:18 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 17/25] leds: cr0014114: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:28 +0100
Message-Id: <20190310182836.20841-18-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-cr0014114.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 1c82152764d2..0aee979b048f 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -8,7 +8,6 @@
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <uapi/linux/uleds.h>
 
 /*
  *  CR0014114 SPI protocol descrtiption:
@@ -40,8 +39,9 @@
 #define CR_FW_DELAY_MSEC	10
 #define CR_RECOUNT_DELAY	(HZ * 3600)
 
+#define CR_DEV_NAME		"cr0014114"
+
 struct cr0014114_led {
-	char			name[LED_MAX_NAME_SIZE];
 	struct cr0014114	*priv;
 	struct led_classdev	ldev;
 	u8			brightness;
@@ -167,8 +167,7 @@ static int cr0014114_set_sync(struct led_classdev *ldev,
 						    struct cr0014114_led,
 						    ldev);
 
-	dev_dbg(led->priv->dev, "Set brightness of %s to %d\n",
-		led->name, brightness);
+	dev_dbg(led->priv->dev, "Set brightness to %d\n", brightness);
 
 	mutex_lock(&led->priv->lock);
 	led->brightness = (u8)brightness;
@@ -183,41 +182,33 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
 	size_t			i = 0;
 	struct cr0014114_led	*led;
 	struct fwnode_handle	*child;
-	struct device_node	*np;
+	struct led_init_data	init_data;
 	int			ret;
-	const char		*str;
 
 	device_for_each_child_node(priv->dev, child) {
-		np = to_of_node(child);
 		led = &priv->leds[i];
+		init_data.fwnode = child;
 
-		ret = fwnode_property_read_string(child, "label", &str);
+		ret = led_compose_name(child, CR_DEV_NAME, ":", init_data.name);
 		if (ret)
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114::");
-		else
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114:%s", str);
+			return ret;
 
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led->ldev.default_trigger);
 
 		led->priv			  = priv;
-		led->ldev.name			  = led->name;
 		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
 		led->ldev.brightness_set_blocking = cr0014114_set_sync;
 
-		ret = devm_led_classdev_register(priv->dev, &led->ldev);
+		ret = devm_led_classdev_register_ext(priv->dev, &led->ldev,
+						     &init_data);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to register LED device %s, err %d",
-				led->name, ret);
+				"failed to register LED device , err %d", ret);
 			fwnode_handle_put(child);
 			return ret;
 		}
 
-		led->ldev.dev->of_node = np;
-
 		i++;
 	}
 
-- 
2.11.0

