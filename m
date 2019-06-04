Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E212166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfFDOsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:48:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:51916 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfFDOsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:48:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 07:48:05 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Jun 2019 07:48:05 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 5FCCD5803EA;
        Tue,  4 Jun 2019 07:48:04 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v4] ASoC: max98090: remove 24-bit format
 support if RJ is 0
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, dgreid@chromium.org,
        cychiang@chromium.org
References: <20190604104909.112984-1-yuhsuan@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5de28b91-2d87-f013-3438-8708160db63d@linux.intel.com>
Date:   Tue, 4 Jun 2019 09:48:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604104909.112984-1-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 5:49 AM, Yu-Hsuan Hsu wrote:
> The supported formats are S16_LE and S24_LE now. However, by datasheet
> of max98090, S24_LE is only supported when it is in the right justified
> mode. We should remove 24-bit format if it is not in that mode to avoid
> triggering error.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
>   Remove Change-Id.
> 
>   sound/soc/codecs/max98090.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 7619ea31ab50..ada8c25e643d 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -1909,6 +1909,21 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
>   	return 0;
>   }
>   
> +static int max98090_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
> +	unsigned int fmt = max98090->dai_fmt;
> +
> +	/* Remove 24-bit format support if it is not in right justified mode. */
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
> +		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
> +	}
> +	return 0;
> +}

The data sheet is ambiguous, it states that 24-bit data is supported in 
RJ mode when TDM is 0. It doesn't say TDM can only support 16 bits.

That said, it's not clear to me if TDM is supported or not in this 
driver, there are multiple references to tdm_slots but DSP_A and DSP_B 
are not supported.

> +
>   static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
>   				   struct snd_pcm_hw_params *params,
>   				   struct snd_soc_dai *dai)
> @@ -2316,6 +2331,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
>   #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
>   
>   static const struct snd_soc_dai_ops max98090_dai_ops = {
> +	.startup = max98090_dai_startup,
>   	.set_sysclk = max98090_dai_set_sysclk,
>   	.set_fmt = max98090_dai_set_fmt,
>   	.set_tdm_slot = max98090_set_tdm_slot,
> 

