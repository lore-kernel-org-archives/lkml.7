Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF856213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSIEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:04:36 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSIEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:04:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h69j8-00076D-ER; Tue, 19 Mar 2019 09:04:02 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h69j6-0006C9-2j; Tue, 19 Mar 2019 09:04:00 +0100
Date:   Tue, 19 Mar 2019 09:04:00 +0100
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
Message-ID: <20190319080400.shcsnsyyjcwijsg3@pengutronix.de>
References: <1552977898-5590-1-git-send-email-Anson.Huang@nxp.com>
 <1552977898-5590-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552977898-5590-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 06:50:12AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, it can support multiple PWM channels, all the channels
> share same counter and period setting, but each channel can
> configure its duty and polarity independently.
> 
> There are several TPM modules in i.MX7ULP, the number of channels
> in TPM modules are different, it can be read from each TPM module's
> PARAM register.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V5:
> 	- improve commit message body;
> 	- add period round function;
> 	- use per channel data for saving channel's private data;
> 	- improve error message output during probe;
> 	- improve different period settings by different channels' handling;
> 	- support #pwm-cells 3 cases.
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 463 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 475 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 54f8238..3ea0391 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -210,6 +210,17 @@ config PWM_IMX27
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx27.
>  
> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
> +	  name is Low Power Timer/Pulse Width Modulation Module.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-imx-tpm.
> +
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 448825e..c368599 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
> +obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> new file mode 100644
> index 0000000..bb6b27e
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,463 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + *
> + * Limitations:
> + * - The TPM counter and period counter are shared between
> + *   multiple channels, so all channels should use same period
> + *   settings.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define PWM_IMX_TPM_PARAM	0x4
> +#define PWM_IMX_TPM_GLOBAL	0x8
> +#define PWM_IMX_TPM_SC		0x10
> +#define PWM_IMX_TPM_CNT		0x14
> +#define PWM_IMX_TPM_MOD		0x18
> +#define PWM_IMX_TPM_CnSC(n)	(0x20 + (n) * 0x8)
> +#define PWM_IMX_TPM_CnV(n)	(0x24 + (n) * 0x8)
> +
> +#define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7, 0)
> +
> +#define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
> +#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
> +#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
> +#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
> +
> +#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
> +#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
> +#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
> +#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2) /* combine ELSA and ELSB as a field */

I'd write a more verbose comment here to make this understandable.
Something like:

/*
 * The reference manual describes this field as two separate bits. The
 * samantic of the two bits isn't orthogonal though, so they are treated
 * together as a 2-bit field here.
 */

> +
> +#define PWM_IMX_TPM_MOD_MOD	GENMASK(15, 0)
> +
> +#define PWM_IMX_TPM_MAX_COUNT		0xffff

This is just the maximal value for PWM_IMX_TPM_MOD_MOD? If so, this
should be reflected in the name. Other than that, PWM_IMX_TPM_MOD_MOD
could be used for that, too.

> +struct imx_tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mutex lock;
> +	u32 user_count;
> +	u32 enable_count;
> +	u32 real_period;
> +};
> +
> +struct imx_tpm_pwm_channel {
> +	u32 config;
> +	bool status;
> +};
> +
> +static inline struct imx_tpm_pwm_chip *to_imx_tpm_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct imx_tpm_pwm_chip, chip);
> +}
> +
> +static unsigned int pwm_imx_tpm_round_period(struct pwm_chip *chip,
> +					     u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 rate, real_period, prescale, period_count;
> +	u64 tmp;
> +
> +	rate = clk_get_rate(tpm->clk);
> +	tmp = period;
> +	tmp *= rate;
> +	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);

The value tmp holds is the time a single counter step takes, right?
Please give that a better name. Something like clock_unit.

