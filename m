Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D232082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfC0PBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:01:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728133AbfC0PBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:01:49 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 76FD69C447E6CE066E30;
        Wed, 27 Mar 2019 23:01:38 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 27 Mar 2019 23:01:32 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 1/1] iommu: Add config option to set lazy mode as default
Date:   Wed, 27 Mar 2019 23:00:30 +0800
Message-ID: <20190327150030.11112-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the default behaviour to be controlled by a kernel config
option instead of changing the command line for the kernel to include
"iommu.strict=0" on ARM64 where this is desired.

This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH.

Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
default, so there is no need to add code for them.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig | 14 ++++++++++++++
 drivers/iommu/iommu.c |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816c64..5daa110d0e83a07 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH

 	  If unsure, say N here.

+config IOMMU_DMA_DEFAULT_LAZY_MODE
+	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
+	depends on IOMMU_API
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused. Removing the need to pass in kernel parameters through
+	  command line. For example, iommu.strict=0 on ARM64. If this is
+	  enabled, you can still disable with kernel parameters, such as
+	  iommu.strict=1 depending on the architecture.
+
+	  If unsure, say N here.
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716369..5acb98e79b5b32d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,7 +43,12 @@
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
+
+#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
+static bool iommu_dma_strict __read_mostly;
+#else
 static bool iommu_dma_strict __read_mostly = true;
+#endif

 struct iommu_callback_data {
 	const struct iommu_ops *ops;
--
1.8.3


