Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC879C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D120881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qHg2rjE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfEWIjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:39:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8671 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEWIja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:39:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 458jbg5PJgz9tybB;
        Thu, 23 May 2019 10:39:27 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qHg2rjE3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OWyPUnGABWAd; Thu, 23 May 2019 10:39:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 458jbg45Bxz9tyb8;
        Thu, 23 May 2019 10:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1558600767; bh=IkYWeZ4tDG4CTAbPN5POqn8JSBG26w6X70unKoUvBPM=;
        h=From:Subject:To:Cc:Date:From;
        b=qHg2rjE3OqyRKas86pc9/NGYDIII6/uVB0IAX3H9hHyYs9na347WtU7xnQmxxOrHI
         ATgiOEP0CmRJyc0GQhr0RTlSB6F3LJ8EQpqEubQW6WWat7ntmekc1NbfJ/+4mmPk4I
         DElM4EKV4T+9+2nW8XFF4YxEP/PAOS8nLw0ptvio=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 948398B851;
        Thu, 23 May 2019 10:39:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1AzVhv0qAqSB; Thu, 23 May 2019 10:39:28 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 537F68B77D;
        Thu, 23 May 2019 10:39:28 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 12F2168517; Thu, 23 May 2019 08:39:27 +0000 (UTC)
Message-Id: <97664671a229a4240bfb22f69ec4743e837c2b83.1558600628.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: fix build failure on book3e with KVM
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 23 May 2019 08:39:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build failure was introduced by the commit identified below,
due to missed macro expension leading to wrong called function's name.

arch/powerpc/kernel/head_fsl_booke.o: In function `SystemCall':
arch/powerpc/kernel/head_fsl_booke.S:416: undefined reference to `kvmppc_handler_BOOKE_INTERRUPT_SYSCALL_SPRN_SRR1'
Makefile:1052: recipe for target 'vmlinux' failed

The called function should be kvmppc_handler_8_0x01B(). This patch fixes it.

Reported-by: Paul Mackerras <paulus@ozlabs.org>
Fixes: 1a4b739bbb4f ("powerpc/32: implement fast entry for syscalls on BOOKE")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_booke.h     | 4 ++--
 arch/powerpc/kernel/head_fsl_booke.S | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index bfeb469e8106..dec0912a6508 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -83,7 +83,7 @@ END_BTB_FLUSH_SECTION
 	SAVE_4GPRS(3, r11);						     \
 	SAVE_2GPRS(7, r11)
 
-.macro SYSCALL_ENTRY trapno intno
+.macro SYSCALL_ENTRY trapno intno srr1
 	mfspr	r10, SPRN_SPRG_THREAD
 #ifdef CONFIG_KVM_BOOKE_HV
 BEGIN_FTR_SECTION
@@ -94,7 +94,7 @@ BEGIN_FTR_SECTION
 	mfspr	r11, SPRN_SRR1
 	mtocrf	0x80, r11	/* check MSR[GS] without clobbering reg */
 	bf	3, 1975f
-	b	kvmppc_handler_BOOKE_INTERRUPT_\intno\()_SPRN_SRR1
+	b	kvmppc_handler_\intno\()_\srr1
 1975:
 	mr	r12, r13
 	lwz	r13, THREAD_NORMSAVE(2)(r10)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 6621f230cc37..2b39f42c3676 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -413,7 +413,7 @@ interrupt_base:
 
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
-	SYSCALL_ENTRY   0xc00 SYSCALL
+	SYSCALL_ENTRY   0xc00 BOOKE_INTERRUPT_SYSCALL SPRN_SRR1
 
 	/* Auxiliary Processor Unavailable Interrupt */
 	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
-- 
2.13.3

