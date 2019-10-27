Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514B20679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212081;
	bh=6u/I12k282DOBG2MRmZ69eO1I+TUxQ9KbrQ2nM3A04A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nLNtkcpkNpx//RfW5BuS9ExmqRA3CkRDO3kM6oY3xaw6nZQPlvi2kiYNuagqGFJel
	 AFUbV5Pxb1odEkbfEhVoJ3DNeeG7fJF1Jxu8nMkb9y+O4bK4GgoajZhqLPrE9jNr/K
	 N/uKvCFS/lhfPuhqojYuHqCfb70uFr8dv+XWpc1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfJ0Vej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbfJ0VKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:10:35 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6015208C0;
        Sun, 27 Oct 2019 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210634;
        bh=6u/I12k282DOBG2MRmZ69eO1I+TUxQ9KbrQ2nM3A04A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmaSuoRxphQ/N1E5qgVtCIjfEGP62HbCXBwk75POoLT3nzBBSNcCdL2B/teMJcRv+
         PY8iN2dO7ZO6qkpf44dJEZgqHYVwlRQZ6uhjCTMF2o3OxBDVT1dAsqNxauG9VCrXBW
         n6mDQMdV4tGkuTFVkKSvsNbSjs5SbzGsW/YH9JhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 082/119] arm64: Force SSBS on context switch
Date:   Sun, 27 Oct 2019 22:00:59 +0100
Message-Id: <20191027203345.704836456@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit cbdf8a189a66001c36007bf0f5c975d0376c5c3a ]

On a CPU that doesn't support SSBS, PSTATE[12] is RES0.  In a system
where only some of the CPUs implement SSBS, we end-up losing track of
the SSBS bit across task migration.

To address this issue, let's force the SSBS bit on context switch.

Fixes: 8f04e8e6e29c ("arm64: ssbd: Add support for PSTATE.SSBS rather than trapping to EL3")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: inverted logic and added comments]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/processor.h |   14 ++++++++++++--
 arch/arm64/kernel/process.c        |   29 ++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -148,6 +148,16 @@ static inline void start_thread_common(s
 	regs->pc = pc;
 }
 
+static inline void set_ssbs_bit(struct pt_regs *regs)
+{
+	regs->pstate |= PSR_SSBS_BIT;
+}
+
+static inline void set_compat_ssbs_bit(struct pt_regs *regs)
+{
+	regs->pstate |= PSR_AA32_SSBS_BIT;
+}
+
 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 				unsigned long sp)
 {
@@ -155,7 +165,7 @@ static inline void start_thread(struct p
 	regs->pstate = PSR_MODE_EL0t;
 
 	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
-		regs->pstate |= PSR_SSBS_BIT;
+		set_ssbs_bit(regs);
 
 	regs->sp = sp;
 }
@@ -174,7 +184,7 @@ static inline void compat_start_thread(s
 #endif
 
 	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
-		regs->pstate |= PSR_AA32_SSBS_BIT;
+		set_compat_ssbs_bit(regs);
 
 	regs->compat_sp = sp;
 }
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -298,7 +298,7 @@ int copy_thread(unsigned long clone_flag
 			childregs->pstate |= PSR_UAO_BIT;
 
 		if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
-			childregs->pstate |= PSR_SSBS_BIT;
+			set_ssbs_bit(childregs);
 
 		p->thread.cpu_context.x19 = stack_start;
 		p->thread.cpu_context.x20 = stk_sz;
@@ -340,6 +340,32 @@ void uao_thread_switch(struct task_struc
 }
 
 /*
+ * Force SSBS state on context-switch, since it may be lost after migrating
+ * from a CPU which treats the bit as RES0 in a heterogeneous system.
+ */
+static void ssbs_thread_switch(struct task_struct *next)
+{
+	struct pt_regs *regs = task_pt_regs(next);
+
+	/*
+	 * Nothing to do for kernel threads, but 'regs' may be junk
+	 * (e.g. idle task) so check the flags and bail early.
+	 */
+	if (unlikely(next->flags & PF_KTHREAD))
+		return;
+
+	/* If the mitigation is enabled, then we leave SSBS clear. */
+	if ((arm64_get_ssbd_state() == ARM64_SSBD_FORCE_ENABLE) ||
+	    test_tsk_thread_flag(next, TIF_SSBD))
+		return;
+
+	if (compat_user_mode(regs))
+		set_compat_ssbs_bit(regs);
+	else if (user_mode(regs))
+		set_ssbs_bit(regs);
+}
+
+/*
  * We store our current task in sp_el0, which is clobbered by userspace. Keep a
  * shadow copy so that we can restore this upon entry from userspace.
  *
@@ -367,6 +393,7 @@ __notrace_funcgraph struct task_struct *
 	contextidr_thread_switch(next);
 	entry_task_switch(next);
 	uao_thread_switch(next);
+	ssbs_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case


