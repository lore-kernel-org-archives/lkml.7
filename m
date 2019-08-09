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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A627C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA62D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBEX06Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405256AbfHIDyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:54:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38125 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfHIDyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:54:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so45298971pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :in-reply-to:references;
        bh=jSOdYAPToz4QppeXhf3mVUt4/K/aoLOslHoXziO/XQo=;
        b=QBEX06QhdqP07aD6voRs8yzUXZyYjsq8jSODIVo2vjIdOkChmqjDIh3JEhLm5uEedH
         dvYnXZmRenoZjM1dA3Vs10JuCBaL6d0l9rl1BGXQ31K9zVbclR9uRDJkwQfVJl88AgSh
         OTnf/Yjb87koLfH9Fq3RMiBy7ojfD9EA+ta3cUugMY0Jele/mMS5lIn282+B44AoYxE0
         PiqHmc4Fua8Jf4Vr+B4sxstpuQ2CC6HkbrXYgxuY9fRZvG2Lg6hqarboXUC481lFxza6
         D5mBabLp7ShPxQ7snQYIyg1veHKgROLApWMHdRldvxaDgtPQdpuyXoO6149+3c2kZdpq
         EQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:in-reply-to:references;
        bh=jSOdYAPToz4QppeXhf3mVUt4/K/aoLOslHoXziO/XQo=;
        b=qnsQ8Awe5bnjrQa5PstEXwWnP0EEa6vnnOod/NMiT25pWRlu4XRCraHKHXZA+GuK3x
         BM8O3mk3MZ5K7yMPLtp89GeJQLwSC+1z1Iq4OgTEku0cdNi1i0MSs2HB3bcJFXS/0ATE
         ooikEDk6twipYqeH7QMTWuGZsyW8RaEIHJ2lR29wCiW4onDzhgW8DdvgD6LndV9P3eKQ
         rXZeFzl/8d8ScMW/rkRckNqBjL+Cw/8ZBbFnEWOTtNflXxA5zwpi/H5iYIcb93/nGNWt
         R/9IcuyessQ9Wl1Hi3IMuZdLeKcBZ4B9Ewf+Xi6MvsBsiKMQc/AnRU2XTQi810xK/H7k
         e+/Q==
X-Gm-Message-State: APjAAAUpjhWEK7YDVwYykjDfrdMVTN88rXK6HZIUtIiRMRK8fCdLhX2m
        ql8zTKl7RLyQz+22hOX5qUY2nUEg
X-Google-Smtp-Source: APXvYqy6d13TOARGVNvDqSUJyAtM041bnVPuwRMW39Qkigcp/7yuaD8wRnLcPuw9EWAwZlofHdEtXQ==
X-Received: by 2002:a63:e010:: with SMTP id e16mr15474601pgh.285.1565322877655;
        Thu, 08 Aug 2019 20:54:37 -0700 (PDT)
Received: from localhost (c-73-189-176-234.hsd1.ca.comcast.net. [73.189.176.234])
        by smtp.gmail.com with ESMTPSA id e11sm114236838pfm.35.2019.08.08.20.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 20:54:36 -0700 (PDT)
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     toshi.kani@hpe.com, fei1.li@intel.com,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Subject: [PATCH 3/3] x86/mtrr, pat: make PAT independent from MTRR
Date:   Thu,  8 Aug 2019 20:54:20 -0700
Message-Id: <582ea1630c9c93b0041c881f3b58bc022b65818a.1565300606.git.isaku.yamahata@gmail.com>
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

This patch makes PAT(Page Attribute Table) independent from
MTRR(Memory Type Range Register)
Some environments (mainly virtual ones) support only PAT, not MTRR.
It's tricky and no gain to support both MTRR and PAT at the
same time except compatibility because PAT replaces MTRR.
So some VM technologies don't support MTRR, but only PAT.
This patch make PAT available on such environments without MTRR.

