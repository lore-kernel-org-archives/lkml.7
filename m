Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAFBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6AB2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0Kp1Ydb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEID21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:28:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36093 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEID20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:28:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so967227qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZaSg4X+n7cnv1EYeXWp4ZJxuEx4ROgYJigi6tJOLQeg=;
        b=h0Kp1YdbiG9NsK+uTE8K8RVxoIs2+l3DhXxi5Ef/BTGX1MKARM8TD2q6EWbmY2FpuN
         tp9NdMCbKHnG1f8661lVOl3bslAqnHvBjH7UmiwPO38NFjwXMYAorcM1wk4f3vp7NVKv
         EQ7Ts52I4j0Y5oce8/w/UyMiohU1VAMSTxh0mthW5hVhPZLMJBC23MvdZqAyf34lR1p4
         FygqGYPfqkN+oXU5Zxd46cJQ8bUWqTWikvXG/qX9RzQ8hzkjkLGVUURM0FNvpmAi/b3w
         2XYB9c4nwN2QHqxVvJ6S9DvwxAjZaZbLdisMn/fISIMrV9ePPKlY0UZqbwQBpaYqQtBD
         HLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ZaSg4X+n7cnv1EYeXWp4ZJxuEx4ROgYJigi6tJOLQeg=;
        b=Ytb0eyIKy3ut8uYbhAVs+OXWIPlhnORzxwMX8BWpzg/CeMvsbzUWJXDqqbcWf1ZtNT
         jfBm2JRFYfrYjn52yUmpg6O/PkKoDPkoBNor7xwOxn/NJyEat78hlaaOHUP1T7XMxQL6
         WSuwB80JwKYd3WPuWQDowGfEf/EQc/ws6nDbV/LzaJYUKpHgJ1rg+tsrZbFMrHNU1F2V
         hHlY6cr04Sdfa+hnMVdTjrTBYNFvoeWGEjvDTO94E1RIJqCy8hh7SxxsbvdoMiJHvJjT
         f0+CxhwKKrRHQVQ8hMZyKk1Mm1C/eoWnBVMBu5938RyN1IDjR8bhMvPBK4OuhKcNlJad
         3w9g==
X-Gm-Message-State: APjAAAVIsG5D1XocdpbkqtVlmV/S+ZYAkjOg/0oyrACZsmnAF+p+HPoF
        qQdquWSa3MPVXVATxE8BN4QFSQjuwuJ3a5Z2GWk=
X-Google-Smtp-Source: APXvYqyAmIPJjNDcW0BmlX5fAjspv4ka2St9jkSk2Q1OH+wIxxWcPudP6MfIdsa/acRna9huT14Rvj5PYBTRuFFuYT0=
X-Received: by 2002:ac8:2556:: with SMTP id 22mr1521671qtn.356.1557372499760;
 Wed, 08 May 2019 20:28:19 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 9 May 2019 13:28:07 +1000
Message-ID: <CAPM=9tyFp5LZ6QO1TaDK5jSb5+2SCe3Rjmk0_juVfr-zfspBLg@mail.gmail.com>
Subject: [git pull] drm for 5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the main drm pull request for 5.2.

This has two exciting community drivers for ARM Mali accelerators.
Since ARM has never been open source friendly on the GPU side of the
house, the community has had to create open source drivers for the
Mali GPUs. Lima covers the older t4xx and panfrost the newer 6xx/7xx
series. Well done to all involved and hopefully this will help ARM
head in the right direction.

There is also now the ability if you don't have any of the legacy
drivers enabled (pre-KMS) to remove all the pre-KMS support code from
the core drm, this saves 10% or so in codesize on my machine.

i915 also enable Icelake/Elkhart Lake Gen11 GPUs by default, vboxvideo
moves out of staging.

There are also some rcar-du patches which crossover with media tree
but all should be acked by Mauro.

Dave.

uapi changes:
- Colorspace connector property
- fourcc - new YUV formts
- timeline sync objects initially merged
- expose FB_DAMAGE_CLIPS to atomic userspace

New drivers:
vboxvideo: moved out of staging
aspeed: ASPEED SoC BMC chip display support
lima: ARM Mali4xx GPU acceleration driver support
panfrost: ARM Mali6xx/7xx Midgard/Bitfrost acceleration driver support

core:
- component helper docs
- unplugging fixes
- devm device init
- MIPI/DSI rate control
- shmem backed gem objects
- connector, display_info, edid_quirks cleanups
- dma_buf fence chain support
- 64-bit dma-fence seqno comparison fixes
- move initial fb config code to core
- gem fence array helpers for Lima
- ability to remove legacy support code if no drivers requires it
(removes 10% of drm.ko size)
- lease fixes

ttm:
- unified DRM_FILE_PAGE_OFFSET handling
- Account for kernel allocations in kernel zone only

panel:
- OSD070T1718-19TS panel support
- panel-tpo-td028ttec1 backlight support
- Ronbo RB070D30 MIPI/DSI
- Feiyang FY07024DI26A30-D MIPI-DSI panel
- Rocktech jh057n00900 MIPI-DSI panel

i915:
- Comet Lake (Gen9) PCI IDs
- Updated Icelake PCI IDs
- Elkhartlake (Gen11) support
- DP MST property addtions
- plane and watermark fixes
- Icelake port sync and VEBOX disable fixes
- struct_mutex usage reduction
- Icelake gamma fix
- GuC reset fixes
- make mmap more asynchronous
- sound display power well race fixes
- DDI/MIPI-DSI clocks for Icelake
- Icelake RPS frequency changing support
- Icelake workarounds

amdgpu:
- Use HMM for userptr
- vega20 experimental smu11 support
- RAS support for vega20
- BACO support for vega12 + fixes for vega20
- reworked IH interrupt handling
- amdkfd RAS support
- Freesync improvements
- initial timeline sync object support
- DC Z ordering fixes
- NV12 planes support
- colorspace properties for planes=3D
- eDP opts if eDP already initialized

nouveau:
- misc fixes

etnaviv:
- misc fixes

msm:
- GPU zap shader support expansion
- robustness ABI addition

exynos:
- Logging cleanups

tegra:
- Shared reset fix
- CPU cache maintenance fix

cirrus:
- driver rewritten using simple helpers

meson:
- G12A support

vmwgfx:
- Resource dirtying management improvements
- Userspace logging improvements

virtio:
- PRIME fixes

rockchip:
- rk3066 hdmi support

sun4i:
- DSI burst mode support

vc4:
- load tracker to detect underflow

v3d:
- v3d v4.2 support

malidp:
- initial Mali D71 support in komeda driver

tfp410:
- omap related improvement

omapdrm:
- drm bridge/panel support
- drop some omap specific panels

rcar-du:
- Display writeback support

drm-next-2019-05-09:
drm pull request for 5.2
The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2=
:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-05-09

for you to fetch changes up to eb85d03e01c3e9f3b0ba7282b2e3515a635decb2:

  Merge tag 'drm-misc-next-fixes-2019-05-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-05-09
11:04:00 +1000)

----------------------------------------------------------------
drm pull request for 5.2

----------------------------------------------------------------
Abdiel Janulgue (1):
      drm/i915/query: Split out query item checks

Aditya Swarup (3):
      drm/i915: Make combo PHY DDI macro definitions consistent for ICL and=
 CNL
      drm/i915: Make MG PHY macros semantically consistent
      drm/i915/icl: Fix CRC mismatch error for DP link layer compliance

Aidan Wood (1):
      drm/amd/display: Fix multi-thread writing to 1 state

Alex Deucher (12):
      drm/amdgpu/powerplay: add BACO support for vega12
      drm/amdgpu/powerplay: split out common smu9 BACO code
      drm/amdgpu: use BACO on vega12 if platform supports it
      drm/amdgpu/display: fix build when DCN KCONFIG is not set
      Revert "drm/amdgpu: more descriptive message if HMM not enabled"
      Revert "drm/amdgpu: support userptr cross VMAs case with HMM"
      Revert "drm/amdkfd: support concurrent userptr update for HMM"
      Revert "drm/amdgpu: fix HMM config dependency issue"
      Revert "drm/amdgpu: replace get_user_pages with HMM mirror helpers"
      Revert "drm/amdkfd: avoid HMM change cause circular lock"
      Revert "drm/amdgpu: use HMM callback to replace mmu notifier"
      drm/amdgpu/smu11: fix warning on 32bit arches

Amber Lin (1):
      drm/amdgpu: get_fw_version isn't ASIC specific

Andreas Kemnade (2):
      drm/omap: panel-tpo-td028ttec1: add backlight support
      dt-bindings: panel: td028ttec1: add backlight property

Andres Rodriguez (1):
      drm: add non-desktop quirk for Valve HMDs

Andrey Grodzovsky (5):
      drm/v3d: Fix calling drm_sched_resubmit_jobs for same sched.
      drm/amdgpu: Add sysfs entries  for xgmi hive v2.
      drm/amdgpu: Move IB pool init and fini v2
      drm/amdgpu: Change VRAM lost print from ERR to INF
      drm/amd/display: Use a reasonable timeout for framebuffer fence waits

Andy Shevchenko (3):
      drm/tinydrm: Trivia typo fix
      drm/selftests/mm: Switch to bitmap_zalloc()
      drm/i915: Switch to bitmap_zalloc()

Anthony Koo (11):
      drm/amd/display: make seamless boot work generically
      drm/amd/display: Fix exception from AUX acquire failure
      drm/amd/display: Keep clocks high before seamless boot done
      drm/amd/display: Fix soft hang issue when some DPCD data invalid
      drm/amd/display: init dc_config before rest of DC init
      drm/amd/display: disable link before changing link settings
      drm/amd/display: Add switch for Fractional PWM on or off
      drm/amd/display: Read eDP link settings on detection
      drm/amd/display: Allow system to enter stutter on init
      drm/amd/display: Send DMCU messages only if FW loaded
      drm/amd/display: Fix eDP Black screen after S4 resume

Anusha Srivatsa (3):
      drm/i915/cml: Add CML PCI IDS
      drm/i915/cml: Introduce Comet Lake PCH
      drm/i915/ehl: Add Support for DMC on EHL

Aric Cyr (9):
      drm/amd/display: 3.2.20
      drm/amd/display: 3.2.21
      drm/amd/display: Add a hysteresis to BTR frame multiplier
      drm/amd/display: 3.2.22
      drm/amd/display: 3.2.23
      drm/amd/display: 3.2.24
      drm/amd/display: 3.2.25
      drm/amd/display: 3.2.26
      drm/amd/display: 3.2.27

Arnd Bergmann (1):
      drm/stm: fix CONFIG_FB dependency

Ayan Kumar Halder (9):
      drm: Added a new format DRM_FORMAT_XVYU2101010
      drm/arm/malidp: Set the AFBC register bits if the framebuffer
has AFBC modifier
      drm/arm/malidp:- Added support for new YUV formats for DP500,
DP550 and DP650
      drm/arm/malidp:- Define a common list of AFBC format modifiers
supported for DP500, DP550 and DP650
      drm/arm/malidp: Specified the rotation memory requirements for
AFBC YUV formats
      drm/arm/malidp:- Writeback framebuffer does not support any modifiers
      drm/arm/malidp:- Use the newly introduced
malidp_format_get_bpp() instead of relying on cpp for calculating
framebuffer size
      drm/arm/malidp:- Disregard the pitch alignment constraint for
AFBC framebuffer.
      drm/arm/malidp: Added support for AFBC modifiers for all layers
except DE_SMART

Bjorn Helgaas (1):
      drm/nouveau: Remove duplicate ACPI_VIDEO_NOTIFY_PROBE definition

Bob Paauwe (5):
      drm/i915/ehl: Add ElkhartLake platform
      drm/i915/ehl: EHL outputs are different from ICL
      drm/i915/ehl: Set proper eu slice/subslice parameters for EHL
      drm/i915/ehl: All EHL ports are combo phys
      drm/i915/ehl: Inherit Ice Lake conditional code

Boris Brezillon (2):
      drm/vc4: Report HVS underrun errors
      drm/vc4: Add a load tracker to prevent HVS underflow errors

Brian Masney (1):
      dt-bindings: drm/panel: simple: add lg,acx467akm-7 panel

Brian Starkey (1):
      drm/fourcc: Add AFBC yuv fourccs for Mali

Charlene Liu (7):
      drm/amd/display: Add disable triple buffering DC debug option
      drm/amd/display: dcn add check surface in_use
      Revert "drm/amd/display: dcn add check surface in_use"
      drm/amd/display: Add pp_smu null pointer check
      drm/amd/display: add HW i2c arbitration with dmcu
      drm/amd/display: fix DP 422 VID_M half the rate issue.
      drm/amd/display: Add hubp_init entry to hubp vtable

Chengguang Xu (2):
      drm/i915: remove redundant likely/unlikely annotation
      drm/vmwgfx: remove redundant unlikely annotation

Chengming Gui (23):
      drm/amd/powerplay: implement power_dpm_state sys interface for SMU11
      drm/amd/powerplay: add watermarks related data structs and
function for SMU11.
      drm/amd/powerplay: implement pp_power_profile_mode sys inerface for S=
MU11
      drm/amd/powerplay: add display_config to handle display config for SM=
U11.
      drm/amd/powerplay: add mclk_latency_table struct and smu_clocks
struct for SMU11
      drm/amd/powerplay: add enable_umd_pstate functions for SMU11
      drm/amd/powerplay: add get_profiling_clk_mask functions for SMU11
      drm/amd/powerplay: add set_uclk_to_highest_level for SMU11
      drm/amd/powerplay: add display_config_changed for SMU11.
      drm/amd/powerplay: add apply_clock_adjust_rules for SMU11.
      drm/amd/powerplay: add vega20_notify_smc_display_config
functions for SMU11
      drm/amd/powerplay: add vega20_find/force_higest/lowest_dpm for SMU11 =
(v2)
      drm/amd/powerplay: add vega20_unforce_dpm_levels for SMU11.
      drm/amd/powerplay: implement power_dpm_force_performance_level for SM=
U11
      drm/amd/powerplay: implement power1_cap and power1_cap_max
interface for SMU11 (v2)
      drm/amd/powerplay: add STABLE_PSTATE_SCLK and STABLE_PSTATE_MCLK
when read sensor for SMU11
      drm/amd/powerplay: implement pwm1 hwmon interface for SMU11 (v2)
      drm/amd/powerplay: implement pwm1_enable hwmon interface for SMU11 (v=
2)
      drm/amd/powerplay: implement fan1_enable hwmon interface for SMU11 (v=
2)
      drm/amd/powerplay: add smu_late_init for SMU11.
      drm/amd/powerplay: add is_dpm_running for SMU11
      drm/amd/powerplay: add set/get_power_profile_mode for Raven (v2)
      drm/amd/powerplay: enable UMDPSTATE support on raven2 (v2)

Chris Wilson (160):
      drm/i915: Defer removing fence register tracking to rpm wakeup
      drm/i915: Revoke mmaps and prevent access to fence registers across r=
eset
      drm/i915: Force the GPU reset upon wedging
      drm/i915: Uninterruptibly drain the timelines on unwedging
      drm/i915: Wait for old resets before applying debugfs/i915_wedged
      drm/i915: Serialise resets with wedging
      drm/i915: Don't claim an unstarted request was guilty
      drm/i915/execlists: Refactor out can_merge_rq()
      drm/i915: Protect i915_active iterators from the shrinker
      drm/i915: Pull sync_scru for device reset outside of wedge_mutex
      drm/i915: Use synchronize_srcu_expedited() for resets
      drm/i915: Include the current timeline seqno for debugging execlists
      drm/i915: Reacquire priolist cache after dropping the engine lock
      drm/i915: Recursive i915_reset_trylock() verboten
      drm/i915: Detect potential i915_reset_trylock() lockups
      drm/i915: Apply rps waitboosting for dma_fence_wait_timeout()
      snd/hda, drm/i915: Track the display_power_status using a cookie
      drm/i915: Only try to park engines after a failed reset
      drm/i915/selftests: Always use an active engine while resetting
      drm/i915: Defer application of request banning to submission
      drm/i915/selftests: Drop unnecessary struct_mutex around i915_reset()
      drm/i915/fbdev: Actually configure untiled displays
      drm/i915/selftests: Always free spinner on __sseu_prepare error
      drm/i915/selftests: Move local mock_ggtt allocations to the heap
      drm/i915: Optionally disable automatic recovery after a GPU reset
      drm/i915/selftests: Make unbannable contexts for reset handling
      drm/i915: Restore interrupt enabling after a reset
      drm/i915: Include reminders about leaving no holes in uAPI enums
      drm/i915: Move verify_wm_state() to heap
      drm/i915: Trim delays for wedging
      drm/i915: Use time based guilty context banning
      drm/i915: Beware temporary wedging when determining -EIO
      drm/i915: Avoid reset lock in writing fence registers
      drm/i915: Reduce the RPS shock
      drm/i915: Prevent user context creation while wedged
      drm/i915/hdcp: Silence compiler critics
      drm/i915: Reorder struct_mutex-vs-reset_lock in i915_gem_fault()
      drm/i915/guc: Flush the residual log capture irq on disabling
      drm/i915/pmu: Always sample an active ringbuffer
      drm/i915: Replace global_seqno with a hangcheck heartbeat seqno
      drm/i915: Remove access to global seqno in the HWSP
      drm/i915: Remove i915_request.global_seqno
      drm/i915/selftests: Exercise resetting during non-user payloads
      drm/i915: Skip scanning for signalers if we are already inflight
      drm/i915: Avoid waking the engines just to check if they are idle
      drm: Wake up next in drm_read() chain if we are forced to
putback the event
      drm/i915: Compute the global scheduler caps
      Revert "drm/i915: Avoid waking the engines just to check if they are =
idle"
      drm/i915: Report engines are idle if already parked
      drm/i915: Make request allocation caches global
      drm/i915: Make object/vma allocation caches global
      drm/i915: Remove second level open-coded rcu work
      drm/i915: Use __ffs() in for_each_priolist for more compact code
      drm/i915/execlists: Suppress mere WAIT preemption
      drm/i915: Introduce i915_timeline.mutex
      drm/i915/selftests: Check that whitelisted registers are accessible
      drm/i915/execlists: Suppress redundant preemption
      drm/i915: Keep timeline HWSP allocated until idle across the system
      drm/i915: Use HW semaphores for inter-engine synchronisation on gen8+
      drm/i915: Prioritise non-busywait semaphore workloads
      drm/i915: Fix I915_EXEC_RING_MASK
      drm/i915: Acquire breadcrumb ref before cancelling
      drm/i915/gtt: Use optimised memset32/64 for clearing PTE
      drm/i915/gtt: Store scratch page size alongside not in the common str=
uct
      drm/i915: Just check the vebox IIR regardless
      drm/i915: Stop capturing semaphore registers for gen6/7 GPU hangs
      drm/i915: Remove last traces of exec-id (GEM_BUSY)
      drm/i915: Store the BIT(engine->id) as the engine's mask
      drm/i915/gtt: Mark ALL_ENGINES as dirty on ppGTT modification
      drm/i915: Move find_active_request() to the engine
      drm/i915: Use i915_global_register()
      drm/i915: Pass around the intel_context
      drm/i915/selftests: Fix MI_STORE_DWORD_IMM alignment
      drm/i915: Make I915_GEM_IDLE_TIMEOUT into a macro
      drm/i915: Force GPU idle on suspend
      drm/i915/selftests: Improve switch-to-kernel-context checking
      drm/i915/selftests: Check preemption support on each engine
      drm/i915: Do a synchronous switch-to-kernel-context on idling
      drm/i915: Refactor common code to load initial power context
      drm/i915: Reduce presumption of request ordering for barriers
      drm/i915: Remove has-kernel-context
      drm/i915: Track active engines within a context
      drm/i915: Split struct intel_context definition to its own header
      drm/i915: Store the intel_context_ops in the intel_engine_cs
      drm/i915: Move over to intel_context_lookup()
      drm/i915: Make context pinning part of intel_context_ops
      drm/i915: Track the pinned kernel contexts on each engine
      drm/i915: Introduce intel_context.pin_mutex for pin management
      drm/i915: Suppress the "Failed to idle" warning for gem_eio
      drm/i915: Introduce a context barrier callback
      drm/i915: Consolidate reset-request debug message
      drm/i915/selftests: Improve error detection of reset failure
      drm/i915/selftests: Disable preemption while setting up fence-timers
      drm/i915: Refactor to common helpers for prepare/finish between
