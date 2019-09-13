Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD30C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7BC206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfIMR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:28:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:5786 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbfIMR2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:28:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 10:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179742919"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2019 10:28:13 -0700
Received: from vjyoung-mobl.amr.corp.intel.com (unknown [10.251.12.73])
        by linux.intel.com (Postfix) with ESMTP id ADFD55803FA;
        Fri, 13 Sep 2019 10:28:12 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add
 dmic format constraint
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
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
 <f2d9e339-ef96-8bb4-7360-422d317a470f@linux.intel.com>
 <CAGvk5PpCOG0Jii_vksrewZ_Dfmc+OVM9C6pkCYLY=n+ac-wVaA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd442561-8fd9-0814-66c6-e08a21bb1a97@linux.intel.com>
Date:   Fri, 13 Sep 2019 12:27:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGvk5PpCOG0Jii_vksrewZ_Dfmc+OVM9C6pkCYLY=n+ac-wVaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please don't top-post on public mailing lists, thanks.

On 9/13/19 9:45 AM, Yu-Hsuan Hsu wrote:
> Thanks for the review! If I'm not mistaken, the microphone is attached 
> to external codec(rt5514) instead of PCH on Kabylake platform. So there 
> should be a TDM between DMICs and PCH. We can see in the 
> kabylake_ssp0_hw_params function, there are some operations about 
> setting tdm slot_width to 16 bits. Therefore, I think it only supports 
> S16_LE format for DMICs. Is it correct?

Ah yes, ok. we have other machine drivers where dmic refers to the PCH 
attached case, thanks for the precision.

I am still not clear on the problem, you are adding this constraint to a 
front-end, so in theory the copier element in the firmware should take 
care of converting from 16-bits recorded on the TDM link to the 24 bits 
used by the application. Is this not the case? is this patch based on an 
actual error and if yes can you share more information to help check 
where the problem happens, topology maybe?

> 
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com 
> <mailto:pierre-louis.bossart@linux.intel.com>> 於 2019年9月12日 週四 下 
> 午9:02寫道：
> 
>     On 9/11/19 9:27 PM, Yu-Hsuan Hsu wrote:
>      > 24 bits recording from DMIC is not supported for KBL platform because
>      > the TDM slot between PCH and codec is 16 bits only. We should add a
>      > constraint to remove that unsupported format.
> 
>     Humm, when you use DMICs they are directly connected to the PCH with a
>     standard 1-bit PDM. There is no notion of TDM or slot.
> 
>     It could very well be that the firmware/topology only support 16 bit (I
>     vaguely recall another case where 24 bits was added), but the
>     description in the commit message would need to be modified to make the
>     reason for this change clearer.
> 
>      >
>      > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org
>     <mailto:yuhsuan@chromium.org>>
>      > ---
>      >   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
>      >   1 file changed, 3 insertions(+)
>      >
>      > diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
>     b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
>      > index 74dda8784f1a01..67b276a65a8d2d 100644
>      > --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
>      > +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
>      > @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct
>     snd_pcm_substream *substream)
>      >       snd_pcm_hw_constraint_list(runtime, 0,
>     SNDRV_PCM_HW_PARAM_CHANNELS,
>      >                       dmic_constraints);
>      >
>      > +     runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
>      > +     snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
>      > +
>      >       return snd_pcm_hw_constraint_list(substream->runtime, 0,
>      >                       SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
>      >   }
>      >
> 

