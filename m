Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FFD20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnpySIpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCJS3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfCJS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so2658272wre.10;
        Sun, 10 Mar 2019 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lYXIB4YDm7Y4uW6SA2ZcCIa9sl4O2qH1l9k7CUGBLg=;
        b=SnpySIpV0PUudFpoMhaBfvJ5WY/FUpcob7igbC5FpDUpfKUpcAv/vlwOgZ5zUmZUhl
         MXudXoYhuKCxwOBMNzoOL/pPfceZmcP2I0oLqoxFV4KDN2Jh2CK65/Udg8LNPuIxOk/u
         +mtZFJ4ou5/SycVtF88657+oPNyimB1R+LH5XMTT2ToSFnIGgu+vRn0nuyNZmKOfRxQ0
         3wIxj+qCiYl7FBa9Gdwq1hNL6DYkbdkseCKzkuCTLCf0mXYdgphdOlzMOs+X9M7MI0CK
         5LsOLt8ZB4OknrATzfOTXZ0HCzz3AGXzp/+CGUDd6xPc95cQiwnqJa3LS1zk3/Jo1yPP
         eW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+lYXIB4YDm7Y4uW6SA2ZcCIa9sl4O2qH1l9k7CUGBLg=;
        b=YTgxgZjBVFBhLXQ35PVN9FB3Aye0ARVjPdchhHpZ2MV/WtR7dQSmrLN0+Jfsoyyf3X
         /edBc2aI1kw7r8QtKIk9VHftpkU8Sn8vdylKKPgYGcsYnebbLUTx6hcicYTNspfCRSaA
         m4fcyX3gEcd+jUk134DH9Wr12AtWNH1Pves6U1T0OWcTWkkiFt6kdKiRCvKoCjEV65RT
         l08iBA9NZaJPL3aSfQNAWRLXgmqXJhkOAAuuL9W+74IcI7AuZjiZVJw7odL8YoyDfiTi
         mofJ8dTYAvHEGniVKaupZCABEv14mXBgFjDYoKc4tEbc+BfQnEWWhQJypJtdfTHPo4Yq
         9scQ==
X-Gm-Message-State: APjAAAXdGMHHGhBFGwhr54wV2/CT/EbFCnJh87F/m0+Wm09mEXFcnUov
        cywWwL2yBdST0bEEsVJrDV1cKQE6rbo=
X-Google-Smtp-Source: APXvYqw66rfNOfy7+/ACne4ukOlZ5hRQMvaQx4LHIXM3s2vssZhpajNyFcSQlLiAvv4RcHm52GkFVg==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr13730681wrr.188.1552242567529;
        Sun, 10 Mar 2019 11:29:27 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:27 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 23/25] leds: gpio: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:34 +0100
Message-Id: <20190310182836.20841-24-jacek.anaszewski@gmail.com>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/leds-gpio.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index b26cf78993d1..c2e551cd2fc7 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -77,11 +77,19 @@ static int gpio_blink_set(struct led_classdev *led_cdev,
 
 static int create_gpio_led(const struct gpio_led *template,
 	struct gpio_led_data *led_dat, struct device *parent,
-	struct device_node *np, gpio_blink_set_t blink_set)
+	struct fwnode_handle *fwnode, gpio_blink_set_t blink_set)
 {
+	struct led_init_data init_data = { fwnode };
 	int ret, state;
 
-	led_dat->cdev.name = template->name;
+	if (template->name) {
+		led_dat->cdev.name = template->name;
+	} else {
+		ret = led_compose_name(fwnode, NULL, NULL, init_data.name);
+		if (ret)
+			return ret;
+	}
+
 	led_dat->cdev.default_trigger = template->default_trigger;
 	led_dat->can_sleep = gpiod_cansleep(led_dat->gpiod);
 	if (!led_dat->can_sleep)
@@ -112,7 +120,8 @@ static int create_gpio_led(const struct gpio_led *template,
 	if (ret < 0)
 		return ret;
 
-	return devm_led_classdev_register(parent, &led_dat->cdev);
+	return devm_led_classdev_register_ext(parent, &led_dat->cdev,
+					      &init_data);
 }
 
 struct gpio_leds_priv {
@@ -145,15 +154,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
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
@@ -185,7 +185,7 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		if (fwnode_property_present(child, "panic-indicator"))
 			led.panic_indicator = 1;
 
-		ret = create_gpio_led(&led, led_dat, dev, np, NULL);
+		ret = create_gpio_led(&led, led_dat, dev, child, NULL);
 		if (ret < 0) {
 			fwnode_handle_put(child);
 			return ERR_PTR(ret);
-- 
2.11.0