reset & wedge
      drm/i915: Mark up vGPU support for full-ppgtt
      drm/i915: Record platform specific ppGTT size in intel_device_info
      drm/i915: Drop address size from ppgtt_type
      drm/i915/gtt: Rename i915_vm_is_48b to i915_vm_is_4lvl
      drm/i915/gtt: Refactor common ppgtt initialisation
      drm/i915: Always kick the execlists tasklet after reset
      drm/i915: Fix off-by-one in reporting hanging process
      drm/i915: Sanity check mmap length against object size
      drm/i915: Stop needlessly acquiring wakeref for debugfs/drop_caches_s=
et
      drm/i915: Switch to use HWS indices rather than addresses
      drm/i915: Hold a ref to the ring while retiring
      drm/i915: Lock the gem_context->active_list while dropping the link
      drm/i915: Hold a reference to the active HW context
      drm/i915/selftests: Provide stub reset functions
      drm/i915: Use __is_constexpr()
      drm/i915: Separate GEM context construction and registration to users=
pace
      drm/i915: Introduce a mutex for file_priv->context_idr
      drm/i915: Stop storing ctx->user_handle
      drm/i915: Stop storing the context name as the timeline name
      drm/i915: Flush pages on acquisition
      drm/i915: Skip object locking around a no-op set-domain ioctl
      drm/i915/selftests: Calculate maximum ring size for preemption chain
      drm/i915/selftests: Mark up preemption tests for hang detection
      drm/i915: Introduce the i915_user_extension_method
      drm/i915: Create/destroy VM (ppGTT) for use with contexts
      drm/i915: Extend CONTEXT_CREATE to set parameters upon construction
      drm/i915: Allow contexts to share a single timeline across all engine=
s
      drm/i915: Remove defunct intel_suspend_gt_powersave()
      drm/i915: Report the correct errno from i915_gem_context_open()
      drm/i915: Adding missing '; ' to ENGINE_INSTANCES
      drm/i915: Drop new chunks of context creation ABI (for now)
      drm/i915: Always backoff after a drm_modeset_lock() deadlock
      drm/i915: Avoid using ctx->file_priv during construction
      drm/i915: Check domains for userptr on release
      drm/i915: Prefault before locking pages in shmem_pwrite
      drm/i915: Move intel_engine_mask_t around for use by i915_request_typ=
es.h
      drm/i915: Split out i915_priolist_types into its own header
      drm/i915: Only emit one semaphore per request
      drm/i915: Move the decision to use the breadcrumb tasklet to the back=
end
      drm/i915: Be precise in types for i915_gem_busy
      drm/i915: Fixup kerneldoc for intel_cdclk_needs_cd2x_update
      drm/i915: Use lockdep_pin_lock() over the construction of the request
      drm/i915/execlists: Enable coarse preemption boundaries for gen8
      drm/i915/selftests: Fix plain use of integer 0 as NULL
      drm/i915: Make RING_PDP relative to engine->mmio_base
      drm/i915: Make use of 'engine->uncore'
      drm/i915: Convert i915_reset.c over to using uncore mmio
      drm/i915: Track the temporary wakerefs used for hsw_get_pipe_config
      drm/i915/guc: Replace WARN with a DRM_ERROR
      drm/i915: Use static allocation for i915_globals_park()
      drm/i915: Consolidate the timeline->barrier
      drm/i915/selftests: Mark live_forcewake_ops as unreliable
      drm/i915/guc: Replace preempt_client lookup with engine->preempt_cont=
ext
      drm/i915: Only reset the pinned kernel contexts on resume
      drm/i915: Bump ready tasks ahead of busywaits
      drm/i915: Call i915_sw_fence_fini on request cleanup
      drm/i915/guc: Implement reset locally
      drm/i915/execlists: Always reset the context's RING registers
      drm/i915: Avoid reclaim taints from runtime-pm debug
      drm/i915: Flush the CSB pointer reset
      drm/i915: Teach intel_workarounds to use uncore mmio access
      drm/i915/selftests: Skip live timeline/suspend tests if wedged
      drm/i915: Drop bool return from breadcrumbs signaler
      drm/i915: Mark up ips for RCU protection
      drm/i915: Introduce struct class_instance for engines across the uAPI
      drm/i915: Avoid use-after-free in reporting create.size

Christian K=C3=B6nig (43):
      drm/amdgpu: fix dma mask check in gmc_v6_0.c
      drm/amdgpu: reroute VMC and UMD to IH ring 1
      drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega 20
      drm/amdgpu: rework shadow handling during PD clear v3
      drm/amdgpu: let amdgpu_vm_clear_bo figure out ats status v2
      drm/amdgpu: allocate VM PDs/PTs on demand
      drm/amdgpu: free PDs/PTs on demand
      drm/amdgpu: drop the huge page flag
      drm/amdgpu: allow huge invalid mappings on GMC8
      drm/amdgpu: change Vega IH ring 1 config
      drm/amdgpu: enable IH doorbell for ring 1&2 on Vega
      drm/amdgpu: enable IH ring 1&2 for Vega20 as well
      drm/amdgpu: limit the number of IVs processed at once
      drm/amdgpu: use ring/hash for fault handling on GMC9 v3
      drm/amdgpu: remove chash
      drm/amdgpu: remove non-sense NULL ptr check
      drm/amdgpu: wait for VM to become idle during flush
      drm/amdgpu: stop evicting busy PDs/PTs
      drm/amdgpu: re-enable retry faults
      drm/amdgpu: free up the first paging queue v2
      drm/amdgpu: use more entries for the first paging queue
      drm/amdgpu: remove some unused VM defines
      drm/amdgpu: always set and check dma addresses in the VM code
      drm/amdgpu: move and rename amdgpu_pte_update_params
      drm/amdgpu: reserve less memory for PDE updates
      drm/amdgpu: new VM update backends
      drm/amdgpu: use the new VM backend for PDEs
      drm/amdgpu: use the new VM backend for PTEs
      drm/amdgpu: revert "XGMI pstate switch initial support"
      drm/amdgpu: use the new VM backend for clears
      drm/amdgpu: move VM table mapping into the backend as well
      drm/amdgpu: drop the ib from the VM update parameters
      drm/amdgpu: don't put the root PD into the relocated list
      drm: fallback to dma_alloc_coherent when memory encryption is active
      dma-buf: add new dma_fence_chain container v7
      drm/syncobj: add new drm_syncobj_add_point interface v4
      drm/syncobj: use the timeline point in drm_syncobj_find_fence v4
      drm/amdgpu: fix ATC handling for Ryzen
      drm/amdgpu: handle leaf PDEs as PTEs on Vega
      drm/amdgpu: provide the page fault queue to the VM code
      drm/amdgpu: fix old fence check in amdgpu_fence_emit
      dma-buf: explicitely note that dma-fence-chains use 64bit seqno
      drm/amd/display: wait for fence without holding reservation lock

Chunming Zhou (6):
      drm/syncobj: add support for timeline point wait v8
      drm/syncobj: add timeline payload query ioctl v6
      drm/syncobj: add transition iotcls between binary and timeline v2
      drm/syncobj: add timeline signal ioctl for syncobj v5
      drm/amdgpu: add timeline support in amdgpu CS v3
      drm/amdgpu: update version for timeline syncobj support in amdgpu v2

Colin Ian King (7):
      drm: fix spelling mistake "intead" -> "instead"
      drm/amdgpu: fix missing assignment of error return code to variable r=
et
      drm/amd/powerplay: fix spelling mistake "unknow" -> "unknown"
      drm/amdgpu: fix spelling mistake "gateing" -> "gating"
      drm/amd/amdgpu: fix spelling mistake "recieve" -> "receive"
      drm/amd/display: fix incorrect null check on pointer
      drm/nouveau/fb/ramgk104: fix spelling mistake "sucessfully" ->
"successfully"

Colin Xu (5):
      drm/i915/gvt: Use consist max display pipe numbers as i915 definition
      drm/i915/gvt: Add macro define for mmio 0x50080 and gvt flip event
      drm/i915/gvt: Enable synchronous flip on handling MI_DISPLAY_FLIP
      drm/i915/gvt: Enable async flip on plane surface mmio writes
      drm/i915/gvt: Fix incorrect mask of mmio 0x22028 in gen8/9 mmio list

Dan Carpenter (7):
      drm/i915/selftests: fix NULL vs IS_ERR() check in mock_context_barrie=
r()
      drm/amd/powerplay: delete some dead code
      drm/amd/powerplay: Off by one in vega20_get_smu_msg_index()
      drm/amd/powerplay: Fix double unlock bug in smu_sys_set_pp_table()
      drm/i915/selftests: Fix an IS_ERR() vs NULL check
      drm/v3d: fix a NULL vs error pointer mixup
      drm: shmem: Off by one in drm_gem_shmem_fault()

Daniel Vetter (38):
      drm/doc: document recommended component helper usage
      drm/bochs: Drop best_encoder
      staging/vboxvideo: Another FIXME item
      drm/hibmc: Drop best_encoder
      Merge tag 'drm-misc-next-2019-03-21' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/doc: Drop "content type" from the legacy kms property table
      drm/fbdev: Make skip_vt_switch the default
      drm/fb-helper: Add fill_info() functions
      drm/fb-helper: set fbi->fix.id in fill_info()
      drm/fb_helper: set info->par in fill_info()
      drm/amdgpu: Use drm_fb_helper_fill_info
      drm/armada: Use drm_fb_helper_fill_info
      drm/ast: Use drm_fb_helper_fill_info
      drm/cirrus: Use drm_fb_helper_fill_info
      drm/exynos: Use drm_fb_helper_fill_info
      drm/gma500: Use drm_fb_helper_fill_info
      drm/hibmc: Use drm_fb_helper_fill_info
      drm/i915: Use drm_fb_helper_fill_info
      drm/mga200g: Use drm_fb_helper_fill_info
      drm/msm: Use drm_fb_helper_fill_info
      drm/nouveau: Use drm_fb_helper_fill_info
      drm/omap: Use drm_fb_helper_fill_info
      drm/radeon: Use drm_fb_helper_fill_info
      drm/rockchip: Use drm_fb_helper_fill_info
      drm/tegra: Use drm_fb_helper_fill_info
      drm/vboxvideo: Use drm_fb_helper_fill_info
      drm/udl: Use drm_fb_helper_fill_info
      drm/fb-helper: Unexport fill_{var,info}
      drm/fb-helper: Fixup fill_info cleanup
      drm/gamma: Clarify gamma lut uapi
      Merge branch 'drm-legacy-cleanup' of
git://people.freedesktop.org/~airlied/linux into drm-next
      drm/leases: Drop object_id validation for negative ids
      drm/lease: Drop recursive leads checks
      drm/leases: Don't init to 0 in drm_master_create
      drm/lease: Check for lessor outside of locks
      drm/lease: Make sure implicit planes are leased
      drm/atomic: Wire file_priv through for property changes
      drm/atomic: -EACCESS for lease-denied crtc lookup

Daniele Ceraolo Spurio (25):
      drm/i915: do not pass dev_priv to low-level forcewake functions
      drm/i915/selftests: add test to verify get/put fw domains
      drm/i915: always use masks on FW regs
      drm/i915: use intel_uncore in fw get/put internal paths
      drm/i915: use intel_uncore for all forcewake get/put
      drm/i915: make more uncore function work on intel_uncore
      drm/i915: make find_fw_domain work on intel_uncore
      drm/i915: reduce the dev_priv->uncore dance in uncore.c
      drm/i915: move regs pointer inside the uncore structure
      drm/i915: make raw access function work on uncore
      drm/i915: stop storing the media fuse
      drm/i915: rename raw reg access functions
      drm/i915: add HAS_FORCEWAKE flag to uncore
      drm/i915: add uncore flags for unclaimed mmio
      drm/i915: take a ref to the rpm in the uncore structure
      drm/i915: switch uncore mmio funcs to use intel_uncore
      drm/i915: switch intel_uncore_forcewake_for_reg to intel_uncore
      drm/i915: intel_wait_for_register_fw to uncore
      drm/i915: switch intel_wait_for_register to uncore
      drm/i915: take a reference to uncore in the engine and use it
      drm/i915: fix i386 build of 64b raw_uncore functions
      drm/i915: move the edram detection out of uncore init
      drm/i915: fix i9xx irq enable/disable
      drm/i915: add intel_uncore_init_early
      drm/i915: rename init/fini/prune uncore functions

Dave Airlie (45):
      Merge tag 'omapdrm-5.2' of git://git.kernel.org/.../tomba/linux
into drm-next
      Merge tag 'du-next-20190318' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-intel-next-2019-03-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-intel-next-2019-03-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'du-next-20190328' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-misc-next-2019-03-28-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge commit 'refs/for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'drm-misc-next-2019-04-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-2019-04-10' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      BackMerge v5.1-rc5 into drm-next
      Revert "drm: allow render capable master with DRM_AUTH ioctls"
      Merge branch 'vmwgfx-next' of
https://gitlab.freedesktop.org/drawat/linux into drm-next
      Merge tag 'drm-intel-next-2019-04-17' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2019-04-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm/tegra/for-5.2-rc1' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge branch 'drm-next-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-msm-next-2019-04-21' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      drm/nouveau: add kconfig option to turn off nouveau legacy contexts. =
(v3)
      drm/legacy: move drm_legacy_master_rmmaps to non-driver legacy header=
.
      drm/legacy: move map cleanups into drm_bufs.c
      drm/radeon: drop unused ati pcigart include.
      drm/legacy: move lock cleanup for master into lock file (v2)
      drm/legacy: move map_hash create/destroy into inlines
      drm/legacy: move init/destroy of struct members into legacy file
      drm/legacy: move legacy dev reinit into legacy misc
      drm/legacy: don't include any of ati_pcigart in legacy. (v2)
      drm: allow removal of legacy codepaths (v4.1)
      drm/legacy: place all drm legacy members under DRM_LEGACY.
      drm/legacy: remove some legacy lock struct members
      Merge tag 'exynos-drm-next-for-v5.2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      drm/udl: introduce a macro to convert dev to udl.
      drm/udl: move to embedding drm device inside udl device.
      drm/fb: revert the i915 Actually configure untiled displays from mast=
er
      Merge tag 'drm-misc-next-fixes-2019-04-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-04-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-5.2' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'drm-misc-next-fixes-2019-05-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-04-30' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-intel-next-fixes-2019-05-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'for-upstream/mali-dp' of
git://linux-arm.org/linux-ld into drm-next
      Merge tag 'drm-misc-next-fixes-2019-05-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

David Francis (12):
      drm/i915: Move dsc rate params compute into drm
      drm/dsc: Add native 420 and 422 support to compute_rc_params
      drm/dsc: Split DSC PPS and SDP header initialisations
      drm/amd/display: Clean up wait on vblank event
      drm/amd/display: Make stream commits call into DC only once
      drm/amd/display: Allow pflips from a framebuffer to itself
      drm/amd/display: Refactor pageflips plane commit
      drm/amd/display: Re-add custom degamma support
      drm/amd/display: On DCN1, Wait for vupdate on cursor updates
      drm/amd/display: Update ABM crtc state on non-modeset
      drm/amd/display: Add debugfs dpcd interface
      drm/amd/display: Handle get crtc position error

David Santamar=C3=ADa Rogado (1):
      drm: panel-orientation-quirks: Add quirk for Lenovo Ideapad D330

Deepak Rawat (9):
      drm/vmwgfx: Use preprocessor macro to get valid context node
      drm/vmwgfx: Use preprocessor macro for cmd struct
      drm/vmwgfx: Add a new define for vmwgfx user-space debugging
      drm/vmwgfx: Print message when command verifier returns with error
      drm/vmwgfx: Clean up some debug messages in vmwgfx_execbuf.c
      drm/vmwgfx: Use VMW_DEBUG_USER for device command buffer errors
      drm/vmwgfx: Fix formatting and spaces in vmwgfx_execbuf.c
      drm/vmwgfx: Use preprocessor macro for FIFO allocation
      drm: Expose "FB_DAMAGE_CLIPS" property to atomic aware user-space onl=
y

Dmitry Osipenko (1):
      drm/tegra: gem: Fix CPU-cache maintenance for BO's allocated
using get_pages()

Dmytro Laktyushkin (9):
      drm/amd/display: Allow for plane-less resource reservation
      drm/amd/display: clean up dml_init_instance
      drm/amd/display: fix releasing planes when exiting odm
      drm/amd/display: fix odm combine pipe reset
      drm/amd/display: add missing opp programming for odm
      drm/amd/display: fix odm pipe management
      drm/amd/display: fix odm output gamma programming
      drm/amd/display: fix clk_mgr naming
      drm/amd/display: fix is odm head pipe logic

Douglas Anderson (1):
      drm/msm: Cleanup A6XX opp-level reading

Emily Deng (1):
      drm/amdgpu: Correct the irq types' num of sdma

Eric Anholt (22):
      drm/v3d: Fix BO stats accounting for dma-buf-imported buffers.
      drm/v3d: Update top-level kerneldoc for the addition of TFU.
      drm/v3d: Don't try to set OVRTMUOUT on V3D 4.x.
      drm/v3d: Make sure the GPU is on when measuring clocks.
      drm/v3d: Handle errors from IRQ setup.
      drm/v3d: Add support for V3D v4.2.
      drm: Add helpers for locking an array of BO reservations.
      drm/v3d: Use drm_gem_lock_reservations()/drm_gem_unlock_reservations(=
)
      drm/v3d: Remove some dead members of struct v3d_bo.
      drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
      drm/vc4: Make sure to emit a tile coordinates between two MSAA loads.
      drm/v3d: Add a note about OOM vs FLDONE, which may be racing on v3.3.
      drm/v3d: Rename the fence signaled from IRQs to "irq_fence".
      drm: Add a helper function for printing a debugfs_regset32.
      drm/vc4: Use drm_print_regset32() for our debug register dumping.
      drm/vc4: Use drm_printer for the debugfs and runtime bo stats output.
      drm/vc4: Add helpers for pm get/put.
      drm/vc4: Make sure that the v3d ident debugfs has vc4's power on.
      drm/vc4: Use common helpers for debugfs setup by the driver component=
s.
      drm/vc4: Disable V3D interactions if the v3d component didn't probe.
      drm: Add helpers for setting up an array of dma_fence dependencies.
      drm/lima: Use the drm_gem_fence_array_add helpers for our deps.

Eric Bernstein (7):
      drm/amd/display: Move enum gamut_remap_select to hw_shared.h
      drm/amd/display: Free DCN version of stream encoder
      drm/amd/display: Rename is_hdmi to is_hdmi_tmds type
      drm/amd/display: Fix setting DP_VID_N_MUL
      drm/amd/display: Use dc_is_hdmi_signal() instead of ENUM
      drm/amd/display: use dc_is_virtual instead of ENUM
      drm/amd/display: Allow cursor position when plane_res.ipp is NULL

Eric Huang (2):
      drm/amdkfd: add RAS capabilities in topology for Vega20 (v2)
      drm/amdkfd: add RAS ECC event support (v3)

Eric Yang (2):
      drm/amd/display: fix underflow on boot
      drm/amd/display: remove deprecated pplib interface

Eryk Brol (2):
      drm/amd/display: Add DCN_VM aperture registers
      drm/amd/display: Create clock funcs

Evan Quan (12):
      drm/amd/powerplay: apply Vega20 BACO workaround
      drm/amdgpu: fix ras parameter descriptions
      drm/amdgpu: trivial typo fix
      drm/amdgpu: error out on mode1 reset failure
      drm/amdgpu: add more debug friendly prompts
      drm/amdgpu: defer cmd/fence/fw buffers destroy on hw_init failure
      drm/amd/powerplay: update current profile mode only when it's
