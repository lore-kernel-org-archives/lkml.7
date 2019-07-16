Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D27C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926B120449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mCAefUio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfGPS6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:58:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NQzPm2qSJHyNNPNoCIrDmmIjlWz77+rLZs+LoDSCCnc=; b=mCAefUio78c06/zAfjCgyR/l1
        US4MU1Rihn1Wf7CcksM3U2gEr9nyYf9bQ+2J2KEVqOQ8H8JagVJxlOoTIUgifAtPBiIgKr/QCL7td
        Yo8Mfogwya+jaUhJpuVcG2kudW6OQGxAXjJCXH7yy/MQv3fFKq1scWavZRygdyVs+CP/8m0OHSOSp
        Heev3pTb+bPb/pDzRfP3i+V5L50n5HZhJTvOxi0WxiOcblN//8+9Om5JaX4/QXzD6TFc6jDVDEz7/
        oDVPmYvo9c8D8faZsBOZgM9wFOpkuIf6dvJQTQxnjqkByy4O8XNn0P4Yqvzop/M17vxidI8EQSSjT
        P26KH8Hag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnSeR-0002qo-9I; Tue, 16 Jul 2019 18:58:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A12220B15D60; Tue, 16 Jul 2019 20:58:08 +0200 (CEST)
Date:   Tue, 16 Jul 2019 20:58:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, will@kernel.org, mingo@redhat.com
Subject: Re: [PATCH] locking/rwsem: use read_acquire in read_slowpath exit
 when queue is empty
Message-ID: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
References: <ea7ef295bc438c9d403087943c82ced56730e6e0.1563292737.git.jstancek@redhat.com>
 <4ef66a01-7937-1eb7-c58b-0992a0142c92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef66a01-7937-1eb7-c58b-0992a0142c92@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 12:53:14PM -0400, Waiman Long wrote:
> On 7/16/19 12:04 PM, Jan Stancek wrote:

> > Suspected problem here is that last *_acquire on down_read() side
> > happens before write side issues *_release:
> >   1. writer: has the lock
> >   2. reader: down_read() issues *read_acquire on entry
> >   3. writer: mm->vmacache_seqnum++; downgrades lock (*fetch_add_release)
> >   4. reader: __rwsem_down_read_failed_common() finds it can take lock and returns
> >   5. reader: observes stale mm->vmacache_seqnum
> >
> > I can reproduce the problem by running LTP mtest06 in a loop and building
> > kernel (-j $NCPUS) in parallel. It does reproduce since v4.20 up to v5.2
> > on arm64 HPE Apollo 70 (224 CPUs, 256GB RAM, 2 nodes). It triggers reliably
> > within ~hour. Patched kernel ran fine for 5+ hours with clean dmesg.
> > Tests were done against v5.2, since commit cf69482d62d9 ("locking/rwsem:
> > Enable readers spinning on writer") makes it much harder to reproduce.

> > Fixes: 4b486b535c33 ("locking/rwsem: Exit read lock slowpath if queue empty & no writer")
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Davidlohr Bueso <dbueso@suse.de>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/locking/rwsem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > index 37524a47f002..757b198d7a5b 100644
> > --- a/kernel/locking/rwsem.c
> > +++ b/kernel/locking/rwsem.c
> > @@ -1030,7 +1030,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> >  		 * exit the slowpath and return immediately as its
> >  		 * RWSEM_READER_BIAS has already been set in the count.
> >  		 */
> > -		if (adjustment && !(atomic_long_read(&sem->count) &
> > +		if (adjustment && !(atomic_long_read_acquire(&sem->count) &
> >  		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> >  			raw_spin_unlock_irq(&sem->wait_lock);
> >  			rwsem_set_reader_owned(sem);
> 
> The chance of taking this path is not that high. So instead of
> increasing the cost of the test by adding an acquire barrier, how about
> just adding smp_mb__after_spinlock() before spin_unlock_irq(). This
> should have the same effect of making sure that no stale data will be
> used in the read-lock critical section.

That's actually more expensive on something like ARM64 I expect.

The far cheaper alternative is smp_acquire__after_ctrl_dep(), however in
general Will seems to prefer using load-acquire over separate barriers,
and for x86 it doesn't matter anyway. For PowerPC these two are a wash,
both end up with LWSYNC (over SYNC for your alternative).


