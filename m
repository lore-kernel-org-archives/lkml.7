Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA1C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86CC2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391456AbfIIRx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:53:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:50147 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfIIRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:53:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 10:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="209041735"
Received: from raavalos-mobl2.amr.corp.intel.com (HELO [10.251.153.215]) ([10.251.153.215])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2019 10:53:24 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
 <391e8f6c-7e35-deb4-4f4d-c39396b778ba@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <29b9fd4e-3d78-b4a3-e61a-c066bf24995a@linux.intel.com>
Date:   Mon, 9 Sep 2019 12:53:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C7402C9EA2@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't top-post on public mailing lists.

> We are working on a backport 3.14 branch for Chrome projects based on BDW platform. In the branch 4-channel capture is supported on some platforms but not all. So we need to add a constraint in the machine driver for machines don't support this feature.
> 
> I checked the for-next branch in the broonie repo. The channels_max of HSW_PCM_DAI_ID_SYSTEM is 4 for capture stream so I think it would have same issue like google's backport tree. I didn't find any constraint for this dai. Would you point out where it is?
> 
> 		.capture = {
> 			.stream_name = "Analog Capture",
> 			.channels_min = 2,
> 			.channels_max = 4,
> 			.rates = SNDRV_PCM_RATE_48000,
> 			.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE,
> 		},

ok, I missed this capture case indeed, but when I look at the Chrome 
3.14 code I don't see this constraint being added, and we already have 
an ssp0_fixup function where 2 channels only are used.

	/* The ADSP will covert the FE rate to 48k, stereo */
	rate->min = rate->max = 48000;
	channels->min = channels->max = 2;

I also don't see any case where we support 4 channels in any broadwell 
machine driver?

So again can you point me to an issue or existing backport that requires 
the patch below. Not trying to be obtuse but we should only change older 
platforms when there is evidence that a change is needed.

-Pierre

> 
> Regards,
> Brent Lu
> 
> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Friday, September 6, 2019 10:21 PM
> To: Lu, Brent <brent.lu@intel.com>; alsa-devel@alsa-project.org
> Cc: Rojewski, Cezary <cezary.rojewski@intel.com>; liam.r.girdwood@linux.intel.com; yang.jie@linux.intel.com; broonie@kernel.org; perex@perex.cz; tiwai@suse.com; kuninori.morimoto.gx@renesas.com; tglx@linutronix.de; linux-kernel@vger.kernel.org
> Subject: Re: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
> 
> On 9/5/19 8:24 PM, Brent Lu wrote:
>> BDW boards using this machine driver supports only stereo capture and
>> playback. Implement a constraint to enforce it.
> 
> Humm, can you clarify what problem/error this patch fixes?
> 
> There are already constraints on the hsw_dais[] where the channels are stereo only.
> 
> Thanks
> -Pierre
> 
>>
>> Signed-off-by: Brent Lu <brent.lu@intel.com>
>> ---
>>    sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
>>    1 file changed, 33 insertions(+)
>>
>> diff --git a/sound/soc/intel/boards/bdw-rt5677.c
>> b/sound/soc/intel/boards/bdw-rt5677.c
>> index 4a4d335..a312b55 100644
>> --- a/sound/soc/intel/boards/bdw-rt5677.c
>> +++ b/sound/soc/intel/boards/bdw-rt5677.c
>> @@ -22,6 +22,8 @@
>>    
>>    #include "../../codecs/rt5677.h"
>>    
>> +#define DUAL_CHANNEL 2
>> +
>>    struct bdw_rt5677_priv {
>>    	struct gpio_desc *gpio_hp_en;
>>    	struct snd_soc_component *component; @@ -245,6 +247,36 @@ static
>> int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
>>    	return 0;
>>    }
>>    
>> +static const unsigned int channels[] = {
>> +	DUAL_CHANNEL,
>> +};
>> +
>> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
>> +	.count = ARRAY_SIZE(channels),
>> +	.list = channels,
>> +	.mask = 0,
>> +};
>> +
>> +static int bdw_fe_startup(struct snd_pcm_substream *substream) {
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>> +	/*
>> +	 * On this platform for PCM device we support,
>> +	 * stereo
>> +	 */
>> +
>> +	runtime->hw.channels_max = DUAL_CHANNEL;
>> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
>> +					   &constraints_channels);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct snd_soc_ops bdw_rt5677_fe_ops = {
>> +	.startup = bdw_fe_startup,
>> +};
>> +
>>    /* broadwell digital audio interface glue - connects codec <--> CPU */
>>    SND_SOC_DAILINK_DEF(dummy,
>>    	DAILINK_COMP_ARRAY(COMP_DUMMY()));
>> @@ -273,6 +305,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
>>    		},
>>    		.dpcm_capture = 1,
>>    		.dpcm_playback = 1,
>> +		.ops = &bdw_rt5677_fe_ops,
>>    		SND_SOC_DAILINK_REG(fe, dummy, platform),
>>    	},
>>    
>>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
