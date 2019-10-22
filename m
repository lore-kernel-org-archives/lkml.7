Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82834CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ACA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 01:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfJVBXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 21:23:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:59543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfJVBXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:23:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 18:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,325,1566889200"; 
   d="scan'208";a="281134067"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Oct 2019 18:23:50 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AA34A300512; Mon, 21 Oct 2019 18:23:50 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86: Add trace points to (nearly) all vectors
Date:   Mon, 21 Oct 2019 18:23:43 -0700
Message-Id: <20191022012343.25596-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some scenarios it can be useful to count or trace every kernel
entry. Most entry paths are covered by trace points already,
but some of the more obscure entry points do not have
trace points.

The most common uncovered one was KVM async page fault.

This patch kit adds trace points to all the other vectors,
except UV (anyone uses?), Xen (generic code), reboot (pointless)

To avoid creating a lot of new trace points this just
lumps them all together into a "other_vector" trace point, because
they're all fairly obscure and uncommon, and can be figured
out from the number when needed, or filtered using the filter
expression. This makes the needed perf command line much shorter.

The exception is the KVM async page fault which is fairly common
inside KVM guests, so is worth breaking out.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/hyperv/hv_init.c                |  2 ++
 arch/x86/include/asm/trace/irq_vectors.h |  9 ++++++
 arch/x86/kernel/apic/vector.c            |  3 ++
 arch/x86/kernel/cpu/mce/core.c           |  3 ++
 arch/x86/kernel/irq.c                    |  6 ++++
 arch/x86/kernel/kvm.c                    |  5 +++
 arch/x86/kernel/traps.c                  | 40 +++++++++++++++++++-----
 7 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2db3972c0e0f..b719cd8964e0 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -144,8 +144,10 @@ __visible void __irq_entry hyperv_reenlightenment_intr(struct pt_regs *regs)
 
 	inc_irq_stat(irq_hv_reenlightenment_count);
 
+	trace_other_vector_entry(HYPERV_REENLIGHTENMENT_VECTOR);
 	schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
 
+	trace_other_vector_exit(HYPERV_REENLIGHTENMENT_VECTOR);
 	exiting_irq();
 }
 
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 33b9d0f0aafe..0c92d3ced26c 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -71,6 +71,11 @@ DEFINE_IRQ_VECTOR_EVENT(error_apic);
  */
 DEFINE_IRQ_VECTOR_EVENT(x86_platform_ipi);
 
+/*
+ * Handle all other vectors.
+ */
+DEFINE_IRQ_VECTOR_EVENT(other_vector);
+
 #ifdef CONFIG_IRQ_WORK
 /*
  * irq_work - called when entering/exiting a irq work interrupt
@@ -138,6 +143,10 @@ DEFINE_IRQ_VECTOR_EVENT(deferred_error_apic);
 DEFINE_IRQ_VECTOR_EVENT(thermal_apic);
 #endif
 
+#ifdef CONFIG_KVM
+DEFINE_IRQ_VECTOR_EVENT(async_page_fault);
+#endif
+
 TRACE_EVENT(vector_config,
 
 	TP_PROTO(unsigned int irq, unsigned int vector,
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b0a6e7..2e883f38b895 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -860,6 +860,7 @@ asmlinkage __visible void __irq_entry smp_irq_move_cleanup_interrupt(void)
 	struct hlist_node *tmp;
 
 	entering_ack_irq();
+	trace_other_vector_entry(IRQ_MOVE_CLEANUP_VECTOR);
 	/* Prevent vectors vanishing under us */
 	raw_spin_lock(&vector_lock);
 
@@ -884,6 +885,8 @@ asmlinkage __visible void __irq_entry smp_irq_move_cleanup_interrupt(void)
 	}
 
 	raw_spin_unlock(&vector_lock);
+	trace_other_vector_exit(IRQ_MOVE_CLEANUP_VECTOR);
+	/* Prevent vectors vanishing under us */
 	exiting_irq();
 }
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370ee4983..f593bd6b0ed7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -61,6 +61,9 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
 
+#undef CREATE_TRACE_POINTS
+#include <asm/trace/irq_vectors.h>
+
 #define SPINUNIT		100	/* 100ns */
 
 DEFINE_PER_CPU(unsigned, mce_exception_count);
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 21efee32e2b1..f57c148dc578 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -308,8 +308,10 @@ __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	entering_ack_irq();
+	trace_other_vector_entry(POSTED_INTR_VECTOR);
 	inc_irq_stat(kvm_posted_intr_ipis);
 	exiting_irq();
+	trace_other_vector_exit(POSTED_INTR_VECTOR);
 	set_irq_regs(old_regs);
 }
 
@@ -321,8 +323,10 @@ __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	entering_ack_irq();
+	trace_other_vector_entry(POSTED_INTR_WAKEUP_VECTOR);
 	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
 	kvm_posted_intr_wakeup_handler();
+	trace_other_vector_exit(POSTED_INTR_WAKEUP_VECTOR);
 	exiting_irq();
 	set_irq_regs(old_regs);
 }
@@ -335,7 +339,9 @@ __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	entering_ack_irq();
+	trace_other_vector_entry(POSTED_INTR_NESTED_VECTOR);
 	inc_irq_stat(kvm_posted_intr_nested_ipis);
