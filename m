Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF7DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744B218AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Zl4qQ3/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfIHUhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:37:20 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:33294 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729230AbfIHUhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fNJRiTsyDxjrEnQ50hBd8V4TRodHhVtOX3D2dnRGh6U=; b=Zl4qQ3/c4bdZqDPUnab9jcHbmk
        eS8vOSMg1SlvMJ9mmyb41bVnb8r8VvhQNwadgQhVIO3PAl015xgzPm0lrSnkZDJZym5QDD3U31e8i
        I4482ByZXavOa84eKpp0R3BxL2774bWLXw0SoESbig7f52zKFB7lUDiAMlTsu3BU/7kI=;
Received: from p200300ccff4729001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff47:2900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i73vo-0000wP-Ro; Sun, 08 Sep 2019 22:37:09 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1i73vo-0007rQ-HL; Sun, 08 Sep 2019 22:37:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] backlight: lm3630a: add an enable gpio for the HWEN pin
Date:   Sun,  8 Sep 2019 22:37:03 +0200
Message-Id: <20190908203704.30147-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908203704.30147-1-andreas@kemnade.info>
References: <20190908203704.30147-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now just enable it in the probe function to allow i2c
access and disable it on remove. Disabling also means resetting
the register values to default.

Tested on Kobo Clara HD.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/video/backlight/lm3630a_bl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index b04b35d007a2..3b45a1733198 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -12,6 +12,8 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
 #include <linux/pwm.h>
 #include <linux/platform_data/lm3630a_bl.h>
 
@@ -48,6 +50,7 @@ struct lm3630a_chip {
 	struct lm3630a_platform_data *pdata;
 	struct backlight_device *bleda;
 	struct backlight_device *bledb;
+	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
 	struct pwm_device *pwmd;
 };
@@ -506,6 +509,14 @@ static int lm3630a_probe(struct i2c_client *client,
 		return -ENOMEM;
 	pchip->dev = &client->dev;
 
+	pchip->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
+						GPIOD_ASIS);
+	if (IS_ERR(pchip->enable_gpio)) {
+		rval = PTR_ERR(pchip->enable_gpio);
+		return rval;
+	}
+
+
 	pchip->regmap = devm_regmap_init_i2c(client, &lm3630a_regmap);
 	if (IS_ERR(pchip->regmap)) {
 		rval = PTR_ERR(pchip->regmap);
@@ -535,6 +546,10 @@ static int lm3630a_probe(struct i2c_client *client,
 	}
 	pchip->pdata = pdata;
 
+	if (pchip->enable_gpio) {
+		gpiod_set_value_cansleep(pchip->enable_gpio, 1);
+		usleep_range(1000, 2000);
+	}
 	/* chip initialize */
 	rval = lm3630a_chip_init(pchip);
 	if (rval < 0) {
@@ -586,6 +601,9 @@ static int lm3630a_remove(struct i2c_client *client)
 	if (rval < 0)
 		dev_err(pchip->dev, "i2c failed to access register\n");
 
+	if (pchip->enable_gpio)
+		gpiod_set_value_cansleep(pchip->enable_gpio, 0);
+
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
 		flush_workqueue(pchip->irqthread);
-- 
2.20.1

