Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA6C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A32206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OblfVUjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLHKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:48:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3725 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfLHKsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 05:48:05 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47W3275p9cz9tySD;
        Sun,  8 Dec 2019 11:47:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OblfVUjh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fjlqa5M82dtu; Sun,  8 Dec 2019 11:47:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47W3274WMKz9tyS4;
        Sun,  8 Dec 2019 11:47:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575802079; bh=j94t5POjnfwMOhIyjty//O1HCzuZ8xq1bFZy5q16/YI=;
        h=From:Subject:To:Cc:Date:From;
        b=OblfVUjh5JfrDrw8apQ0bQF9KcEp5Js0S9M8NuSccX70EezTCPqF55fkFa4bh6Plh
         WACrOL5LuH3LXSQNXCK92twnILcnh7MxbRAnO/zhb4RiNzwjpIEEbeBMgWnach9Z4k
         dpbuKlLh4dlyCG8gh6oa3iYuMhz8pslbIt5Am52w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E0DB8B77A;
        Sun,  8 Dec 2019 11:48:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ggcHE-4w7EfL; Sun,  8 Dec 2019 11:48:02 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 070978B76F;
        Sun,  8 Dec 2019 11:48:01 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 30D2D63723; Sun,  8 Dec 2019 10:48:01 +0000 (UTC)
Message-Id: <1bb34d3ea006c308221706290613e6cc5dc3cb74.1575802064.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/irq: don't use current_stack_pointer() in do_IRQ()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  8 Dec 2019 10:48:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 7306e83ccf5c ("powerpc: Don't use CURRENT_THREAD_INFO to
find the stack"), the current stack base address was obtained by
calling current_thread_info(). That inline function was simply masking
out the value of r1.

In that commit, it was changed to using current_stack_pointer(), which
is an heavier function as it is an outline assembly function which
cannot be inlined and which reads the content of the stack at 0(r1)

Revert to just getting r1 and masking out its value to obtain the base
address of the stack pointer as before.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 7306e83ccf5c ("powerpc: Don't use CURRENT_THREAD_INFO to find the stack")
---
 arch/powerpc/kernel/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 240eca12c71d..bb34005ff9d2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -693,10 +693,11 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
+	register unsigned long r1 asm("r1");
 	void *cursp, *irqsp, *sirqsp;
 
 	/* Switch to the irq stack to handle this */
-	cursp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
+	cursp = (void *)(r1 & ~(THREAD_SIZE - 1));
 	irqsp = hardirq_ctx[raw_smp_processor_id()];
 	sirqsp = softirq_ctx[raw_smp_processor_id()];
 
-- 
2.13.3