really applied
      drm/amd/powerplay: check for invalid profile mode before switching
      drm/amdgpu: enable Vega20 BACO reset support
      drm/amdgpu: update Vega20 sdma golden settings
      drm/amdgpu: expose VCE 4.0 powergate interface
      drm/amdgpu: power down the Vega20 VCE engine on request

Fatemeh Darbehani (2):
      drm/amd/display: Remove redundant 'else' statement in dcn1_update_clo=
cks
      drm/amd/display: Clean up old pplib interface functions

Feifei Xu (1):
      drm/amdgpu: enable ras on gfx9 (v2)

Felix Kuehling (2):
      drm/ttm: Account for kernel allocations in kernel zone only
      drm/amdgpu: Wait for newly allocated PTs to be idle

Gerd Hoffmann (26):
      drm/virtio: implement prime mmap
      drm/virtio: remove prime pin/unpin callbacks.
      drm/virtio: implement prime export
      drm/virtio: add virtio-gpu-features debugfs file.
      drm/virtio: move virtio_gpu_object_{attach, detach} calls.
      drm/virtio: use struct to pass params to virtio_gpu_object_create()
      drm/virtio: params struct for virtio_gpu_cmd_create_resource()
      drm/virtio: params struct for virtio_gpu_cmd_create_resource_3d()
      drm/virtio: rework resource creation workflow.
      drm/virtio: add missing drm_atomic_helper_shutdown() call.
      drm/bochs: add missing drm_atomic_helper_shutdown() call.
      drm/cirrus: add missing drm_helper_force_disable_all() call.
      drm/bochs: drop mode_config_initialized
      drm/cirrus: drop mode_info.mode_config_initialized
      drm: move tinydrm format conversion helpers to new drm_format_helper.=
c
      drm: add drm_fb_memcpy_dstclip() helper
      drm: add drm_fb_xrgb8888_to_rgb565_dstclip()
      drm: add drm_fb_xrgb8888_to_rgb888_dstclip()
      drm/cirrus: rewrite and modernize driver.
      drm: switch drm_fb_memcpy_dstclip to accept __iomem dst
      drm: switch drm_fb_xrgb8888_to_rgb565_dstclip to accept __iomem dst
      drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to accept __iomem dst
      drm/bochs: use simple display pipe
      drm: fix drm_fb_xrgb8888_to_rgb888_dstclip()
      virtio-gpu api: comment feature flags
      drm: add drm_format_helper.c to kerneldoc

Guido G=C3=BCnther (4):
      dt-bindings: display/panel: Add missing unit names
      dt-bindings: Add vendor prefix for ROCKTECH DISPLAYS LIMITED
      dt-bindings: Add Rocktech jh057n00900 panel bindings
      drm/panel: Add Rocktech jh057n00900 panel driver

Gustavo A. R. Silva (2):
      drm/drm_vm: Mark expected switch fall-throughs
      drm/amdgpu/gfx_v8_0: Mark expected switch fall-through

Hans de Goede (4):
      staging/vboxvideo: Drop initial_mode_queried workaround
      staging/vboxvideo: Refactor vbox_update_mode_hints
      drm/vboxvideo: Move the vboxvideo driver out of staging
      MAINTAINERS: Add an entry for the vboxvideo driver

Harmanprit Tatla (1):
      drm/amd/display: cache additional dpcd caps for HDR capability check

Harry Wentland (1):
      drm/amd/display: Pass init_data into DCN resource creation

Hawking Zhang (4):
      drm/amdgpu: update atomfirmware header with ecc related members
      drm/amdgpu: add atomfirmware helper function to query ecc status
      drm/amdgpu: add atomfirmware helper function to query sram ecc caps
      drm/amdgpu: query sram ecc/ecc availability from atombios

Huang Rui (61):
      drm/amd/powerplay: add new smu ip block
      drm/amd/powerplay: add smu11 sub block for SMU IP
      drm/amd/powerplay: add firmware loading interface
      drm/amd/powerplay: add fw load checking interface
      drm/amd/powerplay: add interface to read pptable from vbios
      drm/amd/powerplay: add placeholder of smu_initialize_pptable
      drm/amd/powerplay: add interface to init smc tables (v2)
      drm/amd/powerplay: add interface to init power (v2)
      drm/amd/powerplay: add interface to get vbios bootup values (v2)
      drm/amd/powerplay: add interface to check pptable (v2)
      drm/amd/powerplay: add interface to init fb allocations (v2)
      drm/amd/powerplay: add interface to parse pptable (v2)
      drm/amd/powerplay: add interface to populate smc pptable (v2)
      drm/amd/powerplay: add interface to check fw version (v2)
      drm/amd/powerplay: add interface to write pptable (v2)
      drm/amd/powerplay: add interface to set min dcef deep sleep (v2)
      drm/amd/powerplay: add interface to set tool table location (v2)
      drm/amd/powerplay: add interface to allocate memory pool (v2)
      drm/amd/powerplay: add interface to notify memory pool location (v2)
      drm/amd/powerplay: add interfaces for smu resume
      drm/amd/powerplay: add resume sequence placeholder for smu ip block
      drm/amdgpu: enable new smu ip block for vega20
      drm/amd/powerplay: add new ppsmc header for smu11 (v2)
      drm/amd/powerplay: add pptable header for smu11
      drm/amdgpu: update atomfirmware header for smu11
      drm/amdgpu: update new members in atomfirmware
      drm/amd/powerplay: add smu table context structure
      drm/amd/powerplay: add get atom data table helper
      drm/amdgpu: move get_index_into_master_table macro into
atomfirmware header
      drm/amd/powerplay: implement read_pptable_from_vbios function for smu=
11
      drm/amd/powerplay: update pptable header for smu11
      drm/amd/powerplay: add data structure of bootup values
      drm/amd/powerplay: implement get_vbios_bootup_values function
for smu11 (v2)
      drm/amd/powerplay: implement get_clk_info_from_vbios function
for smu11 (v2)
      drm/amd/powerplay: add vega20 pptable function file
      drm/amd/powerplay: add append_powerplay_table function
      drm/amd/powerplay: add get_max_sustainable_clock function
      drm/amd/powerplay: add the function to set deep sleep dcefclk
      drm/amd/powerplay: add two interfaces to
set_active_display_count and store_cc6_data
      drm/amd/powerplay: add smu display configuration change function
      drm/amd/powerplay: add get_clock_by_type interface for display
      drm/amd/powerplay: add interface to get max high clocks for display
      drm/amd/powerplay: add interface to get clock by type with
latency for display (v2)
      drm/amd/powerplay: add interface to get clock by type with
voltage for display
      drm/amd/powerplay: add interface to request display clock voltage
      drm/amd/powerplay: add interface to get dal power level
      drm/amd/powerplay: add interface to get performance level
      drm/amd/powerplay: add interface to get current shallow sleep clocks
      drm/amd/powerplay: add interface to get current clocks for display
      drm/amd/powerplay: add interface to notify smu enable pme restore reg=
ister
      drm/amd/powerplay: implement interface to set watermarks for clock ra=
nges
      drm/amd/powerplay: remove unnecessary checking in smu_hw_fini
      drm/amd/powerplay: don't check hwmgr while using the sw smu
      drm/amd/powerplay: fix smc messsage index report
      drm/amd/powerplay: fix byte alignment issue of smu11 pptable
      drm/amd/powerplay: move setting allowed mask and feature enabling tog=
ether
      drm/amd/powerplay: fix the issue of checking on message mapping
      drm/amd/powerplay: use REG32_PCIE wrapper instead for sw smu
      drm/amd/powerplay: fix raven issue for sw smu
      drm/amdgpu: enable gfxoff again on raven series (v2)
      drm/amdgpu: add one rlc version into gfxoff blacklist

Hugo Hu (2):
      drm/amd/display: Programming correct VRR_EN bit in VTEM structure
      drm/amd/display: Handle branch device with DFP count =3D 0 case.

Imre Deak (6):
      drm/i915/icl: Prevent incorrect DBuf enabling
      drm/i915: Save the old CDCLK atomic state
      drm/i915: Remove redundant store of logical CDCLK state
      drm/i915: Get power refs in encoder->get_power_domains()
      drm/i915/icl: Simplify release of encoder power refs
      drm/i915/icl: Fix MG_DP_MODE() register programming

Inki Dae (6):
      drm/fimd: use DRM_ERROR instead of DRM_INFO in error case
      drm/exynos: remove unnecessary messages
      drm/exynos: use DRM_DEV_ERROR to print out error message
      drm/exynos: use DRM_DEV_DEBUG* instead of DRM_DEBUG macro
      drm/vidi: replace platform_device pointer with device one
      drm/ipp: clean up debug messages

Jagan Teki (2):
      dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
      drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel

Jakub Wilk (1):
      drm/ttm: Fix spelling of "KiB"

James Ausmus (1):
      drm/i915/ehl: Add EHL platform info and PCI IDs

Jani Nikula (38):
      drm/i915/opregion: fix version check
      drm/i915/opregion: rvda is relative from opregion base in opregion 2.=
1+
      drm/i915/dp: deconflate PPS unlock from divisor register
      drm/i915/dp: use single point of truth for PPS divisor register
      drm/i915: introduce REG_BIT() and REG_GENMASK() to define
register contents
      drm/i915: deprecate _SHIFT in favor of _MASK passed to accessors
      drm/i915: use REG_FIELD_PREP() to define register bitfield values
      drm/i915: stick to kernel fixed size types
      drm/i915/psr: remove drmP.h include that crept in
      drm/i915/bios: iterate over child devices to initialize ddi_port_info
      drm/i915: add Makefile magic for testing headers are self-contained
      drm/i915: make intel_frontbuffer.h self-contained
      drm/i915: extract intel_audio.h from intel_drv.h
      drm/i915: extract intel_crt.h from intel_drv.h
      drm/i915: extract intel_ddi.h from intel_drv.h
      drm/i915: extract intel_connector.h from intel_drv.h
      drm/i915: extract intel_csr.h from intel_drv.h
      drm/i915: extract intel_fbc.h from intel_drv.h
      drm/i915: extract intel_psr.h from intel_drv.h
      drm/i915: extract intel_color.h from intel_drv.h
      drm/i915: extract intel_lspcon.h from intel_drv.h
      drm/i915: extract intel_sdvo.h from intel_drv.h
      drm/i915: extract intel_hdcp.h from intel_drv.h
      drm/i915: extract intel_panel.h from intel_drv.h
      drm/i915: extract intel_pm.h from intel_drv.h
      drm/i915: extract intel_fbdev.h from intel_drv.h
      drm/i915: extract intel_dp.h from intel_drv.h
      drm/i915: extract intel_hdmi.h from intel_drv.h
      drm/i915: extract intel_atomic_plane.h from intel_drv.h
      drm/i915: extract intel_pipe_crc.h from intel_drv.h
      drm/i915: extract intel_tv.h from intel_drv.h
      drm/i915: extract intel_lvds.h from intel_drv.h
      drm/i915: extract intel_dvo.h from intel_drv.h
      drm/i915: extract intel_sprite.h from intel_drv.h
      drm/i915: extract intel_cdclk.h from intel_drv.h
      drm/i915/cdclk: have only one init/uninit function
      drm/i915/dp: revert back to max link rate and lane count on eDP
      drm/i915/ehl: inherit icl cdclk init/uninit

Janusz Krzysztofik (2):
      drm/i915: Mark GEM wedged right after marking device unplugged
      drm/drv: Fix incorrect resolution of merge conflict

Jernej Skrabec (2):
      drm/sun4i: Add VI scaler line size quirk for DE2/DE3
      drm/sun4i: Improve VI scaling for DE2/DE3

Jeykumar Sankaran (7):
      drm/msm/dpu: move hw_inf encoder baseclass
      drm/msm/dpu: remove phys_vid subclass
      drm/msm/dpu: release resources on modeset failure
      drm/msm/dpu: dont use encoder->crtc in atomic path
      drm/msm/dpu: map mixer/ctl hw blocks in encoder modeset
      drm/msm/dpu: assign intf to encoder in mode_set
      drm/msm/dpu: check split role for single flush

Joe Perches (1):
      drm/panel: Rocktech jh057n00900: Add terminating newlines to logging

Joel Stanley (4):
      dt-bindings: gpu: Add ASPEED GFX bindings document
      drm: Add ASPEED GFX driver
      MAINTAINERS: Add ASPEED BMC GFX DRM driver entry
      drm: aspeed: Clean up Kconfig options

Johan Jonker (1):
      dt-bindings: display: rockchip: add document for rk3066 hdmi

John Barberiz (1):
      drm/amd/display: Refactor dp vendor parsing logic to a function

Jon Derrick (4):
      drm/nouveau/bar/nv50: check bar1 vmm return value
      drm/nouveau/bar/nv50: ensure BAR is mapped
      drm/nouveau/bar/gf100: ensure BAR is mapped
      drm/nouveau/mmu: qualify vmm during dtor

Jonathan Marek (1):
      drm/panel: simple: add lg,acx467akm-7 panel

Joonas Lahtinen (15):
      Merge drm/drm-next into drm-intel-next-queued
      Merge tag 'topic/mei-hdcp-2019-02-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190220
      drm/i915: Update DRIVER_DATE to 20190311
      Merge drm/drm-next into drm-intel-next-queued
      Merge tag 'topic/hdr-formats-2019-03-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-intel-next-queued
      Merge tag 'topic/hdr-formats-2019-03-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190320
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190328
      drm/i915: Update DRIVER_DATE to 20190328
      drm/i915: Update DRIVER_DATE to 20190328
      drm/i915: Update DRIVER_DATE to 20190404
      Merge tag 'gvt-next-2019-04-16' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190417

Jordan Crouse (13):
      drm/msm: Remove pm_runtime calls from msm_iommu.c
      drm/msm/gpu: Add submit queue queries
      drm/msm/a6xx: Remove unwanted regulator code
      dt-bindings: drm/msm/a6xx: Add GX power-domain for GMU bindings
      drm/msm/gpu: Attach to the GPU GX power domain
      drm/msm/a6xx: Make GMU reset useful
      msm/drm/a6xx: Turn off the GMU if resume fails
      drm/msm/a6xx: Remove an unused struct member
      dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
      drm/msm/gpu: Move zap shader loading to adreno
      drm/msm/a6xx: Add zap shader load
      dt-bindings: drm/msm/gpu: Document a5xx / a6xx zap shader region
      drm/msm/a6xx: Don't enable GPU state code if dependencies are missing

Joshua Aberback (3):
      drm/amd/display: Populate macro_tile_size field for dml
      drm/amd/display: Add fast_validate parameter
      drm/amd/display: Add profiling tools for bandwidth validation

Josip Pavic (3):
      drm/amd/display: optionally optimize edp link rate based on timing
      drm/amd/display: reduce abm min reduction, deviation gain and
contrast factor
      drm/amd/display: remove min reduction for abm 2.2 level 3

Jos=C3=A9 Roberto de Souza (25):
      drm/i915/psr: Execute the default PSR code path when setting
i915_edp_psr_debug
      drm/i915: Call MG_DP_MODE() macro with the right parameters order
      drm/i915: Fix atomic state leak when resetting HDMI link
      drm/i915: Don't manually add connectors and planes state
      drm/i915: Forcing a modeset when resetting HDMI link
      drm/i915/icl: Remove alpha support protection
      drm/i915/psr: Remove PSR2 FIXME
      drm/i915/psr: Only lookup for enabled CRTCs when forcing a fastset
      drm/i915: Compute and commit color features in fastsets
      drm/i915/psr: Drop test for EDP in CRTC when forcing commit
      drm/i915/crc: Make IPS workaround generic
      drm/i915: Disable PSR2 while getting pipe CRC
      drm/i915: Drop redundant checks to update PSR state
      drm/i915: Force PSR1 exit when getting pipe CRC
      drm/i915: Enable PSR2 by default
      drm/i915: Add new ICL PCI ID
      drm/i915/vbt: Parse and use the new field with PSR2 TP2/3 wakeup time
      drm/i915/psr: Move logic to get TPS registers values to another funct=
ion
      drm/i915/icl+: Always use TPS2 or TPS3 when exiting PSR1
      drm/i915: Fix PSR2 selective update corruption after PSR1 setup
      drm/i915/icl: Fix VEBOX mismatch BUG_ON()
      drm/i915/psr: Update PSR2 SU corruption workaround comment
      drm/i915: Remove unused VLV/CHV PSR registers
      drm/i915/psr: Initialize PSR mutex even when sink is not reliable
      drm/i915/psr: Do not enable PSR in interlaced mode for all GENs

Juha-Pekka Heikkila (3):
      drm/i915: Add P010, P012, P016 plane control definitions
      drm/i915: Preparations for enabling P010, P012, P016 formats
      drm/i915: Enable P010, P012, P016 formats for primary and sprite plan=
es

Jun Lei (10):
      drm/amd/display: PPLIB Hookup
      drm/amd/display: Add p_state_change_support flag to dc_clocks
      drm/amd/display: Add ability to override bounding box in DC construct
      drm/amd/display: add full update commit hint struct
      drm/amd/display: implement bounding box update based on uclk breakdow=
n
      drm/amd/display: fix up reference clock abstractions
      drm/amd/display: extend EDID support to 1kb
      drm/amd/display: add preferred pipe split logic
      drm/amd/display: expand plane caps to include fp16 and scaling capabi=
lity
      drm/amd/display: add explicit handshake between x86 and DMCU

Kangjie Lu (2):
      drm: vkms: check status of alloc_ordered_workqueue
      drm/v3d: fix a missing check of pm_runtime_get_sync

Ken Chalmers (1):
      drm/amd/display: Increase DP blank timeout from 30 ms to 50 ms

Kent Russell (4):
      drm/amdgpu: Add sysfs files for returning VRAM/GTT info v2
      drm/amdgpu: Allow switching to CUSTOM profile on smu7 v2
      drm/amdgpu: Allow switching to CUSTOM profile on Vega10 v2
      drm/amdgpu: Allow switching to CUSTOM profile on Vega20

Kevin Strasser (3):
      drm/fourcc: Add 64 bpp half float formats
      drm/i915: Refactor icl_is_hdr_plane
      drm/i915/icl: Implement half float formats

Kevin Wang (43):
      drm/amd/powerplay: implement smu send message functions for smu11 (v3=
)
      drm/amd/powerplay: implement check_fw_status function for smu11
      drm/amd/powerplay: implement check_fw_version function for smu11
      drm/amd/powerplay: implement smu_init[fini]_smc_tables for smu11
      drm/amd/powerplay: implement smu dpm context functions for smu11
      drm/amd/powerplay: implement smu_init[fini]_power function for smu11
      drm/amd/powerplay: implement smu_init(fini)_fb_allocations function
      drm/amd/powerplay: remove header of smu_v11_0_pptable
      drm/amd/powerplay: implement smu_alloc[free]_memory pool function
      drm/amd/powerplay: implement notify_memory_pool_location
function for smu11
      drm/amd/powerplay: add enum smu_msg_type to header
      drm/amd/powerplay: implement smu vega20_message_map for vega20
      drm/amd/powerplay: use virtual msg index to replace asic-related msg =
index
      drm/amd/powerplay: replace SMU_MSG_XXX with PPSMC_MSG_XXX
message index for smu11 (v2)
      drm/amd/powerplay: implement smu_init_display for smu11
      drm/amd/powerplay: implement smu_run_afll_btc function
      drm/amd/powerplay: implement smu feature functions
      drm/amd/powerplay: implement feature get&set functions
      drm/amd/powerplay: implement smu_notify_display_change function for s=
mu11
      drm/amd/powerplay: implement get_current_clk_freq for smu11
      drm/amd/powerplay: implement smu update table function
      drm/amd/powerplay: implement is_support_sw_smu function for new smu
      drm/amd/powerplay: implement sysfs of amdgpu_get_busy_percent for smu=
11
      drm/amd/powerplay: implement sysfs of pp_table for smu11 (v2)
      drm/amd/powerplay: implement sensor of SCLK and MCLK for smu11
      drm/amd/powerplay: implement sensor of thermal_get_temperature for sm=
