Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C73C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76672084D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbfHHKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:46:40 -0400
Received: from foss.arm.com ([217.140.110.172]:60008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731755AbfHHKqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:46:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81C728;
        Thu,  8 Aug 2019 03:46:38 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407633F694;
        Thu,  8 Aug 2019 03:46:38 -0700 (PDT)
Subject: Re: [PATCH 2/3] sched/fair: Prevent active LB from preempting higher
 sched classes
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20190807174026.31242-1-valentin.schneider@arm.com>
 <20190807174026.31242-3-valentin.schneider@arm.com>
 <20190808092455.qavanylzts2vmktk@e107158-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4d7cd9de-9f90-0e47-5c77-e888fb7eb3ef@arm.com>
Date:   Thu, 8 Aug 2019 11:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808092455.qavanylzts2vmktk@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2019 10:24, Qais Yousef wrote:
>> @@ -8834,6 +8834,10 @@ static inline enum alb_status active_load_balance(struct lb_env *env)
>>  
>>  	raw_spin_lock_irqsave(&busiest->lock, flags);
>>  
>> +	/* Make sure we're not about to stop a task from a higher sched class */
>> +	if (busiest->curr->sched_class != &fair_sched_class)
>> +		goto unlock;
>> +
> 
> This looks correct to me, but I wonder if this check is something that belongs
> to the CONFIG_PREEMPT_RT land. This will give a preference to not disrupt the
> RT/DL tasks which is certainly the desired behavior there, but maybe in none
> PREEMPT_RT world balancing CFS tasks is more important? Hmmm
> 

My take on this is that if the running task isn't CFS, there is no point in
running the cpu_stopper there (PREEMPT_RT or not). We can still try other
things though.

It could be that the running task had been > CFS all along, so if we
failed to move any load then we just couldn't pull any CFS task and should
bail out of load balance at this point.

If the running task was CFS but got preempted by a > CFS task in the
meantime (e.g. after detach_tasks() failed to pull anything), the best we
could do is run detach_one_task() (locally - no need for any cpu_stopper)
to try and nab the now not-running CFS task. Otherwise we'll have to wait
for another round of load_balance().
Not sure how much we care about this case - I think it's extremely unlikely
to repeatedly want to pull a currently-running CFS task and have it
repeatedly preempted by a > CFS task whenever we get to active_load_balance().

Let me try and see if I can come up with something sensible with that
detach_one_task() thingy.

> --
> Qais Yousef
> 
>>  	/*
>>  	 * Don't kick the active_load_balance_cpu_stop, if the curr task on
>>  	 * busiest CPU can't be moved to dst_cpu:
>> --
>> 2.22.0
>>
