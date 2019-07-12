Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246FC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F520863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562916990;
	bh=+oGT3LSFTy1vXGyPRf5LW76f0O7BwTCRGLmZqFXahRM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hKnBpCoiXB7RZA4LuDsQjDWSGQwIfpC3fB3iMYay6k4f26fGk+Yt2EcR3kBhO7OLt
	 1DDneHk7HMnw+nFg7D9tfYWTk8i461rFE4FVpykKdWpj1IvA17fwEhNYwc37zc9vix
	 vQFvZg/ANUVlE7KcH8Rh6JrSiF+SsVwD73VV2oqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGLHg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfGLHg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:36:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E206B20863;
        Fri, 12 Jul 2019 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562916986;
        bh=+oGT3LSFTy1vXGyPRf5LW76f0O7BwTCRGLmZqFXahRM=;
        h=Date:From:To:Cc:Subject:From;
        b=V6+cFwcCyxE1LmbiLgvgq+qdZPW7pJw7awKC3d107FJfuley1la/DG4GYWHtyuNRB
         kZFUTglIGMhqY/VlUtpHsqNmM04+hPQ5oEoQe9+Hj3bnN/tf6qzXxKP/TDYLTT3Rp2
         c1OZRvIUGWYIW3u+8Flw3Cr+PzKGE6qmeFePYg34=
Date:   Fri, 12 Jul 2019 09:36:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.3-rc1
Message-ID: <20190712073623.GA16253@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc1

for you to fetch changes up to c33d442328f556460b79aba6058adb37bb555389:

  debugfs: make error message a bit more verbose (2019-07-08 10:44:57 +0200)

----------------------------------------------------------------
Driver Core and debugfs changes for 5.3-rc1

Here is the "big" driver core and debugfs changes for 5.3-rc1

It's a lot of different patches, all across the tree due to some api
changes and lots of debugfs cleanups.  Because of this, there is going
to be some merge issues with your tree at the moment, I'll follow up
with the expected resolutions to make it easier for you.

Other than the debugfs cleanups, in this set of changes we have:
	- bus iteration function cleanups (will cause build warnings
	  with s390 and coresight drivers in your tree)
	- scripts/get_abi.pl tool to display and parse Documentation/ABI
	  entries in a simple way
	- cleanups to Documenatation/ABI/ entries to make them parse
	  easier due to typos and other minor things
	- default_attrs use for some ktype users
	- driver model documentation file conversions to .rst
	- compressed firmware file loading
	- deferred probe fixes

All of these have been in linux-next for a while, with a bunch of merge
issues that Stephen has been patient with me for.  Other than the merge
issues, functionality is working properly in linux-next :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anders Roxell (1):
      mm/zsmalloc.c: remove unused variable

Arnd Bergmann (1):
      ARM: omap1: remove unused variable

Colin Ian King (1):
      lkdtm: remove redundant initialization of ret

Geert Uytterhoeven (2):
      tools/firmware: Add missing newline at end of file
      arch_topology: Remove error messages on out-of-memory conditions

