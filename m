Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F0C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A22720873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 12:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOu5Z9IY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbfGRMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:23:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43526 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N9PeuYcS0dRBsgMS8SHInxU3JDHybR3gL7ZkPh7ajCE=; b=GOu5Z9IYPEcr+BEby4R2m8kyp
        OnjzJW7wcq4ctswfv6rLA15aCiq2WCpKK2XA52w5/kEIPz0CPvE42FJ8D9+MFFNI2Q03Br+R9vPt6
        ezTHA3Wr/9QcmF+VOYJ3qhFwCceYBX0NSOR7UluvtxGMI6cRNCpDQx39WxIf4wUFASDcpvpGTKJdj
        fdRNpVqvwEf92oSdIu3MEkyocgp5XJG+/y1gv9kpLF/S3/9GY8w9kJkYMmoKMnIUTfJnQLojhma3H
        FxIMTFek3w15/F90W9kmy4z8jHfCUcSMX4pHnIASCn4Tfz8/W9CIoJ+vKGWo9qu67Sg8K3P45FIYs
        P3fp59UAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho5RN-0003Qn-QB; Thu, 18 Jul 2019 12:23:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 048BF20197A72; Thu, 18 Jul 2019 14:23:14 +0200 (CEST)
Date:   Thu, 18 Jul 2019 14:23:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, mingo@redhat.com, jade.alglave@arm.com,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718122313.GO3402@hirez.programming.kicks-ass.net>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
 <20190718105812.GB3419@hirez.programming.kicks-ass.net>
 <20190718114547.v4c7ucsp6k4i6o3b@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718114547.v4c7ucsp6k4i6o3b@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:45:47PM +0100, Will Deacon wrote:
> On Thu, Jul 18, 2019 at 12:58:12PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 18, 2019 at 10:26:41AM +0100, Will Deacon wrote:
> > 
> > > /*
> > >  * We need to ensure ACQUIRE semantics when reading sem->count so that
> > >  * we pair with the RELEASE store performed by an unlocking/downgrading
> > >  * writer.
> > >  *
> > >  * P0 (writer)			P1 (reader)
> > >  *
> > >  * down_write(sem);
> > >  * <write shared data>
> > >  * downgrade_write(sem);
> > >  * -> fetch_add_release(&sem->count)
> > >  *
> > >  *				down_read_slowpath(sem);
> > >  *				-> atomic_read(&sem->count)
> > >  *				   <ctrl dep>
> > >  *				   smp_acquire__after_ctrl_dep()
> > >  *				<read shared data>
> > >  */
> > 
> > So I'm thinking all this is excessive; the simple rule is: lock acquire
> > should imply ACQUIRE, we all know why.
> 
> Fair enough, I just thought this was worth highlighting because you can't
> reply on the wait_lock to give you ACQUIRE ordering.

Right, not in this case, because sem->count is not fully serialized by
it, whereas below the wait-queue is.

> > ---
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index 37524a47f002..9eb630904a17 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1000,6 +1000,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
> >  	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> >  	adjustment = 0;
> >  	if (rwsem_optimistic_spin(sem, false)) {
> > +		/* rwsem_optimistic_spin() implies ACQUIRE through rwsem_*trylock() */
> 
> I couldn't figure out if this was dependent on the return value or not,

I went with the fact that the only way to return true is if taken
becomes true; and that only happens through
rwsem_try_{read,write}_lock_unqueued(), and both imply ACQUIRE on
success.

> and looking at osq_lock() I also couldn't see the ACQUIRE barrier when we're
> spinning on node->locked. Hmm.

Yes, osq is not a full lock and does not imply these barriers. This came
up somewhere, did we forget to write a comment on that? Lemme go look.

> >  		/*
> >  		 * Wake up other readers in the wait list if the front
> >  		 * waiter is a reader.
> > @@ -1014,6 +1015,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
> >  		}
> >  		return sem;
> >  	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
> > +		/* rwsem_reader_phase_trylock() implies ACQUIRE */
> 
> Can we add "on success" to the end of this, please?

Good point.

> >  		return sem;
> >  	}
> >  
> > @@ -1032,6 +1034,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
> >  		 */
> >  		if (adjustment && !(atomic_long_read(&sem->count) &
> >  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> > +			/* Provide lock ACQUIRE */
> > +			smp_acquire__after_ctrl_dep();
> >  			raw_spin_unlock_irq(&sem->wait_lock);
> >  			rwsem_set_reader_owned(sem);
> >  			lockevent_inc(rwsem_rlock_fast);
> > @@ -1065,15 +1069,25 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
> >  	wake_up_q(&wake_q);
> >  
> >  	/* wait to be given the lock */
> > -	while (true) {
> > +	for (;;) {
> >  		set_current_state(state);
> > -		if (!waiter.task)
> > +		if (!smp_load_acquire(&waiter.task)) {
> > +			/*
> > +			 * Matches rwsem_mark_wake()'s smp_store_release() and ensures
> > +			 * we're ordered against its sem->count operations.
> > +			 */
> >  			break;
> > +		}
> 
> Ack. Also, grepping for 'waiter.task' reveals a similar usage in
> drivers/tty/tty_ldsem.c if you're feeling brave enough.

*sigh* of course, for every bug there needs to be a second copy
somewhere.

I'll go look there too. Thanks!


