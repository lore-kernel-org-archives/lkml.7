Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB2C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E82133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfJAKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:01:42 -0400
Received: from foss.arm.com ([217.140.110.172]:45424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbfJAKBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:01:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 516351000;
        Tue,  1 Oct 2019 03:01:41 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8273D3F739;
        Tue,  1 Oct 2019 03:01:39 -0700 (PDT)
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190925093153.GC4553@hirez.programming.kicks-ass.net>
 <1569424727.5576.221.camel@lca.pw>
 <20190925164527.GG4553@hirez.programming.kicks-ass.net>
 <1569500974.5576.234.camel@lca.pw>
 <20191001091837.GK4536@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8160833a-d01b-a942-5087-65831c9f96e9@arm.com>
Date:   Tue, 1 Oct 2019 11:01:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 10:18, Peter Zijlstra wrote:
> On Thu, Sep 26, 2019 at 08:29:34AM -0400, Qian Cai wrote:
> 
>> Oh, you were talking about took #3 while holding #2. Anyway, your patch is
>> working fine so far. Care to post/merge it officially or do you want me to post
>> it?
> 
> Does the below adequately describe the situation?
> 
> ---
> Subject: sched: Avoid spurious lock dependencies
> 
> While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> when DEBUG_OBJETS, can end up doing allocations.
> 
> This then results in the following lock order:
> 
>   rq->lock
>     zone->lock.rlock
>       batched_entropy_u64.lock
> 
> Which in turn causes deadlocks when we do wakeups while holding that
> batched_entropy lock -- as the random code does.
> 
> Solve this by moving __sched_fork() out from under rq->lock. This is
> safe because nothing there relies on rq->lock, as also evident from the
> other __sched_fork() callsite.
> 
> Fixes: b7d5dc21072c ("random: add a spinlock_t to struct batched_entropy")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Funky dependency, but the change looks fine to me.
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..1832fc0fbec5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6039,10 +6039,11 @@ void init_idle(struct task_struct *idle, int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long flags;
>  
> +	__sched_fork(0, idle);
> +
>  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
>  	raw_spin_lock(&rq->lock);
>  
> -	__sched_fork(0, idle);
>  	idle->state = TASK_RUNNING;
>  	idle->se.exec_start = sched_clock();
>  	idle->flags |= PF_IDLE;
> 
> 
