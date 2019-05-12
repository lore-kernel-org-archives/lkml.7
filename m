Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E83C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C062621019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfELVmN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:42:13 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59454 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfELVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:42:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8B50B6083106;
        Sun, 12 May 2019 23:42:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zi9jzZr9jm-l; Sun, 12 May 2019 23:42:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D8C136083105;
        Sun, 12 May 2019 23:42:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8jp0dnQB1Kko; Sun, 12 May 2019 23:42:07 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 80745608A3BE;
        Sun, 12 May 2019 23:42:07 +0200 (CEST)
Date:   Sun, 12 May 2019 23:42:07 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com, marek.vasut@gmail.com
Message-ID: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD changes for v5.2-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Index: HgOwXzVrkmjWkMqO5Rrlde7jUNEYtw==
Thread-Topic: MTD changes for v5.2-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.2

for you to fetch changes up to 3008ba87093852f3756c5d33f584602e5e2a4aa4:

  mtd: part: fix incorrect format specifier for an unsigned long long (2019-05-06 21:57:06 +0200)

----------------------------------------------------------------
This pull request contains the following changes for MTD:

MTD core changes:
- New AFS partition parser
- Update MAINTAINERS entry
- Use of fall-throughs markers

NAND core changes:
- Support having the bad block markers in either the first, second or
  last page of a block. The combination of all three location is now
  possible.
