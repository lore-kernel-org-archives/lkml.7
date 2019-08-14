Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0898021744
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfHNNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:38:51 -0400
Received: from 8bytes.org ([81.169.241.247]:49324 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfHNNip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:38:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 29633374; Wed, 14 Aug 2019 15:38:43 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 03/10] iommu/vt-d: Request passthrough mode from IOMMU core
Date:   Wed, 14 Aug 2019 15:38:34 +0200
Message-Id: <20190814133841.7095-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814133841.7095-1-joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Get rid of the iommu_pass_through variable and request
passthrough mode via the new iommu core function.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bdaed2da8a55..234bc2b55c59 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3267,7 +3267,7 @@ static int __init init_dmars(void)
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	}
 
-	if (iommu_pass_through)
+	if (iommu_default_passthrough())
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 #ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
-- 
2.17.1

