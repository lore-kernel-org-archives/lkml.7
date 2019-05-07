Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03369C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7B5206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557252007;
	bh=54uRGD195r+2szkMPyylnfM2qe9syuEh3NoAUrqNuKc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tJNzXDBREjSqxL6QbRoBQpK7Xw39sOm+ehfK9ko88Zdc8n5qoLeRnA4Z3dmaU479N
	 gStbWYkqCPajVEjgdA74CP5dO2gjcBvKHW9YwvzJzpOmWetvYNRGYoHiUxwk7Zs1SJ
	 RTVZanplb3DEiMi/fAonmDMqW7sOVXPJUX+sPHhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfEGSAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfEGSAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:00:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E375206BF;
        Tue,  7 May 2019 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557252004;
        bh=54uRGD195r+2szkMPyylnfM2qe9syuEh3NoAUrqNuKc=;
        h=Date:From:To:Cc:Subject:From;
        b=eeoSL+pu3sEPvBx6OPglffoHYMHRaXpJ/+m3mSfaDzEGiYTXsk6p/Zu4bAUOMabaW
         hm3i4opo2yOMU9ccQGRp9V03MlddxkNx4bcq/cG6Yjv5twJ1gkA5/mRRcB45DTQNIG
         L/+aXsNwuoVdBkpSkGFh+RZkfWlQVVn8qKCBYTiA=
Date:   Tue, 7 May 2019 20:00:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.2-rc1 - part 2
Message-ID: <20190507180001.GB11857@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc1-part2

for you to fetch changes up to aad14ad3cf3a63bd258b65e18d49c3eb8472d344:

  intel_th: msu: Add current window tracking (2019-05-03 18:17:40 +0200)

----------------------------------------------------------------
Char/Misc patches for 5.2-rc1 - part 2

Here is the "real" big set of char/misc driver patches for 5.2-rc1

Loads of different driver subsystem stuff in here, all over the places:
  - thunderbolt driver updates
  - habanalabs driver updates
  - nvmem driver updates
  - extcon driver updates
  - intel_th driver updates
  - mei driver updates
  - coresight driver updates
  - soundwire driver cleanups and updates
  - fastrpc driver updates
  - other minor driver updates
  - chardev minor fixups

Feels like this tree is getting to be a dumping ground of "small driver
subsystems" these days.  Which is fine with me, if it makes things
easier for those subsystem maintainers.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (4):
      thunderbolt: Fix to check for kmemdup failure
      thunderbolt: Fix to check return value of ida_simple_get
      thunderbolt: xdomain: Fix to check return value of kmemdup
      thunderbolt: Fix to check the return value of kmemdup

Alexander Shishkin (17):
      intel_th: msu: Fix single mode with IOMMU
      intel_th: SPDX-ify the documentation
      intel_th: Rework resource passing between glue layers and core
      intel_th: Skip subdevices if their MMIO is missing
      intel_th: Add "rtit" source device
      intel_th: Communicate IRQ via resource
      intel_th: pci: Use MSI interrupt signalling
      intel_th: msu: Start handling IRQs
      intel_th: Only report useful IRQs to subdevices
      intel_th: msu: Replace open-coded list_{first,last,next}_entry variants
      intel_th: msu: Switch over to scatterlist
      intel_th: msu: Factor out pipeline draining
      intel_th: gth: Factor out trace start/stop
      intel_th: Add switch triggering support
      intel_th: msu: Correct the block wrap detection
      intel_th: msu: Add a sysfs attribute to trigger window switch
      intel_th: msu: Add current window tracking

Alexander Usyskin (1):
      mei: expose device state in sysfs

Andy Shevchenko (2):
      extcon: intel: Split out some definitions to a common header
      extcon: mrfld: Introduce extcon driver for Basin Cove PMIC

Anson Huang (3):
      nvmem: imx-ocotp: use devm_platform_ioremap_resource() to simplify code
      nvmem: mxs-ocotp: use devm_platform_ioremap_resource() to simplify code
      nvmem: imx-iim: use devm_platform_ioremap_resource() to simplify code

Arnd Bergmann (1):
      coresight: catu: fix clang build warning

Charles Keepax (1):
      extcon: arizona: Disable mic detect if running when driver is removed

Chen-Yu Tsai (5):
      nvmem: sunxi_sid: Read out SID for randomness without looping
      nvmem: sunxi_sid: Optimize register read-out method
      nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
      nvmem: sunxi_sid: Read out data in native format
      nvmem: sunxi_sid: Support SID on A83T and H5

