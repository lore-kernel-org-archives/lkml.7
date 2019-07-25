Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2BBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEED22CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564042565;
	bh=zvOD/NhJ1ppVzvGI+gKJSff+TbgtbifjjIqRMfaYbSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GGIQcGyBLTZSKx249OA/OPYPwEdRh8PRVikIcGlccWfYqKF0v0pnk9qXY6kM7WOlj
	 noniiaec6qcX9paBm+8z0kcD0AKGaJotyusCFn9+n9MhiSwnQFcXN9RwSpTMwwcN5c
	 xI+3pnVRfM8lZrCLscZRhAw2wuq8nCBg5khxeGSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfGYIQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389263AbfGYIQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:16:01 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0C822BEF;
        Thu, 25 Jul 2019 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564042559;
        bh=zvOD/NhJ1ppVzvGI+gKJSff+TbgtbifjjIqRMfaYbSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuJVs+Bl5fZsnaeLJ5Ogn8iQitL7ImTW5M4la/vpTqCk0G1jhsQbZoVSIVqlwnZ1O
         tT1b+sQqx2Q2ZP8NAm2NO/Q5wbzH7qt+VtNdrnCE9R6egArit5iUNmWRkFLARRf34R
         jd3w+w5L+uX4PpBjahoidymviPGC3dn5Ff95kkZQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 1/4] arm64: kprobes: Recover pstate.D in single-step exception handler
Date:   Thu, 25 Jul 2019 17:15:54 +0900
Message-Id: <156404255444.2020.3301023170351823334.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156404254387.2020.886452004489353899.stgit@devnote2>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobes manipulates the interrupted PSTATE for single step, and
doesn't restore it. Thus, if we put a kprobe where the pstate.D
(debug) masked, the mask will be cleared after the kprobe hits.

Moreover, in the most complicated case, this can lead a kernel
crash with below message when a nested kprobe hits.

[  152.118921] Unexpected kernel single-step exception at EL1

When the 1st kprobe hits, do_debug_exception() will be called.
At this point, debug exception (= pstate.D) must be masked (=1).
But if another kprobes hits before single-step of the first kprobe
(e.g. inside user pre_handler), it unmask the debug exception
(pstate.D = 0) and return.
Then, when the 1st kprobe setting up single-step, it saves current
DAIF, mask DAIF, enable single-step, and restore DAIF.
However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
single-step exception happens soon after restoring DAIF.

This has been introduced by commit 7419333fa15e ("arm64: kprobe:
Always clear pstate.D in breakpoint exception handler")

To solve this issue, this stores all DAIF bits and restore it
after single stepping.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v3:
   - Update patch description
   - move PSR_DAIF_MASK in daifflags.h
  Changes in v2:
   - Save and restore all DAIF flags.
   - Operate pstate directly and remove spsr_set_debug_flag().
---
 arch/arm64/include/asm/daifflags.h |    2 ++
 arch/arm64/kernel/probes/kprobes.c |   39 +++++-------------------------------
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 987926ed535e..063c964af705 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -13,6 +13,8 @@
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
 #define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
+#define DAIF_MASK		(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bd5dfffca272..bf2259651b67 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -167,33 +167,6 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
 	__this_cpu_write(current_kprobe, p);
 }
 
-/*
- * When PSTATE.D is set (masked), then software step exceptions can not be
- * generated.
- * SPSR's D bit shows the value of PSTATE.D immediately before the
- * exception was taken. PSTATE.D is set while entering into any exception
- * mode, however software clears it for any normal (none-debug-exception)
- * mode in the exception entry. Therefore, when we are entering into kprobe
- * breakpoint handler from any normal mode then SPSR.D bit is already
- * cleared, however it is set when we are entering from any debug exception
- * mode.
- * Since we always need to generate single step exception after a kprobe
- * breakpoint exception therefore we need to clear it unconditionally, when
- * we become sure that the current breakpoint exception is for kprobe.
- */
-static void __kprobes
-spsr_set_debug_flag(struct pt_regs *regs, int mask)
-{
-	unsigned long spsr = regs->pstate;
-
-	if (mask)
-		spsr |= PSR_D_BIT;
-	else
-		spsr &= ~PSR_D_BIT;
-
-	regs->pstate = spsr;
-}
-
 /*
  * Interrupts need to be disabled before single-step mode is set, and not
  * reenabled until after single-step mode ends.
@@ -205,17 +178,17 @@ spsr_set_debug_flag(struct pt_regs *regs, int mask)
 static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
 						struct pt_regs *regs)
 {
-	kcb->saved_irqflag = regs->pstate;
+	kcb->saved_irqflag = regs->pstate & DAIF_MASK;
 	regs->pstate |= PSR_I_BIT;
+	/* Unmask PSTATE.D for enabling software step exceptions. */
+	regs->pstate &= ~PSR_D_BIT;
 }
 
 static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
 						struct pt_regs *regs)
 {
-	if (kcb->saved_irqflag & PSR_I_BIT)
-		regs->pstate |= PSR_I_BIT;
-	else
-		regs->pstate &= ~PSR_I_BIT;
+	regs->pstate &= ~DAIF_MASK;
+	regs->pstate |= kcb->saved_irqflag;
 }
 
 static void __kprobes
@@ -252,8 +225,6 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 
 		set_ss_context(kcb, slot);	/* mark pending ss */
 
-		spsr_set_debug_flag(regs, 0);
-
 		/* IRQs and single stepping do not mix well. */
 		kprobes_save_local_irqflag(kcb, regs);
 		kernel_enable_single_step(regs);

