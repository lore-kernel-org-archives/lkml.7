Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B0C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F420637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 15:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLHPAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 10:00:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfLHO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy10-0000Qy-S7; Sun, 08 Dec 2019 15:58:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 860111C2887;
        Sun,  8 Dec 2019 15:58:30 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:30 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, mm: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Chistoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-26-bigeasy@linutronix.de>
References: <20191015191821.11479-26-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711044.21853.1629437364165530874.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     923717cbab900fb23b31f16fb31b1d86b09bf702
Gitweb:        https://git.kernel.org/tip/923717cbab900fb23b31f16fb31b1d86b09bf702
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:36 +01:00

sched/rt, mm: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the pte_unmap_same() and SLUB code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Chistoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/20191015191821.11479-26-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 mm/memory.c |  2 +-
 mm/slub.c   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 513c3ec..d56883c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2151,7 +2151,7 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 				pte_t *page_table, pte_t orig_pte)
 {
 	int same = 1;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		spinlock_t *ptl = pte_lockptr(mm, pmd);
 		spin_lock(ptl);
diff --git a/mm/slub.c b/mm/slub.c
index d113897..f7c66dc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1964,7 +1964,7 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	return get_any_partial(s, flags, c);
 }
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 /*
  * Calculate the next globally unique transaction for disambiguiation
  * during cmpxchg. The transactions start with the cpu number and are then
@@ -2009,7 +2009,7 @@ static inline void note_cmpxchg_failure(const char *n,
 
 	pr_info("%s %s: cmpxchg redo ", n, s->name);
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
 		pr_warn("due to cpu change %d -> %d\n",
 			tid_to_cpu(tid), tid_to_cpu(actual_tid));
@@ -2637,7 +2637,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	unsigned long flags;
 
 	local_irq_save(flags);
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/*
 	 * We may have been preempted and rescheduled on a different
 	 * cpu before disabling interrupts. Need to reload cpu area
@@ -2691,13 +2691,13 @@ redo:
 	 * as we end up on the original cpu again when doing the cmpxchg.
 	 *
 	 * We should guarantee that tid and kmem_cache are retrieved on
-	 * the same cpu. It could be different if CONFIG_PREEMPT so we need
+	 * the same cpu. It could be different if CONFIG_PREEMPTION so we need
 	 * to check if it is matched or not.
 	 */
 	do {
 		tid = this_cpu_read(s->cpu_slab->tid);
 		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPT) &&
+	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
 		 unlikely(tid != READ_ONCE(c->tid)));
 
 	/*
@@ -2971,7 +2971,7 @@ redo:
 	do {
 		tid = this_cpu_read(s->cpu_slab->tid);
 		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPT) &&
+	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
 		 unlikely(tid != READ_ONCE(c->tid)));
 
 	/* Same with comment on barrier() in slab_alloc_node() */