u11
      drm/amd/powerplay: implement sensor of get_gpu_power for smu11
      drm/amd/powerplay: implement sensor of get_gfx_vdd for smu11
      drm/amd/powerplay: implement sensor of get feature mask
      drm/amd/powerplay: implement sysfs of get num states function
      drm/amd/powerplay: implement sysfs of pp_cur_state function
      drm/amd/powerplay: implement sysfs of pp_force_state for sw-smu
      drm/amd/powerplay: implement update enabled feature state to smc for =
smu11
      drm/amd/powerplay: hwmon don't check powerplay when sw smu is enabled
      drm/amd/powerplay: implement uvd & vce dpm enable functions
      drm/amd/powerplay: implement sensor of uvd & vce power state for smu1=
1
      drm/amd/powerplay: implement dpm enable functions of uvd & vce for sm=
u
      drm/amd/powerplay: enable amdgpu dpm for smu
      drm/amd/powerplay: debugfs don't check powerplay when SW SMU is enabl=
ed.
      drm/amd/powerplay: simplify sw-smu message map macro
      drm/amd/powerplay: move the smc_if_version to asic file
      drm/amd/powerplay: optimization function of smu_update_table
      drm/amd/powerplay: simplify the code of [get|set]_activity_monitor_co=
eff

Kieran Bingham (6):
      gpu: drm: atomic_helper: Fix spelling errors
      Revert "[media] v4l: vsp1: Supply frames to the DU continuously"
      drm: Fix subtle spelling error in drm_crtc_state
      drm: rcar-du: crtc: Make local functions static
      drm: rcar-du: Remove unused prototypes
      drm: rcar-du: Link CRTCs to the DU device

Konstantin Sudakov (3):
      drm/sun4i: dsi: Add burst support
      dt-bindings: Add vendor prefix for Ronbo Electronics
      drm/panel: Add Ronbo RB070D30 panel

Kristian H. Kristensen (3):
      drm/msm: Implement .gem_free_object_unlocked
      drm/msm: Stop dropping struct_mutex in recover_worker()
      drm/msm: Split submit_lookup_objects() into two loops

Laurent Pinchart (68):
      drm/atomic: Constify mode argument to mode_valid_path()
      drm/omap: Remove declaration of nonexisting function
      drm/omap: Remove unused kobj field from struct omap_dss_device
      drm/omap: venc: Remove wss_data field from venc_device structure
      drm/omap: Use atomic suspend/resume helpers
      drm/omap: Move common display enable/disable code to encoder
      drm/omap: Remove connection checks from internal encoders .enable()
      drm/omap: Remove connection checks from display .enable() and .remove=
()
      drm/omap: Remove enable checks from display .enable() and .remove()
      drm/omap: Reverse direction of the DSS device enable/disable operatio=
ns
      drm/omap: Remove omap_dss_device dst field
      drm/omap: Factor out common init/cleanup code for output devices
      drm/omap: Expose DRM modes instead of timings in display devices
      drm/omap: Merge display .get_modes() and .get_size() operations
      drm/omap: Add a dss device operation flag for .get_modes()
      drm/omap: venc: List both PAL and NTSC modes
      drm/omap: Don't pass display pointer to encoder init function
      drm/omap: Move display alias ID to omap_drm_pipeline
      drm/omap: Don't store display pointer in omap_connector structure
      drm/omap: panel-dsi-cm: Store source pointer internally
      drm/omap: Notify all devices in the pipeline of output disconnection
      drm/omap: Remove src field from omap_dss_device structure
      drm/omap: Move DISPC timing checks to CRTC .mode_valid() operation
      drm/omap: venc: Simplify mode setting by caching configuration
      drm/omap: Factor out common mode validation code
      drm/omap: Pass drm_display_mode to .check_timings() and .set_timings(=
)
      drm/omap: venc: Use drm_display_mode natively
      drm/omap: Store pixel clock instead of full mode in DPI and SDI encod=
ers
      drm/omap: Simplify OF lookup of DSS devices
      drm/omap: Refactor initialization sequence
      drm/omap: Merge omap_dss_device type and output_type fields
      drm: Clarify definition of the DRM_BUS_FLAG_(PIXDATA|SYNC)_* macros
      drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags
      dt-bindings: display: tfp410: Add bus parameters properties
      drm/bridge: ti-tfp410: Set connector type based on DT connector node
      drm/bridge: ti-tfp410: Add support for the powerdown GPIO
      drm/bridge: ti-tfp410: Report input bus config through bridge timings
      dt-bindings: Add vendor prefix for OSD Displays
      dt-bindings: display: Add OSD Displays OSD070T1718-19TS panel binding
      drm/panel: simple: Add OSD070T1718-19TS panel support
      drm/omap: Add support for drm_bridge
      drm/omap: Add support for drm_panel
      drm/omap: Whitelist DT nodes to fixup with omapdss, prefix
      drm/omap: Remove TFP410 and DVI connector drivers
      drm/omap: Remove panel-dpi driver
      drm: Turn bus flags macros into an enum
      media: vsp1: wpf: Fix partition configuration for display pipelines
      media: vsp1: Replace leftover occurrence of fragment with body
      media: vsp1: Fix addresses of display-related registers for VSP-DL
      media: vsp1: Replace the display list internal flag with a flags fiel=
d
      media: vsp1: Add vsp1_dl_list argument to .configure_stream() operati=
on
      media: vsp1: dl: Allow chained display lists for display pipelines
      media: vsp1: wpf: Add writeback support
      media: vsp1: drm: Split RPF format setting to separate function
      media: vsp1: drm: Extend frame completion API to the DU driver
      media: vsp1: drm: Implement writeback support
      drm: writeback: Cleanup job ownership handling when queuing job
      drm: writeback: Fix leak of writeback job
      drm: writeback: Add job prepare and cleanup operations
      drm: rcar-du: Fix rcar_du_crtc structure documentation
      drm: rcar-du: Store V4L2 fourcc in rcar_du_format_info structure
      drm: rcar-du: vsp: Extract framebuffer (un)mapping to separate functi=
ons
      drm: rcar-du: Add writeback support for R-Car Gen3
      drm: rcar-du: Support panels connected directly to the DPAD outputs
      drm: Forward-declare struct drm_format_info in drm_framebuffer.h
      drm: rcar-du: lvds: Fix post-DLL divider calculation
      drm: rcar-du: lvds: Adjust operating frequency for D3 and E3
      drm: rcar-du: lvds: Set LVEN and LVRES bits together on D3

Leo (Hanghong) Ma (2):
      drm/amd/display: Expose generic SDP message access interface
      drm/amd/display: Generic SDP message access in amdgpu

Leo Li (6):
      drm/amd/display: Fix "dc has no member named dml" compile error
      drm/amd/display: Recreate private_obj->state during S3 resume
      drm/amd/display: Clean up locking in dcn*_apply_ctx_for_surface()
      drm/amd/include: Add USB_C_TYPE to atom_encoder_cap_defs
      drm/amd/include: Add HUBPREQ_DEBUG register offsets
      drm/amdgpu: Check if SW SMU is supported before accessing funcs

Likun Gao (49):
      drm/amd/powerplay: init microcode for smu11
      drm/amd/powerplay: add function to parse pptable for smu11
      drm/amd/powerplay: add function to check pptable for smu11
      drm/amd/powerplay: update hw fini function to relase some memory
      drm/amd/powerplay: add function to populate smc pptable for smu11
      drm/amd/powerplay: add function to write pptable for smu11 (v2)
      drm/amd/powerplay: add function to set min dcef deep sleep for smu11 =
(v2)
      drm/amd/powerplay: add function to set tool table location for smu11 =
(v2)
      drm/amd/powerplay: expose the function of smu read argument
      drm/amd/powerplay: Change the allocate method of dpm context for smu1=
1.
      drm/amd/powerplay: set defalut dpm table for smu
      drm/amd/powerplay: add function to populate umd state clk.
      drm/amd/powerplay: add function to get power limit for smu11 (v2)
      drm/amd/powerplay: print clock levels for smu11 (v2)
      drm/amd/powerplay: add function to get thermal range
      drm/amd/powerplay: add function to set thermal range
      drm/amd/powerplay: add function to enable thermal alert
      drm/amd/powerplay: add function to set fan table to control thermal
      drm/amd/powerplay: add function to start thermal control
      drm/amd/powerplay: upload dpm level for smu11
      drm/amd/powerplay: force clock levels for smu11
      drm/amd/powerplay: add function to store overdrive information for sm=
u11
      drm/amd/powerplay: add function to set default overdrive settings
      drm/amd/powerplay: add golden dpm table to backup default DPM table (=
v2)
      drm/amd/powerplay: print overdrive percentage information for smu11
      drm/amd/powerplay: get overdrive clock and voltage information
      drm/amd/powerplay: add sys interface for pcie for smu
      drm/amd/powerplay: add function to update overdrive settings
      drm/amd/powerplay: add sys interface for set sclk_od/mclk_od for smu
      drm/amd/powerplay: add sys interface to set pp_od_clk_voltage for smu
      drm/amd/powerplay: adjust power state when set od_clk
      drm/amd/powerplay: dpm clk can be set only when performance
level is manual
      drm/amd/powerplay: Unify smu handle task function (v2)
      drm/amd/powerplay: add function to get sclk and mclk
      drm/amd/powerplay: add fan rpm limit interface for hwmon
      drm/amd/powerplay: add fan input interface for hwmon
      drm/amd/powerplay: set fan target interface for hwmon
      drm/amd/powerplay: get eclk/vclk/dclk for smu11
      drm/amd/powerplay: set dpm table of vclk/dclk/eclk for smu11 (v2)
      drm/amd/powerplay: add suspend and resume function for smu
      drm/amd/powerplay: add condition for smc table hw init
      drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk
      drm/amd/powerplay: support sysfs to set socclk, fclk, dcefclk
      drm/amd/powerplay: add override pcie parameters
      drm/amd/powerplay: support sysfs to set/get pcie
      drm/amd/powerplay: add limit of pp_feature for smu (v3)
      drm/amd/powerplay: add od condition for power limit
      drm/amd/powerplay: fix pcie sysfs interface when set wrong value
      drm/amdgpu: enable MGCG for PCO

Linus Walleij (1):
      drm/mcde: Add device tree bindings

Lionel Landwerlin (2):
      drm: report consistent errors when checking syncobj capibility
      drm: introduce a capability flag for syncobj timeline support

Liviu Dudau (2):
      arm/komeda: Compile komeda_debugfs_init() only if
CONFIG_DEBUG_FS is enabled
      MAINTAINERS: Fix pattern for Documentation path for Arm Mali Komeda

Luca Ceresoli (1):
      drm/doc: fix missing verb

Luca Weiss (1):
      drm/msm: Fix NULL pointer dereference

Lucas De Marchi (16):
      drm/i915/icl: move MG pll hw_state readout
      drm/i915: extract AUX mask assignment to separate function
      drm/i915: refactor transcoders reporting on error state
      drm/i915: allow platforms without eDP transcoder
      drm/i915: Fix bit name in PP_STATUS register
      drm/i915/icl: split combo and mg pll enable
      drm/i915/icl: split pll enable in three steps
      drm/i915/icl: split combo and mg pll disable
      drm/i915/icl: split combo and tbt pll funcs
      drm/i915/icl: remove intel_dpll_is_combophy()
      drm/i915/ehl: Add dpll mgr
      drm/i915/skl: use previous pll hw readout
      drm/i915/bxt: make bxt_calc_pll_link() similar to skl
      drm/i915/cnl: use previous pll hw readout
      drm/i915/icl: use previous pll hw readout
      drm/i915/icl: reduce pll_id scope and use enum type

Lucas Stach (5):
      dma-buf: add some lockdep asserts to the reservation object implement=
ation
      dma-buf: clarify locking documentation for reservation_object_get_exc=
l
      drm/etnaviv: clean up etnaviv_gem_new_handle
      drm/msm: don't allocate pages from the MOVABLE zone
      drm/etnaviv: initialize idle mask before querying the HW db

Lyude Paul (1):
      drm/nouveau/i2c: Disable i2c bus access after ->fini()

Maarten Lankhorst (5):
      drm/doc: Fix copy paste error in drm_crtc_funcs.destroy()
      drm/fourcc: Fix conflicting Y41x definitions
      drm/i915: Handle YUV subpixel support better
      drm/i915: Reject Yf tiling for HDR formats, v2.
      drm/i915: Reject rotation for some hdr formats

Manasi Navare (4):
      drm/dp: Set the connector's TILE property even for DP SST connectors
      drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro
      drm/i915/dp: Expose force_dsc_enable through debugfs
      drm/i915: Nuke drm_crtc_state and use intel_atomic_state instead

Mans Rullgard (1):
      drm/sun4i: hdmi: add support for ddc-i2c-bus property

Mario Kleiner (9):
      drm/amd/display: Use vrr friendly pageflip throttling in DC.
      drm/amd/display: Update VRR state earlier in atomic_commit_tail.
      drm/amd/display: Prevent vblank irq disable while VRR is active. (v3)
      drm/amd/display: Rework vrr flip throttling for late vblank irq.
      drm/amd/display: In VRR mode, do DRM core vblank handling at end
of vblank. (v2)
      drm/amd/display: Make pageflip event delivery compatible with VRR.
      drm/amd/display: Fix and simplify apply_below_the_range()
      drm/amd/display: Compensate for pre-DCE12 BTR-VRR hw limitations. (v3=
)
      drm: Fix timestamp docs for variable refresh properties.

Mark McGarrity (1):
      drm/amd/display: 3.2.19

Martin Leung (1):
      drm/amd/display: half bandwidth for YCbCr420 during validation

Martin Tsai (1):
      drm/amd/display: Poll pending DOWN_REP before enabling the link

Masahiro Yamada (1):
      drm: prefix header search paths with $(srctree)/

Maxime Jourdan (2):
      dt-bindings: display: amlogic, meson-vpu: exclusively use amlogic, ca=
nvas
      drm/meson: exclusively use the canvas provider module

Maxime Ripard (16):
      drm/sun4i: dsi: Restrict DSI tcon clock divider
      drm/sun4i: dsi: Change the start delay calculation
      drm/sun4i: dsi: Enforce boundaries on the start delay
      drm/sun4i: dsi: Fix front vs back porch calculation
      drm/sun4i: dsi: Rework a bit the hblk calculation
      Merge drm/drm-next into drm-misc-next
      Merge tag 'topic/component-typed-2019-02-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-misc-next
      dt-bindings: panel: Add YAML schemas for the Ronbo RB070D30 panel
      drm/vc4: Use 16bpp by default for the fbdev buffer
      drm/sun4i: Move the panel pointer from the TCON to the encoders
      drm/sun4i: rgb: Store the bridge pointer
      drm/sun4i: Move rate variables to long long
      drm/sun4i: rgb: Change the pixel clock validation check
      drm/sun4i: backend: Simplify the get_id logic
      drm/sun4i: mixer: Simplify the get_id logic
      drm/sun4i: Rely on dma interconnect for our RAM offset

Michael D Labriola (1):
      drm: change func to better detect wether swiotlb is needed

Michal Wajdeczko (1):
      drm/i915/guc: Support for extended GuC notification messages

Micha=C5=82 Winiarski (3):
      drm/i915/icl: Default to Thread Group preemption for compute workload=
s
      drm/i915/selftests: Upgrade printing test/subtest name to pr_info
      drm/i915: Update size upon return from GEM_CREATE

Mika Kuoppala (12):
      drm/i915/icl: Handle rps interrupts without irq lock
      drm/i915/icl: Don't warn on spurious interrupts
      drm/i915: Use dedicated rc6 enabling sequence for gen11
      drm/i915/icl: Apply a recommended rc6 threshold
      drm/i915/icl: Enable media sampler powergate
      drm/i915/icl: Disable video turbo mode for rp control
      drm/i915: Use Engine1 instance for gen11 pm interrupts
      drm/i915: Prepare for larger CSB status FIFO size
      drm/i915/icl: Switch to using 12 deep CSB status FIFO
      drm/i915: Disable read only ppgtt support for gen11
      drm/i915: Shortcut readiness to reset check
      drm/i915: Handle catastrophic error on engine reset

Murton Liu (2):
      drm/amd/display: Fix Divide by 0 in memory calculations
      drm/amd/display: HDR visual confirmation incorrectly reports black co=
lor

Nathan Chancellor (2):
      drm/amd/powerplay: Zero initialize num_of_levels in
vega20_set_single_dpm_table
      drm/vmwgfx: Zero initialize handle in vmw_execbuf_process

Neil Armstrong (15):
      dt-bindings: gpu: add bindings for the ARM Mali Bifrost GPU
      dt-bindings: display: amlogic, meson-vpu: Add G12A compatible and por=
ts
      dt-bindings: display: amlogic, meson-dw-hdmi: Add G12A
compatible and ports
      drm/meson: Switch PLL to 5.94GHz base for 297Mhz pixel clock
      drm/meson: Add registers for G12A SoC
      drm/meson: Add G12A Support for VPP setup
      drm/meson: Add G12A Support for VIU setup
      drm/meson: Add G12A support for OSD1 Plane
      drm/meson: Add G12A Support for the Overlay video plane
      drm/meson: Add G12A support for plane handling in CRTC driver
      drm/meson: Add G12A support for CVBS Encoder
      drm/meson: Add G12A Video Clock setup
      drm/meson: Add G12A compatible
      drm/meson: Add G12A support for the DW-HDMI Glue
      drm/meson: add size and alignment requirements for dumb buffers

Nicholas Kazlauskas (43):
      drm/amd/display: Reset planes that were disabled in init_pipes
      drm/amd/display: Set stream->mode_changed when connectors change
      drm/amd/display: Add plane capabilities to dc_caps
      drm/amd/display: Drop underlay plane support
      drm/amd/display: Create overlay planes
      drm/amd/display: Update plane tiling attributes for stream updates
      drm/amdgpu: Bump amdgpu version for per-flip plane tiling updates
      drm/amd/display: Drop atomic_obj_lock for private obj
      drm/amd/display: Don't ASSERT when total_planes =3D=3D AMDGPU_MAX_PLA=
NES
      drm/amd/display: Expose support for alpha blending on overlays
      drm/amd/display: Fix plane address updates for video surface formats
      drm/amdgpu: Clear VRAM for DRM dumb_create buffers
      drm/amdgpu: Only clear dumb buffers if ring is enabled
      drm/amd/display: Respect DRM framebuffer info for video surfaces
      drm/amd/display: Reset alpha state for planes to the correct values
      drm/amd/display: Use drm helper for resetting plane state
      drm/amd/display: Only put primary planes into the mode_info->planes l=
ist
      drm/amd/display: Prevent cursor hotspot overflow for RV overlay plane=
s
      drm/amd/display: Remove semicolon from to_dm_plane_state definition
      drm/amd/display: Initialize stream_update with memset
      drm/amd/display: Add debugfs entry for amdgpu_dm_visual_confirm
      drm/amd/display: Use plane->color_space for dpp if specified
      drm/amd/display: Set surface color space from DRM plane state
      drm/amd/display: Pass plane caps into amdgpu_dm_plane_init
      drm/amd/display: Expose support for NV12 on suitable planes
      drm/amd/display: Add DRM color properties for primary planes
      drm/amd/display: Update plane scaling parameters for fast updates
      drm/amd/display: Maintain z-ordering when creating planes
      drm/amd/display: Recalculate pitch when buffers change
      drm/amd/display: Rework DC plane filling and surface updates
      drm/amd/display: Add basic downscale and upscale valdiation
      drm/amd/display: Use surface directly when checking update type
      drm/amd/display: Don't warn when DC update type > DM guess
      drm/amd/display: Check scaling info when determing update type
      drm/amd/display: Relax requirements for CRTCs to be enabled
      drm/amd/display: Expose support for DRM_FORMAT_RGB565
      drm/amd/display: Refactor CRTC interrupt toggling logic
      drm/amd/display: Disable cursors before disabling planes
      drm/amd/display: Fix CRC vblank refs when changing interrupts
      drm/amd/display: Split enabling CRTC interrupts into two passes
      drm/amd/display: Allow commits with no planes active
      drm/amd/display: Do VRR transition before enable_crc_interrupts
      drm/amd/display: Expose DRM_FORMAT_RGB565 on overlay planes

