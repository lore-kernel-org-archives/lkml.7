Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC1BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C83204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="frYHewT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfF1PsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:48:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44786 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfF1PsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:48:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PW4jwPzB09ZP;
        Fri, 28 Jun 2019 17:47:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=frYHewT2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hcihPcxjSc7Z; Fri, 28 Jun 2019 17:47:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PW3RCmzB09ZQ;
        Fri, 28 Jun 2019 17:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736879; bh=SqjEUXYvT8sVFpmMwykbw4gz6034bxL6k1oKbXzt/pM=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=frYHewT2D5auK2s1xL/2VK9D1wDhSJpKurCgVOYv2M06utEw09VbzoDp5ZE8omKmY
         bSal3EeJ5UKqjz+wH0euptFW97bFb2C7r7GhVIJ1nb5klGxG+jtbNS1srvdLPUbSin
         2sfV+CWNGSTlH9fNraAlAhVCTAGaAyw0EZgp6OUk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CD7E8B955;
        Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fpqZqhbDnebk; Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1249E8B975;
        Fri, 28 Jun 2019 17:48:00 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 0212368DBC; Fri, 28 Jun 2019 15:47:59 +0000 (UTC)
Message-Id: <483ffd1c62d270d7079b41e1747f34d254390c24.1561735588.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 10/12] powerpc/ptrace: create ptrace_get_debugreg()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:47:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create ptrace_get_debugreg() to handle PTRACE_GET_DEBUGREG and
reduce ifdef mess

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/ptrace/ptrace-adv.c   |  9 +++++++++
 arch/powerpc/kernel/ptrace/ptrace-decl.h  |  2 ++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 13 +++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c       | 18 ++----------------
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace/ptrace-adv.c b/arch/powerpc/kernel/ptrace/ptrace-adv.c
index 86e71fa6c5c8..dcc765940344 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-adv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-adv.c
@@ -83,6 +83,15 @@ void user_disable_single_step(struct task_struct *task)
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
+			unsigned long __user *datalp)
+{
+	/* We only support one DABR and no IABRS at the moment */
+	if (addr > 0)
+		return -EINVAL;
+	return put_user(child->thread.debug.dac1, datalp);
+}
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data)
 {
 	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index bdba09a87aea..4b4b6a1d508a 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -176,6 +176,8 @@ int tm_cgpr32_set(struct task_struct *target, const struct user_regset *regset,
 extern const struct user_regset_view user_ppc_native_view;
 
 /* ptrace-(no)adv */
+int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
+			unsigned long __user *datalp);
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data);
 long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_info);
 long ppc_del_hwdebug(struct task_struct *child, long data);
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 7db330c94538..985cca136f85 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -64,6 +64,19 @@ void user_disable_single_step(struct task_struct *task)
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
+			unsigned long __user *datalp)
+{
+	unsigned long dabr_fake;
+
+	/* We only support one DABR and no IABRS at the moment */
+	if (addr > 0)
+		return -EINVAL;
+	dabr_fake = ((child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
+		     (child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
+	return put_user(dabr_fake, datalp);
+}
+
 int ptrace_set_debugreg(struct task_struct *task, unsigned long addr, unsigned long data)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 377e0e541d5f..e789afae6f56 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -211,23 +211,9 @@ long arch_ptrace(struct task_struct *child, long request,
 		break;
 	}
 
-	case PTRACE_GET_DEBUGREG: {
-#ifndef CONFIG_PPC_ADV_DEBUG_REGS
-		unsigned long dabr_fake;
-#endif
-		ret = -EINVAL;
-		/* We only support one DABR and no IABRS at the moment */
-		if (addr > 0)
-			break;
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-		ret = put_user(child->thread.debug.dac1, datalp);
-#else
-		dabr_fake = ((child->thread.hw_brk.address & (~HW_BRK_TYPE_DABR)) |
-			     (child->thread.hw_brk.type & HW_BRK_TYPE_DABR));
-		ret = put_user(dabr_fake, datalp);
-#endif
+	case PTRACE_GET_DEBUGREG:
+		ret = ptrace_get_debugreg(child, addr, datalp);
 		break;
-	}
 
 	case PTRACE_SET_DEBUGREG:
 		ret = ptrace_set_debugreg(child, addr, data);
-- 
2.13.3

