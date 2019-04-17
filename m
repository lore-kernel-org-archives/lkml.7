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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00EEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C68220872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBC/2iZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfDQUzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46897 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfDQUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so10989110lfj.13;
        Wed, 17 Apr 2019 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rm88COlT2cnoF6os49j3Jvd4pKwvofIMU8fozSRdyLI=;
        b=DBC/2iZZptXHXV2KZ8RZ63/tKN/1ChMp+uJUaDriq4psEjW+jlI/ZBPRYYO7u3wTOR
         Huh0x/F782FoT4a5B6A2/tIEknTXupQ8ugC5+hFNhexKjIPj3P1jxqhiFJKc5Old02lN
         NePtlPBZbzRWiY8GnmEp5H0MrM9l6t7EfwoIl5VhnotZ6XnaJ8ZByNMwh8NKouE2qe3K
         j05lhR2thTv5MuH7rUv7rXWhJKdCSfmqLJTaW61n0Jss4bSxr0vxIiVqQ7BmmNnEShgA
         NSd2xpimoulguIh2I2Yf/mfwE0jHAR/vZTd8YL1yZGB9kA3tODCVacnvJxBWZp0zeGbj
         K8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rm88COlT2cnoF6os49j3Jvd4pKwvofIMU8fozSRdyLI=;
        b=JWGBMGM0hPgCvX62qUjIZig/cEJaGk+DELYOANMe+i/dsPQjtFijm7s/EoV9WM7OkB
         iPOUQ2Nh63MsLT2hHmydpVIHBeZPry9ClVbHRAa+LfRk2W3sB1EmkTlYyOuqtsJp7e3K
         +Jlc8D1CFGxsSu4lFvUqzwhgfW76DhVbAvjudWq+4Q9hUqCFAkRp6lUUXb7d97YCSZzw
         0psxXG2UdPylzOj+DvMbL8DNrUH1eRedW4H2d90fBaK2psMvhXfb5/CT+JgR2ZF2xNFm
         okBXoiEKx5g6qnMPtdHXEnlyGbKFhpa2snghYKW7MdNiSEMCtNKBHlck2H4FoYd+pPL3
         3p7g==
X-Gm-Message-State: APjAAAWFX4eyybdG1/hj4mjitBp7u+enNfwm6m+jmR3ax8OzrpaIEM9F
        YFtFsza9jZiE6Cb5C/FLinrwj6TThkk=
X-Google-Smtp-Source: APXvYqwtARdgq4jc5lvYu/ca9zQWazr97bskUtzTnjmXHFE/3alFdnlhE17WaJuAa4g1XESm+kAu1Q==
X-Received: by 2002:a19:f60f:: with SMTP id x15mr14235993lfe.95.1555534538350;
        Wed, 17 Apr 2019 13:55:38 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:37 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 24/26] leds: gpio: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:37 +0200
Message-Id: <20190417205439.17685-25-jacek.anaszewski@gmail.com>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/leds-gpio.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index b26cf78993d1..60fb3c85cf05 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -77,11 +77,11 @@ static int gpio_blink_set(struct led_classdev *led_cdev,
 
 static int create_gpio_led(const struct gpio_led *template,
 	struct gpio_led_data *led_dat, struct device *parent,
-	struct device_node *np, gpio_blink_set_t blink_set)
+	struct fwnode_handle *fwnode, gpio_blink_set_t blink_set)
 {
+	struct led_init_data init_data = {};
 	int ret, state;
 
-	led_dat->cdev.name = template->name;
 	led_dat->cdev.default_trigger = template->default_trigger;
 	led_dat->can_sleep = gpiod_cansleep(led_dat->gpiod);
 	if (!led_dat->can_sleep)
@@ -112,7 +112,13 @@ static int create_gpio_led(const struct gpio_led *template,
 	if (ret < 0)
 		return ret;
 
-	return devm_led_classdev_register(parent, &led_dat->cdev);
+	if (template->name)
+		led_dat->cdev.name = template->name;
+	else
+		init_data.fwnode = fwnode;
+
+	return devm_led_classdev_register_ext(parent, &led_dat->cdev,
+					      &init_data);
 }
 
 struct gpio_leds_priv {
@@ -145,15 +151,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		struct gpio_led_data *led_dat = &priv->leds[priv->num_leds];
 		struct gpio_led led = {};
 		const char *state = NULL;
-		struct device_node *np = to_of_node(child);
-
-		ret = fwnode_property_read_string(child, "label", &led.name);
-		if (ret && IS_ENABLED(CONFIG_OF) && np)
-			led.name = np->name;
-		if (!led.name) {
-			fwnode_handle_put(child);
-			return ERR_PTR(-EINVAL);
-		}
 
 		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
 							     GPIOD_ASIS,
@@ -185,7 +182,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		if (fwnode_property_present(child, "panic-indicator"))
 			led.panic_indicator = 1;
 
-		ret = create_gpio_led(&led, led_dat, dev, np, NULL);
+		ret = create_gpio_led(&led, led_dat, dev, child, NULL);
 		if (ret < 0) {
 			fwnode_handle_put(child);
 			return ERR_PTR(ret);
-- 
2.11.0

