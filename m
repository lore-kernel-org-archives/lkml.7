Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE86B21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taD9Q4/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfLFDbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:31:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46159 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:31:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so5971271ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xaaTIPB3u2Qgm/q/0LM/11m5QVoiIfUwTpyk8ed6BRU=;
        b=taD9Q4/Sx2oatFqFBSHo8DgGU8dPkV1i5MLfgDRpuHUhn2is/3i7Ux0dkyI4vtSo0H
         +8ZDirwg1wZn4bOdqr0E3pxsmGSa+67DDmX0kGbT2ZXFEdqw53utxAWQgzdQAlMwBnwl
         Qucg1dbLUP/kVLt01eUmtDG9WrMc9DeWcYucXJm6HT7fAlk43eyazDNGQc4dCe782By8
         wO4/eBoivI35Dc9CxO1IZEyPkIa2mo//8gPhmyJT4VgcJwahXYkhP5Fjila17r/TvJp8
         UYJ8z2rBDwNZ5mtCEZ8zjE0CW+u46iyE2/Y9MnMqdYM2aJTFeqv8G/P45zC1VB+49BBL
         uBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xaaTIPB3u2Qgm/q/0LM/11m5QVoiIfUwTpyk8ed6BRU=;
        b=YrqSmnxpQwBQEYnx7ToDr/2rrSPL0iCyPIKo90YHSXgkrVwSG6eG7+JEQEP+9U9GEa
         OSh9Oy3I4f6y+poEb8N6GN8ffoqAS+6/bZutErfjIqtEcBGsAezXGIa5wudZjDsG6TrM
         0ZoBppx1nHVRGyUsjwMUWmZ2VVDJlZOOwXPRWKdQDQVhf0nHTgbg6FhyyqwOw85j5IPs
         F+zog0rp++iydwo+aeUcdr7yz7yJayDpWeB4mb8cUMoLRCI/wOG56aVw0ERpHf3e7+ix
         BXDdX85DTPw9/kyX5gQv9hcq4+vqpLqORykkAQtEgw+hbPVw0+vNIQU4ynrwxFtUQcJn
         ncNA==
X-Gm-Message-State: APjAAAWeIBLtapNZJZx5KRvNL0rKlmZj4VQ1o+nJlC4nFsfcfrg4qTqd
        wpTNvgjwFY12Ralh30Ah3ia5iFK9xaZg9UdV9vbuybeAFuY=
X-Google-Smtp-Source: APXvYqzi1f+DJpTfNZt2aDnKsz5nD/6gDYpMi3efvi6kyPrxULFpCK93QXvt4jOwlhvj6Fbo87jHGYN3QpIbfSri1bI=
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr7137678ljo.31.1575603078161;
 Thu, 05 Dec 2019 19:31:18 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Dec 2019 13:31:06 +1000
Message-ID: <CAPM=9tzTYPTk9vBxyGruTO_NwYAqk6s+=LRPg2CX9-Zf55Q1sw@mail.gmail.com>
Subject: [git pull] drm msm-next and fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Rob pointed out I missed his pull request for msm-next, it's been in
next for a while outside of my tree so shouldn't cause any unexpected
issues, it has some OCMEM support in drivers/soc that is acked by
other maintainers as it's outside my tree.

Otherwise it's a usual fixes pull, i915, amdgpu, the main ones, with
some tegra, omap, mgag200 and one core fix.

Dave.

drm-next-2019-12-06:
drm msm + fixes for 5.5-rc1

msm-next:
- OCMEM support for a3xx and a4xx GPUs.
- a510 support + display support

core:
- mst payload deletion fix

i915:
- uapi alignment fix
- fix for power usage regression due to security fixes
- change default preemption timeout to 640ms from 100ms
- EHL voltage level display fixes
- TGL DGL PHY fix
- gvt - MI_ATOMIC cmd parser fix, CFL non-priv warning
- CI spotted deadlock fix
- EHL port D programming fix

amdgpu:
- VRAM lost fixes on BACO for CI/VI
- navi14 DC fixes
- misc SR-IOV, gfx10 fixes
- XGMI fixes for arcturus
- SRIOV fixes

amdkfd:
- KFD on ppc64le enabled
- page table optimisations

radeon:
- fix for r1xx/2xx register checker.

tegra:
- displayport regression fixes
- DMA API regression fixes

mgag200:
- fix devices that can't scanout except at 0 addr

