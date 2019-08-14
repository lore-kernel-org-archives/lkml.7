Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33425C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F61D206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfHNTbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:31:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:26365 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfHNTbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:31:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 12:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="181658948"
Received: from thegde-mobl.amr.corp.intel.com (HELO [10.252.134.116]) ([10.252.134.116])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2019 12:31:43 -0700
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
 <20190802172843.GC12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
Date:   Wed, 14 Aug 2019 14:31:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802172843.GC12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> +void intel_shutdown(struct snd_pcm_substream *substream,
>>>> +            struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct sdw_cdns_dma_data *dma;
>>>> +
>>>> +    dma = snd_soc_dai_get_dma_data(dai, substream);
>>>> +    if (!dma)
>>>> +        return;
>>>> +
>>>> +    snd_soc_dai_set_dma_data(dai, substream, NULL);
>>>> +    kfree(dma);
>>>> +}
>>>
>>> Correct me if I'm wrong, but do we really need to _get_dma_ here?
>>> _set_dma_ seems bulletproof, same for kfree.
>>
>> I must admit I have no idea why we have a reference to DMAs here, this looks
>> like an abuse to store a dai-specific context, and the initial test looks
>> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
>> and Sanyog might have more history than me here.
> 
> I dont see snd_soc_dai_set_dma_data() call for
> sdw_cdns_dma_data so somthing is missing (at least in upstream code)
> 
> IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
> initialization routine and we free it here.. Sanyog?

Vinod, I double-checked that we do not indeed have a call to 
snd_soc_dai_dma_data(), but there is code in cdns_set_stream() that sets 
the relevant dai->playback/capture_dma_data, see below

I am not a big fan of this code, touching the ASoC core internal fields 
isn't a good idea in general.

Also not sure why for a DAI we need both _drvdata and _dma_data 
(especially for this case where the information stored has absolutely 
nothing to do with DMAs).

If the idea was to keep a context that is direction-dependent, that's 
likely unnecessary. For the Intel/Cadence case the interfaces can be 
configured as playback OR capture, not both concurrently, so the "dma" 
information could have been stored in the generic DAI _drvdata.

I have other things to look into for now but this code will likely need 
to be cleaned-up at some point to remove unnecessary parts.

int cdns_set_sdw_stream(struct snd_soc_dai *dai,
			void *stream, bool pcm, int direction)
{
	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
	struct sdw_cdns_dma_data *dma;

	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
	if (!dma)
		return -ENOMEM;

	if (pcm)
		dma->stream_type = SDW_STREAM_PCM;
	else
		dma->stream_type = SDW_STREAM_PDM;

	dma->bus = &cdns->bus;
	dma->link_id = cdns->instance;

	dma->stream = stream;

 >>> this is equivalent to snd_soc_dai_dma_data()

	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
		dai->playback_dma_data = dma;
	else
		dai->capture_dma_data = dma;
<<<<
	return 0;
}
EXPORT_SYMBOL(cdns_set_sdw_stream);
