Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339E92158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYbF+dUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfK1A7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:59:48 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45392 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK1A7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:59:47 -0500
Received: by mail-lj1-f177.google.com with SMTP id n21so26480609ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8D0X0K7Oo82joGiYicsPHRdDYeXKTH+r/SW8RZ8RAvY=;
        b=pYbF+dUwR6WhQKNMEfMWd63Z0CLh6ClM42ATP4QmW5YizFeOKK0WyQ2sfYPl/6DWSS
         Ob/P0vBXv+5ZNndysmKaWIgg9X1BwDWvTFuwvnarvzRaeKRnOITxmKX1UW306szZd62z
         R6+RosRSAvfVeA0qitt/Ex5MdUwm96QfZYbcI0oUskFkU3Wj8Ls1Z7YGUZcmpETkh+W/
         IcOJgS/ZxB/6n47a6vjjBooEIjvTHaeeEs3jdl/A+NAcg/fcK4GUG+idfw2NLJuDyWsN
         JH0kA7ENIEjZFX3WUrkiPsfDxnnpsOSp3Auek7INHZw0dXRVwWz/vjUdV5JDtyMxW0OG
         ugGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=8D0X0K7Oo82joGiYicsPHRdDYeXKTH+r/SW8RZ8RAvY=;
        b=BVra2WScawa96YELN3aqGlhIrnLIpTpQvOvtLhsMretrxM2DstxBMgD8VkqRt4uDs3
         0S4NAXLbLhTNvIfJpzf25/yWwNO6fwDhq4wTJ6r8AHdNjXkUm7jbrB8CCOvb4IH9H9TD
         pMY/12tQ+vc039gy+KAY5+i8zwqCgibvzw9kmH9A/cDiAFeBBwjwu6fCC0dojnNnbdUn
         orcm1X/SbYtc9IfUMvRL1UhdcF/VJ9Wug/ILL00hBdt06etuL6/UFGjvFFMc9Z3rpxN4
         ASZESLY0PZAVX+aktPAobKn/MrcWBvIfYVBoUI+/yeBziWy4MFyUwecFNpP7jbMuBobK
         xz2w==
X-Gm-Message-State: APjAAAVjx0zwZHh40j/PGDCiMtOikNQF2X2NP9smrJEU1wg6fWSTrzwZ
        UDdixNUH8lOXssxk1vpAPas/DzkquHiTDjB7Tp4=
X-Google-Smtp-Source: APXvYqzAzSOVonMNInDK/uAWwcfFVU0mGHAHYE2ltwts9/LdX2H/PheybIY0kpvTpidllQNTd80FgC6z9zG3bXHkTjs=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr33328461ljq.20.1574902770674;
 Wed, 27 Nov 2019 16:59:30 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 28 Nov 2019 10:59:16 +1000
Message-ID: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
Subject: [git pull] drm for 5.5-rc1
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

Hope you get this prior to turkey day, this is the main drm pull
request for 5.5-rc1.

I've got a second one from Thomas Hellstrom that has some mm stuff
you've discussed before I'll send along once this lands.

The diffstat is a bit wierd, but that's what the pull request
generator generated, let me know if it doesn't make sense when you
pull it.

There are some conflicts with your tree, and one silent build failure
which needs this patch from sfr applied:

https://lore.kernel.org/lkml/20191106135340.3fa45898@canb.auug.org.au/raw

my sample merge is here:
https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-5.5-merged

Otherwise lots of stuff in here, though it hasn't been too insane this
merge apart from dealing with the security fun.

Dave.

uapi:
- export different colorspace properties on DP vs HDMI
- new fourcc for ARM 16x16 block format
- syncobj: allow querying last submitted timeline value
- DRM_FORMAT_BIG_ENDIAN defined as unsigned

core:
- allow using gem vma manager in ttm
- connector/encoder/bridge doc fixes
- allow more than 3 encoders for a connector
- displayport mst suspend/resume reprobing support
- vram lazy unmapping, uniform vram mm and gem vram
- edid cleanups + AVI informframe bar info
- displayport helpers - dpcd parser added

dp_cec:
- Allow a connector to be associated with a cec device

ttm:
- pipelining with no_gpu_wait fix
- always keep BOs on the LRU

sched:
- allow free_job routine to sleep

i915:
- Block userptr from mappable GTT
- i915 perf uapi versioning
- OA stream dynamic reconfiguration
- make context persistence optional
- introduce DRM_I915_UNSTABLE Kconfig
- add fake lmem testing under unstable
- BT.2020 support for DP MSA
- struct mutex elimination
- Tigerlake display/PLL/power management improvements
- Jasper Lake PCH support
- refactor PMU for multiple GPUs
- Icelake firmware update
- Split out vga + switcheroo code

amdgpu:
- implement dma-buf import/export without helpers
- vega20 RAS enablement
- DC i2c over aux fixes
- renoir GPU reset
- DC HDCP support
- BACO support for CI/VI asics
- MSI-X support
- Arcturus EEPROM support
- Arcturus VCN encode support
- VCN dynamic powergating on RV/RV2

amdkfd:
- add navi12/14/renoir support to kfd

radeon:
- SI dpm fix ported from amdgpu
- fix bad DMA on ppc platforms

gma500:
- memory leak fixes

qxl:
- convert to new gem mmap

exynos:
- build warning fix

komeda:
- add aclk sysfs attribute

v3d:
- userspace cleanup uapi change

i810:
- fix for underflow in dispatch ioctls

ast:
- refactor show_cursor

mgag200:
- refactor show_cursor

arcgpu:
- encoder finding improvements

mediatek:
- mipi_tx, dsi and partial crtc support for MT8183 SoC
- rotation support

meson:
- add suspend/resume support

omap:
- misc refactors

tegra:
- DisplayPort support for Tegra 210, 186 and 194.
- IOMMU-backed DMA API fixes

panfrost:
- fix lockdep issue
- simplify devfreq integration

rcar-du:
- R8A774B1 SoC support
- fixes for H2 ES2.0

sun4i:
- vcc-dsi regulator support

virtio-gpu:
- vmexit vs spinlock fix
- move to gem shmem helpers
- handle large command buffers with cma

drm-next-2019-11-27:
drm main pull for 5.5-rc1
The following changes since commit ea0b163b13ffc52818c079adb00d55e227a6da6f=
:

  drm/i915/cmdparser: Fix jump whitelist clearing (2019-11-11 08:13:49 -080=
0)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-11-27

for you to fetch changes up to acc61b8929365e63a3e8c8c8913177795aa45594:

  Merge tag 'drm-next-5.5-2019-11-22' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2019-11-26
08:40:23 +1000)

----------------------------------------------------------------
drm main pull for 5.5-rc1

----------------------------------------------------------------
Aaron Liu (4):
      drm/amd/display: update renoir_ip_offset.h
      drm/amdgpu: disable stutter mode for renoir
      drm/amdgpu: remove program of lbpw for renoir
      Revert "drm/amdgpu: disable stutter mode for renoir"

Abdiel Janulgue (3):
      drm/i915: enumerate and init each supported region
      drm/i915: setup io-mapping for LMEM
      drm/i915/lmem: support kernel mapping

Adam Jackson (1):
      drm/fourcc: Fix undefined left shift in DRM_FORMAT_BIG_ENDIAN macros

Adam Zerella (1):
      docs: drm/amdgpu: Resolve build warnings

Ahzo (1):
      drm/amd/display: add NULL checks for clock manager pointer

Aidan Yang (2):
      drm/amd/display: Don't use optimized gamma22 with eetf
      drm/amd/display: Allow inverted gamma

Alejandro Hernandez (1):
      drm/omap: tweak HDMI DDC timings

Alex Deucher (69):
      drm/amdgpu/irq: check if nbio funcs exist
      drm/amdgpu/vm: fix documentation for amdgpu_vm_bo_param
      drm/amdgpu/ras: use GPU PAGE_SIZE/SHIFT for reserving pages
      drm/amdgpu/psp: flush HDP write fifo after submitting cmds to the psp
      drm/amdgpu/psp: invalidate the hdp read cache before reading the
psp response
      drm/amdgpu: flag navi12 and 14 as experimental for 5.4
      drm/amdgpu: fix documentation for amdgpu_gem_prime_export
      drm/amdgpu/mn: fix documentation for amdgpu_mn_read_lock
      drm/amdgpu/vm: fix up documentation in amdgpu_vm.c
      drm/amdgpu/ih: fix documentation in amdgpu_irq_dispatch
      drm/amdgpu: fix documentation for amdgpu_pm.c
      drm/amdgpu/ras: fix and update the documentation for RAS
      drm/amdgpu/display: fix 64 bit divide
      drm/amdgpu/display: include slab.h in dcn21_resource.c
      drm/amdgpu/atomfirmware: use proper index for querying vram type (v3)
      drm/amdgpu/atomfirmware: simplify the interface to get vram info
      drm/amdgpu: don't increment vram lost if we are in hibernation
      drm/amdgpu: improve MSI-X handling (v3)
      drm/amdgpu: move amdgpu_device_get_job_timeout_settings
      drm/amdkfd: fix the build when CIK support is disabled
      drm/amdgpu/ras: fix typos in documentation
      drm/amdgpu/ras: document the reboot ras option
      drm/amdgpu/powerplay: fix typo in mvdd table setup
      drm/amdgpu/swSMU/navi: add feature toggles for more things
      drm/amdgpu/display: clean up dcn2*_pp_smu functions
      Revert "drm/radeon: Fix EEH during kexec"
      drm/amdgpu: move pci_save_state into suspend path
      drm/amdgpu: move gpu reset out of amdgpu_device_suspend
      drm/amdgpu: simplify ATPX detection
      drm/amdgpu: remove in_baco_reset hack
      drm/amdgpu/soc15: add support for baco reset with swSMU
      drm/amdgpu: add new BIF 4.1 register for BACO
      drm/amdgpu: add new BIF 5.0 register for BACO
      drm/amdgpu: add new SMU 7.0.1 registers for BACO
      drm/amdgpu: add new SMU 7.1.2 registers for BACO
      drm/amdgpu: add new SMU 7.1.3 registers for BACO
      drm/amdgpu/powerplay: add core support for pre-SOC15 baco
      drm/amdgpu/powerplay: add support for BACO on tonga
      drm/amdgpu/powerplay: add support for BACO on Iceland
      drm/amdgpu/powerplay: add support for BACO on polaris
      drm/amdgpu/powerplay: add support for BACO on VegaM
      drm/amdgpu/powerplay: add support for BACO on Fiji
      drm/amdgpu/powerplay: add support for BACO on CI
      drm/amdgpu/powerplay: split out common smu7 BACO code
      drm/amdgpu/powerplay: wire up BACO to powerplay API for smu7
      drm/amdgpu: enable BACO reset for SMU7 based dGPUs (v2)
      drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DSC_SUPPORT=3Dn
      drm/amdgpu/uvd6: fix allocation size in enc ring test (v2)
      drm/amdgpu/uvd7: fix allocation size in enc ring test (v2)
      drm/amdgpu/vcn: fix allocation size in enc ring test
      drm/amdgpu/vce: fix allocation size in enc ring test
      drm/amdgpu/vce: make some functions static
      drm/amdgpu/powerplay: use local renoir array sizes for clock fetching
      drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE
      drm/amdgpu/arcturus: properly set BANK_SELECT and FRAGMENT_SIZE
      drm/amdgpu: enable VCN DPG on Raven and Raven2
      drm/amdgpu/gpuvm: add some additional comments in amdgpu_vm_update_pt=
es
      drm/amdgpu/renoir: move gfxoff handling into gfx9 module
      drm/radeon: fix si_enable_smc_cac() failed issue
      drm/amdgpu: Improve RAS documentation (v2)
      drm/amdgpu/powerplay: fix AVFS handling with custom powerplay table
      drm/amdgpu/powerplay/smu7: fix AVFS handling with custom powerplay ta=
ble
      drm/amdgpu/vcn: finish delay work before release resources
      drm/amdgpu/nv: add asic func for fetching vbios from rom directly
      drm/amdgpu/powerplay: properly set PP_GFXOFF_MASK (v2)
      drm/amdgpu: disable gfxoff when using register read interface
      drm/amdgpu: remove experimental flag for Navi14
      drm/amdgpu: disable gfxoff on original raven
      Revert "drm/amd/display: enable S/G for RAVEN chip"

Alex Sierra (1):
      drm/amdkfd: bug fix for out of bounds mem on gpu cache filling info

Allen Pais (1):
      drm/amdkfd: fix a potential NULL pointer dereference (v2)

Alvin Lee (2):
      drm/amd/display: Don't allocate payloads if link lost
      drm/amd/display: Update min dcfclk

Alyssa Rosenzweig (1):
      drm/panfrost: Add errata descriptions from kbase

Andi Shyti (5):
      drm/i915: Hook up GT power management
      drm/i915: Extract GT render sleep (rc6) management
      drm/i915: Extract GT ring management
      drm/i915: Extract GT render power state management
      drm/i915: Extract the GuC interrupt handlers

Andrew F. Davis (1):
      dma-buf: Add dma-buf heaps framework

Andrey Grodzovsky (23):
      drm/amdgpu: Fix bugs in amdgpu_device_gpu_recover in XGMI case.
      drm/amdgpu: Avoid HW GPU reset for RAS.
      dmr/amdgpu: Add system auto reboot to RAS.
      drm/amdgpu: Add smu lock around in pp_smu_i2c_bus_access
      drm/amdgpu: Remove clock gating restore.
      drm/madgpu: Fix EEPROM Checksum calculation.
      drm/amdgpu: Avoid RAS recovery init when no RAS support.
      drm/amdgpu: Add amdgpu_ras_eeprom_reset_table
      drm/amdgpu: Allow to reset to EERPOM table.
      drm/amdgpu: Fix mutex lock from atomic context.
      drm/amdgpu:Fix EEPROM checksum calculation.
      dmr/amdgpu: Fix crash on SRIOV for ERREVENT_ATHUB_INTERRUPT interrupt=
.
      drm/amd/powerplay: Add interface for I2C transactions to SMU.
      drm/amd/powerplay: Add EEPROM I2C read/write support to Arcturus.
      drm/amdgpu: Use ARCTURUS in RAS EEPROM.
      drm/amdgpu: Move amdgpu_ras_recovery_init to after SMU ready.
      drm/sched: Set error to s_fence if HW job submission failed.
      drm/amdgpu: If amdgpu_ib_schedule fails return back the error.
      drm/sched:  Fix passing zero to 'PTR_ERR' warning v2
      drm/sched: Use completion to wait for sched->thread idle v2.
      Revert "drm/amdgpu: dont schedule jobs while in reset"
      drm/sched: Avoid job cleanup if sched thread is parked.
      drm/amdgpu: Avoid accidental thread reactivation.

Andy Shevchenko (1):
      drm/mipi_dbi: Use simple right shift instead of double negation

Animesh Manna (9):
      drm/i915/dsb: feature flag added for display state buffer.
      drm/i915/dsb: DSB context creation.
      drm/i915/dsb: Indexed register write function for DSB.
      drm/i915/dsb: Check DSB engine status.
      drm/i915/dsb: functions to enable/disable DSB engine.
      drm/i915/dsb: function to trigger workload execution of DSB.
      drm/i915/dsb: Enable gamma lut programming using DSB.
      drm/i915/dsb: Enable DSB for gen12.
      drm/i915/dsb: Documentation for DSB.

Ankit Nautiyal (1):
      drm/i915: Add Pipe D cursor ctrl register for Gen12

Anna Karas (6):
      drm/i915/perf: Fix use of kernel-doc format in structure members
      drm/i915/perf: Describe structure members in documentation
      doc: Update header files names
      drm/i915: Describe structure member in documentation
      drm/i915/tgl: Fix doc not corresponding to code
      doc: drm: Update references to previously renamed files

Anshuman Gupta (6):
      drm/i915/tgl: Add DC3CO required register and bits
      drm/i915/tgl: Add DC3CO mask to allowed_dc_mask and gen9_dc_mask
      drm/i915/tgl: Enable DC3CO state in "DC Off" power well
      drm/i915/tgl: Do modeset to enable and configure DC3CO exitline
      drm/i915/tgl: Switch between dc3co and dc5 based on display idleness
      drm/i915/tgl: Add DC3CO counter in i915_dmc_info

Anthony Koo (5):
      drm/amd/display: 3.2.49
      drm/amd/display: set minimum abm backlight level
      drm/amd/display: 3.2.52
      drm/amd/display: correctly populate dpp refclk in fpga
      drm/amd/display: Proper return of result when aux engine acquire fail=
s

Anusha Srivatsa (3):
      drm/dp/dsc: Add Support for all BPCs supported by TGL
      drm/i915/uc: Update HuC firmware naming convention and load latest Hu=
C
      drm/i915/dmc: Update ICL DMC version to v1.09

Ap Kamal (1):
      drm/i915: Making loglevel of PSR2/SU logs same.

Aric Cyr (10):
      drm/amd/display: 3.2.50
      drm/amd/display: 3.2.51
      drm/amd/display: 3.2.51.1
      drm/amd/display: Improve LFC behaviour
      drm/amd/display: Update V_UPDATE whenever VSTARTUP changes
      drm/amd/display: Properly round nominal frequency for SPD
      drm/amd/display: 3.2.53
      drm/amd/display: 3.2.54
      drm/amd/display: 3.2.55
      drm/amd/display: 3.2.56

Arkadiusz Hiler (1):
      drm/i915: Get the correct wakeref for reading HOTPLUG_EN et al.

Arnd Bergmann (5):
      fbdev/sa1100fb: Remove even more dead code
      drm/amd/display: hide an unused variable
      drm/amdgpu: make pmu support optional, again
      drm/amdgpu: hide another #warning
      drm/amdgpu: display_mode_vba_21: remove uint typedef

Austin Kim (1):
      drm/amdgpu: Drop unused variable and statement

Bayan Zabihiyan (1):
      drm/amd/display: Isolate DSC module from driver dependencies

Ben Dooks (3):
      drm/scheduler: make unexported items static
      drm/rockchip: include rockchip_drm_drv.h
      drm/rockchip: make rockchip_gem_alloc_object static

Ben Dooks (Codethink) (2):
      drm/arm: make undeclared items static
      gpu: host1x: Make host1x_cdma_wait_pushbuffer_space() static

Benjamin Gaignard (2):
      drm: sti: fix W=3D1 warnings
      drm: fix warnings in DSC

Bhanusree (3):
      drm/gpu: Add comment for memory barrier
      drm/gpu: Fix Missing blank line after declarations
      drm/gpu: Fix Memory barrier without comment Issue

Bhawanpreet Lakha (29):
      drm/amd/display: add Asic ID for Dali
      drm/amd/display: Implement voltage limitation for dali
      drm/amdgpu: psp HDCP init
      drm/amdgpu: psp DTM init
      drm/amd/display: Add HDCP module
      drm/amd/display: add PSP block to verify hdcp steps
      drm/amd/display: Update hdcp display config
      drm/amd/display: Create amdgpu_dm_hdcp
      drm/amd/display: Create dpcd and i2c packing functions
      drm/amd/display: Initialize HDCP work queue
      drm/amd/display: Handle Content protection property changes
      drm/amd/display: handle DP cpirq
      drm/amd/display: Update CP property based on HW query
      drm/amd/display: only enable HDCP for DCN+
      drm/amd/display: Add hdcp to Kconfig
      drm/amd/display: Add DP_DPHY_INTERNAL_CTR regs
      drm/amd/display: Add DCN_BASE regs
      drm/amd/display: Add renoir hw_seq
      drm/amd/display: create dcn21_link_encoder files
      drm/amd/display: add REFCYC_PER_TRIP_TO_MEMORY programming
      drm/amd/display: fix incorrect page table address for renoir
      drm/amd/display: add detile buffer size for renoir
      drm/amd/display: update dcn21 hubbub registers
      drm/amd/display: update renoir bounding box and res_caps
      drm/amd/display: change PP_SM defs to 8
      drm/amd/display: handle "18" case in TruncToValidBPP
      drm/amd/display: use requested_dispclk_khz instead of clk
      drm/amd/display: handle dp is usb-c
      drm/amd/display: null check pp_smu clock table before using it

Biju Das (5):
      dt-bindings: display: renesas: du: Document the r8a774b1 bindings
      drm: rcar-du: Add R8A774B1 support
      dt-bindings: display: renesas: lvds: Document r8a774b1 bindings
      drm: rcar-du: lvds: Add r8a774b1 support
      dt-bindings: display: renesas: Add r8a774b1 support

Boris Brezillon (2):
      drm: Stop including drm_bridge.h from drm_crtc.h
      drm/msm: Use drm_attach_bridge() to attach a bridge to an encoder

Brian Masney (5):
      dt-bindings: drm/bridge: analogix-anx78xx: add new variants
      drm/bridge: analogix-anx78xx: add new variants
      drm/bridge: analogix-anx78xx: silence -EPROBE_DEFER warnings
      drm/bridge: analogix-anx78xx: convert to i2c_new_dummy_device
      drm/bridge: analogix-anx78xx: add support for 7808 addresses

Bruce Chang (1):
      drm/i915: Avoid atomic context for error capture

CK Hu (1):
      drm/mediatek: add no_clk into ddp private data

CQ Tang (1):
      drm/i915/stolen: make the object creation interface consistent

Charlene Liu (2):
      drm/amd/display: dce11.x /dce12 update formula input
      drm/amd/display: use vbios message to call smu for dpm level

Cheng-Yi Chiang (1):
      drm: dw-hdmi-i2s: enable audio clock in audio_startup

Chenwandun (2):
      drm/amd/display: remove gcc warning Wunused-but-set-variable
      drm/dp_mst: fix gcc compile error

Chris Wilson (237):
      drm/i915: Hold irq-off for the entire fake lock period
      drm/i915/gtt: Preallocate Braswell top-level page directory
      drm/i915: Flush the existing fence before GGTT read/write
      drm/i915: Keep drm_i915_file_private around under RCU
      drm/i915/selftests: Teach igt_gpu_fill_dw() to take intel_context
      drm/i915/selftests: Add the usual batch vma managements to st_workaro=
unds
      drm/i915: Use NOEVICT for first pass on attemping to pin a GGTT mmap
      drm/i915/selftests: Markup impossible error pointers
      drm/i915: Only activate i915_active debugobject once
      drm/i915: Make engine's batch pool safe for use with virtual engines
      drm/i915/selftests: Remove accidental serialization between gpu_fill
      drm/i915/selftests: Try to recycle context allocations
      drm/i915/execlists: Flush the post-sync breadcrumb write harder
      drm/i915/selftests: Ignore coherency failures on Broadwater
      drm/i915: Protect our local workers against I915_FENCE_TIMEOUT
      drm/i915/selftests: cond_resched() within the longer buddy tests
      drm/i915/execlists: Try rearranging breadcrumb flush
      drm/i915/gtt: Downgrade gen7 (ivb, byt, hsw) back to aliasing-ppgtt
      drm/i915/gtt: Downgrade Cherryview back to aliasing-ppgtt
      drm/i915: Remove ppgtt->dirty_engines
      drm/i915: Use RCU for unlocked vm_idr lookup
      drm/i915/perf: Assert locking for i915_init_oa_perf_state()
      drm/i915: Restrict the aliasing-ppgtt to the size of the ggtt
      drm/i915: Report aliasing ppgtt size as ggtt size
      drm/i915: Replace obj->pin_global with obj->frontbuffer
      drm/i915/selftests: Remove unused __engines_name()
      drm/i915: Refresh the errno to vmf_fault translations
      drm/i915: Restore relaxed padding (OCL_OOB_SUPPRES_ENABLE) for skl+
      drm/i915: Protect debugfs per_file_stats with RCU lock
      drm/i915/execlists: Remove incorrect BUG_ON for schedule-out
      drm/i915/execlists: Clear STOP_RING bit on reset
      drm/i915/execlists: Ignore lost completion events
      drm/i915/ringbuffer: Flush writes before RING_TAIL update
      drm/i915: Perform GGTT restore much earlier during resume
      drm/i915/selftests: Take runtime wakeref for igt_ggtt_lowlevel
      drm/i915/selftests: Tighten the timeout testing for partial mmaps
      drm/i915/tgl: Disable rc6 for debugging
      drm/i915: Make shrink/unshrink be atomic
      drm/i915: Make i915_vma.flags atomic_t for mutex reduction
      drm/i915/display: Add glk_cdclk_table
      drm/i915/tgl: Disable read-only ppgtt support
      drm/i915: Squeeze iommu status into debugfs/i915_capabilities
      drm/i915: Disable FBC if BIOS reserved memory (stolen) is unavailable
      drm/i915/execlists: Add a paranoid flush of the CSB pointers upon res=
