Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16795C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B955120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551868436;
	bh=8CRruJIUAHU16/GjXh3FUn81jkfWPTFdY8A5cpU5Y/0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TBVzk5PG67A2WtmjElBVUgCXLErgzqYFAn004G249EgfCFAG3K2+xEE5ATDuAZvjd
	 QQyIsIR0+Wo/BU9w85Okk5cwois9qkFUob9lshD+aAhVyzIB+ZbPjZMimI1G4UjQ27
	 MMaef2whqJjem1I26Glk58YeIGLbipKfEOUtJX4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfCFKdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfCFKdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:33:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BF520661;
        Wed,  6 Mar 2019 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551868433;
        bh=8CRruJIUAHU16/GjXh3FUn81jkfWPTFdY8A5cpU5Y/0=;
        h=Date:From:To:Cc:Subject:From;
        b=Hpdfw0dJ5v/1oeX5b8fTa8qsbvW33llUjLBg3Cv1SKyLLUDnvpHxYxDjkiB2eirOb
         qy8+g8rjjl35ECsK+Ideg2bx1nibv2aDu6eVUECwe+z6BaRv1X0FaipvGAM0mabsk1
         dEHlFer+3MYyCZwyrTTWWHqNofCu1CUbgDuf1O0Y=
Date:   Wed, 6 Mar 2019 11:33:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 5.1-rc1
Message-ID: <20190306103350.GA10570@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.1-rc1

for you to fetch changes up to 36cf3b1363f464c40f6ce647d3ac0ae9617d5fbc:

  driver core: platform: remove misleading err_alloc label (2019-03-01 18:08:06 +0100)

----------------------------------------------------------------
Driver core patches for 5.1-rc1

Here is the big driver core patchset for 5.1-rc1

More patches than "normal" here this merge window, due to some work in
the driver core by Alexander Duyck to rework the async probe
functionality to work better for a number of devices, and independant
work from Rafael for the device link functionality to make it work
"correctly".

Also in here is:
	- lots of BUS_ATTR() removals, the macro is about to go away
	- firmware test fixups
	- ihex fixups and simplification
	- component additions (also includes i915 patches)
	- lots of minor coding style fixups and cleanups.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Duyck (9):
      driver core: Establish order of operations for device_add and device_del via bitflag
      device core: Consolidate locking and unlocking of parent and device
      driver core: Probe devices asynchronously instead of the driver
      workqueue: Provide queue_work_node to queue work near a given NUMA node
      async: Add support for queueing on specific NUMA node
      driver core: Attach devices on CPU local to device node
      PM core: Use new async_schedule_dev command
      libnvdimm: Schedule device registration on node local to the device
      driver core: Rewrite test_async_driver_probe to cover serialization and NUMA affinity

Andrey Smirnov (5):
      ihex: Share code between ihex_validate_fw() and ihex_next_binrec()
      ihex: Check if zero-length record is at the end of the blob
      ihex: Simplify next record offset calculation
      tools/firmware/ihex2fw: Simplify next record offset calculation
      tools/firmware/ihex2fw: Replace explicit alignment with ALIGN

Ayush Mittal (1):
      kernfs: Allocating memory for kernfs_iattrs with kmem_cache.

Bo YU (2):
      kobject: to repalce printk with pr_* style
      kobject: drop newline from msg string

Daniel Vetter (4):
      component: Add documentation
      components: multiple components for a device
      i915/snd_hdac: I915 subcomponent for the snd_hdac
      drivers/component: kerneldoc polish

David Engraf (1):
      device: Fix comment for driver_data in struct device

Enrico Granata (1):
      driver: platform: Support parsing GpioInt 0 in platform_get_irq()

Eric Biggers (1):
      kobject: make kset_get_ownership() 'static'

Feng Tang (1):
      async: Add cmdline option to specify drivers to be async probed

Geert Uytterhoeven (1):
      driver core: Postpone DMA tear-down until after devres release

Greg Kroah-Hartman (11):
      driver core: bus: convert to use BUS_ATTR_WO and RW
      driver core: drop use of BUS_ATTR()
      Merge 5.0-rc2 into driver-core-next
      f2fs: no need to check return value of debugfs_create functions
      PCI: pci.c: convert to use BUS_ATTR_RW
      PCI: pci-sysfs.c: convert to use BUS_ATTR_WO
      pseries: ibmebus.c: convert to use BUS_ATTR_WO
      rapidio: rio-sysfs.c: convert to use BUS_ATTR_WO
      block: rbd: convert to use BUS_ATTR_WO and RO
      Merge 5.0-rc6 into driver-core-next
      Merge tag 'topic/component-typed-2019-02-11' of git://anongit.freedesktop.org/drm/drm-intel into driver-core-next

Jerome Brunet (1):
      driver core: silence device link messages unless debugging

Joe Perches (1):
      device.h: Add __cold to dev_<level> logging functions

Johannes Berg (1):
      driver core: platform: remove misleading err_alloc label

John Zhao (1):
      firmware: hardcode the debug message for -ENOENT

Luis Chamberlain (3):
      Revert "selftests: firmware: add CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config"
      Revert "selftests: firmware: remove use of non-standard diff -Z option"
      selftests: firmware: fix verify_reqs() return value

Mans Rullgard (1):
      platform: set of_node in platform_device_register_full()

Masahiro Yamada (2):
      firmware_loader: move CONFIG_FW_LOADER_USER_HELPER switch to Makefile
      firmware_loader: move firmware/ to drivers/base/firmware_loader/builtin/

