Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD142080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OUGrfNBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfGOMRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:17:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37110 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfGOMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:17:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so16692094otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tVYJfat3Y7wVeMjojJZIkOR1YJRL+CQ1Mc1PP9LcPZo=;
        b=OUGrfNBt78krgMRIcwTlV/wf8t7Uvb6kGzoPTvGnVgMWrsAYHoTk7ACJr+h8l/iHV/
         awoPnN1Z5azN8ypZXuWFGbyZUeF2A38N+5eqCZP2tA91r+4ufSnwMW/0C5zcQsO+cv/Z
         dDadV9S2yavCxWhedywxIwNzF50rgXPiZhDYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tVYJfat3Y7wVeMjojJZIkOR1YJRL+CQ1Mc1PP9LcPZo=;
        b=UVWXCcVjgHkbs+k9LhQojBimWd/yWVQjNIDMmSEwdFrF0uIcxnx2qJYem08gapSSs6
         pWi1+NI4JRKUnqM/7nZARFiOpAhTIbKaahNtgVKK6omRdYVs4y/1TPi+lKcBRDzeWiFc
         wJtugEqKn+sLYJw+g9HYsnIY6kM9EwRDXMhBuRXcbAt9jZWzBjnGn1DOmqrlH1fdc6Kh
         XM+lONbunUV6RV/MSMOXKiN+75nNo+BnzpnRrMt4bxhCdhylCveJYDeXw2odFKqH2jUB
         TaVHRZqQzGx5SieSEwtq7GyzIx52EwEYn0shyfvSMDVExCMAquta8P0LyIvIi1TshKc7
         bNzA==
X-Gm-Message-State: APjAAAW8bLLZIUamXPg/Nw1MSCYWPGziV9Pj8406d4XNTfJwrOXpB1F/
        Dzk+Jip4xI+vmbmlE1UKLRTeZEKcKax09r7QkNw=
X-Google-Smtp-Source: APXvYqxu3WaKWKe7So75QeiT8Q/2UqvMPUjLUNt7InJReY/mamDmaTVGMbFTi1yHLKir2hjCwMU9Tl1Eadbgqd0SBvU=
X-Received: by 2002:a9d:590d:: with SMTP id t13mr1311452oth.281.1563193028262;
 Mon, 15 Jul 2019 05:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
In-Reply-To: <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 15 Jul 2019 14:16:55 +0200
Message-ID: <CAKMK7uGwkm-Vu5dPEE4cAkAbJ5R5hNDA+4tWhZJ7SFNA_H1qUg@mail.gmail.com>
Subject: Re: drm pull for v5.3-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 9:08 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Now with a subject line that isn't from my phone so isn't HTML email.
>
> On Mon, 15 Jul 2019 at 16:38, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Hi Linus,
> >
> > Main pull request for drm for 5.3. This merge window seems to be
> > conflictful and it conincides with myself and most of my family
> > getting hit with a strain of influenza A, and it feels like
> > freedesktop.org git is especially slow today.
> >
> > I was waiting for the HMM tree to land, and I now have a bunch of fun
> > merge conflicts to resolve.
> >
> > I've created a branch
> > https://cgit.freedesktop.org/drm/drm/log/?h=3Ddrm-next-5.3-backmerge-co=
nflicts
> > git://anongit.freedesktop.org/drm/drm drm-next-5.3-backmerge-conflicts
> >
> > Most of them are trivial enough, two probably need better explainations=
:
> >
> > VMware had some mm helpers go in via my tree (looking back I'm not
> > sure Thomas really secured enough acks on these, but I'm going with it
> > for now until I get push back).

Yeah they don't have any acks from core -mm folks. Out of curiosity I
looked into what we could do, and putting a

$ git revert 031e610a6a21448a63dff7a0416e5e206724caac -m1

on top of the drm-next pull here looks reasonable. There's not really
anything else major in that vwmgfx pull.
-Daniel

