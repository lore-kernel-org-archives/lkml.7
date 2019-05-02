Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54225C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A662075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEBKpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:45:02 -0400
Received: from foss.arm.com ([217.140.101.70]:43664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:45:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5846CA78;
        Thu,  2 May 2019 03:45:01 -0700 (PDT)
Received: from [10.1.198.115] (e108754-lin.cambridge.arm.com [10.1.198.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFFD33F719;
        Thu,  2 May 2019 03:44:58 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <8eed9601-8bbb-9f62-f786-f08bd4a72907@arm.com>
 <8371be92-635b-1979-b1cd-6985ecb4811f@arm.com> <5CC87362.6080307@linaro.org>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <632321a8-d7f0-49a6-9577-95fac4c87b1c@arm.com>
Date:   Thu, 2 May 2019 11:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CC87362.6080307@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

>> After cleaning it up I'm getting results around 5.6s for this test case.
>> I've run 50 iterations for each test, with 90s cool down period between
>> them.
>>
>>
>>  			Hackbench: (1 group , 30000 loops, 50 runs)
>>  				Result            Standard Deviation
>>  				(Time Secs)        (% of mean)
>>
>>  No Thermal Pressure(step_wise)  5.644                   7.760%
>>  No Thermal Pressure(IPA)        5.677                   9.062%
>>
>>  Thermal Pressure Averaging
>>  non-PELT Algo. Decay : 250 ms   5.627                   5.593%
>>  (step-wise, bigs capped only)
>>
>>  Thermal Pressure Averaging
>>  non-PELT Algo. Decay : 250 ms   5.690                   3.738%
>>  (IPA)
>>
>> All of the results above are within 1.1% difference with a
>> significantly higher standard deviation.
> 
> Hi Ionela,
> 
> I have replied to your original emails without seeing this one. So,
> interesting results. I see IPA is worse off (Slightly) than step wise in
> both thermal pressure and non-thermal pressure scenarios. Did you try
> 500 ms decay period by any chance?
>

I don't think we can draw a conclusion on that given how close the
results are and given the high standard deviation. Probably if I run
them again the tables will be turned :).

I did not run experiments with different decay periods yet, as I want to
have first a list  of experiments that are relevant for thermal pressure,
that can help later with refining the solution, which can mean either
deciding on a decay period or possibly going with the instantaneous
thermal pressure. Please find more details below.

>>
>> I wanted to run this initially to validate my setup and understand
>> if there is any conclusion we can draw from a test like this, that
>> floods the CPUs with tasks. Looking over the traces, the tasks are
>> running almost back to back, trying to use all available resources,
>> on all the CPUs.
>> Therefore, I doubt that there could be better decisions that could be
>> made, knowing about thermal pressure, for this usecase.
>>
>> I'll try next some capacity inversion usecase and post the results when
>> they are ready.
> 

I've started looking into this, starting from the most obvious case of
capacity inversion: using the user-space thermal governor and capping
the bigs to their lowest OPP. The LITTLEs are left uncapped.

This was not enough on the Hikey960 as the bigs at their lowest OPP were
in the capacity margin of the LITTLEs at their highest OPP. That meant
that LITTLEs would not pull tasks from the bigs, even if they had higher
capacity, as the capacity was in within the 25% margin. So another
change I've made was to set the capacity margin in fair.c to 10%.

I've run both sysbench and dhrystone. I'll put here only the results for
sysbench, interleaved, with and without considering thermal pressure (TP
and !TP).
As before, the TP solution uses averaging with a 250ms decay period.

               			Sysbench: (500000 req, 4 runs)
  				Result            Standard Deviation
  				(Time Secs)        (% of mean)

  !TP/4 threads                   146.46          0.063%
  TP/4 threads                    136.36          0.002%

  !TP/5 threads                   115.38          0.028%
  TP/5 threads                    110.62          0.006%

  !TP/6 threads                   95.38           0.051%
  TP/6 threads                    93.07           0.054%

  !TP/7 threads                   81.19           0.012%
  TP/7 threads                    80.32           0.028%

  !TP/8 threads                   72.58           2.295%
  TP/8 threads                    71.37           0.044%

As expected, the results are significantly improved when the scheduler
is let know of reduced capacity on the bigs which results in tasks being
placed or migrated to the littles which are able to provide better
performance. Traces nicely confirm this.

To be noted that these results only show that reflecting thermal
pressure in the capacity of the CPUs is useful and the scheduler is
equipped to make proper use of this information.
Possibly a thing to consider is whether or not to reduce the capacity
margin, but that's for another discussion.

This does not reflect the benefits of averaging, as, with the bigs
always being capped to the lowest OPP, the thermal pressure value will
be constant over the duration of the workload. The same results would
have been obtained with instantaneous thermal pressure.


Secondly, I've tried to use the step-wise governor, modified to only
cap the big CPUs, with the intention to obtain smaller periods of
capacity inversion for which a thermal pressure solution would show its
benefits.

Unfortunately dhrystone was misbehaving for some reason and was
giving me a high variation between results for the same test case.
Also, sysbench, ran with the same arguments as above, was not creating
enough load and thermal capping as to show the benefits of considering
thermal pressure.

So my recommendation is continue exploiting more test-cases like these.
I would continue with sysbench as it looks more stable, but modify the
the temperature threshold to determine periods of drastic capping of the
bigs. Once a dynamic test case and setup like this (no fixing
frequencies) is identified, it can be used to understand if averaging
is needed and to refine the decay period, and establish a good default.

What do you think? Does this make sense as a direction for obtaining
test cases? In my opinion the previous test cases were not  triggering
the right behaviors that can help prove the need for thermal pressure,
or help refine it. 

I will try to continue in this direction, but I won't be able to get to
in for a few days.

You'll find more results at: 
https://docs.google.com/spreadsheets/d/1ibxDSSSLTodLzihNAw6jM36eVZABuPMMnjvV-Xh4NEo/edit?usp=sharing


> Sure. let me know if I can help.

Any test results or recommendations for test cases would be helpful.
The need for thermal pressure is obvious, but the way that thermal
pressure is reflected in the capacity of the CPUs could be supported by
more thorough testing.

Regards,
Ionela.

> 
> Regards
> Thara
> 
>>
>> Hope it helps,
>> Ionela.
>>
>>
>>> Thank you,
>>> Ionela.
>>>
> 
> 
