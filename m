Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AACC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA2E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGmNjaKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfCFDfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:35:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40601 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbfCFDfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:35:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id h28so6032113qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 19:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/yKa293/nrmEXBMxTDPeeoWKQf3rG3iA8a6yP+dqX+w=;
        b=sGmNjaKT9rHqiLf6QAL+0O+YWRO/XSe6YOLHp0rGE1NjpDjw0T2kO5vAg8PFKHIx3o
         1FARZr1EMzuYJuTHzoe3rBMdNufQPg/toQIIRF6TSp7X7lf5GRvfyBH0uej/L0x7ZAjq
         Wuv4q+r7rPbLchwL+idSxs1rnVVl2vlzxAAmuLp2T5OrrmnE4IubGAmM0Uj8n91/+Yox
         UbbWozlWF+hBL/cg1FADmOtAW6lpdQYH5W/P4qtNoxgEdO630B0z4TEG4jTMZv+ObtFX
         RvWcrgtum+CTe6c9jOyxznD5I1fHEUKTxHqP5o3+W/XCYRmzRTWSHDKzcMggthdqLAX5
         zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/yKa293/nrmEXBMxTDPeeoWKQf3rG3iA8a6yP+dqX+w=;
        b=WvxPRJQJfTJNupdv1TtaL2lljEAdy9igTox0A2w/oxR6fCQ/kTplCzSOY9gqEoTls+
         nD8RyW3z/8UdKTrZK0IHvbc5wmzxhIYHTJy5M1L+iTaRxgjg7C27HY9qnRuPJy1eECzP
         CiZ9Fqb716hTti/7D0OSnntKji9bJv2kpdOZSVc2JnHqp0ukXHxD5+gGZSyRZgtGI9Ju
         qgkzrW312QhO9nCv53DQksVkfwCyCEiJDB56MuK0VwJt9XV0Khx5wOV8ZTTcfih7zPyk
         mtCb0pW0b0YbLsZjfjorZWDGwcdIKDqaNHuZPNNmK3IChXTPGnJ+LfkvFz26p6T0gkFf
         yyBA==
X-Gm-Message-State: APjAAAVzR0ESrIPnAKyB8NartXLDfQLHU7KRzzIysf+z63mqHfPh6aAo
        EBVSGZqOqXm6F3l592n93j7uPLsV+h6i9nrwbnGI8BHC
X-Google-Smtp-Source: APXvYqw+ZRkil+REzIcejIShTC475BgOwEY7u+gNYwJWwzycGMGvV01GbCT6e2zEvHIUgu3GjUK6ZuUpi/xR5mAahOE=
X-Received: by 2002:a37:80b:: with SMTP id 11mr4137942qki.131.1551843311898;
 Tue, 05 Mar 2019 19:35:11 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 6 Mar 2019 13:35:00 +1000
Message-ID: <CAPM=9tzmc2fiodNUtM_2BqE-BhFTQKze6vgJ9bG4y1gegHZcwg@mail.gmail.com>
Subject: [git pull] drm for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the main drm pull request for the 5.1 merge window.

The big changes I'd highlight are:
- nouveau has HMM support now, there is finally an in-tree user so we
can quieten down the rip it out people.
- i915 now enables fastboot by default on Skylake+
- Displayport Multistream support has been refactored and should
hopefully be more reliable.

Core:
- header cleanups aiming towards removing drmP.h
- dma-buf fence seqnos to 64-bits
- common helper for DP mst hotplug for radeon,i915,amdgpu + new
refcounting scheme
- MST i2c improvements
- drm_syncobj_cb removal
- ARM FB compression fourcc
- P010 + P016 fourcc
- allwinner tiled format modifier
- i2c over aux I2C_M_STOP support
- DRM_AUTH handling fixes

TTM:
- ref/unref renaming

New driver:
- ARM komeda display driver

scheduler:
- refactor mirror list handling
- rework hw fence processing
- 0 run queue entity fix

bridge:
- TI DS90C185 LVDS bridge
- thc631lvdm83d bridge improvements
- cadence + allwinner DSI ported to generic phy

panels:
- Sitronix ST7701 panel
- Kingdisplay KD097D04
- LeMaker BL035-RGB-002
- PDA 91-00156-A0
- Innolux EE101IA-01D

i915:
- Enable fastboot by default on SKL+/VLV/CHV
- Export RPCS configuration for ICL media driver
- Coffelake PCI ID
- CNL clocks setup fixes
- ACPI/PMIC support for MIPI/DSI
- Per-engine WA init for all engines
- Shrinker locking fixes
- Kerneldoc updates
- Lots of ring improvements and reset fixes
- Coffeelake GVT Support
- VFIO GVT EDID Region support
- runtime PM wakeref tracking
- ILK->IVB primary plane enable delays
- userptr mutex locking fixes
- DSI fixes
- LVDS/TV cleanups
- HW readout fixes
- LUT robustness fixes
- ICL display and watermark fixes
- gem mmap race fix

amdgpu:
- add scheduled dependencies interface
- DCC on scanout surfaces
- vega10/20 BACO support
- Multiple IH rings on soc15
- XGMI locking fixes
- DC i2c/aux cleanups
- runtime SMU debug interface
- Kexec improvmeents
- SR-IOV fixes
- DC freesync + ABM fixes
- GDS fixes
- GPUVM fixes
- vega20 PCIE DPM switching fixes
- Context priority handling fixes

radeon:
- fix missing break in evergreen parser

nouveau:
- SVM support via HMM

msm:
- QCOM Compressed modifier support

exynos:
- s5pv210 rotator support

imx:
- zpos property support
- pending update fixes
v3d:
- cache flush improvments

vc4:
- reflection support
- HDMI overscan support

tegra:
- CEC refactoring
- HDMI audio fixes
- Tegra186 prep work
- SOR crossbar device tree fixes

sun4i
- implicit fencing support
- YUV and scalar support improvements
- A23 support
- tiling fixes

atmel-hlcdc:
- clipping and rotation property fixes

qxl:
- BO and PRIME improvements
- generic fbdev emulation

dw-hdmi:
- HDMI 2.0 2160p
- YUV420 ouput

rockchip:
- implicit fencing support
- reflection proerties

virtio-gpu:
- use generic fbdev emulation

tilcdc:
- cpufreq vs crtc init fix

rcar-du:
- R8A774C0 support
- D3/E3 RGB output routing fixes and DPAD0 support
- RA87744 LVDS support

bochs:
- atomic and generic fbdev emulation
- ID mismatch error on bochs load

meson:
- remove firmware fbs

drm-next-2019-03-06:
drm next pull request for 5.1
The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783=
:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-03-06

for you to fetch changes up to 4b057e73f28f1df13b77b77a52094238ffdf8abd:

  Merge tag 'drm-misc-fixes-2019-02-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-03-05
08:14:22 +1000)

----------------------------------------------------------------
drm next pull request for 5.1

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu/psp: ignore psp response status

Aditya Swarup (1):
      drm/i915/cnl: Fix CNL macros for Voltage Swing programming

Alban Bedel (1):
      drm/tegra: hdmi: Fix audio to work with any pixel clock rate

Alex Deucher (19):
      drm/amdgpu: expose sclk and mclk via hwmon
      drm/amdgpu: add need_reset_on_init asic callback (v2)
      drm/amdgpu/si: add need_reset_on_init asic callback for SI (v2)
      drm/amdgpu/cik: add need_reset_on_init asic callback for CIK (v2)
      drm/amdgpu/vi: add need_reset_on_init asic callback for VI (v2)
      drm/amdgpu/soc15: add need_reset_on_init asic callback for SOC15 (v2)
      drm/amdgpu: check if we need to reset at init time (v2)
      drm/amdgpu/soc15: return proper error codes in baco reset
      drm/amdgpu: Add APTX quirk for Lenovo laptop
      drm/amdgpu: Add missing power attribute to APU check
      drm/radeon: check if device is root before getting pci speed caps
      drm/amdgpu: remove old CI DPM implementation
      Revert "drm/amd/display: add -msse2 to prevent Clang from
emitting libcalls to undefined SW FP routines"
      drm/amdgpu/powerplay: declare firmware for CI cards
      drm/amdgpu: don't clamp debugfs register access to the BAR size
      drm/amdgpu: remove some old unused dpm helpers
      drm/amdgpu: add missing license on baco files
      drm/amdgpu/powerplay: fix return codes in BACO code
      drm/amdgpu/powerplay: fix typo in BACO header guards

Alistair Francis (1):
      drm/bochs: Fix the ID mismatch error

Amber Lin (3):
      drm/amdgpu: Relocate kgd2kfd function declaration
      drm/amdgpu: Simplify kgd2kfd interface
      drm/amdgpu: Remove kgd2kfd function pointers

Andrey Grodzovsky (4):
      drm/sched: Refactor ring mirror list handling.
      drm/sched: Rework HW fence processing.
      drm/amdgpu: Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
      drm/amd/display: Fix deadlock with display during hanged ring recover=
y.

Andrzej Pietrasiewicz (1):
      drm/exynos: Change Andrzej Pietrasiewicz's e-mail address

Anthony Koo (10):
      drm/amd/display: fix issue with DC brightness low with VB
      drm/amd/display: link_rate_set should index into table
      drm/amd/display: interface to check if timing can be seamless
      drm/amd/display: refactor out programming of vupdate interrupt
      drm/amd/display: add way to determine if link is active
      drm/amd/display: add seamless boot flag to stream
      drm/amd/display: refactor programming of DRR
      drm/amd/display: refactor init_hw to isolate pipe related init
      drm/amd/display: remove screen flashes on seamless boot
      drm/amd/display: Increase precision for backlight curve

Anusha Srivatsa (1):
      drm/i915/huc: Update the HuC version for BXT

Archit Taneja (1):
      MAINTAINERS: drm: Remove myself as drm-bridge maintainer

Ard Biesheuvel (1):
      drm: disable uncached DMA optimization for ARM and arm64

Arnd Bergmann (3):
      drm/msm/gpu: fix building without debugfs
      drm/msm: avoid unused function warning
      gpu: host1x: Use completion instead of semaphore

Bas Nieuwenhuizen (5):
      drm/sched: Fix entities with 0 rqs.
      drm/amdgpu: Only add rqs for initialized rings.
      drm/amdgpu: Check if fd really is an amdgpu fd.
      drm/amdgpu: Add command to override the context priority.
      drm/amdgpu: Bump amdgpu version for context priority override.

Bayan Zabihiyan (1):
      drm/amd/display: Add new infopacket definition

Ben Skeggs (50):
      drm/nouveau/devinit/tu102: rename implementation from tu104
      drm/nouveau/mc/tu102: rename implementation from tu104
      drm/nouveau/mmu/tu102: rename implementation from tu104
      drm/nouveau/bar/tu102: rename implementation from tu104
      drm/nouveau/fault/tu102: rename implementation from tu104
      drm/nouveau/disp/tu102: rename implementation from tu104
      drm/nouveau/fifo/tu102: rename implementation from tu104
      drm/nouveau/ce/tu102: rename implementation from tu104
      drm/nouveau/core: define GSP subdev
      drm/nouveau/top: add function to lookup PRI address for devices
      drm/nouveau/top/gv100-: translate entry for the GSP
      drm/nouveau/gsp/gv100-: instantiate GSP falcon
      drm/nouveau/nvdec/gp102-: utilise engine PRI address from TOP
      drm/nouveau/nvdec/tu102-: instantiate NVDEC0 falcon
      drm/nouveau/sec2: utilise engine PRI address from TOP
      drm/nouveau/sec2/tu102-: instantiate SEC2 falcon
      drm/nouveau/secboot: fix missing newline in error messages
      drm/nouveau/bios/init: label existing INIT_GENERIC_CONDITION types
      drm/nouveau/bios/init: handle
INIT_GENERIC_CONDITION_ID_NO_PANEL_SEQ_DELAYS
      drm/nouveau/disp/gf119-: decode exception reason to human-readable st=
ring
      drm/nouveau: allocate kernel channel(s) before initialising display
      drm/nouveau/kms: display destroy/init/fini hooks can be static
      drm/nouveau/kms/nv04-nv4x: move a bunch of pre-nv50 page flip
code to dispnv04
      drm/nouveau/kms/nv04-nv4x: move suspend code to dispnv04 fini hook
      drm/nouveau/kms/nv04-nv4x: move resume code to dispnv04 init hook
      drm/nouveau: allow accelerated buffer moves even when gr isn't presen=
t
      drm/nouveau/gr/gf100-: move fecs set_watchdog_timeout method
into a function
      drm/nouveau/gr/gf100-: move fecs discover_image_size into a function
      drm/nouveau/gr/gf100-: move fecs discover_zcull_image_size into a fun=
ction
      drm/nouveau/gr/gf100-: move fecs discover_pm_image_size into a functi=
on
      drm/nouveau/gr/gf100-: move fecs elpg setup into functions
      drm/nouveau/gr/gf100-: remove some unnecessary reg writes
      drm/nouveau/gr/gf100-: move fecs bind_pointer into a function
      drm/nouveau/gr/gf100-: store fecs/gpccs falcon pointers in substructu=
res
      drm/nouveau/mmu/gf100-: make mmu invalidate function more general
      drm/nouveau/mmu/gf100-: virtualise setting pdb base address for
invalidation
      drm/nouveau/gr/gf100-: expose fecs methods for pausing ctxsw
      drm/nouveau/gr/gf100-: expose method to determine current context
      drm/nouveau/mmu: support initialisation of client-managed address-spa=
ces
      drm/nouveau/mmu: store mapped flag separately from memory pointer
      drm/nouveau/mmu: add a privileged method to directly manage PTEs
      drm/nouveau/mmu/gp100-: add privileged methods for fault replay/cance=
l
      drm/nouveau/mmu/gp100-: support vmms with gcc/tex replayable
faults enabled
      drm/nouveau/fault/gp100: expose MaxwellFaultBufferA
      drm/nouveau/fault/gv100-: expose VoltaFaultBufferA
      drm/nouveau: prepare for enabling svm with existing userspace interfa=
ces
      drm/nouveau/svm: initial support for shared virtual memory
      drm/nouveau/dmem: extend copy function to allow direct use of
physical addresses
      drm/nouveau/dmem: use physical vram addresses during migration copies
      drm/nouveau/dmem: use dma addresses during migration copies

Biju Das (2):
      dt-bindings: display: renesas: lvds: Document r8a7744 bindings
      drm: rcar-du: lvds: Add r8a7744 support

Bob Paauwe (1):
      drm/i915: DFSM pipe disable is valid from gen9 onwards (v2)

Boris Brezillon (7):
      drm/vc4: Fix negative X/Y positioning on SAND planes
      drm/vc4: Add support for X/Y reflection
      drm/connector: Fix drm_mode_create_tv_properties() doc
      drm/connector: Clarify the unit of TV margins
      drm/connector: Allow creation of margin props alone
      drm/vc4: Take margin setup into account when updating planes
      drm/vc4: Attach margin props to the HDMI connector

Brajeswar Ghosh (6):
      drm/drm_drv.c: Remove duplicate header
      drm/i915: Remove duplicate header from i915_request.h
      drm/intel_dsi_vbt: Remove duplicate header
      drm/amd/display: Remove duplicate header
      drm/amd/display/dcn10_hw_sequencer_debug: Remove duplicate header
      drm/amd/display/i2c_hw_engine_dce110: Remove duplicate header

Brian Starkey (1):
      drm/afbc: Add AFBC modifier usage documentation

Bruce Wang (1):
      drm/msm/dpu: remove struct encoder_kickoff_params

Chandan Uddaraju (1):
      drm: add definitions for DP Audio/Video compliance tests

Charlene Liu (2):
      drm/amd/display: fix PME notification not working in RV desktop
      drm/amd/display: dp interlace MSA timing programming for Interlace mo=
de.

Chen-Yu Tsai (5):
      dt-bindings: display: sun4i-drm: Add compatible strings for A23 displ=
ay
      drm/sun4i: backend: Remove BGRX8888 from list of supported formats
      drm/sun4i: layer: Assign backend pointer before calling DRM helpers
      drm/sun4i: layer: support just backend formats when frontend is
unavailable
      drm/sun4i: Add support for A23 display pipeline

Chiawen Huang (1):
      drm/amd/display: add gpio lock/unlock

Chris Wilson (126):
      drm/i915/selftests: Reorder request allocation vs vma pinning
      drm/i915/selftests: verify_gt_engine_wa() needs rpm wakeref
      drm/i915/execlists: Move RCS mmio workaround to new common wa_list
      drm/i915/execlists: Apply a full mb before execution for Braswell
      drm/i915: Push EMIT_INVALIDATE at request start to backends
      drm/i915/ringbuffer: EMIT_INVALIDATE after switch context
      drm/i915: Pipeline PDP updates for Braswell
      drm/i915: Skip the ERR_PTR error state
      drm/i915: Flush GPU relocs harder for gen3
      drm/i915/selftests: Check we can recover a wedged device
      drm/i915/selftests: Verify we can perform resets from atomic context
      drm/i915: Fix Cherryview oops on boot
      drm/i915: Apply missed interrupt after reset w/a to all ringbuffer ge=
