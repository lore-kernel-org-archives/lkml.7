Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DDAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE532073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sHXfRysl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLWP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:26:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49052 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWP0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:26:15 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47hNV96yzQz9vJyt;
        Mon, 23 Dec 2019 16:26:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sHXfRysl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L8wKDvhVT9WF; Mon, 23 Dec 2019 16:26:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47hNV95tz6z9vJyn;
        Mon, 23 Dec 2019 16:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1577114769; bh=/A5nHGIX1n3gwM0sFa6XeCQneVLd9/XPssrSN7a7g8I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=sHXfRysliIex+d9/Owu7dVjupZ7ryZ4/iam1CzsrVLiPJ3QWUWPNKNxH2tlzAx0T7
         2mJv4J994amOHthnEbpWAe6aPUuiJEyWrLCLMG9NGhtWSXZbPDkdCpaK7fb2+10M5I
         KcCNi4EXt6+o4eROPWPD2kOCTHPAUZ0u1QNvWOH0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0165D8B7AB;
        Mon, 23 Dec 2019 16:26:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mfRKu-QhdIrE; Mon, 23 Dec 2019 16:26:14 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D3EC28B7A1;
        Mon, 23 Dec 2019 16:26:14 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DE545637D8; Mon, 23 Dec 2019 15:26:14 +0000 (UTC)
Message-Id: <98430a9b57d4888610fd245337422434376e22fb.1577114567.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1577114567.git.christophe.leroy@c-s.fr>
References: <cover.1577114567.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 4/8] powerpc/irq: move set_irq_regs() closer to
 irq_enter/exit()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 23 Dec 2019 15:26:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_irq_regs() is called by do_IRQ() while irq_enter() and irq_exit()
are called by __do_irq().

Move set_irq_regs() in __do_irq()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 410accba865d..28414c6665cc 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -647,6 +647,7 @@ static inline void call_do_irq(struct pt_regs *regs, void *sp)
 
 void __do_irq(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int irq;
 
 	irq_enter();
@@ -672,11 +673,11 @@ void __do_irq(struct pt_regs *regs)
 	trace_irq_exit(regs);
 
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 void do_IRQ(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
@@ -686,16 +687,11 @@ void do_IRQ(struct pt_regs *regs)
 
 	check_stack_overflow();
 
-	/* Already there ? */
-	if (unlikely(cursp == irqsp || cursp == sirqsp)) {
+	/* Already there ? Otherwise switch stack and call */
+	if (unlikely(cursp == irqsp || cursp == sirqsp))
 		__do_irq(regs);
-		set_irq_regs(old_regs);
-		return;
-	}
-	/* Switch stack and call */
-	call_do_irq(regs, irqsp);
-
-	set_irq_regs(old_regs);
+	else
+		call_do_irq(regs, irqsp);
 }
 
 void __init init_IRQ(void)
-- 
2.13.3

