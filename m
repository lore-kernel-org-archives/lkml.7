Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D82C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319112173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407896AbfFLAgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:36:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:50299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407566AbfFLAgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:36:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 17:36:13 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2019 17:36:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/7] iommu/vt-d: Don't enable iommu's which have been ignored
Date:   Wed, 12 Jun 2019 08:28:47 +0800
Message-Id: <20190612002851.17103-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu driver will ignore some iommu units if there's no
device under its scope or those devices have been explicitly
set to bypass the DMA translation. Don't enable those iommu
units, otherwise the devices under its scope won't work.

Fixes: d8190dc638866 ("iommu/vt-d: Enable DMA remapping after rmrr mapped")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d1a82039e835..5251533a18a4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3232,7 +3232,12 @@ static int __init init_dmars(void)
 		goto error;
 	}
 
-	for_each_active_iommu(iommu, drhd) {
+	for_each_iommu(iommu, drhd) {
+		if (drhd->ignored) {
+			iommu_disable_translation(iommu);
+			continue;
+		}
+
 		/*
 		 * Find the max pasid size of all IOMMU's in the system.
 		 * We need to ensure the system pasid table is no bigger
@@ -4793,7 +4798,7 @@ int __init intel_iommu_init(void)
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
-		if (!translation_pre_enabled(iommu))
+		if (!drhd->ignored && !translation_pre_enabled(iommu))
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
-- 
2.17.1

