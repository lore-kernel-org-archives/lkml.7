Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6773EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F3206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfHWP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:57:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:61520 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732573AbfHWP5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:57:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 08:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="181751261"
Received: from dongdon2-mobl.amr.corp.intel.com (HELO [10.254.108.232]) ([10.254.108.232])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2019 08:57:30 -0700
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
 <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
 <20190823073407.GF2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0658de0f-c7a5-4a38-5893-e8cb665154d5@linux.intel.com>
Date:   Fri, 23 Aug 2019 10:57:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823073407.GF2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>>> +void intel_shutdown(struct snd_pcm_substream *substream,
>>>>>> +            struct snd_soc_dai *dai)
>>>>>> +{
>>>>>> +    struct sdw_cdns_dma_data *dma;
>>>>>> +
>>>>>> +    dma = snd_soc_dai_get_dma_data(dai, substream);
>>>>>> +    if (!dma)
>>>>>> +        return;
>>>>>> +
>>>>>> +    snd_soc_dai_set_dma_data(dai, substream, NULL);
>>>>>> +    kfree(dma);
>>>>>> +}
>>>>>
>>>>> Correct me if I'm wrong, but do we really need to _get_dma_ here?
>>>>> _set_dma_ seems bulletproof, same for kfree.
>>>>
>>>> I must admit I have no idea why we have a reference to DMAs here, this looks
>>>> like an abuse to store a dai-specific context, and the initial test looks
>>>> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
>>>> and Sanyog might have more history than me here.
>>>
>>> I dont see snd_soc_dai_set_dma_data() call for
>>> sdw_cdns_dma_data so somthing is missing (at least in upstream code)
>>>
>>> IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
>>> initialization routine and we free it here.. Sanyog?
>>
>> Vinod, I double-checked that we do not indeed have a call to
>> snd_soc_dai_dma_data(), but there is code in cdns_set_stream() that sets the
>> relevant dai->playback/capture_dma_data, see below
>>
>> I am not a big fan of this code, touching the ASoC core internal fields
>> isn't a good idea in general.
> 
> IIRC as long as you stick to single link I do not see this required. The
> question comes into picture when we have multi links as you would need
> to allocate a soundwire stream and set that for all the sdw DAIs
> 
> So, what is the current model of soundwire stream, which entity allocates
> that and do you still care about multi-link? is there any machine driver
> with soundwire upstream yet?

yes, multi-link is definitively required and one of the main appeals of 
SoundWire. We have a platform with 2 amplifiers on separate links and 
they need to be synchronized and handled with the stream concept.

The tentative plan would be to move the stream allocation to the dailink 
.init (or equivalent), and make sure each DAI in that link used the same 
stream information. There are dependencies on the multi-cpu concept that 
Morimoto-san wanted to push, so we'll likely be the first users.

For the DAI trigger, we will need to change the existing API so that a 
sdw_stream_enable() can be called multiple times, but only takes effect 
when the .trigger of the first DAI in the stream is invoked. This is a 
similar behavior than with HDaudio .trigger operations when the SYNC 
bits are used.

We will do this when we have a first pass working with all codec drivers 
upstream and a basic machine driver upstream with all 4 links working 
independently.

Everything is done in public btw, you can track our WIP solutions here:

https://github.com/thesofproject/linux/pull/1140
https://github.com/thesofproject/linux/pull/1141
https://github.com/thesofproject/linux/pull/1142

