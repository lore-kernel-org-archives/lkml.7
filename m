Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2877214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335161;
	bh=tA7N63A3Y2XUWDydx2+AxIUi/zFZdphvUHYoBS0xL9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ocQY5amF58A9JXI+iubAKtD8XL2CMIZMRu1DGCVayS6cnQke8I4OdPxM+u7s3SQsX
	 01csFRb9Ux/qbWgXBi59pQLv0C+83HTYz9k6BeRwffAk8u+XibpukFOuyyCDmk/lQV
	 nfGIkZE6RvY6PpIbYOR9sqiNdLasFLq6xVEYqszM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfCKUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfCKT4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9898C214D8;
        Mon, 11 Mar 2019 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334165;
        bh=tA7N63A3Y2XUWDydx2+AxIUi/zFZdphvUHYoBS0xL9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJ12NynaUpkxDg88DyQtrCnlC6h7UpevPiN5wg/BqOGgQvglP7yJA5CEJvW8CMiG4
         HqWVIWmeywJqUOdTn/vD62+JMTD65hz46HhIhWxm9y2M/Df4sUW7uwLpDRuRJmb/jg
         pFsm4QQS7wLYdxY8e21Qg4fdynpO1TRZ1TIAitvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 25/52] Input: cap11xx - switch to using set_brightness_blocking()
Date:   Mon, 11 Mar 2019 15:54:49 -0400
Message-Id: <20190311195516.137772-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 628442880af8c201d307a45f3862a7a17df8a189 ]

Updating LED state requires access to regmap and therefore we may sleep,
so we could not do that directly form set_brightness() method.
Historically we used private work to adjust the brightness, but with the
introduction of set_brightness_blocking() we no longer need it.

As a bonus, not having our own work item means we do not have
use-after-free issue as we neglected to cancel outstanding work on
driver unbind.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/cap11xx.c | 35 ++++++++++----------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 312916f99597..73686c2460ce 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -75,9 +75,7 @@
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
 	struct led_classdev cdev;
-	struct work_struct work;
 	u32 reg;
-	enum led_brightness new_brightness;
 };
 #endif
 
@@ -233,30 +231,21 @@ static void cap11xx_input_close(struct input_dev *idev)
 }
 
 #ifdef CONFIG_LEDS_CLASS
-static void cap11xx_led_work(struct work_struct *work)
+static int cap11xx_led_set(struct led_classdev *cdev,
+			    enum led_brightness value)
 {
-	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
+	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
 	struct cap11xx_priv *priv = led->priv;
-	int value = led->new_brightness;
 
 	/*
-	 * All LEDs share the same duty cycle as this is a HW limitation.
-	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
+	 * All LEDs share the same duty cycle as this is a HW
+	 * limitation. Brightness levels per LED are either
+	 * 0 (OFF) and 1 (ON).
 	 */
-	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
-				BIT(led->reg), value ? BIT(led->reg) : 0);
-}
-
-static void cap11xx_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
-{
-	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
-
-	if (led->new_brightness == value)
-		return;
-
-	led->new_brightness = value;
-	schedule_work(&led->work);
+	return regmap_update_bits(priv->regmap,
+				  CAP11XX_REG_LED_OUTPUT_CONTROL,
+				  BIT(led->reg),
+				  value ? BIT(led->reg) : 0);
 }
 
 static int cap11xx_init_leds(struct device *dev,
@@ -299,7 +288,7 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 		led->cdev.flags = 0;
-		led->cdev.brightness_set = cap11xx_led_set;
+		led->cdev.brightness_set_blocking = cap11xx_led_set;
 		led->cdev.max_brightness = 1;
 		led->cdev.brightness = LED_OFF;
 
@@ -312,8 +301,6 @@ static int cap11xx_init_leds(struct device *dev,
 		led->reg = reg;
 		led->priv = priv;
 
-		INIT_WORK(&led->work, cap11xx_led_work);
-
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error) {
 			of_node_put(child);
-- 
2.19.1