n
      drm/i915: Unwind failure on pinning the gen7 ppgtt
      drm/i915: Remove debugfs/i915_ppgtt_info
      drm/i915: Restrict PSMI context load w/a to Haswell GT1
      drm/i915: Remove HW semaphores for gen7 inter-engine synchronisation
      drm/i915: Drop debugfs/i915_next_seqno
      drm/i915/execlists: Pull the render flush into breadcrumb emission
      drm/i915/ringbuffer: Pull the render flush into breadcrumb emission
      drm/i915: Update kerneldoc for intel_wm_need_update()
      drm/i915: Remove redundant trailing request flush
      drm/i915/ringbuffer: Remove irq-seqno w/a for gen6/7 rcs
      drm/i915/ringbuffer: Remove irq-seqno w/a for gen6 xcs
      drm/i915/ringbuffer: Move irq seqno barrier to the GPU for gen7
      drm/i915/ringbuffer: Move irq seqno barrier to the GPU for gen5
      drm/i915: Drop unused engine->irq_seqno_barrier w/a
      drm/i915/selftests: Take a breath during check_partial_mappings()
      drm: Reorder set_property_atomic to avoid returning with an active ww=
_ctx
      drm/i915/gen6: Flush RING_IMR changes before changing the global GT I=
MR
      drm/i915: Show machine type in error state
      drm/i915: Always try to reset the GPU on takeover
      drm/i915: Do not allow unwedging following a failed driver initialisa=
tion
      drm/i915: Remove partial attempt to swizzle on pread/pwrite
      drm/i915: Fixup kerneldoc for intel_device_info_runtime_init
      drm/i915/hsw: Flush RING_IMR changes before changing the global
GT IMR (vecs)
      drm/i915: Report the number of closed vma held by each context in deb=
ugfs
      drm/i915/selftests: Mark the whole mock device as DMA capable
      drm/i915: Return immediately if trylock fails for direct-reclaim
      drm/i915: Downgrade scare message for unknown HuC firmware
      drm/i915: Reduce i915_request_alloc retirement to local context
      drm/i915: Guard error capture against unpinned vma
      drm/i915: Use mutex_lock_killable() from inside the shrinker
      drm/i915: Removing polling for struct_mutex from vmap shrinker
      drm/i915: Track all held rpm wakerefs
      drm/i915: Markup paired operations on wakerefs
      drm/i915: Track GT wakeref
      drm/i915: Track the rpm wakerefs for error handling
      drm/i915: Mark up sysfs with rpm wakeref tracking
      drm/i915: Mark up debugfs with rpm wakeref tracking
      drm/i915/perf: Track the rpm wakeref
      drm/i915/pmu: Track rpm wakeref
      drm/i915/guc: Track the rpm wakeref
      drm/i915/gem: Track the rpm wakerefs
      drm/i915/fb: Track rpm wakerefs
      drm/i915/hotplug: Track temporary rpm wakeref
      drm/i915/panel: Track temporary rpm wakeref
      drm/i915/selftests: Mark up rpm wakerefs
      drm/i915: Syntatic sugar for using intel_runtime_pm
      drm/i915: Markup paired operations on display power domains
      drm/i915: Track the wakeref used to initialise display power domains
      drm/i915/dp: Markup pps lock power well
      drm/i915: Complain if hsw_get_pipe_config acquires the same
power well twice
      drm/i915: Combined gt.awake/gt.power wakerefs
      drm/i915: Mark up Ironlake ips with rpm wakerefs
      drm/i915: Differentiate between ggtt->mutex and ppgtt->mutex
      drm/i915: Prevent concurrent GGTT update and use on Braswell (again)
      drm/i915/perf: Annotate i915_perf.wakeref for keneldoc
      drm/i915: Only dump GPU state on set-wedged if interesting
      drm/i915/userptr: Avoid struct_mutex recursion for
mmu_invalidate_range_start
      drm/i915: Move intel_execlists_show_requests() aside
      drm/i915/userptr: Fix error handling of mutex_lock_killable()
      drm/i915: Serialise concurrent calls to i915_gem_set_wedged()
      drm/i915: Pull all the reset functionality together into i915_reset.c
      drm/i915: Limit the for_each_set_bit() to the valid range
      drm/i915/breadcrumbs: Drop assertion that we've already enabled irqs
      drm/i915/selftests: Query the vm under test for hugepage support
      drm/i915: Use b->irq_enable() as predicate for mock engine
      drm/i915/selftests: Make evict tolerant of foreign objects
      drm/i915/selftests: Allocate mock ring/timeline per context
      drm/i915: Prevent use of global_seqno=3D0
      drm/i915/selftests: Track evict objects explicitly
      drm/i915/selftests: Create a clean GGTT for vma/gtt selftesting
      drm/i915/selftests: Refactor common live_test framework
      drm/i915/selftests: Use common mock_engine::advance
      drm/i915: Refactor out intel_context_init()
      drm/i915: Tidy common test_bit probing of i915_request->fence.flags
      drm/i915: Show all active engines on hangcheck
      drm/i915/execlists: Mark up priority boost on preemption
      drm/i915: De-inline intel_context_init()
      drm/i915: Measure the required reserved size for request emission
      drm/i915: Remove manual breadcumb counting
      drm/i915: Compute the HWS offsets explicitly
      drm/i915: Make all GPU resets atomic
      drm/i915/guc: Disable global reset
      drm/i915: Remove GPU reset dependence on struct_mutex
      drm/i915/selftests: Trim struct_mutex duration for set-wedged selftes=
t
      drm/i915: Issue engine resets onto idle engines
      drm/i915: Wait for a moment before forcibly resetting the device
      drm/i915: Stop tracking MRU activity on VMA
      drm/i915: Pull VM lists under the VM mutex.
      drm/i915: Move vma lookup to its own lock
      drm/i915: Always allocate an object/vma for the HWSP
      drm/i915: Move list of timelines under its own lock
      drm/i915: Introduce concept of per-timeline (context) HWSP
      drm/i915: Enlarge vma->pin_count
      drm/i915: Allocate a status page for each timeline
      drm/i915: Share per-timeline HWSP using a slab suballocator
      drm/i915: Track the context's seqno in its own timeline HWSP
      drm/i915: Track active timelines
      drm/i915/selftests: Apply a subtest filter
      drm/i915: Identify active requests
      drm/i915: Rename execlists->queue_priority to queue_priority_hint
      drm/i915/execlists: Suppress preempting self
      drm/i915: Remove the intel_engine_notify tracepoint
      drm/i915: Replace global breadcrumbs with per-context interrupt track=
ing
      drm/i915: Drop fake breadcrumb irq
      drm/i915: Allow normal clients to always preempt idle priority client=
s
      drm/i915: Trim NEWCLIENT boosting
      drm/i915/selftests: Exercise some AB...BA preemption chains
      drm/i915: Generalise GPU activity tracking
      drm/i915: Release the active tracker tree upon idling
      drm/i915: Allocate active tracking nodes from a slabcache
      drm/i915: Pull i915_gem_active into the i915_active family
      drm/i915: Push clear_intel_crtc_state() onto the heap
      drm/i915: Hack and slash, throttle execbuffer hogs

Christian K=C3=B6nig (22):
      drm/v3d: fix broken build
      dma-buf: make fence sequence numbers 64 bit v2
      drm/etnaviv: fix for 64bit seqno change
      drm/syncobj: remove drm_syncobj_cb and cleanup
      drm/amdgpu: disable system memory page tables for now
      drm/amdgpu: add IH ring to ih_get_wptr/ih_set_rptr v2
      drm/amdgpu: simplify IH programming
      drm/amdgpu: fix IH overflow on Vega10 v2
      drm/amdgpu: add the IH to the IV trace
      drm/amdgpu: improve GMC v9 page fault message
      drm/ttm: stop always moving BOs on the LRU on page fault
      drm/amdgpu: set the executable flag on unused Vega10 PTEs v2
      drm/amdgpu: enable IH ring 1 and ring 2 v4
      drm/amdgpu: add support for processing IH ring 1 & 2
      drm/amdgpu: add support for self irq on Vega10 v2
      drm/amdgpu: cleanup amdgpu_pte_update_params
      drm/amdgpu: fix waiting for BO moves with CPU based PD/PT updates
      drm/amdgpu: cleanup VM dw estimation a bit
      drm/amdgpu: fix NULL ptr dref in the VM code
      drm/amdgpu: cleanup amdgpu_ih_process a bit more
      drm/amdgpu: cleanup setting bulk_movable
      drm/amdgpu: partial revert cleanup setting bulk_movable v2

Chunming Zhou (2):
      drm/ttm: add lru notify to bo driver v2
      drm/amdgpu: set bulk_moveable to false when lru changed v2

Clint Taylor (2):
      drm/i915/hdmi: SCDC Scrambling enable without CTS mode
      drm/i915/icl: combo port vswing programming changes per BSPEC

Colin Ian King (8):
      amdgpu/dc: remove various variables that are defined but never used
      drm/amd/amdgpu: fix spelling mistake "matech" -> "match"
      drm/amdgpu: fix several indentation issues
      drm/nouveau/bios/dp: make array vsoff static, shrinks object size
      drm/nouveau/bios/ramcfg: fix missing parentheses when calculating RON
      drm/nouveau/pmu: don't print reply values if exec is false
      drm/nouveau: fix missing break in switch statement
      drm/nouveau/falcon: fix a few indentation issues

Cristian Birsan (1):
      dt-bindings: display: Add support for PDA 91-00156-A0 panel

Damian Kos (1):
      drm/rockchip: fix for mailbox read validation.

Dan Carpenter (4):
      drm: Fix an error pointer dereference()
      drm/ati_pcigart: Fix error code in drm_ati_pcigart_init()
      drm/komeda: Off by one in komeda_fb_get_pixel_addr()
      drm/msm: fix an error code in the ioctl

Daniel Vetter (32):
      drm/dp-mst-helper: Remove hotplug callback
      drm/qxl: Don't set the dpms hook
      drm/xen: Don't set the dpms hook
      drm/todo: Better defio support in the generic fbdev emulation
      drm/crtc-helpers: WARN when used with atomic drivers
      drm/ch7006: Stop using drm_crtc_force_disable
      drm/nouveau: Stop using drm_crtc_force_disable
      drm: Unexport drm_crtc_force_disable
      drm/atomic: Add missing () to function ref in kerneldoc
      drm: Move the legacy kms disable_all helper to crtc helpers
      drm/arc: Don't set the dpms hook
      drm/tda998x: Don't set dpms hook
      drm/doc: Polish kerneldoc for drm_device.h
      drm/docs: improve docs for drm_drv.c
      drm/of: Fix kerneldoc
      drm/panel: Small documentation polish
      drm/doc: Move bridge link target to the right place
      staging/vboxvideo: Don't set FBINFO_MISC_ALWAYS_SETPAR
      drm: Split out drm_probe_helper.h
      drm/doc: Add a warning to drm_dev_is_unplugged
      drm/<drivers>: Don't set FBINFO_(FLAG_)DEFAULT
      drm/irq: Don't check for DRIVER_HAVE_IRQ in drm_irq_(un)install
      drm: Switch DRIVER_ flags to an enum
      drm/irq: Ditch DRIVER_IRQ_SHARED
      drm/doc: fix VRR_ENABLED casing
      drm/doc: Task to rename CMA helpers
      drm/doc: Move hdmi infoframe docs
      drm/doc: Drop chapter "KMS Initialization and Cleanup"
      staging/vboxvideo: don't set dev_priv_size =3D 0
      staging/vboxvideo: Add TODO
      drm/doc: Make igts for cross-driver stuff strongly suggested
      Merge tag 'drm-misc-next-2019-02-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Daniele Castagna (2):
      drm/rockchip: Fix YUV buffers color rendering
      drm/rockchip: Add reflection properties

Daniele Ceraolo Spurio (4):
      drm/i915/selftests: recreate WA lists inside the selftest
      drm/i915: init per-engine WAs for all engines
      drm/i915: drop DPF code for gen8+
      drm/i915/icl: do a posting read after irq install

Dave Airlie (25):
      Merge tag 'drm-misc-next-2019-01-07-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/msm: fix build warning for 64-bit seqno
      Merge tag 'tilcdc-4.22' of https://github.com/jsarha/linux into drm-n=
ext
      Merge tag 'du-next-20190114' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-misc-next-2019-01-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2019-01-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2019-01-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2019-01-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'drm-misc-next-2019-02-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2019-02-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'exynos-drm-next-for-v5.1' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'du-next-20190208' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm/tegra/for-5.1-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'drm-intel-next-2019-02-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge v5.0-rc7 into drm-next
      Merge branch 'linux-5.1' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'imx-drm-next-2019-02-22' of
git://git.pengutronix.de/pza/linux into drm-next
      Merge v5.0 into drm-next
      Merge tag 'drm-misc-fixes-2019-02-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

David Francis (12):
      drm/amd/display: Detach backlight from stream
      drm/amd/display: Add backlight pwm debugfs
      drm/amd/display: Remove unused parameter plane_states
      drm/amd/display: Shift dc link aux to aux_payload
      drm/amd/display: Switch ddc to new aux interface
      drm/amd/display: Change from aux_engine to dce_aux
      drm/amd/display: Remove i2caux folder
      drm/amd/display: Let updates with no scaling changes be fast
      drm/amd/display: Simplify underscan and ABM commit
      drm/amd/display: Call into DC once per multiplane flip
      drm/amd/display: Perform plane updates only when needed
      drm/amd/display: Know what a pageflip is

Derek Lai (1):
      drm/amd/display: Set link rate set if eDP ver >=3D 1.4.

Dmitry Osipenko (3):
      gpu: host1x: Cancel only job that actually got stuck
      gpu: host1x: Don't complete a completed job
      gpu: host1x: Continue CDMA execution starting with a next job

Dmytro Laktyushkin (6):
      drm/amd/display: Remove some extra braces
      drm/amd/display: update DCN dml calcs
      drm/amd/display: add dsclk to pipe bw struct
      drm/amd/display: Rename configure_encoder to enc1_configure_encoder
      drm/amd/display: add a debug flag to force odm combine
      drm/amd/display: add n_vid_mul and half pix_rate for odm

Douglas Anderson (1):
      drm/msm: Fix A6XX support for opp-level

Emil Velikov (5):
      drm: drop DRM_AUTH requirement from AUTH_MAGIC ioctl
      drm: factor out drm_close_helper() function
      drm: plug memory leak on drm_setup() failure
      drm: annotate drm_core_check_feature() dev arg. as const
      drm: allow render capable master with DRM_AUTH ioctls

Emily Deng (4):
      drm/amdgpu/virtual_dce: No need to pin the fb's bo
      drm/amdgpu/virtual_dce: No need to pin the cursor bo
      drm/amdgpu/sriov:Correct pfvf exchange logic
      drm/amdgpu/sriov: For finishing routine send rel event after init fai=
led

Enric Balletbo i Serra (1):
      drm/rockchip: update cursors asynchronously through atomic.

Eric Anholt (6):
      drm/v3d: Document cache flushing ABI.
      drm/v3d: Drop unused v3d_flush_caches().
      drm/v3d: Don't bother flushing L1TD at job start.
      drm/v3d: Drop the wait for L2T flush to complete.
      drm/v3d: Stop trying to flush L2C on V3D 3.3+
      drm/v3d: Invalidate the caches from the outside in.

Eric Bernstein (4):
      drm/amd/display: Expose hubp1_vready_workaround function
      drm/amd/display: Fix runtime errors for diagnostic tests
      drm/amd/display: Improve logging of validation failures during
atomic_check
      drm/amd/display: Check if registers are available before accessing

Eric Huang (1):
      drm/amd/powerplay: add override pcie parameters for Vega20

Eric Yang (4):
      drm/amd/display: update bw formula to v252
      drm/amd/display: add workaround for 4k video underflow
      revert "drm/amd/display: Add condition to sync eDP SW status and
HW status"
      drm/amd/display: take dpms_off into account for edp turn off logic

Eryk Brol (3):
      drm/amd/display: Restructure DCN10 hubbub
      drm/amd/display: Introduce DC VM interface
      drm/amd/display: DC VM Fixes

Eugen Hristev (2):
      dt-bindings: Add vendor prefix for PDA Precision Design Associates, I=
nc.
      drm/panel: simple: Add support for PDA 91-00156-A0 panel

