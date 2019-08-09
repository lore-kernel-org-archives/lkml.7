Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D20C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1846F2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN+XPr63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405149AbfHIDyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:54:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44945 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:54:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so45253511pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :in-reply-to:references;
        bh=1aVagfxyN8G8j+kirK6xoGVYw9Fno6o6iFZH2FNHiqc=;
        b=aN+XPr637TIDRDqszzE3R7o1IqujRbYmcS9VeVQgDPYaTX+4gclHuL7uUautVnSNZC
         YlMSvCAZgyHgDXTF3rkDFd5lTWQ7h8aAZ2XUiWKs5nYf1s1nquGV11PNb6h41Wms8QWo
         fxusB3DOKXqyQaCeoTms7w/h31k/x9w+b8o52ZDg2Ft57+8LRG+l+zKRt644JbouLlTc
         q2lJw+7l1JgZ6UrVuMgs7SSZnHUUoUIGatDqbw1Ra+R1kX79oUkHefd1fxg/cAHt5MVA
         po2U6Eb1r0sGSWNMPhpguZouOjOViW9XxkoyMQrgdZ42jW7EB0klLx2YpUUn3kTWbokt
         Pa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:in-reply-to:references;
        bh=1aVagfxyN8G8j+kirK6xoGVYw9Fno6o6iFZH2FNHiqc=;
        b=ZOOol0yUu54CFa+CHoSW/7iybN2UO7Edpko4D3W+y0/ZzMfzQeNHpyxqUaecIkyuCz
         gneahi7J4pTHT/EIftoxp6qDJxz9nQ2i/5dJFVQ+Jgt7xiFgprsl17bPGFPF8ok6DNxJ
         7t+IepXgSFnb4sR2hXcILcRknb+aVdeUhGPxkUVU3u1rN5xhmVSa5X9jBUj+0V/GMpmi
         Juf4FCz66EZQGXyVqIWGP09wkX68ajIEH4Pgw1x3DDalBYo7Rm2xxlMPLa3iyVsPkI9/
         q7mB7jZ1JN17IP4KHmrg7iG5aZq6qU9oTRofvR4kxaW1u/tIdZV26VYuIBVcSYoX3j49
         3zow==
X-Gm-Message-State: APjAAAW0fCJe9PB/RMmAMBa8hb39OKuPMbzhwOcmCk+nvCNcyzc+cTih
        raqIiyaSfGBO3w2fHXuGUV4kXR54
X-Google-Smtp-Source: APXvYqzvceOoObH+gqwg/UiPvP4WhzBwySK+3M0u4UaG924El+N5Twl9BG/exPiI/po8xtgoyX+0YQ==
X-Received: by 2002:a63:40a:: with SMTP id 10mr15933904pge.317.1565322873889;
        Thu, 08 Aug 2019 20:54:33 -0700 (PDT)
Received: from localhost (c-73-189-176-234.hsd1.ca.comcast.net. [73.189.176.234])
        by smtp.gmail.com with ESMTPSA id z13sm98063521pfa.94.2019.08.08.20.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 20:54:33 -0700 (PDT)
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     toshi.kani@hpe.com, fei1.li@intel.com,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Subject: [PATCH 1/3] x86/mtrr: split common funcs from mtrr.c
Date:   Thu,  8 Aug 2019 20:54:18 -0700
Message-Id: <a913f1f3b0117c2d100ae15b994372210e39d44c.1565300606.git.isaku.yamahata@gmail.com>
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
It renames prefix of common functions in mtrr.c from mtrr_ to
mtrr_pat_ which are commonly used by both MTRR and PAT and moves out
them from mtrr.c to rendezvous.c.
Only prefix rename and movement, no logic change.

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/include/asm/mtrr.h           |  25 +--
 arch/x86/kernel/cpu/common.c          |   2 +-
 arch/x86/kernel/cpu/mtrr/Makefile     |   2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c       | 201 ++---------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h       |   6 +
 arch/x86/kernel/cpu/mtrr/rendezvous.c | 221 ++++++++++++++++++++++++++
 arch/x86/kernel/setup.c               |   4 +-
 arch/x86/kernel/smpboot.c             |   8 +-
 arch/x86/power/cpu.c                  |   2 +-
 9 files changed, 260 insertions(+), 211 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mtrr/rendezvous.c

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index dbff1456d215..d90e87c55302 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -32,6 +32,7 @@
  * arch_phys_wc_add and arch_phys_wc_del.
  */
 # ifdef CONFIG_MTRR
