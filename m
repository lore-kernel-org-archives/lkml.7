Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F592085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfCYJak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:30:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbfCYJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:30:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8Lvv-0006Hu-EO; Mon, 25 Mar 2019 10:30:19 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8Lvt-0007dU-4O; Mon, 25 Mar 2019 10:30:17 +0100
Date:   Mon, 25 Mar 2019 10:30:17 +0100
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
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V9 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190325093017.glw2wfjxga2rddmu@pengutronix.de>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553218974-20464-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:48:11AM +0000, Anson Huang wrote:
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
> Changes since V8:
> 	- add more limitation notes for period/duty update un-atomic limitations;
> 	- add waiting for period/duty update actually applied to HW;
> 	- move the duty update into period update function to make them to be updated
> 	  as together as possiable;
> 	- don't allow PS change if counter is running;
> 	- save channel polarity settings and return it directly when .get_state is called,
> 	  as the HW polarity setting could be impacted by enable status.
> ---
>  drivers/pwm/Kconfig       |  11 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 530 insertions(+)
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
> index 0000000..58af0915
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,518 @@
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
> + * - The period and duty changes are NOT atomic, if new period and
> + *   new duty are requested simultaneously when counter is running,
> + *   there could be a small window of running old duty with new
> + *   period, as the period is updated before duty in this driver, the
> + *   probability is very low, ONLY happen when the TPM counter changes
> + *   from MOD to zero between the consecutive update of period and
> + *   duty.

The window that this bug triggers is small, but if it does, the window
where the invalid combination is applied, isn't small---it's one
complete period if I'm not mistaken. So I'd write:

 - Changing period and duty cycle together isn't atomic. With the wrong
   timing it might happen that a period is produced with old duty cycle
   but new period settings.

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
> + * samantic of the two bits isn't orthogonal though, so they are treated

s/samantic/semantic/

> + * together as a 2-bit field here.
> + */
> +#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2)
> +#define PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED	0x1
> +#define PWM_IMX_TPM_CnSC_ELS_INVERSED	FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 1)
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
> +/* this function is supposed to be called with mutex hold */
> +static int pwm_imx_tpm_setup_period_duty(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 struct imx_tpm_pwm_param *p)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	unsigned long timeout;
> +	u32 val, cmod, cur_prescale;
> +
> +	val = readl(tpm->base + PWM_IMX_TPM_SC);
> +	cmod = FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> +	cur_prescale = FIELD_GET(PWM_IMX_TPM_SC_PS, val);
> +	if (cmod && cur_prescale != p->prescale)
> +		return -EBUSY;
> +
> +	/* set TPM counter prescale */
> +	val &= ~PWM_IMX_TPM_SC_PS;
> +	val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	/*
> +	 * set period count:
> +	 * if (CMOD[1:0] = 0:0) then MOD register is updated when MOD
> +	 * register is written.
> +	 *
> +	 * if (CMOD[1:0] ≠ 0:0), then MOD register is updated according
> +	 * to the CPWMS bit, that is:
> +	 *
> +	 * if the selected mode is not CPWM then MOD register is updated
> +	 * after MOD register was written and the TPM counter changes from
> +	 * MOD to zero.
> +	 *
> +	 * if the selected mode is CPWM then MOD register is updated after
> +	 * MOD register was written and the TPM counter changes from MOD
> +	 * to (MOD – 1).

Given that the driver doesn't make use of CPWM, this comment could be
simplified. I'd write:

	/*
	 * If the PWM is enabled (CMOD[1:0] ≠ 2b00), the period length
	 * is latched into hardware when the next period starts.
	 */

This is even true for the (here unused) CPWM mode. (The reference manual
isn't entirely clear here IMHO. I assume if MOD == 4000 and CNT == 2001
then MOD is then changed to 2000, the currently running period is
completed with a length of 4000 prescaled clk cycles?!)

> +	 */
> +	writel(p->mod, tpm->base + PWM_IMX_TPM_MOD);
> +
> +	/*
> +	 * set channel value:
> +	 * if (CMOD[1:0] = 0:0) then CnV register is updated when CnV
> +	 * register is written.
> +	 *
> +	 * if (CMOD[1:0] ≠ 0:0), then CnV register is updated according
> +	 * to the selected mode, that is:
> +	 *
> +	 * if the selected mode is output compare then CnV register is
> +	 * updated on the next TPM counter increment (end of the prescaler
> +	 * counting) after CnV register was written.
> +	 *
> +	 * if the selected mode is EPWM then CnV register is updated after
> +	 * CnV register was written and the TPM counter changes from MOD
> +	 * to zero.
> +	 *
> +	 * if the selected mode is CPWM then CnV register is updated after
> +	 * CnV register was written and the TPM counter changes from MOD
> +	 * to (MOD – 1).

This is similar to the above too verbose and covers stuff that is not
relevant for this driver. Also the used wording is not obvious if you
don't look into the reference manual.

> +	 */
> +	writel(p->val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +
> +	/* make sure MOD & CnV registers are updated */
> +	timeout = jiffies + msecs_to_jiffies(tpm->real_period /
> +					     NSEC_PER_MSEC + 1);
> +	while (readl(tpm->base + PWM_IMX_TPM_MOD) != p->mod
> +	       || readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm))
> +	       != p->val) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIME;
> +		cpu_relax();
> +	}
> +
> +	return 0;
> +}
> [...]
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
> +		ret = pwm_imx_tpm_setup_period_duty(chip, pwm, &param);
> +		if (ret)
> +			goto exit;
> +
> +		tpm->real_period = real_state.period;
> +	}
> +
> +	ret = pwm_imx_tpm_apply_hw(chip, pwm, &real_state);

It's unintuitive here that both pwm_imx_tpm_setup_period_duty and
pwm_imx_tpm_apply_hw (potentially) configure the duty cycle. I didn't
thought it to an end, but maybe this could be optimised?

> +exit:
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
> +	chan = devm_kzalloc(chip->dev, sizeof(*chan), GFP_KERNEL);

There is no advantage in using the devm variant here as the requested
memory is freed in .free anyhow. So this only adds additional memory
foodprint and runtime overhead.

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

The call to pwm_set_chip_data could better be done in the PWM core.

> +}

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
