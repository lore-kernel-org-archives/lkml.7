Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6AC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2308218D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfGDQeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59625 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfGDQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gJ-0005f2-Au; Thu, 04 Jul 2019 18:33:59 +0200
Message-Id: <20190704155608.834832034@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 06/25] x86/apic: Cleanup the include maze
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of these APIC files include the world and some more. Remove the
unneeded cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic_flat_64.c   |   15 ++++-----------
 arch/x86/kernel/apic/apic_noop.c      |   18 +-----------------
 arch/x86/kernel/apic/apic_numachip.c  |    6 +++---
 arch/x86/kernel/apic/ipi.c            |   15 +--------------
 arch/x86/kernel/apic/probe_32.c       |   18 ++----------------
 arch/x86/kernel/apic/probe_64.c       |   11 -----------
 arch/x86/kernel/apic/x2apic_cluster.c |   14 ++++++--------
 arch/x86/kernel/apic/x2apic_phys.c    |    9 +++------
 arch/x86/kernel/apic/x2apic_uv_x.c    |   28 ++++------------------------
 9 files changed, 24 insertions(+), 110 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,21 +8,14 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/acpi.h>
-#include <linux/errno.h>
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
 #include <linux/export.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
-#include <asm/ipi.h>
-#include <asm/apic.h>
-#include <asm/apic_flat_64.h>
 #include <asm/jailhouse_para.h>
+#include <asm/apic_flat_64.h>
+#include <asm/apic.h>
+#include <asm/ipi.h>
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -9,25 +9,9 @@
  * to not uglify the caller's code and allow to call (some) apic routines
  * like self-ipi, etc...
  */
-
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
 
-#include <linux/smp.h>
-#include <asm/ipi.h>
-
-#include <linux/interrupt.h>
-#include <asm/acpi.h>
-#include <asm/e820/api.h>
+#include <asm/apic.h>
 
 static void noop_init_apic_ldr(void) { }
 static void noop_send_IPI(int cpu, int vector) { }
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -10,15 +10,15 @@
  * Send feedback to <support@numascale.com>
  *
  */
-
+#include <linux/types.h>
 #include <linux/init.h>
 
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
-#include <asm/ipi.h>
+
 #include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
-#include <asm/pci_x86.h>
+#include <asm/ipi.h>
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -1,21 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/cpumask.h>
-#include <linux/interrupt.h>
 
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/spinlock.h>
-#include <linux/kernel_stat.h>
-#include <linux/mc146818rtc.h>
-#include <linux/cache.h>
-#include <linux/cpu.h>
+#include <linux/cpumask.h>
 
-#include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/tlbflush.h>
-#include <asm/mmu_context.h>
 #include <asm/apic.h>
-#include <asm/proto.h>
 #include <asm/ipi.h>
 
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -6,26 +6,12 @@
  *
  * Generic x86 APIC driver probe layer.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/init.h>
 #include <linux/errno.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
-#include <asm/apicdef.h>
-#include <asm/apic.h>
-#include <asm/setup.h>
-
-#include <linux/smp.h>
-#include <asm/ipi.h>
 
-#include <linux/interrupt.h>
+#include <asm/apic.h>
 #include <asm/acpi.h>
-#include <asm/e820/api.h>
+#include <asm/ipi.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -8,19 +8,8 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/threads.h>
-#include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/hardirq.h>
-#include <linux/dmar.h>
-
-#include <asm/smp.h>
 #include <asm/apic.h>
 #include <asm/ipi.h>
-#include <asm/setup.h>
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
-#include <linux/irq.h>
-#include <linux/cpu.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/apic.h>
 
-#include <asm/smp.h>
 #include "x2apic.h"
 
 struct cluster_mask {
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -1,13 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/threads.h>
+
 #include <linux/cpumask.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/ctype.h>
-#include <linux/dmar.h>
+#include <linux/acpi.h>
 
-#include <asm/smp.h>
 #include <asm/ipi.h>
+
 #include "x2apic.h"
 
 int x2apic_phys;
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -7,40 +7,20 @@
  *
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
+#include <linux/crash_dump.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
-#include <linux/hardirq.h>
 #include <linux/proc_fs.h>
-#include <linux/threads.h>
-#include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/export.h>
-#include <linux/string.h>
-#include <linux/ctype.h>
-#include <linux/sched.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/cpu.h>
-#include <linux/init.h>
-#include <linux/io.h>
 #include <linux/pci.h>
-#include <linux/kdebug.h>
-#include <linux/delay.h>
-#include <linux/crash_dump.h>
-#include <linux/reboot.h>
-#include <linux/memory.h>
-#include <linux/numa.h>
 
+#include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/uv_hub.h>
-#include <asm/current.h>
-#include <asm/pgtable.h>
 #include <asm/uv/bios.h>
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
-#include <asm/e820/api.h>
-#include <asm/ipi.h>
-#include <asm/smp.h>
-#include <asm/x86_init.h>
-#include <asm/nmi.h>
 
 DEFINE_PER_CPU(int, x2apic_extra_bits);
 


