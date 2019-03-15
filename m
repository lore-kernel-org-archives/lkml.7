Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023221872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfCOJfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:35:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:35:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4jFW-0007K7-Lj; Fri, 15 Mar 2019 10:35:34 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4jFU-0006Ph-Aq; Fri, 15 Mar 2019 10:35:32 +0100
Date:   Fri, 15 Mar 2019 10:35:32 +0100
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
Message-ID: <20190315093532.xw5ivfkxrwvrkvix@pengutronix.de>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
 <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:46:51AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- use "PWM_IMX_" as macro definition prefix and "pwm_imx_" as function prefix;
> 	- improve the limitation txt;
> 	- return error for configuring period/prescale fail;
> 	- disable clock when driver probe failed and remove;
> 	- improve module build dependency;
> 	- introduce user_count to determine whether configuing period is allowed;
> 	- some logic improvement for setting duty/status etc.;
> ---
>  drivers/pwm/Kconfig       |  12 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 396 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 409 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..6117fe6 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -201,6 +201,18 @@ config PWM_IMX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx.
>  
> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +

I think this empty newline is unusual.

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
> index 9c676a0..64e036c 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
>  obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
> +obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> new file mode 100644
> index 0000000..f108f75
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,396 @@
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
> +#define PWM_IMX_TPM_GLOBAL	0x8
> +#define PWM_IMX_TPM_SC		0x10
> +#define PWM_IMX_TPM_CNT		0x14
> +#define PWM_IMX_TPM_MOD		0x18
> +#define PWM_IMX_TPM_C0SC	0x20
> +#define PWM_IMX_TPM_C0V		0x24
> +
> +#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
> +#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
> +#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
> +
> +#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
> +#define PWM_IMX_TPM_CnSC_MSnB	BIT(5)
> +#define PWM_IMX_TPM_CnSC_MSnA	BIT(4)
> +#define PWM_IMX_TPM_CnSC_ELSnB	BIT(3)
> +#define PWM_IMX_TPM_CnSC_ELSnA	BIT(2)
> +
> +#define PWM_IMX_TPM_SC_PS_MASK		0x7
> +#define PWM_IMX_TPM_MOD_MOD_MASK	0xffff
> +
> +#define PWM_IMX_TPM_MAX_COUNT		0xffff
> +
> +#define PWM_IMX_TPM_MAX_CHANNEL_NUM	6
> +
> +#define PWM_IMX_TPM_CnSC(n)	(PWM_IMX_TPM_C0SC + n * 0x8)
> +#define PWM_IMX_TPM_CnV(n)	(PWM_IMX_TPM_C0V + n * 0x8)

parenthesis around n please.

> +struct imx_tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mutex lock;
> +	u32 user_count;
> +	u32 chn_config[PWM_IMX_TPM_MAX_CHANNEL_NUM];
> +	bool chn_status[PWM_IMX_TPM_MAX_CHANNEL_NUM];
> +};
> +
> +#define to_imx_tpm_pwm_chip(_chip)	\
> +		container_of(_chip, struct imx_tpm_pwm_chip, chip)
> +
> +static int pwm_imx_tpm_config_counter(struct pwm_chip *chip, u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 period_cnt, val, div, saved_cmod;
> +	u64 tmp;
> +
> +	tmp = clk_get_rate(tpm->clk);
> +	tmp *= period;
> +	val = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (val < PWM_IMX_TPM_MAX_COUNT)

<= ?

> +		div = 0;
> +	else
> +		div = ilog2(roundup_pow_of_two(val /
> +			(PWM_IMX_TPM_MAX_COUNT + 1)));
> +	if (div > PWM_IMX_TPM_SC_PS_MASK) {

#define PWM_IMX_TPM_SC_PS	GENMASK(0, 2)

if (!FIELD_FIT(PWM_IMX_TPM_SC_PS, div)) {
	...

> +		dev_err(chip->dev,
> +			"failed to find valid prescale value!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* make sure counter is disabled for programming prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	saved_cmod = val & PWM_IMX_TPM_SC_CMOD;

saved_cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val) ?

> +	val &= ~PWM_IMX_TPM_SC_CMOD;
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);

As this interrupts the output, please only do it if necessary.

> +	/* set TPM counter prescale */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	val &= ~PWM_IMX_TPM_SC_PS_MASK;
> +	val |= div;

val |= FIELD_PREP(PWM_IMX_TPM_SC_PS_MASK, div);

> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	/*
> +	 * set period counter: according to RM, the MOD register is
> +	 * updated immediately when CMOD[1:0] = 2b'00 (counter disabled).

	updated immediately after CMOD[1:0] = 2b'00 above

> +	 */
> +	do_div(tmp, NSEC_PER_SEC);
> +	period_cnt = DIV_ROUND_CLOSEST_ULL(tmp, 1 << div)

The (partial) RHS is equivalent to

	(tmp + (1 << div) >> 1) >> div

which might be cheaper for the CPU to calculate.

> +			& PWM_IMX_TPM_MOD_MOD_MASK;

If it can happen, that this masking changes the result, this is an error
that needs handling. (And if not, drop it; maybe in favour of a
comment.)

> +	writel(period_cnt, tpm->base + PWM_IMX_TPM_MOD);
> +
> +	/* restore the clock mode */
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	val |= saved_cmod;
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	return 0;
> +}
> +
> +static void pwm_imx_tpm_config(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       u32 period,
> +			       u32 duty_cycle,
> +			       enum pwm_polarity polarity)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 duty_cnt, val;
> +	u64 tmp;
> +
> +	/* set duty counter */
> +	tmp = readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD_MASK;

I recommend storing this value in driver data.

> +	tmp *= duty_cycle;
> +	duty_cnt = DIV_ROUND_CLOSEST_ULL(tmp, period);
> +	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD_MASK,
> +		 tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));

