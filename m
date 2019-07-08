Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0CC606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB992064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfGHJWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfGHJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr4-0004pG-Fw; Mon, 08 Jul 2019 11:22:38 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673796.14831.16250211652466679867.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

up to:  f8a8fe61fec8: x86/irq: Seperate unused system vectors from spurious entry again

Updates for the x86 APIC interrupt handling and APIC timer:

  - Fix a long standing issue with spurious interrupts which was caused by
    the big vector management rework a few years ago. Robert Hodaszi
    provided finally enough debug data and an excellent initial failure
    analysis which allowed to understand the underlying issues.

    This contains a change to the core interrupt management code which is
    required to handle this correctly for the APIC/IO_APIC. The core
    changes are NOOPs for most architectures except ARM64. ARM64 is not
    impacted by the change as confirmed by Marc Zyngier.

  - Newer systems allow to disable the PIT clock for power saving causing
    panic in the timer interrupt delivery check of the IO/APIC when the
    HPET timer is not enabled either. While the clock could be turned
    on this would cause an endless whack a mole game to chase the proper
    register in each affected chipset.

    These systems provide the relevant frequencies for TSC, CPU and the
    local APIC timer via CPUID and/or MSRs, which allows to avoid the
    PIT/HPET based calibration.  As the calibration code is the only usage
    of the legacy timers on modern systems and is skipped anyway when the
    frequencies are known already, there is no point in setting up the PIT
    and actually checking for the interrupt delivery via IO/APIC.

    To achieve this on a wide variety of platforms, the CPUID/MSR based
    frequency readout has been made more robust, which also allowed to
    remove quite some workarounds which turned out to be not longer
    required. Thanks to Daniel Drake for analysis, patches and verification.

Thanks,

	tglx

------------------>
Daniel Drake (3):
      x86/tsc: Use CPUID.0x16 to calculate missing crystal frequency
      x86/apic: Rename 'lapic_timer_frequency' to 'lapic_timer_period'
      x86/tsc: Set LAPIC timer period to crystal clock frequency

Nadav Amit (1):
      x86/apic: Use non-atomic operations when possible

