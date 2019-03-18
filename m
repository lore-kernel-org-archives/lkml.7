Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4920835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSBLi2U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCRK1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:27:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37750 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfCRK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:27:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so3622997wmf.2;
        Mon, 18 Mar 2019 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=001qndSXYyGIzfpYO8fuXbLP6OIwBjapLr0OBQc9wjE=;
        b=NSBLi2U/p1Cgxq5u2WI6NX7DPJhPJIsmV2FXoRnbF22LBScAneBg0QlAy4SGtJJ+ni
         JyDKGlyqkiWAR7GDLuTlEjKPMs+pUAr60wyZObpblFJjSufM3FqpezX83cIoWXL882BF
         BHHZIKpPSAU9fT95UDDR1KKUl+z6kZyKCulOdvdR8An9/HK7Gr05NHBVkBXcVptugTF7
         2Uda6sOcxQ4496fSO4tfH2Xf4i1Crc5oWR3oOnz4D92qLeLlRxVorGBUxzTS4W3NmqF/
         f8HHtLi+5t+NhhFaUPgCm6S0QpRb8Jnka2VKWW6O9ykVMbeEY9cPfV9nOP9IMQTt9Thh
         GsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=001qndSXYyGIzfpYO8fuXbLP6OIwBjapLr0OBQc9wjE=;
        b=SUzUEcrDYbq0MBVoEX5A8V70G1dF7Kdrsu1CBcdWdDlHVLaHgeEb4V1copWHH6vD86
         vwEH28LsEntHyz/hy4D2YBfzUT2EfF1xQfbw4Bl4PTTJ/VpubJNiIbXr/FQX1FiNvFWD
         mGbQnmL6str1SMqBTmaFrZRQlMdaGGYgUln3LkjWKGdob+OJ7llM5vJu3r+g70YNpdcz
         bBVHswHKjoKSYasI8ovhadsgGlXB8+ZlaLwBebRfWekRgconqeXBt0LsWxzCLrDQ8k4Z
         bnmN96+6ejTO6jdTK9i+bC1jNPHOsmeQZUcVDj/+bCnLanSlhDirDDfZQjK0sLQsEloj
         /xtg==
X-Gm-Message-State: APjAAAVXUnjh5VIzIAj9qnWGKLcuPjj7WRx1RgGpl2nbVjbGuKF+245c
        ude1ReoD1zvdQmqPXvvkiGA=
X-Google-Smtp-Source: APXvYqx94IP2cEBcc5IyqBRd9V64hjn/1nvB6oE7BqhFgudrRYjv70wK0Eodgu9RVIP+RFlKKl7s3Q==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr6804912wmb.7.1552904862659;
        Mon, 18 Mar 2019 03:27:42 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id y66sm17192498wmd.37.2019.03.18.03.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 03:27:41 -0700 (PDT)
Date:   Mon, 18 Mar 2019 11:27:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/5] pwm: Add i.MX TPM PWM driver support
Message-ID: <20190318102740.GE17565@ulmo>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <1552894581-3391-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 07:41:42AM +0000, Anson Huang wrote:
> i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
> inside, add TPM PWM driver support.

I think this could be improved. You're basically restating the subject
here, but the commit message gives you a good place to provide more
information about the capabilities and restrictions. For example if this
supports polarity, mention it in the commit message.

Something that also looks very interesting is how this supports
detection of the number of channels, so make sure to mention that as
well.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- improve register read/write using bit field operations;
> 	- correct some logic issue;
> 	- ONLY disable clock when PWM is NOT in use during suspend;
> 	- add some comments for PWM mode settings;
> 	- fix some spelling errors;
> 	- reading channel number from register instead of using fix value.
> ---
>  drivers/pwm/Kconfig       |  11 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-imx-tpm.c | 436 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 448 insertions(+)
>  create mode 100644 drivers/pwm/pwm-imx-tpm.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 54f8238..3ea0391 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -210,6 +210,17 @@ config PWM_IMX27
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx27.
> =20
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
> @@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
>  obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> +obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> new file mode 100644
> index 0000000..12cb16c
> --- /dev/null
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -0,0 +1,436 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + *
> + * Limitations:
> + * - The TPM counter and period counter are shared between
> + *   multiple channels, so all channels should use same period
> + *   settings.

