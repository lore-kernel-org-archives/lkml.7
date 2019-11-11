Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7222C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EA72190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKKQlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:41:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:28029 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfKKQlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:41:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="193986437"
Received: from magalleg-mobl3.amr.corp.intel.com (HELO [10.251.146.103]) ([10.251.146.103])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2019 08:41:16 -0800
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: kbl_rt5663_rt5514_max98927:
 Add dmic format constraint
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org
References: <20190923162940.199580-1-yuhsuan@chromium.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba9f2c6a-42e8-1195-dbb7-cf5867915aa6@linux.intel.com>
Date:   Mon, 11 Nov 2019 09:36:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20190923162940.199580-1-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/19 11:29 AM, Yu-Hsuan Hsu wrote:
> On KBL platform, the microphone is attached to external codec(rt5514)
> instead of PCH. However, TDM slot between PCH and codec is 16 bits only.
> In order to avoid setting wrong format, we should add a constraint to
> force to use 16 bits format forever.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
> I have updated the commit message. Please see whether it is clear
> enough. Thanks.

Sorry, I missed this patch. Looks ok, though the 'right' approach would 
be to have topology and/or copiers deal with format changes.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


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
