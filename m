Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B695321874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfCUNm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:42:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfCUNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:42:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6xxW-0003SA-On; Thu, 21 Mar 2019 14:42:14 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6xxU-0002Sq-5V; Thu, 21 Mar 2019 14:42:12 +0100
Date:   Thu, 21 Mar 2019 14:42:12 +0100
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
Subject: Re: [PATCH V8 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190321134212.hypmz4enz7z5wamg@pengutronix.de>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
 <1553128960-17923-3-git-send-email-Anson.Huang@nxp.com>
 <20190321091950.tkzem7cbgvtynr5m@pengutronix.de>
 <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321104112.xits5qgk7tsuhdps@pengutronix.de>
 <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

On Thu, Mar 21, 2019 at 12:47:32PM +0000, Anson Huang wrote:
> > On Thu, Mar 21, 2019 at 09:54:15AM +0000, Anson Huang wrote:
> > > > On Thu, Mar 21, 2019 at 12:47:57AM +0000, Anson Huang wrote:
> > > > > +static void pwm_imx_tpm_setup_period(struct pwm_chip *chip,
> > > > > +				     struct imx_tpm_pwm_param *p) {
> > > > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > > > +	u32 val, saved_cmod, cur_prescale;
> > > > > +
> > > > > +	/* make sure counter is disabled for programming prescale */
> > > >
> > > > @Thierry: What is your thought here? IMHO this should only be
> > > > allowed if all affected PWMs are off.
> > >
> > > As we already make sure that ONLY when there is ONLY 1 user and the
> > > requested period is different from the current period, then this
> > > function will be called, so there is impossible that multiple PWMs are active
> > and the period is requested to be changed.
> > > Am I right?
> > 
> > This problem is not about two PWMs. If you reconfigure a running PWM the
> > requirement is that the hardware completes a whole period with the old
> > configuration and then immediately starts a new period with the new
> > parameters. If you stop the counter, the last period with the old parameters
> > is disturbed.
> 
> So, I think simply return error if the counter is running and there is a new PS change
> request, right?

That's the general idea yes. If you cannot fulfil the request without
violating the guarantees you have to adhere, refuse the request with an
error.

> > > > > +		 */
> > > > > +		state->polarity = PWM_POLARITY_NORMAL;
> > > > > +
> > > > > +	/* get channel status */
> > > > > +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true :
> > > > > +false; }
> > > > > +
> > > > > +static void pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> > > > > +				 struct pwm_device *pwm,
> > > > > +				 struct pwm_state *state)
> > > >
> > > > pwm_imx_tpm_apply_hw is called with the mutex hold. Is this necessary?
> > > > Please either call it without the mutex or annotate the function
> > > > that the caller is supposed to hold it.
> > >
> > > OK, will make sure call it without mutex hold.

Reading through the reference manual I noticed that there might be a
stall: If you write two values to CnV the second write is ignored if the
first wasn't latched yet. That might mean that you cannot release the
mutex before the newly configured state is active. This is related to
the request to not let .apply return before the configured state is
active, but I didn't thought this to an end what the real consequences
have to be.

> > > If counter is enabled, and for edge aligned PWM mode(EPWM), the
> > > register is updated After written and TPM counter changes from MOD to
> > > zero, same as period count update, HW will make sure the period finish..
> > 
> > Looking into my concern again, it is actually the other way around:
> > Assuming a single used PWM channel that runs at duty_cycle=500 +
> > period=1000. Then pwm_imx_tpm_apply() is called with state-
> > >duty_cycle=700 and state->period=800. pwm_imx_tpm_apply() calls
> > pwm_imx_tpm_setup_period() to configure for .period=1000. Now if the
> > PWM completes a period before pwm_imx_tpm_apply_hw() sets up CnV to
> > the value corresponding to duty_cycle=700, it produces a waveform with
> > duty_cycle=500 and period=800 which is bad. This is another limitation that
> > can be worked around in software with some effort (which might or might
> > not be worth to spend).
> 
> I am sure that on i.MX7ULP platform we used for backlight ONLY, it should NOT
> that matter if this case happen, unless the counter is disabled, then the effort spend
> on this case will be huge, so I plan to leave it as what it is if you don't mind.

That means you have to add this to the list of limitations.

> > > > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip,
> > > > > +			      struct pwm_device *pwm,
> > > > > +			     struct pwm_state *state)
> > > > > +{
> > > > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > > > +	struct imx_tpm_pwm_param param;
> > > > > +	struct pwm_state real_state;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pwm_imx_tpm_round_state(chip, &param, state, &real_state);
> > > > > +	if (ret)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	mutex_lock(&tpm->lock);
> > > > > +
> > > > > +	/*
> > > > > +	 * TPM counter is shared by multiple channels, so
> > > > > +	 * prescale and period can NOT be modified when
> > > > > +	 * there are multiple channels in use with different
> > > > > +	 * period settings.
> > > > > +	 */
> > > > > +	if (real_state.period != tpm->real_period) {
> > > > > +		if (tpm->user_count > 1) {
> > > > > +			ret = -EBUSY;
> > > > > +			goto exit;
> > > > > +		}
> > > > > +
> > > > > +		pwm_imx_tpm_setup_period(chip, &param);
> > > > > +		tpm->real_period = real_state.period;
> > > > > +	}
> > > > > +
> > > > > +	pwm_imx_tpm_apply_hw(chip, pwm, &real_state);
> > > > > +
> > > > > +exit:
> > > > > +	mutex_unlock(&tpm->lock);
> > > >
> > > > .apply is supposed to sleep until the newly configured state is active.
> > > > This is missing here, right?
> > >
> > > NOT quite understand, you meant .apply could be sleep if mutex is hold
> > > by other thread?
> > 
> > No. .apply is supposed to only return when the new configuration is active.
> > So if the PWM is running in its previous configuration, you setup the registers
> > such that the new configuration gets active in the next period, you must not
> > yet return to the caller until the new period started.
> 
> That bring me back to previous question, we can add waiting for period finish
> And then return from .apply, but we also need a timeout for the wait, what should
> The timeout value be? 100mS? Or even several seconds?

A sane value would be the duration of the previously configured period
length as this is the theoretical upper limit for this delay.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