et
      drm/i915/execlists: Ensure the context is reloaded after a GPU reset
      drm/i915/pmu: Use GT parked for estimating RC6 while asleep
      drm/i915/tgl: Disable preemption while being debugged
      drm/i915/selftests: Keep the engine awake while we keep for preemptio=
n
      drm/i915/gtt: Make sure the gen6 ppgtt is bound before first use
      drm/i915: Don't mix srcu tag and negative error codes
      drm/i915/tgl: Limit ourselves to just rcs0
      drm/i915: Show the logical context ring state on dumping
      drm/i915: Only apply a rmw mmio update if the value changes
      drm/i915/tgl: Extend MI_SEMAPHORE_WAIT
      drm/i915: Extend Haswell GT1 PSMI workaround to all
      drm/i915: Verify the engine after acquiring the active.lock
      drm/i915/selftests: Exercise CS TLB invalidation
      drm/i915/tgl: Suspend pre-parser across GTT invalidations
      drm/i915: Mark i915_request.timeline as a volatile, rcu pointer
      drm/i915: Lock signaler timeline while navigating
      drm/i915: Protect timeline->hwsp dereferencing
      Revert "drm/i915/tgl: Implement Wa_1406941453"
      drm/i915/execlists: Relax assertion for a pinned context image on res=
et
      drm/i915/execlists: Drop redundant list_del_init(&rq->sched.link)
      drm/i915: Only enqueue already completed requests
      drm/i915/execlists: Refactor -EIO markup of hung requests
      drm/i915: Fixup preempt-to-busy vs resubmission of a virtual request
      drm/i915: Fixup preempt-to-busy vs reset of a virtual request
      drm/i915: Prevent bonded requests from overtaking each other on preem=
ption
      drm/i915: Mark contents as dirty on a write fault
      drm/i915/selftests: Verify the LRC register layout between init and H=
W
      drm/i915/tgl: Swap engines for no rps (gpu reclocking)
      drm/i915/execlists: Simplify gen12_csb_parse
      drm/i915/selftests: Exercise concurrent submission to all engines
      drm/i915/selftests: Do not try to sanitize mock HW
      drm/i915: Pass intel_gt to has-reset?
      drm/i915/selftests: Distinguish mock device from no wakeref
      drm/i915/selftests: Provide a mock GPU reset routine
      drm/i915/selftests: Exercise context switching in parallel
      drm/i915/gt: Only unwedge if we can reset first
      drm/i915: Initialise breadcrumb lists on the virtual engine
      drm/i915/userptr: Never allow userptr into the mappable GGTT
      drm/i915/selftests: Extract random_offset() for use with a prng
      drm/i915/gem: Refactor tests on obj->ops->flags
      drm/i915/selftests: Exercise potential false lite-restore
      dma-fence: Serialise signal enabling (dma_fence_enable_sw_signaling)
      drm/i915/execlists: Skip redundant resubmission
      drm/mm: Use helpers for drm_mm_node booleans
      drm/mm: Convert drm_mm_node booleans to bitops
      drm/mm: Use clear_bit_unlock() for releasing the drm_mm_node()
      drm/i915: Restrict L3 remapping sysfs interface to dwords
      drm/i915: Use helpers for drm_mm_node booleans
      drm/i915: Only track bound elements of the GTT
      drm/i915: Mark up address spaces that may need to allocate
      drm/i915: Pull i915_vma_pin under the vm->mutex
      drm/i915: Push the i915_active.retire into a worker
      drm/i915: Coordinate i915_active with its own mutex
      drm/i915: Move idle barrier cleanup into engine-pm
      drm/i915: Drop struct_mutex from around i915_retire_requests()
      drm/i915: Remove the GEM idle worker
      drm/i915: Merge wait_for_timelines with retire_request
      drm/i915/gem: Retire directly for mmap-offset shrinking
      drm/i915: Move request runtime management onto gt
      drm/i915: Move global activity tracking from GEM to GT
      drm/i915: Remove logical HW ID
      drm/i915: Move context management under GEM
      drm/i915/overlay: Drop struct_mutex guard
      drm/i915: Drop struct_mutex guard from debugfs/framebuffer_info
      drm/i915: Remove struct_mutex guard for debugfs/opregion
      drm/i915: Drop struct_mutex from suspend state save/restore
      drm/i915/selftests: Drop vestigal struct_mutex guards
      drm/i915: Drop struct_mutex from around GEM initialisation
      drm/i915/gt: Restore dropped 'interruptible' flag
      drm/i915/gt: Prefer local path to runtime powermanagement
      drm/i915/execlists: Fix annotation for decoupling virtual request
      drm/i915/selftests: Appease lockdep
      drm/i915/gt: Treat a busy timeline as 'active' while waiting
      drm/i915/perf: Wean ourselves off dev_priv
      drm/i915/perf: Set the exclusive stream under perf->lock
      drm/i915/execlists: Assign virtual_engine->uncore from first sibling
      drm/i915/selftests: Assign the mock_engine->uncore shortcut
      drm/i915/selftests: Assign the intel_runtime_pm pointer for mock_unco=
re
      drm/i915/gt: Flush submission tasklet before waiting/retiring
      drm/i915/gt: Give engine->kernel_context distinct timeline lock class=
es
      drm/i915/selftests: Hold request reference over waits
      drm/i915/execlists: Protect peeking at execlists->active
      drm/i915/gt: execlists->active is serialised by the tasklet
      drm/i915/gt: Warn CI about an unrecoverable wedge
      drm/i915/execlists: Mark up expected state during reset
      drm/i915/selftests: Check that registers are preserved between
virtual engines
      drm/i915/perf: Store shortcut to intel_uncore
      drm/i915: Note the addition of timeslicing to the pretend scheduler
      drm/i915/execlists: Leave tell-tales as to why pending[] is bad
      drm/i915/execlists: Only mark incomplete requests as -EIO on cancelli=
ng
      drm/i915: Add an rcu_barrier option to i915_drop_caches
      drm/i915/selftests: Serialise write to scratch with its vma binding
      drm/i915/perf: Replace global wakeref tracking with engine-pm
      drm/i915/execlists: Prevent merging requests with conflicting flags
      drm/i915: Mark up "sentinel" requests
      drm/i915/perf: Prefer using the pinned_ctx for emitting delays on con=
fig
      drm/i915/perf: Avoid polluting the i915_oa_config with error pointers
      drm/i915/selftests: Fixup naked 64b divide
      drm/i915/display: Squelch kerneldoc warnings
      drm/i915/selftests: Check known register values within the context
      drm/i915/selftests: Check that GPR are cleared for new contexts
      drm/i915/execlists: Tweak virtual unsubmission
      drm/i915/execlists: Assert tasklet is locked for process_csb()
      drm/i915/perf: Allow dynamic reconfiguration of the OA stream
      drm/i915: Drop obj.page_pin_count after a failed vma->set_pages()
      drm/i915: Remove leftover vma->obj->pages_pin_count on insert/remove
      drm/i915/execlists: Clear semaphore immediately upon ELSP promotion
      drm/i915: Flush tasklet submission before sleeping on i915_request_wa=
it
      drm/i915/selftests: Drop stale struct_mutex
      drm/i915/execlist: Trim immediate timeslice expiry
      drm/i915/selftests: Teach execlists to take intel_gt as its argument
      drm/i915/selftests: Teach guc to take intel_gt as its argument
      drm/i915/selftests: Teach workarounds to take intel_gt as its argumen=
t
      drm/i915/selftests: Teach timelines to take intel_gt as its argument
      drm/i915: Do initial mocs configuration directly
      drm/i915: Store i915_ggtt as the backpointer on fence registers
      drm/i915: Move swizzle_bit under i915_ggtt
      drm/i915/selftests: Teach requests to use all available engines
      drm/i915/execlists: Don't merely skip submission if maybe timeslicing
      drm/i915/selftests: Add the mock engine to the gt->engine[]
      drm/i915/gt: Convert the leftover for_each_engine(gt)
      drm/i915/gvt: Wean off struct_mutex
      drm/i915: Don't set queue_priority_hint if we don't kick the submissi=
on
      drm/i915/selftests: Use all physical engines for i915_active
      drm/i915/gt: Introduce barrier pulses along engines
      drm/i915: Lift i915_vma_parked() onto the gt
      drm/i915: Remove pm park/unpark notifications
      drm/i915/selftests: Set vm->gt backpointer for mock_ppgtt
      drm/i915/selftests: Make the mman object busy everywhere
      drm/i915: Drop assertion that ce->pin_mutex guards state updates
      drm/i915/gem: Distinguish each object type
      drm/i915: Teach record_defaults to operate on the intel_gt
      drm/i915/selftests: Teach switch_to_context() to use the context
      drm/i915/selftests: Move uncore fw selftests to operate on intel_gt
      drm/i915/selftests: Synchronize checking active status with retiremen=
t
      drm/i915/selftests: Release ctx->engine_mutex after iteration
      drm/i915/gt: Try to more gracefully quiesce the system before resets
      drm/i915/execlists: Force preemption
      drm/i915/execlists: Cancel banned contexts on schedule-out
      drm/i915/gem: Cancel contexts when hangchecking is disabled
      drm/i915/gt: Replace hangcheck by heartbeats
      drm/i915/selftests: Flush interrupts before disabling tasklets
      drm/i915/selftests: Flush any i915_active callback work as well
      drm/i915/gt: Split intel_ring_submission
      drm/i915/selftests: Tweak the default subtest runtime
      drm/i915/selftests: Force ordering of context switches
      drm/i915/pmu: Initialise the spinlock before registering
      drm/i915: Encapsulate kconfig constant values inside boolean predicat=
es
      drm/i915/tgl: Adjust the location of RING_MI_MODE in the context imag=
e
      drm/i915: Split memory_region initialisation into its own file
      drm/i915: Put future HW and their uAPIs under STAGING & BROKEN
      drm/i915/rps: Flip interpretation of ips fmin/fmax to max rps
      drm/i915/selftests: Measure basic throughput of blit routines
      drm/i915/selftests: Drop global engine lookup for gt selftests
      drm/i915/selftests: Check all blitter engines for client blt
      drm/i915/selftests: Use a random engine for GEM coherency tests
      drm/i915/gt: Tidy up rps irq handler to use intel_gt
      drm/i915/selftests: Select a random engine for testing memory regions
      drm/i915/selftests: Exercise adjusting rpcs over all render-class eng=
ines
      drm/i915/selftests: Check a few more fixed locations within the
context image
      drm/i915/execlists: Simply walk back along request timeline on reset
      drm/i915/selftests: Initialise err in case there are no engines!
      drm/i915/selftests: Initialise ret
      drm/i915/display: Mark conn as initialised by iterator
      drm/i915/gem: Limit the blitter sizes to ensure low preemption latenc=
y
      drm/i915/gt: Make timeslice duration configurable
      drm/i915/gem: Make context persistence optional
      drm/i915/gt: Always track callers to intel_rps_mark_interactive()
      drm/i915/selftests: Assert that the idle_pulse is sent
      drm/i915/selftests: Pretty print the i915_active
      drm/i915: Split detaching and removing the vma
      drm/i915/gem: Refine occupancy test in kill_context()
      drm/i915/lmem: Check against i915_selftest only under CONFIG_SELFTEST
      drm/i915/selftests: Start kthreads before stopping
      drm/i915: Protect request peeking with RCU
      drm/i915/gt: Call intel_gt_sanitize() directly
      drm/i915/gem: Leave reloading kernel context on resume to GT
      drm/i915/gt: Move user_forcewake application to GT
      drm/i915: Defer rc6 shutdown to suspend_late
      drm/i915/gt: Drop false assertion on user_forcewake
      drm/i915/selftests: Add intel_gt_suspend_prepare
      drm/i915/gt: Only drop heartbeat.systole if the sole owner
      drm/i915/gem: Fix error path to unlock if the GEM context is closed
      drm/i915: Leave the aliasing-ppgtt size alone
      drm/i915: Protect context while grabbing its name for the request
      drm/i915/pmu: "Frequency" is reported as accumulated cycles
      drm/i915/userptr: Try to acquire the page lock around set_page_dirty(=
)
      drm/i915/execlists: Move reset_active() from schedule-out to schedule=
-in
      drm/i915: Flush context free work on cleanup
      drm/i915/fbdev: Restore physical addresses for fb_mmap()
      drm/i915/gt: Wait for new requests in intel_gt_retire_requests()
      drm/i915: Split i915_active.mutex into an irq-safe spinlock for the r=
btree
      Revert "drm/i915/gt: Wait for new requests in intel_gt_retire_request=
s()"

Christian K=C3=B6nig (34):
      drm/amdgpu: use moving fence instead of exclusive for VM updates
      drm/amdgpu: reserve at least 4MB of VRAM for page tables v2
      drm/amdgpu: remove amdgpu_cs_try_evict
      drm/amdgpu: cleanup mtype mapping
      drm/amdgpu: cleanup PTE flag generation v3
      drm/amdgpu: grab the id mgr lock while accessing passid_mapping
      drm/ttm: return -EBUSY on pipelining with no_gpu_wait (v2)
      drm/amdgpu: split the VM entity into direct and delayed
      drm/amdgpu: allow direct submission in the VM backends v2
      drm/amdgpu: allow direct submission of PDE updates v2
      drm/amdgpu: allow direct submission of PTE updates
      drm/amdgpu: allow direct submission of clears
      drm/amdgpu: allocate PDs/PTs with no_gpu_wait in a page fault
      drm/amdgpu: reserve the root PD while freeing PASIDs
      drm/amdgpu: add graceful VM fault handling v3
      drm/amdgpu: revert "disable bulk moves for now"
      drm/amdgpu: cleanup coding style in the VM code a bit
      drm/amdgpu: drop double HDP flush in the VM code
      drm/amdgpu: trace if a PD/PT update is done directly
      drm/amdgpu: cleanup creating BOs at fixed location (v2)
      drm/amdgpu: once more fix amdgpu_bo_create_kernel_at
      drm/amdgpu: restrict hotplug error message
      drm/amdgpu: fix error handling in amdgpu_bo_list_create
      drm/amdgpu: fix potential VM faults
      dma-buf: change DMA-buf locking convention v3
      dma-buf: stop using the dmabuf->lock so much v2
      drm/ttm, drm/vmwgfx: move cpu_writers handling into vmwgfx
      drm/ttm: always keep BOs on the LRU
      drm/ttm: remove pointers to globals
      drm/ttm: use the parent resv for ghost objects v3
      drm/qxl: stop using TTM to call driver internal functions
      drm/ttm: stop exporting ttm_mem_io_* functions
      drm/amdgpu: add independent DMA-buf export v8
      drm/amdgpu: add independent DMA-buf import v9

Christophe JAILLET (2):
      drm/mcde: Fix an error handling path in 'mcde_probe()'
      drm/amd/display: Fix typo in some comments

Chunming Zhou (1):
      drm/syncobj: extend syncobj query ability v3

Clinton A Taylor (4):
      drm/i915/tgl: Add missing ddi clock select during DP init sequence
      drm/i915/tgl/pll: Set update_active_dpll
      drm/i915/tc: Update DP_MODE programming
      drm/i915/tgl: Add dkl phy programming sequences

Colin Ian King (11):
      drm/amd/display: rename variable eanble -> enable
      staging: fbtft: make several arrays static const, makes object smalle=
r
      drm/selftests: fix spelling mistake "misssing" -> "missing"
      drm/amd/display: fix spelling mistake AUTHENICATED -> AUTHENTICATED
      drm/amdgpu: fix uninitialized variable pasid_mapping_needed
      drm/amdgpu: remove redundant variable r and redundant return statemen=
t
      drm/amdkfd: add missing void argument to function kgd2kfd_init
      drm/i915: make array hw_engine_mask static, makes object smaller
      drm/komeda: remove redundant assignment to pointer disable_done
      drm/i915/selftests: fix null pointer dereference on pointer data
      drm/amdgpu/psp: fix spelling mistake "initliaze" -> "initialize"

Dan Carpenter (7):
      drm/mipi-dbi: fix a loop in debugfs code
      drm: panel-lvds: Potential Oops in probe error handling
      drm/i810: Prevent underflow in ioctl
      drm/amd/powerplay: unlock on error in smu_resume()
      drm/amd/powerplay: Fix error handling in smu_init_fb_allocations()
      drm/amdkfd: Fix a && vs || typo
      drm/amdgpu/vi: silence an uninitialized variable warning

Daniel Kurtz (1):
      drm/bridge: dw-hdmi: Restore audio when setting a mode

Daniel Vetter (14):
      drm/vblank: Document and fix vblank count barrier semantics
      drm/vkms: Use wait_for_flip_done
      drm/vkms: Reduce critical section in vblank_simulate
      drm/i915: disable set/get_tiling ioctl on gen12+
      drm: Use EOPNOTSUPP, not ENOTSUPP
      drm/blend: Define the direction of Z position values
      drm/doc: Improve docs around connector (un)registration
      drm/dp-mst: Drop connection_mutex check
      drm/doc: Drop misleading comment on drm_mode_config_cleanup
      drm/todo: Remove i915 device_link task
      drm/todo: Add levels
      Merge v5.4-rc4 into drm-next
      drm/simple-kms: Standardize arguments for callbacks
      drm/i915: Don't select BROKEN

Daniele Ceraolo Spurio (17):
      drm/i915/uc: define GuC and HuC FWs for EHL
      drm/i915: use a separate context for gpu relocs
      drm/i915: fix SFC reset flow
      drm/i915/tgl: s/ss/eu fuse reading support
      drm/i915/huc: fix version parsing from CSS header
      drm/i915/tgl: the BCS engine supports relative MMIO
      drm/i915/tgl: simplify the lrc register list for !RCS
      drm/i915: Add microcontrollers documentation section
      drm/i915/guc: improve documentation
      drm/i915/huc: improve documentation
      drm/i915: define i915_ggtt_has_aperture
      drm/i915: do not map aperture if it is not available.
      drm/i915: set num_fence_regs to 0 if there is no aperture
      drm/i915: error capture with no ggtt slot
      drm/i915/uc: define GuC and HuC binaries for TGL
      drm/i915: drop lrc header page
      drm/i915/guc: drop guc shared area

Dariusz Marcinkiewicz (8):
      drm_dp_cec: add connector info support.
      drm/i915/intel_hdmi: use cec_notifier_conn_(un)register
      drm/vc4/vc4_hdmi: fill in connector info
      drm: sti: use cec_notifier_conn_(un)register
      drm: exynos: exynos_hdmi: use cec_notifier_conn_(un)register
      tda9950: use cec_notifier_cec_adap_(un)register
      drm: tda998x: use cec_notifier_conn_(un)register
      drm/tegra: Use cec_notifier_conn_(un)register()

Dave Airlie (29):
      Merge tag 'drm-intel-next-2019-10-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2019-10-09-2' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2019-10-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'mediatek-drm-next-5.5' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge tag 'du-next-20191016' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-next-5.5-2019-10-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-next-5.5-2019-10-25' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-2019-10-24-2' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'exynos-drm-next-for-v5.5' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'topic/mst-suspend-resume-reprobe-2019-10-29-2' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2019-10-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm/tegra/for-5.5-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'drm-intel-next-2019-11-01-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-next-5.5-2019-11-01' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'mediatek-drm-next-5.5-2' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-next
      Merge tag 'drm-intel-next-fixes-2019-11-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2019-11-06' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge v5.4-rc7 into drm-next
      Merge tag 'drm-next-5.5-2019-11-08' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2019-11-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'arcpgu-updates-2019.07.18' of
github.com:abrodkin/linux into drm-next
      Backmerge i915 security patches from commit 'ea0b163b13ff' into drm-n=
ext
      Merge tag 'drm-intel-next-fixes-2019-11-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-next-5.5-2019-11-15' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2019-11-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2019-11-20' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-11-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-next-5.5-2019-11-22' of
git://people.freedesktop.org/~agd5f/linux into drm-next

David Galiffi (1):
      drm/amd/display: Fix dongle_caps containing stale information.

David Riley (3):
      drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using fenced version=
.
      drm/virtio: Use vmalloc for command buffer allocations.
      drm/virtio: Fix warning in virtio_gpu_queue_fenced_ctrl_buffer.

Dennis Li (3):
      drm/amdgpu: change to query the actual EDC counter
      drm/amd/include: add register define for VML2 and ATCL2
      drm/amdgpu: add RAS support for VML2 and ATCL2

Dhinakaran Pandiyan (1):
      drm/i915/tgl: Gen-12 display loses Yf tiling and legacy CCS support

Dmytro Laktyushkin (21):
      drm/amd/display: update navi to use new surface programming behaviour
      drm/amd/display: remove temporary transition code
      drm/amd/display: add additional flag consideration for surface update
      drm/amd/display: add vtg update after global sync update
      drm/amd/display: fix global sync param extraction indexing
      drm/amd/display: update odm mode validation to be in line with policy
      drm/amd/display: Add detile buffer size for DCN20
      drm/amd/display: fix pipe re-assignment when odm present
      drm/amd/display: add renoir specific watermark range and clk helper
      drm/amd/display: enable hostvm based on roimmu active for dcn2.1
      drm/amd/display: initialize RN gpuvm context programming function
      drm/amd/display: correct dcn21 NUM_VMID to 16
      drm/amd/display: update odm mode validation to be in line with policy
      drm/amd/display: remove unused code
      drm/amd/display: split dcn20 fast validate into more functions
      drm/amd/display: correctly initialize dml odm variables
      drm/amd/display: move dispclk vco freq to clk mgr base
      drm/amd/display: remove unnecessary assert
      drm/amd/display: fix number of dcn21 dpm clock levels
      drm/amd/display: add embedded flag to dml
      drm/amd/display: fix avoid_split for dcn2+ validation

Don Hiatt (1):
      drm/i915/guc: Skip suspend/resume GuC action on platforms w/o
GuC submission

Douglas Anderson (1):
      drm/rockchip: Round up _before_ giving to the clock framework

Emily Deng (3):
      drm/amdgpu: Fix tdr3 could hang with slow compute issue
      drm/amdgpu/discovery: Need to free discovery memory
      drm/amdgpu: Need to disable msix when unloading driver

Eric Huang (1):
      drm/amdgpu: change read of GPU clock counter on Vega10 VF

