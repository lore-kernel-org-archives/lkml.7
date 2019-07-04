Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C4C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A937218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGDQeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59732 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfGDQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:10 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gS-0005hs-CI; Thu, 04 Jul 2019 18:34:08 +0200
Message-Id: <20190704155610.235245968@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 20/25] x86/smp: Move smp_function_call implementations into
 IPI code
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it where it belongs. That allows to keep all the shorthand logic in
one place.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/smp.h |    1 +
 arch/x86/kernel/apic/ipi.c |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smp.c      |   40 ----------------------------------------
 3 files changed, 41 insertions(+), 40 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -142,6 +142,7 @@ void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
+void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -62,6 +62,46 @@ void apic_send_IPI_allbutself(unsigned i
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 }
 
+/*
+ * Send a 'reschedule' IPI to another CPU. It goes straight through and
+ * wastes no time serializing anything. Worst case is that we lose a
+ * reschedule ...
+ */
+void native_smp_send_reschedule(int cpu)
+{
+	if (unlikely(cpu_is_offline(cpu))) {
+		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
+		return;
+	}
+	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
+}
+
+void native_send_call_func_single_ipi(int cpu)
+{
+	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+}
+
+void native_send_call_func_ipi(const struct cpumask *mask)
+{
+	cpumask_var_t allbutself;
+
+	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
+		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+		return;
+	}
+
+	cpumask_copy(allbutself, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), allbutself);
+
+	if (cpumask_equal(mask, allbutself) &&
+	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
+		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	else
+		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+
+	free_cpumask_var(allbutself);
+}
+
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -115,46 +115,6 @@
 static atomic_t stopping_cpu = ATOMIC_INIT(-1);
 static bool smp_no_nmi_ipi = false;
 
-/*
- * this function sends a 'reschedule' IPI to another CPU.
- * it goes straight through and wastes no time serializing
- * anything. Worst case is that we lose a reschedule ...
- */
-static void native_smp_send_reschedule(int cpu)
-{
-	if (unlikely(cpu_is_offline(cpu))) {
-		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
-		return;
-	}
-	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
-}
-
-void native_send_call_func_single_ipi(int cpu)
-{
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
-}
-
-void native_send_call_func_ipi(const struct cpumask *mask)
-{
-	cpumask_var_t allbutself;
-
-	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-		return;
-	}
-
-	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
-
-	if (cpumask_equal(mask, allbutself) &&
-	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
-		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
-	else
-		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
-
-	free_cpumask_var(allbutself);
-}
-
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	/* We are registered on stopping cpu too, avoid spurious NMI */


