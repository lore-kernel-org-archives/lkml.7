Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2389FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93312175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PwU+T+Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCTKGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:06:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30197 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfCTKGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:06:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZ04RDgz9vByy;
        Wed, 20 Mar 2019 11:06:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PwU+T+Y6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PX6hGgKCuwLw; Wed, 20 Mar 2019 11:06:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZ03G8Sz9vByx;
        Wed, 20 Mar 2019 11:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076408; bh=Guh3jdarvREMy9XI7NXgO+/Y6kZ5VjrGMUUFuRWHaI4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=PwU+T+Y6NUJXTR3ei3rw5qVGoMy5/nImwOjN7JP9KlI0uri24NBmy6SMEZ+XNWTTd
         4nJ9KlVFbDjLcRfafr3CF6IlaZKfHcH7V96w2jRwx0bQUQbsheXX/WYE6my0xqQ0bH
         un0S76OJp8DoM9cSWqUAdKizmSy+Vu+x7G1Ywrm4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C59B8B911;
        Wed, 20 Mar 2019 11:06:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MEak5RtUmh9U; Wed, 20 Mar 2019 11:06:49 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61C1D8B918;
        Wed, 20 Mar 2019 11:06:49 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3CDB463AEF; Wed, 20 Mar 2019 10:06:49 +0000 (UTC)
Message-Id: <f5d51418cbc9145c202bfeb047133ef435dcbb40.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 13/27] powerpc/mm: define get_slice_psize() all the time
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_slice_psize() can be defined regardless of CONFIG_PPC_MM_SLICES
to avoid ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/slice.h | 4 ++++
 arch/powerpc/mm/hugetlbpage.c    | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index 44816cbc4198..d85c85422fdf 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -38,6 +38,10 @@ void slice_setup_new_exec(void);
 
 static inline void slice_init_new_context_exec(struct mm_struct *mm) {}
 
+#ifndef get_slice_psize
+#define get_slice_psize(mm, addr)	MMU_PAGE_4K
+#endif
+
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 26a57ebaf5cf..87358b89513e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -540,14 +540,12 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
-#ifdef CONFIG_PPC_MM_SLICES
 	/* With radix we don't use slice, so derive it from vma*/
-	if (!radix_enabled()) {
+	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled()) {
 		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
 
 		return 1UL << mmu_psize_to_shift(psize);
 	}
-#endif
 	return vma_kernel_pagesize(vma);
 }
 
-- 
2.13.3

