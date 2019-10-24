Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA64FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A4921928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mQgVZqoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfJXW7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:59:08 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44849 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbfJXW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:59:02 -0400
Received: by mail-il1-f194.google.com with SMTP id f13so133396ils.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ewd1rVkhq4LpaE/RWcspGCRKM0wa097bcHOPlCsLiI=;
        b=mQgVZqoRA4C+jywJUfgezpEMpK4tDsxVj3MUVMhVw/V9KcdTEUnsDGiizEdRxNe0bb
         ELefZpeh5KMWKi4lWruJDQ1QC90tpmN8TVijGarn6mOv9PaWnFbEE0XJXBbh4hO+7lBA
         FpbKaB41bdmIsd+CpF7LR63qOH935RjV9rLd1yJ2oY61BFupVypeGI25J9q2RtDWUQIC
         5ON3WMxbPtMeEjsiOeIkqRf9s6M6n0vj52bbh2pV32Aet4/ciZ4liSoH8flRfWTzhJ8i
         kvZCYSijtjo2lWxjVxcOl6cVpTV8MG7bOXT5NFkZtM4uYql59ionZXhmaOv70wcgiZU0
         hBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ewd1rVkhq4LpaE/RWcspGCRKM0wa097bcHOPlCsLiI=;
        b=rotjCCX04GVgzqRtBVRyLyZF6Heg8SIoYByKN0T2keo5ZLZPKWzlbDKreSOjtq1Woy
         5ogA7JA995zGfQlkZQ92ebrQyY6VPsocDdSpVBqI0bHJ2oQyqSqXTrjjBG1F0NQdCTO2
         dzo1QD9s2Bq5T2ZlncWCJMWNWKJHJs5/dUMr9uyzsofM9S5a8g5lFhn5eYeCGW+g6izm
         4CCT03oCCk4EcUTMjToXdEFzw4sFWhytW+9uwlT1X09m850KmJmwJLtl4TIAnNN6OvWg
         p+JXbeADLMpMhl25T1fOQaXmb2bwrxaaGp+FO5WDrWF9T53rci2s3D8RywKP7NbvoEI3
         rb3g==
X-Gm-Message-State: APjAAAXut4PA79PiY2++D6pGwsKpWirjK2MSPOtMVDaoJFgdZcupLlZb
        aQY8+ro3wulmxLGLyrTdUc5tGQ==
X-Google-Smtp-Source: APXvYqz43O6FDAWcYOVrF1HCpzRXwF5m1tk03ArHzCfCtyXH/mGlZwggHZNmnwLL7SV3KQivEs92Mw==
X-Received: by 2002:a92:dd88:: with SMTP id g8mr569648iln.199.1571957941595;
        Thu, 24 Oct 2019 15:59:01 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:59:01 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 6/6] riscv: for C functions called only from assembly, mark with __visible
Date:   Thu, 24 Oct 2019 15:58:38 -0700
Message-Id: <20191024225838.27743-7-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191024225838.27743-1-paul.walmsley@sifive.com>
References: <20191024225838.27743-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than adding prototypes for C functions called only by assembly
code, mark them as __visible.  This avoids adding prototypes that will
never be used by the callers.  Resolves the following sparse warnings:

arch/riscv/kernel/irq.c:27:29: warning: symbol 'do_IRQ' was not declared. Should it be static?
arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
arch/riscv/kernel/ptrace.c:165:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?
arch/riscv/kernel/signal.c:295:17: warning: symbol 'do_notify_resume' was not declared. Should it be static?
arch/riscv/kernel/traps.c:92:1: warning: symbol 'do_trap_unknown' was not declared. Should it be static?
arch/riscv/kernel/traps.c:94:1: warning: symbol 'do_trap_insn_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:96:1: warning: symbol 'do_trap_insn_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:98:1: warning: symbol 'do_trap_insn_illegal' was not declared. Should it be static?
arch/riscv/kernel/traps.c:100:1: warning: symbol 'do_trap_load_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:102:1: warning: symbol 'do_trap_load_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:104:1: warning: symbol 'do_trap_store_misaligned' was not declared. Should it be static?
arch/riscv/kernel/traps.c:106:1: warning: symbol 'do_trap_store_fault' was not declared. Should it be static?
arch/riscv/kernel/traps.c:108:1: warning: symbol 'do_trap_ecall_u' was not declared. Should it be static?
arch/riscv/kernel/traps.c:110:1: warning: symbol 'do_trap_ecall_s' was not declared. Should it be static?
arch/riscv/kernel/traps.c:112:1: warning: symbol 'do_trap_ecall_m' was not declared. Should it be static?
arch/riscv/kernel/traps.c:124:17: warning: symbol 'do_trap_break' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:136:24: warning: symbol 'smp_callin' was not declared. Should it be static?

Based on a suggestion from Luc Van Oostenryck.

This version includes changes based on feedback from Christoph Hellwig
<hch@lst.de>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de> # for do_syscall_trace_*
---
 arch/riscv/kernel/irq.c     | 2 +-
 arch/riscv/kernel/ptrace.c  | 4 ++--
 arch/riscv/kernel/signal.c  | 4 ++--
 arch/riscv/kernel/smpboot.c | 2 +-
 arch/riscv/kernel/traps.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 6d8659388c49..fffac6ddb0e0 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -24,7 +24,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs)
+asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 368751438366..1252113ef8b2 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -148,7 +148,7 @@ long arch_ptrace(struct task_struct *child, long request,
  * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
  * {handle,ret_from}_syscall.
  */
-void do_syscall_trace_enter(struct pt_regs *regs)
+__visible void do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		if (tracehook_report_syscall_entry(regs))
@@ -162,7 +162,7 @@ void do_syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
 }
 
-void do_syscall_trace_exit(struct pt_regs *regs)
+__visible void do_syscall_trace_exit(struct pt_regs *regs)
 {
 	audit_syscall_exit(regs);
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 64bc914ce9ff..d0f6f212f5df 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -292,8 +292,8 @@ static void do_signal(struct pt_regs *regs)
  * notification of userspace execution resumption
  * - triggered by the _TIF_WORK_MASK flags
  */
-asmlinkage void do_notify_resume(struct pt_regs *regs,
-	unsigned long thread_info_flags)
+asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
+					   unsigned long thread_info_flags)
 {
 	/* Handle pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index ec0be2f6a2e8..261f4087cc39 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -133,7 +133,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage void __init smp_callin(void)
+asmlinkage __visible void __init smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0b6e271efc43..473de3ae8bb7 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -84,7 +84,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 }
 
 #define DO_ERROR_INFO(name, signo, code, str)				\
-asmlinkage void name(struct pt_regs *regs)				\
+asmlinkage __visible void name(struct pt_regs *regs)			\
 {									\
 	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
 }
@@ -121,7 +121,7 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
 }
 
-asmlinkage void do_trap_break(struct pt_regs *regs)
+asmlinkage __visible void do_trap_break(struct pt_regs *regs)
 {
 	if (user_mode(regs))
 		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->sepc);
-- 
2.24.0.rc0

