Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CCC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1024520C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDf9sTqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfG3Fw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfG3Fwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5I6cv8rPAulGunfRGkEsTPG6LGj3MyO3rpoe2rANz8U=; b=oDf9sTqLOFXjgtQQfZeUNN/vp5
        lCVFV/7Tr8JxHR/pQ+/TMmCyjB6NjzjA2mMLkEkCi7jL4ivm6humWCpK5bUJBpgGkIVEIqxfqPwDM
        4YTgjZfSuNSKi4iH6bf2ix1BFnAHfKSiDJt5tuFXYnbRAPanFBN7galzFX5sH/RzaX/Ar5BkCfFvd
        41uRDFgvEN7sG3tRwMzHosXwxm3yjKdGtPSFyxJvDop/5dTh5Q/5Zvl1zocmST9V55oZcYCaE7QDT
        9yH7K0Mb6/P0GmUwfW3WtYnIUZ9WM04YEB6aiSTy77a+Q6/+Ce1zgMON+82ync3MS6VeeHv8iSw9J
        klDnrBYw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL46-0001T1-B3; Tue, 30 Jul 2019 05:52:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] mm: cleanup the hmm_vma_walk_hugetlb_entry stub
Date:   Tue, 30 Jul 2019 08:52:02 +0300
Message-Id: <20190730055203.28467-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stub out the whole function and assign NULL to the .hugetlb_entry method
if CONFIG_HUGETLB_PAGE is not set, as the method won't ever be called in
that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f4e90ea5779f..2b56a4af1001 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -769,11 +769,11 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #define hmm_vma_walk_pud	NULL
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
 static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
 {
-#ifdef CONFIG_HUGETLB_PAGE
 	unsigned long addr = start, i, pfn;
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -812,10 +812,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 
 	return ret;
-#else /* CONFIG_HUGETLB_PAGE */
-	return -EINVAL;
-#endif
 }
+#else
+#define hmm_vma_walk_hugetlb_entry NULL
+#endif /* CONFIG_HUGETLB_PAGE */
 
 static void hmm_pfns_clear(struct hmm_range *range,
 			   uint64_t *pfns,
-- 
2.20.1

