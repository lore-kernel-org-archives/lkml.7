Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBB8214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCLJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:17:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCLJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:17:47 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3dXZ-0002dH-9m; Tue, 12 Mar 2019 10:17:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3dXX-000766-ON; Tue, 12 Mar 2019 10:17:39 +0100
Date:   Tue, 12 Mar 2019 10:17:39 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there are just a few minor things left I commented below.

On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> +#define div_u64_round(a, b) \
> +	({typeof(b) __b = b; div_u64((a) + __b / 2, __b); })

Parenthesis around b please. I guess I didn't had them in my suggestion
either, sorry for that.

> +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> +{
> +	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> +	int ret;
> +
> +	if (enable) {
> +		ret = clk_enable(pwm->clk);
> +		if (ret) {
> +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!enable)
> +		clk_disable(pwm->clk);
> +
> +	return 0;
> +}

There is only a single caller for this function. I wonder if it is
trivial enough to fold it into pwm_sifive_apply.

> +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
> +			    struct pwm_state *state)
> +{
> +	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> +	unsigned int duty_cycle;
> +	u32 frac;
> +	struct pwm_state cur_state;
> +	bool enabled;
> +	int ret = 0;
> +	unsigned long num;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ret = clk_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_lock(&pwm->lock);
> +	pwm_get_state(dev, &cur_state);
> +
> +	enabled = cur_state.enabled;
> +
> +	if (state->period != pwm->approx_period) {
> +		if (pwm->user_count != 1) {
> +			ret = -EBUSY;
> +			goto exit;
> +		}
> +		pwm->approx_period = state->period;
> +		pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> +	}
> +
> +	duty_cycle = state->duty_cycle;
> +	if (!state->enabled)
> +		duty_cycle = 0;
> +
> +	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> +	frac = div_u64_round(num, state->period);
> +	/* The hardware cannot generate a 100% duty cycle */
> +	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +
> +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> +	       dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> +
> +	if (state->enabled != enabled) {
> +		ret = pwm_sifive_enable(chip, state->enabled);
> +		if (ret)
> +			goto exit;

This goto is a noop.

> +	}
> +
> +exit:
> +	clk_disable(pwm->clk);
> +	mutex_unlock(&pwm->lock);
> +	return ret;
> +}

There are a few other things that could be improved, but I think they
could be addressed later. For some of these I don't even know what to
suggest, for some Thierry might not agree it is worth fixing:

 - rounding
   how to round? When should a request declined, when is rounding ok?
   There is still "if (state->period != pwm->approx_period) return -EBUSY"
   in this driver. This is better than before, but if state-period ==
   pwm->approx_period + 1 the result (if accepted) might be the same as
   without the +1 and so returning -EBUSY for one case and accepting the
   other is strange.
 - don't call PWM API functions designed for consumers (here: pwm_get_state)
 - Move div_u64_round to include/linux/math64.h

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
