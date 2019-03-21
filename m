Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93296C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA9F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfCUKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:41:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:41:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6v8M-0000lP-FK; Thu, 21 Mar 2019 11:41:14 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6v8K-0004tp-82; Thu, 21 Mar 2019 11:41:12 +0100
Date:   Thu, 21 Mar 2019 11:41:12 +0100
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
Message-ID: <20190321104112.xits5qgk7tsuhdps@pengutronix.de>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
 <1553128960-17923-3-git-send-email-Anson.Huang@nxp.com>
 <20190321091950.tkzem7cbgvtynr5m@pengutronix.de>
 <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anson,

On Thu, Mar 21, 2019 at 09:54:15AM +0000, Anson Huang wrote:
> > -----Original Message-----
> > From: Uwe Kleine-König [mailto:u.kleine-koenig@pengutronix.de]
> > Sent: 2019年3月21日 17:20
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: thierry.reding@gmail.com; robh+dt@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux@armlinux.org.uk; stefan@agner.ch;
> > otavio@ossystems.com.br; Leonard Crestez <leonard.crestez@nxp.com>;
> > schnitzeltony@gmail.com; jan.tuerk@emtrion.com; Robin Gong
> > <yibin.gong@nxp.com>; linux-pwm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V8 2/5] pwm: Add i.MX TPM PWM driver support
> > 
> > Hello,
> > 
> > On Thu, Mar 21, 2019 at 12:47:57AM +0000, Anson Huang wrote:
> > > i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> > > inside, it can support multiple PWM channels, all the channels share
> > > same counter and period setting, but each channel can configure its
> > > duty and polarity independently.
> > >
> > > There are several TPM modules in i.MX7ULP, the number of channels in
> > > TPM modules are different, it can be read from each TPM module's PARAM
> > > register.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > changes since V7:
> > > 	- improve prescale computation;
> > > 	- improve some register definitions;
> > > 	- remove unnecessary check for period count check;
> > > 	- improve function parameter to use pointer instead of value;
> > > ---
> > >  drivers/pwm/Kconfig       |  11 ++
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-imx-tpm.c | 435
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 447 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > 54f8238..3ea0391 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -210,6 +210,17 @@ config PWM_IMX27
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-imx27.
> > >
> > > +config PWM_IMX_TPM
> > > +	tristate "i.MX TPM PWM support"
> > > +	depends on ARCH_MXC || COMPILE_TEST
> > > +	depends on HAVE_CLK && HAS_IOMEM
> > > +	help
> > > +	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
> > > +	  name is Low Power Timer/Pulse Width Modulation Module.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-imx-tpm.
> > > +
> > >  config PWM_JZ4740
> > >  	tristate "Ingenic JZ47xx PWM support"
> > >  	depends on MACH_INGENIC
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> > > 448825e..c368599 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+= pwm-
> > hibvt.o
> > >  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
> > >  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
> > >  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
> > > +obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
> > >  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
> > >  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
> > >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> > > diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> > new
> > > file mode 100644 index 0000000..0efea36
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-imx-tpm.c
> > > @@ -0,0 +1,435 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright 2018-2019 NXP.
> > > + *
> > > + * Limitations:
> > > + * - The TPM counter and period counter are shared between
> > > + *   multiple channels, so all channels should use same period
> > > + *   settings.
> > 
> > What about:
> > 
> >  - Not all parameters to change the period length can be changed
> >    atomically. The counter must be stopped to change SC.PS.
> > 
> >  - Changes to polarity cannot be latched at the time of the next period
> >    start.
> 
> OK.
> 
> > 
> > ?
> > 
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/log2.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define PWM_IMX_TPM_PARAM	0x4
> > > +#define PWM_IMX_TPM_GLOBAL	0x8
> > > +#define PWM_IMX_TPM_SC		0x10
> > > +#define PWM_IMX_TPM_CNT		0x14
> > > +#define PWM_IMX_TPM_MOD		0x18
> > > +#define PWM_IMX_TPM_CnSC(n)	(0x20 + (n) * 0x8)
> > > +#define PWM_IMX_TPM_CnV(n)	(0x24 + (n) * 0x8)
> > > +
> > > +#define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7,
> > 0)
> > > +
> > > +#define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
> > > +#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
> > > +#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK
> > 	FIELD_PREP(PWM_IMX_TPM_SC_CMOD, 1)
> > > +#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
> > > +
> > > +#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
> > > +#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
> > > +#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
> > > +
> > > +/*
> > > + * The reference manual describes this field as two separate bits.
> > > +The
> > > + * samantic of the two bits isn't orthogonal though, so they are
> > > +treated
> > > + * together as a 2-bit field here.
> > > + */
> > > +#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2)
> > > +#define PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED	0x1
> > > +#define PWM_IMX_TPM_CnSC_ELS_INVERSED
> > 	FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 1)
> > > +#define PWM_IMX_TPM_CnSC_ELS_NORMAL
> > 	FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 2)
> > > +
> > > +
> > > +#define PWM_IMX_TPM_MOD_WIDTH	16
> > > +#define PWM_IMX_TPM_MOD_MOD
> > 	GENMASK(PWM_IMX_TPM_MOD_WIDTH - 1, 0)
> > > +
> > > +struct imx_tpm_pwm_chip {
> > > +	struct pwm_chip chip;
> > > +	struct clk *clk;
> > > +	void __iomem *base;
> > > +	struct mutex lock;
> > > +	u32 user_count;
> > > +	u32 enable_count;
> > > +	u32 real_period;
> > > +};
> > > +
> > > +struct imx_tpm_pwm_param {
> > > +	u8 prescale;
> > > +	u32 mod;
> > > +};
> > > +
> > > +static inline struct imx_tpm_pwm_chip *to_imx_tpm_pwm_chip(struct
> > > +pwm_chip *chip) {
> > > +	return container_of(chip, struct imx_tpm_pwm_chip, chip); }
> > > +
> > > +static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
> > > +				   struct imx_tpm_pwm_param *p,
> > > +				   struct pwm_state *state,
> > > +				   struct pwm_state *real_state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	u32 rate, prescale, period_count, clock_unit;
> > > +	u64 tmp;
> > > +
> > > +	rate = clk_get_rate(tpm->clk);
> > > +	tmp = (u64)state->period * rate;
> > > +	clock_unit = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> > > +	if (clock_unit <= PWM_IMX_TPM_MOD_MOD)
> > > +		prescale = 0;
> > > +	else
> > > +		prescale = ilog2(clock_unit) + 1 -
> > PWM_IMX_TPM_MOD_WIDTH;
> > > +
> > > +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> > > +		return -ERANGE;
> > > +	p->prescale = prescale;
> > > +
> > > +	period_count = (clock_unit + ((1 << prescale) >> 1)) >> prescale;
> > > +	p->mod = period_count;
> > > +
> > > +	/* calculate real period HW can support */
> > > +	tmp = (u64)period_count << prescale;
> > > +	tmp *= NSEC_PER_SEC;
> > > +	real_state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > > +
> > > +	/*
> > > +	 * if eventually the PWM output is inactive, either
> > > +	 * duty cycle is 0 or status is disabled, need to
> > > +	 * make sure the output pin is inactive.
> > > +	 */
> > > +	if (!state->enabled)
> > > +		real_state->duty_cycle = 0;
> > > +	else
> > > +		real_state->duty_cycle = state->duty_cycle;
> > 
> > You're maybe lying about the duty cycle here. Also it would be more
> > consistent to calculate the value to be written into the CnV register that
> > defines the duty cycle here.
> > 
> > Regarding the period computation I'm happy with this function. Unless I miss
> > something this function is idempotent (i.e. doing
> > 
> > 	pwm_imx_tpm_round_state(chip, &p, some_state, &real_state1);
> > 	pwm_imx_tpm_round_state(chip, &p, &real_state1, &real_state2);
> > 
> > results in real_state1 == real_state2) given that
> > clk_get_rate(tpm->clk) < NSEC_PER_SEC.
> 
> Sorry, I can NOT get your point, can you be more detail?

