Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887F21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfCVQE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:04:29 -0400
Received: from 8bytes.org ([81.169.241.247]:58690 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfCVQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:04:29 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E74214A7; Fri, 22 Mar 2019 17:04:27 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu: Don't print warning when IOMMU driver only supports unmanaged domains
Date:   Fri, 22 Mar 2019 17:04:26 +0100
Message-Id: <20190322160426.1480-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Print the warning about the fall-back to IOMMU_DOMAIN_DMA in
iommu_group_get_for_dev() only when such a domain was
actually allocated.

Otherwise the user will get misleading warnings in the
kernel log when the iommu driver used doesn't support
IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY.

Fixes: fccb4e3b8ab09 ('iommu: Allow default domain type to be set on the kernel command line')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..109de67d5d72 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1105,10 +1105,12 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
 		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
-			dev_warn(dev,
-				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-				 iommu_def_domain_type);
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
+			if (dom) {
+				dev_warn(dev,
+					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
+					 iommu_def_domain_type);
+			}
 		}
 
 		group->default_domain = dom;
-- 
2.16.4

