Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1BC468BE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DA3216C4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfFICpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:45:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:21699 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfFICpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:45:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 19:45:30 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2019 19:45:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/6] iommu/vt-d: Don't return error when device gets right domain
Date:   Sun,  9 Jun 2019 10:37:58 +0800
Message-Id: <20190609023803.23832-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190609023803.23832-1-baolu.lu@linux.intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device gets a right domain in add_device ops, it shouldn't
return error.

Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b431cc6f6ba4..d5a6c8064c56 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5360,10 +5360,7 @@ static int intel_iommu_add_device(struct device *dev)
 				domain_add_dev_info(si_domain, dev);
 				dev_info(dev,
 					 "Device uses a private identity domain.\n");
-				return 0;
 			}
-
-			return -ENODEV;
 		}
 	} else {
 		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
@@ -5378,10 +5375,7 @@ static int intel_iommu_add_device(struct device *dev)
 
 				dev_info(dev,
 					 "Device uses a private dma domain.\n");
-				return 0;
 			}
-
-			return -ENODEV;
 		}
 	}
 
-- 
2.17.1

