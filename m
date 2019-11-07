Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7756C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F62166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbfKGRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:05:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:48853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbfKGRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:05:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="192880772"
Received: from cjense2x-mobl1.amr.corp.intel.com (HELO [10.251.130.63]) ([10.251.130.63])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2019 09:05:24 -0800
Subject: Re: [alsa-devel] [PATCH v3 3/6] ASoC: amd: Enabling I2S instance in
 DMA and DAI
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
 <1573133093-28208-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73a0569b-7885-3461-4aff-e38e85a06ebf@linux.intel.com>
Date:   Thu, 7 Nov 2019 09:22:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573133093-28208-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			val = rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_I2STDM_ITER);
> +		}
>   	} else {
> -		val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> -		val = val | (rtd->xfer_resolution  << 3);
> -		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +			break;
> +		case I2S_SP_INSTANCE:
> +		default:
> +			val = rv_readl(rtd->acp3x_base + mmACP_I2STDM_IRER);
> +			val = val | (rtd->xfer_resolution  << 3);
> +			rv_writel(val, rtd->acp3x_base + mmACP_I2STDM_IRER);
> +		}

You could reduce the code by setting the address in the switch case, 
then perform the read/modify/write outisde of the switch.

> @@ -131,33 +168,104 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
>   		rtd->bytescount = acp_get_byte_count(rtd,
>   						substream->stream);
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -			rv_writel(period_bytes, rtd->acp3x_base +
> +			switch (rtd->i2s_instance) {
> +			case I2S_BT_INSTANCE:
> +				rv_writel(period_bytes, rtd->acp3x_base +
>   					mmACP_BT_TX_INTR_WATERMARK_SIZE);
> -			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> -			val = val | BIT(0);
> -			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +				val = rv_readl(rtd->acp3x_base +
> +						mmACP_BTTDM_ITER);
> +				val = val | BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +						mmACP_BTTDM_ITER);
> +				rv_writel(1, rtd->acp3x_base +
> +						mmACP_BTTDM_IER);
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				rv_writel(period_bytes, rtd->acp3x_base +
> +					mmACP_I2S_TX_INTR_WATERMARK_SIZE);
> +				val = rv_readl(rtd->acp3x_base +
> +						mmACP_I2STDM_ITER);
> +				val = val | BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +						mmACP_I2STDM_ITER);
> +				rv_writel(1, rtd->acp3x_base +
> +						mmACP_I2STDM_IER);
> +			}
>   		} else {
> -			rv_writel(period_bytes, rtd->acp3x_base +
> +			switch (rtd->i2s_instance) {
> +			case I2S_BT_INSTANCE:
> +				rv_writel(period_bytes, rtd->acp3x_base +
>   					mmACP_BT_RX_INTR_WATERMARK_SIZE);
> -			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> -			val = val | BIT(0);
> -			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +				val = rv_readl(rtd->acp3x_base +
> +						mmACP_BTTDM_IRER);
> +				val = val | BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +						mmACP_BTTDM_IRER);
> +				rv_writel(1, rtd->acp3x_base +
> +						mmACP_BTTDM_IER);
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				rv_writel(period_bytes, rtd->acp3x_base +
> +					mmACP_I2S_RX_INTR_WATERMARK_SIZE);
> +				val = rv_readl(rtd->acp3x_base +
> +						mmACP_I2STDM_IRER);
> +				val = val | BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +						 mmACP_I2STDM_IRER);
> +				rv_writel(1, rtd->acp3x_base +
> +						mmACP_I2STDM_IER);
> +			}

same here, you could set 3 addresses in the switch cases, and perform 
the operations outside of the switch.

