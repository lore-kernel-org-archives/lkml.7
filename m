Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EEEECE596
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE69221924
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cazKxs+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfJHWlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:12 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34328 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfJHWlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:10 -0400
Received: by mail-pg1-f201.google.com with SMTP id g15so246069pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8ud+ZyVKVzp8perwrvpDLfe0HIBghmzVmkhv8miUgms=;
        b=cazKxs+dARL2RI/9v+6T4IH1qeNG80YgHPhtpsqSoRdywa37yWDAzufmjPq3q4zjRt
         mxZtg5BXBkt3cGmMO1WJH+hArzpnDv9NOtopk8G93ZdjLSHGGUNiRSL9Bf2xAdTtgPMP
         jy+CdsrQLs3ORU+3vEd0a8DjbuKefTlFIs+IAwBp3PZBYBEsg7Y4FY8Ex+V/1f9cHL0e
         WQR6pLqvs/CRRxLeDbHTtUOGKm8gVxXHwj+zhk5VOa/d1w7XkpwmMv3jxOYeU0X19TYd
         MnXWvhn+R0YJ3Oc24q/5MRtT9dEmmEpFn/1dslHDxwuUcKwB9M/ckj+BYHJiMP3683s3
         d78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8ud+ZyVKVzp8perwrvpDLfe0HIBghmzVmkhv8miUgms=;
        b=JOtnLzmLNjLZRyHEYhlwhm5UBUGBSjmX93XyFGX/ZeHvAUn8HbhuGRtWaH9+sSQZXx
         u92j5c6kNWEVFJfSLMqxxSDKH4zu9nYGoNjRRHxUpGqhVI3SZlnjHDfNMzL6VTdPLS73
         YE1otezlrnYYcEzfnJiVj64Acep18E3Ej0qqx4yenHdy0Aof9PkpGb69SgwUYU6X0xhC
         dfpF+0g1EzOUxicHVDtNHkSeXcWZJioJxxUCZDoA3mQX650R+RSGelqCXFVZY239nJos
         cKbXDQREPFI+aamuWVc3MnbywyUDLTj1dCtOiVTwQqGeXs5snnLdh5aCZk+dg3+DjueK
         P0AA==
X-Gm-Message-State: APjAAAXLgEpEmkmmLgwEK+IEyIhr0n5azreDpskmIqEcmxk6j1tRvJR9
        cHUHkapaK5C6Bjc/Iv2H+8n23koIdodz8P+pQRE=
X-Google-Smtp-Source: APXvYqyPO9y6IbR8kAC3KisSZXK6hnqGwFIgbID/zGCFGrIe+I9w1LI4Fv1BBV0NcPmFd/SPvZo5Qg1FSec5m8cW4Dw=
X-Received: by 2002:a63:e013:: with SMTP id e19mr871840pgh.274.1570574469068;
 Tue, 08 Oct 2019 15:41:09 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:48 -0700
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 4/5] x86: use the correct function type for sys_ni_syscall
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
 arch/x86/entry/syscall_32.c            |  8 +++-----
 arch/x86/entry/syscall_64.c            | 14 ++++++++++----
 arch/x86/entry/syscalls/syscall_32.tbl |  4 ++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index aa3336a7cb15..7d17b3addbbb 100644
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
index b1bf31713374..adf619a856e8 100644
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
index 2de75fda1d20..15908eb9b17e 100644
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
2.23.0.581.g78d2f28ef7-goog

