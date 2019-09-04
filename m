Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1998C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8419B21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfIDRt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:49:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:54851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:49:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194814550"
Received: from enagase-mobl1.amr.corp.intel.com (HELO [10.251.133.230]) ([10.251.133.230])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 10:49:24 -0700
Subject: Re: [alsa-devel] [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire
 stream config/free callbacks
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
 <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
 <20190904073549.GL2672@vkoul-mobl>
 <4de9613c-2da4-8d39-6f99-3039811673b8@linux.intel.com>
 <20190904165522.GC2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b37f7be2-27b4-4ba5-e07a-8993d8c171f2@linux.intel.com>
Date:   Wed, 4 Sep 2019 12:49:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904165522.GC2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 11:55 AM, Vinod Koul wrote:
> On 04-09-19, 08:31, Pierre-Louis Bossart wrote:
>> On 9/4/19 2:35 AM, Vinod Koul wrote:
>>> On 22-08-19, 08:53, Pierre-Louis Bossart wrote:
>>>> Thanks for the review Guennadi
>>>>
>>>>>> +static int sdw_config_stream(void *arg, void *s, void *dai,
>>>>>> +			     void *params, int link_id, int alh_stream_id)
>>>>>
>>>>> I realise, that these function prototypes aren't being introduced by these
>>>>> patches, but just wondering whether such overly generic prototype is really
>>>>> a good idea here, whether some of those "void *" pointers could be given
>>>>> real types. The first one could be "struct device *" etc.
>>>>
>>>> In this case the 'arg' parameter is actually a private 'struct snd_sof_dev',
>>>> as shown below [1]. We probably want to keep this relatively opaque, this is
>>>> a context that doesn't need to be exposed to the SoundWire code.
>>>
>>> This does look bit ugly.
>>>
>>>> The dai and params are indeed cases where we could use stronger types, they
>>>> are snd_soc_dai and hw_params respectively. I don't recall why the existing
>>>> code is this way, Vinod and Sanyog may have the history of this.
>>>
>>> Yes we wanted to decouple the sdw and audio bits that is the reason why
>>> none of the audio types are used here, but I think it should be revisited
>>> and perhaps made as:
>>>
>>> sdw_config_stream(struct device *sdw, struct sdw_callback_ctx *ctx)
>>>
>>> where the callback context contains all the other args. That would make
>>> it look lot neater too and of course use real structs if possible
>>
>> the suggested sdw_callbback_ctx is really intel-specific at the moment, e.g.
>> the notion of link_id and alh_stream_id are due to the hardware, it's not
>> generic at all. And in the latest code we also pass the dai->id.
> 
> s/sdw_callback_ctx/intel_sdw_callback_ctx
> 
> Yes this code is intel specific and this would be intel specific too

ok, I'll fold all the fields in a structure then. That's a nice cleanup, 
thanks Guennadi and Vinod for the reviews.
