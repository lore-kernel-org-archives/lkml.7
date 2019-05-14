Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB74C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C736216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfENODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:03:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:47286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfENODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:03:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 07:02:59 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2019 07:02:58 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [RFC PATCH v3 11/21] x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
Date:   Tue, 14 May 2019 07:02:04 -0700
Message-Id: <1557842534-4266-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial implementation of a hardlockup detector driven by an
HPET timer. This initial implementation includes functions to control the
timer via its registers. It also requests such timer, installs an NMI
interrupt handler and performs the initial configuration of the timer.

The detector is not functional at this stage. A subsequent changeset will
invoke the interfaces provides by this detector as well as functionality
to determine if the HPET timer caused the NMI.

In order to detect hardlockups in all the monitored CPUs, move the
interrupt to the next monitored CPU while handling the NMI interrupt; wrap
around when reaching the highest CPU in the mask. This rotation is
achieved by setting the affinity mask to only contain the next CPU to
monitor. A cpumask keeps track of all the CPUs that need to be monitored.
Such cpumask is updated when the watchdog is enabled or disabled in a
particular CPU.

This detector relies on an HPET timer that is capable of using Front Side
Bus interrupts. In order to avoid using the generic interrupt code,
program directly the MSI message register of the HPET timer.

HPET registers are only accessed to kick the timer after looking for
hardlockups. This happens every watchdog_thresh seconds. A subsequent
changeset will determine whether the HPET timer caused the interrupt based
on the value of the time-stamp counter. For now, just add a stub function.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/Kconfig.debug              |  11 +
 arch/x86/include/asm/hpet.h         |  13 ++
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/hpet.c              |   3 +-
 arch/x86/kernel/watchdog_hld_hpet.c | 334 ++++++++++++++++++++++++++++
 5 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/watchdog_hld_hpet.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..376a5db81aec 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -169,6 +169,17 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR_HPET
+	bool "Use HPET Timer for Hard Lockup Detection"
+	select SOFTLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR_CORE
+	depends on HPET_TIMER && HPET && X86_64
+	help
+	  Say y to enable a hardlockup detector that is driven by an High-
+	  Precision Event Timer. This option is helpful to not use counters
+	  from the Performance Monitoring Unit to drive the detector.
+
 config X86_DECODER_SELFTEST
 	bool "x86 instruction decoder selftest"
 	depends on DEBUG_KERNEL && KPROBES
diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 20abdaa5372d..31fc27508cf3 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -114,12 +114,25 @@ struct hpet_hld_data {
 	bool		has_periodic;
 	u32		num;
 	u64		ticks_per_second;
+	u32		handling_cpu;
+	u32		enabled_cpus;
+	struct msi_msg	msi_msg;
+	unsigned long	cpu_monitored_mask[0];
 };
 
 extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
+extern int hardlockup_detector_hpet_init(void);
+extern void hardlockup_detector_hpet_stop(void);
+extern void hardlockup_detector_hpet_enable(unsigned int cpu);
+extern void hardlockup_detector_hpet_disable(unsigned int cpu);
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
+static inline int hardlockup_detector_hpet_init(void)
+{ return -ENODEV; }
+static inline void hardlockup_detector_hpet_stop(void) {}
+static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
+static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 62e78a3fd31e..f9222769d84b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 20a16a304f89..44459b36d333 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -181,7 +181,8 @@ struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 	if (!(cfg & HPET_TN_FSB_CAP))
 		return NULL;
 
