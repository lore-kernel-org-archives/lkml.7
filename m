Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256F2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05081233A0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfHXGCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:02:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfHXGCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so7667840pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oCd/OvNgjN1eLcHsD8e48owdFKLZIu6izSzqsYhIrYo=;
        b=kLRI0GoDeDqcZGlSaWWHO7hR04QWxkcqMwVTeRq/8T6+q0tK6ghHKBCQQT1+E9HMC4
         goXv/SS8D2P0kXdJjslP24rIPxiKWp+v0bLnB/YMyi/Mh5jC9YWi78S6SnnJTYG2UCt8
         XRT4lCGsQHBbh9uhHlm6hFKsFDMpX9hl16kSBeBVXeYbugA80NJwPkwv3LeAWvw7Y5qi
         djDmlO6iP0EyHsts1X3GN/dE6I+yy8pEAo/4dgCF2p8TLK4LBbPlA1lh4/uZ1gmRnead
         FN05IlbEAP1pniaCVl4Eh1KifsrwkVhjImQNTnAYKe5Dcrkt29QI5szszmcKC/CSButL
         BI4g==
X-Gm-Message-State: APjAAAVUbgOxSL9K6PkctA8yr5d7VeMvzFJ6WaFNLcKC1impv/q0eT0Z
        wKPCrXaUaLPLP0KqX29Bss0=
X-Google-Smtp-Source: APXvYqxgHWibWpCv9DU9593FwklEMZ/faA9X/VUVWe3TMQ1vbVwc5dfunNI4PBxMZzfSFjylnMjIug==
X-Received: by 2002:a63:6d6:: with SMTP id 205mr7241396pgg.262.1566626570606;
        Fri, 23 Aug 2019 23:02:50 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:49 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 5/9] x86/mm/tlb: Privatize cpu_tlbstate
Date:   Fri, 23 Aug 2019 15:41:49 -0700
Message-Id: <20190823224153.15223-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tlbstate is mostly private and only the variable is_lazy is shared.
This causes some false-sharing when TLB flushes are performed.

Break cpu_tlbstate intro cpu_tlbstate and cpu_tlbstate_shared, and mark
each one accordingly.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h | 39 ++++++++++++++++++---------------
 arch/x86/mm/init.c              |  2 +-
 arch/x86/mm/tlb.c               | 15 ++++++++-----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 559195f79c2f..1f88ea410ff3 100644
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
index 5376a5447bd0..24c9839e3d9b 100644
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
@@ -555,7 +555,7 @@ static void flush_tlb_func(void *info)
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (this_cpu_read(cpu_tlbstate_shared.is_lazy)) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -655,11 +655,14 @@ static void flush_tlb_func(void *info)
 
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

