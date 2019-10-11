Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E476214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfJKLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:22:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfJKLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:22:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIszi-0007Cp-FJ; Fri, 11 Oct 2019 13:22:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0ECBF1C0325;
        Fri, 11 Oct 2019 13:22:02 +0200 (CEST)
Date:   Fri, 11 Oct 2019 11:22:01 -0000
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] syscalls/x86: Use the correct function type for
 sys_ni_syscall
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191008224049.115427-5-samitolvanen@google.com>
References: <20191008224049.115427-5-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <157079292192.9978.16707723873924335711.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     f48f01a92cca09e86d46c91d8edf9d5a71c61727
Gitweb:        https://git.kernel.org/tip/f48f01a92cca09e86d46c91d8edf9d5a71c61727
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Tue, 08 Oct 2019 15:40:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Oct 2019 12:49:18 +02:00

syscalls/x86: Use the correct function type for sys_ni_syscall

Use the correct function type for sys_ni_syscall() in system
call tables to fix indirect call mismatches with Control-Flow
Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191008224049.115427-5-samitolvanen@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/syscall_32.c            |  8 +++-----
 arch/x86/entry/syscall_64.c            | 14 ++++++++++----
 arch/x86/entry/syscalls/syscall_32.tbl |  4 ++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index aa3336a..7d17b3a 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -10,13 +10,11 @@
 #ifdef CONFIG_IA32_EMULATION
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
-
-/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
-extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
-
+#define __sys_ni_syscall __ia32_sys_ni_syscall
 #else /* CONFIG_IA32_EMULATION */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __sys_ni_syscall sys_ni_syscall
 #endif /* CONFIG_IA32_EMULATION */
 
 #include <asm/syscalls_32.h>
@@ -29,6 +27,6 @@ __visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] = 
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_compat_max] = &sys_ni_syscall,
+	[0 ... __NR_syscall_compat_max] = &__sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index b1bf317..adf619a 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -4,11 +4,17 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
+#include <linux/syscalls.h>
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
-extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
+extern asmlinkage long sys_ni_syscall(void);
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return sys_ni_syscall();
+}
+
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 #define __SYSCALL_X32(nr, sym, qual) __SYSCALL_64(nr, sym, qual)
 #include <asm/syscalls_64.h>
@@ -23,7 +29,7 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
+	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
 
@@ -40,7 +46,7 @@ asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_syscall_x32_max+1] = {
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_x32_max] = &sys_ni_syscall,
+	[0 ... __NR_syscall_x32_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2de75fd..15908eb 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -124,7 +124,7 @@
 110	i386	iopl			sys_iopl			__ia32_sys_iopl
 111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
 112	i386	idle
-113	i386	vm86old			sys_vm86old			sys_ni_syscall
+113	i386	vm86old			sys_vm86old			__ia32_sys_ni_syscall
 114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
 115	i386	swapoff			sys_swapoff			__ia32_sys_swapoff
 116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
@@ -177,7 +177,7 @@
 163	i386	mremap			sys_mremap			__ia32_sys_mremap
 164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
 165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
-166	i386	vm86			sys_vm86			sys_ni_syscall
+166	i386	vm86			sys_vm86			__ia32_sys_ni_syscall
 167	i386	query_module
 168	i386	poll			sys_poll			__ia32_sys_poll
 169	i386	nfsservctl
