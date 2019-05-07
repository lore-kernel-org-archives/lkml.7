Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751A4C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53A214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEHAKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:10:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:18957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfEHAKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:10:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 17:10:02 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 07 May 2019 17:10:02 -0700
Subject: [PATCH v2 3/6] PCI/P2PDMA: Fix the gen_pool_add_virt() failure path
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org
Date:   Tue, 07 May 2019 16:56:16 -0700
Message-ID: <155727337603.292046.13101332703665246702.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pci_p2pdma_add_resource() implementation immediately frees the pgmap
if gen_pool_add_virt() fails. However, that means that when @dev
triggers a devres release devm_memremap_pages_release() will crash
trying to access the freed @pgmap.

Use the new devm_memunmap_pages() to manually free the mapping in the
error path.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/pci/p2pdma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c52298d76e64..595a534bd749 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -208,13 +208,15 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			pci_bus_address(pdev, bar) + offset,
 			resource_size(&pgmap->res), dev_to_node(&pdev->dev));
 	if (error)
-		goto pgmap_free;
+		goto pages_free;
 
 	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
 		 &pgmap->res);
 
 	return 0;
 
+pages_free:
+	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:
 	devm_kfree(&pdev->dev, pgmap);
 	return error;

