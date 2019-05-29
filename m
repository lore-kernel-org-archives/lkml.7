Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B23C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2D20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2JEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:04:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfE2JEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:04:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AFA7AEFD;
        Wed, 29 May 2019 09:04:11 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 3/3] xen/swiotlb: remember having called xen_create_contiguous_region()
Date:   Wed, 29 May 2019 11:04:07 +0200
Message-Id: <20190529090407.1225-4-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529090407.1225-1-jgross@suse.com>
References: <20190529090407.1225-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of always calling xen_destroy_contiguous_region() in case the
memory is DMA-able for the used device, do so only in case it has been
made DMA-able via xen_create_contiguous_region() before.

This will avoid a lot of xen_destroy_contiguous_region() calls for
64-bit capable devices.

As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
flag of the first allocated page can be used for remembering.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: add PG_xen_remapped alias for PG_owner_priv_1 (Boris Ostrovsky)
    only clear page flag in case of sane conditions (Jan Beulich)
---
 drivers/xen/swiotlb-xen.c  | 6 +++++-
 include/linux/page-flags.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index aba5247b9145..7e2d9d1b6f63 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -321,6 +321,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
 			return NULL;
 		}
+		SetPageXenRemapped(virt_to_page(ret));
 	}
 	memset(ret, 0, size);
 	return ret;
@@ -345,8 +346,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	size = 1UL << (order + XEN_PAGE_SHIFT);
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
-		     range_straddles_page_boundary(phys, size)))
+		     range_straddles_page_boundary(phys, size)) &&
+	    PageXenRemapped(virt_to_page(vaddr))) {
 		xen_destroy_contiguous_region(phys, order);
+		ClearPageXenRemapped(virt_to_page(vaddr));
+	}
 
 	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
 }
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9f8712a4b1a5..296480e990f2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -152,6 +152,8 @@ enum pageflags {
 	PG_savepinned = PG_dirty,
 	/* Has a grant mapping of another (foreign) domain's page. */
 	PG_foreign = PG_owner_priv_1,
+	/* Remapped by swiotlb-xen. */
+	PG_xen_remapped = PG_owner_priv_1,
 
 	/* SLOB */
 	PG_slob_free = PG_private,
@@ -329,6 +331,7 @@ PAGEFLAG(Pinned, pinned, PF_NO_COMPOUND)
 	TESTSCFLAG(Pinned, pinned, PF_NO_COMPOUND)
 PAGEFLAG(SavePinned, savepinned, PF_NO_COMPOUND);
 PAGEFLAG(Foreign, foreign, PF_NO_COMPOUND);
+PAGEFLAG(XenRemapped, xen_remapped, PF_NO_COMPOUND);
 
 PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
 	__CLEARPAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
-- 
2.16.4

