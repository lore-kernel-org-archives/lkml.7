Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD34C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C901217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QnJPQ93y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEJGbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:31:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3605 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfEJGbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:31:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 450gN044zdz9v1GD;
        Fri, 10 May 2019 08:31:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QnJPQ93y; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5RVjzFTZy1GP; Fri, 10 May 2019 08:31:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 450gN0334Cz9v1GC;
        Fri, 10 May 2019 08:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557469888; bh=4JggaEKDb5wcArbI27Jxgc52P6X1TORgfQ6AS2Hpqwk=;
        h=From:Subject:To:Cc:Date:From;
        b=QnJPQ93yxEE6EnayQikQChVZCRkXoIeJiZUDR1Y60shyqnBi3jPffhNZOSX8MHtKY
         dTDpHcTzhyXSBfsB4k7Ce2EgDsqX4i0w9npPT5CE9nEDqaLtiw/elIYZnrcOIyfnz8
         3E+QN/feMgkGyALx3EMoqUPRRCzQrQbJorKS9HaU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 597528B7CF;
        Fri, 10 May 2019 08:31:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YwAGeELdQCyp; Fri, 10 May 2019 08:31:29 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 354198B756;
        Fri, 10 May 2019 08:31:29 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1C25766204; Fri, 10 May 2019 06:31:28 +0000 (UTC)
Message-Id: <7b15f4a18ab2d9fb54559acbadf2cd83a7d147f7.1557469839.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/64: mark start_here_multiplatform as __ref
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 10 May 2019 06:31:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, the following warning is encountered:

WARNING: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup()
The function start_here_multiplatform() references
the function __init .early_setup().
This is often because start_here_multiplatform lacks a __init
annotation or the annotation of .early_setup is wrong.

Fixes: 56c46bba9bbf ("powerpc/64: Fix booting large kernels with STRICT_KERNEL_RWX")
Cc: Russell Currey <ruscur@russell.cc>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 5321a11c2835..259be7f6d551 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -904,6 +904,7 @@ p_toc:	.8byte	__toc_start + 0x8000 - 0b
 /*
  * This is where the main kernel code starts.
  */
+__REF
 start_here_multiplatform:
 	/* set up the TOC */
 	bl      relative_toc
@@ -979,6 +980,7 @@ start_here_multiplatform:
 	RFI
 	b	.	/* prevent speculative execution */
 
+	.previous
 	/* This is where all platforms converge execution */
 
 start_here_common:
-- 
2.13.3

