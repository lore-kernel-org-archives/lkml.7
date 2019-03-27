Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF314C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61712173C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TiV1J3Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfC0XRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58926 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0XRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728649; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=el5zc9kKHl8yaJaBUzXwPG3gnMwu3m5CekGe8tBw7AQ=;
        b=TiV1J3TgUfNZV0Yb8/EMrLwshPAnn8QfkbtZDlR4rKOFvBdAVeQd8NbvMTGTurv3BHCtL2
        cqNIUY2hM1LmVn6Pgjb1ZOwo7kpGVx+jD9TaKNEO0IzVdT1iKjblMsak17ruEnA2nJ5OtB
        aRg6fPkICxE8DrBNQgNOs6Ghxh4ZlkQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 12/27] pwm: jz4740: Use regmap from TCU driver
Date:   Thu, 28 Mar 2019 00:16:16 +0100
Message-Id: <20190327231631.15708-13-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ingenic-timer "TCU" driver provides us with a regmap, that we can
use to safely access the TCU registers.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/pwm/Kconfig      |  1 +
 drivers/pwm/pwm-jz4740.c | 79 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 54f8238aac0d..a4abb7417d63 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -213,6 +213,7 @@ config PWM_IMX27
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
+	select REGMAP
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index b2f910413f81..144e2a54aa59 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -17,18 +17,19 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
+#include <linux/mfd/ingenic-tcu.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
-
-#include <asm/mach-jz4740/timer.h>
+#include <linux/regmap.h>
 
 #define NUM_PWM 8
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
+	struct regmap *map;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -38,6 +39,8 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
 	 * for use as PWMs.
@@ -45,42 +48,44 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	jz4740_timer_start(pwm->hwpwm);
+	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
 
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
-	jz4740_timer_stop(pwm->hwpwm);
+	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
-	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
-	jz4740_timer_enable(pwm->hwpwm);
+	/* Enable PWM output */
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
 
+	/* Start counter */
+	regmap_write(jz->map, TCU_REG_TESR, BIT(pwm->hwpwm));
 	return 0;
 }
 
 static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
 	/* Disable PWM output.
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_EN, 0);
 
 	/* Stop counter */
-	jz4740_timer_disable(pwm->hwpwm);
+	regmap_write(jz->map, TCU_REG_TECR, BIT(pwm->hwpwm));
 }
 
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -90,7 +95,6 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long tmp;
 	unsigned long period, duty;
 	unsigned int prescaler = 0;
-	uint16_t ctrl;
 
 	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
 	do_div(tmp, 1000000000);
@@ -113,26 +117,42 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	jz4740_pwm_disable(chip, pwm);
 
-	jz4740_timer_set_count(pwm->hwpwm, 0);
-	jz4740_timer_set_duty(pwm->hwpwm, duty);
-	jz4740_timer_set_period(pwm->hwpwm, period);
+	/*
+	 * Set abrupt shutdown.
+	 *
+	 * TODO: test the hardware with this bit disabled, as shutting down
+	 * abruptly is not desired.
+	 */
+	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
+
+	/* Set clock prescale */
+	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PRESCALE_MASK,
+			   prescaler << TCU_TCSR_PRESCALE_LSB);
 
-	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
-		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
+	/* Reset counter to 0 */
+	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	/* Set duty */
+	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
 
+	/* Set period */
+	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
+
+	/* Set polarity */
 	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
-		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+				   TCU_TCSR_PWM_INITL_HIGH, 0);
 		break;
 	case PWM_POLARITY_INVERSED:
-		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+				   TCU_TCSR_PWM_INITL_HIGH,
+				   TCU_TCSR_PWM_INITL_HIGH);
 		break;
 	}
 
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
-
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
 
@@ -149,8 +169,9 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
+	struct device *dev = &pdev->dev;
 
-	jz4740 = devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
+	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
@@ -158,7 +179,13 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(jz4740->clk))
 		return PTR_ERR(jz4740->clk);
 
-	jz4740->chip.dev = &pdev->dev;
+	jz4740->map = dev_get_regmap(dev->parent, NULL);
+	if (!jz4740->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
+
+	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
 	jz4740->chip.base = -1;
-- 
2.11.0

