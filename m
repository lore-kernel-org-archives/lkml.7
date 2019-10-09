Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FE3C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B8820679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfJISxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:53:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:61728 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731661AbfJISxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:53:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 11:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="223684054"
Received: from gteodore-mobl2.amr.corp.intel.com (HELO [10.251.153.168]) ([10.251.153.168])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 11:53:51 -0700
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
Date:   Wed, 9 Oct 2019 13:53:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/19 11:01 AM, Srinivas Kandagatla wrote:
> 
> 
> On 09/10/2019 15:29, Pierre-Louis Bossart wrote:
>>
>>
>> On 10/9/19 3:32 AM, Srinivas Kandagatla wrote:
>>> Hi Pierre,
>>>
>>> On 14/08/2019 15:09, Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>> On 8/13/19 11:11 PM, Vinod Koul wrote:
>>>>> On 13-08-19, 20:58, Mark Brown wrote:
>>>>>> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:
>>>>>>
>>>>>>> Indeed. I don't have a full understanding of that part to be 
>>>>>>> honest, nor why
>>>>>>> we need something SoundWire-specific. We already abused the 
>>>>>>> set_tdm_slot API
>>>>>>> to store an HDaudio stream, now we have a rather confusing stream
>>>>>>> information for SoundWire and I have about 3 other 'stream' 
>>>>>>> contexts in
>>>>>>> SOF... I am still doing basic cleanups but this has been on my 
>>>>>>> radar for a
>>>>>>> while.
>>>>>>
>>>>>> There is something to be said for not abusing the TDM slot API if 
>>>>>> it can
>>>>>> make things clearer by using bus-idiomatic mechanisms, but it does 
>>>>>> mean
>>>>>> everything needs to know about each individual bus :/ .
>>>>>
>>>>> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
>>>>> helps in the case for him to get the stream context and set the stream
>>>>> context from the machine driver.
>>>>>
>>>>> Nothing else is expected to be done from this API. We already do a set
>>>>> using snd_soc_dai_set_sdw_stream(). Here we add the 
>>>>> snd_soc_dai_get_sdw_stream() to query
>>>>
>>>> I didn't see a call to snd_soc_dai_set_sdw_stream() in Srini's code?
>>>
>>>
>>> There is a snd_soc_dai_get_sdw_stream() to get stream context and we 
>>> add slave streams(amplifier in this case) to that context using 
>>> sdw_stream_add_slave() in machine driver[1].
>>>
>>> Without this helper there is no way to link slave streams to stream 
>>> context in non dai based setup like smart speaker amplifiers.
>>>
>>> Currently this driver is blocked on this patch, If you think there 
>>> are other ways to do this, am happy to try them out.
>>
>> So to be clear, you are *not* using snd_soc_dai_set_sdw_stream?
> Yes, am not using snd_soc_dai_set_sdw_stream().

It's been a while since this thread started, and I still don't quite get 
the concepts or logic.

First, I don't understand what the problem with "aux" devices is. All 
the SoundWire stuff is based on the concept of DAI, so I guess I am 
missing why introducing the "aux" device changes anything.

Next, a 'stream' connects multiple DAIs to transmit information from 
sources to sinks. A DAI in itself is created without having any notion 
of which stream it will be associated with. This can only be done with 
machine level information.

If you query a DAI to get a stream context, then how is this stream 
context allocated in the first place? It looks like a horse and cart 
problem. Or you are assuming that a specific DAI provides the context, 
and that all other DAIs do not expose this .get_sdw_stream()? What if 
more that 1 DAI provide a stream context?

And last, I am even more lost since w/ the existing codec drivers we 
have, sdw_stream_add_slave() is called from the dai .hw_params callback, 
once you have information on formats/rates, etc. using 
sdw_stream_add_slave() from a machine driver looks like an even bigger 
stretch. I really thought the machine driver would only propagate the 
notion of stream to all DAIs that are part of the same dailink.

I am not trying to block the Qualcomm implementation, just would like to 
make sure the assumptions are clear and that we are not using the same 
API in completely different ways.




