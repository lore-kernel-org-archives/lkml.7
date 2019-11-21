Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F27AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5704A206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUOvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:51:11 -0500
Received: from foss.arm.com ([217.140.110.172]:57558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfKUOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:51:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161AFDA7;
        Thu, 21 Nov 2019 06:51:10 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4FB83F703;
        Thu, 21 Nov 2019 06:51:08 -0800 (PST)
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191121115602.GA213296@google.com>
 <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
 <20191121133043.GA46904@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <09e234a2-ea65-4d09-5215-9b0fe4ec09fe@arm.com>
Date:   Thu, 21 Nov 2019 14:51:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121133043.GA46904@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2019 13:30, Quentin Perret wrote:
> On Thursday 21 Nov 2019 at 12:56:39 (+0000), Valentin Schneider wrote:
>>> @@ -6274,6 +6274,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>>  			if (!fits_capacity(util, cpu_cap))
>>>  				continue;
>>>  
>>> +			/*
>>> +			 * Skip CPUs that don't satisfy uclamp requests. Note
>>> +			 * that the above already ensures the CPU has enough
>>> +			 * spare capacity for the task; this is only really for
>>> +			 * uclamp restrictions.
>>> +			 */
>>> +			if (!task_fits_capacity(p, capacity_orig_of(cpu)))
>>> +				continue;
>>
>> This is partly redundant with the above, I think. What we really want here
>> is just
>>
>> fits_capacity(uclamp_eff_value(p, UCLAMP_MIN), capacity_orig_of(cpu))
>>
>> but this would require some inline #ifdeffery.
> 
> This suggested change lacks the UCLAMP_MAX part, which is a shame
> because this is precisely in the EAS path that we should try and
> down-migrate tasks if they have an appropriate max_clamp. So, your first
> proposal made sense, IMO.
> 
 
Hm right, had to let that spin in my head for a while but I think I got it.

I was only really thinking of:

  (h960: LITTLE = 462 cap, big = 1024)
  p.uclamp.min = 512 -> skip LITTLEs regardless of the actual util_est

but your point is we also want stuff like:

  p.uclamp.max = 300 -> accept LITTLEs regardless of the actual util_est

I'll keep the feec() change as-is and add something like the above in the
changelog for v2.

> Another option to avoid the redundancy would be to do something along
> the lines of the totally untested diff below.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5709ff..38cb5fe7ba65 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6372,9 +6372,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                                 continue;
>  
> -                       /* Skip CPUs that will be overutilized. */
>                         util = cpu_util_next(cpu, p, cpu);
>                         cpu_cap = capacity_of(cpu);
> +                       spare_cap = cpu_cap - util;
> +                       util = uclamp_util_with(cpu_rq(cpu), util, p);
> +
> +                       /* Skip CPUs that will be overutilized. */
>                         if (!fits_capacity(util, cpu_cap))
>                                 continue;
>  
> @@ -6389,7 +6392,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                          * Find the CPU with the maximum spare capacity in
>                          * the performance domain
>                          */
> -                       spare_cap = cpu_cap - util;
>                         if (spare_cap > max_spare_cap) {
>                                 max_spare_cap = spare_cap;
>                                 max_spare_cap_cpu = cpu;
> 
> Thoughts ?
> 

uclamp_util_with() (or uclamp_rq_util_with() ;)) picks the max between the
rq-aggregated clamps and the task clamps, which isn't what we want. If the
task has a low-ish uclamp.max (e.g. the 300 example from above) but the
rq-wide max-aggregated uclamp.max is ~800, we'd clamp using that 800. It
makes sense for frequency selection, but not for task placement IMO.

> Thanks,
> Quentin
> 
