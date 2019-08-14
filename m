Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9D0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B930521744
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfHNNiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:38:52 -0400
Received: from 8bytes.org ([81.169.241.247]:49374 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfHNNiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:38:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BC81A4F1; Wed, 14 Aug 2019 15:38:43 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 07/10] iommu: Print default domain type on boot
Date:   Wed, 14 Aug 2019 15:38:38 +0200
Message-Id: <20190814133841.7095-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814133841.7095-1-joro@8bytes.org>
References: <20190814133841.7095-1-joro@8bytes.org>
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
index e1feb4061b8b..233bc22b487e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -93,12 +93,40 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
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