Nikola Cornij (2):
      drm/amd/display: Pass SDP spliting in parameters
      drm/amd/display: Calculate link bandwidth in a common function

Noralf Tr=C3=B8nnes (25):
      drm: Fix drm_release() and device unplug
      drm/drv: drm_dev_unplug(): Move out drm_dev_put() call
      drm/modes: Add DRM_SIMPLE_MODE()
      drm/tinydrm: tinydrm_display_pipe_init() don't use tinydrm_device
      drm/tinydrm: Remove tinydrm_shutdown()
      drm/tinydrm/mipi-dbi: Add drm_to_mipi_dbi()
      drm/fb-helper: generic: Don't take module ref for fbcon
      drm/drv: Hold ref on parent device during drm_device lifetime
      drm: Add devm_drm_dev_init()
      drm/drv: DOC: Add driver example code
      drm/tinydrm/repaper: Drop using tinydrm_device
      drm/tinydrm: Drop using tinydrm_device
      drm/tinydrm: Remove tinydrm_device
      drm/tinydrm: Use drm_dev_enter/exit()
      drm: Add library for shmem backed GEM objects
      tinydrm/mipi-dbi: Use dma-safe buffers for all SPI transfers
      drm/fb-helper: Remove unused gamma_size variable
      drm/fb-helper: dpms_legacy(): Only set on connectors in use
      drm/vc4: Call drm_dev_register() after all setup is done
      drm/fb-helper: generic: Call drm_client_add() after setup is done
      drm/client: Rename drm_client_add() to drm_client_register()
      drm/i915/fbdev: Move intel_fb_initial_config() to fbdev helper
      drm/tinydrm: Fix fbdev pixel format
      drm/fb-helper: Fix drm_fb_helper_firmware_config() NULL pointer deref
      drm/cma-helper: Fix drm_gem_cma_free_object()

Oak Zeng (1):
      drm/amdgpu: Cosmetic change for calling func amdgpu_gmc_vram_location

Paul Kocialkowski (1):
      drm/vc4: Add a debugfs entry to disable/enable the load tracker

Paulo Zanoni (5):
      drm/i915: refactor the IRQ init/reset macros
      drm/i915: don't specify the IRQ register in the gen2 macros
      drm/i915: add GEN2_ prefix to the I{E, I, M, S}R registers
      drm/i915: convert the IRQ initialization functions to intel_uncore
      drm/i915: fully convert the IRQ initialization macros to intel_uncore

Peter Ujfalusi (3):
      drm/bridge: ti-tfp410: Fall back to HPD polling if HPD irq is
not available
      dt-bindings: display: tfp410: Add bus-width parameter property
      drm/bridge: ti-tfp410: Set the bus_format

Philip Yang (8):
      drm/amdgpu: use HMM callback to replace mmu notifier
      drm/amdkfd: avoid HMM change cause circular lock
      drm/amdgpu: replace get_user_pages with HMM mirror helpers
      drm/amdgpu: fix HMM config dependency issue
      drm/amdkfd: support concurrent userptr update for HMM
      drm/amdgpu: support userptr cross VMAs case with HMM
      drm/amdgpu: more descriptive message if HMM not enabled
      drm: increase drm mmap_range size to 1TB

Philipp Zabel (1):
      reset: add acquired/released state for exclusive reset controls

Qiang Yu (5):
      drm: export drm_timeout_abs_to_jiffies
      drm/lima: driver for ARM Mali4xx GPUs
      MAINTAINERS: add drm/lima driver info
      drm/lima: add missing Kconfig dependency
      drm/lima: include used header file explicitly

Radhakrishna Sripada (2):
      drm/i915: Rename skl_wa_clkgating to the actual WA
      drm/i915: Fix the inconsistent RMW in WA 827

Ramalingam C (16):
      drm/i915: HDCP state handling in ddi_update_pipe
      drm/i915: Gathering the HDCP1.4 routines together
      drm/i915: Initialize HDCP2.2
      drm/i915: MEI interface implementation
      drm/i915: hdcp1.4 CP_IRQ handling and SW encryption tracking
      drm/i915: Enable and Disable of HDCP2.2
      drm/i915: Implement HDCP2.2 receiver authentication
      drm/i915: Implement HDCP2.2 repeater authentication
      drm: HDCP2.2 link check period
      drm/i915: Implement HDCP2.2 link integrity check
      drm/i915: Handle HDCP2.2 downstream topology change
      drm: removing the DP Errata msg and its msg id
      drm/i915: Implement the HDCP2.2 support for DP
      drm/i915: Implement the HDCP2.2 support for HDMI
      drm/i915: CP_IRQ handling for DP HDCP2.2 msgs
      drm/i915: Fix KBL HDCP2.2 encrypt status signalling

Randy Dunlap (1):
      MAINTAINERS: mark lima mailing list as moderated

Reza Amini (1):
      drm/amd/display: Fix VTEM InfoPacket programming

Rob Clark (3):
      drm/msm/gpu: add per-process pagetables param
      drm/msm: add param to retrieve # of GPU faults (global)
      drm/msm/a6xx: No zap shader is not an error

Rob Herring (10):
      drm: Add reservation_object to drm_gem_object
      drm: etnaviv: Switch to use drm_gem_object reservation_object
      drm: msm: Switch to use drm_gem_object reservation_object
      drm: v3d: Switch to use drm_gem_object reservation_object
      drm: vc4: Switch to use drm_gem_object reservation_object
      drm: imx: Use of_node_name_eq for node name comparisons
      iommu: io-pgtable: Add ARM Mali midgard MMU page table format
      drm: Add a drm_gem_objects_lookup helper
      drm/panfrost: Add initial panfrost driver
      drm/panfrost: Add support for 2MB page entries

Robert M. Fosha (1):
      drm/i915/guc: Retry GuC load for all load failures

Robin Murphy (4):
      drm/panfrost: Set DMA masks earlier
      drm/panfrost: Disable PM on probe failure
      drm/panfrost: Don't scream about deferred probe
      drm/panfrost: Show stored feature registers

Rodrigo Vivi (9):
      drm/i915: Sort ctx workarounds init from newer to older platforms.
      drm/i915: Sort newer to older platforms.
      drm/i915: Remove unused HAS_PCH_CNP_LP
      drm/i915: Yet another if/else sort of newer to older platforms.
      drm/i915/gen11+: First assume next platforms will inherit stuff
      drm/i915: Move PCH_NOP to -1
      drm/i915: Start using comparative INTEL_PCH_TYPE
      drm/i915: Also use new comparative stuff for more ICP+ stuff
      x86/gpu: add ElkhartLake to gen11 early quirks

Russell King (1):
      drm: etnaviv: avoid DMA API warning when importing buffers

Ryan Pavlik (1):
      drm: add non-desktop quirks to Sensics and OSVR headsets.

Samson Tam (2):
      drm/amd/display: Link train only when link is DP and backend is enabl=
ed
      drm/amd/display: change name from dc_link_get_verified_link_cap
to dc_link_get_link_cap

Sean Paul (12):
      Merge drm/drm-next into drm-misc-next
      Merge tag 'topic/hdr-formats-2019-03-07' of
git://anongit.freedesktop.org/drm/drm-misc into drm-misc-next
      Merge tag 'topic/hdr-formats-2019-03-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-misc-next
      Documentation/gpu/meson: Remove link to meson_canvas.c
      Merge drm/drm-next into drm-misc-next
      drm/msm: Use drm_mode_vrefresh instead of mode->vrefresh
      drm/msm: dpu: Simplify frame_done watchdog timeout calculation
      drm/msm: dpu: Untangle frame_done timeout units
      drm/msm: dpu: Don't queue the frame_done watchdog for cursor
      drm/msm: dpu: Don't set frame_busy_mask for async updates
      drm/gem: Fix sphinx warnings
      Merge panfrost-fixes into drm-misc-next-fixes

Seung-Woo Kim (1):
      drm/exynos: g2d: remove style error

SivapiriyanKumarasamy (3):
      drm/amd/display: Add PSR SMU Interrupt support
      drm/amd/display: fix dp_hdmi_max_pixel_clk units
      drm/amd/display: Call hwss.set_cursor_sdr_white_level, if available

Stefan Agner (1):
      drm/bridge: use bus flags in bridge timings

Steven Price (2):
      drm/panfrost: Add missing include
      drm/panfrost: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST

Su Sung Chung (1):
      drm/amd/display: return correct dc_status for dcn10_validate_global

Sujaritha Sundaresan (4):
      drm/i915/guc: Splitting CT channel open/close functions
      drm/i915/guc: Calling guc_disable_communication in all suspend paths
      drm/i915/guc: Preparing for GuC reset along with engine reset
      drm/i915/guc: GuC suspend path cleanup

Swati Sharma (3):
      drm: Add Y2xx and Y4xx (xx:10/12/16) format definitions and fourcc
      drm/i915/icl: Add Y2xx and Y4xx (xx:10/12/16) plane control definitio=
ns
      drm/i915/icl: Enabling Y2xx and Y4xx (xx:10/12/16) formats for
universal planes

Takashi Iwai (1):
      ALSA: hda: Fix racy display power access

Tao Zhou (1):
      drm/amdgpu: add thick tile mode settings for Oland of gfx6

Thierry Reding (4):
      reset: Add acquired flag to of_reset_control_array_get()
      reset: Add acquire/release support for arrays
      Merge branch 'reset/acquire' of
git://git.pengutronix.de/git/pza/linux into drm/tegra/for-next
      drm/tegra: sor: Implement acquire/release for reset

Thomas Hellstrom (1):
      drm/vmwgfx: Be more restrictive when dirtying resources

Thomas Lim (2):
      drm/amd/display: Respect aux return values
      drm/amd/display: Add power down display on boot flag

Thomas Preston (1):
      drm/i915/bios: assume eDP is present on port A when there is no VBT

Thomas Zimmermann (5):
      staging/vboxvideo: Use same BO mmap offset as other drivers
      drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
      drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init()
      drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
      drm: Use the same mmap-range offset and size for GEM and TTM

Tobias Klausmann (1):
      drm/nouveau/nouveau: forward error generated while resuming objects t=
ree

Tom St Denis (1):
      drm/amd/amdgpu: Add ENGINE_CNTL register to vcn10 headers

Tomeu Vizoso (2):
      drm/panfrost: Prevent concurrent resets
      drm/panfrost: Add sanity checks to submit IOCTL

Tony Lindgren (1):
      drm/omap: dsi: Fix PM for display blank with paired dss_pll calls

Tvrtko Ursulin (8):
      drm/i915: Re-arrange execbuf so context is known before engine
      drm/i915: Relax mmap VMA check
      drm/i915: Split Pineview device info into desktop and mobile
      drm/i915: Remove redundant device id from IS_IRONLAKE_M macro
      drm/i915: Split some PCI ids into separate groups
      drm/i915: Introduce concept of a sub-platform
      drm/i915: Fix uninitialized mask in intel_device_info_subplatform_ini=
t
      drm/i915/icl: Whitelist GEN9_SLICE_COMMON_ECO_CHICKEN1

Tyler DiBattista (1):
      drm/amd/display: Add function to create 4d19 fixed point

Uma Shankar (11):
      drm/i915/glk: Fix degamma lut programming
      drm/i915/icl: Add icl pipe degamma and gamma support
      drm/i915/icl: Enable ICL Pipe CSC block
      drm/i915/icl: Enable pipe output csc
      drm/i915/icl: Add degamma and gamma lut size to gen11 caps
      drm: Add HDMI colorspace property
      drm: Add colorspace info to AVI Infoframe
      drm/i915: Attach colorspace property and enable modeset
      drm/i915/icl: Drop redundant gamma mode mask
      drm/i915: Fix GCMAX color register programming
      drm/i915: Program EXT2 GC MAX registers

Urja Rannikko (1):
      drm/rockchip: vop: Support dithering to RGB666

Vandita Kulkarni (2):
      drm/i915/icl: Ungate ddi clocks before IO enable
      drm/i915/icl: Fix port disable sequence for mipi-dsi

Vicente Bergas (1):
      drm/rockchip: shutdown drm subsystem on shutdown

Ville Syrj=C3=A4l=C3=A4 (132):
      drm/i915: Populate gamma_mode for all platforms
      drm/i915: Track pipe gamma enable/disable in crtc state
      drm/i915: Track pipe csc enable in crtc state
      drm/i915: Turn off pipe gamma when it's not needed
      drm/i915: Turn off pipe CSC when it's not needed
      drm/i915: Disable pipe gamma when C8 pixel format is used
      drm/i915: Update DSPCNTR gamma/csc bits during crtc_enable()
      drm/i915: Dump skl+ watermark changes
      drm/i915: s/PUNIT_REG_DSPFREQ/PUNIT_REG_DSPSSPM/
      drm/i915: Assert that VED and ISP are power gated
      Revert "drm/i915: W/A for underruns with WM1+ disabled on icl"
      drm/i915: Include "ignore lines" in skl+ wm state
      drm/i915: Implement new w/a for underruns with wm1+ disabled
      drm/i915: Add pipe crc tracepoint
      drm/i915: Add pipe enable/disable tracepoints
      drm/i915: Add overlooked plane disable tracepoint into
intel_crtc_disable_planes()
      drm/i915: Wrap plane update/disable hook calls
      drm/i915: Remove the "pf" crc source
      drm/i915: Use named initializers for the crc source name array
      drm/i915: Remove the broken DP CRC support for g4x
      drm/i915: Extend skl+ crc sources with more planes
      drm/i915: Add the missing HDMI gamut metadata packet stuff
      drm/i915: Return the mask of enabled infoframes from ->inforame_enabl=
ed()
      drm/i915: Store mask of enabled infoframes in the crtc state
      drm/i915: Precompute HDMI infoframes
      drm/i915: Read out HDMI infoframes
      drm/i915/sdvo: Precompute HDMI infoframes
      drm/i915/sdvo: Read out HDMI infoframes
      drm/i915: Check infoframe state in intel_pipe_config_compare()
      drm/i915: Include infoframes in the crtc state dump
      drm/i915: Finalize Wa_1408961008:icl
      drm/i915: Fix the state checker for ICL Y planes
      drm/i915: Do not temporarily disable the DPLL on i830
      drm/i915: Simplify i830 DVO 2x clock handling
      drm/i915: Populate pipe_offsets[] & co. accurately
      drm/i915: Store DIMM rank information as a number
      drm/i915: Extract functions to derive SKL+ DIMM info
      drm/i915: Polish skl_is_16gb_dimm()
      drm/i915: Extract BXT DIMM helpers
      drm/i915: Fix DRAM size reporting for BXT
      drm/i915: Extract DIMM info on GLK too
      drm/i915: Use dram_dimm_info more
      drm/i915: Generalize intel_is_dram_symmetric()
      drm/i914: s/l_info/dimm_l/ etc.
      drm/i915: Clean up intel_get_dram_info() a bit
      drm/i915: Extract DIMM info on cnl+
      drm/i915: Read out memory type
      drm/i915: Readout and check csc_mode
      drm/i915: Precompute/readout/check CHV CGM mode
      drm/i915: Extract ilk_csc_limited_range()
      drm/i915: Clean up ilk/icl pipe/output CSC programming
      drm/i915: Extract ilk_csc_convert_ctm()
      drm/i915: Clean the csc limited range/identity programming
      drm/i915: Split ilk vs. icl csc matrix handling
      drm/i915: Fix legacy gamma mode for ICL
      drm/i915: Turn off the CUS when turning off a HDR plane
      drm/i915: Don't pass crtc to intel_find_shared_dpll()
      drm/i915: Don't pass crtc to intel_get_shared_dpll() and .get_dpll()
      drm/i915: Pass crtc_state down to skl dpll funcs
      drm/i915: Remove redundant on stack dpll_hw_state from skl_get_dpll()
      drm/i915: Pass crtc_state down to bxt dpll funcs
      drm/i915: Remove redundant on stack dpll_hw_state from bxt_get_dpll()
      drm/i915: Pass crtc_state down to cnl dpll funcs
      drm/i915: Remove redundant on stack dpll_hw_state from cnl_get_dpll()
      drm/i915: Pass crtc_state down to icl dpll funcs
      drm/i915: Remove redundant on stack dpll_hw_state from icl_get_dpll()
      drm/i915: Fix readout for cnl DPLL kdiv=3D=3D3
      drm/i915: Nuke icl_calc_dp_combo_pll_link()
      drm/i915: Remove the fragile array index -> link rate mapping
      drm/i915: Add some missing curly braces
      drm/i915: Polish intel_get_lvds_encoder()
      drm/i915: Pass dev_priv to intel_is_dual_link_lvds()
      drm/i915: Reorder gen3/4 swizzle detection logic
      drm/i915: Introduce i9xx_has_pfit()
      drm/i915: Introduce i9xx_has_pps()
      drm/i915: Introduce i915_has_asle()
      drm/i915: Use HPLLVCO_MOBILE for all PNVs
      drm/i915: Accept alloc_size =3D=3D blocks
      drm/i915: Don't pass plane state to skl_compute_plane_wm()
      drm/i915: Extract skl_compute_wm_params()
      drm/i915: Allocate enough DDB for the cursor
      drm/i915: Make sure cursor has enough ddb for the selected wm level
      drm/i915: Keep plane watermarks enabled more aggressively
      drm/i915: Move some variables to tighter scope
      drm/i915: Don't pass pipe_wm around so much
      drm/i915: Inline skl_update_pipe_wm() into its only caller
      drm/i915: Really calculate the cursor ddb based on the highest
enabled wm level
      drm/i915: Refactor EDID fixed mode search
      drm/i915: Pick the first mode from EDID as the fixed mode when
there is no preferred mode
      drm/i915: Refactor VBT fixed mode handling
      drm/i915: Adjust DSI fixed mode handling
      drm/i915: Stop hand rolling drm_mode_match()
      drm/i915: Clean up EDID downclock mode lookup
      drm/i915: Mark AML 0x87CA as ULX
      drm/i915: Disable C3 when enabling vblank interrupts on i945gm
      drm/i915: Use vblank_disable_immediate on gen2
      drm: Nuke unused drm_display_info.pixel_clock
      drm: Fix tabs vs. spaces
      drm: Kill drm_display_info.name
      drm/uapi: Remove unused DRM_DISPLAY_INFO_LEN
      drm/edid: Remove defunct EDID_QUIRK_FIRST_DETAILED_PREFERRED
      drm/i915: Add broadcast RGB property for DP MST
      drm/i915: Expose the force_audio property with DP MST
      drm/i915: Remove the 8bpc shackles from DP MST
      drm/i915: Add max_bpc property for DP MST
      drm/i915: Update TRANS_MSA_MISC for fastsets
      drm/i915: Extract check_luts()
      drm/i915: Turn intel_color_check() into a vfunc
      drm/i915: Extract i9xx_color_check()
      drm/i915: Extract chv_color_check()
      drm/i915: Extract icl_color_check()
      drm/i915: Extract glk_color_check()
      drm/i915: Extract bdw_color_check()
      drm/i915: Extract ilk_color_check()
      drm/i915: Drop the pointless linear legacy LUT load on CHV
      drm/i915: Skip the linear degamma LUT load on ICL+
      drm/i915: Force 2*96 MHz cdclk on glk/cnl when audio power is enabled
      drm/i915: Skip modeset for cdclk changes if possible
      drm/i915: Extract ilk_lut_10()
      drm/i915: Don't use split gamma when we don't have to
      drm/i915: Implement split/10bit gamma for ivb/hsw
      drm/i915: Add 10bit LUT for ilk/snb
      drm/i915: Add "10.6" LUT mode for i965+
      drm/i915: Expose the legacy LUT via the GAMMA_LUT/GAMMA_LUT_SIZE
props on gen2/3
      drm/i915: Expose full 1024 LUT entries on ivb+
      drm/i915: Fix pipe_bpp readout for BXT/GLK DSI
      drm/i915: Set DP min_bpp to 8*3 for non-RGB output formats
      drm/i915: Clean up DSC vs. not bpp handling
      drm/i915: Do not enable FEC without DSC
      drm/i915: Restore correct bxt_ddi_phy_calc_lane_lat_optim_mask()
