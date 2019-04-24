Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F220C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009042148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZPwsO6Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfDXHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:10:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ehC7gqea2vti0BBQFwW9XKtZ4cq4raV9z3lJdyKr98c=; b=ZPwsO6Fb/2SmRiK6MNTYyC0LE
        3pcn4nDruVwaqF7/BTzEFTCCcBDcvYtZIju21NOTa0hbOpy3RKR+SM2Dw1YN/LxQ2tx8+PfBCxKat
        8eoe4Hp0buY22S/HPpM/HqQy/Mx2kQ9rLQ/n14H8mQsqw7nWxwBumws6CyitkXLLpAgtN7ZThG3cZ
        njODZLz/i8d7o54Lqub+xTVctSq7JIvzRMiHQfURWfZvWXe4zPjVW+hxXmfJNR5mI6zP8lQ2uUPNf
        u5JFbIHi/fAmXjlDfk5E0xuyX3WDPRZh6xRJBm7rZz0rrZAEAMiCXS71KBMChN2UpTusSxPzRk3EI
        MmfzfJsXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJC2a-0003eU-LO; Wed, 24 Apr 2019 07:10:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 295A229BBFB81; Wed, 24 Apr 2019 09:09:59 +0200 (CEST)
Date:   Wed, 24 Apr 2019 09:09:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190424070959.GE4038@hirez.programming.kicks-ass.net>
References: <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:12:16PM -0400, Waiman Long wrote:
> That is true in general, but doing preempt_disable/enable across
> function boundary is ugly and prone to further problems down the road.

We do worse things in this code, and the thing Linus proposes is
actually quite simple, something like so:

---
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -912,7 +904,7 @@ rwsem_down_read_slowpath(struct rw_semap
 			raw_spin_unlock_irq(&sem->wait_lock);
 			break;
 		}
-		schedule();
+		schedule_preempt_disabled();
 		lockevent_inc(rwsem_sleep_reader);
 	}
 
@@ -1121,6 +1113,7 @@ static struct rw_semaphore *rwsem_downgr
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
+	preempt_disable();
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
@@ -1129,10 +1122,12 @@ inline void __down_read(struct rw_semaph
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	preempt_enable();
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
+	preempt_disable();
 	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
 			&sem->count) & RWSEM_READ_FAILED_MASK)) {
 		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
@@ -1142,6 +1137,7 @@ static inline int __down_read_killable(s
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
+	preempt_enable();
 	return 0;
 }
 
