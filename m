Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D57C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547520661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551868412;
	bh=z7N0rXGeWkhA3+7dunPzFErviceofJ/q/kbBD6UrwZo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NAL7Crj82h6p2VT1Lw3Ma/XzTq221plio2dqq2hpi2A7lv2/NQdCFf4P4w/RwzD4u
	 4ypqLj9jxclcsDuq+THpjcRSPOVxfnlD8Iu6oGrFrY5y9Q8ynZ1EdAQxfdRlO+wgsL
	 uxaTF/p+/KACTHnDBJDQ69joH/YSV0HKBOtvoZkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfCFKda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCFKd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:33:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABEE20661;
        Wed,  6 Mar 2019 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551868406;
        bh=z7N0rXGeWkhA3+7dunPzFErviceofJ/q/kbBD6UrwZo=;
        h=Date:From:To:Cc:Subject:From;
        b=KU+gLy9aZyMrFMdjsAsauwaD4wQzS1zrGrcvRct5w+CjNKKMwqSgu/Auk16iMyRlc
         GtrUPyQ7ELNlx+YdgtAAhNT3kaqlKazX9AZ+zSHeI/Cy0ypkHBt2Kl0MmKe8xuYrsP
         g1N2YKStt5LDQ4Vd0IEuEWvG+b61ayqhnJSlMuBM=
Date:   Wed, 6 Mar 2019 11:33:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.1-rc1
Message-ID: <20190306103324.GA10412@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.1-rc1