Signed-off-by: Isaku Yamahata <isaku.yamahata@gmail.com>
---
 arch/x86/Kconfig                      |  1 -
 arch/x86/include/asm/mtrr.h           | 32 +++++----
 arch/x86/include/asm/pat.h            |  2 +
 arch/x86/kernel/cpu/mtrr/generic.c    |  5 --
 arch/x86/kernel/cpu/mtrr/mtrr.c       |  8 +--
 arch/x86/kernel/cpu/mtrr/mtrr.h       |  1 -
 arch/x86/kernel/cpu/mtrr/rendezvous.c | 76 +++++++++++---------
 arch/x86/mm/Makefile                  |  3 +
 arch/x86/mm/pat.c                     | 99 ++++++++++++++++++++++++---
 9 files changed, 158 insertions(+), 69 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..5654283e010f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1838,7 +1838,6 @@ config MTRR_SANITIZER_SPARE_REG_NR_DEFAULT
 config X86_PAT
 	def_bool y
 	prompt "x86 PAT support" if EXPERT
-	depends on MTRR
 	---help---
 	  Use PAT attributes to setup page level cache control.
 
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 5b056374f5a6..a401ad106c28 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -31,10 +31,25 @@
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
  */
-# ifdef CONFIG_MTRR
-extern bool mtrr_enabled(void);
+#if defined(CONFIG_MTRR) || defined(CONFIG_X86_PAT)
+/* common method for MTRR and PAT */
 extern void mtrr_pat_prepare_set(void) __acquires(set_atomicity_lock);
 extern void mtrr_pat_post_set(void) __releases(set_atomicity_lock);
+extern void mtrr_pat_ap_init(void);
+extern void set_mtrr_pat_aps_delayed_init(void);
+extern void mtrr_pat_aps_init(void);
+extern void mtrr_pat_bp_restore(void);
+#else
+static inline void mtrr_pat_prepare_set(void) { }
+static inline void mtrr_pat_post_set(void) { }
+static inline void mtrr_pat_ap_init(void) { };
+static inline void set_mtrr_pat_aps_delayed_init(void) { };
+static inline void mtrr_pat_aps_init(void) { };
+static inline void mtrr_pat_bp_restore(void) { };
+#endif
+
+# ifdef CONFIG_MTRR
+extern bool mtrr_enabled(void);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -45,11 +60,7 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_pat_ap_init(void);
 extern void mtrr_pat_bp_init(void);
-extern void set_mtrr_pat_aps_delayed_init(void);
-extern void mtrr_pat_aps_init(void);
-extern void mtrr_pat_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 #  else
@@ -57,8 +68,6 @@ static inline bool mtrr_enabled(void)
 {
 	return false;
 }
-static inline void mtrr_pat_prepare_set(void) { };
-static inline void mtrr_pat_post_set(void) { };
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
 	/*
@@ -95,13 +104,8 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 }
 static inline void mtrr_pat_bp_init(void)
 {
-	pat_disable("MTRRs disabled, skipping PAT initialization too.");
+	pat_bp_init();
 }
-
-static inline void mtrr_pat_ap_init(void) { };
-static inline void set_mtrr_pat_aps_delayed_init(void) { };
-static inline void mtrr_pat_aps_init(void) { };
-static inline void mtrr_pat_bp_restore(void) { };
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/include/asm/pat.h b/arch/x86/include/asm/pat.h
index 92015c65fa2a..2a355ce94ebf 100644
--- a/arch/x86/include/asm/pat.h
+++ b/arch/x86/include/asm/pat.h
@@ -7,7 +7,9 @@
 
 bool pat_enabled(void);
 void pat_disable(const char *reason);
+extern void pat_set(void);
 extern void pat_init(void);
+extern void pat_bp_init(void);
 extern void init_cache_modes(void);
 
 extern int reserve_memtype(u64 start, u64 end,
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index a44f05f64846..f9a7ca79e2c2 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -6,13 +6,8 @@
 #define DEBUG
 
 #include <linux/export.h>
-#include <linux/init.h>
-#include <linux/io.h>
 #include <linux/mm.h>
 
-#include <asm/processor-flags.h>
-#include <asm/cpufeature.h>
-#include <asm/tlbflush.h>
 #include <asm/mtrr.h>
 #include <asm/msr.h>
 #include <asm/pat.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 475627ca2c1b..2d28c9b37ae7 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -657,13 +657,7 @@ void __init mtrr_pat_bp_init(void)
 
 	if (!mtrr_enabled()) {
 		pr_info("Disabled\n");
-
-		/*
-		 * PAT initialization relies on MTRR's rendezvous handler.
-		 * Skip PAT init until the handler can initialize both
-		 * features independently.
-		 */
-		pat_disable("MTRRs disabled, skipping PAT initialization too.");
+		pat_bp_init();
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 57948b651b8e..dfc1094cae27 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -53,7 +53,6 @@ void set_mtrr_prepare_save(struct set_mtrr_context *ctxt);
 void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
