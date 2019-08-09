Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D39C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C8321783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="U4wFMiiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406922AbfHIMbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:31:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55846 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406900AbfHIMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565353852; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCxXdaQu4lhuJCLZ4IbpQ5mBJdm8h+q/u3Hs4ncJ21U=;
        b=U4wFMiiOp3rkARE3UX8N8JdgipYOTsWjf0qzaEWScdM1c/t0O9ULZw6GB3Yy48AelC2UP0
        7F/mnlIPKYqit3Ag5uSOoWzxGdYqJ9F27BOszTqjMYVa2MmwbdkM3QJzaG5+d/97gPAeJ1
        PnLgELtgd7wTY+4QSSGEZf2vO0i/l8k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Date:   Fri,  9 Aug 2019 14:30:30 +0200
Message-Id: <20190809123031.24219-7-paul@crapouillou.net>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM will always start with the inactive part. To counter that,
when PWM is enabled we switch the configured polarity, and use
'period - duty + 1' as the real duty.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 85e2110aae4f..8df898429d47 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -121,6 +121,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		   *parent_clk = clk_get_parent(clk);
 	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
+	bool polarity_inversed;
 	int ret;
 
 	parent_rate = clk_get_rate(parent_clk);
@@ -183,24 +184,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-	/* Set duty */
-	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
-
 	/* Set period */
 	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
+	/*
+	 * The PWM will always start with the inactive part. To counter that,
+	 * when PWM is enabled we switch the configured polarity, and use
+	 * 'period - duty + 1' as the real duty.
+	 */
+
+	/* Set duty */
+	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), period - duty + 1);
+
 	/* Set polarity */
-	switch (state->polarity) {
-	case PWM_POLARITY_NORMAL:
+	polarity_inversed = state->polarity == PWM_POLARITY_INVERSED;
+	if (!polarity_inversed ^ state->enabled)
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH, 0);
-		break;
-	case PWM_POLARITY_INVERSED:
+	else
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH,
 				   TCU_TCSR_PWM_INITL_HIGH);
-		break;
-	}
 
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
-- 
2.21.0.593.g511ec345e18

