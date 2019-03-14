Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9180C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA792184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfCNJRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:17:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57771 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCNJRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:17:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4MU4-00016d-Mj; Thu, 14 Mar 2019 10:17:04 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h4MU2-000189-MR; Thu, 14 Mar 2019 10:17:02 +0100
Date:   Thu, 14 Mar 2019 10:17:02 +0100
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
Message-ID: <20190314091702.sooxvnzd4mqr2ilz@pengutronix.de>
References: <1552461970-20813-1-git-send-email-Anson.Huang@nxp.com>
 <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552461970-20813-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:31:16AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- improve coding style, function name's prefix;
> 	- improve Kconfig's help info;
> 	- use .apply instead for .enable/.disable/.config etc. to simply the code;
> 	- improve clock operation, make clock enabled during probe phase and ONLY disabled
> 	  when suspend, as register read/write need to sync with clock, keeping it enabled
> 	  makes the register read/write simple;
> 	- improve prescale calculation;
> 	- add error message print during probe for ioremap and clk get;
> ---
>  drivers/pwm/Kconfig       |  10 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 332 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..c1cbb43 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -201,6 +201,16 @@ config PWM_IMX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx.
>  
> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC

Can you please make this

	depends on ARCH_MXC || COMPILE_TEST
	depends on HAVE_CLK && HAS_IOMEM

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
> index 0000000..8c1a1ba
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
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
> +#include <linux/spinlock.h>
> +
> +#define TPM_GLOBAL	0x8
> +#define TPM_SC		0x10
> +#define TPM_CNT		0x14
> +#define TPM_MOD		0x18
> +#define TPM_C0SC	0x20
> +#define TPM_C0V		0x24

PWM_IMX_TPM_COV etc. please

> +
> +#define TPM_SC_CMOD_SHIFT	3
> +#define TPM_SC_CMOD_MASK	(0x3 << TPM_SC_CMOD_SHIFT)

If you use the macros that are documented in <linux/bitops.h> you don't
need these MASK and SHIFT stuff.

> +#define TPM_SC_CPWMS		BIT(5)
> +
> +#define TPM_CnSC_CHF		BIT(7)
> +#define TPM_CnSC_MSnB		BIT(5)
> +#define TPM_CnSC_MSnA		BIT(4)
> +#define TPM_CnSC_ELSnB		BIT(3)
> +#define TPM_CnSC_ELSnA		BIT(2)
> +
> +#define TPM_SC_PS_MASK		0x7
> +#define TPM_MOD_MOD_MASK	0xffff
> +
> +#define TPM_COUNT_MAX		0xffff
> +
> +#define TPM_CHn_ADDR_OFFSET	0x8
> +#define TPM_DEFAULT_PWM_CHANNEL_NUM	2

Is this better called "..._MAX_..." instead of "..._DEFAULT_..."? This
is used as array size below and when reading

	u32 chn_config[TPM_DEFAULT_PWM_CHANNEL_NUM];

I wonder if the actual number of PWMs can be bigger than the default.

> +struct imx_tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	spinlock_t lock;
> +	u32 chn_config[TPM_DEFAULT_PWM_CHANNEL_NUM];
> +	bool chn_status[TPM_DEFAULT_PWM_CHANNEL_NUM];
> +};
> +
> +#define to_imx_tpm_pwm_chip(_chip)	container_of(_chip, struct imx_tpm_pwm_chip, chip)
> +
> +static void imx_tpm_pwm_config_counter(struct pwm_chip *chip, u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	unsigned int period_cnt;
> +	u32 val, div;
> +	u64 tmp;
> +
> +	tmp = clk_get_rate(tpm->clk);
> +	tmp *= period;
> +	val = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (val < TPM_COUNT_MAX)
> +		div = 0;
> +	else
> +		div = ilog2(roundup_pow_of_two(val / TPM_COUNT_MAX));

Are you sure you have to divide by TPM_COUNT_MAX and not by
(TPM_COUNT_MAX + 1)?

> +	if (div > TPM_SC_PS_MASK) {
> +		dev_err(chip->dev,
> +			"failed to find valid prescale value!\n");
> +		return;

I think you should handle this failure and make imx_tpm_pwm_apply() fail.

> +	}
> +	/* set TPM counter prescale */
> +	val = readl(tpm->base + TPM_SC);
> +	val &= ~TPM_SC_PS_MASK;
> +	val |= div;
> +	writel(val, tpm->base + TPM_SC);

According to the documentation PS can only be written if the counter is
disabled, I think this isn't ensured here.

> +	/* set period counter */
> +	do_div(tmp, NSEC_PER_SEC);
> +	period_cnt = DIV_ROUND_CLOSEST_ULL(tmp, 1 << div);
> +	writel(period_cnt & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);

If there is already a value pending in the MOD register, another write
to it is ignored. A comment, why this cannot happen, would be
appropriate. (Note, I'm not sure this cannot happen.)

> +}
> +
> +static void imx_tpm_pwm_config(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	static bool tpm_cnt_initialized;
> +	unsigned int duty_cnt;
> +	u32 val;
> +	u64 tmp;
> +
> +	/*
> +	 * TPM counter is shared by multi channels, let's make it to be
> +	 * ONLY first channel can config TPM counter's precale and period
> +	 * count.
> +	 */
> +	if (!tpm_cnt_initialized) {
> +		imx_tpm_pwm_config_counter(chip, state->period);
> +		tpm_cnt_initialized = true;
> +	}

So the period can only be configured once. That is not as good as it
could be. You should allow a change whenever there is exactly one PWM in
use.

> +	/* set duty counter */
> +	tmp = readl(tpm->base + TPM_MOD) & TPM_MOD_MOD_MASK;
> +	tmp *= state->duty_cycle;
> +	duty_cnt = DIV_ROUND_CLOSEST_ULL(tmp, state->period);

Uah, you use state->period here even though for the 2nd PWM the Divider
might not be setup appropriately.

> [...]
> +static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm = to_imx_tpm_pwm_chip(chip);
> +	struct pwm_state curstate;
> +	unsigned long flags;
> +
> +	imx_tpm_pwm_get_state(chip, pwm, &curstate);
> +
> +	spin_lock_irqsave(&tpm->lock, flags);
> +
> +	if (state->period != curstate.period ||
> +	    state->duty_cycle != curstate.duty_cycle ||
> +	    state->polarity != curstate.polarity)
> +		imx_tpm_pwm_config(chip, pwm, state);
> +
> +	if (state->enabled != curstate.enabled)
> +		imx_tpm_pwm_enable(chip, pwm, state->enabled);

This is wrong. This sequence:

	pwm_apply_state(pwm, { .duty_cycle = 0, .period = 10000, .enabled = true });
	pwm_apply_state(pwm, { .duty_cycle = 10000, .period = 10000, .enabled = false });

must keep the output pin low which isn't guaranteed here.

> +
> +	spin_unlock_irqrestore(&tpm->lock, flags);
> +
> +	return 0;
> +}

I didn't look in depth through the complete driver yet, but there is
IIRC still some feedback on v1 that wasn't addressed in v2 (because v2
was sent before the last feedback). So I will look in more depth in v3
(assuming it comes late enough address the concerns from this mail).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
