Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DBC22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIUmnsPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfLLWf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:35:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27482 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731195AbfLLWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pEKtnt+JQUKetJNgDkSiBPLQgi++nxjMDJ2PaPmD118=;
        b=cIUmnsPewdgPwHo3wGAf19iVm/r2BEM3snnGLWGxLKql0m3oDdAmeraFuksW3+gFPFAjHp
        rprr5G4/G4hU9Nnhihjo+5KhE/8MYPx9ELBX1EJ6H2+TyynpsMqVIbvGbCJk7s7lA+wxJ3
        QOd2wOQRUxrRWq6m+exvlgnX6UQ1FZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-d24WbFT5P1OL16jJFm_DOA-1; Thu, 12 Dec 2019 17:35:47 -0500
X-MC-Unique: d24WbFT5P1OL16jJFm_DOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F93800053;
        Thu, 12 Dec 2019 22:35:46 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CDF360BF3;
        Thu, 12 Dec 2019 22:35:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 5/5] locking/lockdep: Decrement irq context counters when removing lock chain
Date:   Thu, 12 Dec 2019 17:35:25 -0500
Message-Id: <20191212223525.1652-6-longman@redhat.com>
In-Reply-To: <20191212223525.1652-1-longman@redhat.com>
References: <20191212223525.1652-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently three counters to track the irq context of a lock
chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
They are incremented when a new lock chain is added, but they are not
decremented when a lock chain is removed. That causes the some of
the statistic counts reported by /proc/lockdep_stats to be incorrect.

Fix that by decrementing the right counter when a lock chain is removed.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 35 +++++++++++++++++++++---------
 kernel/locking/lockdep_internals.h |  6 +++++
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 97c17ba85d29..1d8f2fcd4bb4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2300,16 +2300,24 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	return 0;
 }
 
-static void inc_chains(void)
+static void inc_chains(int irq_context)
 {
-	if (current->hardirq_context)
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
 		nr_hardirq_chains++;
-	else {
-		if (current->softirq_context)
-			nr_softirq_chains++;
-		else
-			nr_process_chains++;
-	}
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains++;
+	else
+		nr_process_chains++;
+}
+
+static void dec_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains--;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains--;
+	else
+		nr_process_chains--;
 }
 
 #else
@@ -2325,6 +2333,10 @@ static inline void inc_chains(void)
 	nr_process_chains++;
 }
 
+static void dec_chains(int irq_context)
+{
+	nr_process_chains--;
+}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void
@@ -2933,7 +2945,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	chain_hlocks[chain->base + j] = class - lock_classes;
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
-	inc_chains();
+	inc_chains(chain->irq_context);
 
 	return 1;
 }
@@ -3686,7 +3698,8 @@ mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 
 static inline unsigned int task_irq_context(struct task_struct *task)
 {
-	return 2 * !!task->hardirq_context + !!task->softirq_context;
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
 }
 
 static int separate_irq_context(struct task_struct *curr,
@@ -4890,6 +4903,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 free_lock_chain:
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
+	dec_chains(chain->irq_context);
+
 	/*
 	 * Note: calling hlist_del_rcu() from inside a
 	 * hlist_for_each_entry_rcu() loop is safe.
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 999cd714e0d1..26e387d3155a 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -98,6 +98,12 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 
 #define MAX_LOCKDEP_CHAINS_BITS	16
 
+/*
+ * Bit definitions for lock_chain.irq_context
+ */
+#define LOCK_CHAIN_SOFTIRQ_CONTEXT	(1 << 0)
+#define LOCK_CHAIN_HARDIRQ_CONTEXT	(1 << 1)
+
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
-- 
2.18.1

