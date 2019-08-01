Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4A1206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfHAQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:01:51 -0400
Received: from foss.arm.com ([217.140.110.172]:38428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731613AbfHAQBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:01:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2151597;
        Thu,  1 Aug 2019 09:01:50 -0700 (PDT)
Received: from [10.1.25.42] (c02x80rpjhd5.cambridge.arm.com [10.1.25.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9B83F694;
        Thu,  1 Aug 2019 09:01:49 -0700 (PDT)
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <20190729164932.GN31398@hirez.programming.kicks-ass.net>
 <20190730064115.GC8927@localhost.localdomain>
 <20190730082108.GJ31381@hirez.programming.kicks-ass.net>
 <c93f6c12-b804-99da-7e38-bbaf55fe7a1b@arm.com>
 <20190731222046.5ff83259@sweethome>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e69422ca-26d3-2c36-854d-1e1369925b41@arm.com>
Date:   Thu, 1 Aug 2019 17:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731222046.5ff83259@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 9:20 PM, luca abeni wrote:
> On Wed, 31 Jul 2019 18:32:47 +0100
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> [...]
>>>>>>  static void dequeue_dl_entity(struct sched_dl_entity *dl_se)
>>>>>>  {
>>>>>> +	if (!on_dl_rq(dl_se))
>>>>>> +		return;  
>>>>>
>>>>> Why allow double dequeue instead of WARN?  
>>>>
>>>> As I was saying to Valentin, it can currently happen that a task
>>>> could have already been dequeued by update_curr_dl()->throttle
>>>> called by dequeue_task_dl() before calling __dequeue_task_dl(). Do
>>>> you think we should check for this condition before calling into
>>>> dequeue_dl_entity()?  
>>>
>>> Yes, that's what ->dl_throttled is for, right? And !->dl_throttled
>>> && !on_dl_rq() is a BUG.  
>>
>> OK, I will add the following snippet to the patch.
>> Although it's easy to provoke a situation in which DL tasks are
>> throttled, I haven't seen a throttling happening when the task is
>> being dequeued.
> 
> This is a not-so-common situation, that can happen with periodic tasks
> (a-la rt-app) blocking on clock_nanosleep() (or similar) after
> executing for an amount of time comparable with the SCHED_DEADLINE
> runtime.
> 
> It might happen that the task consumed a little bit more than the
> remaining runtime (but has not been throttled yet, because the
> accounting happens at every tick)... So, when dequeue_task_dl() invokes
> update_task_dl() the runtime becomes negative and the task is throttled.
> 
> This happens infrequently, but if you try rt-app tasksets with multiple
> tasks and execution times near to the runtime you will see it
> happening, sooner or later.
> 
> 
> [...]
>> @@ -1592,6 +1591,10 @@ static void __dequeue_task_dl(struct rq *rq,
>> struct task_struct *p) static void dequeue_task_dl(struct rq *rq,
>> struct task_struct *p, int flags) {
>>         update_curr_dl(rq);
>> +
>> +       if (p->dl.dl_throttled)
>> +               return;
> 
> Sorry, I missed part of the previous discussion, so maybe I am missing
> something... But I suspect this "return" might be wrong (you risk to
> miss a call to task_non_contending(), coming later in this function).
> 
> Maybe you cound use
> 	if (!p->dl_throttled)
> 		__dequeue_task_dl(rq, p)
> 

I see. With the following rt-app file on h960 (8 CPUs) I'm able to
recreate the situation relatively frequently.

...
"tasks" : {
 "thread0" : {
  "instance" : 12,
  "run" : 11950,
  "timer" : { "ref" : "unique", "period" : 100000, "mode" : "absolute"},
  "dl-runtime" : 12000,
  "dl-period" : 100000,
  "dl-deadline" : 100000
 }
}

...
[ 1912.086664] CPU1: p=[thread0-9 3070] throttled p->on_rq=0 flags=0x9
[ 1912.086726] CPU2: p=[thread0-10 3071] throttled p->on_rq=0 flags=0x9
[ 1924.738912] CPU6: p=[thread0-10 3149] throttled p->on_rq=0 flags=0x9
...

And the flag DEQUEUE_SLEEP is set so like you said
task_non_contending(p) should be called.

I'm going to use your proposal. Thank you for the help!
