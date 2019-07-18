Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDEC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0091821783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbfGRKux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:50:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfGRKux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:50:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA96BA3B46;
        Thu, 18 Jul 2019 10:50:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D35660C8E;
        Thu, 18 Jul 2019 10:50:52 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7F32C4E58D;
        Thu, 18 Jul 2019 10:50:52 +0000 (UTC)
Date:   Thu, 18 Jul 2019 06:50:52 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, peterz@infradead.org, mingo@redhat.com,
        jade alglave <jade.alglave@arm.com>,
        paulmck@linux.vnet.ibm.com, Jan Stancek <jstancek@redhat.com>
Message-ID: <79224323.853324.1563447052432.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net> <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com> <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck> <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com> <20190717192200.GA17687@dustball.usersys.redhat.com> <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.24]
Thread-Topic: locking/rwsem: add acquire barrier to read_slowpath exit when queue is empty
Thread-Index: o2nqmyFzePBpYTAcf1w+YWoIawuE7A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 18 Jul 2019 10:50:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> Hi Jan, Waiman, [+Jade and Paul for the litmus test at the end]
> 
> On Wed, Jul 17, 2019 at 09:22:00PM +0200, Jan Stancek wrote:
> > On Wed, Jul 17, 2019 at 10:19:04AM -0400, Waiman Long wrote:
> > > > If you add a comment to the code outlining the issue (preferably as a
> > > > litmus
> > > > test involving sem->count and some shared data which happens to be
> > > > vmacache_seqnum in your test)), then:
> > > > 
> > > > Reviewed-by: Will Deacon <will@kernel.org>
> > > > 
> > > > Thanks,
> > > > 
> > > > Will
> > > 
> > > Agreed. A comment just above smp_acquire__after_ctrl_dep() on why this
> > > is needed will be great.
> > > 
> > > Other than that,
> > > 
> > > Acked-by: Waiman Long <longman@redhat.com>
> > > 
> > 
> > litmus test looks a bit long, would following be acceptable?
> > 
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index 37524a47f002..d9c96651bfc7 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1032,6 +1032,13 @@ static inline bool rwsem_reader_phase_trylock(struct
> > rw_semaphore *sem,
> >  		 */
> >  		if (adjustment && !(atomic_long_read(&sem->count) &
> >  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> > +			/*
> > +			 * down_read() issued ACQUIRE on enter, but we can race
> > +			 * with writer who did RELEASE only after us.
> > +			 * ACQUIRE here makes sure reader operations happen only
> > +			 * after all writer ones.
> > +			 */
> 
> How about an abridged form of the litmus test here, just to show the cod
> flow? e.g.:
> 
> /*
>  * We need to ensure ACQUIRE semantics when reading sem->count so that
>  * we pair with the RELEASE store performed by an unlocking/downgrading
>  * writer.
>  *
>  * P0 (writer)			P1 (reader)
>  *
>  * down_write(sem);
>  * <write shared data>
>  * downgrade_write(sem);
>  * -> fetch_add_release(&sem->count)
>  *
>  *				down_read_slowpath(sem);
>  *				-> atomic_read(&sem->count)
>  *				   <ctrl dep>
>  *				   smp_acquire__after_ctrl_dep()
>  *				<read shared data>
>  */

Works for me. The code is at 3 level of indentation, but I can try
to squeeze it in for v4.

> 
> In writing this, I also noticed that we don't have any explicit ordering
> at the end of the reader slowpath when we wait on the queue but get woken
> immediately:
> 
> 	if (!waiter.task)
> 		break;
> 
> Am I missing something?

I'm assuming this isn't problem, because set_current_state() on line above
is using smp_store_mb().

> 
> > +			smp_acquire__after_ctrl_dep();
> >  			raw_spin_unlock_irq(&sem->wait_lock);
> >  			rwsem_set_reader_owned(sem);
> >  			lockevent_inc(rwsem_rlock_fast);
> > 
> > 
> > with litmus test in commit log:
> > ----------------------------------- 8< ------------------------------------
> > C rwsem
> > 
> > {
> > 	atomic_t rwsem_count = ATOMIC_INIT(1);
> > 	int vmacache_seqnum = 10;
> > }
> > 
> > P0(int *vmacache_seqnum, atomic_t *rwsem_count)
> > {
> > 	r0 = READ_ONCE(*vmacache_seqnum);
> > 	WRITE_ONCE(*vmacache_seqnum, r0 + 1);
> > 	/* downgrade_write */
> > 	r1 = atomic_fetch_add_release(-1+256, rwsem_count);
> > }
> > 
> > P1(int *vmacache_seqnum, atomic_t *rwsem_count, spinlock_t *sem_wait_lock)
> > {
> > 	/* rwsem_read_trylock */
> > 	r0 = atomic_add_return_acquire(256, rwsem_count);
> > 	/* rwsem_down_read_slowpath */
> > 	spin_lock(sem_wait_lock);
> > 	r0 = atomic_read(rwsem_count);
> > 	if ((r0 & 1) == 0) {
> > 		// BUG: needs barrier
> > 		spin_unlock(sem_wait_lock);
> > 		r1 = READ_ONCE(*vmacache_seqnum);
> > 	}
> > }
> > exists (1:r1=10)
> > ----------------------------------- 8< ------------------------------------
> 
> Thanks for writing this! It's definitely worth sticking it in the commit
> log, but Paul and Jade might also like to include it as part of their litmus
> test repository too.
> 
> Will
> 
