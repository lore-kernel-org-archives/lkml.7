Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC45C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938FF208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfHFQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbfHFQRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:17:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C63CC08E286;
        Tue,  6 Aug 2019 16:17:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3280760475;
        Tue,  6 Aug 2019 16:17:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Aug 2019 18:17:52 +0200 (CEST)
Date:   Tue, 6 Aug 2019 18:17:42 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190806161741.GC21454@redhat.com>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 06 Aug 2019 16:17:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05, Peter Zijlstra wrote:
>
> Re-implement percpu_rwsem without relying on rwsem.

looks correct... But,

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

...

>  void __percpu_up_read(struct percpu_rw_semaphore *sem)
>  {
>  	smp_mb(); /* B matches C */
> @@ -103,9 +109,10 @@ void __percpu_up_read(struct percpu_rw_s
>  	 * critical section.
>  	 */
>  	__this_cpu_dec(*sem->read_count);
> +	preempt_enable();
>  
> -	/* Prod writer to recheck readers_active */
> -	rcuwait_wake_up(&sem->writer);
> +	/* Prod writer to re-evaluate readers_active_check() */
> +	wake_up(&sem->waiters);

but this will also wake all the pending readers up. Every reader will burn
CPU for no reason and likely delay the writer.

In fact I'm afraid this can lead to live-lock, because every reader in turn
will call __percpu_up_read().

To simplify, lets consider a single-cpu machine.

Suppose we have an active reader which sleeps somewhere and a pending writer
sleeping in wait_event(readers_active_check).

A new reader R1 comes and blocks in wait_event(!sem->block).

Another reader R2 comes and does wake_up(sem->waiters). Quite possibly it will
enter wait_event(!sem->block) before R1 gets CPU.

Then it is quite possible that R1 does __this_cpu_inc() before the writer
passes wait_event(readers_active_check()) or even before it gets CPU.

Now, R1 calls __percpu_up_read(), wakes R2 up, and so on.


How about 2 wait queues?

This way we can also make percpu_up_write() more fair, it can probably check
waitqueue_active(writers) before wake_up(readers).

Oleg.

