Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635BEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FF1205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950537;
	bh=oTekImA/+nyeVowpRPE5W/zaHGtAeTl/S2YCyonCT+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hn6yqybcNpKnneO0HyxnpC+Yrnf3B5vSE0I/pcTQGmg7TM5O01e9U3EatLeWqU/ES
	 NoKHYYTH13ziTh0e9Fhc+g/FQ29WjUr3kQ/MmYjpe9XxKOfyxKRj+QIQ6zGE2sQH/c
	 iAFMPCYLhE89nUnfew7GZe/R2Wft5b0qAMMbFp5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJECC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:59 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2F820836;
        Tue, 10 Dec 2019 04:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950518;
        bh=oTekImA/+nyeVowpRPE5W/zaHGtAeTl/S2YCyonCT+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSTbikKxP6JlBINsNOFN8mHsL9YfNH8UXKlI9LK1IaK4ovT385qezvSWmNfxsxIUY
         uk5AUencqDDPPddoqwO0k+NN0k4V+5rQEpJFwYixqDtkZt/cLj6MMH3rEKGF9lOszu
         q2RTDZtDuDkC5wFaLMwAtod98+LxFOPRL5ENHSLs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH tip/core/rcu 03/10] rcu: Fix data-race due to atomic_t copy-by-value
Date:   Mon,  9 Dec 2019 20:01:47 -0800
Message-Id: <20191210040154.2498-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

This fixes a data-race where `atomic_t dynticks` is copied by value. The
copy is performed non-atomically, resulting in a data-race if `dynticks`
is updated concurrently.

This data-race was found with KCSAN:
==================================================================
BUG: KCSAN: data-race in dyntick_save_progress_counter / rcu_irq_enter

write to 0xffff989dbdbe98e0 of 4 bytes by task 10 on cpu 3:
 atomic_add_return include/asm-generic/atomic-instrumented.h:78 [inline]
 rcu_dynticks_snap kernel/rcu/tree.c:310 [inline]
 dyntick_save_progress_counter+0x43/0x1b0 kernel/rcu/tree.c:984
 force_qs_rnp+0x183/0x200 kernel/rcu/tree.c:2286
 rcu_gp_fqs kernel/rcu/tree.c:1601 [inline]
 rcu_gp_fqs_loop+0x71/0x880 kernel/rcu/tree.c:1653
 rcu_gp_kthread+0x22c/0x3b0 kernel/rcu/tree.c:1799
 kthread+0x1b5/0x200 kernel/kthread.c:255
 <snip>

read to 0xffff989dbdbe98e0 of 4 bytes by task 154 on cpu 7:
 rcu_nmi_enter_common kernel/rcu/tree.c:828 [inline]
 rcu_irq_enter+0xda/0x240 kernel/rcu/tree.c:870
 irq_enter+0x5/0x50 kernel/softirq.c:347
 <snip>

Reported by Kernel Concurrency Sanitizer on:
CPU: 7 PID: 154 Comm: kworker/7:1H Not tainted 5.3.0+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
==================================================================

Signed-off-by: Marco Elver <elver@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/tree.c          | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 6612260..697e2c0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -449,7 +449,7 @@ TRACE_EVENT_RCU(rcu_fqs,
  */
 TRACE_EVENT_RCU(rcu_dyntick,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
+	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
 
 	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
 
@@ -464,7 +464,7 @@ TRACE_EVENT_RCU(rcu_dyntick,
 		__entry->polarity = polarity;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
-		__entry->dynticks = atomic_read(&dynticks);
+		__entry->dynticks = dynticks;
 	),
 
 	TP_printk("%s %lx %lx %#3x", __entry->polarity,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..6145e08 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -577,7 +577,7 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -650,14 +650,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	 * leave it in non-RCU-idle state.
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
+		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
+				  atomic_read(&rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (irq)
@@ -744,7 +745,7 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -833,7 +834,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
+			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
-- 
2.9.5

