Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5185C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29812192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255952;
	bh=iwxSt1EW6xsFMy3sR3ka9Z3ZjvACjccmDDT3wNwIUmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MvurGmMbilAwuUXK4qn9YFkBE+O+IFS4rhKGao+I2hZlLIEqRdKjiSTYlXlA1NLMM
	 +NhEFCwqtTPBpJDqY7MGomKo7y3kSJOtDHU+zC0sZtzJc7xyvaYZl/xa2eYN9iqsnU
	 VhrV6CeURYW7GCbDfhY1LPGtUJehFfYx4sip2c8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbfCVL7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387510AbfCVL7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B0520830;
        Fri, 22 Mar 2019 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255948;
        bh=iwxSt1EW6xsFMy3sR3ka9Z3ZjvACjccmDDT3wNwIUmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNPgp4T245UvJUP19ZPbFvc8Ydrr3qrVMGggHESK4kpdbtTyCDn0EygiYeOgs7+n6
         kYaY6Q+YRIKvR5xhUMgQ2D0yH3DsUEEgjSNmeOvnQSuyJwwF7+B9xOka/DurqYdWTr
         BLfHum0ccP0NOA+KRTj+OjW8z8xQcbOv9SFO0raA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Van Asbroeck <thesven73@gmail.com>,
        Sven Van Asbroeck <TheSven73@googlemail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/280] Input: cap11xx - switch to using set_brightness_blocking()
Date:   Fri, 22 Mar 2019 12:13:18 +0100
Message-Id: <20190322111308.850090285@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