Eric Yang (7):
      drm/amd/display: exit PSR during detection
      drm/amd/display: fix code to control 48mhz refclk
      drm/amd/display: hook up notify watermark ranges and get clock table
      drm/amd/display: use dcn10 version of program tiling on Renoir
      drm/amd/display: add sanity check for clk table from smu
      drm/amd/display: move wm ranges reporting to end of init hw
      drm/amd/display: fix hubbub deadline programing

Eugeniy Paltsev (1):
      drm/arcpgu: rework encoder search

Evan Quan (30):
      drm/amd/powerplay: guard manual mode prerequisite for clock level for=
ce
      drm/amd/powerplay: update cached feature enablement status V3
      drm/amd/powerplay: do proper cleanups on hw_fini
      drm/amd/powerplay: issue DC-BTC for arcturus on SMU init
      drm/amd/powerplay: update smu11_driver_if_arcturus.h
      drm/amd/powerplay: properly set mp1 state for SW SMU suspend/reset ro=
utine
      drm/amd/powerplay: check SMU engine readiness before proceeding
on S3 resume
      drm/amd/powerplay: update arcturus smu-driver interaction header
      drm/amd/powerplay: enable df cstate control on powerplay routine
      drm/amd/powerplay: enable df cstate control on swSMU routine
      drm/amd/powerplay: enable Arcturus runtime VCN dpm on/off
      drm/amd/powerplay: update Arcturus driver smu interface XGMI link par=
t
      drm/amd/powerplay: add lock protection for swSMU APIs V2
      drm/amd/powerplay: split out those internal used swSMU APIs V2
      drm/amd/powerplay: clear the swSMU code layer
      drm/amd/powerplay: skip unsupported clock limit settings on Arcturus =
V2
      drm/amd/powerplay: correct current clock level label for Arcturus
      drm/amdgpu: change pstate only after all XGMI device initialized
      drm/amd/powerplay: update is_sw_smu_xgmi check
      drm/amd/powerplay: support xgmi pstate setting on powerplay routine V=
2
      drm/amd/powerplay: update Arcturus driver-smu interface header
      drm/amdgpu: register gpu instance before fan boost feature enablment
      drm/amdgpu: fix possible pstate switch race condition
      drm/amdgpu: perform p-state switch after the whole hive initialized
      drm/amd/powerplay: fix deadlock on setting
power_dpm_force_performance_level
      drm/amd/powerplay: correct Arcturus OD support
      drm/amd/powerplay: avoid DPM reenable process on Navi1x ASICs V2
      drm/amd/powerplay: issue BTC on Navi during SMU setup
      drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on unsupported AS=
ICs
      drm/amd/powerplay: correct fine grained dpm force level setting

Ezequiel Garcia (2):
      dt-bindings: display: rockchip: document VOP gamma LUT address
      drm/rockchip: Add optional support for CRTC gamma LUT

Felix Kuehling (7):
      drm/amdgpu: Determing PTE flags separately for each mapping (v3)
      drm/amdgpu: Use optimal mtypes and PTE bits for Arcturus
      drm/amdgpu: Remove unnecessary TLB workaround (v2)
      drm/amdgpu: Disable page faults while reading user wptrs
      drm/amdgpu: Disable retry faults in VMID0
      drm/amdgpu: Fix KFD-related kernel oops on Hawaii
      drm/amdgpu: Fix error handling in amdgpu_ras_recovery_init

Fernando Pacheco (1):
      drm/i915/uc: Extract common code from GuC stop/disable comm

Geert Uytterhoeven (3):
      drm: rcar_lvds: Fix color mismatches on R-Car H2 ES2.0 and later
      drm: Spelling s/connet/connect/
      drm/amdgpu: Remove superfluous void * cast in debugfs_create_file() c=
all

Gerd Hoffmann (63):
      fbdev: drop res_id parameter from remove_conflicting_pci_framebuffers
      drm: drop resource_id parameter from
drm_fb_helper_remove_conflicting_pci_framebuffers
      drm/i915: switch to drm_fb_helper_remove_conflicting_pci_framebuffers
      drm/virtio: make resource id workaround runtime switchable.
      drm/virtio: add plane check
      drm/virtio: cleanup queue functions
      drm/virtio: notify virtqueues without holding spinlock
      drm/virtio: pass gem reservation object to ttm init
      drm/virtio: switch virtio_gpu_wait_ioctl() to gem helper.
      drm/virtio: simplify cursor updates
      drm/virtio: remove virtio_gpu_object_wait
      drm/virtio: drop no_wait argument from virtio_gpu_object_reserve
      drm/virtio: remove ttm calls from in virtio_gpu_object_{reserve,
unreserve}
      drm/virtio: add virtio_gpu_object_array & helpers
      drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
      drm/virtio: rework virtio_gpu_object_create fencing
      drm/virtio: rework virtio_gpu_transfer_from_host_ioctl fencing
      drm/virtio: rework virtio_gpu_transfer_to_host_ioctl fencing
      drm/virtio: rework virtio_gpu_cmd_context_{attach, detach}_resource
      drm/virtio: drop virtio_gpu_object_list_validate/virtio_gpu_unref_lis=
t
      drm/virtio: switch from ttm to gem shmem helpers
      drm/virtio: remove virtio_gpu_alloc_object
      drm/virtio: drop virtio_gpu_object_{ref,unref}
      drm/virtio: drop virtio_gpu_object_{reserve, unreserve}
      drm/virtio: add fence sanity check
      drm/virtio: add worker for object release
      drm/virtio: fix command submission with objects but without fence.
      drm: add drm_print_bits
      drm/ttm: add drm gem ttm helpers, starting with drm_gem_ttm_print_inf=
o()
      drm/vram: use drm_gem_ttm_print_info
      drm/vram: add vram-mm debugfs file
      drm/qxl: use drm_gem_object_funcs callbacks
      drm/qxl: use drm_gem_ttm_print_info
      drm/vram: fix Kconfig
      drm/ttm: turn ttm_bo_device.vma_manager into a pointer
      drm/nouveau: switch to gem vma offset manager
      drm/vram: switch to gem vma offset manager
      drm/radeon: switch to gem vma offset manager
      drm/amdgpu: switch to gem vma offset manager
      drm/qxl: switch to gem vma offset manager
      drm/vmwgfx: switch to own vma manager
      drm/ttm: remove embedded vma_offset_manager
      drm/virtio: enable prime mmap support
      drm: tweak drm_print_bits()
      drm: add mmap() to drm_gem_object_funcs
      drm/shmem: switch shmem helper to &drm_gem_object_funcs.mmap
      drm/shmem: drop VM_DONTDUMP
      drm/shmem: drop VM_IO
      drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
      drm/ttm: factor out ttm_bo_mmap_vma_setup
      drm/ttm: rename ttm_fbdev_mmap
      drm/ttm: add drm_gem_ttm_mmap()
      drm/vram: switch vram helper to &drm_gem_object_funcs.mmap()
      drm/vram: drop verify_access
      drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS
      drm/qxl: drop qxl_ttm_fault
      drm/qxl: switch qxl to &drm_gem_object_funcs.mmap
      drm/qxl: drop verify_access
      drm/qxl: use DEFINE_DRM_GEM_FOPS()
      drm/qxl: allocate small objects top-down
      drm/virtio: print a single line with device features
      drm/virtio: move byteorder handling into
virtio_gpu_cmd_transfer_to_host_2d function
      drm/ttm: fix mmap refcounting

Guchun Chen (11):
      drm/amdgpu: remove duplicated header file include
      drm/amdgpu: add ras error query count interface for nbio
      drm/amdgpu: support pcie bif ras query and inject
      drm/amdgpu: add pcie bif ras related registers
      drm/amdgpu: implement ras query function for pcie bif
      drm/amdgpu: fix ras ctrl debugfs node leak
      drm/amdgpu: avoid null pointer dereference
      drm/amdgpu: remove redundant variable definition
      drm/amdgpu: enable full ras by default
      drm/amdgpu: refine reboot debugfs operation in ras case (v3)
      drm/amdgpu: define macros for retire page reservation

Guido G=C3=BCnther (1):
      drm/mxsfb: Read bus flags from bridge if present

Gwan-gyeong Mun (9):
      drm: Rename HDMI colorspace property creation function
      drm: Add DisplayPort colorspace property creation function
      drm/i915/dp: Extend program of VSC Header and DB for Colorimetry Form=
at
      drm/i915/dp: Add support of BT.2020 Colorimetry to DP MSA
      drm/i915/dp: Attach colorspace property
      drm/i915: Add new GMP register size for GEN11
      drm/i915/dp: Program an Infoframe SDP Header and DB for HDR
Static Metadata
      drm/i915/dp: Attach HDR metadata property to DP connector
      drm/i915: Split a setting of MSA to MST and SST

HaiJun Chang (1):
      drm/amdgpu: fix gfx VF FLR test fail on navi

Hans Verkuil (2):
      drm/sun4i/sun4i_hdmi_enc: call cec_s_conn_info()
      cec: add cec_adapter to cec_notifier_cec_adap_unregister()

Hans de Goede (3):
      drm/radeon: Bail earlier when radeon.cik_/si_support=3D0 is passed
      drm/amdgpu: Bail earlier when amdgpu.cik_/si_support is not set to 1
      drm/vboxvideo: Use drm_gem_fb_create_with_dirty instead of
drm_gem_fb_create

Harish Kasiviswanathan (4):
      drm/amdkfd: Store kfd_dev in iolink and cache properties
      drm/amd: Pass drm_device to kfd
      device_cgroup: Export devcgroup_check_permission
      drm/amdkfd: Check against device cgroup

Harry Wentland (1):
      drm/amd/display; Fix kernel doc warnings

Hawking Zhang (31):
      drm/amdgpu: add new amdgpu nbio header file
      drm/amdgpu: switch to new amdgpu_nbio structure
      drm/amdgpu/nbio: add functions to query ras specific interrupt status
      drm/amdgpu: add nbif v7_4 irq source header for vega20
      drm/amdgpu: update nbio v7_4 ip header files
      drm/amdgpu: add ras_controller and err_event_athub interrupt support
      drm/amdgpu: poll ras_controller_irq and err_event_athub_irq status
      drm/amdgpu: add helper function to do common ras_late_init/fini (v3)
      drm/amdgpu: switch to amdgpu_ras_late_init for gfx v9 block (v2)
      drm/amdgpu: switch to amdgpu_ras_late_init for sdma v4 block (v2)
      drm/amdgpu: switch to amdgpu_ras_late_init for gmc v9 block (v2)
      drm/amdgpu: add mmhub ras_late_init callback function (v2)
      drm/amdgpu: add ras_late_init callback function for nbio v7_4 (v3)
      drm/amdgpu: switch to amdgpu_ras_late_init for nbio v7_4 (v2)
      drm/amdgpu: check mmhub_funcs pointer before refering to it
      drm/amdgpu: fix memory leak when ras is not supported on specific ip =
block
      drm/amdgpu: only apply gds clearing workaround when ras is supported
      drm/amdgpu: set ip specific ras interface pointer to NULL after free =
it
      drm/amdgpu/gmc: switch to amdgpu_gmc_ras_late_init helper function
      drm/amdgpu/gfx: switch to amdgpu_gfx_ras_late_init helper function
      drm/amdgpu/sdma: switch to amdgpu_sdma_ras_late_init helper function
      drm/amdgpu/mmhub: switch to amdgpu_mmhub_ras_late_init helper functio=
n
      drm/amdgpu/nbio: switch to amdgpu_nbio_ras_late_init helper function
      drm/amdgpu: init UMC & RSMU register base address
      drm/amdgpu: initialize ras structures for xgmi block (v2)
      drm/amdgpu: enable error injection to XGMI block via debugfs
      drm/amdgpu: add psp ip block for arct
      drm/amdgpu: do not init mec2 jt for renoir
      drm/amdgpu: add command id in psp response failure message
      drm/amdgpu: disallow direct upload save restore list from gfx driver
      drm/amdgpu: avoid upload corrupted ta ucode to psp

Heinrich Fink (1):
      drm: Add high-precision time to vblank trace event

Hersen Wu (3):
      drm/amdgpu/powerplay: add renoir funcs to support dc
      drm/amdgpu/display: hook renoir dc to pplib funcs
      drm/amdgpu/display: fix build error casused by CONFIG_DRM_AMD_DC_DCN2=
_1

Huang Rui (11):
      drm/amdkfd: add renoir cache info for CRAT (v2)
      drm/amdkfd: add renoir kfd device info (v2)
      drm/amdkfd: enable kfd device queue manager v9 for renoir
      drm/amdkfd: add renoir type for the workaround of iommu v2 (v2)
      drm/amdkfd: init kfd apertures v9 for renoir
      drm/amdkfd: init kernel queue for renoir
      drm/amdkfd: add package manager for renoir
      drm/amdkfd: add renoir kfd topology
      drm/amdgpu: disable gfxoff while use no H/W scheduling policy
      drm/amdkfd: enable renoir while device probes
      drm/amdkfd: fix the missed asic name while inited renoir_device_info

Iago Toral Quiroga (2):
      drm/v3d: don't leak bin job if v3d_job_init fails.
      drm/v3d: clean caches at the end of render jobs on request from user =
space

Icenowy Zheng (3):
      Revert "drm/sun4i: dsi: Change the start delay calculation"
      drm/sun4i: dsi: fix the overhead of the horizontal front porch
      drm/sun4i: sun6i_mipi_dsi: fix DCS long write packet length

Ilya Bakoulin (3):
      drm/amd/display: Fix DML tests
      drm/amd/display: Add missing surface address registers
      drm/amd/display: Fix HUBP secondary viewport programming

Imre Deak (7):
      drm/i915: Align power domain names with port names
      drm/i915/tgl: Add the Thunderbolt PLL divider values
      drm/i915: Add new CNL PCH ID seen on a CML platform
      drm/i915: Avoid HPD poll detect triggering a new detect cycle
      drm/i915/gen8+: Add RC6 CTX corruption WA
      drm/i915: Fix detection for a CMP-V PCH
      drm/i915: Restore GT coarse power gating workaround

Jack Zhang (5):
      drm/amd/amdgpu: add sw_fini interface for df_funcs
      drm/amdgpu/sriov: add ring_stop before ring_create in psp v11 code
      drm/amd/amdgpu/sriov ip block setting of Arcturus
      drm/amd/amdgpu/sriov temporarily skip ras,dtm,hdcp for arcturus VF
      drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus VF.

Jacopo Mondi (1):
      drm: rcar-du: kms: Expand comment in vsps parsing routine

Jaehyun Chung (2):
      drm/amd/display: OTC underflow fix
      drm/amd/display: Add capability check for static ramp calc

Jagan Teki (4):
      dt-bindings: sun6i-dsi: Add VCC-DSI supply property
      drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI regulator support
      drm/sun4i: dsi: Fix TCON DRQ set bits
      drm/sun4i: dsi: Fix video start delay computation

James Ausmus (4):
      drm/i915/tgl: Add memory type decoding for bandwidth checking
      drm/i915: Move SAGV block time to dev_priv
      drm/i915/tgl: Read SAGV block time from PCODE
      drm/i915/aml: Allow SPT PCH for all AML devices

James Zhu (1):
      drm/amdgpu/vcn: Enable VCN2.5 encoding

Jane Jian (1):
      drm/amdgpu: add VCN0 and VCN1 needed headers

Jani Nikula (28):
      drm/i915: add INTEL_NUM_PIPES() and use it
      drm/i915: convert device info num_pipes to pipe_mask
      drm/i915: introduce INTEL_DISPLAY_ENABLED()
      drm/i915: stop conflating HAS_DISPLAY() and disabled display
      drm/i915/dsb: single register write function for DSB.
      drm/i915: add i915_driver_modeset_remove()
      drm/i915: pass i915 to i915_driver_modeset_probe()
      drm/i915: pass i915 to intel_modeset_driver_remove()
      drm/i915: abstract intel_panel_sanitize_ssc() from intel_modeset_init=
()
      drm/i915: abstract intel_mode_config_init() from intel_modeset_init()
      drm/i915: pass i915 to intel_modeset_init() and intel_modeset_init_hw=
()
      drm/i915/display: abstract all vgaarb access to intel_vga.[ch]
      drm/print: move drm_debug variable to drm_print.[ch]
      drm/print: add drm_debug_enabled()
      drm/etnaviv: use drm_debug_enabled() to check for debug categories
      drm/i2c/sil164: use drm_debug_enabled() to check for debug categories
      drm/msm: use drm_debug_enabled() to check for debug categories
      drm/i915: use DRM_ERROR() instead of drm_err()
      drm/i915: use DRM_DEBUG_KMS() instead of drm_dbg(DRM_UT_KMS, ...)
      drm/i915/dp: remove static variable for aux last status
      drm/i915/vga: rename intel_vga_msr_write() to intel_vga_reset_io_mem(=
)
      drm/i915: split out i915_switcheroo.[ch] from i915_drv.c
      drm/i915: move gmbus setup down to intel_modeset_init()
      drm/i915/dsc: rename crtc state dsc_params member to dsc
      drm/i915/dsc: move crtc state dp_dsc_cfg member under dsc as config
      drm/i915/bios: add compression parameter block definition
      drm/i915/display: only include intel_dp_link_training.h where needed
      drm/i915: fix accidental static variable use

Janusz Krzysztofik (3):
      drm/i915: Restore full symmetry in i915_driver_modeset_probe/remove
      drm/i915: Fix i915_inject_load_error() name to read *_probe_*
      drm/i915: Rename "inject_load_failure" module parameter

Jay Cornwall (3):
      drm/amdkfd: Swap trap temporary registers in gfx10 trap handler
      drm/amdkfd: Fix race in gfx10 context restore handler
      drm/amdgpu: Update Arcturus golden registers

Jean Delvare (2):
      drm/amd: be quiet when no SAD block is found
      drm/radeon: be quiet when no SAD block is found

Jean-Jacques Hiblot (1):
      drm/omap: use refcount API to track the number of users of dma_addr

Jesse Zhang (2):
      drm/amd/amdgpu:Fix compute ring unable to detect hang.
      drm/amd/amdgpu: finish delay works before release resources

Jiange Zhao (7):
      drm/amdgpu: Add SRIOV mailbox backend for Navi1x
      drm/amdgpu: For Navi12 SRIOV VF, register mailbox functions
      drm/amdgpu/SRIOV: Navi10/12 VF doesn't support SMU
      drm/amdgpu/SRIOV: Navi12 SRIOV VF doesn't load TOC
      drm/amdgpu/SRIOV: Navi12 SRIOV VF gets GTT base
      drm/amdgpu/SRIOV: add navi12 pci id for SRIOV (v2)
      drm/amdgpu/SRIOV: SRIOV VF doesn't support BACO

Jing Zhou (1):
      drm/amd/display: verify stream link before link test

Jitao Shi (12):
      dt-bindings: display: mediatek: update dsi supported chips
      drm/mediatek: separate mipi_tx to different file
      drm/mediatek: add mipi_tx driver for mt8183
      drm/mediatek: move mipi_dsi_host_register to probe
      drm/mediatek: fixes CMDQ reg address of mt8173 is different with mt27=
01
      drm/mediatek: replace writeb() with mtk_dsi_mask()
      drm/mediatek: add dsi reg commit disable control
      drm/mediatek: add frame size control
      drm/mediatek: add mt8183 dsi driver support
      drm/mediatek: change the dsi phytiming calculate method
      drm/mediatek: adjust dsi and mipi_tx probe sequence
      drm/mediatek: add dphy reset after setting lanes number

Johan Hovold (1):
      drm/msm: fix memleak on release

John Clements (2):
      drm/amdgpu: enable TA load support in Arcturus
      drm/amdgpu: clean up load TMR sequence

John Stultz (4):
      dma-buf: heaps: Add heap helpers
      dma-buf: heaps: Add system heap to dmabuf heaps
      dma-buf: heaps: Add CMA heap to dmabuf heaps
      kselftests: Add dma-heap test

Jonas Karlman (4):
      drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame suppor=
t
      drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
      drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
      drm/sun4i: Enable DRM InfoFrame support on H6

Jonathan Kim (1):
      drm/amdgpu: fix vega20 pstate status change

Jonathan Neusch=C3=A4fer (1):
      drm/mcde: Fix reference to DOC comment

Joonas Lahtinen (9):
      drm/i915: Remove link to missing "Batchbuffer Pools" documentation
      drm/i915: Indent GuC/WOPCM documentation sections
      drm/i915: Update DRIVER_DATE to 20190927
      drm/i915: Update DRIVER_DATE to 20191007
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20191021
      drm/i915: Update DRIVER_DATE to 20191101
      drm/i915: Update DRIVER_DATE to 20191101
      Merge tag 'gvt-next-fixes-2019-11-12' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jordan Lazare (1):
      drm/amd/display: Remove superfluous assert

Joseph Gravenor (2):
      drm/amd/display: fix hotplug during display off
      drm/amd/display: add guard for SMU ver, for 48mhz clk

Joshua Aberback (3):
      drm/amd/display: Add missing shifts and masks for dpp registers on dc=
n2
      drm/amd/display: Restore should_update_pstate_support after bad rever=
t
      drm/amd/display: Apply vactive dram clock change workaround to dcn2 D=
MLv2

Josip Pavic (2):
      drm/amd/display: define parameters for abm 2.3
      drm/amd/display: wait for set pipe mcp command completion

Jos=C3=A9 Roberto de Souza (33):
      drm/i915/psr: Make PSR registers relative to transcoders
      drm/i915: Add transcoder restriction to PSR2
      drm/i915: Do not unmask PSR interruption in IRQ postinstall
      drm/i915/tgl: Guard and warn if more than one eDP panel is present
      drm/i915: Do not read PSR2 register in transcoders without PSR2
      drm/i915/tgl: Add maximum resolution supported by PSR2 HW
      drm: Add for_each_oldnew_intel_crtc_in_state_reverse()
      drm/i915: Disable pipes in reverse order
      drm/i915/tgl: Implement TGL DisplayPort training sequence
      drm/i915/tgl: PSR link standby is not supported anymore
      drm/i915/psr: Only handle interruptions of the transcoder in use
      drm/i915/tgl: Access the right register when handling PSR interruptio=
ns
      drm/i915: Apply FBC WA for TGL too
      drm/i915/mst: Do not hardcoded the crtcs that encoder can connect
      drm/connector: Share with non-atomic drivers the function to get
the single encoder
      drm/connector: Allow max possible encoders to attach to a connector
      drm/i915/tgl: Finish modular FIA support on registers
      drm/i915/icl: Unify disable and enable phy clock gating functions
      drm/i915/tgl: Check the UC health of tc controllers after power on
      drm/i915/tgl: Add dkl phy pll calculations
      drm/i915/tgl: Return the mg/dkl pll as DDI clock for new TC ports
      drm/i915/tgl: Fix dkl link training
      drm/i915/mg: Use tc_port instead of port parameter to MG registers
      drm/i915/display/psr: Print in debugfs if PSR is not enabled
because of sink
      drm/i915: Add is_dgfx to device info
      drm/i915/tc: Clear DKL_TX_PMD_LANE_SUS before program voltage swing
      drm/i915: Add two spaces before the SKL_DFSM registers
      drm/i915/display: Handle fused off HDCP
      drm/i915/display: Check if FBC is fused off
      drm/i915/display/icl+: Check if DMC is fused off
      drm/i915/display/cnl+: Handle fused off DSC
      drm/i915/dp: Do not switch aux to TBT mode for non-TC ports
      drm/i915/display: Fix TRANS_DDI_MST_TRANSPORT_SELECT definition

