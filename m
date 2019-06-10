Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE4C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7507220859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfFJSvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:51:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:51:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C227C337;
        Mon, 10 Jun 2019 11:51:48 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 511F03F246;
        Mon, 10 Jun 2019 11:51:47 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com
Subject: [PATCH 0/8] iommu: Add auxiliary domain and PASID support to Arm SMMUv3
Date:   Mon, 10 Jun 2019 19:47:06 +0100
Message-Id: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add substreams and PCI PASID support to the SMMUv3 driver. At the moment
the driver supports a single address space per device. PASID enables
multiple address spaces per device, up to a million in theory (1 << 20).

Two kernel features will make use of PASIDs, auxiliary domains (AUXD)
and Shared Virtual Addressing (SVA). Auxiliary domains allow to program
PASID contexts using IOMMU domains. SVA allows to bind process address
spaces to device contexts and relieve device drivers of DMA management.

Since SVA support for SMMUv3 has a lot more dependencies (new fault API,
ASID pinning, generic bind, PRI or stall support, and so on),
introducing PASID support to the SMMUv3 driver is easier with auxiliary
domains.

The AUXD API allows device drivers to easily test PASID support of their
devices, although they need to allocate IOVA and pages themselves
because the DMA API doesn't support AUXD for the moment:

	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
	domain = iommu_domain_alloc(dev->bus);
	iommu_aux_attach_device(domain, dev);
	iommu_map(domain, iova, phys_addr, size, prot);
	pasid = iommu_aux_get_pasid(domain);
	/* Then launch DMA with the PASID and IOVA */

Auxiliary domains also allow to split devices into multiple contexts
assignable to guest, with vfio-mdev.

Past discussions for these patches:
* Auxiliary domains (patch 6)
  [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
  https://www.spinics.net/lists/iommu/msg30637.html
* SSID support for the SMMU (patches 2, 3, 4, 5, 7 and 8)
  [PATCH v2 00/40] Shared Virtual Addressing for the IOMMU
  https://lists.linuxfoundation.org/pipermail/iommu/2018-May/027595.html
* I/O ASID (patch 1)
  [PATCH v3 00/16] Shared virtual address IOMMU and VT-d support
  https://lkml.kernel.org/lkml/1556922737-76313-4-git-send-email-jacob.jun.pan@linux.intel.com/

Jean-Philippe Brucker (8):
  iommu: Add I/O ASID allocator
  dt-bindings: document PASID property for IOMMU masters
  iommu/arm-smmu-v3: Support platform SSID
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Support auxiliary domains
  iommu/arm-smmu-v3: Improve add_device() error handling
  iommu/arm-smmu-v3: Add support for PCI PASID

 .../devicetree/bindings/iommu/iommu.txt       |   6 +
 drivers/iommu/Kconfig                         |   5 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/arm-smmu-v3.c                   | 714 ++++++++++++++++--
 drivers/iommu/ioasid.c                        | 150 ++++
 drivers/iommu/of_iommu.c                      |   6 +-
 include/linux/ioasid.h                        |  49 ++
 include/linux/iommu.h                         |   1 +
 8 files changed, 865 insertions(+), 67 deletions(-)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

-- 
2.21.0