-void pat_bp_init(void);
 
 extern void __init set_mtrr_ops(const struct mtrr_ops *ops);
 
diff --git a/arch/x86/kernel/cpu/mtrr/rendezvous.c b/arch/x86/kernel/cpu/mtrr/rendezvous.c
index d902b9e5cc17..2f31dcf334a9 100644
--- a/arch/x86/kernel/cpu/mtrr/rendezvous.c
+++ b/arch/x86/kernel/cpu/mtrr/rendezvous.c
@@ -47,20 +47,6 @@ u32 mtrr_deftype_lo, mtrr_deftype_hi;
 static unsigned long cr4;
 static DEFINE_RAW_SPINLOCK(set_atomicity_lock);
 
-/* PAT setup for BP. We need to go through sync steps here */
-void __init pat_bp_init(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	mtrr_pat_prepare_set();
-
-	pat_init();
-
-	mtrr_pat_post_set();
-	local_irq_restore(flags);
-}
-
 /*
  * Since we are disabling the cache don't allow any interrupts,
  * they would run extremely slow and would only increase the pain.
@@ -104,11 +90,14 @@ void mtrr_pat_prepare_set(void) __acquires(set_atomicity_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	__flush_tlb();
 
-	/* Save MTRR state */
-	rdmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
+	if (mtrr_enabled()) {
+		/* Save MTRR state */
+		rdmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
 
-	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo & ~0xcff, mtrr_deftype_hi);
+		/* Disable MTRRs, and set the default type to uncached */
+		mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo & ~0xcff,
+			   mtrr_deftype_hi);
+	}
 
 	/* Again, only flush caches if we have to. */
 	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
@@ -121,8 +110,10 @@ void mtrr_pat_post_set(void) __releases(set_atomicity_lock)
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	__flush_tlb();
 
-	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
+	if (mtrr_enabled()) {
+		/* Intel (P6) standard MTRRs */
+		mtrr_wrmsr(MSR_MTRRdefType, mtrr_deftype_lo, mtrr_deftype_hi);
+	}
 
 	/* Enable caches */
 	write_cr0(read_cr0() & ~X86_CR0_CD);
@@ -133,6 +124,14 @@ void mtrr_pat_post_set(void) __releases(set_atomicity_lock)
 	raw_spin_unlock(&set_atomicity_lock);
 }
 
