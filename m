Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E752C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CBF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsKqXUcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfG2O3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfG2O3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UZ1iiZ91D5ta7woyBUt0JspQpjAYy1irdMsZOOrHXMc=; b=PsKqXUcN7z7Xz9gU7L79usjrqd
        1TEUjHamWsPT+rB4y+/yJm/EmvCFSl7ml+1TBJeGQpJ7BwVxO9wF2ewwlhrRVlZhQ2fn7eM4nvSru
        Htj0+NqPiUUfos5bsZ+wlkRab0SxVL9RrtXQZ0X5t45PUuUj7wuHcCn43N+m+i27dIdLRZryJCjb+
        p41WXKWECLMO9LZLn3XL4a/cY1LJKbqbDtDs9Mnwi1jx/mtoDZJwIzftrtvBMEa3DqdCL4xlxrb9T
        Pn5dnuGhyiDr2tSO2dx5kndNT3pjthrpWfVIQvSgWUpbBrW0LeWUm490FPAwN1pfH7BrK6o7UT0aq
        y3B5AiUQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6eN-0006P2-Jm; Mon, 29 Jul 2019 14:29:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] mm: remove the MIGRATE_PFN_WRITE flag
Date:   Mon, 29 Jul 2019 17:28:43 +0300
Message-Id: <20190729142843.22320-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729142843.22320-1-hch@lst.de>
References: <20190729142843.22320-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIGRATE_PFN_WRITE is only used locally in migrate_vma_collect_pmd,
where it can be replaced with a simple boolean local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/migrate.h | 1 -
 mm/migrate.c            | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 8b46cfdb1a0e..ba74ef5a7702 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -165,7 +165,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 #define MIGRATE_PFN_VALID	(1UL << 0)
 #define MIGRATE_PFN_MIGRATE	(1UL << 1)
 #define MIGRATE_PFN_LOCKED	(1UL << 2)
-#define MIGRATE_PFN_WRITE	(1UL << 3)
 #define MIGRATE_PFN_SHIFT	6
 
 static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
diff --git a/mm/migrate.c b/mm/migrate.c
index 74735256e260..724f92dcc31b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2212,6 +2212,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		unsigned long mpfn, pfn;
 		struct page *page;
 		swp_entry_t entry;
+		bool writable = false;
 		pte_t pte;
 
 		pte = *ptep;
@@ -2240,7 +2241,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			mpfn = migrate_pfn(page_to_pfn(page)) |
 					MIGRATE_PFN_MIGRATE;
 			if (is_write_device_private_entry(entry))
-				mpfn |= MIGRATE_PFN_WRITE;
+				writable = true;
 		} else {
 			if (is_zero_pfn(pfn)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
@@ -2250,7 +2251,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
-			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
+			if (pte_write(pte))
+				writable = true;
 		}
 
 		/* FIXME support THP */
@@ -2284,8 +2286,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			ptep_get_and_clear(mm, addr, ptep);
 
 			/* Setup special migration page table entry */
-			entry = make_migration_entry(page, mpfn &
-						     MIGRATE_PFN_WRITE);
+			entry = make_migration_entry(page, writable);
 			swp_pte = swp_entry_to_pte(entry);
 			if (pte_soft_dirty(pte))
 				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-- 
2.20.1

