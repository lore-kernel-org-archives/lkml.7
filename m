Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED252C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbfC0Gky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:40:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfC0Gky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:40:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006787"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:40:51 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Date:   Wed, 27 Mar 2019 14:34:56 +0800
Message-Id: <20190327063506.32564-1-baolu.lu@linux.intel.com>
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
bounds. But it's different for an external device. The minimum
IOMMU mapping granularity is one page (4k), so for DMA transfers
smaller than that a malicious PCIe device can access the whole
page of memory even if it does not belong to the driver in
question. This opens a possibility for DMA attack. For more
information about DMA attacks imposed by an untrusted PCI/PCIe
device, please refer to [2].

This implements bounce buffer for the untrusted external
devices. The transfers should be limited in isolated pages
so the IOMMU window does not cover memory outside of what
the driver expects. Full pages within a buffer could be
directly mapped in IOMMU page table, but for partial pages
we use bounce page instead.

In addition, the IOMMU mappings cached in the IOTLB for
untrusted devices should be invalidated immediately after
the unmap operation. Otherwise, the IOMMU window is left
open to attacks.

The implementation of bounce buffers for untrusted devices
will cause a little performance overhead, but we didn't see
any user experience problems. The users could use the kernel
parameter of "intel_iommu=nobounce" to remove the performance
overhead if they trust their devices enough.

The bounce buffer idea:

Based-on-idea-by: Mika Westerberg <mika.westerberg@intel.com>
Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
Based-on-idea-by: Alan Cox <alan.cox@intel.com>

The patch series has been tested by:

Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>

[1] https://thunderclap.io/
[2] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
[3] https://christian.kellner.me/2019/02/27/thunderclap-and-linux/

Best regards,
Lu Baolu

Change log:
  v1->v2:
  - Refactor the code to remove struct bounce_param;
  - During the v1 review cycle, we discussed the possibility
    of reusing swiotlb code to avoid code dumplication, but
    we found the swiotlb implementations are not ready for the
    use of bounce page pool.
    https://lkml.org/lkml/2019/3/19/259
  - This patch series has been rebased to v5.1-rc2.

Lu Baolu (10):
  iommu/vt-d: Add trace events for domain map/unmap
  iommu/vt-d: Add helpers for domain mapping/unmapping
  iommu/vt-d: Add address walk helper
  iommu/vt-d: Add dir_to_prot() helper
  iommu/vt-d: Add bounce buffer API for map/unmap
  iommu/vt-d: Add bounce buffer API for dma sync
  iommu/vt-d: Check whether device requires bounce buffer
  iommu/vt-d: Add dma sync ops for untrusted devices
  iommu/vt-d: Flush IOTLB for untrusted device in time
  iommu/vt-d: Use bounce buffer for untrusted devices

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/intel-iommu.c                   | 336 ++++++++++---
 drivers/iommu/intel-pgtable.c                 | 447 ++++++++++++++++++
 drivers/iommu/intel-trace.c                   |  14 +
 include/linux/intel-iommu.h                   |  36 ++
 include/trace/events/intel_iommu.h            | 132 ++++++
 7 files changed, 905 insertions(+), 66 deletions(-)
 create mode 100644 drivers/iommu/intel-pgtable.c
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

-- 
2.17.1

