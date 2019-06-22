Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E3C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265120665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="y2E8XlKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFVKI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:08:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:08:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA7dNL2096180
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:07:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA7dNL2096180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198059;
        bh=ibOFgSb/u+fjBRekLJqG7MSpW+l3TBIfNynhEDNqUho=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=y2E8XlKylqBJ/5WcXuxZ/EMkVFCCy4jSI5n2l6cq+wK1AAeOk1UdxIqxyOGA3H5z8
         5sNmzGpMyKB4yG5C96z/GYcRfx/scnE9T+KckQP3o9WEHREdNWwz8dsNnCzuYmzpY9
         JTLn9m/qbgF+SIsFuZBWYdCIyr36yjPSafGfgAI3I5P3g7XEH+Y6cIVjFSQuB66crq
         eMAWgI0ehxJNPLCcjPi5vx0q0euF5dM7cnAm2pxEqZyYvLAUcIiUm6br9Q9wv3FszD
         +zOFr4Dhgw8w9ljtuLckaqoIXzuY8eIk83kGB45UBZ3zywR9cwhsW6cPgCAumyOn8G
         TBR/QVCk3BGHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA7cQq2096174;
        Sat, 22 Jun 2019 03:07:38 -0700
Date:   Sat, 22 Jun 2019 03:07:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-a86b4625138d39e97b4cc254fc9c4bb9e1dc4542@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, andrew.cooper3@citrix.com,
        hpa@zytor.com, ravi.v.shankar@intel.com, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, luto@kernel.org
Reply-To: hpa@zytor.com, andrew.cooper3@citrix.com,
          chang.seok.bae@intel.com, ravi.v.shankar@intel.com,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          luto@kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1557309753-24073-7-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-7-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/fsgsbase/64: Enable FSGSBASE instructions in
 helper functions
Git-Commit-ID: a86b4625138d39e97b4cc254fc9c4bb9e1dc4542
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

Commit-ID:  a86b4625138d39e97b4cc254fc9c4bb9e1dc4542
Gitweb:     https://git.kernel.org/tip/a86b4625138d39e97b4cc254fc9c4bb9e1dc4542
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:52 +0200

x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions

Add cpu feature conditional FSGSBASE access to the relevant helper
functions. That allows to accelerate certain FS/GS base operations in
subsequent changes.

Note, that while possible, the user space entry/exit GSBASE operations are
not going to use the new FSGSBASE instructions. The reason is that it would
require additional storage for the user space value which adds more
complexity to the low level code and experiments have shown marginal
benefit. This may be revisited later but for now the SWAPGS based handling
in the entry code is preserved except for the paranoid entry/exit code.

To preserve the SWAPGS entry mechanism introduce __[rd|wr]gsbase_inactive()
helpers. Note, for Xen PV, paravirt hooks can be added later as they might
allow a very efficient but different implementation.

[ tglx: Massaged changelog ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-7-git-send-email-chang.seok.bae@intel.com

---
 arch/x86/include/asm/fsgsbase.h | 27 ++++++++---------
 arch/x86/kernel/process_64.c    | 66 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 15 deletions(-)

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
index 250e4c4ac6d9..c34ee0f72378 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -161,6 +161,40 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Out of line to be protected from kprobes. It is not used on Xen
+ * paravirt. When paravirt support is needed, it needs to be renamed
+ * with native_ prefix.
+ */
+static noinline unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase;
+
+	lockdep_assert_irqs_disabled();
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
+	lockdep_assert_irqs_disabled();
+
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+}
+NOKPROBE_SYMBOL(__wrgsbase_inactive);
+
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -339,6 +373,38 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
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
