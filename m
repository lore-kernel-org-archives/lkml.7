Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B05C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE9214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfKGJcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:32:36 -0500
Received: from foss.arm.com ([217.140.110.172]:52634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKGJcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:32:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEC6F46A;
        Thu,  7 Nov 2019 01:32:34 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CBDE3F71A;
        Thu,  7 Nov 2019 01:32:32 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin> <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin> <5DC1E9BC.1010001@linaro.org>
 <20191105215233.GA6450@e108754-lin>
 <436ad772-c727-127e-1469-d99549db03fc@arm.com> <5DC3088B.8070401@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <943a8368-1f19-d981-7583-0db4e32895af@arm.com>
Date:   Thu, 7 Nov 2019 10:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5DC3088B.8070401@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2019 18:53, Thara Gopinath wrote:
> On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
>> On 05/11/2019 22:53, Ionela Voinescu wrote:
>>> On Tuesday 05 Nov 2019 at 16:29:32 (-0500), Thara Gopinath wrote:
>>>> On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
>>>>> On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
>>>>>> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
>>>>>>> Hi Thara,
>>>>>>>
>>>>>>> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
>>>>>>> [...]
>>>>>>>> +static void trigger_thermal_pressure_average(struct rq *rq)
>>>>>>>> +{
>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
>>>>>>>> +				per_cpu(thermal_pressure, cpu_of(rq)));
>>>>>>>> +#endif
>>>>>>>> +}
>>>>>>>
>>>>>>> Why did you decide to keep trigger_thermal_pressure_average and not
>>>>>>> call update_thermal_load_avg directly?
>>>>>>>
>>>>>>> For !CONFIG_SMP you already have an update_thermal_load_avg function
>>>>>>> that does nothing, in kernel/sched/pelt.h, so you don't need that
>>>>>>> ifdef. 
>>>>>> Hi,
>>>>>>
>>>>>> Yes you are right. But later with the shift option added, I shift
>>>>>> rq_clock_task(rq) by the shift. I thought it is better to contain it in
>>>>>> a function that replicate it in three different places. I can remove the
>>>>>> CONFIG_SMP in the next version.
>>>>>
>>>>> You could still keep that in one place if you shift the now argument of
>>>>> ___update_load_sum instead.
>>>>
>>>> No. I cannot do this. The authors of the pelt framework  prefers not to
>>>> include a shift parameter there. I had discussed this with Vincent earlier.
>>>>
>>>
>>> Right! I missed Vincent's last comment on this in v4. 
>>>
>>> I would argue that it's more of a PELT parameter than a CFS parameter
>>> :), where it's currently being used. I would also argue that's more of a
>>> PELT parameter than a thermal parameter. It controls the PELT time
>>> progression for the thermal signal, but it seems more to configure the
>>> PELT algorithm, rather than directly characterize thermals.
>>>
>>> In any case, it only seemed to me that adding a wrapper function for
>>> this purpose only was not worth doing.
>>
>> Coming back to the v4 discussion
>> https://lore.kernel.org/r/379d23e5-79a5-9d90-0fb6-125d9be85e99@arm.com
>>
>> There is no API between pelt.c and other parts of the scheduler/kernel
>> so why should we keep an unnecessary parameter and wrapper functions?
>>
>> There is also no abstraction, update_thermal_load_avg() in pelt.c even
>> carries '_thermal_' in its name.
>>
>> So why not define this shift value '[sched_|pelt_]thermal_decay_shift'
>> there as well? It belongs to update_thermal_load_avg().
>>
>> All call sites of update_thermal_load_avg() use 'rq_clock_task(rq) >>
>> sched_thermal_decay_shift' so I don't see the need to pass it in.
>>
>> IMHO, preparing for eventual code changes (e.g. parsing different now
>> values) is not a good practice in the kernel. Keeping the code small and
>> tidy is.
> 
> I think we are going in circles on this one. I acknowledge you have an
> issue. That being said, I also understand the need to keep the pelt
> framework code tight. Also Ionela pointed out that there could be a need
> for a faster decay in which case it could mean a left shift leading to
> further complications if defined in pelt.c (I am not saying that I will
> implement a faster decay in this patch set but it is more of a future
> extension if needed!)

The issue still exists so why not discussing it here?

Placing thermal related time shift operations in a
update_*thermal*_load_avg() PELT function look perfectly fine to me.

> I can make trigger_thermal_pressure_average inline if that will
> alleviate some of the concerns.

That's not the issue here. The issue is the extra shim layer which is
unnecessary in the current implementation.

update_blocked_averages()
{
    ...
    update_rt_rq_load_avg()
    update_dl_rq_load_avg()
    update_irq_load_avg()
    trigger_thermal_pressure_average() <--- ?
    ...
}

Wouldn't a direct call to update_thermal_load_avg() here make things so
much more clear? And I'm not talking about today and about people
involved in this review.

> I would also urge you to reconsider the merits of arguing this point
> back and forth.

I just did.

[...]