Chengguang Xu (4):
      chardev: add additional check for minor range overlap
      chardev: add a check for given minor range
      chardev: code cleanup for __register_chrdev_region()
      chardev: update comment based on the code

Dalit Ben Zoor (7):
      habanalabs: set new golden value to tpc clock relaxation
      habanalabs: allow user to modify TPC clock relaxation value
      habanalabs: add device status option to INFO IOCTL
      habanalabs: remove call to cs_parser()
      habanalabs: remove redundant member from parser struct
      habanalabs: remove condition that is always true
      habanalabs: increase timeout if working with simulator

Dan Carpenter (1):
      misc: rtsx: clean up some indenting

Dotan Barak (1):
      habanalabs: remove implicit include from header files

Fabrice Gasnier (4):
      dt-bindings: nvmem: Add STM32 factory-programmed romem
      nvmem: Add driver for STM32 factory-programmed read only mem
      nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
      nvmem: core: add nvmem_cell_read_u16

Fuqian Huang (1):
      misc: genwqe: Fix misuse of %x

Georgi Djakov (1):
      MAINTAINERS: Add mailing list for the interconnect API

Greg Kroah-Hartman (9):
      Merge 5.1-rc3 into char-misc-next
      Merge tag 'misc-habanalabs-next-2019-04-19' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge 5.1-rc6 into char-misc-next
      Merge tag 'icc-5.2-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
      Merge tag 'extcon-next-for-5.2' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'thunderbolt-for-v5.2' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-next
      Merge tag 'soundwire-5.2-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'misc-habanalabs-next-2019-05-03' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'gnss-5.2-rc1' of https://git.kernel.org/.../johan/gnss into char-misc-next

Gustavo A. R. Silva (2):
      sgi-xpc: mark expected switch fall-through
      parport: ieee1284: mark expected switch fall-through

Hans de Goede (1):
      virt: vbox: Sanity-check parameter types for hgcm-calls coming from userspace

Igor Grinberg (1):
      habanalabs: add new device CPU boot status

Jean-Francois Dagenais (1):
      w1: ds2408: reset on output_write retry with readback

Jorge Ramirez-Ortiz (1):
      nvmem: core: fix read buffer in place

Kangjie Lu (5):
      thunderbolt: property: Fix a NULL pointer dereference
      thunderbolt: Fix a missing check of kmemdup
      char: hpet: fix a missing check of ioremap
      thunderbolt: property: Fix a missing check of kzalloc
      slimbus: fix a potential NULL pointer dereference in of_qcom_slim_ngd_register

Leo Yan (4):
      dt-bindings: arm: coresight: Add new compatible for static replicator
      coresight: replicator: Add new device id for static replicator
      dt-bindings: arm: coresight: Unify funnel DT binding
      coresight: funnel: Support static funnel

Lucas Stach (3):
      nvmem: imx-ocotp: add support for imx8mq
      nvmem: imx-ocotp: broaden Kconfig dependency
      dt-bindings: imx-ocotp: Add i.MX8MQ compatible

Mariusz Bialonczyk (2):
      w1: ds2482: cosmetic fixes after 54865314f5a1
      w1: fix the resume command API

Mathieu Poirier (20):
      coresight: pmu: Adding ITRACE property to cs_etm PMU
      coresight: etm4x: Add kernel configuration for CONTEXTID
      coresight: etm4x: Skip selector pair 0
      coresight: etm4x: Configure tracers to emit timestamps
      coresight: Adding return code to sink::disable() operation
      coresight: Move reference counting inside sink drivers
      coresight: Properly address errors in sink::disable() functions
      coresight: Properly address concurrency in sink::update() functions
      coresight: perf: Clean up function etm_setup_aux()
      coresight: perf: Refactor function free_event_data()
      coresight: Communicate perf event to sink buffer allocation functions
      coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()
      coresight: tmc-etr: Create per-thread buffer allocation function
      coresight: tmc-etr: Introduce the notion of process ID to ETR devices
      coresight: tmc-etr: Introduce the notion of reference counting to ETR devices
      coresight: tmc-etr: Introduce the notion of IDR to ETR devices
      coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide scenarios
      coresight: tmc-etr: Add support for CPU-wide trace scenarios
      coresight: tmc-etf: Add support for CPU-wide trace scenarios
      coresight: etb10: Add support for CPU-wide trace scenarios