Thomas Gleixner (8):
      x86/apic: Make apic_bsp_setup() static
      x86/timer: Skip PIT initialization on modern chipsets
      genirq: Delay deactivation in free_irq()
      genirq: Fix misleading synchronize_irq() documentation
      genirq: Add optional hardware synchronization for shutdown
      x86/ioapic: Implement irq_get_irqchip_state() callback
      x86/irq: Handle spurious interrupt after shutdown gracefully
      x86/irq: Seperate unused system vectors from spurious entry again


 arch/x86/entry/entry_32.S             | 24 ++++++++++
 arch/x86/entry/entry_64.S             | 30 ++++++++++--
 arch/x86/include/asm/apic.h           |  5 +-
 arch/x86/include/asm/hw_irq.h         |  5 +-
 arch/x86/include/asm/time.h           |  1 +
 arch/x86/kernel/apic/apic.c           | 87 +++++++++++++++++++++++----------
 arch/x86/kernel/apic/apic_flat_64.c   |  4 +-
 arch/x86/kernel/apic/io_apic.c        | 50 +++++++++++++++++++
 arch/x86/kernel/apic/vector.c         |  4 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/cpu/mshyperv.c        |  4 +-
 arch/x86/kernel/cpu/vmware.c          |  2 +-
 arch/x86/kernel/i8253.c               | 25 +++++++++-
 arch/x86/kernel/idt.c                 |  3 +-
 arch/x86/kernel/irq.c                 |  2 +-
 arch/x86/kernel/jailhouse.c           |  2 +-
 arch/x86/kernel/smp.c                 |  2 +-
 arch/x86/kernel/time.c                |  7 ++-
 arch/x86/kernel/tsc.c                 | 57 ++++++++++++++--------
 arch/x86/kernel/tsc_msr.c             |  4 +-
 kernel/irq/autoprobe.c                |  6 +--
 kernel/irq/chip.c                     |  6 +++
 kernel/irq/cpuhotplug.c               |  2 +-
 kernel/irq/internals.h                |  5 ++
 kernel/irq/manage.c                   | 90 +++++++++++++++++++++++++++--------
 25 files changed, 335 insertions(+), 94 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7b23431be5cb..44c6e6f54bf7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1104,6 +1104,30 @@ ENTRY(irq_entries_start)
     .endr
 END(irq_entries_start)
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	.align 8
+ENTRY(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
+    vector=vector+1
+	jmp	common_spurious
+	.align	8
+    .endr
+END(spurious_entries_start)
+
+common_spurious:
+	ASM_CLAC
+	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
+	SAVE_ALL switch_stacks=1
+	ENCODE_FRAME_POINTER
+	TRACE_IRQS_OFF
+	movl	%esp, %eax
+	call	smp_spurious_interrupt
+	jmp	ret_from_intr
+ENDPROC(common_interrupt)
+#endif
+
 /*
  * the CPU automatically disables interrupts when executing an IRQ vector,
  * so IRQ-flags tracing has to follow that:
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 20e45d9b4e15..6d835991bb23 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -375,6 +375,18 @@ ENTRY(irq_entries_start)
     .endr
 END(irq_entries_start)
 
+	.align 8
+ENTRY(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
+	jmp	common_spurious
+	.align	8
+	vector=vector+1
+    .endr
+END(spurious_entries_start)
+
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
 	pushq %rax
@@ -571,10 +583,20 @@ _ASM_NOKPROBE(interrupt_entry)
 
 /* Interrupt entry/exit. */
 
-	/*
-	 * The interrupt stubs push (~vector+0x80) onto the stack and
-	 * then jump to common_interrupt.
-	 */
+/*
+ * The interrupt stubs push (~vector+0x80) onto the stack and
+ * then jump to common_spurious/interrupt.
+ */
+common_spurious:
+	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	smp_spurious_interrupt		/* rdi points to pt_regs */
+	jmp	ret_from_intr
+END(common_spurious)
+_ASM_NOKPROBE(common_spurious)
+
+/* common_interrupt is a hotpath. Align it */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 common_interrupt:
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 130e81e10fc7..693a0ad56019 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -52,7 +52,7 @@ extern unsigned int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
-extern unsigned int lapic_timer_frequency;
+extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
@@ -154,7 +154,6 @@ static inline int apic_force_enable(unsigned long addr)
 extern int apic_force_enable(unsigned long addr);
 #endif
 
-extern void apic_bsp_setup(bool upmode);
 extern void apic_ap_setup(void);
 
 /*
@@ -174,6 +173,7 @@ extern void lapic_assign_system_vectors(void);
 extern void lapic_assign_legacy_vector(unsigned int isairq, bool replace);
 extern void lapic_online(void);
 extern void lapic_offline(void);
+extern bool apic_needs_pit(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -187,6 +187,7 @@ static inline void init_bsp_APIC(void) { }
 static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
+static inline bool apic_needs_pit(void) { return true; }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 32e666e1231e..cbd97e22d2f3 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -150,8 +150,11 @@ extern char irq_entries_start[];
 #define trace_irq_entries_start irq_entries_start
 #endif
 
+extern char spurious_entries_start[];
+
 #define VECTOR_UNUSED		NULL
-#define VECTOR_RETRIGGERED	((void *)~0UL)
+#define VECTOR_SHUTDOWN		((void *)~0UL)
+#define VECTOR_RETRIGGERED	((void *)~1UL)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index cef818b16045..8ac563abb567 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -7,6 +7,7 @@
 
 extern void hpet_time_init(void);
 extern void time_init(void);
+extern bool pit_timer_init(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ab6af775f06c..a5241b209ea5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -194,7 +194,7 @@ static struct resource lapic_resource = {
 	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
 };
 
-unsigned int lapic_timer_frequency = 0;
+unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
@@ -500,7 +500,7 @@ lapic_timer_set_periodic_oneshot(struct clock_event_device *evt, bool oneshot)
 	if (evt->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
-	__setup_APIC_LVTT(lapic_timer_frequency, oneshot, 1);
+	__setup_APIC_LVTT(lapic_timer_period, oneshot, 1);
 	return 0;
 }
 
@@ -804,11 +804,11 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 
 static int __init lapic_init_clockevent(void)
 {
-	if (!lapic_timer_frequency)
+	if (!lapic_timer_period)
 		return -1;
 
 	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
+	lapic_clockevent.mult = div_sc(lapic_timer_period/APIC_DIVISOR,
 					TICK_NSEC, lapic_clockevent.shift);
 	lapic_clockevent.max_delta_ns =
 		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
@@ -820,6 +820,33 @@ static int __init lapic_init_clockevent(void)
 	return 0;
 }
 
+bool __init apic_needs_pit(void)
+{
+	/*
+	 * If the frequencies are not known, PIT is required for both TSC
+	 * and apic timer calibration.
+	 */
+	if (!tsc_khz || !cpu_khz)
+		return true;
+
+	/* Is there an APIC at all? */
+	if (!boot_cpu_has(X86_FEATURE_APIC))
+		return true;
+
+	/* Deadline timer is based on TSC so no further PIT action required */
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return false;
+
+	/* APIC timer disabled? */
+	if (disable_apic_timer)
+		return true;
+	/*
+	 * The APIC timer frequency is known already, no PIT calibration
+	 * required. If unknown, let the PIT be initialized.
+	 */
+	return lapic_timer_period == 0;
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
@@ -838,7 +865,7 @@ static int __init calibrate_APIC_clock(void)
 	 */
 	if (!lapic_init_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_frequency);
+			    lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -883,13 +910,13 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 - lapic_cal_pm1,
 					&delta, &deltatsc);
 
