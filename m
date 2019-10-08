Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF396ECE599
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62AE21871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ79GobX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJHWlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:11 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53675 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfJHWlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:07 -0400
Received: by mail-pl1-f201.google.com with SMTP id g13so238310plq.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nY9TR1zH/jI+XYpaiFW/FXGUm9qw4jfI4t8VFgiNY4c=;
        b=KZ79GobXrQMLfriyi4mGSroRkl4B969zUHlHKe7WxoiPUQ2hlGziQcVffjhBhoFtIo
         gGx57adOfO11m5qIPJrVDLLkRrTl5Iey3gVPSRKVsOTfbr9a6qvoX2p8REQ7B+JSpdB+
         8TlH48i5S2wB75eCb67J4ryPXKhJcYLqVawFWHGjD7sbzUf+3aySsAjcykiAAAko8A75
         DkO7tG3ZioOZLPRAOaUNC502CqDCzwyUMtSMpfT2IXFMfbnOQXUMyRoE+N/kk8nwfSdd
         GpLZyhKZBWcmKz3whWvIFQj9lK47CW5RR3lV12D9h6DuhWozzEvzBhFsAmV7vPXFUmbO
         qweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nY9TR1zH/jI+XYpaiFW/FXGUm9qw4jfI4t8VFgiNY4c=;
        b=okqd339A9/s27PpBhmNZdi+qMV5wVYZbLhd0MgFprn+HUBrrxUGNLkcgZ4EpepS3Mp
         RACcRrbAKA9nzTbGWJlV1Zcq68+/wyzSmLs7xTXC/CDbKyS+57ZT6NMPrVk/GDyzzDOR
         s2NDict8VSXvrAWtV1zT/ZKaoX0GUyRzMGNG25qRsyH3PGahFzZVRskwfa7Fcxx7kiZn
         h02+7qaN2SQuMWPg9K5RjVp3dgTMKtBXRFVzGIYHYG8hkD0kTzfw9M18tZ+D9yEUVF9B
         LCoEtmdohgGYWDTD0705jsGPnhrHPHIYiKWXIiVE8juY6veydsg+rLpBvgu40Md/bK83
         rhWQ==
X-Gm-Message-State: APjAAAVfLcxgMRM2mI9uqSDOHifojUYoTEJg6I8f/sALQCODvebvdGnD
        +R92fe6GdZz+nTk3EwksNLcmoF55O5lpVNvW/tE=
X-Google-Smtp-Source: APXvYqwE+zkZO9o8rV7bGeKM0jIUo/CP8dqDgpqaBVP6YdPc/OKN/BxZIAQtcHRP/z4TwNI+ph1gSeZd8WOlHH49r8k=
X-Received: by 2002:a63:40b:: with SMTP id 11mr782332pge.425.1570574466521;
 Tue, 08 Oct 2019 15:41:06 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:47 -0700
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 3/5] x86: use COMPAT_SYSCALL_DEFINE0 for IA32 (rt_)sigreturn
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
2.23.0.581.g78d2f28ef7-goog

