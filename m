Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B00C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD47420656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="aOgxNM5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfFYK6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:58:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18162 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbfFYK6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:58:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Y36j4bwXz9v17h;
        Tue, 25 Jun 2019 12:58:21 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=aOgxNM5v; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fa8GvaOu9h1B; Tue, 25 Jun 2019 12:58:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Y36j3bmrz9v17d;
        Tue, 25 Jun 2019 12:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561460301; bh=0qZwQpr4MSd6rLow6MYfEuYxvZJpdGewNYEX+NzmT+w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=aOgxNM5v9od8NAMRJ7xXJVy75EleSN4MzA0JwePexW1XghuoBRKJIM9TXJ/yVvpzg
         gdmaUE6etLhQuUzeodyl5JyegwKPgZnwMaJbQgJeZJ7/5eNqEKIM8blLhXaKNiJrrU
         iqh5Hce11gbPCrNbpegGU8N3yl+KBjMlpiVmWkbQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A432B8B879;
        Tue, 25 Jun 2019 12:58:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lBAx_H-bhUvc; Tue, 25 Jun 2019 12:58:22 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6410F8B874;
        Tue, 25 Jun 2019 12:58:22 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 35EE668E1B; Tue, 25 Jun 2019 10:58:19 +0000 (UTC)
Message-Id: <347a44cbfdd864c8ab5440d8915710cb1648a05a.1561459984.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1561459983.git.christophe.leroy@c-s.fr>
References: <cover.1561459983.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 13/13] powerpc/hw_breakpoint: move instruction stepping
 out of hw_breakpoint_handler()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Jun 2019 10:58:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8xx, breakpoints stop after executing the instruction, so
stepping/emulation is not needed. Move it into a sub-function and
remove the #ifdefs.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/hw_breakpoint.c | 60 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index b71d3837d673..a6a509b9fd13 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -198,15 +198,43 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 /*
  * Handle debug exception notifications.
  */
+static bool stepping_handler(struct pt_regs *regs, struct perf_event *bp,
+			     unsigned long addr)
+{
+	int stepped;
+	unsigned int instr;
+
+	/* Do not emulate user-space instructions, instead single-step them */
+	if (user_mode(regs)) {
+		current->thread.last_hit_ubp = bp;
+		regs->msr |= MSR_SE;
+		return false;
+	}
+
+	stepped = 0;
+	instr = 0;
+	if (!__get_user_inatomic(instr, (unsigned int *) regs->nip))
+		stepped = emulate_step(regs, instr);
+
+	/*
+	 * emulate_step() could not execute it. We've failed in reliably
+	 * handling the hw-breakpoint. Unregister it and throw a warning
+	 * message to let the user know about it.
+	 */
+	if (!stepped) {
+		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at "
+			"0x%lx will be disabled.", addr);
+		perf_event_disable_inatomic(bp);
+		return false;
+	}
+	return true;
+}
+
 int hw_breakpoint_handler(struct die_args *args)
 {
 	int rc = NOTIFY_STOP;
 	struct perf_event *bp;
 	struct pt_regs *regs = args->regs;
-#ifndef CONFIG_PPC_8xx
-	int stepped = 1;
-	unsigned int instr;
-#endif
 	struct arch_hw_breakpoint *info;
 	unsigned long dar = regs->dar;
 
@@ -251,31 +279,9 @@ int hw_breakpoint_handler(struct die_args *args)
 	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
 		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
 
-#ifndef CONFIG_PPC_8xx
-	/* Do not emulate user-space instructions, instead single-step them */
-	if (user_mode(regs)) {
-		current->thread.last_hit_ubp = bp;
-		regs->msr |= MSR_SE;
+	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info->address))
 		goto out;
-	}
 
-	stepped = 0;
-	instr = 0;
-	if (!__get_user_inatomic(instr, (unsigned int *) regs->nip))
-		stepped = emulate_step(regs, instr);
-
-	/*
-	 * emulate_step() could not execute it. We've failed in reliably
-	 * handling the hw-breakpoint. Unregister it and throw a warning
-	 * message to let the user know about it.
-	 */
-	if (!stepped) {
-		WARN(1, "Unable to handle hardware breakpoint. Breakpoint at "
-			"0x%lx will be disabled.", info->address);
-		perf_event_disable_inatomic(bp);
-		goto out;
-	}
-#endif
 	/*
 	 * As a policy, the callback is invoked in a 'trigger-after-execute'
 	 * fashion
-- 
2.13.3

