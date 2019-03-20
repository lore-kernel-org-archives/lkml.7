Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFA12183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCTBqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:46:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:57385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfCTBqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:46:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 18:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="143465768"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2019 18:45:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Remove iommu_callback_data
Date:   Wed, 20 Mar 2019 09:40:24 +0800
Message-Id: <20190320014024.22332-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu_callback_data is not used anywhere, remove it to make
the code more concise.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..1164b9926a2b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,10 +45,6 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
 static bool iommu_dma_strict __read_mostly = true;
 
-struct iommu_callback_data {
-	const struct iommu_ops *ops;
-};
-
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -1215,9 +1211,6 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 	struct notifier_block *nb;
-	struct iommu_callback_data cb = {
-		.ops = ops,
-	};
 
 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
 	if (!nb)
@@ -1229,7 +1222,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
-	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
+	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
 	if (err)
 		goto out_err;
 
@@ -1238,7 +1231,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 
 out_err:
 	/* Clean up */
-	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
 	bus_unregister_notifier(bus, nb);
 
 out_free:
-- 
2.17.1

