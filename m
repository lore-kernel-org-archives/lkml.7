Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3240FC606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013812064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfGHJWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfGHJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr2-0004p2-Hb; Mon, 08 Jul 2019 11:22:36 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/hotplug for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673794.14831.7846075415358186761.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-hotplug-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

up to:  caa759323c73: smp: Remove smp_call_function() and on_each_cpu() return values

A small set of updates for SMP and CPU hotplug:

  - Abort disabling secondary CPUs in the freezer when a wakeup is pending
    instead of evaluating it only after all CPUs have been offlined.

  - Remove the shared annotation for the strict per CPU cfd_data in the smp
    function call core code.

  - Remove the return values of smp_call_function() and on_each_cpu() as
    they are unconditionally 0. Fixup the few callers which actually
    bothered to check the return value.

Thanks,

	tglx

------------------>
Jiri Kosina (1):
      cpu/hotplug: Fix notify_cpu_starting() reference in bringup_wait_for_ap()

Nadav Amit (2):
      smp: Do not mark call_function_data as shared
      smp: Remove smp_call_function() and on_each_cpu() return values

Pavankumar Kondeti (1):
      cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending


 arch/alpha/kernel/smp.c       | 19 +++++--------------
 arch/alpha/oprofile/common.c  |  6 +++---
 arch/arm/common/bL_switcher.c |  6 ++----
 arch/ia64/kernel/perfmon.c    | 12 ++----------
 arch/ia64/kernel/uncached.c   |  8 ++++----
 arch/powerpc/kernel/rtas.c    |  3 +--
 arch/x86/lib/cache-smp.c      |  3 ++-
 drivers/char/agp/generic.c    |  3 +--
 include/linux/smp.h           |  7 +++----
 kernel/cpu.c                  |  9 ++++++++-
 kernel/smp.c                  | 12 ++++--------
 kernel/up.c                   |  3 +--
 12 files changed, 36 insertions(+), 55 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index d0dccae53ba9..5f90df30be20 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -614,8 +614,7 @@ void
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	if (on_each_cpu(ipi_imb, NULL, 1))
-		printk(KERN_CRIT "smp_imb: timed out\n");
+	on_each_cpu(ipi_imb, NULL, 1);
 }
 EXPORT_SYMBOL(smp_imb);
 
@@ -630,9 +629,7 @@ flush_tlb_all(void)
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	if (on_each_cpu(ipi_flush_tlb_all, NULL, 1)) {
-		printk(KERN_CRIT "flush_tlb_all: timed out\n");
-	}
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
 
 #define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
@@ -667,9 +664,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		}
 	}
 
-	if (smp_call_function(ipi_flush_tlb_mm, mm, 1)) {
-		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
-	}
+	smp_call_function(ipi_flush_tlb_mm, mm, 1);
 
 	preempt_enable();
 }
@@ -720,9 +715,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	data.mm = mm;
 	data.addr = addr;
 
-	if (smp_call_function(ipi_flush_tlb_page, &data, 1)) {
-		printk(KERN_CRIT "flush_tlb_page: timed out\n");
-	}
+	smp_call_function(ipi_flush_tlb_page, &data, 1);
 
 	preempt_enable();
 }
@@ -772,9 +765,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 		}
 	}
 
-	if (smp_call_function(ipi_flush_icache_page, mm, 1)) {
-		printk(KERN_CRIT "flush_icache_page: timed out\n");
-	}
+	smp_call_function(ipi_flush_icache_page, mm, 1);
 
 	preempt_enable();
 }
diff --git a/arch/alpha/oprofile/common.c b/arch/alpha/oprofile/common.c
index 310a4ce1dccc..1b1259c7d7d1 100644
--- a/arch/alpha/oprofile/common.c
+++ b/arch/alpha/oprofile/common.c
@@ -65,7 +65,7 @@ op_axp_setup(void)
 	model->reg_setup(&reg, ctr, &sys);
 
 	/* Configure the registers on all cpus.  */
-	(void)smp_call_function(model->cpu_setup, &reg, 1);
+	smp_call_function(model->cpu_setup, &reg, 1);
 	model->cpu_setup(&reg);
 	return 0;
 }