Julian Parkin (3):
      drm/amd/display: Separate hardware initialization from creation
      drm/amd/display: Reprogram FMT on pipe change
      drm/amd/display: Program DWB watermarks from correct state

Jun Lei (6):
      drm/amd/display: remove hw access from dc_destroy
      drm/amd/display: add explicit comparator as default optimization chec=
k
      drm/amd/display: add 50us buffer as WA for pstate switch in active
      drm/amd/display: add odm visual confirm
      drm/amd/display: add flag to allow diag to force enumerate edp
      drm/amd/display: do not synchronize "drr" displays

Jyri Sarha (1):
      drm/omap: dss: move platform_register_drivers() to dss.c and remove c=
ore.c

Kai Vehmanen (3):
      drm/i915: save AUD_FREQ_CNTRL state at audio domain suspend
      drm/i915: Fix audio power up sequence for gen10+ display
      drm/i915: extend audio CDCLK>=3D2*BCLK constraint to more platforms

Kai-Heng Feng (1):
      drm/amd/display: Restore backlight brightness after system resume

Kangjie Lu (2):
      gma/gma500: fix a memory disclosure bug due to uninitialized bytes
      drm/gma500: fix memory disclosures due to uninitialized bytes

Kenneth Feng (5):
      drm/amd/amdgpu: add IH cg support on soc15 project
      drm/amd/powerplay: bug fix for pcie parameters override
      drm/amd/powerplay: bug fix for memory clock request from display
      drm/amd/powerplay: dynamically disable ds and ulv for compute
      drm/amd/powerplay: read pcie speed/width info (v2)

Kenneth Graunke (1):
      drm/i915: Whitelist COMMON_SLICE_CHICKEN2

Kent Russell (2):
      Revert "drm/amdgpu/nbio7.4: add hw bug workaround for vega20"
      drm/amdgpu: Add SMUIO values for other I2C controller v2

Kevin Wang (9):
      drm/amd/powerplay: replace smu->table_count with SMU_TABLE_COUNT
in smu (v2)
      drm/amd/powerplay: remove duplicate macro of smu_get_uclk_dpm_states
      drm/amd/powerplay: change metrics update period from 1ms to 100ms
      drm/amd/powerplay: add sensor lock support for smu
      drm/amd/powerplay: initlialize smu->is_apu is false by default
      drm/amdgpu/swSMU: custom UMD pstate peak clock for navi14
      drm/amdgpu: fix amdgpu trace event print string format error
      drm/amd/swSMU: fix smu workload bit map error
      drm/amdgpu: fix sysfs interface pcie_replay_count error on navi asic

Khaled Almahallawy (1):
      drm/i915/tgl: Enable DDI/Port G

Krunoslav Kovac (2):
      drm/amd/display: Subsample mode suboptimal for YCbCr4:2:2
      drm/amd/display: Only use EETF when maxCL > max display

Krzysztof Kozlowski (2):
      drm/amd: Fix Kconfig indentation
      drm/i915: Fix Kconfig indentation

Krzysztof Wilczynski (1):
      drm/exynos: Move static keyword to the front of declaration

Kyle Mahlkuch (1):
      drm/radeon: Fix EEH during kexec

KyleMahlkuch (1):
      drm/radeon: Clean up code in radeon_pci_shutdown()

Laurent Pinchart (7):
      drm/panel: Add missing drm_panel_init() in panel drivers
      drm/panel: Initialise panel dev and funcs through drm_panel_init()
      drm/ingenic: Hardcode panel type to DPI
      drm/panel: Add and fill drm_panel type field
      drm/bridge: panel: Infer connector type from panel by default
      drm/panel: panel-simple: Set OSD070T1718 panel type
      drm/bridge: Fix references to drm_bridge_funcs in documentation

Le Ma (10):
      drm/amdgpu: disable vcn ip block for front door loading on Arcturus
      drm/amdgpu: enable psp front door loading by default on Arcturus
      drm/amdgpu: correct condition check for psp rlc autoload
      drm/amdgpu/soc15: disable doorbell interrupt as part of BACO
entry sequence
      drm/amd/powerplay: avoid disabling ECC if RAS is enabled for VEGA20
      drm/amd/powerplay: send EnterBaco msg with argument as RAS recovery f=
lag
      drm/amd/powerplay: add BACO platformCaps for VEGA20
      drm/amdgpu: clear UVD VCPU buffer when err_event_athub generated
      drm/amdgpu: bypass some cleanup work after err_event_athub (v2)
      drm/amdgpu: fix no ACK from LDS read during stress test for Arcturus

Lee Shawn C (1):
      drm/edid: Select DMT timing if EDID's display feature not support GTF

Leo Li (2):
      drm/amd/display: Fix maybe-uninitialized warning
      drm/amdgpu: Add DC feature mask to disable fractional pwm

Leo Liu (3):
      drm/amdgpu/vcn: use amdgpu_ring_test_helper
      drm/amdgpu: add code comment in vcn_v2_5_hw_init
      drm/amdgpu/vcn2.5: fix the enc loop with hw fini

Lewis Huang (7):
      drm/amd/display: refine i2c over aux
      drm/amd/display: fix i2c wtire mot incorrect issue
      drm/amd/display: check phy dpalt lane count config
      drm/amd/display: move the bounding box patch before calculate wm
      drm/amd/display: Temporary workaround to toggle watermark setting
      drm/amd/display: enable smu set dcfclk
      drm/amd/display: take signal type from link

Linus Walleij (1):
      drm/sti: Include the right header

Lionel Landwerlin (15):
      drm/i915/perf: move perf types to their own header
      drm/i915/perf: drop list of streams
      drm/i915/perf: store the associated engine of a stream
      drm/i915/perf: allow for CS OA configs to be created lazily
      drm/i915/perf: implement active wait for noa configurations
      drm/i915/perf: execute OA configuration from command stream
      drm/i915/perf: introduce a versioning of the i915-perf uapi
      drm/i915: add support for perf configuration queries
      drm/i915/perf: allow holding preemption on filtered ctx
      drm/i915/perf: fix oa config reconfiguration
      drm/i915: capture aux page table error register
      drm/i915/tgl: Add perf support on TGL
      drm/i915/perf: ensure selftests select valid format
      drm/i915/perf: always consider holding preemption a privileged op
      drm/i915/perf: don't forget noa wait after oa config

Lowry Li (Arm Technology China) (8):
      drm/komeda: Adds error event print functionality
      drm/komeda: Adds register dump support for gcu, lup and dou
      drm/komeda: Adds power management support
      drm/komeda: SW workaround for D71 doesn't flush shadow registers
      drm/komeda: Add line size support
      drm/komeda: Adds layer horizontal input size limitation check for D71
      drm/komeda: Set output color depth for output
      drm/komeda: Adds output-color format support

Luben Tuikov (1):
      drm/amdgpu: Use the ALIGN() macro

Lucas De Marchi (20):
      drm/i915: parameterize south hpd macros
      drm/i915: unify icp, tgp and mcc irq handling
      drm/i915: parameterize SDE hotplug registers
      drm/i915: unify icp, tgp and mcc irq setup
      drm/i915: protect access to DP_TP_* on non-dp
      drm/i915/tgl: move DP_TP_* to transcoder
      drm/i915/tgl: disable SAGV temporarily
      drm/i915/tgl: add gen12 to stolen initialization
      drm/i915/tgl: Add initial dkl pll support
      drm/i915/tgl: re-indent code to prepare for DKL changes
      drm/i915/tgl: initialize TC and TBT ports
      drm/dp-mst: fix warning on unused var
      drm/i915: simplify setting of ddi_io_power_domain
      drm/i915: fix port checks for MST support on gen >=3D 11
      drm/i915: remove extra new line on pipe_config mismatch
      drm/i915: add pipe id/name to pipe mismatch logs
      drm/i915: prettify MST debug message
      drm/i915: do not set MOCS control values on dgfx
      drm/i915: split gen11_irq_handler to make it shareable
      drm/i915/tgl: add support to one DP-MST stream

Lyude Paul (38):
      drm/i915: Call dma_set_max_seg_size() in i915_driver_hw_probe()
      drm/dp_mst: Move link address dumping into a function
      drm/dp_mst: Get rid of list clear in destroy_connector_work
      drm/dp_mst: Move test_calc_pbn_mode() into an actual selftest
      drm/print: Add drm_err_printer()
      drm/dp_mst: Combine redundant cases in drm_dp_encode_sideband_req()
      drm/dp_mst: Add sideband down request tracing + selftests
      drm/dp_mst: Refactor drm_dp_send_enum_path_resources
      drm/dp_mst: Remove huge conditional in drm_dp_mst_handle_up_req()
      drm/dp_mst: Constify guid in drm_dp_get_mst_branch_by_guid()
      drm/dp_mst: Refactor drm_dp_mst_handle_up_req()
      drm/dp_mst: Refactor drm_dp_mst_handle_down_rep()
      drm/dp_mst: Cleanup drm_dp_send_link_address() a bit
      drm/encoder: Fix possible_clones documentation
      drm/encoder: Fix possible_crtcs documentation
      drm/encoder: Don't raise voice in drm_encoder_mask() documentation
      drm/dp_mst: Destroy topology_mgr mutexes
      drm/dp_mst: Rename drm_dp_add_port and drm_dp_update_port
      drm/dp_mst: Remove lies in {up, down}_rep_recv documentation
      drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
      drm/amdgpu: Iterate through DRM connectors correctly
      drm/amdgpu/dm/mst: Remove unnecessary NULL check
      drm/amdgpu/dm/mst: Don't create MST topology managers for eDP ports
      drm/amdgpu/dm/mst: Use ->atomic_best_encoder
      drm/dp_mst: Destroy MSTBs asynchronously
      drm/dp_mst: Remove PDT teardown in drm_dp_destroy_port() and refactor
      drm/dp_mst: Refactor pdt setup/teardown, add more locking
      drm/dp_mst: Handle UP requests asynchronously
      drm/dp_mst: Add probe_lock
      drm/dp_mst: Protect drm_dp_mst_port members with locking
      drm/dp_mst: Don't forget to update port->input in
drm_dp_mst_handle_conn_stat()
      drm/dp_mst: Lessen indenting in drm_dp_mst_topology_mgr_resume()
      drm/nouveau: Don't grab runtime PM refs for HPD IRQs
      drm/nouveau: Resume hotplug interrupts earlier
      drm/amdgpu: Iterate through DRM connectors correctly
      drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
      drm/dp_mst: Add basic topology reprobing when resuming
      drm/dp_mst: Add topology ref history tracking for debugging

Maarten Lankhorst (12):
      drm/i915: Fix regression with crtc disable ordering
      drm/i915/dp: Fix dsc bpp calculations, v5.
      drm/i915: Add hardware readout for FEC
      drm/i915: Get rid of crtc_state->fb_changed
      drm/i915: Rename planar linked plane variables
      drm/i915: Do not add all planes when checking scalers on glk+
      drm/plane: Clarify our expectations for src/dst rectangles
      drm/i915: Fix for_each_intel_plane_mask definition
      drm/i915: Introduce and use intel_atomic_crtc_state_for_each_plane_st=
ate.
      drm/i915: Use intel_plane_state in prepare and cleanup plane_fb
      drm/i915: Remove begin/finish_crtc_commit, v4.
      drm/i915: Remove cursor use of properties for coordinates

Madhumitha Tolakanahalli Pradeep (1):
      drm/i915/tgl: Enabling DSC on Pipe A for TGL

Manasi Navare (11):
      drm/i915/dp: Fix DSC enable code to use cpu_transcoder instead
of encoder->type
      drm/i915/display: Rename update_crtcs() to commit_modeset_enables()
      drm/i915/display: Move the commit_tail() disable sequence to
separate function
      drm/i915/display/icl: Bump up the hdisplay and vdisplay as per
transcoder limits
      drm/i915/display/icl: Bump up the plane/fb height
      drm/i915/display/icl: Save Master transcoder in slave's
crtc_state for Transcoder Port Sync
      drm/i915/display/icl: Enable TRANSCODER PORT SYNC for tiled
displays across separate ports
      drm/i915/display/icl: HW state readout for transcoder port sync confi=
g
      drm/i915/display/icl: Enable master-slaves in trans port sync
      drm/i915/display/icl: Disable transcoder port sync as part of
crtc_disable() sequence
      drm/i915/display/icl: In port sync mode disable slaves first then mas=
ter

Marek Ol=C5=A1=C3=A1k (4):
      drm/amdgpu: remove gfx9 NGG
      drm/amdgpu: return tcc_disabled_mask to userspace
      drm/amdgpu: simplify gds_compute_max_wave_id computation
      drm/amdgpu: Allow reading more status registers on si/cik

Markus Elfring (2):
      drm/bridge/synopsys: dsi: Use devm_platform_ioremap_resource()
in __dw_mipi_dsi_probe()
      drm/rockchip: rk3066_hdmi: Use devm_platform_ioremap_resource()
in rk3066_hdmi_bind()

Martin Leung (3):
      drm/amd/display: enable single dp seamless boot
      drm/amd/display: fix use of uninitialized variable
      drm/amd/display: add more checks to validate seamless boot timing

Martin Tsai (1):
      drm/amd/display: Handle virtual signal type in disable_link()

Matt Coffin (4):
      drm/amdgpu/navi10: implement sclk/mclk OD via pp_od_clk_voltage
      drm/amdgpu/navi10: implement GFXCLK_CURVE overdrive
      drm/amdgpu/navi10: Implement od clk printing
      drm/amdgpu/smu_v11: Unify and fix power limits

Matt Roper (25):
      drm/i915: Allow /2 CD2X divider on gen11+
      drm/i915: Add 324mhz and 326.4mhz cdclks for gen11+
      drm/i915/tgl: Use refclk/2 as bypass frequency
      drm/i915: Consolidate bxt/cnl/icl cdclk readout
      drm/i915: Use literal representation of cdclk tables
      drm/i915: Combine bxt_set_cdclk and cnl_set_cdclk
      drm/i915: Kill cnl_sanitize_cdclk()
      drm/i915: Consolidate {bxt,cnl,icl}_uninit_cdclk
      drm/i915: Add calc_voltage_level display vfunc
      drm/i915: Enhance cdclk sanitization
      drm/i915: Consolidate {bxt,cnl,icl}_init_cdclk
      drm/i915/cml: Add second PCH ID for CMP
      drm/i915: Future-proof DDC pin mapping
      drm/i915: Unify ICP and MCC hotplug pin tables
      drm: Destroy the correct mutex name in drm_dp_mst_topology_mgr_destro=
y
      drm/i915: Small joiner RAM buffer size is platform-specific
      drm/i915/vbt: Child device size remains unchanged through VBT 229
      drm/i915: Select DPLL's via mask
      drm/i915/ehl: Don't forget to set TC long detect function
      drm/i915: Introduce Jasper Lake PCH
      drm/i915: Catch GTT fault errors for gen11+ planes
      drm/i915/tgl: Handle AUX interrupts for TC ports
      drm/i915: Drop unused AUX register offsets
      drm/i915/tgl: Add AUX B & C to DC_OFF_POWER_DOMAINS
      drm/i915: Provide more information on DP AUX failures

Matthew Auld (23):
      drm/i915: s/for_each_sgt_dma/for_each_sgt_daddr/
      drm/i915/buddy: add missing call to i915_global_register
      drm/i915: export color_differs
      drm/i915: s/i915_gtt_color_adjust/i915_ggtt_color_adjust
      drm/i915: cleanup cache-coloring
      drm/i915: include GTT page-size info in error state
      drm/i915: check for kernel_context
      drm/i915: simplify i915_gem_init_early
      drm/i915: introduce intel_memory_region
      drm/i915/region: support contiguous allocations
      drm/i915/region: support volatile objects
      drm/i915: treat shmem as a region
      drm/i915: treat stolen as a region
      drm/i915: support creating LMEM objects
      drm/i915/selftests: add write-dword test for LMEM
      drm/i915/selftests: extend coverage to include LMEM huge-pages
      drm/i915/selftests: prefer random sizes for the huge-GTT-page smoke t=
ests
      drm/i915/selftests: add sanity selftest for huge-GTT-pages
      drm/i915/selftests/blt: add some kthreads into the mix
      drm/i915/blt: fixup block_size rounding
      drm/i915: don't allocate the ring in stolen if we lack aperture
      drm/i915/selftests: check for missing aperture
      drm/i915/lmem: add the fake lmem region

Matthias Kaehlcke (1):
      drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the internal I2C
controller

Maxime Ripard (3):
      MAINTAINERS: Update Allwinner DRM drivers entry
      MAINTAINERS: Add Jernej =C5=A0krabec as a reviewer for DE2
      Merge drm/drm-next into drm-misc-next

Michael Strauss (5):
      drm/amd/display: Update number of dcn21 audio endpoints
      drm/amd/display: Fix rn audio playback and video playback speed
      drm/amd/display: Fix MPO & pipe split on 3-pipe dcn2x
      drm/amd/display: Passive DP->HDMI dongle detection fix
      drm/amd/display: Disable force_single_disp_pipe_split on DCN2+

Michal Wajdeczko (2):
      drm/i915/execlists: Use vfunc to check engine submission mode
      drm/i915: Don't try to place HWS in non-existing mappable region

Micha=C5=82 Winiarski (4):
      drm/i915: Define explicit wedged on init reset state
      drm/i915/execlists: Use per-process HWSP as scratch
      drm/i915: Adjust length of MI_LOAD_REGISTER_REG
      drm/i915: Add definitions for MI_MATH command

Michel Thierry (7):
      drm/i915/tgl: Move GTCR register to cope with GAM MMIO address remap
      drm/i915/tgl: Enable VD HCP/MFX sub-pipe power gating
      drm/i915/tgl: Do not apply WaIncreaseDefaultTLBEntries from GEN12 onw=
ards
      drm/i915/tgl/perf: use the same oa ctx_id format as icl
      drm/i915/tgl: Register state context definition for Gen12
      drm/i915/tgl: Introduce gen12 forcewake ranges
      drm/i915/tgl: Implement Wa_1406941453

Mihail Atanassov (6):
      drm/komeda: Add ACLK rate to sysfs
      drm/komeda: Remove in-code use of ifdef
      drm/komeda: Use IRQ_RETVAL shorthand in d71_irq_handler
      drm/komeda: Workaround for broken FLIP_COMPLETE timestamps
      drm/komeda: Dump SC_ENH_* registers from scaler block
      MAINTAINERS: Add Mihail to Komeda DRM driver

Mika Kuoppala (19):
      drm/i915: Extend non readable mcr range
      drm/i915: Use engine relative LRIs on context setup
      drm/i915: Update Gen11 forcewake ranges
      drm/i915/tgl: Re-enable rc6
      drm/i915/icl: Wa_1607087056
      drm/i915/tgl: Add IS_TGL_REVID
      drm/i915/tgl: Include ro parts of l3 to invalidate
      drm/i915/tgl: Add HDC Pipeline Flush
      drm/i915/tgl: Add extra hdc flush workaround
      drm/i915/tgl: Keep FF dop clock enabled for A0
      drm/i915/tgl: Wa_1409420604
      drm/i915/tgl: Wa_1409170338
      drm/i915/tgl: Wa_1409600907
      drm/i915/tgl: Wa_1607138336
      drm/i915/tgl: Wa_1607030317, Wa_1607186500, Wa_1607297627
      drm/i915/tgl: Wa_1607138340
      drm/i915: Remove nonpriv flags when srm/lrm
      drm/i915/tgl: Add SFC instdone to error state
      drm/i915/tgl: Add gam instdone

Mikita Lipski (2):
      drm/amd/display: Rebuild mapped resources after pipe split
      drm/amd/display: Fix debugfs on MST connectors

Monk Liu (1):
      drm/amdgpu: fix an UMC hw arbitrator bug(v3)

Nathan Chancellor (1):
      drm/amd/display: Add a conversion function for transmitter and
phy_id enums

Navid Emamdoost (3):
      drm/amd/display: prevent memory leak
      drm/amdgpu: fix multiple memory leaks in acp_hw_init
      drm/amd/display: memory leak

Neil Armstrong (3):
      drm/meson: dw_hdmi: add resume/suspend hooks
      drm/meson: add resume/suspend hooks
      drm/meson: vclk: use the correct G12A frac max value

Neil Mayhew (1):
      drm/amdgpu: Show resolution correctly in mode validation debug output

Nicholas Kazlauskas (1):
      drm/amd/display: Free gamma after calculating legacy transfer functio=
n

Nickey Yang (1):
      drm/rockchip: vop: add the definition of dclk_pol

Nikola Cornij (4):
      drm/amd/display: Add back support for DSC 4:2:2 Simple
      drm/amd/display: config to override DSC start slice height
      drm/amd/display: Set number of pipes to 1 if the second pipe was disa=
bled
      drm/amd/display: Add output bitrate to DML calculations

Nirmoy Das (2):
      drm/amdgpu: fix memory leak
      drm/amdgpu: remove unused parameter in amdgpu_gfx_kiq_free_ring

Nishka Dasgupta (1):
      drm/tilcdc: plane: Make structure tilcdc_plane_funcs constant

Noah Abradjian (1):
      drm/amd/display: Make clk mgr the only dto update point

Oak Zeng (7):
      drm/amdgpu: Extends amdgpu vm definitions (v2)
      drm/amdgpu: Support new arcturus mtype
      drm/amdkfd: Fix MQD size calculation
      drm/amdkfd: Print more sdma engine hqds in debug fs
      drm/amdgpu: Clean up gmc_v9_0_gart_enable
      drm/amdgpu: Enable gfx cache probing on HDP write for arcturus
      drm/amdgpu: Add comments to gmc structure

Oleg Vasilev (1):
      drm/vkms: prime import support

Ondrej Jirman (1):
      drm: Remove redundant of_device_is_available check

Ori Messinger (1):
      drm/amdgpu: Report vram vendor with sysfs (v3)

Pan Bian (2):
      drm/amdgpu: fix potential double drop fence reference
      drm/amdgpu: fix double reference dropping

Paul Hsieh (1):
      drm/amd/display: audio endpoint cannot switch

Pelle van Gils (1):
      drm/amdgpu/powerplay/vega10: allow undervolting in p7

Pelloux-prayer, Pierre-eric (2):
      drm/amdgpu: call amdgpu_vm_prt_fini before deleting the root PD
      drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)

Peter Griffin (1):
      drm/lima: Add support for multiple reset lines

Philip Yang (3):
      drm/amdgpu: check if nbio->ras_if exist
      drm/amdgpu: user pages array memory leak fix
      drm/amdkfd: don't use dqm lock during device reset/suspend/resume

Prike Liang (16):
      drm/amd/powerplay: implement sysfs for getting dpm clock
      drm/amd/powerplay: Add the interface for geting dpm current power sta=
te
      drm/amd/amdgpu: power up sdma engine when S3 resume back
      drm/amd/powerplay: implement VCN power gating control interface
      drm/amd/powerplay: bypass dpm_context null pointer check guard
for some smu series
      drm/amd/powerplay: implement the interface for setting soft freq rang=
e
      drm/amd/powerplay: add interface for forcing and unforcing dpm limit =
value
      drm/amd/powerplay: add interface for getting workload type
      drm/amd/powerplay: add the interfaces for getting and setting
profiling dpm clock level
      drm/amd/powerplay: implement interface set_power_profile_mode() (v2)
      drm/amd/powerplay: implement the interface for setting sclk/uclk
profile_peak level
      drm/amd/powerplay: update the interface for getting dpm full
