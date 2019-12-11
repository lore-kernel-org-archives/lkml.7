Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD02C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93749214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQp5EnhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfLKMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:31:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfLKMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LTZ/BPfJTPVp0bgwkMHutu1dARSjSH9NSFpOWuJS0KI=; b=GQp5EnhZlhc0hKF8Vwa6Mskdi1
        UfPcurHOEBZni5wRyasGcG4fCkyZjzSvxlJ/Gu5hbQ7dPfUqQxZAY3cP2mhVN9VGplKUhqr1/625g
        uZJ4qRBnW6m5jD71YcDOU/OiqNWSIJSLWOUBdKmxgTz3/u3BvHJf6oqrgUw79kKNjd4ZsqUMyQS0i
        BmBH9gqK8L9tSy3O/8zJjvNaZzIxoAmvokMDpoFApIjRyi/Y1B497JToHbMm58kOqKLA04OWT1TmN
        vHbvLQK60tbSK1LdHDF413P+wBgmlDcjU/4YJSgKobQ2pk/a/bwhfA5Y2QV2A0ITU4R+h58heLQDE
        6QqKg4yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if18z-0001PJ-Tz; Wed, 11 Dec 2019 12:31:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8800530603E;
        Wed, 11 Dec 2019 13:29:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1BF152026FBC3; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122955.711253433@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/17] sh/tlb: Fix PGTABLE_LEVELS > 2
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert reported that his SH7722-based Migo-R board failed to boot after
commit:

  c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")

That commit fell victim to copying the wrong pattern --
__pmd_free_tlb() used to be implemented with pmd_free().

Fixes: c5b27a889da9 ("sh/tlb: Convert SH to generic mmu_gather")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -12,6 +12,7 @@ extern void pgd_free(struct mm_struct *m
 extern void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd);
 extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
 extern void pmd_free(struct mm_struct *mm, pmd_t *pmd);
+#define __pmd_free_tlb(tlb, pmdp, addr)		pmd_free((tlb)->mm, (pmdp))
 #endif
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
@@ -33,13 +34,4 @@ do {							\
 	tlb_remove_page((tlb), (pte));			\
 } while (0)
 
-#if CONFIG_PGTABLE_LEVELS > 2
-#define __pmd_free_tlb(tlb, pmdp, addr)			\
-do {							\
-	struct page *page = virt_to_page(pmdp);		\
-	pgtable_pmd_page_dtor(page);			\
-	tlb_remove_page((tlb), page);			\
-} while (0);
-#endif
-
 #endif /* __ASM_SH_PGALLOC_H */


