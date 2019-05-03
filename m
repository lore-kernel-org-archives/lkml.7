Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F6C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B142070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tEiN5+wY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfECNLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:11:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfECNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OMaRH3VsZn3co8dH6kEeF/IldLW+pNsz2+t9J3vWeWs=; b=tEiN5+wYuky+hkGHcDPv/NmmM
        9JHqAPCvZpRfkuLS7DZTVekcDERfYf5LXdUsQiU3JlcIPGLItAt+z0kT5f2ue/r4qnGGMyQvOiKs0
        oThiUGTDL9cseF6rKhhp+KKs4ufm75krm1WC1PYR2smQPgRQCEYNV/w+kKx6nbQvITeqdK6L++6sb
        /rZkNDLXMHe4NGDzHJNXJ/6ayucgnpNCfnXqlyvbOg2YqPJhuA37RHB+nifAqRExalpGHwo4ASrwD
        tLf91ER5WDHamwSPJeNSBkW7sGTsYXRKnffpD61A0dMNOgaKijNlc3Up4pgX80N/Nu0alWm21xi3O
        hpLjWJ6tQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMXxo-0006P5-9A; Fri, 03 May 2019 13:10:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5266E2869A006; Fri,  3 May 2019 15:10:54 +0200 (CEST)
Date:   Fri, 3 May 2019 15:10:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v7 08/20] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190503131054.GE2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-9-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428212557.13482-9-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 05:25:45PM -0400, Waiman Long wrote:
> +static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
> +					enum writer_wait_state wstate)
>  {
>  	long new;
>  
> +	lockdep_assert_held(&sem->wait_lock);
> +	do {
> +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
> +		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +			return false;
>  
> +		if (count & RWSEM_LOCK_MASK) {
> +			if (has_handoff || (wstate != WRITER_HANDOFF))
> +				return false;
> +			new = count | RWSEM_FLAG_HANDOFF;
> +		} else {
> +			new = (count | RWSEM_WRITER_LOCKED) &
> +				~RWSEM_FLAG_HANDOFF;
>  
> +			if (list_is_singular(&sem->wait_list))
> +				new &= ~RWSEM_FLAG_WAITERS;
> +		}
> +	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
> +
> +	/*
> +	 * We have either acquired the lock with handoff bit cleared or
> +	 * set the handoff bit.
> +	 */
> +	if (new & RWSEM_FLAG_HANDOFF)
> +		return false;
> +
> +	rwsem_set_owner(sem);
> +	return true;
>  }

I've changed that like so.

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -406,19 +406,23 @@ static inline bool rwsem_try_write_lock(
 	long new;
 
 	lockdep_assert_held(&sem->wait_lock);
+
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
 		if (has_handoff && wstate == WRITER_NOT_FIRST)
 			return false;
 
+		new = count;
+
 		if (count & RWSEM_LOCK_MASK) {
 			if (has_handoff || (wstate != WRITER_HANDOFF))
 				return false;
-			new = count | RWSEM_FLAG_HANDOFF;
+
+			new |= RWSEM_FLAG_HANDOFF;
 		} else {
-			new = (count | RWSEM_WRITER_LOCKED) &
-				~RWSEM_FLAG_HANDOFF;
+			new |= RWSEM_WRITER_LOCKED;
+			new &= ~RWSEM_FLAG_HANDOFF;
 
 			if (list_is_singular(&sem->wait_list))
 				new &= ~RWSEM_FLAG_WAITERS;