@@ -86,7 +86,7 @@ op_axp_cpu_start(void *dummy)
 static int
 op_axp_start(void)
 {
-	(void)smp_call_function(op_axp_cpu_start, NULL, 1);
+	smp_call_function(op_axp_cpu_start, NULL, 1);
 	op_axp_cpu_start(NULL);
 	return 0;
 }
@@ -101,7 +101,7 @@ op_axp_cpu_stop(void *dummy)
 static void
 op_axp_stop(void)
 {
-	(void)smp_call_function(op_axp_cpu_stop, NULL, 1);
+	smp_call_function(op_axp_cpu_stop, NULL, 1);
 	op_axp_cpu_stop(NULL);
 }
 
diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 57f3b7512636..17bc259729e2 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -542,16 +542,14 @@ static void bL_switcher_trace_trigger_cpu(void *__always_unused info)
 
 int bL_switcher_trace_trigger(void)
 {
-	int ret;
-
 	preempt_disable();
 
 	bL_switcher_trace_trigger_cpu(NULL);
-	ret = smp_call_function(bL_switcher_trace_trigger_cpu, NULL, true);
+	smp_call_function(bL_switcher_trace_trigger_cpu, NULL, true);
 
 	preempt_enable();
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bL_switcher_trace_trigger);
 
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 58a6337c0690..7c52bd2695a2 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -6390,11 +6390,7 @@ pfm_install_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 	}
 
 	/* save the current system wide pmu states */
-	ret = on_each_cpu(pfm_alt_save_pmu_state, NULL, 1);
-	if (ret) {
-		DPRINT(("on_each_cpu() failed: %d\n", ret));
-		goto cleanup_reserve;
-	}
+	on_each_cpu(pfm_alt_save_pmu_state, NULL, 1);
 
 	/* officially change to the alternate interrupt handler */
 	pfm_alt_intr_handler = hdl;
