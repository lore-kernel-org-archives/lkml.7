Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946AFC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F86C2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfHXGCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:02:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so8014467pfq.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wuq/UPhGkaTNEp5qk9/bwOvoi4lXXhFrlEiO7VG/SEs=;
        b=gdS2wqyB92UMT5s8orvZIyxxqBfW6rg8arVsbcQBGPKda+dV0mgcoNbxAE61/fACm3
         eRdizxeR81GjqyALFEUpxC8//2I7bry5BXPZy2CaVu5L34HxfALQfM23wxwFO6/cTEt5
         a2lTvi0XnIOCrA5MwSU4OZMiIJWcLH5JLQpcnW5necKIn986aoUGnx5xBwFu4GLagL4z
         VtMJJ7Kx3PmS0E1iFzksE3ovyYNMUhewuRY821sxNR3uiNDHpzSZA44QabxO2D1KgcKJ
         C8EyfNPCWvXJ7s7IUWifNbeiqvw1nWBE05xdp3w5a7y1sMdqtXn60uOq0mvvnTvsZ1bd
         D+ew==
X-Gm-Message-State: APjAAAVO9WgvmkBoN5J/AwwfL7cqwXXzdjLFhFMMOR1DnSHK9tvWHtV+
        lLEDSQJ8D/XgLTklnDGkSno=
X-Google-Smtp-Source: APXvYqzIWphO6hNB3iHZCUpTva9x+9PGLfejDR/HfxAyOYjmb63Vr4OQUT0ljUFddgB07pk0mKOvjQ==
X-Received: by 2002:a63:121b:: with SMTP id h27mr7054426pgl.335.1566626564336;
        Fri, 23 Aug 2019 23:02:44 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:43 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 2/9] x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
Date:   Fri, 23 Aug 2019 15:41:46 -0700
Message-Id: <20190823224153.15223-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unification of these two functions allows to use them in the updated
SMP infrastrucutre.

To do so, remove the reason argument from flush_tlb_func_local(), add
a member to struct tlb_flush_info that says which CPU initiated the
flush and act accordingly. Optimize the size of flush_tlb_info while we
are at it.

Unfortunately, this prevents us from using a constant tlb_flush_info for
arch_tlbbatch_flush(), but in a later stage we will inline
tlb_flush_info into the IPI data, so it should not have an impact
eventually.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h |  5 +-
 arch/x86/mm/tlb.c               | 85 +++++++++++++++------------------
 2 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d841262d..2f6e9be163ae 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -559,8 +559,9 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
-	unsigned int		stride_shift;
-	bool			freed_tables;
+	unsigned int		initiating_cpu;
+	u8			stride_shift;
+	u8			freed_tables;
 };
 
 #define local_flush_tlb() __flush_tlb()
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e6a9edc5baaf..2674f55ed9a1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -292,7 +292,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
-	/* We don't want flush_tlb_func_* to run concurrently with us. */
+	/* We don't want flush_tlb_func() to run concurrently with us. */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
@@ -512,14 +512,13 @@ void initialize_tlbstate_and_flush(void)
 }
 
 /*
- * flush_tlb_func_common()'s memory ordering requirement is that any
+ * flush_tlb_func()'s memory ordering requirement is that any
  * TLB fills that happen after we flush the TLB are ordered after we
  * read active_mm's tlb_gen.  We don't need any explicit barriers
  * because all x86 flush operations are serializing and the
  * atomic64_read operation won't be reordered by the compiler.
  */
-static void flush_tlb_func_common(const struct flush_tlb_info *f,
-				  bool local, enum tlb_flush_reason reason)
+static void flush_tlb_func(void *info)
 {
 	/*
 	 * We have three different tlb_gen values in here.  They are:
@@ -530,14 +529,26 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 * - f->new_tlb_gen: the generation that the requester of the flush
 	 *                   wants us to catch up to.
 	 */
+	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
 	u64 mm_tlb_gen = atomic64_read(&loaded_mm->context.tlb_gen);
 	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	bool local = smp_processor_id() == f->initiating_cpu;
+	unsigned long nr_invalidate = 0;
 
 	/* This code cannot presently handle being reentered. */
 	VM_WARN_ON(!irqs_disabled());
 
+	if (!local) {
+		inc_irq_stat(irq_tlb_count);
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+
+		/* Can only happen on remote CPUs */
+		if (f->mm && f->mm != loaded_mm)
+			return;
+	}
+
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
@@ -565,8 +576,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 * be handled can catch us all the way up, leaving no work for
 		 * the second flush.
 		 */
-		trace_tlb_flush(reason, 0);
-		return;
+		goto done;
 	}
 
 	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
