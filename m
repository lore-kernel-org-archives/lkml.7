Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620F218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfCOUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:07:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:22898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCOUHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 13:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="307617697"
Received: from chang-linux-3.sc.intel.com ([143.183.85.65])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2019 13:07:01 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [RESEND PATCH v6 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
Date:   Fri, 15 Mar 2019 13:06:37 -0700
Message-Id: <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper functions will switch on faster accesses to FSBASE and GSBASE
when the FSGSBASE feature is enabled.

Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
if the user GSBASE is saved at kernel entry, being updated as changes, and
restored back at kernel exit. However, it seems to spend more cycles for
savings and restorations. Little or no benefit was measured from
experiments.

Also, introduce __{rd,wr}gsbase_inactive() as helpers to access user GSBASE
with SWAPGS. Note, for Xen PV, paravirt hooks can be added, since it may
allow a very efficient but different implementation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Any Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/include/asm/fsgsbase.h | 27 +++++++---------
 arch/x86/kernel/process_64.c    | 56 +++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177499b4..aefd53767a5d 100644
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
index 6a62f4af9fcf..87b5ffce2a47 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -160,6 +160,42 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Interrupts are disabled here. Out of line to be protected
+ * from kprobes. It is not used on Xen paravirt. When paravirt
+ * support is needed, it needs to be renamed with native_ prefix.
+ */
+static noinline unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase, flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	gsbase = rdgsbase();
+	native_swapgs();
+	local_irq_restore(flags);
+
+	return gsbase;
+}
+NOKPROBE_SYMBOL(__rdgsbase_inactive);
+
+/*
+ * Interrupts are disabled here. Out of line to be protected
+ * from kprobes. It is not used on Xen paravirt. When paravirt
+ * support is needed, it needs to be renamed with native_ prefix.
+ */
+static noinline void __wrgsbase_inactive(unsigned long gsbase)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+	local_irq_restore(flags);
+}
+NOKPROBE_SYMBOL(__wrgsbase_inactive);
+
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -338,6 +374,26 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		gsbase = __rdgsbase_inactive();
+	else
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		__wrgsbase_inactive(gsbase);
+	else
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
-- 
2.19.1

