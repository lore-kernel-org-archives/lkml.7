Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F4CA9EBD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C9721929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438239AbfJXTuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:50:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:62203 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437983AbfJXTup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:50:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="282043137"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 24 Oct 2019 12:50:43 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 01/11] iommu/vt-d: Cache virtual command capability register
Date:   Thu, 24 Oct 2019 12:54:54 -0700
Message-Id: <1571946904-86776-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual command registers are used in the guest only, to prevent
vmexit cost, we cache the capability and store it during initialization.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dmar.c        | 1 +
 include/linux/intel-iommu.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..49bb7d76e646 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -950,6 +950,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
+	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ed11ef594378..2e1bed9b7eef 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -186,6 +186,9 @@
 #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
 #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
 
+/* Virtual command interface capabilities */
+#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID allocation */
+
 /* IOTLB_REG */
 #define DMA_TLB_FLUSH_GRANU_OFFSET  60
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
@@ -520,6 +523,7 @@ struct intel_iommu {
 	u64		reg_size; /* size of hw register set */
 	u64		cap;
 	u64		ecap;
+	u64		vccap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
-- 
2.7.4

