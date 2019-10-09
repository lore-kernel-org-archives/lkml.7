Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB967ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0C8206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDUQeWip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfJIP6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:58:12 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:47765 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIP6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:58:12 -0400
Received: by mail-wr1-f74.google.com with SMTP id j7so1318158wrx.14
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=abr/+LxZ+FiLxVnRzYrbO/3J1+C3HpnTllGYvP95Mw0=;
        b=XDUQeWipb1cPMDQgCk+EbEfY2ZmWh4MZncDgs/3STz23uKf22/84ZKr68H7ncRN1Q4
         K5N7cjK0U9UOiEPZ0KcAxa2d151J5hWupoOW/OPLWPUHa7eYTqNCocDzYwrTKg1GE0BB
         oBcN74VCEgH1taQyhz1pmSm/iz2ZGcKLp2SRWjx75bAilZQU6fhEcbFaNnUjcU0DbAvP
         lzwBTHZvLqp2/Hk3vqe8kQibjNMUbSkAWllfGU3wTB/LRljUrcuQguQVFGoIxZaV85kU
         AtCY+qLlMgcrjDWOPu6d/O/3QjGAeU3mNYREV6U7b+0CyOulZ5ZR5+LYq3nrEPnSh/LJ
         5btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=abr/+LxZ+FiLxVnRzYrbO/3J1+C3HpnTllGYvP95Mw0=;
        b=ix44NA/mlqbE8phHda+wqsTE+OpdwWmljXlZsSYX73BUHNnRySNt0XC7UJJBVEFuis
         wAh1E0WWl/+lgHbLnBfblE6SeGYgGNln6JKMGsQIzZPXLXqVqNE4V5ihFjYsslTs9sHk
         OUQ0bYMMv95fBngBMc8B3BMzUwxuedBoAskerzn2ghTWb6eT9B0vXtK8WnZciTmdUWxy
         oLYfrjPjyALzBL271yr2mskwyY/XjWOleHSfcdfGmQ9QvvD6la6iwzGQrmoai10cGS2x
         d0yDsZMSbGrauBUMZzGBFo+il5UWKetgpAkypDGninFgI4IVac+ddmIMwWlh1F6MbLFu
         fzAQ==
X-Gm-Message-State: APjAAAVwVgrHSx8+c6eDyNoml5DKN0UtaPy3kTLk2pgPsW+pfp5pAv6J
        2GNNaxyfYYTx6zFNloHRjPJIvWhdWA==
X-Google-Smtp-Source: APXvYqzsJxBFYiO8oJHtBTE1EecgQsR6L1Gk90WMsV+WM9D0Qhl6lyF5V7lcoI4kIGU4VF+YSawV1hC2yA==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr3669684wrw.115.1570636688809;
 Wed, 09 Oct 2019 08:58:08 -0700 (PDT)
Date:   Wed,  9 Oct 2019 17:57:43 +0200
Message-Id: <20191009155743.202142-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] rcu: Fix data-race due to atomic_t copy-by-value
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/trace/events/rcu.h |  4 ++--
 kernel/rcu/tree.c          | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 694bd040cf51..fdd31c5fd126 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -442,7 +442,7 @@ TRACE_EVENT_RCU(rcu_fqs,
  */
 TRACE_EVENT_RCU(rcu_dyntick,
 
-	TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
+	TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
 
 	TP_ARGS(polarity, oldnesting, newnesting, dynticks),
 
@@ -457,7 +457,7 @@ TRACE_EVENT_RCU(rcu_dyntick,
 		__entry->polarity = polarity;
 		__entry->oldnesting = oldnesting;
 		__entry->newnesting = newnesting;
-		__entry->dynticks = atomic_read(&dynticks);
+		__entry->dynticks = dynticks;
 	),
 
 	TP_printk("%s %lx %lx %#3x", __entry->polarity,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 81105141b6a8..62e59596a30a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -576,7 +576,7 @@ static void rcu_eqs_enter(bool user)
 	}
 
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rdp = this_cpu_ptr(&rcu_data);
 	do_nocb_deferred_wakeup(rdp);
@@ -649,14 +649,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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
@@ -743,7 +744,7 @@ static void rcu_eqs_exit(bool user)
 	rcu_dynticks_task_exit();
 	rcu_dynticks_eqs_exit();
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -827,7 +828,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
+			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
 	barrier();
-- 
2.23.0.581.g78d2f28ef7-goog

