Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2220854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfCAD2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:28:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:46930 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfCAD2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:28:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 19:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="137175135"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2019 19:28:37 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/4] iommu/vt-d: Disable ATS support on untrusted devices
Date:   Fri,  1 Mar 2019 11:23:10 +0800
Message-Id: <20190301032313.9311-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
devices") disables ATS support on the devices which have been marked
as untrusted. Unfortunately this is not enough to fix the DMA attack
vulnerabiltiies because IOMMU driver allows translated requests as
long as a device advertises the ATS capability. Hence a malicious
peripheral device could use this to bypass IOMMU.

This disables the ATS support on untrusted devices by clearing the
internal per-device ATS mark. As the result, IOMMU driver will block
any translated requests from any device marked as untrusted.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f8f6d46c60f4..abdd165a829c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2484,7 +2484,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pci_ats_disabled() &&
+		if (!pdev->untrusted &&
+		    !pci_ats_disabled() &&
 		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
 		    dmar_find_matched_atsr_unit(pdev))
-- 
2.17.1

