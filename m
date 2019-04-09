Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95EEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7913B2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDIJ3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:29:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfDIJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:29:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDn3u-00042j-UH; Tue, 09 Apr 2019 11:29:02 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDn3r-0005GN-RB; Tue, 09 Apr 2019 11:28:59 +0200
Date:   Tue, 9 Apr 2019 11:28:59 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH V10 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190409092859.qj4rgpljokdsokes@pengutronix.de>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
 <1553582817-29519-3-git-send-email-Anson.Huang@nxp.com>
 <20190409064750.qnjcddlf5gktipah@pengutronix.de>
 <DB3PR0402MB391632F693646A5D600B74F9F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB391632F693646A5D600B74F9F52D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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

On Tue, Apr 09, 2019 at 08:51:48AM +0000, Anson Huang wrote:
> > On Tue, Mar 26, 2019 at 06:52:33AM +0000, Anson Huang wrote:
> > > +     /* get polarity */
> > > +     if (chan) {
> > > +             state->polarity = chan->polarity;
> > > +     } else {
> > > +             /* in case no channel requested yet, return HW status */
> > > +             val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +             if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ==
> > > +                 PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)
> > > +                     state->polarity = PWM_POLARITY_INVERSED;
> > > +             else
> > > +                     /*
> > > +                      * Assume reserved values (2b00 and 2b11) to yield
> > > +                      * normal polarity.
> > > +                      */
> > > +                     state->polarity = PWM_POLARITY_NORMAL;
> > > +     }
> > 
> > What is the good reason to prefer chan->polarity over reading out the
> > hardware state?
> 
> Reading it from DDR is faster than accessing HW register as per
> previous comment?

How much time do you save here? Is it worth to complicate the function
for that?

> > > +     /* get channel status */
> > > +     state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true :
> > > +false; }
> > > +
> > > +/* this function is supposed to be called with mutex hold */ static
> > > +int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> > > +                             struct pwm_device *pwm,
> > > +                             struct pwm_state *state,
> > > +                             struct imx_tpm_pwm_param *p) {
> > > +     struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +     struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> > > +     bool period_update = false;
> > > +     bool duty_update = false;
> > > +     u32 val, cmod, cur_prescale;
> > > +     unsigned long timeout;
> > > +     struct pwm_state c;
> > > +
> > > +     if (state->period != tpm->real_period) {
> > > +             /*
> > > +              * TPM counter is shared by multiple channels, so
> > > +              * prescale and period can NOT be modified when
> > > +              * there are multiple channels in use with different
> > > +              * period settings.
> > > +              */
> > > +             if (tpm->user_count > 1)
> > > +                     return -EBUSY;
> > > +
> > > +             val = readl(tpm->base + PWM_IMX_TPM_SC);
> > > +             cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> > > +             cur_prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> > > +             if (cmod && cur_prescale != p->prescale)
> > > +                     return -EBUSY;
> > > +
> > > +             /* set TPM counter prescale */
> > > +             val &= ~PWM_IMX_TPM_SC_PS;
> > > +             val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
> > > +             writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +
> > > +             /*
> > > +              * set period count:
> > > +              * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
> > > +              * is updated when MOD register is written.
> > > +              *
> > > +              * if the PWM is enabled (CMOD[1:0] ≠ 2b00), the period length
> > > +              * is latched into hardware when the next period starts.
> > > +              */
> > > +             writel(p->mod, tpm->base + PWM_IMX_TPM_MOD);
> > > +             tpm->real_period = state->period;
> > > +             period_update = true;
> > > +     }
> > > +
> > > +     pwm_imx_tpm_get_state(chip, pwm, &c);
> > 
> > If you move this call above the previous if block you can use c.period instead
> > of tpm->real_period which is easier to follow.
> 
> I think the period could be changed by the if block, so duty also be changed, need
> to put the .get_state here, am I right?

As you don't use c.period below this shouldn't matter. Where does duty
change?

> > > +     if (state->duty_cycle != c.duty_cycle) {
> > > +             /*
> > > +              * set channel value:
> > > +              * if the PWM is disabled (CMOD[1:0] = 2b00), then CnV register
> > > +              * is updated when CnV register is written.
> > > +              *
> > > +              * if the PWM is enabled (CMOD[1:0] ≠ 2b00), the duty length
> > > +              * is latched into hardware when the next period starts.
> > > +              */
> > > +             writel(p->val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +             duty_update = true;
> > > +     }
> > > +
> > > +     /* make sure MOD & CnV registers are updated */
> > > +     if (period_update || duty_update) {
> > > +             timeout = jiffies + msecs_to_jiffies(tpm->real_period /
> > > +                                                  NSEC_PER_MSEC + 1);
> > > +             while (readl(tpm->base + PWM_IMX_TPM_MOD) != p->mod
> > > +                    || readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm))
> > > +                    != p->val) {
> > > +                     if (time_after(jiffies, timeout))
> > > +                             return -ETIME;
> > > +                     cpu_relax();
> > > +             }
> > > +     }
> > 
> > If the PWM is running you wait in the above loop until the new values are
> > active but before you configure the period. I think in the case where the
> > PWM is active and a change of polarity is requested it would be more correct
> > to refuse the change.
> 
> Not very understand, the period is changed at the beginning, and most of the time,
> period should be fixed, changing polarity should be allowed even PWM is active?

Changing polarity should be atomic (that is, get active with the next
period's start). As the hardware doesn't support that, claiming it does
is a bad idea.

> That does NOT introduce too many trouble, is it a common case that dynamic changing
> polarity is NOT good? 
> 
> 
> > 
> > > +     val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +     val &= ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA |
> > > +              PWM_IMX_TPM_CnSC_MSB);
> > > +     if (state->enabled) {
> > > +             /*
> > > +              * set polarity (for edge-aligned PWM modes)
> > > +              *
> > > +              * ELS[1:0] = 2b10 yields normal polarity behaviour,
> > > +              * ELS[1:0] = 2b01 yields inversed polarity.
> > > +              * The other values are reserved.
> > > +              *
> > > +              * polarity settings will enabled/disable output status
> > > +              * immediately, so if the channel is disabled, need to
> > > +              * make sure MSA/MSB/ELS are set to 0 which means channel
> > > +              * disabled.
> > 
> > I don't understand this comment. Either ELS = 0 is reserved or it can be used.
> > What is an output status?
> 
> The reference manual ONLY states it as reserved, so how to add comments here?

The problem might just be, that I don't get what you intend to say in
the last paragraph.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