Please align the 2nd line to the opening parenthesis.

> +
> +	/* set polarity */
> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	val &= ~(PWM_IMX_TPM_CnSC_ELSnB | PWM_IMX_TPM_CnSC_ELSnA |
> +		 PWM_IMX_TPM_CnSC_MSnA);
> +	val |= PWM_IMX_TPM_CnSC_MSnB;
> +	val |= polarity ? PWM_IMX_TPM_CnSC_ELSnA : PWM_IMX_TPM_CnSC_ELSnB;

I'd recommend not hard coding here that PWM_POLARITY_NORMAL evaluates to
false.

In the reference manual I have (Rev. F, 07/2017) MSnA is called MSA
only. Ditto for MSnB -> MSB, ELSnA -> ELSA, ELSnB -> ELSB. (Hmm, but it
is not entirely consistent. So Table 64-4 indeed has the 'n's.)

I wonder why MSA and MSB are two bits instead of making this a field of
width 2 with 2b10 meaning PWM mode. But maybe it's just me not
understanding the independent semantic of these two bits?

Reading the reference manual I'd say in PWM mode the semantic of ELSA
and ELSB is:

	On counter reload set the output to ELSB
	On counter match set the output to ELSA

Noting that in a comment would ease understanding the code here.

> +	/*
> +	 * polarity settings will enabled/disable output statue

s/statue/status/

> +	 * immediately, so here ONLY save the config and will be
> +	 * written into register when channel is enabled/disabled.

s/will be written/write it/

> +	 */
> +	tpm->chn_config[pwm->hwpwm] = val;
> +}

A comment here about how and when the values written in
pwm_imx_tpm_config take effect would be good.

> +static void pwm_imx_tpm_enable(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       bool enable)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u32 val, i;
> +
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	if (enable) {
> +		/* restore channel config */
> +		writel(tpm->chn_config[pwm->hwpwm],
> +			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +		/* start TPM counter anyway */
> +		val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	} else {
> +		/*
> +		 * When a channel is disabled, its polarity settings will be
> +		 * saved and its output will be disabled by clearing polarity
> +		 * setting, when channel is enabled, polarity settings will be
> +		 * restored and output will be enabled again.
> +		 */
> +		/* save channel config */
> +		tpm->chn_config[pwm->hwpwm] = readl(tpm->base +
> +			PWM_IMX_TPM_CnSC(pwm->hwpwm));

Doesn't tpm->chn_config[pwm->hwpwm] already contain the right value?
Please align the 2nd line to the opening parenthesis.

> +		/* disable channel */
> +		writel(PWM_IMX_TPM_CnSC_CHF,
> +			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));

Clearing CHF doens't disable the channel as I read the manual.

> +		for (i = 0; i < chip->npwm; i++)
> +			if (i != pwm->hwpwm && tpm->chn_status[i])

If you set tpm->chn_status[i] = false before this loop, you don't have
to care for i != pwm->hwpwm. If you maintain an "enable count" you don't
have to loop at all.

> +				break;
> +		if (i == chip->npwm) {
> +			/* stop TPM counter since all channels are disabled */
> +			val &= ~PWM_IMX_TPM_SC_CMOD;
> +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> +		}
> +	}
> +
> +	/* update channel statue */
> +	tpm->chn_status[pwm->hwpwm] = enable;
> +}
> +
> +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	u64 tmp;
> +	u32 val, rate;
> +
> +	mutex_lock(&tpm->lock);
> +
> +	/* get period */
> +	rate = clk_get_rate(tpm->clk);
> +	tmp = readl(tpm->base + PWM_IMX_TPM_MOD);
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	val &= PWM_IMX_TPM_SC_PS_MASK;
> +	tmp *= (1 << val) * NSEC_PER_SEC;
> +	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get duty cycle */
> +	tmp = readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +	tmp *= (1 << val) * NSEC_PER_SEC;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get polarity */
> +	val = readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	if (val & PWM_IMX_TPM_CnSC_ELSnA)
> +		state->polarity = PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity = PWM_POLARITY_NORMAL;
> +
> +	/* get channel status */
> +	state->enabled = tpm->chn_status[pwm->hwpwm] ? true : false;
> +
> +	mutex_unlock(&tpm->lock);
> +}
> +
> +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct pwm_state curstate;
> +	u32 duty_cycle = state->duty_cycle;
> +	int ret;
> +
> +	pwm_imx_tpm_get_state(chip, pwm, &curstate);
> +
> +	mutex_lock(&tpm->lock);

