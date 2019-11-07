Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A61C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4752166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfKGRFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:05:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:48853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKGRFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:05:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="192880761"
Received: from cjense2x-mobl1.amr.corp.intel.com (HELO [10.251.130.63]) ([10.251.130.63])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2019 09:05:21 -0800
Subject: Re: [alsa-devel] [PATCH v3 2/6] ASoC: amd: Refactoring of DAI from
 DMA driver
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
        Mark Brown <broonie@kernel.org>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>
References: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573133093-28208-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2547cf06-6f2f-78d8-d7c8-d0eb9c84f880@linux.intel.com>
Date:   Thu, 7 Nov 2019 09:13:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573133093-28208-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

if (!adata)
	return -ENOMEM;
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
> +	adata->i2s_irq = res->start;
> +	dev_set_drvdata(&pdev->dev, adata);
> +	status = devm_snd_soc_register_component(&pdev->dev,
> +			&acp3x_dai_component,
> +			&acp3x_i2s_dai, 1);
> +	if (status) {
> +		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
> +		return -ENODEV;

if the probe fails for such errors, don't you have a memory leak?

> +	}
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	return 0;

err:
	kree(adata)
	return ret;
?


>   static const struct snd_pcm_hardware acp3x_pcm_hardware_playback = {
>   	.info = SNDRV_PCM_INFO_INTERLEAVED |
>   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> @@ -279,7 +261,11 @@ static int acp3x_dma_open(struct snd_soc_component *component,
>   			  struct snd_pcm_substream *substream)
>   {
>   	int ret = 0;
> +

newline?

> -
>   static const struct snd_soc_component_driver acp3x_i2s_component = {
>   	.name		= DRV_NAME,
>   	.open		= acp3x_dma_open,
> @@ -619,6 +415,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   	irqflags = *((unsigned int *)(pdev->dev.platform_data));
> +	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
> +	if (!adata)
> +		return -ENOMEM;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
> @@ -626,10 +425,6 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
> -	if (!adata)
> -		return -ENOMEM;
> -

that part is hard to review with diff, please double-check the changes.
