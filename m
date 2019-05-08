Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED97C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C0C21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbfEHREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:04:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:26495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfEHRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697566"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH v7 06/18] x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
Date:   Wed,  8 May 2019 03:02:21 -0700
Message-Id: <1557309753-24073-7-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper functions will switch on faster accesses to FSBASE and
GSBASE when the FSGSBASE feature is enabled.

Accessing user GSBASE needs a couple of SWAPGS operations. It is
avoidable, if the user GSBASE is saved at kernel entry, being updated
as changes, and restored back at kernel exit.

However, this approach is more complicated than the SWAPGS-based.
SWAGPS is used to swap the content of GSBASE and MSR_KERNEL_GS_BASE,
contains the user space, on the transitions from and to user space.
Across context switches, MSR_KERNEL_GS_BASE has to be updated.

With FSGSBSE, the SWAPGS-based needs to be modified with using the
new instruction, on context switches and in the paranoid path for
performance and functionality. On the context switches, the MSR read
(or write) will be replaced by FSGSBASE instruction as shown in this
change. The following patch details the performance benefit with this.
In the paranoid path, the SWAPGS will not be used any more, as the
existing differentiation logic for kernel and user GS will be
broken. The paranoid path change will be also highlighed in the
followon patches.

Also, __{rd,wr}gsbase_inactive() are added as helpers to access user
GSBASE with SWAPGS. Note, for Xen PV, paravirt hooks can be added,
since it may allow a very efficient but different implementation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Any Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/include/asm/fsgsbase.h | 27 ++++++++----------
 arch/x86/kernel/process_64.c    | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177..aefd537 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -49,35 +49,32 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
 
 	return fsbase;
 }
 
-static inline unsigned long x86_gsbase_read_cpu_inactive(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-
-	return gsbase;
-}
-
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		wrfsbase(fsbase);
+	else
+		wrmsrl(MSR_FS_BASE, fsbase);
 }
 
-static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
-{
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
-}
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 32d12c6..17421c3 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -161,6 +161,36 @@ enum which_selector {
 };
 
 /*
+ * Out of line to be protected from kprobes. It is not used on Xen
+ * paravirt. When paravirt support is needed, it needs to be renamed
+ * with native_ prefix.
+ */
+static noinline unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase;
+
+	native_swapgs();
+	gsbase = rdgsbase();
+	native_swapgs();
+
+	return gsbase;
+}
+NOKPROBE_SYMBOL(__rdgsbase_inactive);
+
+/*
+ * Out of line to be protected from kprobes. It is not used on Xen
+ * paravirt. When paravirt support is needed, it needs to be renamed
+ * with native_ prefix.
+ */
+static noinline void __wrgsbase_inactive(unsigned long gsbase)
+{
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+}
+NOKPROBE_SYMBOL(__wrgsbase_inactive);
+
+/*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
  * It's forcibly inlined because it'll generate better code and this function
@@ -338,6 +368,38 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		/* Interrupts are disabled here. */
+		local_irq_save(flags);
+		gsbase = __rdgsbase_inactive();
+		local_irq_restore(flags);
+	} else {
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		/* Interrupts are disabled here. */
+		local_irq_save(flags);
+		__wrgsbase_inactive(gsbase);
+		local_irq_restore(flags);
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
-- 
2.7.4

