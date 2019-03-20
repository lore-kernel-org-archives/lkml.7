Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C72184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCTITO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:19:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51191 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:19:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6WR8-0001N6-F3; Wed, 20 Mar 2019 09:18:58 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h6WR6-0003NO-4n; Wed, 20 Mar 2019 09:18:56 +0100
Date:   Wed, 20 Mar 2019 09:18:56 +0100
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
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190320081856.wkw55pmw57i4ifdj@pengutronix.de>
References: <1553058067-18793-1-git-send-email-Anson.Huang@nxp.com>
 <1553058067-18793-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553058067-18793-3-git-send-email-Anson.Huang@nxp.com>
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

On Wed, Mar 20, 2019 at 05:06:21AM +0000, Anson Huang wrote:
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
> Changes since V6:
> 	- merge "config" and "enable" functions into ONE function pwm_imx_tpm_apply_hw;
> 	- save computation for confiuring counter, the "round_state" function will return
> 	  the registers value directly;
> 	- improve the logic in .apply;
> 	- return error when there is still PWM active during suspend callback.
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 428 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 440 insertions(+)
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
> index 0000000..02403d0
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,428 @@
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

#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	FIELD_PREP(PWM_IMX_TPM_SC_CMOD, 1)

?

> +#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
> +
> +#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
> +#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
> +#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
> +
> +/*
> + * The reference manual describes this field as two separate bits. The
> + * samantic of the two bits isn't orthogonal though, so they are treated
> + * together as a 2-bit field here.
> + */
> +#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2)
> +#define PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED	0x1
> +
> +#define PWM_IMX_TPM_MOD_MOD	GENMASK(15, 0)
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
> +	if (clock_unit <= PWM_IMX_TPM_MOD_MOD) {
> +		prescale = 0;
> +	} else {
> +		prescale = roundup_pow_of_two(clock_unit);
> +		prescale = ilog2(prescale) - 16;

This 16 should be a define to make it obvious where it comes from.

Maybe use:

	#define PWM_IMX_TPM_MOD_WIDTH	16
	#define PWM_IMX_TPM_MOD_MOD	GENMASK(PWM_IMX_TPM_MOD_WIDTH - 1, 0)

?

If clock_unit happens to be 0x10000, we end up with prescale = 0 which
is wrong. I think we need:

	} else {
		prescale = ilog2(clock_unit) + 1 - PWM_IMX_TPM_MOD_WIDTH;

without the roundup.

> +	}
> +
> +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
> +		return -ERANGE;
> +	p->prescale = prescale;
> +
> +	period_count = (clock_unit + ((1 << prescale) >> 1)) >> prescale;
> +	if (period_count > PWM_IMX_TPM_MOD_MOD)
> +		return -ERANGE;

This check (together with the right way to calculate prescale) is
theoretically superflous. period_count cannot be bigger than
PWM_IMX_TPM_MOD_MOD. I'd either drop that check or add a scary warning
to make people hitting this report the respective parameters.

> +	p->mod = period_count;
> +
> +	/* calculate real period HW can support */
> +	tmp = (u64)period_count << prescale;
> +	tmp *= NSEC_PER_SEC;
> +	real_state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/*
> +	 * if eventually the PWM output is LOW, either
> +	 * duty cycle is 0 or status is disabled, need
> +	 * to make sure the output pin is LOW.

s/LOW/inactive/, then it's also true for inversed polarity.

> +	 */
> +	if (!state->enabled)
> +		real_state->duty_cycle = 0;
> +	else
> +		real_state->duty_cycle = state->duty_cycle;
> +
> +	real_state->polarity = state->polarity;
> +	real_state->enabled = state->enabled;
> +
> +	return 0;
> +}
> +
> +static void pwm_imx_tpm_config_counter(struct pwm_chip *chip,
> +				       struct imx_tpm_pwm_param p)

Please pass p as a pointer. I think pwm_imx_tpm_setup_period is a better
name here.

> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 val, saved_cmod;
> +
> +	/* make sure counter is disabled for programming prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	saved_cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> +	if (saved_cmod) {
> +		val &= ~PWM_IMX_TPM_SC_CMOD;
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);

I thought we agreed on not stopping the counter if the PS field isn't
changed?

> +	}
> +
> +	/* set TPM counter prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);

val already holds this register value, no need to reread.

> +	val &= ~PWM_IMX_TPM_SC_PS;
> +	val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p.prescale);
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	/*
> +	 * set period count: according to RM, the MOD register is
> +	 * updated immediately after CMOD[1:0] = 2b'00 above
> +	 */