+extern bool mtrr_enabled(void);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -42,14 +43,18 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_ap_init(void);
-extern void mtrr_bp_init(void);
-extern void set_mtrr_aps_delayed_init(void);
-extern void mtrr_aps_init(void);
-extern void mtrr_bp_restore(void);
+extern void mtrr_pat_ap_init(void);
+extern void mtrr_pat_bp_init(void);
+extern void set_mtrr_pat_aps_delayed_init(void);
+extern void mtrr_pat_aps_init(void);
+extern void mtrr_pat_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 #  else
+static inline bool mtrr_enabled(void)
+{
+	return false;
+}
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
@@ -84,15 +89,15 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-static inline void mtrr_bp_init(void)
+static inline void mtrr_pat_bp_init(void)
 {
 	pat_disable("MTRRs disabled, skipping PAT initialization too.");
 }
 
-#define mtrr_ap_init() do {} while (0)
-#define set_mtrr_aps_delayed_init() do {} while (0)
-#define mtrr_aps_init() do {} while (0)
-#define mtrr_bp_restore() do {} while (0)
+static inline void mtrr_pat_ap_init(void) { };
+static inline void set_mtrr_pat_aps_delayed_init(void) { };
+static inline void mtrr_pat_aps_init(void) { };
+static inline void mtrr_pat_bp_restore(void) { };
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 11472178e17f..39b7942cb6fc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1550,7 +1550,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	mtrr_ap_init();
+	mtrr_pat_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 }
diff --git a/arch/x86/kernel/cpu/mtrr/Makefile b/arch/x86/kernel/cpu/mtrr/Makefile
index cc4f9f1cb94c..e339d729f349 100644
--- a/arch/x86/kernel/cpu/mtrr/Makefile
+++ b/arch/x86/kernel/cpu/mtrr/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y		:= mtrr.o if.o generic.o cleanup.o
+obj-y		:= mtrr.o if.o generic.o cleanup.o rendezvous.o
 obj-$(CONFIG_X86_32) += amd.o cyrix.o centaur.o
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 507039c20128..3d35edb1aa42 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -35,7 +35,6 @@
 
 #include <linux/types.h> /* FIXME: kvm_para.h needs this */
 
-#include <linux/stop_machine.h>
 #include <linux/kvm_para.h>
 #include <linux/uaccess.h>
 #include <linux/export.h>
@@ -46,10 +45,7 @@
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
-#include <linux/rcupdate.h>
 
-#include <asm/cpufeature.h>
-#include <asm/e820/api.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 #include <asm/pat.h>
@@ -62,7 +58,7 @@
 u32 num_var_ranges;
 static bool __mtrr_enabled;
 
-static bool mtrr_enabled(void)
+bool mtrr_enabled(void)
 {
 	return __mtrr_enabled;
 }
@@ -71,15 +67,11 @@ unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
 u64 size_or_mask, size_and_mask;
-static bool mtrr_aps_delayed_init;
 
 static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
 const struct mtrr_ops *mtrr_if;
 
-static void set_mtrr(unsigned int reg, unsigned long base,
-		     unsigned long size, mtrr_type type);
-
 void __init set_mtrr_ops(const struct mtrr_ops *ops)
 {
 	if (ops->vendor && ops->vendor < X86_VENDOR_NUM)
@@ -144,46 +136,6 @@ static void __init init_table(void)
 		mtrr_usage_table[i] = 1;
 }
 
