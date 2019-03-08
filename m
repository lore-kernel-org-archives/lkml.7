Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A608AC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813C920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCHL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:57:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCHL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:57:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2E80-0003WO-6a; Fri, 08 Mar 2019 12:57:28 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h2E7y-0006fT-Mh; Fri, 08 Mar 2019 12:57:26 +0100
Date:   Fri, 8 Mar 2019 12:57:26 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190308115726.smgooacsr37fmxwg@pengutronix.de>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com>
 <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com>
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

On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
> > > +                         struct pwm_state *state)
> > > +{
> > > +     struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> > > +     unsigned int duty_cycle, x;
> > > +     u32 frac;
> > > +     struct pwm_state cur_state;
> > > +     bool enabled;
> > > +     int ret = 0;
> > > +     unsigned long num;
> > > +
> > > +     if (state->polarity != PWM_POLARITY_INVERSED)
> > > +             return -EINVAL;
> > > +
> > > +     mutex_lock(&pwm->lock);
> > > +     pwm_get_state(dev, &cur_state);
> > > +     enabled = cur_state.enabled;
> > > +
> > > +     if (state->period != cur_state.period) {
> >
> > Did you test this with more than one consumer? For sure the following
> > should work:
> >
> >         pwm1 = pwm_get(.. the first ..);
> >         pwm_apply_state(pwm1, { .enabled = true, .period = 10000000, .... });
> >
> >         pwm2 = pwm_get(.. the second ..);
> >         pwm_apply_state(pwm2, { .enabled = true, .period = 10000000, .... });
> >
> > but for the second pwm_apply_state() run state->period is likely not
> > exactly 10000000.
> 
> Yes, I have tested multiple consumers using sysfs interface. It is working.

Can you provide details about your testing here? What is the parent clk
rate? Which settings did you test? Can you confirm my claim that the
above sequence would fail or point out my error in reasoning?

> > > +     x = 1U << PWM_SIFIVE_CMPWIDTH;
> > > +     num = (u64)duty_cycle * x + x / 2;
> > > +     frac = div_u64(num, state->period);
> >
> > I don't understand the "+ x / 2" part. Should this better be
> > "+ state->period / 2"? Something like
> 
> This eqn is as per your comments against v5 of this patch series.
>  frac = (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 <<
> PWM_SIFIVE_CMPWIDTH) / 2) / period;

OK, then not only the code is wrong, but also my suggestion was. :-)

> > #define div_u64_round(a, b) ({typeof(b) __b = b; div_u64(a + __b / 2, __b)})
> >
> > would make this less error prone.

This still stands. It makes it easier to get the code right and makes it
easier to understand.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
