Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84397C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B1C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="hQS6oY/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437227AbfIWIN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:13:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43086 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406610AbfIWINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so9358223lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0u2P7pamoOhyJrqwJt38ESkhZ0sdWB5inGNjp2B0iE=;
        b=hQS6oY/JaqwIwiWR3QGBGTrvnZ0Ox9Tp21cnMGLGOBTSqAv6Pxu1Uo7aVpspDOwoKs
         ICEjPp6uhe0tKO00gdZLNcWvQ1ZE1Fx63MnumVq1Xw7e18d7WTJ8a4/ZgU/UEQqPFM9q
         aS6UZDZ/Vv1kDFZtq8xRAmhcKq+JziDPGf8Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0u2P7pamoOhyJrqwJt38ESkhZ0sdWB5inGNjp2B0iE=;
        b=qVO6a9/2jWN69zpX1ql1UE0b0obrvGq4cRuJZF1NygVoneaMh1RXCtYKsNNyvQosXX
         8CF2Hv02V1oQuQ/iHPs7ofLirs1sA2T3/ChAyiQ3VnykA/SCtObnSaCq8ih51h8w+/dM
         BABq59HpS4OcizzUpFIRXobnqeNzRTl9FAmutsyqifTxCekVOsp7u036kIovjhNv28n8
         l3oky645fP7PL5bWF+yB3yOhWGjlogrB7sd8ROGSGf3wBIVybAZu0n4r7HfQzp33pybj
         w30LudUKh5erlig/cJeyvPmduNLFfL/LBvM7nTo4bncux5ruPAE7Y5Jpk+ARcgWx2kE8
         q/eQ==
X-Gm-Message-State: APjAAAW/BjqhGx0h5vYd8PfH0wy3NwC2s2GD1QHyPcHPC5j2/j0zYWCd
        wmb6tvsAAWndqcuP+1eVS+MY/iimJ95iwL59
X-Google-Smtp-Source: APXvYqyXbJD3jcPtkfunH7p5W/yiqrLQ0jizMCztCXox/YlwFtfX/7WaU2GXsONN3ApveQi4vG9rwg==
X-Received: by 2002:a19:22cd:: with SMTP id i196mr15644550lfi.160.1569226433180;
        Mon, 23 Sep 2019 01:13:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:52 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pwm: mxs: implement ->apply
Date:   Mon, 23 Sep 2019 10:13:45 +0200
Message-Id: <20190923081348.6843-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
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
 drivers/pwm/pwm-mxs.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 04c0f6b95c1a..c70c26a9ff68 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -26,6 +26,7 @@
 #define  PERIOD_PERIOD_MAX	0x10000
 #define  PERIOD_ACTIVE_HIGH	(3 << 16)
 #define  PERIOD_INACTIVE_LOW	(2 << 18)
+#define  PERIOD_POLARITY_NORMAL	(PERIOD_ACTIVE_HIGH | PERIOD_INACTIVE_LOW)
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
@@ -41,6 +42,66 @@ struct mxs_pwm_chip {
 
 #define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
 
+static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 struct pwm_state *state)
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
+	 * If the PWM channel is disabled, make sure to turn on the clock
+	 * before writing the register. Otherwise, keep it enabled.
+	 */
+	if (!pwm_is_enabled(pwm)) {
+		ret = clk_prepare_enable(mxs->clk);
+		if (ret)
+			return ret;
+	}
+
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
+		if (pwm_is_enabled(pwm))
+			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
+		clk_disable_unprepare(mxs->clk);
+	}
+	return 0;
+}
+
 static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
@@ -116,6 +177,7 @@ static void mxs_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops mxs_pwm_ops = {
+	.apply = mxs_pwm_apply,
 	.config = mxs_pwm_config,
 	.enable = mxs_pwm_enable,
 	.disable = mxs_pwm_disable,
-- 
2.20.1

