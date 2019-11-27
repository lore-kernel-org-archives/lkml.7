Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FACC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D1E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574872903;
	bh=FRtEQi6se4HuGFXxaAPurI8BcR57hmVaZde2tfbiEIM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=m3Sm835NONHnE2pLjwGOiyhyvB7/guraHcNMg2U25N0C5HpXdnuOKaGdH1xwWqFYj
	 w1Hf+zc2beUqvxKGBVu0OdMxVLwL3Mtdph5yfYFan2A930+mi1H/fsV8+R66xcYtit
	 usKKAxKK68XZ2V5761Z/aQUZ3sCURYJn92vwhFQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfK0Qlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfK0Qll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 11:41:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C792073F;
        Wed, 27 Nov 2019 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574872900;
        bh=FRtEQi6se4HuGFXxaAPurI8BcR57hmVaZde2tfbiEIM=;
        h=Date:From:To:Cc:Subject:From;
        b=edkWLGlZQq2BagGpQNFy+h5vwPgVkii6m70JS3RFatr+0PLvt6WWrZSUc2CVNCpjB
         7EonLJVIn2sXOzs0lWkL3B+Jsia7T1oR69Tk6C9xL49p6pxD0/uM9CLt6d5ueWrs7o
         U6EfRboOSN6+SmLxsubpS1C7s0yRsaWZBB5BWB6Y=
Date:   Wed, 27 Nov 2019 17:41:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.5-rc1
Message-ID: <20191127164138.GA3088162@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.5-rc1

for you to fetch changes up to 0e4a459f56c32d3e52ae69a4b447db2f48a65f44:

  tracing: Remove unnecessary DEBUG_FS dependency (2019-11-22 16:19:13 +0100)

----------------------------------------------------------------
Driver core patches for 5.5-rc1

Here is the "big" set of driver core patches for 5.5-rc1

There's a few minor cleanups and fixes in here, but the majority of the
patches in here fall into two buckets:
  - debugfs api cleanups and fixes
  - driver core device link support for boot dependancy issues

The debugfs api cleanups are working to slowly refactor the debugfs apis
so that it is even harder to use incorrectly.  That work has been
happening for the past few kernel releases and will continue over time,
it's a long-term project/goal

The driver core device link support missed 5.4 by just a bit, so it's
been sitting and baking for many months now.  It's from Saravana Kannan
to help resolve the problems that DT-based systems have at boot time
with dependancy graphs and kernel modules.  Turns out that no one has
actually tried to build a generic arm64 kernel with loads of modules and
have it "just work" for a variety of platforms (like a distro kernel)
The big problem turned out to be a lack of depandancy information
between different areas of DT entries, and the work here resolves that
problem and now allows devices to boot properly, and quicker than a
monolith kernel.

All of these patches have been in linux-next for a long time with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      driver core: platform: Declare ret variable only once

Arkadiusz Drabczyk (1):
      firmware: Update pointer to documentation

Bartosz Golaszewski (10):
      drivers: move the early platform device support to arch/sh
      sh: add the sh_ prefix to early platform symbols
      Documentation: devres: add missing entry for devm_platform_ioremap_resource()
      lib: devres: prepare devm_ioremap_resource() for more variants
      lib: devres: provide devm_ioremap_resource_wc()
      drivers: platform: provide devm_platform_ioremap_resource_wc()
      misc: sram: use devm_platform_ioremap_resource_wc()
      drivers: provide devm_platform_ioremap_resource_byname()
      gpio: mvebu: use devm_platform_ioremap_resource_byname()
      gpio: tegra186: use devm_platform_ioremap_resource_byname()

Ben Dooks (Codethink) (1):
      cpu-topology: declare parse_acpi_topology in <linux/arch_topology.h>

Drew DeVault (1):
      firmware loader: log path to loaded firmwares

Geert Uytterhoeven (8):
      Documentation: debugfs: Document debugfs helper for unsigned long values
      debugfs: Add debugfs_create_xul() for hexadecimal unsigned long
      mmc: atmel-mci: Fix debugfs on 64-bit platforms
      mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
      mmc: dw_mmc: Fix debugfs on 64-bit platforms
      mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call
      mac80211: Use debugfs_create_xul() helper
      net: caif: Fix debugfs on 64-bit platforms

Greg Kroah-Hartman (15):
      debugfs: remove return value of debugfs_create_u8()
      debugfs: remove return value of debugfs_create_u16()
      debugfs: remove return value of debugfs_create_u64()
      debugfs: remove return value of debugfs_create_size_t()
      ntb: ntb_pingpong: no need to check the return value of debugfs calls
      debugfs: remove return value of debugfs_create_x16()
      debugfs: remove return value of debugfs_create_x32()
      debugfs: remove return value of debugfs_create_x64()
      Merge 5.4-rc5 into driver-core-next
      powerpc: pseries: no need to check return value of debugfs_create functions
      debugfs: remove return value of debugfs_create_x8()
      debugfs: remove return value of debugfs_create_atomic_t()
      IB: mlx5: no need to check return value of debugfs_create functions
      media: c8sectpfe: no need to check return value of debugfs_create functions
      crypto: hisilicon: no need to check return value of debugfs_create functions

Jon Hunter (1):
      mailbox: tegra: Fix superfluous IRQ error message