omap:
- fix dma_addr refcounting
The following changes since commit acc61b8929365e63a3e8c8c8913177795aa45594:

  Merge tag 'drm-next-5.5-2019-11-22' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2019-11-26
08:40:23 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-12-06

for you to fetch changes up to 9c1867d730a6e1dc23dd633392d102860578c047:

  Merge tag 'drm-intel-next-fixes-2019-12-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2019-12-06
13:10:52 +1000)

----------------------------------------------------------------
drm msm + fixes for 5.5-rc1

msm-next:
- OCMEM support for a3xx and a4xx GPUs.
- a510 support + display support

core:
- mst payload deletion fix

i915:
- uapi alignment fix
- fix for power usage regression due to security fixes
- change default preemption timeout to 640ms from 100ms
- EHL voltage level display fixes
- TGL DGL PHY fix
- gvt - MI_ATOMIC cmd parser fix, CFL non-priv warning
- CI spotted deadlock fix
- EHL port D programming fix

amdgpu:
- VRAM lost fixes on BACO for CI/VI
- navi14 DC fixes
- misc SR-IOV, gfx10 fixes
- XGMI fixes for arcturus
- SRIOV fixes

amdkfd:
- KFD on ppc64le enabled
- page table optimisations

radeon:
- fix for r1xx/2xx register checker.

tegra:
- displayport regression fixes
- DMA API regression fixes

mgag200:
- fix devices that can't scanout except at 0 addr

omap:
- fix dma_addr refcounting

----------------------------------------------------------------
Alex Deucher (5):
      drm/amd/display: add default clocks if not able to fetch them
      MAINTAINERS: Drop Rex Zhu for amdgpu powerplay
      drm/amdgpu: flag vram lost on baco reset for VI/CIK
      drm/amd/display: re-enable wait in pipelock, but add timeout
      drm/radeon: fix r1xx/r2xx register checker for POT textures

AngeloGioacchino Del Regno (6):
      drm/msm/mdp5: Add optional TBU and TBU_RT clocks
      dt-bindings: msm/mdp5: Document optional TBU and TBU_RT clocks
      drm/msm/mdp5: Add configuration for msm8x76
      drm/msm/dsi: Add configuration for 28nm PLL on family B
      drm/msm/dsi: Add configuration for 8x76
      drm/msm/adreno: Add support for Adreno 510 GPU

Arnd Bergmann (1):
      drm/msm: include linux/sched/task.h

Ben Dooks (2):
      drm/msm: make a5xx_show and a5xx_gpu_state_put static
      drm/msm/mdp5: make config variables static

Brian Masney (6):
      dt-bindings: soc: qcom: add On Chip MEMory (OCMEM) bindings
      dt-bindings: display: msm: gmu: add optional ocmem property
      soc: qcom: add OCMEM driver
      drm/msm/gpu: add ocmem init/cleanup functions
      soc: qcom: ocmem: add missing includes
      drm/msm/hdmi: silence -EPROBE_DEFER warning

Chris Wilson (13):
      drm/i915/gt: Fixup config ifdeffery for pm_suspend_target_state
      drm/i915: Wait until the intel_wakeref idle callback is complete
      drm/i915: Mark up the calling context for intel_wakeref_put()
      drm/i915/gt: Close race between engine_park and intel_gt_retire_requests
      drm/i915/gt: Unlock engine-pm after queuing the kernel context switch
      drm/i915/gt: Mark the execlists->active as the primary volatile access
      drm/i915/execlists: Fixup cancel_port_requests()
      drm/i915/gt: Adapt engine_park synchronisation rules for engine_retire
      drm/i915/gt: Schedule request retirement when timeline idles
      drm/i915/gt: Make intel_ring_unpin() safe for concurrent pint
      drm/i915: Default to a more lenient forced preemption timeout
      drm/i915: Reduce nested prepare_remote_context() to a trylock
      drm/i915/gem: Take timeline->mutex to walk list-of-requests

Corentin Labbe (5):
      agp: remove unused variable size in agp_generic_create_gatt_table
      agp: move AGPGART_MINOR to include/linux/miscdevice.h
      agp: remove unused variable num_segments
      agp: Add bridge parameter documentation
      ia64: agp: Replace empty define with do while

Dave Airlie (6):
      Merge tag 'drm-msm-next-2019-11-05' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'drm-intel-next-fixes-2019-11-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-next-5.5-2019-12-03' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm/tegra/for-5.5-rc1-fixes' of
