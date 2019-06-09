Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF36C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9C52146E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 13:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfFINlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 09:41:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:32101 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfFINlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 09:41:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 06:41:16 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2019 06:41:16 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 05/22] iommu: Add a timeout parameter for PRQ response
Date:   Sun,  9 Jun 2019 06:44:05 -0700
Message-Id: <1560087862-57608-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IO page request is processed outside IOMMU subsystem, response
can be delayed or lost. Add a tunable setup parameter such that user can
choose the timeout for IOMMU to track pending page requests.

This timeout mechanism is a basic safety net which can be implemented in
conjunction with credit based or device level page response exception
handling.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 drivers/iommu/iommu.c                           | 29 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f666..b43f089 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1813,6 +1813,14 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	iommu.prq_timeout=
+			Timeout in seconds to wait for page response
+			of a pending page request.
+			Format: <integer>
+			Default: 10
+			0 - no timeout tracking
+			1 to 100 - allowed range
+
 	io7=		[HW] IO7 for Marvel based alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13b301c..64e87d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,19 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
 static bool iommu_dma_strict __read_mostly = true;
 
+/*
+ * Timeout to wait for page response of a pending page request. This is
+ * intended as a basic safty net in case a pending page request is not
+ * responded for an exceptionally long time. Device may also implement
+ * its own protection mechanism against this exception.
+ * Units are in jiffies with a range between 1 - 100 seconds equivalent.
+ * Default to 10 seconds.
+ * Setting 0 means no timeout tracking.
+ */
+#define IOMMU_PAGE_RESPONSE_MAX_TIMEOUT (HZ * 100)
+#define IOMMU_PAGE_RESPONSE_DEF_TIMEOUT (HZ * 10)
+static unsigned long prq_timeout = IOMMU_PAGE_RESPONSE_DEF_TIMEOUT;
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -157,6 +170,22 @@ static int __init iommu_dma_setup(char *str)
 }
 early_param("iommu.strict", iommu_dma_setup);
 
+static int __init iommu_set_prq_timeout(char *str)
+{
+	unsigned long timeout;
+
+	if (!str)
+		return -EINVAL;
+	timeout = simple_strtoul(str, NULL, 0);
+	timeout = timeout * HZ;
+	if (timeout > IOMMU_PAGE_RESPONSE_MAX_TIMEOUT)
+		return -EINVAL;
+	prq_timeout = timeout;
+
+	return 0;
+}
+early_param("iommu.prq_timeout", iommu_set_prq_timeout);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
-- 
2.7.4

