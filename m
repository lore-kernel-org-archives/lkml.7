Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1F0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FECC2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014272;
	bh=U9BNCHPmYuZnrtHrBx88BCeEEwo02lL9ebLIPtJWHCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfVufvlfGf6CO0ZXnT08X7YMAE69GFClv9NUky2Ak8sfUatT5xPHLLXCxbkTxz9iL
	 l5qNw39bBphQgKVT3c51drz0vFLgcbGFwgdje0E0J3gMpvgT6XmxDpf91q3QrO80bx
	 QjWJ1KdLQt37N1Ma1z4JhmIeDTe8b8XT02NXspxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfLJVoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbfLJVdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8DF214AF;
        Tue, 10 Dec 2019 21:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013603;
        bh=U9BNCHPmYuZnrtHrBx88BCeEEwo02lL9ebLIPtJWHCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQKFC5MLfjx1WJma+/avB765Z9pz/hZCzgeAUDZZUub7jMseWfqYBj70dSZx6LMA+
         f0Xar9TV99N90YfJTvfOJBVLclIhxTv1h/Yb9T/OdRGwPhpR34ipzslHBlM6chCl6U
         ElHW5IMLhT26AYeINJm77ptCMRsn1skXvbGc6mfA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 051/177] syscalls/x86: Use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
Date:   Tue, 10 Dec 2019 16:30:15 -0500
Message-Id: <20191210213221.11921-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 00198a6eaf66609de5e4de9163bb42c7ca9dd7b7 ]

Use COMPAT_SYSCALL_DEFINE0 to define (rt_)sigreturn() syscalls to
replace sys32_sigreturn() and sys32_rt_sigreturn(). This fixes indirect
call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191008224049.115427-4-samitolvanen@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 4 ++--
 arch/x86/ia32/ia32_signal.c            | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d13..273e99c0b9110 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -130,7 +130,7 @@
 116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
 117	i386	ipc			sys_ipc				__ia32_compat_sys_ipc
 118	i386	fsync			sys_fsync			__ia32_sys_fsync
-119	i386	sigreturn		sys_sigreturn			sys32_sigreturn
+119	i386	sigreturn		sys_sigreturn			__ia32_compat_sys_sigreturn
 120	i386	clone			sys_clone			__ia32_compat_sys_x86_clone
 121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
 122	i386	uname			sys_newuname			__ia32_sys_newuname
@@ -184,7 +184,7 @@
 170	i386	setresgid		sys_setresgid16			__ia32_sys_setresgid16
 171	i386	getresgid		sys_getresgid16			__ia32_sys_getresgid16
 172	i386	prctl			sys_prctl			__ia32_sys_prctl
-173	i386	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
+173	i386	rt_sigreturn		sys_rt_sigreturn		__ia32_compat_sys_rt_sigreturn
 174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
 175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_sys_rt_sigprocmask
 176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 513ba49c204fe..35ddf2c9848c6 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -21,6 +21,7 @@
 #include <linux/personality.h>
 #include <linux/compat.h>
 #include <linux/binfmts.h>
+#include <linux/syscalls.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
 #include <asm/fpu/internal.h>
@@ -118,7 +119,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage long sys32_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
@@ -144,7 +145,7 @@ asmlinkage long sys32_sigreturn(void)
 	return 0;
 }
 
-asmlinkage long sys32_rt_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_ia32 __user *frame;
-- 
2.20.1

