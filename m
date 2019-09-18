Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EDC21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568807232;
	bh=d4e7GowKxmmRHMX6UJsKQRD1I4cCJatVCg8LZj90qmw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Bat8eiwAxOFSu7bOp9tuQRRaK1fxLyoARFGov8JLjsJ2Negat756pmm7rasCHTA4Y
	 4RDh4M5pj87fS8EGXsnh9tU+xMgeZBsDLyQh3omvxo6bCaNUGjrT5srgvILaVx3jAh
	 wJNZCTTbvCFnofn/vizDLjbLfkcXVLArzO3DBPpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfIRLrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:47:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfIRLrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:47:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9AC21907;
        Wed, 18 Sep 2019 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568807227;
        bh=d4e7GowKxmmRHMX6UJsKQRD1I4cCJatVCg8LZj90qmw=;
        h=Date:From:To:Cc:Subject:From;
        b=RB1uUWvgInKC8lEMB37zBP9yKocBTqbaH2L8vTmEE6gWOFVq3gmzW/KvP+SV7DrZU
         7L5UQJ8ymU6fxESD4RdF9/RxEvGUyeMlL+pe7FWOcbYGqO2PC+4auAJS2WUdHECTIb
         dRJ3gkofCFeydDeuY8c3xmb0TjIP2p7sKUObM73M=
Date:   Wed, 18 Sep 2019 13:47:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB patches for 5.4-rc1
Message-ID: <20190918114705.GA1899329@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc1

for you to fetch changes up to fb9617edf6c0e1b86a6595cd92dd3f84595221d9:

  Merge tag 'usb-ci-v5.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next (2019-09-05 10:02:07 +0200)

----------------------------------------------------------------
USB changes for 5.4-rc1

Here is the big set of USB patches for 5.4-rc1.

Two major chunks of code are moving out of the tree and into the staging
directory, uwb and wusb (wireless USB support), because there are no
devices that actually use this protocol anymore, and what we have today
probably doesn't work at all given that the maintainers left many many
years ago.  So move it to staging where it will be removed in a few
releases if no one screams.

Other than that, lots of little things.  The usual gadget and xhci and
usb serial driver updates, along with a bunch of sysfs file cleanups due
to the driver core changes to support that.  Nothing really major, just
constant forward progress.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (4):
      usbfs: Add ioctls for runtime power management
      USB: usbfs: Add a capability flag for runtime suspend
      USB: rio500: Fix lockdep violation
      USB: usbcore: Fix slab-out-of-bounds bug during device reset

Andrey Smirnov (2):
      usb: dwc3: Use devres to get clocks
      usb: dwc3: Use clk_bulk_prepare_enable()

Andy Shevchenko (6):
      usb: dwc2: Switch to use device_property_count_u32()
      usb: dwc3: Switch to use device_property_count_u32()
      usb: typec: tcpm: Switch to use fwnode_property_count_uXX()
      usb: typec: mux: Switch to use fwnode_property_count_uXX()
      usb: dwc2: Switch to use device_property_count_u32()
      usb: dwc3: Switch to use device_property_count_u32()

Arnd Bergmann (1):
      usb: remove ehci-w90x900 driver

Benjamin Herrenschmidt (12):
      usb: gadget: aspeed: Don't set port enable change bit on reset
      usb: gadget: aspeed: Cleanup EP0 state on port reset
      usb: gadget: aspeed: Fix EP0 stall handling
      usb: gadget: aspeed: Don't reject requests on suspended devices
      usb: gadget: aspeed: Check suspend/resume callback existence
      usb: gadget: aspeed: Rework the reset logic
      usb: gadget: aspeed: Remove unused "suspended" flag
      usb: gadget: aspeed: Improve debugging when nuking
      usb: Add definitions for the USB2.0 hub TT requests
      usb: gadget: aspeed: Implement dummy hub TT requests
      usb: gadget: net2280: Move all "ll" registers in one structure
      usb: gadget: net2280: Add workaround for AB chip Errata 11

Christoph Hellwig (10):
      usb: add a HCD_DMA flag instead of guestimating DMA capabilities
      usb/max3421: remove the dummy {un,}map_urb_for_dma methods
      dma-mapping: remove is_device_dma_capable
      driver core: initialize a default DMA mask for platform device
      usb/ohci-sm501: remove the HCD_DMA flag
      usb/ohci-tmio: remove the HCD_DMA flag
      usb-storage: use hcd_uses_dma to check for DMA capabilities
      usb: remove a stale comment in hcd_alloc_coherent
      usb: remove commented out dma wrappers
      mfd: don't select DMA_DECLARE_COHERENT for the sm501 and tc6393xb drivers

Christophe JAILLET (2):
      usb: xhci: dbc: Simplify error handling in 'xhci_dbc_alloc_requests()'
      usb: xhci: dbc: Use GFP_KERNEL instead of GFP_ATOMIC in 'xhci_dbc_alloc_requests()'

Chuhong Yuan (4):
      USB: core: hcd-pci: Use dev_get_drvdata where possible
      usb: gadget: pch_udc: Use dev_get_drvdata
      usb: chipidea: msm: Use device-managed registration API
      usb: chipidea: msm: Use device-managed registration API

