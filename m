Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F672089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="m6ymIbjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437205AbfIJRtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:49:51 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28150 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfIJRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568137790; x=1599673790;
  h=from:to:subject:date:message-id:in-reply-to:references;
  bh=TWMkQtCBlL578v4YLPeK5EGe2lJw/CTmN/BUW7ZfNjY=;
  b=m6ymIbjHXIOugDHnZgRdLjQ2DSlWujcyON7SrZx2LEGNn6vZZJH2k7qU
   fa4MKf2N21NNkKpv170/mH60B9wecXH85h5j08e0/adIbfkEXFFOhO6af
   IBwb9XiuEIssctkwNi7FZ4JihEAE2Qd1gyWqjOXA5AUxSoGcmxmm8kmDF
   s=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="750019361"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Sep 2019 17:49:48 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id E6F6BA0464;
        Tue, 10 Sep 2019 17:49:46 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x8AHnjFI023835;
        Tue, 10 Sep 2019 19:49:45 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id x8AHniMh023833;
        Tue, 10 Sep 2019 19:49:44 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iommu/amd: Hold the domain lock when calling iommu_map_page
Date:   Tue, 10 Sep 2019 19:49:24 +0200
Message-Id: <1568137765-20278-5-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu_map_page calls into __domain_flush_pages, which requires the
domain lock since it traverses the device list, which the lock protects.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d4f25767622e..3714ae5ded31 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2562,6 +2562,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	unsigned long address;
 	u64 dma_mask;
 	int ret;
+	unsigned long flags;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2587,7 +2588,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
+			spin_lock_irqsave(&domain->lock, flags);
 			ret = iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, GFP_ATOMIC);
+			spin_unlock_irqrestore(&domain->lock, flags);
 			if (ret)
 				goto out_unmap;
 
@@ -3095,7 +3098,9 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IW;
 
 	mutex_lock(&domain->api_lock);
+	spin_lock(&domain->lock);
 	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
+	spin_unlock(&domain->lock);
 	mutex_unlock(&domain->api_lock);
 
 	domain_flush_np_cache(domain, iova, page_size);
-- 
2.7.4

