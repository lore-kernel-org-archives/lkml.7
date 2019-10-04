Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4754C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFD2222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="K86FwHST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfJDNdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:33:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39246 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388498AbfJDNdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:33:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so4496228lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84d/4Z+Ct38UY+63PRtlhnBYnsxa6bKE+yT9EoLxBQ8=;
        b=K86FwHSTa8imnI9kd9BEczCcJ4FljqrcPnSq74CItPMRqe8R6vfy70DGfXffz1/7UZ
         TODX6szyElyk+mI/cd/cryh1cWqSMz12FRwMKfpiXnWC0M4ETDbYLC7NyJj+MiXKKcls
         niGe1in8ylcyKNdPXYsk+8eMs1lSfo8FUHpbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84d/4Z+Ct38UY+63PRtlhnBYnsxa6bKE+yT9EoLxBQ8=;
        b=nDjtY69ekFxOnavJN6V8iuzlwBIF4cFhjg0jFme6IhYIpxWDg/aNB+VzZ7iirBLQ7E
         dJPM2SK4HAmU8jSYBA1qb+keIZ/RFNZSG/znvRoCSrdjlcxl/p1wPa+EcJLOFLzQ0jC3
         W9kZYN/3699Ocp7msJYJrO+JLXew0geMHambRTrZd2ipgcnAvtWgZMtKqpzUg3tT/G3j
         mBi2bg9oTU7IgGigbUcvKqaKXrLViM1K6GDE/q1qaxBdCOjOfpJWVKSO/s/2hQbtkmpk
         qHlCskv5j3d/AENHI/XG8vL4CmTVShGKyV0vqXuuo3WDUQSfiDUCd1VBzVR6cdC11Aju
         37bg==
X-Gm-Message-State: APjAAAWGCZQv4kHXoNLa+Y1AvOF9G71uOvYe2Ovg3oEuV1mudq5Y6gus
        /b3OVluHyMirQIQkhzxmucVk8Q==
X-Google-Smtp-Source: APXvYqzs5zFXhqdDNu2+43b758ZHk0CgecW26AuZBrDWWj+4OulMZAKBuWb/lzr0T//DOGSJ1OjAdA==
X-Received: by 2002:a19:3805:: with SMTP id f5mr6004869lfa.173.1570195979142;
        Fri, 04 Oct 2019 06:32:59 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:32:58 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] pwm: mxs: implement ->apply
Date:   Fri,  4 Oct 2019 15:32:02 +0200
Message-Id: <20191004133207.6663-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting setting the polarity, switch the driver
to support the ->apply method.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index b14376b47ac8..10efd3de0bb3 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -26,6 +26,7 @@
 #define  PERIOD_PERIOD_MAX	0x10000
 #define  PERIOD_ACTIVE_HIGH	(3 << 16)
 #define  PERIOD_INACTIVE_LOW	(2 << 18)
+#define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
@@ -41,6 +42,74 @@ struct mxs_pwm_chip {
 
 #define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
 
+static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
+	int ret, div = 0;
+	unsigned int period_cycles, duty_cycles;
+	unsigned long rate;
+	unsigned long long c;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOTSUPP;
+
+	/*
+	 * If the PWM channel is disabled, make sure to turn on the
+	 * clock before calling clk_get_rate() and writing to the
+	 * registers. Otherwise, just keep it enabled.
+	 */
+	if (!pwm_is_enabled(pwm)) {
+		ret = clk_prepare_enable(mxs->clk);
+		if (ret)
+			return ret;
+	}
+
+	if (!state->enabled && pwm_is_enabled(pwm))
+		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
+
+	rate = clk_get_rate(mxs->clk);
+	while (1) {
+		c = rate / cdiv[div];
+		c = c * state->period;
+		do_div(c, 1000000000);
+		if (c < PERIOD_PERIOD_MAX)
+			break;
+		div++;
+		if (div >= PERIOD_CDIV_MAX)
+			return -EINVAL;
+	}
+
+	period_cycles = c;
+	c *= state->duty_cycle;
+	do_div(c, state->period);
+	duty_cycles = c;
+
+	/*
+	 * The data sheet the says registers must be written to in
+	 * this order (ACTIVEn, then PERIODn). Also, the new settings
+	 * only take effect at the beginning of a new period, avoiding
+	 * glitches.
+	 */
+	writel(duty_cycles << 16,
+	       mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
+	writel(PERIOD_PERIOD(period_cycles) | PERIOD_POLARITY_NORMAL | PERIOD_CDIV(div),
+	       mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
+
+	if (state->enabled) {
+		if (!pwm_is_enabled(pwm)) {
+			/*
+			 * The clock was enabled above. Just enable
+			 * the channel in the control register.
+			 */
+			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
+		}
+	} else {
+		clk_disable_unprepare(mxs->clk);
+	}
+	return 0;
+}
+
 static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
@@ -116,6 +185,7 @@ static void mxs_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops mxs_pwm_ops = {
+	.apply = mxs_pwm_apply,
 	.config = mxs_pwm_config,
 	.enable = mxs_pwm_enable,
 	.disable = mxs_pwm_disable,
-- 
2.20.1