+static inline void mtrr_pat_set_all(void)
+{
+	if (mtrr_enabled())
+		mtrr_if->set_all();
+	else
+		pat_set();
+}
+
 struct set_mtrr_data {
 	unsigned long	smp_base;
 	unsigned long	smp_size;
@@ -165,17 +164,19 @@ static int mtrr_pat_rendezvous_handler(void *info)
 	 * set_all()).
 	 */
 	if (data->smp_reg != ~0U) {
-		mtrr_if->set(data->smp_reg, data->smp_base,
-			     data->smp_size, data->smp_type);
+		if (mtrr_enabled()) {
+			mtrr_if->set(data->smp_reg, data->smp_base,
+				     data->smp_size, data->smp_type);
+		}
 	} else if (mtrr_pat_aps_delayed_init ||
 		   !cpu_online(smp_processor_id())) {
-		mtrr_if->set_all();
+		mtrr_pat_set_all();
 	}
 	return 0;
 }
 
 /**
- * set_mtrr_pat - update mtrrs on all processors
+ * set_mtrr_pat - update mtrrs and pat on all processors
  * @reg:	mtrr in question
  * @base:	mtrr base
  * @size:	mtrr size
@@ -230,6 +231,7 @@ void set_mtrr_pat_cpuslocked(unsigned int reg, unsigned long base,
 				      .smp_type = type
 				    };
 
+	WARN_ON(!mtrr_enabled());
 	stop_machine_cpuslocked(mtrr_pat_rendezvous_handler,
 				&data, cpu_online_mask);
 }
@@ -247,12 +249,24 @@ static void set_mtrr_pat_from_inactive_cpu(unsigned int reg, unsigned long base,
 				       cpu_callout_mask);
 }
 
+static inline bool use_intel_mtrr_pat(void)
+{
+	if (mtrr_enabled() || pat_enabled())
+		return true;
+
+#ifdef CONFIG_MTRR
+	return use_intel();
+#else
+	return true;
+#endif
+}
+
 void mtrr_pat_ap_init(void)
 {
-	if (!mtrr_enabled())
+	if (!use_intel_mtrr_pat())
 		return;
 
-	if (!use_intel() || mtrr_pat_aps_delayed_init)
+	if (mtrr_pat_aps_delayed_init)
 		return;
 
 	rcu_cpu_starting(smp_processor_id());
@@ -275,9 +289,7 @@ void mtrr_pat_ap_init(void)
 
 void set_mtrr_pat_aps_delayed_init(void)
 {
-	if (!mtrr_enabled())
-		return;
-	if (!use_intel())
+	if (!use_intel_mtrr_pat())
 		return;
 
 	mtrr_pat_aps_delayed_init = true;
@@ -288,7 +300,7 @@ void set_mtrr_pat_aps_delayed_init(void)
  */
 void mtrr_pat_aps_init(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!use_intel_mtrr_pat())
 		return;
 
 	/*
@@ -305,8 +317,8 @@ void mtrr_pat_aps_init(void)
 
 void mtrr_pat_bp_restore(void)
 {
-	if (!use_intel() || !mtrr_enabled())
+	if (!use_intel_mtrr_pat())
 		return;
 
-	mtrr_if->set_all();
+	mtrr_pat_set_all();
 }
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc9b341..841820553a62 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -24,6 +24,9 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
 obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
+ifndef CONFIG_MTRR
+obj-$(CONFIG_X86_PAT)		+= ../kernel/cpu/mtrr/rendezvous.o
+endif
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f69920..852cd0c3f96e 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -297,7 +297,7 @@ void init_cache_modes(void)
  * to enable additional cache attributes, WC, WT and WP.
  *
  * This function must be called on all CPUs using the specific sequence of
- * operations defined in Intel SDM. mtrr_rendezvous_handler() provides this
+ * operations defined in Intel SDM. mtrr_pat_rendezvous_handler() provides this
  * procedure for PAT.
  */
 void pat_init(void)
@@ -374,8 +374,33 @@ void pat_init(void)
 
 #undef PAT
 
