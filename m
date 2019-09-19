Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036BC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138D921927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfISPKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:10:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403953AbfISPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:09:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy47-0006pT-V7; Thu, 19 Sep 2019 17:09:52 +0200
Message-Id: <20190919150809.754111224@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 13/15] arm64/entry: Move FPU restore out of
 exit_to_usermode() loop
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restoring the FPU is not required to be insided the loop. The final point
to do that is before returning to user space. Move it there.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/entry-common.h |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/arch/arm64/include/asm/entry-common.h
+++ b/arch/arm64/include/asm/entry-common.h
@@ -7,8 +7,6 @@
 
 #include <asm/daifflags.h>
 
-#define ARCH_EXIT_TO_USERMODE_WORK	(_TIF_FOREIGN_FPSTATE)
-
 static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
 {
 	if (ti_work & _TIF_NEED_RESCHED)
@@ -24,15 +22,14 @@ static inline void local_irq_disable_exi
 }
 #define local_irq_disable_exit_to_user local_irq_disable_exit_to_user
 
-static inline void arch_exit_to_usermode_work(struct pt_regs *regs,
-					      unsigned long ti_work)
+static inline void arch_exit_to_usermode(struct pt_regs *regs,
+					 unsigned long ti_work)
 {
-	/* Must this be inside the work loop ? */
 	if (ti_work & _TIF_FOREIGN_FPSTATE)
 		fpsimd_restore_current_state();
 
 }
-#define arch_exit_to_usermode_work arch_exit_to_usermode_work
+#define arch_exit_to_usermode arch_exit_to_usermode
 
 enum ptrace_syscall_dir {
 	PTRACE_SYSCALL_ENTER = 0,


