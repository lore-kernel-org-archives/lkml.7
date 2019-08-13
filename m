Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6918C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C332620665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHMTPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:15:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:4865 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfHMTPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:15:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 12:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="200586463"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2019 12:15:00 -0700
Received: from dalyrusx-mobl.amr.corp.intel.com (unknown [10.251.3.205])
        by linux.intel.com (Postfix) with ESMTP id D9969580372;
        Tue, 13 Aug 2019 12:14:58 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
Date:   Tue, 13 Aug 2019 14:15:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 1:06 PM, Srinivas Kandagatla wrote:
> 
> 
> On 13/08/2019 18:51, Pierre-Louis Bossart wrote:
>> On 8/13/19 11:50 AM, Srinivas Kandagatla wrote:
>>> Thanks for the review,
>>>
>>> On 13/08/2019 15:44, Pierre-Louis Bossart wrote:
>>>> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>>>>> On platforms which have smart speaker amplifiers connected via
>>>>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>>>>> driver should be able to get sdw master stream from dai so that it can
>>>>> use the runtime stream to setup slave streams.
>>>>
>>>> using the _set_sdw_stream? I don't fully get the sequence with the 
>>>> wording above.
>>>
>>> Yes, using set_sdw_stream().
>>
>> Maybe I am missing something here, but I don't see where the 
>> set_sdw_stream() is called.
> 
> sorry for the confusion. It was too quick reply. :-)
> I was suppose to say sdw_stream_add_slave() instead of set_sdw_stream().

ok, so get_sdw_stream() and set_sdw_stream() are not meant to be mirrors 
or both implemented. It's just a helper to respectively get a context or 
set a context but a get-modify-set type of operation is not expected.

Do I get this right?

> 
> As Aux device is dailess there is no way to get hold of sdw stream 
> runtime for slave device associated with it.
> 
> Having snd_soc_dai_get_sdw_stream() would help machine driver to get 
> hold of sdw_stream_runtime from controller dai and setup slave streams 
> using sdw_stream_add_slave().
> 
> 
> thanks,
> srini
> 
> 
>>
>> Also I don't fully get the rule. set_sdw_stream() looks required, 
>> get_sdw_stream() is optional, is this what you are suggesting?
>>
>>>>
>>>>>
>>>>> soundwire already as a set function, get function would provide more
>>>>> flexibility to above configurations.
>>>>
>>>> I am not clear if you are asking for both to be used, or get only or 
>>>> set only?
>>>
>>> It depends on the usecase, in db845c usecase  [1] as Aux device is 
>>> dai less, machine driver is using get function to get hold of master 
>>> stream so that it can setup slave port config.
>>>
>>>
>>> Looks like there is a typo in above like
>>>
>>> This was supposed to be "soundwire already has a set function, get 
>>> function would provide more flexibility to above configurations"
>>>
>>> [1] 
>>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/sound/soc/qcom/db845c.c?h=integration-linux-qcomlt 
>>>
>>>
>>> thanks,
>>> srini
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>   include/sound/soc-dai.h | 10 ++++++++++
>>>>>   1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>>>>> index dc48fe081a20..1e01f4a302e0 100644
>>>>> --- a/include/sound/soc-dai.h
>>>>> +++ b/include/sound/soc-dai.h
>>>>> @@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
>>>>>       int (*set_sdw_stream)(struct snd_soc_dai *dai,
>>>>>               void *stream, int direction);
>>>>> +    void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>>>>>       /*
>>>>>        * DAI digital mute - optional.
>>>>>        * Called by soc-core to minimise any pops.
>>>>> @@ -410,4 +411,13 @@ static inline int 
>>>>> snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>>>>           return -ENOTSUPP;
>>>>>   }
>>>>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai 
>>>>> *dai,
>>>>> +                           int direction)
>>>>> +{
>>>>> +    if (dai->driver->ops->get_sdw_stream)
>>>>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>>>>> +    else
>>>>> +        return ERR_PTR(-ENOTSUPP);
>>>>> +}
>>>>> +
>>>>>   #endif
>>>>>
>>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>

