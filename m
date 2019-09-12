Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB35C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C9520CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfILNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:02:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:55893 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731864AbfILNCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:02:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 06:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,497,1559545200"; 
   d="scan'208";a="215037563"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2019 06:02:43 -0700
Received: from vjyoung-mobl.amr.corp.intel.com (unknown [10.251.12.73])
        by linux.intel.com (Postfix) with ESMTP id 3F784580862;
        Thu, 12 Sep 2019 06:02:42 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add
 dmic format constraint
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org
References: <20190912022740.161798-1-yuhsuan@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f2d9e339-ef96-8bb4-7360-422d317a470f@linux.intel.com>
Date:   Thu, 12 Sep 2019 08:02:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190912022740.161798-1-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 9:27 PM, Yu-Hsuan Hsu wrote:
> 24 bits recording from DMIC is not supported for KBL platform because
> the TDM slot between PCH and codec is 16 bits only. We should add a
> constraint to remove that unsupported format.

Humm, when you use DMICs they are directly connected to the PCH with a 
standard 1-bit PDM. There is no notion of TDM or slot.

It could very well be that the firmware/topology only support 16 bit (I 
vaguely recall another case where 24 bits was added), but the 
description in the commit message would need to be modified to make the 
reason for this change clearer.

> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
>   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 74dda8784f1a01..67b276a65a8d2d 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
>   	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
>   			dmic_constraints);
>   
> +	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
> +
>   	return snd_pcm_hw_constraint_list(substream->runtime, 0,
>   			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
>   }
> 

