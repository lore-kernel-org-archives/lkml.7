Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63749C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3BD21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563450355;
	bh=RPpl1KU1qr/RkmdD31fDZWCThQM0vN+6XBl50RiqJJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iZFwTnsQVEJJhMOZAh/KknhgWXrojQmw6gHCQ+3kI1vGiFdRnnBfBWmxaCUX3Skax
	 sv7AhvJOB0Fq2rZJvC02A180xmScr77BvgaPptDEtjvGZi/h2wfOF60GxawYBJy9i3
	 7MWwN+Aqce6UXJAJZyuaSawk7CI1W0ozyBR69vkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbfGRLpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRLpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:45:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E121D2085A;
        Thu, 18 Jul 2019 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563450352;
        bh=RPpl1KU1qr/RkmdD31fDZWCThQM0vN+6XBl50RiqJJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFr4hJ+aD6ugXNf56PVi1ZCswiZWGPB+WmeEwKSIEIIn1xCZPKECRENlC5+NPXSb1
         AsQsnICVRq4W/Lyojpx7N2ElsvTqLJ3FiT9Tvsnxnzq8rCoSBsY7RZ5wIb/mdZSiis
         UqfPno0uTpymZN4smggxej+JZavlSBuDvWDtKMqc=
Date:   Thu, 18 Jul 2019 12:45:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, mingo@redhat.com, jade.alglave@arm.com,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718114547.v4c7ucsp6k4i6o3b@willie-the-truck>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
 <20190718105812.GB3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718105812.GB3419@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:58:12PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 18, 2019 at 10:26:41AM +0100, Will Deacon wrote:
> 
> > /*
> >  * We need to ensure ACQUIRE semantics when reading sem->count so that
> >  * we pair with the RELEASE store performed by an unlocking/downgrading
> >  * writer.
> >  *
> >  * P0 (writer)			P1 (reader)
> >  *
> >  * down_write(sem);
> >  * <write shared data>
> >  * downgrade_write(sem);
> >  * -> fetch_add_release(&sem->count)
> >  *
> >  *				down_read_slowpath(sem);
> >  *				-> atomic_read(&sem->count)
> >  *				   <ctrl dep>
> >  *				   smp_acquire__after_ctrl_dep()
> >  *				<read shared data>
> >  */
> 
> So I'm thinking all this is excessive; the simple rule is: lock acquire
> should imply ACQUIRE, we all know why.

Fair enough, I just thought this was worth highlighting because you can't
reply on the wait_lock to give you ACQUIRE ordering.

> > In writing this, I also noticed that we don't have any explicit ordering
> > at the end of the reader slowpath when we wait on the queue but get woken
> > immediately:
> > 
> > 	if (!waiter.task)
> > 		break;
> > 
> > Am I missing something?
> 
> Ha!, I ran into the very same one. I keep confusing myself, but I think
> you're right and that needs to be smp_load_acquire() to match the
> smp_store_release() in rwsem_mark_wake().
> 
> (the actual race there is _tiny_ due to the smp_mb() right before it,
> but I cannot convince myself that is indeed sufficient)
> 
> The signal_pending_state() case is also fun, but I think wait_lock there
> is sufficient (even under RCpc).
> 
> I've ended up with this..
> 
> ---
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..9eb630904a17 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1000,6 +1000,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
>  	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
>  	adjustment = 0;
>  	if (rwsem_optimistic_spin(sem, false)) {
> +		/* rwsem_optimistic_spin() implies ACQUIRE through rwsem_*trylock() */

I couldn't figure out if this was dependent on the return value or not,
and looking at osq_lock() I also couldn't see the ACQUIRE barrier when we're
spinning on node->locked. Hmm.

>  		/*
>  		 * Wake up other readers in the wait list if the front
>  		 * waiter is a reader.
> @@ -1014,6 +1015,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
>  		}
>  		return sem;
>  	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
> +		/* rwsem_reader_phase_trylock() implies ACQUIRE */

Can we add "on success" to the end of this, please?

>  		return sem;
>  	}
>  
> @@ -1032,6 +1034,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
>  		 */
>  		if (adjustment && !(atomic_long_read(&sem->count) &
>  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +			/* Provide lock ACQUIRE */
> +			smp_acquire__after_ctrl_dep();
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			rwsem_set_reader_owned(sem);
>  			lockevent_inc(rwsem_rlock_fast);
> @@ -1065,15 +1069,25 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
>  	wake_up_q(&wake_q);
>  
>  	/* wait to be given the lock */
> -	while (true) {
> +	for (;;) {
>  		set_current_state(state);
> -		if (!waiter.task)
> +		if (!smp_load_acquire(&waiter.task)) {
> +			/*
> +			 * Matches rwsem_mark_wake()'s smp_store_release() and ensures
> +			 * we're ordered against its sem->count operations.
> +			 */
>  			break;
> +		}

Ack. Also, grepping for 'waiter.task' reveals a similar usage in
drivers/tty/tty_ldsem.c if you're feeling brave enough.

Will
