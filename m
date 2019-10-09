Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3DEECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336D320679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaBfOFrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfJIQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:01:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34852 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731375AbfJIQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:01:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so3694243wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bDqDxoFy92WA4ghkXv1lx9zPC55ecQKMRynuRGpc+u0=;
        b=HaBfOFrHa9oyt36nChd39PrJeZUuOjiwkLqEufxO0FDeZaAM8pWk3w4qC1FGJOimkU
         6wWBfq2FQ/2E8UwhSjPpYWlZ+oBCdv6+FSOJIHJg4+UDLU1RVGiSXws/q5x6ExjaEtfU
         zY6UQfEr64W+A634cyy+tMjAFKqRE7kRsq7zQNtKYkuOe0Fk/sI/R66Q9wnewpNnPv5i
         YFish3WqSGpPEY6BlBJU4lqY8vkSGrKW0vVc6bHEhhpKx/OJhUGrnSdSK/7dpNia+Piu
         RBrnot2SiL8iXKl9WrBpL0hG05qmasETpP59f8VRzgfBv2358jKef340rHlceZw20cVW
         r4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDqDxoFy92WA4ghkXv1lx9zPC55ecQKMRynuRGpc+u0=;
        b=k7w1NOh+Pe8QGO1V8BPo7AJkCT1/0SH9yx4UIw2QHyOAXutJBoMEHKnQNhs9p1zKdo
         frlSJ9TRbqNbF2tJfA1n8fjUrPOYCBcloA4Oz34Z0IdM0b+LAeY0Y5dWzTr88HLrwQrz
         /3CwlSgzFepJExeKhygzJ9vs6JeoJAd9HOUrVrGtqUeqE+S0KUgEqPErRSuOPUD53uRf
         Z/VIi3UPdT1QJcqyTHGfY7HhGoonNCmHkotXtV+ZFxaR8QuC4GxlGNJ4FxfdTK2sbU2o
         S7u1hSVx4QEx4JxzcqBA112qtZLSvQ+GUJBDMBKzSyU8Zf+eOszL9aCKzSImDTJi9PiF
         IONg==
X-Gm-Message-State: APjAAAWsMZPTbmtMONVvzPMxpQubxptFb51b7JF3jo26S3Z79wO1lbkn
        OczAoMuU9yl2vAWgpAjc6RwCtA==
X-Google-Smtp-Source: APXvYqzS4G4hCzugWk9CK8hEXOZqPw/jgCNwNE5AD8pAOVurhhqma+ZSJFGExlpy2Hxm0bdJ4iPIUw==
X-Received: by 2002:adf:8123:: with SMTP id 32mr3763237wrm.300.1570636862592;
        Wed, 09 Oct 2019 09:01:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q124sm3600028wma.5.2019.10.09.09.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:01:01 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        spapothi@codeaurora.org
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
Date:   Wed, 9 Oct 2019 17:01:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2019 15:29, Pierre-Louis Bossart wrote:
> 
> 
> On 10/9/19 3:32 AM, Srinivas Kandagatla wrote:
>> Hi Pierre,
>>
>> On 14/08/2019 15:09, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 8/13/19 11:11 PM, Vinod Koul wrote:
>>>> On 13-08-19, 20:58, Mark Brown wrote:
>>>>> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> Indeed. I don't have a full understanding of that part to be 
>>>>>> honest, nor why
>>>>>> we need something SoundWire-specific. We already abused the 
>>>>>> set_tdm_slot API
>>>>>> to store an HDaudio stream, now we have a rather confusing stream
>>>>>> information for SoundWire and I have about 3 other 'stream' 
>>>>>> contexts in
>>>>>> SOF... I am still doing basic cleanups but this has been on my 
>>>>>> radar for a
>>>>>> while.
>>>>>
>>>>> There is something to be said for not abusing the TDM slot API if 
>>>>> it can
>>>>> make things clearer by using bus-idiomatic mechanisms, but it does 
>>>>> mean
>>>>> everything needs to know about each individual bus :/ .
>>>>
>>>> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
>>>> helps in the case for him to get the stream context and set the stream
>>>> context from the machine driver.
>>>>
>>>> Nothing else is expected to be done from this API. We already do a set
>>>> using snd_soc_dai_set_sdw_stream(). Here we add the 
>>>> snd_soc_dai_get_sdw_stream() to query
>>>
>>> I didn't see a call to snd_soc_dai_set_sdw_stream() in Srini's code?
>>
>>
>> There is a snd_soc_dai_get_sdw_stream() to get stream context and we 
>> add slave streams(amplifier in this case) to that context using 
>> sdw_stream_add_slave() in machine driver[1].
>>
>> Without this helper there is no way to link slave streams to stream 
>> context in non dai based setup like smart speaker amplifiers.
>>
>> Currently this driver is blocked on this patch, If you think there are 
>> other ways to do this, am happy to try them out.
> 
> So to be clear, you are *not* using snd_soc_dai_set_sdw_stream?
Yes, am not using snd_soc_dai_set_sdw_stream().

--srini
> 
> 
> 
> 
> 
