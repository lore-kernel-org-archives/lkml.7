Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E29C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2731E2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SVJZ6Mlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLWP0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:26:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13491 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLWP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:26:18 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47hNVC08mlz9vJyn;
        Mon, 23 Dec 2019 16:26:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SVJZ6Mlz; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NMduw6uLKHzc; Mon, 23 Dec 2019 16:26:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47hNVB65gtz9vJyx;
        Mon, 23 Dec 2019 16:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1577114770; bh=D3+VKZJ3hPYAS69Fkh6Xu5UkefnPwZgOHwwzmESq47E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=SVJZ6MlzwisGMPUrmb7zjVPn5E8ioInBlKV63cjaMHP359fiVDCGeCtBL5c7Aj4ga
         AF6Jo0GLl1l0ZXQGUUjJidH0sEXKC9h1uHvPP2AbupP4aEkLAv03ie8lEC2Q8n6j+j
         aIV0/BOVpK5WBNpgm9FZ5rrlbf92caXOOrUkX52s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0ADF38B7AB;
        Mon, 23 Dec 2019 16:26:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nedWeDvJrad3; Mon, 23 Dec 2019 16:26:15 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0D5B8B7A1;
        Mon, 23 Dec 2019 16:26:15 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E4733637D8; Mon, 23 Dec 2019 15:26:15 +0000 (UTC)
Message-Id: <ca37c53561e4023315499ee3a35816bad01e4964.1577114567.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1577114567.git.christophe.leroy@c-s.fr>
References: <cover.1577114567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 5/8] powerpc/irq: move stack overflow verification
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Dec 2019 15:26:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are going to switch to IRQ stack immediately in the exception
handler, it won't be possible anymore to check stack overflow by
reading stack pointer.

Do the verification on regs->gpr[1] which contains the stack pointer
at the time the IRQ happended, and move it to __do_irq() so that the
verification is also done when calling __do_irq() directly once the
exception entry does the stack switch.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 28414c6665cc..4df49f6e9987 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -596,15 +596,16 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
-static inline void check_stack_overflow(void)
+static inline void check_stack_overflow(struct pt_regs *regs)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
+	bool is_user = user_mode(regs);
 	long sp;
 
-	sp = current_stack_pointer() & (THREAD_SIZE-1);
+	sp = regs->gpr[1] & (THREAD_SIZE - 1);
 
 	/* check for stack overflow: is there less than 2KB free? */
-	if (unlikely(sp < 2048)) {
+	if (unlikely(!is_user && sp < 2048)) {
 		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
@@ -654,6 +655,8 @@ void __do_irq(struct pt_regs *regs)
 
 	trace_irq_entry(regs);
 
+	check_stack_overflow(regs);
+
 	/*
 	 * Query the platform PIC for the interrupt & ack it.
 	 *
@@ -685,8 +688,6 @@ void do_IRQ(struct pt_regs *regs)
 	irqsp = hardirq_ctx[raw_smp_processor_id()];
 	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
-	check_stack_overflow();
-
 	/* Already there ? Otherwise switch stack and call */
 	if (unlikely(cursp == irqsp || cursp == sirqsp))
 		__do_irq(regs);
-- 
2.13.3

