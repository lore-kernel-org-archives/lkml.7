Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9572147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfD3OjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:39:04 -0400
Received: from foss.arm.com ([217.140.101.70]:48450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfD3OjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:39:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4E79374;
        Tue, 30 Apr 2019 07:39:03 -0700 (PDT)
Received: from [10.1.198.115] (e108754-lin.cambridge.arm.com [10.1.198.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7462F3F719;
        Tue, 30 Apr 2019 07:39:01 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
Message-ID: <8371be92-635b-1979-b1cd-6985ecb4811f@arm.com>
Date:   Tue, 30 Apr 2019 15:39:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On 29/04/2019 14:29, Ionela Voinescu wrote:
> Hi Thara,
> 
>>
>> 			Hackbench: (1 group , 30000 loops, 10 runs)
>> 				Result            Standard Deviation
>> 				(Time Secs)        (% of mean)
>>
>> No Thermal Pressure             10.21                   7.99%
>>
>> Instantaneous thermal pressure  10.16                   5.36%
>>
>> Thermal Pressure Averaging
>> using PELT fmwk                 9.88                    3.94%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 500 ms   9.94                    4.59%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 250 ms   7.52                    5.42%
>>
>> Thermal Pressure Averaging
>> non-PELT Algo. Decay : 125 ms   9.87                    3.94%
>>
>>
> 
> I'm trying your patches on my Hikey960 and I'm getting different results
> than the ones here.
> 
> I'm running with the step-wise governor, enabled only on the big cores.
> The decay period is set to 250ms.
> 
> The result for hackbench is:
> 
> # ./hackbench -g 1 -l 30000
> Running in process mode with 1 groups using 40 file descriptors each (== 40 tasks)
> Each sender will pass 30000 messages of 100 bytes
> Time: 20.756
> 
> During the run I see the little cores running at maximum frequency
> (1.84GHz) while the big cores run mostly at 1.8GHz, only sometimes capped
> at 1.42GHz. There should not be any capacity inversion.
> The temperature is kept around 75 degrees (73 to 77 degrees).
> 
> I don't have any kind of active cooling (no fans on the board), only a
> heatsink on the SoC.
> 
> But as you see my results(~20s) are very far from the 7-10s in your
> results.
> 
> Do you see anything wrong with this process? Can you give me more
> details on your setup that I can use to test on my board?
> 

I've found that my poor results above were due to debug options
mistakenly left enabled in the defconfig. Sorry about that!

After cleaning it up I'm getting results around 5.6s for this test case.
I've run 50 iterations for each test, with 90s cool down period between
them.


 			Hackbench: (1 group , 30000 loops, 50 runs)
 				Result            Standard Deviation
 				(Time Secs)        (% of mean)

 No Thermal Pressure(step_wise)  5.644                   7.760%
 No Thermal Pressure(IPA)        5.677                   9.062%

 Thermal Pressure Averaging
 non-PELT Algo. Decay : 250 ms   5.627                   5.593%
 (step-wise, bigs capped only)

 Thermal Pressure Averaging
 non-PELT Algo. Decay : 250 ms   5.690                   3.738%
 (IPA)

All of the results above are within 1.1% difference with a
significantly higher standard deviation.

I wanted to run this initially to validate my setup and understand
if there is any conclusion we can draw from a test like this, that
floods the CPUs with tasks. Looking over the traces, the tasks are
running almost back to back, trying to use all available resources,
on all the CPUs.
Therefore, I doubt that there could be better decisions that could be
made, knowing about thermal pressure, for this usecase.

I'll try next some capacity inversion usecase and post the results when
they are ready.

Hope it helps,
Ionela.


> Thank you,
> Ionela.
> 