-	lapic_timer_frequency = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+	lapic_timer_period = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
 	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_frequency);
+		    lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
@@ -900,13 +927,13 @@ static int __init calibrate_APIC_clock(void)
 
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
 		    "%u.%04u MHz.\n",
-		    lapic_timer_frequency / (1000000 / HZ),
-		    lapic_timer_frequency % (1000000 / HZ));
+		    lapic_timer_period / (1000000 / HZ),
+		    lapic_timer_period % (1000000 / HZ));
 
 	/*
 	 * Do a sanity check on the APIC calibration result
 	 */
-	if (lapic_timer_frequency < (1000000 / HZ)) {
+	if (lapic_timer_period < (1000000 / HZ)) {
 		local_irq_enable();
 		pr_warning("APIC frequency too slow, disabling apic timer\n");
 		return -1;
@@ -1350,6 +1377,8 @@ void __init init_bsp_APIC(void)
 	apic_write(APIC_LVT1, value);
 }
 
+static void __init apic_bsp_setup(bool upmode);
+
 /* Init the interrupt delivery mode for the BSP */
 void __init apic_intr_mode_init(void)
 {
@@ -2039,21 +2068,32 @@ __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
 	entering_irq();
 	trace_spurious_apic_entry(vector);
 
+	inc_irq_stat(irq_spurious_count);
+
+	/*
+	 * If this is a spurious interrupt then do not acknowledge
+	 */
+	if (vector == SPURIOUS_APIC_VECTOR) {
+		/* See SDM vol 3 */
+		pr_info("Spurious APIC interrupt (vector 0xFF) on CPU#%d, should never happen.\n",
+			smp_processor_id());
+		goto out;
+	}
+
 	/*
-	 * Check if this really is a spurious interrupt and ACK it
-	 * if it is a vectored one.  Just in case...
-	 * Spurious interrupts should not be ACKed.
+	 * If it is a vectored one, verify it's set in the ISR. If set,
+	 * acknowledge it.
 	 */
 	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
-	if (v & (1 << (vector & 0x1f)))
+	if (v & (1 << (vector & 0x1f))) {
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
+			vector, smp_processor_id());
 		ack_APIC_irq();
-
-	inc_irq_stat(irq_spurious_count);
-
-	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
-	pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
-		"should never happen.\n", vector, smp_processor_id());
-
+	} else {
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
+			vector, smp_processor_id());
+	}
+out:
 	trace_spurious_apic_exit(vector);
 	exiting_irq();
 }
@@ -2414,11 +2454,8 @@ static void __init apic_bsp_up_setup(void)
 /**
  * apic_bsp_setup - Setup function for local apic and io-apic
  * @upmode:		Force UP mode (for APIC_init_uniprocessor)
- *
- * Returns:
- * apic_id of BSP APIC
  */
