Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6226EC41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CC221871
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfHFOEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:04:13 -0400
Received: from verein.lst.de ([213.95.11.211]:56760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfHFOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:04:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31004227A81; Tue,  6 Aug 2019 16:04:09 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:04:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806140408.GA22902@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, does this work?

--
From 34d35f335a98f515f2516b515051e12eae744c8d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 6 Aug 2019 14:33:23 +0300
Subject: dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING

The new DMA_ATTR_NO_KERNEL_MAPPING needs to actually assign
a dma_addr to work.  Also skip it if the architecture needs
forced decryption handling, as that needs a kernel virtual
address.

Fixes: d98849aff879 (dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code)
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 59bdceea3737..b01064d884f2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -130,11 +130,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev)) {
 		/* remove any dirty cache lines on the kernel alias */
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
 		/* return the page pointer as the opaque cookie */
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 		return page;
 	}
 
-- 
2.20.1

