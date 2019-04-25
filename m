Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC0218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfDYDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:52:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388848AbfDYDwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:52:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E0D1E4C7E82AEEA99D38;
        Thu, 25 Apr 2019 11:52:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.210) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 11:52:29 +0800
Subject: Re: [PATCH] sched: fix a potential divide error
To:     Peter Zijlstra <peterz@infradead.org>
References: <20190420083416.170446-1-xiexiuqi@huawei.com>
 <20190423184458.GW4038@hirez.programming.kicks-ass.net>
CC:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <cj.chengjian@huawei.com>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <14cdc45e-7a6f-5e1f-e877-10503180ac4e@huawei.com>
Date:   Thu, 25 Apr 2019 11:52:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190423184458.GW4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.19.210]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your comments.

On 2019/4/24 2:44, Peter Zijlstra wrote:
> On Sat, Apr 20, 2019 at 04:34:16PM +0800, Xie XiuQi wrote:
>> We meet a divide error on 3.10.0 kernel, the error message is bellow:
> 
> That is a _realllllllyyyy_ old kernel. I would urge you to upgrade.

I will.

> 
>> [499992.287996] divide error: 0000 [#1] SMP
> 
>> sched_clock_cpu may not be consistent bwtwen cpus. If a task migrate
>> to another cpu, the se.exec_start was set to that cpu's rq_clock_task
>> by update_stats_curr_start(). Which may not be monotonic.
>>
>> update_stats_curr_start
>>   <- set_next_entity
>>      <- set_curr_task_fair
>>         <- sched_move_task
> 
> That is not in fact a cross-cpu migration path. But I see the point.
> Also many migration paths do in fact preserve monotonicity, even when
> the clock is busted, but you're right, not all of them.
> 
>> So, if  now - p->last_task_numa_placement is -1, then (*period + 1) is
>> 0, and divide error was triggerred at the div operation:
>>   task_numa_placement:
>>     runtime = numa_get_avg_runtime(p, &period);
>>     f_weight = div64_u64(runtime << 16, period + 1);  // divide error here
>>
>> In this patch, we make sure period is not less than 0 to avoid this
>> divide error.
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  kernel/sched/fair.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 40bd1e27b1b7..f2abb258fc85 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
>>  	if (p->last_task_numa_placement) {
>>  		delta = runtime - p->last_sum_exec_runtime;
>>  		*period = now - p->last_task_numa_placement;
>> +
>> +		/* Avoid backward, and prevent potential divide error */
>> +		if ((s64)*period < 0)
>> +			*period = 0;
>>  	} else {
>>  		delta = p->se.avg.load_sum;
>>  		*period = LOAD_AVG_MAX;
> 
> Yeah, I suppose that is indeed correct.
> 
> I'll try and come up with a better Changelog tomorrow.

Thanks.

-- 
Thanks,
Xie XiuQi

