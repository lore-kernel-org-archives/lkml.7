Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039EDC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FA021019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfEMLxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:53:37 -0400
Received: from 8bytes.org ([81.169.241.247]:41168 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfEMLxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:53:36 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 75174AAC; Mon, 13 May 2019 13:53:35 +0200 (CEST)
Date:   Mon, 13 May 2019 13:53:34 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.2
Message-ID: <20190513115328.GA12854@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

this pull-request includes two reverts which I had to do after the merge
window started, because the reverted patches caused issues in
linux-next. But the rest of this was ready before the merge window. With
this in mind:

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.2

for you to fetch changes up to b5531563e8a0b8fcc5344a38d1fad9217e08e09b:

  Merge branches 'arm/tegra', 'arm/mediatek', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next (2019-05-07 09:40:12 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.2

Including:

	- ATS support for ARM-SMMU-v3.

	- AUX domain support in the IOMMU-API and the Intel VT-d driver.
	  This adds support for multiple DMA address spaces per
	  (PCI-)device. The use-case is to multiplex devices between
	  host and KVM guests in a more flexible way than supported by
	  SR-IOV.

	- The Rest are smaller cleanups and fixes, two of which needed
	  to be reverted after testing in linux-next.

----------------------------------------------------------------
Andy Shevchenko (1):
      iommu/vt-d: Switch to bitmap_zalloc()

Christoph Hellwig (4):
      iommu/amd: Remove the leftover of bypass support
      iommu/vt-d: Clean up iommu_no_mapping
      iommu/vt-d: Use dma_direct for bypass devices
      iommu/vt-d: Don't clear GFP_DMA and GFP_DMA32 flags

Dmitry Osipenko (3):
      iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
      iommu/tegra-smmu: Properly release domain resources
      iommu/tegra-smmu: Respect IOMMU API read-write protections

Douglas Anderson (1):
      iommu/arm-smmu: Break insecure users by disabling bypass by default

Eric Auger (1):
      iommu/vt-d: Fix leak in intel_pasid_alloc_table on error path

Gustavo A. R. Silva (1):
      iommu/vt-d: Use struct_size() helper

Jean-Philippe Brucker (11):
      iommu: Bind process address spaces to devices
      iommu/amd: Use pci_prg_resp_pasid_required()
      PCI: Move ATS declarations outside of CONFIG_PCI
      PCI: Add a stub for pci_ats_disabled()
      ACPI/IORT: Check ATS capability in root complex nodes
      iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
      iommu/arm-smmu-v3: Store SteamIDs in master
      iommu/arm-smmu-v3: Add a master->domain pointer
      iommu/arm-smmu-v3: Link domains and devices
      iommu/arm-smmu-v3: Add support for PCI ATS
      iommu/arm-smmu-v3: Disable tagged pointers

Jinyu Qi (1):
      iommu/iova: Separate atomic variables to improve performance

Joerg Roedel (7):
      Merge branch 'api-features' into x86/vt-d
      iommu/amd: Remove amd_iommu_pd_list
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branch 'api-features' into arm/smmu
      Revert "iommu/amd: Remove the leftover of bypass support"
      Revert "iommu/amd: Flush not present cache in iommu_map_page"
      Merge branches 'arm/tegra', 'arm/mediatek', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next

Lu Baolu (15):
      iommu: Remove iommu_callback_data
      iommu: Add APIs for multiple domains per device
      iommu/vt-d: Make intel_iommu_enable_pasid() more generic
      iommu/vt-d: Add per-device IOMMU feature ops entries
      iommu/vt-d: Move common code out of iommu_attch_device()
      iommu/vt-d: Aux-domain specific domain attach/detach
      iommu/vt-d: Return ID associated with an auxiliary domain
      vfio/mdev: Add iommu related member in mdev_device
      vfio/type1: Add domain at(de)taching group helpers
      vfio/type1: Handle different mdev isolation type
      iommu/vt-d: Flush IOTLB for untrusted device in time
      iommu/vt-d: Don't request page request irq under dmar_global_lock
      iommu/vt-d: Cleanup: no spaces at the start of a line
      iommu/vt-d: Set intel_iommu_gfx_mapped correctly
      iommu/vt-d: Make kernel parameter igfx_off work with vIOMMU

Tom Murphy (1):
      iommu/amd: Flush not present cache in iommu_map_page

Vivek Gautam (1):
      iommu/arm-smmu: Log CBFRSYNRA register on context fault

Wen Yang (1):
      iommu/mediatek: Fix leaked of_node references

Will Deacon (1):
      iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel

 drivers/acpi/arm64/iort.c           |  11 +
 drivers/iommu/Kconfig               |  25 ++
 drivers/iommu/amd_iommu.c           |  52 +---
 drivers/iommu/amd_iommu_init.c      |   8 -
 drivers/iommu/amd_iommu_types.h     |   6 -
 drivers/iommu/arm-smmu-regs.h       |   2 +
 drivers/iommu/arm-smmu-v3.c         | 355 +++++++++++++++++-----
 drivers/iommu/arm-smmu.c            |  11 +-
 drivers/iommu/dmar.c                |   2 +-
 drivers/iommu/intel-iommu.c         | 584 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel-pasid.c         |   4 +-
 drivers/iommu/intel-svm.c           |  19 +-
 drivers/iommu/intel_irq_remapping.c |   7 +-
 drivers/iommu/iommu.c               | 211 ++++++++++++-
 drivers/iommu/mtk_iommu.c           |   8 +-
 drivers/iommu/tegra-smmu.c          |  41 ++-
 drivers/vfio/mdev/mdev_core.c       |  18 ++
 drivers/vfio/mdev/mdev_private.h    |   1 +
 drivers/vfio/vfio_iommu_type1.c     | 139 +++++++--
 include/linux/intel-iommu.h         |  13 +-
 include/linux/iommu.h               | 144 +++++++++
 include/linux/iova.h                |  16 +-
 include/linux/mdev.h                |  14 +
 include/linux/pci.h                 |  31 +-
 24 files changed, 1376 insertions(+), 346 deletions(-)

Please pull.

Thanks,

	Joerg

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlzZWrcACgkQK/BELZcB
GuNo1w//QRnAse4e2vXewn+JJWiOOMMoIcyj+LVXaduvKNfUbHRce0BLUDKY0ISu
JPqyld7e2G7AhCc2yvANswtTKAEIthkTTgvgDed3kF5kBHOb/1ja34RhNTsXJ3Yq
Y4dkOUBg7k8jFHMVaIs6B6q+KEyVEFArRmjWAM4+bWt1Y+aXH7ditJ3eI6AyEIuv
dg4ylMM06W9F3/rzsc+f3aSHlNes+Cqfo7/fAgn7REOcqY3aGpk/JJCjqdLE143s
m/GHSj81U/cdeoYHzcJtKvGsiaAXiQKJCvEe2CKLVBs+JUHmprnsmRYjOnwG2X26
sMjiAlnkFuNuG0gPqqGS5jg7HjXLMucnJJjCYgrm05G+Ht/Vvulw9ctYk4qcVF0i
5mAFUvBew6kLOUbr9Oa3IojpNHPgM4Eoft5Wvagy5lpCdelmWkwu2cHgbF6/KT4l
cyEKd4DdqgR2keWov7ODlvas2pWx1dtvBtTOV8iZmSMit90aitCU1I2MoEp7YcS7
+RhfeHQ9GPOZE2OmgrRiqyJx8JabgFLLnRWaouOhJcAO79YpGCHz1s0zrgX10zdv
ux7qHuNuL12AgLGueivAS8UeuaQYd3X7hncns8Xyj0NrtQYo8PuZBhiMzpR/Ms0u
AgYev7a/yZwa8AM9rdtGpRWYK8r90K5kF1cHUhuc/QL+wC8Eeuk=
=lC6W
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