-struct set_mtrr_data {
-	unsigned long	smp_base;
-	unsigned long	smp_size;
-	unsigned int	smp_reg;
-	mtrr_type	smp_type;
-};
-
-/**
- * mtrr_rendezvous_handler - Work done in the synchronization handler. Executed
- * by all the CPUs.
- * @info: pointer to mtrr configuration data
- *
- * Returns nothing.
- */
-static int mtrr_rendezvous_handler(void *info)
-{
-	struct set_mtrr_data *data = info;
-
-	/*
-	 * We use this same function to initialize the mtrrs during boot,
-	 * resume, runtime cpu online and on an explicit request to set a
-	 * specific MTRR.
-	 *
-	 * During boot or suspend, the state of the boot cpu's mtrrs has been
-	 * saved, and we want to replicate that across all the cpus that come
-	 * online (either at the end of boot or resume or during a runtime cpu
-	 * online). If we're doing that, @reg is set to something special and on
-	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
-	 * started the boot/resume sequence, this might be a duplicate
-	 * set_all()).
-	 */
-	if (data->smp_reg != ~0U) {
-		mtrr_if->set(data->smp_reg, data->smp_base,
-			     data->smp_size, data->smp_type);
-	} else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
-		mtrr_if->set_all();
-	}
-	return 0;
-}
-
 static inline int types_compatible(mtrr_type type1, mtrr_type type2)
 {
 	return type1 == MTRR_TYPE_UNCACHABLE ||
@@ -192,77 +144,6 @@ static inline int types_compatible(mtrr_type type1, mtrr_type type2)
 	       (type1 == MTRR_TYPE_WRBACK && type2 == MTRR_TYPE_WRTHROUGH);
 }
 
-/**
- * set_mtrr - update mtrrs on all processors
- * @reg:	mtrr in question
- * @base:	mtrr base
- * @size:	mtrr size
- * @type:	mtrr type
- *
- * This is kinda tricky, but fortunately, Intel spelled it out for us cleanly:
- *
- * 1. Queue work to do the following on all processors:
- * 2. Disable Interrupts
- * 3. Wait for all procs to do so
- * 4. Enter no-fill cache mode
- * 5. Flush caches
- * 6. Clear PGE bit
- * 7. Flush all TLBs
- * 8. Disable all range registers
- * 9. Update the MTRRs
- * 10. Enable all range registers
- * 11. Flush all TLBs and caches again
- * 12. Enter normal cache mode and reenable caching
- * 13. Set PGE
- * 14. Wait for buddies to catch up
- * 15. Enable interrupts.
- *
- * What does that mean for us? Well, stop_machine() will ensure that
- * the rendezvous handler is started on each CPU. And in lockstep they
- * do the state transition of disabling interrupts, updating MTRR's
- * (the CPU vendors may each do it differently, so we call mtrr_if->set()
- * callback and let them take care of it.) and enabling interrupts.
- *
- * Note that the mechanism is the same for UP systems, too; all the SMP stuff
- * becomes nops.
- */
-static void
-set_mtrr(unsigned int reg, unsigned long base, unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine(mtrr_rendezvous_handler, &data, cpu_online_mask);
-}
-
-static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
-				unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
-}
-
-static void set_mtrr_from_inactive_cpu(unsigned int reg, unsigned long base,
-				      unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine_from_inactive_cpu(mtrr_rendezvous_handler, &data,
-				       cpu_callout_mask);
-}
-
 /**
  * mtrr_add_page - Add a memory type region
  * @base: Physical base address of region in pages (in units of 4 kB!)
@@ -382,7 +263,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	/* Search for an empty MTRR */
 	i = mtrr_if->get_free_region(base, size, replace);
 	if (i >= 0) {
-		set_mtrr_cpuslocked(i, base, size, type);
+		set_mtrr_pat_cpuslocked(i, base, size, type);
 		if (likely(replace < 0)) {
 			mtrr_usage_table[i] = 1;
 		} else {
@@ -390,7 +271,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 			if (increment)
 				mtrr_usage_table[i]++;
 			if (unlikely(replace != i)) {
-				set_mtrr_cpuslocked(replace, 0, 0, 0);
+				set_mtrr_pat_cpuslocked(replace, 0, 0, 0);
 				mtrr_usage_table[replace] = 0;
 			}
 		}
@@ -518,7 +399,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 		goto out;
 	}
 	if (--mtrr_usage_table[reg] < 1)
-		set_mtrr_cpuslocked(reg, 0, 0, 0);
+		set_mtrr_pat_cpuslocked(reg, 0, 0, 0);
 	error = reg;
  out:
 	mutex_unlock(&mtrr_mutex);