Mika Westerberg (36):
      net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
      thunderbolt: Remove unused work field in struct tb_switch
      thunderbolt: Drop duplicated get_switch_at_route()
      thunderbolt: Block reads and writes if switch is unplugged
      thunderbolt: Take domain lock in switch sysfs attribute callbacks
      thunderbolt: Do not allocate switch if depth is greater than 6
      thunderbolt: Enable TMU access when accessing port space on legacy devices
      thunderbolt: Add dummy read after port capability list walk on Light Ridge
      thunderbolt: Move LC specific functionality into a separate file
      thunderbolt: Configure lanes when switch is initialized
      thunderbolt: Set sleep bit when suspending switch
      thunderbolt: Properly disable path
      thunderbolt: Cache adapter specific capability offset into struct port
      thunderbolt: Rename tunnel_pci to tunnel
      thunderbolt: Generalize tunnel creation functionality
      thunderbolt: Add functions for allocating and releasing HopIDs
      thunderbolt: Assign remote for both ports in case of dual link
      thunderbolt: Add helper function to iterate from one port to another
      thunderbolt: Extend tunnel creation to more than 2 adjacent switches
      thunderbolt: Deactivate all paths before restarting them
      thunderbolt: Discover preboot PCIe paths the boot firmware established
      thunderbolt: Add support for full PCIe daisy chains
      thunderbolt: Scan only valid NULL adapter ports in hotplug
      thunderbolt: Generalize port finding routines to support all port types
      thunderbolt: Rework NFC credits handling
      thunderbolt: Add support for Display Port tunnels
      thunderbolt: Do not tear down tunnels when driver is unloaded
      thunderbolt: Run tb_xdp_handle_request() in system workqueue
      thunderbolt: Add XDomain UUID exchange support
      thunderbolt: Add support for DMA tunnels
      thunderbolt: Make tb_switch_alloc() return ERR_PTR()
      thunderbolt: Add support for XDomain connections
      thunderbolt: Make __TB_[SW|PORT]_PRINT take const parameters
      thunderbolt: Make rest of the logging to happen at debug level
      thunderbolt: Reword output of tb_dump_hop()
      thunderbolt: Start firmware on Titan Ridge Apple systems

Nathan Chancellor (1):
      thunderbolt: Make priority unsigned in struct tb_path

Oded Gabbay (24):
      habanalabs: rename goya_non_fatal_events array to all events
      habanalabs: use EQ MSI/X ID per chip
      habanalabs: remove unused defines
      habanalabs: ratelimit warnings at start of IOCTLs
      uapi/habanalabs: add some comments in habanalabs.h
      habanalabs: keep track of the device's dma mask
      habanalabs: never fail hard reset of device
      habanalabs: improve error messages
      habanalabs: remove trailing blank line from EOF
      habanalabs: prevent CPU soft lockup on Palladium
      habanalabs: remove extra semicolon
      uapi/habanalabs: fix some comments in uapi file
      habanalabs: refactoring in goya.c
      habanalabs: ASIC_AUTO_DETECT enum value is redundant
      habanalabs: split mmu/no-mmu code paths in memory ioctl
      habanalabs: all FD must be closed before removing device
      habanalabs: improve IOCTLs behavior when disabled or reset
      habanalabs: prevent device PTE read/write during hard-reset
      habanalabs: re-factor goya_parse_cb_no_ext_queue()
      uapi/habanalabs: add missing fields in bmon params
      habanalabs: use ASIC functions interface for rreg/wreg
      habanalabs: rename restore to ctx_switch when appropriate
      habanalabs: return old dram bar address upon change
      habanalabs: rename functions to improve code readability

Omer Shpigelman (3):
      habanalabs: add MMU shadow mapping
      habanalabs: add new IOCTL for debug, tracing and profiling
      habanalabs: add goya implementation for debug configuration

Ondrej Jirman (2):
      dt-bindings: gnss: add u-blox,neo-6m compatible
      gnss: ubx: add u-blox,neo-6m compatible

Patrick Venture (4):
      dt-bindings: misc: aspeed-p2a-ctrl: add support
      drivers/misc: Add Aspeed P2A control driver
      drivers/misc: Add Aspeed P2A control driver
      misc: aspeed-p2a-ctrl: fix mixed declarations

Paul Gortmaker (1):
      soundwire: intel: fix implicit header use of module.h/export.h

