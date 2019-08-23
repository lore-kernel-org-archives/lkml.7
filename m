Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BFC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635B221670
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfHXGN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:13:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35992 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHXGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:13:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so6891329plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=INVtJHgm0b2/J/2q5zY54fqZ7ZxoyrSsmyIhQis+AsE=;
        b=rSFfnKJ0O0yhuTyTg7joglWpL+kKQZxU68bpXs3v5CpKUaejGmXpWE3mxp68xZRUS9
         J1pz7Um3D4XVgJgegoJ72C2NhlavxWoGBMhax3eIY3z2MrNPlG+Lj0LdKB9Z9i64gF1E
         cLtSXsW+mdC/m1ob/IT+Wp5k2drbKccNl91YEOftG4xN7U7slUPHdwxWHuM4x+4DmYa1
         ritEZnK4beFS44cFYWH0Gx2j952ajbN+PNE6YdaP4YzlResD22466wMbagiPJiNGVHuP
         eWqTKFnDblqlJucVh/o1r0YUoCJQCB8jUinJNAVz6tMbd4xw/PiAVtehTohHi9cgc4rW
         sqWA==
X-Gm-Message-State: APjAAAWpbHsmRSfZLCp4+ZZc7Ky8IXwAqm+YNZ4+nihnxvDmLTWJzSh+
        ddY5dixsTULkOryrseKi48M=
X-Google-Smtp-Source: APXvYqytAgy02S76SH8accLSf7pTZnLDb+ENFHy9Yggx8T6t29mNQNPLuwfRP/1hMekGtarTgvgKRw==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr8683551plr.343.1566627202825;
        Fri, 23 Aug 2019 23:13:22 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o9sm3691360pgv.19.2019.08.23.23.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:13:22 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [RFC PATCH v2 1/3] x86/mm/tlb: Change __flush_tlb_one_user interface
Date:   Fri, 23 Aug 2019 15:52:46 -0700
Message-Id: <20190823225248.15597-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823225248.15597-1-namit@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_tlb_one_user() currently flushes a single entry, and flushes it
both in the kernel and user page-tables, when PTI is enabled.

Change __flush_tlb_one_user() and related interfaces into
__flush_tlb_range() that flushes a range and does not flush the user
page-table.

This refactoring is needed for the next patch, but regardless makes
sense and has several advantages. First, only Xen-PV, which does not
use PTI, implements the paravirtual interface of flush_tlb_one_user() so
nothing is broken by separating the user and kernel page-table flushes,
and the interface is more intuitive.

Second, INVLPG can flush unrelated mappings, and it is also a
serializing instruction. It is better to have a tight loop that flushes
the entries.

Third, currently __flush_tlb_one_kernel() also flushes the user
page-tables, which is not needed. This allows to avoid this redundant
flush.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/paravirt.h       |  5 ++--
 arch/x86/include/asm/paravirt_types.h |  3 ++-
 arch/x86/include/asm/tlbflush.h       | 24 +++++------------
 arch/x86/kernel/paravirt.c            |  7 ++---
 arch/x86/mm/tlb.c                     | 39 ++++++++++++++++++++++-----
 arch/x86/xen/mmu_pv.c                 | 21 +++++++++------
 6 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bc4829c9b3f9..7347328eacd3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -57,9 +57,10 @@ static inline void __flush_tlb_global(void)
 	PVOP_VCALL0(mmu.flush_tlb_kernel);
 }
 