+	trace_other_vector_exit(POSTED_INTR_NESTED_VECTOR);
 	exiting_irq();
 	set_irq_regs(old_regs);
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index e820568ed4d5..8d915b559617 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -33,6 +33,7 @@
 #include <asm/apicdef.h>
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
+#include <asm/trace/irq_vectors.h>
 
 static int kvmapf = 1;
 
@@ -246,6 +247,8 @@ do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned lon
 {
 	enum ctx_state prev_state;
 
+	trace_async_page_fault_entry(0);
+
 	switch (kvm_read_and_reset_pf_reason()) {
 	default:
 		do_page_fault(regs, error_code, address);
@@ -262,6 +265,8 @@ do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned lon
 		rcu_irq_exit();
 		break;
 	}
+
+	trace_async_page_fault_exit(0);
 }
 NOKPROBE_SYMBOL(do_async_page_fault);
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f8447112..6ccc01d74747 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -62,6 +62,8 @@
 #include <asm/vm86.h>
 #include <asm/umip.h>
 
+#include <asm/trace/irq_vectors.h>
+
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
 #include <asm/pgalloc.h>
@@ -264,19 +266,22 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
 	unsigned long trapnr, int signr, int sicode, void __user *addr)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	trace_other_vector_entry(trapnr);
 
 	/*
 	 * WARN*()s end up here; fix them up before we call the
 	 * notifier chain.
 	 */
 	if (!user_mode(regs) && fixup_bug(regs, trapnr))
-		return;
+		goto out;
 
 	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
 			NOTIFY_STOP) {
 		cond_local_irq_enable(regs);
 		do_trap(trapnr, signr, str, regs, error_code, sicode, addr);
 	}
+out:
+	trace_other_vector_exit(trapnr);
 }
 
 #define IP ((void __user *)uprobe_get_trap_addr(regs))
@@ -433,9 +438,10 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	const struct mpx_bndcsr *bndcsr;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	trace_other_vector_entry(X86_TRAP_BR);
 	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
 			X86_TRAP_BR, SIGSEGV) == NOTIFY_STOP)
-		return;
+		goto exit;
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs))
@@ -501,6 +507,8 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 		die("bounds", regs, error_code);
 	}
 
+exit:
+	trace_other_vector_exit(X86_TRAP_BR);
 	return;
 
 exit_trap:
@@ -512,6 +520,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	 * time..
 	 */
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
+	goto exit;
 }
 
 dotraplinkage void
@@ -522,22 +531,23 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
+	trace_other_vector_entry(X86_TRAP_GP);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
 		if (user_mode(regs) && fixup_umip_exception(regs))
-			return;
+			goto out;
 	}
 
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-		return;
+		goto out;
 	}
 
 	tsk = current;
 	if (!user_mode(regs)) {
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
+			goto out;
 
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
@@ -549,12 +559,12 @@ do_general_protection(struct pt_regs *regs, long error_code)
 		 */
 		if (!preemptible() && kprobe_running() &&
 		    kprobe_fault_handler(regs, X86_TRAP_GP))
-			return;
+			goto out;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
 			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
 			die(desc, regs, error_code);
-		return;
+		goto out;
 	}
 
 	tsk->thread.error_code = error_code;
@@ -563,6 +573,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
 	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 
 	force_sig(SIGSEGV);
+
+out:
+	trace_other_vector_exit(X86_TRAP_GP);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
@@ -588,6 +601,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	 * This means that we can't schedule.  That's okay.
 	 */
 	ist_enter(regs);
+	trace_other_vector_entry(X86_TRAP_BP);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
@@ -609,6 +623,7 @@ dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
 	cond_local_irq_disable(regs);
 
 exit:
+	trace_other_vector_exit(X86_TRAP_BP);
 	ist_exit(regs);
 }
 NOKPROBE_SYMBOL(do_int3);
@@ -714,6 +729,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	int si_code;
 
 	ist_enter(regs);
+	trace_other_vector_entry(X86_TRAP_DB);
 
 	get_debugreg(dr6, 6);
 	/*
@@ -806,6 +822,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	debug_stack_usage_dec();
 
 exit:
+	trace_other_vector_exit(X86_TRAP_DB);
 	ist_exit(regs);
 }
 NOKPROBE_SYMBOL(do_debug);
@@ -858,14 +875,18 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
 dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	trace_other_vector_entry(X86_TRAP_MF);
 	math_error(regs, error_code, X86_TRAP_MF);
+	trace_other_vector_exit(X86_TRAP_MF);
 }
 
 dotraplinkage void
 do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	trace_other_vector_entry(X86_TRAP_XF);
 	math_error(regs, error_code, X86_TRAP_XF);
+	trace_other_vector_exit(X86_TRAP_XF);
 }
 
 dotraplinkage void
@@ -881,6 +902,7 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 
+	trace_other_vector_entry(X86_TRAP_NM);
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
@@ -889,7 +911,7 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 
 		info.regs = regs;
 		math_emulate(&info);
-		return;
+		goto out;
 	}
 #endif
 
@@ -905,6 +927,8 @@ do_device_not_available(struct pt_regs *regs, long error_code)
 		 */
 		die("unexpected #NM exception", regs, error_code);
 	}
+out: __maybe_unused;
+	trace_other_vector_exit(X86_TRAP_NM);
 }
 NOKPROBE_SYMBOL(do_device_not_available);
 
-- 
2.21.0

