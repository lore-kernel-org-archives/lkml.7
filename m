Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF9C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0220640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDhLNSgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfIQAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:07:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43781 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:07:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so641199pld.10;
        Mon, 16 Sep 2019 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGQICKpcervV/f86viOkB++yLxsxzlIcZcpff5TogD4=;
        b=LDhLNSgpP2tPlLRhJelbmx5Ekz+8nY89eW4yz9R2J48WLARAO77Ojhdmmo45RfykbZ
         kSo6NFJZNplkr4WqwgsDo1Fp3MEOMQl+gA1vPbYM5Ruqwox2ni87eu+dC5H4opsHFOtL
         xXysw6W9PCO8y3GFYZR67SoKbD1D1E53Afs71NHlJltWQqomg7kn2NgRINbFFFq4QaZC
         g9ZPEODlxkbvIKDYmm1wS9xwYxWTBX/+Ghs/c7fL7YSqva6SH0vMCUXF+Q/WHBXydcF+
         07ao2sdANeXMeAnUazIONYCPeDM8vQ1KquzoMlG8d2TSDryQ4zS+RR4agDMEiVnRVnX1
         fO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGQICKpcervV/f86viOkB++yLxsxzlIcZcpff5TogD4=;
        b=kjx9OEjp4TxYG+sIqAFnKoYhTMQREimhQ0FgtDhF3hre+1RWwEJnWu5hwZDCfHIZul
         AcJzgrMRqon4fjiXV8SMMsUuHMw9Qwizy9h6NAZaNWxn+IdCDQ/iCili4H5cWcLEiglZ
         oR9HeonWCG+vPVh+9rVwIPW1YxHWA4bYV1JoqK1rksTSLilj0TkRhLwA9pZMb/OETOtx
         2GzZOqjhbzsQu5k6TOJpgUm137hsckRJKfTkEKBa7fmcpqOSY30m7LBqBCMsbp0/WNIc
         To03lwmEQo5Kr51vylo9dCzFXW/G5I8xJV1aAhhTm1XfW9eNCpgipR123FoGjZe1uG3t
         ZAOg==
X-Gm-Message-State: APjAAAUcoVRoUAU4KCxo5EHYz10UgYUDXkvxTmjJBM2zLiRyfMkTCHXN
        vLsE39ujd67UfYA/R0Ks95c=
X-Google-Smtp-Source: APXvYqwnStqZdbH/7r4iGdgZClZ9YY/we/pQe6S/tGNwmXObj/MEZIHs6NwzYuE+NFBg/aaekyVADw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr823128pln.216.1568678864404;
        Mon, 16 Sep 2019 17:07:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id p20sm213382pgj.47.2019.09.16.17.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Sep 2019 17:07:44 -0700 (PDT)
Date:   Mon, 16 Sep 2019 17:07:25 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/2] ASoC: fsl_mqs: Add MQS component driver
Message-ID: <20190917000725.GF12789@Asurada-Nvidia.nvidia.com>
References: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
 <74dfc73a92d2df4213225abe7d2a3db82672fe0f.1568367274.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74dfc73a92d2df4213225abe7d2a3db82672fe0f.1568367274.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 05:42:14PM +0800, Shengjiu Wang wrote:
