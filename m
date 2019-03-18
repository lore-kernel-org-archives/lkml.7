Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCRIIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:08:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfCRIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:08:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h5nJA-0005q6-ON; Mon, 18 Mar 2019 09:07:44 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h5nJ9-0007mm-2b; Mon, 18 Mar 2019 09:07:43 +0100
Date:   Mon, 18 Mar 2019 09:07:43 +0100
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
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
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
Subject: Re: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190318080743.xumj6e72bzumszvp@pengutronix.de>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
 <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
 <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB39161B062231C59842595374F5470@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:41:02AM +0000, Anson Huang wrote:
> Hi,Uwe
> > > +	val &= ~PWM_IMX_TPM_SC_CMOD;
> > > +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> > 
> > As this interrupts the output, please only do it if necessary.
> 
> OK, will do it ONLY when it is enabled previously.

I think you only need to do that when the value actually changes.

> > > +	/* set duty counter */
> > > +	tmp = readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD_MASK;
> > 
> > I recommend storing this value in driver data.
> 
> NOT quite understand, as we did NOT use it in other places except the get_state,
> just reading the register once should be OK there.

I had the impression it is used more than once. Will look again in the
next iteration. But also note that shadowing the value might already be
beneficial for a single call site as driver data might occupy more RAM
than necessary anyhow and reading from RAM is faster than from the
hardware's register. Probably this is not a fast path, so not worth the
optimisation?!

> > I wonder why MSA and MSB are two bits instead of making this a field of
> > width 2 with 2b10 meaning PWM mode. But maybe it's just me not
> > understanding the independent semantic of these two bits?
> 
> I think making them a field makes more sense, but anyway we just follow
> the RM.

If it makes the driver easier to understand (which I think it does) feel
free to derivate from the RM. Just add a comment to the definition, then
it's fine.

> > Reading the reference manual I'd say in PWM mode the semantic of ELSA
> > and ELSB is:
> > 
> > 	On counter reload set the output to ELSB
> > 	On counter match set the output to ELSA
> > 
> > Noting that in a comment would ease understanding the code here.
> 
> I added below comment for PWM modes:
> 
> 137         /*
> 138          * set polarity (for edge-aligned PWM modes)
> 139          *
> 140          * CPWMS  MSB:MSA  ELSB:ELSA  Mode  Configuration
> 141          * 0      10       10         PWM   High-true pulse
> 142          * 0      10       00         PWM   Reserved
> 143          * 0      10       01         PWM   Low-true pulse
> 144          * 0      10       11         PWM   Reserved
> 145          *
> 146          * High-true pulse: clear output on counter match, set output on
> 147          * counter reload, set output when counter first enabled or paused.
> 148          *
> 149          * Low-true pulse: set output on counter match, clear output on
> 150          * counter reload, clear output when counter first enabled or paused.
> 151          */

I stumbled over "high-true" and "low-true" in the RM, too. In my bubble
this is an uncommon wording. I'd write instead:

	/*
	 * set polarity
	 *
	 * ELSB:ELSA = 2b10 yields normal polarity behaviour, ELSB:ELSA
	 * = 2b01 yields inversed polarity. The other values are
	 * reserved.
	 */

And don't write about CPWM, MSA and MSB which are always used with fixed
values anyhow in the driver. 
 
> > > +		/* disable channel */
> > > +		writel(PWM_IMX_TPM_CnSC_CHF,
> > > +			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > 
> > Clearing CHF doens't disable the channel as I read the manual.
> 
> This write clears CHF as well as writing other bits 0, to disable the output. Maybe I
> can explicitly clear MSA/MSB/ELSA/ELSB to avoid confusion.

Ah, I misinterpreted the value written.

> > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			     struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state curstate;
> > > +	u32 duty_cycle = state->duty_cycle;
> > > +	int ret;
> > > +
> > > +	pwm_imx_tpm_get_state(chip, pwm, &curstate);
> > > +
> > > +	mutex_lock(&tpm->lock);
> > 
> > What should this lock protect? Does it hurt if the state changes between
> > pwm_imx_tpm_get_state releasing the lock and pwm_imx_tpm_apply taking
> > it?
> 
> The idea is to protect the share resourced by multiple channels, but I think I can make the mutex_lock
> includes get_state and remove the lock in get_state function.

You might need it in .get_state to return a consistent state to the
caller. In this case just introduce an unlocked variant of .get_state to
share code between the two functions.

And BTW the question was honest. I'm not entirely sure that you need to
hold the lock.

> > > +		 */
> > > +		if (tpm->user_count != 1)
> > > +			return -EBUSY;
> > 
> > Ideally if say period = 37 is requested but currently we have period =
> > 36 and configuring 37 would result in 36 anyhow, don't return EBUSY.
> 
> I think here the protection is just for making sure that is there are multiple
> users, period can NOT be changed, since all channels will be impacted.

I think you misunderstood what I intended to say here.

Consider that in the case that there is only a single PWM in use
configuring for a period of 37 ns actually yields 36 ns because the
hardware cannot provide 37 ns and 36 ns is the best match.

Then if a second user comes and requests 37 ns, the result here is, that
the second user gets the -EBUSY. This is ridiculous however because the
request is denied even though the period is already configured for the
length that would be configured if the second user were the only one.

> > > +	tpm->chip.dev = &pdev->dev;
> > > +	tpm->chip.ops = &imx_tpm_pwm_ops;
> > > +	tpm->chip.base = -1;
> > > +	tpm->chip.npwm = PWM_IMX_TPM_MAX_CHANNEL_NUM;
> > 
> > This is wrong, as some only have 2 channels?
> 
> I saw we can get channel number from register, will read register to determine
> the channel number, but for the channel config and status saved in struct, I will
> still use the MAX channel number to define the array.

Yeah, that is sensible.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
