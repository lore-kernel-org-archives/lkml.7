Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB118205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfLKBny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:43:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:13025 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfLKBny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:43:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:43:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="238371957"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2019 17:43:52 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: trace: Extend map_sg trace event
Date:   Wed, 11 Dec 2019 09:42:55 +0800
Message-Id: <20191211014255.8020-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current map_sg stores trace message in a coarse manner. This
extends it so that more detailed messages could be traced.

The map_sg trace message looks like:

map_sg: dev=0000:00:17.0 [1/9] dev_addr=0xf8f90000 phys_addr=0x158051000 size=4096
map_sg: dev=0000:00:17.0 [2/9] dev_addr=0xf8f91000 phys_addr=0x15a858000 size=4096
map_sg: dev=0000:00:17.0 [3/9] dev_addr=0xf8f92000 phys_addr=0x15aa13000 size=4096
map_sg: dev=0000:00:17.0 [4/9] dev_addr=0xf8f93000 phys_addr=0x1570f1000 size=8192
map_sg: dev=0000:00:17.0 [5/9] dev_addr=0xf8f95000 phys_addr=0x15c6d0000 size=4096
map_sg: dev=0000:00:17.0 [6/9] dev_addr=0xf8f96000 phys_addr=0x157194000 size=4096
map_sg: dev=0000:00:17.0 [7/9] dev_addr=0xf8f97000 phys_addr=0x169552000 size=4096
map_sg: dev=0000:00:17.0 [8/9] dev_addr=0xf8f98000 phys_addr=0x169dde000 size=4096
map_sg: dev=0000:00:17.0 [9/9] dev_addr=0xf8f99000 phys_addr=0x148351000 size=4096

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c        |  7 +++--
 include/trace/events/intel_iommu.h | 48 ++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 72c10e082257..0726705d2d89 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3776,8 +3776,8 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	trace_map_sg(dev, iova_pfn << PAGE_SHIFT,
-		     sg_phys(sglist), size << VTD_PAGE_SHIFT);
+	for_each_sg(sglist, sg, nelems, i)
+		trace_map_sg(dev, i + 1, nelems, sg);
 
 	return nelems;
 }
@@ -3989,6 +3989,9 @@ bounce_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	for_each_sg(sglist, sg, nelems, i)
+		trace_bounce_map_sg(dev, i + 1, nelems, sg);
+
 	return nelems;
 
 out_unmap:
diff --git a/include/trace/events/intel_iommu.h b/include/trace/events/intel_iommu.h
index 54e61d456cdf..112bd06487bf 100644
--- a/include/trace/events/intel_iommu.h
+++ b/include/trace/events/intel_iommu.h
@@ -49,12 +49,6 @@ DEFINE_EVENT(dma_map, map_single,
 	TP_ARGS(dev, dev_addr, phys_addr, size)
 );
 
-DEFINE_EVENT(dma_map, map_sg,
-	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
-		 size_t size),
-	TP_ARGS(dev, dev_addr, phys_addr, size)
-);
-
 DEFINE_EVENT(dma_map, bounce_map_single,
 	TP_PROTO(struct device *dev, dma_addr_t dev_addr, phys_addr_t phys_addr,
 		 size_t size),
@@ -99,6 +93,48 @@ DEFINE_EVENT(dma_unmap, bounce_unmap_single,
 	TP_ARGS(dev, dev_addr, size)
 );
 
+DECLARE_EVENT_CLASS(dma_map_sg,
+	TP_PROTO(struct device *dev, int index, int total,
+		 struct scatterlist *sg),
+
+	TP_ARGS(dev, index, total, sg),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(dev))
+		__field(dma_addr_t, dev_addr)
+		__field(phys_addr_t, phys_addr)
+		__field(size_t,	size)
+		__field(int, index)
+		__field(int, total)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(dev));
+		__entry->dev_addr = sg->dma_address;
+		__entry->phys_addr = sg_phys(sg);
+		__entry->size = sg->dma_length;
+		__entry->index = index;
+		__entry->total = total;
+	),
+
+	TP_printk("dev=%s [%d/%d] dev_addr=0x%llx phys_addr=0x%llx size=%zu",
+		  __get_str(dev_name), __entry->index, __entry->total,
+		  (unsigned long long)__entry->dev_addr,
+		  (unsigned long long)__entry->phys_addr,
+		  __entry->size)
+);
+
+DEFINE_EVENT(dma_map_sg, map_sg,
+	TP_PROTO(struct device *dev, int index, int total,
+		 struct scatterlist *sg),
+	TP_ARGS(dev, index, total, sg)
+);
+
+DEFINE_EVENT(dma_map_sg, bounce_map_sg,
+	TP_PROTO(struct device *dev, int index, int total,
+		 struct scatterlist *sg),
+	TP_ARGS(dev, index, total, sg)
+);
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.17.1