-void __init apic_bsp_setup(bool upmode)
+static void __init apic_bsp_setup(bool upmode)
 {
 	connect_bsp_APIC();
 	if (upmode)
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 0005c284a5c5..65072858f553 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -78,7 +78,7 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	int cpu = smp_processor_id();
 
 	if (cpu < BITS_PER_LONG)
-		clear_bit(cpu, &mask);
+		__clear_bit(cpu, &mask);
 
 	_flat_send_IPI_mask(mask, vector);
 }
@@ -92,7 +92,7 @@ static void flat_send_IPI_allbutself(int vector)
 			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
 
 			if (cpu < BITS_PER_LONG)
-				clear_bit(cpu, &mask);
+				__clear_bit(cpu, &mask);
 
 			_flat_send_IPI_mask(mask, vector);
 		}
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 53aa234a6803..c7bb6c69f21c 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -58,6 +58,7 @@
 #include <asm/acpi.h>
 #include <asm/dma.h>
 #include <asm/timer.h>
+#include <asm/time.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
 #include <asm/irq_remapping.h>
@@ -1893,6 +1894,50 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
 	return ret;
 }
 
+/*
+ * Interrupt shutdown masks the ioapic pin, but the interrupt might already
+ * be in flight, but not yet serviced by the target CPU. That means
+ * __synchronize_hardirq() would return and claim that everything is calmed
+ * down. So free_irq() would proceed and deactivate the interrupt and free
+ * resources.
+ *
+ * Once the target CPU comes around to service it it will find a cleared
+ * vector and complain. While the spurious interrupt is harmless, the full
+ * release of resources might prevent the interrupt from being acknowledged
+ * which keeps the hardware in a weird state.
+ *
+ * Verify that the corresponding Remote-IRR bits are clear.
+ */
+static int ioapic_irq_get_chip_state(struct irq_data *irqd,
+				   enum irqchip_irq_state which,
+				   bool *state)
+{
+	struct mp_chip_data *mcd = irqd->chip_data;
+	struct IO_APIC_route_entry rentry;
+	struct irq_pin_list *p;
+
+	if (which != IRQCHIP_STATE_ACTIVE)
+		return -EINVAL;
+
+	*state = false;
+	raw_spin_lock(&ioapic_lock);
+	for_each_irq_pin(p, mcd->irq_2_pin) {
+		rentry = __ioapic_read_entry(p->apic, p->pin);
+		/*
+		 * The remote IRR is only valid in level trigger mode. It's
+		 * meaning is undefined for edge triggered interrupts and
+		 * irrelevant because the IO-APIC treats them as fire and
+		 * forget.
+		 */
+		if (rentry.irr && rentry.trigger) {
+			*state = true;
+			break;
+		}
+	}
+	raw_spin_unlock(&ioapic_lock);
+	return 0;
+}
+
 static struct irq_chip ioapic_chip __read_mostly = {
 	.name			= "IO-APIC",
 	.irq_startup		= startup_ioapic_irq,
@@ -1902,6 +1947,7 @@ static struct irq_chip ioapic_chip __read_mostly = {
 	.irq_eoi		= ioapic_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -1914,6 +1960,7 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 	.irq_eoi		= ioapic_ir_ack_level,
 	.irq_set_affinity	= ioapic_set_affinity,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
@@ -2083,6 +2130,9 @@ static inline void __init check_timer(void)
 	unsigned long flags;
 	int no_pin1 = 0;
 
+	if (!global_clock_event)
+		return;
+
 	local_irq_save(flags);
 
 	/*
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3173e07d3791..1c6d1d5f28d3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -343,7 +343,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 	trace_vector_clear(irqd->irq, vector, apicd->cpu, apicd->prev_vector,
 			   apicd->prev_cpu);
 
-	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->cpu, vector, managed);
 	apicd->vector = 0;
 
@@ -352,7 +352,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 	if (!vector)
 		return;
 
-	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_UNUSED;
+	per_cpu(vector_irq, apicd->prev_cpu)[vector] = VECTOR_SHUTDOWN;
 	irq_matrix_free(vector_matrix, apicd->prev_cpu, vector, managed);
 	apicd->prev_vector = 0;
 	apicd->move_in_progress = 0;
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 7685444a106b..609e499387a1 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -50,7 +50,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 	cpumask_copy(tmpmsk, mask);
 	/* If IPI should not be sent to self, clear current CPU */
 	if (apic_dest != APIC_DEST_ALLINC)
-		cpumask_clear_cpu(smp_processor_id(), tmpmsk);
+		__cpumask_clear_cpu(smp_processor_id(), tmpmsk);
 
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3fa238a137d2..faae6115ddef 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -270,9 +270,9 @@ static void __init ms_hyperv_init_platform(void)
 
 		rdmsrl(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
 		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
-		lapic_timer_frequency = hv_lapic_frequency;
+		lapic_timer_period = hv_lapic_frequency;
 		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
-			lapic_timer_frequency);
+			lapic_timer_period);
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0eda91f8eeac..3c648476d4fb 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -157,7 +157,7 @@ static void __init vmware_platform_setup(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-		lapic_timer_frequency = ecx / HZ;
+		lapic_timer_period = ecx / HZ;
 		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
 			ecx);
 #endif
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 0d307a657abb..2b7999a1a50a 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -18,10 +19,32 @@
  */
 struct clock_event_device *global_clock_event;
 
-void __init setup_pit_timer(void)
+/*
+ * Modern chipsets can disable the PIT clock which makes it unusable. It
+ * would be possible to enable the clock but the registers are chipset
+ * specific and not discoverable. Avoid the whack a mole game.
+ *
+ * These platforms have discoverable TSC/CPU frequencies but this also
+ * requires to know the local APIC timer frequency as it normally is
+ * calibrated against the PIT interrupt.
+ */
+static bool __init use_pit(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_TSC) || !boot_cpu_has(X86_FEATURE_TSC))
+		return true;
+
+	/* This also returns true when APIC is disabled */
+	return apic_needs_pit();
+}
+
+bool __init pit_timer_init(void)
 {
+	if (!use_pit())
+		return false;
+
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
+	return true;
 }
 
 #ifndef CONFIG_X86_64
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 6d8917875f44..cc4444cb3898 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -320,7 +320,8 @@ void __init idt_setup_apic_and_irq_gates(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 		set_bit(i, system_vectors);
-		set_intr_gate(i, spurious_interrupt);
+		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
+		set_intr_gate(i, entry);
 	}
 #endif
 }
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2ea7c2f..a975246074b5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -246,7 +246,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	if (!handle_irq(desc, regs)) {
 		ack_APIC_irq();
 
-		if (desc != VECTOR_RETRIGGERED) {
+		if (desc != VECTOR_RETRIGGERED && desc != VECTOR_SHUTDOWN) {
 			pr_emerg_ratelimited("%s: %d.%d No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55a2dfb..ba95bc70460d 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -45,7 +45,7 @@ static void jailhouse_get_wallclock(struct timespec64 *now)
 
 static void __init jailhouse_timer_init(void)
 {
-	lapic_timer_frequency = setup_data.apic_khz * (1000 / HZ);
+	lapic_timer_period = setup_data.apic_khz * (1000 / HZ);
 }
 
 static unsigned long jailhouse_get_tsc(void)
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 04adc8d60aed..acddd988602d 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -146,7 +146,7 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 	}
 
 	cpumask_copy(allbutself, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), allbutself);
+	__cpumask_clear_cpu(smp_processor_id(), allbutself);
 
 	if (cpumask_equal(mask, allbutself) &&
 	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 0e14f6c0d35e..07c0e960b3f3 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -82,8 +82,11 @@ static void __init setup_default_timer_irq(void)
 /* Default timer init function */
 void __init hpet_time_init(void)
 {
-	if (!hpet_enable())
-		setup_pit_timer();
+	if (!hpet_enable()) {
+		if (!pit_timer_init())
+			return;
+	}
+
 	setup_default_timer_irq();
 }
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15b5e98a86f9..8f47c4862c56 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -631,31 +631,38 @@ unsigned long native_calibrate_tsc(void)
 
 	crystal_khz = ecx_hz / 1000;
 
-	if (crystal_khz == 0) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_SKYLAKE_MOBILE:
-		case INTEL_FAM6_SKYLAKE_DESKTOP:
-		case INTEL_FAM6_KABYLAKE_MOBILE:
-		case INTEL_FAM6_KABYLAKE_DESKTOP:
-			crystal_khz = 24000;	/* 24.0 MHz */
-			break;
-		case INTEL_FAM6_ATOM_GOLDMONT_X:
-			crystal_khz = 25000;	/* 25.0 MHz */
-			break;
-		case INTEL_FAM6_ATOM_GOLDMONT:
-			crystal_khz = 19200;	/* 19.2 MHz */
-			break;
-		}
-	}
+	/*
+	 * Denverton SoCs don't report crystal clock, and also don't support
+	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
+	 * clock.
+	 */
+	if (crystal_khz == 0 &&
+			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_X)
+		crystal_khz = 25000;
 
-	if (crystal_khz == 0)
-		return 0;
 	/*
-	 * TSC frequency determined by CPUID is a "hardware reported"
+	 * TSC frequency reported directly by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	if (crystal_khz != 0)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	/*
+	 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
+	 * clock, but we can easily calculate it to a high degree of accuracy
+	 * by considering the crystal ratio and the CPU speed.
+	 */
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+		unsigned int eax_base_mhz, ebx, ecx, edx;
+
+		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		crystal_khz = eax_base_mhz * 1000 *
+			eax_denominator / ebx_numerator;
+	}
+
+	if (crystal_khz == 0)
+		return 0;
 
 	/*
 	 * For Atom SoCs TSC is the only reliable clocksource.
@@ -664,6 +671,16 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * The local APIC appears to be fed by the core crystal clock
+	 * (which sounds entirely sensible). We can set the global
+	 * lapic_timer_period here to avoid having to calibrate the APIC
+	 * timer later.
+	 */
+	lapic_timer_period = crystal_khz * 1000 / HZ;
+#endif
+
 	return crystal_khz * ebx_numerator / eax_denominator;
 }
 
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 3d0e9aeea7c8..067858fe4db8 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -71,7 +71,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 /*
  * MSR-based CPU/TSC frequency discovery for certain CPUs.
  *
- * Set global "lapic_timer_frequency" to bus_clock_cycles/jiffy
+ * Set global "lapic_timer_period" to bus_clock_cycles/jiffy
  * Return processor base frequency in KHz, or 0 on failure.
  */
 unsigned long cpu_khz_from_msr(void)
