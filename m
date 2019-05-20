Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E59C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3E820856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbfETNnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:43:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:25194 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388106AbfETNnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:43:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 06:43:11 -0700
X-ExtLoop1: 1
Received: from gklab-127-091.igk.intel.com (HELO gklab-125-020.igk.intel.com) ([10.91.125.20])
  by orsmga004.jf.intel.com with ESMTP; 20 May 2019 06:43:09 -0700
From:   Lukasz Odzioba <lukasz.odzioba@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     dwmw2@infradead.org, joro@8bytes.org, lukasz.odzioba@intel.com,
        grzegorz.andrejczuk@intel.com
Subject: [PATCH 1/1] iommu/vt-d: Remove unnecessary rcu_read_locks
Date:   Mon, 20 May 2019 15:41:28 +0200
Message-Id: <1558359688-21804-1-git-send-email-lukasz.odzioba@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use RCU's for rarely updated lists like iommus, rmrr, atsr units.

I'm not sure why domain_remove_dev_info() in domain_exit() was surrounded
by rcu_read_lock. Lock was present before refactoring in d160aca527,
but it was related to rcu list, not domain_remove_dev_info function.

dmar_remove_one_dev_info() doesn't touch any of those lists, so it doesn't
require a lock. In fact it is called 6 times without it anyway.

Fixes: d160aca5276d ("iommu/vt-d: Unify domain->iommu attach/detachment")

Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
---
 drivers/iommu/intel-iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199..1b7ad80 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1911,9 +1911,7 @@ static void domain_exit(struct dmar_domain *domain)
 	struct page *freelist;
 
 	/* Remove associated devices and clear attached or cached domains */
-	rcu_read_lock();
 	domain_remove_dev_info(domain);
-	rcu_read_unlock();
 
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
@@ -5254,9 +5252,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 		old_domain = find_domain(dev);
 		if (old_domain) {
-			rcu_read_lock();
 			dmar_remove_one_dev_info(dev);
-			rcu_read_unlock();
 
 			if (!domain_type_is_vm_or_si(old_domain) &&
 			    list_empty(&old_domain->devices))
-- 
1.8.3.1