+void pat_set(void)
+{
+	if (pat_disabled)
+		return;
+
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
+/* PAT setup for BP. We need to go through sync steps here */
+void __init pat_bp_init(void)
+{
+	pat_set();
+}
+
 static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
 
+static int pat_pagerange_is_ram(resource_size_t start, resource_size_t end);
+static int pat_pagerange_is_acpi(resource_size_t start, resource_size_t end);
+
 /*
  * Does intersection of PAT memory type and MTRR memory type and returns
  * the resulting memory type as PAT understands it.
@@ -383,6 +408,22 @@ static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
  * The intersection is based on "Effective Memory Type" tables in IA-32
  * SDM vol 3a
  */
+static unsigned long system_memory_type(u64 start, u64 end,
+					enum page_cache_mode req_type)
+{
+	/*
+	 * ACPI subsystem tries to map non-ram area as writeback.
+	 * If it's not ram, use uc minus similarly to mtrr case.
+	 */
+	if (pat_pagerange_is_ram(start, end) == 1)
+		return _PAGE_CACHE_MODE_WB;
+	/* allow writeback for ACPI tables/ACPI NVS */
+	if (pat_pagerange_is_acpi(start, end) == 1)
+		return _PAGE_CACHE_MODE_WB;
+
+	return _PAGE_CACHE_MODE_UC_MINUS;
+}
+
 static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 				     enum page_cache_mode req_type)
 {
@@ -391,13 +432,21 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
 	 * request is for WB.
 	 */
 	if (req_type == _PAGE_CACHE_MODE_WB) {
-		u8 mtrr_type, uniform;
-
-		mtrr_type = mtrr_type_lookup(start, end, &uniform);
-		if (mtrr_type != MTRR_TYPE_WRBACK)
-			return _PAGE_CACHE_MODE_UC_MINUS;
-
-		return _PAGE_CACHE_MODE_WB;
+		if (mtrr_enabled()) {
+			u8 mtrr_type, uniform;
+
+			mtrr_type = mtrr_type_lookup(start, end, &uniform);
+			if (mtrr_type == MTRR_TYPE_INVALID) {
+				/* MTRR doesn't cover this range. */
+				return system_memory_type(
+					start, end, req_type);
+			}
+			if (mtrr_type != MTRR_TYPE_WRBACK)
+				return _PAGE_CACHE_MODE_UC_MINUS;
+
+			return _PAGE_CACHE_MODE_WB;
+		}
+		return system_memory_type(start, end, req_type);
 	}
 
 	return req_type;
@@ -446,6 +495,36 @@ static int pat_pagerange_is_ram(resource_size_t start, resource_size_t end)
 	return (ret > 0) ? -1 : (state.ram ? 1 : 0);
 }
 
+static int pagerange_is_acpi_desc_callback(struct resource *res, void *arg)
+{
+	unsigned long initial_pfn = res->start >> PAGE_SHIFT;
+	unsigned long end_pfn = (res->end + 1) >> PAGE_SHIFT;
+	unsigned long total_nr_pages = end_pfn - initial_pfn;
+
+	return pagerange_is_ram_callback(initial_pfn, total_nr_pages, arg);
+}
+
+static int pagerange_is_acpi_desc(unsigned long desc,
+				  resource_size_t start, resource_size_t end)
+{
+	int ret = 0;
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	struct pagerange_state state = {start_pfn, 0, 0};
+
+	ret = walk_iomem_res_desc(desc, IORESOURCE_MEM | IORESOURCE_BUSY,
+		start, end, &state, pagerange_is_acpi_desc_callback);
+	return (ret > 0) ? -1 : (state.ram ? 1 : 0);
+}
+
+static int pat_pagerange_is_acpi(resource_size_t start, resource_size_t end)
+{
+	int ret = pagerange_is_acpi_desc(IORES_DESC_ACPI_TABLES, start, end);
+
+	if (ret == 1)
+		return ret;
+	return pagerange_is_acpi_desc(IORES_DESC_ACPI_NV_STORAGE, start, end);
+}
+
 /*
  * For RAM pages, we use page flags to mark the pages with appropriate type.
  * The page flags are limited to four types, WB (default), WC, WT and UC-.
@@ -561,7 +640,7 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 	if (!pat_enabled()) {
 		/* This is identical to page table setting without PAT */
 		if (new_type)
-			*new_type = req_type;
+			*new_type = pat_x_mtrr_type(start, end, req_type);
 		return 0;
 	}
 
@@ -577,6 +656,8 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 	 * optimization for /dev/mem mmap'ers into WB memory (BIOS
 	 * tools and ACPI tools). Use WB request for WB memory and use
 	 * UC_MINUS otherwise.
+	 * When mtrr is disabled, check iomem resource which is derived
+	 * from e820.
 	 */
 	actual_type = pat_x_mtrr_type(start, end, req_type);
 
-- 
2.17.1