Greg Kroah-Hartman (53):
      zswap: ignore debugfs_create_dir() return value
      trace: no need to check return value of debugfs_create functions
      blktrace: no need to check return value of debugfs_create functions
      zsmalloc: no need to check return value of debugfs_create functions
      mm: kmemleak: no need to check return value of debugfs_create functions
      hwpoison-inject: no need to check return value of debugfs_create functions
      sh: no need to check return value of debugfs_create functions
      fail_function: no need to check return value of debugfs_create functions
      kprobes: no need to check return value of debugfs_create functions
      mm: cleancache: no need to check return value of debugfs_create functions
      backing-dev: no need to check return value of debugfs_create functions
      x86: xen: no need to check return value of debugfs_create functions
      arm: omap1: no need to check return value of debugfs_create functions
      arm: omap2: no need to check return value of debugfs_create functions
      arm: dump: no need to check return value of debugfs_create functions
      x86: mm: no need to check return value of debugfs_create functions
      x86: platform: no need to check return value of debugfs_create functions
      x86: kdebugfs: no need to check return value of debugfs_create functions
      gcov: no need to check return value of debugfs_create functions
      mailbox: no need to check return value of debugfs_create functions
      btrfs: no need to check return value of debugfs_create functions
      debugfs: make debugfs_create_u32_array() return void
      vmw_balloon: no need to check return value of debugfs_create functions
      lkdtm: no need to check return value of debugfs_create functions
      ti-st: no need to check return value of debugfs_create functions
      thermal: intel: no need to check return value of debugfs_create functions
      thermal: intel_powerclamp: no need to check return value of debugfs_create functions
      thermal: tegra: no need to check return value of debugfs_create functions
      cxl: no need to check return value of debugfs_create functions
      lib: dynamic_debug: no need to check return value of debugfs_create functions
      fault-inject: clean up debugfs file creation logic
      mic: no need to check return value of debugfs_create functions
      genwq: no need to check return value of debugfs_create functions
      mei: no need to check return value of debugfs_create functions
      coresight: cpu-debug: no need to check return value of debugfs_create functions
      watchdog: mei_wdt: no need to check return value of debugfs_create functions
      watchdog: bcm_kona_wdt: no need to check return value of debugfs_create functions
      6lowpan: no need to check return value of debugfs_create functions
      power: avs: smartreflex: no need to check return value of debugfs_create functions
      thermal: bcm2835: no need to check return value of debugfs_create functions
      debugfs: log errors when something goes wrong
      debugfs: provide pr_fmt() macro
      lib: 842: no need to check return value of debugfs_create functions
      nfsd: no need to check return value of debugfs_create functions
      orangefs: no need to check return value of debugfs_create functions
      ubifs: no need to check return value of debugfs_create functions
      sunrpc: no need to check return value of debugfs_create functions
      ceph: no need to check return value of debugfs_create functions
      swiotlb: no need to check return value of debugfs_create functions
      lib: notifier-error-inject: no need to check return value of debugfs_create functions
      ubifs: fix build warning after debugfs cleanup patch
      orangefs: fix build warning from debugfs cleanup patch
      debugfs: make error message a bit more verbose

James Morse (1):
      drivers: base: cacheinfo: Ensure cpu hotplug work is done before Intel RDT

Kimberly Brown (5):
      gfs2: replace ktype default_attrs with default_groups
      ext4: replace ktype default_attrs with default_groups
      dlm: Replace default_attrs in dlm_ktype with default_groups
      f2fs: replace ktype default_attrs with default_groups
      btrfs: sysfs: Replace default_attrs in ktypes with groups

Lin Yi (1):
      lib : kobject: fix refcount imblance on kobject_rename

Mauro Carvalho Chehab (20):
      ABI: fix some syntax issues at the ABI database
      ABI: sysfs-driver-hid: the "What" field doesn't parse fine
      ABI: sysfs-class-uwb_rc: remove a duplicated incomplete entry
      ABI: better identificate tables
      ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
      ABI: Fix KernelVersion tags
      drivers: base/node.c: fixes a kernel-doc markups
      docs: driver-model: convert docs to ReST and rename to *.rst
      scripts: add an script to parse the ABI files
      scripts/get_abi.pl: parse files with text at beginning
      scripts/get_abi.pl: avoid use literal blocks when not needed
      scripts/get_abi.pl: split label naming from xref logic
      scripts/get_abi.pl: add support for searching for ABI symbols
      scripts/get_abi.pl: represent what in tables
      scripts/get_abi.pl: fix parse issues with some files
      scripts/get_abi.pl: avoid creating duplicate names
      scripts/get_abi.pl: add a handler for invalid "where" tag
      scripts/get_abi.pl: add a validate command
      doc: ABI scripts: add a SPDX header file
      ABI: sysfs-driver-mlxreg-io: fix the what fields

Nishad Kamdar (2):
      firmware: ti_sci: Use the correct style for SPDX License Identifier
      firmware: arm_scmi: Use the correct style for SPDX License Identifier

Suzuki K Poulose (7):
      staging: most-core: Use bus_find_device_by_name
      mfd: Remove unused helper syscon_regmap_lookup_by_pdevname
      acpi: utils: Cleanup acpi_dev_match_cb
      bus_find_device: Unify the match callback with class_find_device
      driver_find_device: Unify the match function with class_find_device()
      drivers: Add generic helper to match by of_node
      drivers: s390/cio: Fix compilation warning about const qualifiers

Sven Van Asbroeck (1):
      firmware: improve LSM/IMA security behaviour

Takashi Iwai (6):
      firmware: Free temporary page table after vmapping
      firmware: Unify the paged buffer release helper
      firmware: Use kvmalloc for page tables
      firmware: Factor out the paged buffer handling code
      firmware: Add support for loading compressed files
      selftests: firmware: Add compressed firmware tests

