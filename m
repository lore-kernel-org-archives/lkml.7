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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41950C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113702084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+CnZ2zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfCJS3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38173 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfCJS3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so2674577wrm.5;
        Sun, 10 Mar 2019 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pkqGDpmkVPFNDWyaBj0ikJkJ8vB3SYx3bkaTDNEKdpo=;
        b=J+CnZ2zhkkkbFjn2n/mTVwcGReZ+c43Rg/DLZkTnU820/0sPWRAZl8Jj6vsBfJTdH3
         mL/veqfMNRaCLzGi2bgn55s21N6GjjDqOx8bl7Us4eNKKFXTErDbr8qx/srSdgDZJeCh
         XODzMJyYOZqesK+7vUpFaKMnZU5jsr1BgCHf4PaoQ0CyXn3y1sX1U24lbIiIixaB8yIY
         ee0hWlUIq7M9xTftewdbhdwQ8R+koG/fn+vW98xZfB4hiGKkTNTjENTtx1sT5ctmt9ym
         fUQftbTNh/qflgrBg0UmA5zHK3UhNK3mbylnCLXC9GKiyOcMyAArt2MS3LHkgTZ/L9uv
         wqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pkqGDpmkVPFNDWyaBj0ikJkJ8vB3SYx3bkaTDNEKdpo=;
        b=iXjXp3u1ZwV8pGqbeJW397RwcRllRtAlxfAi5ABkegoqrbWOXXpEeJ0bcXc1fftyNx
         8FPH8yztX9epadUxbDaJPbGNGldqQd8irKqIxFyxl/Z5PSnPlbfwYbZYiul5NgbPJ3g7
         aCP9XJf26BEzZ9w6qNclzK6H+hi2Z+y8YyZ7yyxW/+yS+O7TDJsJ544cNLnbAYMXLEIx
         DNq1UXQT8e9DEcSm0TIn12lodS+rfCDj6vg+UJ6dT4l0/QVZU09uOhEzp36b4YjGF7WD
         N0ucvxMGW6600Zr2wMHO3vg/TGR5Tb89IlfEsaORTu8B4M4jsOe2LlCFHsRqSIGEsICD
         8Uig==
X-Gm-Message-State: APjAAAUubqGP2gRdxDKegG1GKYCrH7ORdIZMUKwtNrbojhwpZcYpTtsJ
        rRX+mvyIpGa5qv1z4zknii8cs2XY1TQ=
X-Google-Smtp-Source: APXvYqzC44Cg4e/B55n9EL+Q7RrU35sfj+gSCQib1gRFP5J2EP2MXZ3wONtuylSK6x71yD+dpcwf7Q==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr18464549wrm.262.1552242570037;
        Sun, 10 Mar 2019 11:29:30 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:29 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 25/25] leds: an30259a: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:36 +0100
Message-Id: <20190310182836.20841-26-jacek.anaszewski@gmail.com>
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
Cc: Simon Shields <simon@lineageos.org>
---
 drivers/leds/leds-an30259a.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 1c1f0c8c56f4..d714ee8322c0 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-#include <uapi/linux/uleds.h>
 
 #define AN30259A_MAX_LEDS 3
 
@@ -54,6 +53,8 @@
 #define AN30259A_BLINK_MAX_TIME 7500 /* ms */
 #define AN30259A_SLOPE_RESOLUTION 500 /* ms */
 
+#define AN30259A_NAME "an30259a"
+
 #define STATE_OFF 0
 #define STATE_KEEP 1
 #define STATE_ON 2
@@ -62,11 +63,11 @@ struct an30259a;
 
 struct an30259a_led {
 	struct an30259a *chip;
+	struct fwnode_handle *fwnode;
 	struct led_classdev cdev;
 	u32 num;
 	u32 default_state;
 	bool sloping;
-	char label[LED_MAX_NAME_SIZE];
 };
 
 struct an30259a {
@@ -226,14 +227,7 @@ static int an30259a_dt_init(struct i2c_client *client,
 
 		led->num = source;
 		led->chip = chip;
-
-		if (of_property_read_string(child, "label", &str))
-			snprintf(led->label, sizeof(led->label), "an30259a::");
-		else
-			snprintf(led->label, sizeof(led->label), "an30259a:%s",
-				 str);
-
-		led->cdev.name = led->label;
+		led->fwnode = of_fwnode_handle(child);
 
 		if (!of_property_read_string(child, "default-state", &str)) {
 			if (!strcmp(str, "on"))
@@ -312,13 +306,21 @@ static int an30259a_probe(struct i2c_client *client)
 	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
 
 	for (i = 0; i < chip->num_leds; i++) {
+		struct led_init_data init_data = { chip->leds[i].fwnode };
+
+		int ret = led_compose_name(init_data.fwnode, AN30259A_NAME, ":",
+					   init_data.name);
+		if (ret)
+			return ret;
+
 		an30259a_init_default_state(&chip->leds[i]);
 		chip->leds[i].cdev.brightness_set_blocking =
 			an30259a_brightness_set;
 		chip->leds[i].cdev.blink_set = an30259a_blink_set;
 
-		err = devm_led_classdev_register(&client->dev,
-						 &chip->leds[i].cdev);
+		err = devm_led_classdev_register_ext(&client->dev,
+						 &chip->leds[i].cdev,
+						 &init_data);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.11.0

