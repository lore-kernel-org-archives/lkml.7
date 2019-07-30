Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127AB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qUVDb0Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbfG3Fwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfG3Fws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/5sNjyutpvGxyHVQu1GnV/XZDve/kWrhGHnNmckcmW4=; b=qUVDb0Gb7qkDZ66Y+5kTNUPiZS
        oPKFdf1FdqOh8A+YmmGZN9LNdSXHfAWdAy/P90p3MOCc2Z96eNVGgpwDoqMg90kChee4ehDTqgr0j
        Pkj3WfEI90d1K0L5yj8xDhi4zgmFwII7fKqNTkcOh87hmP8aIWYto5bpxj6Uy1e0sMmXDfuZHNiQe
        ryhsB5F5qd969AsJYWXGSU3b3LjXZyE7SQi6J6IID+hg37hn/a03/WzGB57Vb+NcFVUtwUa5rdmZi
        cmRAd6TOTOi1MrSWzl3EdA3D5NUMB0guYKclteB1z/GzP1uvBIhvL0Mxg647o4EVb80KI84ij7PDP
        xbU47HuQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL40-0001NU-9X; Tue, 30 Jul 2019 05:52:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] mm: only define hmm_vma_walk_pud if needed
Date:   Tue, 30 Jul 2019 08:52:00 +0300
Message-Id: <20190730055203.28467-11-hch@lst.de>
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

We only need the special pud_entry walker if PUD-sized hugepages and
pte mappings are supported, else the common pagewalk code will take
care of the iteration.  Not implementing this callback reduced the
amount of code compiled for non-x86 platforms, and also fixes compile
failures with other architectures when helpers like pud_pfn are not
implemented.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e63ab7f11334..4d3bd41b6522 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -455,15 +455,6 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
-{
-	if (!pud_present(pud))
-		return 0;
-	return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
-				range->flags[HMM_PFN_WRITE] :
-				range->flags[HMM_PFN_VALID];
-}
-
 static int hmm_vma_handle_pmd(struct mm_walk *walk,
 			      unsigned long addr,
 			      unsigned long end,
@@ -700,10 +691,19 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
-static int hmm_vma_walk_pud(pud_t *pudp,
-			    unsigned long start,
-			    unsigned long end,
-			    struct mm_walk *walk)
+#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && \
+    defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
+static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
+{
+	if (!pud_present(pud))
+		return 0;
+	return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
+				range->flags[HMM_PFN_WRITE] :
+				range->flags[HMM_PFN_VALID];
+}
+
+static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
+		struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -765,6 +765,9 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 
 	return 0;
 }
+#else
+#define hmm_vma_walk_pud	NULL
+#endif
 
 static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				      unsigned long start, unsigned long end,
-- 
2.20.1