git://anongit.freedesktop.org/tegra/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2019-12-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-12-05' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Drew Davenport (7):
      drm/msm/dpu: Remove unused variables
      drm/msm/dpu: Remove unused macro
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm/dpu: Remove unnecessary NULL checks
      drm/msm: Remove unused function arguments

Felix Kuehling (1):
      drm/amdgpu: Optimize KFD page table reservation

Gao, Fred (2):
      drm/i915/gvt: Refine non privilege register address calucation
      drm/i915/gvt: Update force-to-nonpriv register whitelist

Guenter Roeck (1):
      drm/dp_mst: Fix build on systems with STACKTRACE_SUPPORT=n

John Clements (2):
      drm/amdgpu: Resolved offchip EEPROM I/O issue
      drm/amdgpu: Added ASIC specific checks in gfxhub V1.1 get XGMI info

Joonas Lahtinen (1):
      Merge tag 'gvt-next-fixes-2019-12-02' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Krzysztof Wilczynski (1):
      drm/msm/dsi: Move static keyword to the front of declarations

Likun Gao (1):
      drm/amdgpu/powerplay: unify smu send message function

Matt Roper (3):
      drm/i915/ehl: Update voltage level checks
      drm/i915/tgl: Add DKL PHY vswing table for HDMI
      drm/i915/ehl: Make icp_digital_port_connected() use phy instead of port

Monk Liu (6):
      drm/amdgpu: use CPU to flush vmhub if sched stopped
      drm/amdgpu: fix calltrace during kmd unload(v3)
      drm/amdgpu: skip rlc ucode loading for SRIOV gfx10
      drm/amdgpu: do autoload right after MEC loaded for SRIOV VF
      drm/amdgpu: should stop GFX ring in hw_fini
      drm/amdgpu: fix GFX10 missing CSIB set(v3)

Rob Clark (4):
      firmware: qcom: scm: add OCMEM lock/unlock interface
      firmware: qcom: scm: add support to restore secure config to qcm_scm-32
      drm/msm: fix rd dumping for split-IB1
      drm/msm: always dump buffer base/size

Sean Paul (1):
      drm/msm: Sanitize the modeset_is_locked checks in dpu

Stephan Gerhold (1):
      drm/msm/dsi: Implement qcom, dsi-phy-regulator-ldo-mode for 28nm PHY

Thierry Reding (9):
      drm/tegra: hub: Remove bogus connection mutex check
      drm/tegra: gem: Properly pin imported buffers
      drm/tegra: gem: Remove premature import restrictions
      drm/tegra: Use proper IOVA address for cursor image
      drm/tegra: sor: Implement system suspend/resume
      drm/tegra: vic: Export module device table
      drm/tegra: Silence expected errors on IOMMU attach
      drm/tegra: sor: Make the +5V HDMI supply optional
      drm/tegra: Run hub cleanup on ->remove()

Thomas Zimmermann (3):
      drm/mgag200: Extract device type from flags
      drm/mgag200: Store flags from PCI driver data in device structure
      drm/mgag200: Add workaround for HW that does not support 'startadd'

Timothy Pearson (1):
      amdgpu: Enable KFD on POWER systems

Tomi Valkeinen (1):
      drm/omap: fix dma_addr refcounting

Tvrtko Ursulin (1):
      drm/i915/query: Align flavour of engine data lookup

Wayne Lin (1):
      drm/dp_mst: Correct the bug in drm_dp_update_payload_part1()

Xiaojie Yuan (1):
      drm/amdgpu/gfx10: unlock srbm_mutex after queue programming finish

Zhan Liu (1):
      drm/amd/display: Include num_vmid and num_dsc within NV14's resource caps

Zhan liu (2):
      drm/amd/display: Adding NV14 IP Parameters
      drm/amd/display: Get NV14 specific ip params as needed

Zhenyu Wang (1):
      drm/i915/gvt: Fix cmd length check for MI_ATOMIC

zhengbin (11):
      drm/msm/dpu: Remove set but not used variable 'priv' in dpu_kms.c
      drm/msm/dpu: Remove set but not used variable 'priv' in
