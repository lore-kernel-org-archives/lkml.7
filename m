Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7844EC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BDF218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lG0YUNq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfIPQLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:11:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43294 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfIPQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:11:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id c3so427389qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hYiV+Tzil2zbGH6H1vEL04hASaKNGcqRjqpNKuog1j8=;
        b=lG0YUNq0CsRkhS38Czc8GPhdseFXPei6ngb882prpIs6rtQBqa5+IA40cIyaYC8Ks8
         rGueAAHbb5sMHq4WHVpkBOYb309J+03aycktHh0K72nEADhHFxcvcvLhA4B2C+nWVzIM
         4pMMUzQB74LsShGMrY6nTeHz4HTMTIMX80JN8FBA6LYWxZ2qYzelKprspJxt89VGX9T6
         rwYxy7xaC+SaccDFhp6uzDxpsxE0fdgExL04yJgNn4mm3bHzAgugmzcpZkh0HzUdig1P
         jPK+RYzeuI1uXxxEUO2iNTdBWB5L38TYs+nGbzaYLiDAYvNuw1cqYebyl2uUf/UYCbax
         bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hYiV+Tzil2zbGH6H1vEL04hASaKNGcqRjqpNKuog1j8=;
        b=gmdKWj6WFfTfDtQ21fovaUODpw37Ho4rgs0AxO9aTU/qQcxTtOhtnHUj5S++naAOPj
         OHwfXxPHT72E1HMdXV5OFykpxXrKZbJJl7aPWI9KZVy53dLZNqqzksB7TtWV9gStuRml
         wANB2lQUfnnf7Vypen9FFNhmhmtWlCGrJjI83wwWT3dFGD5kf7M44OO5zX7s8r6FGLMO
         4FEtqxjuuMvsJmTD9PmYE/39MthvYza3mN2HKdJDis8EsG7in24tV7DnK+dz2tbKsb5d
         aKZaVX2n4zOCJ4es5N4KAAy2QGfH1IKdenzChbat1R6bCphgD97BgmHEFq8FUGlCXFHl
         wP6A==
X-Gm-Message-State: APjAAAWGIGVonQ8ZtA8oG3s+gNCQurWB4Ig/9BCmNbqvSLvs6zae/TT9
        UCXNn+wV4j9QBPZp1q7e48r2Sg==
X-Google-Smtp-Source: APXvYqxk0TAaIrkXFjV44Y2FBZzSwLv+eXPJ6geS1Fu5CtVTt5E6UNG4eh1wn9bmUozmUn48ntR4TQ==
X-Received: by 2002:ac8:7b2e:: with SMTP id l14mr361841qtu.11.1568650312629;
        Mon, 16 Sep 2019 09:11:52 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a72sm18233133qkg.77.2019.09.16.09.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:11:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RFC PATCH] mm/slub: remove left-over debugging code
Date:   Mon, 16 Sep 2019 12:11:34 -0400
Message-Id: <1568650294-8579-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB_RESILIENCY_TEST and SLUB_DEBUG_CMPXCHG look like some left-over
debugging code during the internal development that probably nobody uses
it anymore. Remove them to make the world greener.
---
 mm/slub.c | 110 --------------------------------------------------------------
 1 file changed, 110 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..f97155ba097d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -150,12 +150,6 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
  * - Variable sizing of the per node arrays
  */
 
