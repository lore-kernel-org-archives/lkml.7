Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57182217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXUwnk7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfG2O3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfG2O3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=btXxqezSTYpMi2lLCeQ3gcAVYHUyBBOdSXXsZurrEew=; b=ZXUwnk7xK0eKvyNMCJiotaRVYY
        rDFhDzOGkIe8OqjwqnrED1/er13fgyYhrlvT/BdF5iqD2+fHbtr+SI6BVjX7Y8UUDrM5++0RTtGD+
        A6wiqxzp5hNljbLRwzQ62Oxo0eirdUqNPJBq/QV7OfJFQt+QafoC8dV+5GO3zFNzfnYPHLQIGe9Me
        uVgP7tYhnsmBNwE9+DLYy6MFGcMI2KOY40RRE4FWvTaRyAvNOgfRu14N1QeGfaqlBnzHHd60ZFwpx
        XrKs7PeR4RmkKc8b/thC2CTBP75FhQaJQp1/nAV/tBf5G2wLyPJyvf25PxBVnv3It7Os91C9hkzNf
        KazPletQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6eK-0006O9-Rc; Mon, 29 Jul 2019 14:29:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] mm: remove the unused MIGRATE_PFN_DEVICE flag
Date:   Mon, 29 Jul 2019 17:28:42 +0300
Message-Id: <20190729142843.22320-9-hch@lst.de>
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

No one ever checks this flag, and we could easily get that information
from the page if needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 +--
 include/linux/migrate.h                | 1 -
 mm/migrate.c                           | 4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 6cb930755970..f04686a2c21f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -582,8 +582,7 @@ static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm,
 			*dma_addr))
 		goto out_dma_unmap;
 
-	return migrate_pfn(page_to_pfn(dpage)) |
-		MIGRATE_PFN_LOCKED | MIGRATE_PFN_DEVICE;
+	return migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
 
 out_dma_unmap:
 	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 229153c2c496..8b46cfdb1a0e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -166,7 +166,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 #define MIGRATE_PFN_MIGRATE	(1UL << 1)
 #define MIGRATE_PFN_LOCKED	(1UL << 2)
 #define MIGRATE_PFN_WRITE	(1UL << 3)
-#define MIGRATE_PFN_DEVICE	(1UL << 4)
 #define MIGRATE_PFN_SHIFT	6
 
 static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
diff --git a/mm/migrate.c b/mm/migrate.c
index dc4e60a496f2..74735256e260 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2237,8 +2237,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = device_private_entry_to_page(entry);
-			mpfn = migrate_pfn(page_to_pfn(page))|
-				MIGRATE_PFN_DEVICE | MIGRATE_PFN_MIGRATE;
+			mpfn = migrate_pfn(page_to_pfn(page)) |
+					MIGRATE_PFN_MIGRATE;
 			if (is_write_device_private_entry(entry))
 				mpfn |= MIGRATE_PFN_WRITE;
 		} else {
-- 
2.20.1

