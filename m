Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56695C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3606320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407331AbfHIPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:22:37 -0400
Received: from 8bytes.org ([81.169.241.247]:48506 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfHIPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:22:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F07A61C7; Fri,  9 Aug 2019 17:22:35 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        bp@alien8.de, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/3] iommu: Print default domain type on boot
Date:   Fri,  9 Aug 2019 17:22:31 +0200
Message-Id: <20190809152233.2829-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809152233.2829-1-joro@8bytes.org>
References: <20190809152233.2829-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Introduce a subsys_initcall for IOMMU code and use it to
print the default domain type at boot.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..b57ce00c1310 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,12 +80,40 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 static LIST_HEAD(iommu_device_list);
 static DEFINE_SPINLOCK(iommu_device_lock);
 
+/*
+ * Use a function instead of an array here because the domain-type is a
+ * bit-field, so an array would waste memory.
+ */
+static const char *iommu_domain_type_str(unsigned int t)
+{
+	switch (t) {
+		case IOMMU_DOMAIN_BLOCKED:
+			return "Blocked";
+		case IOMMU_DOMAIN_IDENTITY:
+			return "Passthrough";
+		case IOMMU_DOMAIN_UNMANAGED:
+			return "Unmanaged";
+		case IOMMU_DOMAIN_DMA:
+			return "Translated";
+		default:
+			return "Unknown";
+	}
+}
+
+static int __init iommu_subsys_init(void)
+{
+	pr_info("Default domain type: %s\n",
+		iommu_domain_type_str(iommu_def_domain_type));
+
+	return 0;
+}
+subsys_initcall(iommu_subsys_init);
+
 int iommu_device_register(struct iommu_device *iommu)
 {
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
-
 	return 0;
 }
 
-- 
2.17.1

