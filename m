Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A79320857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCSKQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:16:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53407 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:16:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6BnY-0005El-Iq; Tue, 19 Mar 2019 11:16:44 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6BnV-00028O-L4; Tue, 19 Mar 2019 11:16:41 +0100
Date:   Tue, 19 Mar 2019 11:16:41 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190319101641.45sztmodp4pgz5uu@pengutronix.de>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-3-git-send-email-Anson.Huang@nxp.com>
 <20190319080400.shcsnsyyjcwijsg3@pengutronix.de>
 <DB3PR0402MB3916E87140DE4A4242E879E9F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916E87140DE4A4242E879E9F5400@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

On Tue, Mar 19, 2019 at 09:08:26AM +0000, Anson Huang wrote:
> > On Tue, Mar 19, 2019 at 06:50:12AM +0000, Anson Huang wrote:
> > > +	}
> > > +
> > > +	/* if no valid prescale found, use MAX instead */
> > > +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> > > +		prescale = PWM_IMX_TPM_SC_PS >>
> > __bf_shf(PWM_IMX_TPM_SC_PS);
> > 
> > 		prescale = FIELD_PREP(PWM_IMX_TPM_SC_PS,
> > PWM_IMX_TPM_SC_PS)
> > 
> > What is the consequence if the calculated prescale isn't valid? I assume this
> > yields a greatly different period? If yes, this should result in an error.
> 
> Yes, that is what I intend to do, if a request period is too large and the prescale
> Can NOT meet the requirement, I force it to the largest value that hardware can
> Provide, I am NOT sure if it is the correct solution, if no, I can make it return error
> If round period returns an invalid result.

I'd say for sure it is not correct to configure for a period of 3 s if
20 s are requested. Where to draw the line exactly I don't know either.

In my opinion we need a general guideline like:

	If the requested period + duty_cycle combo isn't supported use
	the biggest available period that is not bigger than requested,
	scale duty cycle accordingly and pick the biggest available duty
	cycle that is not bigger than the scaled value.
	If the requested period is shorter than possible, return
	-ERANGE.

I think the above is sensible, but that's something that IMHO must first
be declared to be "official" as it doesn't make sense if a single driver
implements this and the other still do their own stuff.

Additionally I would consider it beneficial to have something like:

	int pwm_round_state(pwm, &state)

that modifies state according to the above rules without affecting the
hardware. With the respective driver callback the framework could then
implement stuff like: "If the resulting configuration deviates too much
from the requested state, return an error to the consumer." with having
the definition of "too much" in a single place. It would also allow a
consumer who cares much about the resulting waveform to determine the
effects without testing.