Mathieu Malaterre (1):
      drivers: base: Use __printf markup to silence compiler

Ondrej Mosnacek (1):
      sysfs: remove unused include of kernfs-internal.h

Rafael J. Wysocki (15):
      driver core: Fix DL_FLAG_AUTOREMOVE_SUPPLIER device link flag handling
      driver core: Avoid careless re-use of existing device links
      driver core: Do not resume suppliers under device_links_write_lock()
      driver core: Fix handling of runtime PM flags in device_link_add()
      driver core: Fix adding device links to probing suppliers
      driver core: Do not call rpm_put_suppliers() in pm_runtime_drop_link()
      IOMMU: Make dwo drivers use stateless device links
      driver core: Make driver core own stateful device links
      driver core: Add device link flag DL_FLAG_AUTOPROBE_CONSUMER
      PM-runtime: Take suppliers into account in __pm_runtime_set_status()
      driver core: Document limitation related to DL_FLAG_RPM_ACTIVE
      PM-runtime: Fix __pm_runtime_set_status() race with runtime resume
      driver core: Fix possible supplier PM-usage counter imbalance
      driver core: Fix PM-runtime for links added during consumer probe
      driver core: Add missing description of new struct device_link field

Richard Gong (1):
      firmware: intel_stratix10_service: add hardware dependency

Sergei Shtylyov (1):
      devres: always use dev_name() in devm_ioremap_resource()

Sergey Senozhatsky (1):
      debugfs: debugfs_use_start/finish do not exist anymore

Stephen Martin (1):
      sysfs: fix blank line coding style warning

Stephen Rothwell (1):
      firmware: intel_stratix10_service: remove COMPILE_TEST

Wei Yang (1):
      driver core: move device->knode_class to device_private

Yong Wu (1):
      driver core: Remove the link if there is no driver with AUTO flag

 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 Documentation/driver-api/component.rst             |  17 ++
 Documentation/driver-api/device_link.rst           |  87 +++++--
 Documentation/driver-api/index.rst                 |   1 +
 Makefile                                           |   2 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |  10 +-
 drivers/base/base.h                                |  12 +
 drivers/base/bus.c                                 |  66 ++----
 drivers/base/class.c                               |  14 +-
 drivers/base/component.c                           | 206 +++++++++++++++-
 drivers/base/core.c                                | 246 +++++++++++++++----
 drivers/base/cpu.c                                 |   1 +
 drivers/base/dd.c                                  | 188 ++++++++++++---
 drivers/base/firmware_loader/Makefile              |   4 +-
 .../base/firmware_loader/builtin}/.gitignore       |   0
 .../base/firmware_loader/builtin}/Makefile         |   0
 drivers/base/firmware_loader/fallback_table.c      |   5 -
 drivers/base/firmware_loader/main.c                |   8 +-
 drivers/base/platform.c                            |  21 +-
 drivers/base/power/main.c                          |  12 +-
 drivers/base/power/runtime.c                       | 101 +++++---
 drivers/base/test/test_async_driver_probe.c        | 261 ++++++++++++++++-----
 drivers/block/rbd.c                                |  45 ++--
 drivers/firmware/Kconfig                           |   2 +-
 drivers/gpu/drm/i915/intel_audio.c                 |   4 +-
 drivers/iommu/exynos-iommu.c                       |   1 +
 drivers/iommu/rockchip-iommu.c                     |   3 +-
 drivers/nvdimm/bus.c                               |  11 +-
 drivers/pci/pci-sysfs.c                            |   5 +-
 drivers/pci/pci.c                                  |   7 +-
 drivers/rapidio/rio-sysfs.c                        |   5 +-
 fs/debugfs/inode.c                                 |   4 +-
 fs/f2fs/debug.c                                    |  20 +-
 fs/f2fs/f2fs.h                                     |   4 +-
 fs/f2fs/super.c                                    |   5 +-
 fs/kernfs/dir.c                                    |   2 +-
 fs/kernfs/inode.c                                  |   2 +-
 fs/kernfs/kernfs-internal.h                        |   2 +-
 fs/kernfs/mount.c                                  |   7 +-
 fs/sysfs/file.c                                    |   2 +-
 include/drm/i915_component.h                       |   4 +
 include/linux/async.h                              |  82 ++++++-
 include/linux/component.h                          |  76 ++++++
 include/linux/device.h                             |  30 ++-
 include/linux/ihex.h                               |  29 ++-
 include/linux/platform_device.h                    |   1 +
 include/linux/workqueue.h                          |   2 +
 include/sound/hda_component.h                      |   5 +-
 kernel/async.c                                     |  53 +++--
 kernel/workqueue.c                                 |  84 +++++++
 lib/devres.c                                       |   4 +-
 lib/kobject.c                                      |   2 +-
 lib/kobject_uevent.c                               |   9 +-
 sound/hda/hdac_component.c                         |   4 +-
 sound/hda/hdac_i915.c                              |   6 +-
 tools/firmware/ihex2fw.c                           |  17 +-
 tools/testing/selftests/firmware/config            |   1 -
 tools/testing/selftests/firmware/fw_filesystem.sh  |   9 +-
 tools/testing/selftests/firmware/fw_lib.sh         |   2 +-
 59 files changed, 1395 insertions(+), 422 deletions(-)
 create mode 100644 Documentation/driver-api/component.rst
 rename {firmware => drivers/base/firmware_loader/builtin}/.gitignore (100%)
 rename {firmware => drivers/base/firmware_loader/builtin}/Makefile (100%)
