Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE76C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333DE20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="qbmziYdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfDYO3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:29:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19790 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfDYO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:29:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44qfhd0D9xz9v0SD;
        Thu, 25 Apr 2019 16:29:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qbmziYdd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LOHiPcKbS1NY; Thu, 25 Apr 2019 16:29:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhc6Dljz9v0SC;
        Thu, 25 Apr 2019 16:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556202576; bh=AUSYZpYmEaJQ2oANoAJMV/aOoYD8xEh/CyM2zMzJ7xc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qbmziYddU4C04RPUCZU8qHcyJOFdCMSTTO0O0GrbSEBJUfHxcgv14iz2hfnvgx7GQ
         gW96MNg7j+yVAg3YbKm30APceXvFZ6vB2FferDBd48Z2GoE3J0UqRhD8kC3B91y+NJ
         Pm7WtaPOkptlAde6CQq/AuJYdsEN49WMc7ceE4oM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68C7C8B931;
        Thu, 25 Apr 2019 16:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T9NAZ1FJBDsc; Thu, 25 Apr 2019 16:29:38 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 267398B923;
        Thu, 25 Apr 2019 16:29:38 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DD2BF66276; Thu, 25 Apr 2019 14:29:37 +0000 (UTC)
Message-Id: <f263887b4ca31f4bb0fe77823e301c28ba27c796.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/11] powerpc/mm: drop slice DEBUG
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Apr 2019 14:29:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slice is now an improved functionnality. Drop the DEBUG stuff.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/slice.c | 62 ++++---------------------------------------------
 1 file changed, 4 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 97fbf7b54422..a9d803738b65 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -41,28 +41,6 @@
 
 static DEFINE_SPINLOCK(slice_convert_lock);
 
-#ifdef DEBUG
-int _slice_debug = 1;
-
-static void slice_print_mask(const char *label, const struct slice_mask *mask)
-{
-	if (!_slice_debug)
-		return;
-	pr_devel("%s low_slice: %*pbl\n", label,
-			(int)SLICE_NUM_LOW, &mask->low_slices);
-	pr_devel("%s high_slice: %*pbl\n", label,
-			(int)SLICE_NUM_HIGH, mask->high_slices);
-}
-
-#define slice_dbg(fmt...) do { if (_slice_debug) pr_devel(fmt); } while (0)
-
-#else
-
-static void slice_print_mask(const char *label, const struct slice_mask *mask) {}
-#define slice_dbg(fmt...)
-
-#endif
-
 static inline bool slice_addr_is_low(unsigned long addr)
 {
 	u64 tmp = (u64)addr;
@@ -207,9 +185,6 @@ static void slice_convert(struct mm_struct *mm,
 	unsigned long i, flags;
 	int old_psize;
 
-	slice_dbg("slice_convert(mm=%p, psize=%d)\n", mm, psize);
-	slice_print_mask(" mask", mask);
-
 	psize_mask = slice_mask_for_size(&mm->context, psize);
 
 	/* We need to use a spinlock here to protect against
@@ -255,10 +230,6 @@ static void slice_convert(struct mm_struct *mm,
 				(((unsigned long)psize) << (mask_index * 4));
 	}
 
-	slice_dbg(" lsps=%lx, hsps=%lx\n",
-		  (unsigned long)mm_ctx_low_slices(&mm->context),
-		  (unsigned long)mm_ctx_high_slices(&mm->context));
-
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
@@ -485,14 +456,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	BUG_ON(mm_ctx_slb_addr_limit(&mm->context) == 0);
 	VM_BUG_ON(radix_enabled());
 
-	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
-	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
-		  addr, len, flags, topdown);
-
 	/* If hint, make sure it matches our alignment restrictions */
 	if (!fixed && addr) {
 		addr = _ALIGN_UP(addr, page_size);
-		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
 		if (addr > high_limit - len || addr < mmap_min_addr ||
 		    !slice_area_is_free(mm, addr, len))
@@ -538,17 +504,12 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		slice_copy_mask(&good_mask, maskp);
 	}
 
-	slice_print_mask(" good_mask", &good_mask);
-	if (compat_maskp)
-		slice_print_mask(" compat_mask", compat_maskp);
-
 	/* First check hint if it's valid or if we have MAP_FIXED */
 	if (addr != 0 || fixed) {
 		/* Check if we fit in the good mask. If we do, we just return,
 		 * nothing else to do
 		 */
 		if (slice_check_range_fits(mm, &good_mask, addr, len)) {
-			slice_dbg(" fits good !\n");
 			newaddr = addr;
 			goto return_addr;
 		}
@@ -558,13 +519,10 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 */
 		newaddr = slice_find_area(mm, len, &good_mask,
 					  psize, topdown, high_limit);
-		if (newaddr != -ENOMEM) {
-			/* Found within the good mask, we don't have to setup,
-			 * we thus return directly
-			 */
-			slice_dbg(" found area at 0x%lx\n", newaddr);
+
+		/* Found within good mask, don't have to setup, thus return directly */
+		if (newaddr != -ENOMEM)
 			goto return_addr;
-		}
 	}
 	/*
 	 * We don't fit in the good mask, check what other slices are
@@ -572,11 +530,9 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	 */
 	slice_mask_for_free(mm, &potential_mask, high_limit);
 	slice_or_mask(&potential_mask, &potential_mask, &good_mask);
-	slice_print_mask(" potential", &potential_mask);
 
 	if (addr != 0 || fixed) {
 		if (slice_check_range_fits(mm, &potential_mask, addr, len)) {
-			slice_dbg(" fits potential !\n");
 			newaddr = addr;
 			goto convert;
 		}
@@ -586,18 +542,14 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	if (fixed)
 		return -EBUSY;
 
-	slice_dbg(" search...\n");
-
 	/* If we had a hint that didn't work out, see if we can fit
 	 * anywhere in the good area.
 	 */
 	if (addr) {
 		newaddr = slice_find_area(mm, len, &good_mask,
 					  psize, topdown, high_limit);
-		if (newaddr != -ENOMEM) {
-			slice_dbg(" found area at 0x%lx\n", newaddr);
+		if (newaddr != -ENOMEM)
 			goto return_addr;
-		}
 	}
 
 	/* Now let's see if we can find something in the existing slices
@@ -618,8 +570,6 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		return -ENOMEM;
 
 	slice_range_to_mask(newaddr, len, &potential_mask);
-	slice_dbg(" found potential area at 0x%lx\n", newaddr);
-	slice_print_mask(" mask", &potential_mask);
 
  convert:
 	/*
@@ -697,8 +647,6 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 	struct slice_mask *mask;
 	unsigned int psize = mmu_virtual_psize;
 
-	slice_dbg("slice_init_new_context_exec(mm=%p)\n", mm);
-
 	/*
 	 * In the case of exec, use the default limit. In the
 	 * case of fork it is just inherited from the mm being
@@ -730,8 +678,6 @@ void slice_setup_new_exec(void)
 {
 	struct mm_struct *mm = current->mm;
 
-	slice_dbg("slice_setup_new_exec(mm=%p)\n", mm);
-
 	if (!is_32bit_task())
 		return;
 
-- 
2.13.3

