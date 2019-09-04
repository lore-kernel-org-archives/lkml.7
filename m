Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFD022CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfIDNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:31:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:57229 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDNbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:31:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 06:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="187627781"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2019 06:31:44 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
        by linux.intel.com (Postfix) with ESMTP id 151D65802AF;
        Wed,  4 Sep 2019 06:31:43 -0700 (PDT)
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4de9613c-2da4-8d39-6f99-3039811673b8@linux.intel.com>
Date:   Wed, 4 Sep 2019 08:31:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904073549.GL2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 2:35 AM, Vinod Koul wrote:
> On 22-08-19, 08:53, Pierre-Louis Bossart wrote:
>> Thanks for the review Guennadi
>>
>>>> +static int sdw_config_stream(void *arg, void *s, void *dai,
>>>> +			     void *params, int link_id, int alh_stream_id)
>>>
>>> I realise, that these function prototypes aren't being introduced by these
>>> patches, but just wondering whether such overly generic prototype is really
>>> a good idea here, whether some of those "void *" pointers could be given
>>> real types. The first one could be "struct device *" etc.
>>
>> In this case the 'arg' parameter is actually a private 'struct snd_sof_dev',
>> as shown below [1]. We probably want to keep this relatively opaque, this is
>> a context that doesn't need to be exposed to the SoundWire code.
> 
> This does look bit ugly.
> 
>> The dai and params are indeed cases where we could use stronger types, they
>> are snd_soc_dai and hw_params respectively. I don't recall why the existing
>> code is this way, Vinod and Sanyog may have the history of this.
> 
> Yes we wanted to decouple the sdw and audio bits that is the reason why
> none of the audio types are used here, but I think it should be revisited
> and perhaps made as:
> 
> sdw_config_stream(struct device *sdw, struct sdw_callback_ctx *ctx)
> 
> where the callback context contains all the other args. That would make
> it look lot neater too and of course use real structs if possible

the suggested sdw_callbback_ctx is really intel-specific at the moment, 
e.g. the notion of link_id and alh_stream_id are due to the hardware, 
it's not generic at all. And in the latest code we also pass the dai->id.

