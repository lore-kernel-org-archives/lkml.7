Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC6CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6DA20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXU+VZ8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfCaRz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36477 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbfCaRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so8933711wrd.3;
        Sun, 31 Mar 2019 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+WCWEgjBNg9Oyao4gE2JxVTaekNmJfdIUQWTYf4k6Tc=;
        b=VXU+VZ8CYOszT/4OeaXkNZWi17E3pvbWhNDnJjkw4aqnGy/zqRkzJKj4ph8SfPfXkm
         XBgTPYaKSP9J8e666PTaZzFpIzc2kGn0JQIKGFBDbW3xWHcGUOxCUkuuepNZNXab1ppk
         3bmRylk5mUx2xI2Ao/AE4aOos8aluukSCQZ4p4I/L0Ga8qq3+evCcS6Y9XLf1Dy359PK
         A1klHsl9AbX9jlSdXCukiajZ4r9qaSf7C8wfCPYobDNrden97W+LnUqWfhZYx+JmZWVG
         NpBPbz0Q+10RV+FxJJPs4RI2ACBxLhkEuzvGllCEPWg0Wu0I5HMeeULGQjY5igIOCKWi
         y1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+WCWEgjBNg9Oyao4gE2JxVTaekNmJfdIUQWTYf4k6Tc=;
        b=Roe4CeCPhX6heyQU/X+VyXoHpwNehon1KhoiKxUl6Pzq8ih/fl58HKvGarlvGTlVRN
         PfJExt201UkxrL9/3PdAR9uXXINXXBTX1/kSIGyijPUiz8eq1cvDXCnWgCoHQ6wqSBk/
         thKrvDYOCRNmUJf0K8ZpiR2jMQGLTrs/rnXy9khGiIgxiGkcgfLbFSiM+CwvqTtPyxmI
         8xULmmwthZ4hA5WZxBsvQe4e1fjLC6B+/BRGpYo8Pl+fDSXZKbOfV5IIuD5BchhMaKA4
         AEYMp4xAqIuWxkQxMyJAseak1qQWmF4j2wyMpmohXpNjnGdFqUsZvm3EI6dPZaqR59Ax
         jJLw==
X-Gm-Message-State: APjAAAWmFjayN/XuKd2WLPi5SGIHRri8nDfyTt6Bs/tF7dourHgAajtW
        Zh9qJCx950rUrfq3ECuoDLJkzX3hXII=
X-Google-Smtp-Source: APXvYqz+kbqYJatTapoKwEz6oq5Ri3+znlXOm3i9/0dIjEeqoXEEocykx/thiEOecZs5at4rXf4k6g==
X-Received: by 2002:adf:fe03:: with SMTP id n3mr27862485wrr.59.1554054954074;
        Sun, 31 Mar 2019 10:55:54 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:53 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v3 25/25] leds: an30259a: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:55:01 +0200
Message-Id: <20190331175501.23471-26-jacek.anaszewski@gmail.com>
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
Cc: Simon Shields <simon@lineageos.org>
---
 drivers/leds/leds-an30259a.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index 1c1f0c8c56f4..0659baddb39b 100644
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
+		init_data.led_hw_name = AN30259A_NAME;
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