> MQS (medium quality sound), is used to generate medium quality
> audio via a standard digital output pin. It can be used to
> connect stereo speakers or headphones simply via power amplifier
> stages without an additional DAC chip. It only accepts 2-channel,
> LSB-valid 16bit, MSB shift-out first, frame sync asserting with
> the first bit of the frame, data shifted with the posedge of
> bit clock, 44.1 kHz or 48 kHz signals from SAI1 in left justified
> format; and it provides the SNR target as no more than 20dB for
> the signals below 10 kHz. The signals above 10 kHz will have
> worse THD+N values.
> 
> MQS provides only simple audio reproduction. No internal pop,
> click or distortion artifact reduction methods are provided.
> 
> The MQS receives the audio data from the SAI1 Tx section.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> Changes in v2
> - use devm_platform_ioremap_resource
> 
>  sound/soc/fsl/Kconfig   |  10 ++
>  sound/soc/fsl/Makefile  |   2 +
>  sound/soc/fsl/fsl_mqs.c | 333 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 sound/soc/fsl/fsl_mqs.c
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index aa99c008a925..65e8cd4be930 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -25,6 +25,16 @@ config SND_SOC_FSL_SAI
>  	  This option is only useful for out-of-tree drivers since
>  	  in-tree drivers select it automatically.
>  
> +config SND_SOC_FSL_MQS
> +	tristate "Medium Quality Sound (MQS) module support"
> +	depends on SND_SOC_FSL_SAI
> +	select REGMAP_MMIO
> +	help
> +	  Say Y if you want to add Medium Quality Sound (MQS)
> +	  support for the Freescale CPUs.
> +	  This option is only useful for out-of-tree drivers since
> +	  in-tree drivers select it automatically.
> +
>  config SND_SOC_FSL_AUDMIX
>  	tristate "Audio Mixer (AUDMIX) module support"
>  	select REGMAP_MMIO
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index c0dd04422fe9..8cde88c72d93 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -23,6 +23,7 @@ snd-soc-fsl-esai-objs := fsl_esai.o
>  snd-soc-fsl-micfil-objs := fsl_micfil.o
>  snd-soc-fsl-utils-objs := fsl_utils.o
>  snd-soc-fsl-dma-objs := fsl_dma.o
> +snd-soc-fsl-mqs-objs := fsl_mqs.o
>  
>  obj-$(CONFIG_SND_SOC_FSL_AUDMIX) += snd-soc-fsl-audmix.o
>  obj-$(CONFIG_SND_SOC_FSL_ASOC_CARD) += snd-soc-fsl-asoc-card.o
> @@ -33,6 +34,7 @@ obj-$(CONFIG_SND_SOC_FSL_SPDIF) += snd-soc-fsl-spdif.o
>  obj-$(CONFIG_SND_SOC_FSL_ESAI) += snd-soc-fsl-esai.o
>  obj-$(CONFIG_SND_SOC_FSL_MICFIL) += snd-soc-fsl-micfil.o
>  obj-$(CONFIG_SND_SOC_FSL_UTILS) += snd-soc-fsl-utils.o
> +obj-$(CONFIG_SND_SOC_FSL_MQS) += snd-soc-fsl-mqs.o
>  obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
>  
>  # MPC5200 Platform Support
> diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
> new file mode 100644
> index 000000000000..c1619a553514
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// ALSA SoC IMX MQS driver
> +//
> +// Copyright (C) 2014-2015 Freescale Semiconductor, Inc.
> +// Copyright 2019 NXP
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <sound/initval.h>
> +
> +#define REG_MQS_CTRL		0x00
> +
> +#define MQS_EN_MASK			(0x1 << 28)
> +#define MQS_EN_SHIFT			(28)
> +#define MQS_SW_RST_MASK			(0x1 << 24)
> +#define MQS_SW_RST_SHIFT		(24)
> +#define MQS_OVERSAMPLE_MASK		(0x1 << 20)
> +#define MQS_OVERSAMPLE_SHIFT		(20)
> +#define MQS_CLK_DIV_MASK		(0xFF << 0)
> +#define MQS_CLK_DIV_SHIFT		(0)
> +
> +/* codec private data */
> +struct fsl_mqs {
> +	struct regmap *regmap;
> +	struct clk *mclk;
> +	struct clk *ipg;
> +
> +	unsigned int reg_iomuxc_gpr2;
> +	unsigned int reg_mqs_ctrl;
> +	bool use_gpr;
> +};
> +
> +#define FSL_MQS_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> +#define FSL_MQS_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
> +
> +static int fsl_mqs_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct fsl_mqs *mqs_priv = snd_soc_component_get_drvdata(component);
> +	unsigned long mclk_rate;
> +	int div, res;
> +	int bclk, lrclk;
> +
> +	mclk_rate = clk_get_rate(mqs_priv->mclk);
> +	bclk = snd_soc_params_to_bclk(params);
> +	lrclk = params_rate(params);
> +
> +	/*
> +	 * mclk_rate / (oversample(32,64) * FS * 2 * divider ) = repeat_rate;
> +	 * if repeat_rate is 8, mqs can achieve better quality.
> +	 * oversample rate is fix to 32 currently.
> +	 */
> +	div = mclk_rate / (32 * lrclk * 2 * 8);
> +	res = mclk_rate % (32 * lrclk * 2 * 8);
> +
> +	if (res == 0 && div > 0 && div <= 256) {
> +		if (mqs_priv->use_gpr) {
> +			regmap_update_bits(mqs_priv->regmap, IOMUXC_GPR2,
> +					   IMX6SX_GPR2_MQS_CLK_DIV_MASK,
> +					   (div - 1) << IMX6SX_GPR2_MQS_CLK_DIV_SHIFT);
> +			regmap_update_bits(mqs_priv->regmap, IOMUXC_GPR2,
> +					   IMX6SX_GPR2_MQS_OVERSAMPLE_MASK, 0);
> +		} else {
> +			regmap_update_bits(mqs_priv->regmap, REG_MQS_CTRL,
> +					   MQS_CLK_DIV_MASK,
> +					   (div - 1) << MQS_CLK_DIV_SHIFT);
> +			regmap_update_bits(mqs_priv->regmap, REG_MQS_CTRL,
> +					   MQS_OVERSAMPLE_MASK, 0);
> +		}
> +	} else {
> +		dev_err(component->dev, "can't get proper divider\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_mqs_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	/* Only LEFT_J & SLAVE mode is supported. */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsl_mqs_startup(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct fsl_mqs *mqs_priv = snd_soc_component_get_drvdata(component);
> +
> +	if (mqs_priv->use_gpr)
> +		regmap_update_bits(mqs_priv->regmap, IOMUXC_GPR2,
> +				   IMX6SX_GPR2_MQS_EN_MASK,
> +				   1 << IMX6SX_GPR2_MQS_EN_SHIFT);
> +	else
> +		regmap_update_bits(mqs_priv->regmap, REG_MQS_CTRL,
> +				   MQS_EN_MASK,
> +				   1 << MQS_EN_SHIFT);
> +	return 0;
> +}
> +
> +static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct fsl_mqs *mqs_priv = snd_soc_component_get_drvdata(component);
> +
> +	if (mqs_priv->use_gpr)
> +		regmap_update_bits(mqs_priv->regmap, IOMUXC_GPR2,
> +				   IMX6SX_GPR2_MQS_EN_MASK, 0);
> +	else
> +		regmap_update_bits(mqs_priv->regmap, REG_MQS_CTRL,
> +				   MQS_EN_MASK, 0);
> +}
> +
> +const static struct snd_soc_component_driver soc_codec_fsl_mqs = {
> +	.idle_bias_on = 1,
> +	.non_legacy_dai_naming	= 1,
> +};
> +
> +static const struct snd_soc_dai_ops fsl_mqs_dai_ops = {
> +	.startup = fsl_mqs_startup,
> +	.shutdown = fsl_mqs_shutdown,
> +	.hw_params = fsl_mqs_hw_params,
> +	.set_fmt = fsl_mqs_set_dai_fmt,
> +};
> +
> +static struct snd_soc_dai_driver fsl_mqs_dai = {
> +	.name		= "fsl-mqs-dai",
> +	.playback	= {
> +		.stream_name	= "Playback",
> +		.channels_min	= 2,
> +		.channels_max	= 2,
> +		.rates		= FSL_MQS_RATES,
> +		.formats	= FSL_MQS_FORMATS,
> +	},
> +	.ops = &fsl_mqs_dai_ops,
> +};
> +
> +static const struct regmap_config fsl_mqs_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = REG_MQS_CTRL,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static int fsl_mqs_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *gpr_np = 0;
> +	struct fsl_mqs *mqs_priv;
> +	void __iomem *regs;
> +	int ret = 0;
> +
> +	mqs_priv = devm_kzalloc(&pdev->dev, sizeof(*mqs_priv), GFP_KERNEL);
> +	if (!mqs_priv)
> +		return -ENOMEM;
> +
> +	/* On i.MX6sx the MQS control register is in GPR domain
> +	 * But in i.MX8QM/i.MX8QXP the control register is moved
> +	 * to its own domain.
> +	 */
> +	if (of_device_is_compatible(np, "fsl,imx8qm-mqs"))
> +		mqs_priv->use_gpr = false;
> +	else
> +		mqs_priv->use_gpr = true;
> +
> +	if (mqs_priv->use_gpr) {
> +		gpr_np = of_parse_phandle(np, "gpr", 0);
> +		if (IS_ERR(gpr_np)) {
> +			dev_err(&pdev->dev, "failed to get gpr node by phandle\n");
> +			ret = PTR_ERR(gpr_np);
> +			goto out;
> +		}
> +
> +		mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
> +		if (IS_ERR(mqs_priv->regmap)) {
> +			dev_err(&pdev->dev, "failed to get gpr regmap\n");
> +			ret = PTR_ERR(mqs_priv->regmap);
> +			goto out;
> +		}
> +	} else {
> +		regs = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(regs))
> +			return PTR_ERR(regs);
> +
> +		mqs_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +							     "core",
> +							     regs,
> +							     &fsl_mqs_regmap_config);
> +		if (IS_ERR(mqs_priv->regmap)) {
> +			dev_err(&pdev->dev, "failed to init regmap: %ld\n",
> +				PTR_ERR(mqs_priv->regmap));
> +			return PTR_ERR(mqs_priv->regmap);
> +		}
> +
> +		mqs_priv->ipg = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(mqs_priv->ipg)) {
> +			dev_err(&pdev->dev, "failed to get the clock: %ld\n",
> +				PTR_ERR(mqs_priv->ipg));
> +			goto out;
> +		}
> +	}
> +
> +	mqs_priv->mclk = devm_clk_get(&pdev->dev, "mclk");
> +	if (IS_ERR(mqs_priv->mclk)) {
> +		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
> +			PTR_ERR(mqs_priv->mclk));
> +		goto out;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, mqs_priv);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
> +			&fsl_mqs_dai, 1);
> +out:
> +	if (!IS_ERR(gpr_np))
> +		of_node_put(gpr_np);
> +
> +	return ret;
> +}
> +
> +static int fsl_mqs_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int fsl_mqs_runtime_resume(struct device *dev)
> +{
> +	struct fsl_mqs *mqs_priv = dev_get_drvdata(dev);
> +
> +	if (mqs_priv->ipg)
> +		clk_prepare_enable(mqs_priv->ipg);
> +
> +	if (mqs_priv->mclk)
> +		clk_prepare_enable(mqs_priv->mclk);
> +
> +	if (mqs_priv->use_gpr)
> +		regmap_write(mqs_priv->regmap, IOMUXC_GPR2,
> +			     mqs_priv->reg_iomuxc_gpr2);
> +	else
> +		regmap_write(mqs_priv->regmap, REG_MQS_CTRL,
> +			     mqs_priv->reg_mqs_ctrl);
> +	return 0;
> +}
> +
> +static int fsl_mqs_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_mqs *mqs_priv = dev_get_drvdata(dev);
> +
> +	if (mqs_priv->use_gpr)
> +		regmap_read(mqs_priv->regmap, IOMUXC_GPR2,
> +			    &mqs_priv->reg_iomuxc_gpr2);
> +	else
> +		regmap_read(mqs_priv->regmap, REG_MQS_CTRL,
> +			    &mqs_priv->reg_mqs_ctrl);
> +
> +	if (mqs_priv->mclk)
> +		clk_disable_unprepare(mqs_priv->mclk);
> +
> +	if (mqs_priv->ipg)
> +		clk_disable_unprepare(mqs_priv->ipg);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops fsl_mqs_pm_ops = {
> +	SET_RUNTIME_PM_OPS(fsl_mqs_runtime_suspend,
> +			   fsl_mqs_runtime_resume,
> +			   NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +};
> +
> +static const struct of_device_id fsl_mqs_dt_ids[] = {
> +	{ .compatible = "fsl,imx8qm-mqs", },
> +	{ .compatible = "fsl,imx6sx-mqs", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_mqs_dt_ids);
> +
> +static struct platform_driver fsl_mqs_driver = {
> +	.probe		= fsl_mqs_probe,
> +	.remove		= fsl_mqs_remove,
> +	.driver		= {
> +		.name	= "fsl-mqs",
> +		.of_match_table = fsl_mqs_dt_ids,
> +		.pm = &fsl_mqs_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(fsl_mqs_driver);
> +
> +MODULE_AUTHOR("Shengjiu Wang <Shengjiu.Wang@nxp.com>");
> +MODULE_DESCRIPTION("MQS codec driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform: fsl-mqs");
> -- 
> 2.21.0
> 
