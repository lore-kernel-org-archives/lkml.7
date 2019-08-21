Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412B3C3A59B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CDB22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="kx7OwaVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfHUKUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:20:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbfHUKUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:20:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46D3b56w75z9v00k;
        Wed, 21 Aug 2019 12:20:49 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kx7OwaVt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5mxKnH78Nl8v; Wed, 21 Aug 2019 12:20:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46D3b55tB3z9v00j;
        Wed, 21 Aug 2019 12:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566382849; bh=N68GV62YPUP85s+ntUba1TxmZ6DCcu8UBUiNuPYWgF8=;
        h=From:Subject:To:Cc:Date:From;
        b=kx7OwaVtbU13+k4R8hFKFj7L3+ERcqPtEnofI7l+KTcRB2lBCew3WZ6KyXIT5bjLd
         rRiLtKj4lPRh98+ZGiTwlFHrcarZane7eQLeBTzbHXKm/AIsP+Sc9kQCIw140I7oW8
         jiQGwGaCBiGRlBVrwxmIvoLy7szqOwW3XcvHVpuU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BBA808B7E2;
        Wed, 21 Aug 2019 12:20:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CtQxMFt3XWIt; Wed, 21 Aug 2019 12:20:51 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E9458B7E0;
        Wed, 21 Aug 2019 12:20:51 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 59EB96B73E; Wed, 21 Aug 2019 10:20:51 +0000 (UTC)
Message-Id: <54f67bb7ac486c1350f2fa8905cd279f94b9dfb1.1566382841.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: set STACK_END_MAGIC earlier on the init_stack
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 21 Aug 2019 10:20:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, the STACK_END_MAGIC is set on init_stack in start_kernel().

To avoid a false 'Thread overran stack, or stack corrupted' message
on early Oopses, setup STACK_END_MAGIC as soon as possible.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_8xx.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 5ab9178c2347..b8ca5b43e587 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -15,6 +15,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/magic.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -741,6 +742,9 @@ start_here:
 	/* stack */
 	lis	r1,init_thread_union@ha
 	addi	r1,r1,init_thread_union@l
+	lis	r0, STACK_END_MAGIC@h
+	ori	r0, r0, STACK_END_MAGIC@l
+	stw	r0, 0(r1)
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
-- 
2.13.3