@@ -6421,7 +6417,6 @@ int
 pfm_remove_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 {
 	int i;
-	int ret;
 
 	if (hdl == NULL) return -EINVAL;
 
@@ -6435,10 +6430,7 @@ pfm_remove_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 
 	pfm_alt_intr_handler = NULL;
 
-	ret = on_each_cpu(pfm_alt_restore_pmu_state, NULL, 1);
-	if (ret) {
-		DPRINT(("on_each_cpu() failed: %d\n", ret));
-	}
+	on_each_cpu(pfm_alt_restore_pmu_state, NULL, 1);
 
 	for_each_online_cpu(i) {
 		pfm_unreserve_session(NULL, 1, i);
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 583f7ff6b589..c618d0745e22 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -124,8 +124,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
 	if (status == PAL_VISIBILITY_OK_REMOTE_NEEDED) {
 		atomic_set(&uc_pool->status, 0);
-		status = smp_call_function(uncached_ipi_visibility, uc_pool, 1);
-		if (status || atomic_read(&uc_pool->status))
+		smp_call_function(uncached_ipi_visibility, uc_pool, 1);
+		if (atomic_read(&uc_pool->status))
 			goto failed;
 	} else if (status != PAL_VISIBILITY_OK)
 		goto failed;
@@ -146,8 +146,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	if (status != PAL_STATUS_SUCCESS)
 		goto failed;
 	atomic_set(&uc_pool->status, 0);
-	status = smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
-	if (status || atomic_read(&uc_pool->status))
+	smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
+	if (atomic_read(&uc_pool->status))
 		goto failed;
 
 	/*
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index fbc676160adf..64d95eb6ffff 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -994,8 +994,7 @@ int rtas_ibm_suspend_me(u64 handle)
 	/* Call function on all CPUs.  One of us will make the
 	 * rtas call
 	 */
-	if (on_each_cpu(rtas_percpu_suspend_me, &data, 0))
-		atomic_set(&data.error, -EINVAL);
+	on_each_cpu(rtas_percpu_suspend_me, &data, 0);
 
 	wait_for_completion(&done);
 
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 1811fa4a1b1a..7c48ff4ae8d1 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -15,6 +15,7 @@ EXPORT_SYMBOL(wbinvd_on_cpu);
 
 int wbinvd_on_all_cpus(void)
 {
-	return on_each_cpu(__wbinvd, NULL, 1);
+	on_each_cpu(__wbinvd, NULL, 1);
+	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 658664a5a5aa..df1edb5ec0ad 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1311,8 +1311,7 @@ static void ipi_handler(void *null)
 
 void global_cache_flush(void)
 {
-	if (on_each_cpu(ipi_handler, NULL, 1) != 0)
-		panic(PFX "timed out waiting for the other CPUs!\n");
+	on_each_cpu(ipi_handler, NULL, 1);
 }
 EXPORT_SYMBOL(global_cache_flush);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a56f08ff3097..bb8b451ab01f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -35,7 +35,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 /*
  * Call a function on all processors
  */
-int on_each_cpu(smp_call_func_t func, void *info, int wait);
+void on_each_cpu(smp_call_func_t func, void *info, int wait);
 
 /*
  * Call a function on processors specified by mask, which might include
@@ -101,7 +101,7 @@ extern void smp_cpus_done(unsigned int max_cpus);
 /*
  * Call a function on all other processors
  */
-int smp_call_function(smp_call_func_t func, void *info, int wait);
+void smp_call_function(smp_call_func_t func, void *info, int wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
@@ -144,9 +144,8 @@ static inline void smp_send_stop(void) { }
  *	These macros fold the SMP functionality into a single CPU system
  */
 #define raw_smp_processor_id()			0
-static inline int up_smp_call_function(smp_call_func_t func, void *info)
+static inline void up_smp_call_function(smp_call_func_t func, void *info)
 {
-	return 0;
 }
 #define smp_call_function(func, info, wait) \
 			(up_smp_call_function(func, info))
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f2ef10460698..0778249cd49d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -522,7 +522,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	/*
 	 * SMT soft disabling on X86 requires to bring the CPU out of the
 	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
-	 * CPU marked itself as booted_once in cpu_notify_starting() so the
+	 * CPU marked itself as booted_once in notify_cpu_starting() so the
 	 * cpu_smt_allowed() check will now return false if this is not the
 	 * primary sibling.
 	 */
@@ -1221,6 +1221,13 @@ int freeze_secondary_cpus(int primary)
 	for_each_online_cpu(cpu) {
 		if (cpu == primary)
 			continue;
+
+		if (pm_wakeup_pending()) {
+			pr_info("Wakeup pending. Abort CPU freeze\n");
+			error = -EBUSY;
+			break;
+		}
+
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
 		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
diff --git a/kernel/smp.c b/kernel/smp.c
index d155374632eb..616d4d114847 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -34,7 +34,7 @@ struct call_function_data {
 	cpumask_var_t		cpumask_ipi;
 };
 
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct call_function_data, cfd_data);
+static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
@@ -487,13 +487,11 @@ EXPORT_SYMBOL(smp_call_function_many);
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function(smp_call_func_t func, void *info, int wait)
+void smp_call_function(smp_call_func_t func, void *info, int wait)
 {
 	preempt_disable();
 	smp_call_function_many(cpu_online_mask, func, info, wait);
 	preempt_enable();
-
-	return 0;
 }
 EXPORT_SYMBOL(smp_call_function);
 
@@ -594,18 +592,16 @@ void __init smp_init(void)
  * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
  * of local_irq_disable/enable().
  */
-int on_each_cpu(void (*func) (void *info), void *info, int wait)
+void on_each_cpu(void (*func) (void *info), void *info, int wait)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	preempt_disable();
-	ret = smp_call_function(func, info, wait);
+	smp_call_function(func, info, wait);
 	local_irq_save(flags);
 	func(info);
 	local_irq_restore(flags);
 	preempt_enable();
-	return ret;
 }
 EXPORT_SYMBOL(on_each_cpu);
 
diff --git a/kernel/up.c b/kernel/up.c
index 483c9962c999..862b460ab97a 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -35,14 +35,13 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 }
 EXPORT_SYMBOL(smp_call_function_single_async);
 
-int on_each_cpu(smp_call_func_t func, void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	func(info);
 	local_irq_restore(flags);
-	return 0;
 }
 EXPORT_SYMBOL(on_each_cpu);
 

