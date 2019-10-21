Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F78CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057EE21872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665203;
	bh=4F+42j2uRaytgggMA8FTxB05z1lZ6ltMnzNWkmjsaBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mOxHkvDTNZCH3XTylqOi92PYswhWdw7o6/Bd6O9f0gJQBIH9OGtHWeEgBElrz5uj+
	 Nxf9pLiIANiLMP5sa+KceF0fU6YD+7y/l1PgDVEq/PXM6oldv1HfUaqmTy5OAhKbNg
	 /MgWHC01MZ70uPNIEKSHWC92oHJK3X9vV+U8YFWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfJUNkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbfJUNj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1947121BE5;
        Mon, 21 Oct 2019 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665198;
        bh=4F+42j2uRaytgggMA8FTxB05z1lZ6ltMnzNWkmjsaBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjRz6knflWdL4V9pshprAKjgzJJJ1rh0fxRGdRVk9kEdsTL3/m1HG7XnWLYgLrzyX
         nCy/jaSlEe/w5di8P8Cs4RIAM+BM/G+vllgPg2xpGxXxJqp0w2rRCTDfx0kTAygwwQ
         wPJ1y9LLYIH9QsX7aCC4EIhDy2gsANDdE3JlpXIU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 23/57] tools arch x86: Grab a copy of the file containing the IRQ vector defines
Date:   Mon, 21 Oct 2019 10:38:00 -0300
Message-Id: <20191021133834.25998-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/arch/x86/include/asm/irq_vectors.h | 146 +++++++++++++++++++++++
 tools/perf/check-headers.sh              |   1 +
 2 files changed, 147 insertions(+)
 create mode 100644 tools/arch/x86/include/asm/irq_vectors.h

diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
new file mode 100644
index 000000000000..889f8b1b5b7f
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
index 93c46d38024e..48290a0c917c 100755
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
-- 
2.21.0