Pierre-Louis Bossart (25):
      soundwire: intel: fix inversion in devm_kcalloc parameters
      soundwire: remove useless initializations
      soundwire: stream: remove useless initialization of local variable
      soundwire: Kconfig: fix help format
      soundwire: fix SPDX license for header files
      soundwire: fix alignment issues in header files
      soundwire: bus: fix alignment issues
      soundwire: bus: fix typos in comments
      soundwire: bus: remove useless parentheses
      soundwire: bus: fix boolean comparisons
      soundwire: bus: remove spurious newline
      soundwire: bus_type: fix alignment issues
      soundwire: mipi_disco: fix alignment issues
      soundwire: mipi_disco: fix boolean comparisons
      soundwire: stream: fix alignment issues
      soundwire: slave: fix alignment issues
      soundwire: intel_init: fix alignment issues
      soundwire: intel: fix alignment issues
      soundwire: intel: protect macro parameters
      soundwire: intel: fix boolean comparison
      soundwire: cadence_master: fix alignment issues
      soundwire: cadence_master: balance parentheses
      soundwire: cadence_master: fix boolean comparisons
      soundwire: cadence_master: remove spurious newline
      soundwire: add missing newlines in dynamic debug logs

Srinivas Kandagatla (7):
      misc: fastrpc: make sure memory read and writes are visible
      misc: fastrpc: use correct spinlock variant
      misc: fastrpc: consider address offset before sending to DSP
      misc: fastrpc: take into account of overlapping buffers
      misc: fastrpc: fix remote page size calculation
      misc: fastrpc: increase max init file size to 64 MB
      nvmem: core: add NVMEM_SYSFS Kconfig

Stephen Boyd (1):
      firmware: vpd: Drop __iomem usage for memremap() memory

Stephen Rothwell (1):
      lib/siphash.c: mark expected switch fall-throughs

Suzuki K Poulose (10):
      coresight: tmc: Report DMA setup failures
      coresight: dynamic-replicator: Clean up error handling
      coresight: replicator: Prepare for merging with dynamic-replicator
      coresight: dynamic-replicator: Prepare for merging with static replicator
      coresight: Merge the static and dynamic replicator drivers
      coresight: Fix freeing up the coresight connections
      coresight: etb10: Cleanup power management
      coresight: tpiu: Cleanup power management
      coresight: catu: Cleanup power management
      coresight: tmc: Cleanup power management

Thierry Escande (2):
      misc: fastrpc: Avoid free of DMA buffer in interrupt context
      misc: fastrpc: Fix a possible double free

Todd Kjos (1):
      binder: check for overflow when alloc for security context

Tomas Winkler (6):
      mei: add missing SPDX tag to mei Kconfig
      mei: convert to SPDX license tags
      nfc/mei: convert to SPDX license tags
      mei/hdcp: Fix SPDX identifiers
      mei: adjust the copyright notice in the files.
      mei: hdcp: use own Kconfig file

Tomer Tayar (10):
      habanalabs: Move device CPU code into common file
      habanalabs: Move PCI code into common file
      habanalabs: Remove unneeded function pointers
      habanalabs: Add a printout with the name of a busy engine
      habanalabs: Allow accessing DRAM virtual addresses via debugfs
      habanalabs: Cancel pr_fmt() definition dependency on includes order
      habanalabs: Use single pool for CPU accessible host memory
      habanalabs: Manipulate DMA addresses in ASIC functions
      habanalabs: Update CPU DMA pool label name
      habanalabs: Update CPU DMA memory label name

Valdis Kletnieks (1):
      extcon: Fix build warning for extcon_unregister_notifier comment

Vinod Koul (14):
      soundwire: intel: fix SPDX license for header file
      soundwire: fix kconfig help format
      soundwire: fix SPDX license for header files
      soundwire: remove empty line before/after braces
      soundwire: cadence: remove empty line after braces
      soundwire: intel: remove empty line after braces
      soundwire: add argument to function definition
      soundwire: more alignment fixes
      soundwire: intel: more alignment fixes
      soundwire: avoid multiple assignments
      soundwire: fix more typos
      soundwire: wrap macro argument in parenthesis
      soundwire: add a blank line between functions
      soundwire: remove multiple blank lines

Vishnu DASA (1):
      VMCI: Use BIT() macro for bit definitions

Yangtao Li (5):
      interconnect: convert to DEFINE_SHOW_ATTRIBUTE
      nvmem: sunxi-sid: fix wrong description in kernel doc
      nvmem: sunxi-sid: add binding for H6's SID controller
      nvmem: sunxi-sid: convert to SPDX license tags
      nvmem: sunxi_sid: Support SID on H6

Yauhen Kharuzhy (2):
      extcon: intel-cht-wc: Make charger detection co-existed with OTG host mode
      extcon: intel-cht-wc: Enable external charger

