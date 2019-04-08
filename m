Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B589C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF43213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDHX5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:57:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:9984 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDHX5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169924"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 00/18] Shared virtual address IOMMU and VT-d support
Date:   Mon,  8 Apr 2019 16:59:15 -0700
Message-Id: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to enable SVA virtualization, i.e. shared guest
application address space and physical device DMA address. Only IOMMU portion
of the changes are included in this series. Additional support is needed in
VFIO and QEMU (will be submitted separately) to complete this functionality.

To make incremental changes and reduce the size of each patchset. This series
does not inlcude support for page request services.

In VT-d implementation, PASID table is per device and maintained in the host.
Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables


This work is based on collaboration with other developers on the IOMMU
mailing list. Notably,

[1] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
https://lkml.org/lkml/2019/3/17/124

[2] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
Brucker
https://www.spinics.net/lists/iommu/msg30639.html

[3] [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation by Lu Baolu
https://lkml.org/lkml/2018/11/12/1921

There are roughly three parts:
1. Generic PASID allocator [1] with extension to support custom allocator
2. IOMMU cache invalidation passdown from guest to host
3. Guest PASID bind for nested translation

All generic IOMMU APIs are reused from [1], which has a v7 just published with
no real impact to the patches used here. It is worth noting that unlike sMMU
nested stage setup, where PASID table is owned by the guest, VT-d PASID table is
owned by the host, individual PASIDs are bound instead of the PASID table.


Jacob Pan (15):
  ioasid: Add custom IOASID allocator
  ioasid: Convert ioasid_idr to XArray
  driver core: add per device iommu param
  iommu: introduce device fault data
  iommu: introduce device fault report API
  iommu: Introduce attach/detach_pasid_table API
  iommu/vt-d: Add custom allocator for IOASID
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu: Add guest PASID bind function
  iommu/vt-d: Move domain helper to header
  iommu/vt-d: Add nested translation support
  iommu/vt-d: Add bind guest PASID support
  iommu: add max num of cache and granu types
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function

Jean-Philippe Brucker (1):
  drivers core: Add I/O ASID allocator

Liu, Yi L (1):
  iommu: Introduce cache_invalidate API

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

 drivers/base/Kconfig        |   7 ++
 drivers/base/Makefile       |   1 +
 drivers/base/ioasid.c       | 211 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/dmar.c        |  48 +++++++++
 drivers/iommu/intel-iommu.c | 219 ++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.c | 191 +++++++++++++++++++++++++++++-----
 drivers/iommu/intel-pasid.h |  24 ++++-
 drivers/iommu/intel-svm.c   | 217 +++++++++++++++++++++++++++++++++++---
 drivers/iommu/iommu.c       | 207 +++++++++++++++++++++++++++++++++++-
 include/linux/device.h      |   3 +
 include/linux/intel-iommu.h |  40 +++++--
 include/linux/intel-svm.h   |   7 ++
 include/linux/ioasid.h      |  66 ++++++++++++
 include/linux/iommu.h       | 127 +++++++++++++++++++++++
 include/uapi/linux/iommu.h  | 248 ++++++++++++++++++++++++++++++++++++++++++++
 16 files changed, 1559 insertions(+), 58 deletions(-)
 create mode 100644 drivers/base/ioasid.c
 create mode 100644 include/linux/ioasid.h
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4

