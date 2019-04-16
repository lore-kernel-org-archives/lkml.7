Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9smmJ/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfDPNW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:22:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wRyiz2HGMtkDqHKMIja+EJXdfw0X4hWiHm86Pz6GyS0=; b=a9smmJ/FvN68FOGmwvw7TG7rq
        OYX8NG8t5cYXxKuUc7SxzmrDPiW1d/vZ/tF6gOyS8wzWMFV8R81ZtgWJi9j40tYkF4qQ/55UvunPm
        nUllrC2x+X83Almwe4V0ZdG1Yo1BaPCl1i6ZnyQjLMBQrdGC3wdn2BYISHSTdTVOwAxFXqnHWFZdQ
        cieEbEtXWdPUBhqCnBryaM08IDi78k1OAFCpvw63AJorHLMhaoptOdff+jkEO3eVGzSkeiq5MTGgm
        2nEdKHJOc5yGJo9R1cRICRcmnguaEKECBSFC7O3v02OwENF/JAb7rAyCcBAhwmlbFEJdqjnFa4l5d
        QaUeCbClA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGO2W-00041o-RS; Tue, 16 Apr 2019 13:22:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0DA829B5EF9E; Tue, 16 Apr 2019 15:22:18 +0200 (CEST)
Date:   Tue, 16 Apr 2019 15:22:18 +0200
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
Message-ID: <20190416132218.GJ12232@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:47PM -0400, Waiman Long wrote:
> +#define RWSEM_COUNT_LOCKED(c)	((c) & RWSEM_LOCK_MASK)

The above doesn't seem to make it more readable or shorter.

--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -192,7 +192,7 @@ static inline bool rwsem_try_write_lock(
 {
 	long new;
 
-	if (RWSEM_COUNT_LOCKED(count))
+	if (count & RWSEM_LOCK_MASK)
 		return false;
 
 	new = count + RWSEM_WRITER_LOCKED -
@@ -214,7 +214,7 @@ static inline bool rwsem_try_write_lock_
 {
 	long count = atomic_long_read(&sem->count);
 
-	while (!RWSEM_COUNT_LOCKED(count)) {
+	while (!(count & RWSEM_LOCK_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count + RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
@@ -393,7 +393,7 @@ __rwsem_down_read_failed_common(struct r
 	 * If there are no writers and we are first in the queue,
 	 * wake our own waiter to join the existing active readers !
 	 */
-	if (!RWSEM_COUNT_LOCKED(count) ||
+	if (!(count & RWSEM_LOCK_MASK) ||
 	   (!(count & RWSEM_WRITER_MASK) && (adjustment & RWSEM_FLAG_WAITERS)))
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 
@@ -522,7 +522,7 @@ __rwsem_down_write_failed_common(struct
 			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 			count = atomic_long_read(&sem->count);
-		} while (RWSEM_COUNT_LOCKED(count));
+		} while (count & RWSEM_LOCK_MASK);
 
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
