Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B36C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BC8218BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGDQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfGDQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:03 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gK-0005fH-1I; Thu, 04 Jul 2019 18:34:00 +0200
Message-Id: <20190704155608.942106985@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 07/25] x86/apic: Move ipi header into apic directory
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only used locally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/ipi.h           |   90 -----------------------------------
 arch/x86/kernel/apic/apic_flat_64.c  |    3 -
 arch/x86/kernel/apic/apic_numachip.c |    3 -
 arch/x86/kernel/apic/bigsmp_32.c     |    9 ---
 arch/x86/kernel/apic/ipi.c           |    3 -
 arch/x86/kernel/apic/ipi.h           |   90 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c      |    3 -
 arch/x86/kernel/apic/probe_64.c      |    3 -
 arch/x86/kernel/apic/x2apic_phys.c   |    3 -
 9 files changed, 103 insertions(+), 104 deletions(-)

--- a/arch/x86/include/asm/ipi.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _ASM_X86_IPI_H
-#define _ASM_X86_IPI_H
-
-#ifdef CONFIG_X86_LOCAL_APIC
-
-/*
- * Copyright 2004 James Cleverdon, IBM.
- *
- * Generic APIC InterProcessor Interrupt code.
- *
- * Moved to include file by James Cleverdon from
- * arch/x86-64/kernel/smp.c
- *
- * Copyrights from kernel/smp.c:
- *
- * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
- * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
- * (c) 2002,2003 Andi Kleen, SuSE Labs.
- */
-
-#include <asm/hw_irq.h>
-#include <asm/apic.h>
-#include <asm/smp.h>
-
-/*
- * the following functions deal with sending IPIs between CPUs.
- *
- * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
- */
-
-static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
-					 unsigned int dest)
-{
-	unsigned int icr = shortcut | dest;
-
-	switch (vector) {
-	default:
-		icr |= APIC_DM_FIXED | vector;
-		break;
-	case NMI_VECTOR:
-		icr |= APIC_DM_NMI;
-		break;
-	}
-	return icr;
-}
-
-static inline int __prepare_ICR2(unsigned int mask)
-{
-	return SET_APIC_DEST_FIELD(mask);
-}
-
-static inline void __xapic_wait_icr_idle(void)
-{
-	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
-		cpu_relax();
-}
-
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
-
-/*
- * This is used to send an IPI with no shorthand notation (the destination is
- * specified in bits 56 to 63 of the ICR).
- */
-void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest);
-
-extern void default_send_IPI_single(int cpu, int vector);
-extern void default_send_IPI_single_phys(int cpu, int vector);
-extern void default_send_IPI_mask_sequence_phys(const struct cpumask *mask,
-						 int vector);
-extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
-							 int vector);
-
-extern int no_broadcast;
-
-#ifdef CONFIG_X86_32
-extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
-							 int vector);
-extern void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
-							 int vector);
-extern void default_send_IPI_mask_logical(const struct cpumask *mask,
-						 int vector);
-extern void default_send_IPI_allbutself(int vector);
-extern void default_send_IPI_all(int vector);
-extern void default_send_IPI_self(int vector);
-#endif
-
-#endif
-
-#endif /* _ASM_X86_IPI_H */
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -15,7 +15,8 @@
 #include <asm/jailhouse_para.h>
 #include <asm/apic_flat_64.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -18,7 +18,8 @@
 
 #include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -4,18 +4,13 @@
  *
  * Drives the local APIC in "clustered mode".
  */
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/smp.h>
 
-#include <asm/apicdef.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 static unsigned bigsmp_get_apic_id(unsigned long x)
 {
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -3,7 +3,8 @@
 #include <linux/cpumask.h>
 
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
 {
--- /dev/null
+++ b/arch/x86/kernel/apic/ipi.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_X86_IPI_H
+#define _ASM_X86_IPI_H
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+/*
+ * Copyright 2004 James Cleverdon, IBM.
+ *
+ * Generic APIC InterProcessor Interrupt code.
+ *
+ * Moved to include file by James Cleverdon from
+ * arch/x86-64/kernel/smp.c
+ *
+ * Copyrights from kernel/smp.c:
+ *
+ * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
+ * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
+ * (c) 2002,2003 Andi Kleen, SuSE Labs.
+ */
+
+#include <asm/hw_irq.h>
+#include <asm/apic.h>
+#include <asm/smp.h>
+
+/*
+ * the following functions deal with sending IPIs between CPUs.
+ *
+ * We use 'broadcast', CPU->CPU IPIs and self-IPIs too.
+ */
+
+static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
+					 unsigned int dest)
+{
+	unsigned int icr = shortcut | dest;
+
+	switch (vector) {
+	default:
+		icr |= APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		icr |= APIC_DM_NMI;
+		break;
+	}
+	return icr;
+}
+
+static inline int __prepare_ICR2(unsigned int mask)
+{
+	return SET_APIC_DEST_FIELD(mask);
+}
+
+static inline void __xapic_wait_icr_idle(void)
+{
+	while (native_apic_mem_read(APIC_ICR) & APIC_ICR_BUSY)
+		cpu_relax();
+}
+
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
+
+/*
+ * This is used to send an IPI with no shorthand notation (the destination is
+ * specified in bits 56 to 63 of the ICR).
+ */
+void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest);
+
+extern void default_send_IPI_single(int cpu, int vector);
+extern void default_send_IPI_single_phys(int cpu, int vector);
+extern void default_send_IPI_mask_sequence_phys(const struct cpumask *mask,
+						 int vector);
+extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
+							 int vector);
+
+extern int no_broadcast;
+
+#ifdef CONFIG_X86_32
+extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
+							 int vector);
+extern void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask,
+							 int vector);
+extern void default_send_IPI_mask_logical(const struct cpumask *mask,
+						 int vector);
+extern void default_send_IPI_allbutself(int vector);
+extern void default_send_IPI_all(int vector);
+extern void default_send_IPI_self(int vector);
+#endif
+
+#endif
+
+#endif /* _ASM_X86_IPI_H */
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -11,7 +11,8 @@
 
 #include <asm/apic.h>
 #include <asm/acpi.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -9,7 +9,8 @@
  * James Cleverdon.
  */
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -3,9 +3,8 @@
 #include <linux/cpumask.h>
 #include <linux/acpi.h>
 
-#include <asm/ipi.h>
-
 #include "x2apic.h"
+#include "ipi.h"
 
 int x2apic_phys;
 


