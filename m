Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD4C282E2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B372087B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 01:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfDUB2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 21:28:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:3762 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfDUB2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 21:28:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Apr 2019 18:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,376,1549958400"; 
   d="scan'208";a="136008116"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2019 18:23:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 00/10] iommu: Bounce page for untrusted devices
Date:   Sun, 21 Apr 2019 09:17:09 +0800
Message-Id: <20190421011719.14909-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Thunderbolt vulnerabilities are public and have a nice
name as Thunderclap [1] [3] nowadays. This patch series aims
to mitigate those concerns.

An external PCI device is a PCI peripheral device connected
to the system through an external bus, such as Thunderbolt.
What makes it different is that it can't be trusted to the
same degree as the devices build into the system. Generally,
a trusted PCIe device will DMA into the designated buffers
and not overrun or otherwise write outside the specified
bounds. But it's different for an external device.

The minimum IOMMU mapping granularity is one page (4k), so
for DMA transfers smaller than that a malicious PCIe device
can access the whole page of memory even if it does not
belong to the driver in question. This opens a possibility
for DMA attack. For more information about DMA attacks
imposed by an untrusted PCI/PCIe device, please refer to [2].

This implements bounce buffer for the untrusted external
devices. The transfers should be limited in isolated pages
so the IOMMU window does not cover memory outside of what
the driver expects. Full pages within a buffer could be
directly mapped in IOMMU page table, but for partial pages
we use bounce page instead.

The implementation of bounce buffers for untrusted devices
will cause a little performance overhead, but we didn't see
any user experience problems. The users could use the kernel
parameter defined in the IOMMU driver to remove the performance
overhead if they trust their devices enough.

The first part of this patch series (PATCH1/10 ~ 4/10) extends
the swiotlb APIs to support bounce buffer in page manner. The
second part (PATCH 5/10) introduce the APIs for bounce page:

 * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
   - Map a buffer start at DMA address @addr in bounce page
     manner. For buffer parts that doesn't cross a whole
     minimal IOMMU page, the bounce page policy is applied.
     A bounce page mapped by swiotlb will be used as the DMA
     target in the IOMMU page table. Otherwise, the physical
     address @paddr is mapped instead.
 
 * iommu_bounce_unmap(dev, addr, size, dir, attrs)
   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
     page will be torn down after the bounced data get synced.
 
 * iommu_bounce_sync_single(dev, addr, size, dir, target)
   - Synce the bounced data in case the bounce mapped buffer is
     reused.

The third part of this patch series (PATCH 6/10 ~ 10/10) uses
the bounce page APIs to map/unmap/sync DMA buffers for those
untrusted devices in Intel IOMMU driver.

The third part of this patch series depends on a patch set posted
here [4] for discussion. It delegates Intel IOMMU DMA domains to
the iommu generic layer.

The bounce page idea:
Based-on-idea-by: Mika Westerberg <mika.westerberg@intel.com>
Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
Based-on-idea-by: Alan Cox <alan.cox@intel.com>
Based-on-idea-by: Kevin Tian <kevin.tian@intel.com>

The patch series has been tested by:
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>

Reference:
[1] https://thunderclap.io/
[2] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
[3] https://christian.kellner.me/2019/02/27/thunderclap-and-linux/
[4] https://lkml.org/lkml/2019/3/4/644

Best regards,
Lu Baolu

Change log:
  v2->v3:
  - The previous v2 was posed here:
    https://lkml.org/lkml/2019/3/27/157
  - Reuse the existing swiotlb APIs for bounce buffer by
    extending it to support bounce page.
  - Move the bouce page APIs into iommu generic layer.
  - This patch series is based on 5.1-rc1.

  v1->v2:
  - The previous v1 was posted here:
    https://lkml.org/lkml/2019/3/12/66
  - Refactor the code to remove struct bounce_param;
  - During the v1 review cycle, we discussed the possibility
    of reusing swiotlb code to avoid code dumplication, but
    we found the swiotlb implementations are not ready for the
    use of bounce page pool.
    https://lkml.org/lkml/2019/3/19/259
  - This patch series has been rebased to v5.1-rc2.

Lu Baolu (10):
  iommu: Add helper to get minimal page size of domain
  swiotlb: Factor out slot allocation and free
  swiotlb: Limit tlb address range inside slot pool
  swiotlb: Extend swiotlb to support page bounce
  iommu: Add bounce page APIs
  iommu/vt-d: Add trace events for domain map/unmap
  iommu/vt-d: Keep swiotlb on if bounce page is necessary
  iommu/vt-d: Check whether device requires bounce buffer
  iommu/vt-d: Add dma sync ops for untrusted devices
  iommu/vt-d: Use bounce buffer for untrusted devices

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/Kconfig                         |  15 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/intel-iommu.c                   | 276 ++++++++++++++----
 drivers/iommu/intel-trace.c                   |  14 +
 drivers/iommu/iommu.c                         | 275 +++++++++++++++++
 include/linux/dma-mapping.h                   |   6 +
 include/linux/iommu.h                         |  50 ++++
 include/trace/events/intel_iommu.h            | 132 +++++++++
 kernel/dma/swiotlb.c                          | 117 ++++++--
 10 files changed, 808 insertions(+), 83 deletions(-)
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

-- 
2.17.1

