Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F821C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D809321670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjSLcF2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfD3QKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:10:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45208 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:10:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id b3so16760662qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8AN6ep9mNdUa7gnX6C5esMrIuerPErujN9+xJ7wR15A=;
        b=fjSLcF2sGref4PQME0CxL6FXUxSHxI28O/+/MZTPx/Fu5aPacVhPp4PR1KYQw0DD27
         DQIZCKP0TUbdu8JkvqsL9RNCmMAwcTTF4ptsC3MCiJMPEAOAvWuIlrqfP/Aaa4MTxLQn
         TRVEj8lm2a5XsrL17oz96OVcZ1xSHW+YixU/9WUhonNAuieqfxdlByL6GpxSJuMIioAc
         iDkWqaxLClscNUIktZhG0dnY2g9oHw+0J7Zka9aHU/Ujkr9I9sWP0YyPvDDxqTcYtqY7
         8119U5/DDnuMi4teT8Aguh2v7UKwKI9DvSGt/f5Q1cN8r0oQIUwBVX9+OJckLnzo68FD
         Gd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8AN6ep9mNdUa7gnX6C5esMrIuerPErujN9+xJ7wR15A=;
        b=br0i8r9wiOFgSREBpqftluDKO0zN1868vcdY0IqKnv0J3YAPC7tMuFsTm2UP2Ogzrb
         SDdYvHH05BYYlsHIz/Dvxb0su7yzYwiyH6hDWM+n6DwyO2vdZ2LPcfxtdQVC7RNd6wrU
         bnRbdtRtQHikYorUcnd9Bi70FjYpKkAICr+dFctnUCY2JM6fWxWZWT39jcDSb/mvlcai
         NNSFilLl9qmE//TwsQNbgLZ34w3b5Kn0ihZmkKkqNCO3sX97Ef0Kxv3YvcBme0yoLY3W
         PBvYfSE5mPtvFnWJMZAB3gMIeHtyRcoIlaTTwQ8sZgsnoYY+vtFT7dSE1flDZ2oyIyYz
         Thyg==
X-Gm-Message-State: APjAAAW205RmaIZNRIsdw6E/CCYQnsCWWM+moou+mH6T4cUQFsk21dDm
        f2wQ7ef+gJLE7QHnqhMtYaSw8w==
X-Google-Smtp-Source: APXvYqwhJ/Fy7Be3oirq7ksoxFEELVfHGhB67HJK1DrcE+ycA4rYxlf0yTTMN3yx6Jr5wImLa48kLQ==
X-Received: by 2002:aed:3681:: with SMTP id f1mr7242941qtb.240.1556640612995;
        Tue, 30 Apr 2019 09:10:12 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id a124sm3677787qkd.3.2019.04.30.09.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:10:11 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
 <8371be92-635b-1979-b1cd-6985ecb4811f@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC87362.6080307@linaro.org>
Date:   Tue, 30 Apr 2019 12:10:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <8371be92-635b-1979-b1cd-6985ecb4811f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2019 10:39 AM, Ionela Voinescu wrote:
> Hi Thara,
> 
> On 29/04/2019 14:29, Ionela Voinescu wrote:
>> Hi Thara,
>>
>>>
>>> 			Hackbench: (1 group , 30000 loops, 10 runs)
>>> 				Result            Standard Deviation
>>> 				(Time Secs)        (% of mean)
>>>
>>> No Thermal Pressure             10.21                   7.99%
>>>
>>> Instantaneous thermal pressure  10.16                   5.36%
>>>
>>> Thermal Pressure Averaging
>>> using PELT fmwk                 9.88                    3.94%
>>>
>>> Thermal Pressure Averaging
>>> non-PELT Algo. Decay : 500 ms   9.94                    4.59%
>>>
>>> Thermal Pressure Averaging
>>> non-PELT Algo. Decay : 250 ms   7.52                    5.42%
>>>
>>> Thermal Pressure Averaging
>>> non-PELT Algo. Decay : 125 ms   9.87                    3.94%
>>>
>>>
>>
>> I'm trying your patches on my Hikey960 and I'm getting different results
>> than the ones here.
>>
>> I'm running with the step-wise governor, enabled only on the big cores.
>> The decay period is set to 250ms.
>>
>> The result for hackbench is:
>>
>> # ./hackbench -g 1 -l 30000
>> Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
>> Each sender will pass 30000 messages of 100 bytes
>> Time: 20.756
>>
>> During the run I see the little cores running at maximum frequency
>> (1.84GHz) while the big cores run mostly at 1.8GHz, only sometimes capped
>> at 1.42GHz. There should not be any capacity inversion.
>> The temperature is kept around 75 degrees (73 to 77 degrees).
>>
>> I don't have any kind of active cooling (no fans on the board), only a
>> heatsink on the SoC.
>>
>> But as you see my results(~20s) are very far from the 7-10s in your
>> results.
>>
>> Do you see anything wrong with this process? Can you give me more
>> details on your setup that I can use to test on my board?
>>
> 
> I've found that my poor results above were due to debug options
> mistakenly left enabled in the defconfig. Sorry about that!
> 
> After cleaning it up I'm getting results around 5.6s for this test case.
> I've run 50 iterations for each test, with 90s cool down period between
> them.
> 
> 
>  			Hackbench: (1 group , 30000 loops, 50 runs)
>  				Result            Standard Deviation
>  				(Time Secs)        (% of mean)
> 
>  No Thermal Pressure(step_wise)  5.644                   7.760%
>  No Thermal Pressure(IPA)        5.677                   9.062%
> 
>  Thermal Pressure Averaging
>  non-PELT Algo. Decay : 250 ms   5.627                   5.593%
>  (step-wise, bigs capped only)
> 
>  Thermal Pressure Averaging
>  non-PELT Algo. Decay : 250 ms   5.690                   3.738%
>  (IPA)
> 
> All of the results above are within 1.1% difference with a
> significantly higher standard deviation.

Hi Ionela,

I have replied to your original emails without seeing this one. So,
interesting results. I see IPA is worse off (Slightly) than step wise in
both thermal pressure and non-thermal pressure scenarios. Did you try
500 ms decay period by any chance?

> 
> I wanted to run this initially to validate my setup and understand
> if there is any conclusion we can draw from a test like this, that
> floods the CPUs with tasks. Looking over the traces, the tasks are
> running almost back to back, trying to use all available resources,
> on all the CPUs.
> Therefore, I doubt that there could be better decisions that could be
> made, knowing about thermal pressure, for this usecase.
> 
> I'll try next some capacity inversion usecase and post the results when
> they are ready.

Sure. let me know if I can help.

Regards
Thara

> 
> Hope it helps,
> Ionela.
> 
> 
>> Thank you,
>> Ionela.
>>


-- 
Regards
Thara
