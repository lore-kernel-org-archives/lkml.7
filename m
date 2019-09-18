Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC52C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9B521925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEl7t1cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfIRWqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:46:30 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:57093 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbfIRWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:46:28 -0400
Received: by mail-vk1-f202.google.com with SMTP id o205so454651vka.23
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hxlPlftsTB4mok5rEJ9zfp3wbpIw6poo4y/CamTNGMY=;
        b=QEl7t1cKZyJlqs8xDT0JReRTmdSjaZMsLKAvxvjJ2cYK4TDFz2dlDkNfd/VhugwmqT
         Jt34oXAovYw1xS6fEX/XsRZybBkhabcLiVU0feJqFTGfblRS20rgHlGaqq0v6UKD2wAW
         GRsfHObsF6Dn5aG+lhm5/dooz6TQXXuhS/40a5A+2x8E73QgtFpVWCBHFGKy3OdQ9ha9
         Kv8kLTpo6IGSghwvHLqrzCItk1aBo+90VmBnQPq+3RLjneg9LhC8j8X8/WyHVrjgsA+2
         iti/lFEBGjd9oeAwKDHYe1JSVbvqk80XZ1IHvvJvQa1xwhghQ3oGV6ZpJvlHP8VFaDX5
         tHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hxlPlftsTB4mok5rEJ9zfp3wbpIw6poo4y/CamTNGMY=;
        b=Jii3/z2yT7nfzwGDq1g3MmYoGaxZ+rZQLp7E/vZDbVln4mQxgkKmRQ5uVwAQKn/JC8
         ib5m81fSawJwCx0VliSM1RopfaUzfbCiF+AOOPpUBA/9eASOEfsVBnS2MPjfn95VEeF/
         2lYzvgefjvQqcjYR7RdVf7Aqj4TcwzyPRxIPRqkrY8dZdBOedqsjswdo3fUqUepSPJev
         olgD0Pb4Js/mJe/dyfKAz1u0Z29v5iyTLjz6Y820HtaEI6uYKdpDhEP+TD0qRWID2idm
         satqCUVOSFqf2Wm6YdIxmXn1Vr8XFy4UiPof0lMCDeaVCfPbo1HMrdP2/PKXdTnt9Q+7
         YAkw==
X-Gm-Message-State: APjAAAWuOoqiGkEng1j2kxb2xx7qxqSImHJ4dAn3ad01J9z/glvGdvj/
        7wbP9IWiWZnBv3BpUm6JrtFGGE8V6jYeq0a3Hns=
X-Google-Smtp-Source: APXvYqxd7J2AKBReNjQWjPb2u03h/S+dh0/ishFD/XqrBEFQpznBdZtDCwhanG8hm5ysWjEuQJauroqIAzr6Z60yUxA=
X-Received: by 2002:a67:6887:: with SMTP id d129mr3908287vsc.33.1568846786136;
 Wed, 18 Sep 2019 15:46:26 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:06 -0700
In-Reply-To: <20190918224608.77973-1-samitolvanen@google.com>
Message-Id: <20190918224608.77973-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190918224608.77973-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2 3/5] x86: use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
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

Use COMPAT_SYSCALL_DEFINE0 to define (rt_)sigreturn syscalls to
replace sys32_sigreturn and sys32_rt_sigreturn. This fixes indirect
call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 4 ++--
 arch/x86/ia32/ia32_signal.c            | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3fe02546aed3..2de75fda1d20 100644
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
 175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
 176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 1cee10091b9f..30416d7f19d4 100644
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
2.23.0.351.gc4317032e6-goog

