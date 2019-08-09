Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524C20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407364AbfHIPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:22:43 -0400
Received: from 8bytes.org ([81.169.241.247]:48534 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407220AbfHIPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:22:38 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5E8DB45B; Fri,  9 Aug 2019 17:22:36 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        bp@alien8.de, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/3] iommu: Disable passthrough mode when SME is active
Date:   Fri,  9 Aug 2019 17:22:33 +0200
Message-Id: <20190809152233.2829-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809152233.2829-1-joro@8bytes.org>
References: <20190809152233.2829-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Using Passthrough mode when SME is active causes certain
devices to use the SWIOTLB bounce buffer. The bounce buffer
code has an upper limit of 256kb for the size of DMA
allocations, which is too small for certain devices and
causes them to fail.

With this patch we enable IOMMU by default when SME is
active in the system, making the default configuration work
for more systems than it does now.

Users that don't want IOMMUs to be enabled still can disable
them with kernel parameters.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 62cae6db0970..fbe1aa51bce9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -104,6 +104,12 @@ static int __init iommu_subsys_init(void)
 	else
 		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 
+	if ((iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) &&
+	    sme_active()) {
+		pr_info("SME detected - Disabling default IOMMU passthrough\n");
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+	}
+
 	pr_info("Default domain type: %s\n",
 		iommu_domain_type_str(iommu_def_domain_type));
 
-- 
2.17.1

