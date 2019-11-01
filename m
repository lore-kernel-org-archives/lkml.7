Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8F1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BE62085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7gUsER0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfKARWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:22:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51214 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfKARWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:22:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id q70so10028954wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MpRg6nqoHYJ/pSBwFIjrrktBed6kT7iSbfFA/w2faoE=;
        b=G7gUsER0tv0aZqOVv8Y3URfYq478/asw+rQpa5aMIbdQ3gHHxu5VxIioUzSRzO0C90
         m6oKt0WJy+Ih0so1DbrGyD0PI7ZZ6AtmRXyaasQcKVsFoPflGG5F06K+lS1ZVQ/jV2NL
         iplZw7ZrvqRg7oKm4qBvgKoxGxtLx3nSSpAz728tvFbh1EztgcuRY8Hp5iPnBbKQUWfd
         bUe8DDLcTCFbLjYpg7uV2REvjjvTj2Dw0MecZRxRRoj2SVppAOupQ+UzPB+fmE+HDO/A
         eIpKbhZtJcqvofllGCu6pREuPuaZHXzoN8qam2C865TRazuBdyOX1Su7xy7m+WpiEBjM
         P5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MpRg6nqoHYJ/pSBwFIjrrktBed6kT7iSbfFA/w2faoE=;
        b=R8u9mKWLLFaNgiDvUZ/eqNIhTb4S8axq4TMrXD7tArTThrwL5zynBCYU7GcmfZ4eTC
         BcttZCQyX9w2ymkgDFdgX0q+Mc2ebngKv1Yk9Tlx313HpUx+BdwcOHdNVofFpb1vUy3B
         fe/vaSo3Ez2EbdLYZSIS/WRi3LNrHHl2MXPBF0LInGduyGGTxldyHH2L2nJpMEDWSjGc
         31/F48i+hD2kQyBTJF2ZVFw62tH7StTpxSm9JlkvGNfwsE4MlGfEH7mrfbsSuYbcZDPb
         RrakxjyriZH/l80e7NJ7gBtYfpfXPXjlEKqNBq9mQQJBG59fVit9US5EDHjVfw1qiiT7
         4c3Q==
X-Gm-Message-State: APjAAAXhMy+00CEhRG2DwnnQlBTWzPFPl5KDzTQ9nfqh6iscov4OBCEB
        mwjKEFQAY6Wv5hZa4QzDnThoYg==
X-Google-Smtp-Source: APXvYqw0qJqgEGHH9z4Y57tq14rEexdFZkWs0tWv7RFkvZVXE35wyn8WRC4YEb7LPfsnBK/ASDhOsA==
X-Received: by 2002:a05:600c:2385:: with SMTP id m5mr4227405wma.9.1572628926436;
        Fri, 01 Nov 2019 10:22:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u1sm12264367wru.90.2019.11.01.10.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 10:22:05 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v4 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org
References: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
 <20191030153150.18303-3-srinivas.kandagatla@linaro.org>
 <af29ec6e-d89e-7fa4-a8cd-29ab944ecd5c@linux.intel.com>
 <926bd15f-e230-8f5e-378d-355bfeeecf27@linaro.org>
 <3d17a2a2-3033-e740-a466-e6cf7919adb2@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7ea278b4-ecd4-bd17-4550-3f6f9136260e@linaro.org>
Date:   Fri, 1 Nov 2019 17:22:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3d17a2a2-3033-e740-a466-e6cf7919adb2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2019 16:39, Pierre-Louis Bossart wrote:
> 
>>>> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
>>>> +                 struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>>>> +
>>>> +    if (!ctrl->sruntime[dai->id])
>>>> +        return -EINVAL;
>>>> +
>>>> +    return sdw_enable_stream(ctrl->sruntime[dai->id]);
>>>
>>> So in hw_params you call sdw_prepare_stream() and in _prepare you 
>>> call sdw_enable_stream()?
>>>
>>> Shouldn't this be handled in a .trigger operation as per the 
>>> documentation "From ASoC DPCM framework, this stream state is linked to
>>> .trigger() start operation."
>>
>> If I move sdw_enable/disable_stream() to trigger I get a big click 
>> noise on my speakers at start and end of every playback. Tried 
>> different things but nothing helped so far!. Enabling Speaker DACs 
>> only after SoundWire ports are enabled is working for me!
>> There is nothing complicated on WSA881x codec side all the DACs are 
>> enabled/disabled as part of DAPM.
> 
> that looks like a work-around to me? If you do a bank switch without 
> anything triggered, you are most likely sending a bunch of zeroes to 
> your amplifier and enabling click/pop removals somehow.
> 
> It'd be worth looking into this, maybe there's a missing digital 
> mute/unmute that's not done in the right order?

Digital mute does not help too, as they get unmuted before 
sdw_enable_stream() call in trigger, I hit same click sound.

Same in the disable path too!

Also I noticed that there are more than 20+ register read/writes in the 
sdw_enable_stream() path which took atleast 30 to 40 milliseconds.


I will try my luck checking the docs to see if I can find something 
which talks about this.

--srini


> 
>>
>>>
>>> It's also my understanding that .prepare will be called multiples times, 
>>
>> I agree, need to add some extra checks in the prepare to deal with this!
>>
>>> including for underflows and resume if you don't support INFO_RESUME.
>>
>>>
>>> the sdw_disable_stream() is in .hw_free, which is not necessarily 
>>> called by the core, so you may have a risk of not being able to recover?
>>
>> Hmm, I thought hw_free is always called to release resources allocated 
>> in hw_params.
>>
>> In what cases does the core not call this?
> 
> yes, but prepare can be called without hw_free called first. that's why 
> we updated the state machine to allow for DISABLED|DEPREPARED -> 
> PREPARED transitions.
> 
>>>> +static const struct dev_pm_ops qcom_swrm_dev_pm_ops = {
>>>> +    SET_RUNTIME_PM_OPS(qcom_swrm_runtime_suspend,
>>>> +               qcom_swrm_runtime_resume,
>>>> +               NULL
>>>> +    )
>>>> +};
>>>
>>> Maybe define pm_runtime at a later time then? We've had a lot of race 
>>> conditions to deal with, and it's odd that you don't support plain 
>>> vanilla suspend first?
>>>
>> Trying to keep things simple for the first patchset! added this 
>> dummies to keep the soundwire core happy!
> 
> If you are referring to the errors when pm_runtime is not enabled, we 
> fixed this is the series that's been out for review for 10 days now...
> 
> see '[PATCH 03/18] soundwire: bus: add PM/no-PM versions of read/write 
> functions', that should remove the need for dummy functions.
> 
