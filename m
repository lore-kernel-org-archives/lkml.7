Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA9ECE596
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfJOTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:20:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389418AbfJOTSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:46 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLB-00067i-FL; Tue, 15 Oct 2019 21:18:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 25/34] mm: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:12 +0200
Message-Id: <20191015191821.11479-26-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the pte_unmap_same() and SLUB code over to use CONFIG_PREEMPTION.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memory.c |  2 +-
 mm/slub.c   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f27..fd2cede4a84f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2133,7 +2133,7 @@ static inline int pte_unmap_same(struct mm_struct *mm=
, pmd_t *pmd,
 				pte_t *page_table, pte_t orig_pte)
 {
 	int same =3D 1;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		spinlock_t *ptl =3D pte_lockptr(mm, pmd);
 		spin_lock(ptl);
diff --git a/mm/slub.c b/mm/slub.c
index 3d63ae320d31b..23fa669934829 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1984,7 +1984,7 @@ static void *get_partial(struct kmem_cache *s, gfp_t =
flags, int node,
 	return get_any_partial(s, flags, c);
 }
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 /*
  * Calculate the next globally unique transaction for disambiguiation
  * during cmpxchg. The transactions start with the cpu number and are then
@@ -2029,7 +2029,7 @@ static inline void note_cmpxchg_failure(const char *n,
=20
 	pr_info("%s %s: cmpxchg redo ", n, s->name);
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	if (tid_to_cpu(tid) !=3D tid_to_cpu(actual_tid))
 		pr_warn("due to cpu change %d -> %d\n",
 			tid_to_cpu(tid), tid_to_cpu(actual_tid));
@@ -2657,7 +2657,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t=
 gfpflags, int node,
 	unsigned long flags;
=20
 	local_irq_save(flags);
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	/*
 	 * We may have been preempted and rescheduled on a different
 	 * cpu before disabling interrupts. Need to reload cpu area
@@ -2700,13 +2700,13 @@ static __always_inline void *slab_alloc_node(struct=
 kmem_cache *s,
 	 * as we end up on the original cpu again when doing the cmpxchg.
 	 *
 	 * We should guarantee that tid and kmem_cache are retrieved on
-	 * the same cpu. It could be different if CONFIG_PREEMPT so we need
+	 * the same cpu. It could be different if CONFIG_PREEMPTION so we need
 	 * to check if it is matched or not.
 	 */
 	do {
 		tid =3D this_cpu_read(s->cpu_slab->tid);
 		c =3D raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPT) &&
+	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
 		 unlikely(tid !=3D READ_ONCE(c->tid)));
=20
 	/*
@@ -2984,7 +2984,7 @@ static __always_inline void do_slab_free(struct kmem_=
cache *s,
 	do {
 		tid =3D this_cpu_read(s->cpu_slab->tid);
 		c =3D raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPT) &&
+	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
 		 unlikely(tid !=3D READ_ONCE(c->tid)));
=20
 	/* Same with comment on barrier() in slab_alloc_node() */
--=20
2.23.0

