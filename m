Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1462081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCHJeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:34:31 -0500
Received: from 8bytes.org ([81.169.241.247]:57152 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfCHJea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:34:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 64978475; Fri,  8 Mar 2019 10:34:29 +0100 (CET)
Date:   Fri, 8 Mar 2019 10:34:28 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.1
Message-ID: <20190308093422.GA14090@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.1

for you to fetch changes up to d05e4c8600c36084ce9de6249bb972c9bdd75b7e:

  Merge branches 'iommu/fixes', 'arm/msm', 'arm/tegra', 'arm/mediatek', 'x86/vt-d', 'x86/amd', 'hyper-v' and 'core' into next (2019-03-01 11:24:51 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.1

Including:

	- A big cleanup and optimization patch-set for the
	  Tegra GART driver

	- Documentation updates and fixes for the IOMMU-API

	- Support for page request in Intel VT-d scalable mode

	- Intel VT-d dma_[un]map_resource() support

	- Updates to the ATS enabling code for PCI (acked by Bjorn) and
	  Intel VT-d to align with the latest version of the ATS spec

	- Relaxed IRQ source checking in the Intel VT-d driver for some
	  aliased devices, needed for future devices which send IRQ
	  messages from more than on request-ID

	- IRQ remapping driver for Hyper-V

	- Patches to make generic IOVA and IO-Page-Table code usable
	  outside of the IOMMU code

	- Various other small fixes and cleanups

----------------------------------------------------------------
Bjorn Helgaas (6):
      iommu: Use dev_printk() when possible
      iommu/amd: Use dev_printk() when possible
      iommu/vt-d: Use dev_printk() when possible
      iommu/vt-d: Remove unnecessary local variable initializations
      iommu/vt-d: Remove unused dmar_remove_one_dev_info() argument
      iommu/vt-d: Remove misleading "domain 0" test from domain_exit()

Dmitry Osipenko (24):
      iommu/tegra: gart: Remove pr_fmt and clean up includes
      iommu/tegra: gart: Clean up driver probe errors handling
      iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
      iommu: Introduce iotlb_sync_map callback
      iommu/tegra: gart: Optimize mapping / unmapping performance
      dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
      ARM: dts: tegra20: Update Memory Controller node to the new binding
      memory: tegra: Don't invoke Tegra30+ specific memory timing setup on Tegra20
      memory: tegra: Adapt to Tegra20 device-tree binding changes
      memory: tegra: Read client ID on GART page fault
      memory: tegra: Use of_device_get_match_data()
      memory: tegra: Use relaxed versions of readl/writel
      iommu/tegra: gart: Integrate with Memory Controller driver
      memory: tegra: Do not try to probe SMMU on Tegra20
      memory: tegra: Do not ask for IRQ sharing
      memory: tegra: Clean up error messages
      iommu/tegra: gart: Fix spinlock recursion
      iommu/tegra: gart: Fix NULL pointer dereference
      iommu/tegra: gart: Allow only one active domain at a time
      iommu/tegra: gart: Don't use managed resources
      iommu/tegra: gart: Prepend error/debug messages with "gart:"
      iommu/tegra: gart: Don't detach devices from inactive domains
      iommu/tegra: gart: Simplify clients-tracking code
      iommu/tegra: gart: Perform code refactoring

Geert Uytterhoeven (3):
      iommu: Document iommu_ops.iotlb_sync_map()
      iommu: Document iommu_ops.is_attach_deferred()
      iommu: Fix IOMMU debugfs fallout

Jacob Pan (1):
      iommu/vt-d: Support page request in scalable mode

Jerry Snitselaar (1):
      iommu/amd: Print reason for iommu_map_page failure in map_sg

Joerg Roedel (1):
      Merge branches 'iommu/fixes', 'arm/msm', 'arm/tegra', 'arm/mediatek', 'x86/vt-d', 'x86/amd', 'hyper-v' and 'core' into next

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Julia Lawall (1):
      iommu/msm: Reduce indentation

Kuppuswamy Sathyanarayanan (5):
      PCI/ATS: Add pci_prg_resp_pasid_required() interface.
      iommu/vt-d: Fix PRI/PASID dependency issue.
      PCI/ATS: Add pci_ats_page_aligned() interface
      iommu/vt-d: Enable ATS only if the device uses page aligned address.
      PCI/ATS: Add inline to pci_prg_resp_pasid_required()

Lan Tianyu (3):
      x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
      iommu/hyper-v: Add Hyper-V stub IOMMU driver
      MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS scope

Logan Gunthorpe (3):
      iommu/vt-d: Implement dma_[un]map_resource()
      iommu/vt-d: Add helper to set an IRTE to verify only the bus number
      iommu/vt-d: Allow interrupts from the entire bus for aliased devices

Lu Baolu (5):
      iommu/vt-d: Check identity map for hot-added devices
      iommu/vt-d: Disable ATS support on untrusted devices
      iommu/vt-d: Set context field after value initialized
      iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
      iommu/vt-d: Get domain ID before clear pasid entry

Nicolas Boichat (1):
      iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Peter Xu (2):
      iommu/amd: Remove clear_flush_young notifier
      iommu/vt-d: Remove change_pte notifier

Rob Herring (1):
      iommu: Allow io-pgtable to be used outside of drivers/iommu/

Sakari Ailus (1):
      iommu/iova: Allow compiling the library without IOMMU support

Shaokun Zhang (1):
      iommu/dma: Remove unused variable

Tom Murphy (1):
      iommu: Fix flush_tlb_all typo

Yang Wei (1):
      iommu/mediatek: Fix semicolon code style issue

 .../bindings/iommu/nvidia,tegra20-gart.txt         |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt       |  27 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/tegra20.dtsi                     |  15 +-
 arch/x86/kernel/cpu/mshyperv.c                     |  12 +
 drivers/Makefile                                   |   2 +-
 drivers/iommu/Kconfig                              |  17 +-
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd_iommu.c                          |  28 +-
 drivers/iommu/amd_iommu_init.c                     |  20 +-
 drivers/iommu/amd_iommu_v2.c                       |  24 --
 drivers/iommu/arm-smmu-v3.c                        |   3 +-
 drivers/iommu/arm-smmu.c                           |   2 +-
 drivers/iommu/dma-iommu.c                          |   3 +-
 drivers/iommu/dmar.c                               |   2 +-
 drivers/iommu/hyperv-iommu.c                       | 196 +++++++++
 drivers/iommu/intel-iommu.c                        | 158 +++----
 drivers/iommu/intel-pasid.c                        |   2 +-
 drivers/iommu/intel-svm.c                          |  88 ++--
 drivers/iommu/intel_irq_remapping.c                |  32 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |   6 +-
 drivers/iommu/io-pgtable-arm.c                     |   3 +-
 drivers/iommu/io-pgtable.c                         |   5 +-
 drivers/iommu/iommu-debugfs.c                      |  23 +-
 drivers/iommu/iommu.c                              |  16 +-
 drivers/iommu/ipmmu-vmsa.c                         |   3 +-
 drivers/iommu/irq_remapping.c                      |   3 +
 drivers/iommu/irq_remapping.h                      |   1 +
 drivers/iommu/msm_iommu.c                          |  10 +-
 drivers/iommu/mtk_iommu.h                          |   3 +-
 drivers/iommu/mtk_iommu_v1.c                       |   2 +-
 drivers/iommu/qcom_iommu.c                         |   2 +-
 drivers/iommu/tegra-gart.c                         | 473 ++++++++-------------
 drivers/iommu/tegra-smmu.c                         |   4 -
 drivers/memory/tegra/mc.c                          | 118 +++--
 drivers/memory/tegra/mc.h                          |  10 +-
 drivers/pci/ats.c                                  |  57 +++
 include/linux/intel-iommu.h                        |  21 +-
 include/linux/intel-svm.h                          |   2 +-
 {drivers/iommu => include/linux}/io-pgtable.h      |   0
 include/linux/iommu.h                              |   6 +-
 include/linux/pci-ats.h                            |   5 +
 include/linux/pci.h                                |   2 +
 include/soc/tegra/mc.h                             |  27 +-
 include/uapi/linux/pci_regs.h                      |   2 +
 45 files changed, 839 insertions(+), 612 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
 create mode 100644 drivers/iommu/hyperv-iommu.c
 rename {drivers/iommu => include/linux}/io-pgtable.h (100%)

Please pull.

Thanks,

	Joerg

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyCNx0ACgkQK/BELZcB
GuMXPBAA0Pnc+YuoShqGaYwxK8f9sKUz1fjwcPTOPWFvovu/mKRmbTRyL++oNB6I
bzMzK/P0pU08LceBpjr8OaQ3N/8taB4zjx/Ta/2bmObYOGxbCBoXeq8Yf4Z/Qn6O
Mv2VMtYUyv42wxG14nNhOXtWvPrMYJX1cuNa1DphQQUeirKc2iHGDULYfv0wRu6U
FSpq0XkqMNS2dmGteNsNVacTaWya3P9U0vzgPNmFqmx5Rf5ZQE/NHGw7IYkxbeyW
7aaI0zWX2LMOC8rfwRR5A3YQI2tZUsP2pX7Y8mHlqHLnY+cm2yXny4jAgvBu67K4
vFvLNS5l6P0WngLC3sp9q6fU5ukTajCVEgX+LjC11Ks10UBzw4eE55a1pIT4WZzQ
PFEP1e0rOv8g5ngOSRg4pK9Wo32xKbckAZ5/3QNfyZVeYx1eAaelADr4+gqVeRMB
6Oo/NoZBT6pGP2tpzZs7EVs6GpMnOSQDn/mKbMX0nls1SdYVSfvfcqv2/8tgeqSi
m8L4c1xzl/XP6V7o9Dgi4yIDGIp2WsYSOZ6cOedwI35/Ioc4m/ilq8H1Fic8hW+U
WYChs3TWvSdXN43j4sOBy4791F+38bdq1hjcCF8/MLhZa4B4orYl5EEs93+4Bu32
9OtL0NDuMN3NV13DALv2hSJe2EkD7eAOWmiJ6rmUmgt/shfE/aM=
=tR/H
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
