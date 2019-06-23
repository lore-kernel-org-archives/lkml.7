Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB4C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DFB20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Yb7Hg8VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfFWMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:33:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:33:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NCW3EJ2633806
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 05:32:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NCW3EJ2633806
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561293124;
        bh=xI64kCSLthFnWHAv7fria3Qdf/e2UpskuLW6LkOyOaY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Yb7Hg8VGPyfFAcX+bx6U2P8952VxKrMeYu9v8kL5fW3KDwD8ZXscKmNsHkT5aBCij
         V8fkizSR/mtC51wSVhhNKTQcXPwgB9iDcW++5H7m3hEbClOWcQ9x7qpYtmUGgshhYI
         YHR5hUhEc0U0RAx1U33Fk8Pg3sghVoJLl2874NPFo0jJfdMymUnwo4pzj6jKU+wLN+
         Q0raDKHA8iyXT7OUL/bue5wQYar7uwEKJX0Je/62qDJU26atZjWkC1kguvlqgjNjdb
         xhbhXciCUhWrNR6sYFf4WOLMDPL6QTCTiDk7HXnOZJix2Ov4ClrsczdB9jkjXxMHCJ
         GffSt+Zxhn2XA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NCW0OV2633803;
        Sun, 23 Jun 2019 05:32:00 -0700
Date:   Sun, 23 Jun 2019 05:32:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-caa759323c73676b3e48c8d9c86093c88b4aba97@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, namit@vmware.com,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com, hpa@zytor.com,
        ink@jurassic.park.msu.ru, akpm@linux-foundation.org,
        luto@kernel.org, peterz@infradead.org, mattst88@gmail.com,
        bp@alien8.de, tglx@linutronix.de, tony.luck@intel.com,
        mingo@kernel.org, rth@twiddle.net
Reply-To: ink@jurassic.park.msu.ru, fenghua.yu@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, namit@vmware.com,
          dave.hansen@linux.intel.com, peterz@infradead.org,
          luto@kernel.org, akpm@linux-foundation.org, rth@twiddle.net,
          mingo@kernel.org, tony.luck@intel.com, tglx@linutronix.de,
          mattst88@gmail.com, bp@alien8.de
In-Reply-To: <20190613064813.8102-2-namit@vmware.com>
References: <20190613064813.8102-2-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] smp: Remove smp_call_function() and on_each_cpu()
 return values
Git-Commit-ID: caa759323c73676b3e48c8d9c86093c88b4aba97
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  caa759323c73676b3e48c8d9c86093c88b4aba97
Gitweb:     https://git.kernel.org/tip/caa759323c73676b3e48c8d9c86093c88b4aba97
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 12 Jun 2019 23:48:05 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 23 Jun 2019 14:26:26 +0200

smp: Remove smp_call_function() and on_each_cpu() return values

The return value is fixed. Remove it and amend the callers.

[ tglx: Fixup arm/bL_switcher and powerpc/rtas ]

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lkml.kernel.org/r/20190613064813.8102-2-namit@vmware.com

---
 arch/alpha/kernel/smp.c       | 19 +++++--------------
 arch/alpha/oprofile/common.c  |  6 +++---
 arch/arm/common/bL_switcher.c |  6 ++----
 arch/ia64/kernel/perfmon.c    | 12 ++----------
 arch/ia64/kernel/uncached.c   |  8 ++++----
 arch/powerpc/kernel/rtas.c    |  3 +--
 arch/x86/lib/cache-smp.c      |  3 ++-
 drivers/char/agp/generic.c    |  3 +--
 include/linux/smp.h           |  7 +++----
 kernel/smp.c                  | 10 +++-------
 kernel/up.c                   |  3 +--
 11 files changed, 27 insertions(+), 53 deletions(-)

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
diff --git a/kernel/smp.c b/kernel/smp.c
index 220ad142f5dd..616d4d114847 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
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
 