-/* Enable to test recovery from slab corruption on boot */
-#undef SLUB_RESILIENCY_TEST
-
-/* Enable to log cmpxchg failures */
-#undef SLUB_DEBUG_CMPXCHG
-
 /*
  * Mininum number of partial slabs. These will be left on the partial
  * lists even if they are empty. kmem_cache_shrink may reclaim them.
@@ -392,10 +386,6 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
 
-#ifdef SLUB_DEBUG_CMPXCHG
-	pr_info("%s %s: cmpxchg double redo ", n, s->name);
-#endif
-
 	return false;
 }
 
@@ -433,10 +423,6 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 	cpu_relax();
 	stat(s, CMPXCHG_DOUBLE_FAIL);
 
-#ifdef SLUB_DEBUG_CMPXCHG
-	pr_info("%s %s: cmpxchg double redo ", n, s->name);
-#endif
-
 	return false;
 }
 
@@ -2004,45 +1990,11 @@ static inline unsigned long next_tid(unsigned long tid)
 	return tid + TID_STEP;
 }
 
-static inline unsigned int tid_to_cpu(unsigned long tid)
-{
-	return tid % TID_STEP;
-}
-
-static inline unsigned long tid_to_event(unsigned long tid)
-{
-	return tid / TID_STEP;
-}
-
 static inline unsigned int init_tid(int cpu)
 {
 	return cpu;
 }
 
-static inline void note_cmpxchg_failure(const char *n,
-		const struct kmem_cache *s, unsigned long tid)
-{
-#ifdef SLUB_DEBUG_CMPXCHG
-	unsigned long actual_tid = __this_cpu_read(s->cpu_slab->tid);
-
-	pr_info("%s %s: cmpxchg redo ", n, s->name);
-
-#ifdef CONFIG_PREEMPT
-	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
-		pr_warn("due to cpu change %d -> %d\n",
-			tid_to_cpu(tid), tid_to_cpu(actual_tid));
-	else
-#endif
-	if (tid_to_event(tid) != tid_to_event(actual_tid))
-		pr_warn("due to cpu running other code. Event %ld->%ld\n",
-			tid_to_event(tid), tid_to_event(actual_tid));
-	else
-		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
-			actual_tid, tid, next_tid(tid));
-#endif
-	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
-}
-
 static void init_kmem_cache_cpus(struct kmem_cache *s)
 {
 	int cpu;
@@ -2751,7 +2703,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 				object, tid,
 				next_object, next_tid(tid)))) {
 
-			note_cmpxchg_failure("slab_alloc", s, tid);
 			goto redo;
 		}
 		prefetch_freepointer(s, next_object);
@@ -4694,66 +4645,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 }
 #endif	/* CONFIG_SLUB_DEBUG */
 
-#ifdef SLUB_RESILIENCY_TEST
-static void __init resiliency_test(void)
-{
-	u8 *p;
-	int type = KMALLOC_NORMAL;
-
-	BUILD_BUG_ON(KMALLOC_MIN_SIZE > 16 || KMALLOC_SHIFT_HIGH < 10);
-
-	pr_err("SLUB resiliency testing\n");
-	pr_err("-----------------------\n");
-	pr_err("A. Corruption after allocation\n");
-
-	p = kzalloc(16, GFP_KERNEL);
-	p[16] = 0x12;
-	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
-	       p + 16);
-
-	validate_slab_cache(kmalloc_caches[type][4]);
-
-	/* Hmmm... The next two are dangerous */
-	p = kzalloc(32, GFP_KERNEL);
-	p[32 + sizeof(void *)] = 0x34;
-	pr_err("\n2. kmalloc-32: Clobber next pointer/next slab 0x34 -> -0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-
-	validate_slab_cache(kmalloc_caches[type][5]);
-	p = kzalloc(64, GFP_KERNEL);
-	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
-	*p = 0x56;
-	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
-	       p);
-	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[type][6]);
-
-	pr_err("\nB. Corruption after free\n");
-	p = kzalloc(128, GFP_KERNEL);
-	kfree(p);
-	*p = 0x78;
-	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][7]);
-
-	p = kzalloc(256, GFP_KERNEL);
-	kfree(p);
-	p[50] = 0x9a;
-	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][8]);
-
-	p = kzalloc(512, GFP_KERNEL);
-	kfree(p);
-	p[512] = 0xab;
-	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][9]);
-}
-#else
-#ifdef CONFIG_SYSFS
-static void resiliency_test(void) {};
-#endif
-#endif	/* SLUB_RESILIENCY_TEST */
-
 #ifdef CONFIG_SYSFS
 enum slab_stat_type {
 	SL_ALL,			/* All slabs */
@@ -5875,7 +5766,6 @@ static int __init slab_sysfs_init(void)
 	}
 
 	mutex_unlock(&slab_mutex);
-	resiliency_test();
 	return 0;
 }
 
-- 
1.8.3.1

