Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05E9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE6920715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLWM2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:28:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLWM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:28:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ijMou-0002FA-Ui; Mon, 23 Dec 2019 13:28:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 76C311C0105;
        Mon, 23 Dec 2019 13:28:20 +0100 (CET)
Date:   Mon, 23 Dec 2019 12:28:20 -0000
From:   "tip-bot2 for Omar Sandoval" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/crash: Define arch_crash_save_vmcoreinfo() if
 CONFIG_CRASH_CORE=y
Cc:     Omar Sandoval <osandov@fb.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0589961254102cca23e3618b96541b89f2b249e2.1576858905.git.osandov@fb.com>
References: <0589961254102cca23e3618b96541b89f2b249e2.1576858905.git.osandov@fb.com>
MIME-Version: 1.0
Message-ID: <157710410032.30329.7180720417870538436.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     8757dc970f550dc399f899be0e7a2c00b7e82e8f
Gitweb:        https://git.kernel.org/tip/8757dc970f550dc399f899be0e7a2c00b7e82e8f
Author:        Omar Sandoval <osandov@fb.com>
AuthorDate:    Fri, 20 Dec 2019 08:22:49 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Dec 2019 12:58:41 +01:00

x86/crash: Define arch_crash_save_vmcoreinfo() if CONFIG_CRASH_CORE=y

On x86 kernels configured with CONFIG_PROC_KCORE=y and
CONFIG_KEXEC_CORE=n, the vmcoreinfo note in /proc/kcore is incomplete.

Specifically, it is missing arch-specific information like the KASLR
offset and whether 5-level page tables are enabled. This breaks
applications like drgn [1] and crash [2], which need this information
for live debugging via /proc/kcore.

This happens because:

1. CONFIG_PROC_KCORE selects CONFIG_CRASH_CORE.
2. kernel/crash_core.c (compiled if CONFIG_CRASH_CORE=y) calls
   arch_crash_save_vmcoreinfo() to get the arch-specific parts of
   vmcoreinfo. If it is not defined, then it uses a no-op fallback.
3. x86 defines arch_crash_save_vmcoreinfo() in
   arch/x86/kernel/machine_kexec_*.c, which is only compiled if
   CONFIG_KEXEC_CORE=y.

Therefore, an x86 kernel with CONFIG_CRASH_CORE=y and
CONFIG_KEXEC_CORE=n uses the no-op fallback and gets incomplete
vmcoreinfo data. This isn't relevant to kdump, which requires
CONFIG_KEXEC_CORE. It only affects applications which read vmcoreinfo at
runtime, like the ones mentioned above.

Fix it by moving arch_crash_save_vmcoreinfo() into two new
arch/x86/kernel/crash_core_*.c files, which are gated behind
CONFIG_CRASH_CORE.

1: https://github.com/osandov/drgn/blob/73dd7def1217e24cc83d8ca95c995decbd9ba24c/libdrgn/program.c#L385
2: https://github.com/crash-utility/crash/commit/60a42d709280cdf38ab06327a5b4fa9d9208ef86

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kairui Song <kasong@redhat.com>
Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/0589961254102cca23e3618b96541b89f2b249e2.1576858905.git.osandov@fb.com
---
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/crash_core_32.c    | 17 +++++++++++++++++
 arch/x86/kernel/crash_core_64.c    | 24 ++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_32.c | 12 ------------
 arch/x86/kernel/machine_kexec_64.c | 19 -------------------
 5 files changed, 42 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/kernel/crash_core_32.c
 create mode 100644 arch/x86/kernel/crash_core_64.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6175e37..9b294c1 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace_$(BITS).o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
+obj-$(CONFIG_CRASH_CORE)	+= crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
diff --git a/arch/x86/kernel/crash_core_32.c b/arch/x86/kernel/crash_core_32.c
new file mode 100644
index 0000000..c0159a7
--- /dev/null
+++ b/arch/x86/kernel/crash_core_32.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crash_core.h>
+
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+#ifdef CONFIG_X86_PAE
+	VMCOREINFO_CONFIG(X86_PAE);
+#endif
+}
diff --git a/arch/x86/kernel/crash_core_64.c b/arch/x86/kernel/crash_core_64.c
new file mode 100644
index 0000000..845a57e
--- /dev/null
+++ b/arch/x86/kernel/crash_core_64.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crash_core.h>
+
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	u64 sme_mask = sme_me_mask;
+
+	VMCOREINFO_NUMBER(phys_base);
+	VMCOREINFO_SYMBOL(init_top_pgt);
+	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
+			      pgtable_l5_enabled());
+
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
+	VMCOREINFO_NUMBER(sme_mask);
+}
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 7b45e8d..02bddfc 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -250,15 +250,3 @@ void machine_kexec(struct kimage *image)
 
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
-
-void arch_crash_save_vmcoreinfo(void)
-{
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-#ifdef CONFIG_X86_PAE
-	VMCOREINFO_CONFIG(X86_PAE);
-#endif
-}
-
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 16e125a..ad5cdd6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -398,25 +398,6 @@ void machine_kexec(struct kimage *image)
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
 
-void arch_crash_save_vmcoreinfo(void)
-{
-	u64 sme_mask = sme_me_mask;
-
-	VMCOREINFO_NUMBER(phys_base);
-	VMCOREINFO_SYMBOL(init_top_pgt);
-	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
-			pgtable_l5_enabled());
-
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-	vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
-			      kaslr_offset());
-	VMCOREINFO_NUMBER(KERNEL_IMAGE_SIZE);
-	VMCOREINFO_NUMBER(sme_mask);
-}
-
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