Evan Quan (24):
      drm/amd/powerplay: support BOOTUP_DEFAULT power profile mode
      drm/amd/powerplay: update OD support flag for SKU with no OD capabili=
ties
      drm/amd/powerplay: create pp_od_clk_voltage device file under OD supp=
ort
      drm/amd/powerplay: avoid possible buffer overflow
      drm/amd/powerplay: drop the unnecessary uclk hard min setting
      drm/amd/powerplay: support enabled ppfeatures retrieving and setting =
V3
      drm/amd/powerplay: support retrieving and adjusting SOC clock
power levels V2
      drm/amd/powerplay: support retrieving and adjusting fclock power leve=
ls V2
      drm/amd/powerplay: support retrieving and adjusting dcefclock
power levels V2
      drm/amdgpu: check PSP support before adding the ip block
      drm/amdgpu: fix wrong APU judgement
      drm/amd/powerplay: avoid unnecessary dpm level setting
      drm/amd/powerplay: enforce display related settings only on needed
      drm/amd/powerplay: fit the SOC clock also to the new performance leve=
l
      drm/amd/powerplay: run btc before enabling all SMU features
      drm/amd/display: change the max clock level to 16
      drm/amd/powerplay: support Vega10 fan table V3
      drm/amd/powerplay: enable MGPU fan boost feature on Vega10
      drm/amd/powerplay: correct Vega20 gfxclk readout under DS
      drm/amd/powerplay: avoid frequent metrics table export
      drm/amd/powerplay: support Vega10 SOCclk and DCEFclk dpm level settin=
gs
      drm/amd/powerplay: support Vega10 retrieving and setting ppfeatures
      drm/amd/powerplay: support Vega12 SOCclk and DCEFclk dpm level settin=
gs
      drm/amd/powerplay: support Vega12 retrieving and setting ppfeatures

Ezequiel Garcia (5):
      drm/virtio: Remove incorrect kfree()
      drm/virtio: Add missing virtqueue reset
      drm/virtio: Drop deprecated load/unload initialization
      drm/rockchip: Fix typo in VOP macros argument
      drm/rockchip: Separate RK3288 from RK3368 win01 registers

Fabrizio Castro (4):
      dt-bindings: display: renesas: du: Document r8a774c0 bindings
      dt-bindings: display: renesas: lvds: Document r8a774c0 bindings
      drm: rcar-du: Add r8a774c0 device support
      drm: rcar-du: lvds: add R8A774C0 support

Fatemeh Darbehani (3):
      drm/amd/display: Add pixel clock values to dtn logs
      drm/amd/display: Start using the new pp_smu interface
      drm/amd/display: Add Vline1 interrupt source to InterruptManager

Felix Kuehling (6):
      drm/amdkfd: Allow building KFD on ARM64 (v2)
      drm/amdkfd: Don't assign dGPUs to APU topology devices
      drm/amdgpu: Add helper to wait for BO fences using a sync object
      drm/amdgpu: Replace ttm_bo_wait with amdgpu_bo_sync_wait
      drm/amdgpu: Avoid setting off KFD eviction fences in amdgpu_vm
      drm/amdgpu: Simplify eviction fence handling

Frediano Ziglio (1):
      drm/qxl: change the way slot is detected

Fritz Koenig (5):
      drm/msm/dpu: Remove unused format tables.
      drm/msm/dpu: Use simple list for plane format init
      drm/msm/dpu: Plane helper for modifiers
      drm/msm/dpu: Initialize supported modifiers
      drm/msm/dpu: Correct initialization of modifiers

Gary Kattan (1):
      drm/amd/display: Ungate stream before programming registers

Geert Uytterhoeven (1):
      drm: rcar-du: Convert live DT patches to sugar syntax

Gerd Hoffmann (47):
      drm/qxl: add spice-devel list to MAINTAINERS
      drm/virtio: switch to generic fbdev emulation
      drm/bochs: add edid present check
      drm/virtio: log error responses
      drm/virtio: fix pageflip flush
      drm/virtio: drop virtio_gpu_fence_cleanup()
      drm/bochs: encoder cleanup
      drm/bochs: split bochs_hw_setmode
      drm/bochs: atomic: add atomic_flush+atomic_enable callbacks.
      drm/bochs: atomic: add mode_set_nofb callback.
      drm/bochs: atomic: switch planes to atomic, wire up helpers.
      drm/bochs: atomic: use atomic set_config helper
      drm/bochs: atomic: use atomic page_flip helper
      drm/bochs: atomic: use suspend/resume helpers
      drm/bochs: atomic: set DRIVER_ATOMIC
      drm/bochs: remove old bochs_crtc_* functions
      drm/bochs: drop unused gpu_addr arg from bochs_bo_pin()
      drm/bochs: move ttm_bo_(un)reserve calls into bochs_bo_{pin, unpin}
      drm/bochs: add basic prime support
      drm/bochs: switch to generic drm fbdev emulation
      drm/bochs: drop old fbdev emulation code
      drm/bochs: move remaining fb bits to kms
      drm/qxl: drop ttm_mem_reg arg from qxl_hw_surface_alloc()
      drm/qxl: drop unused qxl_fb_virtual_address
      drm/qxl: simplify slot management
      drm/qxl: drop unused fields from struct qxl_device
      drm/qxl: use separate offset spaces for the two slots / ttm memory ty=
pes.
      drm/qxl: allow both PRIV and VRAM placement for QXL_GEM_DOMAIN_SURFAC=
E
      drm/qxl: use QXL_GEM_DOMAIN_SURFACE for shadow bo.
      drm/qxl: use QXL_GEM_DOMAIN_SURFACE for dumb gem objects
      drm/qxl: move qxl_primary_apply_cursor to correct place
      drm/qxl: drop unused offset parameter from qxl_io_create_primary()
      drm/qxl: track primary bo
      drm/qxl: use shadow bo directly
      drm/qxl: cover all crtcs in shadow bo.
      drm/qxl: use qxl_num_crtc directly
      drm/qxl: implement prime kmap/kunmap
      drm/qxl: use generic fbdev emulation
      drm/qxl: remove dead qxl fbdev emulation code
      drm/qxl: implement qxl_gem_prime_(un)pin
      drm/qxl: add mode/framebuffer check functions
      drm/qxl: add qxl_add_mode helper function
      drm/qxl: use kernel mode db
      drm/qxl: use ttm_tt
      drm/cirrus: add plane setup
      drm/bochs: fix bochs_gem_prime_mmap
      drm/virtio: do NOT reuse resource ids

Greg Kroah-Hartman (1):
      drm/i915: do not return invalid pointers as a *dentry

Gustavo A. R. Silva (17):
      qxl: Use struct_size() in kzalloc()
      drm/amd/display: Fix boolean expression in get_surf_rq_param
      drm/amdgpu_vm: fix boolean expressions
      drm/amdgpu: Replace kzalloc with kcalloc
      drm/via: mark expected switch fall-throughs
      drm/savage: mark expected switch fall-throughs
      drm/vc4: Use struct_size() in kzalloc()
      drm/amd/display/dc/bios_parser2: Mark expected switch fall-throughs
      drm/radeon/si_dpm: Mark expected switch fall-throughs
      drm/amd/display/dce_mem_input: Mark expected switch fall-through
      drm/amd/powerplay/smu7_hwmgr: Mark expected switch fall-throughs
      drm/radeon/ci_dpm: Mark expected switch fall-throughs
      drm/amdgpu/si_dpm: Mark expected switch fall-throughs
      drm/radeon/evergreen_cs: fix missing break in switch statement
      drm/amd/powerplay/smu8_hwmgr: use struct_size() in kzalloc()
      drm/amd/powerplay/smu10_hwmgr: use struct_size() in kzalloc()
      drm/nouveau: mark expected switch fall-through

Hang Yuan (3):
      drm/i915/gvt: add functions to get default resolution
      drm/i915/gvt: add hotplug emulation
      drm/i915/gvt: add VFIO EDID region

Hans de Goede (12):
      drm/i915: Update crtc scaler settings when update_pipe is set
      drm/i915: Add an update_pipe callback to intel_encoder and call
this on fastsets (v2)
      drm/i915: Allow calling intel_edp_drrs_enable twice
      drm/i915: DDI: call intel_psr_ and _edp_drrs_enable() on pipe updates=
 (v2)
      ACPI / PMIC: Add support for executing PMIC MIPI sequence elements
      ACPI / PMIC: Implement exec_mipi_pmic_seq_element for CHT
Whiskey Cove PMIC
      ACPI / PMIC: Add generic
intel_soc_pmic_exec_mipi_pmic_seq_element handling
      drm/i915/intel_dsi_vbt: Add support for PMIC MIPI sequences
      drm/i915/dsi: Fix pipe_bpp for handling for 6 bpc pixel-formats
      drm/i915/dsi: Enable dithering for 6 bpc panels
      drm/i915: Enable fastboot by default on Skylake and newer
      drm/i915: Enable fastboot by default on VLV and CHV

Harish Kasiviswanathan (2):
      drm/amdgpu: Fix pci platform speed and width
      drm/amd/powerplay: add override pcie parameters for Vega20 (v2)

Harry Wentland (1):
      drm/amd/display: Check hpd_gpio for NULL before accessing it

Hawking Zhang (2):
      drm/amdgpu/psp: update the naming of GFX_FW_TYPE_RLC_RESTORE_LIST_CNT=
L
      drm/amdgpu/psp: make get_fw_type and prep_cmd_buf to be common interf=
aces

Heiko Stuebner (3):
      drm/rockchip: Add implicit fencing support for planes
      drm/rockchip: check yuv2yuv existence before assigning window data
      dt-bindings: display: add binding for Innolux ee101ia-01d panel

Hsin-Yi, Wang (1):
      drm/panel: panel-innolux: set display off in innolux_panel_unprepare

Hugo Hu (1):
      drm/amd/display: Add debug option to force fclk request

Ilia Mirkin (1):
      drm/nouveau/volt/gf117: fix speedo readout register

Ilya Bakoulin (1):
      drm/amd/display: Check that vrefresh is in freesync range

Imad Syed (1):
      drm/amd/display: Remove unused headers

Imre Deak (8):
      drm/i915/icl: Add a debug print for TypeC port disconnection
      drm/i915/bios: Parse the VBT TypeC and Thunderbolt port flags
      drm/i915/icl: Fix HPD handling for TypeC legacy ports
      drm/i915/icl: Add fallback detection method for TypeC legacy ports
      drm/i915/ddi: Move DDI port detection to the corresponding helper
      drm/i915/icl: Detect port F presence via VBT
      drm/i915/icl: Add TypeC ports only if VBT is present
      drm/i915/icl: Work around broken VBTs for port F detection

Jack Xiao (1):
      drm/amdgpu: add flags to emit_ib interface v2

Jagan Teki (2):
      dt-bindings: display: Add Sitronix ST7701 panel documentation
      drm/panel: Add Sitronix ST7701 panel driver

Jani Nikula (50):
      drm/i915: add a helper to make a copy of i915_params
      drm/i915: add a helper to free the members of i915_params
      drm/i915/uc: add dev_priv parameter to intel_uc_is_using_* functions
      drm/i915/params: set i915.enable_hangcheck permissions to 0600
      drm/i915/params: document I915_PARAMS_FOR_EACH()
      drm: un-inline drm_legacy_findmap()
      drm: include kernel.h and agp_backend.h from intel-gtt.h
      drm: include idr.h from drm_file.h
      drm: include types.h from drm_hdcp.h
      drm: forward declare struct drm_file in drm_syncobj.h
      drm/i915: start moving runtime device info to a separate struct
      drm/i915/reg: abstract display_mmio_offset access
      drm/i915: pass dev_priv to intel_device_info_runtime_init()
      drm/i915: always use INTEL_INFO() to access device info
      drm/i915: drop intel_device_info_dump()
      drm/i915: rename dev_priv info to __info to avoid usage
      Merge tag 'topic/drmp-cleanup-2019-01-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next-queued
      Merge drm/drm-next into drm-intel-next-queued
      Ndrm/i915/debugfs: store rotation string buffer on stack
      drm/i915: drop all drmP.h includes
      drm/i915/gvt: remove drmP.h include
      drm/i915/gvt: give the cmd parser decode_info a const treatment
      drm/i915/gvt: give the cmd parser cmd_info a const treatment
      drm/i915: small isolated c99 types to kernel types switch
      drm/i915/crt: switch to kernel types
      drm/i915/lspcon: switch to kernel types
      drm/i915/debugfs: switch to kernel types
      drm/i915/irq: switch to kernel types
      drm/i915/cdclk: switch to kernel types
      drm/i915/dpll_mgr: switch to kernel types
      drm/i915/dp: switch to kernel types
      drm/i915/sprite: switch to kernel types
      drm/i915/dp: remove PANEL_POWER_OFF macro and its use
      drm/i915/color: switch to kernel types
      drm/i915/pm: switch to kernel types
      drm/i915/ddi: switch to kernel types
      drm/i915/csr: switch to kernel types
      drm/i915/display: switch to kernel types
      drm/i915/i915_drv.h: switch to kernel types
      drm/i915/intel_drv.h: switch to kernel types
      drm/dp: use DRM_DEBUG_DP() instead of drm_dbg for logging
      drm/i915/gvt: switch to kernel types
      drm/i915/sdvo: switch to kernel types
      drm/i915/crt: split out intel_crt_present() to platform specific setu=
p
      drm/i915/lvds: only call intel_lvds_init() on platforms that
might have LVDS
      drm/i915/lvds: nuke intel_lvds_supported()
      drm/i915/tv: only call intel_tv_init() on platforms that might have T=
V
      drm/i915: rename has_edp_a() to ilk_has_edp_a()
      drm/i915/lvds: simplify gen 2 lvds presence
      drm/i915/crt: simplify CRT VBT check on pre-VLV/DDI

Jayant Shekhar (3):
      drm/msm/dpu: Remove unused enum and comment from dpu mdss
      drm/msm/dpu: Cleanup dpu plane interface
      drm/msm/dpu: Clean up dpu hw interrupts

Jerry (Fangzhi) Zuo (3):
      drm/amd/display: Skip create new stream if crtc state doesn't change
      drm/amd/display: Apply fake sink back to MST sequence
      drm/amd/display: Clear dc_sink after it gets released

Jeykumar Sankaran (13):
      drm/msm/dpu: avoid tracking reservations in RM
      drm/msm/dpu: remove dev from RM
      drm/msm/dpu: clean up dpu_rm_check_property_topctl declaration
      drm/msm/dpu: remove encoder from crtc mixer struct
      drm/msm/dpu: clean up redundant hw type
      drm/msm/dpu: maintain hw_mdp in kms
      drm/msm/dpu: fix documentation for intf_type
      drm/msm/dpu: handle failures while initializing displays
      drm/msm/dpu: use kthread_destroy_worker to release msm workers
      drm/msm/dpu: use msm wq for vblank events
      drm/msm/dpu: use msm wq for idle power collapse
      drm/msm: clean up display thread
      drm/msm: subclass work object for vblank events

Jim Qu (12):
      drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang
      drm/amdgpu: update nbio v6.1 register/master to support BACO
      drm/amdgpu: add BACO interfaces in pm and hwmgr function table
      drm/amdpgu: add common functions for BACO feature in PP (v2)
      drm/amdgpu: add BACO interfaces for vega10
      drm/amdgpu: expose BACO interfaces to upper level from PP
      drm/amdgpu: update NBIO v7.4 to support BACO
      drm/amdgpu: also include NBIO v7.4 register mask header
      drm/amdgpu: update THM IP register header to support BACO
      drm/amdgpu/powerper: add vega20 BACO functions
      drm/amdgpu: use BACO reset if platform support (v2)
      drm/amdgpu: use BACO reset on vega20 if platform support

Joe Perches (1):
      drm/msm: Add __printf verification

John Barberiz (2):
      drm/amd/display: Fix use of uninitialized union
      drm/amd/display: Use udelay when waiting between aux retries

Jonathan Corbet (1):
      dma-buf: Fix kerneldoc comment for struct dma_fence_array

Joonas Lahtinen (2):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set
      drm/i915: Handle vm_mmap error during I915_GEM_MMAP ioctl with WC set

Jordan Crouse (5):
      drm/msm/gpu: Remove hardcoded interrupt name
      drm/msm: drop interrupt-names
      dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
      dt-bindings: drm/msm/a6xx: Document GMU bindings
      drm/msm: Truncate the buffer object name if the copy from user failed

Joshua Aberback (2):
      drm/amd/display: Fix missing hwss function for dce
      drm/amd/display: Fix for NULL ramp pointer crashing driver

