Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD2C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DEF20665
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560712020;
	bh=+oV5/5HSBBw1Y/ts4wq5dkiYhlHIJdIAPW9khuhiS1I=;
	h=From:Date:Subject:To:List-ID:From;
	b=OqO+1NGOpTSzEl3UYh4DNGeTGcPtDN1954ExrX0KzohloY8MHwTEYH183bMpsKnfv
	 dZ7aZjkrXdw+BVT2axPP/7pQxkC/1p/Bha+kPPD2mQWzFAfQV92VWqvwJhJFauAF22
	 BUAtB0eZFeltvVlJIgkJ04M8bCdD4FJTtD/4m0+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfFPTG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 15:06:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44979 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfFPTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 15:06:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so4920217lfm.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 12:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=d5ZswzrpgOLmVuTDvEvbnHfc1Gnk2aoe5AO7rykJndY=;
        b=GhGJf6INMlUa3mEP5yaIgRd8JShMkE76xfPrNe/VXJrRN7pBb9JBuiCbOfJSQHqff4
         5YrxAV/f9CRn4HQb/U0ewpY7uOkdUmWlBCxi1Ze7K5S5BsXLkOQjeKAigg22vE0yYQZy
         iHa7PtLvD0YY5o8GhhV0PM+OEJljRkqv990Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=d5ZswzrpgOLmVuTDvEvbnHfc1Gnk2aoe5AO7rykJndY=;
        b=b7Fz1OXM1D+aqfbyWT6Ex0W4DpogD0Agigk1y/hWa+I2wlJ2HPEkf/xxcCktm7fcgY
         P4Hlt6ReCMtHbuDaWrCcFb/NvQje7IDS42oB+5+9SeDxejXfU2tgwrjaIUtqy1uHrErj
         rFDr1LM339ClcpYcW+qHyA3WU0jl7ezVLmR8xRdbelUKoLlzQRNZp9GxDwGKIl298kZv
         ela4fU000hz5bqNDn1MQteSAing7Lj+ACBlgAxuRive/UQnp3iPiBwjzg6bJPk6wrD52
         qGSpiuViFKml4Q6Bnb/0Z0S7zXldr3Z+i1XXjHHdmPI3hD/B3PWoo8Rh88hfPvFcPojr
         vaAg==
X-Gm-Message-State: APjAAAVBflI+Nh/wm+wjWe/y7MN67ZR1yNNbuceb+sOAMPF7ZkWXDyr2
        lVV18/87hnwjUv0EGA3nAqQ/HoA6pf8=
X-Google-Smtp-Source: APXvYqyHw6bzGluy9Y9grGsiULj1r6tA5W44a1gwE1tWSyYN/CXlWA2nkGnJ3D7hsVwu2yBFHcuNpQ==
X-Received: by 2002:a19:230e:: with SMTP id j14mr13387214lfj.13.1560712014102;
        Sun, 16 Jun 2019 12:06:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x194sm1419812lfa.64.2019.06.16.12.06.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 12:06:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i21so7196577ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 12:06:53 -0700 (PDT)
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr40131788ljh.84.1560712012785;
 Sun, 16 Jun 2019 12:06:52 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Jun 2019 09:06:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
Message-ID: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
Subject: Linux 5.2-rc5
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"It's Sunday afternoon somewhere in the world".

In fact, it's _barely_ Sunday afternoon back home, where I'll be later
today. But not quite yet, and I continue my slightly flaky release
schedule due to my normal release time being spent on an airplane once
again.

In fact, that will happen the _next_ two weekends too due to yet more
travel. So the releases will not be quite the clockwork they usually
are.

But the good news is that we're getting to the later parts of the rc
series, and things do seem to be calming down. I was hoping rc5 would
end up smaller than rc4, and so it turned out. There's some pending
stuff still, but it all looks quite small and nothing seems to be
particularly scary-looking.