> +	if (tmp <= PWM_IMX_TPM_MAX_COUNT) {
> +		prescale = 0;
> +	} else {
> +		prescale = roundup_pow_of_two(tmp /
> +					      (PWM_IMX_TPM_MAX_COUNT + 1));

Do divide a u64 you must not use a plain division. You need div64_ul()
here.

> +		prescale = ilog2(prescale);

This is equivalent to:

	prescale = roundup_pow_of_two(tmp);
	prescale = ilog2(prescale) - 16;

which safes a division. (Of course don't use a plain 16 in your code.)

> +	}
> +
> +	/* if no valid prescale found, use MAX instead */
> +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> +		prescale = PWM_IMX_TPM_SC_PS >> __bf_shf(PWM_IMX_TPM_SC_PS);

		prescale = FIELD_PREP(PWM_IMX_TPM_SC_PS, PWM_IMX_TPM_SC_PS)

What is the consequence if the calculated prescale isn't valid? I assume
this yields a greatly different period? If yes, this should result in an
error.

> +	/* if no valid period count found, use MAX instead */
> +	period_count = (tmp + ((1 << prescale) >> 1)) >> prescale;
> +	if (period_count > PWM_IMX_TPM_MOD_MOD)
> +		period_count = PWM_IMX_TPM_MOD_MOD;

Ditto.

> +	/* calculate real period HW can support */
> +	tmp = period_count;
> +	tmp *= (1 << prescale) * NSEC_PER_SEC;

I don't know what the compiler does here, I guess it is a bit easier for
it to optimise here if you write:

	tmp = (u64)period_count << prescale;
	tmp *= NSEC_PER_SEC;
	
> +	real_period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	return real_period;
> +}
> +
> +static void pwm_imx_tpm_config_counter(struct pwm_chip *chip, u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 val, rate, prescale, saved_cmod;
> +	u64 tmp;
> +
> +	rate = clk_get_rate(tpm->clk);
> +	tmp = period;
> +	tmp *= rate;
> +	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (tmp <= PWM_IMX_TPM_MAX_COUNT) {
> +		prescale = 0;
> +	} else {
> +		prescale = roundup_pow_of_two(tmp /
> +					      (PWM_IMX_TPM_MAX_COUNT + 1));
> +		prescale = ilog2(prescale);
> +	}
> +
> +	/* make sure counter is disabled for programming prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	saved_cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> +	if (saved_cmod) {
> +		val &= ~PWM_IMX_TPM_SC_CMOD;
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
> +
> +	/* set TPM counter prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	val &= ~PWM_IMX_TPM_SC_PS;
> +	val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, prescale);
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	/*
> +	 * set period count: according to RM, the MOD register is
> +	 * updated immediately after CMOD[1:0] = 2b'00 above
> +	 */
> +	val = (tmp + ((1 << prescale) >> 1)) >> prescale;
> +	writel(val, tpm->base + PWM_IMX_TPM_MOD);
> +
> +	/* restore the clock mode if necessary */
> +	if (saved_cmod) {
> +		val = readl(tpm->base + PWM_IMX_TPM_SC);
> +		val |= FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
> +
> +	tpm->real_period = period;
> +}
> +
> +static void pwm_imx_tpm_config(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       u32 period,
> +			       u32 duty_cycle,
> +			       enum pwm_polarity polarity)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	u32 val;
> +	u64 tmp;
> +
> +	/* set duty counter */
> +	tmp = readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
> +	tmp *= duty_cycle;
> +	val = DIV_ROUND_CLOSEST_ULL(tmp, period);
> +	writel(val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +
> +	/*
> +	 * set polarity (for edge-aligned PWM modes)
> +	 *
> +	 * ELS[1:0] = 2b10 yields normal polarity behaviour,
> +	 * ELS[1:0] = 2b01 yields inversed polarity.
> +	 * The other values are reserved.
> +	 */
> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	val &= ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA);
> +	val |= PWM_IMX_TPM_CnSC_MSB;
> +	val |= (polarity == PWM_POLARITY_NORMAL) ?
> +		FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x2) :
> +		FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x1);
> +	/*
> +	 * polarity settings will enabled/disable output status
> +	 * immediately, so here ONLY save the config and write
> +	 * it into register when channel is enabled/disabled.
> +	 */
> +	chan->config = val;

