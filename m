Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5686DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382D12178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKGRFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:05:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:48853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389802AbfKGRF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:05:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 09:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="192880778"
Received: from cjense2x-mobl1.amr.corp.intel.com (HELO [10.251.130.63]) ([10.251.130.63])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2019 09:05:26 -0800
Subject: Re: [alsa-devel] [RESEND PATCH v3 5/6] ASoC: amd: handle ACP3x i2s-sp
 watermark interrupt.
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
        Alexander.Deucher@amd.com,
        Colin Ian King <colin.king@canonical.com>
References: <1573133093-28208-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573133093-28208-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <18b68b8f-773d-8493-22ab-0be3e749b04b@linux.intel.com>
Date:   Thu, 7 Nov 2019 09:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1573133093-28208-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/19 7:24 AM, Ravulapati Vishnu vardhan rao wrote:
> whenever audio data equal to I2S-SP fifo watermark level is
> produced/consumed, interrupt is generated.
> 
> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
> ---
>   sound/soc/amd/raven/acp3x-pcm-dma.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index 8fab505..629a32f 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -176,6 +176,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
>   		snd_pcm_period_elapsed(rv_i2s_data->play_stream);
>   		play_flag = 1;
>   	}
> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
> +				rv_i2s_data->i2ssp_play_stream) {
> +		rv_writel(BIT(I2S_TX_THRESHOLD),
> +			rv_i2s_data->acp3x_base	+ mmACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(rv_i2s_data->i2ssp_play_stream);

The commit message looks odd. If you have a DMA and signal a period 
elapsed, is this really a case where the FIFO level reaches a watermark?
Usually the FIFOs are somewhat small and there are multiple DMA 
transfers per period?
