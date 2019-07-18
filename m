Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F368EC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6021783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563442008;
	bh=J2dEcF1SlRL4s9DV6Ki0Uk/88KpAyOrkhzkzF15duRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V9eA2saK/8yUCDIz680k491e7VCjRkC9XVRaqg8XXbisHkYi8uRbrTn4G7dPnnKqy
	 wFYlIvaQzrgEyTrv1tsnUGh+s7VQOYi/RvTxYlz6Jla5FXWUCC7V6OaLqoN18m+1LU
	 5wz2anBV0BBogz372gxPsGldfkHkWaIU+YLhfJdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbfGRJ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfGRJ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:26:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6765C20578;
        Thu, 18 Jul 2019 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563442005;
        bh=J2dEcF1SlRL4s9DV6Ki0Uk/88KpAyOrkhzkzF15duRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6/iOWGGIMlLIcWzqGNTeh7dpM3OA1bijDLUV5UV8gchEp9KpPa8zQGr9KKuhBC/W
         vql9RPR5Sq2jycovaCfrVjBORFjzQH6/HnClRRgrFOHXlrHXpVBpKAhxw6rwaHW8ua
         1SGmjWdPNZgDmq8okKOT7arEcaT+AqjZfDZ0r0D8=
Date:   Thu, 18 Jul 2019 10:26:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, peterz@infradead.org, mingo@redhat.com,
        jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717192200.GA17687@dustball.usersys.redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan, Waiman, [+Jade and Paul for the litmus test at the end]

On Wed, Jul 17, 2019 at 09:22:00PM +0200, Jan Stancek wrote:
> On Wed, Jul 17, 2019 at 10:19:04AM -0400, Waiman Long wrote:
> > > If you add a comment to the code outlining the issue (preferably as a litmus
> > > test involving sem->count and some shared data which happens to be
> > > vmacache_seqnum in your test)), then:
> > > 
> > > Reviewed-by: Will Deacon <will@kernel.org>
> > > 
> > > Thanks,
> > > 
> > > Will
> > 
> > Agreed. A comment just above smp_acquire__after_ctrl_dep() on why this
> > is needed will be great.
> > 
> > Other than that,
> > 
> > Acked-by: Waiman Long <longman@redhat.com>
> > 
> 
> litmus test looks a bit long, would following be acceptable?
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..d9c96651bfc7 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1032,6 +1032,13 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  		 */
>  		if (adjustment && !(atomic_long_read(&sem->count) &
>  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> +			/*
> +			 * down_read() issued ACQUIRE on enter, but we can race
> +			 * with writer who did RELEASE only after us.
> +			 * ACQUIRE here makes sure reader operations happen only
> +			 * after all writer ones.
> +			 */

How about an abridged form of the litmus test here, just to show the cod
flow? e.g.:

/*
 * We need to ensure ACQUIRE semantics when reading sem->count so that
 * we pair with the RELEASE store performed by an unlocking/downgrading
 * writer.
 *
 * P0 (writer)			P1 (reader)
 *
 * down_write(sem);
 * <write shared data>
 * downgrade_write(sem);
 * -> fetch_add_release(&sem->count)
 *
 *				down_read_slowpath(sem);
 *				-> atomic_read(&sem->count)
 *				   <ctrl dep>
 *				   smp_acquire__after_ctrl_dep()
 *				<read shared data>
 */

In writing this, I also noticed that we don't have any explicit ordering
at the end of the reader slowpath when we wait on the queue but get woken
immediately:

	if (!waiter.task)
		break;

Am I missing something?

> +			smp_acquire__after_ctrl_dep();
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			rwsem_set_reader_owned(sem);
>  			lockevent_inc(rwsem_rlock_fast);
> 
> 
> with litmus test in commit log:
> ----------------------------------- 8< ------------------------------------
> C rwsem
> 
> {
> 	atomic_t rwsem_count = ATOMIC_INIT(1);
> 	int vmacache_seqnum = 10;
> }
> 
> P0(int *vmacache_seqnum, atomic_t *rwsem_count)
> {
> 	r0 = READ_ONCE(*vmacache_seqnum);
> 	WRITE_ONCE(*vmacache_seqnum, r0 + 1);
> 	/* downgrade_write */
> 	r1 = atomic_fetch_add_release(-1+256, rwsem_count);
> }
> 
> P1(int *vmacache_seqnum, atomic_t *rwsem_count, spinlock_t *sem_wait_lock)
> {
> 	/* rwsem_read_trylock */
> 	r0 = atomic_add_return_acquire(256, rwsem_count);
> 	/* rwsem_down_read_slowpath */
> 	spin_lock(sem_wait_lock);
> 	r0 = atomic_read(rwsem_count);
> 	if ((r0 & 1) == 0) {
> 		// BUG: needs barrier
> 		spin_unlock(sem_wait_lock);
> 		r1 = READ_ONCE(*vmacache_seqnum);
> 	}
> }
> exists (1:r1=10)
> ----------------------------------- 8< ------------------------------------

Thanks for writing this! It's definitely worth sticking it in the commit
log, but Paul and Jade might also like to include it as part of their litmus
test repository too.

Will
