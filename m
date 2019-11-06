Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE00C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0066214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfKFQvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:51:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:62357 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbfKFQvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:51:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:51:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="353532224"
Received: from pdblomfi-mobl.gar.corp.intel.com (HELO [10.254.107.145]) ([10.254.107.145])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2019 08:51:20 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v2 2/7] ASoC: amd: Refactoring of DAI
 from DMA driver
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6768c0eb-003c-398b-6b44-8167d44b3cfe@linux.intel.com>
Date:   Wed, 6 Nov 2019 10:31:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573137364-5592-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 8:35 AM, Ravulapati Vishnu vardhan rao wrote:
> Asoc: PCM DMA driver should only have dma ops.
> So Removed all DAI related functionality.
> Refactoring the PCM DMA diver code.
> Added new file containing only DAI ops.
> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/Makefile        |   2 +
>   sound/soc/amd/raven/acp3x-i2s.c     | 268 ++++++++++++++++++++++++++++++++++++
>   sound/soc/amd/raven/acp3x-pcm-dma.c | 232 ++-----------------------------
>   sound/soc/amd/raven/acp3x.h         |  42 ++++++
>   4 files changed, 326 insertions(+), 218 deletions(-)
>   create mode 100644 sound/soc/amd/raven/acp3x-i2s.c
> 
> diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
> index 108d1ac..8eef292 100644
> --- a/sound/soc/amd/raven/Makefile
> +++ b/sound/soc/amd/raven/Makefile
> @@ -1,6 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   # Raven Ridge platform Support
>   snd-pci-acp3x-objs	:= pci-acp3x.o
> +snd-acp3x-i2s-objs	:= acp3x-i2s.o
>   snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
>   obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
> +obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-acp3x-i2s.o
>   obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-acp3x-pcm-dma.o
> diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
> new file mode 100644
> index 0000000..728e757
> --- /dev/null
> +++ b/sound/soc/amd/raven/acp3x-i2s.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// AMD ALSA SoC PCM Driver
> +//
> +//Copyright 2016 Advanced Micro Devices, Inc.
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dai.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "acp3x.h"
> +
> +#define DRV_NAME "acp3x-i2s"
> +
> +static int acp3x_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +{
> +
> +	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +
> +	case SND_SOC_DAIFMT_I2S:
> +		adata->tdm_mode = false;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +			adata->tdm_mode = true;
> +			break;

alignment is off

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int acp3x_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
> +		u32 rx_mask, int slots, int slot_width)
> +{
> +	u32 val = 0;

init not needed

> +	u16 slot_len;
> +
> +	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	switch (slot_width) {
> +	case SLOT_WIDTH_8:
> +		slot_len = 8;
> +		break;
> +	case SLOT_WIDTH_16:
> +		slot_len = 16;
> +		break;
> +	case SLOT_WIDTH_24:
> +		slot_len = 24;
> +		break;
> +	case SLOT_WIDTH_32:
> +		slot_len = 0;

That looks suspicious or a comment would help.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_ITER);
> +	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
> +	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
> +
> +	val = (FRM_LEN | (slots << 15) | (slot_len << 18));
> +	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
> +	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
> +
> +	adata->tdm_fmt = val;
> +	return 0;
> +}
> +
> +static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *dai)
> +{
> +	u32 val = 0;
> +	struct i2s_stream_instance *rtd = substream->runtime->private_data;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_U8:
> +	case SNDRV_PCM_FORMAT_S8:
> +		rtd->xfer_resolution = 0x0;
> +		break;
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		rtd->xfer_resolution = 0x02;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		rtd->xfer_resolution = 0x04;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		rtd->xfer_resolution = 0x05;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> +	val = val | (rtd->xfer_resolution  << 3);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +	else
> +		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);

for the capture case, you didn't initially read from IRER, so you are 
doing a read-modify-write for playback but write for capture.

maybe that's legit but a comment would help then.

> +
> +	return 0;
> +}
> +
> +static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +	struct i2s_stream_instance *rtd = substream->runtime->private_data;
> +	u32 val, period_bytes;
> +
> +	period_bytes = frames_to_bytes(substream->runtime,
> +			substream->runtime->period_size);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		rtd->bytescount = acp_get_byte_count(rtd,
> +						substream->stream);
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			rv_writel(period_bytes, rtd->acp3x_base +
> +					mmACP_BT_TX_INTR_WATERMARK_SIZE);
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			val = val | BIT(0);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		} else {
> +			rv_writel(period_bytes, rtd->acp3x_base +
> +					mmACP_BT_RX_INTR_WATERMARK_SIZE);
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> +			val = val | BIT(0);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);

and here you separated the reads for ITER and IRER, so my comment above 
likely points to a mistake.

> +		}
> +		rv_writel(1, rtd->acp3x_base + mmACP_BTTDM_IER);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			val = val & ~BIT(0);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		} else {
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> +			val = val & ~BIT(0);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +		}
> +		rv_writel(0, rtd->acp3x_base + mmACP_BTTDM_IER);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct snd_soc_dai_ops acp3x_i2s_dai_ops = {
> +	.hw_params = acp3x_i2s_hwparams,
> +	.trigger   = acp3x_i2s_trigger,
> +	.set_fmt = acp3x_i2s_set_fmt,
> +	.set_tdm_slot = acp3x_i2s_set_tdm_slot,
> +};
> +
> +static const struct snd_soc_component_driver acp3x_dai_component = {
> +	.name           = "acp3x-i2s",
> +};
> +
> +static struct snd_soc_dai_driver acp3x_i2s_dai = {
> +	.playback = {
> +		.rates = SNDRV_PCM_RATE_8000_96000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
> +			SNDRV_PCM_FMTBIT_U8 |
> +			SNDRV_PCM_FMTBIT_S24_LE |
> +			SNDRV_PCM_FMTBIT_S32_LE,
> +		.channels_min = 2,
> +		.channels_max = 8,
> +
> +		.rate_min = 8000,
> +		.rate_max = 96000,
> +	},
> +	.capture = {
> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
> +			SNDRV_PCM_FMTBIT_U8 |
> +			SNDRV_PCM_FMTBIT_S24_LE |
> +			SNDRV_PCM_FMTBIT_S32_LE,
> +		.channels_min = 2,
> +		.channels_max = 2,
> +		.rate_min = 8000,
> +		.rate_max = 48000,
> +	},
> +	.ops = &acp3x_i2s_dai_ops,
> +};
> +
> +
> +static int acp3x_dai_probe(struct platform_device *pdev)
> +{
> +	int status;
> +	struct resource *res;
> +	struct i2s_dev_data *adata;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +
> +	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
> +			GFP_KERNEL);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
> +			resource_size(res));
> +	if (IS_ERR(adata->acp3x_base))
> +		return PTR_ERR(adata->acp3x_base);
> +
> +
> +

extra lines, run checkpatch...