@@ -104,7 +104,7 @@ unsigned long cpu_khz_from_msr(void)
 	res = freq * ratio;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	lapic_timer_frequency = (freq * 1000) / HZ;
+	lapic_timer_period = (freq * 1000) / HZ;
 #endif
 
 	/*
diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 16cbf6beb276..ae60cae24e9a 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
 			/* It triggered already - consider it spurious. */
 			if (!(desc->istate & IRQS_WAITING)) {
 				desc->istate &= ~IRQS_AUTODETECT;
-				irq_shutdown(desc);
+				irq_shutdown_and_deactivate(desc);
 			} else
 				if (i < 32)
 					mask |= 1 << i;
@@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned long val)
 				mask |= 1 << i;
 
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
@@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
 				nr_of_irqs++;
 			}
 			desc->istate &= ~IRQS_AUTODETECT;
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 		}
 		raw_spin_unlock_irq(&desc->lock);
 	}
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 51128bea3846..04fe4f989bd8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
 		}
 		irq_state_clr_started(desc);
 	}
+}
+
+
+void irq_shutdown_and_deactivate(struct irq_desc *desc)
+{
+	irq_shutdown(desc);
 	/*
 	 * This must be called even if the interrupt was never started up,
 	 * because the activation can happen before the interrupt is
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 5b1072e394b2..6c7ca2e983a5 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		 */
 		if (irqd_affinity_is_managed(d)) {
 			irqd_set_managed_shutdown(d);
-			irq_shutdown(desc);
+			irq_shutdown_and_deactivate(desc);
 			return false;
 		}
 		affinity = cpu_online_mask;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..3a948f41ab00 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -82,6 +82,7 @@ extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
 extern void irq_shutdown(struct irq_desc *desc);
+extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
@@ -96,6 +97,10 @@ static inline void irq_mark_irq(unsigned int irq) { }
 extern void irq_mark_irq(unsigned int irq);
 #endif
 
+extern int __irq_get_irqchip_state(struct irq_data *data,
+				   enum irqchip_irq_state which,
+				   bool *state);
+
 extern void init_kstat_irqs(struct irq_desc *desc, int node, int nr);
 
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 53a081392115..fad61986f35c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -34,8 +35,9 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
 
-static void __synchronize_hardirq(struct irq_desc *desc)
+static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
 {
+	struct irq_data *irqd = irq_desc_get_irq_data(desc);
 	bool inprogress;
 
 	do {
@@ -51,6 +53,20 @@ static void __synchronize_hardirq(struct irq_desc *desc)
 		/* Ok, that indicated we're done: double-check carefully. */
 		raw_spin_lock_irqsave(&desc->lock, flags);
 		inprogress = irqd_irq_inprogress(&desc->irq_data);
+
+		/*
+		 * If requested and supported, check at the chip whether it
+		 * is in flight at the hardware level, i.e. already pending
+		 * in a CPU and waiting for service and acknowledge.
+		 */
+		if (!inprogress && sync_chip) {
+			/*
+			 * Ignore the return code. inprogress is only updated
+			 * when the chip supports it.
+			 */
+			__irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE,
+						&inprogress);
+		}
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		/* Oops, that failed? */
@@ -73,13 +89,18 @@ static void __synchronize_hardirq(struct irq_desc *desc)
  *	Returns: false if a threaded handler is active.
  *
  *	This function may be called - with care - from IRQ context.
+ *
+ *	It does not check whether there is an interrupt in flight at the
+ *	hardware level, but not serviced yet, as this might deadlock when
+ *	called with interrupts disabled and the target CPU of the interrupt
+ *	is the current CPU.
  */
 bool synchronize_hardirq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, false);
 		return !atomic_read(&desc->threads_active);
 	}
 