@@ -662,9 +543,9 @@ static void mtrr_restore(void)
 
 	for (i = 0; i < num_var_ranges; i++) {
 		if (mtrr_value[i].lsize) {
-			set_mtrr(i, mtrr_value[i].lbase,
-				    mtrr_value[i].lsize,
-				    mtrr_value[i].ltype);
+			set_mtrr_pat(i, mtrr_value[i].lbase,
+					mtrr_value[i].lsize,
+					mtrr_value[i].ltype);
 		}
 	}
 }
@@ -680,13 +561,13 @@ int __initdata changed_by_mtrr_cleanup;
 
 #define SIZE_OR_MASK_BITS(n)  (~((1ULL << ((n) - PAGE_SHIFT)) - 1))
 /**
- * mtrr_bp_init - initialize mtrrs on the boot CPU
+ * mtrr_pat_bp_init - initialize mtrrs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are
  * initialized (i.e. before smp_init()).
  *
  */
-void __init mtrr_bp_init(void)
+void __init mtrr_pat_bp_init(void)
 {
 	u32 phys_addr;
 
@@ -786,32 +667,6 @@ void __init mtrr_bp_init(void)
 	}
 }
 
-void mtrr_ap_init(void)
-{
-	if (!mtrr_enabled())
-		return;
-
-	if (!use_intel() || mtrr_aps_delayed_init)
-		return;
-
-	rcu_cpu_starting(smp_processor_id());
-
-	/*
-	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
-	 * changed, but this routine will be called in cpu boot time,
-	 * holding the lock breaks it.
-	 *
-	 * This routine is called in two cases:
-	 *
-	 *   1. very earily time of software resume, when there absolutely
-	 *      isn't mtrr entry changes;
-	 *
-	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
-	 *      lock to prevent mtrr entry changes
-	 */
-	set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
-}
-
 /**
  * Save current fixed-range MTRR state of the first cpu in cpu_online_mask.
  */
