Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC74C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF721897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hj+GjKX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfICUZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:25:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=p20SyTx54rQ/rC+3qpXB42zmxOwM1gRNChHwv7aAJrA=; b=Hj+GjKX+XYxMqwKRCr3w9n0OH
        HaWSG8j4sBxXXbxzPg4lNXG/rE+AkXLoQ7QOha+I9U3H8FDJH48jzqm+z0rnwuB2y8ruG8L+iZnGt
        LZQ1bwk5JomqBCBeNo20IrgZcfvMYbMpNC9t/RbZ9Sg2ky0p4ECFL3Hu5AVjAqHIg8C+SOjjOmhIX
        het5zMb36g/vkzCJIG3oC1yuopVxwluJB4blqZ9pdzJbXSLU7iAIYw75UL8355tQU/Ntdh7fvV+TK
        xBj8XcNwJsGZewyQVRdpO9k+fs5tzcXMWYxCH5e8qgRCl5hAY+M2TzGUatT0RHqA2d4F9XMWbLefk
        toOtPHU+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5FLx-0003LC-HJ; Tue, 03 Sep 2019 20:24:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A6873011DF;
        Tue,  3 Sep 2019 22:23:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6411420977768; Tue,  3 Sep 2019 22:24:34 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:24:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
Message-ID: <20190903202434.GX2349@hirez.programming.kicks-ass.net>
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:11:34PM -0400, Mathieu Desnoyers wrote:

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9f51932bd543..e24d52a4c37a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1130,6 +1130,10 @@ struct task_struct {
>  	unsigned long			numa_pages_migrated;
>  #endif /* CONFIG_NUMA_BALANCING */
>  
> +#ifdef CONFIG_MEMBARRIER
> +	atomic_t membarrier_state;
> +#endif
> +
>  #ifdef CONFIG_RSEQ
>  	struct rseq __user *rseq;
>  	u32 rseq_sig;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 4a7944078cc3..3577cd7b3dbb 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -371,7 +371,17 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>  static inline void membarrier_execve(struct task_struct *t)
>  {
>  	atomic_set(&t->mm->membarrier_state, 0);
> +	atomic_set(&t->membarrier_state, 0);
>  }
> +
> +static inline void membarrier_prepare_task_switch(struct task_struct *t)
> +{
> +	if (!t->mm)
> +		return;
> +	atomic_set(&t->membarrier_state,
> +		   atomic_read(&t->mm->membarrier_state));
> +}
> +

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 010d578118d6..8d4f1f20db15 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3038,6 +3038,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>  	perf_event_task_sched_out(prev, next);
>  	rseq_preempt(prev);
>  	fire_sched_out_preempt_notifiers(prev, next);
> +	membarrier_prepare_task_switch(next);
>  	prepare_task(next);
>  	prepare_arch_switch(next);
>  }


Yuck yuck yuck..

so the problem I have with this is that we add yet another cacheline :/

Why can't we frob this state into a line/word we already have to
unconditionally touch, like the thread_info::flags word for example.

The above also does the store unconditionally, even though, in the most
common case, it won't have to.
