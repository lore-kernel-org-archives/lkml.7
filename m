Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BBC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC67D20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDIGsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:48:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIGsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:48:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDkXv-0005qX-7C; Tue, 09 Apr 2019 08:47:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDkXu-0000yV-2C; Tue, 09 Apr 2019 08:47:50 +0200
Date:   Tue, 9 Apr 2019 08:47:50 +0200
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
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V10 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190409064750.qnjcddlf5gktipah@pengutronix.de>
References: <1553582817-29519-1-git-send-email-Anson.Huang@nxp.com>
 <1553582817-29519-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553582817-29519-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:52:33AM +0000, Anson Huang wrote:
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
> Changes since V9:
> 	- improve some comments;
> 	- merge period_duty setting and config_hw to be 1 function, avoid duplicated duty settings
> 	  in some scenario;
> 	- use non "devm_" function for channel data allocation and free.
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
> index 0000000..e1e9b68
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
> + * - Changes to polarity cannot be latched at the time of the
> + *   next period start.
> + * - Changing period and duty cycle together isn't atomic,
> + *   with the wrong timing it might happen that a period is
> + *   produced with old duty cycle but new period settings.
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
> +#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	FIELD_PREP(PWM_IMX_TPM_SC_CMOD, 1)
> +#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
> +
> +#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
> +#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
> +#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
> +
> +/*
> + * The reference manual describes this field as two separate bits. The
> + * semantic of the two bits isn't orthogonal though, so they are treated
> + * together as a 2-bit field here.
> + */
> +#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2)
> +#define PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED	0x1
> +#define PWM_IMX_TPM_CnSC_ELS_INVERSED	FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 1)

This looks strange.  The only usage of
PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED is:

	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ==
	    PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)

If you change this to

	if ((val & PWM_IMX_TPM_CnSC_ELS) ==
	    PWM_IMX_TPM_CnSC_ELS_INVERSED)

you can drop the PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED symbol.

> +#define PWM_IMX_TPM_CnSC_ELS_NORMAL	FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 2)
> +
> +
> +#define PWM_IMX_TPM_MOD_WIDTH	16
> +#define PWM_IMX_TPM_MOD_MOD	GENMASK(PWM_IMX_TPM_MOD_WIDTH - 1, 0)
> +
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
> +struct imx_tpm_pwm_param {
> +	u8 prescale;
> +	u32 mod;
> +	u32 val;
> +};
> +
> +struct imx_tpm_pwm_channel {
> +	enum pwm_polarity polarity;
> +};
> +
> +static inline struct imx_tpm_pwm_chip *to_imx_tpm_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct imx_tpm_pwm_chip, chip);
> +}
> +
> +static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
> +				   struct imx_tpm_pwm_param *p,
> +				   struct pwm_state *state,
> +				   struct pwm_state *real_state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 rate, prescale, period_count, clock_unit;
> +	u64 tmp;
> +
> +	rate = clk_get_rate(tpm->clk);
> +	tmp = (u64)state->period * rate;
> +	clock_unit = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (clock_unit <= PWM_IMX_TPM_MOD_MOD)
> +		prescale = 0;
> +	else
> +		prescale = ilog2(clock_unit) + 1 - PWM_IMX_TPM_MOD_WIDTH;
> +
> +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> +		return -ERANGE;
> +	p->prescale = prescale;
> +
> +	period_count = (clock_unit + ((1 << prescale) >> 1)) >> prescale;
> +	p->mod = period_count;
> +
> +	/* calculate real period HW can support */
> +	tmp = (u64)period_count << prescale;
> +	tmp *= NSEC_PER_SEC;
> +	real_state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/*
> +	 * if eventually the PWM output is inactive, either
> +	 * duty cycle is 0 or status is disabled, need to
> +	 * make sure the output pin is inactive.
> +	 */
> +	if (!state->enabled)
> +		real_state->duty_cycle = 0;
> +	else
> +		real_state->duty_cycle = state->duty_cycle;
> +
> +	tmp = (u64)p->mod * real_state->duty_cycle;
> +	p->val = DIV_ROUND_CLOSEST_ULL(tmp, real_state->period);
> +
> +	real_state->polarity = state->polarity;
> +	real_state->enabled = state->enabled;
> +
> +	return 0;
> +}
> +
> +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	u32 rate, val, prescale;
> +	u64 tmp;
> +
> +	/* get period */
> +	state->period = tpm->real_period;
> +
> +	/* get duty cycle */
> +	rate = clk_get_rate(tpm->clk);
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> +	tmp = readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +	tmp = (tmp << prescale) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get polarity */
> +	if (chan) {
> +		state->polarity = chan->polarity;
> +	} else {
> +		/* in case no channel requested yet, return HW status */
> +		val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ==
> +		    PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)
> +			state->polarity = PWM_POLARITY_INVERSED;
> +		else
> +			/*
> +			 * Assume reserved values (2b00 and 2b11) to yield
> +			 * normal polarity.
> +			 */
> +			state->polarity = PWM_POLARITY_NORMAL;
> +	}

What is the good reason to prefer chan->polarity over reading out the
hardware state?

