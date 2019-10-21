Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F70CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64782067B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfJVAEm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfJVAEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxC-00045w-FI; Tue, 22 Oct 2019 01:19:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 925891C04D3;
        Tue, 22 Oct 2019 01:19:07 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:07 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools arch x86: Grab a copy of the file containing
 the IRQ vector defines
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-z7gi058lzhnrm32slevg3xod@git.kernel.org>
References: <tip-z7gi058lzhnrm32slevg3xod@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994705.29376.10717273950729910695.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d2b72b7280370aaddcbe93d00939bc7ec21dda48
Gitweb:        https://git.kernel.org/tip/d2b72b7280370aaddcbe93d00939bc7ec21dda48
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 15:40:23 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 15:42:01 -03:00

tools arch x86: Grab a copy of the file containing the IRQ vector defines

We'll use it to generate a table and then convert the irq_vectors:*
tracepoint 'vector' arg in things like perf trace, script, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-z7gi058lzhnrm32slevg3xod@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/irq_vectors.h | 146 ++++++++++++++++++++++-
 tools/perf/check-headers.sh              |   1 +-
 2 files changed, 147 insertions(+)
 create mode 100644 tools/arch/x86/include/asm/irq_vectors.h

diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
new file mode 100644
index 0000000..889f8b1
--- /dev/null
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IRQ_VECTORS_H
+#define _ASM_X86_IRQ_VECTORS_H
+
+#include <linux/threads.h>
+/*
+ * Linux IRQ vector layout.
+ *
+ * There are 256 IDT entries (per CPU - each entry is 8 bytes) which can
+ * be defined by Linux. They are used as a jump table by the CPU when a
+ * given vector is triggered - by a CPU-external, CPU-internal or
+ * software-triggered event.
+ *
+ * Linux sets the kernel code address each entry jumps to early during
+ * bootup, and never changes them. This is the general layout of the
+ * IDT entries:
+ *
+ *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
+ *  Vectors  32 ... 127 : device interrupts
+ *  Vector  128         : legacy int80 syscall interface
+ *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
+ *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
+ *
+ * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
+ *
+ * This file enumerates the exact layout of them:
+ */
+
+#define NMI_VECTOR			0x02
+#define MCE_VECTOR			0x12
+
+/*
+ * IDT vectors usable for external interrupt sources start at 0x20.
+ * (0x80 is the syscall vector, 0x30-0x3f are for ISA)
+ */
+#define FIRST_EXTERNAL_VECTOR		0x20
+
+/*
+ * Reserve the lowest usable vector (and hence lowest priority)  0x20 for
+ * triggering cleanup after irq migration. 0x21-0x2f will still be used
+ * for device interrupts.
+ */
+#define IRQ_MOVE_CLEANUP_VECTOR		FIRST_EXTERNAL_VECTOR
+
+#define IA32_SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x30-0x3f are used for ISA interrupts.
+ *   round up to the next 16-vector boundary
+ */
+#define ISA_IRQ_VECTOR(irq)		(((FIRST_EXTERNAL_VECTOR + 16) & ~15) + irq)
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  some of the following vectors are 'rare', they are merged
+ *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
+ *  TLB, reschedule and local APIC vectors are performance-critical.
+ */
+
+#define SPURIOUS_APIC_VECTOR		0xff
+/*
+ * Sanity check
+ */
+#if ((SPURIOUS_APIC_VECTOR & 0x0F) != 0x0F)
+# error SPURIOUS_APIC_VECTOR definition error
+#endif
+
+#define ERROR_APIC_VECTOR		0xfe
+#define RESCHEDULE_VECTOR		0xfd
+#define CALL_FUNCTION_VECTOR		0xfc
+#define CALL_FUNCTION_SINGLE_VECTOR	0xfb
+#define THERMAL_APIC_VECTOR		0xfa
+#define THRESHOLD_APIC_VECTOR		0xf9
+#define REBOOT_VECTOR			0xf8
+
+/*
+ * Generic system vector for platform specific use
+ */
+#define X86_PLATFORM_IPI_VECTOR		0xf7
+
+/*
+ * IRQ work vector:
+ */
+#define IRQ_WORK_VECTOR			0xf6
+
+#define UV_BAU_MESSAGE			0xf5
+#define DEFERRED_ERROR_VECTOR		0xf4
+
+/* Vector on which hypervisor callbacks will be delivered */
+#define HYPERVISOR_CALLBACK_VECTOR	0xf3
+
+/* Vector for KVM to deliver posted interrupt IPI */
+#ifdef CONFIG_HAVE_KVM
+#define POSTED_INTR_VECTOR		0xf2
+#define POSTED_INTR_WAKEUP_VECTOR	0xf1
+#define POSTED_INTR_NESTED_VECTOR	0xf0
+#endif
+
+#define MANAGED_IRQ_SHUTDOWN_VECTOR	0xef
+
+#if IS_ENABLED(CONFIG_HYPERV)
+#define HYPERV_REENLIGHTENMENT_VECTOR	0xee
+#define HYPERV_STIMER0_VECTOR		0xed
+#endif
+
+#define LOCAL_TIMER_VECTOR		0xec
+
+#define NR_VECTORS			 256
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
+#else
+#define FIRST_SYSTEM_VECTOR		NR_VECTORS
+#endif
+
+/*
+ * Size the maximum number of interrupts.
+ *
+ * If the irq_desc[] array has a sparse layout, we can size things
+ * generously - it scales up linearly with the maximum number of CPUs,
+ * and the maximum number of IO-APICs, whichever is higher.
+ *
+ * In other cases we size more conservatively, to not create too large
+ * static arrays.
+ */
+
+#define NR_IRQS_LEGACY			16
+
+#define CPU_VECTOR_LIMIT		(64 * NR_CPUS)
+#define IO_APIC_VECTOR_LIMIT		(32 * MAX_IO_APICS)
+
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_PCI_MSI)
+#define NR_IRQS						\
+	(CPU_VECTOR_LIMIT > IO_APIC_VECTOR_LIMIT ?	\
+		(NR_VECTORS + CPU_VECTOR_LIMIT)  :	\
+		(NR_VECTORS + IO_APIC_VECTOR_LIMIT))
+#elif defined(CONFIG_X86_IO_APIC)
+#define	NR_IRQS				(NR_VECTORS + IO_APIC_VECTOR_LIMIT)
+#elif defined(CONFIG_PCI_MSI)
+#define NR_IRQS				(NR_VECTORS + CPU_VECTOR_LIMIT)
+#else
+#define NR_IRQS				NR_IRQS_LEGACY
+#endif
+
+#endif /* _ASM_X86_IRQ_VECTORS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 93c46d3..48290a0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -28,6 +28,7 @@ arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
 arch/x86/include/asm/inat_types.h
+arch/x86/include/asm/irq_vectors.h
 arch/x86/include/asm/msr-index.h
 arch/x86/include/uapi/asm/prctl.h
 arch/x86/lib/x86-opcode-map.txt
