Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B597FC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfGKFdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:33:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58882 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfGKFdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:33:52 -0400
X-UUID: 327af44e836944e1adb3d59daca23acd-20190711
X-UUID: 327af44e836944e1adb3d59daca23acd-20190711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1269385009; Thu, 11 Jul 2019 13:33:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Jul 2019 13:33:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Jul 2019 13:33:44 +0800
From:   <miles.chen@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] kernel/dma: export dma_alloc_from_contiguous to modules
Date:   Thu, 11 Jul 2019 13:33:43 +0800
Message-ID: <20190711053343.28873-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

This change exports dma_alloc_from_contiguous and
dma_release_from_contiguous to modules.

Currently, we can add a reserve a memory node in dts files, make
it a CMA memory by setting compatible = "shared-dma-pool",
and setup the dev->cma_area by using of_reserved_mem_device_init_by_idx().

Export dma_alloc_from_contiguous and dma_release_from_contiguous, so we
can allocate/free from/to dev->cma_area in kernel modules.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 kernel/dma/contiguous.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..d5920bdedc77 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 
 	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
+EXPORT_SYMBOL_GPL(dma_alloc_from_contiguous);
 
 /**
  * dma_release_from_contiguous() - release allocated pages
@@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 {
 	return cma_release(dev_get_cma_area(dev), pages, count);
 }
+EXPORT_SYMBOL_GPL(dma_release_from_contiguous);
 
 /*
  * Support for reserved memory regions defined in device tree
-- 
2.18.0

