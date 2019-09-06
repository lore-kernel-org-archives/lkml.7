Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4ACC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AB2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404615AbfIFOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:20:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:46030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbfIFOUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:20:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 07:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="384226932"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2019 07:20:36 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
        by linux.intel.com (Postfix) with ESMTP id 29AA35800FE;
        Fri,  6 Sep 2019 07:20:35 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
Date:   Fri, 6 Sep 2019 09:20:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 8:24 PM, Brent Lu wrote:
> BDW boards using this machine driver supports only stereo capture and
> playback. Implement a constraint to enforce it.

Humm, can you clarify what problem/error this patch fixes?

There are already constraints on the hsw_dais[] where the channels are 
stereo only.

Thanks
-Pierre

> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
> index 4a4d335..a312b55 100644
> --- a/sound/soc/intel/boards/bdw-rt5677.c
> +++ b/sound/soc/intel/boards/bdw-rt5677.c
> @@ -22,6 +22,8 @@
>   
>   #include "../../codecs/rt5677.h"
>   
> +#define DUAL_CHANNEL 2
> +
>   struct bdw_rt5677_priv {
>   	struct gpio_desc *gpio_hp_en;
>   	struct snd_soc_component *component;
> @@ -245,6 +247,36 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
>   	return 0;
>   }
>   
> +static const unsigned int channels[] = {
> +	DUAL_CHANNEL,
> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int bdw_fe_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * stereo
> +	 */
> +
> +	runtime->hw.channels_max = DUAL_CHANNEL;
> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops bdw_rt5677_fe_ops = {
> +	.startup = bdw_fe_startup,
> +};
> +
>   /* broadwell digital audio interface glue - connects codec <--> CPU */
>   SND_SOC_DAILINK_DEF(dummy,
>   	DAILINK_COMP_ARRAY(COMP_DUMMY()));
> @@ -273,6 +305,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
>   		},
>   		.dpcm_capture = 1,
>   		.dpcm_playback = 1,
> +		.ops = &bdw_rt5677_fe_ops,
>   		SND_SOC_DAILINK_REG(fe, dummy, platform),
>   	},
>   
> 