The framework could then add additional checks like:

	int pwm_apply_state(pwm, state)
	{
		struct pwm_state rounded_state;

		if IS_ENABLED(CONFIG_PWM_EXTRA_CHECKS):
			rounded_state = pwm->ops->round_state(state);
			if !was_rounded_according_to_the_rules(round_state):
				warn(...)

		pwm->ops->apply(pwm, state)

		if IS_ENABLED(CONFIG_PWM_EXTRA_CHECKS):
			actual_state = pwm->ops->get_state(state);
			if actual_state != round_state:
				warn(...)

> > > +	/* calculate real period HW can support */
> > > +	tmp = period_count;
> > > +	tmp *= (1 << prescale) * NSEC_PER_SEC;
> > 
> > I don't know what the compiler does here, I guess it is a bit easier for it to
> > optimise here if you write:
> > 
> > 	tmp = (u64)period_count << prescale;
> > 	tmp *= NSEC_PER_SEC;
> 
> 
> OK, I just don't want to use (u64) force cast, so I did that.

I don't care much about that. If you prefer do:

	tmp = period_cound;
	tmp <<= prescale;
	tmp *= NSEC_PER_SEC;

Just don't multiply by (1 << prescale).

> > > +static void pwm_imx_tpm_config(struct pwm_chip *chip,
> > > +			       struct pwm_device *pwm,
> > > +			       u32 period,
> > > +			       u32 duty_cycle,
> > > +			       enum pwm_polarity polarity) {
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> > > +	u32 val;
> > > +	u64 tmp;
> > > +
> > > +	/* set duty counter */
> > > +	tmp = readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
> > > +	tmp *= duty_cycle;
> > > +	val = DIV_ROUND_CLOSEST_ULL(tmp, period);
> > > +	writel(val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +
> > > +	/*
> > > +	 * set polarity (for edge-aligned PWM modes)
> > > +	 *
> > > +	 * ELS[1:0] = 2b10 yields normal polarity behaviour,
> > > +	 * ELS[1:0] = 2b01 yields inversed polarity.
> > > +	 * The other values are reserved.
> > > +	 */
> > > +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +	val &= ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA);
> > > +	val |= PWM_IMX_TPM_CnSC_MSB;
> > > +	val |= (polarity == PWM_POLARITY_NORMAL) ?
> > > +		FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x2) :
> > > +		FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x1);
> > > +	/*
> > > +	 * polarity settings will enabled/disable output status
> > > +	 * immediately, so here ONLY save the config and write
> > > +	 * it into register when channel is enabled/disabled.
> > > +	 */
> > > +	chan->config = val;
> > 
> > This function's behaviour is strange. It configures the hardware with the right
> > the duty_cycle but not the polarity. I cannot imagine that this not buggy.
> 
> I think that is hardware limitation here, I used the polarity setting to enable/disable
> the channel, if we set the polarity here directly, the output status may NOT reflect
> the real state, if eventually the status is disabled, setting the polarity directly into register
> will make the output active, that is NOT expected, right? And that is why I put comments
> here.

The frameworks expectation is that .apply results in the hardware
switches to the new configuration directly after completing a previously
configured period. So if you change the period, get preempted and then
change the polarity three periods later that is a bug. If it's
impossible to fix this in software please do as good as possible
(whatever that means) and add this problem to the list of limitations at
the top of the driver.

> > > +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> > > +				  struct pwm_device *pwm,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	u32 rate, val;
> > > +	u64 tmp;
> > > +
> > > +	/* get period */
> > > +	state->period = tpm->real_period;
> > > +
> > > +	/* get duty cycle */
> > > +	rate = clk_get_rate(tpm->clk);
> > > +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> > > +	val = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> > > +	tmp = readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +	tmp *= (1 << val) * NSEC_PER_SEC;
> > > +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > > +
> > > +	/* get polarity */
> > > +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) == 0x1)
> > > +		state->polarity = PWM_POLARITY_INVERSED;
> > > +	else if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) == 0x2)
> > > +		state->polarity = PWM_POLARITY_NORMAL;
> > 
> > 	else ?
> 
> OK, maybe I can set other values to a default polarity.

I'd do:

	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) == 0x1)
		state->polarity = PWM_POLARITY_INVERSED;
	else
		/*
		 * Assume reserved values (0b00 and 0b11) to yield
		 * normal polarity.
		 */
		state->polarity = PWM_POLARITY_NORMAL;

(unless it can be determined what the other configurations do. The RM
declares them as reserved, maybe they just yield constant high and
constant low patterns?)

A define for "inversed" (1) and "normal" (2) would be good.

