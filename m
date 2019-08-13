Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96578C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616692067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qfBhulLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfHMUL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:11:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35063 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfHMULn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4Y3wJNz9v0CS;
        Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qfBhulLY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rA5jPD3yY6uL; Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4Y2th6z9v0CM;
        Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727101; bh=WeqLxZtr9LFGc7QK6NMnLOJ1YD4PPAgjsmOOJfb818k=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qfBhulLYnl51N21MMmLo279huThx4jtQC1qL/WJcUFmpbPx8PTjrw1K3k7b6Y0ZO+
         FYy/8s4IkGcFglyJOCtxis2ByUI9v+BXncZusntKKvVvroHEDSY4jatCdbgBgo16EN
         AYMorBS8NijUeTXcFx7gvjmzMBInGqEat3OfdzF0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89C298B7F2;
        Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eGQYKY7h5hGX; Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C8068B7F0;
        Tue, 13 Aug 2019 22:11:41 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2DF2469632; Tue, 13 Aug 2019 20:11:41 +0000 (UTC)
Message-Id: <84bab66e7afc4b35e2bd460a87b5911c1b0830d2.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 08/10] powerpc/mm: move __ioremap_at() and __iounmap_at()
 into ioremap.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allthough __ioremap_at() and __iounmap_at() are specific to PPC64,
lets move them into ioremap.c as it wouldn't be worth creating an
ioremap_64.c only for those functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ioremap.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c | 42 ------------------------------------------
 2 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 57d742509cec..889ee656cf64 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -103,3 +103,46 @@ void iounmap(volatile void __iomem *token)
 	vunmap(addr);
 }
 EXPORT_SYMBOL(iounmap);
+
+#ifdef CONFIG_PPC64
+/**
+ * __ioremap_at - Low level function to establish the page tables
+ *                for an IO mapping
+ */
+void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
+{
+	/* We don't support the 4K PFN hack with ioremap */
+	if (pgprot_val(prot) & H_PAGE_4K_PFN)
+		return NULL;
+
+	if ((ea + size) >= (void *)IOREMAP_END) {
+		pr_warn("Outside the supported range\n");
+		return NULL;
+	}
+
+	WARN_ON(pa & ~PAGE_MASK);
+	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
+	WARN_ON(size & ~PAGE_MASK);
+
+	if (ioremap_range((unsigned long)ea, pa, size, prot, NUMA_NO_NODE))
+		return NULL;
+
+	return (void __iomem *)ea;
+}
+EXPORT_SYMBOL(__ioremap_at);
+
+/**
+ * __iounmap_from - Low level function to tear down the page tables
+ *                  for an IO mapping. This is used for mappings that
+ *                  are manipulated manually, like partial unmapping of
+ *                  PCI IOs or ISA space.
+ */
+void __iounmap_at(void *ea, unsigned long size)
+{
+	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
+	WARN_ON(size & ~PAGE_MASK);
+
+	unmap_kernel_range((unsigned long)ea, size);
+}
+EXPORT_SYMBOL(__iounmap_at);
+#endif
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index b50a53a0a42b..32220f7381d7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -119,45 +119,6 @@ int __weak ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, p
 	return 0;
 }
 
-/**
- * __ioremap_at - Low level function to establish the page tables
- *                for an IO mapping
- */
-void __iomem *__ioremap_at(phys_addr_t pa, void *ea, unsigned long size, pgprot_t prot)
-{
-	/* We don't support the 4K PFN hack with ioremap */
-	if (pgprot_val(prot) & H_PAGE_4K_PFN)
-		return NULL;
-
-	if ((ea + size) >= (void *)IOREMAP_END) {
-		pr_warn("Outside the supported range\n");
-		return NULL;
-	}
-
-	WARN_ON(pa & ~PAGE_MASK);
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	if (ioremap_range((unsigned long)ea, pa, size, prot, NUMA_NO_NODE))
-		return NULL;
-
-	return (void __iomem *)ea;
-}
-
-/**
- * __iounmap_from - Low level function to tear down the page tables
- *                  for an IO mapping. This is used for mappings that
- *                  are manipulated manually, like partial unmapping of
- *                  PCI IOs or ISA space.
- */
-void __iounmap_at(void *ea, unsigned long size)
-{
-	WARN_ON(((unsigned long)ea) & ~PAGE_MASK);
-	WARN_ON(size & ~PAGE_MASK);
-
-	unmap_kernel_range((unsigned long)ea, size);
-}
-
 void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 				pgprot_t prot, void *caller)
 {
@@ -201,9 +162,6 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	return ret;
 }
 
-EXPORT_SYMBOL(__ioremap_at);
-EXPORT_SYMBOL(__iounmap_at);
-
 #ifndef __PAGETABLE_PUD_FOLDED
 /* 4 level page table */
 struct page *pgd_page(pgd_t pgd)
-- 
2.13.3