@@ -95,14 +116,19 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
+ *
+ *	It optionally makes sure (when the irq chip supports that method)
+ *	that the interrupt is not pending in any CPU and waiting for
+ *	service.
  */
 void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc) {
-		__synchronize_hardirq(desc);
+		__synchronize_hardirq(desc, true);
 		/*
 		 * We made sure that no hardirq handler is
 		 * running. Now verify that no threaded handlers are
@@ -1699,6 +1725,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
+		/* Only shutdown. Deactivate after synchronize_hardirq() */
 		irq_shutdown(desc);
 	}
 
@@ -1727,8 +1754,12 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 
 	unregister_handler_proc(irq, action);
 
-	/* Make sure it's not being used on another CPU: */
-	synchronize_hardirq(irq);
+	/*
+	 * Make sure it's not being used on another CPU and if the chip
+	 * supports it also make sure that there is no (not yet serviced)
+	 * interrupt in flight at the hardware level.
+	 */
+	__synchronize_hardirq(desc, true);
 
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
@@ -1768,6 +1799,14 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
+		/*
+		 * There is no interrupt on the fly anymore. Deactivate it
+		 * completely.
+		 */
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		irq_domain_deactivate_irq(&desc->irq_data);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);
@@ -1855,7 +1894,7 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 	}
 
 	irq_settings_clr_disable_unlazy(desc);
