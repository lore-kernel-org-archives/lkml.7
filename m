Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C3C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5A4208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfITMwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:52:50 -0400
Received: from foss.arm.com ([217.140.110.172]:44314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfITMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:52:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D67D1570;
        Fri, 20 Sep 2019 05:52:49 -0700 (PDT)
Received: from [192.168.2.253] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D783F67D;
        Fri, 20 Sep 2019 05:52:46 -0700 (PDT)
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
References: <20190903103329.24961-1-qais.yousef@arm.com>
 <20190904072524.09de28aa@oasis.local.home>
 <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
 <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
 <20190918145233.kgntor5nb2gmnczd@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d307c2f6-f16c-4e9e-0476-91d49d115480@arm.com>
Date:   Fri, 20 Sep 2019 14:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918145233.kgntor5nb2gmnczd@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 4:52 PM, Qais Yousef wrote:
> On 09/13/19 14:30, Dietmar Eggemann wrote:
>> On 9/4/19 4:40 PM, Qais Yousef wrote:
>>> On 09/04/19 07:25, Steven Rostedt wrote:
>>>> On Tue,  3 Sep 2019 11:33:29 +0100
>>>> Qais Yousef <qais.yousef@arm.com> wrote:

[...]

>> On a big.LITTLE system (6 CPUs with [446 1024 1024 446 466 466] CPU
>> capacity vector) I try to trace the handling of the 3rd big task
>> (big2-2, util_min: 800, util_max: 1024) of an rt-app workload running 3
>> of them.
>>
>> rt_task_fits_capacity() call in:
>>
>> tag 1: select_task_rq_rt(), 3-7: 1st till 5th in find_lowest_rq()
>>
>> [   37.505325] rt_task_fits_capacity: CPU3 tag=1 [big2-2 285] ret=0
>> [   37.505882] find_lowest_rq: CPU3 [big2-2 285] tag=1 find_lowest_rq
>> [   37.506509] CPU3 [big2-2 285] lowest_mask=0,3-5
>> [   37.507971] rt_task_fits_capacity: CPU3 tag=3 [big2-2 285] ret=0
>> [   37.508200] rt_task_fits_capacity: CPU3 tag=4 [big2-2 285] ret=0
>> [   37.509486] rt_task_fits_capacity: CPU0 tag=5 [big2-2 285] ret=0
>> [   37.510191] rt_task_fits_capacity: CPU3 tag=5 [big2-2 285] ret=0
>> [   37.511334] rt_task_fits_capacity: CPU4 tag=5 [big2-2 285] ret=0
>> [   37.512194] rt_task_fits_capacity: CPU5 tag=5 [big2-2 285] ret=0
>> [   37.513210] rt_task_fits_capacity: CPU0 tag=6 [big2-2 285] ret=0
>> [   37.514085] rt_task_fits_capacity: CPU3 tag=7 [big2-2 285] ret=0
>> [   37.514732] --> select_task_rq_rt: CPU3 [big2-2 285] cpu=0
>>
>> Since CPU 0,3-5 can't run big2-2, it takes up to the test that the
>> fitness hasn't changed. In case a capacity-aware (with fallback CPU)
>> cpupri_find() would have returned a suitable lowest_mask, less work
>> would have been needed.
> 
> rt_task_fits_capacity() is inlined and I'd expect all the data it accesses to
> be cache hot, so it should be fast.

My concern is not so much runtime but maintenance of the new code. We
want to integrate a feature 'Asymmetric CPU capacity support' in RT and
DL sched class which have the same overall design (DL was copied from
RT). IMHO, the new feature 'Asymmetric CPU capacity support' has to be
integrated the same way (if possible) to let people understand the
related code easily.

> I had 2 concerns with using cpupri_find()
> 
> 	1. find_lowest_rq() is not the only user

But the only one calling it with lowest_mask != NULL (like for DL
find_later_rq() is the only one calling cpudl_find() with later_mask !=
NULL.

> 	2. The fallback mechanism means we either have to call cpupri_find()
> 	   twice once to find filtered lowest_rq and the other to return the
> 	   none filtered version.

This is what I have in mind. (Only compile tested! ... and the 'if
(cpumask_any(lowest_mask) >= nr_cpu_ids)' condition has to be considered
as well):

@@ -98,8 +103,26 @@ int cpupri_find(struct cpupri *cp, struct
task_struct *p,
                        continue;

                if (lowest_mask) {
+                       int cpu, max_cap_cpu = -1;
+                       unsigned long max_cap = 0;
+
                        cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);

+                       for_each_cpu(cpu, lowest_mask) {
+                               unsigned long cap =
arch_scale_cpu_capacity(cpu);
+
+                               if (!rt_task_fits_capacity(p, cpu))
+                                       cpumask_clear_cpu(cpu, lowest_mask);
+
+                               if (cap > max_cap) {
+                                       max_cap = cap;
+                                       max_cap_cpu = cpu;
+                               }
+                       }
+
+                       if (cpumask_empty(lowest_mask) && max_cap)
+                               cpumask_set_cpu(max_cap_cpu, lowest_mask);
+

[...]

>> I can't see the
>>
>> for_each_domain(cpu, sd) {
>> 	for_each_cpu_and(best_cpu, lowest_mask, sched_domain_span(sd)) {
>>                 ...
>> 	}
>> }
>>
>> other than we want to pick a CPU from the lowest_mask first which is
>> closer to task_cpu(task).
>>
>> Qemu doesn't give me cluster:
>>
>> # cat /proc/sys/kernel/sched_domain/cpu0/domain*/name
>> MC
> 
> I'm not sure I get what you're trying to get at here. Can you please elaborate
> more?

I was referring to this for each scheduler domain snippet:

for_each_domain(cpu, sd) {

}

this would first look for a best_cpu in MC and then in DIE level in the
original code. I remember that Steven asked about the for_each_cpu_and()
you introduced here.
But in case you can test the idea of introducing the changes in
cpupri_find() you won't have to worry about this anymore.

[...]
