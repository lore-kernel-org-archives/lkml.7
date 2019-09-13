Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42378C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1012C20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vx1JtXuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfIMVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:00:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49360 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:00:33 -0400
Received: by mail-qk1-f202.google.com with SMTP id n125so34260076qkc.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tHWqibxj44VBW2KrBTK8gRKer9OLMOmPBpYom2KakWE=;
        b=vx1JtXuc157hChWhOy2H1FzKcqNbiiDkkykMj+vw3wt+VeQuvDfvoXe1J4uNo1d3eT
         eKV/hiftzJVCemQssZgI4jTqPW/rcn9+7KB8/gq05NwdTtAT+AFETGLm2nDjgnhK9GeV
         EGpd94h7ua0ZfLGqxqDgc6oU6ISgLLZd8VHsuD1jh3KfUBvUNrUNbQXKgw0ZrhfPUe7+
         iX0wE1nxnDOLGvpwphngsK5s0enRSzsizDmMssb0U77spKdYJaqSfOY/k4zzuBomjbj+
         FGwXft9cD3stAcyRNswWm60SWwi7QR4GOSywoRZEYPT1Eboarh8rh0qbrqdyN3v/HLQj
         U84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tHWqibxj44VBW2KrBTK8gRKer9OLMOmPBpYom2KakWE=;
        b=akXbBRKse48hRPKHA70fXCLI9zHUhLrogO3xJQkaiVsYDVr4+jpMP/fg9xahKQZR0V
         X39Thdc4HViYVa2T/kqkqo0bnUFP21cAjROYIDIYQhm5eMjiqJq/0D8YDAmRf+W9uvSQ
         gAU6r1u7eDM/hXxjtJCC6qOyEpF4Eg+KE70v/Plap1BJTPsCh+nrooJduhZOwAE3bvYy
         g9cKcN+e5pQPOlKANm2izG6Gxhy+XoCyXRnzyV+NKD/vhcLRM4vDnuxqbw647G1ZOMrC
         OwSwNWtGGwygc0HKeUhBXLrMzGwwqTqAYo+JUZnzd/8MRFrYU34gTJFFZIu0MPfSvOeT
         Yx2g==
X-Gm-Message-State: APjAAAXphx1i7ta8k+vV60HqsvFt9nrSrFL5V7xlbtXd6UzQqNnsVMkJ
        yT5rbZu6AHaFpaFgeUy0tdwtCMtHhq0xq9s+J8g=
X-Google-Smtp-Source: APXvYqwERGBM683+CJasc2yCWpj5bxgYucD0QvRQBum02qkK+g5AYrIVP0xJ2LoordHvtbpULKuz09pqx+JWLg5+dRY=
X-Received: by 2002:a05:6214:1264:: with SMTP id r4mr32009045qvv.64.1568408431106;
 Fri, 13 Sep 2019 14:00:31 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:00:17 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20190913210018.125266-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 3/4] x86: use the correct function type for sys_ni_syscall
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct function type for sys_ni_syscall in system
call tables to fix indirect call mismatches with Control-Flow
Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/syscall_32.c            | 13 ++++++++++---
 arch/x86/entry/syscall_64.c            | 12 +++++++++---
 arch/x86/entry/syscalls/syscall_32.tbl |  4 ++--
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index aa3336a7cb15..1cbdfff116d1 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -11,12 +11,19 @@
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 
-/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
-extern asmlinkage long sys_ni_syscall(const struct pt_regs *);
+extern asmlinkage long sys_ni_syscall(void);
+
+asmlinkage long __ia32_sys_ni_syscall(const struct pt_regs *__unused)
+{
+	return sys_ni_syscall();
+}
+
+#define __sys_ni_syscall __ia32_sys_ni_syscall
 
 #else /* CONFIG_IA32_EMULATION */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __sys_ni_syscall sys_ni_syscall
 #endif /* CONFIG_IA32_EMULATION */
 
 #include <asm/syscalls_32.h>
@@ -29,6 +36,6 @@ __visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] =
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_compat_max] = &sys_ni_syscall,
+	[0 ... __NR_syscall_compat_max] = &__sys_ni_syscall,
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index d5252bc1e380..0341b3e7fede 100644
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
+asmlinkage long __x64_sys_ni_syscall(const struct pt_regs *__unused)
+{
+	return sys_ni_syscall();
+}
+
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
@@ -20,6 +26,6 @@ asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	 * Smells like a compiler bug -- it doesn't work
 	 * when the & below is removed.
 	 */
-	[0 ... __NR_syscall_max] = &sys_ni_syscall,
+	[0 ... __NR_syscall_max] = &__x64_sys_ni_syscall,
 #include <asm/syscalls_64.h>
 };
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c00019abd076..9514f2fe456a 100644
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
-- 
2.23.0.237.gc6a4ce50a0-goog