scale clock frequency
      drm/amdkfd: fix kgd2kfd_device_init() definition conflict error
      drm/amdgpu: add GFX_PIPELINE capacity check for updating gfx cgpg
      drm/amdgpu: fix S3 failed as RLC safe mode entry stucked in
polloing gfx acq
      drm/amdgpu/powerplay: implement interface pp_power_profile_mode

Qiang Yu (4):
      dma-buf/resv: fix exclusive fence get
      drm/lima: use drm_gem_shmem_helpers
      drm/lima: use drm_gem_(un)lock_reservations
      drm/lima: add __GFP_NOWARN flag to all dma_alloc_wc

Qingqing Zhuo (1):
      drm/amd/display: replace FIXME with TODO

Radhakrishna Sripada (1):
      drm/i915/tgl: Implement Wa_1409142259

Ramalingam C (6):
      drm/i915: mei_hdcp: I915 sends ddi index as per ME FW
      drm: Move port definition back to i915 header
      drm: Extend I915 mei interface for transcoder info
      misc/mei/hdcp: Fill transcoder index in port info
      drm/i915/hdcp: update current transcoder into intel_hdcp
      drm/i915/hdcp: Enable HDCP 1.4 and 2.2 on Gen12+

Raul E Rangel (2):
      drm/amd/display: fix struct init in update_bounding_box
      drm/amd/powerplay: fix struct init in renoir_print_clk_levels

Raymond Smith (1):
      drm/fourcc: Add Arm 16x16 block modifier

Reza Amini (1):
      drm/amd/display: Add center mode for integer scaling in DC

Rob Herring (6):
      MAINTAINERS: Add Steven and Alyssa as panfrost reviewers
      drm/panfrost: Fix possible suspend in panfrost_remove
      drm/shmem: Do dma_unmap_sg before purging pages
      drm/shmem: Use mutex_trylock in drm_gem_shmem_purge
      drm/panfrost: Use mutex_trylock in panfrost_gem_purge
      drm/gem: Fix mmap fake offset handling for drm_gem_object_funcs.mmap

Robert Chiras (1):
      drm/mxsfb: Update mxsfb to support a bridge

Robert M. Fosha (2):
      drm/i915/guc: Enable guc logging on guc log relay write
      drm/i915/guc: Update H2G enable logging action definition

Robin Singh (1):
      drm/amd/display: Added pixel dynamic expansion control.

Rodrigo Siqueira (3):
      drm: Add link training repeaters addresses
      drm/drm_vblank: Change EINVAL by the correct errno
      drm: Add LT-tunable PHY repeater mode operations

Roman Li (5):
      drm/amd/display: Add stereo mux and dig programming calls for dcn21
      drm/amd/display: disable ext aux support for vega
      drm/amd/display: Add debugfs entry for reading psr state
      drm/amd/display: Enable PSR
      drm/amdgpu/display: add dc feature mask for psr enablement

Ronald Tschal=C3=A4r (1):
      drm/bridge: sil_sii8620: make remote control optional.

Sam Bobroff (2):
      drm/radeon: fix bad DMA from INTERRUPT_CNTL2
      drm/amdgpu: fix bad DMA from INTERRUPT_CNTL2

Sam Ravnborg (2):
      drm_dp_cec: drop use of drmP.h
      drm: delete drmP.h + drm_os_linux.h

Sean Paul (20):
      drm: mst: Fix query_payload ack reply struct
      Documentation/gpu: Fix no structured comments warning for
drm_gem_ttm_helper.h
      drm: damage_helper: Fix race checking plane->state->fb
      Documentation: Fix warning in drm-kms-helpers.rst
      Revert "drm/omap: add OMAP_BO flags to affect buffer allocation"
      Merge drm/drm-next into drm-misc-next
      Revert "kselftests: Add dma-heap test"
      Revert "dma-buf: heaps: Add CMA heap to dmabuf heaps"
      Revert "dma-buf: heaps: Add system heap to dmabuf heaps"
      Revert "dma-buf: heaps: Add heap helpers"
      Revert "dma-buf: Add dma-buf heaps framework"
      drm/mediatek: Add RGB[A] variants to published plane formats
      drm/mediatek: Refactor plane init
      drm/mediatek: Add helper to get component for a plane
      drm/mediatek: Add plumbing for layer_check hook
      drm/mediatek: Plumb supported rotation values from components to
plane init
      drm/mediatek: Support reflect-y plane rotation
      drm/mediatek: Support reflect-x plane rotation
      drm/mediatek: Support 180 degree rotation
      drm/mst: Fix up u64 division