for you to fetch changes up to 142a0f83b216a607aebed42e54a1be620765e28c:

  habanalabs: adjust Kconfig to fix build errors (2019-03-02 12:03:56 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 5.1-rc1

Here is the big char/misc driver patch pull request for 5.1-rc1.

The largest thing by far is the new habanalabs driver for their AI
accelerator chip.  For now it is in the drivers/misc directory but will
probably move to a new directory soon along with other drivers of this
type.

Other than that, just the usual set of individual driver updates and
fixes.  There's an "odd" merge in here from the DRM tree that they asked
me to do as the MEI driver is starting to interact with the i915 driver,
and it needed some coordination.  All of those patches have been
properly acked by the relevant subsystem maintainers.

All of these have been in linux-next with no reported issues, most for
quite some time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (1):
      misc/ics932s401: Add a missing check to i2c_smbus_read_word_data

Alan Tull (1):
      fpga: altera_freeze_bridge: remove restriction to socfpga

Alban Bedel (7):
      nvmem: core: Set the provider read-only when no write callback is given
      nvmem: core: Fix of_nvmem_cell_get() for optional cells
      nvmem: core: Fix cell lookup when no cell is found
      nvmem: core: Properly handle connection ID in of_nvmem_device_get()
      nvmem: core: Always reference the device returned by nvmem_device_get()
      nvmem: core: Fix device reference leak
      nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()

Alexander Kapshuk (1):
      ver_linux: Assign constant RE to variable name for clarity

Alexander Shishkin (5):
      intel_th: Update ABI documentation
      intel_th: Only create useful device nodes
      intel_th: Don't reference unassigned outputs
      stm class: Prevent division by zero
      intel_th: gth: Fix an off-by-one in output unassigning

Alexander Usyskin (3):
      mei: squash single_recv_buf into one bit in client properties
      mei: hbm: clean the feature flags on link reset
      mei: bus: move hw module get/put to probe/release

Andreas Kemnade (5):
      gnss: sirf: write data to gnss only when the gnss device is open
      gnss: sirf: add support for configurations without wakeup signal
      dt-bindings: gnss: add w2sg0004 compatible string
      gnss: sirf: add a separate supply for a lna
      dt-bindings: gnss: add lna-supply property

Andy Shevchenko (2):
      vmbus: Switch to use new generic UUID API
      intel_th: pti: Use sysfs_match_string() helper

Anson Huang (2):
      dt-bindings: nvmem: imx-ocotp: add compatible string for i.MX7ULP
      nvmem: imx-ocotp: add i.MX7ULP support

Bartosz Golaszewski (1):
      nvmem: core: don't check the return value of notifier chain call

Buland Singh (1):
      hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

Chengguang Xu (2):
      uio: fix potential memory leak in error case
      uio: remove redundant check

Christophe Leroy (2):
      lkdtm: Print real addresses
      lkdtm: Add tests for NULL pointer dereference

Colin Ian King (2):
      drivers: misc: ad525x_dpot: clean indentation issue, remove tabs
      fpga: mgr: altera-ps-spi: make array dummy static, shrinks object size

Dan Carpenter (1):
      vmw_balloon: release lock on error in vmballoon_reset()

Daniel Vetter (4):
      component: Add documentation
      components: multiple components for a device
      i915/snd_hdac: I915 subcomponent for the snd_hdac
      Pull in char-misc-next from Greg

David Dai (2):
      interconnect: qcom: Add sdm845 interconnect provider driver
      arm64: dts: sdm845: Add interconnect provider DT nodes

Finn Thain (22):
      scsi/atari_scsi: Don't select CONFIG_NVRAM
      m68k/atari: Move Atari-specific code out of drivers/char/nvram.c
      char/nvram: Re-order functions to remove forward declarations and #ifdefs
      nvram: Replace nvram_* function exports with static functions
      m68k/atari: Implement arch_nvram_ops struct
      powerpc: Replace nvram_* extern declarations with standard header
      char/nvram: Adopt arch_nvram_ops
      char/nvram: Allow the set_checksum and initialize ioctls to be omitted
      char/nvram: Implement NVRAM read/write methods
      m68k/atari: Implement arch_nvram_ops methods and enable CONFIG_HAVE_ARCH_NVRAM_OPS
      m68k/mac: Adopt naming and calling conventions for PRAM routines
      m68k/mac: Use macros for RTC accesses not magic numbers
      m68k/mac: Fix PRAM accessors
      macintosh/via-cuda: Don't rely on Cuda to end a transfer
      m68k: Dispatch nvram_ops calls to Atari or Mac functions
      char/nvram: Add "devname:nvram" module alias
      powerpc: Define missing ppc_md.nvram_size for CHRP and PowerMac
      powerpc: Implement nvram ioctls
      powerpc, fbdev: Use NV_CMODE and NV_VMODE only when CONFIG_PPC32 && CONFIG_PPC_PMAC && CONFIG_NVRAM
      powerpc: Enable HAVE_ARCH_NVRAM_OPS and disable GENERIC_NVRAM
      char/generic_nvram: Remove as unused
      powerpc: Adopt nvram module for PPC64

Freeman Liu (1):
      nvmem: sc27xx: Convert nvmem offset to block index

Georgi Djakov (6):
      interconnect: Add generic on-chip interconnect API
      dt-bindings: Introduce interconnect binding
      interconnect: Allow endpoints translation via DT
      interconnect: Add debugfs support
      MAINTAINERS: add a maintainer for the interconnect API
      interconnect: Revert to previous config if any request fails

Greg Kroah-Hartman (9):
      Merge tag 'lkdtm-next' of https://git.kernel.org/.../kees/linux into char-misc-next
      Merge 5.0-rc4 into char-misc-next
      Revert "arm64: dts: sdm845: Add interconnect provider DT nodes"
      Merge 5.0-rc6 into char-misc-next
      Merge tag 'extcon-next-for-5.1' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'intel_th-stm-for-greg-20190221' of git://git.kernel.org/.../ash/stm into char-misc-next
      Merge tag 'gnss-5.1-rc1' of https://git.kernel.org/.../johan/gnss into char-misc-next
      Merge tag 'topic/mei-hdcp-2019-02-26' of git://anongit.freedesktop.org/drm/drm-intel into char-misc-next
      Merge tag 'hyperv-next-signed' of git://git.kernel.org/.../hyperv/linux into char-misc-next

Gustavo A. R. Silva (7):
      misc: enclosure: Use struct_size() in kzalloc()
      applicom: Fix potential Spectre v1 vulnerabilities
      char: lp: mark expected switch fall-through
      intel_th: Mark expected switch fall-throughs
      hpet: Use struct_size() in kzalloc()
      misc: mic/scif: mark expected switch fall-through
      virt: vbox: Mark expected switch fall-through

Haiyang Zhang (1):
      MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS

Johan Hovold (3):
      gnss: sirf: fix premature wakeup interrupt enable
      gnss: sirf: force hibernate mode on probe
      gnss: sirf: drop redundant double negation

Jordan Crouse (1):
      drm/msm/a6xx: Add support for an interconnect path

Kees Cook (1):
      lkdtm: Do not depend on BLOCK and clean up headers

Kimberly Brown (2):
      Drivers: hv: vmbus: Expose counters for interrupts and full conditions
      Drivers: hv: vmbus: Change server monitor_pages index to 0

Leo Yan (1):
      coresight: cpu-debug: Support for CA73 CPUs

Liu Jian (2):
      driver: uio: fix possible memory leak in __uio_register_device
      driver: uio: fix possible use-after-free in __uio_register_device

Logan Gunthorpe (6):
      iomap: Use non-raw io functions for io{read|write}XXbe
      parisc: iomap: introduce io{read|write}64
      iomap: introduce io{read|write}64_{lo_hi|hi_lo}
      io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
      ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
      ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common header

Loys Ollivier (4):
      dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
      dt-bindings: gnss: add mediatek binding
      gnss: add mtk receiver type support
      gnss: add driver for mediatek receivers

Mathieu Poirier (3):
      perf/aux: Make perf_event accessible to setup_aux()
      coresight: perf: Add "sinks" group to PMU directory
      coresight: Use event attributes for sink selection

Matt Hsiao (2):
      misc: hpilo: Exclude unsupported device via blacklist
      misc: hpilo: Do not claim unsupported hardware

Minchan Kim (1):
      binder: reduce mmap_sem write-side lock

Nadav Amit (1):
      vmw_balloon: remove the version number

Naveen Kumar Parna (2):
      efirtc: remove unnecessary code efi_rtc_open & efi_rtc_close
      mbcs: add .owner to mbcs struct file_operations

Oded Gabbay (33):
      habanalabs: add skeleton driver
      habanalabs: add Goya registers header files
      habanalabs: add basic Goya support
      habanalabs: add context and ASID modules
      habanalabs: add command buffer module
      habanalabs: add basic Goya h/w initialization
      habanalabs: add h/w queues module
      habanalabs: add event queue and interrupts
      habanalabs: add sysfs and hwmon support
      habanalabs: add device reset support
      habanalabs: add command submission module
      habanalabs: implement INFO IOCTL
      habanalabs: add debugfs support
      Update MAINTAINERS and CREDITS with habanalabs info
      habanalabs: don't print result when rc indicates error
      habanalabs: driver's Kconfig must select DMA_SHARED_BUFFER
      habanalabs: return error when failing to read/write i2c
      habanalabs: use u64 when comparing variables' sum to u32_max
      habanalabs: allow memory allocations larger than 4GB
      habanalabs: make functions static or declare them
      habanalabs: disable CPU access on timeouts
      habanalabs: fix mmu cache registers init
      habanalabs: fix validation of WREG32 to DMA completion
      habanalabs: set DMA0 completion to SOB 1007
      habanalabs: add comments in uapi/misc/habanalabs.h
      habanalabs: fix memory leak with CBs with unaligned size
      habanalabs: print pointer using %p
      habanalabs: soft-reset device if context-switch fails
      habanalabs: use NULL to initialize array of pointers
      habanalabs: fix little-endian<->cpu conversion warnings
      habanalabs: use do_div for 64-bit divisions
      habanalabs: use %px instead of %p in error print
      habanalabs: adjust Kconfig to fix build errors

Omer Shpigelman (4):
      habanalabs: add virtual memory and MMU modules
      habanalabs: add MMU DRAM default page mapping
      habanalabs: extend QMAN0 job timeout
      habanalabs: return correct error code on MMU mapping failure

Peng Hao (2):
      misc/mic/vop/vop_main : remove unneeded semicolon
      misc/sgi-gru/grufault: fix a style error

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Ramalingam C (19):
      drm/i915: enum port definition is moved into i915_drm.h
      drm/i915: header for i915 - MEI_HDCP interface
      drm/i915: MEI interface definition
      drm: helper functions for hdcp2 seq_num to from u32
      drm/audio: declaration of struct device
      misc/mei/hdcp: Client driver for HDCP application
      misc/mei/hdcp: Define ME FW interface for HDCP2.2
      misc/mei/hdcp: Initiate Wired HDCP2.2 Tx Session
      misc/mei/hdcp: Verify Receiver Cert and prepare km
      misc/mei/hdcp: Verify H_prime
      misc/mei/hdcp: Store the HDCP Pairing info
      misc/mei/hdcp: Initiate Locality check
      misc/mei/hdcp: Verify L_prime
      misc/mei/hdcp: Prepare Session Key
      misc/mei/hdcp: Repeater topology verification and ack
      misc/mei/hdcp: Verify M_prime
      misc/mei/hdcp: Enabling the HDCP authentication
      misc/mei/hdcp: Closing wired HDCP2.2 Tx Session
      misc/mei/hdcp: Component framework for I915 Interface

Randy Dunlap (1):
      misc/habanalabs: adjust Kconfig to fix build errors

RickyWu (1):
      misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260

Rob Herring (1):
      coresight: Use of_node_name_eq for node name comparisons

Roman Kiryanov (1):
      drivers: platform: goldfish: fix the checkpatch complain in Kconfig

Sai Prakash Ranjan (1):
      coresight: etm4x: Add support to enable ETMv4.2

Silvio Cesare (1):
      lkdtm: change snprintf to scnprintf for possible overflow

Srinath Mannam (1):
      nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP

Srinivas Kandagatla (10):
      slimbus: core: match full device id
      slimbus: core: do not call device_status under a lock
      slimbus: core: use slim_device_update_status() to update status
      slimbus: core: add missing spin_lock_init on txn_lock
      misc: dt-bindings: Add Qualcomm Fastrpc bindings
      misc: fastrpc: Add Qualcomm fastrpc basic driver model
      misc: fastrpc: Add support for context Invoke method
      misc: fastrpc: Add support for create remote init process
      misc: fastrpc: Add support for dmabuf exporter
      misc: fastrpc: select CONFIG_DMA_SHARED_BUFFER

Stefan Agner (1):
      nvmem: allow to select i.MX nvmem driver for i.MX 7D

Stefan Wahren (2):
      dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
      nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support

Sudip Mukherjee (1):
      parport: daisy: use new parport device model

Thierry Escande (1):
      misc: fastrpc: Fix device_open when no session is available

Todd Kjos (10):
      binder: create node flag to request sender's security context
      binder: create userspace-to-binder-buffer copy function
      binder: add functions to copy to/from binder buffers
      binder: add function to copy binder object from buffer
      binder: avoid kernel vm_area for buffer fixups
      binder: remove kernel vm_area for buffer space
      binder: remove user_buffer_offset
      binder: use userspace pointer as base of buffer space
      binder: fix sparse issue in binder_alloc_selftest.c
      binder: fix handling of misaligned binder object

Tomas Winkler (2):
      mei: bus: export to_mei_cl_device for mei client devices drivers
      mei: bus: whitelist hdcp client

Tomer Tayar (2):
      habanalabs: Dissociate RAZWI info from event types
      habanalabs: fix little-endian<->cpu conversion warnings

Venkatesh Srinivas (1):
      uio/uio_pci_generic: Disable bus-mastering on release

Vijai Kumar K (1):
      extcon: Add support for ptn5150 extcon driver

Vincent Whitchurch (7):
      vop: Use %z for size_t
      vop: Add definition of readq/writeq if missing
      vop: vringh: Do not crash if no DMA channel
      vop: Fix handling of >32 feature bits
      mic: vop: Cast pointers to unsigned long
      mic: Rename ioremap pointer to remap
      mic: vop: Allow building on more systems

Vishnu DASA (1):
      VMCI: Support upto 64-bit PPNs

Wei Yongjun (3):
      extcon: ptn5150: Fix return value check in ptn5150_i2c_probe()
      misc: fastrpc: Fix return value check in fastrpc_map_create()
      habanalabs: use GFP_ATOMIC under spin lock

Xavier Deguillard (1):
      vmw_balloon: support 64-bit memory limit

YueHaibing (1):
      coresight: stm: Remove set but not used variable 'res_size'

Zhi Jin (1):
      stm class: Fix an endless loop in channel allocation

 CREDITS                                            |    2 +-
 Documentation/ABI/stable/sysfs-bus-vmbus           |   33 +
 .../ABI/testing/debugfs-driver-habanalabs          |  126 +
 .../ABI/testing/sysfs-bus-intel_th-output-devices  |    6 +-
 Documentation/ABI/testing/sysfs-driver-habanalabs  |  190 +
 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |   27 +
 Documentation/devicetree/bindings/gnss/gnss.txt    |    1 +
 .../devicetree/bindings/gnss/mediatek.txt          |   35 +
 .../devicetree/bindings/gnss/sirfstar.txt          |    1 +
 .../bindings/interconnect/interconnect.txt         |   60 +
 .../bindings/interconnect/qcom,sdm845.txt          |   24 +
 .../devicetree/bindings/misc/qcom,fastrpc.txt      |   78 +
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |    4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/driver-api/component.rst             |   17 +
 Documentation/driver-api/device_link.rst           |    3 +
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/interconnect/interconnect.rst        |   94 +
 MAINTAINERS                                        |   21 +-
 arch/Kconfig                                       |    3 +
 arch/m68k/Kconfig.machine                          |    2 +
 arch/m68k/atari/Makefile                           |    2 +
 arch/m68k/atari/nvram.c                            |  272 +
 arch/m68k/include/asm/atarihw.h                    |    6 +
 arch/m68k/include/asm/macintosh.h                  |    4 +
 arch/m68k/kernel/setup_mm.c                        |   82 +-
 arch/m68k/mac/misc.c                               |  174 +-
 arch/parisc/include/asm/io.h                       |    9 +
 arch/parisc/lib/iomap.c                            |   64 +
 arch/powerpc/Kconfig                               |    6 +-
 arch/powerpc/include/asm/io.h                      |    2 +
 arch/powerpc/include/asm/nvram.h                   |    9 -
 arch/powerpc/kernel/nvram_64.c                     |  158 +-
 arch/powerpc/kernel/setup_32.c                     |   36 +-
 arch/powerpc/platforms/chrp/Makefile               |    2 +-
 arch/powerpc/platforms/chrp/nvram.c                |   14 +-
 arch/powerpc/platforms/chrp/setup.c                |    2 +-
 arch/powerpc/platforms/powermac/Makefile           |    2 -
 arch/powerpc/platforms/powermac/nvram.c            |    9 +
 arch/powerpc/platforms/powermac/setup.c            |    3 +-
 arch/powerpc/platforms/powermac/time.c             |    2 +-
 arch/powerpc/platforms/pseries/nvram.c             |    2 -
 arch/s390/kernel/perf_cpum_sf.c                    |    6 +-
 arch/x86/events/intel/bts.c                        |    4 +-
 arch/x86/events/intel/pt.c                         |    5 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/android/Kconfig                            |    2 +-
 drivers/android/binder.c                           |  556 +-
 drivers/android/binder_alloc.c                     |  303 +-
 drivers/android/binder_alloc.h                     |   47 +-
 drivers/android/binder_alloc_selftest.c            |    7 +-
 drivers/android/binder_trace.h                     |    2 +-
 drivers/base/component.c                           |  206 +-
 drivers/char/Kconfig                               |   19 +-
 drivers/char/Makefile                              |    6 +-
 drivers/char/applicom.c                            |   35 +-
 drivers/char/efirtc.c                              |   23 -
 drivers/char/generic_nvram.c                       |  159 -
 drivers/char/hpet.c                                |    9 +-
 drivers/char/lp.c                                  |    4 +-
 drivers/char/mbcs.c                                |    1 +
 drivers/char/nvram.c                               |  673 +--
 drivers/extcon/Kconfig                             |    8 +
 drivers/extcon/Makefile                            |    1 +
 drivers/extcon/extcon-ptn5150.c                    |  339 ++
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/altera-ps-spi.c                       |    2 +-
 drivers/gnss/Kconfig                               |   13 +
 drivers/gnss/Makefile                              |    3 +
 drivers/gnss/core.c                                |    1 +
 drivers/gnss/mtk.c                                 |  152 +
 drivers/gnss/sirf.c                                |  256 +-
 drivers/gpu/drm/i915/intel_audio.c                 |    4 +-
 drivers/gpu/drm/i915/intel_display.h               |   16 +-
 drivers/gpu/drm/msm/Kconfig                        |    1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   20 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    9 +
 drivers/gpu/drm/msm/msm_gpu.h                      |    3 +
 drivers/hv/channel.c                               |    4 +-
 drivers/hv/channel_mgmt.c                          |   18 +-
 drivers/hv/hyperv_vmbus.h                          |    4 +-
 drivers/hv/ring_buffer.c                           |   14 +-
 drivers/hv/vmbus_drv.c                             |   86 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  112 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |    6 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |    3 +-
 drivers/hwtracing/coresight/coresight-priv.h       |    1 +
 drivers/hwtracing/coresight/coresight-stm.c        |   12 +-
 drivers/hwtracing/coresight/coresight.c            |   60 +
 drivers/hwtracing/coresight/of_coresight.c         |    4 +-
 drivers/hwtracing/intel_th/core.c                  |    6 +-
 drivers/hwtracing/intel_th/gth.c                   |    4 +
 drivers/hwtracing/intel_th/pti.c                   |   16 +-
 drivers/hwtracing/intel_th/sth.c                   |    4 +
 drivers/hwtracing/stm/core.c                       |   11 +-
 drivers/interconnect/Kconfig                       |   15 +
 drivers/interconnect/Makefile                      |    6 +
 drivers/interconnect/core.c                        |  799 +++
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    5 +
 drivers/interconnect/qcom/sdm845.c                 |  838 +++
 drivers/macintosh/via-cuda.c                       |    8 +-
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    2 +
 drivers/misc/ad525x_dpot.c                         |   24 +-
 drivers/misc/cardreader/rts5227.c                  |   64 +-
 drivers/misc/cardreader/rts5249.c                  |   32 +-
 drivers/misc/cardreader/rts5260.c                  |  136 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |   40 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |    5 +
 drivers/misc/enclosure.c                           |    4 +-
 drivers/misc/fastrpc.c                             | 1401 +++++
 drivers/misc/habanalabs/Kconfig                    |   25 +
 drivers/misc/habanalabs/Makefile                   |   14 +
 drivers/misc/habanalabs/asid.c                     |   57 +
 drivers/misc/habanalabs/command_buffer.c           |  445 ++
 drivers/misc/habanalabs/command_submission.c       |  780 +++
 drivers/misc/habanalabs/context.c                  |  215 +
 drivers/misc/habanalabs/debugfs.c                  | 1077 ++++
 drivers/misc/habanalabs/device.c                   | 1140 +++++
 drivers/misc/habanalabs/goya/Makefile              |    3 +
 drivers/misc/habanalabs/goya/goya.c                | 5391 ++++++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h               |  211 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |  254 +
 drivers/misc/habanalabs/goya/goya_security.c       | 2999 +++++++++++
 drivers/misc/habanalabs/habanalabs.h               | 1464 ++++++
 drivers/misc/habanalabs/habanalabs_drv.c           |  461 ++
 drivers/misc/habanalabs/habanalabs_ioctl.c         |  234 +
 drivers/misc/habanalabs/hw_queue.c                 |  635 +++
 drivers/misc/habanalabs/hwmon.c                    |  458 ++
 drivers/misc/habanalabs/include/armcp_if.h         |  335 ++
 .../include/goya/asic_reg/cpu_ca53_cfg_masks.h     |  191 +
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h      |   61 +
 .../habanalabs/include/goya/asic_reg/cpu_if_regs.h |   49 +
 .../include/goya/asic_reg/cpu_pll_regs.h           |  105 +
 .../include/goya/asic_reg/dma_ch_0_regs.h          |  209 +
 .../include/goya/asic_reg/dma_ch_1_regs.h          |  209 +
 .../include/goya/asic_reg/dma_ch_2_regs.h          |  209 +
 .../include/goya/asic_reg/dma_ch_3_regs.h          |  209 +
 .../include/goya/asic_reg/dma_ch_4_regs.h          |  209 +
 .../include/goya/asic_reg/dma_macro_masks.h        |  105 +
 .../include/goya/asic_reg/dma_macro_regs.h         |  181 +
 .../include/goya/asic_reg/dma_nrtr_masks.h         |  209 +
 .../include/goya/asic_reg/dma_nrtr_regs.h          |  227 +
 .../include/goya/asic_reg/dma_qm_0_masks.h         |  465 ++
 .../include/goya/asic_reg/dma_qm_0_regs.h          |  179 +
 .../include/goya/asic_reg/dma_qm_1_regs.h          |  179 +
 .../include/goya/asic_reg/dma_qm_2_regs.h          |  179 +
 .../include/goya/asic_reg/dma_qm_3_regs.h          |  179 +
 .../include/goya/asic_reg/dma_qm_4_regs.h          |  179 +
 .../habanalabs/include/goya/asic_reg/goya_blocks.h | 1372 +++++
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |  275 +
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |  118 +
 .../habanalabs/include/goya/asic_reg/ic_pll_regs.h |  105 +
 .../habanalabs/include/goya/asic_reg/mc_pll_regs.h |  105 +
 .../include/goya/asic_reg/mme1_rtr_masks.h         |  653 +++
 .../include/goya/asic_reg/mme1_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme2_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme3_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme4_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme5_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme6_rtr_regs.h          |  331 ++
 .../include/goya/asic_reg/mme_cmdq_masks.h         |  373 ++
 .../include/goya/asic_reg/mme_cmdq_regs.h          |  139 +
 .../habanalabs/include/goya/asic_reg/mme_masks.h   | 1537 ++++++
 .../include/goya/asic_reg/mme_qm_masks.h           |  465 ++
 .../habanalabs/include/goya/asic_reg/mme_qm_regs.h |  179 +
 .../habanalabs/include/goya/asic_reg/mme_regs.h    | 1153 +++++
 .../habanalabs/include/goya/asic_reg/mmu_masks.h   |  143 +
 .../habanalabs/include/goya/asic_reg/mmu_regs.h    |   53 +
 .../include/goya/asic_reg/pci_nrtr_masks.h         |  209 +
 .../include/goya/asic_reg/pci_nrtr_regs.h          |  227 +
 .../include/goya/asic_reg/pcie_aux_regs.h          |  243 +
 .../include/goya/asic_reg/psoc_emmc_pll_regs.h     |  105 +
 .../include/goya/asic_reg/psoc_global_conf_masks.h |  447 ++
 .../include/goya/asic_reg/psoc_global_conf_regs.h  |  745 +++
 .../include/goya/asic_reg/psoc_mme_pll_regs.h      |  105 +
 .../include/goya/asic_reg/psoc_pci_pll_regs.h      |  105 +
 .../include/goya/asic_reg/psoc_spi_regs.h          |  143 +
 .../include/goya/asic_reg/sram_y0_x0_rtr_regs.h    |   83 +
 .../include/goya/asic_reg/sram_y0_x1_rtr_regs.h    |   83 +
 .../include/goya/asic_reg/sram_y0_x2_rtr_regs.h    |   83 +
 .../include/goya/asic_reg/sram_y0_x3_rtr_regs.h    |   83 +
 .../include/goya/asic_reg/sram_y0_x4_rtr_regs.h    |   83 +
 .../habanalabs/include/goya/asic_reg/stlb_masks.h  |  117 +
 .../habanalabs/include/goya/asic_reg/stlb_regs.h   |   55 +
 .../include/goya/asic_reg/tpc0_cfg_masks.h         | 1607 ++++++
 .../include/goya/asic_reg/tpc0_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc0_cmdq_masks.h        |  373 ++
 .../include/goya/asic_reg/tpc0_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc0_eml_cfg_masks.h     |  347 ++
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h      |  313 ++
 .../include/goya/asic_reg/tpc0_nrtr_masks.h        |  209 +
 .../include/goya/asic_reg/tpc0_nrtr_regs.h         |  227 +
 .../include/goya/asic_reg/tpc0_qm_masks.h          |  465 ++
 .../include/goya/asic_reg/tpc0_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc1_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc1_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc1_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc1_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc2_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc2_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc2_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc2_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc3_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc3_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc3_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc3_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc4_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc4_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc4_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc4_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc5_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc5_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc5_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc5_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc6_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc6_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc6_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc6_rtr_regs.h          |  323 ++
 .../include/goya/asic_reg/tpc7_cfg_regs.h          |  887 ++++
 .../include/goya/asic_reg/tpc7_cmdq_regs.h         |  139 +
 .../include/goya/asic_reg/tpc7_nrtr_regs.h         |  227 +
 .../include/goya/asic_reg/tpc7_qm_regs.h           |  179 +
 .../include/goya/asic_reg/tpc_pll_regs.h           |  105 +
 drivers/misc/habanalabs/include/goya/goya.h        |   45 +
 .../habanalabs/include/goya/goya_async_events.h    |  186 +
 drivers/misc/habanalabs/include/goya/goya_fw_if.h  |   28 +
 .../misc/habanalabs/include/goya/goya_packets.h    |  129 +
 drivers/misc/habanalabs/include/hl_boot_if.h       |   30 +
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   47 +
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
 drivers/misc/habanalabs/include/qman_if.h          |   56 +
 drivers/misc/habanalabs/irq.c                      |  327 ++
 drivers/misc/habanalabs/memory.c                   | 1723 +++++++
 drivers/misc/habanalabs/mmu.c                      |  906 ++++
 drivers/misc/habanalabs/sysfs.c                    |  539 ++
 drivers/misc/hpilo.c                               |   14 +-
 drivers/misc/ics932s401.c                          |    2 +
 drivers/misc/lkdtm/core.c                          |   15 +-
 drivers/misc/lkdtm/lkdtm.h                         |    2 +
 drivers/misc/lkdtm/perms.c                         |   36 +-
 drivers/misc/mei/Kconfig                           |   10 +
 drivers/misc/mei/Makefile                          |    2 +
 drivers/misc/mei/bus-fixup.c                       |   16 +
 drivers/misc/mei/bus.c                             |   22 +-
 drivers/misc/mei/hbm.c                             |    7 +
 drivers/misc/mei/hdcp/Makefile                     |    7 +
 drivers/misc/mei/hdcp/mei_hdcp.c                   |  849 +++
 drivers/misc/mei/hdcp/mei_hdcp.h                   |  377 ++
 drivers/misc/mei/hw.h                              |    3 +-
 drivers/misc/mic/Kconfig                           |    3 +-
 drivers/misc/mic/bus/scif_bus.h                    |    8 +-
 drivers/misc/mic/bus/vop_bus.h                     |    8 +-
 drivers/misc/mic/card/mic_device.c                 |    8 +-
 drivers/misc/mic/host/mic_boot.c                   |    8 +-
 drivers/misc/mic/scif/scif_map.h                   |    4 +-
 drivers/misc/mic/scif/scif_rma.c                   |    2 +-
 drivers/misc/mic/vop/vop_main.c                    |   29 +-
 drivers/misc/mic/vop/vop_vringh.c                  |   51 +-
 drivers/misc/sgi-gru/grufault.c                    |    4 +-
 drivers/misc/vmw_balloon.c                         |   24 +-
 drivers/misc/vmw_vmci/vmci_doorbell.c              |    9 +-
 drivers/misc/vmw_vmci/vmci_doorbell.h              |    2 +-
 drivers/misc/vmw_vmci/vmci_driver.h                |    2 +
 drivers/misc/vmw_vmci/vmci_guest.c                 |   39 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   63 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.h            |    4 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h                |   30 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |   36 +-
 drivers/nvmem/Kconfig                              |    2 +-
 drivers/nvmem/bcm-ocotp.c                          |   37 +-
 drivers/nvmem/core.c                               |   42 +-
 drivers/nvmem/imx-ocotp.c                          |   13 +
 drivers/nvmem/sc27xx-efuse.c                       |   12 +-
 drivers/parport/daisy.c                            |   32 +-
 drivers/parport/parport_pc.c                       |    2 +-
 drivers/parport/probe.c                            |    2 +-
 drivers/parport/share.c                            |   10 +-
 drivers/perf/arm_spe_pmu.c                         |    6 +-
 drivers/platform/goldfish/Kconfig                  |    4 +-
 drivers/scsi/Kconfig                               |    6 +-
 drivers/scsi/atari_scsi.c                          |   10 +-
 drivers/slimbus/core.c                             |   45 +-
 drivers/uio/uio.c                                  |   16 +-
 drivers/uio/uio_pci_generic.c                      |   17 +
 drivers/video/fbdev/Kconfig                        |    2 +-
 drivers/video/fbdev/controlfb.c                    |   42 +-
 drivers/video/fbdev/imsttfb.c                      |   23 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |    7 +-
 drivers/video/fbdev/platinumfb.c                   |   21 +-
 drivers/video/fbdev/valkyriefb.c                   |   30 +-
 drivers/virt/vboxguest/vboxguest_core.c            |    2 +-
 include/asm-generic/iomap.h                        |   22 +
 include/drm/drm_audio_component.h                  |    1 +
 include/drm/drm_hdcp.h                             |   18 +
 include/drm/i915_component.h                       |    5 +
 include/drm/i915_drm.h                             |   15 +
 include/drm/i915_mei_hdcp_interface.h              |  149 +
 include/dt-bindings/interconnect/qcom,sdm845.h     |  143 +
 include/linux/component.h                          |   76 +
 include/linux/coresight.h                          |    7 +-
 include/linux/gnss.h                               |    1 +
 include/linux/hyperv.h                             |  144 +-
 include/linux/interconnect-provider.h              |  142 +
 include/linux/interconnect.h                       |   59 +
 include/linux/io-64-nonatomic-hi-lo.h              |   64 +
 include/linux/io-64-nonatomic-lo-hi.h              |   64 +
 include/linux/mei_cl_bus.h                         |    2 +
 include/linux/nvram.h                              |  133 +-
 include/linux/parport.h                            |   13 +
 include/linux/perf_event.h                         |    2 +-
 include/linux/vmw_vmci_defs.h                      |    7 +-
 include/sound/hda_component.h                      |    5 +-
 include/uapi/linux/android/binder.h                |   19 +
 include/uapi/linux/pmu.h                           |    2 +
 include/uapi/misc/fastrpc.h                        |   41 +
 include/uapi/misc/habanalabs.h                     |  450 ++
 kernel/events/ring_buffer.c                        |    2 +-
 lib/Kconfig.debug                                  |    1 -
 lib/iomap.c                                        |  140 +-
 scripts/ver_linux                                  |    6 +-
 sound/hda/hdac_component.c                         |    4 +-
 sound/hda/hdac_i915.c                              |    6 +-
 326 files changed, 60914 insertions(+), 1955 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
 create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/driver-api/component.rst
 create mode 100644 Documentation/interconnect/interconnect.rst
 create mode 100644 arch/m68k/atari/nvram.c
 delete mode 100644 drivers/char/generic_nvram.c
 create mode 100644 drivers/extcon/extcon-ptn5150.c
 create mode 100644 drivers/gnss/mtk.c
 create mode 100644 drivers/interconnect/Kconfig
 create mode 100644 drivers/interconnect/Makefile
 create mode 100644 drivers/interconnect/core.c
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/sdm845.c
 create mode 100644 drivers/misc/fastrpc.c
 create mode 100644 drivers/misc/habanalabs/Kconfig
 create mode 100644 drivers/misc/habanalabs/Makefile
 create mode 100644 drivers/misc/habanalabs/asid.c
 create mode 100644 drivers/misc/habanalabs/command_buffer.c
 create mode 100644 drivers/misc/habanalabs/command_submission.c
 create mode 100644 drivers/misc/habanalabs/context.c
 create mode 100644 drivers/misc/habanalabs/debugfs.c
 create mode 100644 drivers/misc/habanalabs/device.c
 create mode 100644 drivers/misc/habanalabs/goya/Makefile
 create mode 100644 drivers/misc/habanalabs/goya/goya.c
 create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
 create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
 create mode 100644 drivers/misc/habanalabs/habanalabs.h
 create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
 create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
 create mode 100644 drivers/misc/habanalabs/hw_queue.c
 create mode 100644 drivers/misc/habanalabs/hwmon.c
 create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/hl_boot_if.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
 create mode 100644 drivers/misc/habanalabs/include/qman_if.h
 create mode 100644 drivers/misc/habanalabs/irq.c
 create mode 100644 drivers/misc/habanalabs/memory.c
 create mode 100644 drivers/misc/habanalabs/mmu.c
 create mode 100644 drivers/misc/habanalabs/sysfs.c
 create mode 100644 drivers/misc/mei/hdcp/Makefile
 create mode 100644 drivers/misc/mei/hdcp/mei_hdcp.c
 create mode 100644 drivers/misc/mei/hdcp/mei_hdcp.h
 create mode 100644 include/drm/i915_mei_hdcp_interface.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
 create mode 100644 include/linux/interconnect-provider.h
 create mode 100644 include/linux/interconnect.h
 create mode 100644 include/uapi/misc/fastrpc.h
 create mode 100644 include/uapi/misc/habanalabs.h