What should this lock protect? Does it hurt if the state changes between
pwm_imx_tpm_get_state releasing the lock and pwm_imx_tpm_apply taking
it?

> +
> +	if (state->period != curstate.period) {
> +		/*
> +		 * TPM counter is shared by multiple channels, so
> +		 * the prescale and period can NOT be modified when
> +		 * there are multiple channels used.

s/the //; s/used/in use/

> +		 */
> +		if (tpm->user_count != 1)
> +			return -EBUSY;

Ideally if say period = 37 is requested but currently we have period =
36 and configuring 37 would result in 36 anyhow, don't return EBUSY.

> +		ret = pwm_imx_tpm_config_counter(chip, state->period);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!state->enabled)
> +		duty_cycle = 0;

A comment above this block that explains why this is done would be
great (but see below).

> +
> +	if (state->duty_cycle != curstate.duty_cycle ||
> +	    state->polarity != curstate.polarity)
> +		pwm_imx_tpm_config(chip, pwm,
> +			state->period, duty_cycle, state->polarity);
> +
> +	if (state->enabled != curstate.enabled)
> +		pwm_imx_tpm_enable(chip, pwm, state->enabled);

This is a bit unintuitive I think. For example I had to think for a
while why you pass duty_cycle to pwm_imx_tpm_config() but check
state->duty_cycle in the if condition. I'd suggest:

	if (state->enabled == false) {
		/*
		 * configure for duty_cycle == 0 here? Wait until this
		 * setting is active?
		 */
		if (curstate.enabled)
			pwm_imx_tpm_enable(chip, pwm, false);
	} else {
		...

	}


> +
> +	mutex_unlock(&tpm->lock);
> +
> +	return 0;
> +}
> +
> +static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *dev)
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
> +static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +
> +	mutex_lock(&tpm->lock);
> +	tpm->user_count--;
> +	mutex_unlock(&tpm->lock);
> +}
> +
> +static const struct pwm_ops imx_tpm_pwm_ops = {
> +	.get_state = pwm_imx_tpm_get_state,
> +	.request = pwm_imx_tpm_request,
> +	.apply = pwm_imx_tpm_apply,
> +	.free = pwm_imx_tpm_free,
> +	.owner = THIS_MODULE,

Can you please group "request" with "free"? The order as defined in
struct pwm_ops would be optimal.

> +};
> +
> +static int pwm_imx_tpm_probe(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm;
> +	struct resource *res;
> +	int ret;
> +
> +	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
> +	if (!tpm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tpm);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tpm->base = devm_ioremap_resource(&pdev->dev, res);

You can use devm_platform_ioremap_resource instead of the two previous
calls.

> +	if (IS_ERR(tpm->base)) {
> +		ret = PTR_ERR(tpm->base);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "pwm ioremap failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	tpm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(tpm->clk)) {
> +		ret = PTR_ERR(tpm->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get pwm clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(tpm->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to prepare or enable clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	tpm->chip.dev = &pdev->dev;
> +	tpm->chip.ops = &imx_tpm_pwm_ops;
> +	tpm->chip.base = -1;
> +	tpm->chip.npwm = PWM_IMX_TPM_MAX_CHANNEL_NUM;

This is wrong, as some only have 2 channels?

> +	mutex_init(&tpm->lock);
> +
> +	ret = pwmchip_add(&tpm->chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
> +		clk_disable_unprepare(tpm->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pwm_imx_tpm_remove(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(tpm->clk);
> +
> +	return pwmchip_remove(&tpm->chip);

Wrong order. Before pwmchip_remove returns the PWM must stay functional.

> +}
> +
> +static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(tpm->clk);

You must not disable the clock if the PWM is in use.

> +	return 0;
> +}

The time I want to/can spend on community review is over now for this
week. I didn't look at all details yet but I think it is still worth to
send this mail out to not make you bored :-) Also I think further
thoughts by me will be eased if you address my comments here first.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
