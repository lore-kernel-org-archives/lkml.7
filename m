Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192ECECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD57222CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948230;
	bh=aLfiwxh2cGEke7pOc3TnWhzlU9xXH4nxrckrExWMU18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkV15kqMgyMf37pmRfQL/4RXfM8JUH3Gb9e+GiW6Rx6jUAKwEHfBgPjPEePUGxIU0
	 TnEZSlnEpSHYFJ7tsA91+ZTkwQBXLxCaOgjAu/TK3JSIBX0ZCMg/zjXK0DpDXhEA/X
	 3R1w33OaPgdP+Q68HzoHzlGjSG+tHD6IJM6Vr5rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbfJAQnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732809AbfJAQnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCA821D80;
        Tue,  1 Oct 2019 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948215;
        bh=aLfiwxh2cGEke7pOc3TnWhzlU9xXH4nxrckrExWMU18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWWIZRNqbE4vqel5OdWH3sr+frEE5US6n38icgt6oKSuf6iz2NqmNR2UYjNxzgpKm
         aOWAFBlkMYgTg58gMX+iehZ0tiMB9CyA9DHZ7qIRds15weOf1jJf5zA2snYF2B5FM3
         VAJ/jxYGbX3YB9wbS7/X3UPdKRsp7txmJWcj6Jp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/43] pwm: stm32-lp: Add check in case requested period cannot be achieved
Date:   Tue,  1 Oct 2019 12:42:45 -0400
Message-Id: <20191001164311.15993-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit c91e3234c6035baf5a79763cb4fcd5d23ce75c2b ]

LPTimer can use a 32KHz clock for counting. It depends on clock tree
configuration. In such a case, PWM output frequency range is limited.
Although unlikely, nothing prevents user from requesting a PWM frequency
above counting clock (32KHz for instance):
- This causes (prd - 1) = 0xffff to be written in ARR register later in
the apply() routine.
This results in badly configured PWM period (and also duty_cycle).
Add a check to report an error is such a case.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-stm32-lp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 0059b24cfdc3c..28e1f64134763 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -58,6 +58,12 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate the period and prescaler value */
 	div = (unsigned long long)clk_get_rate(priv->clk) * state->period;
 	do_div(div, NSEC_PER_SEC);
+	if (!div) {
+		/* Clock is too slow to achieve requested period. */
+		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
+		return -EINVAL;
+	}
+
 	prd = div;
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
-- 
2.20.1