I assume you ask about the idempotent stuff and my critics about the
duty cycle above is clear.

IMHO a PWM driver should have the property that if I do:

	pwm_get_state(my_pwm, &state);
	pwm_apply_state(my_pwm, &state);

it should not result in any changes. This could for example happen if I
request the period of a PWM to be 3333334 ns, then the output might be
configured (because of hardware constraints) to 3333333.333333333 ns.
Then get_state returns 3333333 ns (which is fine) and then configuring
for these 3333333 ns results in a period of length 331666 ns.

This is not the case here as pwm_imx_tpm_round_state is idempotent which
is actually a good property and my comment was pointing out something
good, not requesting a change.

> > > +	real_state->polarity = state->polarity;
> > > +	real_state->enabled = state->enabled;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > A comment here noting that pwm_imx_tpm_setup_period is supposed to be
> > called with the mutex hold would be good here.
> 
> Fine.
> 
> > 
> > > +static void pwm_imx_tpm_setup_period(struct pwm_chip *chip,
> > > +				     struct imx_tpm_pwm_param *p) {
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	u32 val, saved_cmod, cur_prescale;
> > > +
> > > +	/* make sure counter is disabled for programming prescale */
> > 
> > @Thierry: What is your thought here? IMHO this should only be allowed if all
> > affected PWMs are off.
> 
> As we already make sure that ONLY when there is ONLY 1 user and the requested
> period is different from the current period, then this function will be called, so there
> is impossible that multiple PWMs are active and the period is requested to be changed.
> Am I right? 

This problem is not about two PWMs. If you reconfigure a running PWM the
requirement is that the hardware completes a whole period with the old
configuration and then immediately starts a new period with the new
parameters. If you stop the counter, the last period with the old
parameters is disturbed.

> 
> > 
> > > +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> > > +	saved_cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> > > +	cur_prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> > > +	if (saved_cmod && cur_prescale != p->prescale) {
> > > +		val &= ~PWM_IMX_TPM_SC_CMOD;
> > > +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +	}
> > > +
> > > +	/* set TPM counter prescale */
> > > +	val &= ~PWM_IMX_TPM_SC_PS;
> > > +	val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
> > > +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +
> > > +	/* restore the clock mode if necessary */
> > > +	if (saved_cmod && cur_prescale != p->prescale) {
> > > +		val |= FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
> > > +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> > > +	}
> > > +
> > > +	/*
> > > +	 * set period count:
> > > +	 * according to RM, the MOD register is updated immediately
> > > +	 * if CMOD[1:0] = 2b'00. if CMOD[1:0] != 2b'00, then MOD
> > > +	 * register is updated according to the CPWMS bit, that is:
> > > +	 *
> > > +	 * if the selected mode is not CPWM then MOD register is
> > > +	 * updated after MOD register was written and the TPM
> > > +	 * counter changes from MOD to zero.
> > > +	 *
> > > +	 * if the selected mode is CPWM then MOD register is updated
> > > +	 * after MOD register was written and the TPM counter changes
> > > +	 * from MOD to (MOD – 1).
> > > +	 */
> > > +	writel(p->mod, tpm->base + PWM_IMX_TPM_MOD); }
> > > +
> > > +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> > > +				  struct pwm_device *pwm,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	u32 rate, val, prescale;
> > > +	u64 tmp;
> > > +
> > > +	/* get period */
> > > +	state->period = tpm->real_period;
> > > +
> > > +	/* get duty cycle */
> > > +	rate = clk_get_rate(tpm->clk);
> > > +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> > > +	prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> > > +	tmp = readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> > > +	tmp = (tmp << prescale) * NSEC_PER_SEC;
> > > +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> > > +
> > > +	/* get polarity */
> > > +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> > > +	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ==
> > > +	    PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)
> > > +		state->polarity = PWM_POLARITY_INVERSED;
> > > +	else
> > > +		/*
> > > +		 * Assume reserved values (2b00 and 2b11) to yield
> > > +		 * normal polarity.
> > 
> > Given that this driver writes PWM_IMX_TPM_CnSC_ELS = 2b00 in some
> > situations assuming that this results in an constant inactive output, this
> > should be recognized here. (Not entirely sure the output is inactive because
> > of only PWM_IMX_TPM_CnSC_ELS = 2b00.)
> 
> Fine, then I can save the original requested polarity in each channel, and then return
> the last requested polarity here, NOT read from hardware, since the polarity could be
> different according to enable status.

This works iff there was a polarity requested before.
 
> > > +		 */
> > > +		state->polarity = PWM_POLARITY_NORMAL;
> > > +
> > > +	/* get channel status */
> > > +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true :
> > > +false; }
> > > +
> > > +static void pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> > > +				 struct pwm_device *pwm,
> > > +				 struct pwm_state *state)
> > 
> > pwm_imx_tpm_apply_hw is called with the mutex hold. Is this necessary?
> > Please either call it without the mutex or annotate the function that the caller
> > is supposed to hold it.
> 
> OK, will make sure call it without mutex hold.
> 
> > 
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct pwm_state c;
> > > +	u32 val, sc_val;
> > > +	u64 tmp;
> > > +
> > > +	pwm_imx_tpm_get_state(chip, pwm, &c);
> > > +
> > > +	if (state->duty_cycle != c.duty_cycle) {
> > > +		/* set duty counter */
> > > +		tmp = readl(tpm->base + PWM_IMX_TPM_MOD) &
> > PWM_IMX_TPM_MOD_MOD;
> > > +		tmp *= state->duty_cycle;
> > > +		val = DIV_ROUND_CLOSEST_ULL(tmp, state->period);
> > > +		writel(val, tpm->base + PWM_IMX_TPM_CnV(pwm-
> > >hwpwm));
> > 
> > How does this affect a currently running PWM? Consider it runs at
> > duty_cycle=500 + period=1000 and now should change to duty_cycle=700 +
> > period=800. Can it happen that we see a or even several periods with
> > duty_cycle=700 and period=1000?
> 
> 
> The reference manual says, if counter is disabled, it will be updated immediately.

The counter is not disabled, right?

> If counter is enabled, and for edge aligned PWM mode(EPWM), the register is updated
> After written and TPM counter changes from MOD to zero, same as period count update,
> HW will make sure the period finish..

Looking into my concern again, it is actually the other way around:
Assuming a single used PWM channel that runs at duty_cycle=500 +
period=1000. Then pwm_imx_tpm_apply() is called with state->duty_cycle=700
and state->period=800. pwm_imx_tpm_apply() calls
pwm_imx_tpm_setup_period() to configure for .period=1000. Now if the
PWM completes a period before pwm_imx_tpm_apply_hw() sets up CnV to the
value corresponding to duty_cycle=700, it produces a waveform with
duty_cycle=500 and period=800 which is bad. This is another limitation
that can be worked around in software with some effort (which might or
might not be worth to spend).

> If (CMOD[1:0] = 0:0) then CnV register is updated when CnV register is written.
> If (CMOD[1:0] ≠ 0:0), then CnV register is updated according to the selected mode, that
> is:
> • If the selected mode is output compare then CnV register is updated on the next TPM
> counter increment (end of the prescaler counting) after CnV register was written.
> • If the selected mode is EPWM then CnV register is updated after CnV register was
> written and the TPM counter changes from MOD to zero.
> • If the selected mode is CPWM then CnV register is updated after CnV register was
> written and the TPM counter changes from MOD to (MOD – 1).
> 64.5.14

The case "selected mode is EPWM" is the one relevant for us, right?

> > > +	}
> > > +
> > > +	if (state->enabled != c.enabled) {
> > 
> > If the PWM was already on and is changed to another enabled state, you're
> > ignoring the (maybe) new polarity here.
> > 
> > > +		/*
> > > +		 * set polarity (for edge-aligned PWM modes)
> > > +		 *
> > > +		 * ELS[1:0] = 2b10 yields normal polarity behaviour,
> > > +		 * ELS[1:0] = 2b01 yields inversed polarity.
> > > +		 * The other values are reserved.
> > > +		 *
> > > +		 * polarity settings will enabled/disable output status
> > > +		 * immediately, so if the channel is disabled, need to
> > > +		 * make sure MSA/MSB/ELS are set to 0 which means channel
> > > +		 * disabled.
> > > +		 */
> > > +		val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm-
> > >hwpwm));
> > > +		val &= ~(PWM_IMX_TPM_CnSC_ELS |
> > PWM_IMX_TPM_CnSC_MSA |
> > > +			 PWM_IMX_TPM_CnSC_MSB);
> > > +		sc_val = readl(tpm->base + PWM_IMX_TPM_SC);
> > > +		if (state->enabled) {
> > > +			val |= PWM_IMX_TPM_CnSC_MSB;
> > > +			val |= (state->polarity == PWM_POLARITY_NORMAL) ?
> > > +				PWM_IMX_TPM_CnSC_ELS_NORMAL :
> > > +				PWM_IMX_TPM_CnSC_ELS_INVERSED;
> > > +			if (++tpm->enable_count == 1) {
> > > +				/* start TPM counter */
> > > +				sc_val |=
> > PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> > > +				writel(sc_val, tpm->base +
> > PWM_IMX_TPM_SC);
> > > +			}
> > > +		} else {
> > > +			if (--tpm->enable_count == 0) {
> > > +				/* stop TPM counter */
> > > +				sc_val &= ~PWM_IMX_TPM_SC_CMOD;
> > > +				writel(sc_val, tpm->base +
> > PWM_IMX_TPM_SC);
> > > +			}
> > > +		}
> > > +		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm-
> > >hwpwm));
> > > +	}
> > > +}
> > > +
> > > +static int pwm_imx_tpm_apply(struct pwm_chip *chip,
> > > +			      struct pwm_device *pwm,
> > > +			     struct pwm_state *state)
> > > +{
> > > +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> > > +	struct imx_tpm_pwm_param param;
> > > +	struct pwm_state real_state;
> > > +	int ret;
> > > +
> > > +	ret = pwm_imx_tpm_round_state(chip, &param, state, &real_state);
> > > +	if (ret)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&tpm->lock);
> > > +
> > > +	/*
> > > +	 * TPM counter is shared by multiple channels, so
> > > +	 * prescale and period can NOT be modified when
> > > +	 * there are multiple channels in use with different
> > > +	 * period settings.
> > > +	 */
> > > +	if (real_state.period != tpm->real_period) {
> > > +		if (tpm->user_count > 1) {
> > > +			ret = -EBUSY;
> > > +			goto exit;
> > > +		}
> > > +
> > > +		pwm_imx_tpm_setup_period(chip, &param);
> > > +		tpm->real_period = real_state.period;
> > > +	}
> > > +
> > > +	pwm_imx_tpm_apply_hw(chip, pwm, &real_state);
> > > +
> > > +exit:
> > > +	mutex_unlock(&tpm->lock);
> > 
> > .apply is supposed to sleep until the newly configured state is active.
> > This is missing here, right?
> 
> NOT quite understand, you meant .apply could be sleep if mutex is hold by
> other thread?

