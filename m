Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D682082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLPULd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:11:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:10614 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfLPULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:11:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 11:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="209411623"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2019 11:19:22 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 00/10] Nested Shared Virtual Address (SVA) VT-d support
Date:   Mon, 16 Dec 2019 11:24:02 -0800
Message-Id: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to enable SVA virtualization, i.e. enable use of SVA
within a guest user application.

Only IOMMU portion of the changes are included in this series. Additional
support is needed in VFIO and QEMU (will be submitted separately) to complete
this functionality.

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

This is the remaining VT-d only portion of V5 since the uAPIs and IOASID common
code have been applied to Joerg's IOMMU core branch.
(https://lkml.org/lkml/2019/10/2/833)

The complete set with VFIO patches are here:
https://github.com/jacobpan/linux.git:siov_sva

The complete nested SVA upstream patches are divided into three phases:
    1. Common APIs and PCI device direct assignment
    2. Page Request Services (PRS) support
    3. Mediated device assignment

With this set and the accompanied VFIO code, we will achieve phase #1.

Thanks,

Jacob

ChangeLog:
	- v8
	  - Extracted cleanup patches from V7 and accepted into maintainer's
	    tree (https://lkml.org/lkml/2019/12/2/514).
	  - Added IOASID notifier and VT-d handler for termination of PASID
	    IOMMU context upon free. This will ensure success of VFIO IOASID
	    free API regardless PASID is in use.
	    (https://lore.kernel.org/linux-iommu/1571919983-3231-1-git-send-email-yi.l.liu@intel.com/)

	- V7
	  - Respect vIOMMU PASID range in virtual command PASID/IOASID allocator
	  - Caching virtual command capabilities to avoid runtime checks that
	    could cause vmexits.

	- V6
	  - Rebased on top of Joerg's core branch
	  (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core)
	  - Adapt to new uAPIs and IOASID allocators

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

Jacob Pan (9):
  iommu/vt-d: Move domain helper to header
  iommu/vt-d: Add nested translation helper function
  iommu/vt-d: Add bind guest PASID support
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function
  iommu/vt-d: Cache virtual command capability register
  iommu/vt-d: Add custom allocator for IOASID
  iommu/ioasid: Add notifier for status change
  iommu/vt-d: Handle IOASID notifications

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

 drivers/iommu/dmar.c        |  47 ++++++++
 drivers/iommu/intel-iommu.c | 255 ++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-pasid.c | 273 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel-pasid.h |  25 +++-
 drivers/iommu/intel-svm.c   | 266 ++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/ioasid.c      |  43 +++++++
 include/linux/intel-iommu.h |  46 +++++++-
 include/linux/intel-svm.h   |  17 +++
 include/linux/ioasid.h      |  20 ++++
 include/uapi/linux/iommu.h  |   5 +-
 10 files changed, 983 insertions(+), 14 deletions(-)

-- 
2.7.4

