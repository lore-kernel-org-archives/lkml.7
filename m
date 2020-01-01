Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC9BC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA9206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgAAF2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:28:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:55757 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgAAF23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 00:28:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 21:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; 
   d="scan'208";a="244319525"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:27 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 4/4] iommu: Determine default domain type before allocating domain
Date:   Wed,  1 Jan 2020 13:26:48 +0800
Message-Id: <20200101052648.14295-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determine the default domain type for each group and use it to
allocate the iommu domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 716326a2ee5b..fc1df1acbd25 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,6 +43,7 @@ struct iommu_group {
 	int id;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
+	unsigned int def_domain_type;
 };
 
 struct group_device {
@@ -1383,6 +1384,33 @@ static int alloc_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+static void get_group_def_domain_type(struct iommu_group *group)
+{
+	struct group_device *tmp = NULL;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(tmp, &group->devices, list) {
+		struct device *dev = tmp->dev;
+
+		/*
+		 * If there are any untrusted devices in the group, force
+		 * IOMMU_DOMAIN_DMA to prevent DMA attack from malicious
+		 * devices.
+		 */
+		if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted) {
+			group->def_domain_type = IOMMU_DOMAIN_DMA;
+			break;
+		}
+
+		if (dev->iommu_passthrough)
+			group->def_domain_type = IOMMU_DOMAIN_IDENTITY;
+	}
+	mutex_unlock(&group->mutex);
+
+	if (!group->def_domain_type)
+		group->def_domain_type = iommu_def_domain_type;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1412,13 +1440,14 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		get_group_def_domain_type(group);
+		dom = __iommu_domain_alloc(dev->bus, group->def_domain_type);
+		if (!dom && group->def_domain_type != IOMMU_DOMAIN_DMA) {
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
+					 group->def_domain_type);
 			}
 		}
 
-- 
2.17.1