So the current period isn't completed? That's wrong.

> +	writel(p.mod, tpm->base + PWM_IMX_TPM_MOD);
> +
> +	/* restore the clock mode if necessary */
> +	if (saved_cmod) {
> +		val = readl(tpm->base + PWM_IMX_TPM_SC);
> +		val |= FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
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

"prescale" would be a better name here than "val". As in the previous
review round: Don't multiply by (1 << something).

> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get polarity */
> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ==
> +	    PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)
> +		state->polarity = PWM_POLARITY_INVERSED;
> +	else
> +		/*
> +		 * Assume reserved values (2b00 and 2b11) to yield
> +		 * normal polarity.
> +		 */
> +		state->polarity = PWM_POLARITY_NORMAL;
> +
> +	/* get channel status */
> +	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> +}
> +
> +static void pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
> +				 struct pwm_device *pwm,
> +				 struct pwm_state state)

Please pass a the struct pwm_state as a pointer, not as a value.

> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct pwm_state c;
> +	u32 val, sc_val;
> +	u64 tmp;
> +
> +	pwm_imx_tpm_get_state(chip, pwm, &c);
> +
> +	if (state.duty_cycle != c.duty_cycle) {
> +		/* set duty counter */
> +		tmp = readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
> +		tmp *= state.duty_cycle;
> +		val = DIV_ROUND_CLOSEST_ULL(tmp, state.period);
> +		writel(val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +	}
> +
> +	if (state.enabled != c.enabled) {

This is wrong. If the PWM was running (c.enabled == true) and you are
supposed to disable (state.enabled == false) you enable the hardware
once more.

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
> +		 */
> +		val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +		val &= ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA |
> +			 PWM_IMX_TPM_CnSC_MSB);
> +		sc_val = readl(tpm->base + PWM_IMX_TPM_SC);
> +		if (state.enabled) {
> +			val |= PWM_IMX_TPM_CnSC_MSB;
> +			val |= (state.polarity == PWM_POLARITY_NORMAL) ?
> +				FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x2) :
> +				FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x1);

Introduce PWM_IMX_TPM_CnSC_ELS_POLARITY_NORMAL and use it together with
PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED here. If you put the FIELD_PREP
into the definition the line doesn't get excessively long.

Maybe also add

	#define PWM_IMX_TPM_CnSC_ELS_INACTIVE FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0)

?

> +			if (++tpm->enable_count == 1) {
> +				/* start TPM counter */
> +				sc_val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +				writel(sc_val, tpm->base + PWM_IMX_TPM_SC);
> +			}
> +		} else {
> +			if (--tpm->enable_count == 0) {
> +				/* stop TPM counter */
> +				sc_val &= ~PWM_IMX_TPM_SC_CMOD;
> +				writel(sc_val, tpm->base + PWM_IMX_TPM_SC);
> +			}
> +		}
> +		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	}
> +}
> +
> +static int pwm_imx_tpm_apply(struct pwm_chip *chip,
> +			      struct pwm_device *pwm,
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
> +
> +	mutex_lock(&tpm->lock);
> +
> +	/*
> +	 * TPM counter is shared by multiple channels, so
> +	 * prescale and period can NOT be modified when
> +	 * there are multiple channels in use with different
> +	 * period settings.
> +	 */
> +	if (real_state.period != tpm->real_period) {
> +		if (tpm->user_count > 1) {
> +			ret = -EBUSY;
> +			goto exit;
> +		}
> +
> +		pwm_imx_tpm_config_counter(chip, param);
> +		tpm->real_period = real_state.period;
> +	}

Maybe add a comment that this could still be optimized. For example if
pwm_imx_tpm_round_state returned prescale = 5 but prescale is currently
6, you might still be able to configure

> +
> +	pwm_imx_tpm_apply_hw(chip, pwm, real_state);
> +
> +exit:
> +	mutex_unlock(&tpm->lock);
> +
> +	return ret;
> +}
> +
> +static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
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
> +	if (tpm->enable_count > 0)
> +		return -EBUSY;
> +
> +	clk_disable_unprepare(tpm->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (tpm->enable_count == 0) {

tpm->enable_count cannot be different from 0 here.

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