And this time around we don't even have any huge SPDX updates, so the
diffstat looks nice and small and clean too. Normal changes all over
(with drivers being the bulk of it as it should be: sound stands out,
but there's gpu, HID, USB, block.. ). Outside of driver fixes there's
the usual noise all over: arch updates, documentation, and small misc
fixes spread out.

As mentioned, nothing particularly stands out as being scary. Shortlog
appended for details for those of you who want to scan over it
quickly, it's not big.

Go forth and test,

               Linus

---

Alex Deucher (1):
      drm/amdgpu: return 0 by default in amdgpu_pm_load_smu_firmware

Alex Levin (1):
      ASoC: Intel: sst: fix kmalloc call with wrong flags

Alexandre Belloni (1):
      usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC

Amadeusz S=C5=82awi=C5=84ski (2):
      ALSA: hdac: fix memory release for SST and SOF drivers
      SoC: rt274: Fix internal jack assignment in set_jack callback

Andrea Arcangeli (1):
      coredump: fix race condition between collapse_huge_page() and core du=
mping

Andreas Gruenbacher (1):
      gfs2: Fix rounding error in gfs2_iomap_page_prepare

Andreas Herrmann (2):
      block/switching-sched.txt: Update to blk-mq schedulers
      blkio-controller.txt: Remove references to CFQ

Andrey Ryabinin (1):
      x86/kasan: Fix boot with 5-level paging and KASAN

Andrey Smirnov (1):
      usb: phy: mxs: Disable external charger detect in mxs_phy_hw_init()

Andrzej Pietrasiewicz (1):
      usb: gadget: dwc2: fix zlp handling

Axel Lin (1):
      regulator: tps6507x: Fix boot regression due to testing wrong
init_data pointer

Baoquan He (1):
      x86/mm/KASLR: Compute the size of the vmemmap section properly

Benjamin Tissoires (4):
      HID: multitouch: handle faulty Elo touch device
      Revert "HID: Increase maximum report size allowed by hid_field_extrac=
t()"
      Revert "HID: core: Do not call request_module() in async context"
      Revert "HID: core: Call request_module before doing device_add"

Boris Brezillon (1):
      drm/gem_shmem: Use a writecombine mapping for ->vaddr

Borislav Petkov (2):
      RAS/CEC: Fix binary search function
      x86/microcode, cpuhotplug: Add a microcode loader CPU hotplug callbac=
k

B=C5=82a=C5=BCej Szczygie=C5=82 (1):
      HID: a4tech: fix horizontal scrolling

Casey Schaufler (1):
      Smack: Restore the smackfsdef mount option and add missing prefixes

Chaitanya Kulkarni (1):
      null_blk: remove duplicate check for report zone

Chris Packham (1):
      USB: serial: pl2303: add Allied Telesis VT-Kit3

Christoph Hellwig (1):
      x86/fpu: Don't use current->mm to check for a kthread

Christophe Leroy (3):
      spi: spi-fsl-spi: call spi_finalize_current_message() at the end
      powerpc: Fix kexec failure on book3s/32
      powerpc/32s: fix booting with CONFIG_PPC_EARLY_DEBUG_BOOTX

Coly Li (2):
      bcache: fix stack corruption by PRECEDING_KEY()
      bcache: only set BCACHE_DEV_WB_RUNNING when cached device attached

Cong Wang (1):
      RAS/CEC: Convert the timer callback to a workqueue

Curtis Malainey (1):
      ASoC: rt5677-spi: Handle over reading when flipping bytes

Damien Le Moal (1):
      block: force select mq-deadline for zoned block devices

Dan Carpenter (1):
      drm/amdgpu: Fix bounds checking in amdgpu_ras_is_supported()

Dan Williams (6):
      drivers/base/devres: introduce devm_release_action()
      mm/devm_memremap_pages: introduce devm_memunmap_pages
      PCI/P2PDMA: fix the gen_pool_add_virt() failure path
      lib/genalloc: introduce chunk owners
      PCI/P2PDMA: track pgmap references per resource, not globally
      mm/devm_memremap_pages: fix final page put race

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1260 and 0x1261 compositions

Dave Jiang (1):
      iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_=
lock

Dave Martin (1):
      arm64/sve: Fix missing SVE/FPSIMD endianness conversions

Don Brace (1):
      scsi: hpsa: correct ioaccel2 chaining

Douglas Anderson (1):
      usb: dwc2: host: Fix wMaxPacketSize handling (fix webcam regression)

Eiichi Tsukata (3):
      tracing: Fix out-of-range read in trace_stack_print()
      tracing/uprobe: Fix NULL pointer dereference in trace_uprobe_create()
      tracing/uprobe: Fix obsolete comment on trace_uprobe_create()

Eric Biggers (1):
      io_uring: fix memory leak of UNIX domain socket inode

Eric W. Biederman (1):
      signal/ptrace: Don't leak unitialized kernel memory with
PTRACE_PEEK_SIGINFO

Ezequiel Garcia (1):
      drm/panfrost: Require the simple_ondemand governor

Geert Uytterhoeven (1):
      block/ps3vram: Use %llu to format sector_t after LBDAF removal

Gen Zhang (2):
      selinux: fix a missing-check bug in selinux_add_mnt_opt( )
      selinux: fix a missing-check bug in selinux_sb_eat_lsm_opts()

Georgii Staroselskii (1):
      ASoC: sun4i-codec: fix first delay on Speaker

Greg Kroah-Hartman (1):
      blk-mq: no need to check return value of debugfs_create functions

Guennadi Liakhovetski (1):
      ASoC: SOF: ipc: fix a race, leading to IPC timeouts

Gustavo A. R. Silva (1):
      usb: typec: ucsi: ccg: fix memory leak in do_flash

H. Nikolaus Schaller (1):
      gpio: pca953x: hack to fix 24 bit gpio expanders

Hans de Goede (9):
      HID: logitech-dj: add support for the Logitech MX5500's
Bluetooth Mini-Receiver
      HID: logitech-hidpp: add support for the MX5500 keyboard
      HID: logitech-hidpp: Add support for the S510 remote control
      HID: logitech-dj: Fix 064d:c52f receiver support
      drm: panel-orientation-quirks: Add quirk for GPD pocket2
      drm: panel-orientation-quirks: Add quirk for GPD MicroPC
      drm/i915/dsi: Use a fuzzy check for burst mode clock check
      platform/x86: asus-wmi: Only Tell EC the OS will handle display
hotkeys from asus_nb_wmi
      libata: Extend quirks for the ST1000LM024 drives with NOLPM quirk

Heikki Krogerus (1):
      usb: typec: Make sure an alt mode exist before getting its partner

Hsin-Yi Wang (5):
      drm/mediatek: fix unbind functions
      drm/mediatek: unbind components in mtk_drm_unbind()
      drm/mediatek: call drm_atomic_helper_shutdown() when unbinding driver
      drm/mediatek: clear num_pipes when unbind driver
      drm/mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()

Hugh Dickins (1):
      x86/fpu: Use fault_in_pages_writeable() for pre-faulting

Hui Wang (1):
      Revert "ALSA: hda/realtek - Improve the headset mic for Acer
Aspire laptops"

James Morse (1):
      x86/resctrl: Don't stop walking closids when a locksetup group is fou=
nd

Jani Nikula (2):
      drm/edid: abstract override/firmware EDID retrieval
      drm: add fallback override/firmware EDID modes workaround

Jann Horn (1):
      ptrace: restore smp_rmb() in __ptrace_may_access()

Jason Gerecke (5):
      HID: wacom: Don't set tool type until we're in range
      HID: wacom: Don't report anything prior to the tool entering range
      HID: wacom: Send BTN_TOUCH in response to INTUOSP2_BT eraser contact
      HID: wacom: Correct button numbering 2nd-gen Intuos Pro over Bluetoot=
h
      HID: wacom: Sync INTUOSP2_BT touch state after each frame if necessar=
y

Jens Axboe (1):
      cgroup/bfq: revert bfq.weight symlink change

Joel Savitz (1):
      cpuset: restore sanity to cpuset_cpus_allowed_fallback()

Johannes Weiner (1):
      mm: memcontrol: don't batch updates of local VM stats and events

Jon Hunter (2):
      ASoC: simple-card: Fix configuration of DAI format
      ASoC: simple-card: Restore original configuration of DAI format

Joseph Salisbury (1):
      HID: hyperv: Add a module description line

Josh Poimboeuf (1):
      module: Fix livepatch/ftrace module text permissions race

Julien Thierry (1):
      clocksource/drivers/arm_arch_timer: Don't trace count reader function=
s

J=C3=B6rgen Storvist (1):
      USB: serial: option: add support for Simcom SIM7500/SIM7600 RNDIS mod=
e

Kai Vehmanen (2):
      ASoC: SOF: fix race in FW boot timeout handling
      ASoC: SOF: fix DSP oops definitions in FW ABI

Kai-Heng Feng (2):
      HID: i2c-hid: add iBall Aer3 to descriptor override
      USB: usb-storage: Add new ID to ums-realtek

Kailang Yang (1):
      ALSA: hda/realtek - Update headset mode for ALC256

Kan Liang (1):
      x86/CPU: Add more Icelake model numbers

Keyon Jie (1):
      ASoC: SOF: control: correct the copy size for bytes kcontrol put

Kirill Tkhai (1):
      mm/vmscan.c: fix recent_rotated history

Kov=C3=A1cs Tam=C3=A1s (1):
      ASoC: Intel: Baytrail: add quirk for Aegex 10 (RU2) tablet

Kuninori Morimoto (2):
      ASoC: soc-dpm: fixup DAI active unbalance
      ASoC: soc-core: fixup references at soc_cleanup_card_resources()

Libin Yang (2):
      ASoC: soc-pcm: BE dai needs prepare when pause release after resume
      ASoC: SOF: pcm: clear hw_params_upon_resume flag correctly

Linus Torvalds (1):
      Linux 5.2-rc5

Linus Walleij (1):
      i2c: pca-platform: Fix GPIO lookup code

Lionel Landwerlin (1):
      drm/i915/perf: fix whitelist on Gen10+

Lu Baolu (2):
      iommu: Add missing new line for dma type
      iommu/vt-d: Set the right field for Page Walk Snoop

Lucas De Marchi (1):
      drm/i915/dmc: protect against reading random memory

Manuel Traut (1):
      scripts/decode_stacktrace.sh: prefix addr2line with $CROSS_COMPILE

Marco Zatta (1):
      USB: Fix chipmunk-like voice when using Logitech C270 for recording a=
udio.

Marcus Cooper (2):
      ASoC: sun4i-i2s: Fix sun8i tx channel offset mask
      ASoC: sun4i-i2s: Add offset to RX channel select

Mark Brown (1):
      spi: Fix Raspberry Pi breakage

Martin Schiller (1):
      usb: dwc2: Fix DMA cache alignment issues

Mathew King (1):
      platform/x86: intel-vbtn: Report switch events when event wakes devic=
e

Matt Flax (1):
      ASoC : cs4265 : readable register too low

Matt Mullins (1):
      x86/kgdb: Return 0 from kgdb_arch_set_breakpoint()

Minas Harutyunyan (1):
      usb: dwc2: Set actual frame number for completed ISOC transfer
for none DDMA

Minchan Kim (1):
      mm/vmscan.c: fix trying to reclaim unevictable LRU page

Ming Lei (1):
      blk-mq: remove WARN_ON(!q->elevator) from blk_mq_sched_free_requests

Nathan Chancellor (1):
      arm64: Don't unconditionally add -Wno-psabi to KBUILD_CFLAGS

Neil Armstrong (4):
      drm/meson: fix G12A HDMI PLL settings for 4K60 1000/1001 variations
      drm/meson: fix primary plane disabling
      drm/meson: fix G12A primary plane disabling
      drm/panfrost: make devfreq optional again

Nicholas Piggin (2):
      powerpc/64s: Fix THP PMD collapse serialisation
      powerpc/64s: __find_linux_pte() synchronization vs pmdp_invalidate()

Nikolay Borisov (1):
      btrfs: Always trim all unallocated space in btrfs_trim_free_extents

Odin Ugedal (1):
      docs cgroups: add another example size for hugetlb

Ondrej Mosnacek (1):
      selinux: log raw contexts as untrusted strings

Pan Xiuli (1):
      ASoC: SOF: soundwire: add initial soundwire support

Parav Pandit (3):
      vfio/mdev: Improve the create/remove sequence
      vfio/mdev: Avoid creating sysfs remove file on stale device removal
      vfio/mdev: Synchronize device create/remove with parent removal

Philippe Mazenauer (1):
      clocksource/drivers/timer-ti-dm: Change to new style declaration

Pierre-Louis Bossart (9):
      ASoC: SOF: nocodec: fix undefined reference
      ASoC: SOF: core: fix error handling with the probe workqueue
      ASoC: SOF: pcm: remove warning - initialize workqueue on open
      ASoC: SOF: uapi: mirror firmware changes
      ASoC: SOF: bump to ABI 3.6
      ASoC: Intel: cht_bsw_max98090: fix kernel oops with platform_name ove=
rride
      ASoC: Intel: bytcht_es8316: fix kernel oops with platform_name overri=
de
      ASoC: Intel: cht_bsw_nau8824: fix kernel oops with platform_name over=
ride
      ASoC: Intel: cht_bsw_rt5672: fix kernel oops with platform_name overr=
ide

Potyra, Stefan (1):
      mm/mlock.c: mlockall error for flag MCL_ONFAULT

Prarit Bhargava (1):
      x86/resctrl: Prevent NULL pointer dereference when local MBM is disab=
led

Ranjani Sridharan (6):
      ASoC: SOF: fix error in verbose ipc command parsing
      ASoC: core: lock client_mutex while removing link components
      ASoC: SOF: core: remove DSP after unregistering machine driver
      ASoC: SOF: core: remove snd_soc_unregister_component in case of error
      ASoC: hda: fix unbalanced codec dev refcount for HDA_DEV_ASOC
      ASoC: core: Fix deadlock in snd_soc_instantiate_card()

Rick Edgecombe (2):
      mm/vmalloc: Fix calculation of direct map addr range
      mm/vmalloc: Avoid rare case of flushing TLB with weird arguments

Robin Murphy (1):
      iommu/arm-smmu: Avoid constant zero in TLBI writes

Rui Nuno Capela (1):
      ALSA: ice1712: Check correct return value to snd_i2c_sendbytes
(EWS/DMX 6Fire)

Russell King (1):
      i2c: acorn: fix i2c warning

S.j. Wang (2):
      ASoC: fsl_asrc: Fix the issue about unsupported rate
      ASoC: cs42xx8: Add regcache mask dirty

Sathya Prakash M R (3):
      ASoC: Intel: soc-acpi: Fix machine selection order
      ASoC: Intel: sof-rt5682: fix for codec button mapping
      ASoC: Intel: sof-rt5682: fix AMP quirk support

Sean Young (1):
      media: dvb: warning about dvb frequency limits produces too much nois=
e

Sebastian Andrzej Siewior (1):
      x86/fpu: Update kernel's FPU state before using for the fsave header

Shakeel Butt (1):
      mm/list_lru.c: fix memory leak in __memcg_init_list_lru_node

Shirish S (1):
      drm/amdgpu/{uvd,vcn}: fetch ring's read_ptr after alloc

Slawomir Blauciak (1):
      ASoC: SOF: ipc: replace fw ready bitfield with explicit bit ordering

Stanimir Varbanov (1):
      media: venus: hfi_parser: fix a regression in parser

Stefano Stabellini (1):
      xen/swiotlb: don't initialize swiotlb twice on arm64

Super Liu (1):
      spi: abort spi_sync if failed to prepare_transfer_hardware

Takashi Sakamoto (2):
      ALSA: firewire-motu: fix destruction of data for isochronous resource=
s
      ALSA: oxfw: allow PCM capture for Stanton SCS.1m

Tejun Heo (6):
      cgroup: Use css_tryget() instead of css_tryget_online() in task_get_c=
ss()
      cgroup: Call cgroup_release() before __exit_signal()
      cgroup: Implement css_task_iter_skip()
      cgroup: Include dying leaders with live threads in PROCS iterations
      cgroup: css_task_iter_skip()'d iterators must be advanced before acce=
ssed
      cgroup: Fix css_task_iter_advance_css_set() cset skip condition

Thomas Gleixner (1):
      timekeeping: Repair ktime_get_coarse*() granularity

Tobias Auerochs (1):
      HID: rmi: Use SET_REPORT request on control endpoint for Acer
Switch 3 and 5

Tzung-Bi Shih (1):
      ASoC: core: move DAI pre-links initiation to snd_soc_instantiate_card

Vadim Pasternak (2):
      platform/x86: mlx-platform: Fix parent device in i2c-mux-reg
device registration
      platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove f=
low

Vasily Gorbik (1):
      tracing: avoid build warning with HAVE_NOP_MCOUNT

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix per-pixel alpha with CCS
      drm/i915/sdvo: Implement proper HDMI audio support for SDVO

Viorel Suman (2):
      ASoC: ak4458: add return value for ak4458_probe
      ASoC: ak4458: rstn_control - return a non-zero on error only

Wei Li (1):
      ftrace: Fix NULL pointer dereference in free_ftrace_func_mapper()

Wei Yongjun (1):
      usb: gadget: udc: lpc32xx: fix return value check in lpc32xx_udc_prob=
e()

Wengang Wang (1):
      fs/ocfs2: fix race in ocfs2_dentry_attach_lock()

Will Deacon (1):
      arm64: tlbflush: Ensure start/end of address range are aligned to str=
ide

Yang Shi (1):
      mm: mmu_gather: remove __tlb_reset_range() for force flush

Yongqiang Niu (2):
      drm/mediatek: adjust ddp clock control flow
      drm/mediatek: respect page offset for PRIME mmap calls

Young Xiao (1):
      usb: gadget: fusb300_udc: Fix memory leak of fusb300->ep[i]

Yu-Hsuan Hsu (1):
      ASoC: max98090: remove 24-bit format support if RJ is 0

YueHaibing (4):
      spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
      ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error
      ASoC: da7219: Fix build error without CONFIG_I2C
      tracing: Make two symbols static

Zhu Yingjiang (2):
      ASoC: SOF: Intel: hda: fix the hda init chip
      ASoC: SOF: Intel: hda: use the defined ppcap functions

swkhack (1):
      mm/mlock.c: change count_mm_mlocked_page_nr return type
