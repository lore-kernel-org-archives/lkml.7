Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B78C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17211218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfGDQfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:35:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfGDQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gL-0005fW-2e; Thu, 04 Jul 2019 18:34:01 +0200
Message-Id: <20190704155609.143792082@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 09/25] x86/apic: Consolidate the apic local headers
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are three small local headers. Some contain functions which are
only used in one source file.

Move all the inlines and declarations into a single local header and the
inlines which are only used in one source file into that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic_flat_64.c   |    3 -
 arch/x86/kernel/apic/apic_flat_64.h   |    8 ---
 arch/x86/kernel/apic/apic_numachip.c  |    3 -
 arch/x86/kernel/apic/bigsmp_32.c      |    2 
 arch/x86/kernel/apic/ipi.c            |   14 ++++-
 arch/x86/kernel/apic/ipi.h            |   90 ----------------------------------
 arch/x86/kernel/apic/local.h          |   63 +++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c       |    3 -
 arch/x86/kernel/apic/probe_64.c       |    2 
 arch/x86/kernel/apic/x2apic.h         |    9 ---
 arch/x86/kernel/apic/x2apic_cluster.c |    2 
 arch/x86/kernel/apic/x2apic_phys.c    |    3 -
 12 files changed, 83 insertions(+), 119 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -15,8 +15,7 @@
 #include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
-#include "apic_flat_64.h"
-#include "ipi.h"
+#include "local.h"
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
--- a/arch/x86/kernel/apic/apic_flat_64.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_APIC_FLAT_64_H
-#define _ASM_X86_APIC_FLAT_64_H
-
-extern void flat_init_apic_ldr(void);
-
-#endif
-
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -18,8 +18,7 @@
 
 #include <asm/pgtable.h>
 
-#include "apic_flat_64.h"
-#include "ipi.h"
+#include "local.h"
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -10,7 +10,7 @@
 
 #include <asm/apic.h>
 
-#include "ipi.h"
+#include "local.h"
 
 static unsigned bigsmp_get_apic_id(unsigned long x)
 {
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,10 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/cpumask.h>
+#include <linux/smp.h>
 
-#include <asm/apic.h>
+#include "local.h"
 
-#include "ipi.h"
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
 
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
 {
--- a/arch/x86/kernel/apic/ipi.h
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
--- /dev/null
+++ b/arch/x86/kernel/apic/local.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Historical copyright notices:
+ *
+ * Copyright 2004 James Cleverdon, IBM.
+ * (c) 1995 Alan Cox, Building #3 <alan@redhat.com>
+ * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
+ * (c) 2002,2003 Andi Kleen, SuSE Labs.
+ */
+#include <asm/apic.h>
+
+/* APIC flat 64 */
+void flat_init_apic_ldr(void);
+
+/* X2APIC */
+int x2apic_apic_id_valid(u32 apicid);
+int x2apic_apic_id_registered(void);
+void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
+unsigned int x2apic_get_apic_id(unsigned long id);
+u32 x2apic_set_apic_id(unsigned int id);
+int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+void x2apic_send_IPI_self(int vector);
+
+/* IPI */
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
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
+
+/*
+ * This is used to send an IPI with no shorthand notation (the destination is
+ * specified in bits 56 to 63 of the ICR).
+ */
+void __default_send_IPI_dest_field(unsigned int mask, int vector, unsigned int dest);
+
+void default_send_IPI_single(int cpu, int vector);
+void default_send_IPI_single_phys(int cpu, int vector);
+void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
+
+extern int no_broadcast;
+
+#ifdef CONFIG_X86_32
+void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
+void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
+void default_send_IPI_allbutself(int vector);
+void default_send_IPI_all(int vector);
+void default_send_IPI_self(int vector);
+#endif
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -8,11 +8,12 @@
  */
 #include <linux/export.h>
 #include <linux/errno.h>
+#include <linux/smp.h>
 
 #include <asm/apic.h>
 #include <asm/acpi.h>
 
-#include "ipi.h"
+#include "local.h"
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -10,7 +10,7 @@
  */
 #include <asm/apic.h>
 
-#include "ipi.h"
+#include "local.h"
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
--- a/arch/x86/kernel/apic/x2apic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* Common bits for X2APIC cluster/physical modes. */
-
-int x2apic_apic_id_valid(u32 apicid);
-int x2apic_apic_id_registered(void);
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
-unsigned int x2apic_get_apic_id(unsigned long id);
-u32 x2apic_set_apic_id(unsigned int id);
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
-void x2apic_send_IPI_self(int vector);
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -7,7 +7,7 @@
 
 #include <asm/apic.h>
 
-#include "x2apic.h"
+#include "local.h"
 
 struct cluster_mask {
 	unsigned int	clusterid;
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -3,8 +3,7 @@
 #include <linux/cpumask.h>
 #include <linux/acpi.h>
 
-#include "x2apic.h"
-#include "ipi.h"
+#include "local.h"
 
 int x2apic_phys;
 


