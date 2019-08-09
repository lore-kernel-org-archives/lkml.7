Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50329C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F9920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407354AbfHIPWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:22:40 -0400
Received: from 8bytes.org ([81.169.241.247]:48516 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406642AbfHIPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:22:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2528E457; Fri,  9 Aug 2019 17:22:36 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        bp@alien8.de, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/3] iommu: Set default domain type at runtime
Date:   Fri,  9 Aug 2019 17:22:32 +0200
Message-Id: <20190809152233.2829-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809152233.2829-1-joro@8bytes.org>
References: <20190809152233.2829-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Set the default domain-type at runtime, not at compile-time.
This keeps default domain type setting in one place when we
have to change it at runtime.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b57ce00c1310..62cae6db0970 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -26,11 +26,8 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
-#else
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
-#endif
+
+static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = true;
 
 struct iommu_group {
@@ -102,6 +99,11 @@ static const char *iommu_domain_type_str(unsigned int t)
 
 static int __init iommu_subsys_init(void)
 {
+	if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
+		iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+	else
+		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+
 	pr_info("Default domain type: %s\n",
 		iommu_domain_type_str(iommu_def_domain_type));
 
-- 
2.17.1

