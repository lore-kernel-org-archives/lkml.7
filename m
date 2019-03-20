Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DD12175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rrJ+TXQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCTKG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8626 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfCTKGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZ45Z4dz9vC0B;
        Wed, 20 Mar 2019 11:06:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rrJ+TXQt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DsiIUSRnnjzN; Wed, 20 Mar 2019 11:06:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ44NqDz9vByx;
        Wed, 20 Mar 2019 11:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076412; bh=iYTDYIgOtVxX8iH/SKUL7hTlgw7ZdVQEMLbWoVp3Cjg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=rrJ+TXQtKwfIDxjfD0DsO+Rf+v8eFXmCsziLkOfqFUykn4/0DkO1He+VEhbZBIaOc
         IpjuK1tERJTdtSJUH8bHZAZ9suDIpvuPuLCMwLaZhuQlXGyXGRt26x6b2srCv781NW
         DTEKnjkaQgcyjgluGbGQkSfCP9FfqgBaKGJYMh44=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8AB58B918;
        Wed, 20 Mar 2019 11:06:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0e9hOgtSvnj8; Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CEB48B911;
        Wed, 20 Mar 2019 11:06:53 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 681DA63AEF; Wed, 20 Mar 2019 10:06:53 +0000 (UTC)
Message-Id: <48261d1836013a82b9574b3d453e0b7a88d03ae5.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 17/27] powerpc/mm: cleanup HPAGE_SHIFT setup
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only book3s/64 may select default among several HPAGE_SHIFT at runtime.
8xx always defines 512K pages as default
FSL_BOOK3E always defines 4M pages as default

This patch limits HUGETLB_PAGE_SIZE_VARIABLE to book3s/64
moves the definitions in subarches files.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                 |  2 +-
 arch/powerpc/include/asm/hugetlb.h   |  2 ++
 arch/powerpc/include/asm/page.h      | 11 ++++++++---
 arch/powerpc/mm/hugetlbpage-hash64.c | 16 ++++++++++++++++
 arch/powerpc/mm/hugetlbpage.c        | 23 +++--------------------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5d8e692d6470..7815eb0cc2a5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -390,7 +390,7 @@ source "kernel/Kconfig.hz"
 
 config HUGETLB_PAGE_SIZE_VARIABLE
 	bool
-	depends on HUGETLB_PAGE
+	depends on HUGETLB_PAGE && PPC_BOOK3S_64
 	default y
 
 config MATH_EMULATION
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 84598c6b0959..20a101046cff 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -15,6 +15,8 @@
 
 extern bool hugetlb_disabled;
 
+void hugetlbpage_init_default(void);
+
 void flush_dcache_icache_hugepage(struct page *page);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 0c11a7513919..eef10fe0e06f 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -28,10 +28,15 @@
 #define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
-#ifdef CONFIG_HUGETLB_PAGE
-extern unsigned int HPAGE_SHIFT;
-#else
+#ifndef CONFIG_HUGETLB_PAGE
 #define HPAGE_SHIFT PAGE_SHIFT
+#elif defined(CONFIG_PPC_BOOK3S_64)
+extern unsigned int hpage_shift;
+#define HPAGE_SHIFT hpage_shift
+#elif defined(CONFIG_PPC_8xx)
+#define HPAGE_SHIFT		19	/* 512k pages */
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#define HPAGE_SHIFT		22	/* 4M pages */
 #endif
 #define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index b0d9209d9a86..7a58204c3688 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -15,6 +15,9 @@
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 
+unsigned int hpage_shift;
+EXPORT_SYMBOL(hpage_shift);
+
 extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 				  unsigned long pa, unsigned long rlags,
 				  unsigned long vflags, int psize, int ssize);
@@ -145,3 +148,16 @@ void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr
 							   old_pte, pte);
 	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+void hugetlbpage_init_default(void)
+{
+	/* Set default large page size. Currently, we pick 16M or 1M
+	 * depending on what is available
+	 */
+	if (mmu_psize_defs[MMU_PAGE_16M].shift)
+		hpage_shift = mmu_psize_defs[MMU_PAGE_16M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
+		hpage_shift = mmu_psize_defs[MMU_PAGE_1M].shift;
+	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
+		hpage_shift = mmu_psize_defs[MMU_PAGE_2M].shift;
+}
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 3b449c9d4e47..dd62006e1243 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -28,9 +28,6 @@
 
 bool hugetlb_disabled = false;
 
-unsigned int HPAGE_SHIFT;
-EXPORT_SYMBOL(HPAGE_SHIFT);
-
 #define hugepd_none(hpd)	(hpd_val(hpd) == 0)
 
 #define PTE_T_ORDER	(__builtin_ffs(sizeof(pte_t)) - __builtin_ffs(sizeof(void *)))
@@ -646,23 +643,9 @@ static int __init hugetlbpage_init(void)
 #endif
 	}
 
-#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-	/* Default hpage size = 4M on FSL_BOOK3E and 512k on 8xx */
-	if (mmu_psize_defs[MMU_PAGE_4M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_4M].shift;
-	else if (mmu_psize_defs[MMU_PAGE_512K].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_512K].shift;
-#else
-	/* Set default large page size. Currently, we pick 16M or 1M
-	 * depending on what is available
-	 */
-	if (mmu_psize_defs[MMU_PAGE_16M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_16M].shift;
-	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_1M].shift;
-	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
-		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
-#endif
+	if (IS_ENABLED(HUGETLB_PAGE_SIZE_VARIABLE))
+		hugetlbpage_init_default();
+
 	return 0;
 }
 
-- 
2.13.3