This sounds like something that you may want to also highlight in the
device tree bindings.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
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
> +#define PWM_IMX_TPM_C0SC	0x20
> +#define PWM_IMX_TPM_C0V		0x24
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
> +#define PWM_IMX_TPM_CnSC_ELSB	BIT(3)
> +#define PWM_IMX_TPM_CnSC_ELSA	BIT(2)
> +
> +#define PWM_IMX_TPM_MOD_MOD	GENMASK(15, 0)
> +
> +#define PWM_IMX_TPM_MAX_COUNT		0xffff
> +
> +#define PWM_IMX_TPM_MAX_CHANNEL_NUM	6
> +
> +#define PWM_IMX_TPM_CnSC(n)	(PWM_IMX_TPM_C0SC + (n) * 0x8)
> +#define PWM_IMX_TPM_CnV(n)	(PWM_IMX_TPM_C0V + (n) * 0x8)

You never use the C0SC and C0V registers other than as the base of these
indexed registers. I think it makes more sense to replace the C0SC and
C0V register definitions above with these.

> +struct imx_tpm_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	struct mutex lock;
> +	u32 user_count;
> +	u32 enable_count;
> +	u32 chn_config[PWM_IMX_TPM_MAX_CHANNEL_NUM];
> +	bool chn_status[PWM_IMX_TPM_MAX_CHANNEL_NUM];

I suggest you use per PWM data. That way you can attach the data
directly per PWM channel instead of having to carry the array here.

> +};
> +
> +#define to_imx_tpm_pwm_chip(_chip)	\
> +		container_of(_chip, struct imx_tpm_pwm_chip, chip)

I'd prefer this to be a static inline function.

> +static int pwm_imx_tpm_config_counter(struct pwm_chip *chip, u32 period)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	u32 period_cnt, val, div, saved_cmod;
> +	u64 tmp;
> +
> +	tmp =3D clk_get_rate(tpm->clk);
> +	tmp *=3D period;
> +	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
> +	if (val <=3D PWM_IMX_TPM_MAX_COUNT)
> +		div =3D 0;
> +	else
> +		div =3D ilog2(roundup_pow_of_two(val /
> +			(PWM_IMX_TPM_MAX_COUNT + 1)));

Maybe use some temporary variables to make this easier to read.

