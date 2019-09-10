Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBBAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4582171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="DoXnPZpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437226AbfIJRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:50:09 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2144 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437206AbfIJRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1568137807; x=1599673807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mJRW8lKwbthmLc8gotnL669qFNsjqI2ujReZHQn2tbQ=;
  b=DoXnPZpNIxMywwVrYkhaMNy4d0RYKG92Ucsnfb8V4EBVu/0pYVQdILOu
   B8d1EWyOpqXFT6A0vgT7XzDbfp5ndlc9TdwJMEo3kPYmrT3L8IujbhESy
   CwI+7/c8az9dp8uPmLRb1XvrPdTC0b43r2YYDJBqmy+ufz6d7u8atjDHv
   0=;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="701858197"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Sep 2019 17:49:51 +0000
Received: from uf8b156e456a5587c9af4.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 87B94A1EC9;
        Tue, 10 Sep 2019 17:49:48 +0000 (UTC)
Received: from uf8b156e456a5587c9af4.ant.amazon.com (localhost [127.0.0.1])
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x8AHnk7Z023845;
        Tue, 10 Sep 2019 19:49:46 +0200
Received: (from sironi@localhost)
        by uf8b156e456a5587c9af4.ant.amazon.com (8.15.2/8.15.2/Submit) id x8AHnkE6023839;
        Tue, 10 Sep 2019 19:49:46 +0200
From:   Filippo Sironi <sironi@amazon.de>
To:     sironi@amazon.de, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Wei Wang <wawei@amazon.de>
Subject: [PATCH 5/5] iommu/amd: Hold the domain lock when calling domain_flush_tlb[_pde]
Date:   Tue, 10 Sep 2019 19:49:25 +0200
Message-Id: <1568137765-20278-6-git-send-email-sironi@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wawei@amazon.de>

domain_flush_tlb[_pde] traverses the device list, which is protected by
the domain lock.

Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3714ae5ded31..f5df23acd1c7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1806,7 +1806,11 @@ static void free_gcr3_table(struct protection_domain *domain)
 
 static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->domain.lock, flags);
 	domain_flush_tlb(&dom->domain);
+	spin_unlock_irqrestore(&dom->domain.lock, flags);
 	domain_flush_complete(&dom->domain);
 }
 
@@ -2167,7 +2171,9 @@ static int attach_device(struct device *dev,
 	 * left the caches in the IOMMU dirty. So we have to flush
 	 * here to evict all dirty stuff.
 	 */
+	spin_lock_irqsave(&domain->lock, flags);
 	domain_flush_tlb_pde(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	domain_flush_complete(domain);
 
@@ -3245,8 +3251,11 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_tlb_pde(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 	domain_flush_complete(dom);
 }
 
-- 
2.7.4

