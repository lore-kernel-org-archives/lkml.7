Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CF62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfHSNXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:23:42 -0400
Received: from 8bytes.org ([81.169.241.247]:50322 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfHSNXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 020F33F3; Mon, 19 Aug 2019 15:22:58 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 02/11] iommu: Add helpers to set/get default domain type
Date:   Mon, 19 Aug 2019 15:22:47 +0200
Message-Id: <20190819132256.14436-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Add a couple of functions to allow changing the default
domain type from architecture code and a function for iommu
drivers to request whether the default domain is
passthrough.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 22 ++++++++++++++++++++++
 include/linux/iommu.h | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3361ca5ef769..84acd47936ac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2211,6 +2211,28 @@ int iommu_request_dma_domain_for_dev(struct device *dev)
 	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_DMA);
 }
 
+void iommu_set_default_passthrough(bool cmd_line)
+{
+	if (cmd_line)
+		iommu_set_cmd_line_dma_api();
+
+	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+}
+
+void iommu_set_default_translated(bool cmd_line)
+{
+	if (cmd_line)
+		iommu_set_cmd_line_dma_api();
+
+	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+}
+
+bool iommu_default_passthrough(void)
+{
+	return iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY;
+}
+EXPORT_SYMBOL_GPL(iommu_default_passthrough);
+
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
 	const struct iommu_ops *ops = NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fdc355ccc570..4955498204a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -413,6 +413,9 @@ extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
+extern void iommu_set_default_passthrough(bool cmd_line);
+extern void iommu_set_default_translated(bool cmd_line);
+extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
 			enum iommu_resv_type type);
@@ -694,6 +697,19 @@ static inline int iommu_request_dma_domain_for_dev(struct device *dev)
 	return -ENODEV;
 }
 
+static inline void iommu_set_default_passthrough(bool cmd_line)
+{
+}
+
+static inline void iommu_set_default_translated(bool cmd_line)
+{
+}
+
+static inline bool iommu_default_passthrough(void)
+{
+	return true;
+}
+
 static inline int iommu_attach_group(struct iommu_domain *domain,
 				     struct iommu_group *group)
 {
-- 
2.16.4

