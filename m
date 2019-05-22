Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7858C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977221479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfEVHUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:20:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40532 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfEVHUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:20:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1073820008A;
        Wed, 22 May 2019 09:20:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0057B200079;
        Wed, 22 May 2019 09:20:31 +0200 (CEST)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 97A152061A;
        Wed, 22 May 2019 09:20:30 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
Subject: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Date:   Wed, 22 May 2019 10:20:18 +0300
Message-Id: <20190522072018.10660-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the very beginning, the swiotlb implementation (and even before that,
pci implementation if we look in full git history) did not sync
the bounced buffer in case of DMA mapping using DMA_FROM_DEVICE direction.

However, this is incorrect since the device might not write to that area
at all (or might partially write to it), which leads to data corruption
in the sense that data in original buffer is lost (overwritten with
uninitialized data in the bounced buffer at DMA unmap time).

In general, DMA mapping using DMA_FROM_DEVICE does not mean existing data
should be thrown away.

Fix this by sync-ing the bounced buffer at DMA mapping time
irrespective of DMA direction.

Link: https://lore.kernel.org/lkml/584b54f6-bd12-d036-35e6-23eb2dabe811@arm.com
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---

I haven't provided a Fixes tag since this approach goes way back in time.
If you agree with the fix, we'll have to decide if it should go
into -stable and what's the earliest LTS branch to get the backport.

Patch is based on konrad/swiotlb.git, devel/for-linus-5.2 branch.

 kernel/dma/swiotlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 38d57218809c..f330222f0eb5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -545,13 +545,14 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 
 	/*
 	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
+	 * This is needed when we sync the memory.  Then we sync the buffer
+	 * irrespective of mapping direction - since for FROM_DEVICE we want to
+	 * make sure original data is not lost in the case of device not fully
+	 * overwriting the area mapped.
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
 
 	return tlb_addr;
-- 
2.17.1

