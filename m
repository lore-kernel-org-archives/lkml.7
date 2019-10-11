Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF7C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09761214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfJKLWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:22:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfJKLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:22:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIszi-0007D1-Pg; Fri, 11 Oct 2019 13:22:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 657391C0178;
        Fri, 11 Oct 2019 13:22:02 +0200 (CEST)
Date:   Fri, 11 Oct 2019 11:22:02 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] syscalls/x86: Wire up COMPAT_SYSCALL_DEFINE0
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191008224049.115427-3-samitolvanen@google.com>
References: <20191008224049.115427-3-samitolvanen@google.com>
MIME-Version: 1.0
Message-ID: <157079292227.9978.612006427333892080.tip-bot2@tip-bot2>
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

Commit-ID:     cf3b83e19d7c928e05a5d193c375463182c6029a
Gitweb:        https://git.kernel.org/tip/cf3b83e19d7c928e05a5d193c375463182c6029a
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 08 Oct 2019 15:40:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Oct 2019 12:49:18 +02:00

syscalls/x86: Wire up COMPAT_SYSCALL_DEFINE0

x86 has special handling for COMPAT_SYSCALL_DEFINEx, but there was
no override for COMPAT_SYSCALL_DEFINE0.  Wire it up so that we can
use it for rt_sigreturn.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191008224049.115427-3-samitolvanen@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 32 +++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 90eb70d..3dab048 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -28,13 +28,21 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
+#define __IA32_COMPAT_SYS_STUB0(x, name)				\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();			\
+	}
+
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
@@ -76,15 +84,24 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
+#define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();\
+	}
+
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #else /* CONFIG_X86_X32 */
+#define __X32_COMPAT_SYS_STUB0(x, name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
@@ -95,6 +112,17 @@
  * mapping of registers to parameters, we need to generate stubs for each
  * of them.
  */
+#define COMPAT_SYSCALL_DEFINE0(name)					\
+	static long __se_compat_sys_##name(void);			\
+	static inline long __do_compat_sys_##name(void);		\
+	__IA32_COMPAT_SYS_STUB0(x, name)				\
+	__X32_COMPAT_SYS_STUB0(x, name)					\
+	static long __se_compat_sys_##name(void)			\
+	{								\
+		return __do_compat_sys_##name();			\
+	}								\
+	static inline long __do_compat_sys_##name(void)
+
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
