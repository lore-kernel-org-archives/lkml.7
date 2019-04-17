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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00ABC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF88620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMkgw5VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfDQUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36469 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387675AbfDQUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so19949586lfi.3;
        Wed, 17 Apr 2019 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ttSs43mFUqoRscY9CogQ2WjLkWsV97kHMypR4eJ/Mf8=;
        b=rMkgw5VOVHeRP5oeuEJs3IpFsef182BKNGGufccKJiMxUY3gWd+Qgl1SPJEHQ0C0X/
         bdPHNFy+s5ccLAT7tzT3g8toyPCQOLYQR7mYEUK6hgljnSvEf6tBl8BoLQG724CNthNY
         495Kh1MSVYCvDSUrqCv4Q4H0MuLInWJ4mhRwyWKj3BPRTtnlTyKQ9atY6MUgNMR4/2BQ
         Kl1j/Ba7xs/9a9dFTn4iyEfr/6OWytjg8wpi3rVhFvapNqZDf1kvUY6LHQrtuiPiDT4y
         VblC43Iy/JnoMiFSXxoksINuRLLfEM9ethI8fnjQKhlijDrf29IrwCR8gQG/Cz03fopV
         LdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ttSs43mFUqoRscY9CogQ2WjLkWsV97kHMypR4eJ/Mf8=;
        b=EoAH5Ii6mkF0xoywA+W1vUxXFObd3goZPgnVLrXI6vu+52kfAz1044BepUQ02susrH
         A94fXxJ6/pXZbApH7JKL49FR9tnfuogxXVP9V7VdiuTFqLgEgkMH1/BnHuNrXukdhqvr
         63RX5N/OBo3qp5uEHggIhHaJcu6Gm3L0Yp2sinltI8D5JdkFUBU7K/66xzvX8enGX0YQ
         3wkr5U3V8h+DYqoC+Am4jfRVzkBN/lGPyxJdQaT8GjxQV/TNh+YMLmB2PMeAYgY9SPS/
         5JbWb8JCQE4QtYvQz/cJj71fEwVyoNvjZx0idrVpoDn8JMyMWsPD9EqOR9lsYSZtmnAv
         bhZg==
X-Gm-Message-State: APjAAAV4masq5zma59dVXvx/o4WBndODD1OEgKLuzp0LqoNz2Rre7pOI
        KsZ46ZlVZnlmJ8gE83BvsseLlJfsstU=
X-Google-Smtp-Source: APXvYqySBAMuNTFoqcLwXVyw7Xi57zTe+aBUgza5M+EjOY0bMBNMnbAmSB0AyuWlIdkJ7hJ0RLmwuw==
X-Received: by 2002:a19:7014:: with SMTP id h20mr1069223lfc.158.1555534542019;
        Wed, 17 Apr 2019 13:55:42 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:41 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 26/26] leds: an30259a: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:39 +0200
Message-Id: <20190417205439.17685-27-jacek.anaszewski@gmail.com>
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
Cc: Simon Shields <simon@lineageos.org>
---
 drivers/leds/leds-an30259a.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 1c1f0c8c56f4..c626efa5403c 100644
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
@@ -312,13 +306,20 @@ static int an30259a_probe(struct i2c_client *client)
 	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
 
 	for (i = 0; i < chip->num_leds; i++) {
+		struct led_init_data init_data;
+
 		an30259a_init_default_state(&chip->leds[i]);
 		chip->leds[i].cdev.brightness_set_blocking =
 			an30259a_brightness_set;
 		chip->leds[i].cdev.blink_set = an30259a_blink_set;
 
-		err = devm_led_classdev_register(&client->dev,
-						 &chip->leds[i].cdev);
+		init_data.fwnode = chip->leds[i].fwnode;
+		init_data.devicename = AN30259A_NAME;
+		init_data.default_label = ":";
+
+		err = devm_led_classdev_register_ext(&client->dev,
+						 &chip->leds[i].cdev,
+						 &init_data);
 		if (err < 0)
 			goto exit;
 	}
-- 
2.11.0

