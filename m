Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC40FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8898A21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRZwsjA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfDWSpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:45:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDWSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/5D0naDooO7qJa3ZnudXQ3B4DSjp5r3xhDuJFGQeqVU=; b=qRZwsjA6QjjYF0369fUruElSa
        0CUMvDh6DhF0YAyx2FiQMIlXnt+KAfHzVX0pZvsspf4XMLIDktZ3RjsYUHVqkqUkz4o8ef8apwPTz
        ya9THqDX7Mdh1xeZqfZQQLHHC6gJvtl8W8PDw4XkvtS2UMafuuIn/iq2zkE3EkkulgsG42G8oGMYV
        18iwgu/3gjMEh+iMXDvvZJAFDCnvAdGCG1RZtcWV0xcLH3Zb7qd5Gdm8y+IRywB5YWpU9RLdUtXps
        hefYVGcaaMxS8XnbQgFmiyl1hS2J1P1N+2PXHUcjMm+p5pI5058GpKdsJgKvD5bIcrBmfZSzCBLXK
        SN36BZUZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ0Pb-0008PX-LL; Tue, 23 Apr 2019 18:44:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61B7A29C3F389; Tue, 23 Apr 2019 20:44:58 +0200 (CEST)
Date:   Tue, 23 Apr 2019 20:44:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        cj.chengjian@huawei.com
Subject: Re: [PATCH] sched: fix a potential divide error
Message-ID: <20190423184458.GW4038@hirez.programming.kicks-ass.net>
References: <20190420083416.170446-1-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420083416.170446-1-xiexiuqi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 04:34:16PM +0800, Xie XiuQi wrote:
> We meet a divide error on 3.10.0 kernel, the error message is bellow:

That is a _realllllllyyyy_ old kernel. I would urge you to upgrade.

> [499992.287996] divide error: 0000 [#1] SMP

> sched_clock_cpu may not be consistent bwtwen cpus. If a task migrate
> to another cpu, the se.exec_start was set to that cpu's rq_clock_task
> by update_stats_curr_start(). Which may not be monotonic.
> 
> update_stats_curr_start
>   <- set_next_entity
>      <- set_curr_task_fair
>         <- sched_move_task

That is not in fact a cross-cpu migration path. But I see the point.
Also many migration paths do in fact preserve monotonicity, even when
the clock is busted, but you're right, not all of them.

> So, if  now - p->last_task_numa_placement is -1, then (*period + 1) is
> 0, and divide error was triggerred at the div operation:
>   task_numa_placement:
>     runtime = numa_get_avg_runtime(p, &period);
>     f_weight = div64_u64(runtime << 16, period + 1);  // divide error here
> 
> In this patch, we make sure period is not less than 0 to avoid this
> divide error.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 40bd1e27b1b7..f2abb258fc85 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2007,6 +2007,10 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
>  	if (p->last_task_numa_placement) {
>  		delta = runtime - p->last_sum_exec_runtime;
>  		*period = now - p->last_task_numa_placement;
> +
> +		/* Avoid backward, and prevent potential divide error */
> +		if ((s64)*period < 0)
> +			*period = 0;
>  	} else {
>  		delta = p->se.avg.load_sum;
>  		*period = LOAD_AVG_MAX;

Yeah, I suppose that is indeed correct.

I'll try and come up with a better Changelog tomorrow.

