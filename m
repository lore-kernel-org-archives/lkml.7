Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2823BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35892087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEFSLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:11:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58456 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfEFSLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:11:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A840A78;
        Mon,  6 May 2019 11:11:16 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338D03F5AF;
        Mon,  6 May 2019 11:11:14 -0700 (PDT)
Date:   Mon, 6 May 2019 19:11:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.ibm.com,
        benh@kernel.crashing.org, macro@linux-mips.org, mingo@kernel.org,
        npiggin@gmail.com
Subject: [GIT PULL] mmiowb() removal for 5.2
Message-ID: <20190506181110.GB2875@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the mmiowb() removal series ready for 5.2. The only relatively
recent changes have been addressing review comments on the documentation,
which is in a much better shape thanks to the efforts of Ben and Ingo.

I was initially planning to split this into two pull requests so that you
could run the coccinelle script yourself, however it's been plain sailing
in linux-next so I've just included the whole lot here to keep things
simple.

There is a trivial conflict in the S390 asm/Kbuild file with the rwsem
changes in -tip, but I think that's it.

Please pull,

Will

--->8

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-mmiowb

for you to fetch changes up to 9726840d9cf0d42377e1591263d7c1d9ae0988ac:

  docs/memory-barriers.txt: Update I/O section to be clearer about CPU vs thread (2019-04-23 13:34:17 +0100)

----------------------------------------------------------------
Remove Mysterious Macro Intended to Obscure Weird Behaviours (mmiowb())

Remove mmiowb() from the kernel memory barrier API and instead, for
architectures that need it, hide the barrier inside spin_unlock() when
MMIO has been performed inside the critical section.