calculation
      drm/i915: Suppress spurious combo PHY B warning
      drm/i915: Fix ICL output CSC programming

Wen Yang (2):
      drm/pl111: fix possible object reference leak
      drm/msm: a5xx: fix possible object reference leak

Wenjing Liu (6):
      drm/amd/display: add pipe lock during stream update
      drm/amd/display: add i2c over aux failure handling
      drm/amd/display: add global master update lock interfaces
      drm/amd/display: use proper formula to calculate bandwidth from timin=
g
      drm/amd/display: prefer preferred link cap over verified link setting=
s
      drm/amd/display: Add function to copy DC streams

Wentao Lou (2):
      drm/amdkfd/sriov:Put the pre and post reset in exclusive mode v2
      drm/amdgpu: value of amdgpu_sriov_vf cannot be set into F32_POLL_ENAB=
LE

Wesley Chalmers (2):
      drm/amd/display: Set flip pending for pipe split
      drm/amd/display: Fix DP audio regression

Xiaolin Zhang (2):
      drm/i915/gvt: replaced register address with name
      drm/i915/gvt: addressed guest GPU hang with HWS index mode

Yan Zhao (1):
      drm/i915/gvt: remove the unused sreg

Yang Wei (1):
      drm/amd/powerplay: fix semicolon code style issue

Yannick Fertr=C3=A9 (6):
      drm/stm: dw_mipi_dsi-stm: add sleep power management
      drm/stm: add sleep power management
      drm/panel: otm8009a: Add delay at the end of initialization
      drm/panel: otm8009a: No error msg if probe deferred
      drm/panel: rm68200: No error msg if probe deferred
      drm/panel: otm8009a: Set clock to 29.70 Mhz

Yintian Tao (2):
      drm/amdgpu: support dpm level modification under virtualization v3
      drm/amdgpu: disable DRIVER_ATOMIC under SRIOV

Yong Zhao (2):
      drm/amdgpu: Eliminate the set_pde_pte function pointer in amdgpu_gmc_=
funcs
      drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION to 0

Yongqiang Sun (6):
      drm/amd/display: Refactor reg_set and reg_update.
      drm/amd/display: Combine field toggle macro and sequence write macro.
      drm/amd/display: change generic_reg_wait to void.
      drm/amd/display: Move dm_read_reg_func to dc_helper.
      drm/amd/display: define HUBP_MASK_SH_LIST_DCN for Raven
      drm/amd/display: Refactor watermark programming

YueHaibing (14):
      drm: Remove set but not used variable 'gem'
      drm/qxl: remove set but not used variable 'bo_old'
      drm/ttm: remove set but not used variable 'bdev'
      drm/amdgpu: remove set but not used variables 'vm, bo'
      drm/amdgpu: remove set but not used variable 'vbi_time_out'
      drm/vboxvideo: Remove unused including <linux/version.h>
      drm/ttm: remove set but not used variable 'rdev'
      drm/virtio: remove set but not used variable 'vgdev'
      drm/vmwgfx: Remove set but not used variable 'restart'
      drm/vmwgfx: Remove set but not used variable 'fb_offset, fb_depth'
      drm/lima: Make lima_sched_ops static
      drm/sun4i: Make some symbols static
      drm/meson: Make some functions static
      drm/panfrost: Make panfrost_gem_free_object() static

Zhao Yakui (2):
      drm/i915/gvt: Refine the snapshort range of I915 MCHBAR to
optimize gvt-g boot time
      drm/i915/gvt: Refine the combined intel_vgpu_oos_page struct to
save memory

Zheng Yang (1):
      drm: rockchip: introduce rk3066 hdmi

Zhenyu Wang (3):
      drm/i915: always pin hw_id for GVT context
      drm/i915: Disable semaphore on vGPU for now
      Merge tag 'drm-intel-next-2019-04-04' into gvt-next

hersen wu (2):
      drm/amd/display: program default output gamma
      drm/amd/powerplay: raven 4k@60hz dp monitor always flicking

james qian wang (Arm Technology China) (25):
      drm/komeda: Add d71_enum_resources and d71_cleanup
      drm/komeda: Add d71 layer
      drm/komeda: Add d71 compiz component
      drm/komeda: Add D71 improc and timing_ctrlr
      drm/komeda: Add komeda_assemble_pipelines
      drm/komeda: Add irq handling
      drm/komeda: Add debugfs node "register" for register dump
      drm: Add drm_atomic_get_old/new_private_obj_state
      drm/komeda: Add komeda_pipeline/component_get_state_and_set_user
      drm/komeda: Initialize komeda component as drm private object
      drm/komeda: Add komeda_build_layer_data_flow
      drm/komeda: Add komeda_plane/plane_helper_funcs
      drm/komeda: Add komeda_build_display_data_flow
      drm/komeda: Add komeda_release_unclaimed_resources
      drm/komeda: Add komeda_crtc_atomic_flush
      drm/komeda: Add komeda_crtc_mode_valid/fixup
      drm/komeda: Add komeda_crtc_prepare/unprepare
      drm/komeda: Add komeda_crtc_atomic_enable/disable
      drm/komeda: Add komeda_crtc_vblank_enable/disable
      drm/komeda: Add komeda_crtc_funcs
      drm/komeda: Add komeda_kms_check
      drm/komeda: Add sysfs attribute: core_id and config_id
      drm/komeda: Expose bus_width to Komeda-CORE
      drm/komeda: Fixed warning: Function parameter or member not described
      drm/komeda: Mark the local functions as static

kbuild test robot (3):
      drm/amd/powerplay: fix memdup.cocci warnings
      drm/amdgpu: fix semicolon.cocci warnings
      drm/vc4: vc4_debugfs_regset32() can be static

mmcgarri (1):
      drm/amd/display: 3.2.18

shaoyunl (9):
      drm/amdgpu: Enable XGMI mapping for peer device
      drm/amdgpu: XGMI pstate switch initial support
      drm/amdgpu: XGMI pstate switch initial support
      drm/amdgpu: Adjust TMR address alignment as per HW requirement
      drm/amdgpu: Add preferred_domain check when determine XGMI state
      drm/amdgpu: Always enable memory sharing within same XGMI hive
      drm/powerplay: Add smu set xgmi pstate interface
      drm/amdgpu: Set proper function to set xgmi pstate
      drm/powerplay : send SMC message to set XGMI pstate

wentalou (1):
      drm/amdgpu: amdgpu_device_recover_vram got NULL of shadow->parent

