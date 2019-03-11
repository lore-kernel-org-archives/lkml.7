Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ADD2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCKJ1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:27:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35059 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfCKJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:27:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3HCo-0005pT-TG; Mon, 11 Mar 2019 10:26:46 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h3HCm-0003af-RP; Mon, 11 Mar 2019 10:26:44 +0100
Date:   Mon, 11 Mar 2019 10:26:44 +0100
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
Subject: Re: [PATCH 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190311092644.a2x53zgxv2iseqao@pengutronix.de>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
 <1552288273-31028-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552288273-31028-3-git-send-email-Anson.Huang@nxp.com>
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

On Mon, Mar 11, 2019 at 07:16:16AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 277 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..23839ad 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -201,6 +201,15 @@ config PWM_IMX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx.
>  
> +config PWM_IMX_TPM
> +	tristate "i.MX TPM PWM support"
> +	depends on ARCH_MXC
> +	help
> +	  Generic PWM framework driver for i.MX TPM.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-imx-tpm.

On which imx platforms does this hardware unit exist? I'd say it makes
sense to mention this in the help text and even restrict availability to
enable this driver to these platforms. This ensures that the help text
stays helpful (because a reviewer will spot it if the restriction is
lifted but the help text isn't adapted accordingly).

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
> index 0000000..a53256a
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + */

Please add a link to the reference manual to the header.

> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define TPM_GLOBAL	0x8
> +#define TPM_SC		0x10
> +#define TPM_CNT		0x14
> +#define TPM_MOD		0x18
> +#define TPM_C0SC	0x20
> +#define TPM_C0V		0x24
> +
> +#define SC_CMOD		3

This seems to be an offset, why not defining it as BIT(3) instead?

> +#define SC_CPWMS	BIT(5)
> +#define MSnB		BIT(5)
> +#define MSnA		BIT(4)
> +#define ELSnB		BIT(3)
> +#define ELSnA		BIT(2)
> +
> +#define TPM_SC_PS_MASK		0x7
> +#define TPM_MOD_MOD_MASK	0xffff
> +
> +#define PERIOD_PERIOD_MAX	0x10000

I bet the maximum period is 0xffff, so this name is irritating.

> +#define PERIOD_DIV_MAX		8
> +
> +#define TPM_CHn_ADDR_OFFSET	0x8
> +#define DEFAULT_PWM_CHANNEL_NUM	2

Please add a common prefix to all these defines. Also it should be
obvious to which register a certain bit mask belongs to.

> +struct tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static const unsigned int prediv[8] = {
> +	1, 2, 4, 8, 16, 32, 64, 128
> +};

Given that prediv[i] == 1 << i I wonder if we really need this array.

> +#define to_tpm_pwm_chip(_chip)	container_of(_chip, struct tpm_pwm_chip, chip)
> +
> +static int tpm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	struct tpm_pwm_chip *tpm = to_tpm_pwm_chip(chip);
> +	unsigned int period_cycles, duty_cycles;
> +	unsigned long rate;
> +	u32 val, div = 0;
> +	u64 c;
> +	int ret;
> +
> +	rate = clk_get_rate(tpm->clk);

You must not call clk_get_rate if the clock is off.

> +	/* calculate the period_cycles and duty_cycles */
> +	while (1) {
> +		c = rate / prediv[div];
> +		c = c * period_ns;

You're loosing precision here. Consider:

	div = 2
	rate = 33333335
	period_ns = 30000000

Then you have c == 249999990000000 while the exact value is
250000012500000 which you achieve if you multiply with period_ns before
dividing by prediv[div].

> +		do_div(c, 1000000000);

NSEC_PER_SEC instead of 1000000000?

> +		if (c < PERIOD_PERIOD_MAX)
> +			break;
> +		div++;
> +		if (div >= 8)
> +			return -EINVAL;
> +	}

I'm sure div can be calculated without a loop.

> +	/* enable the clock before writing the register */
> +	if (!pwm_is_enabled(pwm)) {

If the unit is disabled, there is no need to actually configure period
and duty_cycle. Also if I understand correctly this might start the PWM
with whatever configuration was applied before which shouldn't happen.

> +		ret = clk_prepare_enable(tpm->clk);
> +		if (ret) {
> +			dev_err(chip->dev,
> +				"failed to prepare or enable clk %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	val = readl(tpm->base + TPM_SC);
> +	val &= ~TPM_SC_PS_MASK;
> +	val |= div;
> +	writel(val, tpm->base + TPM_SC);

If the unit ran with (say) div == 5 and a high duty cycle before and for
the new configuration you need div == 6 with a low duty cycle, can it
happen here that the output uses the new div value already with the high
duty cycle? If so, this is bad.

> +	period_cycles = c;
> +	c *= duty_ns;
> +	do_div(c, period_ns);
> +	duty_cycles = c;
> +
> +	writel(period_cycles & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);

Don't you need to add pwm->hwpwm * TPM_CHn_ADDR_OFFSET to the register
offset here? And if not, I assume this affects the other PWMs provided
by this hardware unit which is bad.

> +	writel(duty_cycles & TPM_MOD_MOD_MASK, tpm->base +
> +	       TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> +
> +	/* if pwm is not enabled, disable clk after setting */
> +	if (!pwm_is_enabled(pwm))
> +		clk_disable_unprepare(tpm->clk);
> +
> +	return 0;
> +}
> +
> +static int tpm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct tpm_pwm_chip *tpm = to_tpm_pwm_chip(chip);
> +	int ret;
> +	u32 val;
> +
> +	ret = clk_prepare_enable(tpm->clk);
> +	if (ret) {
> +		dev_err(chip->dev,
> +			"failed to prepare or enable clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * To enable a tpm channel, CPWMS = 0, MSnB:MSnA = 0x0,
> +	 * for TPM normal polarity ELSnB:ELSnA = 2b'10,
> +	 * inverse ELSnB:ELSnA = 2b'01
> +	 */
> +	val = readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> +	val &= ~(MSnB | MSnA | ELSnB | ELSnA);
> +	val |= MSnB;

If you set MSnB unconditionally, you don't need to clear it first.

> +	val |= pwm->state.polarity ? ELSnA : ELSnB;
> +
> +	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> +
> +	/* start the counter */
> +	val = readl(tpm->base + TPM_SC);
> +	val |= 0x1 << SC_CMOD;
> +	writel(val, tpm->base + TPM_SC);

If tpm_pwm_enable is called for the first PWM provided by the hardware,
how does this writel affect the second one?

> +	return 0;
> +}
> +
> +static void tpm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct tpm_pwm_chip *tpm = to_tpm_pwm_chip(chip);
> +
> +	clk_disable_unprepare(tpm->clk);

I assume this interrupts the currently running period immediately?! If
so, this is wrong. What is the resulting pin state if the clk is
disabled? Does it freeze (i.e. just stops on the level where it happend
to be) or does it get inactive? If the latter: Does it get inactive for
both possible polarities?

> +}
> +
> +static int tpm_pwm_set_polarity(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    enum pwm_polarity polarity)
> +{
> +	struct tpm_pwm_chip *tpm = to_tpm_pwm_chip(chip);
> +	int ret;
> +	u32 val;
> +
> +	/* enable the clock before writing the register */
> +	if (!pwm_is_enabled(pwm)) {
> +		ret = clk_prepare_enable(tpm->clk);
> +		if (ret) {
> +			dev_err(chip->dev,
> +				"failed to prepare or enable clk %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	val = readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> +	val &= ~(ELSnB | ELSnA);
> +	val |= pwm->state.polarity ? ELSnA : ELSnB;
> +	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
> +
> +	/* disable the clock after writing the register */
> +	if (!pwm_is_enabled(pwm))
> +		clk_disable_unprepare(tpm->clk);
> +
> +	return  0;
> +}
> +
> +static const struct pwm_ops tpm_pwm_ops = {
> +	.config		= tpm_pwm_config,
> +	.enable		= tpm_pwm_enable,
> +	.disable	= tpm_pwm_disable,
> +	.set_polarity	= tpm_pwm_set_polarity,
> +	.owner		= THIS_MODULE,

Please implement .apply instead of .config, .enable, .disable and
.set_polarity.

Also you align the = here but in other structs (e.g.
tpm_pwm_driver.driver) you don't. It's a bit a question of personal
preference what you do, but it should be consistent in a driver. If you
ask me, just use a single space before the assignment. Otherwise you
either have to touch the whole struct when a new and longer member is
added, or it looks really ugly afterwards because only some members have
a commonly aligned assignment.

> +};
> +
> +static int tpm_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct tpm_pwm_chip *tpm;
> +	struct resource *res;
> +	int ret;
> +
> +	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
> +	if (!tpm)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tpm->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(tpm->base))
> +		return PTR_ERR(tpm->base);
> +
> +	tpm->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(tpm->clk))
> +		return PTR_ERR(tpm->clk);

Please add a dev_err if devm_ioremap_resource or devm_clk_get fails,
unless the problem is EPROBE_DEFER.

> +	tpm->chip.dev = &pdev->dev;
> +	tpm->chip.ops = &tpm_pwm_ops;
> +	tpm->chip.base = -1;
> +	tpm->chip.npwm = DEFAULT_PWM_CHANNEL_NUM;
> +
> +	/* init pwm channel number if "fsl,pwm-number" is found in DT */
> +	ret = of_property_read_u32(np, "fsl,pwm-number", &tpm->chip.npwm);
> +	if (ret)
> +		dev_warn(&pdev->dev, "two pwm channels by default\n");

@Thierry: Can we please agree on a non-vendor specific property here?

> +	ret = pwmchip_add(&tpm->chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, tpm);

If you do this earlier---just after allocating the memory is fine---you
can simplify this a bit to:

	ret = pwmchip_add(&tpm->chip);
	if (ret)
		dev_err(&pdev->dev, "Failed to add pwm chip (%d)\n", ret);

	return ret;

> +
> +	return 0;
> +}
> +
> +static int tpm_pwm_remove(struct platform_device *pdev)
> +{
> +	struct tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&tpm->chip);
> +}
> +
> +static int __maybe_unused tpm_pwm_suspend(struct device *dev)
> +{
> +	struct tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(tpm->clk);

If the PWM is in use, it shouldn't stop on suspend.

> +	return 0;
> +}
> +
> +static int __maybe_unused tpm_pwm_resume(struct device *dev)
> +{
> +	struct tpm_pwm_chip *tpm = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(tpm->clk);
> +	if (ret) {
> +		dev_err(dev, "could not prepare or enable tpm clock\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +};
> +
> +static SIMPLE_DEV_PM_OPS(tpm_pwm_pm,
> +		 tpm_pwm_suspend, tpm_pwm_resume);
> +
> +static const struct of_device_id tpm_pwm_dt_ids[] = {
> +	{ .compatible = "fsl,imx-tpm-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, tpm_pwm_dt_ids);
> +
> +static struct platform_driver tpm_pwm_driver = {
> +	.driver = {
> +		.name = "tpm-pwm",
> +		.of_match_table = tpm_pwm_dt_ids,
> +		.pm = &tpm_pwm_pm,
> +	},
> +	.probe	= tpm_pwm_probe,
> +	.remove = tpm_pwm_remove,
> +};
> +module_platform_driver(tpm_pwm_driver);

The filename is pwm-imx-tpm. It would be great if this would relate to
the driver name and the used function prefix.

> +
> +MODULE_AUTHOR("Jacky Bai <ping.bai@nxp.com>");

Should Jacky Bai the author of this patch?

> +MODULE_DESCRIPTION("i.MX TPM PWM Driver");
> +MODULE_LICENSE("GPL v2");

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