Thierry Reding (1):
      driver: core: Allow subsystems to continue deferring probe

 .../ABI/obsolete/sysfs-driver-hid-roccat-pyra      |   2 +-
 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  45 +-
 Documentation/ABI/testing/pstore                   |   4 +-
 .../testing/sysfs-bus-event_source-devices-format  |   4 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352       |  12 +-
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |   4 +-
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |   4 +-
 .../ABI/testing/sysfs-bus-pci-devices-aer_stats    |  24 +-
 .../ABI/testing/sysfs-bus-pci-devices-cciss        |  44 +-
 .../ABI/testing/sysfs-bus-usb-devices-usbsevseg    |  22 +-
 .../testing/sysfs-class-backlight-driver-lm3533    |   6 +-
 Documentation/ABI/testing/sysfs-class-cxl          |   6 +-
 Documentation/ABI/testing/sysfs-class-devfreq      |   2 +-
 .../ABI/testing/sysfs-class-led-driver-lm3533      |   8 +-
 Documentation/ABI/testing/sysfs-class-leds-gt683r  |   4 +-
 Documentation/ABI/testing/sysfs-class-powercap     |   2 +-
 Documentation/ABI/testing/sysfs-class-uwb_rc       |   6 -
 Documentation/ABI/testing/sysfs-driver-altera-cvp  |   2 +-
 Documentation/ABI/testing/sysfs-driver-hid         |  12 +-
 .../ABI/testing/sysfs-driver-hid-roccat-kone       |   2 +-
 Documentation/ABI/testing/sysfs-driver-ppi         |   2 +-
 Documentation/ABI/testing/sysfs-driver-st          |   2 +-
 Documentation/ABI/testing/sysfs-driver-wacom       |   2 +-
 Documentation/ABI/testing/sysfs-kernel-fscaps      |   2 +-
 Documentation/ABI/testing/sysfs-kernel-vmcoreinfo  |   2 +-
 Documentation/driver-api/gpio/driver.rst           |   2 +-
 .../driver-model/{binding.txt => binding.rst}      |  20 +-
 Documentation/driver-model/{bus.txt => bus.rst}    |  69 +--
 .../driver-model/{class.txt => class.rst}          |  74 ++--
 .../{design-patterns.txt => design-patterns.rst}   | 106 ++---
 .../driver-model/{device.txt => device.rst}        |  57 +--
 .../driver-model/{devres.txt => devres.rst}        |  50 +--
 .../driver-model/{driver.txt => driver.rst}        | 114 ++---
 Documentation/driver-model/index.rst               |  26 ++
 .../driver-model/{overview.txt => overview.rst}    |  37 +-
 .../driver-model/{platform.txt => platform.rst}    |  30 +-
 .../driver-model/{porting.txt => porting.rst}      | 335 +++++++--------
 Documentation/eisa.txt                             |   4 +-
 Documentation/filesystems/debugfs.txt              |   2 +-
 Documentation/hwmon/submitting-patches.rst         |   2 +-
 arch/arm/include/asm/ptdump.h                      |   9 +-
 arch/arm/mach-omap1/clock.c                        |  64 +--
 arch/arm/mach-omap1/pm.c                           |   7 +-
 arch/arm/mach-omap2/pm-debug.c                     |  15 +-
 arch/arm/mm/dump.c                                 |   4 +-
 arch/arm/mm/ptdump_debugfs.c                       |   8 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 arch/sh/kernel/kdebugfs.c                          |   3 -
 arch/sh/mm/asids-debugfs.c                         |  11 +-
 arch/sh/mm/cache-debugfs.c                         |  20 +-
 arch/sh/mm/pmb.c                                   |   9 +-
 arch/sh/mm/tlb-debugfs.c                           |  20 +-
 arch/x86/kernel/kdebugfs.c                         |  60 +--
 arch/x86/mm/debug_pagetables.c                     |  35 +-
 arch/x86/platform/atom/punit_atom_debug.c          |  23 +-
 arch/x86/platform/intel-quark/imr.c                |  14 +-
 arch/x86/platform/intel/iosf_mbi.c                 |  21 +-
 arch/x86/platform/uv/tlb_uv.c                      |  15 +-
 arch/x86/xen/debugfs.c                             |   7 +-
 arch/x86/xen/p2m.c                                 |   3 -
 drivers/acpi/acpi_lpss.c                           |   4 +-
 drivers/acpi/sleep.c                               |   2 +-
 drivers/acpi/utils.c                               |  11 +-
 drivers/amba/tegra-ahb.c                           |   4 +-
 drivers/base/arch_topology.c                       |   5 +-
 drivers/base/bus.c                                 |   6 +-
 drivers/base/cacheinfo.c                           |   3 +-
 drivers/base/core.c                                |   6 +
 drivers/base/dd.c                                  |  55 ++-
 drivers/base/devcon.c                              |   2 +-
 drivers/base/driver.c                              |   4 +-
 drivers/base/firmware_loader/Kconfig               |  18 +
 drivers/base/firmware_loader/fallback.c            |  65 +--
 drivers/base/firmware_loader/firmware.h            |  16 +-
 drivers/base/firmware_loader/main.c                | 224 +++++++++-
 drivers/base/node.c                                |   5 +-
 drivers/base/platform.c                            |   2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |   8 +-
 drivers/char/ipmi/ipmi_si_platform.c               |   2 +-
 drivers/firmware/arm_scmi/common.h                 |   2 +-
 drivers/firmware/efi/dev-path-parser.c             |   4 +-
 drivers/firmware/ti_sci.h                          |   2 +-
 drivers/fpga/of-fpga-region.c                      |   7 +-
 drivers/gpio/gpio-cs5535.c                         |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   2 +-
 drivers/gpu/drm/tegra/dc.c                         |   4 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  15 +-
 drivers/hwtracing/coresight/coresight.c            |   6 +-
 drivers/hwtracing/coresight/of_coresight.c         |   2 +-
 drivers/hwtracing/intel_th/core.c                  |   5 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |   2 +-
 drivers/i2c/i2c-core-acpi.c                        |   4 +-
 drivers/i2c/i2c-core-of.c                          |   4 +-
 drivers/iio/inkern.c                               |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   2 +-
 drivers/iommu/arm-smmu-v3.c                        |   2 +-
 drivers/iommu/arm-smmu.c                           |   2 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |  28 +-
 drivers/mailbox/bcm-pdc-mailbox.c                  |   8 +-
 drivers/mfd/altera-sysmgr.c                        |   4 +-
 drivers/mfd/syscon.c                               |  21 -
 drivers/misc/cxl/cxl.h                             |  15 +-
 drivers/misc/cxl/debugfs.c                         |  36 +-
 drivers/misc/genwqe/card_base.c                    |   5 -
 drivers/misc/genwqe/card_base.h                    |   2 +-
 drivers/misc/genwqe/card_debugfs.c                 | 165 ++------
 drivers/misc/genwqe/card_dev.c                     |   6 +-
 drivers/misc/lkdtm/core.c                          |  15 +-
 drivers/misc/mei/debugfs.c                         |  47 +--
 drivers/misc/mei/main.c                            |   8 +-
 drivers/misc/mei/mei_dev.h                         |   7 +-
 drivers/misc/mic/card/mic_debugfs.c                |  18 +-
 drivers/misc/mic/cosm/cosm_debugfs.c               |   4 -
 drivers/misc/mic/host/mic_debugfs.c                |   4 -
 drivers/misc/mic/scif/scif_debugfs.c               |   5 -
 drivers/misc/mic/vop/vop_debugfs.c                 |   4 -
 drivers/misc/ti-st/st_kim.c                        |   4 -
 drivers/misc/vmw_balloon.c                         |  19 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c             |   4 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   2 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   4 +-
 drivers/nvmem/core.c                               |   2 +-
 drivers/of/of_mdio.c                               |   2 +-
 drivers/of/platform.c                              |   2 +-
 drivers/pci/probe.c                                |   2 +-
 drivers/pci/search.c                               |   4 +-
 drivers/pinctrl/devicetree.c                       |   7 +-
 drivers/power/avs/smartreflex.c                    |  41 +-
 drivers/s390/cio/ccwgroup.c                        |   6 +-
 drivers/s390/cio/chsc_sch.c                        |   2 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/device.c                          |  10 +-
 drivers/s390/cio/scm.c                             |   4 +-
 drivers/s390/crypto/ap_bus.c                       |   8 +-
 drivers/scsi/scsi_proc.c                           |   2 +-
 drivers/spi/spi.c                                  |   4 +-
 drivers/staging/most/core.c                        |   9 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   2 -
 drivers/thermal/intel/intel_powerclamp.c           |  12 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |  25 +-
 drivers/thermal/tegra/soctherm.c                   |  14 +-
 drivers/thunderbolt/switch.c                       |   4 +-
 drivers/usb/core/devio.c                           |   4 +-
 drivers/usb/core/usb.c                             |   4 +-
 drivers/usb/phy/phy-am335x-control.c               |   4 +-
 drivers/usb/phy/phy-isp1301.c                      |   4 +-
 drivers/visorbus/visorbus_main.c                   |   4 +-
 drivers/watchdog/bcm_kona_wdt.c                    |  14 +-
 drivers/watchdog/mei_wdt.c                         |  30 +-
 fs/btrfs/sysfs.c                                   |  18 +-
 fs/ceph/debugfs.c                                  |  24 +-
 fs/ceph/super.c                                    |   4 +-
 fs/ceph/super.h                                    |   2 +-
 fs/debugfs/file.c                                  |  14 +-
 fs/debugfs/inode.c                                 |  34 +-
 fs/dlm/lockspace.c                                 |   3 +-
 fs/ext4/sysfs.c                                    |   6 +-
 fs/f2fs/sysfs.c                                    |   6 +-
 fs/gfs2/sys.c                                      |   3 +-
 fs/nfsd/fault_inject.c                             |  12 +-
 fs/nfsd/nfsctl.c                                   |   5 +-
 fs/nfsd/state.h                                    |   4 +-
 fs/orangefs/orangefs-debugfs.c                     |  54 +--
 fs/orangefs/orangefs-debugfs.h                     |   2 +-
 fs/orangefs/orangefs-mod.c                         |   6 +-
 fs/ubifs/debug.c                                   | 169 ++------
 fs/ubifs/debug.h                                   |   4 +-
 fs/ubifs/super.c                                   |   9 +-
 include/linux/backing-dev-defs.h                   |   1 -
 include/linux/ceph/debugfs.h                       |   4 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/debugfs.h                            |  12 +-
 include/linux/device.h                             |  11 +-
 include/linux/mfd/syscon.h                         |   6 -
 kernel/dma/swiotlb.c                               |  25 +-
 kernel/fail_function.c                             |  23 +-
 kernel/gcov/fs.c                                   |  24 +-
 kernel/kprobes.c                                   |  25 +-
 kernel/trace/blktrace.c                            |   6 -
 kernel/trace/trace.c                               |   4 -
 lib/842/842_debugfs.h                              |   5 +-
 lib/dynamic_debug.c                                |  12 +-
 lib/fault-inject.c                                 |  73 ++--
 lib/kobject.c                                      |   4 +-
 lib/notifier-error-inject.c                        |  13 +-
 mm/backing-dev.c                                   |  24 +-
 mm/cleancache.c                                    |   3 +-
 mm/hwpoison-inject.c                               |  67 +--
 mm/kmemleak.c                                      |   7 +-
 mm/zsmalloc.c                                      |  24 +-
 mm/zswap.c                                         |   2 -
 net/6lowpan/6lowpan_i.h                            |  16 +-
 net/6lowpan/core.c                                 |   8 +-
 net/6lowpan/debugfs.c                              |  97 ++---
 net/ceph/ceph_common.c                             |   5 +-
 net/ceph/debugfs.c                                 |  33 +-
 net/sunrpc/debugfs.c                               |  66 +--
 scripts/coccinelle/free/devm_free.cocci            |   2 +-
 scripts/get_abi.pl                                 | 468 +++++++++++++++++++++
 sound/soc/rockchip/rk3399_gru_sound.c              |   2 +-
 tools/firmware/Makefile                            |   2 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  73 +++-
 tools/testing/selftests/firmware/fw_lib.sh         |   7 +
 tools/testing/selftests/firmware/fw_run_tests.sh   |   1 +
 206 files changed, 1985 insertions(+), 2235 deletions(-)
 rename Documentation/driver-model/{binding.txt => binding.rst} (92%)
 rename Documentation/driver-model/{bus.txt => bus.rst} (76%)
 rename Documentation/driver-model/{class.txt => class.rst} (75%)
 rename Documentation/driver-model/{design-patterns.txt => design-patterns.rst} (59%)
 rename Documentation/driver-model/{device.txt => device.rst} (71%)
 rename Documentation/driver-model/{devres.txt => devres.rst} (93%)
 rename Documentation/driver-model/{driver.txt => driver.rst} (75%)
 create mode 100644 Documentation/driver-model/index.rst
 rename Documentation/driver-model/{overview.txt => overview.rst} (90%)
 rename Documentation/driver-model/{platform.txt => platform.rst} (95%)
 rename Documentation/driver-model/{porting.txt => porting.rst} (62%)
 create mode 100755 scripts/get_abi.pl
