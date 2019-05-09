Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E189CC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A752173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="KN3iirzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEIM7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:59:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36737 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEIM7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:59:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 450D2K2Wfvz9v0vx;
        Thu,  9 May 2019 14:59:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=KN3iirzk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KloxUBLf2aLe; Thu,  9 May 2019 14:59:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 450D2K1Jfvz9v0vm;
        Thu,  9 May 2019 14:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1557406777; bh=bjxVmGayki9KchW8MayZ1YtVg0d3U0cW8pv3uWCqln4=;
        h=From:Subject:To:Cc:Date:From;
        b=KN3iirzkskwbti6N5NugYST8J3heL1osAoBNNDrVwm+82ddbJiAc3pWcBIjlr9Qeg
         tCClutOGk83Pv23h5PCMoXMxj7RUKf812V4HobFsF8+sV8C+parcdJvqhKjCSQ2IcS
         0pKY+T9kcsaYu/tqEmu67GX9wOIXA20yxwsJ2JNM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 935418B91C;
        Thu,  9 May 2019 14:59:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6-BNBGXyCheG; Thu,  9 May 2019 14:59:38 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BBFC8B918;
        Thu,  9 May 2019 14:59:38 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2F10166235; Thu,  9 May 2019 12:59:38 +0000 (UTC)
Message-Id: <a4e5d99c5173797b7242652be99801a9bb5d68fc.1557406475.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: fix flush_hash_pages() on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@vger.kernel.org
Date:   Thu,  9 May 2019 12:59:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_hash_pages() runs with data translation off, so current
task_struct has to be accesssed using physical address.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Fixes: f7354ccac844 ("powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/hash_low.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index e27792d0b744..8366c2abeafc 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -539,7 +539,8 @@ _GLOBAL(flush_hash_pages)
 #ifdef CONFIG_SMP
 	lis	r9, (mmu_hash_lock - PAGE_OFFSET)@ha
 	addi	r9, r9, (mmu_hash_lock - PAGE_OFFSET)@l
-	lwz	r8,TASK_CPU(r2)
+	tophys	(r8, r2)
+	lwz	r8, TASK_CPU(r8)
 	oris	r8,r8,9
 10:	lwarx	r0,0,r9
 	cmpi	0,r0,0
-- 
2.13.3

