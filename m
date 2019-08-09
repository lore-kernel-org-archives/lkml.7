Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B87C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C60217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiJ2ZmQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405213AbfHIDyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:54:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43011 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:54:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id r26so9205481pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :in-reply-to:references;
        bh=COoB7J/M4S1HF6JlK+1a14lZwUTZv7OB+klQ0WU4WM0=;
        b=FiJ2ZmQaKARYkRQtMHszy7pd6hKeD/YFTHcpYIBQiYiGwFKwEQSMq81WjUZNAel33c
         mZHJINOrOYq8W7QzQMOX4jaIfyxBch2Ypn4dumQzEcGLSh8mB2EJyOLEXGRxS0h8pBP+
         vs5KLwQTviBFsgICnmTiLV5v9vg2yEBW6nYOVGVzLKtASROGwgN13IEC4RupvCe7I8s8
         whtfWryUJr/exy4IYCISzKU/sI89ryceHkF/af1SgSmOuqv7vbpValcFfA/vvWTmE9CC
         TBCnviGsx/hkbbg5BROxo5s0aXsRGxyoY9CJdILlV7x5KQe+T6hdwph9r9nA5RQnsHB2
         9zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:in-reply-to:references;
        bh=COoB7J/M4S1HF6JlK+1a14lZwUTZv7OB+klQ0WU4WM0=;
        b=RiABGj930S6/HiFZ9871TWBD+h7yWcWZR7TMG5j5an4xKABOwDu0bEfMXM6xh4VFul
         sryIEMRqPguE+ciLeEIYQlAhZxhHaq9bCd+w3E0CSDwua84S2CHxd53oUk+zsqnEGFKy
         +gtr5JljzQ5HNjemWLHfk6C8q/jW3M3CJ5fQFTE5ljDIgASrjbR5HTzU78jc3orYY7zQ
         Im+4eoBNQbqs9LDRPr6zaVlGMx62+V4r4R/VQIqEcthgXpWG838Y/AC0gqb3MttGDPRc
         5/DK5Au+w4/AbcvX4ZoEpwWA+werWekx83HU7VUUk2XiwkIt3PRwnaLUiVVi0szakPdi
         WkSA==
X-Gm-Message-State: APjAAAV8E/3SheEgwURHw6l1kdqvq4c/CG0XZF3pRrJe03sMtYQS/xYi
        caxuUZI0Af7mwwyCxd305G4k4P0p
X-Google-Smtp-Source: APXvYqzglb40Ftl5Blo0VvJTyO9lo7/f2q7FG5J1Fpe2JafJ4O2n2SmxsBhE3VSSq0HPDQ0yTFLbJA==
X-Received: by 2002:a63:e807:: with SMTP id s7mr15184975pgh.194.1565322875864;
        Thu, 08 Aug 2019 20:54:35 -0700 (PDT)
Received: from localhost (c-73-189-176-234.hsd1.ca.comcast.net. [73.189.176.234])
        by smtp.gmail.com with ESMTPSA id o14sm189361560pfh.153.2019.08.08.20.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 20:54:35 -0700 (PDT)
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     toshi.kani@hpe.com, fei1.li@intel.com,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Subject: [PATCH 2/3] x86/mtrr: split common funcs from generic.c
Date:   Thu,  8 Aug 2019 20:54:19 -0700
Message-Id: <42a1c726ace6292cf79891d64567bb86137ce8e1.1565300606.git.isaku.yamahata@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565300606.git.isaku.yamahata@gmail.com>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
Reply-To: isaku.yamahata@gmail.com
In-Reply-To: <cover.1565300606.git.isaku.yamahata@gmail.com>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for make PAT(Page Attribute Table) independent
from MTRR(Memory Type Range Register).
It renames prefix of common functions in mtrr/generic.c from mtrr_ to
mtrr_pat_ which are commonly used by both MTRR and PAT and moves out
them from mtrr/generic.c to rendezvous.c.
Only prefix rename and movement, no logic change.

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/include/asm/mtrr.h           |   4 +
 arch/x86/kernel/cpu/mtrr/generic.c    | 111 ++------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.c       |   2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.h       |   3 +-
 arch/x86/kernel/cpu/mtrr/rendezvous.c |  91 +++++++++++++++++++++
 5 files changed, 106 insertions(+), 105 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index d90e87c55302..5b056374f5a6 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -33,6 +33,8 @@
  */
 # ifdef CONFIG_MTRR
 extern bool mtrr_enabled(void);
