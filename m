Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B59C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E888821920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568807299;
	bh=mUL20LAYM2GfW05hQXJcjxbkD1ILI65Hsc3vixsQxPY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=baJr6QKRGQSYjvRvUaTtCdMKJex6DD8wvgH8mupfGs8qooSQcYIDJeHHo9OYvrh3n
	 2RCV3DKKyZopsSPHs1ffONHIIcw0qYjzykhwrQqKGafO7yPzrLrwpHZvI8UklFxFps
	 npR9tFsKcTKbR9fZkK4BrmHx0ivbSS8RHFobdxPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfIRLsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbfIRLsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:48:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A9521907;
        Wed, 18 Sep 2019 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568807296;
        bh=mUL20LAYM2GfW05hQXJcjxbkD1ILI65Hsc3vixsQxPY=;
        h=Date:From:To:Cc:Subject:From;
        b=j/o15qZWAEsi5WY2HCQfXPNYmXum3sKmahJ2NE4NfkKmXIEKLb8Ikmx6xBZC8x+96
         Q2BEq9/pD2JCDDZHQOCJecf4vnESSGxn8B/kfZypB0JyoPkmjo3bfR4FlQx0VRtzfx
         FQc6eM4H3I+OMnZt5M+jbFx2LSzjCnXmgrt42bQ0=
Date:   Wed, 18 Sep 2019 13:48:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.4-rc1
Message-ID: <20190918114814.GA1899579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.4-rc1

for you to fetch changes up to ca7ce5a2710ad2a57bf7d0c4c712590bb69a5e1c:

  coccinelle: platform_get_irq: Fix parse error (2019-09-06 10:10:28 +0200)

----------------------------------------------------------------
Driver core patches for 5.4-rc1

Here is the big driver core update for 5.4-rc1.

There was a bit of a churn in here, with a number of core and OF
platform patches being added to the tree, and then after much discussion
and review and a day-long in-person meeting, they were decided to be
reverted and a new set of patches is currently being reviewed on the
mailing list.

Other than that churn, there are two "persistent" branches in here that
other trees will be pulling in as well during the merge window.  One
branch to add support for drivers to have the driver core automatically
add sysfs attribute files when a driver is bound to a device so that the
driver doesn't have to manually do it (and then clean it up, as it
always gets it wrong).

There's another branch in here for generic lookup helpers for the driver
core that lots of busses are starting to use.  That's the majority of
the non-driver-core changes in this patch series.

There's also some on-going debugfs file creation cleanup that has been
slowly happening over the past few releases, with the goal to hopefully
get that done sometime next year.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akinobu Mita (2):
      devcoredump: use memory_read_from_buffer
      devcoredump: fix typo in comment

Dmitry Torokhov (1):
      driver core: add dev_groups to all drivers

Greg Kroah-Hartman (24):
      Merge branch 'generic_lookup_helpers' into driver-core-next
      mfd: ab3100: no need to check return value of debugfs_create functions
      mfd: ab8500: no need to check return value of debugfs_create functions
      mfd: aat2870: no need to check return value of debugfs_create functions
      Merge tag 'dev_groups_all_drivers' into driver-core-next
      uio: uio_fsl_elbc_gpcm: convert platform driver to use dev_groups
      firmware: arm_scpi: convert platform driver to use dev_groups
      video: fbdev: wm8505fb: convert platform driver to use dev_groups
      video: fbdev: w100fb: convert platform driver to use dev_groups
      video: fbdev: sm501fb: convert platform driver to use dev_groups
      platform: x86: hp-wmi: convert platform driver to use dev_groups
      olpc: x01: convert platform driver to use dev_groups
      Merge 5.3-rc4 into driver-core-next
      Revert "of/platform: Disable generic device linking code for PowerPC"
      Revert "of/platform: Fix device_links_supplier_sync_state_resume() warning"
      Revert "of/platform: Fix fn definitons for of_link_is_valid() and of_link_property()"
      Revert "of/platform: Don't create device links for default busses"
      Revert "of/platform: Create device links for all child-supplier depencencies"
      Revert "of/platform: Pause/resume sync state during init and of_platform_populate()"
      Revert "driver core: Add sync_state driver/bus callback"
      Revert "of/platform: Add functional dependency link from DT bindings"
      Revert "driver core: Add edit_links() callback for drivers"
      Revert "driver core: Add support for linking devices during device addition"
      sysfs: add BIN_ATTR_WO() macro

Jia-Ju Bai (1):
      fs: kernfs: Fix possible null-pointer dereferences in kernfs_path_from_node_locked()

Masahiro Yamada (1):
      driver-core: add include guard to linux/container.h

Peng Wang (1):
      kernfs: fix potential null pointer dereference

Rafael J. Wysocki (2):
      driver core: Remove device link creation limitation
      driver core: Fix creation of device links with PM-runtime flags

Saravana Kannan (10):
      driver core: Add support for linking devices during device addition
      driver core: Add edit_links() callback for drivers
      of/platform: Add functional dependency link from DT bindings
      driver core: Add sync_state driver/bus callback
      of/platform: Pause/resume sync state during init and of_platform_populate()
      of/platform: Create device links for all child-supplier depencencies
      of/platform: Don't create device links for default busses
      of/platform: Fix fn definitons for of_link_is_valid() and of_link_property()
      of/platform: Fix device_links_supplier_sync_state_resume() warning
      of/platform: Disable generic device linking code for PowerPC