dpu_encoder_phys_vid.c
      drm/msm/dpu: Remove set but not used variable 'priv' in dpu_core_irq.c
      drm/msm/dpu: Remove set but not used variables 'dpu_cstate', 'priv'
      drm/msm/dpu: Remove set but not used variables 'cmd_enc', 'priv'
      drm/msm/dpu: Remove set but not used variables 'mode', 'dpu_kms', 'priv'
      drm/msm/mdp5: Remove set but not used variable 'fmt'
      drm/msm/mdp5: Remove set but not used variable 'hw_cfg' in blend_setup
      drm/msm/dsi: Remove set but not used variable 'lpx'
      drm/msm/dsi: Remove set but not used variable 'lp'
      drm/msm/mdp5: Remove set but not used variable 'hw_cfg' in modeset_init

 .../devicetree/bindings/display/msm/gmu.txt        |  51 +++
 .../devicetree/bindings/display/msm/mdp5.txt       |   2 +
 .../devicetree/bindings/sram/qcom,ocmem.yaml       |  96 +++++
 MAINTAINERS                                        |   1 -
 arch/ia64/include/asm/agp.h                        |   4 +-
 drivers/char/agp/frontend.c                        |   3 +-
 drivers/char/agp/generic.c                         |  12 +-
 drivers/firmware/qcom_scm-32.c                     |  52 ++-
 drivers/firmware/qcom_scm-64.c                     |  12 +
 drivers/firmware/qcom_scm.c                        |  53 +++
 drivers/firmware/qcom_scm.h                        |   9 +
 drivers/gpu/drm/Kconfig                            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c            |  10 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 178 +++------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  40 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  40 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           |  19 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   7 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  19 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  74 ++++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   9 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |   1 -
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   4 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |   5 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      |   5 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |   1 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h       |   4 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  29 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |  28 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |   1 -
 drivers/gpu/drm/drm_dp_mst_topology.c              |   6 +-
 drivers/gpu/drm/i915/Kconfig.profile               |   2 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   4 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  29 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   4 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |  21 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   8 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |  67 +++-
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |  10 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   8 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |   3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |  83 +++-
 drivers/gpu/drm/i915/gt/intel_gt_requests.h        |   7 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  50 ++-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   2 +-
 drivers/gpu/drm/i915/gt/intel_ring.c               |  13 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |  35 +-
 drivers/gpu/drm/i915/gt/intel_timeline_types.h     |   5 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |   7 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   6 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   5 +-
 drivers/gpu/drm/i915/i915_active.c                 |   5 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |   6 +-
 drivers/gpu/drm/i915/i915_query.c                  |   7 +-
 drivers/gpu/drm/i915/intel_wakeref.c               |  21 +-
 drivers/gpu/drm/i915/intel_wakeref.h               |  45 ++-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |  36 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |  18 +
 drivers/gpu/drm/mgag200/mgag200_main.c             |   3 +-
 drivers/gpu/drm/msm/Kconfig                        |   1 +
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |  28 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.h              |   3 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |  25 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.h              |   3 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |  79 +++-
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |   7 +
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  15 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  40 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  15 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c       |  43 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |  21 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  39 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  15 -
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |   7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  60 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   4 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |   6 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |  10 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           | 114 +++++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   3 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |  23 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h           |   2 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |   2 -
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |  28 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   3 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   8 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c         |  60 ++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |   8 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   6 +-
 drivers/gpu/drm/msm/msm_gpummu.c                   |   6 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   6 +-
 drivers/gpu/drm/msm/msm_mmu.h                      |   4 +-
 drivers/gpu/drm/msm/msm_rd.c                       |  16 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |   4 +
 drivers/gpu/drm/radeon/r100.c                      |   4 +-
 drivers/gpu/drm/radeon/r200.c                      |   4 +-
 drivers/gpu/drm/tegra/dc.c                         |  18 +-
 drivers/gpu/drm/tegra/drm.c                        |   7 +-
 drivers/gpu/drm/tegra/gem.c                        |  50 ++-
 drivers/gpu/drm/tegra/hub.c                        |   3 -
 drivers/gpu/drm/tegra/plane.c                      |  11 +
 drivers/gpu/drm/tegra/sor.c                        |  38 +-
 drivers/gpu/drm/tegra/vic.c                        |   7 +-
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/ocmem.c                           | 433 +++++++++++++++++++++
 include/linux/agpgart.h                            |   2 -
 include/linux/miscdevice.h                         |   1 +
 include/linux/qcom_scm.h                           |  26 ++
 include/soc/qcom/ocmem.h                           |  65 ++++
 126 files changed, 2014 insertions(+), 764 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
 create mode 100644 drivers/soc/qcom/ocmem.c
 create mode 100644 include/soc/qcom/ocmem.h