Josip Pavic (7):
      drm/amd/display: Pack DMCU iRAM alignment
      drm/amd/display: Update DMCU versioning mechanism
      drm/amd/display: Create switching mechanism for ABM 2.2
      drm/amd/display: Adjust ABM 2.2 contrast parameters
      drm/amd/display: Modify ABM 2.2 Max Reduction
      drm/amd/display: send pipe set command to dmcu when stream unblanks
      drm/amd/display: send pipe set command to dmcu when backlight is set

Jos=C3=A9 Roberto de Souza (15):
      drm/i915: Disable PSR in Apple panels
      drm/i915/psr: Don't tell sink that main link will be active
while is active PSR2
      drm/i915/psr: Set PSR CRC verification bit in sink inside PSR1 block
      drm/i915/psr: Enable sink to trigger a interruption on PSR2 CRC misma=
tch
      drm/i915/icl: Do not change reserved registers related to PSR2
      drm/i915: Remove old PSR2 FIXME about frontbuffer tracking
      drm: Add the PSR SU granularity registers offsets
      drm/i915/psr: Check if resolution is supported by default SU granular=
ity
      drm/i915/psr: Check if source supports sink specific SU granularity
      drm: Fix documentation generation for DP_DPCD_QUIRK_NO_PSR
      drm/i915/fbc/cnl: Add GLK and CNL+ hardware tracking area
      drm/i915/psr: Allow PSR2 to be enabled when debugfs asks
      drm/i915: Refactor PSR status debugfs
      drm/i915: Add PSR2 selective update status registers and bits definit=
ions
      drm/i915/debugfs: Print PSR selective update status register values

Juha-Pekka Heikkila (1):
      drm/i915: Fix ILK-IVB primary plane enable delays

Julia Lawall (1):
      drm: rcar-du: add missing of_node_put

Jun Lei (3):
      drm/amd/display: Add a PP_SMU_VER_MAX enum
      drm/amd/display: remove sink reference in dc_stream_state
      drm/amd/display: add stream ID and otg instance in dc_stream_state

Jyri Sarha (1):
      drm/tilcdc: Register cpufreq notifier after we have initialized crtc

J=C3=A9r=C3=B4me Glisse (2):
      drm/nouveau/dmem: device memory helpers for SVM
      drm/nouveau/svm: new ioctl to migrate process memory to GPU memory

Ken Chalmers (3):
      drm/amd/display: Use 100 Hz precision for pipe pixel clocks
      drm/amd/display: Expand set_pixel_clock debug log message
      drm/amd/display: Fix 64-bit division for 32-bit builds

Kenneth Feng (3):
      drm/amd/powerplay: run acg btc for Vega12
      drm/amd/powerplay: OD setting fix on Vega10
      drm/amd/powerplay: update soc boot and max level on vega10

Kent Russell (3):
      drm/amdgpu: Cleanup 2 compiler warnings
      drm/amdgpu: Add NBIO SMN headers v2
      drm/amdgpu: Add sysfs file for PCIe usage v5

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Krunoslav Kovac (4):
      drm/amd/display: Fix issue with VLine interrupt not firing
      drm/amd/display: Check for NULL when creating gamma struct
      drm/amd/display: Default to linear output gamma
      drm/amd/display: DGAM enabled for HDR

Kuninori Morimoto (1):
      drm: dw-hdmi-i2s: convert to SPDX identifiers

Kuo-Hsin Yang (1):
      drm/gem: Mark pinned pages as unevictable

Laurent Pinchart (10):
      drm: bridge: Constify mode arguments to bridge .mode_set() operation
      drm: rcar-du: dw-hdmi: Reject modes with a too high clock frequency
      drm: rcar-du: Replace EXT_CTRL_REGS feature flag with generation chec=
k
      drm: rcar-du: Move CRTC outputs bitmask to private CRTC state
      drm: rcar-du: Disable unused DPAD outputs
      drm: rcar-du: Remove inclusion of drmP.h
      drm: rcar-du: Simplify encoder registration
      drm: rcar-du: lvds: Don't fail probe if output is not connected on D3=
/E3
      drm: rcar-du: lvds: Add API to enable/disable clock output
      drm: rcar-du: Turn LVDS clock output on/off for DPAD0 output on D3/E3

Leo Li (8):
      drm/amd/display: Remove stream_status->link
      drm/amd/display: Use local variable instead of caching global
      drm/amd/display: Fix driver load crash in amdgpu_dm
      drm/amd/display: Compensate for XGMI SS downspread on dprefclk
      drm/amd/display: Move iteration out of dm_update_planes
      drm/amd/display: Move iteration out of dm_update_crtcs
      Revert "drm/amd/display: Signal hw_done() after waiting for flip_done=
()"
      drm/amd/display: Fully remove i2caux folder

Lewis Huang (1):
      drm/amd/display: add plane size change check condition

Likun Gao (1):
      drm/amdgpu: make gfx9 enter into rlc safe mode when set MGCG

Linus Walleij (2):
      drm/fb-helper: Scale back depth to supported maximum
      drm/panel: Add a driver for the TPO TPG110

Lionel Landwerlin (2):
      drm/i915: Record the sseu configuration per-context & engine
      drm/i915/perf: lock powergating configuration to default when active

Liviu Dudau (1):
      drm: arm/komeda: Remove IRQ parsing from initial series

Lucas De Marchi (12):
      drm/i915: Rename IS_GEN to IS_GEN_RANGE
      drm/i915: replace IS_GEN<N> with IS_GEN(..., N)
      drm/i915: merge gen checks to use range
      drm/i915: initialize unused MOCS entries to PTE
      drm/i915: Simplify MOCS table definition
      drm/i915: use a macro to define MOCS entries
      drm/i915: keep track of used entries in MOCS table
      drm/i915: cache number of MOCS entries
      drm/i915/icl: use tc_port in MG_PLL macros
      drm/i915: always return something on DDI clock selection
      drm/i915/icl: remove dpll from clk_sel
      drm/i915/icl: keep track of unused pll while looping

Lucas Stach (4):
      gpu: ipu-v3: pre: add double buffer status readback
      gpu: ipu-v3: prg: add function to get channel configure status
      drm/imx: ipuv3-plane: add function to query atomic update status
      drm/imx: only send commit done event when all state has been applied

Lyude Paul (34):
      drm/dp_mst: Fix memory leak in drm_dp_mst_topology_mgr_destroy()
      drm/dp_mst: Remove bogus conditional in drm_dp_update_payload_part1()
      drm/dp_mst: Refactor drm_dp_update_payload_part1()
      drm/dp_mst: Fix some formatting in drm_dp_add_port()
      drm/dp_mst: Fix some formatting in drm_dp_payload_send_msg()
      drm/dp_mst: Fix some formatting in drm_dp_mst_allocate_vcpi()
      drm/dp_mst: Fix some formatting in drm_dp_mst_deallocate_vcpi()
      drm/dp_mst: Rename drm_dp_mst_get_validated_(port|mstb)_ref and frien=
ds
      drm/dp_mst: Introduce new refcounting scheme for mstbs and ports
      drm/dp_mst: Restart last_connected_port_and_mstb() if topology ref fa=
ils
      drm/dp_mst: Stop releasing VCPI when removing ports from topology
      drm/dp_mst: Fix payload deallocation on hotplugs using malloc refs
      drm/i915: Keep malloc references to MST ports
      drm/amdgpu/display: Keep malloc ref to MST port
      drm/nouveau: Remove bogus cleanup in nv50_mstm_add_connector()
      drm/nouveau: Remove unnecessary VCPI checks in nv50_msto_cleanup()
      drm/nouveau: Keep malloc references to MST ports
      drm/nouveau: Stop unsetting mstc->port, use malloc refs
      drm/nouveau: Grab payload lock in nv50_msto_payload()
      drm/dp_mst: Add some atomic state iterator macros
      drm/dp_mst: Start tracking per-port VCPI allocations
      drm/dp_mst: Check payload count in drm_dp_mst_atomic_check()
      drm/nouveau: Use atomic VCPI helpers for MST
      drm/i915: Pass down rc in intel_encoder->compute_config()
      drm/i915: Pass down rc in intel_encoder->compute_config()
      drm/dp_mst: Fix unbalanced malloc ref in drm_dp_mst_deallocate_vcpi()
      drm/dp_mst: Remove port validation in drm_dp_atomic_find_vcpi_slots()
      drm/atomic: Add drm_atomic_state->duplicated
      drm/nouveau: Move PBN and VCPI allocation into nv50_head_atom
      drm/dp_mst: Remove rebase-detritus in VCPI helper kernel-docs
      drm/i915: Block fbdev HPD processing during suspend
      drm/i915: Don't send MST hotplugs during resume
      drm/i915: Don't send hotplug in intel_dp_check_mst_status()
      drm/nouveau: Don't WARN_ON VCPI allocation failures

Maarten Lankhorst (5):
      drm/i915: Disable FBC on fastset if necessary, v2.
      drm/i915/backlight: Restore backlight on resume, v3.
      drm/i915/backlight: Fix backlight takeover on LPT, v3.
      drm/i915: Enable fastset for non-boot modesets.
      drm/i915: Make HW readout mark CRTC scaler as in use.

Manasi Navare (3):
      drm/i915/dsc: Add Per connector debugfs node for DSC support/enable
      drm/i915/dsc: Fix the deadlock in dsc debugfs node
      drm/dsc: Add kernel documentation for DRM DP DSC helpers

Marek Ol=C5=A1=C3=A1k (2):
      drm/amdgpu: clean up memory/GDS/GWS/OA alignment code
      drm/amdgpu: add a workaround for GDS ordered append hangs with
compute queues

Mario Kleiner (1):
      drm/amd/display: Use vrr friendly pageflip throttling in DC.

Mark Yao (1):
      drm: rockchip: vop: add rk3066 vop definitions

Martin Tsai (2):
      drm/amd/display: Redefine DMCU_SCRATCH to identify DMCU state
      drm/amd/display: Poll pending down rep before clear payload
allocation table

Mathieu Malaterre (1):
      drm/dp: annotate implicit fall throughs

Matt Atwood (1):
      drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT

Matt Roper (10):
      drm/i915: Use intel_ types more consistently for watermark code (v2)
      drm/i915: Use intel_ types more consistently for color
management code (v2)
      drm/i915: Don't use DDB allocation when choosing gen9 watermark metho=
d
      drm/i915: Switch to level-based DDB allocation algorithm (v5)
      drm/i915: Don't forget to reset blocks when testing lower wm levels
      drm: Add color management LUT validation helper (v4)
      drm/i915: Validate userspace-provided color management LUT's (v4)
      drm/i915: Force background color to black for gen9+ (v2)
      drm/i915: Apply LUT validation checks to platforms more accurately (v=
3)
      drm: Trivial comment grammar cleanups

Matteo Croce (1):
      drm/amd: fix typo

Matteo Franchin (1):
      drm/fourcc: Add modifier defininitions for AFBC 1.3

Maxime Jourdan (1):
      drm/meson: remove firmware framebuffers

Maxime Ripard (14):
      Merge tag 'topic/drmp-cleanup-2019-01-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-misc-next
      Merge drm/drm-next into drm-misc-next
      drm/sun4i: Move access control before setting the register as documen=
ted
      drm/sun4i: frontend: Add a quirk structure
      drm/sun4i: Set the coef_rdy bit right after the coef have been set
      drm/sun4i: Make COEF_RDY conditional
      drm/sun4i: frontend: Move the FIR filter phases to our quirks
      Merge drm/drm-next into drm-misc-next
      sun6i: dsi: Convert to generic phy handling
      phy: Move Allwinner A31 D-PHY driver to drivers/phy/
      drm/bridge: cdns: Separate DSI and D-PHY configuration
      drm/bridge: cdns: Convert to phy framework
      drm/sun4i: dsi: Fix unitialized variable warning
      Merge drm/drm-next into drm-misc-next

Mika Kuoppala (2):
      drm/i915/icl: Forcibly evict stale csb entries
      drm/i915: Compile fix for 64b dma-fence seqno

Murton Liu (1):
      drm/amd/display: PIP overlay corruption

Nathan Chancellor (4):
      drm/i915: Disable -Wuninitialized
      drm/amd/display: Use memset to initialize variable in
wait_for_training_aux_rd_interval
      drm/amd/display: Use memset to initialize variables in
amdgpu_dm_atomic_commit_tail
      drm/amd/display: Use memset to initialize variables in
fill_plane_dcc_attributes

Neil Armstrong (4):
      drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support
      drm/meson: add HDMI div40 TMDS mode
      drm/meson: add support for HDMI2.0 2160p modes
      drm/bridge: dw-hdmi: add support for YUV420 output

Nicholas Kazlauskas (20):
      drm/amd/display: Set requested plane state DCC params for GFX9
      drm/amd/display: Only get the connector state for VRR when toggled
      drm/amd/display: Fix disabled cursor on top screen edge
      drm/amd/display: Enable vblank interrupt during CRC capture
      drm/amd/display: Re-enable CRC capture following modeset
      drm/amd/display: Don't leak memory when updating streams
      drm/amd/display: Don't re-enable CRC when CONFIG_DEBUG_FS isn't defin=
ed
      drm/amd/display: Apply all surface updates onto surfaces
      drm/amd/display: Use the right surface for flip and FreeSync
      drm/amd/display: Reformat dm_determine_update_type_for_commit
      drm/amd/display: Initialize stream_update to zero
      drm/amd/display: Remove FreeSync timing changed debug output
      drm/amd/display: Disconnect mpcc when changing tg
      drm/amd/display: Don't re-program planes for DPMS changes
      drm: Block fb changes for async plane updates
      drm/amd/display: Fix wrong z-order when updating overlay planes
      drm/amd/display: Don't expose support for DRM_FORMAT_RGB888
      drm/amd/display: Fix update type mismatches in atomic check
      drm/amd/display: Do cursor updates after stream updates
      drm/amd/display: Clear stream->mode_changed after commit

Nickey Yang (1):
      drm/panel: Add Kingdisplay KD097D04 panel driver

Noralf Tr=C3=B8nnes (10):
      drm/fb-helper: generic: Fix setup error path
      drm/hisilicon/kirin: Use drm_fbdev_generic_setup()
      drm/mxsfb: Use drm_fbdev_generic_setup()
      drm/cma-helper: Remove unused fbdev code
      drm/gem-fb-helper: Add drm_gem_fb_create_with_dirty()
      drm/damage-helper: Add drm_atomic_helper_damage_merged()
      drm/tinydrm: Use struct drm_rect
      drm/tinydrm: Use damage helper for dirtyfb
      drm/todo: Tick off some tinydrm entries
      drm/fb-helper: generic: Fix drm_fbdev_client_restore()

Oak Zeng (4):
      drm/amdgpu: Use sdma_engine array
      drm/amdgpu: Add per device sdma_doorbell_range field
      drm/amdgpu: Fix sdma doorbell range setting
      drm/amdgpu: Setting doorbell range registers earlier

Oleksandr Andrushchenko (1):
      drm/xen-front: Fix mmap attributes for display buffers

Oscar Mateo (2):
      drm/i915/icl: Record the valid VDBoxes with SFC capability
      drm/i915/icl: Mind the SFC units when resetting VD or VEBox engines

P Raviraj Sitaram (1):
      drm/i915: correct the pitch check for NV12 framebuffer

Paul Hsieh (1):
      drm/amd/display: dmcu is blocking due to wrong disable ABM command

Paul Kocialkowski (23):
      drm/vc4: Limit SAND tiling support to semiplanar YUV420 formats
      drm: Auto-set allow_fb_modifiers when given modifiers at plane init
      drm/fourcc: Add format info helpers for checking YUV planes dispositi=
on
      drm/fourcc: Add format info helpers for checking YUV sub-sampling
      drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422 che=
ck
      drm/sun4i: frontend: Pass DRM format info to input format helpers
      drm/sun4i: frontend: Determine input format based on colorspace
      drm/sun4i: Move the BT.601 CSC coefficients to the frontend
      drm/sun4i: frontend: Configure and enable YUV to RGB CSC when needed
      drm/sun4i: frontend: Add support for packed YUV422 input formats
      drm/sun4i: frontend: Add support for semi-planar YUV input formats
      drm/sun4i: frontend: Add support for planar YUV input formats
      drm/fourcc: Add definitions for Allwinner vendor and VPU tiled format
      drm/sun4i: frontend: Add support for tiled YUV input mode configurati=
on
      drm/sun4i: Add buffer stride and offset configuration for tiling mode
      drm/sun4i: frontend: Add and use helper for checking tiling support
      drm/sun4i: layer: Add tiled modifier support and helper
      drm/sun4i: drv: Allow framebuffer modifiers in mode config
      drm/sun4i: frontend: Hook-in support for the A10, with specific quirk=
s
      drm/sun4i: frontend: Hook-in support for the A20
      dt-bindings: Add vendor prefix for LeMaker
      dt-bindings: display: Add bindings for the LeMaker BL035-RGB-002 LCD =
