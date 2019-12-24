Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEFC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD20206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLXGXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:23:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:9869 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfLXGXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:23:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 22:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="418904083"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 23 Dec 2019 22:23:46 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Roland Dreier <roland@purestorage.com>,
        Jim Yan <jimyan@baidu.com>
Subject: [PATCH 1/1] iommu/vt-d: Add a quirk flag for scope mismatched devices
Date:   Tue, 24 Dec 2019 14:22:40 +0800
Message-Id: <20191224062240.4796-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect devices with endpoint scope to have normal PCI headers,
and devices with bridge scope to have bridge PCI headers.  However
Some PCI devices may be listed in the DMAR table with bridge scope,
even though they have a normal PCI header. Add a quirk flag for
those special devices.

Cc: Roland Dreier <roland@purestorage.com>
Cc: Jim Yan <jimyan@baidu.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index fb30d5053664..fc24abc70a05 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -65,6 +65,26 @@ static void free_iommu(struct intel_iommu *iommu);
 
 extern const struct iommu_ops intel_iommu_ops;
 
+static int scope_mismatch_quirk;
+static void quirk_dmar_scope_mismatch(struct pci_dev *dev)
+{
+	pci_info(dev, "scope mismatch ignored\n");
+	scope_mismatch_quirk = 1;
+}
+
+/*
+ * We expect devices with endpoint scope to have normal PCI
+ * headers, and devices with bridge scope to have bridge PCI
+ * headers.  However some PCI devices may be listed in the
+ * DMAR table with bridge scope, even though they have a
+ * normal PCI header. We don't declare a socpe mismatch for
+ * below special cases.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2f0d,	/* NTB devices  */
+			 quirk_dmar_scope_mismatch);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2020,	/* NVME host */
+			 quirk_dmar_scope_mismatch);
+
 static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
@@ -231,20 +251,9 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		if (!dmar_match_pci_path(info, scope->bus, path, level))
 			continue;
 
-		/*
-		 * We expect devices with endpoint scope to have normal PCI
-		 * headers, and devices with bridge scope to have bridge PCI
-		 * headers.  However PCI NTB devices may be listed in the
-		 * DMAR table with bridge scope, even though they have a
-		 * normal PCI header.  NTB devices are identified by class
-		 * "BRIDGE_OTHER" (0680h) - we don't declare a socpe mismatch
-		 * for this special case.
-		 */
-		if ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT &&
-		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
-		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
-		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
+		if (!scope_mismatch_quirk &&
+		    ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT) ^
+		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL))) {
 			pr_warn("Device scope type does not match for %s\n",
 				pci_name(info->dev));
 			return -EINVAL;
-- 
2.17.1

