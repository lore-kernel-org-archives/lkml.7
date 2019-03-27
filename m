Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCBD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fBCn0n2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbfC0XRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59018 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0XRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728654; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GkICgK8vBLcuX0i49vbljswblHjkddWYl4PLQNv7YN4=;
        b=fBCn0n2kr2zKU+fYHSy5pOAEVW5H1+Z8POU4Iedav/d33XjWF7EkWJ0I6Ww3f04a/Lt15L
        5l/GlIMhZkk9Dlez0weEgBb1s8dqcuMFZNUYT5WfMovwHML1KFwBy9L0zRqab9x0t3tAIj
        XNVfmx1UlnLdJtqmsmuryOdvkKUn9BA=
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
Subject: [PATCH v11 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date:   Thu, 28 Mar 2019 00:16:18 +0100
Message-Id: <20190327231631.15708-15-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.

The new algorithm will compute the maximum frequency at which the clock
can run for the given period/duty parameters, and use clk_set_max_rate()
to ensure that we will always compute period/duty values that fit in our
16-bit register fields.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/pwm/pwm-jz4740.c | 51 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 1a0eab0abafe..b55ee879e23d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -108,24 +108,47 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = pwm_get_chip_data(pwm),
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
+	int ret;
 
-	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	parent_rate = clk_get_rate(parent_clk);
+
+	jz4740_pwm_disable(chip, pwm);
+
+	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
+	ret = clk_set_rate(clk, parent_rate);
+	if (ret)
+		return ret;
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	/*
+	 * Limit the clock to a maximum rate that still gives us a period value
+	 * which fits in 16 bits.
+	 */
+	tmp = 0xffffull * NSEC_PER_SEC;
+	do_div(tmp, state->period);
+
+	ret = clk_set_max_rate(clk, tmp);
+	if (ret) {
+		dev_err(chip->dev, "Unable to set max rate: %i\n", ret);
+		return ret;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	/*
+	 * Read back the clock rate, as it may have been modified by
+	 * clk_set_max_rate()
+	 */
+	rate = clk_get_rate(clk);
+
+	if (rate != parent_rate)
+		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
 
+	/* Calculate period value */
+	tmp = (unsigned long long)rate * state->period;
+	do_div(tmp, NSEC_PER_SEC);
+	period = (unsigned long)tmp;
+
+	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
 	duty = period - tmp;
@@ -133,8 +156,6 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty >= period)
 		duty = period - 1;
 
-	jz4740_pwm_disable(chip, pwm);
-
 	/*
 	 * Set abrupt shutdown.
 	 *
@@ -144,8 +165,6 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	clk_set_rate(clk, rate);
-
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-- 
2.11.0

