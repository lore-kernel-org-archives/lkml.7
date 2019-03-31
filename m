Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A53A20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r18b1FWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfCaR4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50886 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbfCaRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so7873259wmi.0;
        Sun, 31 Mar 2019 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i48o7umsfgsnIadIeOH6ATSiX7UaI2YtQvgZAcvv5P0=;
        b=r18b1FWLa/c5M3xobQUkgbU/FPsmMeHw/7nVCOkp65u1KjKvcxFLmGDDyKzcIBuklq
         ORol5fXsktY/5mvK6kkQtGUSxgycgjg84XJixj/uiAZl6PQ+Iz45pBH7v9Ox3vzf8yqV
         Id7XddvSObA0JmjYvGaxqgZzGOKlvo+zzMnh72mgAjWLbXUH9PGWEipBvvTWfwV/oget
         gVff8YMfeMC5XJWysCYVq1IFdlUFwBHcwCONRDcHO6NJ6YDAiPNpAECPMe3LNx/Tk21W
         eDmAl483OYU7ZviXoxy4RiBZnwYSR13jO79TYC+oUTpSjVpNAezua/BvwV/JNMDzs5q8
         l08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i48o7umsfgsnIadIeOH6ATSiX7UaI2YtQvgZAcvv5P0=;
        b=AxwUejEkXS7qFyPQSsYtZI+uzjWfF626g3EnktNwgG7XtHZnUDxtT0FwIuu5fuHKc8
         ioDH423MaYSNZb8VNxfx34KSs8z24nnrfkjDaEr1tzI5VuM3mVVd38HVmAKttQ4M6mSr
         7VIhiJ7s5tgLddz8l71l9YVsbz18AwzVXmNPAwqb0sFV3kgvgpKXexzjgdl3UipJUTZM
         Uq2LoBA9XeUz361hyzuxyph854OGUmj6H8JHjRJejFm78SxwtESdWAV0gEVt4Bte0LXb
         6aJ0RiL3E8+vh0fw6dDCB1BhQQQ8yVcMhsKo4nfsPkK54R4aAFubBpZDgV+/eFLqU268
         oYdQ==
X-Gm-Message-State: APjAAAXCRe/scIHcv5KE7RM+k8lbqy+0yb0UDCyi/LIwm0BGgP4oURTD
        t/dDi+ykfzdE2DEBN36W0N9tLCYXY6I=
X-Google-Smtp-Source: APXvYqxgDuCZL7OCXNphjoHz0NZ1iwLRUvct3Tmfsz0v8VbwHgsOTljbuYM6ITnTuXVbiUQltT78Lw==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr9785736wml.34.1554054941041;
        Sun, 31 Mar 2019 10:55:41 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:40 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH v3 17/25] leds: cr0014114: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:53 +0200
Message-Id: <20190331175501.23471-18-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-cr0014114.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 1c82152764d2..08c8946519eb 100644
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
@@ -183,41 +182,32 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
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
 
-		ret = fwnode_property_read_string(child, "label", &str);
-		if (ret)
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114::");
-		else
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114:%s", str);
-
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led->ldev.default_trigger);
 
 		led->priv			  = priv;
-		led->ldev.name			  = led->name;
 		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
 		led->ldev.brightness_set_blocking = cr0014114_set_sync;
 
-		ret = devm_led_classdev_register(priv->dev, &led->ldev);
+		init_data.fwnode = child;
+		init_data.led_hw_name = CR_DEV_NAME;
+		init_data.default_label = ":";
+
+		ret = devm_led_classdev_register_ext(priv->dev, &led->ldev,
+						     &init_data);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to register LED device %s, err %d",
-				led->name, ret);
+				"failed to register LED device, err %d", ret);
 			fwnode_handle_put(child);
 			return ret;
 		}
 
-		led->ldev.dev->of_node = np;
-
 		i++;
 	}
 
-- 
2.11.0

