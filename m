Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827E5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E08221901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfDXP5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:57:00 -0400
Received: from foss.arm.com ([217.140.101.70]:47682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfDXP47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:56:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06188A78;
        Wed, 24 Apr 2019 08:56:59 -0700 (PDT)
Received: from [10.1.194.42] (e108754-lin.cambridge.arm.com [10.1.194.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 854B43F557;
        Wed, 24 Apr 2019 08:56:56 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin> <5CBF93F6.8000109@linaro.org>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <84e64cb1-db2d-6519-e0c4-97779079d96d@arm.com>
Date:   Wed, 24 Apr 2019 16:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5CBF93F6.8000109@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 23/04/2019 23:38, Thara Gopinath wrote:
> On 04/18/2019 05:48 AM, Quentin Perret wrote:
>> On Tuesday 16 Apr 2019 at 15:38:41 (-0400), Thara Gopinath wrote:
>>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>>> @@ -177,6 +178,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>>>  
>>>  		if (policy->max > clipped_freq)
>>>  			cpufreq_verify_within_limits(policy, 0, clipped_freq);
>>> +
>>> +		sched_update_thermal_pressure(policy->cpus,
>>> +				policy->max, policy->cpuinfo.max_freq);
>>
>> Is this something we could do this CPUFreq ? Directly in
>> cpufreq_verify_within_limits() perhaps ?
>>
>> That would re-define the 'thermal pressure' framework in a more abstract
>> way and make the scheduler look at 'frequency capping' events,
>> regardless of the reason for capping.
>>
>> That would reflect user-defined frequency constraint into cpu_capacity,
>> in addition to the thermal stuff. I'm not sure if there is another use
>> case for frequency capping ?
> Hi Quentin,
> Thanks for the review. Sorry for the delay in response as I was on
> vacation for the past few days.
> I think there is one major difference between user-defined frequency
> constraints and frequency constraints due to thermal events in terms of
> the time period the system spends in the the constraint state.
> Typically, a user constraint lasts for seconds if not minutes and I
> think in this case cpu_capacity_orig should reflect this constraint and
> not cpu_capacity like this patch set. Also, in case of the user
> constraint, there is possibly no need to accumulate and average the
> capacity constraints and instantaneous values can be directly applied to
> cpu_capacity_orig. On the other hand thermal pressure is more spiky and
> sometimes in the order of ms and us requiring the accumulating and
> averaging.

I think we can't make any assumptions in regards to the intentions of
the user when restricting the OPP range though the cpufreq interface,
but it would still be nice to do something and reflecting it as thermal
pressure would be a good start. It might not be due to thermal, but it
is a capacity restriction that would have the same result. Also, if the
user has the ability to tune the decay period he has the control over
the behavior of the signal. Given that currently there isn't a smarter
mechanism (modifying capacity orig, re-normalising the capacity range)
for long-term capping, even treating it as short-term capping is a good
start. But this is a bigger exercise and it needs thorough
consideration, so it could be skipped, in my opinion, for now.. 

Also, if we want to stick with the "definition", userspace would still
be able to reflect thermal pressure though the thermal limits interface
by setting the cooling device state, which will be reflected in this
update as well. So userspace would have a mechanism to reflect thermal
pressure.

One addition.. I like that the thermal pressure framework is not tied to
cpufreq. There are firmware solutions that do not bother informing
cpufreq of limits being changed, and therefore all of this could be
skipped. But any firmware driver could call sched_update_thermal_pressure
on notifications for limits changing from firmware, which is an
important feature.

>>
>> Perhaps the Intel boost stuff could be factored in there ? That is,
>> at times when the boost freq is not reachable capacity_of() would appear
>> smaller ... Unless this wants to be reflected instantaneously ?
> Again, do you think intel boost is more applicable to be reflected in
> cpu_capacity_orig and not cpu_capacity?
>>
>> Thoughts ?
>> Quentin
>>
> 

The changes here would happen even faster than thermal capping, same as
other restrictions imposed by firmware, so it would not seem right to me
to reflect it in capacity_orig. Reflecting it as thermal pressure is
another matter, which I'd say it should be up to the client. The big
disadvantage I'd see for this is coping with decisions made while being
capped, when you're not capped any longer, and the other way around. I
believe these changes would happen too often and they will not happen in
a ramp-up/ramp-down behavior that we expect from thermal mitigation.
That's why I believe averaging/regulation of the signal works well in
this case, and it might not for power related fast restrictions.

But given these three cases above, it might be that the ideal solution
is for this framework to be made more generic and for each client to be
able to obtain and configure a pressure signal to be reflected
separately in the capacity of each CPU.

My two pennies' worth,
Ionela.