> > They conflicted with one of the mm
> > cleanups in the hmm tree, I've pushed a patch to the top of my next to
> > fix most of the fallout in my tree, and the resulting fixup is to pick
> > the closure->ptefn hunk and apply something like in mm/memory.c
> >
> > @@ -2201,7 +2162,7 @@ static int apply_to_page_range_wrapper(pte_t *pte=
,
> >         struct page_range_apply *pra =3D
> >                 container_of(pter, typeof(*pra), pter);
> >
> > -       return pra->fn(pte, NULL, addr, pra->data);
> > +       return pra->fn(pte, addr, pra->data);
> >  }
> >
> > Then there is the one hmm merge fixup below.
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -783,7 +783,7 @@ int amdgpu_ttm_tt_get_user_pages(struct ttm_tt
> > *ttm, struct page **pages)
> >                                 0 : range->flags[HMM_PFN_WRITE];
> >         range->pfn_flags_mask =3D 0;
> >         range->pfns =3D pfns;
> >  -     hmm_range_register(range, mm, start,
> >  +     hmm_range_register(range, mirror, start,
> >                            start + ttm->num_pages * PAGE_SIZE, PAGE_SHI=
FT);
> >
> > There are also a Kconfig conflict in mm, and an i915 Makefile conflict
> > that standout.
> >
> > Feel free to just pull the resolved tree if you want, or get back to
> > me if this is too messy.
> >
> > The biggest thing in this apart from the mm/hmm dancing, is the AMD
> > Navi GPU support, this again contains a bunch of header files that are
> > large. These are the new AMD RX5700 GPUs that just recently became
> > available.
> >
> > Thanks,
> > Dave.
> >
> > New drivers:
> > ST-Ericsson MCDE driver
> > Ingenic JZ47xx SoC
> >
> > UAPI change:
> > HDR source metadata property
> >
> > Core:
> > - HDR inforframes and EDID parsing
> > - drm hdmi infoframe unpacking
> > - remove prime sg_table caching into dma-buf
> > - New gem vram helpers to reduce driver code
> > - Lots of drmP.h removal
> > - reservation fencing fix
> > - documentation updates
> > - drm_fb_helper_connector removed
> > - mode name command handler rewrite
> >
> > fbcon:
> > - Remove the fbcon notifiers
> >
> > ttm:
> > - forward progress fixes
> >
> > dma-buf:
> > - make mmap call optional
> > - debugfs refcount fixes
> > - dma-fence free with pending signals fix
> > - each dma-buf gets an inode
> >
> > Panels:
> > - Lots of additional panel bindings
> >
> > amdgpu:
> > - initial navi10 support
> > - avoid hw reset
> > - HDR metadata support
> > - new thermal sensors for vega asics
> > - RAS fixes
> > - use HMM rather than MMU notifier
> > - xgmi topology via kfd
> > - SR-IOV fixes
> > - driver reload fixes
> > - DC use a core bpc attribute
> > - Aux fixes for DC
> > - Bandwidth calc updates for DC
> > - Clock handling refactor
> > - kfd VEGAM support
> >
> > vmwgfx:
> > - Coherent memory support changes
> >
> > i915:
> > - HDR Support
> > - HDMI i2c link
> > - Icelake multi-segmented gamma support
> > - GuC firmware update
> > - Mule Creek Canyon PCH support for EHL
> > - EHL platform updtes
> > - move i915.alpha_support to i915.force_probe
> > - runtime PM refactoring
> > - VBT parsing refactoring
> > - DSI fixes
> > - struct mutex dependency reduction
> > - GEM code reorg
> >
> > mali-dp:
> > - Komeda driver features
> >
> > msm:
> > - dsi vs EPROBE_DEFER fixes
> > - msm8998 snapdragon 835 support
> > - a540 gpu support
> > - mdp5 and dpu interconnect support
> >
> > exynos:
> > - drmP.h removal
> >
> > tegra:
> > - misc fixes
> >
> > tda998x:
> > - audio support improvements
> > - pixel repeated mode support
> > - quantisation range handling corrections
> > - HDMI vendor info fix
> >
> > armada:
> > - interlace support fix
> > - overlay/video plane register handling refactor
> > - add gamma support
> >
> > rockchip:
> > - RX3328 support
> >
> > panfrost:
> > - expose perf counters via hidden ioctls
> >
> > vkms:
> > - enumerate CRC sources list
> > ast:
> > - rework BO handling
> >
> > mgag200:
> > - rework BO handling
> >
> > dw-hdmi:
> > - suspend/resume support
> >
> > rcar-du:
> > - R8A774A1 Soc Support
> > - LVDS dual-link mode support
> > - Additional formats
> > - Misc fixes
> >
> > omapdrm:
> > - DSI command mode display support
> >
> > stm
> > - fb modifier support
> > - runtime PM support
> >
> > sun4i:
> > - use vmap ops
> >
> > vc4:
> > - binner bo binding rework
> >
> > v3d:
> > - compute shader support
> > - resync/sync fixes
> > - job management refactoring
> >
> > lima:
> > - NULL pointer in irq handler fix
> > - scheduler default timeout
> >
> > virtio:
> > - fence seqno support
> > - trace events
> >
> > bochs:
> > - misc fixes
> >
> > tc458767:
> > - IRQ/HDP handling
> >
> > sii902x:
> > - HDMI audio support
> >
> > atmel-hlcdc:
> > - misc fixes
> >
> > meson:
> > - zpos support
> >
> > drm-next-2019-07-15-1:
> > drm main pull request for 5.3-rc1
> > The following changes since commit 6116b892bd4fd0ddc5f30566a556218bb2e1=
a9b6:
> >
> >   vga_switcheroo: Depend upon fbcon being built-in, if enabled
> > (2019-06-26 10:36:49 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-07-15-1
> >
> > for you to fetch changes up to 6dfc43d3a19174faead54575c204aee106225f43=
:
> >
> >   mm: adjust apply_to_pfn_range interface for dropped token.
> > (2019-07-15 15:16:20 +1000)
> >
> > ----------------------------------------------------------------
> > drm main pull request for 5.3-rc1
> >
> > ----------------------------------------------------------------
> > Abhinav Kumar (2):
> >       drm/msm/dsi: add protection against NULL dsi device
> >       drm/msm/dpu: add icc voting in dpu_mdss_init
> >
> > Aditya Swarup (1):
> >       drm/i915/icl: Fix setting 10 bit deep color mode
> >
> > Aidan Wood (2):
> >       drm/amd/display: Properly set DCF clock
> >       drm/amd/display: Properly set u clock
> >
> > Alex Deucher (37):
> >       drm/amdgpu/vega20: use mode1 reset for RAS and XGMI
> >       drm/amdgpu: use pcie_bandwidth_available rather than open coding =
it
> >       drm/amdgpu/soc15: skip reset on init
> >       drm/amdgpu: fix a race in GPU reset with IB test (v2)
> >       drm/amdgpu/display: Drop some new CONFIG_DRM_AMD_DC_DCN1_01 guard=
s
> >       Revert "drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu"
> >       drm/amdgpu: return 0 by default in amdgpu_pm_load_smu_firmware
> >       drm/amdgpu: wait to fetch the vbios until after common init
> >       Revert "drm/amd/display: make clk_mgr call enable_pme_wa"
> >       Revert "drm/amd/display: Add Underflow Asserts to dc"
> >       Revert "drm/amd/display: move vmid determination logic out of dc"
> >       Revert "drm/amd/display: Rework CRTC color management"
> >       Revert "drm/amd/display: Use macro for invalid OPP ID"
> >       Revert "drm/amd/display: Copy stream updates onto streams"
> >       drm/amdgpu: add Navi10 pci ids
> >       drm/amd/powerplay/smu11: remove smu_update_table_with_arg
> >       drm/amdgpu/powerplay: add license to smu11 header
> >       drm/amdgpu/powerplay/vega20: use correct table index
> >       drm/amdgpu/gfx10: update to latest golden setting
> >       drm/amd/display: add fast_validate parameter to dcn20_validate_ba=
ndwidth
> >       drm/amd/display: updates for dcn20_update_bandwidth
> >       drm/amd/display: update dcn2 dc_plane_cap
> >       drm/amdgpu: drop unused df init callback
> >       Merge branch 'drm-next' into drm-next-5.3
> >       drm/amdgpu/powerplay: FEATURE_MASK is 64 bit so use ULL
> >       drm/amdgpu/display: switch udelay to msleep
> >       drm/amdgpu/display: drop ifdefs around comments
> >       drm/amdgpu: fix warning on 32 bit
> >       drm/amdgpu: drop copy/paste leftover to fix big endian
> >       drm/amdgpu/gfx9: use reset default for PA_SC_FIFO_SIZE
> >       drm/amdgpu/gfx10: use reset default for PA_SC_FIFO_SIZE
> >       drm/amdgpu/display: fix interrupt client id for navi
> >       drm/amdgpu: properly guard DC support in navi code
> >       drm/amdgpu/psp11: simplify the ucode register logic
> >       drm/amdgpu: add missing documentation on new module parameters
> >       drm/amdgpu: properly guard the generic discovery code
> >       drm/amdgpu/navi10: add uclk activity sensor
> >
> > Amber Lin (1):
> >       drm/amdkfd: Add domain number into gpu_id
> >
> > Andreas Pretzsch (1):
> >       drm/panel: simple: Add support for EDT ET035012DM6
> >
> > Andres Rodriguez (2):
> >       drm/edid: parse CEA blocks embedded in DisplayID
> >       drm/edid: use for_each_displayid_db where applicable
> >
> > Andrew F. Davis (3):
> >       dma-buf: Remove leftover [un]map_atomic comments
> >       dma-buf: Update [un]map documentation to match the other function=
s
> >       dma-buf: Make mmap callback actually optional
> >
> > Andrey Grodzovsky (5):
> >       drm/sched: Keep s_fence->parent pointer
> >       drm/scheduler: Add flag to hint the release of guilty job.
> >       drm/amdgpu: Avoid HW reset if guilty job already signaled.
> >       drm/sched: Fix static checker warning for potential NULL ptr
> >       drm/sched: Fix make htmldocs warnings.
> >
> > Anthony Koo (5):
> >       drm/amd/display: fix multi display seamless boot case
> >       drm/amd/display: do not power on eDP power rail early
> >       drm/amd/display: fix issues with bad AUX reply on some displays
> >       drm/amd/display: fix issue with eDP not detected on driver load
> >       drm/amd/display: do not power on eDP power rail early
> >
> > Aric Cyr (11):
> >       drm/amd/display: 3.2.28
> >       drm/amd/display: 3.2.29
> >       drm/amd/display: 3.2.30
> >       drm/amd/display: Use VCP for extended colorimetry
> >       drm/amd/display: 3.2.31
> >       drm/amd/display: 3.2.32
> >       drm/amd/display: program manual trigger only for bottom most pipe
> >       drm/amd/display: 3.2.33
> >       drm/amd/display: 3.2.34
> >       drm/amd/display: 3.2.35
> >       drm/amd/display: Intermittent DCN2 pipe hang on mode change
> >
> > Arnd Bergmann (6):
> >       drm/amdgpu: fix error handling in df_v3_6_pmc_start
> >       drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
> >       amdgpu: make pmu support optional
> >       drm/amd/display: dcn20: include linux/delay.h
> >       drm/amd/powerplay: vega20: fix uninitialized variable use
> >       drm/amd/display: avoid 64-bit division
> >
> > Ayan Halder (1):
> >       drm/komeda: Make Komeda interrupts shareable
> >
> > Benjamin Gaignard (1):
> >       drm/stm: ltdc: restore calls to clk_{enable/disable}
> >
> > Bhawanpreet Lakha (1):
> >       drm/amd/powerplay: Fix maybe-uninitialized in get_ppfeature_statu=
s
> >
> > Biju Das (4):
> >       dt-bindings: display: renesas: du: Document the r8a774a1 bindings
> >       dt-bindings: display: renesas: lvds: Document r8a774a1 bindings
> >       drm: rcar-du: Add R8A774A1 support
> >       drm: rcar-du: lvds: Add r8a774a1 support
> >
> > Bob Yang (1):
> >       drm/amd/display: fixed DCC corruption
> >
> > Boris Brezillon (4):
> >       drm/panfrost: Move gpu_{write, read}() macros to panfrost_regs.h
> >       drm/panfrost: Add a module parameter to expose unstable ioctls
> >       drm/panfrost: Add an helper to check the GPU generation
> >       drm/panfrost: Expose performance counters through unstable ioctls
> >
> > Brian Masney (2):
> >       drm/msm: correct attempted NULL pointer dereference in put_iova
> >       drm/msm: add dirty framebuffer helper
> >
> > Charlene Liu (20):
> >       drm/amd/display: add SW_USE_I2C_REG request.
> >       drm/amd/display: color space ycbcr709 support
> >       drm/amd/display: reset retimer/redriver below 340Mhz
> >       drm/amd/display: define v_total_min and max parameters
> >       drm/amd/display: enabling stream after HPD low to high happened
> >       drm/amd/display: add some math functions for dcn_calc_math
> >       drm/amd/display: add audio related regs
> >       drm/amd/display: dcn2 dmcu wait_for_loop update with dispclk.
> >       drm/amd/display: fix can not turn on two displays due to
> > DSC_RESOURCE failed.
> >       drm/amd/display: Add hubp_init entry to hubp vtable
> >       drm/amd/display: add SW_USE_I2C_REG request.
> >       drm/amd/display: Create DWB resource for DCN2
> >       drm/amd/display: [backport] dwb dm + efc support
> >       drm/amd/display: used optimum VSTARTUP instead of MaxVStartup
> >       drm/amd/display: Return UPDATE_TYPE_FULL on writeback update
> >       drm/amd/display: add some parameters to validate bandwidth functi=
ons
> >       drm/amd/display: add dwb stere caps and version
> >       drm/amd/display: add p010 and ayuv plane caps
> >       drm/amd/display: dcn2 use fixed clocks.
> >       drm/amd/display: expose dentist_get_did_from_divider
> >
> > Chengming Gui (3):
> >       drm/amd/powerplay: Enable "disable dpm" feature to support swSMU
> > debug (v2)
> >       drm/amd/powerplay: Fix code error for translating int type to
> > bool type correctly
> >       drm/amd/powerplay: add set_power_profile_mode for raven1_refresh
> >
> > Chia-I Wu (4):
> >       drm/virtio: set seqno for dma-fence
> >       drm/virtio: trace drm_fence_emit
> >       drm/virtio: add trace events for commands
> >       drm/virtio: allocate fences with GFP_KERNEL
> >
> > Chris Park (5):
> >       drm/amd/display: Support AVI InfoFrame V3 and V4
> >       drm/amd/display: Define Byte 14 on AVI InfoFrame
> >       drm/amd/display: Move link functions from dc to dc_link
> >       drm/amd/display: Clean up scdc_test_data struct
> >       drm/amd/display: Move link functions from dc to dc_link
> >
> > Chris Wilson (150):
> >       drm/i915: Verify workarounds immediately after application
> >       drm/i915: Verify the engine workarounds stick on application
> >       drm/i915: Make workaround verification *optional*
> >       drm/i915: Avoid use-after-free in reporting create.size
> >       drm/i915: Stop overwriting RING_IMR in rcs resume
> >       drm/i915: Setup the RCS ring prior to execution
> >       drm/i915: Remove unwarranted clamping for hsw/bdw
> >       drm/i915: Track HAS_RPS alongside HAS_RC6 in the device info
> >       drm/i915: Expose the busyspin durations for i915_wait_request
> >       drm/i915/gtt: Skip clearing the GGTT under gen6+ full-ppgtt
> >       drm/i915: Start writeback from the shrinker
> >       dma-buf: Remove unused sync_dump()
> >       drm/i915: Store the default sseu setup on the engine
> >       drm/i915/selftests: Verify whitelist of context registers
> >       drm/i915: Move GraphicsTechnology files under gt/
> >       drm/i915: Introduce struct intel_wakeref
> >       drm/i915: Pull the GEM powermangement coupling into its own file
> >       drm/i915: Introduce context->enter() and context->exit()
> >       drm/i915: Pass intel_context to i915_request_create()
> >       drm/i915: Invert the GEM wakeref hierarchy
> >       drm/i915: Explicitly pin the logical context for execbuf
> >       drm/i915: Allow multiple user handles to the same VM
> >       drm/i915: Disable preemption and sleeping while using the punit s=
ideband
> >       drm/i915: Lift acquiring the vlv punit magic to a common sb-get
> >       drm/i915: Lift sideband locking for vlv_punit_(read|write)
> >       drm/i915: Replace pcu_lock with sb_lock
> >       drm/i915: Separate sideband declarations to intel_sideband.h
> >       drm/i915: Merge sbi read/write into a single accessor
> >       drm/i915: Merge sandybridge_pcode_(read|write)
> >       drm/i915: Move sandybride pcode access to intel_sideband.c
> >       drm/i915/ringbuffer: EMIT_INVALIDATE *before* switch context
> >       drm/i915: Enable render context support for Ironlake (gen5)
> >       drm/i915: Enable render context support for gen4 (Broadwater to C=
antiga)
> >       drm/i915/gvt: Pin the per-engine GVT shadow contexts
> >       drm/i915: Export intel_context_instance()
> >       drm/i915/selftests: Use the real kernel context for sseu isolatio=
n tests
> >       drm/i915/selftests: Pass around intel_context for sseu
> >       drm/i915: Pass intel_context to intel_context_pin_lock()
> >       drm/i915: Split engine setup/init into two phases
> >       drm/i915: Switch back to an array of logical per-engine HW contex=
ts
> >       drm/i915: Remove intel_context.active_link
> >       drm/i915: Move i915_request_alloc into selftests/
> >       drm/i915: Skip unused contexts for context_barrier_task()
> >       drm/i915: Wait for the struct_mutex on idling
> >       drm/i915: Move the engine->destroy() vfunc onto the engine
> >       drm/i915: Complete both freed-object passes before draining the w=
orkqueue
> >       drm/i915: Include fence signaled bit in print_request()
> >       drm/i915/guc: Fix runtime suspend
> >       drm/i915/execlists: Flush the tasklet on parking
> >       drm/i915: Leave engine parking to the engines
> >       drm/i915/hangcheck: Track context changes
> >       drm/i915: Delay semaphore submission until the start of the signa=
ler
> >       drm/i915: Disable semaphore busywaits on saturated systems
> >       drm/i915: Acquire the signaler's timeline HWSP last
> >       drm/i915: Assert breadcrumbs are correctly ordered in the signal =
handler
> >       drm/i915: Prefer checking the wakeref itself rather than the coun=
ter
> >       drm/i915: Assert the local engine->wakeref is active
> >       drm/i915: Flush the switch-to-kernel-context harder for DROP_IDLE
> >       drm/i915: Remove delay for idle_work
> >       drm/i915: Cancel retire_worker on parking
> >       drm/i915: Stop spinning for DROP_IDLE (debugfs/i915_drop_caches)
> >       drm/i915: Only reschedule the submission tasklet if preemption is=
 possible
> >       drm/i915/execlists: Don't apply priority boost for resets
> >       drm/i915: Reboot CI if forcewake fails
> >       drm/i915/hangcheck: Replace hangcheck.seqno with RING_HEAD
> >       drm/i915: Seal races between async GPU cancellation, retirement
> > and signaling
> >       drm/i915: Rearrange i915_scheduler.c
> >       drm/i915: Pass i915_sched_node around internally
> >       drm/i915: Check for no-op priority changes first
> >       drm/i915: Mark semaphores as complete on unsubmit out if payload
> > was started
> >       drm/i915: Truly bump ready tasks ahead of busywaits
> >       drm/i915/dp: Initialise locals for static analysis
> >       drm/i915/hdcp: Use both bits for device_count
> >       drm/i915: Bump signaler priority on adding a waiter
> >       drm/i915: Downgrade NEWCLIENT to non-preemptive
> >       drm/i915/execlists: Drop promotion on unsubmit
> >       drm/i915: Restore control over ppgtt for context creation ABI
> >       drm/i915: Allow a context to define its set of engines
> >       drm/i915: Extend I915_CONTEXT_PARAM_SSEU to support local ctx->en=
gine[]
> >       drm/i915: Re-expose SINGLE_TIMELINE flags for context creation
> >       drm/i915: Allow userspace to clone contexts on creation
> >       drm/i915: Load balancing across a virtual engine
> >       drm/i915: Apply an execution_mask to the virtual_engine
> >       drm/i915: Extend execution fence to support a callback
> >       drm/i915/execlists: Virtual engine bonding
> >       drm/i915: Allow specification of parallel execbuf
> >       drm/i915/gtt: Always acquire struct_mutex for gen6_ppgtt_cleanup
> >       drm/i915/gtt: Neuter the deferred unbind callback from gen6_ppgtt=
_cleanup
> >       drm/i915: Keep user GGTT alive for a minimum of 250ms
> >       drm/i915: Kill the undead intel_context.c zombie
> >       drm/i915: Split GEM object type definition to its own header
> >       drm/i915: Pull GEM ioctls interface to its own file
> >       drm/i915: Move object->pages API to i915_gem_object.[ch]
> >       drm/i915: Move shmem object setup to its own file
> >       drm/i915: Move phys objects to its own file
> >       drm/i915: Move mmap and friends to its own file
> >       drm/i915: Move GEM domain management to its own file
> >       drm/i915: Move more GEM objects under gem/
> >       drm/i915: Pull scatterlist utils out of i915_gem.h
> >       drm/i915: Move GEM object domain management from struct_mutex to =
local
> >       drm/i915: Move GEM object waiting to its own file
> >       drm/i915: Move GEM object busy checking to its own file
> >       drm/i915: Move GEM client throttling to its own file
> >       drm/i915: Rename intel_context.active to .inflight
> >       drm/i915: Drop the deferred active reference
> >       drm/i915: Take a runtime pm wakeref for atomic commits
> >       drm/i915: Avoid refcount_inc on known zero count
> >       drm/i915/gtt: Avoid overflowing the WC stash
> >       drm/i915: Drop check for non-NULL entry in llist_for_each_entry_s=
afe
> >       drm/i915: Make default value for i915.mmio_debug a compile time o=
ption
> >       drm/i915: Track the purgeable objects on a separate eviction list
> >       drm/i915: Report all objects with allocated pages to the shrinker
> >       drm/i915/selftests: Flush partial-tiling object once
> >       drm/i915: Use unchecked writes for setting up the fences
> >       drm/i915: Use unchecked uncore writes to flush the GTT
> >       drm: Flush output polling on shutdown
> >       drm/i915/gtt: Replace struct_mutex serialisation for allocation
> >       dma-buf: Discard old fence_excl on retrying get_fences_rcu for re=
alloc
> >       drm/i915: Move object close under its own lock
> >       drm/i915: Skip context_barrier emission for unused contexts
> >       drm/i915: Report an earlier wedged event when suspending the engi=
nes
> >       dma-fence: Signal all callbacks from dma_fence_release()
> >       drm/i915: Allow interrupts when taking the timeline->mutex
> >       drm/i915: Promote i915->mm.obj_lock to be irqsafe
> >       drm/i915: Pull kref into i915_address_space
> >       drm/i915: Rename i915_hw_ppgtt to i915_ppgtt
> >       drm/i915: Add a label for config DRM_I915_SPIN_REQUEST
> >       drm/i915: Prevent lock-cycles between GPU waits and GPU resets
> >       drm/i915: Combine unbound/bound list tracking for objects
> >       dma-fence/reservation: Markup rcu protected access for DEBUG_MUTE=
XES
> >       drm/i915: kerneldoc warnings squelched
> >       drm/i915: Move fence register tracking from i915->mm to ggtt
> >       drm/i915: Enable refcount debugging for default debug levels
> >       drm/i915: Discard some redundant cache domain flushes
> >       drm/i915: Execute signal callbacks from no-op i915_request_wait
> >       drm/i915: Refine i915_reset.lock_map
> >       drm/i915: Keep contexts pinned until after the next kernel contex=
t switch
> >       drm/i915: Stop retiring along engine
> >       drm/i915: Replace engine->timeline with a plain list
> >       drm/i915: Avoid tainting i915_gem_park() with wakeref.lock
> >       drm/i915/gtt: Serialise both updates to PDE and our shadow
> >       drm/i915/guc: Reduce verbosity on log overflows
> >       drm/i915: Keep engine alive as we retire the context
> >       drm/i915: Use drm_gem_object.resv
> >       drm/i915: Skip shrinking already freed pages
> >       drm/i915/selftests: Flush live_evict
> >       drm/i915: Don't dereference request if it may have been retired
> > when printing
> >       drm/i915: Make the semaphore saturation mask global
> >       drm/i915/execlists: Detect cross-contamination with GuC
> >       drm/i915: Stop passing I915_WAIT_LOCKED to i915_request_wait()
> >
> > Christian K=C3=B6nig (18):
> >       drm/i915: remove DRM_AUTH from IOCTLs which also have DRM_RENDER_=
ALLOW
> >       drm/scheduler: rework job destruction
> >       MAINTAINERS: drop Jerry as TTM maintainer
> >       dma-buf: start caching of sg_table objects v2
> >       drm: remove prime sg_table caching
> >       drm/amdgpu: rename amdgpu_prime.[ch] into amdgpu_dma_buf.[ch]
> >       drm/amdgpu: remove static GDS, GWS and OA allocation
> >       drm/ttm: Make LRU removal optional v2
> >       drm/ttm: return immediately in case of a signal
> >       drm/ttm: remove manual placement preference
> >       drm/ttm: cleanup ttm_bo_mem_space
> >       drm/ttm: immediately move BOs to the new LRU v3
> >       drm/ttm: fix busy memory to fail other user v10
> >       drm/ttm: fix ttm_bo_unreserve
> >       drm/amdgpu: drop some validation failure messages
> >       drm/amdgpu: create GDS, GWS and OA in system domain
> >       drm/amdgpu: stop removing BOs from the LRU v3
> >       drm/amdgpu: disable concurrent flushes for Navi10 v2
> >
> > Chunming Zhou (2):
> >       drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu
> >       drm/amd/display: use ttm_eu_reserve_buffers instead of
> > amdgpu_bo_reserve v2
> >
> > Claudiu Beznea (3):
> >       drm: atmel-hlcdc: add config option for clock selection
> >       drm: atmel-hlcdc: avoid initializing cfg with zero
> >       drm/atmel-hlcdc: revert shift by 8
> >
> > Clinton Taylor (1):
> >       drm/i915/icl: Set GCP_COLOR_INDICATION only for 10/12 bit deep co=
lor
> >
> > Cl=C3=A9ment P=C3=A9ron (2):
> >       drm: panfrost: add optional bus_clock
> >       dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
> >
> > Colin Ian King (6):
> >       drm/amdgpu: fix spelling mistake "retrived" -> "retrieved"
> >       drm/i915/gtt: set err to -ENOMEM on memory allocation failure
> >       drm/amdkfd: fix null pointer dereference on dev
> >       drm/i915: fix use of uninitialized pointer vaddr
> >       drm/bridge: sii902x: fix comparision of u32 with less than zero
> >       drm/amd/display: fix a couple of spelling mistakes
> >
> > Dan Carpenter (5):
> >       drm/i915: selftest_lrc: Check the correct variable
> >       drm/bridge: sii902x: re-order conditions to prevent out of bounds=
 read
> >       drm/amdgpu: Fix bounds checking in amdgpu_ras_is_supported()
> >       drm/mcde: Fix an uninitialized variable
> >       drm: self_refresh: Fix a reversed condition in
> > drm_self_refresh_helper_cleanup()
> >
> > Daniel Drake (1):
> >       drm/i915/fbc: disable framebuffer compression on GeminiLake
> >
> > Daniel He (1):
> >       drm/amd/display: Modified AUX_DPHY_RX_CONTROL0
> >
> > Daniel Vetter (17):
> >       drm/doc: Improve docs for conn_state->best_encoder
> >       drm: Some ocd in drm_file.c
> >       drm/doc: More fine-tuning on userspace review requirements
> >       drm/docs: More links for implicit/explicit fencing.
> >       drm/crc-debugfs: User irqsafe spinlock in drm_crtc_add_crc_entry
> >       drm/vkms: Forward timer right after drm_crtc_handle_vblank
> >       drm/crc-debugfs: Also sprinkle irqrestore over early exits
> >       Merge tag 'du-next-20190608-2' of
> > git://linuxtv.org/pinchartl/media into drm-next
> >       Merge tag 'omapdrm-5.3' of git://git.kernel.org/.../tomba/linux
> > into drm-next
> >       drm/fb: document dirty helper better
> >       drm/ast: Drop fb_debug_enter/leave
> >       Merge tag 'drm-misc-next-2019-06-14' of
> > git://anongit.freedesktop.org/drm/drm-misc into drm-next
> >       drm/todo: Improve drm_gem_object funcs todo
> >       drm/gem: Unexport drm_gem_(un)pin/v(un)map
> >       drm/vkms: Move format arrays to vkms_plane.c
> >       Merge v5.2-rc5 into drm-next
> >       drm/todo: Update drm_gem_object_funcs todo even more
> >
> > Daniele Ceraolo Spurio (12):
> >       drm/i915: extract intel_display_power.h/c from intel_runtime_pm.h=
/c
> >       drm/i915: move more defs in intel_display_power.h
> >       drm/i915/guc: always use Command Transport Buffers
> >       drm/i915/wopcm: update default size for gen11+
> >       drm/i915: prefer i915_runtime_pm in intel_runtime function
> >       drm/i915: Remove rpm asserts that use i915
> >       drm/i915: make enable/disable rpm assert function use the rpm str=
ucture
> >       drm/i915: move and rename i915_runtime_pm
> >       drm/i915: move a few more functions to accept the rpm structure
> >       drm/i915: update rpm_get/put to use the rpm structure
> >       drm/i915: update with_intel_runtime_pm to use the rpm structure
> >       drm/i915: make intel_wakeref work on the rpm struct
> >
> > Dave Airlie (20):
> >       Merge tag 'drm-misc-next-2019-05-24' of
> > git://anongit.freedesktop.org/drm/drm-misc into drm-next
> >       Merge tag 'drm-intel-next-2019-05-24' of
> > git://anongit.freedesktop.org/drm/drm-intel into drm-next
> >       Merge branch 'drm-next-5.3' of
> > git://people.freedesktop.org/~agd5f/linux into drm-next
> >       Merge tag 'drm-misc-next-2019-06-05' of
> > git://anongit.freedesktop.org/drm/drm-misc into drm-next
> >       Merge branch 'drm-next-5.3' of
> > git://people.freedesktop.org/~agd5f/linux into drm-next
> >       Merge branch 'vmwgfx-next' of
> > git://people.freedesktop.org/~thomash/linux into drm-next
> >       Merge tag 'drm-misc-next-2019-06-20' of
> > git://anongit.freedesktop.org/drm/drm-misc into drm-next
> >       Merge tag 'drm-intel-next-2019-06-19' of
> > git://anongit.freedesktop.org/drm/drm-intel into drm-next
> >       Merge commit 'refs/for-upstream/mali-dp' of
> > git://linux-arm.org/linux-ld into drm-next
> >       Merge tag 'drm/tegra/for-5.3-rc1' of
> > git://anongit.freedesktop.org/tegra/linux into drm-next
> >       Merge tag 'for-airlie-tda998x' of
> > git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
> >       Merge tag 'drm-next-5.3-2019-06-25' of
> > git://people.freedesktop.org/~agd5f/linux into drm-next
> >       Merge tag 'drm-msm-next-2019-06-25' of
> > https://gitlab.freedesktop.org/drm/msm into drm-next
> >       Merge tag 'exynos-drm-next-for-v5.3' of
> > git://git.kernel.org/.../daeinki/drm-exynos into drm-next
> >       Merge tag 'for-airlie-armada' of
> > git://git.armlinux.org.uk/~rmk/linux-arm into drm-next
> >       Merge tag 'drm-misc-next-fixes-2019-06-27' of
> > git://anongit.freedesktop.org/drm/drm-misc into drm-next
> >       Merge tag 'drm-next-5.3-2019-06-27' of
> > git://people.freedesktop.org/~agd5f/linux into drm-next
> >       Merge tag 'drm-next-5.3-2019-07-09' of
> > git://people.freedesktop.org/~agd5f/linux into drm-next
> >       Merge tag 'imx-drm-next-2019-07-05' of
> > git://git.pengutronix.de/git/pza/linux into drm-next
> >       mm: adjust apply_to_pfn_range interface for dropped token.
> >
> > David Riley (4):
> >       drm/virtio: Ensure cached capset entries are valid before copying=
.
> >       drm/virtio: Wake up all waiters when capset response comes in.
> >       drm/virtio: Fix cache entry creation race.
> >       drm/virtio: Add memory barriers for capset cache.
> >
> > Deepak Rawat (2):
> >       drm/vmwgfx: Add debug message for layout change ioctl
> >       drm/vmwgfx: Use VMW_DEBUG_KMS for vmwgfx mode-setting user errors
> >
> > Derek Lai (1):
> >       drm/amd/display: add i2c_hw_Status check to make sure as HW I2c i=
n use
> >
> > Dmytro Laktyushkin (14):
> >       drm/amd/display: move signal type out of otg dlg params
> >       drm/amd/display: stop external access to internal optc sync param=
s
> >       drm/amd/display: fix acquire_first_split_pipe function
> >       drm/amd/display: add null checks and set update flags
> >       drm/amd/display: move vmid determination logic out of dc
> >       drm/amd/display: clean up validation failure log spam
> >       drm/amd/display: fix dsc validation
> >       drm/amd/display: fix fpga fclk programming
> >       drm/amd/display: fix dcn2 mpc split decision
> >       drm/amd/display: fix odm mpo disable
> >       drm/amd/display: fix macro_tile_size for tiling
> >       drm/amd/display: add null checks and set update flags for DCN2
> >       drm/amd/display: move vmid determination logic to a module
> >       drm/amd/display: add missing mod_vmid destructor
> >
> > Dongli Zhang (1):
> >       drm/i915: remove unused IO_TLB_SEGPAGES which should be defined b=
y swiotlb
> >
> > Dongwon Kim (1):
> >       drm/i915/gen11: enable support for headerless msgs
> >
> > Douglas Anderson (7):
> >       dt-bindings: drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc =
bus
> >       drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus
> >       drm/bridge/synopsys: dw-hdmi: Fix unwedge crash when no pinctrl e=
ntries
> >       drm: bridge: dw-hdmi: Add hook for resume
> >       drm/rockchip: dw_hdmi: Handle suspend/resume
> >       drm/rockchip: Properly adjust to a true clock in adjusted_mode
> >       drm/rockchip: Base adjustments of the mode based on prev adjustme=
nts
> >
> > Emil Velikov (2):
> >       drm/virtio: remove irrelevant DRM_UNLOCKED flag
> >       drm/omap: remove open-coded drm_invalid_op()
> >
> > Emily Deng (5):
> >       drm/amdgpu: fix unload driver fail
> >       drm/amdgpu: Need to set the baco cap before baco reset
> >       drm/amdgpu:Fix the unpin warning about csb buffer
> >       drm/amdgpu/sriov: Correct some register program method
> >       drm/amdgpu/display: Fix reload driver error
> >
> > Eric Anholt (11):
> >       drm/v3d: Switch the type of job-> to reduce casting.
> >       drm/v3d: Refactor job management.
> >       drm/v3d: Add support for compute shader dispatch.
> >       drm/v3d: Drop reservation of a shared slot in the dma-buf reserva=
tions.
> >       drm/v3d: Add missing implicit synchronization.
> >       drm/doc: Allow new UAPI to be used once it's in drm-next/drm-misc=
-next.
> >       drm/doc: Document expectation that userspace review looks at kern=
el uAPI.
> >       drm/v3d: Fix debugfs reads of MMU regs.
> >       drm/v3d: Set the correct DMA mask according to the MMU's limits.
> >       drm/v3d: Dump V3D error debug registers in debugfs, and one at re=
set.
> >       drm/v3d: Fix and extend MMU error handling.
> >
> > Eric Bernstein (5):
> >       drm/amd/display: Refactor DIO stream encoder
> >       drm/amd/display: Dont aser if DP_DPHY_INTERNAL_CTRL
> >       drm/amd/display: Refactor DIO stream encoder
> >       drm/amd/display: Alpha plane type
> >       drm/amd/display: expose enable dp output functions
> >
> > Eric Yang (8):
> >       drm/amd/display: Set dispclk and dprefclock directly
> >       drm/amd/display: move back vbios cmd table for set dprefclk
> >       drm/amd/display: make clk mgr soc specific
> >       drm/amd/display: Move CLK_BASE_INNER macro
> >       drm/amd/display: move clk_mgr files to right place
> >       drm/amd/display: Fix type of pp_smu_wm_set_range struct
> >       drm/amd/display: Refactor clk_mgr functions
> >       drm/amd/display: Refactor clk_mgr functions
> >
> > Erico Nunes (2):
> >       drm/lima: add timeout to drm scheduler init
> >       drm/scheduler: Fix job cleanup without timeout handler
> >
> > Ernst Sj=C3=B6strand (6):
> >       drm/amd/amdgpu: Indent AMD_IS_APU properly
> >       drm/amd/amdgpu: Fix amdgpu_set_pp_od_clk_voltage error check
> >       drm/amd/amdgpu: amdgpu_hwmon_show_temp: initialize temp
> >       drm/amd/amdgpu: Check stream in amdgpu_dm_commit_planes
> >       drm/amd/amdgpu: Fix style issues in dcn20_resource.c
> >       drm/amd/amdgpu: sdma_v4_0_start: initialize r
> >
> > Eryk Brol (5):
> >       drm/amd/display: Disable audio stream only if it's currently enab=
led
> >       drm/amd/display: Ensure DRR triggers in BP
> >       drm/amd/display: Increase Backlight Gain Step Size
> >       drm/amd/display: Ensure DRR triggers in BP
> >       drm/amd/display: Change DCN2 vupdate start programming
> >
> > Evan Quan (33):
> >       drm/amd/powerplay: support hotspot/memory critical limit values
> >       drm/amd/powerplay: support temperature emergency max values
> >       drm/amd/powerplay: support SMU metrics table on Vega12
> >       drm/amd/powerplay: expose current hotspot and memory temperatures=
 V2
> >       drm/amd/powerplay: support hwmon temperature channel labels V2
> >       drm/amd/powerplay: expose Vega12 current power
> >       drm/amd/powerplay: expose Vega12 current gpu activity
> >       drm/amd/powerplay: expose Vega20 realtime memory utilization
> >       drm/amd/powerplay: expose Vega12 realtime memory utilization
> >       drm/amd/powerplay: expose SMU7 asics realtime memory utilization
> >       drm/amdgpu: add new sysfs interface for memory realtime utilizati=
on
> >       drm/amdgpu: enable separate timeout setting for every ring type V=
4
> >       drm/amd/powerplay: fix Vega10 mclk/socclk voltage link setup
> >       drm/amd/powerplay: valid Vega10 DPMTABLE_OD_UPDATE_VDDC settings =
V2
> >       drm/amd/powerplay: avoid repeat AVFS enablement/disablement
> >       drm/amd/powerplay: update Vega10 power state on OD
> >       drm/amd/powerplay: force to update all clock tables on OD reset
> >       drm/amd/powerplay: update Vega10 ACG Avfs Gb parameters
> >       drm/amd/powerplay: drop unnecessary sw smu check
> >       drm/amd/powerplay: drop redundant smu call
> >       drm/amd/powerplay: support ppfeatures sysfs interface on sw smu r=
outine
> >       drm/amd/powerplay: honor hw limit on fetching metrics data
> >       drm/amd/powerplay: support uclk activity retrieve on sw smu routi=
ne
> >       drm/amd/powerplay: support sw smu hotspot and memory temperature =
retrieval
> >       drm/amd/powerplay: fix sw SMU wrong UVD/VCE powergate setting
> >       drm/amd/powerplay: enable ppfeaturemask module parameter support =
on Vega20
> >       drm/amd/powerplay: check gfxclk dpm enablement before proceeding
> >       drm/amd/powerplay: check prerequisite for VCN power gating
> >       drm/amd/powerplay: support runtime ppfeatures setting on Navi10
> >       drm/amd/powerplay: add missing smu_get_clk_info_from_vbios() call
> >       drm/amd/powerplay: no memory activity support on Vega10
> >       drm/amdgpu: fix MGPU fan boost enablement for XGMI reset
> >       drm/amd/powerplay: use hardware fan control if no powerplay fan t=
able
> >
> > Fabien Dessenne (2):
> >       drm/stm: ltdc: manage the get_irq probe defer case
> >       drm/stm: ltdc: return appropriate error code during probe
> >
> > Fabio Estevam (4):
> >       dt-bindings: Add vendor prefix for VXT Ltd
> >       dt-bindings: Add VXT VL050-8048NT-C01 panel bindings
> >       drm/panel: simple: Add support for VXT VL050-8048NT-C01 panel
> >       drm/damage-helper: Use NULL instead of 0
> >
> > Felix Kuehling (10):
> >       drm/amdgpu: Reserve shared fence for eviction fence
> >       drm/amdgpu: Improve error handling for HMM
> >       drm/amdkfd: Fix a circular lock dependency
> >       drm/amdkfd: Simplify eviction state logic
> >       drm/ttm: return -EBUSY if waiting for busy BO fails
> >       drm/amdkfd: Print a warning when the runlist becomes oversubscrib=
ed
> >       drm/amdgpu: Use FENCE_OWNER_KFD in process_sync_pds_resv
> >       drm/amdgpu: Fix tracking of invalid userptrs
> >       drm/amdkfd: Add chained_runlist_idle_disable flag to pm4_mes_runl=
ist
> >       drm/amdkfd: Disable idle optimization for chained runlist
> >
> > Fernando Pacheco (5):
> >       drm/i915/uc: Rename uC firmware init/fini functions
> >       drm/i915/uc: Reserve upper range of GGTT
> >       drm/i915/uc: Place uC firmware in upper range of GGTT
> >       Revert "drm/i915/guc: Disable global reset"
> >       drm/i915/selftests: Check that gpu reset is usable from atomic co=
ntext
> >
> > Flora Cui (1):
> >       drm/amdgpu: fix scheduler timeout calc
> >
> > Fuqian Huang (1):
> >       drm/amdgpu: Use kmemdup rather than duplicating its implementatio=
n
> >
> > Gary Kattan (1):
> >       drm/amd/display: Implement CM dealpha and bias interfaces
> >
> > Geert Uytterhoeven (2):
> >       drm/i915: Grammar s/the its/its/
> >       drm/amd/display: Add missing newline at end of file
> >
> > Gen Zhang (1):
> >       drm/edid: Fix a missing-check bug in drm_load_edid_firmware()
> >
> > Georgi Djakov (1):
> >       drm/msm/mdp5: Use the interconnect API
> >
> > Gerd Hoffmann (2):
> >       drm/cirrus: remove leftover files
> >       drm/virtio: drop framebuffer dirty tracking code
> >
> > Greg Hackmann (3):
> >       dma-buf: give each buffer a full-fledged inode
> >       dma-buf: add DMA_BUF_SET_NAME ioctls
> >       dma-buf: add show_fdinfo handler
> >
> > Greg Kroah-Hartman (17):
> >       vga_switcheroo: no need to check return value of debugfs_create f=
unctions
> >       panel: rocktech: no need to check return value of debugfs_create =
functions
> >       drm: no need to check return value of debugfs_create functions
> >       sti: no need to check return value of debugfs_create functions
> >       host1x: debugfs_create_dir() can never return NULL
> >       radeon: no need to check return value of debugfs_create functions
> >       amdgpu: no need to check return value of debugfs_create functions
> >       amdkfd: no need to check return value of debugfs_create functions
> >       amdgpu_dm: no need to check return value of debugfs_create functi=
ons
> >       drm: debugfs: make drm_debugfs_create_files() never fail
> >       drm/vc4: no need to check return value of debugfs_create function=
s
> >       drm/i915: no need to check return value of debugfs_create functio=
ns
> >       msm: adreno: no need to check return value of debugfs_create func=
tions
> >       msm: dpu1: no need to check return value of debugfs_create functi=
ons
> >       msm: no need to check return value of debugfs_create functions
> >       komeda: no need to check return value of debugfs_create functions
> >       malidp: no need to check return value of debugfs_create functions
> >
> > Gurchetan Singh (1):
> >       drm/virtio: use u64_to_user_ptr macro
> >
> > Gwan-gyeong Mun (6):
> >       drm/i915/dp: Add a config function for YCBCR420 outputs
> >       drm: Rename struct edp_vsc_psr to struct dp_sdp
> >       drm/i915/dp: Program VSC Header and DB for Pixel
> > Encoding/Colorimetry Format
> >       drm/i915/dp: Add a support of YCBCR 4:2:0 to DP MSA
> >       drm/i915/dp: Change a link bandwidth computation for DP
> >       drm/i915/dp: Support DP ports YUV 4:2:0 output to GEN11
> >
> > Hans de Goede (7):
> >       drm/i915/dsi: Call drm_connector_cleanup on vlv_dsi_init error ex=
it path
> >       drm/i915/dsi: Use a fuzzy check for burst mode clock check
> >       drm: panel-orientation-quirks: Add quirk for GPD pocket2
> >       drm: panel-orientation-quirks: Add quirk for GPD MicroPC
> >       drm/i915/dsi: Move logging of DSI VBT parameters to a helper func=
tion
> >       drm/i915/dsi: Move vlv/icl_dphy_param_init call out of
> > intel_dsi_vbt_init (v2)
> >       drm/i915/dsi: Read back pclk set by GOP and use that as pclk (v3)
> >
> > Hariprasad Kelam (2):
> >       drm/bridge: analogix_dp: possible condition with no effect (if =
=3D=3D else)
> >       drm/amd/display: fix compilation error
> >
> > Harish Kasiviswanathan (1):
> >       drm/amdkfd: Fix compute profile switching
> >
> > Harmanprit Tatla (1):
> >       drm/amd/display: Gamma logic limitations causing unintended use
> > of RAM over ROM.
> >
> > Harry Wentland (26):
> >       drm/amd/display: Add ASICREV_IS_PICASSO
> >       drm/amd/display: Don't load DMCU for Raven 1 (v2)
> >       drm/amd/display: Drop DCN1_01 guards
> >       drm/amd/display: Read soc_bounding_box from gpu_info (v2)
> >       drm/amd/display: Add DCN2 and NV ASIC ID
> >       drm/amd/display: add AUX and I2C for DCN2
> >       drm/amd/display: Add GPIO support for DCN2
> >       drm/amd/display: Add DCN2 BIOS parsing
> >       drm/amd/display: Add DCN2 IRQ handling
> >       drm/amd/display: Add DCN2 changes to DML
> >       drm/amd/display: Add DCN2 DIO
> >       drm/amd/display: Add DCN2 clk mgr
> >       drm/amd/display: Add DCN2 OPTC
> >       drm/amd/display: Add DCN2 OPP
> >       drm/amd/display: Add DCN2 MPC
> >       drm/amd/display: Add DCN2 DPP
> >       drm/amd/display: Add DCN2 HUBP and HUBBUB
> >       drm/amd/display: Add DCN2 MMHUBBUB
> >       drm/amd/display: Add DCN2 DWB
> >       drm/amd/display: Add DCN2 IPP
> >       drm/amd/display: Add DCN2 VMID
> >       drm/amd/display: Add DCN2 HW Sequencer and Resource
> >       drm/amd/display: Add DC core changes for DCN2
> >       drm/amd/display: Hook DCN2 into amdgpu_dm and expose as config (v=
2)
> >       drm/amdgpu: Enable DC support for Navi10
> >       drm/amd/display: Add DSC support for Navi (v2)
> >
> > Hawking Zhang (83):
> >       drm/amdgpu/psp: udpate ta_ras interface header
> >       drm/amdgpu: add ATHUB 2.0 register headers
> >       drm/amdgpu: add CLK 11.0 register headers
> >       drm/amdgpu: add DCN 2.0 register headers
> >       drm/amdgpu: add HDP 5.0 register headers
> >       drm/amdgpu: add MP 11.0 register headers
> >       drm/amdgpu: add NBIO 2.3 register headers
> >       drm/amdgpu: add VCN 2.0 register headers
> >       drm/amdgpu: add GC 10.1 register headers (v4)
> >       drm/amdgpu: add MMHUB 2.0 register headers
> >       drm/amdgpu: add OSS 5.0 register headers
> >       drm/amdgpu: add SMUIO 11.0 register headers
> >       drm/amdgpu: add navi10 enums header
> >       drm/amdgpu: atomfirmware.h updates for navi10
> >       drm/amdgpu: add doorbell assignement for navi10
> >       drm/amdgpu: add navi10 ip offset header
> >       drm/amdgpu: Add GDDR6 in vram_name arrary
> >       drm/amdgpu: add gfx10 specific config in amdgpu_gfx_config
> >       drm/amdgpu: add gfx10 specific new member pa_sc_tile_steering_ove=
rride
> >       drm/amdgpu: add gpu_info_firmware v1_1 structure for navi10
> >       drm/amdgpu: parse the new members added by gpu_info ucode v1_1
> >       drm/amdgpu: add sdma v5 packet header file
> >       drm/amdgpu: add navi pm4 header
> >       drm/amdgpu: query vram type from atomfirmware vram_info
> >       drm/amdgpu: query vram_width from vram_info table
> >       drm/amdgpu: add nbio v2.3 for navi10 (v4)
> >       drm/amdgpu/gfx10: new approach to load pfp fw (v4)
> >       drm/amdgpu/gfx10: new approach to load ce fw (v4)
> >       drm/amdgpu/gfx10: new approach to load gfx10 me fw (v4)
> >       drm/amdgpu: add members in amdgpu_me for gfx queue
> >       drm/amdgpu: acquire available gfx queues
> >       drm/amdgpu: add helper function for gfx queue/bitmap transition
> >       drm/amdgpu: rename amdgpu_gfx_compute_mqd_sw_init
> >       drm/amdgpu: Move common code to amdgpu_gfx.c
> >       drm/amdgpu: enable gfx eop interrupt per gfx pipe
> >       drm/amdgpu: add module parameter for async_gfx_ring enablement
> >       drm/amdgpu: create mqd for gfx queues on navi10
> >       drm/amdgpu: add new HDP CG flags
> >       drm/amdgpu: add flag to support IH clock gating
> >       drm/amdgpu: correct pte mtype field for navi
> >       drm/amd/gmc9: rename AMDGPU_PTE_MTYPE to AMDGPU_PTE_MTYPE_VG10
> >       drm/amdgpu: add gfxhub v2.0 block for navi10 (v4)
> >       drm/amdgpu: add mmhub v2 block for navi10 (v4)
> >       drm/amdgpu: add gmc v10 ip block for navi10 (v6)
> >       drm/amdgpu: add irq sources for gfx v10_1
> >       drm/amdgpu: add irq sources for sdma v5_0
> >       drm/amdgpu: add irq sources for vcn v2_0 (v2)
> >       drm/amd/display: move dcn v1_0 irq source header to ivsrcid/dcn/
> >       drm/amdgpu: add navi10 ih ip block (v3)
> >       drm/amdgpu: add structure to support build-in toc to psp sos
> >       drm/amdgpu/psp: support init psp sos microcode with build-in toc
> >       drm/amdgpu: use rlc toc from psp sos binary
> >       drm/amdgpu: rename rlc autoload to backdoor autoload
> >       drm/amdgpu: add helper function to print psp hdr
> >       drm/amdgpu/psp: print out psp v11 ucode hdr in drm debug mode
> >       drm/amdgpu/psp: support print out psp firmware header v1_1 info
> >       drm/amdgpu/psp: add structure to support load toc in psp (v2)
> >       drm/amdgpu/psp: add support to load TOC to psp
> >       drm/amdgpu/psp: start rlc autoload after psp recieved all gfx fir=
mware
> >       drm/amdgpu/psp: switch to use sos_offset_bytes member as sys_bin_=
size
> >       drm/amdgpu/psp: perform tmr_init and asd_init after loading sysdr=
v/sos
> >       drm/amdgpu/psp: update psp gfx interface to match with psp fw (v2=
)
> >       drm/amdgpu/psp: initialize autoload_supported flag in psp_sw_init
> >       drm/amd/amdgpu: add flag to mark whether autoload is supported or=
 not
> >       drm/amdgpu/psp: skip mec jt when autoload is enabled
> >       drm/amdgpu: enable psp front door loading by default on navi10
> >       drm/amdgpu: declare navi10 asd firmware
> >       drm/amdgpu/psp11: skip ta firmware for navi10
> >       drm/amdgpu: add pa_sc_tile_steering_override to drm_amdgpu_info_d=
evice
> >       drm/amdgpu: set the default value of pa_sc_tile_steering_override
> >       drm/amdgpu: add initial support for sdma v5.0 (v6)
> >       drm/amdgpu: add gfx v10 implementation (v10)
> >       drm/amdgpu: avoid to use SOC15_REG_OFFSET in static array for nav=
i10
> >       drm/amdgpu: add navi10 common ip block (v3)
> >       drm/amdgpu: Add navi10 kfd support for amdgpu (v3)
> >       drm/amdgpu: update golden setting programming logic
> >       drm/amdgpu: enable sw smu driver for navi10 by default
> >       drm/amd/powerplay: remove uvd_gated/vce_gated from smu_power_cont=
ext (v2)
> >       drm/amd/powerplay: move get_thermal_temperature_range to ppt func=
s
> >       drm/amd/powerplay: fix no statements in function returning non-vo=
id
> >       drm/amdgpu: initialize THM & CLK IP registers base address
> >       drm/amd/display: enable DSC support by default
> >       drm/amdgpu: fix modprobe failure for uvd_4/5/6
> >
> > Huang Rui (40):
> >       drm/amdgpu: add navi10 asic type
> >       drm/amdgpu: add NV series gpu family id
> >       drm/amdgpu: add GDDR6 vram type
> >       drm/amdgpu: add navi10 gpu info firmware
> >       drm/amdgpu: add v10 structs header (v2)
> >       drm/amdgpu: add gfx v10 clear state header v2
> >       drm/amdgpu: set navi10's fw loading type as direct
> >       drm/amdgpu: load smc ucode at first with psp while rlc auto load
> > is supported
> >       drm/amdgpu: add to set navi ip blocks
> >       drm/amd/powerplay: update smu v11 ppsmc header
> >       drm/amd/powerplay: update smu 11 driver if header for navi10
> >       drm/amd/powerplay: fix the mp/smuio header for navi10
> >       drm/amd/powerplay: introduce the navi10 pptable implementation
> >       drm/amd/powerplay: set smu v11 funcs for navi10
> >       drm/amd/powerplay: add navi10 smc ucode init and navi10 ppt
> > functions setting
> >       drm/amd/powerplay: move bootup value before read pptable from vbi=
os
> >       drm/amd/powerplay: update smu11 driver if header for navi10 (v2)
> >       drm/amdgpu: bump smc firmware header version to v2 (v2)
> >       drm/amdgpu: fix the issue of checking on message mapping
> >       drm/amd/powerplay: smu needs to be initialized after rlc in direc=
t mode
> >       drm/amd/powerplay: introduce the function to load the soft
> > pptable for navi10 (v2)
> >       drm/amd/powerplay: modify the feature mask to enable gfx/soc dpm
> >       drm/amd/powerplay: skip od feature on navi10 for the moment
> >       drm/amd/powerplay: introduce smu clk type to handle ppclk for eac=
h asic
> >       drm/amd/powerplay: introduce smu feature type to handle feature
> > mask for each asic
> >       drm/amd/powerplay: introduce smu table id type to handle the smu
> > table for each asic
> >       drm/amd/powerplay: init table_count for smu tables on asic level
> >       drm/amd/powerplay: add tables_init interface for each asic
> >       drm/amd/powerplay: modify smu_update_table to use SMU_TABLE_xxx
> > as the input
> >       drm/amd/powerplay: use the table size member in the structure
> > instead of getting directly
> >       drm/amd/powerplay: move PPTable_t uses into asic level
> >       drm/amd/powerplay: move SmuMetrics_t uses into asic level
> >       drm/amd/powerplay: move Watermarks_t uses into asic level
> >       drm/amd/powerplay: introduce smu power source type to handle
> > AC/DC source for each asic
> >       drm/amd/powerplay: move getting MAX_FAN_RPM value to asic level
> >       drm/amd/powerplay: don't include the smu11 driver if header in
> > smu v11 (v2)
> >       drm/amd/powerplay: do not set dpm_enabled flag before VCN/DCN
> > DPM is workable
> >       drm/amd/powerplay: set dpm_enabled flag but don't enable vcn dpm
> >       drm/amd/powerplay: make mmhub pg bit configured by pg_flags
> >       drm/amd/powerplay: make athub pg bit configured by pg_flags
> >
> > Hugo Hu (1):
> >       drm/amd/display: Don't use ROM for output TF if GAMMA_CS_TFM_1D
> >
> > Icenowy Zheng (1):
> >       dt-bindings: gpu: add bus clock for Mali Midgard GPUs
> >
> > Ilya Bakoulin (8):
> >       drm/amd/display: Add writeback_config to VBA vars
> >       drm/amd/display: Add writeback_config to VBA vars
> >       drm/amd/display: Fix DCFCLK and SOCCLK not set
> >       drm/amd/display: Fix ODM combine data format
> >       drm/amd/display: Fix LB BPP and Cursor width
> >       drm/amd/display: Drive-by fixes for display_mode_vba
> >       drm/amd/display: Fix incorrect DML output_bpp value
> >       drm/amd/display: Fix incorrect vba type
> >
> > Imre Deak (19):
> >       drm/i915/icl: Fix MG_DP_MODE() register programming
> >       drm/i915/icl: Factor out combo PHY lane power setup helper
> >       drm/i915/icl: Add missing combo PHY lane power setup
> >       drm/i915: Tune down WARN about incorrect VBT TC legacy flag
> >       drm/i915/icl: More workaround for port F detection due to broken =
VBTs
> >       drm/i915: Add support for tracking wakerefs w/o power-on guarante=
e
> >       drm/i915: Force printing wakeref tacking during pm_cleanup
> >       drm/i915: Verify power domains state during suspend in all cases
> >       drm/i915: Add support for asynchronous display power disabling
> >       drm/i915: Disable power asynchronously during DP AUX transfers
> >       drm/i915: WARN for eDP encoders in intel_dp_detect_dpcd()
> >       drm/i915: Remove the unneeded AUX power ref from intel_dp_detect(=
)
> >       drm/i915: Remove the unneeded AUX power ref from intel_dp_hpd_pul=
se()
> >       drm/i915: Replace use of PLLS power domain with DISPLAY_CORE doma=
in
> >       drm/i915: Avoid taking the PPS lock for non-eDP/VLV/CHV
> >       drm/i915: Assert that TypeC ports are not used for eDP
> >       drm/i915/icl: Fix AUX-B HW not done issue w/o AUX-A
> >       drm/mst: Fix MST sideband up-reply failure handling
> >       drm/i915/icl: Ensure port A combo PHY HW state is correct
> >
> > Jack Xiao (51):
> >       drm/amdgpu/gfx10: add special unmap_queues packet for preemption
> >       drm/amdgpu: enable async gfx ring by default
> >       drm/amdgpu/athub2: enable athub2 clock gating
> >       drm/amdgpu: refine the PTE encoding of PRT for navi10
> >       drm/amdgpu: add the trailing fence per ring
> >       drm/amdgpu: add mcbp driver parameter
> >       drm/amdgpu: enable the static csa when mcbp enabled
> >       drm/amdgpu: add ib preemption status in amdgpu_job (v2)
> >       drm/amdgpu/sdma: allocate CSA per sdma ring
> >       drm/amdgpu: program for resuming preempted ib
> >       drm/amdgpu: add mcbp unit test in debugfs (v3)
> >       drm/amdgpu: mark the partial job as preempted in mcbp unit test
> >       drm/amdgpu/mes: add amdgpu_mes driver parameter
> >       drm/amdgpu/mes: add mes header file and definition
> >       drm/amdgpu/mes: add definitions of ip callback function
> >       drm/amdgpu/mes: enable mes on navi10 and later asic
> >       drm/amdgpu/mes10.1: add ip block mes10.1 (v2)
> >       drm/amdgpu/gfx10: fix issues for suspend/resume
> >       drm/amdgpu/vcn2: notify SMU power up/down VCN
> >       drm/amdgpu/vcn2: don't access register when power gated
> >       drm/amdgpu: enable vcn dpm scheme for navi
> >       drm/amdgpu/nv: set vcn pg flag
> >       drm/amdgpu/sdma5: incorrect variable type for gpu address
> >       drm/amdgpu/ucode: add the definitions of MES ucode and ucode data
> >       drm/amdgpu/ucode: add mes firmware file support
> >       drm/amdgpu/mes10.1: add mes firmware info fields
> >       drm/amdgpu/mes10.1: load mes firmware file to CPU buffer
> >       drm/amdgpu/mes10.1: implement ucode CPU buffer destruction
> >       drm/amdgpu/mes10.1: upload mes ucode to gpu buffer
> >       drm/amdgpu/mes10.1: upload mes data ucode to gpu buffer
> >       drm/amdgpu/mes10.1: implement ucode buffers destruction
> >       drm/amdgpu/mes10.1: implement MES firmware backdoor loading
> >       drm/amdgpu/mes10.1: implement mes enablement function
> >       drm/amdgpu/mes10.1: enable mes FW backdoor loading
> >       drm/amd/powerplay/smu11: disable PLL shutdown when gfxoff enabled
> >       drm/amdgpu: RLC must be disabled after SMU when S3 on navi
> >       drm/amdgpu/gfx10: remove unnecessary waiting on gfx inactive
> >       drm/amdgpu/gfx10: require to pin/unpin CSIB BO when suspend/resum=
e
> >       drm/amd: the data retured from PRT is expected to be 0
> >       drm/amdgpu/psp: add new VCN RAM ucode id to psp
> >       drm/amdgpu: add corresponding vcn ram ucode id
> >       drm/amdgpu/psp: convert ucode id to psp ucode id
> >       drm/amdgpu/psp: add new psp interface for vcn updating sram
> >       drm/amd/powerplay: update smu11_driver_if_navi10.h
> >       drm/amd/powerplay: disable fw dstate when gfxoff is enabled
> >       drm/amd/powerplay: enable BACO feature as WAR
> >       drm/amdgpu: add field indicating if has PCIE atomics support
> >       drm/amdgpu: enable PCIE atomics ops support
> >       drm/amdkfd: remove duplicated PCIE atomics request
> >       drm/amdkfd: remove an unused variable
> >       drm/amd/powerplay: increase waiting time for smu response
> >
> > Jack Zhang (1):
> >       drm/amdgpu/sriov: fix Tonga load driver failed
> >
> > Jagadeesh Pagadala (1):
> >       gpu/drm: Remove duplicate headers
> >
> > Jagan Teki (4):
> >       dt-bindings: display: Document FriendlyELEC HD702E LCD panel
> >       drm/panel: simple: Add FriendlyELEC HD702E 800x1280 LCD panel
> >       drm/sun4i: sun6i_mipi_dsi: Support DSI GENERIC_SHORT_WRITE_2 tran=
sfer
> >       drm/panel: st7701: Swap vertical front and back porch timings
> >
> > James Clarke (1):
> >       drm: Fix drm.h uapi header for GNU/kFreeBSD
> >
> > James Zhu (6):
> >       drm/amdgpu: add EDC counter register
> >       drm/amdgpu: add gfx9 gpr EDC workaround when RAS is enabled
> >       drm/amdgpu: Fix S3 test issue
> >       drm/amdgpu: Fixed missing to clear some EDC count
> >       drm/amdgpu: Add GDS clearing workaround in later init for gfx9
> >       drm/amdgpu: explicitly set mmGDS_VMID0_BASE to 0
> >
> > Jani Nikula (69):
> >       Merge drm/drm-next into drm-intel-next-queued
> >       drm/i915: ensure more headers remain self-contained
> >       drm/i915: make intel_bios.h self-contained
> >       drm/i915/dvo: rename dvo.h to intel_dvo_dev.h and make self-conta=
ined
> >       drm/i915: make intel_dpll_mgr.h self-contained
> >       drm/i915: move dsi init functions to intel_dsi.h
> >       drm/i915: extract intel_fifo_underrun.h from intel_drv.h
> >       drm/i915: extract intel_dp_link_training.h from intel_drv.h
> >       drm/i915: extract intel_dp_aux_backlight.h from intel_drv.h
> >       drm/i915: extract i915_irq.h from intel_drv.h and i915_drv.h
> >       drm/i915: extract intel_hotplug.h from intel_drv.h and i915_drv.h
> >       drm/i915: extract intel_bios.h functions from i915_drv.h
> >       drm/i915: extract intel_quirks.h from intel_drv.h
> >       drm/i915: extract intel_overlay.h from intel_drv.h and i915_drv.h
> >       drm/i915: extract intel_vdsc.h from intel_drv.h and i915_drv.h
> >       drm/i915: extract intel_dp_mst.h from intel_drv.h
> >       drm/i915: extract intel_dsi_dcs_backlight.h from intel_drv.h
> >       drm/i915: extract intel_atomic.h from intel_drv.h
> >       drm/i915: extract intel_runtime_pm.h from intel_drv.h
> >       drm/i915: move some leftovers to intel_pm.h from i915_drv.h
> >       drm/i915: extract intel_combo_phy.h from i915_drv.h
> >       drm/i915/csr: alpha_support doesn't depend on csr or vice versa
> >       drm/i915: add single combo phy init/unit functions
> >       drm/i915/dvo: move DVO chip types to intel_dvo.c
> >       drm/i915/dsi: move operation mode types to intel_dsi.h
> >       drm/i915: move ranges to intel_display.c
> >       drm/i915: remove unused/stale macros and comments from intel_drv.=
h
> >       drm/i915/csr: move CSR version macros to intel_csr.h
> >       drm/i915: extract intel_dpio_phy.h from i915_drv.h
> >       drm/i915: extract intel_lpe_audio.h from i915_drv.h
> >       drm/i915: extract intel_acpi.h from i915_drv.h
> >       drm/i915: extract i915_debugfs.h from i915_drv.h
> >       drm/i915: move i915_vgacntrl_reg() where needed
> >       drm/i915: make i915_utils.h self-contained
> >       drm/i915: move more generic utils to i915_utils.h
> >       drm/i915: extract intel_gmbus.h from i915_drv.h and rename intel_=
i2c.c
> >       drm/dp: drmP.h include removal
> >       drm/edid: drmP.h include removal
> >       drm/i915: Update DRIVER_DATE to 20190523
> >       drm/i915: remove duplicate typedef for intel_wakeref_t
> >       drm/i915: Update DRIVER_DATE to 20190524
> >       drm/i915: make REG_BIT() and REG_GENMASK() work with variables
> >       Merge drm/drm-next into drm-intel-next-queued
> >       Revert "drm/i915: Expand subslice mask"
> >       drm/i915: add force_probe module parameter to replace alpha_suppo=
rt
> >       drm/i915/bios: make child device order the priority order
> >       drm/i915/bios: store child device pointer in DDI port info
> >       drm/i915/bios: refactor DDC pin and AUX CH sanitize functions
> >       drm/i915/bios: use port info child pointer to determine HPD inver=
t
> >       drm/i915/bios: use port info child pointer to determine LSPCON pr=
esence
> >       drm/i915/bios: clean up VBT port info debug logging
> >       drm/i915/bios: remove unused, obsolete VBT definitions
> >       drm/i915/bios: reserve struct bdb_ prefix for BDB blocks
> >       drm/i915/bios: add BDB block comments before definitions
> >       drm/i915/bios: sort BDB block definitions using block ID
> >       drm/i915/bios: add VBT swing bit to child device definition
> >       drm/i915/bios: add more LFP options
> >       drm/i915/bios: add an enum for BDB block IDs
> >       Documentation/i915: Fix kernel-doc references to moved gem files
> >       drm/i915: fix documentation build warnings
> >       drm/i915: move pm related declarations to intel_pm.h
> >       drm/i915: remove some unused declarations from intel_drv.h
> >       drm/i915: move more atomic plane declarations to intel_atomic_pla=
ne.h
> >       drm/i915/frontbuffer: remove obsolete comment about mark busy/idl=
e
> >       drm/i915: make intel_sdvo_regs.h self-contained
> >       drm/i915: move modesetting output/encoder code under display/
> >       drm/i915: move modesetting core code under display/
> >       Documentation/i915: fix file references after display/ subdir ren=
ames
> >       drm/i915: Update DRIVER_DATE to 20190619
> >
> > Janusz Krzysztofik (2):
> >       drm/i915: Use drm_dev_unplug()
> >       drm/i915: Split off pci_driver.remove() tail to drm_driver.releas=
e()
> >
> > Jay Cornwall (5):
> >       drm/amdkfd: Fix gfx8 MEM_VIOL exception handler
> >       drm/amdkfd: Preserve wave state after instruction fetch MEM_VIOL
> >       drm/amdkfd: Fix gfx9 XNACK state save/restore
> >       drm/amdkfd: Preserve ttmp[4:5] instead of ttmp[14:15]
> >       drm/amdkfd: Implement queue priority controls for gfx9
> >
> > Jayant Shekhar (3):
> >       drm/msm/dpu: clean up references of DPU custom bus scaling
> >       drm/msm/dpu: Integrate interconnect API in MDSS
> >       dt-bindings: msm/disp: Introduce interconnect bindings for MDSS o=
n SDM845
> >
> > Jeffrey Hugo (6):
> >       drm/msm/mdp5: Fix mdp5_cfg_init error return
> >       dt-bindings: msm/dsi: Add 10nm phy for msm8998 compatible
> >       drm/msm/dsi: Add support for MSM8998 10nm dsi phy
> >       drm/msm/dsi: Add old timings quirk for 10nm phy
> >       drm/msm/dsi: Add support for MSM8998 DSI controller
> >       drm/msm/adreno: Add A540 support
> >
> > Jerome Brunet (1):
> >       drm/meson: imply dw-hdmi i2s audio for meson hdmi
> >
> > John Harrison (3):
> >       drm/i915: Support flags in whitlist WAs
> >       drm/i915: Support whitelist workarounds on all engines
> >       drm/i915: Add whitelist workarounds for ICL
> >
> > Jonas Karlman (1):
> >       drm: Add reference counting on HDR metadata blob
> >
> > Jonathan Bakker (1):
> >       dt-bindings: panel: Add Samsung S6E63M0 panel documentation
> >
> > Jonathan Kim (4):
> >       drm/amdgpu: add df perfmon regs and funcs for xgmi
> >       drm/amdgpu: update df_v3_6 for xgmi perfmons (v2)
> >       drm/amdgpu: add pmu counters
> >       drm/amdgpu:  add sw_init to df_v1_7
> >
> > Jordan Crouse (7):
> >       drm/msm/adreno: Enable 64 bit mode by default on a5xx and a6xx ta=
rgets
> >       drm/msm: Print all 64 bits of the faulting IOMMU address
> >       drm/msm: Pass the MMU domain index in struct msm_file_private
> >       drm/msm/dpu: Fix error recovery after failing to enable clocks
> >       drm/msm/dpu: Avoid a null de-ref while recovering from kms init f=
ail
> >       drm/msm/adreno: Call pm_runtime_force_suspend() during unbind
> >       drm/msm/adreno: Ensure that the zap shader region is big enough
> >
> > Jordan Lazare (1):
> >       drm/amd/display: Remove superflous error message
> >
> > Joshua Aberback (8):
> >       drm/amd/display: Program VTG params after programming Global Sync
> >       drm/amd/display: Rename EDID_BLOCK_SIZE to DC_EDID_BLOCK_SIZE
> >       drm/amd/display: Program VTG params after programming Global Sync=
 for DCN2
> >       drm/amd/display: Remove dependency on pipe->plane for immedaite
> > flip status
> >       drm/amd/display: Optimize bandwidth validation by adding early re=
turn
> >       drm/amd/display: Add profiling tools for bandwidth validation
> >       drm/amd/display: Remove OPP clock programming on plane disable
> >       drm/amd/display: Set test pattern on blank when using Visual Conf=
irm
> >
> > Josip Pavic (1):
> >       drm/amd/display: enable abm on dcn2
> >
> > Jos=C3=A9 Roberto de Souza (1):
> >       drm/i915/psr: Force manual PSR exit in older gens
> >
> > Jun Lei (10):
> >       drm/amd/display: add support for disconnected eDP panels
> >       drm/amd/display: dont set  otg offset
> >       drm/amd/display: Add min_dcfclk_mhz field to bb overrides
> >       drm/amd/display: update calculated bounding box logic for NV
> >       drm/amd/display: fix pstate allow handling in dcn2
> >       drm/amd/display: always use 4 dp lanes for dml
> >       drm/amd/display: Add missing VM conversion from hw values
> >       drm/amd/display: add support for forcing DCFCLK without
> > affecting watermarks
> >       drm/amd/display: making DCN20 WM table non-overlapping
> >       drm/amd/display: update DCN2 uclk switch time
> >
> > Justin Swartz (1):
> >       drm/rockchip: dw_hdmi: add basic rk3228 support
> >
> > Jyri Sarha (7):
> >       dt-bindings: drm/panel: simple: Add binding for TFC S9700RTWV43TR=
-01B
> >       drm/panel: simple: Add TFC S9700RTWV43TR-01B 800x480 panel suppor=
t
> >       drm/bridge: sii902x: Set output mode to HDMI or DVI according to =
EDID
> >       drm/bridge: sii902x: pixel clock unit is 10kHz instead of 1kHz
> >       dt-bindings: display: sii902x: Remove trailing white space
> >       dt-bindings: display: sii902x: Add HDMI audio bindings
> >       drm/bridge: sii902x: Implement HDMI audio support
> >
> > J=C3=A9r=C3=B4me Glisse (1):
> >       dma-buf: balance refcount inbalance
> >
> > Kefeng Wang (1):
> >       drm/omap: Use dev_get_drvdata()
> >
> > Kenneth Feng (15):
> >       drm/amd/powerplay: enable backdoor smu fw loading (v2)
> >       drm/amd/powerplay: enable power features
> >       drm/amd: add gfxoff support on navi10
> >       drm/amd/amdgpu: fw version check with gfxoff
> >       drm/amd/powerplay: gfxoff-seperate the Vega20 case
> >       drm/amd/powerplay: enable DCEFCLK dpm support
> >       drm/amd/powerplay: fix the incorrect type of pptable
> >       drm/amd/powerplay: update smu11_driver_if_navi10.h
> >       drm/amd/powerplay: enable vcn powergating v2
> >       drm/amd/powerplay: add new interface for vcn powergating
> >       amd/powerplay: fix the issue of uclk dpm
> >       amd/powerplay: enable uclk dpm
> >       amd/powerplay: update the vcn pg
> >       drm/amd/powerplay: enable gfxclk ds,dcefclk ds and fw dstate on n=
avi10
> >       drm/amd/powerplay: enable ac/dc feature on navi10
> >
> > Kent Russell (8):
> >       drm/amdgpu: Add replay counter defines to NBIO headers
> >       drm/amdgpu: Add PCIe replay count sysfs file
> >       drm/amdgpu: Fix CIK references in gmc_v8
> >       drm/amdkfd: Cosmetic cleanup
> >       drm/amdkfd: Add VegaM support
> >       drm/amdgpu: Add Unique Identifier sysfs file unique_id v2
> >       drm/amdgpu: Add CHIP_VEGAM to amdgpu_amdkfd_device_probe
> >       drm/amdkfd: Add procfs-style information for KFD processes
> >
> > Kevin Wang (62):
> >       drm/amd/powerplay: add helper function to get smu firmware & if v=
ersion
> >       drm/amd/powerplay: move the funciton of conv_profile_to_workload
> > to asic file
> >       drm/amd/powerplay: move the function of get[set]_power_profile
> > to asic file
> >       drm/amd/powerplay: move the function of uvd&vce dpm to asic file
> >       drm/amd/powerplay: move the function of read_sensor to asic file
> >       drm/amd/powerplay: move the function of is_dpm_running to asic fi=
le
> >       drm/amd/powerplay: add smu11 smu_if_version check for navi10
> >       drm/amd/powerplay: implement smc firmware v2.1 for smu11
> >       drm/amd/powerplay: remove duplicate code from smu hw init
> >       drm/amd/powerplay: optimization feature mask function for asic
> >       drm/amd/powerplay: add allowed feature mask for navi10
> >       drm/amd/powerplay: add function get current clock freq interface
> > for navi10
> >       drm/amd/powerplay: add helper function to get dpm freq informatio=
ns
> >       drm/amd/powerplay: add function print_clk_levels for navi10
> >       drm/amd/powerplay: add helper function of smu_get_dpm_freq_range
> >       drm/amd/powerplay: add helper function of smu_set_soft_freq_range
> >       drm/amd/powerplay: add helper function of smu_set_hard_freq_range
> >       drm/amd/powerplay: add function force_clk_levels for navi10
> >       drm/amd/powerplay: add function populate_umd_state_clk for navi10
> >       drm/amd/powerplay: add function get_clock_by_type_with_latency fo=
r navi10
> >       drm/amd/powerplay: add function pre_display_config_changed for na=
vi10
> >       drm/amd/powerplay: add function display_configuration_changed for=
 navi10
> >       drm/amd/powerplay: add funciton force_dpm_limit for navi10
> >       drm/amd/powerplay: add function unforce_dpm_levels for navi10
> >       drm/amd/powerplay: add function get_gpu_power for navi10
> >       drm/amd/powerplay: add function get_current_activity_percent for =
navi10
> >       drm/amd/powerplay: move read sensor of UVD[VCE]_POWER to amdgpu_s=
mu file
> >       drm/amd/powerplay: add function is_dpm_running for navi10
> >       drm/amd/powerplay: add function set_thermal_fan_table for navi10
> >       drm/amd/powerplay: add function get_fan_speed_percent for navi10
> >       drm/amd/powerplay: remove upload_dpm_level function for vega20
> >       drm/amd/powerplay: add function get_workload_type_map for swsmu
> >       drm/amd/powerplay: add funciton get[set]_power_profile_mode for
> > navi10 (v2)
> >       drm/amd/powerplay: add function get_profiling_clk_mask for navi10
> >       drm/amd/powerplay: add function notify_smc_display_config_change
> > for navi10
> >       drm/amd/powerplay: add function set_watermarks_table function for=
 navi10
> >       drm/amd/powerplay: add function read_sensor for navi10
> >       drm/amd/powerplay: fix dpm freq unit error (10KHz -> Mhz)
> >       drm/amd/powerplay: simplify the interface of get_current_activity=
_percent
> >       drm/amd/powerplay: simplify the interface of get_gpu_power
> >       drm/amd/powerplay: fix amdgpu_pm_info show gpu load error
> >       drm/amd/powerplay: add sclk sysfs interface support for navi10
> >       drm/amd/powerplay: enable uclk dpm default on navi10
> >       drm/amd/powerplay: move power_dpm_force_performance_level to
> > amdgpu_smu file
> >       drm/amd/powerplay: move function get_metrics_table to vega20_ppt
> >       drm/amd/powerplay: move function thermal_get_temperature to veag2=
0_ppt
> >       drm/amd/powerplay: add thermal ctf support for navi10
> >       drm/amd/powerplay: remove smu mutex lock in smu_hw_init
> >       drm/amd/powerplay: remove smu callback funciton get_mclk(get_sclk=
)
> >       drm/amd/powerplay: fix deadlock issue for smu_force_performance_l=
evel
> >       drm/amd/powerplay: fix clk type name error OD_SCLK OD_MCLK
> >       drm/amd/powerplay: move od8_setting helper function to vega20_ppt
> >       drm/amd/powerplay: move od_default_setting callback to asic file
> >       drm/amd/powerplay: simplified od_settings for each asic
> >       drm/amd/powerplay: use pp_feature_mask to control uclk(mclk) dpm =
enabled
> >       drm/amd/powerplay: remove unsupport function
> > set_thermal_fan_table for navi10
> >       drm/amd/powerplay: fix fan speed show error (for hwmon pwm)
> >       drm/amd/powerplay: print smu versions only if version mismatch
> >       drm/amd/powerplay: add feature check in unforce_dpm_levels functi=
on (v2)
> >       drm/amd/powerplay: add baco smu reset function for smu11
> >       drm/amdgpu: add mode1 (psp) reset for navi asic
> >       drm/amd/powerplay: add temperature sensor support for navi10
> >
> > Kieran Bingham (1):
> >       drm: rcar-du: writeback: include interface header
> >
> > Krunoslav Kovac (3):
> >       drm/amd/display: Add GSL source select registers
> >       drm/amd/display: CS_TFM_1D only applied post EOTF
> >       drm/amd/display: fix gamma logic breaking driver unload
> >
> > Laurent Pinchart (11):
> >       drm: bridge: Add dual_link field to the drm_bridge_timings struct=
ure
> >       dt-bindings: display: bridge: thc63lvd1024: Document dual-link op=
eration
> >       drm: bridge: thc63: Report input bus mode through bridge timings
> >       dt-bindings: display: renesas: lvds: Add renesas,companion proper=
ty
> >       drm: rcar-du: lvds: Remove LVDS double-enable checks
> >       drm: rcar-du: lvds: Add support for dual-link mode
> >       drm: rcar-du: Skip LVDS1 output on Gen3 when using dual-link LVDS=
 mode
> >       drm: rcar-du: Add support for missing 32-bit RGB formats
> >       drm: rcar-du: Add support for missing 16-bit RGB4444 formats
> >       drm: rcar-du: Add support for missing 16-bit RGB1555 formats
> >       drm: Add drm_atomic_get_(old|new)_connector_for_encoder() helpers
> >
> > Le.Ma (3):
> >       drm/amdgpu: add structures for buffer allocate/release for rlc au=
toload
> >       drm/amdgpu: add fw load type flag for rlc autoload
> >       drm/amdgpu: enable virtual display feature for navi10
> >
> > Leo (Hanghong) Ma (2):
> >       drm/amd/display: Expose send immediate sdp message interface
> >       drm/amd/display: Expose send immediate sdp message interface
> >
> > Leo Li (5):
> >       drm/amdgpu: Split gpu_info_soc_bounding_box out from amdgpu_ucode=
.h
> >       drm/amd/display: Disconnect DCN2 mpcc when changing tg
> >       drm/amd/display: Clean up locking in dcn*_apply_ctx_for_surface()
> >       drm/amd/display: Guard DML_FAIL_DSC_VALIDATION_FAILURE
> >       drm/amd/display: Properly guard display_mode_vba with DCN2
> >
> > Leo Liu (23):
> >       drm/amdgpu: add no_user_fence flag to ring funcs
> >       drm/amdgpu/UVD: set no_user_fence flag to true
> >       drm/amdgpu/VCE: set no_user_fence flag to true
> >       drm/amdgpu/VCN: set no_user_fence flag to true
> >       drm/amdgpu: check no_user_fence flag for engines
> >       drm/amdgpu: move the VCN DPG mode read and write to VCN
> >       drm/amdgpu: make VCN DPG pause mode detached from general VCN
> >       drm/amdgpu: add nbio callbacks for vcn doorbell support
> >       drm/amdgpu: add Navi10 VCN firmware support
> >       drm/amdgpu: add VCN2.0 decode ring test
> >       drm/amdgpu: add VCN2.0 decode ib test
> >       drm/amdgpu: add JPEG2.0 decode ring test
> >       drm/amdgpu: add JPEG2.0 decode ring ib test
> >       drm/amdgpu: add initial VCN2.0 support (v2)
> >       drm/amdgpu/VCN2.0: remove powergating for UVDW tile
> >       drm/amdgpu/VCN2.0 remove unused Macro and declaration
> >       drm/amdgpu/VCN2.0: add direct SRAM read and write
> >       drm/amdgpu/VCN2.0: add DPG mode start and stop (v2)
> >       drm/amdgpu/VCN2.0: add DPG pause mode
> >       drm/amdgpu: enable VCN2.0 DPG mode
> >       drm/amdgpu/VCN: add buffer for indirect SRAM usage
> >       drm/amdgpu/VCN: implement indirect DPG SRAM mode
> >       drm/amdgpu/VCN: enable indirect DPG SRAM mode
> >
> > Linus Walleij (4):
> >       drm/atomic-helper: Bump vblank timeout to 100 ms
> >       drm/mcde: Add new driver for ST-Ericsson MCDE
> >       drm/bridge: analogix-anx78xx: Drop of_gpio.h include
> >       drm/bridge: analogix_dp: Convert to GPIO descriptors
> >
> > Lionel Landwerlin (1):
> >       drm/i915/perf: fix whitelist on Gen10+
> >
> > Liviu Dudau (1):
> >       arm/komeda: Convert dp_wait_cond() to return an error code.
> >
> > Louis Li (1):
> >       drm/amdgpu: fix ring test failure issue during s3 in vce 3.0 (V2)
> >
> > Lowry Li (Arm Technology China) (10):
> >       drm/komeda: Creates plane alpha and blend mode properties
> >       drm/komeda: Clear enable bit in CU_INPUTx_CONTROL
> >       drm/komeda: Add rotation support on Komeda driver
> >       drm/komeda: Adds limitation check for AFBC wide block not support=
 Rot90
> >       drm/komeda: Update HW up-sampling on D71
> >       drm/komeda: Enable color-encoding (YUV format) support
> >       drm/komeda: Adds SMMU support
> >       dt/bindings: drm/komeda: Adds SMMU support for D71 devicetree
> >       drm/komeda: Adds zorder support
> >       drm/komeda: Add slave pipeline support
> >
> > Lubomir Rintel (1):
> >       drm/armada: replace the simple-framebuffer
> >
> > Lucas De Marchi (16):
> >       drm/i915/icl: fix step numbers in icl_display_core_init()
> >       drm/i915: reorder if chain to have last gen first
> >       drm/i915: do not mix workaround with normal flow
> >       drm/i915/dmc: protect against reading random memory
> >       drm/i915/icl: use ranges for voltage level lookup
> >       drm/i915/cnl: use ranges for voltage level lookup
> >       drm/i915/skl: use ranges for voltage level lookup
> >       drm/i915/dmc: use kernel types
> >       drm/i915/dmc: extract fw_info and table walk from intel_package_h=
eader
> >       drm/i915/dmc: add support for package_header with version 2
> >       drm/i915/dmc: extract function to parse css header
> >       drm/i915/dmc: extract function to parse package_header
> >       drm/i915/dmc: extract function to parse dmc_header
> >       drm/i915/dmc: add support to load dmc_header version 3
> >       drm/i915/dmc: remove redundant return in parse_csr_fw()
> >       drm/i915/dmc: protect against loading wrong firmware
> >
> > Lukasz Majewski (2):
> >       dt-bindings: display/panel: Add KOE tx14d24vm1bpa display descrip=
tion
> >       drm/panel: simple: Add KOE tx14d24vm1bpa display support (320x240=
)
> >
> > Lyude Paul (1):
> >       drm/amdgpu: Don't skip display settings in hwmgr_resume()
> >
> > Maarten Lankhorst (16):
> >       drm/atomic: Create __drm_atomic_helper_crtc_reset() for
> > subclassing crtc_state.
> >       drm/docs: Fix typo in __drm_atomic_helper_connector_reset
> >       drm/i915: Use the new __drm_atomic_helper_crtc_reset() helper.
> >       drm/mali: Convert to using __drm_atomic_helper_crtc_reset() for r=
eset.
> >       drm/rockchip: Convert to using __drm_atomic_helper_crtc_reset() f=
or reset.
> >       drm/tegra: Convert to using __drm_atomic_helper_crtc_reset() for =
reset.
> >       drm/msm: Convert to using __drm_atomic_helper_crtc_reset() for re=
set.
> >       drm/vkms: Convert to using __drm_atomic_helper_crtc_reset() for r=
eset.
> >       Merge remote-tracking branch 'drm/drm-next' into drm-misc-next
> >       Merge remote-tracking branch 'drm/drm-next' into drm-misc-next
> >       Merge remote-tracking branch 'drm/drm-next' into drm-misc-next
> >       drm/i915: Nuke atomic set/get prop plane stubs
> >       Merge remote-tracking branch 'drm/drm-next' into drm-misc-next
> >       Merge branch 'topic/remove-fbcon-notifiers' into drm-misc-next
> >       Merge remote-tracking branch 'drm/drm-next' into drm-misc-next-fi=
xes
> >       Merge tag 'topic/remove-fbcon-notifiers-2019-06-26' into
> > drm-misc-next-fixes
> >
> > Marco Felsch (4):
> >       dt-bindings: display: add EDT ET035012DM6 display description
> >       dt-bindings: Add vendor prefix for Evervision Electronics
> >       dt-bindings: Add Evervision VGG804821 panel
> >       drm/panel: simple: Add Evervision VGG804821 panel support
> >
> > Marek Ol=C5=A1=C3=A1k (5):
> >       drm/amdgpu: bump the DRM version for GDS ENOMEM fixes
> >       drm/amdgpu: fix PA_SC_FIFO_SIZE for Navi10 (v2)
> >       drm/amdgpu: fix transform feedback GDS hang on gfx10 (v2)
> >       drm/amdgpu: handle AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID on gfx10
> >       drm/amdgpu: don't invalidate caches in RELEASE_MEM, only do the w=
riteback
> >
> > Marek Vasut (2):
> >       dt-bindings: display: Add ETM0430G0DH6 bindings
> >       drm/panel: Add support for EDT ETM0430G0DH6
> >
> > Markus Elfring (2):
> >       drm/amd/display: Delete a redundant memory setting in
> > amdgpu_dm_irq_register_interrupt()
> >       drm/amd/powerplay: Delete a redundant memory setting in
> > vega20_set_default_od8_setttings()
> >
> > Martin Leung (1):
> >       drm/amd/display: removing MODULO change for dcn2
> >
> > Matt Roper (4):
> >       drm/i915/ehl: Support HBR3 on EHL combo PHY
> >       drm/i915: Add Wa_1409120013:icl,ehl
> >       drm/i915/ehl: Update MOCS table for EHL
> >       drm/i915/ehl: Introduce Mule Creek Canyon PCH
> >
> > Matthew Auld (2):
> >       drm/i915/gtt: grab wakeref in gen6_alloc_va_range
> >       drm/i915: add in-kernel blitter client
> >
> > Matthias Kaehlcke (1):
> >       dt-bindings: gpu: add #cooling-cells property to the ARM Mali
> > Midgard GPU binding
> >
> > Mauro Carvalho Chehab (2):
> >       Documentation/i915: Fix references to renamed files
> >       gpu: amdgpu: fix broken amdgpu_dma_buf.c references
> >
> > Maxime Ripard (21):
> >       drm/rockchip: Change the scl_vop_cal_scl_fac to pass drm_format_i=
nfo
> >       drm: Remove users of drm_format_num_planes
> >       drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
> >       drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
> >       drm/fourcc: Pass the format_info pointer to drm_format_plane_widt=
h/height
> >       drm: Replace instances of drm_format_info by drm_get_format_info
> >       drm: Remove users of drm_format_info_plane_cpp
> >       drm/fourcc: Fix the parameters name in the documentation
> >       dt-bindings: display: Convert Allwinner DSI to a schema
> >       drm/connector: Add documentation for drm_cmdline_mode
> >       drm/client: Restrict the plane_state scope
> >       drm/client: Restrict the rotation check to the rotation itself
> >       drm/client: Change drm_client_panel_rotation name
> >       drm/modes: Rewrite the command line parser
> >       drm/modes: Support modes names on the command line
> >       drm/modes: Allow to specify rotation and reflection on the comman=
dline
> >       drm/connector: Introduce a TV margins structure
> >       drm/modes: Parse overscan properties
> >       drm/atomic: Add a function to reset connector TV properties
> >       drm/selftests: Add command line parser selftests
> >       drm/vc4: hdmi: Set default state margin at reset
> >
> > Michal Wajdeczko (23):
> >       drm/i915/selftests: Move some reset testcases to separate file
> >       drm/i915/selftests: Split igt_atomic_reset testcase
> >       drm/i915/selftests: Use prepare/finish during atomic reset test
> >       drm/i915/guc: Rename intel_guc_is_alive to intel_guc_is_loaded
> >       drm/i915/uc: Explicitly sanitize GuC/HuC on failure and finish
> >       drm/i915/uc: Use GuC firmware status helper
> >       drm/i915/uc: Skip GuC HW unwinding if GuC is already dead
> >       drm/i915/uc: Stop talking with GuC when resetting
> >       drm/i915/uc: Skip reset preparation if GuC is already dead
> >       drm/i915/guc: Change platform default GuC mode
> >       drm/i915/guc: Don't allow GuC submission
> >       drm/i915/guc: Updates for GuC 32.0.3 firmware
> >       drm/i915/guc: Reset GuC ADS during sanitize
> >       drm/i915/guc: Always ask GuC to update power domain states
> >       drm/i915/guc: Define GuC firmware version for Geminilake
> >       drm/i915/huc: Define HuC firmware version for Geminilake
> >       drm/i915/guc: New GuC interrupt register for Gen11
> >       drm/i915/guc: New GuC scratch registers for Gen11
> >       drm/i915/huc: New HuC status register for Gen11
> >       drm/i915/guc: Update GuC CTB response definition
> >       drm/i915/guc: Enable GuC CTB communication on Gen11
> >       drm/i915/guc: Define GuC firmware version for Icelake
> >       drm/i915/huc: Define HuC firmware version for Icelake
> >
> > Mika Kuoppala (5):
> >       drm/i915/gtt: No need to zero the table for page dirs
> >       drm/i915/gtt: Use a common type for page directories
> >       drm/i915/gtt: Introduce init_pd_with_page
> >       drm/i915/gtt: Introduce init_pd
> >       drm/i915/gtt: Generalize alloc_pd
> >
> > Monk Liu (2):
> >       drm/amdgpu: suppress repeating tmo report
> >       drm/amdgpu: drop the incorrect soft_reset for SRIOV
> >
> > Nathan Chancellor (5):
> >       drm/msm/dsi: Add parentheses to quirks check in
> > dsi_phy_hw_v3_0_lane_settings
> >       drm/amdgpu/mes10.1: Fix header guard
> >       drm/amd/powerplay: Use memset to initialize metrics structs
> >       drm/amd/powerplay: Zero initialize freq in smu_v11_0_get_current_=
clk_freq
> >       drm/amd/powerplay: Zero initialize current_rpm in
> > vega20_get_fan_speed_percent
> >
> > Nathan Huckleberry (1):
> >       drm/msm/dpu: Fix Wunused-const-variable
> >
> > Neil Armstrong (2):
> >       drm/meson: Add zpos immutable property to planes
> >       drm/meson: Add support for XBGR8888 & ABGR8888 formats
> >
> > Nicholas Kazlauskas (23):
> >       drm/amd/display: Fill prescale_params->scale for RGB565
> >       drm/amd/display: Disable cursor when offscreen in negative direct=
ion
> >       drm/amd/display: Hook up CRC capture support for dce120
> >       drm/amd/display: Explicitly specify update type per plane info ch=
ange
> >       drm/amd/display: Switch the custom "max bpc" property to the DRM =
prop
> >       drm/amd/display: Use new connector state when getting color depth
> >       drm/amd/display: Reset planes for color management changes
> >       drm/amd/display: Expose HDR output metadata for supported connect=
ors
> >       drm/amd/display: Only force modesets when toggling HDR
> >       drm/amd/display: Don't set mode_changed=3Dfalse if the stream was=
 removed
> >       drm/amd/display: Add back missing hw translate init for DCN1_01
> >       drm/amd/display: Add connector debugfs for "output_bpc"
> >       drm/amd/display: Always allocate initial connector state state
> >       drm/amd/display: Use current connector state if NULL when checkin=
g bpc
> >       drm/amd/display: Enable fast plane updates when
> > state->allow_modeset =3D true
> >       drm/amdgpu: Add module parameter for specifying default ABM level
> >       drm/amd/display: Set default ABM level to module parameter
> >       drm/amd/display: Copy stream updates onto streams
> >       drm/amd/display: Rework CRTC color management
> >       Revert "drm/amd/display: Enable fast plane updates when
> > state->allow_modeset =3D true"
> >       drm/amd/display: Copy stream updates onto streams
> >       drm/amd/display: Rework CRTC color management
> >       drm/amd/display: update infoframe after dig fe is turned on (v2)
> >
> > Nicholas Mc Guire (1):
> >       drm/msm: check for equals 0 only
> >
> > Nikola Cornij (13):
> >       drm/amd/display: Calculate link bandwidth in a common function
> >       drm/amd/display: Remove additional FEC link bandwidth reduction
> >       drm/amd/display: Use 1/8th DSC target bitrate precision for
> > N4:2:2 and 4:2:0 formats
> >       drm/amd/display: Make sure DSC slice height is divisible by 2
> > for 4:2:0 color format
> >       drm/amd/display: Mark DSC resource as unused after copying to
> > the secondary ODM pipe
> >       drm/amd/display: Acquire DSC HW resource only if required by stre=
am
> >       drm/amd/display: Consider DSC target bpp precision when
> > calculating DSC target bpp
> >       drm/amd/display: Make sure line size is not zero in DCN2 line
> > buffer size calculations
> >       drm/amd/display: Add 170Mpix/sec DSC throughput support
> >       drm/amd/display: Do a reg update instead of set when writing ODM
> > color format
> >       drm/amd/display: Add support for extended DSC DPCD caps
> >       drm/amd/display: Disable DSC power gating in Diags
> >       drm/amd/display: Enable DSC power-gating for DSC streams
> >
> > Noralf Tr=C3=B8nnes (12):
> >       drm/fb-helper: Avoid race with DRM userspace
> >       drm/fb-helper: No need to cache rotation and sw_rotations
> >       drm/fb-helper: Remove drm_fb_helper_crtc->{x, y, desired_mode}
> >       drm/fb-helper: Fix drm_fb_helper_hotplug_event() NULL ptr argumen=
t
> >       drm/fb-helper: Remove drm_fb_helper_crtc
> >       drm/atomic: Move __drm_atomic_helper_disable_plane/set_config()
> >       drm/fb-helper: Prepare to move out commit code
> >       drm/fb-helper: Move out commit code
> >       drm/fb-helper: Remove drm_fb_helper_connector
> >       drm/fb-helper: Prepare to move out modeset config code
> >       drm/fb-helper: Move out modeset config code
> >       drm/todo: Add bootsplash entry
> >
> > Oak Zeng (43):
> >       drm/amdgpu: Remap hdp coherency registers
> >       drm/amdkfd: Expose HDP registers to user space
> >       drm/amdkfd: Use 64 bit sdma_bitmap
> >       drm/amdkfd: Add sdma allocation debug message
> >       drm/amdkfd: Differentiate b/t sdma_id and sdma_queue_id
> >       drm/amdkfd: Shift sdma_engine_id and sdma_queue_id in mqd
> >       drm/amdkfd: Introduce asic-specific mqd_manager_init function
> >       drm/amdkfd: Introduce DIQ type mqd manager
> >       drm/amdkfd: Init mqd managers in device queue manager init
> >       drm/amdkfd: Add mqd size in mqd manager struct
> >       drm/amdkfd: Allocate MQD trunk for HIQ and SDMA
> >       drm/amdkfd: Fix a potential memory leak
> >       drm/amdkfd: Move non-sdma mqd allocation out of init_mqd
> >       drm/amdkfd: Allocate hiq and sdma mqd from mqd trunk
> >       drm/amdkfd: Fix sdma queue map issue
> >       drm/amdkfd: Introduce XGMI SDMA queue type
> >       drm/amdkfd: Expose sdma engine numbers to topology
> >       drm/amdkfd: Delete alloc_format field from map_queue struct
> >       drm/amdkfd: Use kfd fd to mmap mmio
> >       drm/amdkfd: Add gws number to kfd topology node properties
> >       drm/amdgpu: Add interface to alloc gws from amdgpu
> >       drm/amdkfd: Allocate gws on device initialization
> >       drm/amdgpu: Add function to add/remove gws to kfd process
> >       drm/amdkfd: Add function to set queue gws
> >       drm/amdkfd: New IOCTL to allocate queue GWS
> >       drm/amdkfd: PM4 packets change to support GWS
> >       drm/amdkfd: Return proper error code for gws alloc API
> >       drm/amdkfd: CP queue priority controls
> >       drm/amdkfd: Only initialize sdma vm for sdma queues
> >       drm/amdkfd: Only load sdma mqd when queue is active
> >       drm/amdkfd: Refactor create_queue_nocpsch
> >       drm/amdkfd: Separate mqd allocation and initialization
> >       drm/amdkfd: Fix a circular lock dependency
> >       drm/amdkfd: Fix sdma queue allocate race condition
> >       drm/amdkfd: Initialize HSA_CAP_ATS_PRESENT capability in topology=
 codes
> >       drm/amdkfd: Add device to topology after it is completely inited
> >       drm/amdgpu: Reserve space for shared fence
> >       Revert "drm/amdkfd: Fix sdma queue allocate race condition"
> >       Revert "drm/amdkfd: Fix a circular lock dependency"
> >       drm/amdkfd: Fix a circular lock dependency
> >       drm/amdkfd: Fix sdma queue allocate race condition
> >       drm/amdkfd: Set gws_mask to 64 bit 1s
> >       drm/amdgpu: Set queue_preemption_timeout_ms default value
> >
> > Oleg Vasilev (3):
> >       drm/i915: add i2c symlink under hdmi connector
> >       drm: add debug print to update_vblank_count
> >       drm/vkms: add crc sources list
> >
> > Ori Messinger (1):
> >       drm/amdgpu: Report firmware versions with sysfs v2
> >
> > Oscar Mateo (2):
> >       drm/i915/guc: Create vfuncs for the GuC interrupts control functi=
ons
> >       drm/i915/guc: Correctly handle GuC interrupts on Gen11
> >
> > Paul Cercueil (2):
> >       dt-bindings: Add doc for the Ingenic JZ47xx LCD controller driver
> >       DRM: Add KMS driver for the Ingenic JZ47xx SoCs
> >
> > Paul Hsieh (3):
> >       drm/amd/display: Disable ABM before destroy ABM struct
> >       drm/amd/display: disable PSR/ABM before destroy DMCU struct
> >       drm/amd/display: disable PSR/ABM before destroy DMCU struct
> >
> > Paul Kocialkowski (5):
> >       drm/sun4i: Use DRM_GEM_CMA_VMAP_DRIVER_OPS for GEM operations
> >       drm/vc4: Reformat and the binner bo allocation helper
> >       drm/vc4: Check for V3D before binner bo alloc
> >       drm/vc4: Check for the binner bo before handling OOM interrupt
> >       drm/vc4: Allocate binner bo when starting to use the V3D
> >
> > Pawe=C5=82 Chmiel (1):
> >       drm/panel: Add driver for Samsung S6E63M0 panel
> >
> > Peter Griffin (1):
> >       drm/lima: handle shared irq case for lima_pp_bcast_irq_handler
> >
> > Peter Ujfalusi (5):
> >       dt-bindings: display: Add bindings for OSD101T2045-53TS
> >       drm/panel: simple: Add support for OSD101T2045-53TS
> >       dt-bindings: display: Add bindings for OSD101T2587-53TS panel
> >       drm/panel: Add OSD101T2587-53TS driver
> >       drm/panel: simple: Fix panel_simple_dsi_probe
> >
> > Philip Cox (1):
> >       drm/amdkfd: Add navi10 support to amdkfd. (v3)
> >
> > Philip Yang (11):
> >       drm: increase drm mmap_range size to 1TB
> >       drm/amdgpu: use HMM callback to replace mmu notifier
> >       drm/amdkfd: avoid HMM change cause circular lock
> >       drm/amdgpu: replace get_user_pages with HMM mirror helpers
> >       drm/amdgpu: fix HMM config dependency issue
> >       drm/amdkfd: support concurrent userptr update for HMM
> >       drm/amdgpu: support userptr cross VMAs case with HMM
> >       drm/amdgpu: more descriptive message if HMM not enabled
> >       drm/amdgpu: use new HMM APIs and helpers
> >       drm/amdgpu: improve HMM error -ENOMEM and -EBUSY handling
> >       drm/amdgpu: Prepare for hmm_range_register API change (v2)
> >
> > Philipp Zabel (1):
> >       drm/imx: enable IDMAC watermark feature
> >
> > Philippe Cornu (1):
> >       drm/stm: ltdc: use DRM_WARN for fifo & transfer error messages
> >
> > Prike Liang (3):
> >       drm/amd/amdgpu: add RLC firmware to support raven1 refresh
> >       drm/amd/powerplay: detect version of smu backend (v2)
> >       drm/amd/powerplay:clean up the residual mutex for smu_hw_init
> >
> > Radhakrishna Sripada (1):
> >       drm/i915/icl: Fix clockgating issue when using scalers
> >
> > Ramalingam C (7):
> >       drm: move content protection property to mode_config
> >       drm/i915: debugfs: HDCP2.2 capability read
> >       drm: generic fn converting be24 to cpu and vice versa
> >       drm: revocation check at drm subsystem
> >       drm/i915: SRM revocation check for HDCP1.4 and 2.2
> >       drm/hdcp: gathering hdcp related code into drm_hdcp.c
> >       drm/hdcp: drm_hdcp_request_srm() as static
> >
> > Rex Zhu (4):
> >       drm/amdgpu: Add struct kiq_pm4_funcs into kiq struct
> >       drm/amdgpu: Add common gfx func Disable kcq via kiq
> >       drm/amdgpu: Add helper function amdgpu_ring_set_preempt_cond_exec
> >       drm/amdgpu: Add new ring interface preempt_ib
> >
> > Rob Clark (1):
> >       drm/msm/a3xx: remove TPL1 regs from snapshot
> >
> > Rob Herring (1):
> >       drm/panfrost: Align GEM objects GPU VA to 2MB
> >
> > Robert Foss (1):
> >       drm/virtio: Remove redundant return type
> >
> > Robert M. Fosha (1):
> >       drm/i915: Update workarounds selftest for read only regs
> >
> > Rodrigo Siqueira (1):
> >       drm/vkms: Remove useless call to drm_connector_register/unregiste=
r()
> >
> > Roman Li (2):
> >       drm/amd/display: Fill plane attrs only for valid pxl format
> >       drm/amd/display: Fix null-deref on vega20 with xgmi
> >
> > Russell King (30):
> >       drm/armada: fix crtc interlace
> >       drm/armada: use __drm_atomic_helper_plane_reset in overlay reset
> >       drm/armada: add plane size/location accessors
> >       drm/armada: fix plane location and size for interlace
> >       drm/armada: add missing interlaced support for overlay frame
> >       drm/armada: move plane address and pitch calculation to atomic_ch=
eck
> >       drm/armada: add support for setting gamma
> >       drm/armada: add comments about HWC32 cursor colour format
> >       drm/armada: add drm_mode_set_crtcinfo() mode fixup
> >       drm/armada: add and use definitions for RDREG4F
> >       drm/armada: add drm_atomic_helper_shutdown() call in tear-down
> >       drm/armada: add CRTC mode validation
> >       drm/i2c: tda998x: introduce tda998x_audio_settings
> >       drm/i2c: tda998x: implement different I2S flavours
> >       drm/i2c: tda998x: improve programming of audio divisor
> >       drm/i2c: tda998x: derive CTS_N value from aclk sample rate ratio
> >       drm/i2c: tda998x: store audio port enable in settings
> >       drm/i2c: tda998x: index audio port enable config by route type
> >       drm/i2c: tda998x: configure both fields of AIP_CLKSEL together
> >       drm/i2c: tda998x: move audio routing configuration
> >       drm/i2c: tda998x: clean up tda998x_configure_audio()
> >       drm/i2c: tda998x: get rid of params in audio settings
> >       drm/i2c: tda998x: add support for pixel repeated modes
> >       drm/i2c: tda998x: improve correctness of quantisation range
> >       drm/i2c: tda998x: add vendor specific infoframe support
> >       drm/armada: improve Dove clock selection
> >       drm/armada: use mode_valid to validate the adjusted mode
> >       drm/armada: redo CRTC debugfs files
> >       drm/armada: use for_each_endpoint_of_node() to walk crtc endpoint=
s
> >       drm/armada: no need to check parent of remote
> >
> > Sabyasachi Gupta (1):
> >       drm/bridge: Remove duplicate header
> >
> > Sam Bobroff (1):
> >       drm/bochs: Fix connector leak during driver unload
> >
> > Sam Ravnborg (43):
> >       drm: drop drm_bus from todo
> >       drm/gma500: remove empty gma_drm.h header file
> >       drm/gma500: drop drmP.h from header files
> >       drm/gma500: make local header files more self-contained
> >       drm/gma500: drop use of DRM_UDELAY wrapper
> >       drm/gma500: drop drmp.h include from all .c files
> >       drm/bridge: make dw_mipi_dsi.h self-contained
> >       drm/bridge: drop drmP.h usage
> >       drm/mcde: Fix compile problems
> >       drm: make drm/drm_auth.h self contained
> >       drm: make drm/drm_legacy.h self-contained
> >       drm: make drm_crtc_internal.h self-contained
> >       drm: make drm_internal.h self-contained
> >       drm: make drm_legacy.h self-contained
> >       drm: make drm_trace.h self-contained
> >       drm: drop use of drmP.h in drm/*
> >       drm/panel: panel-innolux: drop unused variable
> >       drm/panel: drop drmP.h usage
> >       drm/sis: drop drmP.h use
> >       drm/savage: drop use of drm_os_linux
> >       drm/savage: drop use of drmP.h
> >       drm/r128: drop drm_os_linux dependencies
> >       drm/r128: drop use of drmP.h
> >       drm/sti: drop use of drmP.h
> >       drm: drm_crtc.h self-contained
> >       drm: drm_debugfs.h self-contained
> >       drm/radeon: drop dependency on drm_os_linux.h
> >       drm/radeon: drop drmP.h from header files
> >       drm/radeon: prepare header files for drmP.h removal
> >       drm/radeon: drop use of drmP.h (1/2)
> >       drm/radeon: drop use of drmP.h (2/2)
> >       drm: fix build errors with drm_print.h
> >       drm/amd: drop dependencies on drm_os_linux.h
> >       drm/amd: drop use of drmp.h in os_types.h
> >       drm/amd: drop use of drmP.h in amdgpu.h
> >       drm/amd: drop use of drmP.h in atom.h
> >       drm/amd: drop use of drmP.h from all header files
> >       drm/amd: drop use of drmP.h in powerplay/
> >       drm/amd: drop use of drmP.h in display/
> >       drm/amd: drop use of drmP.h in amdgpu/amdgpu*
> >       drm/amd: drop use of drmP.h in remaining files
> >       drm/exynos: drop drmP.h usage
> >       drm/exynos: trigger build of all modules
> >
> > Samson Tam (3):
> >       drm/amd/display: block passive dongle EDID Emulation for USB-C po=
rts
> >       drm/amd/display: set link->dongle_max_pix_clk to 0 on a disconnec=
t
> >       drm/amd/display: block passive dongle EDID Emulation for USB-C po=
rts
> >
> > Sandeep Sheriker Mallikarjun (2):
> >       drm: atmel-hlcdc: enable sys_clk during initalization.
> >       drm: atmel-hlcdc: add sam9x60 LCD controller
> >
> > Sandor Yu (1):
> >       drm/rockchip: cdn-dp: correct rate in the struct drm_dp_link assi=
gnment
> >
> > Sean Paul (36):
> >       Merge drm/drm-next into drm-misc-next
> >       drm/mediatek: Fix warning about unhandled enum value
> >       drm/edid: Fix docbook in drm_hdmi_infoframe_set_hdr_metadata()
> >       drm/msm/a6xx: Avoid freeing gmu resources multiple times
> >       drm/msm/a6xx: Remove duplicate irq disable from remove
> >       drm/msm/a6xx: Check for ERR or NULL before iounmap
> >       drm/msm/a6xx: Remove devm calls from gmu driver
> >       drm/msm/a6xx: Drop the device reference in gmu
> >       drm/msm/a6xx: Rename a6xx_gmu_probe to a6xx_gmu_init
> >       drm: Tweak drm_encoder_helper_funcs.enable kerneldoc
> >       drm: Add atomic variants of enable/disable to encoder helper func=
s
> >       drm: Add atomic variants for bridge enable/disable
> >       drm: Convert connector_helper_funcs->atomic_check to accept
> > drm_atomic_state
> >       drm: Add helpers to kick off self refresh mode in drivers
> >       drm/rockchip: Use dirtyfb helper
> >       drm/connector: Fix kerneldoc warning in HDR_OUTPUT_METADATA descr=
iption
> >       drm/amdgpu: Fix connector atomic_check compilation fail
> >       drm/rcar-du: Fix error check when retrieving crtc state
> >       drm/msm/dpu: Use provided drm_minor to initialize debugfs
> >       drm/msm/dpu: Remove _dpu_debugfs_init
> >       drm/msm/dpu: Remove bogus comment
> >       drm/self_refresh: Fix possible NULL deref in failure path
> >       drm/msm/dpu: Remove call to drm_mode_set_crtcinfo
> >       drm/msm/dpu: Avoid calling _dpu_kms_mmu_destroy() on init failure
> >       drm/msm/phy/dsi_phy: Set pll to NULL in case initialization fails
> >       drm/msm/dsi_pll_10nm: Release clk hw on destroy and failure
> >       drm/msm/dsi_pll_10nm: Remove impossible check
> >       drm/msm: Depopulate platform on probe failure
> >       drm/msm/dsi: Split mode_flags out of msm_dsi_host_get_panel()
> >       drm/msm/dsi: Don't store dsi host mode_flags in msm_dsi
> >       drm/msm/dsi: Pull out panel init code into function
> >       drm/msm/dsi: Simplify the logic in msm_dsi_manager_panel_init()
> >       drm/msm/dsi: Use the new setup_encoder function in attach_dsi_dev=
ice
> >       drm/msm/dsi: Move dsi panel init into modeset init path
> >       drm/msm/dsi: Move setup_encoder to modeset_init
> >       drm/msm: Re-order uninit function to work during probe defer
> >
> > Sebastian Reichel (4):
> >       drm/omap: use DRM_DEBUG_DRIVER instead of CORE
> >       drm/omap: don't check dispc timings for DSI
> >       drm/omap: add framedone interrupt support
> >       drm/omap: add support for manually updated displays
> >
> > Serge Semin (1):
> >       drm: Permit video-buffers writecombine mapping for MIPS
> >
> > Shashank Sharma (3):
> >       drm/i915: Change gamma/degamma_lut_size data type to u32
> >       drm/i915: Rename ivb_load_lut_10_max
> >       drm/i915/icl: Add Multi-segmented gamma support
> >
> > Shirish S (1):
> >       drm/amdgpu/{uvd,vcn}: fetch ring's read_ptr after alloc
> >
> > SivapiriyanKumarasamy (2):
> >       drm/amd/display: Remove DPMS state dependency for fast boot
> >       drm/amd/display: S3 Resume time increase after decoupling DPMS
> > from fast boot
> >
> > Slava Abramov (1):
> >       drm/amdgpu: use div64_ul for 32-bit compatibility v1
> >
> > Souptick Joarder (1):
> >       drm/panel: Remove duplicate header
> >
> > Stanislav Lisovskiy (1):
> >       drm/i915: Corrupt DSI picture fix for GeminiLake
> >
> > Stephen Rothwell (1):
> >       dt-bindings: fix up for vendor prefixes file conversion
> >
> > Steve Longerbeam (6):
> >       gpu: ipu-v3: ipu-ic: Fix saturation bit offset in TPMEM
> >       gpu: ipu-v3: ipu-ic: Fully describe colorspace conversions
> >       gpu: ipu-v3: ipu-ic-csc: Add support for limited range encoding
> >       gpu: ipu-v3: ipu-ic-csc: Add support for Rec.709 encoding
> >       media: imx: Try colorimetry at both sink and source pads
> >       gpu: ipu-v3: image-convert: Enable double write reduction
> >
> > Stuart Summers (5):
> >       drm/i915: Use local variable for SSEU info in GETPARAM ioctl
> >       drm/i915: Add macro for SSEU stride calculation
> >       drm/i915: Move calculation of subslices per slice to new function
> >       drm/i915: Refactor sseu helper functions
> >       drm/i915: Expand subslice mask
> >
> > Su Sung Chung (4):
> >       drm/amd/display: fix calculation of total_data_read_bandwidth
> >       drm/amd/display: fix crash on setmode when mode is close to bw li=
mit
> >       drm/amd/display: make clk_mgr call enable_pme_wa
> >       drm/amd/display: make clk_mgr call enable_pme_wa
> >
> > Swati Sharma (2):
> >       drm/i915: Introduce vfunc read_luts() to create hw lut
> >       drm/i915: Enable intel_color_get_config()
> >
> > S=C3=A9bastien Szymanski (1):
> >       drm/panel: Add support for Armadeus ST0700 Adapt
> >
> > Tao Zhou (5):
> >       drm/amdgpu: Add psp 11.0 support for navi10.
> >       drm/amd/powerplay/smu11: enable ds socclk by default
> >       drm/amd/powerplay/smu11: add secure board check function (v2)
> >       drm/amd/powerplay/smu11: disable some pp features on navi10 A0
> > secure board
> >       drm/amdgpu: correct reference clock value on navi10
> >
> > Tao.Huang (1):
> >       drm/amd/display: fix resource saving missing when power state swi=
tch
> >
> > Thierry Reding (6):
> >       MAINTAINERS: Add Sam as reviewer for drm/panel
> >       gpu: host1x: Do not output error message for deferred probe
> >       gpu: host1x: Increase maximum DMA segment size
> >       gpu: host1x: Do not link logical devices to DT nodes
> >       drm/tegra: Use GPIO descriptor API
> >       drm/tegra: dpaux: Make VDD supply optional
> >
> > Thomas Hellstrom (11):
> >       drm/vmwgfx: Assign eviction priorities to resources
> >       mm: Allow the [page|pfn]_mkwrite callbacks to drop the mmap_sem
> >       mm: Add an apply_to_pfn_range interface
> >       mm: Add write-protect and clean utilities for address space range=
s
> >       drm/ttm: Allow the driver to provide the ttm struct vm_operations=
_struct
> >       drm/ttm: TTM fault handler helpers
> >       drm/vmwgfx: Implement an infrastructure for write-coherent resour=
ces
> >       drm/vmwgfx: Use an RBtree instead of linked list for MOB resource=
s
> >       drm/vmwgfx: Implement an infrastructure for read-coherent resourc=
es
> >       drm/vmwgfx: Add surface dirty-tracking callbacks
> >       drm/vmwgfx: Kill unneeded legacy security features
> >
> > Thomas Lim (3):
> >       drm/amd/display: Add Underflow Asserts to dc
> >       drm/amd/display: Add power down display on boot flag
> >       drm/amd/display: Add Underflow Asserts to dc
> >
> > Thomas Meyer (1):
> >       drm/omap: Make sure device_id tables are NULL terminated
> >
> > Thomas Zimmermann (36):
> >       drm: Add |struct drm_gem_vram_object| and helpers
> >       drm: Add |struct drm_gem_vram_object| callbacks for |struct ttm_b=
o_driver|
> >       drm: Add |struct drm_gem_vram_object| callbacks for |struct drm_d=
river|
> >       drm: Add drm_gem_vram_fill_create_dumb() to create dumb buffers
> >       drm: Add simple PRIME helpers for GEM VRAM
> >       drm: Add VRAM MM, a simple memory manager for dedicated VRAM
> >       drm: Add default instance for VRAM MM callback functions
> >       drm: Integrate VRAM MM into struct drm_device
> >       drm/ast: Convert AST driver to |struct drm_gem_vram_object|
> >       drm/ast: Convert AST driver to VRAM MM
> >       drm/ast: Replace mapping code with drm_gem_vram_{kmap/kunmap}()
> >       drm/bochs: Convert bochs driver to |struct drm_gem_vram_object|
> >       drm/bochs: Convert bochs driver to VRAM MM
> >       drm/mgag200: Convert mgag200 driver to |struct drm_gem_vram_objec=
t|
> >       drm/mgag200: Convert mgag200 driver to VRAM MM
> >       drm/mgag200: Replace mapping code with drm_gem_vram_{kmap/kunmap}=
()
> >       drm/vboxvideo: Convert vboxvideo driver to |struct drm_gem_vram_o=
bject|
> >       drm/vboxvideo: Convert vboxvideo driver to VRAM MM
> >       drm/hisilicon: Convert hibmc-drm driver to |struct drm_gem_vram_o=
bject|
> >       drm/hisilicon: Convert hibmc-drm driver to VRAM MM
> >       drm: Add drm_gem_vram_{pin/unpin}_reserved() and convert mgag200
> >       drm: Reserve/unreserve GEM VRAM BOs from within pin/unpin functio=
ns
> >       drm: Replace drm_gem_vram_push_to_system() with kunmap + unpin
> >       drm: Rename reserve/unreserve to lock/unlock in GEM VRAM helpers
> >       drm: Assert that BO is locked in drm_gem_vram_{pin, unpin}_locked=
()
> >       drm: Ignore drm_gem_vram_mm_funcs in generated documentation
> >       drm: Reverse lock order in pan_display_legacy()
> >       drm/gem-vram: Support pinning buffers to current location
> >       drm/ast: Unpin cursor BO during cleanup
> >       drm/ast: Remove obsolete or unused cursor state
> >       drm/ast: Pin and map cursor source BO during update
> >       drm/ast: Pin framebuffer BO during dirty update
> >       drm/mgag200: Pin framebuffer BO during dirty update
> >       drm/mgag200: Rewrite cursor handling
> >       drm: Remove lock interfaces from GEM VRAM helpers
> >       drm: Remove functions with kmap-object argument from GEM VRAM hel=
pers
> >
> > Tianci Yin (2):
> >       drm/amdgpu/gfx10: update gfx golden settings
> >       drm/amdgpu: disable some gfx light sleep
> >
> > Tiecheng Zhou (1):
> >       drm/amdgpu/sriov: Need to initialize the HDP_NONSURFACE_BAStE
> >
> > Tom St Denis (6):
> >       drm/amd/amdgpu: Add MEM_LOAD to amdgpu_pm_info debugfs file
> >       drm/amd/doc: Add XGMI sysfs documentation
> >       drm/amd/doc: Add RAS documentation to guide
> >       drm/amd/amdgpu: remove vram_page_split kernel option (v3)
> >       drm/amd/amdgpu: Bail out of BO node creation if not enough VRAM (=
v3)
> >       drm/amd/amdgpu: cast mem->num_pages to 64-bits when shifting (v2)
> >
> > Tomi Valkeinen (27):
> >       drm/bridge: tc358767: fix tc_aux_get_status error handling
> >       drm/bridge: tc358767: reset voltage-swing & pre-emphasis
> >       drm/bridge: tc358767: fix ansi 8b10b use
> >       drm/bridge: tc358767: cleanup spread & scrambler_dis
> >       drm/bridge: tc358767: remove unused swing & preemp
> >       drm/bridge: tc358767: cleanup aux_link_setup
> >       drm/bridge: tc358767: move video stream setup to tc_main_link_str=
eam
> >       drm/bridge: tc358767: split stream enable/disable
> >       drm/bridge: tc358767: move PXL PLL enable/disable to stream enabl=
e/disable
> >       drm/bridge: tc358767: add link disable function
> >       drm/bridge: tc358767: disable only video stream in tc_stream_disa=
ble
> >       drm/bridge: tc358767: ensure DP is disabled before LT
> >       drm/bridge: tc358767: remove unnecessary msleep
> >       drm/bridge: tc358767: use more reliable seq when finishing LT
> >       drm/bridge: tc358767: cleanup LT result check
> >       drm/bridge: tc358767: clean-up link training
> >       drm/bridge: tc358767: remove check for video mode in link enable
> >       drm/bridge: tc358767: use bridge mode_valid
> >       drm/bridge: tc358767: remove tc_connector_best_encoder
> >       drm/bridge: tc358767: copy the mode data, instead of storing the =
pointer
> >       drm/bridge: tc358767: read display_props in get_modes()
> >       drm/bridge: tc358767: add GPIO & interrupt registers
> >       drm/bridge: tc358767: add IRQ and HPD support
> >       dt-bindings: tc358767: add HPD support
> >       drm/bridge: sii902x: add input_bus_flags
> >       drm/bridge: tfp410: fix memleak in get_modes()
> >       drm/bridge: tfp410: fix use of cancel_delayed_work_sync
> >
> > Tony Cheng (1):
> >       drm/amd/display: move dsc clock from plane_resource to stream_res=
ource
> >
> > Trigger Huang (11):
> >       drm/amdgpu: init vega10 SR-IOV reg access mode
> >       drm/amdgpu: initialize PSP before IH under SR-IOV
> >       drm/amdgpu: Add new PSP cmd GFX_CMD_ID_PROG_REG
> >       drm/amdgpu: implement PSP cmd GFX_CMD_ID_PROG_REG
> >       drm/amdgpu: call psp to program ih cntl in SR-IOV
> >       drm/amdgpu: Support PSP VMR ring for Vega10 VF
> >       drm/amdgpu: Skip setting some regs under Vega10 VF
> >       drm/amdgpu: add basic func for RLC program reg
> >       drm/amdgpu: RLC to program regs for Vega10 SR-IOV
> >       drm/amdgpu: Hardcode reg access using L1 security
> >       drm/amdgpu: fix pm_load_smu_firmware for SR-IOV
> >
> > Tvrtko Ursulin (27):
> >       drm/i915/icl: Whitelist GEN9_SLICE_COMMON_ECO_CHICKEN1
> >       drm/i915/selftests: Verify context workarounds
> >       drm/i915/icl: Add WaDisableBankHangMode
> >       drm/i915: Engine discovery query
> >       drm/i915: Reset only affected engines when handling error capture
> >       drm/i915: Tidy engine mask types in hangcheck
> >       drm/i915: Make Gen6/7 RING_FAULT_REG access engine centric
> >       drm/i915: Extract engine fault reset to a helper
> >       drm/i915: Unexport i915_gem_init/fini_aliasing_ppgtt
> >       drm/i915: Convert some more bits to use engine mmio accessors
> >       drm/i915: Tidy intel_execlists_submission_init
> >       drm/i915: Move i915_check_and_clear_faults to intel_reset.c
> >       drm/i915: Eliminate unused mmio accessors
> >       drm/i915: Convert i915_reg_read_ioctl to use explicit mmio access=
ors
> >       drm/i915: Convert icl_get_stolen_reserved to uncore mmio accessor=
s
> >       drm/i915: Convert gem_record_fences to uncore mmio accessors
> >       drm/i915: Convert intel_read_wm_latency to uncore mmio accessors
> >       drm/i915: Remove I915_READ64 and I915_READ64_32x2
> >       drm/i915: Make read_subslice_reg take engine
> >       drm/i915/guc: Move intel_guc_reserved_gtt_size to intel_wopcm_guc=
_size
> >       drm/i915: Make GuC GGTT reservation work on ggtt
> >       drm/i915: Remove I915_READ8
> >       drm/i915: Remove I915_POSTING_READ_FW
> >       drm/i915: Remove POSTING_READ16
> >       drm/i915: Remove I915_WRITE_NOTRACE
> >       drm/i915: Remove I915_READ_NOTRACE
> >       drm/i915: Remove I915_READ16 and I915_WRITE16
> >
> > Tyler DiBattista (2):
> >       drm/amd/display: Change Min fclk to 1.2Ghz
> >       drm/amd/display: move DWB structs and enums to dc_hw_types
> >
> > Uma Shankar (15):
> >       drm: Add HDR source metadata property
> >       drm: Parse HDR metadata info from EDID
> >       drm: Enable HDR infoframe support
> >       video/hdmi: Add Unpack function for DRM infoframe
> >       drm/i915: Enabled Modeset when HDR Infoframe changes
> >       drm/i915: Add DRM Infoframe handling for BYT/CHT
> >       drm/i915: Write HDR infoframe and send to panel
> >       drm/i915: Add state readout for DRM infoframe
> >       drm/i915: Attach HDR metadata property to connector
> >       drm: Drop a redundant unused variable
> >       drm: Fixed doc warnings in drm uapi header
> >       drm: ADD UAPI structure definition section in kernel doc
> >       drm: Fix docbook warnings in hdr metadata helper structures
> >       video/hdmi: Dropped static functions from kernel doc
> >       drm/i915/icl: Add register definitions for Multi Segmented gamma
> >
> > Vandita Kulkarni (4):
> >       drm/i915: Fix the pipe state timing mismatch warnings
> >       drm/i915: Refactor bdw_get_pipemisc_bpp
> >       drm/i915: Fix pipe config mismatch for bpp, output format
> >       drm/i915: Fix pixel clock and crtc clock config mismatch
> >
> > Ville Syrj=C3=A4l=C3=A4 (70):
> >       drm/i915: Fix skl+ max plane width
> >       drm/i915: Fix ICL output CSC programming
> >       drm/i915: Clean up cherryview_load_luts()
> >       drm/i915: Flatten and rename haswell_set_pipemisc()
> >       drm/i915: Enable pipe HDR mode on ICL if only HDR planes are used
> >       drm/i915: Don't skip audio enable if ELD is bogus
> >       drm/i915: hsw+ audio regs are per-transocder
> >       drm/i915: Move the PIPEMISC write the correct place
> >       drm/i915: Allow ICL pipe "HDR mode" when the cursor is visible
> >       drm/i915: Use mul_u32_u32() more
> >       drm/i915: Document that we implement WaIncreaseLatencyIPCEnabled
> >       drm/i915: Drop WaIncreaseLatencyIPCEnabled/1140 for cnl
> >       drm/i915: Move w/a 0477/WaDisableIPC:skl into intel_init_ipc()
> >       drm/i915: Replace intel_ddi_pll_init()
> >       drm/i915: Move the hsw/bdw pc8 code to intel_runtime_pm.c
> >       drm/i915: Kill PCH_KBP
> >       drm/i915: Fix fastset vs. pfit on/off on HSW EDP transcoder
> >       drm/i915: Add readout and state check for pch_pfit.force_thru
> >       drm/i915: Add a new "remapped" gtt_view
> >       drm/i915/selftests: Add mock selftest for remapped vmas
> >       drm/i915/selftests: Add live vma selftest
> >       drm/i915: Shuffle stride checking code around
> >       drm/i915: Overcome display engine stride limits via GTT remapping
> >       drm/i915: Align dumb buffer stride to 4k to allow for gtt remappi=
ng
> >       drm/i915: Bump fb stride limit to 128KiB for gen4+ and 256KiB for=
 gen7+
> >       drm/i915: Bump gen7+ fb size limits to 16kx16k
> >       drm: Add HLG EOTF
> >       drm/i915: Make sandybridge_pcode_read() deal with the second data=
 register
> >       drm/i915: Make sure we have enough memory bandwidth on ICL
> >       drm/i915: Enable infoframes on GLK+ for HDR
> >       drm/i915: Update pipe gamma enable bits when C8 planes are
> > getting enabled/disabled
> >       drm/i915: Add debugs for the C8 vs. legacy LUT case
> >       drm/i915: Pass intel_atomic_state to cdclk funcs
> >       drm/i915: Clean up cdclk vfunc assignments
> >       drm/i915: Pass intel_atomic state to check_digital_port_conflicts=
()
> >       drm/i915: Use intel_ types in intel_modeset_clear_plls()
> >       drm/i915: Use intel_ types in haswell_mode_set_planes_workaround(=
)
> >       drm/i915: Don't pass the crtc to intel_dump_pipe_config()
> >       drm/i915: Don't pass the crtc to intel_modeset_pipe_config()
> >       drm/i915: Use intel_ types in intel_modeset_checks()
> >       drm/i915: Use intel_ types in intel_atomic_check()
> >       drm/i915: Move state dump to the end of atomic_check()
> >       drm/i915: Include crtc_state.active in crtc state dumps
> >       drm/i915: Dump failed crtc states during atomic check
> >       drm/i915: Make state dumpers take a const state
> >       drm/i915: Fix plane state dumps
> >       drm/edid: Clean up DRM_EDID_DIGITAL_* flags
> >       drm/edid: Ignore "DFP 1.x" bit for EDID 1.2 and earlier
> >       drm/i915: Move intel_dp->prepare_link_train assignment into ddi c=
ode
> >       drm/i915: Drop pointless WARN_ON
> >       drm/i915: Fix per-pixel alpha with CCS
> >       drm/i915/sdvo: Fix AVI infoframe TX rate readout
> >       drm/i915/sdvo: Implement proper HDMI audio support for SDVO
> >       drm/i915: Rename SDVO_AUDIO_ENABLE to HDMI_AUDIO_ENABLE
> >       drm/i915/sdvo: Check that we have space for the infoframe
> >       drm/i915/sdvo: Don't unpack stack garbage
> >       drm/i915/sdvo: Don't write stack garbage into the hbuf
> >       drm/i915/sdvo: Actually print the reason why the SDVO command fai=
led
> >       drm/i915: Do not touch the PCH SSC reference if a PLL is using it
> >       drm/i915: Rename HSW/BDW PLL bits
> >       drm/i915: Nuke LC_FREQ
> >       drm/i915: Assert that HSW/BDW LCPLL is using the non-SSC referenc=
e
> >       drm/i915: Improve WRPLL reference clock readout on HSW/BDW
> >       drm/i915: Add missing commas to the end of the subplatform ID arr=
ays
> >       drm/i915: Kill INTEL_SUBPLATFORM_AML
> >       drm/dp: Add DP_DPCD_QUIRK_NO_SINK_COUNT
> >       drm/i915: Don't clobber M/N values during fastset check
> >       drm/i915: Constify intel_pipe_config_compare()
> >       drm/i915: Make pipe_config_err() vs. fastset less confusing
> >       drm/i915: Drop the _INCOMPLETE for has_infoframe
> >
> > Vitaly Prosyak (6):
> >       drm/amd/display: Reuse MPC OGRAM for 1D blender
> >       drm/amd/display: Add a flags union for 3dlut transformation matri=
x
> >       drm/amd/display: Add some tm3dlut flags
> >       drm/amd/display: Add 3dlut control flags
> >       drm/amd/display: add flags for gamut map library
> >       drm/amd/display: Integrate color transform3x4 with 3dlut tm
> >
> > Vivek Gautam (1):
> >       drm/panel: truly: Add additional delay after pulling down reset g=
pio
> >
> > Wang Hai (1):
> >       drm/amd/display: Make some functions static
> >
> > Weitao Hou (1):
> >       gpu: fix typos in code comments
> >
> > Wenjing Liu (11):
> >       drm/amd/display: assign new stream id in dc_copy_stream
> >       drm/amd/display: remove legacy DSC functions
> >       drm/amd/display: remove target_dpp hack for dsc
> >       drm/amd/display: isolate global double buffer lock programming
> >       drm/amd/display: add global master update lock for DCN2
> >       drm/amd/display: Implement DSC MST fair share algorithm
> >       drm/amd/display: fix a potential issue in DSC logic
> >       drm/amd/display: add dsc_passthrough_support bit in dpcd struct
> >       drm/amd/display: decouple dsc adjustment out of enablement
> >       drm/amd/display: update DSC MST DP virtual DPCD peer device
> > enumeration policy
> >       drm/amd/display: update dsc max_target_bpp to 16 bpp
> >
> > Wesley Chalmers (8):
> >       drm/amd/display: Engine-specific encoder allocation
> >       drm/amd/display: Use DCN functions instead of DCE
> >       drm/amd/display: Update link rate from DPCD 10
> >       drm/amd/display: Use macro for invalid OPP ID
> >       drm/amd/display: Use stream opp_id instead of hubp
> >       drm/amd/display: DCN2 Engine-specifc encoder allocation
> >       drm/amd/display: Use DCN2 functions instead of DCE
> >       drm/amd/display: Use macro for invalid OPP ID
> >
> > Wolfram Sang (1):
> >       gpu: drm: bridge: sii9234: simplify getting the adapter of a clie=
nt
> >
> > Xiaojie Yuan (15):
> >       drm/amdgpu/discovery: add ip discovery initial support
> >       drm/amdgpu/discovery: fix calculations of some gfx info
> >       drm/amdgpu/discovery: update definitions of table_info and binary=
_header
> >       drm/amdgpu/discovery: add harvest info data table
> >       drm/amdgpu/discovery: use hardcoded mmRCC_CONFIG_MEMSIZE
> >       drm/amdgpu/discovery: fix hwid for nbio
> >       drm/amdgpu/discovery: stop taking psp header into account
> >       drm/amdgpu/discovery: update definition for struct die_header
> >       drm/amdgpu/discovery: stop converting the units of base addresses
> >       drm/amdgpu/discovery: add module param for ip discovery enablemen=
t
> >       drm/amdgpu/discovery: refactor ip list traversal
> >       drm/amdgpu/gfx10: fix resume failure when enabling async gfx ring
> >       drm/amdgpu/gfx10: drop redundant se/sh selection
> >       drm/amdgpu/gfx10: fix unbalanced MAP/UNMAP_QUEUES when
> > async_gfx_ring is disabled
> >       drm/amd/display: use fixed-width data type for soc bounding box s=
truct
> >
> > Yannick Fertr=C3=A9 (15):
> >       drm/stm: ltdc: disable hw interrupts before its handler init
> >       drm/stm: ltdc: fix data enable polarity
> >       drm/stm: ltdc: update planes at next vblank to avoid partial refr=
esh
> >       drm/stm: ltdc: limit number of layer to avoid memory overflow
> >       drm/stm: ltdc: reset controller to avoid partial refresh
> >       drm/stm: ltdc: add modifier support
> >       dt-bindings: display: stm32: add supply property to DSI controlle=
r
> >       drm/stm: dsi: add regulator support
> >       drm/stm: ltdc: remove clk_round_rate comment
> >       drm/stm: dsi: check hardware version
> >       drm/stm: ltdc: No message if probe
> >       drm/stm: support runtime power management
> >       drm/bridge/synopsys: dsi: add power on/off optional phy ops
> >       drm/stm: dsi: add power on/off phy ops
> >       drm/stm: drv: fix suspend/resume
> >
> > Yintian Tao (1):
> >       drm/amdgpu: register pm sysfs for sriov (v2)
> >
> > Yogesh Mohan Marimuthu (1):
> >       drm/amdgpu: sort probed modes before adding common modes
> >
> > Yong Zhao (1):
> >       drm/amdkfd: Move sdma_queue_id calculation into allocate_sdma_que=
ue()
> >
> > Yongqiang Sun (6):
> >       drm/amd/display: Refactor program watermark.
> >       drm/amd/display: DCN2 reg refactors
> >       drm/amd/display: Remove REFCYC regs
> >       drm/amd/display: Remove duplicate define of TO_DCN20_HUBBUB
> >       drm/amd/display: Refactor program watermark.
> >       drm/amd/display: DCHUB requestors numbers for Navi.
> >
> > Yrjan Skrimstad (1):
> >       drm/amd/powerplay/smu7_hwmgr: replace blocking delay with non-blo=
cking
> >
> > abdoulaye berthe (1):
> >       drm/amd/display: Do not grant POST_LT_ADJ when TPS4 is used
> >
> > hersen wu (17):
> >       drm/amd/powerplay: allow dc request uclk change
> >       drm/amd/powerplay: notify smu with active display count
> >       drm/amd/powerplay: wake up azalia from d3 by sending smu message
> >       drm/amd/powerplay: add interface to get uclk dpm table
> >       drm/amd/powerplay: allow dc request uclk change
> >       drm/amd/powerplay: notify smu with active display count
> >       drm/amd/powrplay: add interface for dc to get max clock values
> >       drm/amd/powerplay: add interface to get uclk dpm table
> >       drm/amd/display: hook navi10 pplib functions
> >       drm/amd/display/dc: fix azalia workaround sw implementation bug
> >       drm/amd/display: disable dcn20 abm feature for bring up
> >       drm/amd/display: do not need otg lock if otg is not active
> >       drm/amd/display: skip dsc config for navi10 bring up
> >       drm/amd/display: navi10 bring up skip dsc encoder config
> >       drm/amd/display: Add vupdate interrupt sources to NV10
> >       drm/amd/display: Disable display writeback on Linux for NV10
> >       drm/amd/display/dc: set num-dwb =3D 1 as navi10 asic cap
> >
> > james qian wang (Arm Technology China) (21):
> >       drm/komeda: Add writeback support
> >       drm/komeda: Added AFBC support for komeda driver
> >       drm/komeda: Attach scaler to drm as private object
> >       drm/komeda: Add the initial scaler support for CORE
> >       drm/komeda: Implement D71 scaler support
> >       drm/komeda: Add writeback scaling support
> >       drm/komeda: Add engine clock requirement check for the downscalin=
g
> >       drm/komeda: Add image enhancement support
> >       drm/komeda: Add komeda_fb_check_src_coords
> >       drm/komeda: Add format support for Y0L2, P010, YUV420_8/10BIT
> >       drm/komeda: Unify mclk/pclk/pipeline->aclk to one MCLK
> >       drm/komeda: Rename main engine clk name "mclk" to "aclk"
> >       dt/bindings: drm/komeda: Unify mclk/pclk/pipeline->aclk to one AC=
LK
> >       drm/komeda: Add component komeda_merger
> >       drm/komeda: Add split support for scaler
> >       drm/komeda: Add layer split support
> >       drm/komeda: Refine function to_d71_input_id
> >       drm/komeda: Accept null writeback configurations for writeback
> >       drm/komeda: Add new component komeda_splitter
> >       drm/komeda: Enable writeback split support
> >       drm/komeda: Correct printk format specifier for "size_t"
> >
> > kbuild test robot (1):
> >       drm/bochs: fix ptr_ret.cocci warnings
> >
> > shaoyunl (5):
> >       drm/amdgpu: Implement get num of hops between two xgmi device
> >       drm/amdkfd: Adjust weight to represent num_hops info when report
> > xgmi iolink
> >       drm/amdgpu: Update latest xgmi topology info after each device
> > is enumulated
> >       drm/amdgpu: Use heavy weight for tlb invalidation on xgmi configu=
ration
> >       drm/amdkfd: remove unnecessary warning message on gpu reset
> >
> > tiancyin (7):
> >       drm/amdgpu/sdma5: fix a sdma potential hang in VK_Examples test
> >       drm/amd/powerplay: disable uclk dpm by default
> >       drm/amdgpu/gfx10: update gfx golden settings
> >       drm/amd/powerplay: add ppt interface version log
> >       drm/amdgpu: add new navi10 DIDs
> >       drm/amdgpu: disable gfxoff on navi10
> >       drm/amd/powerplay: update smu11_driver_if_navi10.h
> >
> > xinhui pan (18):
> >       drm/amdgpu: gpu reset will run late_init
> >       drm/amdgpu: Revert "drm/amdgpu: skip gpu reset when ras error occ=
ured"
> >       drm/amdgpu: Issue ras TA disable/enable cmd forcely on boot
> >       drm/amdgpu: handle ras reset
> >       drm/amdgpu: gmc support ras gpu reset
> >       drm/amdgpu: gfx support ras gpu reset
> >       drm/amdgpu: sdma support ras gpu reset
> >       drm/amdgpu: gpu reset will run ras post init
> >       drm/amdgpu: add badpages sysfs interafce
> >       drm/amdgpu: ras support suspend/resume
> >       drm/amdgpu: enable ras suspend/resume
> >       drm/amdgpu: gmc handle ras resume
> >       drm/amdgpu: gfx handle ras resume
> >       drm/amdgpu: sdma handle ras resume
> >       drm/amdgpu: ras injection use gpu address
> >       drm/amdgpu: cancel late_init_work before gpu reset
> >       drm/amdgpu: Do error injection even vram reserve fails
> >       drm/amdgpu: Disable ras features on all IPs before gpu reset
> >
> >  Documentation/arm64/sve.txt                        |     16 +
> >  Documentation/block/switching-sched.txt            |     18 +-
> >  Documentation/cgroup-v1/blkio-controller.txt       |     96 +-
> >  Documentation/cgroup-v1/hugetlb.txt                |     22 +-
> >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |    100 +
> >  .../devicetree/bindings/display/arm,komeda.txt     |     23 +-
> >  .../bindings/display/bridge/renesas,lvds.txt       |     19 +-
> >  .../devicetree/bindings/display/bridge/sii902x.txt |     42 +-
> >  .../bindings/display/bridge/thine,thc63lvd1024.txt |      6 +
> >  .../bindings/display/bridge/toshiba,tc358767.txt   |      1 +
> >  .../devicetree/bindings/display/ingenic,lcd.txt    |     44 +
> >  .../devicetree/bindings/display/msm/dpu.txt        |     10 +
> >  .../devicetree/bindings/display/msm/dsi.txt        |      1 +
> >  .../display/panel/armadeus,st0700-adapt.txt        |      9 +
> >  .../bindings/display/panel/edt,et-series.txt       |     16 +
> >  .../display/panel/evervision,vgg804821.txt         |     12 +
> >  .../bindings/display/panel/friendlyarm,hd702e.txt  |     32 +
> >  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   |     42 +
> >  .../display/panel/osddisplays,osd101t2045-53ts.txt |     11 +
> >  .../display/panel/osddisplays,osd101t2587-53ts.txt |     14 +
> >  .../bindings/display/panel/samsung,s6e63m0.txt     |     33 +
> >  .../display/panel/tfc,s9700rtwv43tr-01b.txt        |     15 +
> >  .../bindings/display/panel/vl050_8048nt_c01.txt    |     12 +
> >  .../devicetree/bindings/display/renesas,du.txt     |      2 +
> >  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |      8 +
> >  .../devicetree/bindings/display/st,stm32-ltdc.txt  |      3 +
> >  .../bindings/display/sunxi/sun6i-dsi.txt           |     93 -
> >  .../devicetree/bindings/gpu/arm,mali-midgard.txt   |     19 +-
> >  .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |     57 +
> >  .../devicetree/bindings/vendor-prefixes.yaml       |      6 +
> >  Documentation/fb/modedb.txt                        |     14 +
> >  Documentation/gpu/amdgpu.rst                       |     24 +-
> >  Documentation/gpu/drivers.rst                      |      1 +
> >  Documentation/gpu/drm-client.rst                   |      3 +
> >  Documentation/gpu/drm-kms-helpers.rst              |     15 +
> >  Documentation/gpu/drm-mm.rst                       |     34 +-
> >  Documentation/gpu/drm-uapi.rst                     |     19 +-
> >  Documentation/gpu/i915.rst                         |     87 +-
> >  Documentation/gpu/mcde.rst                         |      8 +
> >  Documentation/gpu/todo.rst                         |     55 +-
> >  MAINTAINERS                                        |     10 +-
> >  Makefile                                           |      2 +-
> >  arch/arm64/Makefile                                |      2 +-
> >  arch/arm64/include/asm/tlbflush.h                  |      3 +
> >  arch/arm64/include/uapi/asm/kvm.h                  |      7 +
> >  arch/arm64/include/uapi/asm/ptrace.h               |      4 +
> >  arch/arm64/include/uapi/asm/sigcontext.h           |     14 +
> >  arch/arm64/kernel/fpsimd.c                         |     42 +-
> >  arch/powerpc/include/asm/book3s/64/pgtable.h       |     30 +
> >  arch/powerpc/include/asm/btext.h                   |      4 +
> >  arch/powerpc/include/asm/kexec.h                   |      3 +
> >  arch/powerpc/kernel/machine_kexec_32.c             |      4 +-
> >  arch/powerpc/kernel/prom_init.c                    |      1 +
> >  arch/powerpc/kernel/prom_init_check.sh             |      2 +-
> >  arch/powerpc/mm/book3s64/pgtable.c                 |      3 +
> >  arch/powerpc/mm/pgtable.c                          |     16 +-
> >  arch/x86/include/asm/fpu/internal.h                |      6 +-
> >  arch/x86/include/asm/intel-family.h                |      3 +
> >  arch/x86/kernel/cpu/microcode/core.c               |      2 +-
> >  arch/x86/kernel/cpu/resctrl/monitor.c              |      3 +
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c             |      7 +-
> >  arch/x86/kernel/fpu/core.c                         |      2 +-
> >  arch/x86/kernel/fpu/signal.c                       |     16 +-
> >  arch/x86/kernel/kgdb.c                             |      2 +-
> >  arch/x86/mm/kasan_init_64.c                        |      2 +-
> >  arch/x86/mm/kaslr.c                                |     11 +-
> >  block/Kconfig                                      |      1 +
> >  block/bfq-cgroup.c                                 |      6 +-
> >  block/blk-mq-debugfs.c                             |    145 +-
> >  block/blk-mq-debugfs.h                             |     36 +-
> >  block/blk-mq-sched.c                               |      1 -
> >  drivers/ata/libata-core.c                          |      9 +-
> >  drivers/base/devres.c                              |     24 +-
> >  drivers/block/null_blk_zoned.c                     |      4 -
> >  drivers/block/ps3vram.c                            |      2 +-
> >  drivers/clocksource/arm_arch_timer.c               |      8 +-
> >  drivers/clocksource/timer-ti-dm.c                  |      2 +-
> >  drivers/dax/device.c                               |     13 +-
> >  drivers/dma-buf/dma-buf.c                          |    176 +-
> >  drivers/dma-buf/dma-fence.c                        |     21 +-
> >  drivers/dma-buf/reservation.c                      |      4 +
> >  drivers/dma-buf/sync_debug.c                       |     26 -
> >  drivers/dma-buf/sync_debug.h                       |      1 -
> >  drivers/gpio/gpio-pca953x.c                        |      3 +-
> >  drivers/gpu/drm/Kconfig                            |     11 +
> >  drivers/gpu/drm/Makefile                           |     11 +-
> >  drivers/gpu/drm/amd/amdgpu/Kconfig                 |      7 +-
> >  drivers/gpu/drm/amd/amdgpu/Makefile                |     36 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |     80 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |      1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c           |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |     99 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |     10 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |    975 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |     85 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    228 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |     55 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |      9 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h        |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    163 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c            |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |      1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    185 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |      1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    506 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |    415 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |     34 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |      8 +-
> >  .../amdgpu/{amdgpu_prime.c =3D> amdgpu_dma_buf.c}    |    133 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h        |     46 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h       |     40 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |     60 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |     21 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    186 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c       |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |     18 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |     57 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h            |     24 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |     27 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |     16 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    182 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     86 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |      2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |      1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c            |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |     12 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |      9 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c          |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h            |      3 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |     32 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |    101 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |    211 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h             |     50 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |      2 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |      9 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c            |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |    392 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |      2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |    280 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h            |     37 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |    205 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     49 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    302 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |     17 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |     15 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     17 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |     98 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |      3 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.h          |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c           |     29 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_socbb.h          |     82 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |      1 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |      2 -
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c   |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    314 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     19 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    108 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |     68 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |    201 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |     94 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |     48 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |     14 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |     16 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     12 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |     33 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |     81 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/athub_v2_0.c            |    101 +
> >  drivers/gpu/drm/amd/amdgpu/athub_v2_0.h            |     30 +
> >  drivers/gpu/drm/amd/amdgpu/atom.h                  |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c         |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_dp.c           |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_i2c.c          |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/cik.c                   |     16 +-
> >  drivers/gpu/drm/amd/amdgpu/cik_ih.c                |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |      6 +-
> >  drivers/gpu/drm/amd/amdgpu/clearstate_gfx10.h      |    975 +
> >  drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |      7 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/df_v1_7.c               |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |    391 +-
> >  drivers/gpu/drm/amd/amdgpu/df_v3_6.h               |     10 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   5216 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.h             |     29 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |      8 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |     42 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |     71 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    542 +-
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |     28 +-
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |    353 +
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h           |     35 +
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    918 +
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.h             |     30 +
> >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |     19 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |     58 +-
> >  drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |      1 -
> >  drivers/gpu/drm/amd/amdgpu/kv_smc.c                |      1 -
> >  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |    366 +
> >  drivers/gpu/drm/amd/amdgpu/mes_v10_1.h             |     29 +
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |     25 +-
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |    444 +
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h            |     35 +
> >  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |     18 +-
> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |    486 +
> >  drivers/gpu/drm/amd/amdgpu/navi10_ih.h             |     29 +
> >  drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c       |     68 +
> >  drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h  |   4806 +
> >  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |    334 +
> >  .../{i915/i915_gemfs.h =3D> amd/amdgpu/nbio_v2_3.h}  |     25 +-
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |     15 +-
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |     15 +-
> >  drivers/gpu/drm/amd/amdgpu/nv.c                    |    823 +
> >  drivers/gpu/drm/amd/amdgpu/nv.h                    |     33 +
> >  drivers/gpu/drm/amd/amdgpu/nvd.h                   |    418 +
> >  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    126 +-
> >  drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |      3 +
> >  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    121 +-
> >  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |    135 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |      7 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |      7 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |     57 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   1687 +
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.h             |     45 +
> >  drivers/gpu/drm/amd/amdgpu/si.c                    |     20 +-
> >  drivers/gpu/drm/amd/amdgpu/si_dma.c                |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/si_dpm.c                |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/si_ih.c                 |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/si_smc.c                |      2 +-
> >  drivers/gpu/drm/amd/amdgpu/soc15.c                 |    110 +-
> >  drivers/gpu/drm/amd/amdgpu/soc15.h                 |     20 +
> >  drivers/gpu/drm/amd/amdgpu/soc15_common.h          |     68 +-
> >  drivers/gpu/drm/amd/amdgpu/ta_ras_if.h             |    108 +-
> >  drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |      5 +-
> >  drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |      6 +-
> >  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |     14 +-
> >  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |     13 +-
> >  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |      4 +-
> >  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |      3 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |    150 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   2261 +
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h              |     29 +
> >  drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |     95 +-
> >  drivers/gpu/drm/amd/amdgpu/vi.c                    |     17 +-
> >  drivers/gpu/drm/amd/amdkfd/Makefile                |      3 +
> >  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |    782 +-
> >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |   1124 +
> >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |     13 -
> >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |     63 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |     83 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |     17 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |      3 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |     36 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    105 +-
> >  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    664 +-
> >  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     18 +-
> >  .../drm/amd/amdkfd/kfd_device_queue_manager_cik.c  |      2 +
> >  .../drm/amd/amdkfd/kfd_device_queue_manager_v10.c  |     88 +
> >  .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |      1 +
> >  .../drm/amd/amdkfd/kfd_device_queue_manager_vi.c   |      2 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_events.c            |      2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |      4 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |     10 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |     25 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h      |      1 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c  |    348 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c   |      6 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_vi.c   |      4 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_module.c            |      6 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |     90 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     24 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |    134 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |    498 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    155 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |    143 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |     13 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h    |     16 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h    |      7 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     71 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    101 +-
> >  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |     71 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |     30 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |      3 +
> >  drivers/gpu/drm/amd/display/Kconfig                |     21 +-
> >  drivers/gpu/drm/amd/display/Makefile               |      1 +
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    428 +-
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |     23 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |    473 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |      1 +
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    110 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h  |      2 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     11 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |      4 -
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |    299 +-
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_services.c |      1 -
> >  drivers/gpu/drm/amd/display/dc/Makefile            |     18 +-
> >  drivers/gpu/drm/amd/display/dc/basics/vector.c     |      2 +
> >  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |      2 +
> >  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |      8 +
> >  .../amd/display/dc/bios/command_table_helper2.c    |      5 +-
> >  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |      2 +
> >  .../gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h   |      1 +
> >  .../gpu/drm/amd/display/dc/calcs/dcn_calc_math.c   |     20 +
> >  .../gpu/drm/amd/display/dc/calcs/dcn_calc_math.h   |      3 +
> >  drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |     75 +-
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |     87 +
> >  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |    143 +
> >  .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |    471 +
> >  .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h    |     59 +
> >  .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |    276 +
> >  .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.h |     44 +
> >  .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |    239 +
> >  .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h |     39 +
> >  .../amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c |    153 +
> >  .../amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.h |     34 +
> >  .../dcn10/rv1_clk_mgr.c}                           |    198 +-
> >  .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.h |     31 +
> >  .../amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c |     79 +
> >  .../amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.h |     29 +
> >  .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c       |    126 +
> >  .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.h       |     32 +
> >  .../drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c |     43 +
> >  .../dcn10/rv2_clk_mgr.h}                           |     13 +-
> >  .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |    391 +
> >  .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h   |     48 +
> >  drivers/gpu/drm/amd/display/dc/core/dc.c           |    515 +-
> >  .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |     31 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c      |    293 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |     16 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    227 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    144 +
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    148 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_sink.c      |      2 +
> >  drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    260 +-
> >  drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |     75 +
> >  drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c |     93 +-
> >  drivers/gpu/drm/amd/display/dc/dc.h                |    144 +-
> >  drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    127 +
> >  drivers/gpu/drm/amd/display/dc/dc_dsc.h            |     62 +
> >  drivers/gpu/drm/amd/display/dc/dc_helper.c         |      5 +-
> >  drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    122 +-
> >  drivers/gpu/drm/amd/display/dc/dc_link.h           |     11 +
> >  drivers/gpu/drm/amd/display/dc/dc_stream.h         |     75 +-
> >  drivers/gpu/drm/amd/display/dc/dc_types.h          |    118 +-
> >  drivers/gpu/drm/amd/display/dc/dce/Makefile        |      2 +-
> >  drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |     15 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_abm.h       |     20 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |      4 +-
> >  drivers/gpu/drm/amd/display/dc/dce/dce_audio.h     |      7 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |      3 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |     10 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c   |      2 +
> >  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |     87 +-
> >  .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |     42 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |     97 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |     10 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |    127 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |    109 +-
> >  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h    |     30 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |      3 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c       |      2 +
> >  .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |      3 +
> >  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |      2 +
> >  .../drm/amd/display/dc/dce/dce_stream_encoder.c    |     16 +-
> >  .../amd/display/dc/dce100/dce100_hw_sequencer.c    |      9 +-
> >  .../drm/amd/display/dc/dce100/dce100_resource.c    |     75 +-
> >  .../drm/amd/display/dc/dce100/dce100_resource.h    |      5 +
> >  .../drm/amd/display/dc/dce110/dce110_compressor.c  |      3 +
> >  .../amd/display/dc/dce110/dce110_hw_sequencer.c    |    200 +-
> >  .../amd/display/dc/dce110/dce110_opp_regamma_v.c   |      2 +
> >  .../drm/amd/display/dc/dce110/dce110_resource.c    |     69 +-
> >  .../drm/amd/display/dc/dce110/dce110_resource.h    |      5 +
> >  .../display/dc/dce110/dce110_timing_generator.c    |      5 +
> >  .../display/dc/dce110/dce110_timing_generator.h    |      5 +
> >  .../display/dc/dce110/dce110_timing_generator_v.c  |      5 +
> >  .../drm/amd/display/dc/dce110/dce110_transform_v.c |      2 +
> >  .../drm/amd/display/dc/dce112/dce112_compressor.c  |      3 +
> >  .../drm/amd/display/dc/dce112/dce112_resource.c    |     33 +-
> >  .../drm/amd/display/dc/dce120/dce120_resource.c    |     39 +-
> >  .../display/dc/dce120/dce120_timing_generator.c    |     96 +-
> >  .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |     52 +-
> >  .../amd/display/dc/dce80/dce80_timing_generator.c  |      7 +-
> >  drivers/gpu/drm/amd/display/dc/dcn10/Makefile      |      2 +-
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.h |     31 +-
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |     10 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |      5 +
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |      4 +
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  |      8 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c   |    136 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h   |    271 +
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |    471 +-
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |     16 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |     34 +-
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |      8 +
> >  .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    197 +-
> >  .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |      4 +
> >  .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |      2 +-
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c   |     26 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.h   |     43 +
> >  .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |     11 +-
> >  .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |    174 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |      6 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c   |     10 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    213 +-
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |     91 +-
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |     74 +-
> >  .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.h  |      5 +
> >  .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |    129 +-
> >  .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |     79 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |     17 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |    159 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |    116 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |    502 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h   |    698 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c    |    990 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c   |    694 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h   |    575 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c   |    332 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h   |    458 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c   |    877 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |    592 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h    |    107 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |    700 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h  |    277 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   2008 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |    103 +
> >  .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |    460 +
> >  .../drm/amd/display/dc/dcn20/dcn20_link_encoder.h  |    173 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.c  |    323 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub.h  |    544 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |    526 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h   |    285 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   |    355 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h   |    158 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |    542 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |    116 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   3177 +
> >  .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |    133 +
> >  .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |    610 +
> >  .../amd/display/dc/dcn20/dcn20_stream_encoder.h    |    107 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c  |     59 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h  |     90 +
> >  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |      7 +
> >  drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    142 +-
> >  drivers/gpu/drm/amd/display/dc/dml/Makefile        |     14 +-
> >  .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |   5104 +
> >  .../amd/display/dc/dml/dcn20/display_mode_vba_20.h |     32 +
> >  .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |   1701 +
> >  .../display/dc/dml/dcn20/display_rq_dlg_calc_20.h  |     74 +
> >  .../drm/amd/display/dc/dml/display_mode_enums.h    |     12 +-
> >  .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |     22 +
> >  .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |     36 +-
> >  .../drm/amd/display/dc/dml/display_mode_structs.h  |     32 +
> >  .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    839 +
> >  .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    854 +
> >  .../gpu/drm/amd/display/dc/dml/dml_inline_defs.h   |      8 +
> >  drivers/gpu/drm/amd/display/dc/dsc/Makefile        |     13 +
> >  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |    858 +
> >  drivers/gpu/drm/amd/display/dc/dsc/drm_dsc_dc.c    |    382 +
> >  drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h    |     54 +
> >  drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h     |    706 +
> >  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c       |    258 +
> >  drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h       |     85 +
> >  drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c   |    147 +
> >  drivers/gpu/drm/amd/display/dc/gpio/Makefile       |     11 +
> >  .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.c   |    212 +
> >  .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.h   |     33 +
> >  .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.c |    382 +
> >  .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.h |     35 +
> >  drivers/gpu/drm/amd/display/dc/gpio/ddc_regs.h     |     53 +
> >  drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |      2 +
> >  drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |      2 +
> >  drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     18 +
> >  drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     13 +-
> >  drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c       |      2 +
> >  drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     11 +-
> >  drivers/gpu/drm/amd/display/dc/inc/core_status.h   |      5 +
> >  drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     93 +-
> >  drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |      7 +
> >  drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h     |      2 +-
> >  drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |      2 +-
> >  drivers/gpu/drm/amd/display/dc/inc/hw/audio.h      |      1 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |     31 +-
> >  .../dce_clk_mgr.h =3D> inc/hw/clk_mgr_internal.h}    |    220 +-
> >  drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     58 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     70 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h        |    101 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h        |    180 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     30 +-
> >  drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     50 +-
> >  .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     28 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h    |    105 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |     52 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |     29 +
> >  .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |     66 +-
> >  .../drm/amd/display/dc/inc/hw/timing_generator.h   |     60 +-
> >  drivers/gpu/drm/amd/display/dc/inc/hw/vmid.h       |      1 +
> >  drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |     58 +
> >  drivers/gpu/drm/amd/display/dc/inc/resource.h      |      8 +
> >  drivers/gpu/drm/amd/display/dc/inc/vm_helper.h     |     16 +-
> >  drivers/gpu/drm/amd/display/dc/irq/Makefile        |     10 +
> >  .../amd/display/dc/irq/dce110/irq_service_dce110.c |      2 +
> >  .../amd/display/dc/irq/dce120/irq_service_dce120.c |      2 +
> >  .../amd/display/dc/irq/dce80/irq_service_dce80.c   |      2 +
> >  .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |      4 +-
> >  .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |    375 +
> >  .../amd/display/dc/irq/dcn20/irq_service_dcn20.h   |     34 +
> >  drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |      2 +
> >  drivers/gpu/drm/amd/display/dc/os_types.h          |      8 +-
> >  .../amd/display/dc/virtual/virtual_link_encoder.c  |      2 +
> >  .../display/dc/virtual/virtual_stream_encoder.c    |     17 +
> >  .../drm/amd/display/include/bios_parser_types.h    |      3 +-
> >  drivers/gpu/drm/amd/display/include/dal_asic_id.h  |     20 +-
> >  drivers/gpu/drm/amd/display/include/dal_types.h    |      5 +-
> >  drivers/gpu/drm/amd/display/include/logger_types.h |     10 +
> >  .../gpu/drm/amd/display/include/set_mode_types.h   |      5 +-
> >  .../drm/amd/display/modules/color/color_gamma.c    |     62 +-
> >  .../drm/amd/display/modules/color/color_gamma.h    |      1 +
> >  .../drm/amd/display/modules/freesync/freesync.c    |      2 +
> >  .../gpu/drm/amd/display/modules/inc/mod_shared.h   |     60 +
> >  drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h |     46 +
> >  .../amd/display/modules/info_packet/info_packet.c  |      4 +-
> >  drivers/gpu/drm/amd/display/modules/power/Makefile |      2 +-
> >  drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |    167 +
> >  drivers/gpu/drm/amd/include/amd_shared.h           |     11 +-
> >  .../include/asic_reg/athub/athub_2_0_0_default.h   |    272 +
> >  .../include/asic_reg/athub/athub_2_0_0_offset.h    |    514 +
> >  .../include/asic_reg/athub/athub_2_0_0_sh_mask.h   |   2264 +
> >  .../amd/include/asic_reg/clk/clk_11_0_0_offset.h   |     33 +
> >  .../amd/include/asic_reg/clk/clk_11_0_0_sh_mask.h  |     38 +
> >  .../amd/include/asic_reg/dcn/dcn_2_0_0_offset.h    |  17535 +++
> >  .../amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h   |  68024 ++++++++++
> >  .../drm/amd/include/asic_reg/df/df_3_6_offset.h    |     18 +
> >  .../amd/include/asic_reg/gc/gc_10_1_0_default.h    |   6028 +
> >  .../drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h |  11339 ++
> >  .../amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h    |  43963 +++++++
> >  .../drm/amd/include/asic_reg/gc/gc_9_0_offset.h    |     31 +
> >  .../amd/include/asic_reg/hdp/hdp_5_0_0_offset.h    |    217 +
> >  .../amd/include/asic_reg/hdp/hdp_5_0_0_sh_mask.h   |    659 +
> >  .../include/asic_reg/mmhub/mmhub_2_0_0_default.h   |    927 +
> >  .../include/asic_reg/mmhub/mmhub_2_0_0_offset.h    |   1799 +
> >  .../include/asic_reg/mmhub/mmhub_2_0_0_sh_mask.h   |   7567 ++
> >  .../drm/amd/include/asic_reg/mp/mp_11_0_sh_mask.h  |    429 +
> >  .../amd/include/asic_reg/nbio/nbio_2_3_default.h   |  18521 +++
> >  .../amd/include/asic_reg/nbio/nbio_2_3_offset.h    |  14663 +++
> >  .../amd/include/asic_reg/nbio/nbio_2_3_sh_mask.h   | 120339 ++++++++++=
++++++++
> >  .../drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h   |      3 +
> >  .../drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h   |      3 +
> >  .../drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h |      3 +
> >  .../amd/include/asic_reg/oss/osssys_5_0_0_offset.h |    353 +
> >  .../include/asic_reg/oss/osssys_5_0_0_sh_mask.h    |   1305 +
> >  .../include/asic_reg/smuio/smuio_11_0_0_offset.h   |    323 +
> >  .../include/asic_reg/smuio/smuio_11_0_0_sh_mask.h  |    689 +
> >  .../amd/include/asic_reg/vcn/vcn_2_0_0_offset.h    |   1008 +
> >  .../amd/include/asic_reg/vcn/vcn_2_0_0_sh_mask.h   |   3815 +
> >  drivers/gpu/drm/amd/include/atomfirmware.h         |    188 +-
> >  drivers/gpu/drm/amd/include/cik_structs.h          |      3 +-
> >  drivers/gpu/drm/amd/include/discovery.h            |    165 +
> >  .../include/ivsrcid/{ =3D> dcn}/irqsrcs_dcn_1_0.h    |      0
> >  .../drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_10_1.h |     53 +
> >  .../amd/include/ivsrcid/sdma0/irqsrcs_sdma0_5_0.h  |     43 +
> >  .../amd/include/ivsrcid/sdma1/irqsrcs_sdma1_5_0.h  |     44 +
> >  .../drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h  |     32 +
> >  drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |      1 +
> >  drivers/gpu/drm/amd/include/kgd_pp_interface.h     |     11 +
> >  drivers/gpu/drm/amd/include/navi10_enum.h          |  22764 ++++
> >  drivers/gpu/drm/amd/include/navi10_ip_offset.h     |    855 +
> >  drivers/gpu/drm/amd/include/soc15_hw_ip.h          |      4 +-
> >  drivers/gpu/drm/amd/include/v10_structs.h          |   1258 +
> >  drivers/gpu/drm/amd/include/v9_structs.h           |      3 +-
> >  drivers/gpu/drm/amd/include/vi_structs.h           |      3 +-
> >  drivers/gpu/drm/amd/powerplay/Makefile             |      2 +-
> >  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |    425 +-
> >  .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |     18 +-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |      3 +-
> >  .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |      4 +-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |      8 +-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c   |      3 +
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |    157 +-
> >  .../amd/powerplay/hwmgr/vega10_processpptables.c   |     25 +
> >  .../amd/powerplay/hwmgr/vega10_processpptables.h   |      1 +
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    123 +-
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |      3 +
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |     84 +-
> >  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |    361 +-
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |      2 +
> >  drivers/gpu/drm/amd/powerplay/inc/power_state.h    |      7 +
> >  drivers/gpu/drm/amd/powerplay/inc/pp_thermal.h     |     12 +-
> >  .../drm/amd/powerplay/inc/smu11_driver_if_navi10.h |   1069 +
> >  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |     29 +
> >  .../gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h    |     39 +-
> >  .../gpu/drm/amd/powerplay/inc/smu_v11_0_pptable.h  |      2 +-
> >  drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |      1 +
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |   1579 +
> >  drivers/gpu/drm/amd/powerplay/navi10_ppt.h         |     28 +
> >  drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |   1232 +-
> >  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |      4 +
> >  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |      3 +
> >  .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |      4 +
> >  .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |      9 +
> >  .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |      3 +
> >  drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |      1 +
> >  .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |      4 +
> >  .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |      3 +
> >  .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |     22 +
> >  .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |      1 +
> >  .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |      3 +
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |   1285 +-
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.h         |     50 +
> >  drivers/gpu/drm/arm/display/include/malidp_io.h    |      7 +
> >  drivers/gpu/drm/arm/display/include/malidp_utils.h |      5 +-
> >  drivers/gpu/drm/arm/display/komeda/Makefile        |      2 +
> >  .../gpu/drm/arm/display/komeda/d71/d71_component.c |    582 +-
> >  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |    142 +-
> >  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |      2 +
> >  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c |     67 +
> >  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h |     17 +
> >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |    154 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |     59 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |     13 +-
> >  .../drm/arm/display/komeda/komeda_format_caps.c    |     58 +
> >  .../drm/arm/display/komeda/komeda_format_caps.h    |     24 +-
> >  .../drm/arm/display/komeda/komeda_framebuffer.c    |    175 +-
> >  .../drm/arm/display/komeda/komeda_framebuffer.h    |     13 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |    130 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |     71 +-
> >  .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |     66 +-
> >  .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |    111 +-
> >  .../drm/arm/display/komeda/komeda_pipeline_state.c |    679 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |    191 +-
> >  .../drm/arm/display/komeda/komeda_private_obj.c    |    154 +
> >  .../drm/arm/display/komeda/komeda_wb_connector.c   |    199 +
> >  drivers/gpu/drm/arm/malidp_crtc.c                  |     28 +-
> >  drivers/gpu/drm/arm/malidp_drv.c                   |     11 +-
> >  drivers/gpu/drm/arm/malidp_hw.c                    |      3 +-
> >  drivers/gpu/drm/arm/malidp_mw.c                    |      2 +-
> >  drivers/gpu/drm/arm/malidp_planes.c                |      8 +-
> >  drivers/gpu/drm/armada/armada_510.c                |    130 +-
> >  drivers/gpu/drm/armada/armada_crtc.c               |    214 +-
> >  drivers/gpu/drm/armada/armada_crtc.h               |     21 +-
> >  drivers/gpu/drm/armada/armada_debugfs.c            |     98 +-
> >  drivers/gpu/drm/armada/armada_drm.h                |      1 +
> >  drivers/gpu/drm/armada/armada_drv.c                |     38 +-
> >  drivers/gpu/drm/armada/armada_fb.c                 |      3 +-
> >  drivers/gpu/drm/armada/armada_hw.h                 |     29 +-
> >  drivers/gpu/drm/armada/armada_overlay.c            |     56 +-
> >  drivers/gpu/drm/armada/armada_plane.c              |    124 +-
> >  drivers/gpu/drm/armada/armada_plane.h              |     23 +
> >  drivers/gpu/drm/ast/Kconfig                        |      3 +-
> >  drivers/gpu/drm/ast/ast_drv.c                      |     13 +-
> >  drivers/gpu/drm/ast/ast_drv.h                      |     78 +-
> >  drivers/gpu/drm/ast/ast_fb.c                       |     61 +-
> >  drivers/gpu/drm/ast/ast_main.c                     |     77 +-
> >  drivers/gpu/drm/ast/ast_mode.c                     |    157 +-
> >  drivers/gpu/drm/ast/ast_ttm.c                      |    302 +-
> >  drivers/gpu/drm/ati_pcigart.c                      |      5 +-
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |     18 +-
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    120 +-
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |      2 +
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |     11 +-
> >  drivers/gpu/drm/bochs/Kconfig                      |      2 +-
> >  drivers/gpu/drm/bochs/bochs.h                      |     54 +-
> >  drivers/gpu/drm/bochs/bochs_drv.c                  |     24 +-
> >  drivers/gpu/drm/bochs/bochs_kms.c                  |     18 +-
> >  drivers/gpu/drm/bochs/bochs_mm.c                   |    427 +-
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |      8 +-
> >  drivers/gpu/drm/bridge/analogix-anx78xx.c          |      9 +-
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |     58 +-
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |      6 +-
> >  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |     24 +-
> >  drivers/gpu/drm/bridge/dumb-vga-dac.c              |      2 +-
> >  drivers/gpu/drm/bridge/lvds-encoder.c              |     10 +-
> >  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |      3 +-
> >  drivers/gpu/drm/bridge/nxp-ptn3460.c               |      3 +-
> >  drivers/gpu/drm/bridge/panel.c                     |      5 +-
> >  drivers/gpu/drm/bridge/parade-ps8622.c             |      3 +-
> >  drivers/gpu/drm/bridge/sii902x.c                   |    491 +-
> >  drivers/gpu/drm/bridge/sii9234.c                   |      4 +-
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |    193 +-
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |     17 +-
> >  drivers/gpu/drm/bridge/tc358764.c                  |     14 +-
> >  drivers/gpu/drm/bridge/tc358767.c                  |    593 +-
> >  drivers/gpu/drm/bridge/thc63lvd1024.c              |     64 +-
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c              |     18 +-
> >  drivers/gpu/drm/bridge/ti-tfp410.c                 |     14 +-
> >  drivers/gpu/drm/cirrus/cirrus_ttm.c                |    337 -
> >  drivers/gpu/drm/drm_agpsupport.c                   |     11 +-
> >  drivers/gpu/drm/drm_atomic.c                       |    248 +-
> >  drivers/gpu/drm/drm_atomic_helper.c                |    232 +-
> >  drivers/gpu/drm/drm_atomic_state_helper.c          |     70 +-
> >  drivers/gpu/drm/drm_atomic_uapi.c                  |     23 +-
> >  drivers/gpu/drm/drm_auth.c                         |     30 +-
> >  drivers/gpu/drm/drm_blend.c                        |      9 +-
> >  drivers/gpu/drm/drm_bridge.c                       |    110 +
> >  drivers/gpu/drm/drm_bufs.c                         |     21 +-
> >  drivers/gpu/drm/drm_client.c                       |     15 +-
> >  drivers/gpu/drm/drm_client_modeset.c               |   1125 +
> >  drivers/gpu/drm/drm_color_mgmt.c                   |      8 +-
> >  drivers/gpu/drm/drm_connector.c                    |     99 +-
> >  drivers/gpu/drm/drm_context.c                      |      8 +-
> >  drivers/gpu/drm/drm_crtc.c                         |      4 +-
> >  drivers/gpu/drm/drm_crtc_helper.c                  |     14 +-
> >  drivers/gpu/drm/drm_crtc_internal.h                |     31 +-
> >  drivers/gpu/drm/drm_damage_helper.c                |      2 +-
> >  drivers/gpu/drm/drm_debugfs.c                      |     92 +-
> >  drivers/gpu/drm/drm_debugfs_crc.c                  |     46 +-
> >  drivers/gpu/drm/drm_dma.c                          |      6 +-
> >  drivers/gpu/drm/drm_dp_aux_dev.c                   |      8 +-
> >  drivers/gpu/drm/drm_dp_dual_mode_helper.c          |      4 +-
> >  drivers/gpu/drm/drm_dp_helper.c                    |     16 +-
> >  drivers/gpu/drm/drm_dp_mst_topology.c              |     19 +-
> >  drivers/gpu/drm/drm_drv.c                          |     14 +-
> >  drivers/gpu/drm/drm_dumb_buffers.c                 |      4 +-
> >  drivers/gpu/drm/drm_edid.c                         |    287 +-
> >  drivers/gpu/drm/drm_edid_load.c                    |      9 +-
> >  drivers/gpu/drm/drm_encoder.c                      |      4 +-
> >  drivers/gpu/drm/drm_fb_helper.c                    |   1408 +-
> >  drivers/gpu/drm/drm_file.c                         |    133 +-
> >  drivers/gpu/drm/drm_flip_work.c                    |      6 +-
> >  drivers/gpu/drm/drm_format_helper.c                |      4 +-
> >  drivers/gpu/drm/drm_fourcc.c                       |    120 +-
> >  drivers/gpu/drm/drm_framebuffer.c                  |     13 +-
> >  drivers/gpu/drm/drm_gem.c                          |     40 +-
> >  drivers/gpu/drm/drm_gem_cma_helper.c               |     11 +-
> >  drivers/gpu/drm/drm_gem_framebuffer_helper.c       |      7 +-
> >  drivers/gpu/drm/drm_gem_shmem_helper.c             |      3 +-
> >  drivers/gpu/drm/drm_gem_vram_helper.c              |    641 +
> >  drivers/gpu/drm/drm_hashtab.c                      |     10 +-
> >  drivers/gpu/drm/drm_hdcp.c                         |    382 +
> >  drivers/gpu/drm/drm_internal.h                     |     42 +-
> >  drivers/gpu/drm/drm_ioc32.c                        |      9 +-
> >  drivers/gpu/drm/drm_ioctl.c                        |     22 +-
> >  drivers/gpu/drm/drm_irq.c                          |     13 +-
> >  drivers/gpu/drm/drm_kms_helper_common.c            |      3 +-
> >  drivers/gpu/drm/drm_lease.c                        |     15 +-
> >  drivers/gpu/drm/drm_legacy.h                       |      6 +
> >  drivers/gpu/drm/drm_legacy_misc.c                  |     27 +-
> >  drivers/gpu/drm/drm_lock.c                         |      8 +-
> >  drivers/gpu/drm/drm_memory.c                       |      9 +-
> >  drivers/gpu/drm/drm_mm.c                           |      9 +-
> >  drivers/gpu/drm/drm_mode_config.c                  |      6 +-
> >  drivers/gpu/drm/drm_mode_object.c                  |      9 +-
> >  drivers/gpu/drm/drm_modes.c                        |    480 +-
> >  drivers/gpu/drm/drm_modeset_lock.c                 |      2 +-
> >  drivers/gpu/drm/drm_of.c                           |      5 +-
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c     |     32 +
> >  drivers/gpu/drm/drm_pci.c                          |     11 +-
> >  drivers/gpu/drm/drm_plane_helper.c                 |      9 +-
> >  drivers/gpu/drm/drm_prime.c                        |     84 +-
> >  drivers/gpu/drm/drm_print.c                        |      7 +-
> >  drivers/gpu/drm/drm_probe_helper.c                 |     23 +-
> >  drivers/gpu/drm/drm_property.c                     |      7 +-
> >  drivers/gpu/drm/drm_rect.c                         |      4 +-
> >  drivers/gpu/drm/drm_scatter.c                      |      9 +-
> >  drivers/gpu/drm/drm_scdc_helper.c                  |      2 +-
> >  drivers/gpu/drm/drm_self_refresh_helper.c          |    218 +
> >  drivers/gpu/drm/drm_simple_kms_helper.c            |      5 +-
> >  drivers/gpu/drm/drm_syncobj.c                      |     13 +-
> >  drivers/gpu/drm/drm_sysfs.c                        |     17 +-
> >  drivers/gpu/drm/drm_trace.h                        |      2 +
> >  drivers/gpu/drm/drm_trace_points.c                 |      3 +-
> >  drivers/gpu/drm/drm_vblank.c                       |     22 +-
> >  drivers/gpu/drm/drm_vm.c                           |     19 +-
> >  drivers/gpu/drm/drm_vma_manager.c                  |      6 +-
> >  drivers/gpu/drm/drm_vram_helper_common.c           |     96 +
> >  drivers/gpu/drm/drm_vram_mm_helper.c               |    297 +
> >  drivers/gpu/drm/drm_writeback.c                    |      6 +-
> >  drivers/gpu/drm/etnaviv/etnaviv_dump.c             |      5 -
> >  drivers/gpu/drm/etnaviv/etnaviv_sched.c            |      2 +-
> >  drivers/gpu/drm/exynos/Kconfig                     |      6 +-
> >  drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |      7 +-
> >  drivers/gpu/drm/exynos/exynos7_drm_decon.c         |      8 +-
> >  drivers/gpu/drm/exynos/exynos_dp.c                 |     13 +-
> >  drivers/gpu/drm/exynos/exynos_drm_crtc.c           |      2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_dma.c            |      6 +-
> >  drivers/gpu/drm/exynos/exynos_drm_dpi.c            |      8 +-
> >  drivers/gpu/drm/exynos/exynos_drm_drv.c            |     12 +-
> >  drivers/gpu/drm/exynos/exynos_drm_drv.h            |      8 +-
> >  drivers/gpu/drm/exynos/exynos_drm_dsi.c            |     21 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fb.c             |      6 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |      8 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fimc.c           |     15 +-
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |     14 +-
> >  drivers/gpu/drm/exynos/exynos_drm_g2d.c            |     11 +-
> >  drivers/gpu/drm/exynos/exynos_drm_gem.c            |      7 +-
> >  drivers/gpu/drm/exynos/exynos_drm_gsc.c            |     13 +-
> >  drivers/gpu/drm/exynos/exynos_drm_ipp.c            |      3 +-
> >  drivers/gpu/drm/exynos/exynos_drm_mic.c            |     22 +-
> >  drivers/gpu/drm/exynos/exynos_drm_plane.c          |      4 +-
> >  drivers/gpu/drm/exynos/exynos_drm_rotator.c        |     10 +-
> >  drivers/gpu/drm/exynos/exynos_drm_scaler.c         |     12 +-
> >  drivers/gpu/drm/exynos/exynos_drm_vidi.c           |      9 +-
> >  drivers/gpu/drm/exynos/exynos_hdmi.c               |     41 +-
> >  drivers/gpu/drm/exynos/exynos_mixer.c              |     31 +-
> >  drivers/gpu/drm/gma500/accel_2d.c                  |     18 +-
> >  drivers/gpu/drm/gma500/blitter.h                   |      2 +
> >  drivers/gpu/drm/gma500/cdv_device.c                |     13 +-
> >  drivers/gpu/drm/gma500/cdv_device.h                |      4 +
> >  drivers/gpu/drm/gma500/cdv_intel_crt.c             |      8 +-
> >  drivers/gpu/drm/gma500/cdv_intel_display.c         |     10 +-
> >  drivers/gpu/drm/gma500/cdv_intel_dp.c              |      9 +-
> >  drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |      9 +-
> >  drivers/gpu/drm/gma500/cdv_intel_lvds.c            |      9 +-
> >  drivers/gpu/drm/gma500/framebuffer.c               |     26 +-
> >  drivers/gpu/drm/gma500/framebuffer.h               |      1 -
> >  drivers/gpu/drm/gma500/gem.c                       |      5 +-
> >  drivers/gpu/drm/gma500/gma_device.c                |      1 -
> >  drivers/gpu/drm/gma500/gma_device.h                |      1 +
> >  drivers/gpu/drm/gma500/gma_display.c               |     12 +-
> >  drivers/gpu/drm/gma500/gma_display.h               |      3 +
> >  drivers/gpu/drm/gma500/gtt.c                       |      5 +-
> >  drivers/gpu/drm/gma500/gtt.h                       |      1 -
> >  drivers/gpu/drm/gma500/intel_bios.c                |      6 +-
> >  drivers/gpu/drm/gma500/intel_bios.h                |      3 +-
> >  drivers/gpu/drm/gma500/intel_gmbus.c               |     11 +-
> >  drivers/gpu/drm/gma500/intel_i2c.c                 |      4 +-
> >  drivers/gpu/drm/gma500/mdfld_device.c              |     16 +-
> >  drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |      4 +-
> >  drivers/gpu/drm/gma500/mdfld_dsi_output.c          |     12 +-
> >  drivers/gpu/drm/gma500/mdfld_dsi_output.h          |      8 +-
> >  drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c      |      4 +-
> >  drivers/gpu/drm/gma500/mdfld_intel_display.c       |     11 +-
> >  drivers/gpu/drm/gma500/mdfld_tmd_vid.c             |      2 +
> >  drivers/gpu/drm/gma500/mid_bios.c                  |      5 +-
> >  drivers/gpu/drm/gma500/mid_bios.h                  |      1 +
> >  drivers/gpu/drm/gma500/mmu.c                       |      6 +-
> >  drivers/gpu/drm/gma500/oaktrail.h                  |      2 +
> >  drivers/gpu/drm/gma500/oaktrail_crtc.c             |      8 +-
> >  drivers/gpu/drm/gma500/oaktrail_device.c           |     20 +-
> >  drivers/gpu/drm/gma500/oaktrail_hdmi.c             |      8 +-
> >  drivers/gpu/drm/gma500/oaktrail_lvds.c             |      6 +-
> >  drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c         |     11 +-
> >  drivers/gpu/drm/gma500/power.h                     |      4 +-
> >  drivers/gpu/drm/gma500/psb_device.c                |     12 +-
> >  drivers/gpu/drm/gma500/psb_drv.c                   |     33 +-
> >  drivers/gpu/drm/gma500/psb_drv.h                   |     16 +-
> >  drivers/gpu/drm/gma500/psb_intel_display.c         |      7 +-
> >  drivers/gpu/drm/gma500/psb_intel_lvds.c            |      5 +-
> >  drivers/gpu/drm/gma500/psb_intel_modes.c           |      2 +-
> >  drivers/gpu/drm/gma500/psb_intel_sdvo.c            |     15 +-
> >  drivers/gpu/drm/gma500/psb_irq.c                   |      9 +-
> >  drivers/gpu/drm/gma500/psb_irq.h                   |      2 +-
> >  drivers/gpu/drm/gma500/psb_lid.c                   |      6 +-
> >  drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |     13 +-
> >  drivers/gpu/drm/hisilicon/hibmc/Kconfig            |      2 +-
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |     19 +-
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |     14 +-
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     33 +-
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |     37 +-
> >  drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    341 +-
> >  drivers/gpu/drm/i2c/tda998x_drv.c                  |    450 +-
> >  drivers/gpu/drm/i915/Kconfig                       |     35 +-
> >  drivers/gpu/drm/i915/Kconfig.debug                 |     15 +
> >  drivers/gpu/drm/i915/Kconfig.profile               |     27 +
> >  drivers/gpu/drm/i915/Makefile                      |    201 +-
> >  drivers/gpu/drm/i915/Makefile.header-test          |     37 +-
> >  drivers/gpu/drm/i915/display/Makefile              |      2 +
> >  drivers/gpu/drm/i915/display/Makefile.header-test  |     16 +
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_ch7017.c    |      3 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_ch7xxx.c    |      3 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_ivch.c      |      3 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_ns2501.c    |      5 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_sil164.c    |      3 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/dvo_tfp410.c    |      3 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/icl_dsi.c       |    171 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_acpi.c    |      3 +
> >  drivers/gpu/drm/i915/display/intel_acpi.h          |     17 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_atomic.c  |     35 +-
> >  drivers/gpu/drm/i915/display/intel_atomic.h        |     49 +
> >  .../drm/i915/{ =3D> display}/intel_atomic_plane.c    |     72 +-
> >  .../drm/i915/{ =3D> display}/intel_atomic_plane.h    |     10 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_audio.c   |     61 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_audio.h   |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_bios.c    |    212 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_bios.h    |     21 +
> >  drivers/gpu/drm/i915/display/intel_bw.c            |    421 +
> >  drivers/gpu/drm/i915/display/intel_bw.h            |     47 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_cdclk.c   |    296 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_cdclk.h   |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_color.c   |    248 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_color.h   |      1 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_combo_phy.c   |     87 +-
> >  drivers/gpu/drm/i915/display/intel_combo_phy.h     |     20 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_connector.c   |      3 +-
> >  .../gpu/drm/i915/{ =3D> display}/intel_connector.h   |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_crt.c     |     44 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_crt.h     |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_ddi.c     |     93 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_ddi.h     |      1 -
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_display.c |   1896 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_display.h |     90 +-
> >  drivers/gpu/drm/i915/display/intel_display_power.c |   4618 +
> >  drivers/gpu/drm/i915/display/intel_display_power.h |    288 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dp.c      |    310 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dp.h      |      1 +
> >  .../i915/{ =3D> display}/intel_dp_aux_backlight.c    |      1 +
> >  .../gpu/drm/i915/display/intel_dp_aux_backlight.h  |     13 +
> >  .../i915/{ =3D> display}/intel_dp_link_training.c    |      1 +
> >  .../gpu/drm/i915/display/intel_dp_link_training.h  |     14 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dp_mst.c  |     10 +-
> >  drivers/gpu/drm/i915/display/intel_dp_mst.h        |     14 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_dpio_phy.c    |     42 +-
> >  drivers/gpu/drm/i915/display/intel_dpio_phy.h      |     58 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_dpll_mgr.c    |     87 +-
> >  .../gpu/drm/i915/{ =3D> display}/intel_dpll_mgr.h    |     12 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dsi.c     |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dsi.h     |      8 +
> >  .../i915/{ =3D> display}/intel_dsi_dcs_backlight.c   |      8 +-
> >  .../gpu/drm/i915/display/intel_dsi_dcs_backlight.h |     13 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dsi_vbt.c |    375 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dvo.c     |      8 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_dvo.h     |      0
> >  .../drm/i915/{dvo.h =3D> display/intel_dvo_dev.h}    |     10 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_fbc.c     |      4 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_fbc.h     |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_fbdev.c   |      8 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_fbdev.h   |      0
> >  .../drm/i915/{ =3D> display}/intel_fifo_underrun.c   |      1 +
> >  drivers/gpu/drm/i915/display/intel_fifo_underrun.h |     27 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_frontbuffer.c |      7 +-
> >  .../gpu/drm/i915/{ =3D> display}/intel_frontbuffer.h |      2 +-
> >  .../i915/{intel_i2c.c =3D> display/intel_gmbus.c}    |    100 +-
> >  drivers/gpu/drm/i915/display/intel_gmbus.h         |     27 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_hdcp.c    |     55 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_hdcp.h    |      1 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_hdmi.c    |    175 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_hdmi.h    |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_hotplug.c |      5 +-
> >  drivers/gpu/drm/i915/display/intel_hotplug.h       |     30 +
> >  .../gpu/drm/i915/{ =3D> display}/intel_lpe_audio.c   |      8 +-
> >  drivers/gpu/drm/i915/display/intel_lpe_audio.h     |     22 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_lspcon.c  |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_lspcon.h  |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_lvds.c    |      2 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_lvds.h    |      0
> >  .../gpu/drm/i915/{ =3D> display}/intel_opregion.c    |      3 +-
> >  .../gpu/drm/i915/{ =3D> display}/intel_opregion.h    |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_overlay.c |     40 +-
> >  drivers/gpu/drm/i915/display/intel_overlay.h       |     29 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_panel.c   |      4 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_panel.h   |      0
> >  .../gpu/drm/i915/{ =3D> display}/intel_pipe_crc.c    |     14 +-
> >  .../gpu/drm/i915/{ =3D> display}/intel_pipe_crc.h    |      3 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_psr.c     |     51 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_psr.h     |      0
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_quirks.c  |      1 +
> >  drivers/gpu/drm/i915/display/intel_quirks.h        |     13 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_sdvo.c    |     92 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_sdvo.h    |      0
> >  .../gpu/drm/i915/{ =3D> display}/intel_sdvo_regs.h   |     11 +
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_sprite.c  |     45 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_sprite.h  |     12 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_tv.c      |      9 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_tv.h      |      0
> >  .../gpu/drm/i915/{ =3D> display}/intel_vbt_defs.h    |    633 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/intel_vdsc.c    |      2 +
> >  drivers/gpu/drm/i915/display/intel_vdsc.h          |     21 +
> >  drivers/gpu/drm/i915/{ =3D> display}/vlv_dsi.c       |    230 +-
> >  drivers/gpu/drm/i915/{ =3D> display}/vlv_dsi_pll.c   |     18 +-
> >  drivers/gpu/drm/i915/gem/Makefile                  |      1 +
> >  drivers/gpu/drm/i915/gem/Makefile.header-test      |     16 +
> >  drivers/gpu/drm/i915/gem/i915_gem_busy.c           |    139 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_clflush.c  |     34 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_clflush.h        |     20 +
> >  drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |    304 +
> >  drivers/gpu/drm/i915/gem/i915_gem_client_blt.h     |     21 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_context.c  |   1200 +-
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_context.h  |    106 +-
> >  .../drm/i915/{ =3D> gem}/i915_gem_context_types.h    |     59 +-
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_dmabuf.c   |     42 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_domain.c         |    796 +
> >  .../gpu/drm/i915/{ =3D> gem}/i915_gem_execbuffer.c   |    359 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_fence.c          |     96 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_internal.c |     34 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_ioctls.h         |     52 +
> >  drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    508 +
> >  drivers/gpu/drm/i915/gem/i915_gem_object.c         |    398 +
> >  drivers/gpu/drm/i915/gem/i915_gem_object.h         |    430 +
> >  drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |    107 +
> >  drivers/gpu/drm/i915/gem/i915_gem_object_blt.h     |     24 +
> >  drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    262 +
> >  drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    544 +
> >  drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    212 +
> >  drivers/gpu/drm/i915/gem/i915_gem_pm.c             |    294 +
> >  drivers/gpu/drm/i915/gem/i915_gem_pm.h             |     25 +
> >  drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    571 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_shrinker.c |    181 +-
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_stolen.c   |     41 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_throttle.c       |     73 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_tiling.c   |     31 +-
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_userptr.c  |     40 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_wait.c           |    278 +
> >  drivers/gpu/drm/i915/{ =3D> gem}/i915_gemfs.c        |     22 +-
> >  drivers/gpu/drm/i915/gem/i915_gemfs.h              |     16 +
> >  .../drm/i915/{ =3D> gem}/selftests/huge_gem_object.c |     24 +-
> >  .../gpu/drm/i915/gem/selftests/huge_gem_object.h   |     27 +
> >  .../gpu/drm/i915/{ =3D> gem}/selftests/huge_pages.c  |    105 +-
> >  .../drm/i915/gem/selftests/i915_gem_client_blt.c   |    127 +
> >  .../i915/{ =3D> gem}/selftests/i915_gem_coherency.c  |     56 +-
> >  .../i915/{ =3D> gem}/selftests/i915_gem_context.c    |    379 +-
> >  .../drm/i915/{ =3D> gem}/selftests/i915_gem_dmabuf.c |     35 +-
> >  .../selftests/i915_gem_mman.c}                     |    237 +-
> >  .../gpu/drm/i915/gem/selftests/i915_gem_object.c   |     99 +
> >  .../drm/i915/gem/selftests/i915_gem_object_blt.c   |    110 +
> >  drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c |     80 +
> >  drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |     34 +
> >  drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h |     17 +
> >  .../drm/i915/{ =3D> gem}/selftests/mock_context.c    |     45 +-
> >  drivers/gpu/drm/i915/gem/selftests/mock_context.h  |     24 +
> >  .../gpu/drm/i915/{ =3D> gem}/selftests/mock_dmabuf.c |     22 +-
> >  drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h   |     22 +
> >  .../drm/i915/{ =3D> gem}/selftests/mock_gem_object.h |      7 +-
> >  drivers/gpu/drm/i915/gt/Makefile                   |      2 +
> >  drivers/gpu/drm/i915/gt/Makefile.header-test       |     16 +
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_breadcrumbs.c  |     19 +
> >  drivers/gpu/drm/i915/gt/intel_context.c            |    241 +
> >  drivers/gpu/drm/i915/gt/intel_context.h            |    134 +
> >  .../gpu/drm/i915/{ =3D> gt}/intel_context_types.h    |     29 +-
> >  .../i915/{intel_ringbuffer.h =3D> gt/intel_engine.h} |     81 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_engine_cs.c    |    521 +-
> >  drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    168 +
> >  drivers/gpu/drm/i915/gt/intel_engine_pm.h          |     22 +
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_engine_types.h |     60 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_gpu_commands.h |      1 +
> >  drivers/gpu/drm/i915/gt/intel_gt_pm.c              |    143 +
> >  drivers/gpu/drm/i915/gt/intel_gt_pm.h              |     27 +
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_hangcheck.c    |     35 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc.c          |   1376 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc.h          |     34 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc_reg.h      |      2 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_mocs.c         |     12 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_mocs.h         |      4 +-
> >  .../drm/i915/{i915_reset.c =3D> gt/intel_reset.c}    |    226 +-
> >  .../drm/i915/{i915_reset.h =3D> gt/intel_reset.h}    |      5 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_ringbuffer.c   |    474 +-
> >  drivers/gpu/drm/i915/gt/intel_sseu.c               |    159 +
> >  drivers/gpu/drm/i915/gt/intel_sseu.h               |     75 +
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_workarounds.c  |    407 +-
> >  drivers/gpu/drm/i915/{ =3D> gt}/intel_workarounds.h  |     10 +-
> >  .../drm/i915/{ =3D> gt}/intel_workarounds_types.h    |      7 +-
> >  .../gpu/drm/i915/{selftests =3D> gt}/mock_engine.c   |     67 +-
> >  .../gpu/drm/i915/{selftests =3D> gt}/mock_engine.h   |      4 +-
> >  .../intel_engine_cs.c =3D> gt/selftest_engine_cs.c}  |      0
> >  .../intel_hangcheck.c =3D> gt/selftest_hangcheck.c}  |    270 +-
> >  .../{selftests/intel_lrc.c =3D> gt/selftest_lrc.c}   |    583 +-
> >  drivers/gpu/drm/i915/gt/selftest_reset.c           |    118 +
> >  .../selftest_workarounds.c}                        |    497 +-
> >  drivers/gpu/drm/i915/gvt/aperture_gm.c             |     24 +-
> >  drivers/gpu/drm/i915/gvt/cmd_parser.c              |     27 +-
> >  drivers/gpu/drm/i915/gvt/debugfs.c                 |      4 +-
> >  drivers/gpu/drm/i915/gvt/firmware.c                |      5 +-
> >  drivers/gpu/drm/i915/gvt/gvt.h                     |     10 +-
> >  drivers/gpu/drm/i915/gvt/kvmgt.c                   |      2 +-
> >  drivers/gpu/drm/i915/gvt/mmio_context.c            |      4 +-
> >  drivers/gpu/drm/i915/gvt/opregion.c                |      2 +-
> >  drivers/gpu/drm/i915/gvt/sched_policy.c            |      4 +-
> >  drivers/gpu/drm/i915/gvt/scheduler.c               |    190 +-
> >  drivers/gpu/drm/i915/i915_active.c                 |     96 +
> >  drivers/gpu/drm/i915/i915_active.h                 |      7 +-
> >  drivers/gpu/drm/i915/i915_active_types.h           |      3 +
> >  drivers/gpu/drm/i915/i915_cmd_parser.c             |     26 +-
> >  drivers/gpu/drm/i915/i915_debugfs.c                |    555 +-
> >  drivers/gpu/drm/i915/i915_debugfs.h                |     20 +
> >  drivers/gpu/drm/i915/i915_drv.c                    |    161 +-
> >  drivers/gpu/drm/i915/i915_drv.h                    |   1033 +-
> >  drivers/gpu/drm/i915/i915_fixed.h                  |      6 +-
> >  drivers/gpu/drm/i915/i915_gem.c                    |   4284 +-
> >  drivers/gpu/drm/i915/i915_gem.h                    |      8 +-
> >  drivers/gpu/drm/i915/i915_gem_batch_pool.c         |      6 +-
> >  drivers/gpu/drm/i915/i915_gem_batch_pool.h         |      3 +-
> >  drivers/gpu/drm/i915/i915_gem_clflush.h            |     36 -
> >  drivers/gpu/drm/i915/i915_gem_evict.c              |     49 +-
> >  drivers/gpu/drm/i915/i915_gem_fence_reg.c          |    207 +-
> >  drivers/gpu/drm/i915/i915_gem_fence_reg.h          |     19 +-
> >  drivers/gpu/drm/i915/i915_gem_gtt.c                |   1014 +-
> >  drivers/gpu/drm/i915/i915_gem_gtt.h                |    167 +-
> >  drivers/gpu/drm/i915/i915_gem_object.c             |     90 -
> >  drivers/gpu/drm/i915/i915_gem_object.h             |    509 -
> >  drivers/gpu/drm/i915/i915_gem_render_state.c       |      8 +-
> >  drivers/gpu/drm/i915/i915_globals.c                |      4 +-
> >  drivers/gpu/drm/i915/i915_gpu_error.c              |    142 +-
> >  drivers/gpu/drm/i915/i915_gpu_error.h              |      7 +-
> >  drivers/gpu/drm/i915/i915_irq.c                    |    170 +-
> >  drivers/gpu/drm/i915/i915_irq.h                    |    117 +
> >  drivers/gpu/drm/i915/i915_params.c                 |      7 +-
> >  drivers/gpu/drm/i915/i915_params.h                 |      3 +-
> >  drivers/gpu/drm/i915/i915_pci.c                    |     63 +-
> >  drivers/gpu/drm/i915/i915_perf.c                   |    101 +-
> >  drivers/gpu/drm/i915/i915_pmu.c                    |     28 +-
> >  drivers/gpu/drm/i915/i915_query.c                  |     66 +-
> >  drivers/gpu/drm/i915/i915_reg.h                    |    108 +-
> >  drivers/gpu/drm/i915/i915_request.c                |    548 +-
> >  drivers/gpu/drm/i915/i915_request.h                |     19 +-
> >  drivers/gpu/drm/i915/i915_scatterlist.c            |     39 +
> >  drivers/gpu/drm/i915/i915_scatterlist.h            |    127 +
> >  drivers/gpu/drm/i915/i915_scheduler.c              |     91 +-
> >  drivers/gpu/drm/i915/i915_scheduler.h              |     18 +
> >  drivers/gpu/drm/i915/i915_scheduler_types.h        |      2 +-
> >  drivers/gpu/drm/i915/i915_suspend.c                |      6 +-
> >  drivers/gpu/drm/i915/i915_sysfs.c                  |     65 +-
> >  drivers/gpu/drm/i915/i915_timeline.c               |     14 +-
> >  drivers/gpu/drm/i915/i915_timeline.h               |     19 -
> >  drivers/gpu/drm/i915/i915_timeline_types.h         |      3 -
> >  drivers/gpu/drm/i915/i915_trace.h                  |      9 +-
> >  drivers/gpu/drm/i915/i915_utils.h                  |    187 +-
> >  drivers/gpu/drm/i915/i915_vma.c                    |    134 +-
> >  drivers/gpu/drm/i915/i915_vma.h                    |     38 +-
> >  drivers/gpu/drm/i915/intel_context.c               |    270 -
> >  drivers/gpu/drm/i915/intel_context.h               |     87 -
> >  drivers/gpu/drm/i915/intel_csr.c                   |    399 +-
> >  drivers/gpu/drm/i915/intel_csr.h                   |      4 +
> >  drivers/gpu/drm/i915/intel_device_info.c           |     78 +-
> >  drivers/gpu/drm/i915/intel_device_info.h           |     90 +-
> >  drivers/gpu/drm/i915/intel_drv.h                   |    448 +-
> >  drivers/gpu/drm/i915/intel_guc.c                   |    196 +-
> >  drivers/gpu/drm/i915/intel_guc.h                   |     20 +-
> >  drivers/gpu/drm/i915/intel_guc_ads.c               |    167 +-
> >  drivers/gpu/drm/i915/intel_guc_ads.h               |      1 +
> >  drivers/gpu/drm/i915/intel_guc_ct.c                |     16 +-
> >  drivers/gpu/drm/i915/intel_guc_ct.h                |      5 +
> >  drivers/gpu/drm/i915/intel_guc_fw.c                |    117 +-
> >  drivers/gpu/drm/i915/intel_guc_fwif.h              |    201 +-
> >  drivers/gpu/drm/i915/intel_guc_log.c               |     23 +-
> >  drivers/gpu/drm/i915/intel_guc_reg.h               |     25 +
> >  drivers/gpu/drm/i915/intel_guc_submission.c        |     62 +-
> >  drivers/gpu/drm/i915/intel_guc_submission.h        |      3 +-
> >  drivers/gpu/drm/i915/intel_huc.c                   |    102 +-
> >  drivers/gpu/drm/i915/intel_huc.h                   |     13 +-
> >  drivers/gpu/drm/i915/intel_huc_fw.c                |     73 +-
> >  drivers/gpu/drm/i915/intel_pm.c                    |    567 +-
> >  drivers/gpu/drm/i915/intel_pm.h                    |     19 +
> >  drivers/gpu/drm/i915/intel_runtime_pm.c            |   4436 +-
> >  drivers/gpu/drm/i915/intel_runtime_pm.h            |    213 +
> >  drivers/gpu/drm/i915/intel_sideband.c              |    483 +-
> >  drivers/gpu/drm/i915/intel_sideband.h              |    141 +
> >  drivers/gpu/drm/i915/intel_uc.c                    |    148 +-
> >  drivers/gpu/drm/i915/intel_uc.h                    |      3 +-
> >  drivers/gpu/drm/i915/intel_uc_fw.c                 |    126 +-
> >  drivers/gpu/drm/i915/intel_uc_fw.h                 |     10 +-
> >  drivers/gpu/drm/i915/intel_uncore.c                |     55 +-
> >  drivers/gpu/drm/i915/intel_uncore.h                |      4 +-
> >  drivers/gpu/drm/i915/intel_wakeref.c               |    138 +
> >  drivers/gpu/drm/i915/intel_wakeref.h               |    164 +
> >  drivers/gpu/drm/i915/intel_wopcm.c                 |     27 +-
> >  drivers/gpu/drm/i915/intel_wopcm.h                 |     15 +
> >  drivers/gpu/drm/i915/selftests/huge_gem_object.h   |     45 -
> >  drivers/gpu/drm/i915/selftests/i915_active.c       |     14 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem.c          |     35 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |     34 +-
> >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |     31 +-
> >  .../gpu/drm/i915/selftests/i915_live_selftests.h   |      5 +
> >  .../gpu/drm/i915/selftests/i915_mock_selftests.h   |      1 +
> >  drivers/gpu/drm/i915/selftests/i915_request.c      |     86 +-
> >  drivers/gpu/drm/i915/selftests/i915_timeline.c     |     30 +-
> >  drivers/gpu/drm/i915/selftests/i915_vma.c          |    258 +-
> >  drivers/gpu/drm/i915/selftests/igt_atomic.h        |     56 +
> >  drivers/gpu/drm/i915/selftests/igt_flush_test.c    |     38 +-
> >  drivers/gpu/drm/i915/selftests/igt_reset.c         |     11 +-
> >  drivers/gpu/drm/i915/selftests/igt_reset.h         |      1 +
> >  drivers/gpu/drm/i915/selftests/igt_spinner.c       |     20 +-
> >  drivers/gpu/drm/i915/selftests/igt_spinner.h       |     10 +-
> >  drivers/gpu/drm/i915/selftests/intel_guc.c         |     11 +-
> >  drivers/gpu/drm/i915/selftests/intel_uncore.c      |      4 +-
> >  drivers/gpu/drm/i915/selftests/lib_sw_fence.c      |      3 +
> >  drivers/gpu/drm/i915/selftests/mock_context.h      |     42 -
> >  drivers/gpu/drm/i915/selftests/mock_dmabuf.h       |     41 -
> >  drivers/gpu/drm/i915/selftests/mock_gem_device.c   |     48 +-
> >  drivers/gpu/drm/i915/selftests/mock_gtt.c          |      7 +-
> >  drivers/gpu/drm/i915/selftests/mock_gtt.h          |      4 +-
> >  drivers/gpu/drm/i915/selftests/mock_request.c      |      6 +-
> >  drivers/gpu/drm/i915/selftests/mock_timeline.c     |      1 -
> >  drivers/gpu/drm/i915/selftests/scatterlist.c       |      3 +-
> >  drivers/gpu/drm/imx/ipuv3-plane.c                  |     16 +-
> >  drivers/gpu/drm/ingenic/Kconfig                    |     16 +
> >  drivers/gpu/drm/ingenic/Makefile                   |      1 +
> >  drivers/gpu/drm/ingenic/ingenic-drm.c              |    818 +
> >  drivers/gpu/drm/lima/lima_drv.c                    |      2 +-
> >  drivers/gpu/drm/lima/lima_pp.c                     |      8 +-
> >  drivers/gpu/drm/lima/lima_sched.c                  |     13 +-
> >  drivers/gpu/drm/mcde/Kconfig                       |     18 +
> >  drivers/gpu/drm/mcde/Makefile                      |      3 +
> >  drivers/gpu/drm/mcde/mcde_display.c                |   1142 +
> >  drivers/gpu/drm/mcde/mcde_display_regs.h           |    518 +
> >  drivers/gpu/drm/mcde/mcde_drm.h                    |     44 +
> >  drivers/gpu/drm/mcde/mcde_drv.c                    |    572 +
> >  drivers/gpu/drm/mcde/mcde_dsi.c                    |   1044 +
> >  drivers/gpu/drm/mcde/mcde_dsi_regs.h               |    385 +
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |     30 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |      8 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_fb.c              |      8 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c             |      7 +-
> >  drivers/gpu/drm/mediatek/mtk_dsi.c                 |     12 +-
> >  drivers/gpu/drm/mediatek/mtk_hdmi.c                |      3 +
> >  drivers/gpu/drm/meson/Kconfig                      |      1 +
> >  drivers/gpu/drm/meson/meson_crtc.c                 |      6 +-
> >  drivers/gpu/drm/meson/meson_overlay.c              |     17 +-
> >  drivers/gpu/drm/meson/meson_plane.c                |     27 +-
> >  drivers/gpu/drm/meson/meson_vclk.c                 |     13 +-
> >  drivers/gpu/drm/meson/meson_viu.c                  |      3 +-
> >  drivers/gpu/drm/mgag200/Kconfig                    |      2 +-
> >  drivers/gpu/drm/mgag200/mgag200_cursor.c           |    183 +-
> >  drivers/gpu/drm/mgag200/mgag200_drv.c              |     13 +-
> >  drivers/gpu/drm/mgag200/mgag200_drv.h              |     75 +-
> >  drivers/gpu/drm/mgag200/mgag200_fb.c               |     59 +-
> >  drivers/gpu/drm/mgag200/mgag200_main.c             |     91 +-
> >  drivers/gpu/drm/mgag200/mgag200_mode.c             |     59 +-
> >  drivers/gpu/drm/mgag200/mgag200_ttm.c              |    301 +-
> >  drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |     24 +-
> >  drivers/gpu/drm/msm/adreno/a5xx.xml.h              |     28 +-
> >  drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |      8 +-
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |     40 +-
> >  drivers/gpu/drm/msm/adreno/a5xx_power.c            |     76 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |     70 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |      1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |     16 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |      2 +-
> >  drivers/gpu/drm/msm/adreno/adreno_device.c         |     20 +-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c            |      8 +-
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |      6 +
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |    176 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h      |      4 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |     20 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |      5 -
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |    119 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c        |      6 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |     46 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |      6 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |     57 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |     15 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |     22 +-
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |      4 -
> >  drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |      3 +
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |      2 +-
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |     31 +-
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |     38 +
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |     27 +-
> >  drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |      7 +-
> >  drivers/gpu/drm/msm/dsi/dsi.c                      |      2 +
> >  drivers/gpu/drm/msm/dsi/dsi.h                      |      7 +-
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |     21 +
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |      1 +
> >  drivers/gpu/drm/msm/dsi/dsi_host.c                 |     19 +-
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c              |    149 +-
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |      6 +-
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |      5 +
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |     30 +-
> >  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |    106 +-
> >  drivers/gpu/drm/msm/msm_drv.c                      |     34 +-
> >  drivers/gpu/drm/msm/msm_drv.h                      |      1 +
> >  drivers/gpu/drm/msm/msm_fb.c                       |     20 +-
> >  drivers/gpu/drm/msm/msm_gem.c                      |      6 +-
> >  drivers/gpu/drm/msm/msm_gem.h                      |      1 +
> >  drivers/gpu/drm/msm/msm_gem_submit.c               |     13 +-
> >  drivers/gpu/drm/msm/msm_gpu.c                      |      5 +-
> >  drivers/gpu/drm/msm/msm_iommu.c                    |      2 +-
> >  drivers/gpu/drm/msm/msm_perf.c                     |     15 +-
> >  drivers/gpu/drm/msm/msm_rd.c                       |     16 +-
> >  drivers/gpu/drm/nouveau/dispnv50/disp.c            |      5 +-
> >  drivers/gpu/drm/nouveau/dispnv50/head.c            |     13 +-
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c     |      2 -
> >  drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |     18 +-
> >  drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |      1 +
> >  drivers/gpu/drm/omapdrm/omap_crtc.c                |    180 +-
> >  drivers/gpu/drm/omapdrm/omap_crtc.h                |      2 +
> >  drivers/gpu/drm/omapdrm/omap_drv.c                 |     16 +-
> >  drivers/gpu/drm/omapdrm/omap_drv.h                 |      4 +-
> >  drivers/gpu/drm/omapdrm/omap_fb.c                  |     25 +-
> >  drivers/gpu/drm/omapdrm/omap_irq.c                 |     25 +
> >  drivers/gpu/drm/omapdrm/omap_irq.h                 |      1 +
> >  drivers/gpu/drm/panel/Kconfig                      |     18 +
> >  drivers/gpu/drm/panel/Makefile                     |      2 +
> >  drivers/gpu/drm/panel/panel-arm-versatile.c        |      6 +-
> >  drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |      9 +-
> >  drivers/gpu/drm/panel/panel-innolux-p079zca.c      |     10 +-
> >  drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |      8 +-
> >  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |      9 +-
> >  drivers/gpu/drm/panel/panel-lg-lg4573.c            |      9 +-
> >  drivers/gpu/drm/panel/panel-lvds.c                 |      7 +-
> >  drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |      8 +-
> >  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |     11 +-
> >  drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |    254 +
> >  .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |      7 +-
> >  .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |      3 +-
> >  drivers/gpu/drm/panel/panel-raydium-rm68200.c      |      5 +-
> >  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |     14 +-
> >  drivers/gpu/drm/panel/panel-samsung-ld9040.c       |     10 +-
> >  drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |     10 +-
> >  drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |     11 +-
> >  drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    514 +
> >  drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |     12 +-
> >  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |     10 +-
> >  drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |      7 +-
> >  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |      7 +-
> >  drivers/gpu/drm/panel/panel-simple.c               |    276 +-
> >  drivers/gpu/drm/panel/panel-sitronix-st7701.c      |      6 +-
> >  drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |     10 +-
> >  drivers/gpu/drm/panel/panel-truly-nt35597.c        |     13 +-
> >  drivers/gpu/drm/panfrost/Kconfig                   |      1 +
> >  drivers/gpu/drm/panfrost/Makefile                  |      3 +-
> >  drivers/gpu/drm/panfrost/panfrost_devfreq.c        |     13 +-
> >  drivers/gpu/drm/panfrost/panfrost_device.c         |     30 +
> >  drivers/gpu/drm/panfrost/panfrost_device.h         |     11 +
> >  drivers/gpu/drm/panfrost/panfrost_drv.c            |     15 +
> >  drivers/gpu/drm/panfrost/panfrost_gem.c            |      8 +-
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c            |     10 +-
> >  drivers/gpu/drm/panfrost/panfrost_job.c            |      2 +-
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |    329 +
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h        |     18 +
> >  drivers/gpu/drm/panfrost/panfrost_regs.h           |     22 +
> >  drivers/gpu/drm/qxl/qxl_release.c                  |      2 +-
> >  drivers/gpu/drm/r128/r128_cce.c                    |     28 +-
> >  drivers/gpu/drm/r128/r128_drv.c                    |      9 +-
> >  drivers/gpu/drm/r128/r128_drv.h                    |     16 +-
> >  drivers/gpu/drm/r128/r128_state.c                  |     25 +-
> >  drivers/gpu/drm/radeon/atom.c                      |      2 +
> >  drivers/gpu/drm/radeon/atom.h                      |      1 -
> >  drivers/gpu/drm/radeon/atombios_crtc.c             |      7 +-
> >  drivers/gpu/drm/radeon/atombios_dp.c               |      2 +-
> >  drivers/gpu/drm/radeon/atombios_encoders.c         |     14 +-
> >  drivers/gpu/drm/radeon/atombios_i2c.c              |      2 +-
> >  drivers/gpu/drm/radeon/btc_dpm.c                   |     16 +-
> >  drivers/gpu/drm/radeon/btc_dpm.h                   |      3 +
> >  drivers/gpu/drm/radeon/ci_dpm.c                    |     14 +-
> >  drivers/gpu/drm/radeon/ci_dpm.h                    |      1 +
> >  drivers/gpu/drm/radeon/ci_smc.c                    |      2 +-
> >  drivers/gpu/drm/radeon/cik.c                       |     18 +-
> >  drivers/gpu/drm/radeon/cik_sdma.c                  |      6 +-
> >  drivers/gpu/drm/radeon/clearstate_cayman.h         |      2 +
> >  drivers/gpu/drm/radeon/clearstate_ci.h             |      2 +
> >  drivers/gpu/drm/radeon/clearstate_si.h             |      2 +
> >  drivers/gpu/drm/radeon/cypress_dpm.c               |     11 +-
> >  drivers/gpu/drm/radeon/dce3_1_afmt.c               |      2 +-
> >  drivers/gpu/drm/radeon/dce6_afmt.c                 |      2 +-
> >  drivers/gpu/drm/radeon/evergreen.c                 |     16 +-
> >  drivers/gpu/drm/radeon/evergreen_cs.c              |      2 +-
> >  drivers/gpu/drm/radeon/evergreen_dma.c             |      2 +-
> >  drivers/gpu/drm/radeon/evergreen_hdmi.c            |      2 +-
> >  drivers/gpu/drm/radeon/kv_dpm.c                    |     10 +-
> >  drivers/gpu/drm/radeon/kv_smc.c                    |      1 -
> >  drivers/gpu/drm/radeon/ni.c                        |     17 +-
> >  drivers/gpu/drm/radeon/ni_dma.c                    |      2 +-
> >  drivers/gpu/drm/radeon/ni_dpm.c                    |     16 +-
> >  drivers/gpu/drm/radeon/r100.c                      |     36 +-
> >  drivers/gpu/drm/radeon/r100_track.h                |      2 +
> >  drivers/gpu/drm/radeon/r200.c                      |      2 +-
> >  drivers/gpu/drm/radeon/r300.c                      |     18 +-
> >  drivers/gpu/drm/radeon/r420.c                      |     16 +-
> >  drivers/gpu/drm/radeon/r520.c                      |      4 +-
> >  drivers/gpu/drm/radeon/r600.c                      |     18 +-
> >  drivers/gpu/drm/radeon/r600_cs.c                   |      2 +-
> >  drivers/gpu/drm/radeon/r600_dma.c                  |      6 +-
> >  drivers/gpu/drm/radeon/r600_dpm.c                  |      1 -
> >  drivers/gpu/drm/radeon/r600_dpm.h                  |      2 +
> >  drivers/gpu/drm/radeon/r600_hdmi.c                 |      2 +-
> >  drivers/gpu/drm/radeon/radeon_acpi.c               |     13 +-
> >  drivers/gpu/drm/radeon/radeon_agp.c                |      8 +-
> >  drivers/gpu/drm/radeon/radeon_asic.c               |     10 +-
> >  drivers/gpu/drm/radeon/radeon_atombios.c           |      5 +-
> >  drivers/gpu/drm/radeon/radeon_audio.c              |      2 +-
> >  drivers/gpu/drm/radeon/radeon_benchmark.c          |      2 +-
> >  drivers/gpu/drm/radeon/radeon_bios.c               |     12 +-
> >  drivers/gpu/drm/radeon/radeon_clocks.c             |      9 +-
> >  drivers/gpu/drm/radeon/radeon_combios.c            |      5 +-
> >  drivers/gpu/drm/radeon/radeon_connectors.c         |      2 +-
> >  drivers/gpu/drm/radeon/radeon_cs.c                 |     10 +-
> >  drivers/gpu/drm/radeon/radeon_cursor.c             |      4 +-
> >  drivers/gpu/drm/radeon/radeon_device.c             |     18 +-
> >  drivers/gpu/drm/radeon/radeon_display.c            |     21 +-
> >  drivers/gpu/drm/radeon/radeon_dp_auxch.c           |      2 +-
> >  drivers/gpu/drm/radeon/radeon_dp_mst.c             |      5 +-
> >  drivers/gpu/drm/radeon/radeon_drv.c                |     19 +-
> >  drivers/gpu/drm/radeon/radeon_encoders.c           |      5 +-
> >  drivers/gpu/drm/radeon/radeon_fb.c                 |     17 +-
> >  drivers/gpu/drm/radeon/radeon_fence.c              |     16 +-
> >  drivers/gpu/drm/radeon/radeon_gart.c               |      5 +-
> >  drivers/gpu/drm/radeon/radeon_gem.c                |      9 +-
> >  drivers/gpu/drm/radeon/radeon_i2c.c                |      5 +-
> >  drivers/gpu/drm/radeon/radeon_ib.c                 |      5 +-
> >  drivers/gpu/drm/radeon/radeon_irq_kms.c            |     14 +-
> >  drivers/gpu/drm/radeon/radeon_kms.c                |     17 +-
> >  drivers/gpu/drm/radeon/radeon_legacy_crtc.c        |      9 +-
> >  drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |     11 +-
> >  drivers/gpu/drm/radeon/radeon_legacy_tv.c          |      4 +-
> >  drivers/gpu/drm/radeon/radeon_mn.c                 |      2 +-
> >  drivers/gpu/drm/radeon/radeon_object.c             |     11 +-
> >  drivers/gpu/drm/radeon/radeon_pm.c                 |     17 +-
> >  drivers/gpu/drm/radeon/radeon_prime.c              |      8 +-
> >  drivers/gpu/drm/radeon/radeon_ring.c               |      6 +-
> >  drivers/gpu/drm/radeon/radeon_sa.c                 |      2 +-
> >  drivers/gpu/drm/radeon/radeon_semaphore.c          |      2 +-
> >  drivers/gpu/drm/radeon/radeon_sync.c               |      1 -
> >  drivers/gpu/drm/radeon/radeon_test.c               |      2 +-
> >  drivers/gpu/drm/radeon/radeon_trace.h              |      4 +-
> >  drivers/gpu/drm/radeon/radeon_trace_points.c       |      2 +-
> >  drivers/gpu/drm/radeon/radeon_ttm.c                |     47 +-
> >  drivers/gpu/drm/radeon/radeon_ucode.c              |      2 +-
> >  drivers/gpu/drm/radeon/radeon_uvd.c                |      2 +-
> >  drivers/gpu/drm/radeon/radeon_vce.c                |      4 +-
> >  drivers/gpu/drm/radeon/radeon_vm.c                 |      2 +-
> >  drivers/gpu/drm/radeon/rs400.c                     |     11 +-
> >  drivers/gpu/drm/radeon/rs600.c                     |     13 +-
> >  drivers/gpu/drm/radeon/rs690.c                     |      6 +-
> >  drivers/gpu/drm/radeon/rs780_dpm.c                 |     12 +-
> >  drivers/gpu/drm/radeon/rv515.c                     |     13 +-
> >  drivers/gpu/drm/radeon/rv6xx_dpm.c                 |      1 -
> >  drivers/gpu/drm/radeon/rv730_dpm.c                 |      1 -
> >  drivers/gpu/drm/radeon/rv740_dpm.c                 |      1 -
> >  drivers/gpu/drm/radeon/rv770.c                     |     12 +-
> >  drivers/gpu/drm/radeon/rv770_dma.c                 |      2 +-
> >  drivers/gpu/drm/radeon/rv770_dpm.c                 |      1 -
> >  drivers/gpu/drm/radeon/rv770_dpm.h                 |      1 +
> >  drivers/gpu/drm/radeon/rv770_smc.c                 |      2 +-
> >  drivers/gpu/drm/radeon/si.c                        |     16 +-
> >  drivers/gpu/drm/radeon/si_dma.c                    |      2 +-
> >  drivers/gpu/drm/radeon/si_dpm.c                    |     14 +-
> >  drivers/gpu/drm/radeon/si_smc.c                    |      2 +-
> >  drivers/gpu/drm/radeon/sumo_dpm.c                  |      1 -
> >  drivers/gpu/drm/radeon/sumo_dpm.h                  |      1 +
> >  drivers/gpu/drm/radeon/sumo_smc.c                  |      1 -
> >  drivers/gpu/drm/radeon/trinity_dpm.c               |     10 +-
> >  drivers/gpu/drm/radeon/trinity_smc.c               |      1 -
> >  drivers/gpu/drm/radeon/uvd_v1_0.c                  |      4 +-
> >  drivers/gpu/drm/radeon/uvd_v2_2.c                  |      2 +-
> >  drivers/gpu/drm/radeon/uvd_v3_1.c                  |      1 -
> >  drivers/gpu/drm/radeon/uvd_v4_2.c                  |      2 +-
> >  drivers/gpu/drm/radeon/vce_v1_0.c                  |      2 +-
> >  drivers/gpu/drm/radeon/vce_v2_0.c                  |      2 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c              |     30 +
> >  drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |     12 +
> >  drivers/gpu/drm/rcar-du/rcar_du_kms.c              |     82 +-
> >  drivers/gpu/drm/rcar-du/rcar_du_writeback.c        |      1 +
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c                |    135 +-
> >  drivers/gpu/drm/rcar-du/rcar_lvds.h                |      5 +
> >  drivers/gpu/drm/rockchip/cdn-dp-reg.c              |      4 +-
> >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |     67 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |     30 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |     42 +-
> >  drivers/gpu/drm/savage/savage_bci.c                |     25 +-
> >  drivers/gpu/drm/savage/savage_drv.c                |      9 +-
> >  drivers/gpu/drm/savage/savage_drv.h                |     10 +-
> >  drivers/gpu/drm/savage/savage_state.c              |      9 +-
> >  drivers/gpu/drm/scheduler/sched_main.c             |    179 +-
> >  drivers/gpu/drm/selftests/Makefile                 |      2 +-
> >  drivers/gpu/drm/selftests/drm_cmdline_selftests.h  |     55 +
> >  .../gpu/drm/selftests/test-drm_cmdline_parser.c    |    918 +
> >  drivers/gpu/drm/sis/sis_drv.c                      |      8 +-
> >  drivers/gpu/drm/sis/sis_drv.h                      |     10 +-
> >  drivers/gpu/drm/sis/sis_mm.c                       |      7 +-
> >  drivers/gpu/drm/sti/sti_awg_utils.c                |      2 +
> >  drivers/gpu/drm/sti/sti_awg_utils.h                |      2 +-
> >  drivers/gpu/drm/sti/sti_compositor.c               |      5 +-
> >  drivers/gpu/drm/sti/sti_crtc.c                     |      4 +-
> >  drivers/gpu/drm/sti/sti_crtc.h                     |      6 +-
> >  drivers/gpu/drm/sti/sti_cursor.c                   |      2 +
> >  drivers/gpu/drm/sti/sti_cursor.h                   |      3 +
> >  drivers/gpu/drm/sti/sti_drv.c                      |     21 +-
> >  drivers/gpu/drm/sti/sti_drv.h                      |      5 +-
> >  drivers/gpu/drm/sti/sti_dvo.c                      |      3 +-
> >  drivers/gpu/drm/sti/sti_gdp.c                      |      4 +
> >  drivers/gpu/drm/sti/sti_gdp.h                      |      5 +
> >  drivers/gpu/drm/sti/sti_hda.c                      |      6 +-
> >  drivers/gpu/drm/sti/sti_hdmi.c                     |      5 +-
> >  drivers/gpu/drm/sti/sti_hdmi.h                     |      4 +-
> >  drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c         |      2 +
> >  drivers/gpu/drm/sti/sti_hqvdp.c                    |      8 +-
> >  drivers/gpu/drm/sti/sti_mixer.c                    |      4 +
> >  drivers/gpu/drm/sti/sti_mixer.h                    |      7 +-
> >  drivers/gpu/drm/sti/sti_plane.c                    |      4 +-
> >  drivers/gpu/drm/sti/sti_plane.h                    |      1 -
> >  drivers/gpu/drm/sti/sti_tvout.c                    |      6 +-
> >  drivers/gpu/drm/sti/sti_vid.c                      |      4 +-
> >  drivers/gpu/drm/sti/sti_vtg.c                      |      4 +-
> >  drivers/gpu/drm/sti/sti_vtg.h                      |      1 +
> >  drivers/gpu/drm/stm/drv.c                          |     44 +-
> >  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    105 +-
> >  drivers/gpu/drm/stm/ltdc.c                         |    142 +-
> >  drivers/gpu/drm/sun4i/sun4i_drv.c                  |     16 +-
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |      1 +
> >  drivers/gpu/drm/tegra/dc.c                         |     17 +-
> >  drivers/gpu/drm/tegra/dpaux.c                      |     13 +-
> >  drivers/gpu/drm/tegra/drm.h                        |      3 +-
> >  drivers/gpu/drm/tegra/fb.c                         |     14 +-
> >  drivers/gpu/drm/tegra/output.c                     |     52 +-
> >  drivers/gpu/drm/ttm/ttm_bo.c                       |    271 +-
> >  drivers/gpu/drm/ttm/ttm_bo_util.c                  |      4 +-
> >  drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    169 +-
> >  drivers/gpu/drm/ttm/ttm_execbuf_util.c             |     20 +-
> >  drivers/gpu/drm/v3d/v3d_debugfs.c                  |     35 +-
> >  drivers/gpu/drm/v3d/v3d_drv.c                      |     17 +-
> >  drivers/gpu/drm/v3d/v3d_drv.h                      |    106 +-
> >  drivers/gpu/drm/v3d/v3d_fence.c                    |      2 +
> >  drivers/gpu/drm/v3d/v3d_gem.c                      |    552 +-
> >  drivers/gpu/drm/v3d/v3d_irq.c                      |     55 +-
> >  drivers/gpu/drm/v3d/v3d_mmu.c                      |      7 +-
> >  drivers/gpu/drm/v3d/v3d_regs.h                     |    122 +-
> >  drivers/gpu/drm/v3d/v3d_sched.c                    |    382 +-
> >  drivers/gpu/drm/v3d/v3d_trace.h                    |     94 +
> >  drivers/gpu/drm/vboxvideo/Kconfig                  |      2 +-
> >  drivers/gpu/drm/vboxvideo/vbox_drv.c               |     12 +-
> >  drivers/gpu/drm/vboxvideo/vbox_drv.h               |     75 +-
> >  drivers/gpu/drm/vboxvideo/vbox_fb.c                |     22 +-
> >  drivers/gpu/drm/vboxvideo/vbox_main.c              |     75 +-
> >  drivers/gpu/drm/vboxvideo/vbox_mode.c              |     36 +-
> >  drivers/gpu/drm/vboxvideo/vbox_ttm.c               |    355 +-
> >  drivers/gpu/drm/vc4/vc4_bo.c                       |     31 +-
> >  drivers/gpu/drm/vc4/vc4_debugfs.c                  |      8 +-
> >  drivers/gpu/drm/vc4/vc4_drv.c                      |      6 +
> >  drivers/gpu/drm/vc4/vc4_drv.h                      |     14 +
> >  drivers/gpu/drm/vc4/vc4_gem.c                      |     11 +
> >  drivers/gpu/drm/vc4/vc4_hdmi.c                     |      8 +-
> >  drivers/gpu/drm/vc4/vc4_irq.c                      |     20 +-
> >  drivers/gpu/drm/vc4/vc4_plane.c                    |     15 +-
> >  drivers/gpu/drm/vc4/vc4_txp.c                      |      7 +-
> >  drivers/gpu/drm/vc4/vc4_v3d.c                      |     72 +-
> >  drivers/gpu/drm/virtio/Makefile                    |      4 +-
> >  drivers/gpu/drm/virtio/virtgpu_display.c           |     20 +-
> >  drivers/gpu/drm/virtio/virtgpu_drv.h               |     10 +-
> >  drivers/gpu/drm/virtio/virtgpu_fb.c                |    150 -
> >  drivers/gpu/drm/virtio/virtgpu_fence.c             |     25 +-
> >  drivers/gpu/drm/virtio/virtgpu_ioctl.c             |     38 +-
> >  drivers/gpu/drm/virtio/virtgpu_trace.h             |     52 +
> >  drivers/gpu/drm/virtio/virtgpu_trace_points.c      |      5 +
> >  drivers/gpu/drm/virtio/virtgpu_vq.c                |     36 +-
> >  drivers/gpu/drm/vkms/vkms_crc.c                    |      9 +
> >  drivers/gpu/drm/vkms/vkms_crtc.c                   |     56 +-
> >  drivers/gpu/drm/vkms/vkms_drv.h                    |     10 +-
> >  drivers/gpu/drm/vkms/vkms_output.c                 |     10 -
> >  drivers/gpu/drm/vkms/vkms_plane.c                  |      8 +
> >  drivers/gpu/drm/vmwgfx/Kconfig                     |      1 +
> >  drivers/gpu/drm/vmwgfx/Makefile                    |      2 +-
> >  .../drm/vmwgfx/device_include/svga3d_surfacedefs.h |    233 +-
> >  drivers/gpu/drm/vmwgfx/ttm_lock.c                  |    100 -
> >  drivers/gpu/drm/vmwgfx/ttm_lock.h                  |     30 -
> >  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |     12 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |      4 +
> >  drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |     13 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    167 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    139 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |      1 -
> >  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |     23 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |    472 +
> >  drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    248 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h      |     15 +
> >  drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |      8 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    405 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |     74 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |     18 +-
> >  drivers/gpu/drm/zte/zx_plane.c                     |      6 +-
> >  drivers/gpu/host1x/bus.c                           |     35 +-
> >  drivers/gpu/host1x/debug.c                         |      3 -
> >  drivers/gpu/host1x/dev.c                           |      5 +-
> >  drivers/gpu/ipu-v3/Makefile                        |      4 +-
> >  drivers/gpu/ipu-v3/ipu-ic-csc.c                    |    409 +
> >  drivers/gpu/ipu-v3/ipu-ic.c                        |    138 +-
> >  drivers/gpu/ipu-v3/ipu-image-convert.c             |     37 +-
> >  drivers/gpu/vga/vga_switcheroo.c                   |     34 +-
> >  drivers/hid/hid-a4tech.c                           |     11 +-
> >  drivers/hid/hid-core.c                             |     16 +-
> >  drivers/hid/hid-hyperv.c                           |      2 +
> >  drivers/hid/hid-ids.h                              |      1 +
> >  drivers/hid/hid-logitech-dj.c                      |     50 +-
> >  drivers/hid/hid-logitech-hidpp.c                   |      9 +
> >  drivers/hid/hid-multitouch.c                       |      7 +
> >  drivers/hid/hid-rmi.c                              |     15 +-
> >  drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |      8 +
> >  drivers/hid/wacom_wac.c                            |     71 +-
> >  drivers/i2c/busses/i2c-acorn.c                     |      1 +
> >  drivers/i2c/busses/i2c-pca-platform.c              |      3 +-
> >  drivers/iommu/arm-smmu.c                           |     15 +-
> >  drivers/iommu/intel-iommu.c                        |      7 +-
> >  drivers/iommu/intel-pasid.c                        |      2 +-
> >  drivers/iommu/iommu.c                              |      2 +-
> >  drivers/md/bcache/bset.c                           |     16 +-
> >  drivers/md/bcache/bset.h                           |     34 +-
> >  drivers/md/bcache/sysfs.c                          |      7 +-
> >  drivers/media/dvb-core/dvb_frontend.c              |      2 +-
> >  drivers/media/platform/qcom/venus/hfi_helper.h     |      4 +-
> >  drivers/misc/mei/hdcp/mei_hdcp.c                   |      2 +-
> >  drivers/nvdimm/pmem.c                              |     17 +-
> >  drivers/pci/p2pdma.c                               |    115 +-
> >  drivers/platform/mellanox/mlxreg-hotplug.c         |      1 +
> >  drivers/platform/x86/asus-nb-wmi.c                 |      8 +
> >  drivers/platform/x86/asus-wmi.c                    |      2 +-
> >  drivers/platform/x86/asus-wmi.h                    |      1 +
> >  drivers/platform/x86/intel-vbtn.c                  |     16 +-
> >  drivers/platform/x86/mlx-platform.c                |      2 +-
> >  drivers/ras/cec.c                                  |     80 +-
> >  drivers/regulator/tps6507x-regulator.c             |      6 +-
> >  drivers/scsi/hpsa.c                                |      7 +-
> >  drivers/scsi/hpsa_cmd.h                            |      1 +
> >  drivers/spi/spi-bitbang.c                          |      2 +-
> >  drivers/spi/spi-fsl-spi.c                          |      2 +-
> >  drivers/spi/spi.c                                  |     11 +-
> >  drivers/staging/media/imx/imx-ic-prp.c             |      6 +-
> >  drivers/staging/media/imx/imx-ic-prpencvf.c        |     42 +-
> >  drivers/staging/media/imx/imx-media-csi.c          |     19 +-
> >  drivers/staging/media/imx/imx-media-utils.c        |     73 +-
> >  drivers/staging/media/imx/imx-media-vdic.c         |      5 +-
> >  drivers/staging/media/imx/imx-media.h              |      5 +-
> >  drivers/staging/media/imx/imx7-media-csi.c         |      8 +-
> >  drivers/usb/core/quirks.c                          |      3 +
> >  drivers/usb/dwc2/gadget.c                          |     24 +-
> >  drivers/usb/dwc2/hcd.c                             |     39 +-
> >  drivers/usb/dwc2/hcd.h                             |     20 +-
> >  drivers/usb/dwc2/hcd_intr.c                        |      5 +-
> >  drivers/usb/dwc2/hcd_queue.c                       |     10 +-
> >  drivers/usb/gadget/udc/fusb300_udc.c               |      5 +
> >  drivers/usb/gadget/udc/lpc32xx_udc.c               |      7 +-
> >  drivers/usb/phy/phy-mxs-usb.c                      |     14 +
> >  drivers/usb/serial/option.c                        |      6 +
> >  drivers/usb/serial/pl2303.c                        |      1 +
> >  drivers/usb/serial/pl2303.h                        |      3 +
> >  drivers/usb/storage/unusual_realtek.h              |      5 +
> >  drivers/usb/typec/bus.c                            |      2 +-
> >  drivers/usb/typec/ucsi/ucsi_ccg.c                  |      6 +-
> >  drivers/vfio/mdev/mdev_core.c                      |    136 +-
> >  drivers/vfio/mdev/mdev_private.h                   |      4 +-
> >  drivers/vfio/mdev/mdev_sysfs.c                     |      6 +-
> >  drivers/video/hdmi.c                               |    275 +-
> >  drivers/xen/swiotlb-xen.c                          |     12 +-
> >  fs/btrfs/extent-tree.c                             |     28 +-
> >  fs/gfs2/bmap.c                                     |      5 +-
> >  fs/io_uring.c                                      |      4 +-
> >  fs/ocfs2/dcache.c                                  |     12 +
> >  include/drm/amd_asic_type.h                        |      1 +
> >  include/drm/bridge/dw_hdmi.h                       |      2 +
> >  include/drm/bridge/dw_mipi_dsi.h                   |     10 +
> >  include/drm/drm_atomic.h                           |     22 +
> >  include/drm/drm_atomic_helper.h                    |      4 -
> >  include/drm/drm_atomic_state_helper.h              |      3 +
> >  include/drm/drm_auth.h                             |     11 +-
> >  include/drm/drm_bridge.h                           |    114 +
> >  include/drm/drm_client.h                           |     46 +
> >  include/drm/drm_connector.h                        |    189 +-
> >  include/drm/drm_crtc.h                             |     20 +
> >  include/drm/drm_debugfs.h                          |      2 +
> >  include/drm/drm_device.h                           |      4 +
> >  include/drm/drm_displayid.h                        |     10 +
> >  include/drm/drm_dp_helper.h                        |     49 +-
> >  include/drm/drm_edid.h                             |     38 +-
> >  include/drm/drm_fb_helper.h                        |    102 +-
> >  include/drm/drm_fourcc.h                           |     50 +-
> >  include/drm/drm_framebuffer.h                      |      3 +
> >  include/drm/drm_gem.h                              |      5 -
> >  include/drm/drm_gem_vram_helper.h                  |    153 +
> >  include/drm/drm_hdcp.h                             |     31 +-
> >  include/drm/drm_legacy.h                           |     12 +-
> >  include/drm/drm_mode_config.h                      |     13 +
> >  include/drm/drm_modeset_helper_vtables.h           |     61 +-
> >  include/drm/drm_plane.h                            |      2 +-
> >  include/drm/drm_print.h                            |      2 +
> >  include/drm/drm_self_refresh_helper.h              |     20 +
> >  include/drm/drm_vram_mm_helper.h                   |    102 +
> >  include/drm/gpu_scheduler.h                        |      8 +-
> >  include/drm/i915_pciids.h                          |      4 +-
> >  include/drm/ttm/ttm_bo_api.h                       |     10 +
> >  include/drm/ttm/ttm_bo_driver.h                    |     15 +-
> >  include/drm/ttm/ttm_execbuf_util.h                 |      3 +-
> >  include/linux/cgroup-defs.h                        |      4 +-
> >  include/linux/cgroup.h                             |     14 +-
> >  include/linux/cpuhotplug.h                         |      1 +
> >  include/linux/device.h                             |      1 +
> >  include/linux/dma-buf.h                            |     52 +-
> >  include/linux/genalloc.h                           |     55 +-
> >  include/linux/hdmi.h                               |     67 +
> >  include/linux/host1x.h                             |      2 +
> >  include/linux/memcontrol.h                         |     26 +-
> >  include/linux/memremap.h                           |      8 +
> >  include/linux/mm.h                                 |     19 +-
> >  include/linux/reservation.h                        |      8 +-
> >  include/linux/sched/mm.h                           |      4 +
> >  include/sound/sof/dai.h                            |      1 +
> >  include/sound/sof/header.h                         |     23 +
> >  include/sound/sof/info.h                           |     20 +-
> >  include/sound/sof/xtensa.h                         |      9 +-
> >  include/uapi/drm/amdgpu_drm.h                      |      4 +
> >  include/uapi/drm/drm.h                             |      1 +
> >  include/uapi/drm/drm_mode.h                        |    117 +
> >  include/uapi/drm/i915_drm.h                        |    209 +-
> >  include/uapi/drm/panfrost_drm.h                    |     24 +
> >  include/uapi/drm/v3d_drm.h                         |     28 +
> >  include/uapi/drm/vmwgfx_drm.h                      |      4 +-
> >  include/uapi/linux/dma-buf.h                       |      3 +
> >  include/uapi/linux/kfd_ioctl.h                     |     35 +-
> >  include/uapi/linux/magic.h                         |      1 +
> >  include/uapi/sound/sof/abi.h                       |      2 +-
> >  include/video/imx-ipu-v3.h                         |     56 +-
> >  kernel/cgroup/cgroup.c                             |    139 +-
> >  kernel/cgroup/cpuset.c                             |     15 +-
> >  kernel/cred.c                                      |      9 +
> >  kernel/exit.c                                      |      2 +-
> >  kernel/livepatch/core.c                            |      6 +
> >  kernel/memremap.c                                  |     23 +-
> >  kernel/ptrace.c                                    |     20 +-
> >  kernel/time/timekeeping.c                          |      5 +-
> >  kernel/trace/ftrace.c                              |     22 +-
> >  kernel/trace/trace.c                               |      4 +-
> >  kernel/trace/trace_output.c                        |      2 +-
> >  kernel/trace/trace_uprobe.c                        |     15 +-
> >  lib/genalloc.c                                     |     51 +-
> >  mm/Kconfig                                         |      3 +
> >  mm/Makefile                                        |      1 +
> >  mm/as_dirty_helpers.c                              |    298 +
> >  mm/hmm.c                                           |     14 +-
> >  mm/khugepaged.c                                    |      3 +
> >  mm/list_lru.c                                      |      2 +-
> >  mm/memcontrol.c                                    |     41 +-
> >  mm/memory.c                                        |    145 +-
> >  mm/mlock.c                                         |      7 +-
> >  mm/mmu_gather.c                                    |     24 +-
> >  mm/vmalloc.c                                       |     14 +-
> >  mm/vmscan.c                                        |      6 +-
> >  scripts/decode_stacktrace.sh                       |      2 +-
> >  security/selinux/avc.c                             |     10 +-
> >  security/selinux/hooks.c                           |     39 +-
> >  security/smack/smack_lsm.c                         |     12 +-
> >  sound/firewire/motu/motu-stream.c                  |      2 +-
> >  sound/firewire/oxfw/oxfw.c                         |      3 -
> >  sound/hda/ext/hdac_ext_bus.c                       |      1 -
> >  sound/pci/hda/hda_codec.c                          |      9 +-
> >  sound/pci/hda/patch_realtek.c                      |     91 +-
> >  sound/pci/ice1712/ews.c                            |      2 +-
> >  sound/soc/codecs/ak4458.c                          |     18 +-
> >  sound/soc/codecs/cs4265.c                          |      2 +-
> >  sound/soc/codecs/cs42xx8.c                         |      1 +
> >  sound/soc/codecs/max98090.c                        |     16 +
> >  sound/soc/codecs/rt274.c                           |      3 +-
> >  sound/soc/codecs/rt5670.c                          |     12 +
> >  sound/soc/codecs/rt5677-spi.c                      |      5 +-
> >  sound/soc/fsl/fsl_asrc.c                           |      4 +-
> >  sound/soc/intel/atom/sst/sst_pvt.c                 |      4 +-
> >  sound/soc/intel/boards/bytcht_es8316.c             |      2 +-
> >  sound/soc/intel/boards/cht_bsw_max98090_ti.c       |      2 +-
> >  sound/soc/intel/boards/cht_bsw_nau8824.c           |      2 +-
> >  sound/soc/intel/boards/cht_bsw_rt5672.c            |      2 +-
> >  sound/soc/intel/boards/sof_rt5682.c                |     11 +-
> >  sound/soc/intel/common/soc-acpi-intel-byt-match.c  |     17 +
> >  sound/soc/intel/common/soc-acpi-intel-cnl-match.c  |     10 +-
> >  sound/soc/mediatek/Kconfig                         |      2 +-
> >  sound/soc/soc-core.c                               |     36 +-
> >  sound/soc/soc-dapm.c                               |      7 +-
> >  sound/soc/soc-pcm.c                                |      3 +-
> >  sound/soc/sof/Kconfig                              |      8 +-
> >  sound/soc/sof/control.c                            |      9 +-
> >  sound/soc/sof/core.c                               |     29 +-
> >  sound/soc/sof/intel/bdw.c                          |     26 +-
> >  sound/soc/sof/intel/byt.c                          |     25 +-
> >  sound/soc/sof/intel/cnl.c                          |      4 +
> >  sound/soc/sof/intel/hda-ctrl.c                     |    102 +-
> >  sound/soc/sof/intel/hda-ipc.c                      |     17 +-
> >  sound/soc/sof/intel/hda.c                          |    129 +-
> >  sound/soc/sof/ipc.c                                |     26 +-
> >  sound/soc/sof/loader.c                             |      2 +
> >  sound/soc/sof/pcm.c                                |      8 +-
> >  sound/soc/sof/xtensa/core.c                        |      2 +-
> >  sound/soc/sunxi/sun4i-codec.c                      |      9 +
> >  sound/soc/sunxi/sun4i-i2s.c                        |      6 +-
> >  tools/testing/nvdimm/test/iomap.c                  |      2 +
> >  1785 files changed, 479818 insertions(+), 36145 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.=
yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/ingenic,l=
cd.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.t=
xt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/evervision,vgg804821.tx=
t
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/friendlyarm,hd702e.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2045=
-53ts.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/osddisplays,osd101t2587=
-53ts.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.t=
xt
> >  create mode 100644
> > Documentation/devicetree/bindings/display/panel/vl050_8048nt_c01.txt
> >  delete mode 100644
> > Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yam=
l
> >  create mode 100644 Documentation/gpu/mcde.rst
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> >  rename drivers/gpu/drm/amd/amdgpu/{amdgpu_prime.c =3D> amdgpu_dma_buf.=
c} (93%)
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_socbb.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v2_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx10.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v10_1.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/navi10_ih.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> >  rename drivers/gpu/drm/{i915/i915_gemfs.h =3D> amd/amdgpu/nbio_v2_3.h}=
 (52%)
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/nv.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/nv.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/nvd.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
> >  create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.=
asm
> >  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager=
_v10.c
> >  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v10.c
> >  create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_c=
lk_mgr.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_c=
lk_mgr.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.h
> >  rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_clk_mgr.c =3D>
> > clk_mgr/dcn10/rv1_clk_mgr.c} (59%)
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_cl=
k_mgr.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_cl=
k_mgr.c
> >  rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_clk_mgr.h =3D>
> > clk_mgr/dcn10/rv2_clk_mgr.h} (82%)
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_=
clk_mgr.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_=
clk_mgr.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dc_dsc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.=
c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_enc=
oder.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_enc=
oder.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub=
.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mmhubbub=
.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource=
.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource=
.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_e=
ncoder.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_e=
ncoder.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba=
.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba=
.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/Makefile
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/drm_dsc_dc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dscc_types.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factor=
y_dcn20.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_factor=
y_dcn20.h
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.c
> >  create mode 100644
> > drivers/gpu/drm/amd/display/dc/gpio/dcn20/hw_translate_dcn20.h
> >  rename drivers/gpu/drm/amd/display/dc/{dce/dce_clk_mgr.h =3D>
> > inc/hw/clk_mgr_internal.h} (51%)
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/mcif_wb.h
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_servic=
e_dcn20.c
> >  create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_servic=
e_dcn20.h
> >  create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_vmid.h
> >  create mode 100644 drivers/gpu/drm/amd/display/modules/vmid/vmid.c
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/athub/athub_2_0_0_default.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/athub/athub_2_0_0_offset.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/athub/athub_2_0_0_sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_0=
_offset.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_0_0_sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_=
offset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_=
sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_d=
efault.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_o=
ffset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_s=
h_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_5_0_0_=
offset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_5_0_0_=
sh_mask.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_0_0_default.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_0_0_offset.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_0_0_sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_2_3_=
default.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_2_3_=
offset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_2_3_=
sh_mask.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_offset.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/oss/osssys_5_0_0_sh_mask.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_11_0_0_offset.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_11_0_0_sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_=
offset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_0_0_=
sh_mask.h
> >  create mode 100644 drivers/gpu/drm/amd/include/discovery.h
> >  rename drivers/gpu/drm/amd/include/ivsrcid/{ =3D> dcn}/irqsrcs_dcn_1_0=
.h (100%)
> >  create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx=
_10_1.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/ivsrcid/sdma0/irqsrcs_sdma0_5_0.h
> >  create mode 100644
> > drivers/gpu/drm/amd/include/ivsrcid/sdma1/irqsrcs_sdma1_5_0.h
> >  create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn=
_2_0.h
> >  create mode 100644 drivers/gpu/drm/amd/include/navi10_enum.h
> >  create mode 100644 drivers/gpu/drm/amd/include/navi10_ip_offset.h
> >  create mode 100644 drivers/gpu/drm/amd/include/v10_structs.h
> >  create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_n=
avi10.h
> >  create mode 100644 drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >  create mode 100644 drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgm=
t.c
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgm=
t.h
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_wb_connec=
tor.c
> >  delete mode 100644 drivers/gpu/drm/cirrus/cirrus_ttm.c
> >  create mode 100644 drivers/gpu/drm/drm_client_modeset.c
> >  create mode 100644 drivers/gpu/drm/drm_gem_vram_helper.c
> >  create mode 100644 drivers/gpu/drm/drm_hdcp.c
> >  create mode 100644 drivers/gpu/drm/drm_self_refresh_helper.c
> >  create mode 100644 drivers/gpu/drm/drm_vram_helper_common.c
> >  create mode 100644 drivers/gpu/drm/drm_vram_mm_helper.c
> >  create mode 100644 drivers/gpu/drm/i915/Kconfig.profile
> >  create mode 100644 drivers/gpu/drm/i915/display/Makefile
> >  create mode 100644 drivers/gpu/drm/i915/display/Makefile.header-test
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_ch7017.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_ch7xxx.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_ivch.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_ns2501.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_sil164.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/dvo_tfp410.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/icl_dsi.c (89%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_acpi.c (99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_acpi.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_atomic.c (93%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_atomic.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_atomic_plane.c (88%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_atomic_plane.h (77%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_audio.c (95%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_audio.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_bios.c (94%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_bios.h (83%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_bw.c
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_bw.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_cdclk.c (91%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_cdclk.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_color.c (85%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_color.h (87%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_combo_phy.c (77%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_combo_phy.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_connector.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_connector.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_crt.c (96%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_crt.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_ddi.c (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_ddi.h (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_display.c (93%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_display.h (79%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_display_power.c
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_display_power.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dp.c (96%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dp.h (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dp_aux_backlight.c (=
99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_dp_aux_backlight=
.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dp_link_training.c (=
99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_dp_link_training=
.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dp_mst.c (98%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_dp_mst.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dpio_phy.c (98%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_dpio_phy.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dpll_mgr.c (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dpll_mgr.h (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dsi.c (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dsi.h (95%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dsi_dcs_backlight.c =
(99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_dsi_dcs_backligh=
t.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dsi_vbt.c (70%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dvo.c (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_dvo.h (100%)
> >  rename drivers/gpu/drm/i915/{dvo.h =3D> display/intel_dvo_dev.h} (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_fbc.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_fbc.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_fbdev.c (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_fbdev.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_fifo_underrun.c (99%=
)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_fifo_underrun.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_frontbuffer.c (96%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_frontbuffer.h (99%)
> >  rename drivers/gpu/drm/i915/{intel_i2c.c =3D> display/intel_gmbus.c} (=
91%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_gmbus.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_hdcp.c (96%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_hdcp.h (94%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_hdmi.c (95%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_hdmi.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_hotplug.c (99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_hotplug.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_lpe_audio.c (99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_lpe_audio.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_lspcon.c (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_lspcon.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_lvds.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_lvds.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_opregion.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_opregion.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_overlay.c (98%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_overlay.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_panel.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_panel.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_pipe_crc.c (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_pipe_crc.h (84%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_psr.c (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_psr.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_quirks.c (99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_quirks.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_sdvo.c (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_sdvo.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_sdvo_regs.h (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_sprite.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_sprite.h (89%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_tv.c (99%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_tv.h (100%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_vbt_defs.h (71%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/intel_vdsc.c (99%)
> >  create mode 100644 drivers/gpu/drm/i915/display/intel_vdsc.h
> >  rename drivers/gpu/drm/i915/{ =3D> display}/vlv_dsi.c (90%)
> >  rename drivers/gpu/drm/i915/{ =3D> display}/vlv_dsi_pll.c (98%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/Makefile
> >  create mode 100644 drivers/gpu/drm/i915/gem/Makefile.header-test
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_busy.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_clflush.c (74%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_clflush.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_client_blt.h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_context.c (63%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_context.h (69%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_context_types.h (75%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_dmabuf.c (83%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_domain.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_execbuffer.c (93%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_fence.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_internal.c (79%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_ioctls.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_mman.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_object.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_object.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_object_blt.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_pages.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_phys.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_pm.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_pm.h
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_shrinker.c (75%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_stolen.c (92%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_throttle.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_tiling.c (90%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gem_userptr.c (94%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_wait.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/i915_gemfs.c (51%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/i915_gemfs.h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/huge_gem_object.c (7=
0%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/huge_gem_object.=
h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/huge_pages.c (93%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/i915_gem_client_=
blt.c
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/i915_gem_coherency.c=
 (83%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/i915_gem_context.c (=
80%)
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/i915_gem_dmabuf.c (8=
5%)
> >  rename drivers/gpu/drm/i915/{selftests/i915_gem_object.c =3D>
> > gem/selftests/i915_gem_mman.c} (67%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/i915_gem_object.=
c
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/i915_gem_object_=
blt.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/mock_context.c (54%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/mock_context.h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/mock_dmabuf.c (73%)
> >  create mode 100644 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.h
> >  rename drivers/gpu/drm/i915/{ =3D> gem}/selftests/mock_gem_object.h (6=
5%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/Makefile
> >  create mode 100644 drivers/gpu/drm/i915/gt/Makefile.header-test
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_breadcrumbs.c (95%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_context.c
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_context.h
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_context_types.h (68%)
> >  rename drivers/gpu/drm/i915/{intel_ringbuffer.h =3D> gt/intel_engine.h=
} (90%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_engine_cs.c (82%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pm.c
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pm.h
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_engine_types.h (93%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_gpu_commands.h (99%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_pm.c
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_pm.h
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_hangcheck.c (93%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc.c (74%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc.h (85%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_lrc_reg.h (97%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_mocs.c (98%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_mocs.h (97%)
> >  rename drivers/gpu/drm/i915/{i915_reset.c =3D> gt/intel_reset.c} (91%)
> >  rename drivers/gpu/drm/i915/{i915_reset.h =3D> gt/intel_reset.h} (91%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_ringbuffer.c (90%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_sseu.c
> >  create mode 100644 drivers/gpu/drm/i915/gt/intel_sseu.h
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_workarounds.c (81%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_workarounds.h (79%)
> >  rename drivers/gpu/drm/i915/{ =3D> gt}/intel_workarounds_types.h (88%)
> >  rename drivers/gpu/drm/i915/{selftests =3D> gt}/mock_engine.c (87%)
> >  rename drivers/gpu/drm/i915/{selftests =3D> gt}/mock_engine.h (95%)
> >  rename drivers/gpu/drm/i915/{selftests/intel_engine_cs.c =3D>
> > gt/selftest_engine_cs.c} (100%)
> >  rename drivers/gpu/drm/i915/{selftests/intel_hangcheck.c =3D>
> > gt/selftest_hangcheck.c} (88%)
> >  rename drivers/gpu/drm/i915/{selftests/intel_lrc.c =3D> gt/selftest_lr=
c.c} (68%)
> >  create mode 100644 drivers/gpu/drm/i915/gt/selftest_reset.c
> >  rename drivers/gpu/drm/i915/{selftests/intel_workarounds.c =3D>
> > gt/selftest_workarounds.c} (62%)
> >  create mode 100644 drivers/gpu/drm/i915/i915_debugfs.h
> >  delete mode 100644 drivers/gpu/drm/i915/i915_gem_clflush.h
> >  delete mode 100644 drivers/gpu/drm/i915/i915_gem_object.c
> >  delete mode 100644 drivers/gpu/drm/i915/i915_gem_object.h
> >  create mode 100644 drivers/gpu/drm/i915/i915_irq.h
> >  create mode 100644 drivers/gpu/drm/i915/i915_scatterlist.c
> >  create mode 100644 drivers/gpu/drm/i915/i915_scatterlist.h
> >  delete mode 100644 drivers/gpu/drm/i915/intel_context.c
> >  delete mode 100644 drivers/gpu/drm/i915/intel_context.h
> >  create mode 100644 drivers/gpu/drm/i915/intel_runtime_pm.h
> >  create mode 100644 drivers/gpu/drm/i915/intel_sideband.h
> >  create mode 100644 drivers/gpu/drm/i915/intel_wakeref.c
> >  create mode 100644 drivers/gpu/drm/i915/intel_wakeref.h
> >  delete mode 100644 drivers/gpu/drm/i915/selftests/huge_gem_object.h
> >  create mode 100644 drivers/gpu/drm/i915/selftests/igt_atomic.h
> >  delete mode 100644 drivers/gpu/drm/i915/selftests/mock_context.h
> >  delete mode 100644 drivers/gpu/drm/i915/selftests/mock_dmabuf.h
> >  create mode 100644 drivers/gpu/drm/ingenic/Kconfig
> >  create mode 100644 drivers/gpu/drm/ingenic/Makefile
> >  create mode 100644 drivers/gpu/drm/ingenic/ingenic-drm.c
> >  create mode 100644 drivers/gpu/drm/mcde/Kconfig
> >  create mode 100644 drivers/gpu/drm/mcde/Makefile
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_display.c
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_display_regs.h
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_drm.h
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_drv.c
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_dsi.c
> >  create mode 100644 drivers/gpu/drm/mcde/mcde_dsi_regs.h
> >  create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
> >  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
> >  create mode 100644 drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> >  create mode 100644 drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> >  create mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
> >  create mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
> >  delete mode 100644 drivers/gpu/drm/virtio/virtgpu_fb.c
> >  create mode 100644 drivers/gpu/drm/virtio/virtgpu_trace.h
> >  create mode 100644 drivers/gpu/drm/virtio/virtgpu_trace_points.c
> >  create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> >  create mode 100644 drivers/gpu/ipu-v3/ipu-ic-csc.c
> >  create mode 100644 include/drm/drm_gem_vram_helper.h
> >  create mode 100644 include/drm/drm_self_refresh_helper.h
> >  create mode 100644 include/drm/drm_vram_mm_helper.h
> >  create mode 100644 mm/as_dirty_helpers.c



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