+extern void mtrr_pat_prepare_set(void) __acquires(set_atomicity_lock);
+extern void mtrr_pat_post_set(void) __releases(set_atomicity_lock);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -55,6 +57,8 @@ static inline bool mtrr_enabled(void)
 {
 	return false;
 }
+static inline void mtrr_pat_prepare_set(void) { };
+static inline void mtrr_pat_post_set(void) { };
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index aa5c064a6a22..a44f05f64846 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -397,9 +397,6 @@ print_fixed(unsigned base, unsigned step, const mtrr_type *types)
 	}
 }
 
-static void prepare_set(void);
-static void post_set(void);
-
 static void __init print_mtrr_state(void)
 {
 	unsigned int i;
@@ -445,20 +442,6 @@ static void __init print_mtrr_state(void)
 		pr_debug("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
 }
 
-/* PAT setup for BP. We need to go through sync steps here */
-void __init mtrr_bp_pat_init(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	prepare_set();
-
-	pat_init();
-
-	post_set();
-	local_irq_restore(flags);
-}
-
 /* Grab all of the MTRR state for this CPU into *state */
 bool __init get_mtrr_state(void)
 {
@@ -680,8 +663,6 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	return changed;
 }
 
-static u32 deftype_lo, deftype_hi;
-
 /**
  * set_mtrr_state - Set the MTRR state for this CPU.
  *
@@ -705,100 +686,24 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) != mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
+	if ((mtrr_deftype_lo & 0xff) != mtrr_state.def_type
+	    || ((mtrr_deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
 
-		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+		mtrr_deftype_lo = (mtrr_deftype_lo & ~0xcff) |
+			mtrr_state.def_type | (mtrr_state.enabled << 10);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
 	return change_mask;
 }
 
-
-static unsigned long cr4;
-static DEFINE_RAW_SPINLOCK(set_atomicity_lock);
-
-/*
- * Since we are disabling the cache don't allow any interrupts,
- * they would run extremely slow and would only increase the pain.
- *
- * The caller must ensure that local interrupts are disabled and
- * are reenabled after post_set() has been called.
- */
-static void prepare_set(void) __acquires(set_atomicity_lock)
-{
-	unsigned long cr0;
-
-	/*
-	 * Note that this is not ideal
-	 * since the cache is only flushed/disabled for this CPU while the
-	 * MTRRs are changed, but changing this requires more invasive
-	 * changes to the way the kernel boots
-	 */
-
-	raw_spin_lock(&set_atomicity_lock);
-
-	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
-	cr0 = read_cr0() | X86_CR0_CD;
-	write_cr0(cr0);
-
-	/*
-	 * Cache flushing is the most time-consuming step when programming
-	 * the MTRRs. Fortunately, as per the Intel Software Development
-	 * Manual, we can skip it if the processor supports cache self-
-	 * snooping.
-	 */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
-
-	/* Save value of CR4 and clear Page Global Enable (bit 7) */
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		cr4 = __read_cr4();
-		__write_cr4(cr4 & ~X86_CR4_PGE);
-	}
-
-	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb();
-
-	/* Save MTRR state */
-	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
-
-	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
-
-	/* Again, only flush caches if we have to. */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
-}
-
-static void post_set(void) __releases(set_atomicity_lock)
-{
-	/* Flush TLBs (no need to flush caches - they are disabled) */
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	__flush_tlb();
-
-	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
-
-	/* Enable caches */
-	write_cr0(read_cr0() & ~X86_CR0_CD);
-
-	/* Restore value of CR4 */
-	if (boot_cpu_has(X86_FEATURE_PGE))
-		__write_cr4(cr4);
-	raw_spin_unlock(&set_atomicity_lock);
-}
-
 static void generic_set_all(void)
 {
 	unsigned long mask, count;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	prepare_set();
+	mtrr_pat_prepare_set();
 
 	/* Actually set the state */
 	mask = set_mtrr_state();
@@ -806,7 +711,7 @@ static void generic_set_all(void)
 	/* also set PAT */
 	pat_init();
 
-	post_set();
+	mtrr_pat_post_set();
 	local_irq_restore(flags);
 
 	/* Use the atomic bitops to update the global mask */
@@ -837,7 +742,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 	vr = &mtrr_state.var_ranges[reg];
 
 	local_irq_save(flags);
-	prepare_set();
+	mtrr_pat_prepare_set();
 
 	if (size == 0) {
 		/*
@@ -856,7 +761,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
 	}
 
-	post_set();
+	mtrr_pat_post_set();
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 3d35edb1aa42..475627ca2c1b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -646,7 +646,7 @@ void __init mtrr_pat_bp_init(void)
 			__mtrr_enabled = get_mtrr_state();
 
 			if (mtrr_enabled())
-				mtrr_bp_pat_init();
+				pat_bp_init();
 
 			if (mtrr_cleanup(phys_addr)) {
 				changed_by_mtrr_cleanup = 1;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index e9aeeeac9a3e..57948b651b8e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -53,7 +53,7 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
-void mtrr_bp_pat_init(void);
+void pat_bp_init(void);
 
 extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
 
@@ -76,6 +76,7 @@ void set_mtrr_pat(unsigned int reg, unsigned long base,
 		  unsigned long size, mtrr_type type);
 void set_mtrr_pat_cpuslocked(unsigned int reg, unsigned long base,
 			     unsigned long size, mtrr_type type);
+extern u32 mtrr_deftype_lo, mtrr_deftype_hi;
 
 /* CPU specific mtrr init functions */
 int amd_init_mtrr(void);
diff --git a/arch/x86/kernel/cpu/mtrr/rendezvous.c b/arch/x86/kernel/cpu/mtrr/rendezvous.c
index 5448eea573df..d902b9e5cc17 100644
--- a/arch/x86/kernel/cpu/mtrr/rendezvous.c
+++ b/arch/x86/kernel/cpu/mtrr/rendezvous.c
@@ -33,14 +33,105 @@
 #define DEBUG
 
 #include <linux/stop_machine.h>
+#include <linux/vmstat.h>
 
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 #include <asm/pat.h>
+#include <asm/tlbflush.h>
 
 #include "mtrr.h"
 
 static bool mtrr_pat_aps_delayed_init;
+u32 mtrr_deftype_lo, mtrr_deftype_hi;
+static unsigned long cr4;
+static DEFINE_RAW_SPINLOCK(set_atomicity_lock);
+
+/* PAT setup for BP. We need to go through sync steps here */
+void __init pat_bp_init(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	mtrr_pat_prepare_set();
+
+	pat_init();
+
+	mtrr_pat_post_set();
+	local_irq_restore(flags);
+}
+
+/*
+ * Since we are disabling the cache don't allow any interrupts,
+ * they would run extremely slow and would only increase the pain.
+ *
+ * The caller must ensure that local interrupts are disabled and
+ * are reenabled after mtrr_pat_post_set() has been called.
+ */
+void mtrr_pat_prepare_set(void) __acquires(set_atomicity_lock)
+{
+	unsigned long cr0;
+
+	/*
+	 * Note that this is not ideal
+	 * since the cache is only flushed/disabled for this CPU while the
+	 * MTRRs are changed, but changing this requires more invasive
+	 * changes to the way the kernel boots
+	 */
+
+	raw_spin_lock(&set_atomicity_lock);
+
+	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
+	cr0 = read_cr0() | X86_CR0_CD;
+	write_cr0(cr0);
+
+	/*
+	 * Cache flushing is the most time-consuming step when programming
+	 * the MTRRs. Fortunately, as per the Intel Software Development
+	 * Manual, we can skip it if the processor supports cache self-
+	 * snooping.
+	 */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+
+	/* Save value of CR4 and clear Page Global Enable (bit 7) */
+	if (boot_cpu_has(X86_FEATURE_PGE)) {
+		cr4 = __read_cr4();
+		__write_cr4(cr4 & ~X86_CR4_PGE);
+	}
+
+	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
+	__flush_tlb();
+
+	/* Save MTRR state */
+	rdmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
+
+	/* Disable MTRRs, and set the default type to uncached */
+	mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo & ~0xcff, mtrr_deftype_hi);
+
+	/* Again, only flush caches if we have to. */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+}
+
+void mtrr_pat_post_set(void) __releases(set_atomicity_lock)
+{
+	/* Flush TLBs (no need to flush caches - they are disabled) */
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
+	__flush_tlb();
+
+	/* Intel (P6) standard MTRRs */
+	mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
+
+	/* Enable caches */
+	write_cr0(read_cr0() & ~X86_CR0_CD);
+
+	/* Restore value of CR4 */
+	if (boot_cpu_has(X86_FEATURE_PGE))
+		__write_cr4(cr4);
+	raw_spin_unlock(&set_atomicity_lock);
+}
 
 struct set_mtrr_data {
 	unsigned long	smp_base;
-- 
2.17.1

