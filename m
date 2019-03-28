Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151C21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="CQAdOoIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfC1NTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:19:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57058 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfC1NTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:19:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44VQSz0Pt1z9v2Hm;
        Thu, 28 Mar 2019 14:19:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=CQAdOoIO; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aIJDc8beexsH; Thu, 28 Mar 2019 14:19:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44VQSy6Gw5z9v2Hl;
        Thu, 28 Mar 2019 14:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553779186; bh=UVL3H2vZIF51ymeYqiVTfWcLs0pKuZFsZ4CGcq+jCI8=;
        h=From:Subject:To:Cc:Date:From;
        b=CQAdOoIOEeUoKXlMxKxA4POfXEqlRkvlyVIlDqhW6+xDYeljkTlDRZwv1RlZr2dZN
         x4RLOYmsTVdZ3wHi/9PdNsHXFzKFltkr+lgQ+/wW62NGxTM5NwziSYczq/Nn/thoQp
         Gz5CjhQYPnX4adZ0GQKbCwzMGSkmSnl8gz1jWaVM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D2ED8B91D;
        Thu, 28 Mar 2019 14:19:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tObT9_DV6BB4; Thu, 28 Mar 2019 14:19:48 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 081CF8B91C;
        Thu, 28 Mar 2019 14:19:48 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C5B926FC7E; Thu, 28 Mar 2019 13:19:47 +0000 (UTC)
Message-Id: <a048e3619ef2c378d075f46119ff5b7091320ecc.1553779159.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/nohash64: clean pgtable.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 28 Mar 2019 13:19:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRANSPARENT_HUGEPAGE is only supported by book3s

VMEMMAP_REGION_ID is never used

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..68b2387b503b 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -23,11 +23,7 @@
 			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define PMD_CACHE_INDEX	(PMD_INDEX_SIZE + 1)
-#else
 #define PMD_CACHE_INDEX	PMD_INDEX_SIZE
-#endif
 #define PUD_CACHE_INDEX PUD_INDEX_SIZE
 
 /*
@@ -73,7 +69,6 @@
 
 #define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
-#define VMEMMAP_REGION_ID	(0xfUL)	/* Server only */
 #define USER_REGION_ID		(0UL)
 
 /*
-- 
2.13.3

