Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14366C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9F02071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pFka7N+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLIGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:07:23 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31069 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfLIGHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:07:23 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47WXln5tmqz9v4lH;
        Mon,  9 Dec 2019 07:07:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pFka7N+q; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lkDlMX49Rxkp; Mon,  9 Dec 2019 07:07:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47WXln4mklz9v4lG;
        Mon,  9 Dec 2019 07:07:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575871637; bh=4PTvkpJvM4Rk0FYU1bLjpYOjPs0OZx8HFfawFNgQDuU=;
        h=From:Subject:To:Cc:Date:From;
        b=pFka7N+qv1EiKkmwCjENDSH/EIWMMJAJqtIF9+t/Pk9Xh5M4dt8+ENtvONS0MZxYe
         yu8wVP3iTFvoG/XQLMcVwsN0+gtWVdWj8G8TZORrd9c9Ed2cDbP92MhKy5iphtqnTP
         p+8R6Xjf1Xdzo4W27NFMQnhnew8uj9CSVf06eEK8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 047D98B7AF;
        Mon,  9 Dec 2019 07:07:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QpF-CxIMyPSk; Mon,  9 Dec 2019 07:07:21 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD0268B755;
        Mon,  9 Dec 2019 07:07:21 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BEE5963679; Mon,  9 Dec 2019 06:07:21 +0000 (UTC)
Message-Id: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in
 check_stack_overflow()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  9 Dec 2019 06:07:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_stack_pointer() doesn't return the stack pointer, but the
caller's stack frame. See commit bfe9a2cfe91a ("powerpc: Reimplement
__get_SP() as a function not a define") and commit acf620ecf56c
("powerpc: Rename __get_SP() to current_stack_pointer()") for details.

The purpose of check_stack_overflow() is to verify that the stack has
not overflowed.

To really know whether the stack pointer is still within boundaries,
the check must be done directly on the value of r1.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bb34005ff9d2..4d468d835558 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -599,9 +599,8 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 static inline void check_stack_overflow(void)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-	long sp;
-
-	sp = current_stack_pointer() & (THREAD_SIZE-1);
+	register unsigned long r1 asm("r1");
+	long sp = r1 & (THREAD_SIZE - 1);
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < 2048)) {
-- 
2.13.3

