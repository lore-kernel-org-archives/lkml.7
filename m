Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636BD206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfG2RV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:21:59 -0400
Received: from foss.arm.com ([217.140.110.172]:48318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2RV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:21:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F15F0337;
        Mon, 29 Jul 2019 10:21:57 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05C93F694;
        Mon, 29 Jul 2019 10:21:56 -0700 (PDT)
Subject: Re: [PATCH 3/5] sched/deadline: Use __sub_running_bw() throughout
 dl_change_utilization()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-4-dietmar.eggemann@arm.com>
 <20190729164755.GM31398@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fc48cf4a-6153-5ead-72cd-76df4b10d6a0@arm.com>
Date:   Mon, 29 Jul 2019 18:21:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729164755.GM31398@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 5:47 PM, Peter Zijlstra wrote:
> On Fri, Jul 26, 2019 at 09:27:54AM +0100, Dietmar Eggemann wrote:
>> dl_change_utilization() has a BUG_ON() to check that no schedutil
>> kthread (sugov) is entering this function. So instead of calling
>> sub_running_bw() which checks for the special entity related to a
>> sugov thread, call the underlying function __sub_running_bw().
>>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>  kernel/sched/deadline.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index 99d4c24a8637..1fa005f79307 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -164,7 +164,7 @@ void dl_change_utilization(struct task_struct *p, u64 new_bw)
>>  
>>  	rq = task_rq(p);
>>  	if (p->dl.dl_non_contending) {
>> -		sub_running_bw(&p->dl, &rq->dl);
>> +		__sub_running_bw(p->dl.dl_bw, &rq->dl);
>>  		p->dl.dl_non_contending = 0;
>>  		/*
>>  		 * If the timer handler is currently running and the
> 
> I'm confused; the only called of dl_change_utilization() is
> sched_dl_overflow(), and that already checks FLAG_SUGOV and exits before
> calling.

That's right. There is even a BUG_ON(p->dl.flags & SCHED_FLAG_SUGOV) at
the beginning of dl_change_utilization().

> So how can this matter?

We save the 'if (!dl_entity_is_special(dl_se))' from sub_running_bw()
when we call __sub_running_bw() since we know it can't be a special task.

Later in dl_change_utilization() we already use the inner bw accounting
functions __sub_rq_bw() and __add_rq_bw().
