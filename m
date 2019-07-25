Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC5C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E7921901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Aa+DbwoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfGYO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:27:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43113 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGYO1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:27:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEQlCE1039922
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:26:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEQlCE1039922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064808;
        bh=LMEmiqYkgV7cteSGb25uAeNNlBZmJOTr0jWXAVLTocs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Aa+DbwoLOPXPst0KWE++8/xp0liRM3A8DjRpULdz0pswqKHPFvpOnZKkDrBkwk6Th
         UOEvIxX9z4ojUu8QyoMnxuszS7ApnWw2NecaBsCVmn6z99q1/8fCDT+nKsJchbiCdP
         SpA8uapZwFJ5/NmGOJM6+5uM0VKNvUgOAHFf7QcOcBKLPT1IikuJaMNR57ED1aJ2mx
         Yt3rcG7CeekgmmYpI2Vdp0W5qvznFCCK4iuo9nLirTJG5xp2Ss/XKt9CXUOQeqv+f8
         vl0J8Oa6JfN8cKQiD0xTLd0RGtgLERD5w8A4WOfwfDJFrbJq0A0gAwJrguX8IE1nZS
         21Fj3dM2sj7OA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEQkN01039919;
        Thu, 25 Jul 2019 07:26:46 -0700
Date:   Thu, 25 Jul 2019 07:26:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c94f0718fb1c171d6dfdd69cb6001fa0d8206710@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190722105219.618612624@linutronix.de>
References: <20190722105219.618612624@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Consolidate the apic local headers
Git-Commit-ID: c94f0718fb1c171d6dfdd69cb6001fa0d8206710
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c94f0718fb1c171d6dfdd69cb6001fa0d8206710
Gitweb:     https://git.kernel.org/tip/c94f0718fb1c171d6dfdd69cb6001fa0d8206710
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:58 +0200

x86/apic: Consolidate the apic local headers

Now there are three small local headers. Some contain functions which are
only used in one source file.

Move all the inlines and declarations into a single local header and the
inlines which are only used in one source file into that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.618612624@linutronix.de

---
 arch/x86/kernel/apic/apic_flat_64.c   |  3 +-
 arch/x86/kernel/apic/apic_flat_64.h   |  8 ----
 arch/x86/kernel/apic/apic_numachip.c  |  3 +-
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/ipi.c            | 14 +++++-
 arch/x86/kernel/apic/ipi.h            | 90 -----------------------------------
 arch/x86/kernel/apic/local.h          | 63 ++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c       |  3 +-
 arch/x86/kernel/apic/probe_64.c       |  2 +-
 arch/x86/kernel/apic/x2apic.h         |  9 ----
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  3 +-
 12 files changed, 83 insertions(+), 119 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index cfee2e546531..f8594b844637 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.h b/arch/x86/kernel/apic/apic_flat_64.h
deleted file mode 100644
index d3a2b3876ce6..000000000000
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
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 09ec9ffb268e..cdf45b4700f2 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -18,8 +18,7 @@
 
 #include <asm/pgtable.h>
 
-#include "apic_flat_64.h"
-#include "ipi.h"
+#include "local.h"
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 2c031b75dfce..9703b552f25a 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -10,7 +10,7 @@
 
 #include <asm/apic.h>
 
-#include "ipi.h"
+#include "local.h"
 
 static unsigned bigsmp_get_apic_id(unsigned long x)
 {
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 0f26141d479c..6fa9f6ca7eef 100644
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
diff --git a/arch/x86/kernel/apic/ipi.h b/arch/x86/kernel/apic/ipi.h
deleted file mode 100644
index 8d4911b122f3..000000000000
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
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
new file mode 100644
index 000000000000..95adac0e785b
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
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 40b786e3427a..7cc961d4f51f 100644
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
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index 6268c487f963..e0e1e3380ea2 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -10,7 +10,7 @@
  */
 #include <asm/apic.h>
 
-#include "ipi.h"
+#include "local.h"
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
diff --git a/arch/x86/kernel/apic/x2apic.h b/arch/x86/kernel/apic/x2apic.h
deleted file mode 100644
index a49b3604027f..000000000000
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
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index ebde731dc4cf..d0a13c88f777 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -7,7 +7,7 @@
 
 #include <asm/apic.h>
 
-#include "x2apic.h"
+#include "local.h"
 
 struct cluster_mask {
 	unsigned int	clusterid;
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 3bde4724c1c7..5d50e1f9d4bf 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -3,8 +3,7 @@
 #include <linux/cpumask.h>
 #include <linux/acpi.h>
 
-#include "x2apic.h"
-#include "ipi.h"
+#include "local.h"
 
 int x2apic_phys;
 
