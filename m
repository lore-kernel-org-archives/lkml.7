Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4244C27EBE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kNNcDuFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfFCMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:44:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfFCMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GNP3D276BFtDK39lLo6rJPWpnwlFMjiWsjF1eSRNq9k=; b=kNNcDuFgjSY3vB9kQuAo8Ap2W
        LZjW6ej3axV9mqJfEPOQFrK+BxXkmgewzcyXkXEFQ+hm/CEJTLQGKgVTB5n8CAXGs7hKVoBe6o+pD
        NVaeCspnEij+mfEOtozvjOHEcxOtjBcWqhpbjaxRfUU87KZ+f0jBRMoRfpzzjfMHRhzDmN5dDbvY5
        hlb6vN8a82YFI3+tI26fcMhxrMjTfMYk7TH61euKay+ArCHXVntMUgrvk28lZR4AlDs9wrqOPLlyv
        R4QthQrORiZVlXpb3A5eNEt+oucLFWpIKVIvVP+yiz9BLLHGzskGur/XNFIBDQGswlMoikfSWafKe
        meD4M2llg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXmJn-0004ug-CU; Mon, 03 Jun 2019 12:44:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B738F20274AFF; Mon,  3 Jun 2019 14:44:01 +0200 (CEST)
Date:   Mon, 3 Jun 2019 14:44:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190603124401.GB3463@hirez.programming.kicks-ass.net>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603123705.GB3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 02:37:05PM +0200, Peter Zijlstra wrote:

> Anyway, Oleg, do you see anything blatantly buggered with this patch?
> 
> (the stats were already dodgy for rq-stats, this patch makes them dodgy
> for task-stats too)

It now also has concurrency on wakeup; but afaict that's harmless, we'll
get racing stores of p->state = TASK_RUNNING, much the same as if there
was a remote wakeup vs a wait-loop terminating early.

I suppose the tracepoint consumers might have to deal with some
artifacts there, but that's their problem.

> ---
>  kernel/sched/core.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf0a29a..474aa4c8e9d2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1990,6 +1990,28 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	unsigned long flags;
>  	int cpu, success = 0;
>  
> +	if (p == current) {
> +		/*
> +		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
> +		 * == smp_processor_id()'. Together this means we can special
> +		 * case the whole 'p->on_rq && ttwu_remote()' case below
> +		 * without taking any locks.
> +		 *
> +		 * In particular:
> +		 *  - we rely on Program-Order guarantees for all the ordering,
> +		 *  - we're serialized against set_special_state() by virtue of
> +		 *    it disabling IRQs (this allows not taking ->pi_lock).
> +		 */
> +		if (!(p->state & state))
> +			goto out;
> +
> +		success = 1;
> +		trace_sched_waking(p);
> +		p->state = TASK_RUNNING;
> +		trace_sched_woken(p);
> +		goto out;
> +	}
> +
>  	/*
>  	 * If we are going to wake up a thread waiting for CONDITION we
>  	 * need to ensure that CONDITION=1 done by the caller can not be
> @@ -1999,7 +2021,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	raw_spin_lock_irqsave(&p->pi_lock, flags);
>  	smp_mb__after_spinlock();
>  	if (!(p->state & state))
> -		goto out;
> +		goto unlock;
>  
>  	trace_sched_waking(p);
>  
> @@ -2029,7 +2051,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 */
>  	smp_rmb();
>  	if (p->on_rq && ttwu_remote(p, wake_flags))
> -		goto stat;
> +		goto unlock;
>  
>  #ifdef CONFIG_SMP
>  	/*
> @@ -2089,12 +2111,16 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  #endif /* CONFIG_SMP */
>  
>  	ttwu_queue(p, cpu, wake_flags);
> -stat:
> -	ttwu_stat(p, cpu, wake_flags);
> -out:
> +unlock:
>  	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
>  
> -	return success;
> +out:
> +	if (success) {
> +		ttwu_stat(p, cpu, wake_flags);
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  /**
