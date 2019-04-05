Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202CE21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfDEN75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:59:57 -0400
Received: from foss.arm.com ([217.140.101.70]:49048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDEN7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A707119BF;
        Fri,  5 Apr 2019 06:59:52 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D13C53F68F;
        Fri,  5 Apr 2019 06:59:48 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 02/21] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
Date:   Fri,  5 Apr 2019 14:59:17 +0100
Message-Id: <20190405135936.7266-3-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing all explicit mmiowb() calls from driver
code, implement a tracking system in asm-generic based loosely on the
PowerPC implementation. This allows architectures with a non-empty
mmiowb() definition to have the barrier automatically inserted in
spin_unlock() following a critical section containing an I/O write.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/mmiowb.h       | 63 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mmiowb_types.h | 12 ++++++++
 kernel/Kconfig.locks               |  7 +++++
 kernel/locking/spinlock.c          |  7 +++++
 4 files changed, 89 insertions(+)
 create mode 100644 include/asm-generic/mmiowb.h
 create mode 100644 include/asm-generic/mmiowb_types.h

diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
new file mode 100644
index 000000000000..9439ff037b2d
--- /dev/null
+++ b/include/asm-generic/mmiowb.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_MMIOWB_H
+#define __ASM_GENERIC_MMIOWB_H
+
+/*
+ * Generic implementation of mmiowb() tracking for spinlocks.
+ *
+ * If your architecture doesn't ensure that writes to an I/O peripheral
+ * within two spinlocked sections on two different CPUs are seen by the
+ * peripheral in the order corresponding to the lock handover, then you
+ * need to follow these FIVE easy steps:
+ *
+ * 	1. Implement mmiowb() (and arch_mmiowb_state() if you're fancy)
+ *	   in asm/mmiowb.h, then #include this file
+ *	2. Ensure your I/O write accessors call mmiowb_set_pending()
+ *	3. Select ARCH_HAS_MMIOWB
+ *	4. Untangle the resulting mess of header files
+ *	5. Complain to your architects
+ */
+#ifdef CONFIG_MMIOWB
+
+#include <linux/compiler.h>
+#include <asm-generic/mmiowb_types.h>
+
+#ifndef arch_mmiowb_state
+#include <asm/percpu.h>
+#include <asm/smp.h>
+
+DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+#define __mmiowb_state()	this_cpu_ptr(&__mmiowb_state)
+#else
+#define __mmiowb_state()	arch_mmiowb_state()
+#endif	/* arch_mmiowb_state */
+
+static inline void mmiowb_set_pending(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+	ms->mmiowb_pending = ms->nesting_count;
+}
+
+static inline void mmiowb_spin_lock(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+	ms->nesting_count++;
+}
+
+static inline void mmiowb_spin_unlock(void)
+{
+	struct mmiowb_state *ms = __mmiowb_state();
+
+	if (unlikely(ms->mmiowb_pending)) {
+		ms->mmiowb_pending = 0;
+		mmiowb();
+	}
+
+	ms->nesting_count--;
+}
+#else
+#define mmiowb_set_pending()		do { } while (0)
+#define mmiowb_spin_lock()		do { } while (0)
+#define mmiowb_spin_unlock()		do { } while (0)
+#endif	/* CONFIG_MMIOWB */
+#endif	/* __ASM_GENERIC_MMIOWB_H */
diff --git a/include/asm-generic/mmiowb_types.h b/include/asm-generic/mmiowb_types.h
new file mode 100644
index 000000000000..8eb0095655e7
--- /dev/null
+++ b/include/asm-generic/mmiowb_types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_MMIOWB_TYPES_H
+#define __ASM_GENERIC_MMIOWB_TYPES_H
+
+#include <linux/types.h>
+
+struct mmiowb_state {
+	u16	nesting_count;
+	u16	mmiowb_pending;
+};
+
+#endif	/* __ASM_GENERIC_MMIOWB_TYPES_H */
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index fbba478ae522..6ba2570eddad 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,3 +251,10 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+config ARCH_HAS_MMIOWB
+	bool
+
+config MMIOWB
+	def_bool y if ARCH_HAS_MMIOWB
+	depends on SMP
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d14dd6b..0ff08380f531 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -22,6 +22,13 @@
 #include <linux/debug_locks.h>
 #include <linux/export.h>
 
+#ifdef CONFIG_MMIOWB
+#ifndef arch_mmiowb_state
+DEFINE_PER_CPU(struct mmiowb_state, __mmiowb_state);
+EXPORT_PER_CPU_SYMBOL(__mmiowb_state);
+#endif
+#endif
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPT, because lockdep assumes that interrupts are
-- 
2.11.0

