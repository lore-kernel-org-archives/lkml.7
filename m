Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32831C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81F620704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKVUF2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:05:28 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50507 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKVUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:05:27 -0500
X-Originating-IP: 93.23.248.230
Received: from xps13 (230.248.23.93.rev.sfr.net [93.23.248.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EE5C61C0006;
        Fri, 22 Nov 2019 20:05:21 +0000 (UTC)
Date:   Fri, 22 Nov 2019 21:05:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.5
Message-ID: <20191122210520.3f714435@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 5.5.

Thanks,
Miquèl


The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.5

for you to fetch changes up to 589e1b6c47ce72fcae103c2e45d899610c92c11e:

  Merge tag 'nand/for-5.5' into mtd/next (2019-11-17 18:34:25 +0100)

----------------------------------------------------------------
MTD core:
* Dropped inactive maintainers, updated the repositories and added the IRC
  channel.
* Debugfs functions improvements.
* Initialized of more structure parameters.
* Misc fixes reported by robots.

MTD devices:
* spear_smi: Fixed Write Burst mode
* New Intel IXP4xx flash probing hook.

Raw NAND core:
* Useless extra checks dropped.
* Updated the detection of the bad block markers position

Raw NAND controller drivers:
* Cadence : New driver
* Brcmnand: Support for flash-dma v0 + fixes
* Denali : Support for the legacy controller/chip DT representation
           dropped
* Superfluous dev_err() calls removed

SPI NOR core changes:
* introduce 'struct spi_nor_controller_ops',
* clean the Register Operations methods,
* use dev_dbg insted of dev_err for low level info,
* fix retlen handling in sst_write(),
* fix silent truncations in spi_nor_read and spi_nor_read_raw(),
* fix the clearing of QE bit on lock()/unlock(),
* rework the disabling of the block write protection,
* rework the Quad Enable methods,
* make sure nor->spimem and nor->controller_ops are mutually exclusive,
* set default Quad Enable method for ISSI flashes,
* add support for few flashes.

SPI NOR controller drivers changes:
* intel-spi:
  - support chips without software sequencer,
  - add support for Intel Cannon Lake and Intel Comet Lake-H flashes.

CFI core changes:
* Code cleanups related useless initializers and coding style issues
* Fix for a possible double free problem in cfi_cmdset_0002
* Improved error reporting and handling in cfi_cmdset_0002 core for HyperFlash

----------------------------------------------------------------
Angelo Dureghello (1):
      mtd: devices: fix mchp23k256 read and write

Bartosz Golaszewski (1):
      mtd: st_spi_fsm: remove unused field from struct stfsm

Boris Brezillon (1):
      MAINTAINERS: Add the IRC channel to the MTD entry

DENG Qingfang (1):
      mtd: spi-nor: add support for en25qh16

Florian Fainelli (1):
      mtd: rawnand: brcmnand: Fix NULL pointer assignment

Fuqian Huang (1):
      mtd: maps: l440gx: Avoid printing address to dmesg

Greg Kroah-Hartman (1):
      mtd: no need to check return value of debugfs_create functions

Hou Tao (1):
      mtd: cfi_cmdset_0002: don't free cfi->cfiq in error path of cfi_amdstd_setup()

Jethro Beekman (2):
      mtd: spi-nor: intel-spi: support chips without software sequencer
      mtd: spi-nor: intel-spi: add support for Intel Cannon Lake SPI flash

Kamal Dasu (1):
      mtd: nand: brcmnand: Add support for flash-dma v0

Linus Walleij (2):
      mtd: add DT bindings for the Intel IXP4xx Flash
      mtd: physmap_of: add a hook for Intel IXP4xx flash probing

Manivannan Sadhasivam (1):
      mtd: spi-nor: Add support for w25q256jw

Marek Vasut (1):
      mtd: Remove myself from MAINTAINERS

Masahiro Yamada (1):
      mtd: rawnand: denali: remove the old unified controller/chip DT support

Mika Westerberg (1):
      mtd: spi-nor: intel-spi: Add support for Intel Comet Lake-H SPI serial flash

Miquel Raynal (7):
      mtd: Initialize all parameters of mtd_oob_ops
      MAINTAINERS: mtd/ubi/ubifs: Remove inactive maintainers
      mtd: spear_smi: Fix Write Burst mode
      MAINTAINERS: ubi/ubifs: Update the Git repository
      Merge CFI/Hyperbus tag 'for-v5.5-rc1' into mtd/next
      Merge tag 'spi-nor/for-5.5' into mtd/next
      Merge tag 'nand/for-5.5' into mtd/next

Piotr Sroka (4):
      mtd: rawnand: Change calculating of position page containing BBM
      mtd: rawnand: Add new Cadence NAND driver to MTD subsystem
      dt-bindings: mtd: Add Cadence NAND controller driver
      mtd: rawnand: remove unecessary checking if dmac is NULL

Sagar Shrikant Kadam (2):
      mtd: spi-nor: Add support for is25wp256
      mtd: spi-nor: Set default Quad Enable method for ISSI flashes

Sergei Shtylyov (6):
      mtd: spi-nor: fix silent truncation in spi_nor_read()
      mtd: spi-nor: fix silent truncation in spi_nor_read_raw()
      mtd: cfi_util: use DIV_ROUND_UP() in cfi_udelay()
      mtd: cfi_cmdset_*: kill useless 'ret' variable initializers
      mtd: cfi_cmdset_0002: only check errors when ready in cfi_check_err_status()
      mtd: cfi_cmdset_0002: fix delayed error detection on HyperFlash

Stephen Boyd (1):
      mtd: Remove dev_err() usage after platform_get_irq()

Tudor Ambarus (36):
      mtd: spi-nor: hisi-sfc: Drop nor->erase NULL assignment
      mtd: spi-nor: Introduce 'struct spi_nor_controller_ops'
      mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read() definition
      mtd: spi-nor: Prepend spi_nor_ to all Reg Ops methods
      mtd: spi-nor: Drop duplicated new line
      mtd: spi-nor: Group all Reg Ops to avoid forward declarations
      mtd: spi-nor: Stop compare with negative in Reg Ops methods
      mtd: spi-nor: Drop explicit cast to int to already int value
      mtd: spi-nor: Don't overwrite errno from Reg Ops
      mtd: spi-nor: Pointer parameter for SR in spi_nor_read_sr()
      mtd: spi-nor: Pointer parameter for FSR in spi_nor_read_fsr()
      mtd: spi-nor: Pointer parameter for CR in spi_nor_read_cr()
      mtd: spi-nor: Drop redundant error reports in Reg Ops callers
      mtd: spi-nor: Fix retlen handling in sst_write()
      mtd: spi-nor: Constify data to write to the Status Register
      mtd: spi-nor: Print device info in case of error
      mtd: spi-nor: Use dev_dbg insted of dev_err for low level info
      mtd: spi-nor: Print debug info inside Reg Ops methods
      mtd: spi-nor: Check for errors after each Register Operation
      mtd: spi-nor: Rename label as it is no longer generic
      mtd: spi-nor: Void return type for spi_nor_clear_sr/fsr()
      mtd: spi-nor: Move the WE and wait calls inside Write SR methods
      mtd: spi-nor: Merge spi_nor_write_sr() and spi_nor_write_sr_cr()
      mtd: spi-nor: Describe all the Reg Ops
      mtd: spi-nor: Drop spansion_quad_enable()
      mtd: spi-nor: Fix errno on Quad Enable methods
      mtd: spi-nor: Check all the bits written, not just the BP ones
      mtd: spi-nor: Print debug message when the read back test fails
      mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()
      mtd: spi-nor: Rework the disabling of block write protection
      mtd: spi-nor: Extend the SR Read Back test
      mtd: spi-nor: Rename CR_QUAD_EN_SPAN to SR2_QUAD_EN_BIT1
      mtd: spi-nor: Merge spansion Quad Enable methods
      mtd: spi-nor: Rename Quad Enable methods
      mtd: spi-nor: Make sure nor->spimem and nor->controller_ops are mutually exclusive
      mtd: spi-nor: Move condition to avoid a NULL check

YueHaibing (2):
      mtd: rawnand: mxic: Remove dev_err() on platform_get_irq() failure
      mtd: rawnand: cadence: Remove dev_err() on platform_get_irq() failure

zhengbin (1):
      mtd: spear_smi: remove set but not used variable 'flash_info'

 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt |   53 ++
 Documentation/devicetree/bindings/mtd/intel,ixp4xx-flash.txt      |   22 +
 MAINTAINERS                                                       |   21 +-
 drivers/mtd/chips/cfi_cmdset_0001.c                               |   10 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                               |   79 +-
 drivers/mtd/chips/cfi_cmdset_0020.c                               |    8 +-
 drivers/mtd/chips/cfi_util.c                                      |    2 +-
 drivers/mtd/devices/mchp23k256.c                                  |   20 +-
 drivers/mtd/devices/spear_smi.c                                   |   42 +-
 drivers/mtd/devices/st_spi_fsm.c                                  |    1 -
 drivers/mtd/maps/Kconfig                                          |   11 +
 drivers/mtd/maps/Makefile                                         |    1 +
 drivers/mtd/maps/l440gx.c                                         |    2 +-
 drivers/mtd/maps/physmap-core.c                                   |    5 +
 drivers/mtd/maps/physmap-ixp4xx.c                                 |  132 +++
 drivers/mtd/maps/physmap-ixp4xx.h                                 |   17 +
 drivers/mtd/mtdchar.c                                             |   10 +-
 drivers/mtd/mtdcore.c                                             |   26 +-
 drivers/mtd/mtdswap.c                                             |    8 +-
 drivers/mtd/nand/raw/Kconfig                                      |    7 +
 drivers/mtd/nand/raw/Makefile                                     |    1 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                          |   23 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c                    | 3030 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/denali_dt.c                                  |   59 +-
 drivers/mtd/nand/raw/hisi504_nand.c                               |    4 +-
 drivers/mtd/nand/raw/lpc32xx_mlc.c                                |    1 -
 drivers/mtd/nand/raw/marvell_nand.c                               |    4 +-
 drivers/mtd/nand/raw/meson_nand.c                                 |    4 +-
 drivers/mtd/nand/raw/mtk_ecc.c                                    |    4 +-
 drivers/mtd/nand/raw/mtk_nand.c                                   |    1 -
 drivers/mtd/nand/raw/mxic_nand.c                                  |    4 +-
 drivers/mtd/nand/raw/nand_base.c                                  |    8 +-
 drivers/mtd/nand/raw/nand_micron.c                                |    4 +-
 drivers/mtd/nand/raw/omap2.c                                      |    8 +-
 drivers/mtd/nand/raw/sh_flctl.c                                   |    4 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                            |    5 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                 |    4 +-
 drivers/mtd/spi-nor/aspeed-smc.c                                  |   23 +-
 drivers/mtd/spi-nor/cadence-quadspi.c                             |   58 +-
 drivers/mtd/spi-nor/hisi-sfc.c                                    |   23 +-
 drivers/mtd/spi-nor/intel-spi-pci.c                               |    6 +
 drivers/mtd/spi-nor/intel-spi.c                                   |   58 +-
 drivers/mtd/spi-nor/mtk-quadspi.c                                 |   25 +-
 drivers/mtd/spi-nor/nxp-spifi.c                                   |   23 +-
 drivers/mtd/spi-nor/spi-nor.c                                     | 1537 ++++++++++++++++++++---------------
 drivers/mtd/ubi/debug.c                                           |  111 +--
 include/linux/mtd/spi-nor.h                                       |   64 +-
 include/linux/platform_data/intel-spi.h                           |    1 +
 48 files changed, 4538 insertions(+), 1036 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/intel,ixp4xx-flash.txt
 create mode 100644 drivers/mtd/maps/physmap-ixp4xx.c
 create mode 100644 drivers/mtd/maps/physmap-ixp4xx.h
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c
