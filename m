Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930AC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE67A2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbfHOUJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:09:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:43467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbfHOUJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188596198"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 00/19] Shared virtual address IOMMU and VT-d support
Date:   Thu, 15 Aug 2019 13:13:06 -0700
Message-Id: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

[1] Common APIs git://linux-arm.org/linux-jpb.git sva/api

[2] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
Brucker
https://www.spinics.net/lists/iommu/msg30639.html

[3] [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation by Lu Baolu
https://lkml.org/lkml/2018/11/12/1921

[4] [PATCH v5 00/23] IOMMU and VT-d driver support for Shared Virtual
    Address (SVA)
    https://lwn.net/Articles/754331/

There are roughly three parts:
1. Generic PASID allocator [1] with extension to support custom allocator
2. IOMMU cache invalidation passdown from guest to host
3. Guest PASID bind for nested translation

All generic IOMMU APIs are reused from [1] with minor tweaks. With this
patchset, guest SVA without page request works on VT-d. PRS patches
will come next as we try to avoid large patchset that is hard to review.
The patches for basic SVA support (w/o PRS) starts:
[PATCH v5 05/19] iommu: Introduce attach/detach_pasid_table API

It is worth noting that unlike sMMU nested stage setup, where PASID table
is owned by the guest, VT-d PASID table is owned by the host, individual
PASIDs are bound instead of the PASID table.

This series is based on the new VT-d 3.0 Specification
(https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf).
This is different than the older series in [4] which was based on the older
specification that does not have scalable mode.


ChangeLog:
	- V5
	  Rebased on v5.3-rc4 which has some of the IOMMU fault APIs merged.
 	  Addressed v4 review comments from Eric Auger, Baolu Lu, and
	    Jonathan Cameron. Specific changes are as follows:
	  - Refined custom IOASID allocator to support multiple vIOMMU, hotplug
	    cases.
	  - Extracted vendor data from IOMMU guest PASID bind data, for VT-d
	    will support all necessary guest PASID entry fields for PASID
	    bind.
	  - Support non-identity host-guest PASID mapping
	  - Exception handling in various cases

	- V4
	  - Redesigned IOASID allocator such that it can support custom
	  allocators with shared helper functions. Use separate XArray
	  to store IOASIDs per allocator. Took advice from Eric Auger to
	  have default allocator use the generic allocator structure.
	  Combined into one patch in that the default allocator is just
	  "another" allocator now. Can be built as a module in case of
	  driver use without IOMMU.
	  - Extended bind guest PASID data to support SMMU and non-identity
	  guest to host PASID mapping https://lkml.org/lkml/2019/5/21/802
	  - Rebased on Jean's sva/api common tree, new patches starts with
	   [PATCH v4 10/22]

	- V3
	  - Addressed thorough review comments from Eric Auger (Thank you!)
	  - Moved IOASID allocator from driver core to IOMMU code per
	    suggestion by Christoph Hellwig
	    (https://lkml.org/lkml/2019/4/26/462)
	  - Rebased on top of Jean's SVA API branch and Eric's v7[1]
	    (git://linux-arm.org/linux-jpb.git sva/api)
	  - All IOMMU APIs are unmodified (except the new bind guest PASID
	    call in patch 9/16)

	- V2
	  - Rebased on Joerg's IOMMU x86/vt-d branch v5.1-rc4
	  - Integrated with Eric Auger's new v7 series for common APIs
	  (https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7)
	  - Addressed review comments from Andy Shevchenko and Alex Williamson on
	    IOASID custom allocator.
	  - Support multiple custom IOASID allocators (vIOMMUs) and dynamic
	    registration.


Jacob Pan (14):
  iommu: Add a timeout parameter for PRQ response
  iommu: handle page response timeout
  iommu: Introduce attach/detach_pasid_table API
  iommu/ioasid: Add custom allocators
  iommu: Introduce guest PASID bind function
  iommu/vt-d: Add custom allocator for IOASID
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu/vt-d: Move domain helper to header
  iommu/vt-d: Avoid duplicated code for PASID setup
  iommu/vt-d: Add nested translation helper function
  iommu/vt-d: Misc macro clean up for SVM
  iommu/vt-d: Add bind guest PASID support
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function

Jean-Philippe Brucker (3):
  trace/iommu: Add sva trace events
  iommu: Use device fault trace event
  iommu: Add I/O ASID allocator

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

Yi L Liu (1):
  iommu: Introduce cache_invalidate API

 Documentation/admin-guide/kernel-parameters.txt |   8 +
 drivers/iommu/Kconfig                           |   5 +
 drivers/iommu/Makefile                          |   1 +
 drivers/iommu/dmar.c                            |  46 +++
 drivers/iommu/intel-iommu.c                     | 259 +++++++++++++-
 drivers/iommu/intel-pasid.c                     | 343 ++++++++++++++++---
 drivers/iommu/intel-pasid.h                     |  25 +-
 drivers/iommu/intel-svm.c                       | 298 +++++++++++++---
 drivers/iommu/ioasid.c                          | 433 ++++++++++++++++++++++++
 drivers/iommu/iommu.c                           | 139 ++++++++
 include/linux/intel-iommu.h                     |  39 ++-
 include/linux/intel-svm.h                       |  17 +
 include/linux/ioasid.h                          |  75 ++++
 include/linux/iommu.h                           |  58 ++++
 include/trace/events/iommu.h                    |  84 +++++
 include/uapi/linux/iommu.h                      | 219 ++++++++++++
 16 files changed, 1925 insertions(+), 124 deletions(-)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

-- 
2.7.4