xinhui pan (37):
      drm/amdgpu: add ta ras fw info (v2)
      drm/amdgpu: export ta fw info
      drm/amdgpu: add module parameters for ras
      drm/amdgpu: add ta_ras_if.h
      drm/amdgpu: add psp ras callback func and macro
      drm/amdgpu: add psp ras subsystem infrastructure (v2)
      drm/amdgpu: add psp v11 ras callback
      drm/amdgpu: add psp cmd submit timeout
      drm/amdgpu: add amdgpu_ras.c to support ras (v2)
      drm/amdgpu: add debugfs ctrl node
      drm/amdgpu: reserve bad pages during recovery
      drm/amdgpu: enable ras on sdma4
      drm/amdgpu: enable ras on gmc9
      drm/amdgpu: Add a new flag to AMDGPU_CTX_OP_QUERY_STATE2
      drm/amdgpu: add ioctl query for enabled ras features (v2)
      drm/amdgpu: skip gpu reset when ras error occured
      drm/amdgpu: add human readable debugfs control support (v2)
      drm/amdgpu: handle ras resume
      drm/amdgpu: lookup vbios table to check ecc capability
      drm/amdgpu: export both supported and enabled ras features
      drm/amdgpu: Fix NULL pointer when ta is missing
      drm/amdgpu: Fix warning when lockdep is enabled
      drm/amdgpu: add new member hw_supported
      drm/amdgpu: Fix ras debugfs data parse
      drm/amdgpu: Fix lockdep warning more gracely
      drm/amdgpu: let ras initialization a little noticeable
      drm/amdgpu: add new ras workflow control flags
      drm/amdgpu: Fix some sanity check
      drm/amdgpu: use macro instead of enum for flags
      drm/amdgpu: Fix amdgpu ras to ta enums conversion
      drm/amdgpu: remove per obj debugfs write
      drm/amdgpu: Make default ras error type to none
      drm/amdgpu: Introduce another ras enable function
      drm/amdgpu: gfx use amdgpu_ras_feature_enable_on_boot
      drm/amdgpu: gmc use amdgpu_ras_feature_enable_on_boot
      drm/amdgpu: sdma use amdgpu_ras_feature_enable_on_boot
      drm/amdgpu: Add a check to avoid panic because of unexpected irqs

 .../bindings/display/amlogic,meson-dw-hdmi.txt     |    4 +
 .../bindings/display/amlogic,meson-vpu.txt         |    9 +-
 .../bindings/display/bridge/ti,tfp410.txt          |   32 +-
 .../devicetree/bindings/display/msm/gmu.txt        |   10 +-
 .../devicetree/bindings/display/msm/gpu.txt        |   11 +
 .../display/panel/feiyang,fy07024di26a30d.txt      |   20 +
 .../bindings/display/panel/innolux,p079zca.txt     |    2 +-
 .../bindings/display/panel/innolux,p097pfg.txt     |    2 +-
 .../display/panel/kingdisplay,kd097d04.txt         |    2 +-
 .../bindings/display/panel/lg,acx467akm-7.txt      |    7 +
 .../display/panel/osddisplays,osd070t1718-19ts.txt |   12 +
 .../display/panel/rocktech,jh057n00900.txt         |   18 +
 .../bindings/display/panel/ronbo,rb070d30.yaml     |   51 +
 .../bindings/display/panel/tpo,td028ttec1.txt      |    2 +
 .../display/rockchip/rockchip,rk3066-hdmi.txt      |   72 +
 .../devicetree/bindings/display/ste,mcde.txt       |  104 +
 .../devicetree/bindings/gpu/arm,mali-bifrost.txt   |   92 +
 .../devicetree/bindings/gpu/aspeed-gfx.txt         |   41 +
 .../devicetree/bindings/gpu/brcm,bcm-v3d.txt       |   11 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    3 +
 Documentation/driver-api/component.rst             |    2 +
 Documentation/driver-model/devres.txt              |    3 +
 Documentation/gpu/drm-internals.rst                |    5 +
 Documentation/gpu/drm-kms-helpers.rst              |   18 +
 Documentation/gpu/kms-properties.csv               |    1 -
 Documentation/gpu/meson.rst                        |    6 -
 Documentation/gpu/tinydrm.rst                      |   30 +-
 Documentation/gpu/todo.rst                         |   12 +-
 MAINTAINERS                                        |   47 +-
 arch/x86/kernel/early-quirks.c                     |    4 +-
 drivers/dma-buf/Makefile                           |    3 +-
 drivers/dma-buf/dma-fence-chain.c                  |  242 ++
 drivers/dma-buf/reservation.c                      |    8 +
 drivers/dma-buf/sw_sync.c                          |    2 +-
 drivers/dma-buf/sync_file.c                        |    3 +-
 drivers/gpu/drm/Kconfig                            |   20 +-
 drivers/gpu/drm/Makefile                           |   18 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   41 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   15 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   61 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   61 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   54 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   73 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h   |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  152 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c            |    9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |   16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   82 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |   59 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   38 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  521 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  299 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |   32 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 1482 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  294 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |    7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   50 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  941 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   83 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |  127 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |  270 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  109 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  172 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |   16 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   19 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  205 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   30 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   65 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  652 +++---
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |    2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |   78 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h              |    6 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |    3 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |   95 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   36 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  238 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |    8 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |    3 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   30 +-
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h             |  108 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |    2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |   15 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   80 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |   16 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |    4 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 1892 ++++++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   18 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   53 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  194 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   22 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   21 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  126 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c |    5 +
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  220 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  164 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |   24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  196 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |   22 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  383 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   21 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  195 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  121 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   13 +
 drivers/gpu/drm/amd/display/dc/dc.h                |  134 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |    2 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   18 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |   76 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    9 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   10 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    7 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |  146 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |    5 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |   30 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   42 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |   22 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |   12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |    8 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    5 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |   36 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   78 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |  119 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |   92 +-
 .../drm/amd/display/dc/dce112/dce112_resource.h    |    3 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |   25 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |   45 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.c   |   65 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_clk_mgr.h   |    4 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |   13 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |    7 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |   20 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |   54 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |   63 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |   16 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  213 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    4 +
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |   16 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |    2 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |   52 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.h  |    2 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |   31 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |    3 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |   31 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |   36 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |    2 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |   40 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    5 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |    5 +-
 .../amd/display/dc/dml/display_rq_dlg_helpers.c    |    3 +
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   30 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |    4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |   10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |    6 +
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    7 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    4 +
 drivers/gpu/drm/amd/display/dc/inc/reg_helper.h    |   12 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   14 +-
 .../amd/display/dc/irq/dce110/irq_service_dce110.c |    7 +-
 .../amd/display/dc/irq/dce120/irq_service_dce120.c |    7 +-
 .../amd/display/dc/irq/dce80/irq_service_dce80.c   |    6 +-
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |   40 +-
 .../display/dc/virtual/virtual_stream_encoder.c    |    3 +-
 drivers/gpu/drm/amd/display/include/fixed31_32.h   |    2 +
 drivers/gpu/drm/amd/display/include/signal_types.h |    5 +
 .../drm/amd/display/modules/color/color_gamma.c    |    2 +
 .../drm/amd/display/modules/freesync/freesync.c    |  174 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   15 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |    3 +
 .../drm/amd/include/asic_reg/dcn/dcn_1_0_offset.h  |    8 +
 .../drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h  |    2 +
 .../drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h |    5 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |   98 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   16 -
 drivers/gpu/drm/amd/include/linux/chash.h          |  366 ---
 drivers/gpu/drm/amd/lib/Kconfig                    |   28 -
 drivers/gpu/drm/amd/lib/Makefile                   |   32 -
 drivers/gpu/drm/amd/lib/chash.c                    |  638 ------
 drivers/gpu/drm/amd/powerplay/Makefile             |    2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |   10 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 1253 ++++++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    3 +-
 .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |    2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  127 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   32 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.c    |   66 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.h    |   31 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.c  |   39 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_baco.h  |    5 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   39 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.c  |  119 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.h  |   29 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    5 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_inc.h   |    2 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.c  |   12 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_baco.h  |    1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   53 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h |    2 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  770 +++++++
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h       |    1 -
 drivers/gpu/drm/amd/powerplay/inc/smu10.h          |   14 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |   89 +
 .../gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h    |  128 ++
 .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h  |  147 ++
 drivers/gpu/drm/amd/powerplay/inc/vega20_ppsmc.h   |    3 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 1977 ++++++++++++++++
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |    4 +
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |   20 +
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h   |    1 +
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         | 2413 ++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.h         |  129 ++
 .../gpu/drm/arm/display/include/malidp_product.h   |   12 +
 drivers/gpu/drm/arm/display/include/malidp_utils.h |   31 +
 drivers/gpu/drm/arm/display/komeda/Makefile        |    8 +-
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |  685 ++++++
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |  431 +++-
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |   50 +
 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h  |  530 +++++
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  407 +++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  118 +
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |   95 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |    9 +-
 .../drm/arm/display/komeda/komeda_framebuffer.h    |    9 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |   77 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |   26 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  113 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  129 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |  610 +++++
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  139 ++
 .../drm/arm/display/komeda/komeda_private_obj.c    |  220 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |   48 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |    6 +
 drivers/gpu/drm/arm/malidp_hw.c                    |  249 +-
 drivers/gpu/drm/arm/malidp_hw.h                    |   31 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |   10 +-
 drivers/gpu/drm/arm/malidp_planes.c                |  271 ++-
 drivers/gpu/drm/arm/malidp_regs.h                  |   20 +
 drivers/gpu/drm/armada/armada_fbdev.c              |    6 +-
 drivers/gpu/drm/aspeed/Kconfig                     |   14 +
 drivers/gpu/drm/aspeed/Makefile                    |    3 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |  104 +
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |  241 ++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |  269 +++
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |   42 +
 drivers/gpu/drm/ast/ast_drv.h                      |    4 +-
 drivers/gpu/drm/ast/ast_fb.c                       |    7 +-
 drivers/gpu/drm/ast/ast_ttm.c                      |   10 +-
 drivers/gpu/drm/bochs/bochs.h                      |    9 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |  194 +-
 drivers/gpu/drm/bochs/bochs_mm.c                   |   10 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    6 +-
 drivers/gpu/drm/bridge/tc358767.c                  |    4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  140 +-
 drivers/gpu/drm/cirrus/Kconfig                     |    2 +-
 drivers/gpu/drm/cirrus/Makefile                    |    3 -
 drivers/gpu/drm/cirrus/cirrus.c                    |  657 ++++++
 drivers/gpu/drm/cirrus/cirrus_drv.c                |  161 --
 drivers/gpu/drm/cirrus/cirrus_drv.h                |    4 +-
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |  315 ---
 drivers/gpu/drm/cirrus/cirrus_main.c               |  328 ---
 drivers/gpu/drm/cirrus/cirrus_mode.c               |  621 -----
 drivers/gpu/drm/cirrus/cirrus_ttm.c                |   10 +-
 drivers/gpu/drm/drm_atomic.c                       |   45 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   19 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |    4 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   71 +-
 drivers/gpu/drm/drm_auth.c                         |   21 +-
 drivers/gpu/drm/drm_bufs.c                         |    8 +
 drivers/gpu/drm/drm_client.c                       |   11 +-
 drivers/gpu/drm/drm_connector.c                    |   97 +-
 drivers/gpu/drm/drm_crtc.c                         |    4 +
 drivers/gpu/drm/drm_crtc_internal.h                |    1 +
 drivers/gpu/drm/drm_dp_mst_topology.c              |    1 -
 drivers/gpu/drm/drm_drv.c                          |  223 +-
 drivers/gpu/drm/drm_dsc.c                          |  269 ++-
 drivers/gpu/drm/drm_edid.c                         |  105 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  302 ++-
 drivers/gpu/drm/drm_file.c                         |   26 +-
 drivers/gpu/drm/drm_format_helper.c                |  324 +++
 drivers/gpu/drm/drm_fourcc.c                       |   27 +
 drivers/gpu/drm/drm_gem.c                          |  320 ++-
 drivers/gpu/drm/drm_gem_cma_helper.c               |    8 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |  625 +++++
 drivers/gpu/drm/drm_internal.h                     |   10 +
 drivers/gpu/drm/drm_ioc32.c                        |   13 +-
 drivers/gpu/drm/drm_ioctl.c                        |   86 +-
 drivers/gpu/drm/drm_irq.c                          |    2 +
 drivers/gpu/drm/drm_kms_helper_common.c            |    2 +-
 drivers/gpu/drm/drm_lease.c                        |   13 +-
 drivers/gpu/drm/drm_legacy.h                       |   87 +-
 drivers/gpu/drm/drm_legacy_misc.c                  |   82 +
 drivers/gpu/drm/drm_lock.c                         |   19 +
 drivers/gpu/drm/drm_memory.c                       |   26 +-
 drivers/gpu/drm/drm_mode_config.c                  |    5 +-
 drivers/gpu/drm/drm_mode_object.c                  |    5 +-
 drivers/gpu/drm/drm_modes.c                        |   12 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   13 +
 drivers/gpu/drm/drm_plane.c                        |    8 +
 drivers/gpu/drm/drm_prime.c                        |    1 +
 drivers/gpu/drm/drm_print.c                        |   28 +
 drivers/gpu/drm/drm_syncobj.c                      |  449 +++-
 drivers/gpu/drm/drm_vm.c                           |    6 +-
 drivers/gpu/drm/drm_writeback.c                    |   73 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    6 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   40 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |    4 -
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |    7 -
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |   22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |    6 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |    6 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c         |   26 +-
 drivers/gpu/drm/exynos/exynos_dp.c                 |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |    7 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.c             |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   30 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   97 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   48 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   51 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |   35 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   72 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |   71 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h            |    9 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |   29 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |   15 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |    6 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   49 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   75 +-
 drivers/gpu/drm/exynos/exynos_mixer.c              |   43 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |    2 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    7 +-
 drivers/gpu/drm/gma500/framebuffer.h               |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |    9 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    7 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |   12 +-
 drivers/gpu/drm/i915/.gitignore                    |    1 +
 drivers/gpu/drm/i915/Makefile                      |    8 +-
 drivers/gpu/drm/i915/Makefile.header-test          |   47 +
 drivers/gpu/drm/i915/gvt/Makefile                  |    2 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   74 +-
 drivers/gpu/drm/i915/gvt/display.c                 |    1 -
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |    2 +-
 drivers/gpu/drm/i915/gvt/execlist.c                |   28 +-
 drivers/gpu/drm/i915/gvt/execlist.h                |    2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |    7 +
 drivers/gpu/drm/i915/gvt/gtt.h                     |    2 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   17 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  189 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |    2 +-
 drivers/gpu/drm/i915/gvt/mmio.c                    |    8 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |  247 +-
 drivers/gpu/drm/i915/gvt/reg.h                     |   34 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |   39 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |    6 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |    6 +-
 drivers/gpu/drm/i915/i915_active.c                 |   23 +-
 drivers/gpu/drm/i915/i915_active.h                 |   16 -
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   12 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  173 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  622 +++--
 drivers/gpu/drm/i915/i915_drv.h                    |  408 ++--
 drivers/gpu/drm/i915/i915_gem.c                    |  780 +++----
 drivers/gpu/drm/i915/i915_gem.h                    |    9 +-
 drivers/gpu/drm/i915/i915_gem_context.c            | 1101 ++++++---
 drivers/gpu/drm/i915/i915_gem_context.h            |  260 +--
 drivers/gpu/drm/i915/i915_gem_context_types.h      |  175 ++
 drivers/gpu/drm/i915/i915_gem_dmabuf.c             |    3 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |   18 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   42 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |  156 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  141 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |   26 +-
 drivers/gpu/drm/i915/i915_gem_internal.c           |    2 +-
 drivers/gpu/drm/i915/i915_gem_object.c             |   42 +
 drivers/gpu/drm/i915/i915_gem_object.h             |    8 +-
 drivers/gpu/drm/i915/i915_gem_render_state.c       |    4 +-
 drivers/gpu/drm/i915/i915_gem_stolen.c             |    2 +-
 drivers/gpu/drm/i915/i915_gem_tiling.c             |    6 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |    6 +-
 drivers/gpu/drm/i915/i915_globals.c                |  125 +
 drivers/gpu/drm/i915/i915_globals.h                |   35 +
 drivers/gpu/drm/i915/i915_gpu_error.c              |  183 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |   51 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  665 ++++--
 drivers/gpu/drm/i915/i915_pci.c                    |  262 ++-
 drivers/gpu/drm/i915/i915_perf.c                   |  114 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   67 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |   42 +
 drivers/gpu/drm/i915/i915_pvinfo.h                 |    2 +-
 drivers/gpu/drm/i915/i915_query.c                  |   39 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  571 +++--
 drivers/gpu/drm/i915/i915_request.c                |  498 +++-
 drivers/gpu/drm/i915/i915_request.h                |   87 +-
 drivers/gpu/drm/i915/i915_reset.c                  |  621 +++--
 drivers/gpu/drm/i915/i915_reset.h                  |   16 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |  112 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |   95 +-
 drivers/gpu/drm/i915/i915_scheduler_types.h        |   72 +
 drivers/gpu/drm/i915/i915_suspend.c                |    4 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |   43 +-
 drivers/gpu/drm/i915/i915_sw_fence.h               |   16 +-
 drivers/gpu/drm/i915/i915_timeline.c               |  301 ++-
 drivers/gpu/drm/i915/i915_timeline.h               |   89 +-
 drivers/gpu/drm/i915/i915_timeline_types.h         |   70 +
 drivers/gpu/drm/i915/i915_trace.h                  |  106 +-
 drivers/gpu/drm/i915/i915_user_extensions.c        |   61 +
 drivers/gpu/drm/i915/i915_user_extensions.h        |   20 +
 drivers/gpu/drm/i915/i915_utils.h                  |   31 +
 drivers/gpu/drm/i915/i915_vgpu.c                   |   11 +-
 drivers/gpu/drm/i915/i915_vgpu.h                   |    2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   51 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    3 +
 drivers/gpu/drm/i915/icl_dsi.c                     |   51 +-
 drivers/gpu/drm/i915/intel_atomic.c                |    6 +-
 drivers/gpu/drm/i915/intel_atomic_plane.c          |   59 +-
 drivers/gpu/drm/i915/intel_atomic_plane.h          |   40 +
 drivers/gpu/drm/i915/intel_audio.c                 |   95 +-
 drivers/gpu/drm/i915/intel_audio.h                 |   24 +
 drivers/gpu/drm/i915/intel_bios.c                  |  133 +-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |   14 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |  382 ++--
 drivers/gpu/drm/i915/intel_cdclk.h                 |   46 +
 drivers/gpu/drm/i915/intel_color.c                 | 1131 ++++++---
 drivers/gpu/drm/i915/intel_color.h                 |   17 +
 drivers/gpu/drm/i915/intel_combo_phy.c             |    3 +-
 drivers/gpu/drm/i915/intel_connector.c             |   19 +-
 drivers/gpu/drm/i915/intel_connector.h             |   35 +
 drivers/gpu/drm/i915/intel_context.c               |  269 +++
 drivers/gpu/drm/i915/intel_context.h               |   87 +
 drivers/gpu/drm/i915/intel_context_types.h         |   74 +
 drivers/gpu/drm/i915/intel_crt.c                   |   13 +-
 drivers/gpu/drm/i915/intel_crt.h                   |   21 +
 drivers/gpu/drm/i915/intel_csr.c                   |    5 +-
 drivers/gpu/drm/i915/intel_csr.h                   |   17 +
 drivers/gpu/drm/i915/intel_ddi.c                   |  327 ++-
 drivers/gpu/drm/i915/intel_ddi.h                   |   53 +
 drivers/gpu/drm/i915/intel_device_info.c           |  136 +-
 drivers/gpu/drm/i915/intel_device_info.h           |   46 +-
 drivers/gpu/drm/i915/intel_display.c               |  804 +++++--
 drivers/gpu/drm/i915/intel_dp.c                    |  589 ++++-
 drivers/gpu/drm/i915/intel_dp.h                    |  122 +
 drivers/gpu/drm/i915/intel_dp_link_training.c      |    1 +
 drivers/gpu/drm/i915/intel_dp_mst.c                |  154 +-
 drivers/gpu/drm/i915/intel_dpio_phy.c              |    6 +-
 drivers/gpu/drm/i915/intel_dpll_mgr.c              |  770 ++++---
 drivers/gpu/drm/i915/intel_dpll_mgr.h              |    5 +-
 drivers/gpu/drm/i915/intel_drv.h                   |  666 ++----
 drivers/gpu/drm/i915/intel_dsi.h                   |    1 -
 drivers/gpu/drm/i915/intel_dsi_vbt.c               |   24 +-
 drivers/gpu/drm/i915/intel_dvo.c                   |   10 +-
 drivers/gpu/drm/i915/intel_dvo.h                   |   13 +
 drivers/gpu/drm/i915/intel_engine_cs.c             |  491 ++--
 drivers/gpu/drm/i915/intel_engine_types.h          |  546 +++++
 drivers/gpu/drm/i915/intel_fbc.c                   |    6 +-
 drivers/gpu/drm/i915/intel_fbc.h                   |   42 +
 drivers/gpu/drm/i915/intel_fbdev.c                 |  245 +-
 drivers/gpu/drm/i915/intel_fbdev.h                 |   53 +
 drivers/gpu/drm/i915/intel_fifo_underrun.c         |    1 +
 drivers/gpu/drm/i915/intel_frontbuffer.c           |    5 +-
 drivers/gpu/drm/i915/intel_frontbuffer.h           |   10 +
 drivers/gpu/drm/i915/intel_gpu_commands.h          |    9 +-
 drivers/gpu/drm/i915/intel_guc.c                   |   45 +-
 drivers/gpu/drm/i915/intel_guc.h                   |    4 +-
 drivers/gpu/drm/i915/intel_guc_ads.c               |    3 +-
 drivers/gpu/drm/i915/intel_guc_ct.c                |   99 +-
 drivers/gpu/drm/i915/intel_guc_ct.h                |    3 +
 drivers/gpu/drm/i915/intel_guc_fw.c                |    4 +-
 drivers/gpu/drm/i915/intel_guc_log.c               |    5 +
 drivers/gpu/drm/i915/intel_guc_submission.c        |  133 +-
 drivers/gpu/drm/i915/intel_guc_submission.h        |    1 +
 drivers/gpu/drm/i915/intel_hangcheck.c             |   26 +-
 drivers/gpu/drm/i915/intel_hdcp.c                  | 1261 +++++++++-
 drivers/gpu/drm/i915/intel_hdcp.h                  |   33 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |  800 ++++++-
 drivers/gpu/drm/i915/intel_hdmi.h                  |   51 +
 drivers/gpu/drm/i915/intel_huc.c                   |    2 +-
 drivers/gpu/drm/i915/intel_huc_fw.c                |   27 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    2 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |  904 ++++----
 drivers/gpu/drm/i915/intel_lrc.h                   |   35 +-
 drivers/gpu/drm/i915/intel_lspcon.c                |   19 +-
 drivers/gpu/drm/i915/intel_lspcon.h                |   38 +
 drivers/gpu/drm/i915/intel_lvds.c                  |  101 +-
 drivers/gpu/drm/i915/intel_lvds.h                  |   22 +
 drivers/gpu/drm/i915/intel_mocs.c                  |   14 +-
 drivers/gpu/drm/i915/intel_opregion.c              |    3 +-
 drivers/gpu/drm/i915/intel_overlay.c               |    6 +-
 drivers/gpu/drm/i915/intel_panel.c                 |  150 +-
 drivers/gpu/drm/i915/intel_panel.h                 |   65 +
 drivers/gpu/drm/i915/intel_pipe_crc.c              |  232 +-
 drivers/gpu/drm/i915/intel_pipe_crc.h              |   35 +
 drivers/gpu/drm/i915/intel_pm.c                    |  555 +++--
 drivers/gpu/drm/i915/intel_pm.h                    |   71 +
 drivers/gpu/drm/i915/intel_psr.c                   |  318 +--
 drivers/gpu/drm/i915/intel_psr.h                   |   40 +
 drivers/gpu/drm/i915/intel_ringbuffer.c            |  435 ++--
 drivers/gpu/drm/i915/intel_ringbuffer.h            |  650 +-----
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   99 +-
 drivers/gpu/drm/i915/intel_sdvo.c                  |  169 +-
 drivers/gpu/drm/i915/intel_sdvo.h                  |   23 +
 drivers/gpu/drm/i915/intel_sideband.c              |   12 +-
 drivers/gpu/drm/i915/intel_sprite.c                |  260 ++-
 drivers/gpu/drm/i915/intel_sprite.h                |   55 +
 drivers/gpu/drm/i915/intel_tv.c                    |    5 +-
 drivers/gpu/drm/i915/intel_tv.h                    |   13 +
 drivers/gpu/drm/i915/intel_uc.c                    |   25 +-
 drivers/gpu/drm/i915/intel_uc.h                    |    1 +
 drivers/gpu/drm/i915/intel_uncore.c                |  996 ++++----
 drivers/gpu/drm/i915/intel_uncore.h                |  286 ++-
 drivers/gpu/drm/i915/intel_vbt_defs.h              |    3 +
 drivers/gpu/drm/i915/intel_vdsc.c                  |  133 +-
 drivers/gpu/drm/i915/intel_workarounds.c           |  187 +-
 drivers/gpu/drm/i915/intel_workarounds.h           |   19 +-
 drivers/gpu/drm/i915/intel_workarounds_types.h     |   27 +
 drivers/gpu/drm/i915/selftests/huge_gem_object.c   |    2 +-
 drivers/gpu/drm/i915/selftests/huge_pages.c        |   25 +-
 drivers/gpu/drm/i915/selftests/i915_active.c       |    2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   12 +-
 .../gpu/drm/i915/selftests/i915_gem_coherency.c    |    8 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |  457 +++-
 drivers/gpu/drm/i915/selftests/i915_gem_dmabuf.c   |    1 +
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |    6 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   21 +-
 drivers/gpu/drm/i915/selftests/i915_gem_object.c   |    4 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |   37 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |    4 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c     |    9 +-
 drivers/gpu/drm/i915/selftests/i915_timeline.c     |  120 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   16 +-
 drivers/gpu/drm/i915/selftests/igt_flush_test.c    |    4 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |    9 +-
 drivers/gpu/drm/i915/selftests/intel_guc.c         |    4 +-
 drivers/gpu/drm/i915/selftests/intel_hangcheck.c   |  301 ++-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |  446 +++-
 drivers/gpu/drm/i915/selftests/intel_uncore.c      |  166 +-
 drivers/gpu/drm/i915/selftests/intel_workarounds.c |  423 +++-
 drivers/gpu/drm/i915/selftests/mock_context.c      |   34 +-
 drivers/gpu/drm/i915/selftests/mock_engine.c       |  145 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |   54 +-
 drivers/gpu/drm/i915/selftests/mock_request.c      |   12 +-
 drivers/gpu/drm/i915/selftests/mock_request.h      |    7 -
 drivers/gpu/drm/i915/selftests/mock_timeline.c     |    2 +-
 drivers/gpu/drm/i915/selftests/mock_uncore.c       |   10 +-
 drivers/gpu/drm/i915/selftests/mock_uncore.h       |    2 +-
 drivers/gpu/drm/i915/vlv_dsi.c                     |   84 +-
 drivers/gpu/drm/i915/vlv_dsi_pll.c                 |    4 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |    2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |    2 +-
 drivers/gpu/drm/lima/Kconfig                       |   13 +
 drivers/gpu/drm/lima/Makefile                      |   21 +
 drivers/gpu/drm/lima/lima_bcast.c                  |   47 +
 drivers/gpu/drm/lima/lima_bcast.h                  |   14 +
 drivers/gpu/drm/lima/lima_ctx.c                    |   98 +
 drivers/gpu/drm/lima/lima_ctx.h                    |   30 +
 drivers/gpu/drm/lima/lima_device.c                 |  385 ++++
 drivers/gpu/drm/lima/lima_device.h                 |  131 ++
 drivers/gpu/drm/lima/lima_dlbu.c                   |   58 +
 drivers/gpu/drm/lima/lima_dlbu.h                   |   18 +
 drivers/gpu/drm/lima/lima_drv.c                    |  376 +++
 drivers/gpu/drm/lima/lima_drv.h                    |   45 +
 drivers/gpu/drm/lima/lima_gem.c                    |  349 +++
 drivers/gpu/drm/lima/lima_gem.h                    |   25 +
 drivers/gpu/drm/lima/lima_gem_prime.c              |   47 +
 drivers/gpu/drm/lima/lima_gem_prime.h              |   13 +
 drivers/gpu/drm/lima/lima_gp.c                     |  283 +++
 drivers/gpu/drm/lima/lima_gp.h                     |   16 +
 drivers/gpu/drm/lima/lima_l2_cache.c               |   80 +
 drivers/gpu/drm/lima/lima_l2_cache.h               |   14 +
 drivers/gpu/drm/lima/lima_mmu.c                    |  142 ++
 drivers/gpu/drm/lima/lima_mmu.h                    |   16 +
 drivers/gpu/drm/lima/lima_object.c                 |  122 +
 drivers/gpu/drm/lima/lima_object.h                 |   36 +
 drivers/gpu/drm/lima/lima_pmu.c                    |   60 +
 drivers/gpu/drm/lima/lima_pmu.h                    |   12 +
 drivers/gpu/drm/lima/lima_pp.c                     |  427 ++++
 drivers/gpu/drm/lima/lima_pp.h                     |   19 +
 drivers/gpu/drm/lima/lima_regs.h                   |  298 +++
 drivers/gpu/drm/lima/lima_sched.c                  |  362 +++
 drivers/gpu/drm/lima/lima_sched.h                  |  102 +
 drivers/gpu/drm/lima/lima_vm.c                     |  282 +++
 drivers/gpu/drm/lima/lima_vm.h                     |   62 +
 drivers/gpu/drm/meson/Makefile                     |    2 +-
 drivers/gpu/drm/meson/meson_canvas.c               |   73 -
 drivers/gpu/drm/meson/meson_canvas.h               |   51 -
 drivers/gpu/drm/meson/meson_crtc.c                 |  353 ++-
 drivers/gpu/drm/meson/meson_drv.c                  |   83 +-
 drivers/gpu/drm/meson/meson_drv.h                  |    5 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  163 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.h              |   32 +-
 drivers/gpu/drm/meson/meson_overlay.c              |   18 +-
 drivers/gpu/drm/meson/meson_plane.c                |   21 +-
 drivers/gpu/drm/meson/meson_registers.h            |  247 ++
 drivers/gpu/drm/meson/meson_vclk.c                 |  123 +-
 drivers/gpu/drm/meson/meson_venc.c                 |   11 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |   25 +-
 drivers/gpu/drm/meson/meson_viu.c                  |   85 +-
 drivers/gpu/drm/meson/meson_vpp.c                  |   51 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |    3 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c               |    8 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |   10 +-
 drivers/gpu/drm/msm/Kconfig                        |    5 +
 drivers/gpu/drm/msm/Makefile                       |    9 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  109 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  216 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |    9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   63 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |    3 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |    2 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  141 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |    6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   69 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  119 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   15 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |    5 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  177 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |    3 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c   |    4 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |    2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   15 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    8 +-
 drivers/gpu/drm/msm/msm_fbdev.c                    |    6 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   69 +-
 drivers/gpu/drm/msm/msm_gem.h                      |    8 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |    7 -
 drivers/gpu/drm/msm/msm_gem_submit.c               |   52 +-
 drivers/gpu/drm/msm/msm_gem_vma.c                  |    2 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   17 +-
 drivers/gpu/drm/msm/msm_gpu.h                      |    3 +
 drivers/gpu/drm/msm/msm_iommu.c                    |   13 +-
 drivers/gpu/drm/msm/msm_submitqueue.c              |   41 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |    6 +-
 drivers/gpu/drm/nouveau/Kbuild                     |    8 +-
 drivers/gpu/drm/nouveau/Kconfig                    |   13 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h  |    2 +
 drivers/gpu/drm/nouveau/nouveau_display.c          |    9 -
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   19 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |    2 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |    8 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.h            |    2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    4 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c    |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c     |   14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c  |    2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c      |   26 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h      |    2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c     |   15 +
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.c      |   21 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.h      |    1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c      |    2 +-
 drivers/gpu/drm/omapdrm/displays/Kconfig           |   17 -
 drivers/gpu/drm/omapdrm/displays/Makefile          |    3 -
 .../gpu/drm/omapdrm/displays/connector-analog-tv.c |   45 +-
 drivers/gpu/drm/omapdrm/displays/connector-dvi.c   |  330 ---
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c  |   45 +-
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c  |   39 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c  |  170 --
 .../gpu/drm/omapdrm/displays/encoder-tpd12s015.c   |   40 -
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c       |  221 --
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |  140 +-
 .../omapdrm/displays/panel-lgphilips-lb035q02.c    |   41 +-
 .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |   41 +-
 .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |   61 +-
 .../drm/omapdrm/displays/panel-sony-acx565akm.c    |   55 +-
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |   58 +-
 .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    |   48 +-
 drivers/gpu/drm/omapdrm/dss/base.c                 |  144 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |   24 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |   64 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  110 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c               |   60 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   54 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   54 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |   18 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   76 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |   36 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |   68 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |  229 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |  181 +-
 drivers/gpu/drm/omapdrm/omap_connector.h           |    8 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   13 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  236 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |    2 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |  211 +-
 drivers/gpu/drm/omapdrm/omap_encoder.h             |    3 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |    6 +-
 drivers/gpu/drm/panel/Kconfig                      |   31 +
 drivers/gpu/drm/panel/Makefile                     |    3 +
 drivers/gpu/drm/panel/panel-arm-versatile.c        |    6 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |  272 +++
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |    6 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |    1 -
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   20 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |    3 +-
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |  387 ++++
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |  258 +++
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |    3 -
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |    2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   84 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   12 +-
 drivers/gpu/drm/panfrost/Kconfig                   |   14 +
 drivers/gpu/drm/panfrost/Makefile                  |   12 +
 drivers/gpu/drm/panfrost/TODO                      |   27 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  219 ++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |   14 +
 drivers/gpu/drm/panfrost/panfrost_device.c         |  253 ++
 drivers/gpu/drm/panfrost/panfrost_device.h         |  125 +
 drivers/gpu/drm/panfrost/panfrost_drv.c            |  474 ++++
 drivers/gpu/drm/panfrost/panfrost_features.h       |  309 +++
 drivers/gpu/drm/panfrost/panfrost_gem.c            |   95 +
 drivers/gpu/drm/panfrost/panfrost_gem.h            |   29 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |  367 +++
 drivers/gpu/drm/panfrost/panfrost_gpu.h            |   19 +
 drivers/gpu/drm/panfrost/panfrost_issues.h         |  176 ++
 drivers/gpu/drm/panfrost/panfrost_job.c            |  564 +++++
 drivers/gpu/drm/panfrost/panfrost_job.h            |   51 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  386 ++++
 drivers/gpu/drm/panfrost/panfrost_mmu.h            |   17 +
 drivers/gpu/drm/panfrost/panfrost_regs.h           |  298 +++
 drivers/gpu/drm/pl111/pl111_display.c              |    2 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |    4 +
 drivers/gpu/drm/qxl/qxl_display.c                  |    8 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    3 -
 drivers/gpu/drm/qxl/qxl_ttm.c                      |   11 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    2 +-
 drivers/gpu/drm/radeon/radeon_drv.h                |    1 -
 drivers/gpu/drm/radeon/radeon_fb.c                 |   11 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |   17 +-
 drivers/gpu/drm/rcar-du/Kconfig                    |    4 +
 drivers/gpu/drm/rcar-du/Makefile                   |    3 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   64 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   13 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |   54 +-
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   37 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.h              |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |  122 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.h              |   17 +
 drivers/gpu/drm/rcar-du/rcar_du_writeback.c        |  243 ++
 drivers/gpu/drm/rcar-du/rcar_du_writeback.h        |   39 +
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |   19 +-
 drivers/gpu/drm/rockchip/Kconfig                   |    8 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |  876 +++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h             |  229 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   11 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |    6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   11 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   14 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   20 +-
 drivers/gpu/drm/selftests/test-drm_mm.c            |   12 +-
 drivers/gpu/drm/stm/Kconfig                        |    2 +-
 drivers/gpu/drm/stm/drv.c                          |   35 +
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |   28 +
 drivers/gpu/drm/stm/ltdc.c                         |   24 +
 drivers/gpu/drm/stm/ltdc.h                         |    3 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |   63 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                 |    1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   40 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   29 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   74 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   12 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |    2 -
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  179 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h             |    2 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |   49 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |    2 +
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |    4 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   54 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h             |   11 +
 drivers/gpu/drm/tegra/fb.c                         |    4 +-
 drivers/gpu/drm/tegra/gem.c                        |    4 +-
 drivers/gpu/drm/tegra/sor.c                        |   21 +-
 drivers/gpu/drm/tinydrm/core/Makefile              |    2 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-core.c        |  183 --
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |  160 +-
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |   24 +-
 drivers/gpu/drm/tinydrm/hx8357d.c                  |   59 +-
 drivers/gpu/drm/tinydrm/ili9225.c                  |   87 +-
 drivers/gpu/drm/tinydrm/ili9341.c                  |   59 +-
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   67 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |  185 +-
 drivers/gpu/drm/tinydrm/repaper.c                  |  147 +-
 drivers/gpu/drm/tinydrm/st7586.c                   |  148 +-
 drivers/gpu/drm/tinydrm/st7735r.c                  |   59 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    3 +
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |    2 -
 drivers/gpu/drm/ttm/ttm_memory.c                   |   10 +-
 drivers/gpu/drm/tve200/tve200_display.c            |    3 +-
 drivers/gpu/drm/udl/udl_drv.c                      |   57 +-
 drivers/gpu/drm/udl/udl_drv.h                      |    9 +-
 drivers/gpu/drm/udl/udl_fb.c                       |   20 +-
 drivers/gpu/drm/udl/udl_gem.c                      |    2 +-
 drivers/gpu/drm/udl/udl_main.c                     |   35 +-
 drivers/gpu/drm/v3d/Kconfig                        |    1 +
 drivers/gpu/drm/v3d/v3d_bo.c                       |  314 +--
 drivers/gpu/drm/v3d/v3d_debugfs.c                  |    8 +
 drivers/gpu/drm/v3d/v3d_drv.c                      |   65 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |   37 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |  110 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |   67 +-
 drivers/gpu/drm/v3d/v3d_mmu.c                      |   11 +-
 drivers/gpu/drm/v3d/v3d_regs.h                     |    2 +
 drivers/gpu/drm/v3d/v3d_sched.c                    |   25 +-
 drivers/{staging =3D> gpu/drm}/vboxvideo/Kconfig     |    0
 drivers/{staging =3D> gpu/drm}/vboxvideo/Makefile    |    0
 .../{staging =3D> gpu/drm}/vboxvideo/hgsmi_base.c    |    0
 .../drm}/vboxvideo/hgsmi_ch_setup.h                |    0
 .../drm}/vboxvideo/hgsmi_channels.h                |    0
 .../{staging =3D> gpu/drm}/vboxvideo/hgsmi_defs.h    |    0
 .../{staging =3D> gpu/drm}/vboxvideo/modesetting.c   |    0
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_drv.c  |   25 -
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_drv.h  |    9 -
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_fb.c   |    8 +-
 .../{staging =3D> gpu/drm}/vboxvideo/vbox_hgsmi.c    |    0
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_irq.c  |   10 +-
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_main.c |    6 +-
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_mode.c |   21 +-
 .../{staging =3D> gpu/drm}/vboxvideo/vbox_prime.c    |    0
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_ttm.c  |   12 +-
 drivers/{staging =3D> gpu/drm}/vboxvideo/vboxvideo.h |    0
 .../drm}/vboxvideo/vboxvideo_guest.h               |    0
 .../{staging =3D> gpu/drm}/vboxvideo/vboxvideo_vbe.h |    0
 drivers/{staging =3D> gpu/drm}/vboxvideo/vbva_base.c |    0
 drivers/gpu/drm/vc4/vc4_bo.c                       |   69 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |  105 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |   90 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                      |   39 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   42 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   77 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |  175 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   49 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  162 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  180 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |    9 +
 drivers/gpu/drm/vc4/vc4_kms.c                      |  123 +-
 drivers/gpu/drm/vc4/vc4_perfmon.c                  |   18 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   59 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |   51 +-
 drivers/gpu/drm/vc4/vc4_render_cl.c                |   23 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |   49 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  240 +-
 drivers/gpu/drm/vc4/vc4_vec.c                      |   83 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |   27 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |    1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c               |    4 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |   46 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    4 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |   35 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |  107 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |   74 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |   22 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |  102 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |   36 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |   98 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.h            |    2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |   24 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |   59 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |   23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   30 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            | 1505 ++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c               |   27 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c                |    9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |   12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |   25 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |    4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   23 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   44 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c    |   12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |   45 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.h                 |    1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   47 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |   80 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |   11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |   61 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |    7 +
 drivers/gpu/drm/xen/xen_drm_front.c                |    1 +
 drivers/iommu/io-pgtable-arm.c                     |   91 +-
 drivers/iommu/io-pgtable.c                         |    1 +
 drivers/media/platform/vsp1/vsp1_brx.c             |    1 +
 drivers/media/platform/vsp1/vsp1_clu.c             |    1 +
 drivers/media/platform/vsp1/vsp1_dl.c              |   84 +-
 drivers/media/platform/vsp1/vsp1_dl.h              |    6 +-
 drivers/media/platform/vsp1/vsp1_drm.c             |   94 +-
 drivers/media/platform/vsp1/vsp1_drm.h             |    2 +-
 drivers/media/platform/vsp1/vsp1_entity.c          |    3 +-
 drivers/media/platform/vsp1/vsp1_entity.h          |    7 +-
 drivers/media/platform/vsp1/vsp1_hgo.c             |    1 +
 drivers/media/platform/vsp1/vsp1_hgt.c             |    1 +
 drivers/media/platform/vsp1/vsp1_hsit.c            |    1 +
 drivers/media/platform/vsp1/vsp1_lif.c             |    1 +
 drivers/media/platform/vsp1/vsp1_lut.c             |    1 +
 drivers/media/platform/vsp1/vsp1_regs.h            |    6 +-
 drivers/media/platform/vsp1/vsp1_rpf.c             |    1 +
 drivers/media/platform/vsp1/vsp1_rwpf.h            |    1 +
 drivers/media/platform/vsp1/vsp1_sru.c             |    1 +
 drivers/media/platform/vsp1/vsp1_uds.c             |    1 +
 drivers/media/platform/vsp1/vsp1_uif.c             |    1 +
 drivers/media/platform/vsp1/vsp1_video.c           |   16 +-
 drivers/media/platform/vsp1/vsp1_wpf.c             |   83 +-
 drivers/reset/core.c                               |  180 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/vboxvideo/TODO                     |   10 -
 drivers/usb/dwc3/dwc3-of-simple.c                  |    3 +-
 include/drm/drm_atomic.h                           |    6 +
 include/drm/drm_audio_component.h                  |    7 +-
 include/drm/drm_auth.h                             |    6 +-
 include/drm/drm_bridge.h                           |   11 +-
 include/drm/drm_cache.h                            |    2 +-
 include/drm/drm_client.h                           |    2 +-
 include/drm/drm_connector.h                        |  136 +-
 include/drm/drm_crtc.h                             |    4 +-
 include/drm/drm_device.h                           |    3 +-
 include/drm/drm_drv.h                              |   16 +-
 include/drm/drm_dsc.h                              |    9 +-
 include/drm/drm_edid.h                             |    6 +
 include/drm/drm_fb_helper.h                        |   48 +-
 include/drm/drm_file.h                             |    2 +
 include/drm/drm_format_helper.h                    |   35 +
 include/drm/drm_framebuffer.h                      |    1 +
 include/drm/drm_gem.h                              |   32 +
 include/drm/drm_gem_shmem_helper.h                 |  159 ++
 include/drm/drm_hdcp.h                             |    7 +-
 include/drm/drm_legacy.h                           |    2 -
 include/drm/drm_modes.h                            |   17 +
 include/drm/drm_modeset_helper_vtables.h           |    7 +
 include/drm/drm_print.h                            |    2 +
 include/drm/drm_syncobj.h                          |    5 +
 include/drm/drm_utils.h                            |    4 +
 include/drm/drm_vma_manager.h                      |   12 +
 include/drm/drm_writeback.h                        |   30 +-
 include/drm/i915_pciids.h                          |  217 +-
 include/drm/tinydrm/mipi-dbi.h                     |   32 +-
 include/drm/tinydrm/tinydrm-helpers.h              |   21 +-
 include/drm/tinydrm/tinydrm.h                      |   75 -
 include/drm/ttm/ttm_bo_driver.h                    |    2 +-
 include/linux/dma-fence-chain.h                    |   81 +
 include/linux/dma-fence.h                          |   21 +-
 include/linux/io-pgtable.h                         |    7 +
 include/linux/reservation.h                        |    3 +-
 include/linux/reset.h                              |  113 +-
 include/media/vsp1.h                               |   19 +-
 include/sound/hdaudio.h                            |    2 +-
 include/uapi/drm/amdgpu_drm.h                      |   43 +
 include/uapi/drm/drm.h                             |   37 +
 include/uapi/drm/drm_fourcc.h                      |   51 +-
 include/uapi/drm/drm_mode.h                        |    4 +-
 include/uapi/drm/i915_drm.h                        |  254 ++-
 include/uapi/drm/lima_drm.h                        |  169 ++
 include/uapi/drm/msm_drm.h                         |   14 +
 include/uapi/drm/panfrost_drm.h                    |  142 ++
 include/uapi/linux/kfd_ioctl.h                     |   12 +-
 include/uapi/linux/virtio_gpu.h                    |   12 +-
 sound/hda/hdac_component.c                         |   18 +-
 1012 files changed, 63793 insertions(+), 24015 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/lg,acx467akm-7.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/osddisplays,osd070t1718-19t=