>   		}
> -		rv_writel(1, rtd->acp3x_base + mmACP_BTTDM_IER);
>   		break;
>   	case SNDRV_PCM_TRIGGER_STOP:
>   	case SNDRV_PCM_TRIGGER_SUSPEND:
>   	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> -			val = val & ~BIT(0);
> -			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> +			switch (rtd->i2s_instance) {
> +			case I2S_BT_INSTANCE:
> +				val = rv_readl(rtd->acp3x_base +
> +							mmACP_BTTDM_ITER);
> +				val = val & ~BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +							mmACP_BTTDM_ITER);
> +				rv_writel(0, rtd->acp3x_base +
> +							mmACP_BTTDM_IER);
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				val = rv_readl(rtd->acp3x_base +
> +							mmACP_I2STDM_ITER);
> +				val = val & ~BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +							mmACP_I2STDM_ITER);
> +				rv_writel(0, rtd->acp3x_base +
> +							mmACP_I2STDM_IER);
> +			}
> +
>   		} else {
> -			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
> -			val = val & ~BIT(0);
> -			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
> +			switch (rtd->i2s_instance) {
> +			case I2S_BT_INSTANCE:
> +				val = rv_readl(rtd->acp3x_base +
> +							mmACP_BTTDM_IRER);
> +				val = val & ~BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +							mmACP_BTTDM_IRER);
> +				rv_writel(0, rtd->acp3x_base +
> +							mmACP_BTTDM_IER);
> +				break;
> +			case I2S_SP_INSTANCE:
> +			default:
> +				val = rv_readl(rtd->acp3x_base +
> +							mmACP_I2STDM_IRER);
> +				val = val & ~BIT(0);
> +				rv_writel(val, rtd->acp3x_base +
> +							mmACP_I2STDM_IRER);
> +				rv_writel(0, rtd->acp3x_base +
> +							mmACP_I2STDM_IER);
> +			}

and here too...