panel
      drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD

Paulo Zanoni (1):
      drm/i915: don't apply Display WAs 1125 and 1126 to GLK/CNL+

Pawe=C5=82 Chmiel (2):
      drm/exynos: rotator: Add support for s5pv210
      dt-bindings: gpu: samsung-rotator: Document s5pv210 support

Pedro Tammela (1):
      Makefile: fix mixed tab and spaces

Peter Rosin (8):
      dt-bindings: display: bridge: fork out ti, ds90c185 from lvds-transmi=
tter
      dt-bindings: display: bridge: lvds-transmitter: cleanup example
      dt-bindings: display: bridge: thc63lvdm83d: use standard powerdown-gp=
ios
      drm/bridge: lvds-encoder: add dev helper variable in .probe()
      drm/bridge: lvds-encoder: add powerdown-gpios support
      drm/atmel-hlcdc: rotate planes counterclockwise
      drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
      drm/atmel-hlcdc: fix clipping of planes

Peter Wu (1):
      drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup

Philipp Zabel (3):
      drm/imx: ipuv3-plane: add zpos property
      drm/imx: imx-tve: depend on COMMON_CLK
      drm/imx: allow building under COMPILE_TEST

Pratik Vishwakarma (1):
      drm/amdgpu/display: fix compiler errors [-Werror,-Wparentheses-equali=
ty]

Prike Liang (1):
      drm/amd/powerplay:clean up phm_enable_clock_power_gatings

Radhakrishna Sripada (1):
      drm/i915: Fix the static code analysis warning in debugfs

Rafa=C5=82 Mi=C5=82ecki (1):
      drm/amd/display: Include names of all PP clock types

Ramalingam C (4):
      drm/i915: Fix GEN9 HDCP1.4 key load process
      drm/i915: Fix platform coverage for HDCP1.4
      drm/i915: debug log for REPLY_ACK missing
      drm/i915: Increase timeout for Encrypt status change

Randy Li (1):
      drm/fourcc: Add new P010, P016 video format

Rob Clark (4):
      drm/atomic: integrate modeset lock with private objects
      drm/cirrus: fix connector leak at unload
      drm/msm: honor GPU_READONLY flag
      MAINTAINERS: update entry for drm/msm

Rodrigo Siqueira (1):
      MAINTAINERS: Add entry for VKMS

Rodrigo Vivi (14):
      drm/i915: Update DRIVER_DATE to 20181221
      drm/i915: Update DRIVER_DATE to 20181221
      drm/i915: Update DRIVER_DATE to 20190110
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915/icl: Adding few more device IDs for Ice Lake
      Merge tag 'gvt-next-2019-01-24' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190124
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190129
      Merge tag 'gvt-next-2019-02-01' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915/cfl: Adding another PCI Device ID.
      drm/i915: Update DRIVER_DATE to 20190202
      drm/i915: Rename HAS_GMCH
      drm/i915: Update DRIVER_DATE to 20190207

Roman Li (1):
      drm/amd/display: fix warning on raven hotplug

Sam Ravnborg (24):
      drm: move DRM_IF_VERSION to drm_internal.h
      drm: drm_device.h: update comments to kernel-doc style
      drm: move DRM_SWITCH_POWER defines to drm_device.h
      drm: make drm_framebuffer.h self contained
      drm: remove include of drmP.h from bridge/dw_hdmi.h
      drm: remove include of drmP.h from drm_encoder_slave.h
      drm/arc: do not rely on drmP.h from drm_gem_cma_helper.h
      drm/tinydrm: do not reply on drmP.h from drm_gem_cma_helper.h
      drm: remove drmP.h from drm_gem_cma_helper.h
      drm: move drm_can_sleep() to drm_util.h
      drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
      drm: fix alpha build after drm_util.h change
      drm: fix drm_can_sleep() comment
      drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
      drm/hisilicon/kirin: prepare for drmP.h removal from drm_modeset_help=
er.h
      drm/arcpgu: prepare for drmP.h removal from drm_modeset_helper.h
      drm/bridge: cdns: prepare for drmP.h removal from drm_modeset_helper.=
h
      drmi/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
      staging/vboxvideo: prepare for drmP.h removal from drm_modeset_helper=
.h
      drm/i915: prepare for drmP.h removal from drm_modeset_helper.h
      drm/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
      drm: prepare for drmP.h removal from drm_modeset_helper.h
      drm: remove drmP.h from drm_modeset_helper.h
      drm/komeda: fix build with drm_modeset_helper.h update

Sean Paul (1):
      drm/TODO: Add drm_display_mode.hsync/vrefresh removal

Shayenne Moura (13):
      drm: omapdrm: Cleanup drm_display_mode print str
      drm: meson: Cleanup on drm_display_mode print str
      drm: sti: Cleanup drm_display_mode print str
      drm: i915: Cleanup drm_display_mode print str
      drm: msm: Cleanup drm_display_mode print str
      drm: armada: Cleanup drm_display_mode print str
      drm: Remove use of drm_mode_object
      drm: Complete remove drm_mode_object dependency
      drm/vkms: Bugfix extra vblank frame
      drm/vkms: Bugfix racing hrtimer vblank handle
      drm/doc: Remove solved "VBlank issues"
      drm/vkms: WARN when hrtimer_forward_now fails
      drm/doc: Remove solved KMS cleanup task

Shayenne da Luz Moura (2):
      drm: Rename crtc_idr as object_idr to KMS cleanups
      drm: Remove complete task from TODO documentation

Shirish S (3):
      drm/amd/display: fix compliler errors [-Werror,-Wmissing-braces]
      drm/amdgpu/gmc: fix compiler errors [-Werror,-Wmissing-braces] (V2)
      drm/amd/display: Use context parameters to enable FBC

SivapiriyanKumarasamy (1):
      drm/amd/display: Minor code cleanup

Stephen Boyd (1):
      drm/msm/dpu: Convert to a chained irq chip

Steven Chiu (8):
      drm/amd/display: 3.2.09
      drm/amd/display: 3.2.10
      drm/amd/display: 3.2.11
      drm/amd/display: 3.2.12
      drm/amd/display: 3.2.13
      drm/amd/display: 3.2.14
      drm/amd/display: 3.2.15
      drm/amd/display: 3.2.16

Su Sung Chung (1):
      drm/amd/display: store timing sync info in dc_stream_status

Talha Nassar (1):
      drm/i915/icl: restore WaEnableFloatBlendOptimization

Tanmay Shah (1):
      drm/msm/dpu: Change definition of RGB565 and BGR565

Tao Zhou (1):
      drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20

Tetsuo Handa (1):
      drm/vkms: Fix flush_work() without INIT_WORK().

Thierry Reding (22):
      dt-bindings: panel: Add missing .txt suffix
      drm/tegra: Refactor CEC support
      drm/tegra: sor: Parse more data from HDA format
      drm/tegra: hda: Extract HDA format parsing code
      drm/tegra: hdmi: Reuse common HDA format parser
      gpu: host1x: Represent host1x bus devices in debugfs
      gpu: host1x: Set up stream ID table
      gpu: host1x: Program the channel stream ID
      gpu: host1x: Introduce support for wide opcodes
      gpu: host1x: Support 40-bit addressing
      gpu: host1x: Restrict IOVA space to DMA mask
      gpu: host1x: Support 40-bit addressing on Tegra186
      gpu: host1x: Use correct semantics for HOST1X_CHANNEL_DMAEND
      gpu: host1x: Optimize CDMA push buffer memory usage
      drm/tegra: Store parent pointer in Tegra DRM clients
      drm/tegra: vic: Load firmware on demand
      drm/tegra: Setup shared IOMMU domain after initialization
      drm/tegra: Restrict IOVA space to DMA mask
      drm/tegra: vic: Do not clear driver data
      drm/tegra: vic: Support stream ID register programming
      dt-bindings: display: tegra: Support SOR crossbar configuration
      drm/tegra: sor: Support device tree crossbar configuration

Thomas Zimmermann (7):
      drm/ast: Replace ttm_bo_unref with ttm_bo_put
      drm/nouveau: Replace ttm_bo_reference with ttm_bo_get
      drm/nouveau: Replace ttm_bo_unref with ttm_bo_put
      drm/vmwgfx: Replace ttm_bo_reference with ttm_bo_get
      drm/vmwgfx: Replace ttm_bo_unref with ttm_bo_put
      drm/mgag200: Replace ttm_bo_unref with ttm_bo_put
      drm/ttm: Remove ttm_bo_reference and ttm_bo_unref

Tiecheng Zhou (1):
      drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence

Tom St Denis (1):
      drm/amd/amdgpu: add missing mutex lock to amdgpu_get_xgmi_hive() (v3)

Tomasz Lis (2):
      drm/i915/skl: Rework MOCS tables to keep common part in a define
      drm/i915/icl: Define MOCS table for Icelake

Tony Cheng (1):
      drm/amd/display: refactor reg_update

Tvrtko Ursulin (10):
      drm/i915: Dial down workaround debug messages
      drm/i915: Remove has_pooled_eu static initializer
      drm/i915: Fix wakeref cookie handling in debugfs/i915_forcewake_user
      drm/i915/execlists: Move RPCS setup to context pin
      drm/i915: Move workaround infrastructure code up
      drm/i915: Save some lines of source code in workarounds
      drm/i915: Add timeline barrier support
      drm/i915: Expose RPCS (SSEU) configuration to userspace (Gen11 only)
      drm/i915/selftests: Context SSEU reconfiguration tests
      drm/i915/pmu: Fix enable count array size and bounds checking

Ville Syrj=C3=A4l=C3=A4 (62):
      drm/i915: Use explicit old crtc state in skl_compute_wm()
      drm/i915: Remove bogus FIXME from SKL wm computation
      drm/i915: Remove dead update_wm_pre assignment from SKL wm code
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers
      drm/dp/mst: Validate REMOTE_I2C_READ harder
      drm/edid: Pass connector to AVI infoframe functions
      drm/i915: Use drm_hdmi_avi_infoframe_quant_range() for SDVO HDMI as w=
ell
      drm/radeon: Use drm_hdmi_avi_infoframe_quant_range()
      drm/edid: Add display_info.rgb_quant_range_selectable
      drm/vblank: Allow dynamic per-crtc max_vblank_count
      drm/dp: Implement I2C_M_STOP for i2c-over-aux
      drm/i915: Don't try to use the hardware frame counter with
i965gm TV output
      drm/i915/tv: Fix interlaced ysize calculation
      drm/i915/tv: Fix tv mode clocks
      drm/i915/tv: Store the TV oversampling factor in the TV mode
      drm/i915/tv: Use bools where appropriate
      drm/i915/tv: Nuke silly 0 initialzation of xpos/ypos
      drm/i915/tv: Deobfuscate preferred mode selection
      drm/i915/tv: Use drm_mode_set_name() to name TV modes
      drm/i915/tv: Make TV mode autoselection actually useable
      drm/i915/tv: Nuke reported_modes[]
      drm/i915/tv: Add 1080p30/50/60 TV modes
      drm/i915/tv: Generate better pipe timings for TV encoder
      drm/i915/tv: Fix >1024 modes on gen3
      drm/i915/tv: Filter out >1024 wide modes that would need
vertical scaling on gen3
      video/hdmi: Add an enum for HDMI packet types
      drm/i915: Clean up intel_plane_atomic_check_with_state()
      drm/i915/tv: Fix return value for intel_tv_compute_config()
      drm/i915/tv: Use the scanline counter for timestamps on i965gm TV out=
put
      drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BI=
OSen
      drm/i915: Fix skl srckey mask bits
      drm: Constify drm_color_lut_check()
      drm/i915/tv: Fix adjusted_mode dotclock for interlaced modes
      drm/i915/tv: Bypass the vertical filter if possible
      drm/i915: Don't ignore level 0 lines watermark for glk+
      drm/i915: Reinstate an early latency=3D=3D0 check for skl+
      drm/i915: Fix bits vs. bytes mixup in dbuf block size computation
      drm/i915: Fix > vs >=3D mismatch in watermark/ddb calculations
      drm/i915: Account for minimum ddb allocation restrictions
      drm/i915: Pass dev_priv to skl_needs_memory_bw_wa()
      drm/i915: Drop the definite article in front of SAGV
      drm/i915: Drop the pointless linetime=3D=3D0 check
      drm/i915: Use IS_GEN9_LP() for the linetime w/a check
      drm/dp/mst: Provide defines for ACK vs. NAK reply type
      drm/dp/mst: Provide better debugs for NAK replies
      drm/i915: Don't use the second dbuf slice on icl
      drm/i915: Pick the first unused PLL once again
      drm/i915: Include register polling in reg_rw traces
      drm/i915: Fix wm latency=3D=3D0 disable on skl+
      drm/i915: Extract icl_set_pipe_chicken()
      drm/i915: Setup PIPE_CHICKEN for fastsets too
      drm/i915: W/A for underruns with WM1+ disabled on icl
      drm/i915: Bump skl+ wm blocks to 11 bits
      drm/i915: Just use icl+ definition for PLANE_WM blocks field
      drm: Nuke drm_calc_{h,v}scale_relaxed()
      drm/i915: Don't set update_wm_post on g4x+
      drm/i915: Split the gamma/csc enable bits from the plane_ctl() functi=
on
      drm/i915: Precompute gamma_mode
      drm/i915: Constify the state arguments to the color management stuff
      drm/i915: Pull GAMMA_MODE write out from haswell_load_luts()
      drm/i915: Split color mgmt based on single vs. double buffered regist=
ers
      drm/i915: Move LUT programming to happen after vblank waits

Wenjing Liu (2):
      drm/amd/display: implement dc_init_callbacks to assign callback
pointers after dc_create
      drm/amd/display: determine if a pipe is synced by plane state

Wesley Chalmers (1):
      drm/amd/display: Disable Stutter for Stereo 3D

Xiangliang Yu (2):
      drm/amdgpu/psp: Fix to get wrong xgmi session id
      drm/amdgpu/psp: Fix can't detect psp INVOKE command failed

Xiaodong Yan (1):
      drm/amd/display: Add monitor patch for backlight off

Yangtao Li (1):
      dma-buf: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yong Zhao (8):
      drm/amdgpu: Fix bugs in setting CP RB/MEC DOORBELL_RANGE registers
      drm/amdgpu: Delete user queue doorbell variables
      drm/amdkfd: Move a constant definition around
      drm/amdgpu: Add first_non_cp and last_non_cp in amdgpu_doorbell_index
      drm/amdkfd: Fix bugs regarding CP queue doorbell mask on SOC15
      drm/amdkfd: Optimize out sdma doorbell array in kgd2kfd_shared_resour=
ces
      Revert "drm/amdgpu: Delete user queue doorbell variables"
      Revert "drm/amdgpu: Fix bugs in setting CP RB/MEC DOORBELL_RANGE
registers"

Yongqiang Sun (3):
      drm/amd/display: pass vline_config parameter by reference.
      drm/amd/display: Calc vline position in dc.
      drm/amd/display: Refactor for setup periodic interrupt.

Young Xiao (1):
      drm/i915: avoid division by zero on skl_calc_wrpll_link

YueHaibing (5):
      drm/ast: Remove set but not used variable 'bo'
      drm: Fix error handling in drm_legacy_addctx
      drm/shmob: Fix return value check in shmob_drm_probe
      drm/stm: ltdc: remove set but not used variable 'src_h'
      drm/xen-front: Drop pointless static qualifier in fb_destroy()

Zhenyu Wang (3):
      drm/i915/gvt: mandatory require hypervisor's host_init
      drm/i915/gvt: remove unused parameter for hypervisor's host_exit call
      drm/i915/gvt: Change KVMGT as self load module

abdoulaye berthe (1):
      drm/amd/display: fix CTS 4.2.2.8

emersion (1):
      drm/vkms: set preferred depth to 24

fred gao (6):
      drm/i915/gvt: Add coffeelake platform definition
      drm/i915/gvt: Add mmio handler for CFL
      drm/i915/gvt: Enable gfx virtualiztion for CFL
      drm/i915/gvt: Reuse the gmbus pin macro
      drm/i915/gvt: Refine port select logic for CFL platform
      drm/i915: Enable gfx virtualization for Coffeelake platform

hersen wu (3):
      drm/amd/display: dal-pplib interface refactor dal part
      drm/amd/display: fix eDP fast bootup for pre-raven asic
      drm/amd/display: Connect dig_fe to otg directly instead of calling bi=
os

james qian wang (Arm Technology China) (10):
      drm/arm: Delete redundant CONFIG_DRM_ARM
      drm/komeda: komeda_dev/pipeline/component definition and initialzatio=
n
      dt/bindings: drm/komeda: Add DT bindings for ARM display processor D7=