Sebastian Andrzej Siewior (4):
      drm/i915: Drop the IRQ-off asserts
      drm/i915: Don't disable interrupts for intel_engine_breadcrumbs_irq()
      drm/i810: Refer to `PREEMPTION' in comment
      drm/i915: Don't disable interrupts independently of the lock

Sharat Masetty (1):
      drm: msm: a6xx: fix debug bus register configuration

Shirish S (4):
      drm/amdgpu: fix build error without CONFIG_HSA_AMD
      drm/amdgpu: remove needless usage of #ifdef
      drm/amdgpu/psp: silence response status warning
      drm/amdgpu: dont schedule jobs while in reset

Simon Ser (1):
      drm: two planes with the same zpos have undefined ordering

Sivapiriyan Kumarasamy (1):
      drm/amd/display: fix bug with check for HPD Low in verify link cap

Srinivasan S (1):
      drm/i915/dp: Fix DP MST error after unplugging TypeC cable

Stanislav Lisovskiy (1):
      drm/i915: Add TigerLake bandwidth checking

Stephen Rothwell (4):
      drm/virtio: module_param_named() requires linux/moduleparam.h
      drm/amdkfd: update for drmP.h removal
      drm/sched: struct completion requires linux/completion.h inclusion
      merge fix for "ftrace: Rework event_create_dir()"

Steven Price (7):
      drm/panfrost: Add missing check for pfdev->regulator
      drm/panfrost: Remove NULL check for regulator
      drm/panfrost: Handle resetting on timeout better
      drm/panfrost: Remove commented out call to panfrost_core_dump
      drm: Don't free jobs in wait_event_interruptible()
      drm/panfrost: Use generic code for devfreq
      drm/panfrost: Simplify devfreq utilisation tracking

Stuart Summers (12):
      drm/i915: Use variable for debugfs device status
      drm/i915: Add function to set SSEU info per platform
      drm/i915: Add subslice stride runtime parameter
      drm/i915: Add EU stride runtime parameter
      drm/i915: Use local variables for subslice_mask for device info
      drm/i915: Add function to set subslices
      drm/i915: Use subslice stride to set subslices for a given slice
      drm/i915: Add function to determine if a slice has a subslice
      drm/i915: Refactor instdone loops on new subslice functions
      drm/i915: Add new function to copy subslices for a slice
      drm/i915: Expand subslice mask
      drm/i915: add new gen12 dgfx platform macro

Stylon Wang (1):
      drm/amd/display: Add debugfs entry to force YUV420 output

Sung Lee (3):
      drm/amd/display: Skip DIG Check if Link is Virtual for Display Count
      drm/amd/display: add dummy functions to smu for Renoir Silicon Diags
      drm/amd/display: Do not call update bounding box on dc create

Swati Sharma (15):
      drm/i915/display: Add debug log for color parameters
      drm/i915/display: Add func to get gamma bit precision
      drm/i915/display: Add func to compare hw/sw gamma lut
      drm/i915/display: Add macro to compare gamma hw/sw lut
      drm/i915/display: Extract i9xx_read_luts()
      drm/i915/display: Extract ilk_read_luts()
      drm/i915/display: Extract glk_read_luts()
      drm/i915/display: Add gamma precision function for CHV
      drm/i915/display: Extract i965_read_luts()
      drm/i915/display: Extract chv_read_luts()
      drm/i915/color: Fix formatting issues
      drm/i915/color: Extract icl_read_luts()
      Revert "drm/i915/color: Extract icl_read_luts()"
      drm/i915/color: fix broken gamma state-checker during boot
      drm/i915/color: move check of gamma_enable to specific func/platform

Tao Zhou (33):
      drm/amdgpu: change r type to int in gmc_v9_0_late_init
      drm/amdgpu: change ras bps type to eeprom table record structure
      drm/amdgpu: Hook EEPROM table to RAS
      drm/amdgpu: save umc error records
      drm/amdgpu: move the call of ras recovery_init and bad page
reserve to proper place
      drm/amdgpu: move umc late init from gmc to umc block
      drm/amdgpu: move umc ras init to umc block
      drm/amdgpu: rename umc ras_init to err_cnt_init
      drm/amdgpu: replace DRM_ERROR with DRM_WARN in ras_reserve_bad_pages
      drm/amdgpu: use GPU PAGE SHIFT for umc retired page
      drm/amdgpu: update parameter of ras_ih_cb
      drm/amdgpu: move umc ras irq functions to umc block
      drm/amdgpu: move gfx ecc functions to generic gfx file
      drm/amdgpu: move sdma ecc functions to generic sdma file
      drm/amdgpu: refine sdma4 ras_data_cb
      drm/amdgpu: move umc_ras_if from gmc to umc block
      drm/amdgpu: add common mmhub member for adev
      drm/amdgpu: replace mmhub_funcs with mmhub.funcs
      drm/amdgpu: move mmhub_ras_if from gmc to mmhub block
      drm/amdgpu: add common gmc_ras_fini function
      drm/amdgpu: add common gfx_ras_fini function
      drm/amdgpu: add common sdma_ras_fini function
      drm/amdgpu: remove ih_info parameter of umc_ras_late_init
      drm/amdgpu: remove ih_info parameter of gfx_ras_late_init
      drm/amdgpu: simplify the access to eeprom_control struct
      drm/amdgpu: add ras fini for nbio
      drm/amdgpu: add ras fini for xgmi
      drm/amdgpu: move umc ras fini to umc block
      drm/amdgpu: move mmhub ras fini to mmhub block
      drm/amdgpu: move xgmi ras fini to xgmi block
      drm/amdgpu: implement common gmc_ras_late_init
      drm/amdgpu: add comments in ras interrupt callback
      drm/amdgpu: avoid ras error injection for retired page

Tapani P=C3=A4lli (1):
      drm/i915/tgl: whitelist PS_(DEPTH|INVOCATION)_COUNT

Thierry Reding (80):
      drm/prime: Remove duplicate forward declaration
      drm/dp: Sort includes alphabetically
      drm/dp: Remove a gratuituous blank line
      drm/dp: Add drm_dp_fast_training_cap() helper
      drm/dp: Add drm_dp_channel_coding_supported() helper
      drm/dp: Add drm_dp_alternate_scrambler_reset_cap() helper
      drm/dp: Do not busy-loop during link training
      drm/dp: Add helper to get post-cursor adjustments
      drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers
      drm/bridge: tc358767: Avoid drm_dp_link helpers
      drm/bridge: tc358767: Use DP nomenclature
      drm/msm: edp: Avoid drm_dp_link helpers
      drm/rockchip: Avoid drm_dp_link helpers
      drm/tegra: Move drm_dp_link helpers to Tegra DRM
      drm/tegra: sor: Move register programming out of ->init()
      drm/tegra: Fix ordering of cleanup code
      gpu: host1x: Do not limit DMA segment size
      gpu: host1x: Remove gratuitous blank line
      gpu: host1x: Explicitly initialize host1x_info structures
      gpu: host1x: Request channels for clients, not devices
      drm/tegra: Inherit device DMA parameters from host1x
      drm/tegra: Use DRM_DEBUG_DRIVER for driver messages
      drm/tegra: vic: Skip stream ID programming without IOMMU
      drm/tegra: vic: Inherit DMA mask from host1x
      drm/tegra: vic: Use common IOMMU attach/detach code
      drm/tegra: Move IOMMU group into host1x client
      drm/tegra: gem: Rename paddr -> iova
      drm/tegra: gem: Use dma_get_sgtable()
      drm/tegra: gem: Always map SG tables for DMA-BUFs
      drm/tegra: gem: Use sg_alloc_table_from_pages()
      drm/tegra: dpaux: Support monitor hotplugging
      drm/tegra: dpaux: Retry on transfer size mismatch
      drm/tegra: dpaux: Fix crash if VDD supply is absent
      drm/tegra: dpaux: Parameterize CMH, DRVZ and DRVI
      drm/tegra: Add missing kerneldoc for struct drm_dp_link
      drm/tegra: dp: Add drm_dp_link_reset() implementation
      drm/tegra: dp: Track link capabilities alongside settings
      drm/tegra: dp: Turn link capabilities into booleans
      drm/tegra: dp: Probe link using existing parsing helpers
      drm/tegra: dp: Read fast training capability from link
      drm/tegra: dp: Read TPS3 capability from sink
      drm/tegra: dp: Read channel coding capability from sink
      drm/tegra: dp: Read alternate scrambler reset capability from sink
      drm/tegra: dp: Read eDP version from DPCD
      drm/tegra: dp: Read AUX read interval from DPCD
      drm/tegra: dp: Set channel coding on link configuration
      drm/tegra: dp: Enable alternate scrambler reset when supported
      drm/tegra: dp: Add drm_dp_link_choose() helper
      drm/tegra: dp: Add support for eDP link rates
      drm/tegra: dp: Add DisplayPort link training helper
      drm/tegra: sor: Use DP link training helpers
      drm/tegra: sor: Hook up I2C-over-AUX to output
      drm/tegra: sor: Stabilize eDP
      drm/tegra: sor: Filter eDP rates
      drm/tegra: sor: Add DisplayPort support
      drm/tegra: sor: Remove tegra186-sor1 support
      drm/tegra: sor: Use correct SOR index on Tegra210
      drm/tegra: sor: Implement pad clock for all SOR instances
      drm/tegra: sor: Deduplicate connector type detection code
      drm/tegra: sor: Support DisplayPort on Tegra194
      drm/tegra: sor: Unify clock setup for eDP, HDMI and DP
      drm/tegra: sor: Use correct I/O pad for DP
      drm/tegra: sor: Unify eDP and DP support
      drm/tegra: sor: Avoid timeouts on unplug events
      drm/tegra: sor: Extract common audio enabling code
      drm/tegra: sor: Introduce audio enable/disable callbacks
      drm/tegra: Do not use ->load() and ->unload() callbacks
      drm/tegra: Simplify IOMMU group selection
      gpu: host1x: Overhaul host1x_bo_{pin,unpin}() API
      gpu: host1x: Clean up debugfs on removal
      gpu: host1x: Add direction flags to relocations
      gpu: host1x: Allocate gather copy for host1x
      gpu: host1x: Support DMA mapping of buffers
      gpu: host1x: Set DMA mask based on IOMMU setup
      drm/tegra: Remove memory allocation from Falcon library
      drm/tegra: falcon: Clarify address usage
      drm/tegra: Support DMA API for display controllers
      drm/tegra: Optionally attach clients to the IOMMU
      gpu: host1x: Unconditionally select IOMMU_IOVA
      drm/tegra: Unconditionally select IOMMU_IOVA

Thomas Hellstrom (1):
      drm/ttm, drm/vmwgfx: Use a configuration option for the TTM dma page =
pool

Thomas Zimmermann (35):
      drm/vram: Add kmap ref-counting to GEM VRAM objects
      drm/vram: Acquire lock only once per call to vmap()/vunmap()
      drm/vram: Add infrastructure for move_notify()
      drm/vram: Implement lazy unmapping for GEM VRAM buffers
      drm/vram: Move VRAM memory manager to GEM VRAM implementation
      drm/vram: Have VRAM MM call GEM VRAM functions directly
      drm/vram: Unexport internal functions of VRAM MM
      drm/vram: Unconditonally set BO call-back functions
      drm/vram: Provide vmap and vunmap operations for GEM VRAM objects
      drm/ast: Use drm_gem_vram_{vmap,vunmap}() to map cursor source BO
      drm/mgag200: Use drm_gem_vram_{vmap, vunmap}() to map cursor source B=
O
      drm/vram: Support top-down placement flag
      drm/ast: Don't call ast_show_cursor() from ast_cursor_move()
      drm/ast: Move ast_{show,hide}_cursor() within source file
      drm/ast: Move cursor update code to ast_show_cursor()
      drm/ast: Move cursor offset swapping into ast_show_cursor()
      drm/ast: Allocate cursor BOs at high end of video memory
      drm/mgag200: Rename cursor functions to use mgag200_ prefix
      drm/mgag200: Add init and fini functions for cursor handling
      drm/mgag200: Add separate move-cursor function
      drm/mgag200: Move cursor-image update to mgag200_show_cursor()
      drm/mgag200: Move cursor BO swapping into mgag200_show_cursor()
      drm/mgag200: Reserve video memory for cursor plane
      drm/mgag200: Allocate cursor BOs at high end of video memory
      drm/vboxvideo: Switch to generic fbdev emulation
      drm/vboxvideo: Switch to drm_atomic_helper_dirty_fb()
      drm/vboxvideo: Replace struct vram_framebuffer with generic implemena=
tion
      drm: Add TODO item for fbdev driver conversion
      drm/cirrus: Remove obsolete header file
      drm/vram-helpers: Add helpers for prepare_fb() and cleanup_fb()
      drm/bochs: Replace prepare_fb()/cleanup_fb() with GEM VRAM helpers
      drm/hisilicon/hibmc: Use GEM VRAM's prepare_fb() and cleanup_fb() hel=
pers
      drm/vboxvideo: Replace prepare_fb()/cleanup_fb() with GEM VRAM helper=
s
      drm/fb-helper: Remove drm_fb_helper_defio_init() and update docs
      drm/todo: Clarify situation around fbdev and defio

Tianci.Yin (18):
      drm/amdgpu: add navi14 PCI ID for work station SKU
      drm/amdgpu: fix CPDMA hang in PRT mode for VEGA10
      drm/amdgpu: add navi12 pci id
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: add support for wks firmware loading
      drm/amdgpu: update amdgpu_discovery to handle revision
      drm/amdgpu: add a generic fb accessing helper function(v3)
      drm/amdgpu: introduce psp_v11_0_is_sos_alive interface(v2)
      drm/amdgpu: update atomfirmware header with memory training
related members(v3)
      drm/amdgpu/atomfirmware: add memory training related helper functions=
(v3)
      drm/amdgpu: add psp memory training callbacks and macro
      drm/amdgpu: reserve vram for memory training(v4)
      drm/amdgpu/psp: add psp memory training implementation(v3)
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings for navi12
      drm/amdgpu: add navi14 PCI ID

Tina Zhang (1):
      drm/i915/gvt: Stop initializing pvinfo through reading mmio

Tomi Valkeinen (12):
      drm/omap: drop unneeded locking from mgr_fld_write()
      drm/omap: avoid copy in mgr_fld_read/write
      drm/omap: fix missing scaler pixel fmt limitations
      drm/omap: hdmi5: automatically choose limited/full range output
      drm/omap: hdmi4: fix use of uninitialized var
      drm/omap: add omap_gem_unpin_locked()
      drm/omap: accept NULL for dma_addr in omap_gem_pin
      drm/omap: cleanup OMAP_BO flags
      drm/omap: remove OMAP_BO_TILED define
      drm/omap: cleanup OMAP_BO_SCANOUT use
      drm/omap: add omap_gem_validate_flags()
      drm/omap: add OMAP_BO flags to affect buffer allocation

Trek (1):
      drm/amdgpu: Check for valid number of registers to read

Tvrtko Ursulin (22):
      drm/i915: Move GT init to intel_gt.c
      drm/i915: Make wait_for_timelines take struct intel_gt
      drm/i915: Avoid round-trip via i915 in intel_gt_park
      drm/i915: Make pm_notify take intel_gt
      drm/i915/pmu: Skip busyness sampling when and where not needed
      drm/i915/pmu: Support multiple GPUs
      drm/i915: Make for_each_engine_masked work on intel_gt
      drm/i915: Pass in intel_gt at some for_each_engine sites
      drm/i915/pmu: Fix uninitialized variable on error path
      drm/i915: Pass intel_gt to intel_engines_init_mmio
      drm/i915: Pass intel_gt to intel_setup_engine_capabilities
      drm/i915: Pass intel_gt to intel_engines_cleanup
      drm/i915: Pass intel_gt to intel_engines_setup
      drm/i915: Pass intel_gt to intel_engines_init
      drm/i915: Pass intel_gt to intel_engines_verify_workarounds
      drm/i915: Split drop caches into GT and i915 parts
      drm/i915/selftests: Convert eviction selftests to gt/ggtt
      drm/i915/selftests: Use GT engines in mock_gem_device
      drm/i915/selftests: Use GT engines in igt_live_test
      drm/i915/selftests: Use for_each_uabi_engine in contex selftests
      drm/i915: Convert PAT setup to uncore mmio
      drm/i915: Move intel_engine_context_in/out into intel_lrc.c

Ulf Magnusson (1):
      drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Add helper macros for comparing with whitelisted regis=
ters

Vandita Kulkarni (2):
      drm/i915/tgl: Add dkl phy registers
      drm/i915/tgl: Add support for dkl pll write

Ville Syrj=C3=A4l=C3=A4 (107):
      drm/i915: Use enum pipe instead of crtc index to track active pipes
      drm/i915: Unconfuse pipe vs. crtc->index in i915_get_crtc_scanoutpos(=
)
      drm/i915: Use enum pipe consistently
      drm/i915: s/num_active_crtcs/num_active_pipes/
      drm/i915: Use hweight8() for 8bit masks
      drm/i915: Limit MST to <=3D 8bpc once again
      drm/i915: Prefer encoder->name over port_name()
      drm/i915: Clean up HDMI deep color handling a bit
      Revert "drm/i915: Fix DP-MST crtc_mask"
      drm/i915: add immutable zpos plane properties
      drm/i915: Use a high priority wq for nonblocking plane updates
      drm/i915: Remove pointless planes_changed=3Dtrue assignment
      drm/i915: Fix cdclk bypass freq readout for tgl/bxt/glk
      drm/i915: Fix CD2X pipe select masking during cdclk sanitation
      drm/i915: Reuse cnl_modeset_calc_cdclk() on icl+
      drm/i915: Remove duplicated bxt/cnl/icl .modeset_calc_cdclk() funcs
      drm/i915: Replace is_planar_yuv_format() with
drm_format_info_is_yuv_semiplanar()
      drm/i915: Allow downscale factor of <3.0 on glk+ for all formats
      drm/i915: Extract intel_modeset_calc_cdclk()
      drm/i915: s/pipe_config/crtc_state/ in intel_crtc_atomic_check()
      drm/i915: Bump skl+ max plane width to 5k for linear/x-tiled
      drm/i915: Don't advertise modes that exceed the max plane size
      drm: Add drm_modeset_lock_assert_held()
      drm/atomic-helper: Make crtc helper funcs optional
      drm/dp: Add definitons for MSA MISC bits
      drm/edid: Add CTA-861-G modes with VIC < 128
      video/hdmi: Fix AVI bar unpack
      drm/i915: Fix HSW+ DP MSA YCbCr colorspace indication
      drm/i915: Fix AVI infoframe quantization range for YCbCr output
      drm/i915: Extract intel_hdmi_limited_color_range()
      drm/i915: Never set limited_color_range=3Dtrue for YCbCr output
      drm/i915: Don't look at unrelated PIPECONF bits for interlaced readou=
t
      drm/i915: Simplify intel_get_crtc_ycbcr_config()
      drm/i915: Add PIPECONF YCbCr 4:4:4 programming for HSW
      drm/i915: Document ILK+ pipe csc matrix better
      drm/i915: Set up ILK/SNB csc unit properly for YCbCr output
      drm/i915: Add PIPECONF YCbCr 4:4:4 programming for ILK-IVB
      drm/fb-helper: Include prototype for drm_fb_helper_modinit()
      drm/dsc: Fix bogus cpu_to_be16() usage
      drm: Include prototype for drm_need_swiotlb()
      drm/syncobj: Include the prototype for drm_timeout_abs_to_jiffies()
      drm: Fix return type of crc .poll()
      drm/dp/mst: Reduce nested ifs
      drm/dp/mst: Handle arbitrary DP_LINK_BW values
      drm/dp/mst: Replace the fixed point thing with straight calculation
      drm/rect: Add drm_rect_translate_to()
      drm/rect: Add drm_rect_init()
      drm/i915: Limit MST modes based on plane size too
      drm/i915: Polish intel_tv_mode_valid()
      drm/i915: Fix g4x sprite scaling stride check with GTT remapping
      drm/i915: Populate possible_crtcs correctly
      drm/i915: Clean up encoder->crtc_mask setup
      drm/i915: Implement a better i945gm vblank irq vs. C-states workaroun=
d
      drm/amd/display: Use swap() where appropriate
      drm/amdgpu/powerplay: Use swap() where appropriate
      drm/atmel-hlcdc: Use swap() where appropriate
      drm/i915: Favor last VBT child device with conflicting AUX ch/DDC pin
      drm/i915: Switch to using DP_MSA_MISC_* defines
      drm/i915: Stop using drm_atomic_helper_check_planes()
      drm/i915: Make .modeset_calc_cdclk() mandatory
      drm/i915: Use drm_rect_translate_to()
      drm/i915: Use drm_rect_init()
      drm/i915: Refactor timestamping constants update
      drm/i915: Switch intel_legacy_cursor_update() to intel_ types
      drm/i915: Prepare the connector/encoder mask readout for hw vs.
uapi state split
      drm/i915: Prepare the mode readout for hw vs. uapi state split
      drm/i915: Fix MST oops due to MSA changes
      drm/i915: Move the cursor rotation handling into
intel_cursor_check_surface()
      drm/i915: Polish possible_clones setup
      drm/i915: Refuse modes with hdisplay=3D=3D4096 on pre-HSW DP
      drm/i915: Nuke the useless changed param from skl_ddb_add_affected_pi=
pes()
      drm/i915: Nuke 'realloc_pipes'
      drm/i915: Make dirty_pipes refer to pipes
      drm/i915: Shrink eDRAM ways/sets arrays
      drm/i915: s/hdcp2_hdmi_msg_data/hdcp2_hdmi_msg_timeout/
      drm/i915: Remove dead weight from hdcp2_msg_timeout[]
      drm/i915: Remove hdcp2_hdmi_msg_timeout.timeout2
      drm/i915: Make hdcp2_msg_timeout.timeout u16
      drm/edid: Make drm_get_cea_aspect_ratio() static
      drm/edid: Extract drm_mode_cea_vic()
      drm/edid: Fix HDMI VIC handling
      drm/i915: Check some transcoder timing minimum limits
      drm/edid: Add drm_hdmi_avi_infoframe_bars()
      drm/vc4: Use drm_hdmi_avi_infoframe_bars()
      drm/i915: Add debugs to distingiush a cd2x update from a full
cdclk pll update
      drm/i915: Rework global state locking
      drm/i915: Move check_digital_port_conflicts() earier
      drm/i915: Allow planes to declare their minimum acceptable cdclk
      drm/i915: Eliminate skl_check_pipe_max_pixel_rate()
      drm/i915: Simplify skl_max_scale()
      drm/i915: Add support for half float framebuffers for skl+
      drm/i915: Add support for half float framebuffers for gen4+ primary p=
lanes
      drm/i915: Add support for half float framebuffers for ivb+ sprites
      drm/i915: Add support for half float framebuffers on snb sprites
      drm/i915: Fix PCH reference clock for FDI on HSW/BDW
      drm/i915: Use _PICK() for CHICKEN_TRANS()
      drm/i915: Add CHICKEN_TRANS_D
      drm/i915: Fix i845/i865 cursor width
      drm/i915: Nuke 'mode' argument to intel_get_load_detect_pipe()
      drm/i915: Stop frobbing crtc->base.mode
      drm/i915: Simplify LVDS crtc_mask setup
      drm/i915: s/crtc_mask/pipe_mask/
      drm/i915: Allow ICL+ DSI on any pipe
      drm/i915: Simplify pipe_mask setup even further
      drm/i915/mst: Document the userspace fail with possible_crtcs
      drm/i915: Don't oops in dumb_create ioctl if we have no crtcs
      drm/i915: Preload LUTs if the hw isn't currently using them

Vitaly Prosyak (2):
      drm/amd/display: Reuse dcn2 registers
      drm/amd/display: add new active dongle to existent w/a

Vivek Kasireddy (2):
      drm/i915/ehl: Port C's hotplug interrupt is associated with TC1 bits
      drm/i915: Correct the PCH type in irq postinstall

Wambui Karuga (5):
      drm: remove unnecessary return variable
      drm/mediatek: remove cast to pointers passed to kfree
      drm/radeon: remove assignment for return value
      drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
      drm/amd: correct "_LENTH" mispelling in constant

Wayne Lin (5):
      drm/amd/display: Correct values in AVI infoframe
      drm/amd/display: add support for VSIP info packet
      drm/amd/display: build up VSIF infopacket
      drm/amd/display: correct stream LTE_340MCSC_SCRAMBLE value
      drm/amd/display: Avoid sending abnormal VSIF

Wen He (2):
      drm/arm/mali-dp: Add display QoS interface configuration for Mali DP5=
00
      dt/bindings: display: Add optional property node define for Mali DP50=
0

Wenjing Liu (1):
      drm/amd/display: skip enable stream on disconnected display

Wesley Chalmers (5):
      drm/amd/display: Replace for loop w/ function call
      drm/amd/display: Do not double-buffer DTO adjustments
      drm/amd/display: Revert fixup DPP programming sequence
      drm/amd/display: Optimize clocks on clock change
      drm/amd/display: Use dcn1 Optimal Taps Get

Wolfram Sang (1):
      gpu: drm: bridge: sii9234: convert to devm_i2c_new_dummy_device

Wyatt Wood (1):
      drm/amd/display: Add Logging for Gamma Related information

Xiaodong Yan (1):
      drm/amd/display: make aux defer delay and aux sw start delay seperate

Xiaojie Yuan (14):
      drm/amdgpu: fix null pointer deref in firmware header printing
      drm/amdgpu/discovery: get gpu info from ip discovery table
      drm/amdgpu/powerplay: add new mapping for APCC_DFLL feature
      drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet for pipe sync
      drm/amd/powerplay: add more feature bits
      drm/amdgpu/discovery: reserve discovery data at the top of VRAM
      drm/amd/powerplay: re-enable FW_DSTATE feature bit
      drm/amdgpu/psp11: wait for sOS ready for ring creation
      drm/amdgpu/psp11: fix typo in comment
      drm/amd/powerplay: print the pptable provider
      drm/amdgpu/gfx10: fix mqd backup/restore for gfx rings (v2)
      drm/amdgpu/gfx10: explicitly wait for cp idle after halt/unhalt
      drm/amdgpu/gfx10: fix out-of-bound mqd_backup array access
      drm/amdgpu/gfx10: re-init clear state buffer after gpu reset

Xiaolin Zhang (1):
      drm/i915: to make vgpu ppgtt notificaiton as atomic operation

Yakir Yang (1):
      drm: bridge/dw_hdmi: add audio sample channel status setting

Yannick Fertr=C3=A9 (2):
      drm/stm: ltdc: add pinctrl for DPI encoder mode
      drm/stm: dsi: higher pll out only in video burst mode

Yintian Tao (1):
      drm/amdgpu: put flush_delayed_work at first

Yogesh Mohan Marimuthu (1):
      drm/amd/display: map TRANSMITTER_UNIPHY_x to LINK_REGS_x

Yong Zhao (28):
      drm/amdkfd: Query kfd device info by CHIP id instead of pci device id
      drm/amdkfd: Fix a building error when KFD_SUPPORT_IOMMU_V2 is turned =
off
      drm/amdgpu: Add a kernel parameter for specifying the asic type
      drm/amdkfd: Support Navi14 in KFD
      drm/amdkfd: Delete unused KFD_IS_* macro
      drm/amdkfd: Add an error print if SDMA RLC is not idle
      drm/amdkfd: Remove excessive print when reserving doorbells
      drm/amdkfd: Remove unnecessary pm_init() for non HWS mode
      drm/amdkfd: Fix NULL pointer dereference for set_scratch_backing_va()
      drm/amdkfd: Sync gfx10 kfd2kgd_calls function pointers
      drm/amdkfd: Delete useless SDMA register setting on non HWS path
      drm/amdkfd: Use better name for sdma queue non HWS path
      drm/amdkfd: Move the control stack on GFX10 to userspace buffer
      drm/amdkfd: Delete unused defines
      drm/amdkfd: Use hex print format for pasid
      drm/amdkfd: Record vmid pasid mapping in the driver for non HWS mode
      drm/amdkfd: Query vmid pasid mapping through stored info for non HWS
      drm/amdkfd: Eliminate get_atc_vmid_pasid_mapping_valid
      drm/amdgpu: Export setup_vm_pt_regs() logic for gfxhub 2.0
      drm/amdkfd: Use setup_vm_pt_regs function from base driver in KFD
      drm/amdgpu: Delete useless header file reference
      drm/amdkfd: Delete unnecessary function declarations
      drm/amdkfd: Use array to probe kfd2kgd_calls
      drm/amdgpu: Add the HDP flush support for Navi
      drm/amdgpu: Export setup_vm_pt_regs() logic for mmhub 2.0
      drm/amdkfd: Improve KFD IOCTL printing
      drm/amdkfd: Delete unnecessary pr_fmt switch
      drm/amdkfd: Delete duplicated queue bit map reservation

Yongqiang Niu (18):
      dt-bindings: mediatek: add ovl_2l description for mt8183 display
      dt-bindings: mediatek: add ccorr description for mt8183 display
      dt-bindings: mediatek: add dither description for mt8183 display
      dt-bindings: mediatek: add mutex description for mt8183 display
      drm/mediatek: add ddp component CCORR
      drm/mediatek: add component DITHER
      drm/mediatek: add component OVL_2L0
      drm/mediatek: add component OVL_2L1
      drm/mediatek: add gmc_bits for ovl private data
      drm/medaitek: add layer_nr for ovl private data
      drm/mediatek: add function to background color input select for
ovl/ovl_2l direct link
      drm/mediatek: add background color input select function for ovl/ovl_=
2l
      drm/mediatek: distinguish ovl and ovl_2l by layer_nr
      drm/mediatek: add ovl0/ovl_2l0 usecase
      drm/mediatek: add mutex mod into ddp private data
      drm/mediatek: add mutex mod register offset into ddp private data
      drm/mediatek: add mutex sof into ddp private data
      drm/mediatek: add mutex sof register offset into ddp private data

Yongqiang Sun (2):
      drm/amd/display: Add unknown clk state.
      drm/amd/display: enable vm by default for rn.

YueHaibing (9):
      drm/amd/display: remove set but not used variable 'core_freesync'
      drm/amdgpu: remove duplicated include from mmhub_v1_0.c
      drm/vkms: Remove duplicated include from vkms_drv.c
      drm/qxl: Fix randbuild error
      drm/amd/display: Make dc_link_detect_helper static
      drm/amd/display: Make calculate_integer_scaling static
      drm/amd/powerplay: Make two functions static
      drm/amdgpu: remove set but not used variable 'adev'
      drm/vmwgfx: remove set but not used variable 'srf'

Zhan Liu (3):
      drm/amd/display: Add missing HBM support and raise Vega20's uclk.
      drm/amd/display: Add ENGINE_ID_DIGD condition check for Navi14
      Revert "drm/amd/display: setting the DIG_MODE to the correct value."

Zhan liu (2):
      drm/amd/display: setting the DIG_MODE to the correct value.
      drm/amd/display: Change Navi14's DWB flag to 1

Zhenyu Wang (1):
      drm/i915/gvt: fix dead locking in early workload shadow

abdoulaye berthe (2):
      drm/amd/display: update register field access mechanism
      drm/amd/display: configurable aux timeout support

changzhu (5):
      drm/amdgpu: add dummy read by engines for some GCVM status
registers in gfx10
      drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9
      drm/amdgpu: allow direct upload save restore list for raven2
      drm/amdgpu: initialize vm_inv_eng0_sem for gfxhub and mmhub
      drm/amdgpu: invalidate mmhub semaphore workaround in gmc9/gmc10

chen gong (9):
      drm/amd/powerplay: Add mode2 mode for GPU RESET in SMU
      drm/amd/powerplay: A workaround to GPU RESET on APU
      drm/amdgpu: Use mode2 mode to perform GPU RESET for Renoir
      drm/amdgpu: Do not implement power-on for SDMA after do mode2
reset on Renoir
      drm/amdgpu: No need to check gfxoff status after enable gfxoff featur=
e
      drm/amdgpu/psp: declare PSP TA firmware
      drm/amdgpu: Fix SDMA hang when performing VKexample test
      drm/amdgpu/powerplay: modify the parameters of SMU_MSG_PowerUpVcn to =
0
      drm/amd/powerplay: Disable gfx CGPG when suspend smu

joseph gravenor (1):
      drm/amd/display: fix header for RN clk mgr

shaoyunl (3):
      drm/amdkfd: Add NAVI12 support from kfd side
      drm/amdkfd: use navi12 specific family id for navi12 code path
      drm/amdgpu : enable msix for amdgpu driver

yu kuai (2):
      drm/amdgpu: remove excess function parameter description
      drm/amdgpu: remove set but not used variable 'pipe'

zhengbin (10):
      drm/amd/display: Make some functions static
      drm/amd/display: Make function wait_for_alt_mode static
      drm/amd/display: Remove set but not used variable 'source_bpp'
      drm/amd/display: Remove set but not used variables
'h_ratio_chroma', 'v_ratio_chroma'
      drm/amd/display: Remove set but not used variable 'pixel_width'
      drm/amd/display: Remove set but not used variables 'pp_smu', 'old_pip=
e'
      drm/omap: Remove set but not used variable 'plane'
      drm/omap: Remove set but not used variable 'tclk_trail'
      drm/omap: Remove set but not used variable 'err' in hdmi5_audio_confi=
g
      drm/omap: Remove set but not used variable 'err' in hdmi4_audio_confi=
g

zhong jiang (3):
      drm/amdgpu: remove the redundant null checks
      drm/vkms: Fix an undefined reference error in vkms_composer_worker
      drm/amd/display: remove redundant null pointer check before kfree

zhongshiqi (1):
      dc.c:use kzalloc without test

 .mailmap                                           |    4 +
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |    5 +
 .../devicetree/bindings/display/arm,malidp.txt     |    3 +
 .../devicetree/bindings/display/bridge/anx7814.txt |    6 +-
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |    1 +
 .../bindings/display/bridge/renesas,lvds.txt       |    1 +
 .../bindings/display/mediatek/mediatek,disp.txt    |   30 +-
 .../bindings/display/mediatek/mediatek,dsi.txt     |    4 +-
 .../devicetree/bindings/display/renesas,du.txt     |    2 +
 .../bindings/display/rockchip/rockchip-vop.txt     |    6 +-
 Documentation/driver-api/dma-buf.rst               |    6 +-
 Documentation/gpu/amdgpu.rst                       |   65 +-
 Documentation/gpu/drm-kms-helpers.rst              |    3 -
 Documentation/gpu/drm-mm.rst                       |   11 +-
 Documentation/gpu/i915.rst                         |   82 +-
 Documentation/gpu/mcde.rst                         |    2 +-
 Documentation/gpu/todo.rst                         |  135 +-
 Documentation/networking/tls-offload.rst           |    4 +
 MAINTAINERS                                        |   26 +-
 Makefile                                           |    2 +-
 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi      |    4 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    8 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   13 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 |    4 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |    1 +
 arch/arm/mach-sunxi/mc_smp.c                       |    6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts  |    2 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |    6 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |    6 +-
 .../arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi |    2 +-
 arch/arm64/include/asm/pgtable.h                   |   17 -
 arch/arm64/include/asm/vdso/vsyscall.h             |    7 -
 arch/mips/include/asm/vdso/vsyscall.h              |    7 -
 arch/powerpc/net/bpf_jit_comp64.c                  |   13 +
 arch/x86/kernel/apic/apic.c                        |   28 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c          |    4 +
 arch/x86/kernel/dumpstack_64.c                     |    7 +
 arch/x86/kernel/tsc.c                              |    3 +
 block/blk-cgroup.c                                 |   13 +-
 drivers/block/drbd/drbd_main.c                     |    1 -
 drivers/clk/at91/clk-main.c                        |    5 +-
 drivers/clk/at91/sam9x60.c                         |    1 +
 drivers/clk/at91/sckc.c                            |   20 +-
 drivers/clk/clk-ast2600.c                          |    7 +-
 drivers/clk/imx/clk-imx8mm.c                       |    2 +-
 drivers/clk/imx/clk-imx8mn.c                       |    2 +-
 drivers/clk/meson/g12a.c                           |   13 +-
 drivers/clk/meson/gxbb.c                           |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   27 +-
 drivers/clk/samsung/clk-exynos5433.c               |   14 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c               |    2 +-
 drivers/clk/sunxi/clk-sunxi.c                      |    4 +-
 drivers/clk/ti/clk-dra7-atl.c                      |    6 -
 drivers/clk/ti/clkctrl.c                           |    5 +-
 drivers/clocksource/sh_mtu2.c                      |   16 +-
 drivers/clocksource/timer-mediatek.c               |   10 +-
 drivers/cpufreq/intel_pstate.c                     |    4 +-
 drivers/dma-buf/dma-buf.c                          |  120 +-
 drivers/dma-buf/dma-fence.c                        |   78 +-
 drivers/gpio/gpio-merrifield.c                     |   33 +-
 drivers/gpu/drm/Kconfig                            |   36 +-
 drivers/gpu/drm/Makefile                           |    6 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  102 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   77 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   19 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  147 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  289 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |  214 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |  214 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  176 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   86 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |    5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |  274 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   79 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  313 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |  216 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h        |    5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  176 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   38 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  109 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   28 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   49 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   38 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c          |   70 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c           |   84 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |  101 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   71 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  497 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   87 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  659 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |   43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |  209 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |   99 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  230 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |  158 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h            |    5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  318 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |   28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |   52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   92 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |    2 +
 drivers/gpu/drm/amd/amdgpu/arct_reg_init.c         |    3 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   67 +-
 drivers/gpu/drm/amd/amdgpu/cik.h                   |    3 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   38 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   38 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   44 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   38 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |    5 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |    5 +
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  148 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 1411 +++++----
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    4 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |   24 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h           |    2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  157 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   25 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   27 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   30 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  474 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    5 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   23 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h            |    2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |   15 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |  380 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h              |   41 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    4 +-
 drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   17 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |  214 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h             |    1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  108 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |   44 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  258 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  161 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   21 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   11 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |    3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  188 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |    6 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_0.c              |   37 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_0.h              |   31 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |   48 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   23 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   37 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   41 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c       |    1 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   84 +-
 drivers/gpu/drm/amd/amdgpu/vi.h                    |    3 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |    8 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  139 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   19 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.c            |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  272 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  108 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |   12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c         |    5 +
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_module.c            |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   37 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   26 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   32 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   25 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    3 +
 drivers/gpu/drm/amd/display/Kconfig                |   28 +-
 drivers/gpu/drm/amd/display/Makefile               |    7 +
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |    4 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  383 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   14 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |    9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   52 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  346 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   66 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   17 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   59 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  153 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |    4 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |    7 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    8 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   25 +
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |   14 +-
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    4 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |   13 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |  186 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h   |    1 +
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  304 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h  |    4 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c        |   38 +-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h        |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  281 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  354 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  101 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   44 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   74 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   44 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   14 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   91 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   18 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   23 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   22 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |   93 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |  187 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |    3 -
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    8 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   52 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   44 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |   51 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   52 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   52 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   51 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |    5 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    8 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |   28 +
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   27 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |   50 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |    8 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.h   |    2 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |   60 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |    5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   43 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   62 +
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |    5 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |   57 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |    9 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h   |   89 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c   |    2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |    4 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |   12 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  640 +++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |   16 +
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |    7 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |    6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  354 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |   34 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |    4 +
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |    2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |  116 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h    |   34 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |  122 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h |   33 +
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.c  |  470 +++
 .../drm/amd/display/dc/dcn21/dcn21_link_encoder.h  |   61 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  380 ++-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |   49 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    5 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   12 +-
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |    8 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |    8 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   11 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |    3 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    5 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    1 +
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   85 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       |    3 -
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |    2 -
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |    2 -
 drivers/gpu/drm/amd/display/dc/hdcp/Makefile       |   28 +
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |  324 ++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    9 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |    6 +
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |    5 +
 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h |    3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   12 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   17 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h        |   12 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    5 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |   19 +-
 .../drm/amd/display/include/ddc_service_types.h    |    2 +
 drivers/gpu/drm/amd/display/include/hdcp_types.h   |   96 +
 .../drm/amd/display/modules/color/color_gamma.c    |   51 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   53 +-
 drivers/gpu/drm/amd/display/modules/hdcp/Makefile  |   32 +
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |  426 +++
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |  442 +++
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |  531 ++++
 .../amd/display/modules/hdcp/hdcp1_transition.c    |  307 ++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c    |  305 ++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    |  163 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.h    |  139 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  328 ++
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.h    |  272 ++
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |    1 +
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |  289 ++
 .../drm/amd/display/modules/inc/mod_info_packet.h  |    3 +
 .../amd/display/modules/info_packet/info_packet.c  |   98 +
 .../drm/amd/display/modules/power/power_helpers.c  |   93 +-
 .../drm/amd/display/modules/power/power_helpers.h  |    1 +
 drivers/gpu/drm/amd/include/amd_shared.h           |    2 +
 .../gpu/drm/amd/include/asic_reg/bif/bif_4_1_d.h   |    1 +
 .../drm/amd/include/asic_reg/bif/bif_4_1_sh_mask.h |    2 +
 .../gpu/drm/amd/include/asic_reg/bif/bif_5_0_d.h   |    1 +
 .../drm/amd/include/asic_reg/bif/bif_5_0_sh_mask.h |    2 +
 .../amd/include/asic_reg/dcn/dcn_2_1_0_offset.h    |   10 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_offset.h    |   18 +-
 .../drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h   |   18 +-
 .../drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h |   12 +
 .../amd/include/asic_reg/nbio/nbio_7_4_offset.h    |    4 +-
 .../amd/include/asic_reg/nbio/nbio_7_4_sh_mask.h   |   49 +-
 .../amd/include/asic_reg/oss/osssys_4_0_sh_mask.h  |    4 +
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_0_1_d.h |    1 +
 .../amd/include/asic_reg/smu/smu_7_0_1_sh_mask.h   |    2 +
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_d.h |    1 +
 .../amd/include/asic_reg/smu/smu_7_1_2_sh_mask.h   |    2 +
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_d.h |    1 +
 .../amd/include/asic_reg/smu/smu_7_1_3_sh_mask.h   |    2 +
 .../include/asic_reg/smuio/smuio_11_0_0_offset.h   |   92 +
 .../include/asic_reg/smuio/smuio_11_0_0_sh_mask.h  |  176 ++
 .../drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h  |   12 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   27 +-
 drivers/gpu/drm/amd/include/discovery.h            |    1 -
 .../amd/include/ivsrcid/nbio/irqsrcs_nbif_7_4.h    |   42 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   13 +-
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   10 +
 drivers/gpu/drm/amd/include/renoir_ip_offset.h     |   34 +
 drivers/gpu/drm/amd/include/vega10_enum.h          |    1 +
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   45 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 1190 +++++--
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  523 ++-
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.c      |  195 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.h      |   29 +
 drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.c  |   19 +
 drivers/gpu/drm/amd/powerplay/hwmgr/common_baco.h  |   13 +
 drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.c    |  196 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.h    |   29 +
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    9 +
 drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.c |  222 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.h |   29 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.c    |   91 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.h    |   32 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   40 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.c   |  231 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.h   |   29 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   68 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c  |   23 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   41 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  370 +--
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h |    3 +-
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    4 +
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h   |   51 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h      |    3 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |  134 +-
 .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h  |    2 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      |   41 +-
 drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h   |    3 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  551 +++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.h         |   11 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |  483 ++-
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |  204 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  370 +--
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |  153 +-
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |    2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |    2 -
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |    2 +-
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |    2 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |    4 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |  136 +-
 drivers/gpu/drm/arc/arcpgu_drv.c                   |   16 +-
 drivers/gpu/drm/arc/arcpgu_hdmi.c                  |    1 +
 drivers/gpu/drm/arm/display/Kconfig                |    6 +
 drivers/gpu/drm/arm/display/komeda/Makefile        |    2 +
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |  221 +-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |   41 +-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |    2 +
 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h  |    9 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  105 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |   77 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |   20 +
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |   30 +-
 drivers/gpu/drm/arm/display/komeda/komeda_event.c  |  140 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    2 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |    2 +
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |   17 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   76 +-
 .../drm/arm/display/komeda/komeda_wb_connector.c   |    5 +
 drivers/gpu/drm/arm/malidp_drv.c                   |   16 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |    9 +
 drivers/gpu/drm/arm/malidp_hw.h                    |    3 +
 drivers/gpu/drm/arm/malidp_regs.h                  |   10 +
 drivers/gpu/drm/ast/Kconfig                        |    2 +
 drivers/gpu/drm/ast/ast_drv.c                      |    6 +-
 drivers/gpu/drm/ast/ast_drv.h                      |   43 +-
 drivers/gpu/drm/ast/ast_main.c                     |    1 -
 drivers/gpu/drm/ast/ast_mode.c                     |  266 +-
 drivers/gpu/drm/ast/ast_ttm.c                      |    3 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |    3 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |    5 +-
 drivers/gpu/drm/bochs/Kconfig                      |    2 +
 drivers/gpu/drm/bochs/bochs.h                      |    1 -
 drivers/gpu/drm/bochs/bochs_drv.c                  |    7 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |   26 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |    3 +-
 drivers/gpu/drm/bridge/Kconfig                     |    3 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  110 +-
 drivers/gpu/drm/bridge/analogix-anx78xx.h          |   17 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    1 +
 drivers/gpu/drm/bridge/cdns-dsi.c                  |    3 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    1 +
 drivers/gpu/drm/bridge/lvds-encoder.c              |    3 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |    1 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |    1 +
 drivers/gpu/drm/bridge/panel.c                     |   70 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |    1 +
 drivers/gpu/drm/bridge/sii902x.c                   |    1 +
 drivers/gpu/drm/bridge/sii9234.c                   |   37 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   11 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c      |    4 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |   10 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  114 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h          |   39 +
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   10 +-
 drivers/gpu/drm/bridge/tc358764.c                  |    1 +
 drivers/gpu/drm/bridge/tc358767.c                  |   66 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    1 +
 drivers/gpu/drm/bridge/ti-tfp410.c                 |    1 +
 drivers/gpu/drm/cirrus/cirrus.c                    |    6 +-
 drivers/gpu/drm/cirrus/cirrus_drv.h                |  247 --
 drivers/gpu/drm/drm_atomic_helper.c                |   33 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |    2 +-
 drivers/gpu/drm/drm_blend.c                        |    7 +-
 drivers/gpu/drm/drm_cache.c                        |   14 +-
 drivers/gpu/drm/drm_client_modeset.c               |    3 +-
 drivers/gpu/drm/drm_connector.c                    |  142 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |   23 +-
 drivers/gpu/drm/drm_crtc_helper_internal.h         |    3 +
 drivers/gpu/drm/drm_damage_helper.c                |    8 +-
 drivers/gpu/drm/drm_debugfs_crc.c                  |    8 +-
 drivers/gpu/drm/drm_dp_cec.c                       |   29 +-
 drivers/gpu/drm/drm_dp_helper.c                    |  177 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 1807 ++++++++---
 drivers/gpu/drm/drm_dp_mst_topology_internal.h     |   24 +
 drivers/gpu/drm/drm_drv.c                          |   17 -
 drivers/gpu/drm/drm_dsc.c                          |   23 +-
 drivers/gpu/drm/drm_edid.c                         |  222 +-
 drivers/gpu/drm/drm_edid_load.c                    |    2 +-
 drivers/gpu/drm/drm_encoder.c                      |    1 +
 drivers/gpu/drm/drm_fb_helper.c                    |   62 +-
 drivers/gpu/drm/drm_gem.c                          |   40 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |   31 +-
 drivers/gpu/drm/drm_gem_ttm_helper.c               |   84 +
 drivers/gpu/drm/drm_gem_vram_helper.c              |  735 ++++-
 drivers/gpu/drm/drm_memory.c                       |    1 +
 drivers/gpu/drm/drm_mipi_dbi.c                     |   11 +-
 drivers/gpu/drm/drm_mm.c                           |   36 +-
 drivers/gpu/drm/drm_mode_config.c                  |    2 -
 drivers/gpu/drm/drm_of.c                           |    5 -
 drivers/gpu/drm/drm_panel.c                        |   14 +-
 drivers/gpu/drm/drm_prime.c                        |    9 +
 drivers/gpu/drm/drm_print.c                        |   60 +-
 drivers/gpu/drm/drm_probe_helper.c                 |    4 +-
 drivers/gpu/drm/drm_self_refresh_helper.c          |   18 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    3 +-
 drivers/gpu/drm/drm_syncobj.c                      |   38 +-
 drivers/gpu/drm/drm_trace.h                        |   14 +-
 drivers/gpu/drm/drm_vblank.c                       |   60 +-
 drivers/gpu/drm/drm_vram_helper_common.c           |    8 +-
 drivers/gpu/drm/drm_vram_mm_helper.c               |  297 --
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |    8 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    1 +
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    1 +
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |    1 +
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   32 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |    4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    1 +
 drivers/gpu/drm/gma500/cdv_intel_display.c         |    2 +
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |    2 +-
 drivers/gpu/drm/gma500/oaktrail_crtc.c             |    2 +
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |    3 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   14 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    6 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    3 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c       |    1 +
 drivers/gpu/drm/i2c/sil164_drv.c                   |    2 +-
 drivers/gpu/drm/i2c/tda9950.c                      |   12 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |   10 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    4 +-
 drivers/gpu/drm/i915/Kconfig                       |   18 +-
 drivers/gpu/drm/i915/Kconfig.debug                 |  144 +-
 drivers/gpu/drm/i915/Kconfig.profile               |   49 +
 drivers/gpu/drm/i915/Kconfig.unstable              |   29 +
 drivers/gpu/drm/i915/Makefile                      |   25 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |    2 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |   69 +-
 drivers/gpu/drm/i915/display/intel_atomic.h        |    5 +
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   58 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |    4 +
 drivers/gpu/drm/i915/display/intel_audio.c         |   46 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |    8 +-
 drivers/gpu/drm/i915/display/intel_bios.h          |    3 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |   81 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         | 1316 ++++----
 drivers/gpu/drm/i915/display/intel_cdclk.h         |   13 +-
 drivers/gpu/drm/i915/display/intel_color.c         |  611 +++-
 drivers/gpu/drm/i915/display/intel_color.h         |    7 +
 drivers/gpu/drm/i915/display/intel_connector.c     |   21 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |   13 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  839 +++--
 drivers/gpu/drm/i915/display/intel_ddi.h           |    3 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 2409 ++++++++------
 drivers/gpu/drm/i915/display/intel_display.h       |   66 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |  554 ++--
 drivers/gpu/drm/i915/display/intel_display_power.h |   43 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   64 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  521 ++-
 drivers/gpu/drm/i915/display/intel_dp.h            |    9 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   75 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |  412 ++-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |    5 +
 drivers/gpu/drm/i915/display/intel_dsb.c           |  332 ++
 drivers/gpu/drm/i915/display/intel_dsb.h           |   52 +
 drivers/gpu/drm/i915/display/intel_dsi.c           |    3 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |    4 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |    7 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |   23 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |   19 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |    2 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  216 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |    4 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  303 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |    1 +
 drivers/gpu/drm/i915/display/intel_hotplug.c       |    3 +-
 drivers/gpu/drm/i915/display/intel_hotplug.h       |    1 +
 drivers/gpu/drm/i915/display/intel_lpe_audio.c     |    2 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |   10 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   32 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  441 ++-
 drivers/gpu/drm/i915/display/intel_psr.h           |    1 -
 drivers/gpu/drm/i915/display/intel_sdvo.c          |    2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.h          |    1 +
 drivers/gpu/drm/i915/display/intel_sprite.c        |  549 +++-
 drivers/gpu/drm/i915/display/intel_sprite.h        |    8 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |   87 +-
 drivers/gpu/drm/i915/display/intel_tc.h            |    1 +
 drivers/gpu/drm/i915/display/intel_tv.c            |   12 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |   55 +
 drivers/gpu/drm/i915/display/intel_vdsc.c          |   74 +-
 drivers/gpu/drm/i915/display/intel_vga.c           |  160 +
 drivers/gpu/drm/i915/display/intel_vga.h           |   18 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |    8 +-
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |    9 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |  614 ++--
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |   61 +-
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |   22 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    3 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |   56 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   89 +-
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |   20 +-
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c           |   99 +
 drivers/gpu/drm/i915/gem/i915_gem_lmem.h           |   37 +
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |   84 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   38 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   52 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |   13 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   34 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   48 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    5 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |  165 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.h             |    3 -
 drivers/gpu/drm/i915/gem/i915_gem_region.c         |  174 +
 drivers/gpu/drm/i915/gem/i915_gem_region.h         |   29 +
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |   82 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |  124 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |  130 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.h         |    3 +-
 drivers/gpu/drm/i915/gem/i915_gem_throttle.c       |    4 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |   42 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   55 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.c   |    3 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |  579 +++-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |   30 +-
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |  214 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |  704 +++--
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  306 +-
 .../drm/i915/gem/selftests/i915_gem_object_blt.c   |  354 ++-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c |    2 -
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |   33 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h |   13 +-
 drivers/gpu/drm/i915/gem/selftests/mock_context.c  |   17 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |   19 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |   25 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |    1 +
 drivers/gpu/drm/i915/gt/intel_context_types.h      |    1 +
 drivers/gpu/drm/i915/gt/intel_engine.h             |  231 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  246 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |  234 ++
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.h   |   23 +
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |   28 +-
 drivers/gpu/drm/i915/gt/intel_engine_pool.c        |   15 +-
 drivers/gpu/drm/i915/gt/intel_engine_pool.h        |    4 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   91 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |   18 +-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |   37 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |  160 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |   16 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |    5 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |  209 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |   16 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |  137 +
 drivers/gpu/drm/i915/gt/intel_gt_requests.h        |   24 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |   36 +-
 drivers/gpu/drm/i915/gt/intel_hangcheck.c          |  360 ---
 drivers/gpu/drm/i915/gt/intel_llc.c                |  161 +
 drivers/gpu/drm/i915/gt/intel_llc.h                |   15 +
 drivers/gpu/drm/i915/gt/intel_llc_types.h          |   13 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 1500 ++++++---
 drivers/gpu/drm/i915/gt/intel_lrc.h                |   39 +-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |   66 +-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  277 +-
 drivers/gpu/drm/i915/gt/intel_mocs.h               |    3 -
 drivers/gpu/drm/i915/gt/intel_rc6.c                |  787 +++++
 drivers/gpu/drm/i915/gt/intel_rc6.h                |   28 +
 drivers/gpu/drm/i915/gt/intel_rc6_types.h          |   29 +
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |    1 +
 drivers/gpu/drm/i915/gt/intel_reset.c              |  172 +-
 drivers/gpu/drm/i915/gt/intel_reset.h              |   14 +-
 drivers/gpu/drm/i915/gt/intel_reset_types.h        |    6 +
 drivers/gpu/drm/i915/gt/intel_ring.c               |  323 ++
 drivers/gpu/drm/i915/gt/intel_ring.h               |  131 +
 ...{intel_ringbuffer.c =3D> intel_ring_submission.c} |  404 +--
 drivers/gpu/drm/i915/gt/intel_ring_types.h         |   51 +
 drivers/gpu/drm/i915/gt/intel_rps.c                | 1872 +++++++++++
 drivers/gpu/drm/i915/gt/intel_rps.h                |   38 +
 drivers/gpu/drm/i915/gt/intel_rps_types.h          |   93 +
 drivers/gpu/drm/i915/gt/intel_sseu.c               |   37 +-
 drivers/gpu/drm/i915/gt/intel_sseu.h               |   37 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   52 +-
 drivers/gpu/drm/i915/gt/intel_timeline_types.h     |   10 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   67 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |    7 +
 drivers/gpu/drm/i915/gt/selftest_context.c         |   71 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |  350 +++
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |    2 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |   60 +
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |  207 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c             |   80 +
 drivers/gpu/drm/i915/gt/selftest_llc.h             |   14 +
 drivers/gpu/drm/i915/gt/selftest_lrc.c             | 1943 ++++++++++--
 drivers/gpu/drm/i915/gt/selftest_reset.c           |   16 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |  138 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |  270 +-
 drivers/gpu/drm/i915/gt/selftests/mock_timeline.c  |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |  185 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |    2 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_fwif.h        |    2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c         |   56 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.h         |    4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_reg.h         |    3 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  q|   21 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |   41 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |   15 -
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |   38 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   76 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw_abi.h       |   11 +-
 drivers/gpu/drm/i915/gt/uc/selftest_guc.c          |   46 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |   14 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |    2 +
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |    3 +-
 drivers/gpu/drm/i915/gvt/execlist.c                |    4 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   23 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |   17 -
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    1 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |   48 +-
 drivers/gpu/drm/i915/i915_active.c                 |  389 ++-
 drivers/gpu/drm/i915/i915_active.h                 |  330 +-
 drivers/gpu/drm/i915/i915_active_types.h           |   34 +-
 drivers/gpu/drm/i915/i915_buddy.c                  |    1 +
 drivers/gpu/drm/i915/i915_debugfs.c                |  522 ++-
 drivers/gpu/drm/i915/i915_drv.c                    |  291 +-
 drivers/gpu/drm/i915/i915_drv.h                    |  622 +---
 drivers/gpu/drm/i915/i915_gem.c                    |  406 +--
 drivers/gpu/drm/i915/i915_gem.h                    |   16 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |   58 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |  104 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.h          |    7 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  413 +--
 drivers/gpu/drm/i915/i915_gem_gtt.h                |   77 +-
 drivers/gpu/drm/i915/i915_getparam.c               |    8 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |  150 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |    8 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  839 ++---
 drivers/gpu/drm/i915/i915_irq.h                    |   16 +-
 drivers/gpu/drm/i915/i915_params.c                 |   12 +-
 drivers/gpu/drm/i915/i915_params.h                 |    5 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   80 +-
 drivers/gpu/drm/i915/i915_perf.c                   | 1860 +++++++----
 drivers/gpu/drm/i915/i915_perf.h                   |   32 +-
 drivers/gpu/drm/i915/i915_perf_types.h             |  435 +++
 drivers/gpu/drm/i915/i915_pmu.c                    |  313 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |    8 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |    7 +
 drivers/gpu/drm/i915/i915_query.c                  |  306 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  876 ++++--
 drivers/gpu/drm/i915/i915_request.c                |  235 +-
 drivers/gpu/drm/i915/i915_request.h                |   40 +-
 drivers/gpu/drm/i915/i915_scatterlist.h            |    8 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |   55 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |   18 -
 drivers/gpu/drm/i915/i915_scheduler_types.h        |    9 +
 drivers/gpu/drm/i915/i915_suspend.c                |   11 +-
 drivers/gpu/drm/i915/i915_switcheroo.c             |   67 +
 drivers/gpu/drm/i915/i915_switcheroo.h             |   14 +
 drivers/gpu/drm/i915/i915_sysfs.c                  |  162 +-
 drivers/gpu/drm/i915/i915_trace.h                  |   40 +-
 drivers/gpu/drm/i915/i915_utils.c                  |   43 +-
 drivers/gpu/drm/i915/i915_utils.h                  |   34 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  639 ++--
 drivers/gpu/drm/i915/i915_vma.h                    |  134 +-
 drivers/gpu/drm/i915/intel_csr.c                   |    4 +-
 drivers/gpu/drm/i915/intel_device_info.c           |  230 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    8 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |  272 ++
 drivers/gpu/drm/i915/intel_memory_region.h         |  129 +
 drivers/gpu/drm/i915/intel_pch.c                   |   14 +-
 drivers/gpu/drm/i915/intel_pch.h                   |    6 +-
 drivers/gpu/drm/i915/intel_pm.c                    | 3317 ++--------------=
----
 drivers/gpu/drm/i915/intel_pm.h                    |   30 -
 drivers/gpu/drm/i915/intel_region_lmem.c           |  132 +
 drivers/gpu/drm/i915/intel_region_lmem.h           |   16 +
 drivers/gpu/drm/i915/intel_runtime_pm.c            |    1 -
 drivers/gpu/drm/i915/intel_uncore.c                |   94 +-
 drivers/gpu/drm/i915/intel_uncore.h                |   20 +-
 drivers/gpu/drm/i915/oa/i915_oa_tgl.c              |  121 +
 drivers/gpu/drm/i915/oa/i915_oa_tgl.h              |   16 +
 drivers/gpu/drm/i915/selftests/i915_active.c       |   90 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |    4 +
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   46 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |  143 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |  404 ++-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |    5 +
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |    1 +
 drivers/gpu/drm/i915/selftests/i915_perf.c         |  217 ++
 drivers/gpu/drm/i915/selftests/i915_random.c       |   20 +
 drivers/gpu/drm/i915/selftests/i915_random.h       |    4 +
 drivers/gpu/drm/i915/selftests/i915_request.c      |  502 +--
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |   23 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   19 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.c    |   33 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.h    |    2 +-
 drivers/gpu/drm/i915/selftests/igt_live_test.c     |   19 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c         |    4 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |    2 +-
 .../gpu/drm/i915/selftests/intel_memory_region.c   |  624 ++++
 drivers/gpu/drm/i915/selftests/intel_uncore.c      |   56 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   53 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |    8 +-
 drivers/gpu/drm/i915/selftests/mock_region.c       |   60 +
 drivers/gpu/drm/i915/selftests/mock_region.h       |   16 +
 drivers/gpu/drm/i915/selftests/mock_uncore.c       |    5 +-
 drivers/gpu/drm/i915/selftests/mock_uncore.h       |    3 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |    1 +
 drivers/gpu/drm/imx/parallel-display.c             |    1 +
 drivers/gpu/drm/ingenic/ingenic-drm.c              |    5 +-
 drivers/gpu/drm/lima/Kconfig                       |    1 +
 drivers/gpu/drm/lima/Makefile                      |    4 +-
 drivers/gpu/drm/lima/lima_device.c                 |    5 +-
 drivers/gpu/drm/lima/lima_drv.c                    |   22 +-
 drivers/gpu/drm/lima/lima_gem.c                    |  195 +-
 drivers/gpu/drm/lima/lima_gem.h                    |   32 +-
 drivers/gpu/drm/lima/lima_gem_prime.c              |   46 -
 drivers/gpu/drm/lima/lima_gem_prime.h              |   13 -
 drivers/gpu/drm/lima/lima_mmu.c                    |    1 -
 drivers/gpu/drm/lima/lima_object.c                 |  119 -
 drivers/gpu/drm/lima/lima_object.h                 |   35 -
 drivers/gpu/drm/lima/lima_sched.c                  |    6 +-
 drivers/gpu/drm/lima/lima_vm.c                     |   87 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |    3 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    4 +-
 drivers/gpu/drm/mediatek/Makefile                  |    2 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  111 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    1 +
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  136 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h            |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             |  128 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   67 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   43 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    3 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |    4 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |   24 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.h           |    4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  234 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    1 +
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c             |  338 +-
 drivers/gpu/drm/mediatek/mtk_mipi_tx.h             |   49 +
 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c      |  288 ++
 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c      |  149 +
 drivers/gpu/drm/meson/meson_drv.c                  |   32 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  115 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |    9 +-
 drivers/gpu/drm/mgag200/Kconfig                    |    2 +
 drivers/gpu/drm/mgag200/mgag200_cursor.c           |  327 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    7 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |   23 +-
 drivers/gpu/drm/mgag200/mgag200_main.c             |   20 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   17 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |    7 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |   24 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |    4 +-
 drivers/gpu/drm/msm/dsi/dsi.h                      |    1 +
 drivers/gpu/drm/msm/edp/edp.c                      |    4 +-
 drivers/gpu/drm/msm/edp/edp.h                      |    1 +
 drivers/gpu/drm/msm/edp/edp_ctrl.c                 |   70 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |    2 +
 drivers/gpu/drm/msm/msm_debugfs.c                  |    6 +-
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |   20 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |   46 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |    4 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |   26 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |    2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   40 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   43 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |   19 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    1 +
 drivers/gpu/drm/omapdrm/dss/Makefile               |    2 +-
 drivers/gpu/drm/omapdrm/dss/core.c                 |   55 -
 drivers/gpu/drm/omapdrm/dss/dispc.c                |   46 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |    3 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |   37 +
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c           |    9 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c           |  129 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |    1 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.h           |    2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    1 +
 drivers/gpu/drm/omapdrm/omap_encoder.c             |    1 +
 drivers/gpu/drm/omapdrm/omap_fb.c                  |    9 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |  137 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |    2 +-
 drivers/gpu/drm/panel/panel-arm-versatile.c        |    5 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |    5 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |    5 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |    5 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |    5 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |    5 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |    5 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |    5 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |    5 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |   26 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |    5 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |    5 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |    5 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |    5 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |    5 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |    5 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |    4 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |    5 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |    5 +-
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |    5 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |    5 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |    5 +-
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |    5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |    5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |    5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |    5 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |    5 +-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |    5 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c    |    5 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |    5 +-
 drivers/gpu/drm/panel/panel-simple.c               |   29 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |    5 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |    4 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |    5 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |    5 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |    5 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |    5 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |    5 +-
 drivers/gpu/drm/panfrost/TODO                      |    2 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  124 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |    3 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |   14 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |    2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |    2 +-
 drivers/gpu/drm/panfrost/panfrost_issues.h         |   81 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |   17 +-
 drivers/gpu/drm/pl111/pl111_display.c              |    4 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |    4 +-
 drivers/gpu/drm/qxl/Kconfig                        |    1 +
 drivers/gpu/drm/qxl/qxl_drv.c                      |   20 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    4 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |   32 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |   11 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |   62 +-
 drivers/gpu/drm/radeon/cik.c                       |   12 +-
 drivers/gpu/drm/radeon/r600.c                      |    4 +-
 drivers/gpu/drm/radeon/radeon_audio.c              |    4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   27 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |   24 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |   11 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |    2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    1 +
 drivers/gpu/drm/radeon/si.c                        |    4 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   30 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    5 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |    6 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   29 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |   12 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |    3 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |   19 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |    2 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |    8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |    2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  169 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   10 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |    4 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   48 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |   12 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |    4 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   66 +-
 drivers/gpu/drm/selftests/Makefile                 |    2 +-
 drivers/gpu/drm/selftests/drm_modeset_selftests.h  |    2 +
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c |  238 ++
 drivers/gpu/drm/selftests/test-drm_framebuffer.c   |    2 +-
 drivers/gpu/drm/selftests/test-drm_mm.c            |   14 +-
 .../gpu/drm/selftests/test-drm_modeset_common.h    |    2 +
 drivers/gpu/drm/sti/sti_cursor.c                   |    2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |    3 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |    2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |    3 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |   26 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |   10 +-
 drivers/gpu/drm/sti/sti_vtg.c                      |    2 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    5 +-
 drivers/gpu/drm/stm/ltdc.c                         |   39 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    6 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |    1 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |    1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    1 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   35 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |    1 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |    2 +
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |    1 +
 drivers/gpu/drm/tegra/Kconfig                      |    2 +-
 drivers/gpu/drm/tegra/Makefile                     |    1 +
 drivers/gpu/drm/tegra/dc.c                         |   30 +-
 drivers/gpu/drm/tegra/dc.h                         |    2 -
 drivers/gpu/drm/tegra/dp.c                         |  876 ++++++
 drivers/gpu/drm/tegra/dp.h                         |  177 ++
 drivers/gpu/drm/tegra/dpaux.c                      |  208 +-
 drivers/gpu/drm/tegra/drm.c                        |  417 +--
 drivers/gpu/drm/tegra/drm.h                        |   13 +-
 drivers/gpu/drm/tegra/falcon.c                     |   64 +-
 drivers/gpu/drm/tegra/falcon.h                     |   16 +-
 drivers/gpu/drm/tegra/fb.c                         |    4 +-
 drivers/gpu/drm/tegra/gem.c                        |   81 +-
 drivers/gpu/drm/tegra/gem.h                        |    2 +-
 drivers/gpu/drm/tegra/gr2d.c                       |   12 +-
 drivers/gpu/drm/tegra/gr3d.c                       |   12 +-
 drivers/gpu/drm/tegra/hub.c                        |    6 +-
 drivers/gpu/drm/tegra/output.c                     |   28 +-
 drivers/gpu/drm/tegra/plane.c                      |  104 +
 drivers/gpu/drm/tegra/plane.h                      |    8 +
 drivers/gpu/drm/tegra/sor.c                        | 2576 ++++++++-------
 drivers/gpu/drm/tegra/sor.h                        |    3 +
 drivers/gpu/drm/tegra/vic.c                        |  138 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    5 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |    2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |    2 +-
 drivers/gpu/drm/ttm/Makefile                       |    4 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |    2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |  190 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   27 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |   69 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |   57 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |    2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |    4 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c           |    7 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |    4 +-
 drivers/gpu/drm/udl/udl_connector.c                |    8 -
 drivers/gpu/drm/v3d/v3d_bo.c                       |    2 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |    5 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |   55 +-
 drivers/gpu/drm/vboxvideo/Kconfig                  |    2 +
 drivers/gpu/drm/vboxvideo/Makefile                 |    2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |   19 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.h               |   27 -
 drivers/gpu/drm/vboxvideo/vbox_fb.c                |  149 -
 drivers/gpu/drm/vboxvideo/vbox_main.c              |  119 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  138 +-
 drivers/gpu/drm/vboxvideo/vbox_ttm.c               |    3 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |    3 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    5 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   18 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |    2 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    4 +-
 drivers/gpu/drm/virtio/Kconfig                     |    2 +-
 drivers/gpu/drm/virtio/Makefile                    |    2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   22 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |  135 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    4 +
 drivers/gpu/drm/virtio/virtgpu_gem.c               |  183 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |  228 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |   24 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |  270 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   61 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |   34 -
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |  305 --
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  227 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    9 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |   15 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    6 +
 drivers/gpu/drm/vkms/vkms_gem.c                    |   27 +
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |    3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |    2 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |    7 +-
 drivers/gpu/host1x/Kconfig                         |    2 +-
 drivers/gpu/host1x/bus.c                           |    2 +-
 drivers/gpu/host1x/cdma.c                          |    6 +-
 drivers/gpu/host1x/channel.c                       |   13 +-
 drivers/gpu/host1x/channel.h                       |    1 +
 drivers/gpu/host1x/dev.c                           |  236 +-
 drivers/gpu/host1x/dev.h                           |    3 +
 drivers/gpu/host1x/intr.c                          |    1 -
 drivers/gpu/host1x/job.c                           |   91 +-
 drivers/gpu/host1x/job.h                           |    4 +
 drivers/hid/i2c-hid/i2c-hid-core.c                 |    4 +
 drivers/hid/wacom.h                                |   15 +
 drivers/hid/wacom_wac.c                            |   10 +-
 drivers/hwtracing/intel_th/gth.c                   |    3 +
 drivers/hwtracing/intel_th/msu.c                   |   11 +-
 drivers/hwtracing/intel_th/pci.c                   |   10 +
 drivers/iio/adc/stm32-adc.c                        |    4 +-
 drivers/iio/imu/adis16480.c                        |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    9 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   15 +-
 drivers/iio/proximity/srf04.c                      |   29 +-
 drivers/interconnect/core.c                        |    4 +
 drivers/interconnect/qcom/qcs404.c                 |    3 +-
 drivers/interconnect/qcom/sdm845.c                 |    3 +-
 drivers/media/cec/cec-notifier.c                   |    5 +-
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c   |    6 +-
 drivers/media/platform/meson/ao-cec-g12a.c         |    4 +-
 drivers/media/platform/meson/ao-cec.c              |    4 +-
 drivers/media/platform/s5p-cec/s5p_cec.c           |    4 +-
 drivers/media/platform/seco-cec/seco-cec.c         |    4 +-
 drivers/media/platform/sti/cec/stih-cec.c          |    4 +-
 drivers/media/platform/tegra-cec/tegra_cec.c       |    4 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |   45 +-
 drivers/misc/mei/hdcp/mei_hdcp.h                   |   17 +-
 drivers/net/bonding/bond_main.c                    |   44 +-
 drivers/net/can/c_can/c_can.c                      |   71 +-
 drivers/net/can/c_can/c_can.h                      |    1 +
 drivers/net/can/dev.c                              |    1 +
 drivers/net/can/flexcan.c                          |   11 +-
 drivers/net/can/rx-offload.c                       |  102 +-
 drivers/net/can/spi/mcp251x.c                      |    2 +-
 drivers/net/can/ti_hecc.c                          |  232 +-
 drivers/net/can/usb/gs_usb.c                       |    1 +
 drivers/net/can/usb/mcba_usb.c                     |    3 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c            |   32 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    2 +-
 drivers/net/can/usb/usb_8dev.c                     |    3 +-
 drivers/net/can/xilinx_can.c                       |    1 -
 drivers/net/dsa/bcm_sf2.c                          |    4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   35 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  145 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |    2 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |    1 -
 drivers/net/ethernet/hisilicon/hns/hnae.h          |    3 -
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   22 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.h |    2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   18 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |    2 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   10 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |    4 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |    4 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   10 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    2 +-
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |    3 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |    1 +
 .../ethernet/mellanox/mlx5/core/steering/dr_rule.c |    2 +
 drivers/net/ethernet/mscc/ocelot.c                 |    9 +-
 drivers/net/ethernet/mscc/ocelot.h                 |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   12 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |    3 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |    3 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    4 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |    6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   70 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  134 +-
 drivers/net/usb/cdc_ncm.c                          |    6 +-
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/nfc/fdp/i2c.c                              |    2 +-
 drivers/nfc/st21nfca/core.c                        |    1 +
 drivers/nvme/host/multipath.c                      |    2 +
 drivers/nvme/host/rdma.c                           |    8 +
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   26 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   21 +-
 drivers/pinctrl/pinctrl-stmfx.c                    |   14 -
 drivers/pwm/pwm-bcm-iproc.c                        |    1 +
 drivers/reset/core.c                               |    5 +-
 drivers/soc/imx/gpc.c                              |    8 +-
 drivers/soundwire/Kconfig                          |    1 +
 drivers/soundwire/intel.c                          |    4 +-
 drivers/soundwire/slave.c                          |    3 +-
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/vboxsf/Kconfig                     |   10 +
 drivers/staging/vboxsf/Makefile                    |    5 +
 drivers/staging/vboxsf/TODO                        |    7 +
 drivers/staging/vboxsf/dir.c                       |  418 +++
 drivers/staging/vboxsf/file.c                      |  370 +++
 drivers/staging/vboxsf/shfl_hostintf.h             |  901 ++++++
 drivers/staging/vboxsf/super.c                     |  501 +++
 drivers/staging/vboxsf/utils.c                     |  551 ++++
 drivers/staging/vboxsf/vboxsf_wrappers.c           |  371 +++
 drivers/staging/vboxsf/vfsmod.h                    |  137 +
 drivers/thunderbolt/nhi_ops.c                      |    1 -
 drivers/thunderbolt/switch.c                       |   28 +-
 drivers/video/fbdev/c2p_core.h                     |    8 +-
 drivers/video/fbdev/core/fbmem.c                   |   17 +-
 drivers/video/fbdev/sa1100fb.c                     |   13 -
 drivers/video/hdmi.c                               |    8 +-
 drivers/watchdog/bd70528_wdt.c                     |    1 +
 drivers/watchdog/cpwd.c                            |    8 +-
 drivers/watchdog/imx_sc_wdt.c                      |    8 +-
 drivers/watchdog/meson_gxbb_wdt.c                  |    4 +-
 drivers/watchdog/pm8916_wdt.c                      |   15 +-
 fs/btrfs/inode.c                                   |   15 +-
 fs/btrfs/ioctl.c                                   |    6 -
 fs/btrfs/space-info.c                              |   21 +
 fs/btrfs/tree-checker.c                            |    8 -
 fs/btrfs/volumes.c                                 |    1 +
 fs/ceph/caps.c                                     |   10 +-
 fs/ceph/dir.c                                      |   15 +-
 fs/ceph/file.c                                     |   15 +-
 fs/ceph/inode.c                                    |    1 +
 fs/ceph/super.c                                    |   11 +-
 fs/cifs/smb2pdu.h                                  |    1 +
 fs/configfs/symlink.c                              |    2 +-
 fs/fs-writeback.c                                  |    9 +-
 fs/ocfs2/file.c                                    |  134 +-
 include/asm-generic/vdso/vsyscall.h                |    7 -
 include/drm/amd_asic_type.h                        |   56 +-
 include/drm/bridge/dw_hdmi.h                       |    2 +
 include/drm/drmP.h                                 |  103 -
 include/drm/drm_bridge.h                           |   33 +-
 include/drm/drm_connector.h                        |   25 +-
 include/drm/drm_crtc.h                             |    1 -
 include/drm/drm_dp_helper.h                        |  140 +-
 include/drm/drm_dp_mst_helper.h                    |  172 +-
 include/drm/drm_drv.h                              |    2 -
 include/drm/drm_edid.h                             |    5 +-
 include/drm/drm_encoder.h                          |    6 +-
 include/drm/drm_fb_helper.h                        |    7 +-
 include/drm/drm_gem.h                              |   15 +
 include/drm/drm_gem_shmem_helper.h                 |   43 +-
 include/drm/drm_gem_ttm_helper.h                   |   21 +
 include/drm/drm_gem_vram_helper.h                  |  107 +-
 include/drm/drm_mm.h                               |    7 +-
 include/drm/drm_modeset_helper_vtables.h           |    7 +-
 include/drm/drm_modeset_lock.h                     |    9 +
 include/drm/drm_os_linux.h                         |   55 -
 include/drm/drm_panel.h                            |   13 +-
 include/drm/drm_plane.h                            |   31 +-
 include/drm/drm_prime.h                            |    2 -
 include/drm/drm_print.h                            |   26 +
 include/drm/drm_rect.h                             |   31 +
 include/drm/drm_self_refresh_helper.h              |    3 +-
 include/drm/drm_simple_kms_helper.h                |    2 +-
 include/drm/drm_vblank.h                           |   15 +-
 include/drm/drm_vram_mm_helper.h                   |  104 -
 include/drm/gpu_scheduler.h                        |    3 +
 include/drm/i915_drm.h                             |   18 -
 include/drm/i915_mei_hdcp_interface.h              |   42 +-
 include/drm/ttm/ttm_bo_api.h                       |   66 +-
 include/drm/ttm/ttm_bo_driver.h                    |   32 +-
 include/drm/ttm/ttm_execbuf_util.h                 |    2 +-
 include/drm/ttm/ttm_memory.h                       |    1 -
 include/drm/ttm/ttm_page_alloc.h                   |    2 +-
 include/linux/bpf.h                                |    4 +-
 include/linux/device_cgroup.h                      |   19 +-
 include/linux/dma-buf.h                            |   63 +-
 include/linux/fb.h                                 |    2 +-
 include/linux/host1x.h                             |   26 +-
 include/linux/idr.h                                |    2 +-
 include/linux/mm.h                                 |    5 -
 include/linux/mm_types.h                           |    5 +
 include/linux/page-flags.h                         |   20 +-
 include/linux/radix-tree.h                         |   18 -
 include/linux/reset-controller.h                   |    4 +-
 include/linux/reset.h                              |    2 +-
 include/linux/skmsg.h                              |    9 +-
 include/media/cec-notifier.h                       |    7 +-
 include/net/bonding.h                              |    3 +-
 include/net/fq_impl.h                              |    4 +-
 include/net/neighbour.h                            |    4 +-
 include/net/netfilter/nf_tables.h                  |    3 +-
 include/net/sch_generic.h                          |    4 +
 include/net/sock.h                                 |    4 +-
 include/net/tls.h                                  |    5 +
 include/uapi/drm/amdgpu_drm.h                      |    2 +
 include/uapi/drm/drm.h                             |    3 +-
 include/uapi/drm/drm_fourcc.h                      |   28 +-
 include/uapi/drm/exynos_drm.h                      |    2 +-
 include/uapi/drm/i915_drm.h                        |  128 +-
 include/uapi/drm/omap_drm.h                        |   18 +-
 include/uapi/drm/v3d_drm.h                         |    8 +-
 include/uapi/linux/can.h                           |    2 +-
 include/uapi/linux/can/bcm.h                       |    2 +-
 include/uapi/linux/can/error.h                     |    2 +-
 include/uapi/linux/can/gw.h                        |    2 +-
 include/uapi/linux/can/j1939.h                     |    2 +-
 include/uapi/linux/can/netlink.h                   |    2 +-
 include/uapi/linux/can/raw.h                       |    2 +-
 include/uapi/linux/can/vxcan.h                     |    2 +-
 include/uapi/linux/nvme_ioctl.h                    |    1 +
 include/uapi/linux/sched.h                         |    4 +
 kernel/bpf/cgroup.c                                |    4 +-
 kernel/bpf/syscall.c                               |    7 +-
 kernel/fork.c                                      |   33 +-
 kernel/irq/irqdomain.c                             |    2 +-
 kernel/sched/core.c                                |   23 +-
 kernel/sched/deadline.c                            |   40 +-
 kernel/sched/fair.c                                |   15 +-
 kernel/sched/idle.c                                |    9 +-
 kernel/sched/rt.c                                  |   37 +-
 kernel/sched/sched.h                               |   30 +-
 kernel/sched/stop_task.c                           |   18 +-
 kernel/stacktrace.c                                |    6 +-
 kernel/time/vsyscall.c                             |    9 +-
 lib/Kconfig                                        |    1 -
 lib/dump_stack.c                                   |    7 +-
 lib/idr.c                                          |   31 +-
 lib/radix-tree.c                                   |    2 +-
 lib/test_xarray.c                                  |   24 +
 lib/xarray.c                                       |    4 +
 mm/khugepaged.c                                    |    7 +-
 mm/memcontrol.c                                    |   23 +-
 mm/memory_hotplug.c                                |    8 +
 mm/mmu_notifier.c                                  |    2 +-
 mm/page_alloc.c                                    |   17 +-
 mm/slab.h                                          |    4 +-
 mm/vmstat.c                                        |   25 +-
 net/bridge/netfilter/ebt_dnat.c                    |   19 +-
 net/can/j1939/socket.c                             |    9 +-
 net/can/j1939/transport.c                          |   20 +-
 net/core/skmsg.c                                   |   20 +-
 net/dccp/ipv4.c                                    |    2 +-
 net/ipv4/fib_semantics.c                           |    2 +-
 net/ipv6/route.c                                   |   13 +-
 net/mac80211/main.c                                |    2 +-
 net/mac80211/sta_info.c                            |    3 +-
 net/netfilter/ipset/ip_set_core.c                  |   49 +-
 net/netfilter/ipset/ip_set_hash_ipmac.c            |    2 +-
 net/netfilter/ipset/ip_set_hash_net.c              |    1 +
 net/netfilter/ipset/ip_set_hash_netnet.c           |    1 +
 net/netfilter/nf_tables_api.c                      |    7 +-
 net/netfilter/nf_tables_offload.c                  |    3 +-
 net/netfilter/nft_bitwise.c                        |    5 +-
 net/netfilter/nft_cmp.c                            |    2 +-
 net/nfc/netlink.c                                  |    2 -
 net/sched/cls_api.c                                |   83 +-
 net/sched/sch_taprio.c                             |    5 +-
 net/smc/smc_pnet.c                                 |    2 -
 net/tls/tls_device.c                               |   10 +-
 net/tls/tls_main.c                                 |    2 +
 net/tls/tls_sw.c                                   |   30 +-
 net/vmw_vsock/virtio_transport_common.c            |    8 +-
 samples/bpf/Makefile                               |    1 +
 scripts/gdb/linux/symbols.py                       |    3 +-
 scripts/nsdeps                                     |    6 +-
 security/device_cgroup.c                           |   15 +-
 sound/core/compress_offload.c                      |    2 +-
 sound/core/timer.c                                 |    6 +-
 sound/firewire/bebob/bebob_focusrite.c             |    3 +
 sound/pci/hda/patch_ca0132.c                       |    2 +-
 sound/pci/hda/patch_hdmi.c                         |   13 +
 sound/soc/codecs/hdac_hda.c                        |    2 +-
 sound/soc/codecs/hdmi-codec.c                      |   12 +-
 sound/soc/codecs/max98373.c                        |    4 +-
 sound/soc/codecs/msm8916-wcd-analog.c              |    4 +-
 sound/soc/kirkwood/kirkwood-i2s.c                  |   11 +-
 sound/soc/rockchip/rockchip_max98090.c             |    7 +-
 sound/soc/sh/rcar/dma.c                            |    4 +-
 sound/soc/sof/debug.c                              |    6 +-
 sound/soc/sof/intel/hda-stream.c                   |    4 +-
 sound/soc/sof/ipc.c                                |    4 +-
 sound/soc/sof/topology.c                           |   11 +-
 sound/soc/stm/stm32_sai_sub.c                      |   12 +-
 sound/soc/ti/sdma-pcm.c                            |    2 +-
 tools/gpio/Makefile                                |    6 +-
 tools/perf/perf-sys.h                              |    6 +-
 tools/perf/util/hist.c                             |    2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    8 +-
 .../util/scripting-engines/trace-event-python.c    |    9 +-
 tools/perf/util/trace-event-parse.c                |   31 -
 tools/perf/util/trace-event.h                      |    2 -
 tools/testing/selftests/bpf/test_sysctl.c          |    8 +-
 tools/testing/selftests/net/tls.c                  |  108 +
 tools/testing/selftests/vm/gup_benchmark.c         |    2 +-
 1395 files changed, 66952 insertions(+), 31015 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_0.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder=
.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hdcp/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/include/hdcp_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_executio=
n.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transiti=
on.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/nbio/irqsrcs_nbif_7=
_4.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/ci_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/fiji_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/polaris_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smu_internal.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_event.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_drv.h
 create mode 100644 drivers/gpu/drm/drm_dp_mst_topology_internal.h
 create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c
 delete mode 100644 drivers/gpu/drm/drm_vram_mm_helper.c
 create mode 100644 drivers/gpu/drm/i915/Kconfig.unstable
 create mode 100644 drivers/gpu/drm/i915/display/intel_dsb.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dsb.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_vga.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_vga.h
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_lmem.c
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_lmem.h
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_region.c
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_region.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_requests.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_requests.h
 delete mode 100644 drivers/gpu/drm/i915/gt/intel_hangcheck.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_llc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_llc.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_llc_types.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rc6.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rc6.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rc6_types.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_ring.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_ring.h
 rename drivers/gpu/drm/i915/gt/{intel_ringbuffer.c =3D>
intel_ring_submission.c} (85%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_ring_types.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rps.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rps.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_rps_types.h
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_gt_pm.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_llc.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_llc.h
 create mode 100644 drivers/gpu/drm/i915/i915_perf_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_switcheroo.c
 create mode 100644 drivers/gpu/drm/i915/i915_switcheroo.h
 create mode 100644 drivers/gpu/drm/i915/intel_memory_region.c
 create mode 100644 drivers/gpu/drm/i915/intel_memory_region.h
 create mode 100644 drivers/gpu/drm/i915/intel_region_lmem.c
 create mode 100644 drivers/gpu/drm/i915/intel_region_lmem.h
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_tgl.c
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_tgl.h
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_perf.c
 create mode 100644 drivers/gpu/drm/i915/selftests/intel_memory_region.c
 create mode 100644 drivers/gpu/drm/i915/selftests/mock_region.c
 create mode 100644 drivers/gpu/drm/i915/selftests/mock_region.h
 delete mode 100644 drivers/gpu/drm/lima/lima_gem_prime.c
 delete mode 100644 drivers/gpu/drm/lima/lima_gem_prime.h
 delete mode 100644 drivers/gpu/drm/lima/lima_object.c
 delete mode 100644 drivers/gpu/drm/lima/lima_object.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/core.c
 create mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
 create mode 100644 drivers/gpu/drm/tegra/dp.c
 create mode 100644 drivers/gpu/drm/tegra/dp.h
 delete mode 100644 drivers/gpu/drm/vboxvideo/vbox_fb.c
 delete mode 100644 drivers/gpu/drm/virtio/virtgpu_ttm.c
 create mode 100644 drivers/staging/vboxsf/Kconfig
 create mode 100644 drivers/staging/vboxsf/Makefile
 create mode 100644 drivers/staging/vboxsf/TODO
 create mode 100644 drivers/staging/vboxsf/dir.c
 create mode 100644 drivers/staging/vboxsf/file.c
 create mode 100644 drivers/staging/vboxsf/shfl_hostintf.h
 create mode 100644 drivers/staging/vboxsf/super.c
 create mode 100644 drivers/staging/vboxsf/utils.c
 create mode 100644 drivers/staging/vboxsf/vboxsf_wrappers.c
 create mode 100644 drivers/staging/vboxsf/vfsmod.h
 delete mode 100644 include/drm/drmP.h
 create mode 100644 include/drm/drm_gem_ttm_helper.h
 delete mode 100644 include/drm/drm_os_linux.h
 delete mode 100644 include/drm/drm_vram_mm_helper.h
