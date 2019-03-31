Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917B6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E6B20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSXara/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfCaRz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56183 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbfCaRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so7792850wmf.5;
        Sun, 31 Mar 2019 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rm88COlT2cnoF6os49j3Jvd4pKwvofIMU8fozSRdyLI=;
        b=IKSXara/EaM+USXJ2NXZMPlmxuVnU4hgxsUuYM9/hodmlAJWN2AFVpB9FLC+74teqk
         U3lMRt8JK5eC8G6WENl3K0tEYA39srypTZk5h2+H7nTUHzpHHca2cvdxrCyph8/9YAfO
         NzjyR7VFDvm3KC9M8MuyMToWKWaGMXSB6Js+lSVaTBtFE9QksdF2lMEG+79ZzeBAsW+G
         8XSvDGU7yRSR4Dim1TJSNoRXAzcnpm8hbmFEedbDc/6BUzYN9o6kn6dqFKh+gaOsYRT8
         uavWovr9j1QS+dgpTvPhDrQ+cRX/W8vSRtFi7vbOeqq/vG/ByRyhWUQtqgIryRh+mddr
         KdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rm88COlT2cnoF6os49j3Jvd4pKwvofIMU8fozSRdyLI=;
        b=RixQY4TBVq4S+g9JSrC9q3DOBiHZGUoEnpgPgBjIvzOvtZhUIQmTp9aJKVs+brG2Xm
         MiE8ew6Ql7qpwgrV05iaIi3boflchRNmJ2Jc6ZuBZaQyRE+0zpU7LdkEiy4VRXnfdrHW
         98OZslvLuko5bisNx4bJ2b13HlyNuVdVbLRaZJmifineLFj0zg5B/HJjpwC8P6WOJ4HM
         wyD3meNcOfjn5txHN5hgs1440rY5TnZPylfozOZ9H+ihm6Hp8oQLH6kSJeYBG3WbMamn
         fLBisWcYgJvGEAFVCs5zGSFrOowW9CbTiL9xMcw3xx8McLFAwkRfbxO/LOQjp9No1TQG
         jPpw==
X-Gm-Message-State: APjAAAVI/sj2KpKfTTrI+WRfgYdKvQXz/kWp5X83mAkfr97tCkOq0a3d
        MEqAAQiTxmoObWXnnEBszuyXXYAZljc=
X-Google-Smtp-Source: APXvYqwxq7UZjE/bXB4BcTXetdEeAEh3WoZb/CsI8xjtRj8K/GR7dlKvMeElGjZKeSOBgXVRMtbJ1w==
X-Received: by 2002:a1c:244:: with SMTP id 65mr4513811wmc.42.1554054950742;
        Sun, 31 Mar 2019 10:55:50 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:50 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 23/25] leds: gpio: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:59 +0200
Message-Id: <20190331175501.23471-24-jacek.anaszewski@gmail.com>
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

