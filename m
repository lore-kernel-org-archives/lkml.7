Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72681C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429182064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334365;
	bh=i7ZXanO/d+ZKmAMK18gGBCkdhPyOyyDagBhJj02KJKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMwn38u4RZQpNPTB+CJckjhDxlGyxZjuA/Ow2P3yqrSKWEtd64Vmi3a0h1/vkrH02
	 Hd7p5CdhHXMY6ke2OrfXUXaa/+XzsF5m9QQnJYikf4L/bKNqm+I3NAQIlSqdFCa59m
	 e2y4clVQsJtkgkHw8MwV+dqx5oIN/h5qODvUE0iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfCKT7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfCKT7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A118C2087C;
        Mon, 11 Mar 2019 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334360;
        bh=i7ZXanO/d+ZKmAMK18gGBCkdhPyOyyDagBhJj02KJKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLQxo0gVOUJnsCClIRYzx8NFP7GKIFNEnnEmTaVWWT7Qp53/eDtwjjY9ds97pKdxW
         hpo8sgvcD7NijsSu5WsslJ52m7yGkQnUCQ8oRXT/F884tRGMixl14kM1KYiRyuXgFJ
         71tB7/rrnA3tycxqz0MPj7MnneSHdDuKhrZMtuvg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/12] Input: cap11xx - switch to using set_brightness_blocking()
Date:   Mon, 11 Mar 2019 15:59:05 -0400
Message-Id: <20190311195912.139410-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195912.139410-1-sashal@kernel.org>
References: <20190311195912.139410-1-sashal@kernel.org>
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
index 4401be225d64..3c53aa5d5c0c 100644
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

