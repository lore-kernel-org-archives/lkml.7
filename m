Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD91C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F88E21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cODSCc6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfLKMcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:32:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfLKMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lqUXsp1YoP1pMIfyAAamvA0e1hiYKdF5cDUHBRasd7E=; b=cODSCc6khjn9lP4A4q98C7H8NG
        1IjFybet2yMRA1nson2KvHNrOwtf8g9XdOTbDuvTeaGjj36PIV2VccJbEmWGm3kBpy8AbO16NCVK+
        nmvK+YZf72EbclqQZsBDlwP/8S6KFxZRf/CnPRVTFWvTDjXe6TDp3Vkj24o+GOBVER+FybJk1OXwy
        C9Atb2i3FbxYRcrD92DJXEyWG+jxZiQe4xXQjYuhwZXHjYcqJmb2Hyu2LLx9/04Gn4bWQjUGk8M0m
        wjRi/vKqGOBQc+9xo6s3NUtKkFW501Yo9LbdQjX38chWOZuG0FXE1AXixVugf2r4shoxEPp6UR6xy
        mrxb31zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if192-0001Pe-BZ; Wed, 11 Dec 2019 12:31:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0072530706D;
        Wed, 11 Dec 2019 13:29:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 559F920137CBC; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.514715737@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:28 +0100
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
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 15/17] alpha/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Since Alpha has page based PMDs, no software walkers and IPI based TLB
invalidation, it can use the simple tlb_remove_page() based freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/tlb.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/alpha/include/asm/tlb.h
+++ b/arch/alpha/include/asm/tlb.h
@@ -4,7 +4,16 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, address)		pte_free((tlb)->mm, pte)
-#define __pmd_free_tlb(tlb, pmd, address)		pmd_free((tlb)->mm, pmd)
+extern void ___pte_free_tlb(struct mmu_gather *tlb, pte_t *pte);
+extern void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd);
+
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
+
+#define __pmd_free_tlb(tlb, pmd, address)	\
+	tlb_remove_table((tlb), virt_to_page(pmd))
  
 #endif