> +	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, div))) {
> +		dev_err(chip->dev,
> +			"failed to find valid prescale value!\n");
> +		return -EINVAL;
> +	}
> +
> +	/* make sure counter is disabled for programming prescale */
> +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> +	saved_cmod =3D FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
> +	if (saved_cmod) {
> +		val &=3D ~PWM_IMX_TPM_SC_CMOD;
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
> +
> +	/* set TPM counter prescale */
> +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> +	val &=3D ~PWM_IMX_TPM_SC_PS;
> +	val |=3D FIELD_PREP(PWM_IMX_TPM_SC_PS, div);
> +	writel(val, tpm->base + PWM_IMX_TPM_SC);
> +
> +	/*
> +	 * set period counter: according to RM, the MOD register is
> +	 * updated immediately after CMOD[1:0] =3D 2b'00 above
> +	 */
> +	do_div(tmp, NSEC_PER_SEC);
> +	period_cnt =3D (tmp + ((1 << div) >> 1)) >> div;
> +	if (period_cnt > PWM_IMX_TPM_MOD_MOD) {
> +		dev_err(chip->dev,
> +			"failed to find valid period count!\n");
> +		return -EINVAL;
> +	}

I think you should move the computations and the check to an earlier
point so that you avoid erroring out after you've already written some
of the values. Part of the idea of the atomic API is that it allows you
to check a configuration for validity before you write any registers so
that you either apply a working configuration or none at all. With the
above you could easily end up halfway through the configuration and
leave the PWM in a non-working state.

> +	writel(period_cnt, tpm->base + PWM_IMX_TPM_MOD);
> +
> +	/* restore the clock mode if necessary */
> +	if (saved_cmod) {
> +		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> +		val |=3D FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
> +		writel(val, tpm->base + PWM_IMX_TPM_SC);
> +	}
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
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	u32 duty_cnt, val;
> +	u64 tmp;
> +
> +	/* set duty counter */
> +	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
> +	tmp *=3D duty_cycle;
> +	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, period);
> +	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD,
> +	       tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +
> +	/*
> +	 * set polarity (for edge-aligned PWM modes)
> +	 *
> +	 * CPWMS  MSB:MSA  ELSB:ELSA  Mode  Configuration
> +	 * 0	  10	   10	      PWM   High-true pulse
> +	 * 0	  10	   00	      PWM   Reserved
> +	 * 0	  10	   01	      PWM   Low-true pulse
> +	 * 0	  10	   11	      PWM   Reserved
> +	 *
> +	 * High-true pulse: clear output on counter match, set output on
> +	 * counter reload, set output when counter first enabled or paused.
> +	 *
> +	 * Low-true pulse: set output on counter match, clear output on
> +	 * counter reload, clear output when counter first enabled or paused.
> +	 */
> +
> +	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	val &=3D ~(PWM_IMX_TPM_CnSC_ELSB | PWM_IMX_TPM_CnSC_ELSA |
> +		 PWM_IMX_TPM_CnSC_MSA);
> +	val |=3D PWM_IMX_TPM_CnSC_MSB;
> +	val |=3D (polarity =3D=3D PWM_POLARITY_NORMAL) ?
> +		PWM_IMX_TPM_CnSC_ELSB : PWM_IMX_TPM_CnSC_ELSA;
> +	/*
> +	 * polarity settings will enabled/disable output status
> +	 * immediately, so here ONLY save the config and write
> +	 * it into register when channel is enabled/disabled.
> +	 */
> +	tpm->chn_config[pwm->hwpwm] =3D val;
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
> + * when a channel is enabled, its polarity settings will be restored

"when" -> "When".