>   	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> -		/* Config ringbuffer */
> -		rv_writel(MEM_WINDOW_START, rtd->acp3x_base +
> -			  mmACP_BT_TX_RINGBUFADDR);
> -		rv_writel(MAX_BUFFER, rtd->acp3x_base +
> -			  mmACP_BT_TX_RINGBUFSIZE);
> -		rv_writel(DMA_SIZE, rtd->acp3x_base + mmACP_BT_TX_DMA_SIZE);
> -
> -		/* Config audio fifo */
> -		acp_fifo_addr = ACP_SRAM_PTE_OFFSET + (rtd->num_pages * 8)
> -				+ PLAYBACK_FIFO_ADDR_OFFSET;
> -		rv_writel(acp_fifo_addr, rtd->acp3x_base +
> -			  mmACP_BT_TX_FIFOADDR);
> -		rv_writel(FIFO_SIZE, rtd->acp3x_base + mmACP_BT_TX_FIFOSIZE);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +				/* Config ringbuffer */
> +			rv_writel(I2S_BT_TX_MEM_WINDOW_START,
> +				rtd->acp3x_base + mmACP_BT_TX_RINGBUFADDR);
> +			rv_writel(MAX_BUFFER, rtd->acp3x_base +
> +					mmACP_BT_TX_RINGBUFSIZE);
> +			rv_writel(DMA_SIZE,
> +				rtd->acp3x_base + mmACP_BT_TX_DMA_SIZE);
> +
> +			/* Config audio fifo */
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +						BT_PB_FIFO_ADDR_OFFSET;
> +			rv_writel(acp_fifo_addr,
> +				rtd->acp3x_base +  mmACP_BT_TX_FIFOADDR);
> +			rv_writel(FIFO_SIZE,
> +				rtd->acp3x_base + mmACP_BT_TX_FIFOSIZE);
> +			/* Enable  watermark/period interrupt to host */
> +			rv_writel(BIT(BT_TX_THRESHOLD),
> +				rtd->acp3x_base + mmACP_EXTERNAL_INTR_CNTL);
> +			break;
> +
> +		case I2S_SP_INSTANCE:
> +		default:
> +			/* Config ringbuffer */
> +			rv_writel(I2S_SP_TX_MEM_WINDOW_START,
> +				rtd->acp3x_base + mmACP_I2S_TX_RINGBUFADDR);
> +			rv_writel(MAX_BUFFER,
> +				rtd->acp3x_base + mmACP_I2S_TX_RINGBUFSIZE);
> +			rv_writel(DMA_SIZE,
> +				rtd->acp3x_base + mmACP_I2S_TX_DMA_SIZE);
> +
> +			/* Config audio fifo */
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +						SP_PB_FIFO_ADDR_OFFSET;
> +			rv_writel(acp_fifo_addr,
> +				rtd->acp3x_base + mmACP_I2S_TX_FIFOADDR);
> +			rv_writel(FIFO_SIZE,
> +				rtd->acp3x_base + mmACP_I2S_TX_FIFOSIZE);
> +			/* Enable  watermark/period interrupt to host */
> +			rv_writel(BIT(I2S_TX_THRESHOLD),
> +				rtd->acp3x_base + mmACP_EXTERNAL_INTR_CNTL);
> +		}
>   	} else {
> -		/* Config ringbuffer */
> -		rv_writel(MEM_WINDOW_START + MAX_BUFFER, rtd->acp3x_base +
> -			  mmACP_BT_RX_RINGBUFADDR);
> -		rv_writel(MAX_BUFFER, rtd->acp3x_base +
> -			  mmACP_BT_RX_RINGBUFSIZE);
> -		rv_writel(DMA_SIZE, rtd->acp3x_base + mmACP_BT_RX_DMA_SIZE);
> -
> -		/* Config audio fifo */
> -		acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> -				(rtd->num_pages * 8) + CAPTURE_FIFO_ADDR_OFFSET;
> -		rv_writel(acp_fifo_addr, rtd->acp3x_base +
> -			  mmACP_BT_RX_FIFOADDR);
> -		rv_writel(FIFO_SIZE, rtd->acp3x_base + mmACP_BT_RX_FIFOSIZE);
> +		switch (rtd->i2s_instance) {
> +		case I2S_BT_INSTANCE:
> +			/* Config ringbuffer */
> +			rv_writel(I2S_BT_RX_MEM_WINDOW_START,
> +				rtd->acp3x_base + mmACP_BT_RX_RINGBUFADDR);
> +			rv_writel(MAX_BUFFER,
> +				rtd->acp3x_base + mmACP_BT_RX_RINGBUFSIZE);
> +			rv_writel(DMA_SIZE,
> +				rtd->acp3x_base + mmACP_BT_RX_DMA_SIZE);
> +
> +			/* Config audio fifo */
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +						BT_CAPT_FIFO_ADDR_OFFSET;
> +			rv_writel(acp_fifo_addr,
> +				rtd->acp3x_base + mmACP_BT_RX_FIFOADDR);
> +			rv_writel(FIFO_SIZE,
> +				rtd->acp3x_base + mmACP_BT_RX_FIFOSIZE);
> +			/* Enable  watermark/period interrupt to host */
> +			rv_writel(BIT(BT_RX_THRESHOLD),
> +				rtd->acp3x_base + mmACP_EXTERNAL_INTR_CNTL);
> +			break;
> +
> +		case I2S_SP_INSTANCE:
> +		default:
> +			/* Config ringbuffer */
> +			rv_writel(I2S_SP_RX_MEM_WINDOW_START,
> +				rtd->acp3x_base + mmACP_I2S_RX_RINGBUFADDR);
> +			rv_writel(MAX_BUFFER,
> +				rtd->acp3x_base + mmACP_I2S_RX_RINGBUFSIZE);
> +			rv_writel(DMA_SIZE,
> +				rtd->acp3x_base + mmACP_I2S_RX_DMA_SIZE);
> +
> +			/* Config audio fifo */
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +						SP_CAPT_FIFO_ADDR_OFFSET;
> +			rv_writel(acp_fifo_addr,
> +				rtd->acp3x_base + mmACP_I2S_RX_FIFOADDR);
> +			rv_writel(FIFO_SIZE,
> +				rtd->acp3x_base + mmACP_I2S_RX_FIFOSIZE);
> +			/* Enable  watermark/period interrupt to host */
> +			rv_writel(BIT(I2S_RX_THRESHOLD),
> +				rtd->acp3x_base + mmACP_EXTERNAL_INTR_CNTL);
> +		}

and here too. You are doing the same operations with just different offsets.

