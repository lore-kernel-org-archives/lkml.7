Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18452C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C85218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGCHON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46397 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGCHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so750568pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PLR7V1nQaJKH4h1UrM4nqWdTUtPefxm+ptZQgy80FHA=;
        b=Xulah/i37npJ/0Tqw/xfJvkUJH09wlWJFQBF0eh9YkzJbks7wDWbg/CArSxASduwYc
         dgIcuK30SLqSpYZ5jVpgBywc6XjmEUFTwq6Zywp2uuLatG5vlTr4ij4VuN7E3vK5uKvh
         O0mNAzeT5jrULrFeG9FHl4sIDJNPaCuG8gcYTHBgTNmlwZ0SuS/J+jprBRlfNBmclPm9
         R3+IARQRdxqDMJq+5AxXPP1pLjN0HcqJS0CMXMl8PLMtsrbjlWyXVFc4WsyGNhfK0igA
         pjK2ix9n3oMK4UraXWo+1LU7iBDBNAIKEJ2K8FrZlQO90NVEvJVKq3ZF0BTsHH+MotbN
         PPhA==
X-Gm-Message-State: APjAAAWtdjH7BscrUx93WU5rdN6HpgSKKyUQhTZamLHwSBEYJk4V5S2S
        0ARwYbbd6xTOYGgWXdwy/VU=
X-Google-Smtp-Source: APXvYqw6DIpZX8vVOMMlPbwdsgCyZL3bSbPnlJ6S2xqo+gzcMZCEqksXja9HFiWOdvU3K/Mq84bilg==
X-Received: by 2002:a17:90a:37e9:: with SMTP id v96mr10662312pjb.10.1562138049737;
        Wed, 03 Jul 2019 00:14:09 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Date:   Tue,  2 Jul 2019 16:51:47 -0700
Message-Id: <20190702235151.4377-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tlbstate is mostly private and only the variable is_lazy is shared.
This causes some false-sharing when TLB flushes are performed.

Break cpu_tlbstate intro cpu_tlbstate and cpu_tlbstate_shared, and mark
each one accordingly.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h | 39 ++++++++++++++++++---------------
 arch/x86/mm/init.c              |  2 +-
 arch/x86/mm/tlb.c               | 15 ++++++++-----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 36aa2a9b7597..3a242fb355de 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -178,23 +178,6 @@ struct tlb_state {
 	u16 loaded_mm_asid;
 	u16 next_asid;
 
-	/*
-	 * We can be in one of several states:
-	 *
-	 *  - Actively using an mm.  Our CPU's bit will be set in
-	 *    mm_cpumask(loaded_mm) and is_lazy == false;
-	 *
-	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
-	 *
-	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
-	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
-	 *    We're heuristically guessing that the CR3 load we
-	 *    skipped more than makes up for the overhead added by
-	 *    lazy mode.
-	 */
-	bool is_lazy;
-
 	/*
 	 * If set we changed the page tables in such a way that we
 	 * needed an invalidation of all contexts (aka. PCIDs / ASIDs).
@@ -240,7 +223,27 @@ struct tlb_state {
 	 */
 	struct tlb_context ctxs[TLB_NR_DYN_ASIDS];
 };
-DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
+DECLARE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate);
+
+struct tlb_state_shared {
+	/*
+	 * We can be in one of several states:
+	 *
+	 *  - Actively using an mm.  Our CPU's bit will be set in
+	 *    mm_cpumask(loaded_mm) and is_lazy == false;
+	 *
+	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
+	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *
+	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
+	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
+	 *    We're heuristically guessing that the CR3 load we
+	 *    skipped more than makes up for the overhead added by
+	 *    lazy mode.
+	 */
+	bool is_lazy;
+};
+DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 
 /*
  * Blindly accessing user memory from NMI context can be dangerous
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index fd10d91a6115..34027f36a944 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -951,7 +951,7 @@ void __init zone_sizes_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
-__visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) = {
+__visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.loaded_mm = &init_mm,
 	.next_asid = 1,
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 074288a6916e..9bd24aecbd58 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -145,7 +145,7 @@ void leave_mm(int cpu)
 		return;
 
 	/* Warn if we're not lazy. */
-	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
+	WARN_ON(!this_cpu_read(cpu_tlbstate_shared.is_lazy));
 
 	switch_mm(NULL, &init_mm, NULL);
 }
@@ -277,7 +277,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
+	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
 	bool need_flush;
@@ -322,7 +322,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.is_lazy, false);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
@@ -463,7 +463,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
-	this_cpu_write(cpu_tlbstate.is_lazy, true);
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
 }
 
 /*
@@ -544,7 +544,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy)) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -665,11 +665,14 @@ static void flush_tlb_func_remote(void *info)
 
 static bool tlb_is_not_lazy(int cpu)
 {
-	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
+	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
 }
 
 static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
 
+DEFINE_PER_CPU_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
+EXPORT_PER_CPU_SYMBOL(cpu_tlbstate_shared);
+
 void native_flush_tlb_multi(const struct cpumask *cpumask,
 			    const struct flush_tlb_info *info)
 {
-- 
2.17.1