-static inline void __flush_tlb_one_user(unsigned long addr)
+static inline void __flush_tlb_range(unsigned long start, unsigned long end,
+				     u8 stride_shift)
 {
-	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
+	PVOP_VCALL3(mmu.flush_tlb_range, start, end, stride_shift);
 }
 
 static inline void flush_tlb_multi(const struct cpumask *cpumask,
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 63fa751344bf..a87a5f236251 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -205,7 +205,8 @@ struct pv_mmu_ops {
 	/* TLB operations */
 	void (*flush_tlb_user)(void);
 	void (*flush_tlb_kernel)(void);
-	void (*flush_tlb_one_user)(unsigned long addr);
+	void (*flush_tlb_range)(unsigned long start, unsigned long end,
+				u8 stride_shift);
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1f88ea410ff3..421bc82504e2 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -145,7 +145,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 #else
 #define __flush_tlb() __native_flush_tlb()
 #define __flush_tlb_global() __native_flush_tlb_global()
-#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
+#define __flush_tlb_range(start, end, stride_shift) __native_flush_tlb_range(start, end, stride_shift)
 #endif
 
 struct tlb_context {
@@ -454,23 +454,13 @@ static inline void __native_flush_tlb_global(void)
 /*
  * flush one page in the user mapping
  */
-static inline void __native_flush_tlb_one_user(unsigned long addr)
+static inline void __native_flush_tlb_range(unsigned long start,
+				unsigned long end, u8 stride_shift)
 {
-	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	unsigned long addr;
 
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	/*
-	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
-	 * Just use invalidate_user_asid() in case we are called early.
-	 */
-	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE))
-		invalidate_user_asid(loaded_mm_asid);
-	else
-		invpcid_flush_one(user_pcid(loaded_mm_asid), addr);
+	for (addr = start; addr < end; addr += 1ul << stride_shift)
+		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
 
 /*
@@ -512,7 +502,7 @@ static inline void __flush_tlb_one_kernel(unsigned long addr)
 	 * kernel address space and for its usermode counterpart, but it does
 	 * not flush it for other address spaces.
 	 */
-	__flush_tlb_one_user(addr);
+	__flush_tlb_range(addr, addr + PAGE_SIZE, PAGE_SHIFT);
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5520a04c84ba..195f5577d0d5 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -173,9 +173,10 @@ static void native_flush_tlb_global(void)
 	__native_flush_tlb_global();
 }
 
-static void native_flush_tlb_one_user(unsigned long addr)
+static void native_flush_tlb_range(unsigned long start, unsigned long end,
+				   u8 stride_shift)
 {
-	__native_flush_tlb_one_user(addr);
+	__native_flush_tlb_range(start, end, stride_shift);
 }
 
 struct static_key paravirt_steal_enabled;
@@ -358,7 +359,7 @@ struct paravirt_patch_template pv_ops = {
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb,
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
-	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
+	.mmu.flush_tlb_range	= native_flush_tlb_range,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
 	.mmu.tlb_remove_table	=
 			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0addc6e84126..ad15fc2c0790 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -512,6 +512,35 @@ void initialize_tlbstate_and_flush(void)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
 }
 
+static void flush_tlb_user_pt_range(u16 asid, const struct flush_tlb_info *f)
+{
+	unsigned long start, end, addr;
+	u8 stride_shift;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/*
+	 * Read the data into variable on the stack to prevent it from being
+	 * reevaluated due to invpcid memory clobber.
+	 */
+	start = f->start;
+	end = f->end;
+	stride_shift = f->stride_shift;
+
+	/*
+	 * Some platforms #GP if we call invpcid(type=1/2) before CR4.PCIDE=1.
+	 * Just use invalidate_user_asid() in case we are called early.
+	 */
+	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)) {
+		invalidate_user_asid(asid);
+		return;
+	}
+
+	for (addr = start; addr < end; addr += 1ul << stride_shift)
+		invpcid_flush_one(user_pcid(asid), addr);
+}
+
 /*
  * flush_tlb_func()'s memory ordering requirement is that any
  * TLB fills that happen after we flush the TLB are ordered after we
@@ -624,14 +653,12 @@ static void flush_tlb_func(void *info)
 	    f->new_tlb_gen == local_tlb_gen + 1 &&
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
-		unsigned long addr = f->start;
-
 		nr_invalidate = (f->end - f->start) >> f->stride_shift;
 
-		while (addr < f->end) {
-			__flush_tlb_one_user(addr);
-			addr += 1UL << f->stride_shift;
-		}
+		__flush_tlb_range(f->start, f->end, f->stride_shift);
+
+		flush_tlb_user_pt_range(loaded_mm_asid, f);
+
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_invalidate);
 	} else {
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 48f7c7eb4dbc..ed68657f5e77 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1325,22 +1325,27 @@ static noinline void xen_flush_tlb(void)
 	preempt_enable();
 }
 
-static void xen_flush_tlb_one_user(unsigned long addr)
+static void xen_flush_tlb_range(unsigned long start, unsigned long end,
+				u8 stride_shift)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
-
-	trace_xen_mmu_flush_tlb_one_user(addr);
+	unsigned long addr;
 
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
 	op = mcs.args;
-	op->cmd = MMUEXT_INVLPG_LOCAL;
-	op->arg1.linear_addr = addr & PAGE_MASK;
-	MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
 
-	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	for (addr = start; addr < end; addr += 1ul << stride_shift) {
+		trace_xen_mmu_flush_tlb_one_user(addr);
+
+		op->cmd = MMUEXT_INVLPG_LOCAL;
+		op->arg1.linear_addr = addr & PAGE_MASK;
+		MULTI_mmuext_op(mcs.mc, op, 1, NULL, DOMID_SELF);
+
+		xen_mc_issue(PARAVIRT_LAZY_MMU);
+	}
 
 	preempt_enable();
 }
@@ -2394,7 +2399,7 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
-	.flush_tlb_one_user = xen_flush_tlb_one_user,
+	.flush_tlb_range = xen_flush_tlb_range,
 	.flush_tlb_multi = xen_flush_tlb_multi,
 	.tlb_remove_table = tlb_remove_table,
 
-- 
2.17.1