- Constification of NAND_OP_PARSER(_PATTERN) elements.
- Generic NAND DT bindings changed to yaml format (can be used to
  check the proposed bindings. First platform to be fully supported:
  sunxi.
- Stopped using several legacy hooks.
- Preparation to use the generic NAND layer with the addition of
  several helpers and the removal of the struct nand_chip from generic
  functions.
- Kconfig cleanup to prepare the introduction of external ECC engines
  support.
- Fallthrough comments.
- Introduction of the SPI-mem dirmap API for SPI-NAND devices.

Raw NAND controller drivers changes:
- nandsim:
  * Switch to ->exec-op().
- meson:
  * Misc cleanups and fixes.
  * New OOB layout.
- Sunxi:
  * A23/A33 NAND DMA support.
- Ingenic:
  * Full reorganization and cleanup.
  * Clear separation between NAND controller and ECC engine.
  * Support JZ4740 an JZ4725B.
- Denali:
  * Clear controller/chip separation.
  * ->exec_op() migration.
  * Various cleanups.
- fsl_elbc:
  * Enable software ECC support.
- Atmel:
  * Sam9x60 support.
- GPMI:
  * Introduce the GPMI_IS_MXS() macro.
- Various trivial/spelling/coding style fixes.

SPI NOR core changes:
- Print all JEDEC ID bytes on error
- Fix comment of spi_nor_find_best_erase_type()
- Add region locking flags for s25fl512s

SPI NOR controller drivers changes:
- intel-spi:
  * Avoid crossing 4K address boundary on read/write
  * Add support for Intel Comet Lake SPI serial flash

----------------------------------------------------------------
Aditya Pakki (1):
      mtd: rawnand: vf610: Avoid a potential NULL pointer dereference

Alexander Sverdlin (2):
      mtd: spi-nor: Fix comment of spi_nor_find_best_erase_type()
      mtd: spi-nor: intel-spi: Avoid crossing 4K address boundary on read/write

Anders Roxell (1):
      mtd: rawnand: fix build dependency

Arnd Bergmann (1):
      mtd: physmap_of_gemini: remove extranous __xipram annotation

Boris Brezillon (17):
      mtd: spinand: Use the spi-mem dirmap API
      mtd: nand: Add max_bad_eraseblocks_per_lun info to memorg
      mtd: nand: Add a helper returning the number of eraseblocks per target
      mtd: nand: Add a helper to retrieve the number of pages per target
      mtd: spinand: Implement mtd->_max_bad_blocks
      mtd: rawnand: Use nand_to_mtd() in nand_{set,get}_flash_node()
      mtd: rawnand: Prepare things to reuse the generic NAND layer
      mtd: rawnand: Fill memorg during detection
      mtd: rawnand: Initialize the nand_device object
      mtd: rawnand: Provide a helper to get chip->data_buf
      mtd: rawnand: Move all page cache related fields to a sub-struct
      mtd: rawnand: Use nanddev_mtd_max_bad_blocks()
      mtd: rawnand: Get rid of chip->bits_per_cell
      mtd: rawnand: Get rid of chip->chipsize
      mtd: rawnand: Get rid of chip->numchips
      mtd: rawnand: Get rid of chip->ecc_{strength,step}_ds
      MAINTAINERS: Remove my name from the MTD and NAND entries

Chris Packham (3):
      mtd: maps: physmap: Store gpio_values correctly
      dt-binding: mtd: physmap: Add example using addr-gpios property
      mtd: maps: Allow MTD_PHYSMAP with MTD_RAM

Colin Ian King (1):
      mtd: part: fix incorrect format specifier for an unsigned long long

Fabio Estevam (1):
      mtd: rawnand: gpmi: Introduce GPMI_IS_MXS() macro

Frieder Schrempf (7):
      mtd: rawnand: Always store info about bad block markers in chip struct
      mtd: onenand: Store bad block marker position in chip struct
      mtd: nand: Cleanup flags and fields for bad block marker position
      mtd: nand: Make flags for bad block marker position more granular
      mtd: rawnand: Support bad block markers in first, second or last page
      mtd: rawnand: ESMT: Also use the last page for bad block markers
      mtd: rawnand: AMD: Also use the last page for bad block markers

Geert Uytterhoeven (1):
      mtd: spi-nor: Print all JEDEC ID bytes on error

Gustavo A. R. Silva (5):
      mtd: rawnand: Mark expected switch fall-throughs
      mtd: cfi_util: mark expected switch fall-throughs
      mtd: cfi_cmdset_0002: Mark expected switch fall-throughs
      mtd: phram: Mark expected switch fall-throughs
      mtd: lpddr_cmds: Mark expected switch fall-through

Jonas Bonn (1):
      spi-nor: s25fl512s supports region locking

Jonas Gorski (5):
      dt-bindings: mtd: describe the simple BCM963XX NOR flash layout
      mtd: bcm63xxpart: add of_match_table support
      mtd: bcm63xxpart: move imagetag parsing to its own parser
      dt-bindings: mtd: describe BCM963XX ImageTag format and usage
      mtd: parser_imagetag: add of_match_table support

Jonathan Neuschäfer (1):
      mtd: rawnand: Fix sphinx syntax

Liang Yang (1):
      mtd: rawnand: meson: set oob layout ops

Linus Walleij (9):
      mtd: afs: Move AFS partition parser to parsers subdir
      mtd: partitions: Add AFS partitions DT bindings
      mtd: partitions: Add OF support to AFS partitions
      mtd: afs: simplify partition parsing
      mtd: afs: simplify partition detection
      mtd: factor out v1 partition parsing
      mtd: afs: factor footer parsing into the v1 part parsing
      mtd: afs: factor the IIS read into partition parser
      mtd: afs: add v2 partition parsing

Marek Behún (3):
      mtd: rawnand: fsl_elbc: Cosmetic move
      mtd: rawnand: fsl_elbc: Implement RNDOUT command
      mtd: rawnand: fsl_elbc: Make SW ECC work

Martin Blumenstingl (6):
      mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
      mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf
      mtd: rawnand: meson: use struct_size macro
      mtd: rawnand: meson: use of_property_count_elems_of_size helper
      mtd: rawnand: meson: use a void pointer for meson_nfc_dma_buffer_setup
      mtd: rawnand: meson: only initialize the RB completion once

Masahiro Yamada (10):
      mtd: rawnand: denali: use more nand_chip pointers for internal functions
      mtd: rawnand: denali: refactor raw page accessors
      mtd: rawnand: denali: remove unneeded casts in denali_{read, write}_pio
      mtd: rawnand: denali: switch over to ->exec_op() from legacy hooks
      mtd: rawnand: denali: use bool type instead of int where appropriate
      mtd: rawnand: denali_pci: rename goto labels
      mtd: rawnand: denali: decouple controller and NAND chips
      mtd: rawnand: denali: remove DENALI_NR_BANKS macro
      mtd: rawnand: denali: clean up coding style
      mtd: rawnand: constify elements of NAND_OP_PARSER(_PATTERN)

Maxime Ripard (2):
      dt-bindings: mtd: Add YAML schemas for the generic NAND options
      dt-bindings: mtd: sunxi-nand: Add YAML schemas

Mika Westerberg (1):
      spi-nor: intel-spi: Add support for Intel Comet Lake SPI serial flash

Miquel Raynal (13):
      mtd: nand: omap: Fix comment in platform data using wrong Kconfig symbol
      mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm
      mtd: nand: Clarify Kconfig entry for software Hamming ECC entries
      mtd: rawnand: Change Kconfig titles and re-order a bit the list
      mtd: rawnand: Clarify Kconfig entry MTD_NAND
      mtd: nand: Remove useless line in Kconfig
      mtd: rawnand: atmel: Fix spelling mistake in error message
      dt-bindings: mtd: sunxi: Add new compatible
      mtd: rawnand: sunxi: Add a platform data structure
      mtd: rawnand: sunxi: Add A23/A33 DMA support
      mtd: rawnand: marvell: Fix helper name in comment
      MAINTAINERS: Add myself as MTD maintainer
      MAINTAINERS: MTD Git repository is hosted on kernel.org

Paul Cercueil (13):
      dt-bindings: mtd: ingenic: Add compatible strings for JZ4740 and JZ4725B
      dt-bindings: mtd: ingenic: Change 'BCH' to 'ECC' in documentation
      dt-bindings: mtd: ingenic: Use standard ecc-engine property
      mtd: rawnand: Move drivers for Ingenic SoCs to subfolder
      mtd: rawnand: ingenic: Use SPDX license notifiers
      mtd: rawnand: ingenic: Rename jz4780_nand driver to ingenic_nand
      mtd: rawnand: ingenic: Rename jz4780_bch_init to jz4780_bch_reset
      mtd: rawnand: ingenic: Separate top-level and SoC specific code
      mtd: rawnand: ingenic: Make use of ecc-engine property
      mtd: rawnand: ingenic: Add support for the JZ4740
      mtd: rawnand: ingenic: Add support for the JZ4725B
      mtd: rawnand: ingenic: Add ooblayout for the Qi Ben Nanonote
      mtd: rawnand: ingenic: Move BBTs out of ECC area

Richard Weinberger (5):
      mtd: nandsim: Embed struct nand_chip in struct nandsim
      mtd: nandsim: switch to exec_op interface
      Merge tag 'nand/for-5.2' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'spi-nor/for-5.2' of git://git.kernel.org/.../mtd/linux into mtd/next
      MAINTAINERS: Update jffs2 entry

Thomas Huth (1):
      mtd: maps: Make uclinux_ram_map static

Tudor Ambarus (8):
      ARM: at91: add sam9x60 SFR definitions
      memory: atmel-ebi: add generic name for ebi regmap
      dt-bindings: memory: atmel-ebi: add sam9x60 compatible
      memory: atmel-ebi: add sam9x60 EBI support
      mtd: rawnand: atmel: add generic name for EBICSA regmap
      dt-bindings: mtd: atmel-nand: add sam9x60 compatible
      mtd: rawnand: atmel: add sam9x60 nand controller support
      mtd: rawnand: atmel: switch to SPDX license identifiers

Vignesh Raghavendra (1):
      MAINTAINERS: Add myself as co-maintainer for MTD

YueHaibing (2):
      mtd: rawnand: ingenic: Add missing MODULE_* information
      mtd: rawnand: ingenic: Make jz4725b_ooblayout_ops static

 .../bindings/memory-controllers/atmel,ebi.txt      |    1 +
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   97 ++
 .../devicetree/bindings/mtd/atmel-nand.txt         |    1 +
 .../devicetree/bindings/mtd/denali-nand.txt        |   40 +-
 .../bindings/mtd/ingenic,jz4780-nand.txt           |   32 +-
 .../devicetree/bindings/mtd/mtd-physmap.txt        |   16 +
 .../devicetree/bindings/mtd/nand-controller.yaml   |  143 +++
 Documentation/devicetree/bindings/mtd/nand.txt     |   75 --
 .../mtd/partitions/arm,arm-firmware-suite.txt      |   17 +
 .../brcm,bcm963xx-cfe-nor-partitions.txt           |   24 +
 .../mtd/partitions/brcm,bcm963xx-imagetag.txt      |   45 +
 .../devicetree/bindings/mtd/sunxi-nand.txt         |   48 -
 MAINTAINERS                                        |   18 +-
 arch/arm/configs/at91_dt_defconfig                 |    2 +-
 arch/arm/configs/clps711x_defconfig                |    2 +-
 arch/arm/configs/cm_x2xx_defconfig                 |    2 +-
 arch/arm/configs/cm_x300_defconfig                 |    2 +-
 arch/arm/configs/colibri_pxa270_defconfig          |    2 +-
 arch/arm/configs/corgi_defconfig                   |    2 +-
 arch/arm/configs/davinci_all_defconfig             |    2 +-
 arch/arm/configs/em_x270_defconfig                 |    2 +-
 arch/arm/configs/ep93xx_defconfig                  |    2 +-
 arch/arm/configs/eseries_pxa_defconfig             |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |    2 +-
 arch/arm/configs/ixp4xx_defconfig                  |    2 +-
 arch/arm/configs/keystone_defconfig                |    2 +-
 arch/arm/configs/lpc32xx_defconfig                 |    2 +-
 arch/arm/configs/mini2440_defconfig                |    2 +-
 arch/arm/configs/mmp2_defconfig                    |    2 +-
 arch/arm/configs/multi_v4t_defconfig               |    2 +-
 arch/arm/configs/multi_v5_defconfig                |    2 +-
 arch/arm/configs/multi_v7_defconfig                |    2 +-
 arch/arm/configs/mv78xx0_defconfig                 |    2 +-
 arch/arm/configs/mvebu_v5_defconfig                |    2 +-
 arch/arm/configs/mvebu_v7_defconfig                |    2 +-
 arch/arm/configs/mxs_defconfig                     |    2 +-
 arch/arm/configs/nhk8815_defconfig                 |    4 +-
 arch/arm/configs/omap1_defconfig                   |    2 +-
 arch/arm/configs/omap2plus_defconfig               |    4 +-
 arch/arm/configs/orion5x_defconfig                 |    2 +-
 arch/arm/configs/oxnas_v6_defconfig                |    2 +-
 arch/arm/configs/pxa3xx_defconfig                  |    2 +-
 arch/arm/configs/pxa_defconfig                     |    4 +-
 arch/arm/configs/qcom_defconfig                    |    2 +-
 arch/arm/configs/s3c2410_defconfig                 |    2 +-
 arch/arm/configs/s3c6400_defconfig                 |    2 +-
 arch/arm/configs/sama5_defconfig                   |    2 +-
 arch/arm/configs/socfpga_defconfig                 |    2 +-
 arch/arm/configs/spear13xx_defconfig               |    2 +-
 arch/arm/configs/spear3xx_defconfig                |    2 +-
 arch/arm/configs/spear6xx_defconfig                |    2 +-
 arch/arm/configs/spitz_defconfig                   |    2 +-
 arch/arm/configs/tango4_defconfig                  |    2 +-
 arch/arm/configs/trizeps4_defconfig                |    2 +-
 arch/arm/configs/u300_defconfig                    |    2 +-
 arch/arm64/configs/defconfig                       |    2 +-
 arch/mips/configs/bcm47xx_defconfig                |    2 +-
 arch/mips/configs/ci20_defconfig                   |    2 +-
 arch/mips/configs/db1xxx_defconfig                 |    4 +-
 arch/mips/configs/generic/board-ni169445.config    |    6 +-
 arch/mips/configs/generic/board-ocelot.config      |    2 +-
 arch/mips/configs/loongson1b_defconfig             |    2 +-
 arch/mips/configs/loongson1c_defconfig             |    2 +-
 arch/mips/configs/qi_lb60_defconfig                |    2 +-
 arch/mips/configs/rb532_defconfig                  |    2 +-
 arch/mips/configs/rbtx49xx_defconfig               |    2 +-
 arch/mips/configs/xway_defconfig                   |    2 +-
 arch/powerpc/configs/40x/kilauea_defconfig         |    2 +-
 arch/powerpc/configs/40x/obs600_defconfig          |    2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig     |    2 +-
 arch/powerpc/configs/44x/eiger_defconfig           |    2 +-
 arch/powerpc/configs/44x/sequoia_defconfig         |    2 +-
 arch/powerpc/configs/44x/warp_defconfig            |    2 +-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    2 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    2 +-
 arch/powerpc/configs/85xx-hw.config                |    2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |    2 +-
 arch/powerpc/configs/85xx/socrates_defconfig       |    2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig        |    4 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    2 +-
 arch/powerpc/configs/86xx-hw.config                |    2 +-
 arch/powerpc/configs/mpc512x_defconfig             |    2 +-
 arch/powerpc/configs/mpc83xx_defconfig             |    2 +-
 arch/powerpc/configs/pasemi_defconfig              |    2 +-
 arch/powerpc/configs/ppc44x_defconfig              |    2 +-
 arch/sh/configs/ap325rxa_defconfig                 |    2 +-
 arch/sh/configs/ecovec24_defconfig                 |    2 +-
 arch/sh/configs/migor_defconfig                    |    2 +-
 arch/sh/configs/sdk7786_defconfig                  |    2 +-
 arch/sh/configs/se7724_defconfig                   |    2 +-
 arch/sh/configs/titan_defconfig                    |    2 +-
 drivers/memory/atmel-ebi.c                         |   37 +-
 drivers/mtd/Kconfig                                |   20 +-
 drivers/mtd/Makefile                               |    1 -
 drivers/mtd/afs.c                                  |  266 -----
 drivers/mtd/bcm63xxpart.c                          |  163 +--
 drivers/mtd/chips/cfi_cmdset_0002.c                |    2 +
 drivers/mtd/chips/cfi_util.c                       |    6 +
 drivers/mtd/devices/Kconfig                        |    2 +-
 drivers/mtd/devices/phram.c                        |    2 +
 drivers/mtd/lpddr/lpddr_cmds.c                     |    1 +
 drivers/mtd/maps/Kconfig                           |    2 +-
 drivers/mtd/maps/physmap-core.c                    |    2 +
 drivers/mtd/maps/physmap-gemini.c                  |    2 +-
 drivers/mtd/maps/uclinux.c                         |    8 +-
 drivers/mtd/mtdpart.c                              |    2 +-
 drivers/mtd/nand/Kconfig                           |    1 -
 drivers/mtd/nand/core.c                            |   34 +
 drivers/mtd/nand/onenand/onenand_base.c            |    5 +-
 drivers/mtd/nand/onenand/onenand_bbt.c             |    3 -
 drivers/mtd/nand/raw/Kconfig                       |  393 ++++---
 drivers/mtd/nand/raw/Makefile                      |    9 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c       |  127 ++-
 drivers/mtd/nand/raw/atmel/pmecc.c                 |    5 +-
 drivers/mtd/nand/raw/atmel/pmecc.h                 |    6 +-
 drivers/mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c   |    2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |    7 +-
 drivers/mtd/nand/raw/denali.c                      | 1152 ++++++++++----------
 drivers/mtd/nand/raw/denali.h                      |  117 +-
 drivers/mtd/nand/raw/denali_dt.c                   |   98 +-
 drivers/mtd/nand/raw/denali_pci.c                  |   38 +-
 drivers/mtd/nand/raw/diskonchip.c                  |    7 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c               |  201 ++--
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |    4 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c          |    6 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |   19 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h         |    1 +
 drivers/mtd/nand/raw/hisi504_nand.c                |    2 +-
 drivers/mtd/nand/raw/ingenic/Kconfig               |   50 +
 drivers/mtd/nand/raw/ingenic/Makefile              |    7 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c         |  166 +++
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   83 ++
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c        |  530 +++++++++
 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c         |  295 +++++
 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c          |  197 ++++
 drivers/mtd/nand/raw/{ => ingenic}/jz4740_nand.c   |    7 +-
 drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.c    |  182 +---
 drivers/mtd/nand/raw/internals.h                   |    3 +-
 drivers/mtd/nand/raw/jz4780_bch.h                  |   43 -
 drivers/mtd/nand/raw/jz4780_nand.c                 |  415 -------
 drivers/mtd/nand/raw/marvell_nand.c                |   51 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   30 +-
 drivers/mtd/nand/raw/mtk_nand.c                    |    4 +-
 drivers/mtd/nand/raw/nand_amd.c                    |   19 +-
 drivers/mtd/nand/raw/nand_base.c                   |  324 +++---
 drivers/mtd/nand/raw/nand_bbt.c                    |   73 +-
 drivers/mtd/nand/raw/nand_esmt.c                   |   19 +-
 drivers/mtd/nand/raw/nand_hynix.c                  |   94 +-
 drivers/mtd/nand/raw/nand_jedec.c                  |   27 +-
 drivers/mtd/nand/raw/nand_macronix.c               |    2 +-
 drivers/mtd/nand/raw/nand_micron.c                 |   16 +-
 drivers/mtd/nand/raw/nand_onfi.c                   |   35 +-
 drivers/mtd/nand/raw/nand_samsung.c                |   46 +-
 drivers/mtd/nand/raw/nand_toshiba.c                |   21 +-
 drivers/mtd/nand/raw/nandsim.c                     |  144 ++-
 drivers/mtd/nand/raw/nuc900_nand.c                 |    3 +-
 drivers/mtd/nand/raw/omap2.c                       |    4 +-
 drivers/mtd/nand/raw/omap_elm.c                    |    4 +
 drivers/mtd/nand/raw/qcom_nandc.c                  |    8 +-
 drivers/mtd/nand/raw/sh_flctl.c                    |   13 +-
 drivers/mtd/nand/raw/sunxi_nand.c                  |   90 +-
 drivers/mtd/nand/raw/tegra_nand.c                  |    8 +-
 drivers/mtd/nand/raw/vf610_nfc.c                   |    3 +
 drivers/mtd/nand/spi/core.c                        |  169 +--
 drivers/mtd/nand/spi/gigadevice.c                  |    8 +-
 drivers/mtd/nand/spi/macronix.c                    |    4 +-
 drivers/mtd/nand/spi/micron.c                      |    2 +-
 drivers/mtd/nand/spi/toshiba.c                     |   12 +-
 drivers/mtd/nand/spi/winbond.c                     |    4 +-
 drivers/mtd/parsers/Kconfig                        |   27 +
 drivers/mtd/parsers/Makefile                       |    2 +
 drivers/mtd/parsers/afs.c                          |  410 +++++++
 drivers/mtd/parsers/parser_imagetag.c              |  222 ++++
 drivers/mtd/sm_ftl.c                               |   12 +-
 drivers/mtd/spi-nor/intel-spi-pci.c                |    1 +
 drivers/mtd/spi-nor/intel-spi.c                    |    8 +
 drivers/mtd/spi-nor/spi-nor.c                      |   10 +-
 drivers/mtd/tests/mtd_nandecctest.c                |   16 +-
 include/linux/mtd/bbm.h                            |   14 +-
 include/linux/mtd/nand.h                           |   32 +-
 include/linux/mtd/nand_bch.h                       |    6 +-
 include/linux/mtd/onenand.h                        |    3 +
 include/linux/mtd/rawnand.h                        |  122 ++-
 include/linux/mtd/spinand.h                        |    7 +
 include/linux/platform_data/elm.h                  |    2 +-
 include/soc/at91/atmel-sfr.h                       |   34 +-
 187 files changed, 4763 insertions(+), 2862 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm963xx-cfe-nor-partitions.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/brcm,bcm963xx-imagetag.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt
 delete mode 100644 drivers/mtd/afs.c
 create mode 100644 drivers/mtd/nand/raw/ingenic/Kconfig
 create mode 100644 drivers/mtd/nand/raw/ingenic/Makefile
 create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
 create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
 create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_nand.c
 create mode 100644 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
 create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4740_nand.c (98%)
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.c (57%)
 delete mode 100644 drivers/mtd/nand/raw/jz4780_bch.h
 delete mode 100644 drivers/mtd/nand/raw/jz4780_nand.c
 create mode 100644 drivers/mtd/parsers/afs.c
 create mode 100644 drivers/mtd/parsers/parser_imagetag.c
