Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A72067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LbFuXId9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHMULw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:11:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4377 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHMULp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4b4bqzz9v0CV;
        Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LbFuXId9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vElA5WFI3qlH; Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4b3YP7z9v0CM;
        Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727103; bh=ApfXazdN/aJJxOj2BuRZcVNEeJUk2Dx1JsxPH8E6gtQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LbFuXId9ARdfOWxUljPGkAAdAUAgWT2ilRKvhvXKWiigBu7og0vI/a1LVNJAnw12c
         7bZe2Nq64t19tF8obosUYi33tka5djmfqwjS2kbTCFw911PQZkae0EunZSSx2iwbbt
         vJNJeCpzgBZG+hGzQQ6SnVIOZm+cVyjGSYtMJFHc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A21E58B7F2;
        Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id f9QbSFwF-ExW; Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 60C288B7F0;
        Tue, 13 Aug 2019 22:11:43 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3AC7169632; Tue, 13 Aug 2019 20:11:43 +0000 (UTC)
Message-Id: <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 10/10] powerpc/mm: refactor ioremap_range() and use
 ioremap_page_range()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3s64's ioremap_range() is almost same as fallback ioremap_range(),
except that it calls radix__ioremap_range() when radix is enabled.

radix__ioremap_range() is also very similar to the other ones, expect
that it calls ioremap_page_range when slab is available.

Lets keep only one version of ioremap_range() which calls
ioremap_page_range() on all platforms when slab is available.

At the same time, drop the nid parameter which is not used.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  3 ---
 arch/powerpc/mm/book3s64/pgtable.c         | 21 ---------------------
 arch/powerpc/mm/book3s64/radix_pgtable.c   | 20 --------------------
 arch/powerpc/mm/ioremap.c                  | 23 +++++++++++++----------
 4 files changed, 13 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index e04a839cb5b9..574eca33f893 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -266,9 +266,6 @@ extern void radix__vmemmap_remove_mapping(unsigned long start,
 extern int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 				 pgprot_t flags, unsigned int psz);
 
-extern int radix__ioremap_range(unsigned long ea, phys_addr_t pa,
-				unsigned long size, pgprot_t prot, int nid);
-
 static inline unsigned long radix__get_tree_size(void)
 {
 	unsigned long rts_field;
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 7d0e0d0d22c4..4c8bed856533 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -446,24 +446,3 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
-
-int ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, pgprot_t prot, int nid)
-{
-	unsigned long i;
-
-	if (radix_enabled())
-		return radix__ioremap_range(ea, pa, size, prot, nid);
-
-	for (i = 0; i < size; i += PAGE_SIZE) {
-		int err = map_kernel_page(ea + i, pa + i, prot);
-		if (err) {
-			if (slab_is_available())
-				unmap_kernel_range(ea, size);
-			else
-				WARN_ON_ONCE(1); /* Should clean up */
-			return err;
-		}
-	}
-
-	return 0;
-}
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 11303e2fffb1..d39edbb07bd1 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1218,26 +1218,6 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	return 1;
 }
 
-int radix__ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size,
-			pgprot_t prot, int nid)
-{
-	if (likely(slab_is_available())) {
-		int err = ioremap_page_range(ea, ea + size, pa, prot);
-		if (err)
-			unmap_kernel_range(ea, size);
-		return err;
-	} else {
-		unsigned long i;
-
-		for (i = 0; i < size; i += PAGE_SIZE) {
-			int err = map_kernel_page(ea + i, pa + i, prot);
-			if (WARN_ON_ONCE(err)) /* Should clean up */
-				return err;
-		}
-		return 0;
-	}
-}
-
 int __init arch_ioremap_p4d_supported(void)
 {
 	return 0;
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 537c9148cea1..dc538d7f2467 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -76,21 +76,24 @@ void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long f
 }
 EXPORT_SYMBOL(ioremap_prot);
 
-int __weak ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size,
-			 pgprot_t prot, int nid)
+static int ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size,
+			 pgprot_t prot)
 {
 	unsigned long i;
 
+	if (slab_is_available()) {
+		int err = ioremap_page_range(ea, ea + size, pa, prot);
+
+		if (err)
+			unmap_kernel_range(ea, size);
+		return err;
+	}
+
 	for (i = 0; i < size; i += PAGE_SIZE) {
 		int err = map_kernel_page(ea + i, pa + i, prot);
 
-		if (err) {
-			if (slab_is_available())
-				unmap_kernel_range(ea, size);
-			else
-				WARN_ON_ONCE(1); /* Should clean up */
+		if (WARN_ON_ONCE(err))  /* Should clean up */
 			return err;
-		}
 	}
 
 	return 0;
@@ -165,7 +168,7 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 		ioremap_bot -= size;
 		va = ioremap_bot;
 	}
-	ret = ioremap_range(va, pa, size, prot, NUMA_NO_NODE);
+	ret = ioremap_range(va, pa, size, prot);
 	if (!ret)
 		return (void __iomem *)va + (addr & ~PAGE_MASK);
 
@@ -223,7 +226,7 @@ void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_
 	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
 	WARN_ON(size & ~PAGE_MASK);
 
-	if (ioremap_range((unsigned long)ea, pa, size, prot, NUMA_NO_NODE))
+	if (ioremap_range((unsigned long)ea, pa, size, prot))
 		return NULL;
 
 	return (void __iomem *)ea;
-- 
2.13.3

