Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A7FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F7E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/kFfAx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389139AbfJJIud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:50:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38017 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389110AbfJJIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:50:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so5837542wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CaSbN7PRxQjoeZuLYZCS/ibrJufD/sGhgzh/IxmCXB0=;
        b=Q/kFfAx5bsul8OwzADd7GaD5P3N6vWkTxheK4IdLMtL3FweIIQGg3nrFmDj9FsjwYv
         g7VN4G0a+M4PgzOA5Z0f2Zj6STOST83/zIrUavjrlsK4MWXKcWXCVnlvobfPS8Y3zG13
         izHikJVVQf5NXthw+W+0V7fdGmH0jX+cMF0RBf5Xdnals8I5ckqMg1h0RYILD4IUb3LK
         qhl5/ac1GEn2CpW9AKp0Yw4Xfhcz2win1W58PFaHrnePSL5GCSRpM3g3hHB7kffo8r9S
         6QFD3RrPlHh6V1rWv7LDuDHFeB3ejpUlnLjitW4zh+HJlgw0kgEN8dCk66RQzp+jrjjN
         CPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CaSbN7PRxQjoeZuLYZCS/ibrJufD/sGhgzh/IxmCXB0=;
        b=mWUfWFG5iQk4Z9RRU+1/kOnxja8kbJ9yyhI77aCIayfrDc59A8d1Y7TOMiBJRlFUDb
         hjHEeYOt+qQf84zytUfSxJ6Ovfh2bmWE0qolDvH/F1Iw3A0gMFWWD5X59bd0MriHR3MC
         0VpcO4WdhLQ0Os+Vf9hq7g+GUV7dFF8WcJ0CO9IR7aJJEwgQLqkXoouG4IAK5V+UynZI
         zzupgCmwC2a25tqipVp+Ai2bCYc1SOy8xvsQyxZztHHMTXiypmlalXgCZNRYI85xhboU
         pEiOhlVZtDlcqwHHc1tas+9H33ciYJNEdFEwZ17wLNFtswRcjLn/1HWJgaKfFopGIV4T
         spZA==
X-Gm-Message-State: APjAAAVtVacJmQbDfvUteSMChptAZuHHUG650VY0KLdM/ssObaokT20F
        3DvFbBXF+X83bH+n1/CZEkvgTg==
X-Google-Smtp-Source: APXvYqynP6wIggXzDDvzdrv2aJ+sTKUmFj2Xg07oubjzNbikJp1j3UntU1oUCON1/ZzY0a39oVbQlg==
X-Received: by 2002:a05:600c:1088:: with SMTP id e8mr6697021wmd.27.1570697424720;
        Thu, 10 Oct 2019 01:50:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b130sm7435533wmh.12.2019.10.10.01.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 01:50:23 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
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
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
Date:   Thu, 10 Oct 2019 09:50:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2019 19:53, Pierre-Louis Bossart wrote:
> 
> 
> On 10/9/19 11:01 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 09/10/2019 15:29, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 10/9/19 3:32 AM, Srinivas Kandagatla wrote:
>>>> Hi Pierre,
>>>>
>>>> On 14/08/2019 15:09, Pierre-Louis Bossart wrote:
>>>>>
>>>>>
>>>>> On 8/13/19 11:11 PM, Vinod Koul wrote:
>>>>>> On 13-08-19, 20:58, Mark Brown wrote:
>>>>>>> On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart 
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Indeed. I don't have a full understanding of that part to be 
>>>>>>>> honest, nor why
>>>>>>>> we need something SoundWire-specific. We already abused the 
>>>>>>>> set_tdm_slot API
>>>>>>>> to store an HDaudio stream, now we have a rather confusing stream
>>>>>>>> information for SoundWire and I have about 3 other 'stream' 
>>>>>>>> contexts in
>>>>>>>> SOF... I am still doing basic cleanups but this has been on my 
>>>>>>>> radar for a
>>>>>>>> while.
>>>>>>>
>>>>>>> There is something to be said for not abusing the TDM slot API if 
>>>>>>> it can
>>>>>>> make things clearer by using bus-idiomatic mechanisms, but it 
>>>>>>> does mean
>>>>>>> everything needs to know about each individual bus :/ .
>>>>>>
>>>>>> Here ASoC doesn't need to know about sdw bus. As Srini explained, 
>>>>>> this
>>>>>> helps in the case for him to get the stream context and set the 
>>>>>> stream
>>>>>> context from the machine driver.
>>>>>>
>>>>>> Nothing else is expected to be done from this API. We already do a 
>>>>>> set
>>>>>> using snd_soc_dai_set_sdw_stream(). Here we add the 
>>>>>> snd_soc_dai_get_sdw_stream() to query
>>>>>
>>>>> I didn't see a call to snd_soc_dai_set_sdw_stream() in Srini's code?
>>>>
>>>>
>>>> There is a snd_soc_dai_get_sdw_stream() to get stream context and we 
>>>> add slave streams(amplifier in this case) to that context using 
>>>> sdw_stream_add_slave() in machine driver[1].
>>>>
>>>> Without this helper there is no way to link slave streams to stream 
>>>> context in non dai based setup like smart speaker amplifiers.
>>>>
>>>> Currently this driver is blocked on this patch, If you think there 
>>>> are other ways to do this, am happy to try them out.
>>>
>>> So to be clear, you are *not* using snd_soc_dai_set_sdw_stream?
>> Yes, am not using snd_soc_dai_set_sdw_stream().
> 
> It's been a while since this thread started, and I still don't quite get 
> the concepts or logic.
> 
> First, I don't understand what the problem with "aux" devices is. All 
> the SoundWire stuff is based on the concept of DAI, so I guess I am 

That is the actual problem! Some aux devices does not have dais.

> missing why introducing the "aux" device changes anything.
> 

Problem is that aux devices(amplifier) are dai less but connected via 
SoundWire. So question is how do we attach those SoundWire streams to 
SoundWire master stream?

My Idea was to get handle to the SoundWire stream from controller dai 
and adding these aux SoundWire slave devices as slave to them in machine 
driver. This was much less intrusive than other solutions.

Is there a better way to associate a dai-less codecs to SoundWire master 
stream?

> Next, a 'stream' connects multiple DAIs to transmit information from 
> sources to sinks. A DAI in itself is created without having any notion 
> of which stream it will be associated with. This can only be done with 
> machine level information.
> 
> If you query a DAI to get a stream context, then how is this stream 
> context allocated in the first place? It looks like a horse and cart 
> problem. Or you are assuming that a specific DAI provides the context, 
> and that all other DAIs do not expose this .get_sdw_stream()? What if 
> more that 1 DAI provide a stream context?

In this particular board setup. Soundwire master is allocating the 
stream runtime for each of it dais, and this runtime is used in machine 
driver to attach Auxdev Soundwire slaves.

Other setups where the codec has dai should work as expected!


> 
> And last, I am even more lost since w/ the existing codec drivers we 
> have, sdw_stream_add_slave() is called from the dai .hw_params callback, 
> once you have information on formats/rates, etc. using 
> sdw_stream_add_slave() from a machine driver looks like an even bigger 
> stretch. I really thought the machine driver would only propagate the 
> notion of stream to all DAIs that are part of the same dailink.
> 
> I am not trying to block the Qualcomm implementation, just would like to 
> make sure the assumptions are clear and that we are not using the same 
> API in completely different ways.

Am open for any suggestions on dealing with dai less setups like what we 
have on our board.

--srini
> 
> 
> 
> 