This function's behaviour is strange. It configures the hardware with
the right the duty_cycle but not the polarity. I cannot imagine that
this not buggy.

> +}
> +
> +/*
> + * When a channel's polarity is configured, the polarity settings
> + * will be saved and ONLY write into the register when the channel
> + * is enabled.
> + *
> + * When a channel is disabled, its polarity settings will be saved
> + * and its output will be disabled by clearing polarity settings.
> + *
> + * When a channel is enabled, its polarity settings will be restored
> + * and output will be enabled again.
> + */
> +static void pwm_imx_tpm_enable(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       bool enable)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	u32 val;
> +
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	if (enable) {
> +		/* restore channel config */
> +		writel(chan->config,
> +		       tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +		if (++tpm->enable_count == 1) {
> +			/* start TPM counter */
> +			val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> +		}
> +	} else {
> +		/* disable channel */
> +		val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +		val &= ~(PWM_IMX_TPM_CnSC_MSA | PWM_IMX_TPM_CnSC_MSB |
> +			 PWM_IMX_TPM_CnSC_ELS);
> +		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +		if (--tpm->enable_count == 0) {
> +			/* stop TPM counter since all channels are disabled */
> +			val &= ~PWM_IMX_TPM_SC_CMOD;
> +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> +		}
> +	}
> +
> +	/* update channel status */
> +	chan->status = enable;
> +}
> +
> +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 rate, val;
> +	u64 tmp;
> +
> +	/* get period */
> +	state->period = tpm->real_period;
> +
> +	/* get duty cycle */
> +	rate = clk_get_rate(tpm->clk);
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	val = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> +	tmp = readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +	tmp *= (1 << val) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get polarity */
> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) == 0x1)
> +		state->polarity = PWM_POLARITY_INVERSED;
> +	else if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) == 0x2)
> +		state->polarity = PWM_POLARITY_NORMAL;

	else ?

> +
> +	/* get channel status */
> +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> +}
> +
> +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	u32 p;
> +
> +	mutex_lock(&tpm->lock);
> +
> +	if (state->period != tpm->real_period) {
> +		/*
> +		 * TPM counter is shared by multiple channels, so
> +		 * prescale and period can NOT be modified when
> +		 * there are multiple channels in use with different
> +		 * period settings.
> +		 */
> +		p = pwm_imx_tpm_round_period(chip, state->period);
> +		if (p != tpm->real_period && tpm->user_count != 1)
> +			return -EBUSY;
> +		else if (p != tpm->real_period)
> +			pwm_imx_tpm_config_counter(chip, p);
> +	}

This looks more complicated than it should be. What about:

	p = pwm_imx_tpm_round_period(chip, state->period);

	if (p != tpm->real_period) {
		if (tpm->user_count != 1)
			return -EBUSY;

		pwm_imx_tpm_config_counter(chip, p);
	}

Another optimisation is possible here as pwm_imx_tpm_round_period and
pwm_imx_tpm_config_counter do effectively the same calculations: Let
pwm_imx_tpm_round_period return the respective register values that are
then just written to the registers instead of recalculating them once
more.

> +	if (state->enabled == false) {
> +		/*
> +		 * if eventually the PWM output is LOW, either
> +		 * duty cycle is 0 or status is disabled, need
> +		 * to make sure the output pin is LOW.
> +		 */
> +		pwm_imx_tpm_config(chip, pwm, state->period,
> +				   0, state->polarity);
> +		if (chan->status == true)
> +			pwm_imx_tpm_enable(chip, pwm, false);
> +	} else {
> +		pwm_imx_tpm_config(chip, pwm, state->period,
> +				   state->duty_cycle, state->polarity);
> +		if (chan->status == false)
> +			pwm_imx_tpm_enable(chip, pwm, true);
> +	}