Krzysztof Kozlowski (1):
      drivers: base: Fix Kconfig indentation

Kusanagi Kouichi (2):
      debugfs: Fix !DEBUG_FS debugfs_create_automount
      tracing: Remove unnecessary DEBUG_FS dependency

Linus Walleij (1):
      firmware_loader: Fix labels with comma for builtin firmware

Mark Salyzyn (1):
      firmware_class: make firmware caching configurable

Murali Nalajala (1):
      base: soc: Handle custom soc information sysfs entries

Sami Tolvanen (1):
      driver core: platform: use the correct callback type for bus_find_device

Saravana Kannan (22):
      driver core: Add fwnode_to_dev() to look up device from fwnode
      driver core: Add support for linking devices during device addition
      of: property: Add functional dependency link from DT bindings
      driver core: Add sync_state driver/bus callback
      of/platform: Pause/resume sync state during init and of_platform_populate()
      of: property: Create device links for all child-supplier depencencies
      of: property: Minor code formatting/style clean ups
      driver: core: Improve documentation for fwnode_operations.add_links()
      docs: driver-model: Add documentation for sync_state
      driver core: Add device link support for SYNC_STATE_ONLY flag
      driver core: Allow a device to wait on optional suppliers
      driver core: Allow fwnode_operations.add_links to differentiate errors
      of: property: Make sure child dependencies don't block probing of parent
      of: property: Skip adding device links to suppliers that aren't devices
      of: property: Minor style clean up of of_link_to_phandle()
      of: property: Make it easy to add device links from DT properties
      of: property: Add device link support for iommus, mboxes and io-channels
      driver core: Clarify documentation for fwnode_operations.add_links()
      driver core: Allow device link operations inside sync_state()
      i2c: of: Populate fwnode in of_i2c_get_board_info()
      of: property: Fix the semantics of of_is_ancestor_of()
      of: property: Add device link support for interrupt-parent, dmas and -gpio(s)

Uwe Kleine-König (1):
      driver core: simplify definitions of platform_get_irq*

Will Deacon (1):
      of: property: Add device link support for "iommu-map"

 Documentation/admin-guide/kernel-parameters.rst    |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |   6 +
 Documentation/driver-api/device_link.rst           |   3 +-
 Documentation/driver-api/driver-model/devres.rst   |   4 +
 Documentation/driver-api/driver-model/driver.rst   |  43 +++
 Documentation/filesystems/debugfs.txt              |  50 +--
 arch/powerpc/platforms/pseries/dtl.c               |  38 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c       |  12 +-
 arch/powerpc/platforms/pseries/lpar.c              |  15 +-
 arch/sh/drivers/Makefile                           |   2 +-
 arch/sh/drivers/platform_early.c                   | 347 ++++++++++++++++++
 arch/sh/include/asm/platform_early.h               |  61 ++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh3.c                 |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |   3 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |   3 +-
 arch/sh/kernel/setup.c                             |   3 +-
 arch/sh/kernel/time.c                              |   5 +-
 drivers/base/core.c                                | 308 +++++++++++++++-
 drivers/base/firmware_loader/Kconfig               |  14 +-
 drivers/base/firmware_loader/builtin/Makefile      |   3 +-
 drivers/base/firmware_loader/main.c                |   9 +-
 drivers/base/platform.c                            | 393 ++++-----------------
 drivers/base/soc.c                                 |  30 +-
 drivers/clocksource/sh_cmt.c                       |  13 +-
 drivers/clocksource/sh_mtu2.c                      |  13 +-
 drivers/clocksource/sh_tmu.c                       |  14 +-
 drivers/crypto/hisilicon/qm.c                      |  19 +-
 drivers/crypto/hisilicon/zip/zip_main.c            |  24 +-
 drivers/gpio/gpio-mvebu.c                          |  19 +-
 drivers/gpio/gpio-tegra186.c                       |   4 +-
 drivers/i2c/i2c-core-of.c                          |   1 +
 drivers/infiniband/hw/mlx5/main.c                  |  62 +---
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   9 +-
 drivers/mailbox/tegra-hsp.c                        |   4 +-
 .../platform/sti/c8sectpfe/c8sectpfe-debugfs.c     |  26 +-
 drivers/misc/sram.c                                |  28 +-
 drivers/mmc/host/atmel-mci.c                       |  10 +-
 drivers/mmc/host/dw_mmc.c                          |  10 +-
 drivers/net/caif/caif_serial.c                     |   4 +-
 drivers/ntb/test/ntb_pingpong.c                    |   5 +-
 drivers/of/platform.c                              |  12 +
 drivers/of/property.c                              | 316 +++++++++++++++++
 drivers/tty/serial/sh-sci.c                        |  11 +-
 fs/debugfs/file.c                                  |  87 ++---
 include/linux/arch_topology.h                      |   1 +
 include/linux/debugfs.h                            | 136 ++++---
 include/linux/device.h                             |  33 ++
 include/linux/fwnode.h                             |  42 +++
 include/linux/platform_device.h                    |  70 +---
 include/linux/sys_soc.h                            |   1 +
 kernel/trace/Kconfig                               |   1 -
 lib/devres.c                                       |  62 ++--
 net/mac80211/debugfs_sta.c                         |  17 +-
 79 files changed, 1634 insertions(+), 858 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h