> +	/* get channel status */
> +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> +}
> +
> +/* this function is supposed to be called with mutex hold */
> +static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> +				struct pwm_device *pwm,
> +				struct pwm_state *state,
> +				struct imx_tpm_pwm_param *p)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan = pwm_get_chip_data(pwm);
> +	bool period_update = false;
> +	bool duty_update = false;
> +	u32 val, cmod, cur_prescale;
> +	unsigned long timeout;
> +	struct pwm_state c;
> +
> +	if (state->period != tpm->real_period) {
> +		/*
> +		 * TPM counter is shared by multiple channels, so
> +		 * prescale and period can NOT be modified when
> +		 * there are multiple channels in use with different
> +		 * period settings.
> +		 */
> +		if (tpm->user_count > 1)
> +			return -EBUSY;
> +
> +		val = readl(tpm->base + PWM_IMX_TPM_SC);
> +		cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> +		cur_prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> +		if (cmod && cur_prescale != p->prescale)
> +			return -EBUSY;
> +
> +		/* set TPM counter prescale */
> +		val &= ~PWM_IMX_TPM_SC_PS;
> +		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +		/*
> +		 * set period count:
> +		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
> +		 * is updated when MOD register is written.
> +		 *
> +		 * if the PWM is enabled (CMOD[1:0] ≠ 2b00), the period length
> +		 * is latched into hardware when the next period starts.
> +		 */
> +		writel(p->mod, tpm->base + PWM_IMX_TPM_MOD);
> +		tpm->real_period = state->period;
> +		period_update = true;
> +	}
> +
> +	pwm_imx_tpm_get_state(chip, pwm, &c);

If you move this call above the previous if block you can use c.period
instead of tpm->real_period which is easier to follow.

> +	if (state->duty_cycle != c.duty_cycle) {
> +		/*
> +		 * set channel value:
> +		 * if the PWM is disabled (CMOD[1:0] = 2b00), then CnV register
> +		 * is updated when CnV register is written.
> +		 *
> +		 * if the PWM is enabled (CMOD[1:0] ≠ 2b00), the duty length
> +		 * is latched into hardware when the next period starts.
> +		 */
> +		writel(p->val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +		duty_update = true;
> +	}
> +
> +	/* make sure MOD & CnV registers are updated */
> +	if (period_update || duty_update) {
> +		timeout = jiffies + msecs_to_jiffies(tpm->real_period /
> +						     NSEC_PER_MSEC + 1);
> +		while (readl(tpm->base + PWM_IMX_TPM_MOD) != p->mod
> +		       || readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm))
> +		       != p->val) {
> +			if (time_after(jiffies, timeout))
> +				return -ETIME;
> +			cpu_relax();
> +		}
> +	}

If the PWM is running you wait in the above loop until the new values
are active but before you configure the period. I think in the case
where the PWM is active and a change of polarity is requested it would
be more correct to refuse the change.

> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	val &= ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA |
> +		 PWM_IMX_TPM_CnSC_MSB);
> +	if (state->enabled) {
> +		/*
> +		 * set polarity (for edge-aligned PWM modes)
> +		 *
> +		 * ELS[1:0] = 2b10 yields normal polarity behaviour,
> +		 * ELS[1:0] = 2b01 yields inversed polarity.
> +		 * The other values are reserved.
> +		 *
> +		 * polarity settings will enabled/disable output status
> +		 * immediately, so if the channel is disabled, need to
> +		 * make sure MSA/MSB/ELS are set to 0 which means channel
> +		 * disabled.

I don't understand this comment. Either ELS = 0 is reserved or it can be
used. What is an output status?

> +		val |= PWM_IMX_TPM_CnSC_MSB;
> +		val |= (state->polarity == PWM_POLARITY_NORMAL) ?
> +			PWM_IMX_TPM_CnSC_ELS_NORMAL :
> +			PWM_IMX_TPM_CnSC_ELS_INVERSED;
> +	}
> +	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +	/* control the counter status */
> +	if (state->enabled != c.enabled) {
> +		val = readl(tpm->base + PWM_IMX_TPM_SC);
> +		if (state->enabled) {
> +			if (++tpm->enable_count == 1)
> +				val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +		} else {
> +			if (--tpm->enable_count == 0)
> +				val &= ~PWM_IMX_TPM_SC_CMOD;
> +		}
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
> +
> +	/* save last polarity setting */
> +	chan->polarity = state->polarity;
> +
> +	return 0;
> +}
> +
> +static int pwm_imx_tpm_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_param param;
> +	struct pwm_state real_state;
> +	int ret;
> +
> +	ret = pwm_imx_tpm_round_state(chip, &param, state, &real_state);
> +	if (ret)
> +		return -EINVAL;

return ret;

> +
> +	mutex_lock(&tpm->lock);
> +	ret = pwm_imx_tpm_apply_hw(chip, pwm, &real_state, &param);

IMHO it would be nice if the parameters to pwm_imx_tpm_round_state and
pwm_imx_tpm_apply_hw would be the same an in the same order. Apart from
being nicer to read this is also easier for the compiler.

> +	mutex_unlock(&tpm->lock);
> +
> +	return ret;
> +}
> +
> +static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct imx_tpm_pwm_channel *chan;
> +
> +	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
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
> +	kfree(pwm_get_chip_data(pwm));
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

It's unfortunate that pwmchip_remove can fail as the return value of
pwm_imx_tpm_remove is ignored. Also disabling the clock is bad then.
Fixing this is out of scope for this patch though. This needs changes in
the pwm core.

> +	return ret;
> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