Chunfeng Yun (11):
      dt-bindings: usb: mtu3: fix typo of DMA clock name
      dt-bindings: usb: mtk-xhci: add an optional xhci_ck clock
      usb: xhci-mtk: add an optional xhci_ck clock
      dt-binding: usb: add usb-role-switch property
      dt-bindings: connector: add optional properties for Type-B
      dt-bindings: usb: add binding for USB GPIO based connection detection driver
      dt-bindings: usb: mtu3: add properties about USB Role Switch
      usb: roles: get usb-role-switch from parent
      usb: common: create Kconfig file
      usb: common: add USB GPIO based connection detection driver
      usb: mtu3: register a USB Role Switch for dual role mode

Colin Ian King (6):
      usb: chipidea: udc: remove redundant assignment to variable retval
      usb: musb: remove redundant assignment to variable ret
      USB: storage: isd200: remove redundant assignment to variable sendToTransport
      usb: cdns3: remove redundant assignment to ret on error exit path
      usb: cdns3: fix missing assignment of ret before error check on ret
      usb: cdns3: fix spelling mistake: "cnfiguration" -> "configuration"

Dan Carpenter (1):
      usb: host: ohci-pxa27x: Fix and & vs | typo

Dmitry Torokhov (1):
      driver core: add dev_groups to all drivers

Fuqian Huang (1):
      usb: host: Remove call to memset after dma_alloc_coherent

Gavin Li (1):
      usb: usbfs: only account once for mmap()'ed usb memory usage

Geert Uytterhoeven (1):
      usb: wusbcore: Spelling s/disconenct/disconnect/

Greg Kroah-Hartman (31):
      Merge 5.3-rc2 into usb-next
      Merge tag 'dev_groups_all_drivers' of git://git.kernel.org/.../gregkh/driver-core into usb-next
      USB: usbip: convert platform driver to use dev_groups
      USB: add support for dev_groups to struct usb_driver
      USB: add support for dev_groups to struct usb_device_driver
      USB: Move wusbcore and UWB to staging as it is obsolete
      USB: musb: convert platform driver to use dev_groups
      USB: typec: ucsi_ccg: convert i2c driver to use dev_groups
      MAINTAINERS: mark wusbcore and UWB as obsolete
      USB: phy: twl6030: convert platform driver to use dev_groups
      USB: phy: tahvo: convert platform driver to use dev_groups
      USB: phy: mv-usb: convert platform driver to use dev_groups
      USB: chipidea: convert platform driver to use dev_groups
      USB: lvstest: convert to use dev_groups
      USB: cypress_cy7c63: convert to use dev_groups
      USB: cytherm: convert to use dev_groups
      USB: usbtmc: convert to use dev_groups
      USB: usblp: convert to use dev_groups
      USB: ueagle-atm: convert to use dev_groups
      USB: atm: cxacru: convert to use dev_groups
      USB: usbip: convert to use dev_groups
      USB: trancevibrator: convert to use dev_groups
      USB: usbsevseg: convert to use dev_groups
      Merge 5.3-rc4 into usb-next
      USB: phy: fsl-usb: convert platform driver to use dev_groups
      Merge 5.3-rc5 into usb-next
      Merge tag 'usb-for-v5.4' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge 5.3-rc7 into usb-next
      Merge generic_lookup_helpers into usb-next
      Merge tag 'usb-serial-5.4-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'usb-ci-v5.4-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next

Gustavo A. R. Silva (7):
      usb: host: ohci-tmio: Mark expected switch fall-throughs
      usb: phy: ab8500-usb: Mark expected switch fall-throughs
      USB: gadget: udc: s3c2410_udc: Mark expected switch fall-throughs
      usb: gadget: atmel_usba_udc: Mark expected switch fall-through
      usb: gadget: atmel_usba_udc: Mark expected switch fall-through
      USB: gadget: udc: s3c2410_udc: Mark expected switch fall-throughs
      usb: udc: lpc32xx: silence fall-through warning

Hans de Goede (3):
      usb: typec: tcpm: Use usb_debug_root as root for our debugfs entry
      usb: typec: fusb302: Use usb_debug_root as root for our debugfs entry
      usb: typec: fusb302: Call fusb302_debugfs_init earlier

Heikki Krogerus (5):
      usb: typec: fusb302: Remove unused properties
      dt-bindings: usb: fusb302: Remove deprecated properties
      usb: typec: fusb302: Always provide fwnode for the port
      device connection: Add fwnode_connection_find_match()
      usb: roles: Add fwnode_usb_role_switch_get() function

Ikjoon Jang (1):
      xhci: fix possible memleak on setup address fails.

Jacob Huisman (1):
      usb: usb-skeleton: make comment block in line with coding style

John Keeping (1):
      usb: dwc2: gadget: Fix kill_all_requests race

Kai-Heng Feng (1):
      USB: Disable USB2 LPM at shutdown

Li Jun (1):
      usb: chipidea: add role switch class support

Liu, Changcheng (1):
      usbip: tools: fix GCC8 warning for strncpy

Mao Wenan (1):
      usb: udc: lpc32xx: remove set but not used 3 variables

Marek Szyprowski (6):
      dt-bindings: switch Exynos EHCI/OHCI bindings to use array of generic PHYs
      usb: exynos: add support for getting PHYs from the standard dt array
      ARM: dts: exynos: Use standard arrays of generic PHYs for EHCI/OHCI devices
      usb: dwc3: remove generic PHYs forwarding for XHCI device
      usb: core: phy: add support for PHY calibration
      usb: dwc3: remove generic PHY calibrate() calls

Masahiro Yamada (3):
      usb: host: oxu210hp-hcd: remove include/linux/oxu210hp.h
      usb: host: oxu210hp-hcd: squash oxu210hp.h into oxu210hp-hcd.c
      usb: dwc3: omap: squash include/linux/platform_data/dwc3-omap.h

