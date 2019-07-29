Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14FAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="d4dImQ21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfG2PBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:01:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:49236 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfG2PBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:01:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DF34625EAA1;
        Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id uZtBMiAE7-Yk; Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 537C825EA96;
        Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 537C825EA96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1564412470;
        bh=T1o1f5qyUGZ4OxJpsco35EOtJ06NPoEJpztYQZO6L04=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=d4dImQ217cWJ00CBcqnCBqusCNu+/jyoFvzhoW6B3xgTA0DlDtqc9ruN+GbPcUXRs
         aHgjC5k/3s7aefn7c0J1q+AjuYtHgNKTHK1n6MWh8uXgRWBuSHKWkC/4h8pSnvopKN
         j9fFh8Ap+k8f37Sr0N42AMlNZn/vkKrFi2WOjRyHtQnComrf9RrGxx+52e//3hlH4v
         II1FSQCIySt0ihVv2/RyyZq0nyeOrQmhjbZqpbkKlqqE6RGG9bcMwu0KHqtqEoCX0o
         H/k3jIPiO953SVYVLei9xA8iCTXOlSn6SRfCprAUZUROQb5mKmf9NlAIq9oJWcEnfX
         ij1lsuocpqIFA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 1_BK-N8dSJnX; Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3BE7025EA90;
        Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
Date:   Mon, 29 Jul 2019 11:01:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, riel@surriel.com,
        Andy Lutomirski <luto@kernel.org>
Message-ID: <1705885422.1640.1564412470005.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190729142450.GE31425@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com> <20190729085235.GT31381@hirez.programming.kicks-ass.net> <20190729142450.GE31425@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH] sched: Clean up active_mm reference counting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3817 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3817)
Thread-Topic: sched: Clean up active_mm reference counting
Thread-Index: 0iasEWZrmzJZc53BFxqKkneJHIUbdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 29, 2019, at 10:24 AM, Peter Zijlstra peterz@infradead.org wrote:
[...]
> ---
> Subject: sched: Clean up active_mm reference counting
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Jul 29 16:05:15 CEST 2019
> 
> The current active_mm reference counting is confusing and sub-optimal.
> 
> Rewrite the code to explicitly consider the 4 separate cases:
> 
>    user -> user
> 
>	When switching between two user tasks, all we need to consider
>	is switch_mm().
> 
>    user -> kernel
> 
>	When switching from a user task to a kernel task (which
>	doesn't have an associated mm) we retain the last mm in our
>	active_mm. Increment a reference count on active_mm.
> 
>  kernel -> kernel
> 
>	When switching between kernel threads, all we need to do is
>	pass along the active_mm reference.
> 
>  kernel -> user
> 
>	When switching between a kernel and user task, we must switch
>	from the last active_mm to the next mm, hoping of course that
>	these are the same. Decrement a reference on the active_mm.
> 
> The code keeps a different order, because as you'll note, both 'to
> user' cases require switch_mm().
> 
> And where the old code would increment/decrement for the 'kernel ->
> kernel' case, the new code observes this is a neutral operation and
> avoids touching the reference count.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Cc: riel@surriel.com
> Cc: luto@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> kernel/sched/core.c |   49 ++++++++++++++++++++++++++++++-------------------
> 1 file changed, 30 insertions(+), 19 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3214,12 +3214,8 @@ static __always_inline struct rq *
> context_switch(struct rq *rq, struct task_struct *prev,
> 	       struct task_struct *next, struct rq_flags *rf)
> {
> -	struct mm_struct *mm, *oldmm;
> -
> 	prepare_task_switch(rq, prev, next);
> 
> -	mm = next->mm;
> -	oldmm = prev->active_mm;
> 	/*
> 	 * For paravirt, this is coupled with an exit in switch_to to
> 	 * combine the page table reload and the switch backend into
> @@ -3228,22 +3224,37 @@ context_switch(struct rq *rq, struct tas
> 	arch_start_context_switch(prev);
> 
> 	/*
> -	 * If mm is non-NULL, we pass through switch_mm(). If mm is
> -	 * NULL, we will pass through mmdrop() in finish_task_switch().
> -	 * Both of these contain the full memory barrier required by
> -	 * membarrier after storing to rq->curr, before returning to
> -	 * user-space.
> +	 * kernel -> kernel   lazy + transfer active
> +	 *   user -> kernel   lazy + mmgrab() active
> +	 *
> +	 * kernel ->   user   switch + mmdrop() active
> +	 *   user ->   user   switch
> 	 */
> -	if (!mm) {
> -		next->active_mm = oldmm;
> -		mmgrab(oldmm);
> -		enter_lazy_tlb(oldmm, next);
> -	} else
> -		switch_mm_irqs_off(oldmm, mm, next);
> -
> -	if (!prev->mm) {
> -		prev->active_mm = NULL;
> -		rq->prev_mm = oldmm;
> +	if (!next->mm) {                                // to kernel
> +		enter_lazy_tlb(prev->active_mm, next);
> +
> +		next->active_mm = prev->active_mm;
> +		if (prev->mm)                           // from user
> +			mmgrab(prev->active_mm);
> +		else
> +			prev->active_mm = NULL;
> +	} else {                                        // to user
> +		/*
> +		 * sys_membarrier() requires an smp_mb() between setting
> +		 * rq->curr and returning to userspace.
> +		 *
> +		 * The below provides this either through switch_mm(), or in
> +		 * case 'prev->active_mm == next->mm' through
> +		 * finish_task_switch()'s mmdrop().
> +		 */
> +
> +		switch_mm_irqs_off(prev->active_mm, next->mm, next);
> +
> +		if (!prev->mm) {                        // from kernel
> +			/* will mmdrop() in finish_task_switch(). */
> +			rq->prev_mm = prev->active_mm;
> +			prev->active_mm = NULL;
> +		}
> 	}
> 
>  	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
