Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27756C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002822082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDLMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:06:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727104AbfDLMGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:06:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 283C5269CD2F03AD3FD8;
        Fri, 12 Apr 2019 20:06:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 20:06:20 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <wangxiongfeng2@huawei.com>, <huawei.libin@huawei.com>,
        <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/3] sdei: enable dbg in '_sdei_handler'
Date:   Fri, 12 Apr 2019 20:04:58 +0800
Message-ID: <1555070699-3685-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we monitor a sdei_event callback using 'kprobe', the singlestep
handler can not be called because dbg is masked in sdei_handler. This
patch enable dbg in '_sdei_handler'.

When SDEI events interrupt the userspace, 'vbar_el1' contains
'tramp_vectors' if CONFIG_UNMAP_KERNEL_AT_EL0 is enabled. So we need to
restore 'vbar_el1' with kernel vectors, otherwise we will go to the
wrong place when brk exception or dbg exception happens.

SDEI events may interrupt 'kernel_entry' before we save 'spsr_el1' and
'elr_el1', and dbg exception will corrupts these two registers. So we
also need to save and restore these two registers.

If SDEI events interrupt an instruction being singlestepped, the
instruction in '_sdei_handler' will begin to be singlestepped after we
enable dbg. So we need to disable singlestep in the beginning of
_sdei_handler if we find out we interrupt a singlestep process.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/debug-monitors.c      |  8 ++++++
 arch/arm64/kernel/sdei.c                | 43 ++++++++++++++++++++++++++-------
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index a44cf52..a730266 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -121,6 +121,7 @@ enum dbg_active_el {
 void user_fastforward_single_step(struct task_struct *task);
 
 void kernel_enable_single_step(struct pt_regs *regs);
+void kernel_enable_single_step_noregs(void);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
 
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index d7bb6ae..d6074f4 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -404,6 +404,14 @@ void kernel_enable_single_step(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(kernel_enable_single_step);
 
+void kernel_enable_single_step_noregs(void)
+{
+	WARN_ON(!irqs_disabled());
+	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
+	enable_debug_monitors(DBG_ACTIVE_EL1);
+}
+NOKPROBE_SYMBOL(kernel_enable_single_step_noregs);
+
 void kernel_disable_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index ea94cf8..9dd9cf6 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/alternative.h>
+#include <asm/debug-monitors.h>
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
 #include <asm/ptrace.h>
@@ -176,6 +177,8 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 
 }
 
+extern char vectors[];  /* kernel exception vectors */
+
 /*
  * __sdei_handler() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
@@ -189,8 +192,10 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 	int i, err = 0;
 	int clobbered_registers = 4;
 	u64 elr = read_sysreg(elr_el1);
+	u64 spsr = read_sysreg(spsr_el1);
 	u32 kernel_mode = read_sysreg(CurrentEL) | 1;	/* +SPSel */
 	unsigned long vbar = read_sysreg(vbar_el1);
+	int ss_active = 0;
 
 	if (arm64_kernel_unmapped_at_el0())
 		clobbered_registers++;
@@ -207,19 +212,39 @@ static __kprobes unsigned long _sdei_handler(struct pt_regs *regs,
 	 */
 	__uaccess_enable_hw_pan();
 
+	/*
+	 * Enable dbg here so that we can kprobe a sdei event handler. Before we
+	 * enable dbg, we need to restore vbar_el1 with kernel vectors
+	 */
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	write_sysreg(vectors, vbar_el1);
+	isb();
+#endif
+	ss_active = kernel_active_single_step();
+	if (ss_active)
+		kernel_disable_single_step();
+	local_dbg_enable();
+
 	err = sdei_event_handler(regs, arg);
+
+	local_dbg_disable();
+	if (ss_active)
+		kernel_enable_single_step_noregs();
+
+	/*
+	 * brk exception will corrupt elr_el1 and spsr_el1, and trust firmware
+	 * doesn't save it for us. So we need to restore these two registers
+	 * after 'sdei_event_handler'.
+	 */
+	write_sysreg(elr, elr_el1);
+	write_sysreg(spsr, spsr_el1);
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	write_sysreg(vbar, vbar_el1);
+#endif
+
 	if (err)
 		return SDEI_EV_FAILED;
 
-	if (elr != read_sysreg(elr_el1)) {
-		/*
-		 * We took a synchronous exception from the SDEI handler.
-		 * This could deadlock, and if you interrupt KVM it will
-		 * hyp-panic instead.
-		 */
-		pr_warn("unsafe: exception during handler\n");
-	}
-
 	mode = regs->pstate & (PSR_MODE32_BIT | PSR_MODE_MASK);
 
 	/*
-- 
1.7.12.4

