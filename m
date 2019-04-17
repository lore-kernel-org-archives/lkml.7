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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E677C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDDF20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMfOFpji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfDQU42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:56:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35493 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387565AbfDQUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id t4so15251026ljc.2;
        Wed, 17 Apr 2019 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2K+0bdWhbREWBqUMXly+Sarrig5nBippGvNEs92SKAk=;
        b=gMfOFpjiI3+aTvndmzrCFiE13L1QNh//xCFkcp6Np0SdqWz3b44FzPsbB4XHDsq/jH
         Tc7W0wtLyvg2pXHF0sCcjkhnZf3SmNv2mWtsv1KAx+tS6/Mr49w+uZd4EIvbNZREb5jJ
         RPmCWTdZV9cUoZNY3nSoeUwd9NJUJGWIMC8TYYASfxzpaCJtMmHyOVgHFtroSc39qJ7N
         QrsfFh2zZ/5J9fl270P3YRz1AzQ+4wVfC58fAQ9mHg36dyHou8spHZeySkMAs7E8pe85
         VFNB5PKb4GcEVHKlSx6DECeQUh3u2mJO2E2F82JqAGdbmk0F69GwgE1qgAwWqV+IBi2L
         A0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2K+0bdWhbREWBqUMXly+Sarrig5nBippGvNEs92SKAk=;
        b=GDsNRPM5KHm0Xbdaxlzq2Opzg72ZVno3qyRA5syd3K2n5iNre7H1LdfyYCGSl2NAGx
         w839knDU861y3uONzngsRhXBB5+ph9PVhnvrxXhvWz/+Cqehv5NstIvqJSVWRQhbMVaL
         Dzowro9tmQvL8qDwUUXsY7hJUmPRnMvModwieux0ZC6sSENc7srEKnyvhBapFvOGcqNh
         VQxD2wtpHlG1rlcrkccuDOQ8cJCsdBac1EZaFDQ6CenD5x+RfWcPiBCjKtIAgMRvpieU
         z3hWJ/qu+YVR7cix4Agg9lYJWCgSdWzFFrwnhF2Qp13GV29e8bvEWVEuFFF56WngL2aZ
         koaw==
X-Gm-Message-State: APjAAAWk+/e2hpLSSF2wl9aR+mrPRz5dfTQwB4KUgOFQRpViQ460ClvK
        U7ldKo7XZYxcGta+0MGvGNIcDwIqXyw=
X-Google-Smtp-Source: APXvYqzIaBMbbFmUB/eQ0AxIW0txxSn8plXG7v+K3KZOan5UKqiEybOYzCYMqjVo2xkudZCSFrpfWg==
X-Received: by 2002:a2e:390c:: with SMTP id g12mr48489404lja.174.1555534527441;
        Wed, 17 Apr 2019 13:55:27 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:26 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH v4 18/26] leds: cr0014114: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:31 +0200
Message-Id: <20190417205439.17685-19-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-cr0014114.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 1c82152764d2..1b05456ee267 100644
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
+		init_data.devicename = CR_DEV_NAME;
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

