Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3E7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DD12173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfHHI5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:57:17 -0400
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHI5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:57:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DD7337;
        Thu,  8 Aug 2019 01:57:16 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D2323F706;
        Thu,  8 Aug 2019 01:57:14 -0700 (PDT)
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
Date:   Thu, 8 Aug 2019 10:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808084652.GG29310@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 10:46 AM, Juri Lelli wrote:
> On 08/08/19 10:11, Dietmar Eggemann wrote:
>> On 8/8/19 9:56 AM, Peter Zijlstra wrote:
>>> On Wed, Aug 07, 2019 at 06:31:59PM +0200, Dietmar Eggemann wrote:
>>>> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
>>>>>
>>>>>
>>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>
>>>> [...]
>>>>
>>>>> @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
>>>>>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>>>>>  		cgroup_account_cputime(curtask, delta_exec);
>>>>>  		account_group_exec_runtime(curtask, delta_exec);
>>>>> +		if (curtask->server)
>>>>> +			dl_server_update(curtask->server, delta_exec);
>>>>>  	}
>>>>
>>>> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
>>>> when running the full stack.
>>>
>>> That would seem to imply a stale curtask->server value; the hunk below:
>>>
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas
>>>
>>>         for_each_class(class) {
>>>                 p = class->pick_next_task(rq, NULL, NULL);
>>> -               if (p)
>>> +               if (p) {
>>> +                       if (p->sched_class == class && p->server)
>>> +                               p->server = NULL;
>>>                         return p;
>>> +               }
>>>         }
>>>
>>>
>>> Was supposed to clear p->server, but clearly something is going 'funny'.
>>
>> What about the fast path in pick_next_task()?
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bffe849b5a42..f1ea6ae16052 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>                 if (unlikely(!p))
>>                         p = idle_sched_class.pick_next_task(rq, prev, rf);
>>  
>> +               if (p->sched_class == &fair_sched_class && p->server)
>> +                       p->server = NULL;
>> +
> 
> Hummm, but then who sets it back to the correct server. AFAIU
> update_curr() needs a ->server to do the correct DL accounting?

Ah, OK, this would kill the whole functionality ;-)

