Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873DFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA1620896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pK6vNxO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfFMPKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:10:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47821 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732312AbfFMNwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:52:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PlY94W79z9tyf4;
        Thu, 13 Jun 2019 15:52:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pK6vNxO0; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J-VKxj5mP6NZ; Thu, 13 Jun 2019 15:52:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PlY9300Yz9tydq;
        Thu, 13 Jun 2019 15:52:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560433949; bh=u+wmpa7FkR8lFNxaOvzsfaQBff2eaQMcSvF8WxVITQ4=;
        h=From:Subject:To:Cc:Date:From;
        b=pK6vNxO0jjGBEl047wa0XrcU9BSCZvDqEf2bgBhSZcxdg5nxXLopOw6tG9V0lEk7l
         ps7nr/xu/ytQCcaXwXnvrD1UyXE78QgaDTbabboXnoAZbtAcKm7v8Bu1rgVigBIzrw
         iw63+toBCJl+gV1V5sKtpd2W2fD633m0SK9wcs8Q=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D74078B8E9;
        Thu, 13 Jun 2019 15:52:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id X5YrSOYZs0HE; Thu, 13 Jun 2019 15:52:30 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B34448B8B9;
        Thu, 13 Jun 2019 15:52:30 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 86E5768D76; Thu, 13 Jun 2019 13:52:30 +0000 (UTC)
Message-Id: <c0ea3c32c7ed892501ddcc7a169948c305081551.1560433897.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/booke: fix fast syscall entry on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 13:52:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use r10 instead of r9 to calculate CPU offset as r9 contains
the value from SRR1 which is used later.

Fixes: 1a4b739bbb4f ("powerpc/32: implement fast entry for syscalls on BOOKE")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_booke.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index dec0912a6508..2ae635df9026 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -145,9 +145,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_EMB_HV)
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	lwz	r9,TASK_CPU(r2)
-	slwi	r9,r9,3
-	add	r11,r11,r9
+	lwz	r10, TASK_CPU(r2)
+	slwi	r10, r10, 3
+	add	r11, r11, r10
 #endif
 	lwz	r12,0(r11)
 	mtspr	SPRN_DBCR0,r12
-- 
2.13.3