s.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/ste,mcde.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.=
txt
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 create mode 100644 drivers/dma-buf/dma-fence-chain.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
 delete mode 100644 drivers/gpu/drm/amd/include/linux/chash.h
 delete mode 100644 drivers/gpu/drm/amd/lib/Kconfig
 delete mode 100644 drivers/gpu/drm/amd/lib/Makefile
 delete mode 100644 drivers/gpu/drm/amd/lib/chash.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/smu9_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_baco.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smu_v11_0.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/vega20_ppt.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_stat=
e.c
 create mode 100644 drivers/gpu/drm/aspeed/Kconfig
 create mode 100644 drivers/gpu/drm/aspeed/Makefile
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx.h
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_out.c
 create mode 100644 drivers/gpu/drm/cirrus/cirrus.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_drv.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_fbdev.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_main.c
 delete mode 100644 drivers/gpu/drm/cirrus/cirrus_mode.c
 create mode 100644 drivers/gpu/drm/drm_format_helper.c
 create mode 100644 drivers/gpu/drm/drm_gem_shmem_helper.c
 create mode 100644 drivers/gpu/drm/drm_legacy_misc.c
 create mode 100644 drivers/gpu/drm/i915/.gitignore
 create mode 100644 drivers/gpu/drm/i915/Makefile.header-test
 create mode 100644 drivers/gpu/drm/i915/i915_gem_context_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_globals.c
 create mode 100644 drivers/gpu/drm/i915/i915_globals.h
 create mode 100644 drivers/gpu/drm/i915/i915_priolist_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_scheduler_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_timeline_types.h
 create mode 100644 drivers/gpu/drm/i915/i915_user_extensions.c
 create mode 100644 drivers/gpu/drm/i915/i915_user_extensions.h
 create mode 100644 drivers/gpu/drm/i915/intel_atomic_plane.h
 create mode 100644 drivers/gpu/drm/i915/intel_audio.h
 create mode 100644 drivers/gpu/drm/i915/intel_cdclk.h
 create mode 100644 drivers/gpu/drm/i915/intel_color.h
 create mode 100644 drivers/gpu/drm/i915/intel_connector.h
 create mode 100644 drivers/gpu/drm/i915/intel_context.c
 create mode 100644 drivers/gpu/drm/i915/intel_context.h
 create mode 100644 drivers/gpu/drm/i915/intel_context_types.h
 create mode 100644 drivers/gpu/drm/i915/intel_crt.h
 create mode 100644 drivers/gpu/drm/i915/intel_csr.h
 create mode 100644 drivers/gpu/drm/i915/intel_ddi.h
 create mode 100644 drivers/gpu/drm/i915/intel_dp.h
 create mode 100644 drivers/gpu/drm/i915/intel_dvo.h
 create mode 100644 drivers/gpu/drm/i915/intel_engine_types.h
 create mode 100644 drivers/gpu/drm/i915/intel_fbc.h
 create mode 100644 drivers/gpu/drm/i915/intel_fbdev.h
 create mode 100644 drivers/gpu/drm/i915/intel_hdcp.h
 create mode 100644 drivers/gpu/drm/i915/intel_hdmi.h
 create mode 100644 drivers/gpu/drm/i915/intel_lspcon.h
 create mode 100644 drivers/gpu/drm/i915/intel_lvds.h
 create mode 100644 drivers/gpu/drm/i915/intel_panel.h
 create mode 100644 drivers/gpu/drm/i915/intel_pipe_crc.h
 create mode 100644 drivers/gpu/drm/i915/intel_pm.h
 create mode 100644 drivers/gpu/drm/i915/intel_psr.h
 create mode 100644 drivers/gpu/drm/i915/intel_sdvo.h
 create mode 100644 drivers/gpu/drm/i915/intel_sprite.h
 create mode 100644 drivers/gpu/drm/i915/intel_tv.h
 create mode 100644 drivers/gpu/drm/i915/intel_workarounds_types.h
 create mode 100644 drivers/gpu/drm/lima/Kconfig
 create mode 100644 drivers/gpu/drm/lima/Makefile
 create mode 100644 drivers/gpu/drm/lima/lima_bcast.c
 create mode 100644 drivers/gpu/drm/lima/lima_bcast.h
 create mode 100644 drivers/gpu/drm/lima/lima_ctx.c
 create mode 100644 drivers/gpu/drm/lima/lima_ctx.h
 create mode 100644 drivers/gpu/drm/lima/lima_device.c
 create mode 100644 drivers/gpu/drm/lima/lima_device.h
 create mode 100644 drivers/gpu/drm/lima/lima_dlbu.c
 create mode 100644 drivers/gpu/drm/lima/lima_dlbu.h
 create mode 100644 drivers/gpu/drm/lima/lima_drv.c
 create mode 100644 drivers/gpu/drm/lima/lima_drv.h
 create mode 100644 drivers/gpu/drm/lima/lima_gem.c
 create mode 100644 drivers/gpu/drm/lima/lima_gem.h
 create mode 100644 drivers/gpu/drm/lima/lima_gem_prime.c
 create mode 100644 drivers/gpu/drm/lima/lima_gem_prime.h
 create mode 100644 drivers/gpu/drm/lima/lima_gp.c
 create mode 100644 drivers/gpu/drm/lima/lima_gp.h
 create mode 100644 drivers/gpu/drm/lima/lima_l2_cache.c
 create mode 100644 drivers/gpu/drm/lima/lima_l2_cache.h
 create mode 100644 drivers/gpu/drm/lima/lima_mmu.c
 create mode 100644 drivers/gpu/drm/lima/lima_mmu.h
 create mode 100644 drivers/gpu/drm/lima/lima_object.c
 create mode 100644 drivers/gpu/drm/lima/lima_object.h
 create mode 100644 drivers/gpu/drm/lima/lima_pmu.c
 create mode 100644 drivers/gpu/drm/lima/lima_pmu.h
 create mode 100644 drivers/gpu/drm/lima/lima_pp.c
 create mode 100644 drivers/gpu/drm/lima/lima_pp.h
 create mode 100644 drivers/gpu/drm/lima/lima_regs.h
 create mode 100644 drivers/gpu/drm/lima/lima_sched.c
 create mode 100644 drivers/gpu/drm/lima/lima_sched.h
 create mode 100644 drivers/gpu/drm/lima/lima_vm.c
 create mode 100644 drivers/gpu/drm/lima/lima_vm.h
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/connector-dvi.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-dpi.c
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
 create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
 create mode 100644 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
 create mode 100644 drivers/gpu/drm/panfrost/Kconfig
 create mode 100644 drivers/gpu/drm/panfrost/Makefile
 create mode 100644 drivers/gpu/drm/panfrost/TODO
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_writeback.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_writeback.h
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h
 delete mode 100644 drivers/gpu/drm/tinydrm/core/tinydrm-core.c
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/Kconfig (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/Makefile (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/hgsmi_base.c (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/hgsmi_ch_setup.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/hgsmi_channels.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/hgsmi_defs.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/modesetting.c (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_drv.c (89%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_drv.h (96%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_fb.c (94%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_hgsmi.c (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_irq.c (93%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_main.c (98%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_mode.c (97%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_prime.c (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbox_ttm.c (97%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vboxvideo.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vboxvideo_guest.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vboxvideo_vbe.h (100%)
 rename drivers/{staging =3D> gpu/drm}/vboxvideo/vbva_base.c (100%)
 delete mode 100644 drivers/staging/vboxvideo/TODO
 create mode 100644 include/drm/drm_format_helper.h
 create mode 100644 include/drm/drm_gem_shmem_helper.h
 delete mode 100644 include/drm/tinydrm/tinydrm.h
 create mode 100644 include/linux/dma-fence-chain.h
 create mode 100644 include/uapi/drm/lima_drm.h
 create mode 100644 include/uapi/drm/panfrost_drm.h
