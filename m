Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D5EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E826821920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLVYojmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJJOxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:53:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54816 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJJOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:53:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so7282471wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogX19xTF57aFe3oLSZTYbHqPylf65sw/BnbPhbpyza4=;
        b=YLVYojmZHRibGzAKjxCtdNVt6hLytCZAIUouc12/g7OHFSJVb8NVOYj0YBUxQHe3kI
         snTuCRqGWF2n7c0MYnfyNT3T1rcH7cza8Rg1hQ9xZacfZC4JT5OQtX3dfhuO0cLO8V9T
         vtG3hxajSr8lDjXfWWjjEvoi7qF+niiC/x/xzUGDiRCYnUu6hg+U/gsY53mgR57oTMoR
         rV5j+5o1JU0Eox4Q19cutYZyrt6eR3gBSghIdsf8DyVUdNKysyaUl51ymtl6yd+2uumM
         tcbt5uN4ohwUg+NkP0U3QTW3eXTqk9Ubz+YR/9T2k1qrCG6yX3zDJ+ZFjNtpiXClpgiH
         OVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogX19xTF57aFe3oLSZTYbHqPylf65sw/BnbPhbpyza4=;
        b=OL6KwMR5UQIuACRLUYB+yV0SiLySyqjqlyK3hBUI5Hs4fviU3EFWXjMA6og0ccvRts
         UiOx+e4whXh8RcDQFSEwlsijMd0TT5Z/QLlsa3FY2iiLqgH1gcF1sEKLmolIgtf4NlGN
         pBRPjpkhcnuBc5CYzYvXiozAJYGKvZqLVQQ8z3QqOjKmXTo8QzNLpp64/l0Xu0KF/R77
         l8wG8sIbnAod015uhdTtCWyLBhvUrKKYsR9HVtqiD+q111Wcn7o6G9qhbWH4BPAiWbnO
         O8Yh1M1E3KyTgi76nIRVkIHPAW02vRW0wMUJGzzHlC6Bi/2eIDPjA7mAhvEZzIlu3LAE
         fh2g==
X-Gm-Message-State: APjAAAVv9OOoXUeC/wgIJSxIVbetL+d02WMgVpKC0ix7VW1QyDhaypKG
        j1Ik7itbf4lQ1/FMWWBIuFHMFg==
X-Google-Smtp-Source: APXvYqy+Bih+cBnFUqfiyHx+rF6V6v2BcFAwwwBD4aNU4yH5OgKLOSMFASKwGYJnqnhU8L4hJZeIzQ==
X-Received: by 2002:a05:600c:2481:: with SMTP id 1mr7649336wms.98.1570719178563;
        Thu, 10 Oct 2019 07:52:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h17sm8308000wme.6.2019.10.10.07.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:52:57 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        spapothi@codeaurora.org
References: <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
 <22eff3aa-dfd6-1ee5-8f22-2af492286053@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e671930b-645a-7ee3-6926-eea39626c0a3@linaro.org>
Date:   Thu, 10 Oct 2019 15:52:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <22eff3aa-dfd6-1ee5-8f22-2af492286053@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2019 15:01, Pierre-Louis Bossart wrote:
> 
>>>> It's been a while since this thread started, and I still don't
>>>> quite get the concepts or logic.
>>>>
>>>> First, I don't understand what the problem with "aux" devices is.
>>>> All the SoundWire stuff is based on the concept of DAI, so I guess
>>>> I am
>>>
>>> That is the actual problem! Some aux devices does not have dais.
>>>
>>
>> Usually aux devices are used for things like analog amplifiers that
>> clearly don't have a digital interface, thus it really makes no sense
>> to have a DAI link connecting them. So I guess my question here
>> would be what is the thinking on making the "smart amplifier" dailess?
>> It feels like having a CODEC to CODEC DAI between the CODEC and
>> the AMP would be a more obvious way to connect the two devices
>> and would presumably avoid the issues being discussed around the
>> patch.
> 
> Ah, now I get it, I missed the point about not having DAIs for the 
> amplifier.
> 
> I will second Charles' point, the code you have in the machine driver at 

I agree with Charles,

WSA8810/WSA8815 is connected via SoundWire digital interface, so I can 
try to model this amplifier with dais and see how it ends up.

I still need to figure out prefixing multiple instances of this 
Amplifier controls with "Left" and "Right"

> [1] gets a SoundWire stream context from the SLIMbus codec dai. It's a 
> bit odd to mix layers this way.

Yep we have a very mixed setup on this SoC.

So it looks like this.
Main WCD934X Codec which is connected via SLIMBus which has SoundWire 
Controller block along with other analog + digital blocks.
Again the SoundWire Controller from that WCD934X codec is wired up to 
WSA881X Smart speaker amplifiers.


> 
> 
> And if I look at the code below, taken from [1], if you have more than 
> one codec, then your code looks problematic: data->sruntime would be 
> overriden and you'd use the info from the last codec dai on the dailink...

This code has been written very much specific to DB845c which has only 
one codec. But I agree with your point.

--srini

> 
> case SLIMBUS_0_RX...SLIMBUS_6_TX:
>    for (i = 0 ; i < dai_link->num_codecs; i++) {
>      [snip]
>      data->sruntime[cpu_dai->id] =
>      snd_soc_dai_get_sdw_stream(rtd->codec_dais[i], 0); << same 
> destination for multiple codec_dais...
> 
> If you keep the amp dai-less, then the stream concept should be somehow 
> allocated on the master (or machine) side and passed to the codec dais 
> that are associated to the same 'stream'.
> 
> 
> [1] 
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/tree/sound/soc/qcom/db845c.c?h=release/db845c/qcomlt-5.2 
> 
> 