Mathias Nyman (1):
      xhci: add TSP bitflag to TRB tracing

Matthew Michilot (1):
      USB: serial: ftdi_sio: add support for FT232H CBUS gpios

Matthias Maennich (1):
      usb-storage: remove single-use define for debugging

Miquel Raynal (1):
      usb: host: xhci-plat: Prevent an abnormally restrictive PHY init skipping

Neil Armstrong (1):
      usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables

Nishka Dasgupta (3):
      usb: dwc3: st: Add of_node_put() before return in probe function
      usb: dwc3: st: Add of_dev_put() in probe function
      usb: phy: phy-fsl-usb: Make structure fsl_otg_initdata constant

Oliver Neukum (1):
      USB: rio500: simplify locking

Pawel Laszczak (6):
      dt-bindings: add binding for USBSS-DRD controller.
      usb: common: Separated decoding functions from dwc3 driver.
      usb: common: Patch simplify usb_decode_set_clear_feature function.
      usb: common: Simplify usb_decode_get_set_descriptor function.
      usb: cdns3: Add Cadence USB3 DRD Driver
      usb:cdns3 Fix for stuck packets in on-chip OUT buffer.

Peter Chen (2):
      dt-binding: usb: ci-hdrc-usb2: add imx7ulp compatible
      dt-binding: usb: usbmisc-imx: add imx7ulp compatible

Roger Quadros (2):
      usb: dwc3: don't set gadget->is_otg flag
      usb: gadget: udc: core: Fix segfault if udc_bind_to_driver() for pending driver fails

Ruslan Bilovol (1):
      usb: host: xhci-hub: fix extra endianness conversion

Saranya Gopal (2):
      xhci-ext-caps.c: Add property to disable Intel SW switch
      usb: roles: intel: Enable static DRD mode for role switch

Simon Horman (1):
      dt-bindings: usb: renesas_gen3: Rename bindings documentation file to reflect IP block

Stephen Boyd (1):
      usb: Remove dev_err() usage after platform_get_irq()

Suwan Kim (1):
      usbip: Implement SG support to vhci-hcd and stub driver

Suzuki K Poulose (7):
      drivers: Introduce device lookup variants by name
      drivers: Introduce device lookup variants by of_node
      drivers: Introduce device lookup variants by fwnode
      drivers: Introduce device lookup variants by device type
      drivers: Introduce device lookup variants by ACPI_COMPANION device
      drivers: Add generic helper to match any device
      platform: Add platform_find_device_by_driver() helper

Thinh Nguyen (6):
      usb: dwc3: Update soft-reset wait polling rate
      usb: gadget: Export recommended BESL values
      usb: dwc3: Separate field holding multiple properties
      usb: dwc3: gadget: Set BESL config parameter
      usb: gadget: composite: Set recommended BESL values
      usb: dwc3: gadget: Workaround Mirosoft's BESL check

Wei Yongjun (1):
      usb: cdns3: Remove redundant dev_err call in cdns3_probe()

Yoshihiro Shimoda (3):
      usb: host: xhci-plat: add quirks member into struct xhci_plat_priv
      usb: host: xhci-rcar: Add a helper macro to set xhci_plat_priv
      usb: host: xhci-rcar: Use xhci_plat_priv.quirks instead of code settings

Yu Chen (1):
      usb: roles: Introduce stubs for the exiting functions in role.h

