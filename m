Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31A021907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbfIRXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 19:22:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:10563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfIRXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 19:22:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 16:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="199210209"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 18 Sep 2019 16:22:33 -0700
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
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 0/4] User API for nested shared virtual address (SVA)
Date:   Wed, 18 Sep 2019 16:26:30 -0700
Message-Id: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set consists of IOMMU APIs to support SVA in the guest, a.k.a nested
SVA. As the complete SVA support is complex, we break down the enabling
effort into three stages:
1. PCI device direct assignment
2. Fault handling, especially page request service support
3. Mediated device assignment

Each stage includes common API and vendor specific IOMMU driver changes. This
series is the common uAPI for stage #1. It is intended to build consensus on
the interface which all vendors reply on.

This series is extracted from the complete stage1 set which includes VT-d code.
https://lkml.org/lkml/2019/8/15/951

Changes:
 - Use spinlock instead of mutex to protect ioasid custom allocators. This is
   to support callers in atomic context
 - Added more padding to guest PASID bind data for future extensions, suggested
   by Joerg.
After much thinking, I did not do name change from PASID to IOASID in the uAPI,
considering we have been using PASID in the rest of uAPIs. IOASID will remain
used within the kernel.

For more discussions lead to this series, checkout LPC 2019 VFIO/IOMMU/PCI
microconference materials.
https://linuxplumbersconf.org/event/4/sessions/66/#20190909

Jacob Pan (2):
  iommu/ioasid: Add custom allocators
  iommu: Introduce guest PASID bind function

Jean-Philippe Brucker (1):
  iommu: Add I/O ASID allocator

Yi L Liu (1):
  iommu: Introduce cache_invalidate API

 drivers/iommu/Kconfig      |   4 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/ioasid.c     | 432 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      |  30 ++++
 include/linux/ioasid.h     |  75 ++++++++
 include/linux/iommu.h      |  36 ++++
 include/uapi/linux/iommu.h | 169 ++++++++++++++++++
 7 files changed, 747 insertions(+)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

-- 
2.7.4