Young Xiao (1):
      Drivers: misc: fix out-of-bounds access in function param_set_kgdbts_var

YueHaibing (4):
      parport_cs: Fix memory leak in parport_config
      uio: uio_fsl_elbc_gpcm: Make dev_attr_reg_br and dev_attr_reg_or static
      extcon: axp288: Add a depends on ACPI to the Kconfig entry
      coresight: catu: Make catu_helper_ops and catu_ops static

 Documentation/ABI/stable/sysfs-bus-nvmem           |    2 +
 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |    8 +
 Documentation/ABI/testing/sysfs-class-mei          |   15 +
 .../devicetree/bindings/arm/coresight.txt          |   60 +-
 Documentation/devicetree/bindings/gnss/u-blox.txt  |    1 +
 .../devicetree/bindings/misc/aspeed-p2a-ctrl.txt   |   47 +
 .../bindings/nvmem/allwinner,sunxi-sid.txt         |    3 +-
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |    4 +-
 .../devicetree/bindings/nvmem/st,stm32-romem.txt   |   31 +
 Documentation/trace/intel_th.rst                   |    2 +
 MAINTAINERS                                        |    1 +
 drivers/android/binder.c                           |   12 +-
 drivers/char/hpet.c                                |    2 +
 drivers/extcon/Kconfig                             |    9 +-
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/devres.c                            |    2 +-
 drivers/extcon/extcon-arizona.c                    |   10 +
 drivers/extcon/extcon-intel-cht-wc.c               |   81 +-
 drivers/extcon/extcon-intel-mrfld.c                |  284 +++++
 drivers/extcon/extcon-intel.h                      |   20 +
 drivers/firmware/google/vpd.c                      |    4 +-
 drivers/gnss/ubx.c                                 |    1 +
 drivers/hwtracing/coresight/Kconfig                |    9 +-
 drivers/hwtracing/coresight/Makefile               |    1 -
 drivers/hwtracing/coresight/coresight-catu.c       |    7 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    5 -
 .../coresight/coresight-dynamic-replicator.c       |  255 -----
 drivers/hwtracing/coresight/coresight-etb10.c      |   97 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   37 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  114 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  116 +-
 drivers/hwtracing/coresight/coresight-replicator.c |  238 +++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   82 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  266 ++++-
 drivers/hwtracing/coresight/coresight-tmc.c        |   17 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   12 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |   18 +-
 drivers/hwtracing/coresight/coresight.c            |   29 +-
 drivers/hwtracing/intel_th/acpi.c                  |   10 +-
 drivers/hwtracing/intel_th/core.c                  |  139 ++-
 drivers/hwtracing/intel_th/gth.c                   |  125 +-
 drivers/hwtracing/intel_th/gth.h                   |   19 +
 drivers/hwtracing/intel_th/intel_th.h              |   30 +-
 drivers/hwtracing/intel_th/msu.c                   |  407 +++++--
 drivers/hwtracing/intel_th/msu.h                   |   10 +-
 drivers/hwtracing/intel_th/pci.c                   |   32 +-
 drivers/interconnect/core.c                        |   13 +-
 drivers/misc/Kconfig                               |    8 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/aspeed-p2a-ctrl.c                     |  444 +++++++
 drivers/misc/cardreader/rts5260.c                  |    4 +-
 drivers/misc/fastrpc.c                             |  235 +++-
 drivers/misc/genwqe/card_debugfs.c                 |    4 +-
 drivers/misc/habanalabs/Makefile                   |    2 +-
 drivers/misc/habanalabs/command_buffer.c           |   13 +-
 drivers/misc/habanalabs/command_submission.c       |   22 +-
 drivers/misc/habanalabs/context.c                  |    4 +-
 drivers/misc/habanalabs/debugfs.c                  |   96 +-
 drivers/misc/habanalabs/device.c                   |   93 +-
 drivers/misc/habanalabs/firmware_if.c              |  322 ++++++
 drivers/misc/habanalabs/goya/Makefile              |    3 +-
 drivers/misc/habanalabs/goya/goya.c                | 1209 ++++++--------------
 drivers/misc/habanalabs/goya/goyaP.h               |   81 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |  628 ++++++++++
 drivers/misc/habanalabs/goya/goya_security.c       |   15 +-
 drivers/misc/habanalabs/habanalabs.h               |  220 +++-
 drivers/misc/habanalabs/habanalabs_drv.c           |    9 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  139 ++-
 drivers/misc/habanalabs/hw_queue.c                 |   46 +-
 drivers/misc/habanalabs/include/armcp_if.h         |    2 -
 .../include/goya/asic_reg/cpu_ca53_cfg_masks.h     |    1 -
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h      |    1 -
 .../habanalabs/include/goya/asic_reg/cpu_if_regs.h |    1 -
 .../include/goya/asic_reg/cpu_pll_regs.h           |    1 -
 .../include/goya/asic_reg/dma_ch_0_regs.h          |    1 -
 .../include/goya/asic_reg/dma_ch_1_regs.h          |    1 -
 .../include/goya/asic_reg/dma_ch_2_regs.h          |    1 -
 .../include/goya/asic_reg/dma_ch_3_regs.h          |    1 -
 .../include/goya/asic_reg/dma_ch_4_regs.h          |    1 -
 .../include/goya/asic_reg/dma_macro_masks.h        |    1 -
 .../include/goya/asic_reg/dma_macro_regs.h         |    1 -
 .../include/goya/asic_reg/dma_nrtr_masks.h         |    1 -
 .../include/goya/asic_reg/dma_nrtr_regs.h          |    1 -
 .../include/goya/asic_reg/dma_qm_0_masks.h         |    1 -
 .../include/goya/asic_reg/dma_qm_0_regs.h          |    1 -
 .../include/goya/asic_reg/dma_qm_1_regs.h          |    1 -
 .../include/goya/asic_reg/dma_qm_2_regs.h          |    1 -
 .../include/goya/asic_reg/dma_qm_3_regs.h          |    1 -
 .../include/goya/asic_reg/dma_qm_4_regs.h          |    1 -
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |   12 -
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |    3 +-
 .../habanalabs/include/goya/asic_reg/ic_pll_regs.h |    1 -
 .../habanalabs/include/goya/asic_reg/mc_pll_regs.h |    1 -
 .../include/goya/asic_reg/mme1_rtr_masks.h         |    1 -
 .../include/goya/asic_reg/mme1_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme2_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme3_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme4_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme5_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme6_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/mme_cmdq_masks.h         |    1 -
 .../include/goya/asic_reg/mme_cmdq_regs.h          |    1 -
 .../habanalabs/include/goya/asic_reg/mme_masks.h   |    1 -
 .../include/goya/asic_reg/mme_qm_masks.h           |    1 -
 .../habanalabs/include/goya/asic_reg/mme_qm_regs.h |    1 -
 .../habanalabs/include/goya/asic_reg/mme_regs.h    |    1 -
 .../habanalabs/include/goya/asic_reg/mmu_masks.h   |    1 -
 .../habanalabs/include/goya/asic_reg/mmu_regs.h    |    1 -
 .../include/goya/asic_reg/pci_nrtr_masks.h         |    1 -
 .../include/goya/asic_reg/pci_nrtr_regs.h          |    1 -
 .../include/goya/asic_reg/pcie_aux_regs.h          |    1 -
 .../include/goya/asic_reg/pcie_wrap_regs.h         |  306 +++++
 .../include/goya/asic_reg/psoc_emmc_pll_regs.h     |    1 -
 .../include/goya/asic_reg/psoc_global_conf_masks.h |    1 -
 .../include/goya/asic_reg/psoc_global_conf_regs.h  |    1 -
 .../include/goya/asic_reg/psoc_mme_pll_regs.h      |    1 -
 .../include/goya/asic_reg/psoc_pci_pll_regs.h      |    1 -
 .../include/goya/asic_reg/psoc_spi_regs.h          |    1 -
 .../include/goya/asic_reg/sram_y0_x0_rtr_regs.h    |    1 -
 .../include/goya/asic_reg/sram_y0_x1_rtr_regs.h    |    1 -
 .../include/goya/asic_reg/sram_y0_x2_rtr_regs.h    |    1 -
 .../include/goya/asic_reg/sram_y0_x3_rtr_regs.h    |    1 -
 .../include/goya/asic_reg/sram_y0_x4_rtr_regs.h    |    1 -
 .../habanalabs/include/goya/asic_reg/stlb_masks.h  |    1 -
 .../habanalabs/include/goya/asic_reg/stlb_regs.h   |    1 -
 .../include/goya/asic_reg/tpc0_cfg_masks.h         |    1 -
 .../include/goya/asic_reg/tpc0_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc0_cmdq_masks.h        |    1 -
 .../include/goya/asic_reg/tpc0_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc0_eml_cfg_masks.h     |    1 -
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h      |    1 -
 .../include/goya/asic_reg/tpc0_nrtr_masks.h        |    1 -
 .../include/goya/asic_reg/tpc0_nrtr_regs.h         |    1 -
 .../include/goya/asic_reg/tpc0_qm_masks.h          |    1 -
 .../include/goya/asic_reg/tpc0_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc1_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc1_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc1_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc1_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc2_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc2_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc2_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc2_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc3_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc3_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc3_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc3_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc4_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc4_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc4_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc4_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc5_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc5_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc5_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc5_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc6_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc6_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc6_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc6_rtr_regs.h          |    1 -
 .../include/goya/asic_reg/tpc7_cfg_regs.h          |    1 -
 .../include/goya/asic_reg/tpc7_cmdq_regs.h         |    1 -
 .../include/goya/asic_reg/tpc7_nrtr_regs.h         |    1 -
 .../include/goya/asic_reg/tpc7_qm_regs.h           |    1 -
 .../include/goya/asic_reg/tpc_pll_regs.h           |    1 -
 drivers/misc/habanalabs/include/goya/goya.h        |    4 -
 .../habanalabs/include/goya/goya_async_events.h    |    9 +
 .../misc/habanalabs/include/goya/goya_coresight.h  |  199 ++++
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |    2 +
 drivers/misc/habanalabs/include/hl_boot_if.h       |    3 +-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   16 +-
 .../habanalabs/include/hw_ip/pci/pci_general.h     |   23 +
 drivers/misc/habanalabs/irq.c                      |   14 +-
 drivers/misc/habanalabs/memory.c                   |  197 ++--
 drivers/misc/habanalabs/mmu.c                      |  600 +++++-----
 drivers/misc/habanalabs/pci.c                      |  408 +++++++
 drivers/misc/kgdbts.c                              |    4 +-
 drivers/misc/mei/Kconfig                           |   12 +-
 drivers/misc/mei/Makefile                          |    2 +-
 drivers/misc/mei/bus-fixup.c                       |   14 +-
 drivers/misc/mei/bus.c                             |   13 +-
 drivers/misc/mei/client.c                          |   16 +-
 drivers/misc/mei/client.h                          |   14 +-
 drivers/misc/mei/debugfs.c                         |   15 +-
 drivers/misc/mei/dma-ring.c                        |    2 +-
 drivers/misc/mei/hbm.c                             |   15 +-
 drivers/misc/mei/hbm.h                             |   14 +-
 drivers/misc/mei/hdcp/Kconfig                      |   13 +
 drivers/misc/mei/hdcp/Makefile                     |    2 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |    2 +-
 drivers/misc/mei/hdcp/mei_hdcp.h                   |    2 +-
 drivers/misc/mei/hw-me-regs.h                      |   68 +-
 drivers/misc/mei/hw-me.c                           |   14 +-
 drivers/misc/mei/hw-me.h                           |   16 +-
 drivers/misc/mei/hw-txe-regs.h                     |   63 +-
 drivers/misc/mei/hw-txe.c                          |   14 +-
 drivers/misc/mei/hw-txe.h                          |   14 +-
 drivers/misc/mei/hw.h                              |   14 +-
 drivers/misc/mei/init.c                            |   34 +-
 drivers/misc/mei/interrupt.c                       |   15 +-
 drivers/misc/mei/main.c                            |   80 +-
 drivers/misc/mei/mei-trace.c                       |   14 +-
 drivers/misc/mei/mei-trace.h                       |   14 +-
 drivers/misc/mei/mei_dev.h                         |   17 +-
 drivers/misc/mei/pci-me.c                          |   15 +-
 drivers/misc/mei/pci-txe.c                         |   14 +-
 drivers/misc/sgi-xp/xpc_uv.c                       |    1 +
 drivers/net/thunderbolt.c                          |    3 +
 drivers/nfc/mei_phy.c                              |   18 +-
 drivers/nfc/microread/mei.c                        |   17 +-
 drivers/nfc/pn544/mei.c                            |   15 +-
 drivers/nvmem/Kconfig                              |   24 +-
 drivers/nvmem/Makefile                             |    5 +
 drivers/nvmem/core.c                               |  316 +----
 drivers/nvmem/imx-iim.c                            |    4 +-
 drivers/nvmem/imx-ocotp.c                          |   11 +-
 drivers/nvmem/mxs-ocotp.c                          |    4 +-
 drivers/nvmem/nvmem-sysfs.c                        |  256 +++++
 drivers/nvmem/nvmem.h                              |   62 +
 drivers/nvmem/stm32-romem.c                        |  202 ++++
 drivers/nvmem/sunxi_sid.c                          |  115 +-
 drivers/parport/ieee1284.c                         |    2 +-
 drivers/parport/parport_cs.c                       |    5 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |    4 +
 drivers/soundwire/Kconfig                          |    4 +-
 drivers/soundwire/bus.c                            |  152 ++-
 drivers/soundwire/bus.h                            |   16 +-
 drivers/soundwire/bus_type.c                       |    4 +-
 drivers/soundwire/cadence_master.c                 |  100 +-
 drivers/soundwire/cadence_master.h                 |   22 +-
 drivers/soundwire/intel.c                          |  138 +--
 drivers/soundwire/intel.h                          |    4 +-
 drivers/soundwire/intel_init.c                     |   15 +-
 drivers/soundwire/mipi_disco.c                     |  122 +-
 drivers/soundwire/slave.c                          |   10 +-
 drivers/soundwire/stream.c                         |  285 ++---
 drivers/thunderbolt/Makefile                       |    4 +-
 drivers/thunderbolt/cap.c                          |   85 +-
 drivers/thunderbolt/ctl.c                          |    2 +-
 drivers/thunderbolt/icm.c                          |   65 +-
 drivers/thunderbolt/lc.c                           |  179 +++
 drivers/thunderbolt/nhi.c                          |    3 +-
 drivers/thunderbolt/path.c                         |  420 ++++++-
 drivers/thunderbolt/property.c                     |   16 +-
 drivers/thunderbolt/switch.c                       |  557 +++++++--
 drivers/thunderbolt/tb.c                           |  608 +++++++---
 drivers/thunderbolt/tb.h                           |  227 +++-
 drivers/thunderbolt/tb_msgs.h                      |   11 +
 drivers/thunderbolt/tb_regs.h                      |   50 +-
 drivers/thunderbolt/tunnel.c                       |  691 +++++++++++
 drivers/thunderbolt/tunnel.h                       |   78 ++
 drivers/thunderbolt/tunnel_pci.c                   |  226 ----
 drivers/thunderbolt/tunnel_pci.h                   |   31 -
 drivers/thunderbolt/xdomain.c                      |  170 ++-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    4 +-
 drivers/virt/vboxguest/vboxguest_core.c            |   31 +
 drivers/w1/masters/ds2482.c                        |   18 +-
 drivers/w1/slaves/w1_ds2408.c                      |   76 +-
 drivers/w1/w1_io.c                                 |    3 +-
 fs/char_dev.c                                      |   78 +-
 include/linux/coresight-pmu.h                      |    2 +
 include/linux/coresight.h                          |    7 +-
 include/linux/mei_cl_bus.h                         |    3 +
 include/linux/nvmem-consumer.h                     |    7 +
 include/linux/soundwire/sdw.h                      |   16 +-
 include/linux/soundwire/sdw_intel.h                |    6 +-
 include/linux/soundwire/sdw_registers.h            |    5 +-
 include/linux/soundwire/sdw_type.h                 |    6 +-
 include/linux/thunderbolt.h                        |    8 +
 include/linux/vmw_vmci_defs.h                      |   35 +-
 include/uapi/linux/aspeed-p2a-ctrl.h               |   62 +
 include/uapi/linux/mei.h                           |   67 +-
 include/uapi/misc/habanalabs.h                     |  161 ++-
 lib/siphash.c                                      |   36 +-
 tools/include/linux/coresight-pmu.h                |    2 +
 274 files changed, 10394 insertions(+), 4319 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 drivers/extcon/extcon-intel-mrfld.c
 create mode 100644 drivers/extcon/extcon-intel.h
 delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
 create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
 create mode 100644 drivers/misc/habanalabs/firmware_if.c
 create mode 100644 drivers/misc/habanalabs/goya/goya_coresight.c
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_wrap_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/pci/pci_general.h
 create mode 100644 drivers/misc/habanalabs/pci.c
 create mode 100644 drivers/misc/mei/hdcp/Kconfig
 create mode 100644 drivers/nvmem/nvmem-sysfs.c
 create mode 100644 drivers/nvmem/nvmem.h
 create mode 100644 drivers/nvmem/stm32-romem.c
 create mode 100644 drivers/thunderbolt/lc.c
 create mode 100644 drivers/thunderbolt/tunnel.c
 create mode 100644 drivers/thunderbolt/tunnel.h
 delete mode 100644 drivers/thunderbolt/tunnel_pci.c
 delete mode 100644 drivers/thunderbolt/tunnel_pci.h
 create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h
