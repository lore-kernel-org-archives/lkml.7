Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB1CC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859762084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FiBDTIys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDCUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:06:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48109 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfDCUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCD3TDzz9v3pn;
        Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=FiBDTIys; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CAT7K8uO1yy7; Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCD2MkXz9v6Km;
        Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321976; bh=QrOIJAoXklCeiX4EgvV03ibMMsu5JAy8M1zOTj0D3tg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=FiBDTIyss1zjK+tubbbQp0pmk9Z1eIrPS1TpXt5Mt2lqro8xEiRcqQXeGgnmk85vZ
         CoVJ41KIlGWjD6aZOy3IjMaBE2lk+HmqiZeOZbzgn7kNN9pegUabAVYFpVmz55vvqV
         Ak8pt6S8A6zSJjVu4Jta6qx77wkqQGWxJlKHaVVY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7245D8B905;
        Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9Fgkls_Gh-nC; Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 434D78B902;
        Wed,  3 Apr 2019 22:06:16 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2EDB9655EC; Wed,  3 Apr 2019 20:06:16 +0000 (UTC)
Message-Id: <8f824023d2c2a5cee55afdc172241d5ae6d601ed.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 04/15] powerpc/mm: move pgtable_t in asm/mmu.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgtable_t is now identical for all subarches, move it to the
top level asm/mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 4 ----
 arch/powerpc/include/asm/book3s/64/mmu.h      | 8 --------
 arch/powerpc/include/asm/mmu.h                | 3 +++
 arch/powerpc/include/asm/nohash/32/mmu.h      | 6 ------
 arch/powerpc/include/asm/nohash/64/mmu.h      | 6 ------
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 5cb588395fdc..2612d7a1688c 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -10,8 +10,6 @@
  * BATs
  */
 
-#include <asm/page.h>
-
 /* Block size masks */
 #define BL_128K	0x000
 #define BL_256K 0x001
@@ -49,8 +47,6 @@ struct ppc_bat {
 	u32 batu;
 	u32 batl;
 };
-
-typedef pte_t *pgtable_t;
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 1ceee000c18d..b98b5b304307 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -25,14 +25,6 @@ struct mmu_psize_def {
 	};
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-
-/*
- * For BOOK3s 64 with 4k and 64K linux page size
- * we want to use pointers, because the page table
- * actually store pfn
- */
-typedef pte_t *pgtable_t;
-
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 598cdcdd1355..d10dc714f95f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -124,6 +124,9 @@
 #ifndef __ASSEMBLY__
 #include <linux/bug.h>
 #include <asm/cputable.h>
+#include <asm/page.h>
+
+typedef pte_t *pgtable_t;
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #include <asm/percpu.h>
diff --git a/arch/powerpc/include/asm/nohash/32/mmu.h b/arch/powerpc/include/asm/nohash/32/mmu.h
index 7d94a36d57d2..af0e8b54876a 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_POWERPC_NOHASH_32_MMU_H_
 #define _ASM_POWERPC_NOHASH_32_MMU_H_
 
-#include <asm/page.h>
-
 #if defined(CONFIG_40x)
 /* 40x-style software loaded TLB */
 #include <asm/nohash/32/mmu-40x.h>
@@ -18,8 +16,4 @@
 #include <asm/nohash/32/mmu-8xx.h>
 #endif
 
-#ifndef __ASSEMBLY__
-typedef pte_t *pgtable_t;
-#endif
-
 #endif /* _ASM_POWERPC_NOHASH_32_MMU_H_ */
diff --git a/arch/powerpc/include/asm/nohash/64/mmu.h b/arch/powerpc/include/asm/nohash/64/mmu.h
index 3376f5222d24..87871d027b75 100644
--- a/arch/powerpc/include/asm/nohash/64/mmu.h
+++ b/arch/powerpc/include/asm/nohash/64/mmu.h
@@ -2,13 +2,7 @@
 #ifndef _ASM_POWERPC_NOHASH_64_MMU_H_
 #define _ASM_POWERPC_NOHASH_64_MMU_H_
 
-#include <asm/page.h>
-
 /* Freescale Book-E software loaded TLB or Book-3e (ISA 2.06+) MMU */
 #include <asm/nohash/mmu-book3e.h>
 
-#ifndef __ASSEMBLY__
-typedef pte_t *pgtable_t;
-#endif
-
 #endif /* _ASM_POWERPC_NOHASH_64_MMU_H_ */
-- 
2.13.3