1
      drm/komeda: Build komeda to be a platform module
      drm/komeda: Add DT parsing
      drm/komeda: Add komeda_format_caps for format handling
      drm/komeda: Add komeda_framebuffer
      drm/komeda: Attach komeda_dev to DRM-KMS
      drm/doc: Add initial komeda driver documentation
      MAINTAINERS: Add maintainer for Arm komeda driver

mark mcgarrity (1):
      drm/amd/display: 3.2.17

ndesaulniers@google.com (1):
      drm/amd/display: add -msse2 to prevent Clang from emitting
libcalls to undefined SW FP routines

shaoyunl (2):
      drm/amdgpu: Add message print when unable to get valid hive
      drm/amdgpu: Show XGMI node and hive message per device only once

wentalou (6):
      drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL
      drm/amdgpu: distinguish early and late re-init log in sriov
      drm/amdgpu: sriov should skip asic_reset in device_init
      drm/amdgpu: csa_vaddr should not larger than AMDGPU_GMC_HOLE_START
      drm/amdgpu: sriov restrict max_pfn below AMDGPU_GMC_HOLE
      drm/amdgpu: tighten gpu_recover in mailbox_flr to avoid
duplicate recover in sriov

 .../devicetree/bindings/display/arm,komeda.txt     |   73 +
 .../bindings/display/bridge/lvds-transmitter.txt   |   12 +-
 .../bindings/display/bridge/renesas,lvds.txt       |    4 +-
 .../bindings/display/bridge/thine,thc63lvdm83d.txt |    2 +-
 .../bindings/display/bridge/ti,ds90c185.txt        |   55 +
 .../devicetree/bindings/display/msm/gmu.txt        |   59 +
 .../devicetree/bindings/display/msm/gpu.txt        |   42 +-
 .../panel/{auo,g101evn010 =3D> auo,g101evn010.txt}   |    0
 .../bindings/display/panel/innolux,ee101ia-01d.txt |    7 +
 .../display/panel/lemaker,bl035-rgb-002.txt        |   12 +
 .../bindings/display/panel/pda,91-00156-a0.txt     |   14 +
 .../bindings/display/panel/sitronix,st7701.txt     |   30 +
 .../devicetree/bindings/display/renesas,du.txt     |    2 +
 .../bindings/display/rockchip/rockchip-vop.txt     |    1 +
 .../bindings/display/sunxi/sun4i-drm.txt           |    5 +
 .../display/tegra/nvidia,tegra20-host1x.txt        |    3 +
 .../devicetree/bindings/gpu/samsung-rotator.txt    |    7 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 Documentation/gpu/afbc.rst                         |  235 +
 Documentation/gpu/dp-mst/topology-figure-1.dot     |   52 +
 Documentation/gpu/dp-mst/topology-figure-2.dot     |   56 +
 Documentation/gpu/dp-mst/topology-figure-3.dot     |   59 +
 Documentation/gpu/drivers.rst                      |    2 +
 Documentation/gpu/drm-internals.rst                |   74 +-
 Documentation/gpu/drm-kms-helpers.rst              |   54 +-
 Documentation/gpu/drm-kms.rst                      |   96 -
 Documentation/gpu/drm-uapi.rst                     |    8 +
 Documentation/gpu/komeda-kms.rst                   |  488 ++
 Documentation/gpu/todo.rst                         |  110 +-
 Documentation/gpu/vkms.rst                         |   11 -
 MAINTAINERS                                        |   43 +-
 drivers/acpi/pmic/intel_pmic.c                     |   61 +
 drivers/acpi/pmic/intel_pmic.h                     |    4 +
 drivers/acpi/pmic/intel_pmic_chtwc.c               |   19 +
 drivers/acpi/pmic/intel_pmic_xpower.c              |    1 +
 drivers/dma-buf/dma-buf.c                          |   12 +-
 drivers/dma-buf/dma-fence.c                        |    2 +-
 drivers/dma-buf/sw_sync.c                          |    2 +-
 drivers/dma-buf/sync_debug.c                       |   16 +-
 drivers/dma-buf/sync_file.c                        |    4 +-
 drivers/gpu/drm/Kconfig                            |    4 -
 drivers/gpu/drm/Makefile                           |    4 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  121 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  142 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  129 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h       |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |   88 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    7 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   75 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |   10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  354 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  141 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  133 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |    5 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |    2 +
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                | 6844 ----------------=
----
 drivers/gpu/drm/amd/amdgpu/ci_dpm.h                |  349 -
 drivers/gpu/drm/amd/amdgpu/ci_smc.c                |  279 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   75 +-
 drivers/gpu/drm/amd/amdgpu/cik_dpm.h               |    1 -
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |   36 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |   40 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |    5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   25 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   25 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   44 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   14 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |   36 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |   10 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   11 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |   90 -
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   75 -
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   72 -
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    5 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   12 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   56 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    2 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |   38 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  167 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |   60 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    6 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |  324 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |    9 +-
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c       |   21 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   69 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   16 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |   31 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   44 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 1519 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   48 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   49 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  109 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   59 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |    2 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    5 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |   14 -
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   18 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |   96 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |    4 -
 .../gpu/drm/amd/display/dc/bios/command_table.c    |  135 +-
 .../gpu/drm/amd/display/dc/bios/command_table.h    |    3 -
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |   82 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |    3 -
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |   10 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c   |   45 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   19 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  261 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  147 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  162 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   90 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   17 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   82 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   69 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |    9 +-
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |  123 +
 drivers/gpu/drm/amd/display/dc/dc.h                |   21 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |    9 -
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   13 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   36 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    3 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   69 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |   45 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |  647 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |   30 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |  123 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.h   |   35 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  224 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |  129 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   12 +
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |    8 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    2 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |   79 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h    |    8 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |    4 +-
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |    2 -
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  212 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   16 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |    6 +-
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |   15 +
 .../amd/display/dc/dce120/dce120_hw_sequencer.h    |    1 +
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   84 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |    4 +-
 .../amd/display/dc/dce80/dce80_timing_generator.c  |    8 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c   |  107 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |   12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |   42 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |  203 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |   37 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   28 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |    7 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  397 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    2 +
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |   15 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |   36 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |  184 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |   23 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   74 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   79 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |   10 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    7 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    3 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |   14 +-
 .../drm/amd/display/dc/dml/display_mode_enums.h    |   26 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |   28 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    2 +
 .../drm/amd/display/dc/dml/display_mode_structs.h  |  107 +-
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |   12 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |   28 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.h |   10 +
 drivers/gpu/drm/amd/display/dc/i2caux/Makefile     |   99 -
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.c |  606 --
 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.h |   86 -
 .../amd/display/dc/i2caux/dce100/i2caux_dce100.c   |  106 -
 .../display/dc/i2caux/dce110/aux_engine_dce110.c   |  505 --
 .../display/dc/i2caux/dce110/aux_engine_dce110.h   |   78 -
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.c        |  574 --
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.h        |  218 -
 .../dc/i2caux/dce110/i2c_sw_engine_dce110.c        |  160 -
 .../amd/display/dc/i2caux/dce110/i2caux_dce110.c   |  329 -
 .../amd/display/dc/i2caux/dce110/i2caux_dce110.h   |   54 -
 .../amd/display/dc/i2caux/dce112/i2caux_dce112.c   |  129 -
 .../amd/display/dc/i2caux/dce112/i2caux_dce112.h   |   32 -
 .../amd/display/dc/i2caux/dce120/i2caux_dce120.c   |  120 -
 .../display/dc/i2caux/dce80/i2c_hw_engine_dce80.c  |  875 ---
 .../display/dc/i2caux/dce80/i2c_hw_engine_dce80.h  |   54 -
 .../display/dc/i2caux/dce80/i2c_sw_engine_dce80.c  |  173 -
 .../drm/amd/display/dc/i2caux/dce80/i2caux_dce80.c |  284 -
 .../drm/amd/display/dc/i2caux/dcn10/i2caux_dcn10.c |  120 -
 .../drm/amd/display/dc/i2caux/dcn10/i2caux_dcn10.h |   32 -
 .../display/dc/i2caux/diagnostics/i2caux_diag.c    |   97 -
 .../display/dc/i2caux/diagnostics/i2caux_diag.h    |   32 -
 drivers/gpu/drm/amd/display/dc/i2caux/engine.h     |  111 -
 drivers/gpu/drm/amd/display/dc/i2caux/i2c_engine.c |  118 -
 drivers/gpu/drm/amd/display/dc/i2caux/i2c_engine.h |  115 -
 .../amd/display/dc/i2caux/i2c_generic_hw_engine.c  |  284 -
 .../amd/display/dc/i2caux/i2c_generic_hw_engine.h  |   77 -
 .../gpu/drm/amd/display/dc/i2caux/i2c_hw_engine.c  |  251 -
 .../gpu/drm/amd/display/dc/i2caux/i2c_hw_engine.h  |   80 -
 .../gpu/drm/amd/display/dc/i2caux/i2c_sw_engine.c  |  601 --
 .../gpu/drm/amd/display/dc/i2caux/i2c_sw_engine.h  |   81 -
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     |  491 --
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.h     |  122 -
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |   12 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    9 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |   17 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   19 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |   16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |    5 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    3 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |    4 +-
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    4 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |   17 +-
 .../dc/{i2caux/engine_base.c =3D> inc/hw/vmid.h}     |   45 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   14 +
 .../i2c_sw_engine_dce110.h =3D> inc/vm_helper.h}     |   39 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h         |    8 +
 .../drm/amd/display/include/bios_parser_types.h    |    4 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |    3 +
 .../gpu/drm/amd/display/include/gpio_interface.h   |    8 +
 .../gpu/drm/amd/display/include/i2caux_interface.h |   33 +-
 .../drm/amd/display/modules/color/color_gamma.c    |  165 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  106 +-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |    2 +-
 .../gpu/drm/amd/display/modules/inc/mod_shared.h   |    3 +-
 .../drm/amd/display/modules/power/power_helpers.c  |  612 +-
 .../amd/include/asic_reg/nbio/nbio_6_1_offset.h    |    2 +
 .../amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h   |    4 +
 .../drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h   |   58 +
 .../drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h   |   54 +
 .../drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h |   53 +
 .../amd/include/asic_reg/nbio/nbio_7_4_offset.h    |    2 +
 .../amd/include/asic_reg/nbio/nbio_7_4_sh_mask.h   |    3 +
 .../amd/include/asic_reg/thm/thm_11_0_2_offset.h   |    3 +
 drivers/gpu/drm/amd/include/atombios.h             |    2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   72 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    8 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   96 +
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.c  |  101 +
 .../hwmgr/common_baco.h}                           |   39 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |    9 -
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   10 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   14 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.h       |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    2 +
 .../gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c   |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c   |    8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c  |  158 +
 .../hwmgr/vega10_baco.h}                           |   22 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  196 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.h |    1 +
 .../gpu/drm/amd/powerplay/hwmgr/vega10_pptable.h   |   24 +
 .../amd/powerplay/hwmgr/vega10_processpptables.c   |   50 +-
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   |   37 +
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.h   |    1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |  198 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c  |  103 +
 .../hwmgr/vega20_baco.h}                           |   18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |  419 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h |    3 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_inc.h   |    1 +
 .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |    1 -
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |   12 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |    4 +
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |    4 +-
 drivers/gpu/drm/arc/arcpgu_drv.c                   |   10 +-
 drivers/gpu/drm/arc/arcpgu_sim.c                   |    4 +-
 drivers/gpu/drm/arm/Kconfig                        |   12 +-
 drivers/gpu/drm/arm/Makefile                       |    1 +
 drivers/gpu/drm/arm/display/Kbuild                 |    3 +
 drivers/gpu/drm/arm/display/Kconfig                |   14 +
 drivers/gpu/drm/arm/display/include/malidp_io.h    |   42 +
 .../gpu/drm/arm/display/include/malidp_product.h   |   23 +
 drivers/gpu/drm/arm/display/include/malidp_utils.h |   16 +
 drivers/gpu/drm/arm/display/komeda/Makefile        |   21 +
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |  111 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  110 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  190 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  110 +
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |  144 +
 .../drm/arm/display/komeda/komeda_format_caps.c    |   75 +
 .../drm/arm/display/komeda/komeda_format_caps.h    |   89 +
 .../drm/arm/display/komeda/komeda_framebuffer.c    |  167 +
 .../drm/arm/display/komeda/komeda_framebuffer.h    |   34 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  171 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  114 +
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  202 +
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  359 +
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  109 +
 .../drm/arm/display/komeda/komeda_private_obj.c    |   88 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    4 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    6 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    2 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    2 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |    2 +-
 drivers/gpu/drm/armada/armada_510.c                |    2 +-
 drivers/gpu/drm/armada/armada_crtc.c               |   10 +-
 drivers/gpu/drm/armada/armada_crtc.h               |    2 +
 drivers/gpu/drm/armada/armada_drv.c                |    2 +-
 drivers/gpu/drm/armada/armada_fb.c                 |    2 +-
 drivers/gpu/drm/ast/ast_drv.c                      |    1 +
 drivers/gpu/drm/ast/ast_fb.c                       |    6 +-
 drivers/gpu/drm/ast/ast_main.c                     |    6 +-
 drivers/gpu/drm/ast/ast_mode.c                     |    1 +
 drivers/gpu/drm/ati_pcigart.c                      |    7 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |    2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |    2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |  181 +-
 drivers/gpu/drm/bochs/Makefile                     |    2 +-
 drivers/gpu/drm/bochs/bochs.h                      |   23 +-
 drivers/gpu/drm/bochs/bochs_drv.c                  |   36 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c                |  163 -
 drivers/gpu/drm/bochs/bochs_hw.c                   |   26 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |  219 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |   69 +-
 drivers/gpu/drm/bridge/Kconfig                     |    1 +
 drivers/gpu/drm/bridge/adv7511/adv7511.h           |    8 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    9 +-
 drivers/gpu/drm/bridge/adv7511/adv7533.c           |    2 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |   11 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    6 +-
 drivers/gpu/drm/bridge/cdns-dsi.c                  |  542 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    2 +-
 drivers/gpu/drm/bridge/lvds-encoder.c              |   53 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    2 +-
 drivers/gpu/drm/bridge/panel.c                     |   24 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |    9 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |    3 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |    9 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  151 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h          |    1 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   20 +-
 drivers/gpu/drm/bridge/tc358764.c                  |    2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   11 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    2 +-
 drivers/gpu/drm/cirrus/cirrus_drv.c                |    1 +
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |    3 +
 drivers/gpu/drm/cirrus/cirrus_mode.c               |   71 +-
 drivers/gpu/drm/drm_agpsupport.c                   |    2 +-
 drivers/gpu/drm/drm_atomic.c                       |   19 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   19 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    4 +-
 drivers/gpu/drm/drm_bridge.c                       |    4 +-
 drivers/gpu/drm/drm_bufs.c                         |   15 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |   43 +
 drivers/gpu/drm/drm_connector.c                    |   95 +-
 drivers/gpu/drm/drm_context.c                      |   15 +-
 drivers/gpu/drm/drm_crtc.c                         |   41 -
 drivers/gpu/drm/drm_crtc_helper.c                  |   58 +-
 drivers/gpu/drm/drm_crtc_internal.h                |    1 +
 drivers/gpu/drm/drm_damage_helper.c                |   42 +
 drivers/gpu/drm/drm_dp_helper.c                    |   61 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 1153 +++-
 drivers/gpu/drm/drm_drv.c                          |   24 +-
 drivers/gpu/drm/drm_dsc.c                          |   30 +-
 drivers/gpu/drm/drm_edid.c                         |  101 +-
 drivers/gpu/drm/drm_fb_cma_helper.c                |  137 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  171 +-
 drivers/gpu/drm/drm_file.c                         |   24 +-
 drivers/gpu/drm/drm_flip_work.c                    |    1 +
 drivers/gpu/drm/drm_fourcc.c                       |    9 +
 drivers/gpu/drm/drm_framebuffer.c                  |    3 +-
 drivers/gpu/drm/drm_gem.c                          |   38 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |   50 +-
 drivers/gpu/drm/drm_internal.h                     |    2 +
 drivers/gpu/drm/drm_ioctl.c                        |   22 +-
 drivers/gpu/drm/drm_irq.c                          |   10 +-
 drivers/gpu/drm/drm_lease.c                        |    6 +-
 drivers/gpu/drm/drm_mm.c                           |    2 +-
 drivers/gpu/drm/drm_mode_config.c                  |    5 +-
 drivers/gpu/drm/drm_mode_object.c                  |    9 +-
 drivers/gpu/drm/drm_modes.c                        |   11 +-
 drivers/gpu/drm/drm_modeset_helper.c               |    4 +-
 drivers/gpu/drm/drm_modeset_lock.c                 |    8 +
 drivers/gpu/drm/drm_of.c                           |    4 +-
 drivers/gpu/drm/drm_panel.c                        |    3 +
 drivers/gpu/drm/drm_plane.c                        |    3 +
 drivers/gpu/drm/drm_probe_helper.c                 |    2 +-
 drivers/gpu/drm/drm_property.c                     |    2 +-
 drivers/gpu/drm/drm_rect.c                         |  108 -
 drivers/gpu/drm/drm_simple_kms_helper.c            |    2 +-
 drivers/gpu/drm/drm_syncobj.c                      |   91 +-
 drivers/gpu/drm/drm_vblank.c                       |   47 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    1 -
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   11 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |    3 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |    4 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   23 +
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |    4 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |    7 +-
 drivers/gpu/drm/exynos/regs-scaler.h               |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |    4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |    2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    2 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    1 -
 drivers/gpu/drm/gma500/psb_drv.c                   |    3 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h             |    1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    5 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |   13 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    8 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |   44 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h    |    4 -
 drivers/gpu/drm/i2c/ch7006_drv.c                   |    6 +-
 drivers/gpu/drm/i2c/ch7006_priv.h                  |    1 +
 drivers/gpu/drm/i2c/sil164_drv.c                   |    2 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   12 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |    3 +-
 drivers/gpu/drm/i915/Makefile                      |   12 +-
 drivers/gpu/drm/i915/dvo.h                         |    1 -
 drivers/gpu/drm/i915/gvt/Makefile                  |    1 -
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |    8 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   83 +-
 drivers/gpu/drm/i915/gvt/display.c                 |   43 +-
 drivers/gpu/drm/i915/gvt/display.h                 |   37 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |    5 +-
 drivers/gpu/drm/i915/gvt/edid.c                    |   32 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c              |   12 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |  109 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   11 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   29 +-
 drivers/gpu/drm/i915/gvt/hypercall.h               |   10 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |    4 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  185 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |    6 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |   11 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |   18 +-
 drivers/gpu/drm/i915/gvt/mpt.h                     |   30 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c            |    4 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   11 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    2 +-
 drivers/gpu/drm/i915/gvt/trace.h                   |    2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |   10 +-
 drivers/gpu/drm/i915/i915_active.c                 |  286 +
 drivers/gpu/drm/i915/i915_active.h                 |  425 ++
 drivers/gpu/drm/i915/i915_active_types.h           |   36 +
 drivers/gpu/drm/i915/i915_cmd_parser.c             |    2 +-
 drivers/gpu/drm/i915/i915_debugfs.c                | 1064 ++-
 drivers/gpu/drm/i915/i915_drv.c                    |  283 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  519 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  961 +--
 drivers/gpu/drm/i915/i915_gem_context.c            |  388 +-
 drivers/gpu/drm/i915/i915_gem_context.h            |   26 +
 drivers/gpu/drm/i915/i915_gem_dmabuf.c             |    1 -
 drivers/gpu/drm/i915/i915_gem_evict.c              |   90 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   89 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |   29 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.h          |    1 -
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  229 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |   57 +-
 drivers/gpu/drm/i915/i915_gem_internal.c           |    1 -
 drivers/gpu/drm/i915/i915_gem_object.h             |   57 +-
 drivers/gpu/drm/i915/i915_gem_shrinker.c           |  175 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |   13 +-
 drivers/gpu/drm/i915/i915_gem_tiling.c             |    5 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |  225 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |  296 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |   41 +-
 drivers/gpu/drm/i915/i915_ioc32.c                  |    2 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  475 +-
 drivers/gpu/drm/i915/i915_params.c                 |   38 +-
 drivers/gpu/drm/i915/i915_params.h                 |   13 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   33 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   33 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   23 +-
 drivers/gpu/drm/i915/i915_query.c                  |    2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  300 +-
 drivers/gpu/drm/i915/i915_request.c                |  452 +-
 drivers/gpu/drm/i915/i915_request.h                |  497 +-
 drivers/gpu/drm/i915/i915_reset.c                  | 1349 ++++
 drivers/gpu/drm/i915/i915_reset.h                  |   59 +
 drivers/gpu/drm/i915/i915_scheduler.c              |   29 +-
 drivers/gpu/drm/i915/i915_selftest.h               |    1 +
 drivers/gpu/drm/i915/i915_suspend.c                |   17 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |    2 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |   27 +-
 drivers/gpu/drm/i915/i915_timeline.c               |  257 +-
 drivers/gpu/drm/i915/i915_timeline.h               |   61 +-
 drivers/gpu/drm/i915/i915_trace.h                  |   57 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  261 +-
 drivers/gpu/drm/i915/i915_vma.h                    |   58 +-
 drivers/gpu/drm/i915/icl_dsi.c                     |   45 +-
 drivers/gpu/drm/i915/intel_acpi.c                  |    1 -
 drivers/gpu/drm/i915/intel_atomic.c                |    9 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |   43 +-
 drivers/gpu/drm/i915/intel_audio.c                 |    6 +-
 drivers/gpu/drm/i915/intel_bios.c                  |   30 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |  911 +--
 drivers/gpu/drm/i915/intel_cdclk.c                 |   60 +-
 drivers/gpu/drm/i915/intel_color.c                 |  411 +-
 drivers/gpu/drm/i915/intel_connector.c             |    5 +-
 drivers/gpu/drm/i915/intel_crt.c                   |   91 +-
 drivers/gpu/drm/i915/intel_csr.c                   |   93 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  202 +-
 drivers/gpu/drm/i915/intel_device_info.c           |  107 +-
 drivers/gpu/drm/i915/intel_device_info.h           |   35 +-
 drivers/gpu/drm/i915/intel_display.c               |  876 ++-
 drivers/gpu/drm/i915/intel_display.h               |    6 +-
 drivers/gpu/drm/i915/intel_dp.c                    |  643 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |   32 +-
 drivers/gpu/drm/i915/intel_dp_mst.c                |   97 +-
 drivers/gpu/drm/i915/intel_dpio_phy.c              |   18 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |  302 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.h              |   55 +-
 drivers/gpu/drm/i915/intel_drv.h                   |  231 +-
 drivers/gpu/drm/i915/intel_dsi.h                   |    6 +-
 drivers/gpu/drm/i915/intel_dsi_vbt.c               |   24 +-
 drivers/gpu/drm/i915/intel_dvo.c                   |   12 +-
 drivers/gpu/drm/i915/intel_engine_cs.c             |  430 +-
 drivers/gpu/drm/i915/intel_fbc.c                   |   35 +-
 drivers/gpu/drm/i915/intel_fbdev.c                 |   12 +-
 drivers/gpu/drm/i915/intel_fifo_underrun.c         |   24 +-
 drivers/gpu/drm/i915/intel_frontbuffer.c           |    1 -
 drivers/gpu/drm/i915/intel_gpu_commands.h          |    1 -
 drivers/gpu/drm/i915/intel_guc.h                   |    3 +
 drivers/gpu/drm/i915/intel_guc_fw.c                |    6 +-
 drivers/gpu/drm/i915/intel_guc_log.c               |   32 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |   25 +-
 drivers/gpu/drm/i915/intel_gvt.c                   |   12 +-
 drivers/gpu/drm/i915/intel_hangcheck.c             |  207 +-
 drivers/gpu/drm/i915/intel_hdcp.c                  |   21 +-
 drivers/gpu/drm/i915/intel_hdmi.c                  |   59 +-
 drivers/gpu/drm/i915/intel_hotplug.c               |    8 +-
 drivers/gpu/drm/i915/intel_huc.c                   |    8 +-
 drivers/gpu/drm/i915/intel_huc_fw.c                |    7 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |   23 +-
 drivers/gpu/drm/i915/intel_lpe_audio.c             |    1 +
 drivers/gpu/drm/i915/intel_lrc.c                   |  703 +-
 drivers/gpu/drm/i915/intel_lrc.h                   |   12 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |   36 +-
 drivers/gpu/drm/i915/intel_lvds.c                  |   49 +-
 drivers/gpu/drm/i915/intel_mocs.c                  |  408 +-
 drivers/gpu/drm/i915/intel_mocs.h                  |    1 -
 drivers/gpu/drm/i915/intel_opregion.c              |    1 -
 drivers/gpu/drm/i915/intel_overlay.c               |   48 +-
 drivers/gpu/drm/i915/intel_panel.c                 |  102 +-
 drivers/gpu/drm/i915/intel_pipe_crc.c              |   32 +-
 drivers/gpu/drm/i915/intel_pm.c                    | 1229 ++--
 drivers/gpu/drm/i915/intel_psr.c                   |   83 +-
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  699 +-
 drivers/gpu/drm/i915/intel_ringbuffer.h            |  289 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  594 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |  123 +-
 drivers/gpu/drm/i915/intel_sprite.c                |  145 +-
 drivers/gpu/drm/i915/intel_tv.c                    |  727 ++-
 drivers/gpu/drm/i915/intel_uc.c                    |   15 +-
 drivers/gpu/drm/i915/intel_uc.h                    |    6 +-
 drivers/gpu/drm/i915/intel_uc_fw.c                 |   11 +-
 drivers/gpu/drm/i915/intel_uncore.c                |  511 +-
 drivers/gpu/drm/i915/intel_vdsc.c                  |    5 +-
 drivers/gpu/drm/i915/intel_wopcm.c                 |    6 +-
 drivers/gpu/drm/i915/intel_workarounds.c           |  199 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |   42 +-
 drivers/gpu/drm/i915/selftests/i915_active.c       |  157 +
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   47 +-
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |    5 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |  607 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  105 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  123 +-
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |   22 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |    2 +
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    3 +-
 drivers/gpu/drm/i915/selftests/i915_random.c       |   33 +-
 drivers/gpu/drm/i915/selftests/i915_random.h       |    3 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |  524 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |   47 +
 drivers/gpu/drm/i915/selftests/i915_timeline.c     |  464 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   81 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.c     |   78 +
 drivers/gpu/drm/i915/selftests/igt_live_test.h     |   35 +
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |   91 +-
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  470 --
 drivers/gpu/drm/i915/selftests/intel_guc.c         |   10 +-
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |  417 +-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |  272 +-
 drivers/gpu/drm/i915/selftests/intel_workarounds.c |  123 +-
 drivers/gpu/drm/i915/selftests/lib_sw_fence.c      |   54 +
 drivers/gpu/drm/i915/selftests/lib_sw_fence.h      |    3 +
 drivers/gpu/drm/i915/selftests/mock_context.c      |    7 +-
 drivers/gpu/drm/i915/selftests/mock_engine.c       |  162 +-
 drivers/gpu/drm/i915/selftests/mock_engine.h       |    6 -
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   26 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |   15 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.h          |    4 +-
 drivers/gpu/drm/i915/selftests/mock_timeline.c     |    6 +-
 drivers/gpu/drm/i915/vlv_dsi.c                     |   55 +-
 drivers/gpu/drm/i915/vlv_dsi_pll.c                 |   31 +-
 drivers/gpu/drm/imx/Kconfig                        |    3 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |    2 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |   13 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |    2 +-
 drivers/gpu/drm/imx/imx-tve.c                      |    2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |   42 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |   76 +-
 drivers/gpu/drm/imx/ipuv3-plane.h                  |    2 +
 drivers/gpu/drm/imx/parallel-display.c             |    2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    2 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c              |    2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    9 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |    2 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   30 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |   37 +-
 drivers/gpu/drm/meson/meson_venc.c                 |    2 +
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |    4 +-
 drivers/gpu/drm/mga/mga_drv.c                      |    2 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c               |    1 +
 drivers/gpu/drm/mgag200/mgag200_main.c             |    8 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h           |    2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   34 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   13 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |    3 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |    5 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |   37 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.h        |   14 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |    4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   19 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog_format.h  |  220 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   44 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   44 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |    7 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |    1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   65 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |   36 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   51 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |   27 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  325 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |   28 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |   28 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   12 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dsi_encoder.c   |   11 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c   |   11 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |   11 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c   |   11 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   11 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c       |   11 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |    1 +
 drivers/gpu/drm/msm/dsi/dsi.h                      |    2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    2 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |   13 +-
 drivers/gpu/drm/msm/edp/edp_bridge.c               |   13 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |    7 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  129 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   12 +-
 drivers/gpu/drm/msm/msm_fb.c                       |    2 +-
 drivers/gpu/drm/msm/msm_gem.c                      |    2 +-
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |    2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |   31 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |    1 -
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |    2 +-
 drivers/gpu/drm/nouveau/Kbuild                     |    2 +
 drivers/gpu/drm/nouveau/Kconfig                    |   12 +
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |  214 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |  216 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |    5 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |    5 +-
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |    6 +
 drivers/gpu/drm/nouveau/dispnv50/core.c            |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/curs.c            |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  145 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |    1 +
 drivers/gpu/drm/nouveau/dispnv50/wimm.c            |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |    2 +-
 drivers/gpu/drm/nouveau/include/nvif/class.h       |   13 +-
 drivers/gpu/drm/nouveau/include/nvif/clb069.h      |   12 +
 drivers/gpu/drm/nouveau/include/nvif/if000c.h      |   30 +-
 drivers/gpu/drm/nouveau/include/nvif/ifc00d.h      |   21 +
 drivers/gpu/drm/nouveau/include/nvif/vmm.h         |    4 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |    3 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/ce.h   |    2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |    2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h |    2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |    3 +
 .../gpu/drm/nouveau/include/nvkm/engine/nvdec.h    |    2 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec2.h |    3 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bar.h  |    2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/devinit.h  |    2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/fault.h    |    4 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |   14 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mc.h   |    2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mmu.h  |    6 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/top.h  |    1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |    1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    4 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    4 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h               |   12 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   32 +-
 drivers/gpu/drm/nouveau/nouveau_chan.h             |    1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    1 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |  309 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |   21 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  887 +++
 drivers/gpu/drm/nouveau/nouveau_dmem.h             |   60 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  248 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |    6 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    6 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |    2 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   46 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c              |  835 +++
 drivers/gpu/drm/nouveau/nouveau_svm.h              |   48 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |    4 +-
 drivers/gpu/drm/nouveau/nouveau_vmm.h              |    1 +
 drivers/gpu/drm/nouveau/nv84_fence.c               |    3 +-
 drivers/gpu/drm/nouveau/nvif/disp.c                |    2 +-
 drivers/gpu/drm/nouveau/nvif/vmm.c                 |    5 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/ce/Kbuild      |    2 +-
 .../nouveau/nvkm/engine/ce/{tu104.c =3D> tu102.c}    |    6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   86 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  |   15 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |    6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c   |   16 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |    7 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c    |   12 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.h    |    3 +
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.h    |    2 +-
 .../nvkm/engine/disp/{roottu104.c =3D> roottu102.c}  |   20 +-
 .../nvkm/engine/disp/{sortu104.c =3D> sortu102.c}    |   14 +-
 .../nouveau/nvkm/engine/disp/{tu104.c =3D> tu102.c}  |   14 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild    |    6 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/changk104.h   |    2 +-
 .../engine/fifo/{gpfifotu104.c =3D> gpfifotu102.c}   |   10 +-
 .../nouveau/nvkm/engine/fifo/{tu104.c =3D> tu102.c}  |   30 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/user.h    |    2 +-
 .../nvkm/engine/fifo/{usertu104.c =3D> usertu102.c}  |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c      |   27 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.c  |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |  331 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |   16 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/priv.h      |    5 +
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/base.c   |   10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/Kbuild    |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/base.c    |   23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp102.c   |    2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/priv.h    |    3 +-
 .../nvkm/engine/sec2/tu102.c}                      |   21 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/base.c         |    3 +
 drivers/gpu/drm/nouveau/nvkm/falcon/msgqueue.c     |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/Kbuild         |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/Kbuild     |    2 +-
 .../nouveau/nvkm/subdev/bar/{tu104.c =3D> tu102.c}   |   30 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c      |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c    |   11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/Kbuild |    2 +-
 .../nvkm/subdev/devinit/{tu104.c =3D> tu102.c}       |   14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/Kbuild   |    3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c   |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp100.c  |    3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c  |   16 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h   |    7 +
 .../nouveau/nvkm/subdev/fault/{tu104.c =3D> tu102.c} |   39 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/user.c   |  106 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c     |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/Kbuild     |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c    |   62 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/Kbuild      |    2 +-
 .../nouveau/nvkm/subdev/mc/{tu104.c =3D> tu102.c}    |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/Kbuild     |    4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp100.c    |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp10b.c    |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gv100.c    |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h     |    2 +-
 .../nouveau/nvkm/subdev/mmu/{tu104.c =3D> tu102.c}   |    8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c     |   83 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |  382 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h      |   82 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgf100.c |   56 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgk104.c |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgk20a.c |   10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm200.c |   22 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgm20b.c |   14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c |  210 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp10b.c |   12 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgv100.c |   12 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmmcp77.c |    8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv04.c  |   15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv41.c  |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv44.c  |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c  |    6 +-
 .../nvkm/subdev/mmu/{vmmtu104.c =3D> vmmtu102.c}     |   13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c     |    4 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c |    4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/base.c     |   16 +
 drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c    |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |   60 +
 drivers/gpu/drm/omapdrm/omap_connector.c           |   11 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |    9 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    2 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |    1 -
 drivers/gpu/drm/omapdrm/omap_encoder.c             |    6 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |    2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    1 +
 drivers/gpu/drm/panel/Kconfig                      |   30 +
 drivers/gpu/drm/panel/Makefile                     |    3 +
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   11 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |  473 ++
 drivers/gpu/drm/panel/panel-simple.c               |   54 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |  426 ++
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |  496 ++
 drivers/gpu/drm/pl111/pl111_drv.c                  |    8 +-
 drivers/gpu/drm/qxl/Makefile                       |    2 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |   36 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  340 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |  241 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |    6 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |   64 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |    2 +-
 drivers/gpu/drm/qxl/qxl_fb.c                       |  300 -
 drivers/gpu/drm/qxl/qxl_kms.c                      |   83 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |   12 +-
 drivers/gpu/drm/qxl/qxl_prime.c                    |   25 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |   20 +-
 drivers/gpu/drm/r128/r128_cce.c                    |    5 +-
 drivers/gpu/drm/r128/r128_drv.c                    |    2 +-
 drivers/gpu/drm/radeon/atom.c                      |    2 +
 drivers/gpu/drm/radeon/ci_dpm.c                    |    2 +
 drivers/gpu/drm/radeon/evergreen_cs.c              |    1 +
 drivers/gpu/drm/radeon/radeon_acpi.c               |    1 +
 drivers/gpu/drm/radeon/radeon_audio.c              |   14 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |    1 +
 drivers/gpu/drm/radeon/radeon_device.c             |    1 +
 drivers/gpu/drm/radeon/radeon_display.c            |    3 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |   10 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    5 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |    1 +
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |    1 +
 drivers/gpu/drm/radeon/si_dpm.c                    |    2 +
 drivers/gpu/drm/rcar-du/Kconfig                    |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   81 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |    8 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   45 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   12 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   17 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |    5 +-
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |   51 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   79 +-
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dts    |   93 +-
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dts    |   53 +-
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dts    |   53 +-
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dts    |   53 +-
 .../gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dts    |   53 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |    4 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.h            |    3 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |    3 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |    3 +-
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c             |   17 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  103 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.h                |   27 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |    2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |    2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    2 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |    6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |   38 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |    3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |   39 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |    3 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  163 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   15 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    2 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    2 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |  180 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h        |   53 +
 drivers/gpu/drm/savage/savage_state.c              |    4 +
 drivers/gpu/drm/scheduler/sched_entity.c           |   39 +-
 drivers/gpu/drm/scheduler/sched_main.c             |  219 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |    1 +
 drivers/gpu/drm/shmobile/shmob_drm_drv.c           |    7 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |    1 +
 drivers/gpu/drm/sti/sti_crtc.c                     |   18 +-
 drivers/gpu/drm/sti/sti_drv.c                      |    2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    6 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    6 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |    9 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |    2 +-
 drivers/gpu/drm/stm/drv.c                          |    8 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    2 +-
 drivers/gpu/drm/stm/ltdc.c                         |   15 +-
 drivers/gpu/drm/sun4i/Kconfig                      |    3 +-
 drivers/gpu/drm/sun4i/Makefile                     |    5 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   32 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |    7 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |  354 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.h             |   52 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    5 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |   63 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    3 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |    2 +-
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |    1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   34 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |   17 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |    2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    2 +-
 drivers/gpu/drm/tegra/Makefile                     |    1 +
 drivers/gpu/drm/tegra/drm.c                        |   57 +-
 drivers/gpu/drm/tegra/drm.h                        |    5 +-
 drivers/gpu/drm/tegra/fb.c                         |    2 +-
 drivers/gpu/drm/tegra/hda.c                        |   63 +
 drivers/gpu/drm/tegra/hda.h                        |   20 +
 drivers/gpu/drm/tegra/hdmi.c                       |  222 +-
 drivers/gpu/drm/tegra/hub.c                        |    4 +-
 drivers/gpu/drm/tegra/output.c                     |   11 +-
 drivers/gpu/drm/tegra/sor.c                        |   67 +-
 drivers/gpu/drm/tegra/vic.c                        |   75 +-
 drivers/gpu/drm/tegra/vic.h                        |    9 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   37 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |    5 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    1 +
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |    1 +
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |    1 +
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |   26 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |  100 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |   34 +-
 drivers/gpu/drm/tinydrm/hx8357d.c                  |    3 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |  151 +-
 drivers/gpu/drm/tinydrm/ili9341.c                  |    3 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |    3 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |   97 +-
 drivers/gpu/drm/tinydrm/repaper.c                  |   44 +-
 drivers/gpu/drm/tinydrm/st7586.c                   |   87 +-
 drivers/gpu/drm/tinydrm/st7735r.c                  |    3 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   20 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   19 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |   10 +-
 drivers/gpu/drm/udl/udl_connector.c                |    1 +
 drivers/gpu/drm/udl/udl_drv.c                      |    1 +
 drivers/gpu/drm/udl/udl_main.c                     |    1 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |    1 -
 drivers/gpu/drm/v3d/v3d_gem.c                      |   60 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |   13 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   45 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    1 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |    4 +
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   34 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    7 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |    2 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  145 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |    2 +-
 drivers/gpu/drm/vgem/vgem_fence.c                  |    4 +-
 drivers/gpu/drm/via/via_dmablit.c                  |    4 +
 drivers/gpu/drm/via/via_drv.c                      |    3 +-
 drivers/gpu/drm/virtio/Makefile                    |    2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   10 +-
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c           |  103 -
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   84 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   26 +-
 drivers/gpu/drm/virtio/virtgpu_fb.c                |  191 -
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    8 -
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    2 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   18 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |   13 +
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   17 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   12 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   26 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    3 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |   11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |    6 +-
 drivers/gpu/drm/xen/xen_drm_front.c                |    2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |    3 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |   15 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |    4 +-
 drivers/gpu/drm/zte/zx_drm_drv.c                   |    2 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |    6 +-
 drivers/gpu/drm/zte/zx_tvenc.c                     |    2 +-
 drivers/gpu/drm/zte/zx_vga.c                       |    2 +-
 drivers/gpu/drm/zte/zx_vou.c                       |    2 +-
 drivers/gpu/host1x/bus.c                           |   35 +
 drivers/gpu/host1x/cdma.c                          |  189 +-
 drivers/gpu/host1x/cdma.h                          |    8 +-
 drivers/gpu/host1x/dev.c                           |   49 +-
 drivers/gpu/host1x/dev.h                           |    8 +
 drivers/gpu/host1x/hw/cdma_hw.c                    |   46 +-
 drivers/gpu/host1x/hw/channel_hw.c                 |   43 +-
 drivers/gpu/host1x/hw/host1x06_hardware.h          |    6 +
 drivers/gpu/host1x/hw/host1x07_hardware.h          |    6 +
 drivers/gpu/host1x/hw/hw_host1x06_channel.h        |   11 +
 drivers/gpu/host1x/hw/hw_host1x07_channel.h        |   11 +
 drivers/gpu/ipu-v3/ipu-pre.c                       |    6 +
 drivers/gpu/ipu-v3/ipu-prg.c                       |   16 +
 drivers/gpu/ipu-v3/ipu-prv.h                       |    1 +
 drivers/phy/allwinner/Kconfig                      |   12 +
 drivers/phy/allwinner/Makefile                     |    1 +
 .../allwinner/phy-sun6i-mipi-dphy.c}               |  164 +-
 drivers/staging/vboxvideo/TODO                     |    3 +
 drivers/staging/vboxvideo/vbox_drv.c               |   10 +-
 drivers/staging/vboxvideo/vbox_fb.c                |   23 +-
 drivers/staging/vboxvideo/vbox_irq.c               |    4 +-
 drivers/staging/vboxvideo/vbox_mode.c              |    9 +-
 include/drm/bridge/dw_hdmi.h                       |    7 +-
 include/drm/bridge/dw_mipi_dsi.h                   |    3 +-
 include/drm/drmP.h                                 |   26 +-
 include/drm/drm_atomic.h                           |   54 +-
 include/drm/drm_bridge.h                           |    8 +-
 include/drm/drm_cache.h                            |   18 +
 include/drm/drm_client.h                           |    2 +-
 include/drm/drm_color_mgmt.h                       |   28 +
 include/drm/drm_connector.h                        |   12 +-
 include/drm/drm_crtc.h                             |    3 -
 include/drm/drm_crtc_helper.h                      |   17 +-
 include/drm/drm_damage_helper.h                    |    3 +
 include/drm/drm_device.h                           |  288 +-
 include/drm/drm_dp_helper.h                        |   37 +-
 include/drm/drm_dp_mst_helper.h                    |  153 +-
 include/drm/drm_drv.h                              |  137 +-
 include/drm/drm_dsc.h                              |  233 +-
 include/drm/drm_edid.h                             |   10 +-
 include/drm/drm_encoder_slave.h                    |    1 -
 include/drm/drm_fb_cma_helper.h                    |   22 -
 include/drm/drm_file.h                             |    1 +
 include/drm/drm_fourcc.h                           |  117 +
 include/drm/drm_framebuffer.h                      |   10 +-
 include/drm/drm_gem_cma_helper.h                   |    5 +-
 include/drm/drm_gem_framebuffer_helper.h           |    3 +
 include/drm/drm_hdcp.h                             |    2 +
 include/drm/drm_legacy.h                           |   14 +-
 include/drm/drm_mode_config.h                      |   25 +-
 include/drm/drm_modes.h                            |   21 +-
 include/drm/drm_modeset_helper.h                   |    6 +-
 include/drm/drm_modeset_helper_vtables.h           |    2 +-
 include/drm/drm_modeset_lock.h                     |    2 +-
 include/drm/drm_probe_helper.h                     |   27 +
 include/drm/drm_rect.h                             |    6 -
 include/drm/drm_syncobj.h                          |   23 +-
 include/drm/drm_util.h                             |   53 +-
 include/drm/drm_vblank.h                           |   22 +
 include/drm/gpu_scheduler.h                        |   13 +-
 include/drm/i915_pciids.h                          |    8 +
 include/drm/intel-gtt.h                            |    3 +
 include/drm/tinydrm/mipi-dbi.h                     |    5 +-
 include/drm/tinydrm/tinydrm-helpers.h              |   20 +-
 include/drm/tinydrm/tinydrm.h                      |   26 -
 include/drm/ttm/ttm_bo_api.h                       |   28 -
 include/drm/ttm/ttm_bo_driver.h                    |   11 +-
 include/linux/dma-fence-array.h                    |    1 +
 include/linux/dma-fence.h                          |   22 +-
 include/linux/hdmi.h                               |   15 +
 include/linux/mfd/intel_soc_pmic.h                 |    3 +
 include/trace/events/host1x.h                      |   26 +
 include/uapi/drm/amdgpu_drm.h                      |    9 +-
 include/uapi/drm/drm_fourcc.h                      |   63 +
 include/uapi/drm/i915_drm.h                        |   64 +
 include/uapi/drm/nouveau_drm.h                     |   51 +
 include/uapi/drm/v3d_drm.h                         |    8 +
 include/video/imx-ipu-v3.h                         |    1 +
 1141 files changed, 39562 insertions(+), 37911 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,komeda.tx=
