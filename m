Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7903C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B5524676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hclCZbX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSL6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:58:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40164 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:58:36 -0500
Received: by mail-yb1-f195.google.com with SMTP id a2so2065464ybr.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skzvEBKEgSRmkv36qzyh5QpOtx3Jh5DVz7BfkRa/+7E=;
        b=hclCZbX8N7Cb9s2vfDIteDJO9VyRG0vcYoe6qmtr4KYdBPoT9z5MzW6yI49hr9UDhL
         EPEBTXrQKh7UgYx4kDRo8NgyHYw8947lUcCFPOX11tOhX/TWXE7lZfdT6upUxk3eVjJh
         C+RbTGaB0483N2c4sM/B6y22dYrKYtvPjg8Qv30uRBmtlbCVssdXt3aD2qMESr2Okt1w
         OiRRsjQIAASJyyMn6LPTEBt5ACi/eEBlMV76pZUmxCmH3bEaC3wmp4WSafmNwC/mYkNn
         cR0Tr1QA1Lh0yXJn2ySVPNmZZ+l3HbkRDv2FJXMcJwUhv4ezARQMJQBRoUYQPQLB6SbT
         e98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=skzvEBKEgSRmkv36qzyh5QpOtx3Jh5DVz7BfkRa/+7E=;
        b=IcHZJ2oiX24MBqCfdMML8BLpDiCUEw/XzoUcS0rSL5Xr4PUwv3L0+IUqdB+PWElWmj
         45fLerCIGD87FogTygS3j7+nEavdHBQaT2H/uqVLD5kxUrooXschYY3+B2UhE3WupKDQ
         Rr4qr9ics/eZ7FQK0qCpPzSxz2Bv+NTIXWDdRj3seP3DquBJYShqY/v3QIDw5avNWCEh
         ZKLl3IITZZD+m4alMoPvGp9g4198Deq8O8Q3v2t6aU9OYvljvQG3Pvv8ILxY8zxDMPrk
         LWybGbWWbyPghntiSGaHSVSPNut22qkdn5bee3CWjJjKFqWJ38CoJMG/W95gO7JLXEWv
         ygEA==
X-Gm-Message-State: APjAAAWaWY42iS7wLI1N9ihgfromibFzYDvFWubIPMu4c4acfjivIW9W
        QiJSQDZwSU0AGanmfOoIHg==
X-Google-Smtp-Source: APXvYqyxpDlUsb/TnuTlCNggIrlfyjpxqQD1W8WPu/WOw0bY18HfSZ8vExZcmrMt2qntigbemddzAQ==
X-Received: by 2002:a05:6902:506:: with SMTP id x6mr5711380ybs.456.1576756714617;
        Thu, 19 Dec 2019 03:58:34 -0800 (PST)
Received: from citadel.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 144sm2421451ywy.20.2019.12.19.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 03:58:34 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH] x86: Remove force_iret()
Date:   Thu, 19 Dec 2019 06:58:12 -0500
Message-Id: <20191219115812.102620-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

force_iret() was originally intended to prevent the return to user mode with
the SYSRET or SYSEXIT instructions, in cases where the register state could
have been changed to be incompatible with those instructions.  The entry code
has been significantly reworked since then, and register state is validated
before SYSRET or SYSEXIT are used.  force_iret() no longer serves its original
purpose and can be eliminated.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/ia32/ia32_signal.c        |  2 --
 arch/x86/include/asm/ptrace.h      | 16 ----------------
 arch/x86/include/asm/thread_info.h |  9 ---------
 arch/x86/kernel/process_32.c       |  1 -
 arch/x86/kernel/process_64.c       |  1 -
 arch/x86/kernel/signal.c           |  2 --
 arch/x86/kernel/vm86_32.c          |  1 -
 7 files changed, 32 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 30416d7f19d4..a3aefe9b9401 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -114,8 +114,6 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 
 	err |= fpu__restore_sig(buf, 1);
 
-	force_iret();
-
 	return err;
 }
 
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5057a8ed100b..78897a8da01f 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -339,22 +339,6 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
-/*
- * When hitting ptrace_stop(), we cannot return using SYSRET because
- * that does not restore the full CPU state, only a minimal set.  The
- * ptracer can change arbitrary register values, which is usually okay
- * because the usual ptrace stops run off the signal delivery path which
- * forces IRET; however, ptrace_event() stops happen in arbitrary places
- * in the kernel and don't force IRET path.
- *
- * So force IRET path after a ptrace stop.
- */
-#define arch_ptrace_stop_needed(code, info)				\
-({									\
-	force_iret();							\
-	false;								\
-})
-
 struct user_desc;
 extern int do_get_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info);
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d779366ce3f8..cf4327986e98 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -239,15 +239,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
-/*
- * Force syscall return via IRET by making it look as if there was
- * some work pending. IRET is our most capable (but slowest) syscall
- * return path, which is able to restore modified SS, CS and certain
- * EFLAGS values that other (fast) syscall return instructions
- * are not able to restore properly.
- */
-#define force_iret() set_thread_flag(TIF_NOTIFY_RESUME)
-
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 323499f48858..5052ced43373 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -124,7 +124,6 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 	regs->ip		= new_ip;
 	regs->sp		= new_sp;
 	regs->flags		= X86_EFLAGS_IF;
-	force_iret();
 }
 EXPORT_SYMBOL_GPL(start_thread);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 506d66830d4d..ffd497804dbc 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -394,7 +394,6 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 	regs->cs		= _cs;
 	regs->ss		= _ss;
 	regs->flags		= X86_EFLAGS_IF;
-	force_iret();
 }
 
 void
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193e158d..8a29573851a3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -151,8 +151,6 @@ static int restore_sigcontext(struct pt_regs *regs,
 
 	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
 
-	force_iret();
-
 	return err;
 }
 
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a76c12b38e92..91d55454e702 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -381,7 +381,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 		mark_screen_rdonly(tsk->mm);
 
 	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
-	force_iret();
 	return regs->ax;
 }
 
-- 
2.23.0