YueHaibing (8):
      usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
      usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
      usb: dwc3: omap: use devm_platform_ioremap_resource() to simplify code
      usb: dwc3: keystone: use devm_platform_ioremap_resource() to simplify code
      staging: wusbcore: Fix build error without CONFIG_USB
      usb: cdns3: Fix Wunused-but-set-variable warning
      usb: cdns3: remove set but not used variable 'priv_dev'
      usb: typec: tps6598x: Fix build error without CONFIG_REGMAP_I2C

 .../bindings/connector/usb-connector.txt           |   14 +
 .../devicetree/bindings/usb/cdns-usb3.txt          |   45 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    1 +
 .../devicetree/bindings/usb/exynos-usb.txt         |   41 +-
 .../devicetree/bindings/usb/fcs,fusb302.txt        |    7 -
 Documentation/devicetree/bindings/usb/generic.txt  |    4 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |    5 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   12 +-
 .../{renesas,usb3.txt => renesas,usb3-peri.txt}    |    0
 .../devicetree/bindings/usb/usb-conn-gpio.txt      |   30 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |    1 +
 MAINTAINERS                                        |   19 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   28 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    8 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |    9 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |    8 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    5 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    9 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   16 +-
 arch/arm/boot/dts/exynos54xx.dtsi                  |   18 +-
 arch/m68k/kernel/dma.c                             |    9 -
 arch/powerpc/kernel/setup-common.c                 |    6 -
 arch/sh/boards/mach-ap325rxa/setup.c               |    1 -
 arch/sh/boards/mach-ecovec24/setup.c               |    2 -
 arch/sh/boards/mach-kfr2r09/setup.c                |    1 -
 arch/sh/boards/mach-migor/setup.c                  |    1 -
 arch/sh/boards/mach-se/7724/setup.c                |    2 -
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    1 -
 drivers/amba/tegra-ahb.c                           |   11 +-
 drivers/base/bus.c                                 |   24 -
 drivers/base/core.c                                |   39 +-
 drivers/base/dd.c                                  |   14 +
 drivers/base/devcon.c                              |   51 +-
 drivers/base/platform.c                            |   51 +-
 drivers/fpga/fpga-bridge.c                         |    8 +-
 drivers/fpga/fpga-mgr.c                            |    8 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |    7 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    9 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    3 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    3 +-
 drivers/hwtracing/coresight/coresight-platform.c   |   11 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    2 -
 drivers/hwtracing/coresight/coresight.c            |    4 +-
 drivers/hwtracing/intel_th/core.c                  |   10 +-
 drivers/hwtracing/stm/core.c                       |    9 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |    8 +-
 drivers/i2c/i2c-core-acpi.c                        |   11 +-
 drivers/i2c/i2c-core-of.c                          |    7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |    8 +-
 drivers/iommu/arm-smmu-v3.c                        |    9 +-
 drivers/iommu/arm-smmu.c                           |    9 +-
 drivers/leds/led-class.c                           |    9 +-
 drivers/mfd/Kconfig                                |    2 -
 drivers/mfd/altera-sysmgr.c                        |   14 +-
 drivers/misc/mei/main.c                            |    9 +-
 drivers/mux/core.c                                 |    7 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |    8 +-
 drivers/net/phy/mdio_bus.c                         |    9 +-
 drivers/nvmem/core.c                               |    7 +-
 drivers/of/of_mdio.c                               |    8 +-
 drivers/of/platform.c                              |    7 +-
 drivers/pci/probe.c                                |    7 +-
 drivers/regulator/of_regulator.c                   |    7 +-
 drivers/rtc/interface.c                            |   11 +-
 drivers/s390/cio/ccwgroup.c                        |   18 +-
 drivers/s390/cio/device.c                          |   15 +-
 drivers/s390/crypto/zcrypt_api.c                   |   22 +-
 drivers/scsi/scsi_proc.c                           |    9 +-
 drivers/spi/spi.c                                  |   28 +-
 drivers/staging/Kconfig                            |    3 +
 drivers/staging/Makefile                           |    2 +
 drivers/staging/octeon-usb/octeon-hcd.c            |    2 +-
 drivers/{ => staging}/uwb/Kconfig                  |    0
 drivers/{ => staging}/uwb/Makefile                 |    0
 drivers/staging/uwb/TODO                           |    8 +
 drivers/{ => staging}/uwb/address.c                |    0
 drivers/{ => staging}/uwb/allocator.c              |    2 +-
 drivers/{ => staging}/uwb/beacon.c                 |    0
 drivers/{ => staging}/uwb/driver.c                 |    0
 drivers/{ => staging}/uwb/drp-avail.c              |    0
 drivers/{ => staging}/uwb/drp-ie.c                 |    2 +-
 drivers/{ => staging}/uwb/drp.c                    |    0
 drivers/{ => staging}/uwb/est.c                    |    0
 drivers/{ => staging}/uwb/hwa-rc.c                 |    6 +-
 drivers/{ => staging}/uwb/i1480/Makefile           |    0
 drivers/{ => staging}/uwb/i1480/dfu/Makefile       |    0
 drivers/{ => staging}/uwb/i1480/dfu/dfu.c          |    2 +-
 drivers/{ => staging}/uwb/i1480/dfu/i1480-dfu.h    |    2 +-
 drivers/{ => staging}/uwb/i1480/dfu/mac.c          |    2 +-
 drivers/{ => staging}/uwb/i1480/dfu/phy.c          |    2 +-
 drivers/{ => staging}/uwb/i1480/dfu/usb.c          |    6 +-
 drivers/{ => staging}/uwb/i1480/i1480-est.c        |    2 +-
 drivers/{ => staging}/uwb/ie-rcv.c                 |    0
 drivers/{ => staging}/uwb/ie.c                     |    0
 .../staging/uwb/include}/debug-cmd.h               |    0
 .../uwb => drivers/staging/uwb/include}/spec.h     |    0
 .../uwb => drivers/staging/uwb/include}/umc.h      |    0
 .../uwb => drivers/staging/uwb/include}/whci.h     |    0
 drivers/{ => staging}/uwb/lc-dev.c                 |    0
 drivers/{ => staging}/uwb/lc-rc.c                  |    0
 drivers/{ => staging}/uwb/neh.c                    |    0
 drivers/{ => staging}/uwb/pal.c                    |    2 +-
 drivers/{ => staging}/uwb/radio.c                  |    2 +-
 drivers/{ => staging}/uwb/reset.c                  |    0
 drivers/{ => staging}/uwb/rsv.c                    |    2 +-
 drivers/{ => staging}/uwb/scan.c                   |    0
 drivers/{ => staging}/uwb/umc-bus.c                |    2 +-
 drivers/{ => staging}/uwb/umc-dev.c                |    2 +-
 drivers/{ => staging}/uwb/umc-drv.c                |    2 +-
 drivers/{ => staging}/uwb/uwb-debug.c              |    3 +-
 drivers/{ => staging}/uwb/uwb-internal.h           |    2 +-
 {include/linux => drivers/staging/uwb}/uwb.h       |    2 +-
 drivers/{ => staging}/uwb/uwbd.c                   |    0
 drivers/{ => staging}/uwb/whc-rc.c                 |    6 +-
 drivers/{ => staging}/uwb/whci.c                   |    4 +-
 .../staging/wusbcore/Documentation}/wusb-cbaf      |    0
 .../Documentation}/wusb-design-overview.rst        |    0
 drivers/{usb => staging}/wusbcore/Kconfig          |    3 +-
 drivers/{usb => staging}/wusbcore/Makefile         |    2 +
 drivers/staging/wusbcore/TODO                      |    8 +
 drivers/{usb => staging}/wusbcore/cbaf.c           |    6 +-
 drivers/{usb => staging}/wusbcore/crypto.c         |    4 +-
 drivers/{usb => staging}/wusbcore/dev-sysfs.c      |    0
 drivers/{usb => staging}/wusbcore/devconnect.c     |    2 +-
 drivers/staging/wusbcore/host/Kconfig              |   28 +
 drivers/staging/wusbcore/host/Makefile             |    3 +
 drivers/{usb => staging/wusbcore}/host/hwa-hc.c    |    4 +-
 .../{usb => staging/wusbcore}/host/whci/Makefile   |    0
 drivers/{usb => staging/wusbcore}/host/whci/asl.c  |    4 +-
 .../{usb => staging/wusbcore}/host/whci/debug.c    |    2 +-
 drivers/{usb => staging/wusbcore}/host/whci/hcd.c  |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/hw.c   |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/init.c |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/int.c  |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/pzl.c  |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/qset.c |    4 +-
 drivers/{usb => staging/wusbcore}/host/whci/whcd.h |    4 +-
 .../{usb => staging/wusbcore}/host/whci/whci-hc.h  |    0
 drivers/{usb => staging/wusbcore}/host/whci/wusb.c |    4 +-
 .../staging/wusbcore/include}/association.h        |    0
 .../staging/wusbcore/include}/wusb-wa.h            |    0
 .../staging/wusbcore/include}/wusb.h               |    2 +-
 drivers/{usb => staging}/wusbcore/mmc.c            |    2 +-
 drivers/{usb => staging}/wusbcore/pal.c            |    0
 drivers/{usb => staging}/wusbcore/reservation.c    |    2 +-
 drivers/{usb => staging}/wusbcore/rh.c             |    0
 drivers/{usb => staging}/wusbcore/security.c       |    0
 drivers/{usb => staging}/wusbcore/wa-hc.c          |    0
 drivers/{usb => staging}/wusbcore/wa-hc.h          |    6 +-
 drivers/{usb => staging}/wusbcore/wa-nep.c         |    0
 drivers/{usb => staging}/wusbcore/wa-rpipe.c       |    0
 drivers/{usb => staging}/wusbcore/wa-xfer.c        |    0
 drivers/{usb => staging}/wusbcore/wusbhc.c         |    0
 drivers/{usb => staging}/wusbcore/wusbhc.h         |    4 +-
 drivers/tty/tty_io.c                               |    8 +-
 drivers/usb/Kconfig                                |   39 +-
 drivers/usb/Makefile                               |    4 +-
 drivers/usb/atm/cxacru.c                           |   58 +-
 drivers/usb/atm/ueagle-atm.c                       |   16 +-
 drivers/usb/cdns3/Kconfig                          |   46 +
 drivers/usb/cdns3/Makefile                         |   16 +
 drivers/usb/cdns3/cdns3-pci-wrap.c                 |  203 ++
 drivers/usb/cdns3/core.c                           |  651 +++++
 drivers/usb/cdns3/core.h                           |   98 +
 drivers/usb/cdns3/debug.h                          |  161 ++
 drivers/usb/cdns3/drd.c                            |  381 +++
 drivers/usb/cdns3/drd.h                            |  167 ++
 drivers/usb/cdns3/ep0.c                            |  886 +++++++
 drivers/usb/cdns3/gadget-export.h                  |   28 +
 drivers/usb/cdns3/gadget.c                         | 2744 ++++++++++++++++++++
 drivers/usb/cdns3/gadget.h                         | 1338 ++++++++++
 drivers/usb/cdns3/host-export.h                    |   28 +
 drivers/usb/cdns3/host.c                           |   74 +
 drivers/usb/cdns3/trace.c                          |   11 +
 drivers/usb/cdns3/trace.h                          |  493 ++++
 drivers/usb/chipidea/Kconfig                       |    1 +
 drivers/usb/chipidea/ci.h                          |   12 +
 drivers/usb/chipidea/ci_hdrc_msm.c                 |    9 +-
 drivers/usb/chipidea/core.c                        |   97 +-
 drivers/usb/chipidea/otg.c                         |    8 +-
 drivers/usb/chipidea/udc.c                         |    3 +-
 drivers/usb/class/usblp.c                          |   13 +-
 drivers/usb/class/usbtmc.c                         |   13 +-
 drivers/usb/common/Kconfig                         |   51 +
 drivers/usb/common/Makefile                        |    2 +
 drivers/usb/common/debug.c                         |  268 ++
 drivers/usb/common/usb-conn-gpio.c                 |  284 ++
 drivers/usb/core/config.c                          |   12 +-
 drivers/usb/core/devio.c                           |  116 +-
 drivers/usb/core/driver.c                          |    2 +
 drivers/usb/core/generic.c                         |    5 +
 drivers/usb/core/hcd-pci.c                         |    3 +-
 drivers/usb/core/hcd.c                             |   11 +-
 drivers/usb/core/phy.c                             |   21 +
 drivers/usb/core/phy.h                             |    1 +
 drivers/usb/core/port.c                            |    9 +
 drivers/usb/core/usb.c                             |  222 --
 drivers/usb/core/usb.h                             |    3 +
 drivers/usb/dwc2/gadget.c                          |    9 +-
 drivers/usb/dwc2/hcd.c                             |    6 +-
 drivers/usb/dwc2/params.c                          |    5 +-
 drivers/usb/dwc2/platform.c                        |    4 +-
 drivers/usb/dwc3/core.c                            |   61 +-
 drivers/usb/dwc3/core.h                            |    2 +
 drivers/usb/dwc3/debug.h                           |  252 --
 drivers/usb/dwc3/dwc3-keystone.c                   |    5 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   18 +-
 drivers/usb/dwc3/dwc3-omap.c                       |   15 +-
 drivers/usb/dwc3/dwc3-st.c                         |   10 +-
 drivers/usb/dwc3/gadget.c                          |   24 +-
 drivers/usb/dwc3/host.c                            |   22 +-
 drivers/usb/dwc3/trace.h                           |    2 +-
 drivers/usb/gadget/composite.c                     |   38 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |    7 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |   80 +-
 drivers/usb/gadget/udc/aspeed-vhub/ep0.c           |   59 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |    2 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |   15 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |    3 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    1 +
 drivers/usb/gadget/udc/bcm63xx_udc.c               |    8 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |    4 +-
 drivers/usb/gadget/udc/core.c                      |    2 +-
 drivers/usb/gadget/udc/gr_udc.c                    |    8 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   14 +-
 drivers/usb/gadget/udc/net2280.c                   |   38 +-
 drivers/usb/gadget/udc/net2280.h                   |    3 -
 drivers/usb/gadget/udc/pch_udc.c                   |    3 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |    4 +-
 drivers/usb/gadget/udc/s3c-hsudc.c                 |    4 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |    2 +
 drivers/usb/gadget/udc/udc-xilinx.c                |    4 +-
 drivers/usb/host/Kconfig                           |   32 -
 drivers/usb/host/Makefile                          |    4 -
 drivers/usb/host/ehci-atmel.c                      |    3 -
 drivers/usb/host/ehci-exynos.c                     |   23 +-
 drivers/usb/host/ehci-grlib.c                      |    2 +-
 drivers/usb/host/ehci-hcd.c                        |    2 +-
 drivers/usb/host/ehci-omap.c                       |    4 +-
 drivers/usb/host/ehci-orion.c                      |    3 -
 drivers/usb/host/ehci-platform.c                   |    4 +-
 drivers/usb/host/ehci-pmcmsp.c                     |    2 +-
 drivers/usb/host/ehci-ppc-of.c                     |    2 +-
 drivers/usb/host/ehci-ps3.c                        |    2 +-
 drivers/usb/host/ehci-sh.c                         |    5 +-
 drivers/usb/host/ehci-st.c                         |    4 +-
 drivers/usb/host/ehci-w90x900.c                    |  130 -
 drivers/usb/host/ehci-xilinx-of.c                  |    2 +-
 drivers/usb/host/fhci-hcd.c                        |    2 +-
 drivers/usb/host/fotg210-hcd.c                     |    2 +-
 drivers/usb/host/imx21-hcd.c                       |    6 +-
 drivers/usb/host/isp116x-hcd.c                     |    6 -
 drivers/usb/host/isp1362-hcd.c                     |    5 -
 drivers/usb/host/max3421-hcd.c                     |   17 -
 drivers/usb/host/ohci-exynos.c                     |   23 +-
 drivers/usb/host/ohci-hcd.c                        |    2 +-
 drivers/usb/host/ohci-platform.c                   |    4 +-
 drivers/usb/host/ohci-ppc-of.c                     |    2 +-
 drivers/usb/host/ohci-ps3.c                        |    2 +-
 drivers/usb/host/ohci-pxa27x.c                     |    2 +-
 drivers/usb/host/ohci-sa1111.c                     |    2 +-
 drivers/usb/host/ohci-st.c                         |    4 +-
 drivers/usb/host/ohci-tmio.c                       |    3 +
 drivers/usb/host/oxu210hp-hcd.c                    |  446 +++-
 drivers/usb/host/oxu210hp.h                        |  448 ----
 drivers/usb/host/r8a66597-hcd.c                    |    6 -
 drivers/usb/host/sl811-hcd.c                       |    6 -
 drivers/usb/host/u132-hcd.c                        |    2 -
 drivers/usb/host/uhci-grlib.c                      |    2 +-
 drivers/usb/host/uhci-pci.c                        |    2 +-
 drivers/usb/host/uhci-platform.c                   |    2 +-
 drivers/usb/host/xhci-dbgcap.c                     |    1 -
 drivers/usb/host/xhci-dbgtty.c                     |    4 +-
 drivers/usb/host/xhci-ext-caps.c                   |   18 +
 drivers/usb/host/xhci-hub.c                        |    2 +-
 drivers/usb/host/xhci-mem.c                        |    1 -
 drivers/usb/host/xhci-mtk.c                        |   13 +
 drivers/usb/host/xhci-mtk.h                        |    1 +
 drivers/usb/host/xhci-plat.c                       |   15 +-
 drivers/usb/host/xhci-plat.h                       |    2 +
 drivers/usb/host/xhci-rcar.c                       |   28 -
 drivers/usb/host/xhci-rcar.h                       |   21 +
 drivers/usb/host/xhci.c                            |    5 +-
 drivers/usb/host/xhci.h                            |    3 +-
 drivers/usb/isp1760/isp1760-core.c                 |    3 -
 drivers/usb/isp1760/isp1760-if.c                   |    1 -
 drivers/usb/misc/cypress_cy7c63.c                  |   29 +-
 drivers/usb/misc/cytherm.c                         |   64 +-
 drivers/usb/misc/lvstest.c                         |   19 +-
 drivers/usb/misc/rio500.c                          |  109 +-
 drivers/usb/misc/trancevibrator.c                  |   15 +-
 drivers/usb/misc/usbsevseg.c                       |   17 +-
 drivers/usb/mtu3/Kconfig                           |    1 +
 drivers/usb/mtu3/mtu3.h                            |    5 +
 drivers/usb/mtu3/mtu3_core.c                       |    4 +-
 drivers/usb/mtu3/mtu3_debugfs.c                    |    4 +-
 drivers/usb/mtu3/mtu3_dr.c                         |   48 +-
 drivers/usb/mtu3/mtu3_dr.h                         |    6 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    3 +-
 drivers/usb/musb/musb_core.c                       |   24 +-
 drivers/usb/musb/musb_host.c                       |    2 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |   18 +-
 drivers/usb/phy/phy-fsl-usb.c                      |   14 +-
 drivers/usb/phy/phy-mv-usb.c                       |   17 +-
 drivers/usb/phy/phy-tahvo.c                        |   18 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   12 +-
 drivers/usb/renesas_usbhs/mod_host.c               |    2 +-
 drivers/usb/roles/class.c                          |   57 +-
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |   27 +-
 drivers/usb/serial/ftdi_sio.c                      |   43 +
 drivers/usb/storage/debug.h                        |    2 -
 drivers/usb/storage/isd200.c                       |    2 +-
 drivers/usb/storage/scsiglue.c                     |    8 +-
 drivers/usb/typec/Kconfig                          |    1 +
 drivers/usb/typec/class.c                          |   16 +-
 drivers/usb/typec/mux.c                            |    2 +-
 drivers/usb/typec/tcpm/fusb302.c                   |  101 +-
 drivers/usb/typec/tcpm/tcpm.c                      |   23 +-
 drivers/usb/typec/tcpm/wcove.c                     |    4 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   13 +-
 drivers/usb/usb-skeleton.c                         |    8 +-
 drivers/usb/usbip/stub.h                           |    7 +-
 drivers/usb/usbip/stub_dev.c                       |   50 +-
 drivers/usb/usbip/stub_main.c                      |   57 +-
 drivers/usb/usbip/stub_rx.c                        |  204 +-
 drivers/usb/usbip/stub_tx.c                        |   99 +-
 drivers/usb/usbip/usbip_common.c                   |   59 +-
 drivers/usb/usbip/vhci_hcd.c                       |   12 +-
 drivers/usb/usbip/vhci_rx.c                        |    3 +
 drivers/usb/usbip/vhci_tx.c                        |   66 +-
 drivers/usb/usbip/vudc.h                           |    2 +-
 drivers/usb/usbip/vudc_dev.c                       |    9 -
 drivers/usb/usbip/vudc_main.c                      |    1 +
 drivers/usb/usbip/vudc_sysfs.c                     |    7 +-
 include/linux/device.h                             |  250 +-
 include/linux/dma-mapping.h                        |    5 -
 include/linux/oxu210hp.h                           |    8 -
 include/linux/platform_data/dwc3-omap.h            |   43 -
 include/linux/platform_device.h                    |    5 +-
 include/linux/usb.h                                |    7 +-
 include/linux/usb/ch9.h                            |   27 +
 include/linux/usb/gadget.h                         |    3 +
 include/linux/usb/hcd.h                            |   11 +-
 include/linux/usb/role.h                           |   37 +
 include/linux/usb/usb338x.h                        |   35 +-
 include/uapi/linux/usb/ch9.h                       |    2 +
 include/uapi/linux/usbdevice_fs.h                  |    4 +
 net/ieee802154/core.c                              |    7 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |    9 +-
 tools/usb/usbip/libsrc/usbip_common.c              |    6 +-
 tools/usb/usbip/libsrc/usbip_device_driver.c       |    6 +-
 353 files changed, 10647 insertions(+), 2825 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 rename Documentation/devicetree/bindings/usb/{renesas,usb3.txt => renesas,usb3-peri.txt} (100%)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
 rename drivers/{ => staging}/uwb/Kconfig (100%)
 rename drivers/{ => staging}/uwb/Makefile (100%)
 create mode 100644 drivers/staging/uwb/TODO
 rename drivers/{ => staging}/uwb/address.c (100%)
 rename drivers/{ => staging}/uwb/allocator.c (99%)
 rename drivers/{ => staging}/uwb/beacon.c (100%)
 rename drivers/{ => staging}/uwb/driver.c (100%)
 rename drivers/{ => staging}/uwb/drp-avail.c (100%)
 rename drivers/{ => staging}/uwb/drp-ie.c (99%)
 rename drivers/{ => staging}/uwb/drp.c (100%)
 rename drivers/{ => staging}/uwb/est.c (100%)
 rename drivers/{ => staging}/uwb/hwa-rc.c (99%)
 rename drivers/{ => staging}/uwb/i1480/Makefile (100%)
 rename drivers/{ => staging}/uwb/i1480/dfu/Makefile (100%)
 rename drivers/{ => staging}/uwb/i1480/dfu/dfu.c (99%)
 rename drivers/{ => staging}/uwb/i1480/dfu/i1480-dfu.h (99%)
 rename drivers/{ => staging}/uwb/i1480/dfu/mac.c (99%)
 rename drivers/{ => staging}/uwb/i1480/dfu/phy.c (99%)
 rename drivers/{ => staging}/uwb/i1480/dfu/usb.c (99%)
 rename drivers/{ => staging}/uwb/i1480/i1480-est.c (99%)
 rename drivers/{ => staging}/uwb/ie-rcv.c (100%)
 rename drivers/{ => staging}/uwb/ie.c (100%)
 rename {include/linux/uwb => drivers/staging/uwb/include}/debug-cmd.h (100%)
 rename {include/linux/uwb => drivers/staging/uwb/include}/spec.h (100%)
 rename {include/linux/uwb => drivers/staging/uwb/include}/umc.h (100%)
 rename {include/linux/uwb => drivers/staging/uwb/include}/whci.h (100%)
 rename drivers/{ => staging}/uwb/lc-dev.c (100%)
 rename drivers/{ => staging}/uwb/lc-rc.c (100%)
 rename drivers/{ => staging}/uwb/neh.c (100%)
 rename drivers/{ => staging}/uwb/pal.c (99%)
 rename drivers/{ => staging}/uwb/radio.c (99%)
 rename drivers/{ => staging}/uwb/reset.c (100%)
 rename drivers/{ => staging}/uwb/rsv.c (99%)
 rename drivers/{ => staging}/uwb/scan.c (100%)
 rename drivers/{ => staging}/uwb/umc-bus.c (99%)
 rename drivers/{ => staging}/uwb/umc-dev.c (98%)
 rename drivers/{ => staging}/uwb/umc-drv.c (96%)
 rename drivers/{ => staging}/uwb/uwb-debug.c (99%)
 rename drivers/{ => staging}/uwb/uwb-internal.h (99%)
 rename {include/linux => drivers/staging/uwb}/uwb.h (99%)
 rename drivers/{ => staging}/uwb/uwbd.c (100%)
 rename drivers/{ => staging}/uwb/whc-rc.c (99%)
 rename drivers/{ => staging}/uwb/whci.c (99%)
 rename {Documentation/usb => drivers/staging/wusbcore/Documentation}/wusb-cbaf (100%)
 rename {Documentation/usb => drivers/staging/wusbcore/Documentation}/wusb-design-overview.rst (100%)
 rename drivers/{usb => staging}/wusbcore/Kconfig (93%)
 rename drivers/{usb => staging}/wusbcore/Makefile (96%)
 create mode 100644 drivers/staging/wusbcore/TODO
 rename drivers/{usb => staging}/wusbcore/cbaf.c (99%)
 rename drivers/{usb => staging}/wusbcore/crypto.c (99%)
 rename drivers/{usb => staging}/wusbcore/dev-sysfs.c (100%)
 rename drivers/{usb => staging}/wusbcore/devconnect.c (99%)
 create mode 100644 drivers/staging/wusbcore/host/Kconfig
 create mode 100644 drivers/staging/wusbcore/host/Makefile
 rename drivers/{usb => staging/wusbcore}/host/hwa-hc.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/Makefile (100%)
 rename drivers/{usb => staging/wusbcore}/host/whci/asl.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/debug.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/hcd.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/hw.c (97%)
 rename drivers/{usb => staging/wusbcore}/host/whci/init.c (98%)
 rename drivers/{usb => staging/wusbcore}/host/whci/int.c (96%)
 rename drivers/{usb => staging/wusbcore}/host/whci/pzl.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/qset.c (99%)
 rename drivers/{usb => staging/wusbcore}/host/whci/whcd.h (98%)
 rename drivers/{usb => staging/wusbcore}/host/whci/whci-hc.h (100%)
 rename drivers/{usb => staging/wusbcore}/host/whci/wusb.c (98%)
 rename {include/linux/usb => drivers/staging/wusbcore/include}/association.h (100%)
 rename {include/linux/usb => drivers/staging/wusbcore/include}/wusb-wa.h (100%)
 rename {include/linux/usb => drivers/staging/wusbcore/include}/wusb.h (99%)
 rename drivers/{usb => staging}/wusbcore/mmc.c (99%)
 rename drivers/{usb => staging}/wusbcore/pal.c (100%)
 rename drivers/{usb => staging}/wusbcore/reservation.c (99%)
 rename drivers/{usb => staging}/wusbcore/rh.c (100%)
 rename drivers/{usb => staging}/wusbcore/security.c (100%)
 rename drivers/{usb => staging}/wusbcore/wa-hc.c (100%)
 rename drivers/{usb => staging}/wusbcore/wa-hc.h (99%)
 rename drivers/{usb => staging}/wusbcore/wa-nep.c (100%)
 rename drivers/{usb => staging}/wusbcore/wa-rpipe.c (100%)
 rename drivers/{usb => staging}/wusbcore/wa-xfer.c (100%)
 rename drivers/{usb => staging}/wusbcore/wusbhc.c (100%)
 rename drivers/{usb => staging}/wusbcore/wusbhc.h (99%)
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h
 create mode 100644 drivers/usb/common/Kconfig
 create mode 100644 drivers/usb/common/debug.c
 create mode 100644 drivers/usb/common/usb-conn-gpio.c
 delete mode 100644 drivers/usb/host/ehci-w90x900.c
 delete mode 100644 drivers/usb/host/oxu210hp.h
 delete mode 100644 include/linux/oxu210hp.h
 delete mode 100644 include/linux/platform_data/dwc3-omap.h
