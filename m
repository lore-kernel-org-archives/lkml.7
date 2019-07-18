Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0336C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9882077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563428625;
	bh=0SNEK6gGwQn1OWea04NP26kwWDvWXL2LRO0v9+iQPRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZKOqyyrMKBCdFYStdCXIDcj3i1YUeV0NcVhbG8oebp0TVhF+oM1ETfxuiiU+ERo1B
	 /zB/ZVo030NKmtXSyPbUKAbG5UCRvjVYwoy3o44l+BXq5MlFszsB43/9m+RxA+R5Sq
	 TE5oeqpTemDJUMrfYjGzw94OsNqbqm7+sh20+YWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfGRFno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:43:43 -0400
Received: from localhost.localdomain (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2A02077C;
        Thu, 18 Jul 2019 05:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563428622;
        bh=0SNEK6gGwQn1OWea04NP26kwWDvWXL2LRO0v9+iQPRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FChIDXQr68auUYmY3OgLk0ibepVLmrXp3Sw70Mq/TXZPW8cJmf7mYY6vV/ZGh0zF7
         whI67PGrR0cy6dMai+4+696YLsdqTuovUYa4DcZoXLe2Yn7w9lsNxN8P61Z7xUuMdK
         /7pBZwRxT+hpWsJqJyLkosQ72efnQsS+uQmo7yts=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: [PATCH 1/3] arm64: kprobes: Recover pstate.D in single-step exception handler
Date:   Thu, 18 Jul 2019 14:43:37 +0900
Message-Id: <156342861775.8565.9122725195458920037.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156342860634.8565.14804606041960884732.stgit@devnote2>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, if a nested kprobes hit, it can crash the kernel with below
error message.

[  152.118921] Unexpected kernel single-step exception at EL1

This is because commit 7419333fa15e ("arm64: kprobe: Always clear
pstate.D in breakpoint exception handler") clears pstate.D always in
the nested kprobes. That is correct *unless* any nested kprobes
(single-stepping) runs inside other kprobes (including kprobes in
 user handler).

When the 1st kprobe hits, do_debug_exception() will be called. At this
point, debug exception (= pstate.D) must be masked (=1). When the 2nd
 (nested) kprobe is hit before single-step of the first kprobe, it
modifies debug exception clear (pstate.D = 0).
Then, when the 1st kprobe setting up single-step, it saves current
DAIF, mask DAIF, enable single-step, and restore DAIF.
However, since "D" flag in DAIF is cleared by the 2nd kprobe, the
single-step exception happens soon after restoring DAIF.

To solve this issue, this refers saved pstate register to check the
previous pstate.D and recover it if needed.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bd5dfffca272..6e1dc0bb4c82 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -201,12 +201,14 @@ spsr_set_debug_flag(struct pt_regs *regs, int mask)
  * interrupt occurrence in the period of exception return and  start of
  * out-of-line single-step, that result in wrongly single stepping
  * into the interrupt handler.
+ * This also controls debug flag, so that we can refer the saved pstate.
  */
 static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
 						struct pt_regs *regs)
 {
 	kcb->saved_irqflag = regs->pstate;
 	regs->pstate |= PSR_I_BIT;
+	spsr_set_debug_flag(regs, 0);
 }
 
 static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
@@ -216,6 +218,10 @@ static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
 		regs->pstate |= PSR_I_BIT;
 	else
 		regs->pstate &= ~PSR_I_BIT;
+
+	/* Recover pstate.D mask if needed */
+	if (kcb->saved_irqflag & PSR_D_BIT)
+		spsr_set_debug_flag(regs, 1);
 }
 
 static void __kprobes
@@ -245,15 +251,12 @@ static void __kprobes setup_singlestep(struct kprobe *p,
 		kcb->kprobe_status = KPROBE_HIT_SS;
 	}
 
-
 	if (p->ainsn.api.insn) {
 		/* prepare for single stepping */
 		slot = (unsigned long)p->ainsn.api.insn;
 
 		set_ss_context(kcb, slot);	/* mark pending ss */
 
-		spsr_set_debug_flag(regs, 0);
-
 		/* IRQs and single stepping do not mix well. */
 		kprobes_save_local_irqflag(kcb, regs);
 		kernel_enable_single_step(regs);

