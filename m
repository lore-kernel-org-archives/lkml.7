Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC86C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67A720679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 03:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKVDIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 22:08:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:53712 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfKVDIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 22:08:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 19:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="232540432"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2019 19:08:19 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        Eric Auger <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
Date:   Fri, 22 Nov 2019 11:04:44 +0800
Message-Id: <20191122030449.28892-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel VT-d 3.0 introduces more caches and interfaces for software to
flush when it runs in the scalable mode. Currently various cache flush
helpers are scattered around. This consolidates them by putting them in
the existing iommu_flush structure.

/* struct iommu_flush - Intel IOMMU cache invalidation ops
 *
 * @cc_inv: invalidate context cache
 * @iotlb_inv: Invalidate IOTLB and paging structure caches when software
 *             has changed second-level tables.
 * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when software
 *               has changed first-level tables.
 * @pc_inv: invalidate pasid cache
 * @dev_tlb_inv: invalidate cached mappings used by requests-without-PASID
 *               from the Device-TLB on a endpoint device.
 * @p_dev_tlb_inv: invalidate cached mappings used by requests-with-PASID
 *                 from the Device-TLB on an endpoint device
 */
struct iommu_flush {
        void (*cc_inv)(struct intel_iommu *iommu, u16 did,
                       u16 sid, u8 fm, u64 type);
        void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64 addr,
                          unsigned int size_order, u64 type);
        void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
                            u64 addr, unsigned long npages, bool ih);
        void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32 pasid,
                       u64 granu);
        void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
                            u16 qdep, u64 addr, unsigned int mask);
        void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid, u16 pfsid,
                              u32 pasid, u16 qdep, u64 addr,
                              unsigned long npages);
};

The name of each cache flush ops is defined according to the spec section 6.5
so that people are easy to look up them in the spec.

Best regards,
Lu Baolu

Lu Baolu (5):
  iommu/vt-d: Extend iommu_flush for scalable mode
  iommu/vt-d: Consolidate pasid cache invalidation
  iommu/vt-d: Consolidate device tlb invalidation
  iommu/vt-d: Consolidate pasid-based tlb invalidation
  iommu/vt-d: Consolidate pasid-based device tlb invalidation

 drivers/iommu/dmar.c        |  61 ---------
 drivers/iommu/intel-iommu.c | 246 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel-pasid.c |  39 +-----
 drivers/iommu/intel-svm.c   |  60 ++-------
 include/linux/intel-iommu.h |  39 ++++--
 5 files changed, 244 insertions(+), 201 deletions(-)

-- 
2.17.1

