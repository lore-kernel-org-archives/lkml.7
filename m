Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C54720854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCNKA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:00:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46827 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfCNKA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:00:57 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NAJ-0006O9-DV; Thu, 14 Mar 2019 11:00:43 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4NAI-0002HD-JJ; Thu, 14 Mar 2019 11:00:42 +0100
Date:   Thu, 14 Mar 2019 11:00:42 +0100
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
Subject: Re: [PATCH V2 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190314100042.fl4kdwn7awcw4aov@pengutronix.de>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
 <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
 <20190314091702.sooxvnzd4mqr2ilz@pengutronix.de>
 <DB3PR0402MB3916975BC10346C612135334F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916975BC10346C612135334F54B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

On Thu, Mar 14, 2019 at 09:49:06AM +0000, Anson Huang wrote:
> > On Wed, Mar 13, 2019 at 07:31:16AM +0000, Anson Huang wrote:
> > > +static void imx_tpm_pwm_config(struct pwm_chip *chip,
> > > +			       struct pwm_device *pwm,
> > > +			       struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	static bool tpm_cnt_initialized;
> > > +	unsigned int duty_cnt;
> > > +	u32 val;
> > > +	u64 tmp;
> > > +
> > > +	/*
> > > +	 * TPM counter is shared by multi channels, let's make it to be
> > > +	 * ONLY first channel can config TPM counter's precale and period
> > > +	 * count.
> > > +	 */
> > > +	if (!tpm_cnt_initialized) {
> > > +		imx_tpm_pwm_config_counter(chip, state->period);
> > > +		tpm_cnt_initialized = true;
> > > +	}
> > 
> > So the period can only be configured once. That is not as good as it could be.
> > You should allow a change whenever there is exactly one PWM in use.
> 
> OK, maybe I can add check for other channels' statue here, and allow the period
> update if ONLY 1 channel is enabled.

See how the SiFive patch that I already pointed out solves this same
problem.

> > > +	/* set duty counter */
> > > +	tmp = readl(tpm->base + TPM_MOD) & TPM_MOD_MOD_MASK;
> > > +	tmp *= state->duty_cycle;
> > > +	duty_cnt = DIV_ROUND_CLOSEST_ULL(tmp, state->period);
> > 
> > Uah, you use state->period here even though for the 2nd PWM the Divider
> > might not be setup appropriately.
> 
> I think that is 1 limitation here, the dts should make sure the period used for
> different channels are same or at least they can share same divider, otherwise,
> what if multiple channels can NOT find a divider good for every channel? How to
> deal with this case?

You should return -ERANGE or -EINVAL for the calls that cannot be
satisfied.

> > > [...]
> > > +static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			  struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state curstate;
> > > +	unsigned long flags;
> > > +
> > > +	imx_tpm_pwm_get_state(chip, pwm, &curstate);
> > > +
> > > +	spin_lock_irqsave(&tpm->lock, flags);
> > > +
> > > +	if (state->period != curstate.period ||
> > > +	    state->duty_cycle != curstate.duty_cycle ||
> > > +	    state->polarity != curstate.polarity)
> > > +		imx_tpm_pwm_config(chip, pwm, state);
> > > +
> > > +	if (state->enabled != curstate.enabled)
> > > +		imx_tpm_pwm_enable(chip, pwm, state->enabled);
> > 
> > This is wrong. This sequence:
> > 
> > 	pwm_apply_state(pwm, { .duty_cycle = 0, .period = 10000, .enabled =
> > true });
> > 	pwm_apply_state(pwm, { .duty_cycle = 10000, .period =
> > 10000, .enabled = false });
> > 
> > must keep the output pin low which isn't guaranteed here.
> 
> So you mean for every .apply operation, the channel MUST be disabled first, then config
> it, then enable it?

No. I only say that you should not configure the new period and duty
cycle if in the end the hardware should be disabled. Always disabling is
wrong, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