> + * and output will be enabled again.
> + */
> +static void pwm_imx_tpm_enable(struct pwm_chip *chip,
> +			       struct pwm_device *pwm,
> +			       bool enable)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	u32 val;
> +
> +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> +	if (enable) {
> +		/* restore channel config */
> +		writel(tpm->chn_config[pwm->hwpwm],
> +		       tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +		if (++tpm->enable_count =3D=3D 1) {
> +			/* start TPM counter */
> +			val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> +		}
> +	} else {
> +		/* disable channel */
> +		val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +		val &=3D ~(PWM_IMX_TPM_CnSC_MSA | PWM_IMX_TPM_CnSC_MSB |
> +			 PWM_IMX_TPM_CnSC_ELSB | PWM_IMX_TPM_CnSC_ELSA);
> +		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +
> +		if (--tpm->enable_count =3D=3D 0) {
> +			/* stop TPM counter since all channels are disabled */
> +			val &=3D ~PWM_IMX_TPM_SC_CMOD;
> +			writel(val, tpm->base + PWM_IMX_TPM_SC);
> +		}
> +	}
> +
> +	/* update channel status */
> +	tpm->chn_status[pwm->hwpwm] =3D enable;
> +}
> +
> +static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	u64 tmp;
> +	u32 val, rate;
> +
> +	/* get period */
> +	rate =3D clk_get_rate(tpm->clk);
> +	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD);
> +	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
> +	val &=3D PWM_IMX_TPM_SC_PS;
> +	tmp *=3D (1 << val) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get duty cycle */
> +	tmp =3D readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
> +	tmp *=3D (1 << val) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
> +
> +	/* get polarity */
> +	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> +	if (val & PWM_IMX_TPM_CnSC_ELSA)
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	/* get channel status */
> +	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
> +}
> +
> +static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +	struct pwm_state curstate;
> +	int ret;
> +
> +	mutex_lock(&tpm->lock);
> +
> +	pwm_imx_tpm_get_state(chip, pwm, &curstate);
> +
> +	if (state->period !=3D curstate.period) {
> +		/*
> +		 * TPM counter is shared by multiple channels, so
> +		 * prescale and period can NOT be modified when
> +		 * there are multiple channels in use.
> +		 */
> +		if (tpm->user_count !=3D 1)
> +			return -EBUSY;
> +		ret =3D pwm_imx_tpm_config_counter(chip, state->period);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (state->enabled =3D=3D false) {
> +		/*
> +		 * if eventually the PWM output is LOW, either
> +		 * duty cycle is 0 or status is disabled, need
> +		 * to make sure the output pin is LOW.
> +		 */
> +		pwm_imx_tpm_config(chip, pwm, state->period,
> +				   0, state->polarity);
> +		if (curstate.enabled)
> +			pwm_imx_tpm_enable(chip, pwm, false);
> +	} else {
> +		pwm_imx_tpm_config(chip, pwm, state->period,
> +				   state->duty_cycle, state->polarity);
> +		if (!curstate.enabled)
> +			pwm_imx_tpm_enable(chip, pwm, true);

Doesn't this mean that you won't be applying changes to the polarity
while a PWM is enabled? That seems wrong. Granted, you may usually not
run into that, but if you can't support it I think you should at least
return an error if you detect that the user wants to change polarity
while the PWM is enabled.

> +	}
> +
> +	mutex_unlock(&tpm->lock);
> +
> +	return 0;
> +}
> +
> +static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device =
*dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +
> +	mutex_lock(&tpm->lock);
> +	tpm->user_count++;
> +	mutex_unlock(&tpm->lock);
> +
> +	return 0;
> +}
> +
> +static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *d=
ev)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
> +
> +	mutex_lock(&tpm->lock);
> +	tpm->user_count--;
> +	mutex_unlock(&tpm->lock);
> +}
> +
> +static const struct pwm_ops imx_tpm_pwm_ops =3D {
> +	.request =3D pwm_imx_tpm_request,
> +	.free =3D pwm_imx_tpm_free,
> +	.get_state =3D pwm_imx_tpm_get_state,
> +	.apply =3D pwm_imx_tpm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int pwm_imx_tpm_probe(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm;
> +	int ret;
> +	u32 val;
> +
> +	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
> +	if (!tpm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, tpm);
> +
> +	tpm->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tpm->base)) {
> +		ret =3D PTR_ERR(tpm->base);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "pwm ioremap failed %d\n", ret);

I don't think devm_platform_ioremap_resource() will ever return
-EPROBE_DEFER. Also, there's no need to print an error here since
devm_ioremap_resource() prints one for any possible error condition
anyway.

> +		return ret;
> +	}
> +
> +	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(tpm->clk)) {
> +		ret =3D PTR_ERR(tpm->clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get pwm clk %d\n", ret);

I think it's better to clarify that you're outputting an error (rather
than a clock index) by separating the error code with a ':'. Also these
error messages are easier to read if you spell out words: "clk" ->
"clock". Also: "pwm" -> "PWM".

> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(tpm->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to prepare or enable clk %d\n", ret);

Same comments as above.

> +		return ret;
> +	}
> +
> +	tpm->chip.dev =3D &pdev->dev;
> +	tpm->chip.ops =3D &imx_tpm_pwm_ops;
> +	tpm->chip.base =3D -1;
> +	/* get channel number */
> +	val =3D readl(tpm->base + PWM_IMX_TPM_PARAM);
> +	tpm->chip.npwm =3D FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);

The comment is misleading, better would be "get number of channels".
Also, please use blank lines to increase readability. You could leave a
blank line before the comment, for example.

> +
> +	mutex_init(&tpm->lock);
> +
> +	ret =3D pwmchip_add(&tpm->chip);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);

