Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96335C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEE92064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crKc/7fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfHMSGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:06:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35283 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfHMSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:06:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so22760960wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dbz/igoDoo4+zLxs3kF9+hv9Esg794AftEWjrVInnJg=;
        b=crKc/7fwPh5m+g0e/i39wYeK5QmB4xu5OeW7rfKDO+Bq/9qNZgYMaLTqHvSawI94wE
         jBqROdM2P1VWbYHmQKvFY+DFOlrTE91xcSAH0k6BpHu9v0sYwByfulGgpq8db8lxbinI
         hGM44abSoBlDNcRhNKS2vt0xv357FOof9cDZm6viVbbfVB7Wrj6cwWbzGtLCZFjuCxHo
         FlLxfxc5ixtJTkgDG7Y8zml7gbd4SdtWcvmOhYONMNUCdYiBfb3pF6iLmxCgqrUFw4KX
         0xq3fDXUiqHCQgC4AZN+jPCSv9PPjRsd9RBJI+J6g7U/baizMlf5WEpO1Udmplxj1Zxa
         +2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dbz/igoDoo4+zLxs3kF9+hv9Esg794AftEWjrVInnJg=;
        b=PlJGjGDSyulLjuxXi5PXxXkdIx35ARlaEEVxgg/gZE5c6gsjPZ8ZolC+hJdLdrPtxb
         ZZV/TtSRt6EcnvL8Udnaf2RlnUv9ISJ/S5n/9NACe3f9DrA64iS3p/tgaugB5Z0MCs1J
         Q38TgnyyMoOUZFpZAiwbPsM7V7xW1WLCD13LAEyS7iY+ZLlwmLY5BzvcRGQia9qm+JOo
         O50cxx8ML+lGeiQ8xRA1xi4x/w9IPwjnzSzUgvsT9rTiqv0sqHr7H++Ptg6TutcP5Snc
         A5h4s7YC9dlvYLw0TKgIgiBR4bLkNfKMWQ07YyAtP3A/kkcVRht++n9kIAW6SgCi98DM
         hHPQ==
X-Gm-Message-State: APjAAAXBMH9zJ17OH3uc5IPmxLre6PAu97BHFah1GYFDoV9Ru47LOqfP
        lgVZvZ3W+hz1vr7+lPwJmaH/RA==
X-Google-Smtp-Source: APXvYqzgl6xdkykBM+mhjTBQLfQ5t1yXWfJm/Upuv3NFiGY2+Yb08ANGQdW5WEwn7wKhRxX0zMlI5Q==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr39426525wrx.41.1565719606987;
        Tue, 13 Aug 2019 11:06:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u186sm3990440wmu.26.2019.08.13.11.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:06:46 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
Date:   Tue, 13 Aug 2019 19:06:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 18:51, Pierre-Louis Bossart wrote:
> On 8/13/19 11:50 AM, Srinivas Kandagatla wrote:
>> Thanks for the review,
>>
>> On 13/08/2019 15:44, Pierre-Louis Bossart wrote:
>>> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>>>> On platforms which have smart speaker amplifiers connected via
>>>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>>>> driver should be able to get sdw master stream from dai so that it can
>>>> use the runtime stream to setup slave streams.
>>>
>>> using the _set_sdw_stream? I don't fully get the sequence with the 
>>> wording above.
>>
>> Yes, using set_sdw_stream().
> 
> Maybe I am missing something here, but I don't see where the 
> set_sdw_stream() is called.

sorry for the confusion. It was too quick reply. :-)
I was suppose to say sdw_stream_add_slave() instead of set_sdw_stream().

As Aux device is dailess there is no way to get hold of sdw stream 
runtime for slave device associated with it.

Having snd_soc_dai_get_sdw_stream() would help machine driver to get 
hold of sdw_stream_runtime from controller dai and setup slave streams 
using sdw_stream_add_slave().


thanks,
srini


> 
> Also I don't fully get the rule. set_sdw_stream() looks required, 
> get_sdw_stream() is optional, is this what you are suggesting?
> 
>>>
>>>>
>>>> soundwire already as a set function, get function would provide more
>>>> flexibility to above configurations.
>>>
>>> I am not clear if you are asking for both to be used, or get only or 
>>> set only?
>>
>> It depends on the usecase, in db845c usecase  [1] as Aux device is dai 
>> less, machine driver is using get function to get hold of master 
>> stream so that it can setup slave port config.
>>
>>
>> Looks like there is a typo in above like
>>
>> This was supposed to be "soundwire already has a set function, get 
>> function would provide more flexibility to above configurations"
>>
>> [1] 
>> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/sound/soc/qcom/db845c.c?h=integration-linux-qcomlt 
>>
>>
>> thanks,
>> srini
>>
>>>
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>   include/sound/soc-dai.h | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>>>> index dc48fe081a20..1e01f4a302e0 100644
>>>> --- a/include/sound/soc-dai.h
>>>> +++ b/include/sound/soc-dai.h
>>>> @@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
>>>>       int (*set_sdw_stream)(struct snd_soc_dai *dai,
>>>>               void *stream, int direction);
>>>> +    void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>>>>       /*
>>>>        * DAI digital mute - optional.
>>>>        * Called by soc-core to minimise any pops.
>>>> @@ -410,4 +411,13 @@ static inline int 
>>>> snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>>>           return -ENOTSUPP;
>>>>   }
>>>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai 
>>>> *dai,
>>>> +                           int direction)
>>>> +{
>>>> +    if (dai->driver->ops->get_sdw_stream)
>>>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>>>> +    else
>>>> +        return ERR_PTR(-ENOTSUPP);
>>>> +}
>>>> +
>>>>   #endif
>>>>
>>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
