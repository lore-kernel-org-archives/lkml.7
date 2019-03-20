Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96167C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB02175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TQXZxeT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCTKGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34560 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbfCTKGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQYt25T2z9vC06;
        Wed, 20 Mar 2019 11:06:42 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TQXZxeT2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WVE-TlxJpOpn; Wed, 20 Mar 2019 11:06:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQYt0wpbz9vByx;
        Wed, 20 Mar 2019 11:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076402; bh=j/pbUh2lV6lGY76AVFXOvIL2hKV9TjaV0N8Gw3Pr04w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=TQXZxeT2AMBg0RuIwxGIBu/Mz7ipdNXYjx89M9BIkmNvi7nBnhuUtRa6CeFIzbGFc
         P+i+qT1Q8Eeg3UIOyZWDFUXdd55QxDqlMJymSPKw9m0CA+u6BXZMmjnp0fQXGuUz/f
         YXQ5VMkCvEg3S5z/OgPP+xQZWICNf8sw8rtmb+1w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31AFA8B919;
        Wed, 20 Mar 2019 11:06:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tXCopxwffxpb; Wed, 20 Mar 2019 11:06:43 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E0BC8B911;
        Wed, 20 Mar 2019 11:06:43 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E57DE63AEF; Wed, 20 Mar 2019 10:06:42 +0000 (UTC)
Message-Id: <03f48e9485ad3d536d08405d0a65c221b8c93f1a.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 07/27] powerpc/book3e: hugetlbpage is only for
 CONFIG_PPC_FSL_BOOK3E
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Kconfig.cputype, only CONFIG_PPC_FSL_BOOK3E gets to
select SYS_SUPPORTS_HUGETLBFS so simplify accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile             |  2 +-
 arch/powerpc/mm/hugetlbpage-book3e.c | 47 +++++++++++++++---------------------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c1bd9fa23cd..2c23d1ece034 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -37,7 +37,7 @@ obj-y				+= hugetlbpage.o
 ifdef CONFIG_HUGETLB_PAGE
 obj-$(CONFIG_PPC_BOOK3S_64)	+= hugetlbpage-hash64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= hugetlbpage-radix.o
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= hugetlbpage-book3e.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= hugetlbpage-book3e.o
 endif
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += hugepage-hash64.o
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index c911fe9bfa0e..61915f4d3c7f 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -11,8 +11,9 @@
 
 #include <asm/mmu.h>
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
 #ifdef CONFIG_PPC64
+#include <asm/paca.h>
+
 static inline int tlb1_next(void)
 {
 	struct paca_struct *paca = get_paca();
@@ -29,28 +30,6 @@ static inline int tlb1_next(void)
 	tcd->esel_next = next;
 	return this;
 }
-#else
-static inline int tlb1_next(void)
-{
-	int index, ncams;
-
-	ncams = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
-
-	index = this_cpu_read(next_tlbcam_idx);
-
-	/* Just round-robin the entries and wrap when we hit the end */
-	if (unlikely(index == ncams - 1))
-		__this_cpu_write(next_tlbcam_idx, tlbcam_index);
-	else
-		__this_cpu_inc(next_tlbcam_idx);
-
-	return index;
-}
-#endif /* !PPC64 */
-#endif /* FSL */
-
-#if defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC64)
-#include <asm/paca.h>
 
 static inline void book3e_tlb_lock(void)
 {
@@ -93,6 +72,23 @@ static inline void book3e_tlb_unlock(void)
 	paca->tcd_ptr->lock = 0;
 }
 #else
+static inline int tlb1_next(void)
+{
+	int index, ncams;
+
+	ncams = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
+
+	index = this_cpu_read(next_tlbcam_idx);
+
+	/* Just round-robin the entries and wrap when we hit the end */
+	if (unlikely(index == ncams - 1))
+		__this_cpu_write(next_tlbcam_idx, tlbcam_index);
+	else
+		__this_cpu_inc(next_tlbcam_idx);
+
+	return index;
+}
+
 static inline void book3e_tlb_lock(void)
 {
 }
@@ -134,10 +130,7 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	unsigned long psize, tsize, shift;
 	unsigned long flags;
 	struct mm_struct *mm;
-
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	int index;
-#endif
 
 	if (unlikely(is_kernel_addr(ea)))
 		return;
@@ -161,11 +154,9 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 		return;
 	}
 
-#ifdef CONFIG_PPC_FSL_BOOK3E
 	/* We have to use the CAM(TLB1) on FSL parts for hugepages */
 	index = tlb1_next();
 	mtspr(SPRN_MAS0, MAS0_ESEL(index) | MAS0_TLBSEL(1));
-#endif
 
 	mas1 = MAS1_VALID | MAS1_TID(mm->context.id) | MAS1_TSIZE(tsize);
 	mas2 = ea & ~((1UL << shift) - 1);
-- 
2.13.3

