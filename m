Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC9BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA4C20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJcJrwq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfHFQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbfHFQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hA5e1EMCJqgYejGyHIpPpeJ8rKRPHls2nPKmf9TbEpQ=; b=LJcJrwq5ZQewZswvYmY5mRyZpk
        1/AAsPIRIW9UA0cst7PGgdo7pRhh4ePjyxEFTqCdsjh7EUORxH2CndglB5DcSZf9X3N8Sn6sKAltb
        WWBPJiV/lfl2ul+hsqSrk3D/C5ivDdgjfKPGZTXQhSeNBkogGgnyFlzPfkD559I+eEh9rfGeY2c5w
        FXeB6uScMW1EUmmFK+YdXOfdvFKqwMpCyBF9uzdonrdefrto7s1GONe11pm+yR0lE/qvtGNXNdtUe
        37jSnqybZHehtfCReL3qhmxac2PdimKbmfpWhqJn7mnocY10bShkJ+bK3Y3BkCgnsn/hpbFZ7MPsn
        8usxetzw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yd-0000b0-BS; Tue, 06 Aug 2019 16:06:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] mm: don't abuse pte_index() in hmm_vma_handle_pmd
Date:   Tue,  6 Aug 2019 19:05:47 +0300
Message-Id: <20190806160554.14046-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_index is an internal arch helper in various architectures,
without consistent semantics.  Open code that calculation of a PMD
index based on the virtual address instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 03d37e102e3b..2083e4db46f5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -486,7 +486,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 	if (pmd_protnone(pmd) || fault || write_fault)
 		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 
-	pfn = pmd_pfn(pmd) + pte_index(addr);
+	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
 		if (pmd_devmap(pmd)) {
 			pgmap = get_dev_pagemap(pfn, pgmap);
-- 
2.20.1

