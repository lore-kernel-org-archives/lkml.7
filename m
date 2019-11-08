Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0579C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FB321924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573229373;
	bh=s0nzmpWNJbD5C+AskEEvykR21U7P7AkJtAJ0XDJ+leU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNhPaFChhzXo4/3ZRY2yTqZMb3PrS19kHCtUPXcAxtYWZ5PTd5Za0h7Js1I8hD7Tb
	 nAly2LJeBzc8AMJ6++dkw8jh1oCBMoh6yvL6gDS9DgdjTVxkDwIoYSgIrJ5zw7OZY5
	 2x41VU/lhEe1fispgAWEEzaUSvvFmy50/kU6aJQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfKHQJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfKHQJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:30 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66EF3222C4;
        Fri,  8 Nov 2019 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573229369;
        bh=s0nzmpWNJbD5C+AskEEvykR21U7P7AkJtAJ0XDJ+leU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHAxhXRdH7GCOuexwhYHk/6J6PEls5JPFd6QC++qEPxawfDUh0qNJnu728bBaEVdk
         A1h4Zm4JIZokRxiWJFMV3vRBJC9/w+h2QAGrDZGbX06g81Jhl5xCGRpYNzG+TuHJ7K
         AdM8YHgAC5Tzzg3rGK2VvoekGUt1DVbJqyd/qZcg=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 4/4] irq_work: Weaken ordering in irq_work_run_list()
Date:   Fri,  8 Nov 2019 17:08:58 +0100
Message-Id: <20191108160858.31665-5-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108160858.31665-1-frederic@kernel.org>
References: <20191108160858.31665-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This patch is RFC because it makes the code less clear in favour of
ordering optimization, ordering which has yet to pass under careful
eyes. Not sure it's worth it.)

Clearing IRQ_WORK_PENDING from atomic_fetch_andnot() let us know the
old value of flags that we can reuse in the later cmpxchg() to clear
IRQ_WORK_BUZY if necessary.

However there is no need to read flags atomically here. Its value can't
be concurrently changed before we clear the IRQ_WORK_PENDING bit. So we
can safely read it before the call to atomic_fetch_andnot() which can
then become atomic_andnot() followed by an smp_mb__after_atomic(). That
preserves the ordering that makes sure we see the latest updates
preceding irq_work_claim() while it doesn't raise a new IPI while
observing the work already queued.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 49c53f80a13a..b709ab05cbfd 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -34,8 +34,8 @@ static bool irq_work_claim(struct irq_work *work)
 	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
-	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
-	 * everything we did before is visible.
+	 * The pairing atomic_andnot() followed by a barrier in irq_work_run()
+	 * makes sure everything we did before is visible.
 	 */
 	if (oflags & IRQ_WORK_PENDING)
 		return false;
@@ -143,7 +143,7 @@ static void irq_work_run_list(struct llist_head *list)
 
 	llnode = llist_del_all(list);
 	llist_for_each_entry_safe(work, tmp, llnode, llnode) {
-		int flags;
+		int flags = atomic_read(&work->flags);
 		/*
 		 * Clear the PENDING bit, after this point the @work
 		 * can be re-used.
@@ -151,14 +151,16 @@ static void irq_work_run_list(struct llist_head *list)
 		 * to claim that work don't rely on us to handle their data
 		 * while we are in the middle of the func.
 		 */
-		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+		atomic_andnot(IRQ_WORK_PENDING, &work->flags);
+		smp_mb__after_atomic();
 
 		work->func(work);
 		/*
 		 * Clear the BUSY bit and return to the free state if
 		 * no-one else claimed it meanwhile.
 		 */
-		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+		(void)atomic_cmpxchg(&work->flags, flags & ~IRQ_WORK_PENDING,
+				     flags & ~IRQ_WORK_CLAIMED);
 	}
 }
 
-- 
2.23.0