----------------------------------------------------------------
Will Deacon (23):
      docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER EFFECTS" section
      asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
      arch: Use asm-generic header for asm/mmiowb.h
      mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O accessors
      ARM/io: Remove useless definition of mmiowb()
      arm64/io: Remove useless definition of mmiowb()
      x86/io: Remove useless definition of mmiowb()
      nds32/io: Remove useless definition of mmiowb()
      m68k/io: Remove useless definition of mmiowb()
      sh/mmiowb: Add unconditional mmiowb() to arch_spin_unlock()
      mips/mmiowb: Add unconditional mmiowb() to arch_spin_unlock()
      ia64/mmiowb: Add unconditional mmiowb() to arch_spin_unlock()
      powerpc/mmiowb: Hook up mmwiob() implementation to asm-generic code
      riscv/mmiowb: Hook up mmwiob() implementation to asm-generic code
      Documentation: Kill all references to mmiowb()
      drivers: Remove useless trailing comments from mmiowb() invocations
      drivers: Remove explicit invocations of mmiowb()
      scsi/qla1280: Remove stale comment about mmiowb()
      i40iw: Redefine i40iw_mmiowb() to do nothing
      net/ethernet/silan/sc92031: Remove stale comment about mmiowb()
      arch: Remove dummy mmiowb() definitions from arch code
      docs/memory-barriers.txt: Fix style, spacing and grammar in I/O section
      docs/memory-barriers.txt: Update I/O section to be clearer about CPU vs thread

 Documentation/driver-api/device-io.rst             |  45 ----
 Documentation/driver-api/pci/p2pdma.rst            |   4 -
 Documentation/memory-barriers.txt                  | 249 +++++++++------------
 arch/alpha/include/asm/Kbuild                      |   1 +
 arch/alpha/include/asm/io.h                        |   2 -
 arch/arc/include/asm/Kbuild                        |   1 +
 arch/arm/include/asm/Kbuild                        |   1 +
 arch/arm/include/asm/io.h                          |   2 -
 arch/arm64/include/asm/Kbuild                      |   1 +
 arch/arm64/include/asm/io.h                        |   2 -
 arch/c6x/include/asm/Kbuild                        |   1 +
 arch/csky/include/asm/Kbuild                       |   1 +
 arch/h8300/include/asm/Kbuild                      |   1 +
 arch/hexagon/include/asm/Kbuild                    |   1 +
 arch/hexagon/include/asm/io.h                      |   2 -
 arch/ia64/include/asm/io.h                         |  17 --
 arch/ia64/include/asm/mmiowb.h                     |  25 +++
 arch/ia64/include/asm/spinlock.h                   |   2 +
 arch/m68k/include/asm/Kbuild                       |   1 +
 arch/m68k/include/asm/io_mm.h                      |   2 -
 arch/microblaze/include/asm/Kbuild                 |   1 +
 arch/mips/include/asm/io.h                         |   3 -
 arch/mips/include/asm/mmiowb.h                     |  11 +
 arch/mips/include/asm/spinlock.h                   |  15 ++
 arch/nds32/include/asm/Kbuild                      |   1 +
 arch/nds32/include/asm/io.h                        |   2 -
 arch/nios2/include/asm/Kbuild                      |   1 +
 arch/openrisc/include/asm/Kbuild                   |   1 +
 arch/parisc/include/asm/Kbuild                     |   1 +
 arch/parisc/include/asm/io.h                       |   2 -
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/io.h                      |  33 +--
 arch/powerpc/include/asm/mmiowb.h                  |  18 ++
 arch/powerpc/include/asm/paca.h                    |   6 +-
 arch/powerpc/include/asm/spinlock.h                |  17 --
 arch/powerpc/xmon/xmon.c                           |   5 +-
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/io.h                        |  15 +-
 arch/riscv/include/asm/mmiowb.h                    |  14 ++
 arch/s390/include/asm/Kbuild                       |   1 +
 arch/sh/include/asm/io.h                           |   3 -
 arch/sh/include/asm/mmiowb.h                       |  12 +
 arch/sh/include/asm/spinlock-llsc.h                |   2 +
 arch/sparc/include/asm/Kbuild                      |   1 +
 arch/sparc/include/asm/io_64.h                     |   2 -
 arch/um/include/asm/Kbuild                         |   1 +
 arch/unicore32/include/asm/Kbuild                  |   1 +
 arch/x86/include/asm/Kbuild                        |   1 +
 arch/x86/include/asm/io.h                          |   2 -
 arch/xtensa/include/asm/Kbuild                     |   1 +
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c       |   4 -
 drivers/dma/txx9dmac.c                             |   3 -
 drivers/firewire/ohci.c                            |   1 -
 drivers/gpu/drm/i915/intel_hdmi.c                  |  10 -
 drivers/ide/tx4939ide.c                            |   2 -
 drivers/infiniband/hw/hfi1/chip.c                  |   3 -
 drivers/infiniband/hw/hfi1/pio.c                   |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   2 -
 drivers/infiniband/hw/i40iw/i40iw_osdep.h          |   2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   6 -
 drivers/infiniband/hw/mlx5/qp.c                    |   1 -
 drivers/infiniband/hw/mthca/mthca_cmd.c            |   6 -
 drivers/infiniband/hw/mthca/mthca_cq.c             |   5 -
 drivers/infiniband/hw/mthca/mthca_qp.c             |  17 --
 drivers/infiniband/hw/mthca/mthca_srq.c            |   6 -
 drivers/infiniband/hw/qedr/verbs.c                 |  12 -
 drivers/infiniband/hw/qib/qib_iba6120.c            |   4 -
 drivers/infiniband/hw/qib/qib_iba7220.c            |   3 -
 drivers/infiniband/hw/qib/qib_iba7322.c            |   3 -
 drivers/infiniband/hw/qib/qib_sd7220.c             |   4 -
 drivers/media/pci/dt3155/dt3155.c                  |   8 -
 drivers/memstick/host/jmb38x_ms.c                  |   4 -
 drivers/misc/ioc4.c                                |   2 -
 drivers/misc/mei/hw-me.c                           |   3 -
 drivers/misc/tifm_7xx1.c                           |   1 -
 drivers/mmc/host/alcor.c                           |   1 -
 drivers/mmc/host/sdhci.c                           |  13 --
 drivers/mmc/host/tifm_sd.c                         |   3 -
 drivers/mmc/host/via-sdmmc.c                       |  10 -
 drivers/mtd/nand/raw/r852.c                        |   2 -
 drivers/mtd/nand/raw/txx9ndfmc.c                   |   1 -
 drivers/net/ethernet/aeroflex/greth.c              |   1 -
 drivers/net/ethernet/alacritech/slicoss.c          |   4 -
 drivers/net/ethernet/amazon/ena/ena_com.c          |   1 -
 drivers/net/ethernet/atheros/atlx/atl1.c           |   1 -
 drivers/net/ethernet/atheros/atlx/atl2.c           |   1 -
 drivers/net/ethernet/broadcom/bnx2.c               |   4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   2 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |   4 -
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  29 ---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |   1 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |   2 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |   4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   3 -
 drivers/net/ethernet/broadcom/tg3.c                |   6 -
 .../net/ethernet/cavium/liquidio/cn66xx_device.c   |  10 -
 .../net/ethernet/cavium/liquidio/octeon_device.c   |   1 -
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c |   4 -
 .../net/ethernet/cavium/liquidio/request_manager.c |   1 -
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   5 -
 drivers/net/ethernet/intel/e1000e/netdev.c         |   7 -
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c       |   2 -
 drivers/net/ethernet/intel/fm10k/fm10k_main.c      |   5 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   5 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   5 -
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   5 -
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 -
 drivers/net/ethernet/intel/igbvf/netdev.c          |   4 -
 drivers/net/ethernet/intel/igc/igc_main.c          |   5 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   5 -
 drivers/net/ethernet/marvell/sky2.c                |   4 -
 drivers/net/ethernet/mellanox/mlx4/catas.c         |   4 -
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |  13 --
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   1 -
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   2 -
 drivers/net/ethernet/neterion/s2io.c               |   2 -
 drivers/net/ethernet/neterion/vxge/vxge-main.c     |   5 -
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c  |   4 -
 drivers/net/ethernet/qlogic/qed/qed_int.c          |  13 --
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |   3 -
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   8 -
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   8 -
 drivers/net/ethernet/qlogic/qla3xxx.c              |   1 -
 drivers/net/ethernet/qlogic/qlge/qlge.h            |   1 -
 drivers/net/ethernet/qlogic/qlge/qlge_main.c       |   1 -
 drivers/net/ethernet/renesas/ravb_main.c           |   9 -
 drivers/net/ethernet/renesas/ravb_ptp.c            |   3 -
 drivers/net/ethernet/renesas/sh_eth.c              |   1 -
 drivers/net/ethernet/sfc/falcon/io.h               |   2 -
 drivers/net/ethernet/sfc/io.h                      |   2 -
 drivers/net/ethernet/silan/sc92031.c               |  15 --
 drivers/net/ethernet/via/via-rhine.c               |   3 -
 drivers/net/ethernet/wiznet/w5100.c                |   6 -
 drivers/net/ethernet/wiznet/w5300.c                |  15 --
 drivers/net/wireless/ath/ath5k/base.c              |   4 -
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |   2 -
 drivers/net/wireless/broadcom/b43/main.c           |   7 -
 drivers/net/wireless/broadcom/b43/sysfs.c          |   1 -
 drivers/net/wireless/broadcom/b43legacy/ilt.c      |   2 -
 drivers/net/wireless/broadcom/b43legacy/main.c     |  20 --
 drivers/net/wireless/broadcom/b43legacy/phy.c      |   1 -
 drivers/net/wireless/broadcom/b43legacy/pio.h      |   1 -
 drivers/net/wireless/broadcom/b43legacy/radio.c    |   4 -
 drivers/net/wireless/broadcom/b43legacy/sysfs.c    |   1 -
 drivers/net/wireless/intel/iwlegacy/common.h       |   7 -
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   1 -
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   7 -
 drivers/ntb/test/ntb_perf.c                        |   3 -
 drivers/scsi/bfa/bfa.h                             |   3 +-
 drivers/scsi/bfa/bfa_hw_cb.c                       |   2 -
 drivers/scsi/bfa/bfa_hw_ct.c                       |   2 -
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |   2 -
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |   3 -
 drivers/scsi/megaraid/megaraid_sas_base.c          |   1 -
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   1 -
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   1 -
 drivers/scsi/qedf/qedf_io.c                        |   1 -
 drivers/scsi/qedi/qedi_fw.c                        |   1 -
 drivers/scsi/qla1280.c                             |  15 --
 drivers/ssb/pci.c                                  |   1 -
 drivers/ssb/pcmcia.c                               |   4 -
 drivers/staging/comedi/drivers/mite.c              |   3 -
 drivers/staging/comedi/drivers/ni_660x.c           |   2 -
 drivers/staging/comedi/drivers/ni_mio_common.c     |   1 -
 drivers/staging/comedi/drivers/ni_pcidio.c         |   2 -
 drivers/staging/comedi/drivers/ni_tio.c            |   1 -
 drivers/staging/comedi/drivers/s626.c              |   2 -
 drivers/tty/serial/men_z135_uart.c                 |   1 -
 drivers/tty/serial/serial_txx9.c                   |   1 -
 drivers/usb/early/xhci-dbc.c                       |   4 -
 drivers/usb/host/xhci-dbgcap.c                     |   2 -
 include/asm-generic/io.h                           |   7 +-
 include/asm-generic/mmiowb.h                       |  63 ++++++
 include/asm-generic/mmiowb_types.h                 |  12 +
 include/linux/qed/qed_if.h                         |   2 -
 include/linux/spinlock.h                           |  11 +-
 kernel/Kconfig.locks                               |   7 +
 kernel/locking/spinlock.c                          |   7 +
 kernel/locking/spinlock_debug.c                    |   6 +-
 sound/soc/txx9/txx9aclc-ac97.c                     |   1 -
 181 files changed, 343 insertions(+), 828 deletions(-)
 create mode 100644 arch/ia64/include/asm/mmiowb.h
 create mode 100644 arch/mips/include/asm/mmiowb.h
 create mode 100644 arch/powerpc/include/asm/mmiowb.h
 create mode 100644 arch/riscv/include/asm/mmiowb.h
 create mode 100644 arch/sh/include/asm/mmiowb.h
 create mode 100644 include/asm-generic/mmiowb.h
 create mode 100644 include/asm-generic/mmiowb_types.h