No. .apply is supposed to only return when the new configuration is
active. So if the PWM is running in its previous configuration, you
setup the registers such that the new configuration gets active in the
next period, you must not yet return to the caller until the new period
started.

> BTW, can you have as more of your comments together as possible? That can
> save some time of doing new patch, many thanks for your time and patience.

I understand that coming up with new issues in V8 that were already
present in V5 is annoying. On the other hand when having already pointed
out quite some issues in V5 (and V6 and V7) it's not always easy to
still see the more complicated issues. In this review round the driver
got in my eyes considerably cleaner with the introduction of the
round_state function and earlier the drop of _config and _enable. That
only after this I was able to identify more issues is bad for your work
flow, but a prime show case why a well structured driver is good for
maintainability. Also note that my feedback is (for you) free of charge.
My day's calendar also contains other items. So I can better spend
several small time slices reviewing your work than a single big one. Of
course I could delay sending out my findings till the next small slot,
but I think this is not beneficial in the sum for several reasons. If I
give small (but maybe incomplete) feedback:

 - you are not (completely) delayed;
 - it is less likely that someone else looks at your patch and so
   duplicates my work;
 - it is less likely that the maintainer comes around in a hurry,
   doesn't notice remaining issues and applies the non-optimal patch;
 - you can provide a new iteration that is already better than the last
   and so give the chance to find issues that where somewhat hidden
   behind things the driver suffered before.

In my eyes this outweighs the drawbacks of this workflow.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
