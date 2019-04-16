Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44932C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089820693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qK7S0mj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfDPOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:42:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SueId32iFbRwQuPfy1oY9eCQkdDDSAd9MpnI8G4atNI=; b=qK7S0mj8gni6on4tipdmSvSeP
        J09LqXn5SNRzXcDbjZnuHVgMH2Gg8BVCh2gqf4ZudICsQJi4rOgOlj2O9TwjpHOVsrAIGVQpsZ8US
        WyuY3M4hR3jgSuj6gRIeZ9SwML0524el7wGJikh0+h2c+O5gxCB29pvHLQlj3aRTEVNS8tIjXsDFU
        6Ph+wrDJnW2Djc71FyZpBkauM7xfG61tRFxkU3eODjIOG0T3Rakkpfd7wg6UykW+JcAIygCkwvMRX
        MczdxPl4k5qPxt6eHwb10PrRXP/Be8VmV2l/EimKmGKmhYSfKl1hjM9kDJixJlQhZtHOVLeItv9AK
        jziDaV9Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGPI9-0007Mh-EX; Tue, 16 Apr 2019 14:42:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CE6829AC163A; Tue, 16 Apr 2019 16:42:31 +0200 (CEST)
Date:   Tue, 16 Apr 2019 16:42:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 04/16] locking/rwsem: Implement a new locking scheme
Message-ID: <20190416144231.GQ14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-5-longman@redhat.com>
 <20190416132218.GJ12232@hirez.programming.kicks-ass.net>
 <f6ec3b2e-5a23-d447-cf7d-459f81f5fce4@redhat.com>
 <20190416141820.GO4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416141820.GO4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 04:18:20PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 16, 2019 at 09:32:38AM -0400, Waiman Long wrote:
> > On 04/16/2019 09:22 AM, Peter Zijlstra wrote:
> > > On Sat, Apr 13, 2019 at 01:22:47PM -0400, Waiman Long wrote:
> > >> +#define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)
> > > The above doesn't seem to make it more readable or shorter.
> > 
> > Fair enough. I can remove that macro.
> 
> I did the same for the HANDOFF patch but seem to have misplaced the
> delta and have already refreshed the patch.

Had to redo it, so here goes:

---
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -102,9 +102,6 @@
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
 				 RWSEM_FLAG_HANDOFF)
 
-#define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
-#define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
-	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
  * store tearing can't happen as optimistic spinners may read and use
@@ -365,7 +362,7 @@ static void __rwsem_mark_wake(struct rw_
 	/*
 	 * Clear the handoff flag
 	 */
-	if (woken && RWSEM_COUNT_HANDOFF(atomic_long_read(&sem->count)))
+	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
 		adjustment -= RWSEM_FLAG_HANDOFF;
 
 	if (adjustment)
@@ -387,7 +384,7 @@ static inline bool rwsem_try_write_lock(
 
 retry:
 	if (count & RWSEM_LOCK_MASM)) {
-		if (RWSEM_COUNT_HANDOFF(count) || (wstate != WRITER_HANDOFF))
+		if ((count & RWSEM_FLAG_HANDOFF) || (wstate != WRITER_HANDOFF))
 			return false;
 		/*
 		 * The lock may become free just before setting handoff bit.
@@ -398,7 +395,7 @@ static inline bool rwsem_try_write_lock(
 		goto retry;
 	}
 
-	if ((wstate == WRITER_NOT_FIRST) && RWSEM_COUNT_HANDOFF(count))
+	if ((wstate == WRITER_NOT_FIRST) && (count & RWSEM_FLAG_HANDOFF))
 		return false;
 
 	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
@@ -409,7 +406,7 @@ static inline bool rwsem_try_write_lock(
 		return true;
 	}
 
-	if (unlikely((wstate == WRITER_HANDOFF) && !RWSEM_COUNT_HANDOFF(count)))
+	if (unlikely((wstate == WRITER_HANDOFF) && !(count & RWSEM_FLAG_HANDOFF)))
 		goto retry;
 
 	return false;
@@ -704,7 +701,7 @@ __rwsem_down_write_failed_common(struct
 			    rwsem_waiter_is_first(sem, &waiter))
 				wstate = WRITER_FIRST;
 
-			if (!RWSEM_COUNT_LOCKED(count))
+			if (!(count & RWSEM_LOCK_MASK))
 				break;
 
 			/*