@@ -613,46 +623,34 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	    f->new_tlb_gen == local_tlb_gen + 1 &&
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
-		unsigned long nr_invalidate = (f->end - f->start) >> f->stride_shift;
 		unsigned long addr = f->start;
 
+		nr_invalidate = (f->end - f->start) >> f->stride_shift;
+
 		while (addr < f->end) {
 			__flush_tlb_one_user(addr);
 			addr += 1UL << f->stride_shift;
 		}
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_invalidate);
-		trace_tlb_flush(reason, nr_invalidate);
 	} else {
 		/* Full flush. */
+		nr_invalidate = TLB_FLUSH_ALL;
+
 		local_flush_tlb();
 		if (local)
 			count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-		trace_tlb_flush(reason, TLB_FLUSH_ALL);
 	}
 
 	/* Both paths above update our state to mm_tlb_gen. */
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
-}
-
-static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
-{
-	const struct flush_tlb_info *f = info;
-
-	flush_tlb_func_common(f, true, reason);
-}
 
-static void flush_tlb_func_remote(void *info)
-{
-	const struct flush_tlb_info *f = info;
-
-	inc_irq_stat(irq_tlb_count);
-
-	if (f->mm && f->mm != this_cpu_read(cpu_tlbstate.loaded_mm))
-		return;
-
-	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
+	/* Tracing is done in a unified manner to reduce the code size */
+done:
+	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
+				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
+						  TLB_LOCAL_MM_SHOOTDOWN,
+			nr_invalidate);
 }
 
 static bool tlb_is_not_lazy(int cpu, void *data)
@@ -678,7 +676,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * optimized to use its own mechanism.  These days, x86 uses
 		 * smp_call_function_many(), but UV still uses a manual IPI,
 		 * and that IPI's action is out of date -- it does a manual
-		 * flush instead of calling flush_tlb_func_remote().  This
+		 * flush instead of calling flush_tlb_func().  This
 		 * means that the percpu tlb_gen variables won't be updated
 		 * and we'll do pointless flushes on future context switches.
 		 *
@@ -688,7 +686,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 */
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
-			smp_call_function_many(cpumask, flush_tlb_func_remote,
+			smp_call_function_many(cpumask, flush_tlb_func,
 					       (void *)info, 1);
 		return;
 	}
@@ -704,10 +702,10 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables)
-		smp_call_function_many(cpumask, flush_tlb_func_remote,
+		smp_call_function_many(cpumask, flush_tlb_func,
 			       (void *)info, 1);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func_remote,
+		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
 				(void *)info, 1, GFP_ATOMIC, cpumask);
 }
 
@@ -751,6 +749,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->stride_shift	= stride_shift;
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
+	info->initiating_cpu	= smp_processor_id();
 
 	return info;
 }
@@ -790,7 +789,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
@@ -843,34 +842,26 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	}
 }
 
-/*
- * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
- * This means that the 'struct flush_tlb_info' that describes which mappings to
- * flush is actually fixed. We therefore set a single fixed struct and use it in
- * arch_tlbbatch_flush().
- */
-static const struct flush_tlb_info full_flush_tlb_info = {
-	.mm = NULL,
-	.start = 0,
-	.end = TLB_FLUSH_ALL,
-};
-
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
+	struct flush_tlb_info *info;
 	int cpu = get_cpu();
 
+	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
+
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
+		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
+		flush_tlb_others(&batch->cpumask, info);
 
 	cpumask_clear(&batch->cpumask);
 
+	put_flush_tlb_info();
 	put_cpu();
 }
 
-- 
2.17.1