-	irq_shutdown(desc);
+	irq_shutdown_and_deactivate(desc);
 
 	irq_release_resources(desc);
 
@@ -2578,6 +2617,28 @@ void teardown_percpu_nmi(unsigned int irq)
 	irq_put_desc_unlock(desc, flags);
 }
 
+int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
+			    bool *state)
+{
+	struct irq_chip *chip;
+	int err = -EINVAL;
+
+	do {
+		chip = irq_data_get_irq_chip(data);
+		if (chip->irq_get_irqchip_state)
+			break;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		data = data->parent_data;
+#else
+		data = NULL;
+#endif
+	} while (data);
+
+	if (data)
+		err = chip->irq_get_irqchip_state(data, which, state);
+	return err;
+}
+
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
@@ -2596,7 +2657,6 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 {
 	struct irq_desc *desc;
 	struct irq_data *data;
-	struct irq_chip *chip;
 	unsigned long flags;
 	int err = -EINVAL;
 
@@ -2606,19 +2666,7 @@ int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 	data = irq_desc_get_irq_data(desc);
 
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip->irq_get_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
-
-	if (data)
-		err = chip->irq_get_irqchip_state(data, which, state);
+	err = __irq_get_irqchip_state(data, which, state);
 
 	irq_put_desc_busunlock(desc, flags);
 	return err;