@@ -826,44 +681,6 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-void set_mtrr_aps_delayed_init(void)
-{
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
-		return;
-
-	mtrr_aps_delayed_init = true;
-}
-
-/*
- * Delayed MTRR initialization for all AP's
- */
-void mtrr_aps_init(void)
-{
-	if (!use_intel() || !mtrr_enabled())
-		return;
-
-	/*
-	 * Check if someone has requested the delay of AP MTRR initialization,
-	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
-	 * then we are done.
-	 */
-	if (!mtrr_aps_delayed_init)
-		return;
-
-	set_mtrr(~0U, 0, 0, 0);
-	mtrr_aps_delayed_init = false;
-}
-
-void mtrr_bp_restore(void)
-{
-	if (!use_intel() || !mtrr_enabled())
-		return;
-
-	mtrr_if->set_all();
-}
-
 static int __init mtrr_init_finialize(void)
 {
 	if (!mtrr_enabled())
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 2ac99e561181..e9aeeeac9a3e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -71,6 +71,12 @@ void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
 
+/* rendezvous */
+void set_mtrr_pat(unsigned int reg, unsigned long base,
+		  unsigned long size, mtrr_type type);
+void set_mtrr_pat_cpuslocked(unsigned int reg, unsigned long base,
+			     unsigned long size, mtrr_type type);
+
 /* CPU specific mtrr init functions */
 int amd_init_mtrr(void);
 int cyrix_init_mtrr(void);
diff --git a/arch/x86/kernel/cpu/mtrr/rendezvous.c b/arch/x86/kernel/cpu/mtrr/rendezvous.c
new file mode 100644
index 000000000000..5448eea573df
--- /dev/null
+++ b/arch/x86/kernel/cpu/mtrr/rendezvous.c
@@ -0,0 +1,221 @@
+/* common code for MTRR (Memory Type Range Register) and
+ * PAT(Page Attribute Table)
+ *
+ * Copyright (C) 1997-2000  Richard Gooch
+ * Copyright (c) 2002	     Patrick Mochel
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Library General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Library General Public License for more details.
+ *
+ * Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
+ * The postal address is:
+ *   Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
+ *
+ * Source: "Pentium Pro Family Developer's Manual, Volume 3:
+ * Operating System Writer's Guide" (Intel document number 242692),
+ * section 11.11.7
+ *
+ * This was cleaned and made readable by Patrick Mochel <mochel@osdl.org>
+ * on 6-7 March 2002.
+ * Source: Intel Architecture Software Developers Manual, Volume 3:
+ * System Programming Guide; Section 9.11. (1997 edition - PPro).
+ *
+ * This file was split from mtrr.c and generic.c for MTRR and PAT.
+ */
+
+#define DEBUG
+
+#include <linux/stop_machine.h>
+
+#include <asm/mtrr.h>
+#include <asm/msr.h>
+#include <asm/pat.h>
+
+#include "mtrr.h"
+
+static bool mtrr_pat_aps_delayed_init;
+
+struct set_mtrr_data {
+	unsigned long	smp_base;
+	unsigned long	smp_size;
+	unsigned int	smp_reg;
+	mtrr_type	smp_type;
+};
+
+/**
+ * mtrr_pat_rendezvous_handler - Work done in the synchronization handler.
+ * Executed by all the CPUs.
+ * @info: pointer to mtrr configuration data
+ *
+ * Returns nothing.
+ */
+static int mtrr_pat_rendezvous_handler(void *info)
+{
+	struct set_mtrr_data *data = info;
+
+	/*
+	 * We use this same function to initialize the mtrrs during boot,
+	 * resume, runtime cpu online and on an explicit request to set a
+	 * specific MTRR.
+	 *
+	 * During boot or suspend, the state of the boot cpu's mtrrs has been
+	 * saved, and we want to replicate that across all the cpus that come
+	 * online (either at the end of boot or resume or during a runtime cpu
+	 * online). If we're doing that, @reg is set to something special and on
+	 * all the cpu's we do mtrr_if->set_all() (On the logical cpu that
+	 * started the boot/resume sequence, this might be a duplicate
+	 * set_all()).
+	 */
+	if (data->smp_reg != ~0U) {
+		mtrr_if->set(data->smp_reg, data->smp_base,
+			     data->smp_size, data->smp_type);
+	} else if (mtrr_pat_aps_delayed_init ||
+		   !cpu_online(smp_processor_id())) {
+		mtrr_if->set_all();
+	}
+	return 0;
+}
+
+/**
+ * set_mtrr_pat - update mtrrs on all processors
+ * @reg:	mtrr in question
+ * @base:	mtrr base
+ * @size:	mtrr size
+ * @type:	mtrr type
+ *
+ * This is kinda tricky, but fortunately, Intel spelled it out for us cleanly:
+ *
+ * 1. Queue work to do the following on all processors:
+ * 2. Disable Interrupts
+ * 3. Wait for all procs to do so
+ * 4. Enter no-fill cache mode
+ * 5. Flush caches
+ * 6. Clear PGE bit
+ * 7. Flush all TLBs
+ * 8. Disable all range registers
+ * 9. Update the MTRRs
+ * 10. Enable all range registers
+ * 11. Flush all TLBs and caches again
+ * 12. Enter normal cache mode and reenable caching
+ * 13. Set PGE
+ * 14. Wait for buddies to catch up
+ * 15. Enable interrupts.
+ *
+ * What does that mean for us? Well, stop_machine() will ensure that
+ * the rendezvous handler is started on each CPU. And in lockstep they
+ * do the state transition of disabling interrupts, updating MTRR's
+ * (the CPU vendors may each do it differently, so we call mtrr_if->set()
+ * callback and let them take care of it.) and enabling interrupts.
+ *
+ * Note that the mechanism is the same for UP systems, too; all the SMP stuff
+ * becomes nops.
+ */
+void
+set_mtrr_pat(unsigned int reg, unsigned long base,
+	     unsigned long size, mtrr_type type)
+{
+	struct set_mtrr_data data = { .smp_reg = reg,
+				      .smp_base = base,
+				      .smp_size = size,
+				      .smp_type = type
+				    };
+
+	stop_machine(mtrr_pat_rendezvous_handler, &data, cpu_online_mask);
+}
+
+void set_mtrr_pat_cpuslocked(unsigned int reg, unsigned long base,
+			     unsigned long size, mtrr_type type)
+{
+	struct set_mtrr_data data = { .smp_reg = reg,
+				      .smp_base = base,
+				      .smp_size = size,
+				      .smp_type = type
+				    };
+
+	stop_machine_cpuslocked(mtrr_pat_rendezvous_handler,
+				&data, cpu_online_mask);
+}
+
+static void set_mtrr_pat_from_inactive_cpu(unsigned int reg, unsigned long base,
+					   unsigned long size, mtrr_type type)
+{
+	struct set_mtrr_data data = { .smp_reg = reg,
+				      .smp_base = base,
+				      .smp_size = size,
+				      .smp_type = type
+				    };
+
+	stop_machine_from_inactive_cpu(mtrr_pat_rendezvous_handler, &data,
+				       cpu_callout_mask);
+}
+
+void mtrr_pat_ap_init(void)
+{
+	if (!mtrr_enabled())
+		return;
+
+	if (!use_intel() || mtrr_pat_aps_delayed_init)
+		return;
+
+	rcu_cpu_starting(smp_processor_id());
+
+	/*
+	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
+	 * changed, but this routine will be called in cpu boot time,
+	 * holding the lock breaks it.
+	 *
+	 * This routine is called in two cases:
+	 *
+	 *   1. very earily time of software resume, when there absolutely
+	 *      isn't mtrr entry changes;
+	 *
+	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
+	 *      lock to prevent mtrr entry changes
+	 */
+	set_mtrr_pat_from_inactive_cpu(~0U, 0, 0, 0);
+}
+
+void set_mtrr_pat_aps_delayed_init(void)
+{
+	if (!mtrr_enabled())
+		return;
+	if (!use_intel())
+		return;
+
+	mtrr_pat_aps_delayed_init = true;
+}
+
+/*
+ * Delayed MTRR initialization for all AP's
+ */
+void mtrr_pat_aps_init(void)
+{
+	if (!use_intel() || !mtrr_enabled())
+		return;
+
+	/*
+	 * Check if someone has requested the delay of AP MTRR initialization,
+	 * by doing set_mtrr_pat_aps_delayed_init(), prior to this point.
+	 * If not, then we are done.
+	 */
+	if (!mtrr_pat_aps_delayed_init)
+		return;
+
+	set_mtrr_pat(~0U, 0, 0, 0);
+	mtrr_pat_aps_delayed_init = false;
+}
+
+void mtrr_pat_bp_restore(void)
+{
+	if (!use_intel() || !mtrr_enabled())
+		return;
+
+	mtrr_if->set_all();
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..ca06370c7a13 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1064,7 +1064,7 @@ void __init setup_arch(char **cmdline_p)
 	max_pfn = e820__end_of_ram_pfn();
 
 	/* update e820 for memory not covered by WB MTRRs */
-	mtrr_bp_init();
+	mtrr_pat_bp_init();
 	if (mtrr_trim_uncached_memory(max_pfn))
 		max_pfn = e820__end_of_ram_pfn();
 
@@ -1072,7 +1072,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/*
 	 * This call is required when the CPU does not support PAT. If
-	 * mtrr_bp_init() invoked it already via pat_init() the call has no
+	 * mtrr_pat_bp_init() invoked it already via pat_init() the call has no
 	 * effect.
 	 */
 	init_cache_modes();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fdbd47ceb84d..3e16e7e3a01b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1370,7 +1370,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	set_mtrr_aps_delayed_init();
+	set_mtrr_pat_aps_delayed_init();
 
 	smp_quirk_init_udelay();
 
@@ -1379,12 +1379,12 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 void arch_enable_nonboot_cpus_begin(void)
 {
-	set_mtrr_aps_delayed_init();
+	set_mtrr_pat_aps_delayed_init();
 }
 
 void arch_enable_nonboot_cpus_end(void)
 {
-	mtrr_aps_init();
+	mtrr_pat_aps_init();
 }
 
 /*
@@ -1424,7 +1424,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 
 	nmi_selftest();
 	impress_friends();
-	mtrr_aps_init();
+	mtrr_pat_aps_init();
 }
 
 static int __initdata setup_possible_cpus = -1;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 24b079e94bc2..860d33b0dd1b 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -263,7 +263,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	do_fpu_end();
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
-	mtrr_bp_restore();
+	mtrr_pat_bp_restore();
 	perf_restore_debug_store();
 	msr_restore_context(ctxt);
 }
-- 
2.17.1

