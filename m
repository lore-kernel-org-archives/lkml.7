Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A1C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1E218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGCLE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:04:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGCLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3a-0002cQ-V9; Wed, 03 Jul 2019 13:04:11 +0200
Message-Id: <20190703105916.563090830@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 11/18] x86/hotplug: Silence APIC and NMI when CPU is dead
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support IPI/NMI broadcasting via the shorthand mechanism side
effects of shorthands need to be mitigated:

 Shorthand IPIs and NMIs hit all CPUs including unplugged CPUs

Neither of those can be handled on unplugged CPUs for obvious reasons.

It would be trivial to just fully disable the APIC via the enable bit in
MSR_APICBASE. But that's not possible because clearing that bit on systems
based on the 3 wire APIC bus would require a hardware reset to bring it
back as the APIC would lose track of bus arbitration. On systems with FSB
delivery APICBASE could be disabled, but it has to be guaranteed that no
interrupt is sent to the APIC while in that state and it's not clear from
the SDM whether it still responds to INIT/SIPI messages.

Therefore stay on the safe side and switch the APIC into soft disabled mode
so it won't deliver any regular vector to the CPU.

NMIs are still propagated to the 'dead' CPUs. To mitigate that add a per
cpu variable which tells the NMI handler to ignore NMIs. Note, this cannot
use the stop/restart_nmi() magic which is used in the alternatives code. A
dead CPU cannot invoke nmi_enter() or anything else due to RCU and other
reasons.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h      |    1 +
 arch/x86/include/asm/processor.h |    2 ++
 arch/x86/kernel/apic/apic.c      |   35 ++++++++++++++++++++++++-----------
 arch/x86/kernel/nmi.c            |    3 +++
 arch/x86/kernel/smpboot.c        |   13 ++++++++++++-
 5 files changed, 42 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -136,6 +136,7 @@ extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void disconnect_bsp_APIC(int virt_wire_setup);
 extern void disable_local_APIC(void);
+extern void apic_soft_disable(void);
 extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -428,6 +428,8 @@ DECLARE_PER_CPU_ALIGNED(struct stack_can
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* X86_64 */
 
+DECLARE_PER_CPU(bool, cpu_ignore_nmi);
+
 extern unsigned int fpu_kernel_xstate_size;
 extern unsigned int fpu_user_xstate_size;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1182,25 +1182,38 @@ void clear_local_APIC(void)
 }
 
 /**
- * disable_local_APIC - clear and disable the local APIC
+ * apic_soft_disable - Clears and software disables the local APIC on hotplug
+ *
+ * Contrary to disable_local_APIC() this does not touch the enable bit in
+ * MSR_IA32_APICBASE. Clearing that bit on systems based on the 3 wire APIC
+ * bus would require a hardware reset as the APIC would lose track of bus
+ * arbitration. On systems with FSB delivery APICBASE could be disabled,
+ * but it has to be guaranteed that no interrupt is sent to the APIC while
+ * in that state and it's not clear from the SDM whether it still responds
+ * to INIT/SIPI messages. Stay on the safe side and use software disable.
  */
-void disable_local_APIC(void)
+void apic_soft_disable(void)
 {
-	unsigned int value;
-
-	/* APIC hasn't been mapped yet */
-	if (!x2apic_mode && !apic_phys)
-		return;
+	u32 value;
 
 	clear_local_APIC();
 
-	/*
-	 * Disable APIC (implies clearing of registers
-	 * for 82489DX!).
-	 */
+	/* Soft disable APIC (implies clearing of registers for 82489DX!). */
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_SPIV_APIC_ENABLED;
 	apic_write(APIC_SPIV, value);
+}
+
+/**
+ * disable_local_APIC - clear and disable the local APIC
+ */
+void disable_local_APIC(void)
+{
+	/* APIC hasn't been mapped yet */
+	if (!x2apic_mode && !apic_phys)
+		return;
+
+	apic_soft_disable();
 
 #ifdef CONFIG_X86_32
 	/*
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -512,6 +512,9 @@ NOKPROBE_SYMBOL(is_debug_stack);
 dotraplinkage notrace void
 do_nmi(struct pt_regs *regs, long error_code)
 {
+	if (IS_ENABLED(CONFIG_SMP) && this_cpu_read(cpu_ignore_nmi))
+		return;
+
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
 		this_cpu_write(nmi_state, NMI_LATCHED);
 		return;
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -81,6 +81,9 @@
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
 
+/* Flag for the NMI path telling it to ignore the NMI */
+DEFINE_PER_CPU(bool, cpu_ignore_nmi);
+
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -263,6 +266,8 @@ static void notrace start_secondary(void
 	unlock_vector_lock();
 	cpu_set_state_online(smp_processor_id());
 	x86_platform.nmi_init();
+	/* Reenable NMI handling */
+	this_cpu_write(cpu_ignore_nmi, false);
 
 	/* enable local interrupts */
 	local_irq_enable();
@@ -1599,6 +1604,7 @@ void cpu_disable_common(void)
 	unlock_vector_lock();
 	fixup_irqs();
 	lapic_offline();
+	this_cpu_write(cpu_ignore_nmi, true);
 }
 
 int native_cpu_disable(void)
@@ -1609,7 +1615,12 @@ int native_cpu_disable(void)
 	if (ret)
 		return ret;
 
-	clear_local_APIC();
+	/*
+	 * Disable the local APIC. Otherwise IPI broadcasts will reach
+	 * it. It still responds normally to INIT, NMI, SMI, and SIPI
+	 * messages.
+	 */
+	apic_soft_disable();
 	cpu_disable_common();
 
 	return 0;


