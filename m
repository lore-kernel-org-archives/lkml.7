Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8AF20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfHFPoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:44:09 -0400
Received: from verein.lst.de ([213.95.11.211]:57434 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfHFPoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:44:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9842B227A8A; Tue,  6 Aug 2019 17:44:03 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:44:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190806154403.GA25050@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com> <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565100418.2323.32.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 04:06:58PM +0200, Lucas Stach wrote:
> 
> dma_direct_free_pages() then needs the same check, as otherwise the cpu
> address is treated as a cookie instead of a real address and the
> encryption needs to be re-enabled.

Ok, lets try this one instead:

--
From 3a7aa9fe38a5eae5d879831b4f8c1032e735a0b6 Mon Sep 17 00:00:00 2001
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
 kernel/dma/direct.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 59bdceea3737..4c211c87a719 100644
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
 
@@ -178,7 +180,8 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		__dma_direct_free_pages(dev, size, cpu_addr);
 		return;
-- 
2.20.1

