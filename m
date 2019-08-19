Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474582085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfHSNXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:23:33 -0400
Received: from 8bytes.org ([81.169.241.247]:50394 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfHSNXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:23:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 251CB659; Mon, 19 Aug 2019 15:23:00 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     corbet@lwn.net, tony.luck@intel.com, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Thomas.Lendacky@amd.com,
        Suravee.Suthikulpanit@amd.com, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 08/11] iommu: Print default domain type on boot
Date:   Mon, 19 Aug 2019 15:22:53 +0200
Message-Id: <20190819132256.14436-9-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
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
index 3ee50bb22ca2..0ddd0bd1ff75 100644
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
+	case IOMMU_DOMAIN_BLOCKED:
+		return "Blocked";
+	case IOMMU_DOMAIN_IDENTITY:
+		return "Passthrough";
+	case IOMMU_DOMAIN_UNMANAGED:
+		return "Unmanaged";
+	case IOMMU_DOMAIN_DMA:
+		return "Translated";
+	default:
+		return "Unknown";
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
2.16.4