"failed to add PWM chip: %d"

> +		clk_disable_unprepare(tpm->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pwm_imx_tpm_remove(struct platform_device *pdev)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
> +	int ret =3D pwmchip_remove(&tpm->chip);
> +
> +	clk_disable_unprepare(tpm->clk);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
> +
> +	if (tpm->enable_count =3D=3D 0)
> +		clk_disable_unprepare(tpm->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
> +{
> +	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	if (tpm->enable_count =3D=3D 0) {
> +		ret =3D clk_prepare_enable(tpm->clk);
> +		if (ret)
> +			dev_err(dev,
> +				"failed to prepare or enable clk %d\n",

"failed to prepare or enable clock: %d"

> +				ret);
> +	}
> +
> +	return ret;
> +};

Your handling of the clock seems strange here. Basically in the above
you always keep the clock on and you only disable it if there are no
users and you're going to suspend.

Why do you need to keep an extra reference count anyway? Or why keep the
clock on all the time? Can't you just do a clk_prepare_enable() every
time somebody enables the PWM? The CCF already has built-in reference
counting, so I'm not sure you really need to duplicate that here.

Thierry

> +
> +static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
> +			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
> +
> +static const struct of_device_id imx_tpm_pwm_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx-tpm-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
> +
> +static struct platform_driver imx_tpm_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "imx-tpm-pwm",
> +		.of_match_table =3D imx_tpm_pwm_dt_ids,
> +		.pm =3D &imx_tpm_pwm_pm,
> +	},
> +	.probe	=3D pwm_imx_tpm_probe,
> +	.remove =3D pwm_imx_tpm_remove,
> +};
> +module_platform_driver(imx_tpm_pwm_driver);
> +
> +MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
> +MODULE_DESCRIPTION("i.MX TPM PWM Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.7.4
>=20

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPcpoACgkQ3SOs138+
s6EHbg/8ChX+pTK8uIoERo+CziqQwY01EnNVxxJxw8sLKCaiATzSwAifBf86qSBF
5J06WM/RVT0DoJ727eDabt9/hiWFwox6lgSED0afg2fEQ0ueP3QPPDBit4pP7jMY
SbWQD7hdt9Y34XBJD9aSsA2AUF4UVVK1r+NZ35D4GAfMa8Ccr6YAPfuFEAJ8O+HP
8Yct+VXY3t3v+GoeLClLEso0SwWecyrPvLZ2psIONOA/HAnAWuH/ZelqwB3FWGAx
u1BqkstN94Qt6zHA8Qwd8uuwMuiRSY6U5xVULq9z3WttIdp44b9kMvEpdgbRbkEk
6fLBC/KbMJk9h+E6lIveJpxBwo3JvjqE6QHzV12w7RgJJu5KTFMcGtobsD7jsB/g
W42lHrYdQAPuca1VG3iv9InvYuej7he/C3WFwmA5Fu5n1Z2EeF6ilP1rYa9TvAfQ
2E1qTlTPF1JDlvD4Qb8shfPMqnvqlCyoTyI7z8gCEOZGjd3NEFnrTbXRaF3qabM9
1zjumLCkVu5IenPA9uWpLlWnVj062yRvRecZXjZ0JWAU+1nxSI8C8kriL4f3ya9T
hj9dKlrWQoMeWiif17y73JgbBugosGsGTTYrGr1xdW//zRvXqVf+d43oe0jVAySy
ADkmqg6gruSv8X8Rgyd4IZgucqxTRZ9O4l7NEhpBh9E+uamBIvI=
=TODc
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