t
 create mode 100644
Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
 rename Documentation/devicetree/bindings/display/panel/{auo,g101evn010
=3D> auo,g101evn010.txt} (100%)
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/gpu/afbc.rst
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-1.dot
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-2.dot
 create mode 100644 Documentation/gpu/dp-mst/topology-figure-3.dot
 create mode 100644 Documentation/gpu/komeda-kms.rst
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/ci_dpm.c
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/ci_dpm.h
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/ci_smc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/aux_engine.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce100/i2caux_dce=
100.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_sw_engine_dce110.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2caux_dce=
110.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2caux_dce=
110.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce=
112.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce=
112.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce120/i2caux_dce=
120.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_hw_engine_dce80.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_hw_engine_dce80.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2caux_dce8=
0.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dcn10/i2caux_dcn1=
0.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dcn10/i2caux_dcn1=
0.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/diagnostics/i2caux_diag.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/diagnostics/i2caux_diag.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/engine.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_engine.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_engine.h
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/i2c_generic_hw_engine.c
 delete mode 100644
drivers/gpu/drm/amd/display/dc/i2caux/i2c_generic_hw_engine.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_hw_engine.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_hw_engine.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_sw_engine.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2c_sw_engine.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.h
 rename drivers/gpu/drm/amd/display/dc/{i2caux/engine_base.c =3D>
inc/hw/vmid.h} (63%)
 rename drivers/gpu/drm/amd/display/dc/{i2caux/dce110/i2c_sw_engine_dce110.=
h
=3D> inc/vm_helper.h} (64%)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_sm=
n.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.c
 rename drivers/gpu/drm/amd/{display/dc/i2caux/dce80/i2c_sw_engine_dce80.h
=3D> powerplay/hwmgr/common_baco.h} (65%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c
 rename drivers/gpu/drm/amd/{display/dc/i2caux/dce80/i2caux_dce80.h =3D>
powerplay/hwmgr/vega10_baco.h} (74%)
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c
 rename drivers/gpu/drm/amd/{display/dc/i2caux/dce100/i2caux_dce100.h
=3D> powerplay/hwmgr/vega20_baco.h} (73%)
 create mode 100644 drivers/gpu/drm/arm/display/Kbuild
 create mode 100644 drivers/gpu/drm/arm/display/Kconfig
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_io.h
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_product.h
 create mode 100644 drivers/gpu/drm/arm/display/include/malidp_utils.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/Makefile
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_drv.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_plane.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
 delete mode 100644 drivers/gpu/drm/bochs/bochs_fbdev.c
 create mode 100644 drivers/gpu/drm/i915/i915_active.c
 create mode 100644 drivers/gpu/drm/i915/i915_active.h
 create mode 100644 drivers/gpu/drm/i915/i915_active_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_reset.c
 create mode 100644 drivers/gpu/drm/i915/i915_reset.h
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_active.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_live_test.c
 create mode 100644 drivers/gpu/drm/i915/selftests/igt_live_test.h
 delete mode 100644 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c
 create mode 100644 drivers/gpu/drm/nouveau/include/nvif/clb069.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_dmem.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_dmem.h
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_svm.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_svm.h
 rename drivers/gpu/drm/nouveau/nvkm/engine/ce/{tu104.c =3D> tu102.c} (91%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/disp/{roottu104.c =3D>
roottu102.c} (74%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/disp/{sortu104.c =3D>
sortu102.c} (90%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/disp/{tu104.c =3D> tu102.c} (93=
%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/fifo/{gpfifotu104.c =3D>
gpfifotu102.c} (91%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/fifo/{tu104.c =3D> tu102.c} (82=
%)
 rename drivers/gpu/drm/nouveau/nvkm/engine/fifo/{usertu104.c =3D>
usertu102.c} (86%)
 rename drivers/gpu/drm/{amd/display/dc/i2caux/dce120/i2caux_dce120.h
=3D> nouveau/nvkm/engine/sec2/tu102.c} (77%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/bar/{tu104.c =3D> tu102.c} (84%=
)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/devinit/{tu104.c =3D> tu102.c} =
(87%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/fault/{tu104.c =3D> tu102.c} (8=
2%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fault/user.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/Kbuild
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c
 rename drivers/gpu/drm/nouveau/nvkm/subdev/mc/{tu104.c =3D> tu102.c} (88%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/mmu/{tu104.c =3D> tu102.c} (88%=
)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/mmu/{vmmtu104.c =3D> vmmtu102.c=
} (89%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c
 create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
 create mode 100644 drivers/gpu/drm/panel/panel-sitronix-st7701.c
 create mode 100644 drivers/gpu/drm/panel/panel-tpo-tpg110.c
 delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_lvds.h
 create mode 100644 drivers/gpu/drm/tegra/hda.c
 create mode 100644 drivers/gpu/drm/tegra/hda.h
 delete mode 100644 drivers/gpu/drm/virtio/virtgpu_drm_bus.c
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x06_channel.h
 create mode 100644 drivers/gpu/host1x/hw/hw_host1x07_channel.h
 rename drivers/{gpu/drm/sun4i/sun6i_mipi_dphy.c =3D>
phy/allwinner/phy-sun6i-mipi-dphy.c} (70%)
 create mode 100644 include/drm/drm_probe_helper.h
