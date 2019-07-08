Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EAFC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E0520656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390973AbfGHQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:06:10 -0400
Received: from 8bytes.org ([81.169.241.247]:34550 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbfGHQGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:06:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 034752B6; Mon,  8 Jul 2019 18:06:08 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:06:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.3
Message-ID: <20190708160601.GA1214@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.3

for you to fetch changes up to d95c3885865b71e56d8d60c8617f2ce1f0fa079d:

  Merge branches 'x86/vt-d', 'x86/amd', 'arm/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next (2019-07-04 17:26:48 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.3

Including:

	- Patches to make the dma-iommu code more generic so that it can
	  be used outside of the ARM context with other IOMMU drivers.
	  Goal is to make use of it on x86 too.

	- Generic IOMMU domain support for the Intel VT-d driver. This
	  driver now makes more use of common IOMMU code to allocate
	  default domains for the devices it handles.

	- An IOMMU fault reporting API to userspace. With that the IOMMU
	  fault handling can be done in user-space, for example to
	  forward the faults to a VM.

	- Better handling for reserved regions requested by the
	  firmware. These can be 'relaxed' now, meaning that those don't
	  prevent a device being attached to a VM.

	- Suspend/Resume support for the Renesas IOMMU driver.

	- Added support for dumping SVA related fields of the DMAR table
	  in the Intel VT-d driver via debugfs.

	- A pile of smaller fixes and cleanups.

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu: Fix integer truncation

Bjorn Andersson (1):
      iommu/io-pgtable: Support non-coherent page tables

Christoph Hellwig (15):
      iommu/dma: Cleanup dma-iommu.h
      iommu/dma: Remove the flush_page callback
      iommu/dma: Use for_each_sg in iommu_dma_alloc
      iommu/dma: move the arm64 wrappers to common code
      iommu/dma: Move __iommu_dma_map
      iommu/dma: Refactor the page array remapping allocator
      iommu/dma: Remove __iommu_dma_free
      iommu/dma: Merge the CMA and alloc_pages allocation paths
      iommu/dma: Refactor iommu_dma_alloc, part 2
      iommu/dma: Refactor iommu_dma_get_sgtable
      iommu/dma: Refactor iommu_dma_mmap
      iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
      iommu/dma: Switch copyright boilerplace to SPDX
      arm64: switch copyright boilerplace to SPDX in dma-mapping.c
      arm64: trim includes in dma-mapping.c

Colin Ian King (1):
      iommu/amd: Remove redundant assignment to variable npages

Eric Auger (7):
      iommu: Fix a leak in iommu_insert_resv_region
      iommu/vt-d: Duplicate iommu_resv_region objects per device list
      iommu/vt-d: Introduce is_downstream_to_pci_bridge helper
      iommu/vt-d: Handle RMRR with PCI bridge device scopes
      iommu/vt-d: Handle PCI bridge RMRR device scopes in intel_iommu_get_resv_regions
      iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
      iommu/vt-d: Differentiate relaxable and non relaxable RMRRs

Geert Uytterhoeven (6):
      iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
      iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
      iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
      iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
      iommu/ipmmu-vmsa: Extract hardware context initialization
      iommu/ipmmu-vmsa: Add suspend/resume support

Greg Kroah-Hartman (1):
      iommu/omap: No need to check return value of debugfs_create functions

Jacob Pan (5):
      iommu/vt-d: Fix bind svm with multiple devices
      driver core: Add per device iommu param
      iommu: Introduce device fault data
      iommu: Introduce device fault report API
      iommu/vt-d: Cleanup unused variable

James Sewart (1):
      iommu/vt-d: Implement apply_resv_region iommu ops entry

Jean-Philippe Brucker (3):
      iommu: Add recoverable fault reporting
      iommu: Add padding to struct iommu_fault
      iommu/arm-smmu-v3: Invalidate ATC when detaching a device

Joerg Roedel (5):
      Merge tag 'v5.2-rc3' into x86/vt-d
      Merge tag 'v5.2-rc6' into generic-dma-ops
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'arm/renesas' into arm/smmu
      Merge branches 'x86/vt-d', 'x86/amd', 'arm/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next

Kefeng Wang (1):
      iommu/omap: Use dev_get_drvdata()

Kevin Mitchell (3):
      iommu/amd: Make iommu_disable safer
      iommu/amd: Move gart fallback to amd_iommu_init
      iommu/amd: Only free resources once on init error

Lu Baolu (21):
      iommu: Use right function to get group for device
      iommu: Add API to request DMA domain for device
      iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions
      iommu/vt-d: Enable DMA remapping after rmrr mapped
      iommu/vt-d: Add device_def_domain_type() helper
      iommu/vt-d: Delegate the identity domain to upper layer
      iommu/vt-d: Delegate the dma domain to upper layer
      iommu/vt-d: Identify default domains replaced with private
      iommu/vt-d: Handle 32bit device with identity default domain
      iommu/vt-d: Probe DMA-capable ACPI name space devices
      iommu/vt-d: Implement is_attach_deferred iommu ops entry
      iommu/vt-d: Cleanup get_valid_domain_for_dev()
      iommu/vt-d: Remove startup parameter from device_def_domain_type()
      iommu/vt-d: Remove duplicated code for device hotplug
      iommu/vt-d: Remove static identity map code
      iommu/vt-d: Don't return error when device gets right domain
      iommu/vt-d: Set domain type for a private domain
      iommu/vt-d: Don't enable iommu's which have been ignored
      iommu/vt-d: Allow DMA domain attaching to rmrr locked device
      iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
      iommu/vt-d: Consolidate domain_init() to avoid duplication

Lukasz Odzioba (1):
      iommu/vt-d: Remove unnecessary rcu_read_locks

Nathan Chancellor (1):
      iommu/dma: Fix condition check in iommu_dma_unmap_sg

Qian Cai (3):
      iommu/vt-d: Fix a variable set but not used
      iommu/vt-d: Remove an unused variable "length"
      iommu/vt-d: Silence a variable set but not used

Robin Murphy (8):
      iommu/dma: Move domain lookup into __iommu_dma_{map,unmap}
      iommu/dma: Squash __iommu_dma_{map,unmap}_page helpers
      iommu/dma: Factor out remapped pages lookup
      iommu/dma: Refactor iommu_dma_free
      iommu/dma: Refactor iommu_dma_alloc
      iommu/dma: Don't remap CMA unnecessarily
      iommu/dma: Split iommu_dma_free
      iommu/dma: Cleanup variable naming in iommu_dma_alloc

Sai Praneeth Prakhya (4):
      iommu/vt-d: Modify the format of intel DMAR tables dump
      iommu/vt-d: Introduce macros useful for dumping DMAR table
      iommu/vt-d: Add debugfs support to show scalable mode DMAR table internals
      iommu/vt-d: Cleanup after delegating DMA domain to generic iommu

Tom Murphy (1):
      iommu/amd: Flush not present cache in iommu_map_page

Vivek Gautam (1):
      iommu/io-pgtable-arm: Add support to use system cache

Weitao Hou (1):
      iommu/vt-d: Fix typo in SVM code comment

Will Deacon (3):
      iommu/arm-smmu-v3: Increase maximum size of queues
      iommu/io-pgtable: Replace IO_PGTABLE_QUIRK_NO_DMA with specific flag
      iommu/arm-smmu-v3: Fix compilation when CONFIG_CMA=n

YueHaibing (1):
      iommu/amd: Add missed 'tag' to error msg in iommu_print_event

 .../ABI/testing/sysfs-kernel-iommu_groups          |   9 +
 arch/arm64/mm/dma-mapping.c                        | 412 +--------
 drivers/iommu/amd_iommu.c                          |  26 +-
 drivers/iommu/amd_iommu_init.c                     |  45 +-
 drivers/iommu/arm-smmu-v3.c                        |  69 +-
 drivers/iommu/arm-smmu.c                           |   4 +-
 drivers/iommu/dma-iommu.c                          | 458 ++++++++--
 drivers/iommu/intel-iommu-debugfs.c                | 137 ++-
 drivers/iommu/intel-iommu.c                        | 940 ++++++++++-----------
 drivers/iommu/intel-pasid.c                        |  17 -
 drivers/iommu/intel-pasid.h                        |  26 +
 drivers/iommu/intel-svm.c                          |  15 +
 drivers/iommu/intel_irq_remapping.c                |   4 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  17 +-
 drivers/iommu/io-pgtable-arm.c                     |  40 +-
 drivers/iommu/iommu.c                              | 298 ++++++-
 drivers/iommu/ipmmu-vmsa.c                         | 186 ++--
 drivers/iommu/omap-iommu-debug.c                   |  35 +-
 drivers/iommu/omap-iommu.c                         |   3 +-
 include/linux/device.h                             |   3 +
 include/linux/dma-iommu.h                          |  49 +-
 include/linux/intel-iommu.h                        |   7 +-
 include/linux/intel-svm.h                          |   2 +-
 include/linux/io-pgtable.h                         |  11 +-
 include/linux/iommu.h                              | 105 +++
 include/uapi/linux/iommu.h                         | 155 ++++
 26 files changed, 1772 insertions(+), 1301 deletions(-)
 create mode 100644 include/uapi/linux/iommu.h

Please pull.

Thanks,

	Joerg