This function is really hard to understand. The factors making this
complicated are:

 - Strange semantic of pwm_imx_tpm_config, IMHO the things done in both
   pwm_imx_tpm_config and pwm_imx_tpm_enable should be done in a single
   function.
 - "status" could better be names "enabled"

IMHO it should look like:

	int my_apply(chip, pwm, state)
	{
		ret = my_round_state(state, &hwparams);
		if (ret)
			return ret;

		mutex_lock();

		if (usercount > 1 &&
		    my_hwparams_interfere(current_state, hwparams))
			ret = -EBUSY;
			goto out_unlock;

		my_apply_to_hardware(hwparams);

		mutex_unlock();
	out_unlock:

		return ret;
	}

> +	mutex_unlock(&tpm->lock);
> +
> +	return 0;
> +}
> +
> +static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan;
> +
> +	chan = devm_kzalloc(chip->dev, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	pwm_set_chip_data(pwm, chan);
> +
> +	mutex_lock(&tpm->lock);
> +	tpm->user_count++;
> +	mutex_unlock(&tpm->lock);
> +
> +	return 0;
> +}
> +
> +static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +
> +	mutex_lock(&tpm->lock);
> +	tpm->user_count--;
> +	mutex_unlock(&tpm->lock);
> +
> +	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
> +	pwm_set_chip_data(pwm, NULL);
> +}
> +
> +static const struct pwm_ops imx_tpm_pwm_ops = {
> +	.request = pwm_imx_tpm_request,
> +	.free = pwm_imx_tpm_free,
> +	.get_state = pwm_imx_tpm_get_state,
> +	.apply = pwm_imx_tpm_apply,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int pwm_imx_tpm_probe(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm;
> +	int ret;
> +	u32 val;
> +
> +	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
> +	if (!tpm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tpm);
> +
> +	tpm->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tpm->base))
> +		return PTR_ERR(tpm->base);
> +
> +	tpm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(tpm->clk)) {
> +		ret = PTR_ERR(tpm->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev,
> +				"failed to get PWM clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(tpm->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to prepare or enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	tpm->chip.dev = &pdev->dev;
> +	tpm->chip.ops = &imx_tpm_pwm_ops;
> +	tpm->chip.base = -1;
> +	tpm->chip.of_xlate = of_pwm_xlate_with_flags;
> +	tpm->chip.of_pwm_n_cells = 3;
> +
> +	/* get number of channels */
> +	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
> +	tpm->chip.npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
> +
> +	mutex_init(&tpm->lock);
> +
> +	ret = pwmchip_add(&tpm->chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> +		clk_disable_unprepare(tpm->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pwm_imx_tpm_remove(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
> +	int ret = pwmchip_remove(&tpm->chip);
> +
> +	clk_disable_unprepare(tpm->clk);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +
> +	if (tpm->enable_count == 0)
> +		clk_disable_unprepare(tpm->clk);
> +
> +	return 0;

IMHO you should return an error if enable_count isn't 0 to prevent going
to suspend.

> +}
> +
> +static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (tpm->enable_count == 0) {
> +		ret = clk_prepare_enable(tpm->clk);
> +		if (ret)
> +			dev_err(dev,
> +				"failed to prepare or enable clock: %d\n",
> +				ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
> +			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
> +
> +static const struct of_device_id imx_tpm_pwm_dt_ids[] = {
> +	{ .compatible = "fsl,imx-tpm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
> +
> +static struct platform_driver imx_tpm_pwm_driver = {
> +	.driver = {
> +		.name = "imx-tpm-pwm",
> +		.of_match_table = imx_tpm_pwm_dt_ids,
> +		.pm = &imx_tpm_pwm_pm,
> +	},
> +	.probe	= pwm_imx_tpm_probe,
> +	.remove = pwm_imx_tpm_remove,
> +};
> +module_platform_driver(imx_tpm_pwm_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("i.MX TPM PWM Driver");
> +MODULE_LICENSE("GPL v2");

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