-	hdata = kzalloc(sizeof(*hdata), GFP_KERNEL);
+	hdata = kzalloc(sizeof(struct hpet_hld_data) + cpumask_size(),
+			GFP_KERNEL);
 	if (!hdata)
 		return NULL;
 
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
new file mode 100644
index 000000000000..c20b378b8c0c
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hardlockup detector driven by an HPET timer.
+ *
+ * Copyright (C) Intel Corporation 2019
+ *
+ * A hardlockup detector driven by an HPET timer. It implements the same
+ * interfaces as the PERF-based hardlockup detector.
+ *
+ * A single HPET timer is used to monitor all the CPUs from the allowed_mask
+ * from kernel/watchdog.c. Thus, the timer is programmed to expire every
+ * watchdog_thresh/cpumask_weight(watchdog_allowed_cpumask). The timer targets
+ * CPUs in round robin manner. Thus, every cpu in watchdog_allowed_mask is
+ * monitored every watchdog_thresh seconds.
+ */
+
+#define pr_fmt(fmt) "NMI hpet watchdog: " fmt
+
+#include <linux/nmi.h>
+#include <linux/hpet.h>
+#include <asm/msidef.h>
+#include <asm/hpet.h>
+
+static struct hpet_hld_data *hld_data;
+static bool hardlockup_use_hpet;
+
+/**
+ * kick_timer() - Reprogram timer to expire in the future
+ * @hdata:	A data structure with the timer instance to update
+ * @force:	Force reprogramming
+ *
+ * Reprogram the timer to expire within watchdog_thresh seconds in the future.
+ * If the timer supports periodic mode, it is not kicked unless @force is
+ * true.
+ */
+static void kick_timer(struct hpet_hld_data *hdata, bool force)
+{
+	bool kick_needed = force || !(hdata->has_periodic);
+	u64 new_compare, count, period = 0;
+
+	/*
+	 * Update the comparator in increments of watch_thresh seconds relative
+	 * to the current count. Since watch_thresh is given in seconds, we
+	 * are able to update the comparator before the counter reaches such new
+	 * value.
+	 *
+	 * Let it wrap around if needed.
+	 */
+
+	if (!kick_needed)
+		return;
+
+	if (hdata->has_periodic)
+		period = watchdog_thresh * hdata->ticks_per_second;
+
+	count = hpet_readl(HPET_COUNTER);
+	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+	hpet_set_comparator(hdata->num, (u32)new_compare, (u32)period);
+}
+
+static void disable_timer(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v &= ~HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+static void enable_timer(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v |= HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * is_hpet_wdt_interrupt() - Check if an HPET timer caused the interrupt
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * Returns:
+ * True if the HPET watchdog timer caused the interrupt. False otherwise.
+ */
+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+	return false;
+}
+
+/**
+ * compose_msi_msg() - Populate address and data fields of an MSI message
+ * @hdata:	A data strucure with the message to populate
+ *
+ * Initialize the fields of the MSI message to deliver an NMI interrupt. This
+ * function only initialize the files that don't change during the operation of
+ * of the detector. This function does not populate the Destination ID; which
+ * should be populated using update_msi_destid().
+ */
+static void compose_msi_msg(struct hpet_hld_data *hdata)
+{
+	struct msi_msg *msg = &hdata->msi_msg;
+
+	/*
+	 * The HPET FSB Interrupt Route register does not have an
+	 * address_hi part.
+	 */
+	msg->address_lo = MSI_ADDR_BASE_LO;
+
+	if (apic->irq_dest_mode == 0)
+		msg->address_lo |= MSI_ADDR_DEST_MODE_PHYSICAL;
+	else
+		msg->address_lo |= MSI_ADDR_DEST_MODE_LOGICAL;
+
+	msg->address_lo |= MSI_ADDR_REDIRECTION_CPU;
+
+	/*
+	 * On edge trigger, we don't care about assert level. Also,
+	 * since delivery mode is NMI, no irq vector is needed.
+	 */
+	msg->data = MSI_DATA_TRIGGER_EDGE | MSI_DATA_LEVEL_ASSERT |
+		    MSI_DATA_DELIVERY_NMI;
+}
+
+/** update_msi_destid() - Update APIC destid of handling CPU
+ * @hdata:	A data strucure with the MSI message to update
+ *
+ * Update the APIC destid of the MSI message generated by the HPET timer
+ * on expiration.
+ */
+static int update_msi_destid(struct hpet_hld_data *hdata)
+{
+	u32 destid;
+
+	hdata->msi_msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
+	destid = apic->calc_dest_apicid(hdata->handling_cpu);
+	hdata->msi_msg.address_lo |= MSI_ADDR_DEST_ID(destid);
+
+	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
+
+	return 0;
+}
+
+/**
+ * hardlockup_detector_nmi_handler() - NMI Interrupt handler
+ * @type:	Type of NMI handler; not used.
+ * @regs:	Register values as seen when the NMI was asserted
+ *
+ * Check if it was caused by the expiration of the HPET timer. If yes, inspect
+ * for lockups. Also, prepare the HPET timer to target the next monitored CPU
+ * and kick it.
+ *
+ * Returns:
+ * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
+ * otherwise.
+ */
+static int hardlockup_detector_nmi_handler(unsigned int type,
+					   struct pt_regs *regs)
+{
+	struct hpet_hld_data *hdata = hld_data;
+	u32 cpu = smp_processor_id();
+
+	if (!is_hpet_wdt_interrupt(hdata))
+		return NMI_DONE;
+
+	inspect_for_hardlockups(regs);
+
+	cpu = cpumask_next(cpu, to_cpumask(hdata->cpu_monitored_mask));
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(to_cpumask(hdata->cpu_monitored_mask));
+
+	hdata->handling_cpu = cpu;
+	update_msi_destid(hdata);
+	kick_timer(hdata, !(hdata->has_periodic));
+
+	return NMI_HANDLED;
+}
+
+/**
+ * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the HPET timer to deliver interrupts via the Front-
+ * Side Bus.
+ *
+ * Returns:
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
+{
+	u32 v;
+
+	compose_msi_msg(hdata);
+	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->num));
+	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
+
+	/*
+	 * Since FSB interrupt delivery is used, configure as edge-triggered
+	 * interrupt.
+	 */
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v &= ~HPET_TN_LEVEL;
+	v |= HPET_TN_FSB;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+
+	return 0;
+}
+
+/**
+ * setup_hpet_irq() - Configure the interrupt delivery of an HPET timer
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the interrupt parameters of an HPET timer. If supported, configure
+ * interrupts to be delivered via the Front-Side Bus. Also, install an interrupt
+ * handler.
+ *
+ * Returns:
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_hpet_irq(struct hpet_hld_data *hdata)
+{
+	int ret;
+
+	ret = setup_irq_msi_mode(hdata);
+	if (ret)
+		return ret;
+
+	ret = register_nmi_handler(NMI_WATCHDOG,
+				   hardlockup_detector_nmi_handler, 0,
+				   "hpet_hld");
+
+	return ret;
+}
+
+/**
+ * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
+ * @cpu:	CPU Index in which the watchdog will be enabled.
+ *
+ * Enable the hardlockup detector in @cpu. This means adding it to the
+ * cpumask of monitored CPUs. If @cpu is the first one for which the
+ * hardlockup detector is enabled, enable and kick the timer.
+ */
+void hardlockup_detector_hpet_enable(unsigned int cpu)
+{
+	cpumask_set_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
+
+	if (!hld_data->enabled_cpus++) {
+		hld_data->handling_cpu = cpu;
+		update_msi_destid(hld_data);
+		/* Force timer kick when detector is just enabled */
+		kick_timer(hld_data, true);
+		enable_timer(hld_data);
+	}
+}
+
+/**
+ * hardlockup_detector_hpet_disable() - Disable the hardlockup detector
+ * @cpu:	CPU index in which the watchdog will be disabled
+ *
+ * @cpu is removed from the cpumask of monitored CPUs. If @cpu is also the CPU
+ * handling the timer interrupt, update it to be the next available, monitored,
+ * CPU.
+ */
+void hardlockup_detector_hpet_disable(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, to_cpumask(hld_data->cpu_monitored_mask));
+	hld_data->enabled_cpus--;
+
+	if (hld_data->handling_cpu != cpu)
+		return;
+
+	disable_timer(hld_data);
+	if (!hld_data->enabled_cpus)
+		return;
+
+	cpu = cpumask_first(to_cpumask(hld_data->cpu_monitored_mask));
+	hld_data->handling_cpu = cpu;
+	update_msi_destid(hld_data);
+	enable_timer(hld_data);
+}
+
+void hardlockup_detector_hpet_stop(void)
+{
+	disable_timer(hld_data);
+}
+
+/**
+ * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
+ *
+ * Only initialize and configure the detector if an HPET is available on the
+ * system.
+ *
+ * Returns:
+ * 0 success. An error code if initialization was unsuccessful.
+ */
+int __init hardlockup_detector_hpet_init(void)
+{
+	int ret;
+	u32 v;
+
+	if (!hardlockup_use_hpet)
+		return -ENODEV;
+
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	if (check_tsc_unstable())
+		return -ENODEV;
+
+	hld_data = hpet_hardlockup_detector_assign_timer();
+	if (!hld_data)
+		return -ENODEV;
+
+	disable_timer(hld_data);
+
+	ret = setup_hpet_irq(hld_data);
+	if (ret) {
+		kfree(hld_data);
+		hld_data = NULL;
+	}
+
+	v = hpet_readl(HPET_Tn_CFG(hld_data->num));
+	v |= HPET_TN_32BIT;
+
+	if (hld_data->has_periodic)
+		v |= HPET_TN_PERIODIC;
+	else
+		v &= ~HPET_TN_PERIODIC;
+
+	hpet_writel(v, HPET_Tn_CFG(hld_data->num));
+
+	return ret;
+}
-- 
2.17.1

