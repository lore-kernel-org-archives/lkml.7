Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244BD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SNn2vH7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCKIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:31:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7677 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfCKIae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:30:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44Hrry2CpkzB09Zq;
        Mon, 11 Mar 2019 09:30:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SNn2vH7e; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nRn9I_PSOpmu; Mon, 11 Mar 2019 09:30:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44Hrry13HTzB09ZD;
        Mon, 11 Mar 2019 09:30:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1552293026; bh=ztmGavRLvNdF2u4ml0Z3unJoliY8vD4GX8nem0+fk9E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=SNn2vH7eKtcEgDudG7VvDuSBp3iU2jkMA0MiTvnZgKX7VkWpBrLngbfKRpFtpsR8j
         pfjuUWeRggipXJugMJ/9JfOUqt6XFzi1R8X6JIBdA3pHDYv4rnWWuJaCmPpKTHpXL4
         EBQv7HFFJOxs5IXbw6zS4rzYSCqD+LDRx93mIQkw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A7FD88B813;
        Mon, 11 Mar 2019 09:30:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JDtz0ycH5iH2; Mon, 11 Mar 2019 09:30:30 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 84A818B7FE;
        Mon, 11 Mar 2019 09:30:30 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 787626FA08; Mon, 11 Mar 2019 08:30:30 +0000 (UTC)
Message-Id: <17f151878f35fd449b9375308dd096f0d922746b.1552292207.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 03/10] powerpc/32: Remove MSR_PR test when returning from
 syscall
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Mar 2019 08:30:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscalls are from user only, so we can account time without checking
whether returning to kernel or user as it will only be user.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index b61cfd29c76f..aaf7c5f44823 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -422,12 +422,7 @@ BEGIN_FTR_SECTION
 	lwarx	r7,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1			/* to clear the reservation */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	andi.	r4,r8,MSR_PR
-	beq	3f
 	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
-3:
-#endif
 	lwz	r4,_LINK(r1)
 	lwz	r5,_CCR(r1)
 	mtlr	r4
-- 
2.13.3

