Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A48AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99188206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfKMRSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:18:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:62542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKMRSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:18:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 09:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,301,1569308400"; 
   d="scan'208";a="229813233"
Received: from dmsnyder-mobl1.amr.corp.intel.com (HELO [10.252.193.15]) ([10.252.193.15])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 09:18:07 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v5 3/6] ASoC: amd: Enabling I2S
 instance in DMA and DAI
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
        Alexander.Deucher@amd.com,
        Colin Ian King <colin.king@canonical.com>
References: <1573629249-13272-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573629249-13272-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5ca55e4b-51e5-7d1e-31a6-73f923a10078@linux.intel.com>
Date:   Wed, 13 Nov 2019 10:29:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573629249-13272-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -83,9 +83,20 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
>   		struct snd_pcm_hw_params *params,
>   		struct snd_soc_dai *dai)
>   {
> -	u32 val = 0;
> +	u32 val;
> +	u32 reg_val;

nit-pick: xmas-tree style, move the declarations below


> @@ -104,24 +115,46 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
>   		return -EINVAL;
>   	}
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			reg_val = mmACP_BTTDM_ITER;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = mmACP_I2STDM_ITER;
> +		}
>   	} else {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			reg_val = mmACP_BTTDM_IRER;
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			reg_val = mmACP_I2STDM_IRER;
> +		}
>   	}
> +	val = rv_readl(rtd->acp3x_base + reg_val);
> +	val = val | (rtd->xfer_resolution  << 3);
> +	rv_writel(val, rtd->acp3x_base + reg_val);
>   	return 0;
>   }

nice cleanup, much better than previous versions!

>   
>   static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
>   		int cmd, struct snd_soc_dai *dai)
>   {
> -	int ret = 0;
> +	int ret;

move 2 lines below.

>   	struct i2s_stream_instance *rtd = substream->runtime->private_data;
> -	u32 val, period_bytes;
> -
> +	u32 val, period_bytes, reg_val, ier_val, water_val;
> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +	struct snd_soc_card *card = prtd->card;
> +	struct acp3x_platform_info *pinfo = snd_soc_card_get_drvdata(card);


>   static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>   {
>   	u16 page_idx;
> -	u32 low, high, val, acp_fifo_addr;
> -	dma_addr_t addr = rtd->dma_addr;
> +	uint64_t low, high, val, acp_fifo_addr;
> +	uint64_t reg_ringbuf_size, reg_dma_size, reg_fifo_size, reg_fifo_addr;
> +	dma_addr_t addr;

nit-pick: xmas-tree style

> @@ -303,13 +346,24 @@ static int acp3x_dma_hw_params(struct snd_soc_component *component,
>   			       struct snd_pcm_hw_params *params)
>   {
>   	int status;
> -	u64 size;
> -	struct snd_pcm_runtime *runtime = substream->runtime;
> -	struct i2s_stream_instance *rtd = runtime->private_data;
> +	uint64_t size;
> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +	struct snd_soc_card *card = prtd->card;
> +	struct acp3x_platform_info *pinfo = snd_soc_card_get_drvdata(card);
>   
> +	struct i2s_stream_instance *rtd = substream->runtime->private_data;

nit pick: xmas-tree style and newlines