> > > +	/* get channel status */
> > > +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true :
> > > +false; }
> > > +
> > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			     struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> > > +	u32 p;
> > > +
> > > +	mutex_lock(&tpm->lock);
> > > +
> > > +	if (state->period != tpm->real_period) {
> > > +		/*
> > > +		 * TPM counter is shared by multiple channels, so
> > > +		 * prescale and period can NOT be modified when
> > > +		 * there are multiple channels in use with different
> > > +		 * period settings.
> > > +		 */
> > > +		p = pwm_imx_tpm_round_period(chip, state->period);
> > > +		if (p != tpm->real_period && tpm->user_count != 1)
> > > +			return -EBUSY;
> > > +		else if (p != tpm->real_period)
> > > +			pwm_imx_tpm_config_counter(chip, p);
> > > +	}
> > 
> > This looks more complicated than it should be. What about:
> > 
> > 	p = pwm_imx_tpm_round_period(chip, state->period);
> > 
> > 	if (p != tpm->real_period) {
> > 		if (tpm->user_count != 1)
> > 			return -EBUSY;
> > 
> > 		pwm_imx_tpm_config_counter(chip, p);
> > 	}
> > 
> > Another optimisation is possible here as pwm_imx_tpm_round_period and
> > pwm_imx_tpm_config_counter do effectively the same calculations: Let
> > pwm_imx_tpm_round_period return the respective register values that are
> > then just written to the registers instead of recalculating them once more.
> > 
> 
> This is also my original thoughts, it can avoid computing again in config function, but
> I have to find a place to save the prescale and period count, maybe adding them in
> driver data? Then in config function, just write the registers directly.

No, don't hide that in driver data---hiding is bad. Pass a pointer to a
custom struct that lives on the stack instead.

> > > +	if (state->enabled == false) {
> > > +		/*
> > > +		 * if eventually the PWM output is LOW, either
> > > +		 * duty cycle is 0 or status is disabled, need
> > > +		 * to make sure the output pin is LOW.
> > > +		 */
> > > +		pwm_imx_tpm_config(chip, pwm, state->period,
> > > +				   0, state->polarity);
> > > +		if (chan->status == true)
> > > +			pwm_imx_tpm_enable(chip, pwm, false);
> > > +	} else {
> > > +		pwm_imx_tpm_config(chip, pwm, state->period,
> > > +				   state->duty_cycle, state->polarity);
> > > +		if (chan->status == false)
> > > +			pwm_imx_tpm_enable(chip, pwm, true);
> > > +	}
> > 
> > This function is really hard to understand. The factors making this
> > complicated are:
> > 
> >  - Strange semantic of pwm_imx_tpm_config, IMHO the things done in both
> >    pwm_imx_tpm_config and pwm_imx_tpm_enable should be done in a
> > single
> >    function.
> >  - "status" could better be names "enabled"
> > 
> > IMHO it should look like:
> > 
> > 	int my_apply(chip, pwm, state)
> > 	{
> > 		ret = my_round_state(state, &hwparams);
> > 		if (ret)
> > 			return ret;
> > 
> > 		mutex_lock();
> > 
> > 		if (usercount > 1 &&
> > 		    my_hwparams_interfere(current_state, hwparams))
> > 			ret = -EBUSY;
> > 			goto out_unlock;
> > 
> > 		my_apply_to_hardware(hwparams);
> > 
> > 		mutex_unlock();
> > 	out_unlock:
> > 
> > 		return ret;
> > 	}
> > 
> 
> Agreed, that can also solve the polarity setting question, will give it a try.

And it could also simplify to implement the callback for my suggested
pwm_round_state above.

> > > +static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev) {
> > > +	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> > > +
> > > +	if (tpm->enable_count == 0)
> > > +		clk_disable_unprepare(tpm->clk);
> > > +
> > > +	return 0;
> > 
> > IMHO you should return an error if enable_count isn't 0 to prevent going to
> > suspend.
> 
> OK, although maybe there is other voice that fail to disabling a clock does NOT impact
> System suspend function, the clock will be automatically turned off by hardware anyway,
> But I agree that adding error return is also making sense here.

Not sure you understood what I intended to say. If the enable_count
isn't zero you shouldn't even try to disable the clock. Consider the PWM
is driving a step motor that must not be stopped in an uncontrolled
manner.

There is an effort to ensure that a PWM consumer is suspended before the
PWM. Together with this everybody should be happy.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
