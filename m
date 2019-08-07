Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1848C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D8321E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565189142;
	bh=f1HrfA5UJA+9P1WwiXt0cKlp9OhG5kgjmIQYOpHTY0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tTCrmNfUwxxbuN4aqV5BrUYTdAlLg7n6tyM+7Rdvj/A3rjavxIfi6jSt4l4YzXm+M
	 6WuNaV/wCfSrPcX/wlokDuxhIcwfPyEhOv4OWxGVrPnuzxAGOMExWEay+eC9aAyN/q
	 LsSTH4U0xZOYsfv8RsmaGTLt09ZjXwbx7tqs6fDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfHGOpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388025AbfHGOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:45:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306FE2199C;
        Wed,  7 Aug 2019 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565189139;
        bh=f1HrfA5UJA+9P1WwiXt0cKlp9OhG5kgjmIQYOpHTY0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YD7X9p1V+X4Vpu9bUuweXKMNUWT/yjjmK6ZUORvnYM0Li2JO/n4G54ahYchEr7jGX
         NLVUvV/2RQXCO3H6BGC7mXc1niW39Sl7AzlQwnXvx3CII11tMtJqgbHmM/KNsmnb0R
         3kHLhKJvl353SXUmjOn+mZ848JfOT8Rc4KFHXv3Q=
Date:   Wed, 7 Aug 2019 15:45:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190807144305.v55fohssujsqtegb@willie-the-truck>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I've mostly been spared the joys of pcpu rwsem, but I took a look anyway.
Comments of questionable quality below.

On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:
> The filesystem freezer uses percpu_rwsem in a way that is effectively
> write_non_owner() and achieves this with a few horrible hacks that
> rely on the rwsem (!percpu) implementation.
> 
> When -RT re-implements rwsem this house of cards comes undone.
> 
> Re-implement percpu_rwsem without relying on rwsem.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: jack@suse.com
> ---
>  include/linux/percpu-rwsem.h  |   72 +++++++++++++-------------
>  include/linux/wait.h          |    3 +
>  kernel/cpu.c                  |    4 -
>  kernel/locking/percpu-rwsem.c |  116 +++++++++++++++++++++++++-----------------
>  4 files changed, 112 insertions(+), 83 deletions(-)

[...]

> +/*
> + * Called with preemption disabled, and returns with preemption disabled,
> + * except when it fails the trylock.
> + */
> +bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
>  {
>  	/*
>  	 * Due to having preemption disabled the decrement happens on
>  	 * the same CPU as the increment, avoiding the
>  	 * increment-on-one-CPU-and-decrement-on-another problem.
>  	 *
> -	 * If the reader misses the writer's assignment of readers_block, then
> -	 * the writer is guaranteed to see the reader's increment.
> +	 * If the reader misses the writer's assignment of sem->block, then the
> +	 * writer is guaranteed to see the reader's increment.
>  	 *
>  	 * Conversely, any readers that increment their sem->read_count after
> -	 * the writer looks are guaranteed to see the readers_block value,
> -	 * which in turn means that they are guaranteed to immediately
> -	 * decrement their sem->read_count, so that it doesn't matter that the
> -	 * writer missed them.
> +	 * the writer looks are guaranteed to see the sem->block value, which
> +	 * in turn means that they are guaranteed to immediately decrement
> +	 * their sem->read_count, so that it doesn't matter that the writer
> +	 * missed them.
>  	 */
>  
> +again:
>  	smp_mb(); /* A matches D */
>  
>  	/*
> -	 * If !readers_block the critical section starts here, matched by the
> +	 * If !sem->block the critical section starts here, matched by the
>  	 * release in percpu_up_write().
>  	 */
> -	if (likely(!smp_load_acquire(&sem->readers_block)))
> -		return 1;
> +	if (likely(!atomic_read_acquire(&sem->block)))
> +		return true;
>  
>  	/*
>  	 * Per the above comment; we still have preemption disabled and
>  	 * will thus decrement on the same CPU as we incremented.
>  	 */
> -	__percpu_up_read(sem);
> +	__percpu_up_read(sem); /* implies preempt_enable() */

Irritatingly, it also implies an smp_mb() which I don't think we need here.

>  	if (try)
> -		return 0;
> +		return false;
>  
> -	/*
> -	 * We either call schedule() in the wait, or we'll fall through
> -	 * and reschedule on the preempt_enable() in percpu_down_read().
> -	 */
> -	preempt_enable_no_resched();
> +	wait_event(sem->waiters, !atomic_read_acquire(&sem->block));

Why do you need acquire semantics here? Is the control dependency to the
increment not enough?

Talking of control dependencies, could we replace the smp_mb() in
readers_active_check() with smp_acquire__after_ctrl_dep()? In fact, perhaps
we could remove it altogether, given that our writes will be ordered by
the dependency and I don't think we care about ordering our reads wrt
previous readers. Hmm. Either way, clearly not for this patch.

Anyway, general shape of the patch looks good to me.

Will
