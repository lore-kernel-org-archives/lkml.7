Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74537C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4824D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwDjOih/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbfCaRzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:40 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43155 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfCaRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:37 -0400
Received: by mail-wr1-f46.google.com with SMTP id k17so8883115wrx.10;
        Sun, 31 Mar 2019 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BsQo8AOYpDVpGathPBiCfHPesWRgzTIH9gXVmakoW0Q=;
        b=gwDjOih/POCQhUpF4Bcslvpxk4dVZueIKfnHjR3bdMvlurGOu30imoBRh5cbRT5U/a
         EmGQkVcOzXkLMLAJcs4WeUPk7wIaGqH6b6PEYHVqxEmjxgbCu7aSg3Lu8+F5yO94ZZnu
         +TTPCi/On3nlnvSQTbuvjwhO9mbNV+7OhwfVX0936lL7w/MypiF6X5pgO91he2NQC+qJ
         DSk4QdOwwzmr91Nz1xnyDZLelkhFM1iDIkIQD2aHKk3CPqcNDKBi4oPCWw3KUoAELdBC
         CsOpVsodaSp3aG7ffr526tzctfNi2LvRv20Nq20CIjGZ43RS3H/IZTXl4BotVrtCUccv
         w8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BsQo8AOYpDVpGathPBiCfHPesWRgzTIH9gXVmakoW0Q=;
        b=jnAaE2pnzodkgkVeZa60F8Hqntpj5Nu1aIbhiu0E9b0eqASp3doXWeJ0N4xbc+WjOk
         nSchB6cjOt5QA9OrwqppbtudEdTBmmNw4yLZ79nl377ajvvXYg55csxrNUAPlnw63zt6
         a1dSHcJCVqXF7Pk8/6n70S3cSv3F++msKm3LQ/5sqFW9hcvF0hj/FTjEDOpire8ytiDO
         ZAaE381NEsORiPxHT+CQCQdfh/smQz72kdm7lRwsgZ2D1Pik0du2AuAMUr/mb1X//UCe
         fgx/c7IV4inG668qviNUOcnXq1WA+O7tm3y/J4Wf8SVfiE0hBrebBeGp1xgk3WEOIxff
         BdKA==
X-Gm-Message-State: APjAAAWWbknKtdt+tmS/SW6xREpKVWm6wpZ4VqE2my4qKMOdj5iynUp0
        Tuu7bXK+RszVoZEIBQnzWieg0HN3+Ms=
X-Google-Smtp-Source: APXvYqx0GPtbnI3pMbyUupgdnPvudKBLQ8EXFXQH0MaIXLfWmCrkRoEwhbzQu2bDucsUOKDaf2Te7Q==
X-Received: by 2002:adf:e510:: with SMTP id j16mr36244393wrm.259.1554054934696;
        Sun, 31 Mar 2019 10:55:34 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:33 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 13/25] leds: lm3692x: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:49 +0200
Message-Id: <20190331175501.23471-14-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 4f413a7c5f05..d2b30074d87a 100644
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
+	init_data.led_hw_name = led->client->name;
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

