Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6028C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B29A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697227;
	bh=aLfiwxh2cGEke7pOc3TnWhzlU9xXH4nxrckrExWMU18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRicF0Pa6wHfOLEBt9bA/XOIiE5+AF+IWzHJC4am2gjmCaMgXPw61ElF29yc36zUa
	 dAtWQKp8CBVdscrjHS0hF8qhnrPCggUALbX5d4XL/IZLWPaQFoe2KujZKBC3LliEqK
	 IIu2IOuMdTIYl8khkmECmSCimaLXtlFBy+szOIaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbfJJIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389416AbfJJIrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:47:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27CD208C3;
        Thu, 10 Oct 2019 08:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697220;
        bh=aLfiwxh2cGEke7pOc3TnWhzlU9xXH4nxrckrExWMU18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYRBd9qUjIB2XFpRhzu0FxVNGPuK62PvXtM5utPl9fk/1+rKunEAD3TvnBSqDiVqA
         LV+IHhrg982Y5+OtO0q/XW+DsQX8WPOQf7JeqogkoydXuyS3Bvsk/f9UEpnWoQL0Nd
         HYafTSMk37f1lswXA27qPp4qoTclDww1f+fCufmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/114] pwm: stm32-lp: Add check in case requested period cannot be achieved
Date:   Thu, 10 Oct 2019 10:36:09 +0200
Message-Id: <20191010083609.636396399@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



