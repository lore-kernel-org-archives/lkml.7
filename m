Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51249C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5282B2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hf85m0Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfDYOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:30:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38935 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfDYO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:29:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44qfhX5bMgz9v07C;
        Thu, 25 Apr 2019 16:29:32 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hf85m0Rr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3CVhHm4ymvpm; Thu, 25 Apr 2019 16:29:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhX3zzVz9v06V;
        Thu, 25 Apr 2019 16:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556202572; bh=2iXuU3rvHrueIxyB8zRgvHBrUoFxPmWhG/1O+zaDkH8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=hf85m0Rr7tacLBCzT/O8fczboWu5AJE1VhIsW1AVnWKdcbQznAN3o58UfMZjoDBE0
         V/29bfkOYRCWGeel1Jab4zq1VYyKrh+bdfOesaXUrKjcmRlyo8rTLxIKzH+DeWE2t1
         nM/rWBDV5yYv0vmJEGsDswFRoOTeLd1Z4oVS/iFY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B1028B931;
        Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tC3i-B0MLC8c; Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBE8D8B923;
        Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BBA2166276; Thu, 25 Apr 2019 14:29:33 +0000 (UTC)
Message-Id: <cf8573caf0896a7a1a7fee72280ca09f7096923b.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/11] powerpc/mm: remove a couple of #ifdef
 CONFIG_PPC_64K_PAGES in mm/slice.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Apr 2019 14:29:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces a couple of #ifdef CONFIG_PPC_64K_PAGES
by IS_ENABLED(CONFIG_PPC_64K_PAGES) to improve code maintainability.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 840c4118a185..ace97d953040 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -606,14 +606,13 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	newaddr = slice_find_area(mm, len, &potential_mask,
 				  psize, topdown, high_limit);
 
-#ifdef CONFIG_PPC_64K_PAGES
-	if (newaddr == -ENOMEM && psize == MMU_PAGE_64K) {
+	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && newaddr == -ENOMEM &&
+	    psize == MMU_PAGE_64K) {
 		/* retry the search with 4k-page slices included */
 		slice_or_mask(&potential_mask, &potential_mask, compat_maskp);
 		newaddr = slice_find_area(mm, len, &potential_mask,
 					  psize, topdown, high_limit);
 	}
-#endif
 
 	if (newaddr == -ENOMEM)
 		return -ENOMEM;
@@ -784,9 +783,9 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(radix_enabled());
 
 	maskp = slice_mask_for_size(&mm->context, psize);
-#ifdef CONFIG_PPC_64K_PAGES
+
 	/* We need to account for 4k slices too */
-	if (psize == MMU_PAGE_64K) {
+	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
 		const struct slice_mask *compat_maskp;
 		struct slice_mask available;
 
@@ -794,7 +793,6 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 		slice_or_mask(&available, maskp, compat_maskp);
 		return !slice_check_range_fits(mm, &available, addr, len);
 	}
-#endif
 
 	return !slice_check_range_fits(mm, maskp, addr, len);
 }
-- 
2.13.3