Stephen Boyd (2):
      driver core: platform: Add an error message to platform_get_irq*()
      coccinelle: Add script to check for platform_get_irq() excessive prints

Suzuki K Poulose (11):
      drivers: Introduce device lookup variants by name
      drivers: Introduce device lookup variants by of_node
      drivers: Introduce device lookup variants by fwnode
      drivers: Introduce device lookup variants by device type
      drivers: Introduce device lookup variants by ACPI_COMPANION device
      drivers: Add generic helper to match any device
      platform: Add platform_find_device_by_driver() helper
      i2c: Revert incorrect conversion to use generic helper
      drivers: Fix typo in parameter description for driver_find_device_by_acpi_dev
      drivers: Fix htmldocs warnings with bus_find_next_device()
      device.h: Fix warnings for mismatched parameter names in comments

Thierry Reding (3):
      driver core: platform: Introduce platform_get_irq_optional()
      hwmon: pwm-fan: Use platform_get_irq_optional()
      driver core: platform: Export platform_get_irq_optional()

YueHaibing (1):
      coccinelle: platform_get_irq: Fix parse error

 Documentation/driver-api/device_link.rst           |   4 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c              |  17 +-
 drivers/amba/tegra-ahb.c                           |  11 +-
 drivers/base/bus.c                                 |  24 --
 drivers/base/core.c                                | 219 ++++++++------
 drivers/base/dd.c                                  |  14 +
 drivers/base/devcon.c                              |   8 +-
 drivers/base/devcoredump.c                         |  13 +-
 drivers/base/platform.c                            |  79 ++++-
 drivers/base/power/runtime.c                       |   4 +-
 drivers/firmware/arm_scpi.c                        |   5 +-
 drivers/fpga/fpga-bridge.c                         |   8 +-
 drivers/fpga/fpga-mgr.c                            |   8 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   7 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |   9 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   3 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   3 +-
 drivers/hwmon/pwm-fan.c                            |   2 +-
 drivers/hwtracing/coresight/coresight-platform.c   |  11 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   2 -
 drivers/hwtracing/coresight/coresight.c            |   4 +-
 drivers/hwtracing/intel_th/core.c                  |  10 +-
 drivers/hwtracing/stm/core.c                       |   9 +-
 drivers/i2c/busses/i2c-amd-mp2-pci.c               |   8 +-
 drivers/i2c/i2c-core-acpi.c                        |   8 +-
 drivers/i2c/i2c-core-of.c                          |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   8 +-
 drivers/iommu/arm-smmu-v3.c                        |   9 +-
 drivers/iommu/arm-smmu.c                           |   9 +-
 drivers/leds/led-class.c                           |   9 +-
 drivers/mfd/aat2870-core.c                         |  13 +-
 drivers/mfd/ab3100-core.c                          |  45 +--
 drivers/mfd/ab3100-otp.c                           |  21 +-
 drivers/mfd/ab8500-debugfs.c                       | 324 +++++++--------------
 drivers/mfd/altera-sysmgr.c                        |  14 +-
 drivers/misc/mei/main.c                            |   9 +-
 drivers/mux/core.c                                 |   7 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   8 +-
 drivers/net/phy/mdio_bus.c                         |   9 +-
 drivers/nvmem/core.c                               |   7 +-
 drivers/of/of_mdio.c                               |   8 +-
 drivers/of/platform.c                              |   7 +-
 drivers/pci/probe.c                                |   7 +-
 drivers/platform/x86/hp-wmi.c                      |  47 +--
 drivers/regulator/of_regulator.c                   |   7 +-
 drivers/rtc/interface.c                            |  11 +-
 drivers/s390/cio/ccwgroup.c                        |  18 +-
 drivers/s390/cio/device.c                          |  15 +-
 drivers/s390/crypto/zcrypt_api.c                   |  22 +-
 drivers/scsi/scsi_proc.c                           |   9 +-
 drivers/spi/spi.c                                  |  28 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |  23 +-
 drivers/usb/core/devio.c                           |   8 +-
 drivers/usb/roles/class.c                          |  16 +-
 drivers/usb/typec/class.c                          |  16 +-
 drivers/video/fbdev/sm501fb.c                      |  37 +--
 drivers/video/fbdev/w100fb.c                       |  23 +-
 drivers/video/fbdev/wm8505fb.c                     |  13 +-
 fs/kernfs/dir.c                                    |   9 +-
 include/linux/container.h                          |   5 +
 include/linux/device.h                             | 246 +++++++++++++++-
 include/linux/mfd/aat2870.h                        |   1 -
 include/linux/platform_device.h                    |   4 +
 include/linux/sysfs.h                              |   9 +
 net/ieee802154/core.c                              |   7 +-
 scripts/coccinelle/api/platform_get_irq.cocci      | 102 +++++++
 sound/soc/rockchip/rk3399_gru_sound.c              |   9 +-
 69 files changed, 818 insertions(+), 889 deletions(-)
 create mode 100644 scripts/coccinelle/api/platform_get_irq.cocci
