Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D952BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72EB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfC0Gk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:40:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfC0Gk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:40:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006795"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:40:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 01/10] iommu/vt-d: Add trace events for domain map/unmap
Date:   Wed, 27 Mar 2019 14:34:57 +0800
Message-Id: <20190327063506.32564-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds trace support for the Intel IOMMU driver. It
also declares some events which could be used to trace
the events when an IOVA is being mapped or unmapped in
a domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Makefile             |   1 +
 drivers/iommu/intel-trace.c        |  14 +++
 include/trace/events/intel_iommu.h | 132 +++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8c71a15e986b..8b5fb8051281 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel-trace.c
new file mode 100644
index 000000000000..bfb6a6e37a88
--- /dev/null
+++ b/drivers/iommu/intel-trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel IOMMU trace support
+ *
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/intel_iommu.h>
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
new file mode 100644
index 000000000000..49ca57a90079
--- /dev/null
+++ b/include/trace/events/intel_iommu.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel IOMMU trace support
+ *
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM intel_iommu
+
+#if !defined(_TRACE_INTEL_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTEL_IOMMU_H
+
+#include <linux/tracepoint.h>
+#include <linux/intel-iommu.h>
+
+TRACE_EVENT(bounce_map_single,
+	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
+		 size_t size),
+
+	TP_ARGS(dev, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name),
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_unmap_single,
+	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
+
+	TP_ARGS(dev, dev_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = dev_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
+		  __get_str(dev_name),
+		  (unsigned long long)__entry->dev_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_map_sg,
+	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
+		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
+
+	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(unsigned int, i)
+		__field(unsigned int, last)
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->i = i;
+		__entry->last = nelems - 1;
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->i, __entry->last,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+TRACE_EVENT(bounce_unmap_sg,
+	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
+		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
+
+	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(unsigned int, i)
+		__field(unsigned int, last)
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->i = i;
+		__entry->last = nelems - 1;
+		__entry->dev_addr = dev_addr;
+		__entry->phys_addr = phys_addr;
+		__entry->size = size;
+	),
+
+	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->i, __entry->last,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+#endif /* _TRACE_INTEL_IOMMU_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

