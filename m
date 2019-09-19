Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9776720717
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl4ELjuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392268AbfISTJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:09:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46195 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392253AbfISTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:09:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so4663250ljf.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=M3x9O31tr7uepu8pSmlCLJmyoJqAxBsEGvu2dja0UsU=;
        b=Yl4ELjuNlax/VjUZLDGBmrSKHplz2K3NPKLkyOtbH4sW52BPETZikKxM3UiXbTr9zR
         st+25S26/KogX1wRC3z9ftio79NaC0wI6O197MHYzHR9HpqubTrRlcN3/kpO4Ua4I3St
         npGb9cJV/QWIcUyuTJ36HBnqJidJawJ/vSAXp/WJ887cOtXRJfoVK2Yi0BHK1EhiNj+6
         2Qexu1Y/wo39+o5taGfOrwPT1n5G/zmYeD/h4ycI7SFeqqCrQKLz4NdnEg7UxgqViLIN
         iOl0FyazLKMBBWvy7AjcExnolLqouBvqBqJqA/+KGsliq1D09kTPgx5mozWlORmkntAM
         TuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=M3x9O31tr7uepu8pSmlCLJmyoJqAxBsEGvu2dja0UsU=;
        b=NAI4C8Tou0AF70IJyjxdl8gnEqAXIGdyEKLrtUrWz4L/DsZRVhcssHrkxaseXvTnDO
         giKSS5d7IrOKLHsg5U1uMBC574EpTUK+SpMnNJltcM5aVQA3SbjHAZSKfz+tzfzeA25b
         vjC7IbbpnsvZKpJ2WTq7QGKI08Ex4m9iUWnCuPXLSnIZQJfhJZXR37AuBh6l7ZQBQrIq
         KE5qTvzHzAnZKRCtMPdhRG1uEDvIwCO5T60QHGHbRMrRI1bxCkN1j2phwLxPK/uR2IsC
         k2ia/rHlOEOToddsQiifzlWHqY+E0y0mUEl46a0F67koLa1XD/dxPapxrUEei0yMJtYs
         BRVQ==
X-Gm-Message-State: APjAAAUpyz5pLX6frupI+Stmx1j4qnkqbyVzEc8Xr4GUbzhvQc4U1BUk
        P/bGE5eLd8MjRDdHZmqBnyzPRxGFgtNeICt7AUSzwCMu
X-Google-Smtp-Source: APXvYqyXQFyO0jFOvW04ZxbWzX1so834xXHpOOvEC3drfQ9fMDBEOOQtQsU8ejv5xWNhhrk+Z4z5Ang4RRB3M5mv0DE=
X-Received: by 2002:a2e:b0d1:: with SMTP id g17mr6139010ljl.238.1568920148190;
 Thu, 19 Sep 2019 12:09:08 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Sep 2019 05:08:55 +1000
Message-ID: <CAPM=9txTjip6SonSATB-O38TGX9ituQaw+29PnAkNJ960R1z6g@mail.gmail.com>
Subject: [git pull] drm tree for 5.4-rc1
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

This is the main pull request for 5.4-rc1 merge window. I don't think
there is anything outstanding so next week should just be fixes, but
we'll see if I missed anything. I landed some fixes earlier in the
week but got delayed writing summary and sending it out, due to a mix
of sick kid and jetlag!

There are some fixes pending, but I'd rather get the main merge out of
the way instead of delaying it longer.

It's also pretty large in commit count and new amd header file size.
The largest thing is 4 new amdgpu products (navi12/14, arcturus and
renoir APU support). Otherwise it's pretty much lots of work across
the board, i915 has started landing tigerlake support, lots of icelake
fixes and lots of locking reworking for future gpu support, lots of
header file rework (drmP.h is nearly gone), some old legacy hacks
(DRM_WAIT_ON) have been put into the places they are needed.

There are a few merge conflicts across the board, we have a shared
rerere cache which meant I hadn't noticed them until I avoided the
cache.
https://cgit.freedesktop.org/drm/drm/log/?h=3Ddrm-5.4-merge
contains what we've done, none of them are too crazy.

Let me know if there any issues but it's all pretty contained to
graphics and related bits this time.

Dave.

uapi:
- content protection type property for HDCP

core:
- rework include dependencies
- lots of drmP.h removals
- link rate calculation robustness fix
- make fb helper map only when required
- add connector->DDC adapter link
- DRM_WAIT_ON removed
- drop DRM_AUTH usage from drivers

dma-buf:
- reservation object fence helper

dma-fence:
- shrink dma_fence struct
- merge signal functions
- store timestamps in dma_fence
- selftests

ttm:
- embed drm_get_object struct into ttm_buffer_object
- release_notify callback

bridges:
- sii902x - audio graph card support
- tc358767 - aux data handling rework
- ti-snd64dsi86 - debugfs support, DSI mode flags support

panels:
- Support for GiantPlus GPM940B0, Sharp LQ070Y3DG3B, Ortustech
  COM37H3M, Novatek NT39016, Sharp LS020B1DD01D, Raydium RM67191,
  Boe Himax8279d, Sharp LD-D5116Z01B
- TI nspire, NEC NL8048HL11, LG Philips LB035Q02,
  Sharp LS037V7DW01, Sony ACX565AKM, Toppoly TD028TTEC1
  Toppoly TD043MTEA1

i915:
- Initial tigerlake platform support
- Locking simplification work, general all over refactoring.
- Selftests
- HDCP debug info improvements
- DSI properties
- Icelake display PLL fixes, colorspace fixes, bandwidth fixes, DSI
suspend/resume
- GuC fixes
- Perf fixes
- ElkhartLake enablement
- DP MST fixes
- GVT - command parser enhancements

amdgpu:
- add wipe memory on release flag for buffer creation
- Navi12/14 support (may be marked experimental)
- Arcturus support
- Renoir APU support
- mclk DPM for Navi
- DC display fixes
- Raven scatter/gather support
- RAS support for GFX
- Navi12 + Arcturus power features
- GPU reset for Picasso
- smu11 i2c controller support

amdkfd:
- navi12/14 support
- Arcturus support

radeon:
- kexec fix

nouveau:
- improved display color management
- detect lack of GPU power cables

vmwgfx:
- evicition priority support
- remove unused security feature

msm:
- msm8998 display support
- better async commit support for cursor updates

etnaviv:
- per-process address space support
- performance counter fixes
- softpin support

mcde:
- DCS transfers fix

exynos:
- drmP.h cleanup

lima:
- reduce logging

kirin:
- misc clenaups

komeda:
- dual-link support
- DT memory regions

hisilicon:
- misc fixes

imx:
- IPUv3 image converter fixes
- 32-bit RGB V4L2 pixel format support

ingenic:
- more support for panel related cases

mgag200:
- cursor support fix

panfrost:
- export GPU features register to userspace
- gpu heap allocations
- per-fd address space support

pl111:
- CLD pads wiring support removed from DT

rockchip:
- rework to use DRM PSR helpers
- fix bug in VOP_WIN_GET macro
- DSI DT binding rework

sun4i:
- improve support for color encoding and range
- DDC enabled GPIO

tinydrm:
- rework SPI support
- improve MIPI-DBI support
- moved to drm/tiny

vkms:
- rework CRC tracking

dw-hdmi:
- get_eld and i2s improvements

gm12u320:
- misc fixes

meson:
- global code cleanup
- vpu feature detect

omap:
- alpha/pixel blend mode properties

rcar-du:
- misc fixes


drm-next-2019-09-18:
drm main pull for 5.4-rc1
The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d=
:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-09-18

for you to fetch changes up to 945b584c94f8c665b2df3834a8a6a8faf256cd5f:

  Merge branch 'linux-5.4' of git://github.com/skeggsb/linux into
drm-next (2019-09-17 16:31:34 +1000)

----------------------------------------------------------------
drm main pull for 5.4-rc1

----------------------------------------------------------------
Aaron Liu (27):
      drm/amdgpu: fix no interrupt issue for renoir emu
      drm/amdgpu: enable dce virtual ip module for Renoir
      drm/amdgpu: add asic funcs for renoir
      drm/amdgpu: set rlc funcs for renoir
      drm/amdgpu: add psp_v12_0 for renoir (v2)
      drm/amdgpu: enable clock gating for renoir
      drm/amdgpu: enable power gating for renoir
      drm/amdgpu: update lbpw for renoir
      drm/amdgpu: set fw default loading by psp for renoir
      drm/amd/powerplay: add smu12_driver_if.h (v3)
      drm/amdgpu/powerplay: add initial renoir_ppt.c for renoir (v3)
      drm/amdgpu/powerplay: add smu_v12_0.c & smu_v12_0.h for renoir
      drm/amdgpu/powerplay: add smu ip block for renoir (v2)
      drm/amdgpu/powerplay: add power up/down SDMA interfaces for renoir
      drm/amd/powerplay: udpate smu_v12_0_check_fw_version (v2)
      drm/amdgpu: add set_gfx_cgpg implement (v2)
      drm/amdgpu: add and enable gfxoff feature
      drm/amd/powerplay: fix checking gfxoff status for rn
      drm/amd/powerplay: using valid mapping check for rn
      drm/amd/powerplay: add smu tables for rn
      drm/amd/powerplay: init smu tables for rn
      drm/amd/powerplay: add DPMCLOCKS table implementation
      drm/amdgpu: update gc/sdma goldensetting for rn
      drm/amdgpu: fix GFXOFF on Picasso and Raven2
      drm/amd/powerplay: SMU_MSG_OverridePcieParameters is unsupport for AP=
U
      drm/amdgpu: update IH_CHICKEN in oss 4.0 IP header for VG/RV series
      drm/amdgpu: fix no interrupt issue for renoir emu (v2)

Aditya Swarup (2):
      drm/i915: Use port clock to set correct N value
      drm/i915: Add N & CTS values for 10/12 bit deep color

Ahmad Fatoum (1):
      drm/stm: attach gem fence to atomic state

Ahmad Othman (1):
      drm/amd/display: Refactoring VTEM

Ahzo (1):
      drm/amd/powerplay/smu7: enforce minimal VBITimeout (v2)

Alex Deucher (42):
      drm/amdgpu: disable concurrent flushes on Navi14
      drm/amdgpu: consolidate navi14 IP init
      drm/amdgpu: drop unused function definitions
      drm/amdgpu: flag arcturus as experimental for now
      drm/amdgpu/smu: move fan rpm query into the asic specific code
      drm/amdgpu: add an asic callback to determine the reset method
      drm/amdgpu: add reset_method asic callback for si
      drm/amdgpu: add reset_method asic callback for cik
      drm/amdgpu: add reset_method asic callback for vi
      drm/amdgpu: add reset_method asic callback for soc15
      drm/amdgpu: add reset_method asic callback for navi
      drm/amdgpu/powerplay: add a new interface to set the mp1 state
      drm/amdgpu/powerplay: return success if set_mp1_state is not set
      drm/amdgpu/powerplay: add set_mp1_state for vega20
      drm/amdgpu/powerplay: add set_mp1_state for vega10
      drm/amdgpu/powerplay: add set_mp1_state for vega12
      drm/amdgpu: put the SMC into the proper state on reset/unload
      drm/amdgpu/powerplay: use proper revision id for navi
      drm/amdgpu/display: fix the build without CONFIG_DRM_AMD_DC_DSC_SUPPO=
RT
      drm/amdgpu/gfx10: update golden settings for navi14
      drm/amdgpu: drop drmP.h in amdgpu_amdkfd_arcturus.c
      drm/amdgpu: drop drmP.h from amdgpu_amdkfd_gfx_v10.c
      drm/amdgpu: drop drmP.h in gfx_v10_0.c
      drm/amdgpu: drop drmP.h from navi10_ih.c
      drm/amdgpu: drop drmP.h from nv.c
      drm/amdgpu: drop drmP.h from sdma_v5_0.c
      drm/amdgpu: drop drmP.h from vcn_v2_0.c
      drm/amdgpu: drop drmP.h from vcn_v2_5.c
      drm/amdkfd: enable KFD support for navi14
      Merge tag 'v5.3-rc3' into drm-next-5.4
      drm/amdgpu: add navi14 PCI ID
      drm/amd/display: use kvmalloc for dc_state (v2)
      drm/amdgpu: flag renoir as experimental for now
      drm/amdgpu/gfx9: update pg_flags after determining if gfx off is poss=
ible
      drm/amdgpu/powerplay: silence a warning in smu_v11_0_setup_pptable
      drm/amdgpu/powerplay: Add smu_v12_0_ppsmc.h (v2)
      drm/amdgpu/powerplay/smu7: enable mclk switching if monitors are sync=
ed
      drm/amdgpu/powerplay/vega10: enable mclk switching if monitors are sy=
nced
      drm/amd/display: update bw_calcs to take pipe sync into account (v3)
      drm/amdgpu/display: add flag for multi-display mclk switching
      drm/amdgpu: set adev->num_vmhubs for gmc6,7,8
      drm/amdgpu/virtual_dce: drop error message in hw_init

Alvin Lee (4):
      drm/amd/display: Disable Audio on reinitialize hardware
      drm/amd/display: Remove second initialization of pp_smu
      drm/amd/display: Wait for flip to complete
      drm/amd/display: Only enable audio if speaker allocation exists

Anders Roxell (2):
      drm: mali-dp: Mark expected switch fall-through
      video: fbdev: sh_mobile_lcdcfb: Mark expected switch fall-through

Andi Shyti (2):
      drm/i915: Extract GT powermanagement interrupt handling
      drm/i915: Extract general GT interrupt handlers

Andrey Grodzovsky (18):
      drm/amdgpu: Fix hard hang for S/G display BOs.
      drm/amdgpu: Create helper to clear AMDGPU_GEM_CREATE_CPU_GTT_USWC
      drm/amdgpu: Add check for USWC support for
amdgpu_display_supported_domains
      drm/amdgpu: Fix amdgpu_display_supported_domains logic.
      drm/amdgpu: Add amdgpu_asic_funcs.reset_method for Vega20
      drm/amdgpu: Fix GPU reset crash regression.
      dmr/amdgpu: Fix compile error with CONFIG_DRM_AMDGPU_GART_DEBUGFS
      drm/amd/powerplay: Fix meaning of 0x1E PPSMC_MSG
      drm/amd/powerplay: add mode2 reset callback for pp_smu_mgr
      drm/amd/powerpay: Implement mode2 reset callback for SMU10
      drm/amd/poweplay: Add amd_pm_funcs callback for mode 2
      drm/amdgpu: Use new mode2 reset interface for RV.
      drm/amd/display: Fix error message
      drm/amdgpu: Add RAS EEPROM table.
      drm/amd: Import smuio_11_0 headers for EEPROM access on Vega20
      drm/amd/powerplay: Add interface to lock SMU HW I2C.
      drm/amdgpu: Vega20 SMU I2C HW engine controller.
      drm/amdgpu: Handle job is NULL use case in amdgpu_device_gpu_recover

Andrey Smirnov (15):
      drm/bridge: tc358767: Simplify tc_poll_timeout()
      drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
      drm/bridge: tc358767: Simplify polling in tc_link_training()
      drm/bridge: tc358767: Simplify tc_set_video_mode()
      drm/bridge: tc358767: Drop custom tc_write()/tc_read() accessors
      drm/bridge: tc358767: Simplify AUX data read
      drm/bridge: tc358767: Simplify AUX data write
      drm/bridge: tc358767: Increase AUX transfer length limit
      drm/bridge: tc358767: Use reported AUX transfer size
      drm/bridge: tc358767: Introduce tc_set_syspllparam()
      drm/bridge: tc358767: Introduce tc_pllupdate()
      drm/bridge: tc358767: Simplify tc_aux_wait_busy()
      drm/bridge: tc358767: Drop unnecessary 8 byte buffer
      drm/bridge: tc358767: Replace magic number in tc_main_link_enable()
      drm/bridge: tc358767: Add support for address-only I2C transfers

Andrzej Pietrasiewicz (13):
      drm: Add ddc link in sysfs created by drm_connector
      drm: Add drm_connector_init() variant with ddc
      drm/sun4i: hdmi: Provide ddc symlink in sun4i hdmi connector
sysfs directory
      drm/imx: imx-ldb: Provide ddc symlink in connector's sysfs
      drm/imx: imx-tve: Provide ddc symlink in connector's sysfs
      drm: sti: Provide ddc symlink in hdmi connector sysfs directory
      drm/mgag200: Provide ddc symlink in connector sysfs directory
      drm/ast: Provide ddc symlink in connector sysfs directory
      drm/bridge: dumb-vga-dac: Provide ddc symlink in connector sysfs dire=
ctory
      drm/bridge: dw-hdmi: Provide ddc symlink in connector sysfs directory
      drm/bridge: ti-tfp410: Provide ddc symlink in connector sysfs directo=
ry
      drm/amdgpu: Provide ddc symlink in connector sysfs directory
      drm/radeon: Provide ddc symlink in connector sysfs directory

Anshuman Gupta (3):
      drm/i915: Add HDCP capability info to i915_display_info.
      drm/i915/icl: Remove DDI IO power domain from PG3 power domains
      drm/i915/tgl: Fixing up list of PG3 power domains.

Anthony Koo (6):
      drm/amd/display: add monitor patch to add T7 delay
      drm/amd/display: fix issue where 252-255 values are clipped
      drm/amd/display: 3.2.45
      drm/amd/display: 3.2.46
      drm/amd/display: 3.2.47
      drm/amd/display: 3.2.48

Anusha Srivatsa (3):
      drm/i915: Add modular FIA
      drm/i915/dmc: Load DMC on TGL
      drm/i915/cml: Add Missing PCI IDs

Aric Cyr (9):
      drm/amd/display: 3.2.36
      drm/amd/display: 3.2.37
      drm/amd/display: 3.2.38
      drm/amd/display: 3.2.39
      drm/amd/display: 3.2.40
      drm/amd/display: 3.2.41
      drm/amd/display: 3.2.42
      drm/amd/display: 3.2.43
      drm/amd/display: 3.2.44

Austin Kim (1):
      drm/amdgpu: Move null pointer dereference check

Bayan Zabihiyan (3):
      drm/amd/display: Fix frames_to_insert math
      drm/amd/display: add Cursor Degamma logic for DCN2
      drm/amd/display: Expose OTG_V_TOTAL_MID for HW Diags

Ben Skeggs (15):
      drm/nouveau/kms/gv100: allow windows to use PACKED8BPP formats
      drm/nouveau/kms/tu102-: disable input lut when input is already FP16
      drm/nouveau/kms/nv50-: disable input lut harder
      drm/nouveau/fifo/gf1xx: convert to using nvkm_fault_data
      drm/nouveau/fifo/gk104-: fix parsing of mmu fault data
      drm/nouveau/kms/gv100-: use premultiplied alpha blending between plan=
es
      drm/nouveau/kms/gv100-: implement csc + enable modern colour
managment properties
      drm/nouveau/kms/nv50-: use __drm_atomic_helper_plane_reset()
      drm/nouveau/kms/nv50-: create primary plane before overlay planes
      drm/nouveau/kms/nv50-: attach immutable zpos property to planes
      drm/nouveau/kms/gv100-: add support for plane zpos property
      drm/nouveau/kms/gv100-: attach alpha property to planes
      drm/nouveau/kms/gv100-: attach pixel blend mode property to planes
      drm/nouveau/therm: skip probing for devices not specified in
thermal tables
      drm/nouveau/therm: don't attempt fan control where PMU is
already managing it

Bhawanpreet Lakha (24):
      drm/amd/display: add nv14 cases to amdgpu_dm
      drm/amd/display: add NAVI14 in resource construct
      drm/amd/display: add dm block
      drm/amd/display: add ASICREV defines v2
      drm/amd/display: Add Renoir registers (v3)
      drm/amd/display: Add Renoir clock registers list
      drm/amd/display: Add Renoir hw_seq register list
      drm/amd/display: Add pp_smu functions for Renoir
      drm/amd/display: Add Renoir irq_services (v2)
      drm/amd/display: Add hubp block for Renoir (v2)
      drm/amd/display: Add Renoir hubbub registers list
      drm/amd/display: Add Renoir Hubbub (v2)
      drm/amd/display: Add Renoir clock manager
      drm/amd/display: Add Renoir resource (v2)
      drm/amd/display: Add Renoir GPIO
      drm/amd/display: Add Renoir DML
      drm/amd/display: Fix register names
      drm/amd/display: Handle Renoir in DC
      drm/amd/display: Handle Renoir in amdgpu_dm (v2)
      drm/amd/display: call update_bw_bounding_box
      drm/amd/display: add dal_asic_id for renoir
      drm/amd/display: add dcn21 core DC changes
      drm/amd/display: build dcn21 blocks
      drm/amd/display: add Renoir to kconfig

Boyuan Zhang (3):
      drm/amdgpu: add Navi12 VCN firmware support
      drm/amdgpu: add VCN ip block for Navi12
      drm/amdgpu: enable DPG mode for Navi12

Brian Masney (1):
      drm/msm/phy/dsi_phy: silence -EPROBE_DEFER warnings

Brian Starkey (1):
      drm/crc-debugfs: Add notes about CRC<->commit interactions

Charlene Liu (8):
      drm/amd/display: Split out common HUBP registers and code
      drm/amd/display: Do not fill Null packet in the blank period
      drm/amd/display: add set and get clock for testing purposes
      drm/amd/display: add a option to force the clock at every mode change=
.
      drm/amd/display: wake up ogam mem pwr before programming ocsc
      drm/amd/display: enable dcn_mem_pwr as golden setting updates
      drm/amd/display: support spdif
      drm/amd/display: set av_mute in hw_init for HDMI

Chengming Gui (5):
      drm/amdgpu/powerplay: add arcturus ppt functions
      drm/amdgpu/powerplay: add smu11 driver interface for arcturus. (v2)
      drm/amd/powerplay: get smc firmware and pptable
      drm/amd/powerplay: remove redundancy debug log about smu
unsupported features
      drm/amd/powerplay: add arcturus_is_dpm_running function for arcturus

Chiawen Huang (1):
      drm/amd/display: Add aux tracing log in dce

Chris Wilson (221):
      drm/i915: Signal fence completion from i915_request_wait
      drm/i915: Flush the execution-callbacks on retiring
      drm/i915: Keep rings pinned while the context is active
      drm/i915/execlists: Preempt-to-busy
      drm/i915/execlists: Minimalistic timeslicing
      drm/i915: Rings are always flushed
      drm/i915/selftests: Use request managed wakerefs
      drm/i915/gtt: Defer address space cleanup to an RCU worker
      drm/i915/execlists: Keep virtual context alive until after we kick
      drm/i915: Prevent dereference of engine before NULL check in error ca=
pture
      drm/i915/gt: Rename i915_gt_timelines
      drm/i915/gt: Fixup kerneldoc parameters
      drm/i915: Remove waiting & retiring from shrinker paths
      drm/i915: Track i915_active using debugobjects
      drm/i915: Throw away the active object retirement complexity
      drm/i915: Provide an i915_active.acquire callback
      drm/i915: Local debug BUG_ON for intel_wakeref
      drm/i915/blt: Remove recursive vma->lock
      drm/i915/execlists: Always clear ring_pause if we do not submit
      drm/i915/gem: Clear read/write domains for GPU clear
      drm/i915/execlists: Convert recursive defer_request() into iterative
      drm/i915/gt: Pass intel_gt to pm routines
      drm/i915: Rename intel_wakeref_[is]_active
      drm/i915/selftests: Hold ref on request across waits
      drm/i915/gt: Drop stale commentary for timeline density
      drm/i915/gt: Always call kref_init for the timeline
      drm/i915/gt: Add some debug tracing for context pinning
      drm/i915/selftests: Serialise nop reset with retirement
      drm/i915/selftests: Drop manual request wakerefs around hangcheck
      drm/i915/selftests: Fixup atomic reset checking
      drm/i915: Add a wakeref getter for iff the wakeref is already active
      drm/i915: Only recover active engines
      drm/i915: Lift intel_engines_resume() to callers
      drm: Allow range of 0 for drm_mm_insert_node_in_range()
      drm/i915: Make i945gm_vblank_work_func static
      drm/i915/guc: Avoid reclaim locks during reset
      drm/i915/execlists: Refactor CSB state machine
      drm/i915: Report if i915_active is still busy upon waiting
      drm/i915/display: Handle lost primary_port across suspend
      drm/i915/selftests: Common live setup/teardown
      drm/i915/selftests: Lock the drm_mm while modifying
      drm/i915/execlists: Hesitate before slicing
      drm/i915/gem: Free pages before rcu-freeing the object
      drm/i915: Markup potential lock for i915_active
      drm/i915: Mark up vma->active as safe for use inside shrinkers
      drm/i915/gtt: Defer the free for alloc error paths
      drm/i915: Move the renderstate setup under gt/
      drm/i915: Flush the workqueue before draining
      drm/i915: Check caller held wakerefs in assert_forcewakes_active
      drm/i915/gt: Use caller provided forcewake for intel_mocs_init_engine
      drm/i915/gt: Assume we hold forcewake for execlists resume
      drm/i915/gt: Ignore forcewake acquisition for posting_reads
      drm/i915/gem: Defer obj->base.resv fini until RCU callback
      drm/i915: Show support for accurate sw PMU busyness tracking
      drm/i915/gtt: Handle double alloc failures
      drm/i915: Dump w/a lists on all engines
      drm/i915/gt: Pull engine w/a initialisation into common
      drm/i915/gtt: Mark the freed page table entries with scratch
      drm/i915/selftests: Drain the freedlists between exec passes
      drm/i915/overlay: Stash the kernel context on initialisation
      drm/i915/selftests: Be engine agnostic
      drm/i915: Show instdone for each engine in debugfs
      drm/i915: Order assert forcewake test
      drm/i915: Pull assert_forcewake_active() underneath the lock
      drm/i915: Explicitly track active fw_domain timers
      drm/i915/selftests: Reorder error cleanup for whitelist checking
      drm/i915/selftests: Set igt_spinner.gt for early exit
      drm/i915/userptr: Acquire the page lock around set_page_dirty()
      drm/i915/selftests: Fill in a little more of the dummy fence
      drm/i915/gt: Apply RCS workarounds to the render class
      drm/i915/gt: Remove presumption of RCS0
      drm/i915/userptr: Don't mark readonly objects as dirty
      drm/i915/execlists: Record preemption for selftests
      drm/i915/gt: Drop the duplicate icl workaround
      drm/i915/selftests: Ensure we don't clamp a random offset to 32b
      drm/i915/guc: Remove preemption support for current fw
      drm/i915/selftests: Hold the vma manager lock while modifying mmap_of=
fset
      drm/i915/guc: Drop redundant ctx param from kerneldoc
      drm/i915/gtt: Use shallow dma pages for scratch
      drm/i915/gtt: Wrap page_table with page_directory
      drm/i915/gtt: Reorder gen8 ppgtt free/clear/alloc
      drm/i915/gtt: Markup i915_ppgtt height
      drm/i915/gtt: Compute the radix for gen8 page table levels
      drm/i915/gtt: Convert vm->scratch into an array
      drm/i915/gtt: Use NULL to encode scratch shadow entries
      drm/vgem: Reclassify buffer creation debug message
      drm/i915/display: Drop kerneldoc for 'intel_atomic_commit'
      drm/i915/gtt: Recursive cleanup for gen8
      drm/i915/gtt: Recursive ppgtt clear for gen8
      drm/i915/gt: Use intel_gt as the primary object for handling resets
      drm/i915/guc: Use system workqueue for log capture
      drm/i915/selftests: Ignore self-preemption suppression under gvt
      dma-buf: Expand reservation_list to fill allocation
      drm/i915: Lock the engine while dumping the active request
      drm/i915/execlists: Disable preemption under GVT
      drm/i915/gtt: Recursive ppgtt alloc for gen8
      drm/i915/gtt: Tidy up ppgtt insertion for gen8
      dma-buf: Relax the write-seqlock for reallocating the shared fence li=
st
      drm/i915/oa: Reconfigure contexts on the fly
      drm/i915/execlists: Process interrupted context on reset
      drm/i915/gt: Push engine stopping into reset-prepare
      drm/i915: Drop wmb() inside pread_gtt
      drm/i915: Use maximum write flush for pwrite_gtt
      drm/i915/execlists: Cancel breadcrumb on preempting the virtual engin=
e
      drm/i915/gtt: Correct unshifted 'from' for gen8_ppgtt_alloc errors
      drm/i915/gtt: Fix rounding for 36b
      drm/i915: Remove obsolete engine cleanup
      drm/i915/gt: Hook up intel_context_fini()
      drm/i915: Rely on spinlock protection for GPU error capture
      drm/i915/selftests: Let igt_vma_partial et al breathe
      drm/i915: Squelch nop wait-for-idle trace
      drm/i915: Capture vma contents outside of spinlock
      drm/i915/perf: Initialise err to 0 before looping over ce->engines
      drm/i915/gt: Add to timeline requires the timeline mutex
      drm/i915/uc: Fixup kerneldoc after params were flipped and renamed
      drm/i915/selftests: Careful not to flush hang_fini on error setups
      drm/i915: Flush the i915_vm_release before ggtt shutdown
      drm/i915: Inline engine->init_context into its caller
      drm/i915: Move aliasing_ppgtt underneath its i915_ggtt
      drm/i915/gt: Provide a local intel_context.vm
      drm/i915: Avoid ce->gem_context->i915
      drm/i915/selftests: Pass intel_context to igt_spinner
      drm/i915/execlists: Always clear pending&inflight requests on reset
      drm/i915: Remove lrc default desc from GEM context
      drm/i915/pmu: Atomically acquire the gt_pm wakeref
      drm/i915: Flush extra hard after writing relocations through the GTT
      drm/i915: Allow sharing the idle-barrier from other kernel requests
      drm/i915: Report resv_obj allocation failure
      drm/i915: Hide unshrinkable context objects from the shrinker
      drm/i915: Flush the freed object list on file close
      drm/i915: Teach execbuffer to take the engine wakeref not GT
      drm/i915: Replace struct_mutex for batch pool serialisation
      drm/i915/gt: Remove stale kerneldoc for internal MOCS functions
      drm/i915: Use drm_i915_private directly from drv_get_drvdata()
      drm/i915/gem: Make caps.scheduler static
      drm/i915/gt: Move the [class][inst] lookup for engines onto the GT
      drm/i915: Drop expectations of VM_IO from our GGTT mmappings
      drm/i915: Rename engines to match their user interface
      drm/i915: Use intel_engine_lookup_user for probing HAS_BSD etc
      drm/i915: Include the DRIVER_DATE in the error state
      drm/i915: Isolate i915_getparam_ioctl()
      drm/i915/selftests: Pass intel_context to mock_request
      drm/i915: Allocate kernel_contexts directly
      drm/i915: Fix up the inverse mapping for default ctx->engines[]
      drm/i915/selftests: Fixup a missing legacy_idx
      drm/i915: Defer final intel_wakeref_put to process context
      drm/i915: Only include active engines in the capture state
      drm/i915: Make debugfs/per_file_stats scale better
      drm/i915: Free the imported shmemfs file for phys objects
      drm/i915/execlists: Backtrack along timeline
      drm/i915: Check for a second VCS engine more carefully
      drm/i915: Replace global bsd_dispatch_index with random seed
      drm/i915: Generalise BSD default selection
      drm/i915: Drop the fudge warning on ring restart for ctg/elk
      drm/i915: Remove i915_gem_context_create_gvt()
      drm/i915/gt: Make deferred context allocation explicit
      drm/i915: Push the ring creation flags to the backend
      drm/i915: Lift timeline into intel_context
      drm/i915: Stop reconfiguring our shmemfs mountpoint
      drm/i915: Remove unused debugfs/i915_emon_status
      dma-fence: Propagate errors to dma-fence-array container
      dma-fence: Report the composite sync_file status
      drm/i915/execlists: Avoid sync calls during park
      drm/i915/selftests: Prevent the timeslice expiring during
suppression tests
      drm/i915/gt: Use the local engine wakeref when checking RING register=
s
      drm/i915: Forgo last_fence active request tracking
      drm/i915/overlay: Switch to using i915_active tracking
      drm/i915/guc: Use a local cancel_port_requests
      dma-buf/sw_sync: Synchronize signal vs syncpt free
      drm/i915: Push the wakeref->count deferral to the backend
      drm/i915/gt: Save/restore interrupts around breadcrumb disable
      drm/i915: Include engine->mmio_base in the debug dump
      drm/i915: Disregard drm_mode_config.fb_base
      drm/i915: Serialise read/write of the barrier's engine
      drm/i915: Convert a few more bland dmesg info to be device specific
      drm/i915: Move tasklet kicking to __i915_request_queue caller
      drm/i915/gt: Track timeline activeness in enter/exit
      drm/i915/gt: Convert timeline tracking to spinlock
      drm/i915/gt: Guard timeline pinning without relying on struct_mutex
      drm/i915: Protect request retirement with timeline->mutex
      drm/i915: Extract intel_frontbuffer active tracking
      drm/i915: Use the associated uncore for the vm
      dma-buf: Restore seqlock around dma_resv updates
      drm/i915/gt: Mark context->active_count as protected by timeline->mut=
ex
      drm/i915: Markup expected timeline locks for i915_active
      drm/i915/execlists: Lift process_csb() out of the irq-off spinlock
      drm/i915/selftests: Check the context size
      dma-fence: Shrink size of struct dma_fence
      dma-fence: Avoid list_del during fence->cb_list iteration
      dma-fence: Simply wrap dma_fence_signal_locked with dma_fence_signal
      dma-fence: Store the timestamp in the same union as the cb_list
      drm/i915: Propagate fence errors
      drm/i915: Always wrap the ring offset before resetting
      drm/i915/gt: Mark up the nested engine-pm timeline lock as irqsafe
      drm/i915: Only emit the 'send bug report' once for a GPU hang
      drm/i915: Serialize against vma moves
      drm/i915: i915_active.retire() is optional
      dma-buf: Introduce selftesting framework
      dma-buf: Add selftests for dma-fence
      drm/i915: Select DMABUF_SELFTESTS for the default i915.ko debug build
      drm/i915: Use 0 for the unordered context
      drm/i915: Assume exclusive access to objects inside resume
      dma-buf: Use %zu for printing sizeof
      dmabuf: Mark up onstack timer for selftests
      drm/i915: Serialize insertion into the file->mm.request_list
      drm/i915: Be defensive when starting vma activity
      drm/i915/gtt: Relax pd_used assertion
      drm/i915/gtt: Relax assertion for pt_used
      drm/i915/gtt: Include asm/smp.h
      drm/i915: Replace PIN_NONFAULT with calls to PIN_NOEVICT
      drm/i915/execlists: Set priority hint prior to submission
      drm/i915/gtt: Add some range asserts
      drm/i915/selftests: Fixup a couple of missing serialisation with vma
      drm/i915: Generalise the clflush dma-worker
      drm/i915: Track ggtt fence reservations under its own mutex
      drm/i915: Pull obj->userfault tracking under the ggtt->mutex
      drm/i915: Replace i915_vma_put_fence()
      drm/i915: Kill the undead i915_gem_batch_pool.c
      drm/i915: Hold irq-off for the entire fake lock period
      drm/i915: Flush the existing fence before GGTT read/write
      drm/i915: Use NOEVICT for first pass on attemping to pin a GGTT mmap

Christian Gmeiner (2):
      etnaviv: fix whitespace errors
      etnaviv: perfmon: fix total and idle HI cyleces readout

Christian K=C3=B6nig (17):
      dma-buf: cleanup reservation_object_init/fini
      drm/syncobj: fix leaking dma_fence in drm_syncobj_query_ioctl
      drm/amdgpu: fix error handling in amdgpu_cs_process_fence_dep
      dma-buf: add more reservation object locking wrappers
      dma-buf: fix stack corruption in dma_fence_chain_release
      dma-buf: fix busy wait for new shared fences
      dma-buf: fix shared fence list handling in reservation_object_copy_fe=
nces
      drm/i915: stop using seqcount for fence pruning
      dma-buf: simplify reservation_object_get_fences_rcu a bit
      dma-buf: make dma_fence structure a bit smaller v2
      dma-buf: add reservation_object_fences helper
      drm/i915: use new reservation_object_fences helper
      dma-buf: further relax reservation_object_add_shared_fence
      dma-buf: nuke reservation_object seq number
      dma-buf: rename reservation_object to dma_resv
      drm/scheduler: use job count instead of peek
      drm/amdgpu: fix dma_fence_wait without reference

Christoph Hellwig (5):
      au1200fb: don't use DMA_ATTR_NON_CONSISTENT
      drm/radeon: handle PCIe root ports with addressing limitations
      drm/amdgpu: handle PCIe root ports with addressing limitations
      drm/radeon: simplify and cleanup setting the dma mask
      drm/amdgpu: simplify and cleanup setting the dma mask

Christophe JAILLET (2):
      drm/amd/display: Fix a typo - dce_aduio_mask --> dce_audio_mask
      drm/amdgpu: Fix a typo in the include header guard of 'navi12_ip_offs=
et.h'

Chuhong Yuan (9):
      drm/i915: Use dev_get_drvdata
      drm/amdgpu: Use dev_get_drvdata where possible
      drm/amd/display: Use dev_get_drvdata
      drm/radeon: Use dev_get_drvdata where possible
      drm/qxl: Use dev_get_drvdata where possible
      drm/bochs: Use dev_get_drvdata
      video: fbdev: sm712fb: Use dev_get_drvdata
      video: fbdev: radeonfb: Use dev_get_drvdata
      drm/hisilicon: Use dev_get_drvdata

Colin Ian King (13):
      drm/mgag200: add in missing { } around if block
      fbmem: remove redundant assignment to err
      drm/amd/display: fix a missing null check on a failed kzalloc
      drm/amd/powerplay: fix off-by-one upper bounds limit checks
      drm/amd/powerplay: fix a few spelling mistakes
      drm/amdgpu: fix unsigned variable instance compared to less than zero
      drm/amd/powerplay: remove redundant duplicated return check
      drm/amdgpu/powerplay: fix spelling mistake "unsuported" -> "unsupport=
ed"
      drm/panel: tpo-td043mtea1: remove redundant assignment
      drm/amdgpu/powerplay: remove redundant assignment to variable baco_st=
ate
      drm/amd/display: fix a potential null pointer dereference
      drm/nouveau/bios/init: fix spelling mistake "CONDITON" -> "CONDITION"
      drm/amdgpu: fix spelling mistake "jumpimng" -> "jumping"

Da Lv (1):
      drm: kirin: Fix for hikey620 display offset problem

Dale Zhao (1):
      drm/amd/display: handle active dongle port type is DP++ or DP case

Dan Carpenter (2):
      drm/i915: Fix some NULL vs IS_ERR() conditions
      drm/amd/powerplay: Fix an off by one in navi10_get_smu_msg_index()

Daniel Vetter (73):
      drm/prime: Shuffle functions.
      drm/prime: Update docs
      drm/prime: Unconditionally set up the prime file private
      drm/prime: Make DRIVER_PRIME a no-op
      drm/prime: Actually remove DRIVER_PRIME everywhere
      drm/arm/komeda: Remove DRIVER_HAVE_IRQ
      drm/omapdrm: drop fb_debug_enter/leave
      drm/prime: Align gem_prime_export with obj_funcs.export
      drm/ioctl: Ditch DRM_UNLOCKED except for the legacy vblank ioctl
      drm/arc: Drop drm_gem_prime_export/import
      drm/arm: Drop drm_gem_prime_export/import
      drm/atmel: Drop drm_gem_prime_export/import
      drm/etnaviv: Drop drm_gem_prime_export/import
      drm/exynos: Drop drm_gem_prime_export
      drm/fsl-dcu: Drop drm_gem_prime_export/import
      drm/hisilicon: Drop drm_gem_prime_export/import
      drm/imx: Drop drm_gem_prime_export/import
      drm/mcde: Drop drm_gem_prime_export/import
      drm/mtk: Drop drm_gem_prime_export/import
      drm/meson: Drop drm_gem_prime_export/import
      drm/msm: Drop drm_gem_prime_export/import
      drm/mxsfb: Drop drm_gem_prime_export/import
      drm/nouveau: Drop drm_gem_prime_export/import
      drm/pl111: Drop drm_gem_prime_export/import
      drm/qxl: Drop drm_gem_prime_export/import
      drm/rcar-du: Drop drm_gem_prime_export/import
      drm/rockchip: Drop drm_gem_prime_export/import
      drm/shmob: Drop drm_gem_prime_export/import
      drm/sti: Drop drm_gem_prime_export/import
      drm/stm: Drop drm_gem_prime_export/import
      drm/tilcdc: Drop drm_gem_prime_export/import
      drm/tve2000: Drop drm_gem_prime_export/import
      drm/vboxvideo: Drop drm_gem_prime_export/import
      drm/vc3: Drop drm_gem_prime_import
      drm/radeon: Drop drm_gem_prime_import
      drm/vgem: Drop drm_gem_prime_export
      drm/virtio: Drop drm_gem_prime_export/import
      drm/xen: Drop drm_gem_prime_export/import
      drm/zte: Drop drm_gem_prime_export/import
      drm/vram-helper: Drop drm_gem_prime_export/import
      drm/prime: automatically set gem_obj->resv on import
      drm/vgem: Ditch attach trickery in the fence ioctl
      drm/lima: Drop resv argument from lima_bo_create_struct
      drm/mediatek: Use drm_atomic_helper_wait_for_fences
      drm/panfrost: don't set gem_obj->resv for prime import anymore
      drm/vc4: Don set gem_obj->resv in prime import anymore
      drm/todo: remove gem_prime_import/export todo
      drm/todo: Update backlight todo
      drm/todo: Update mmap todo
      drm/todo: Add new debugfs todo
      drm/etnaviv: Drop resv argument from etnaviv_gem_new_impl
      drm/msm: Drop robj from msm_gem_new_impl
      drm/vkms: Fix crc worker races
      drm/vkms: Use spin_lock_irq in process context
      drm/vkms: Rename vkms_output.state_lock to crc_lock
      drm/vkms: Add our own commit_tail
      drm/vkms: flush crc workers earlier in commit flow
      drm/vkms: Dont flush crc worker when we change crc status
      drm/vkms: No _irqsave within spin_lock_irq needed
      drm/vkms: totally reworked crc data tracking
      drm/vkms: No need for ->pages_lock in crc work anymore
      drm/fb-helper: use gem_bo.resv, not dma_buf.resv in prepare_fb
      drm/msm: Use drm_gem_fb_prepare_fb
      drm/vc4: Use drm_gem_fb_prepare_fb
      drm/vmwgfx: Don't look at state->allow_modeset
      drm/kms: Catch mode_object lifetime errors
      drm/doc: Document kapi doc expectations
      drm/i915: Fix up broken merge
      fbdev: Ditch fb_edid_add_monspecs
      drm/radeon: Fill out gem_object->resv
      drm/nouveau: Fill out gem_object->resv
      drm/amdgpu: Fill out gem_object->resv
      drm/prime: Ditch gem_prime_res_obj hook

Daniele Ceraolo Spurio (51):
      drm/i915: use vfuncs for reg_read/write_fw_domains
      drm/i915: kill uncore_sanitize
      drm/i915: kill uncore_to_i915
      drm/i915: skip forcewake actions on forcewake-less uncore
      drm/i915: dynamically allocate forcewake domains
      drm/i915/gvt: decouple check_vgpu() from uncore_init()
      drm/i915/guc: reorder enable/disable communication steps
      drm/i915/guc: handle GuC messages received with CTB disabled
      drm/i915/guc: Simplify guc client
      drm/i915/tgl: add initial Tiger Lake definitions
      drm/i915/uc: replace uc init/fini misc
      drm/i915/uc: introduce intel_uc_fw_supported
      drm/i915/guc: move guc irq functions to intel_guc parameter
      drm/i915/guc: unify guc irq handling
      drm/i915/uc: move GuC and HuC files under gt/uc/
      drm/i915/uc: move GuC/HuC inside intel_gt under a new intel_uc
      drm/i915/uc: Move intel functions to intel_uc
      drm/i915/uc: prefer intel_gt over i915 in GuC/HuC paths
      drm/i915/guc: prefer intel_gt in guc interrupt functions
      drm/i915/uc: kill <g,h>uc_to_i915
      drm/i915/uc: Gt-fy uc reset
      drm/i915/uc: Sanitize uC when GT is sanitized
      drm/i915/huc: fix status check
      drm/i915/guc: Set GuC init params only once
      drm/i915/uc: Unify uC platform check
      drm/i915: Fix handling of non-supported uC
      drm/i915/uc: Unify uC FW selection
      drm/i915/uc: Unify uc_fw status tracking
      drm/i915/uc: Move xfer rsa logic to common function
      drm/i915/huc: Copy huc rsa only once
      drm/i915/uc: Plumb the gt through fw_upload
      drm/i915/uc: Unify uC firmware upload
      drm/i915/guc: init submission structures as part of guc_init
      drm/i915/uc: Don't enable communication twice on resume
      drm/i915/uc: Move uC WOPCM setup in uc_init_hw
      drm/i915/gt: Move gt_cleanup_early out of gem_cleanup_early
      drm/i915/uc: Move uC early functions inside the GT ones
      drm/i915/gt: Introduce intel_gt_runtime_suspend/resume
      drm/i915: split out uncore_mmio_debug
      drm/i915/guc: keep breadcrumb irq always enabled
      drm/i915: drop engine_pin/unpin_breadcrumbs_irq
      drm/i915/guc: Remove client->submissions
      drm/i915: Move i915_power_well_id out of i915_reg.h
      drm/i915: Move engine IDs out of i915_reg.h
      drm/i915: Move gmbus definitions out of i915_reg.h
      drm/i915: Wrappers for display register waits
      drm/i915/tgl: add Gen12 default indirect ctx offset
      drm/i915/tgl: add GEN12_MAX_CONTEXT_HW_ID
      drm/i915/tgl: Gen12 csb support
      drm/i915/tgl: Gen12 render context size
      drm/i915: Dynamically allocate s0ix struct for VLV

Dariusz Marcinkiewicz (2):
      drm: dw-hdmi: use cec_notifier_conn_(un)register
      dw-hdmi-cec: use cec_notifier_cec_adap_(un)register

Dave Airlie (20):
      Merge tag 'drm-intel-next-2019-07-30' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2019-08-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-next-5.4-2019-08-09' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'vmwgfx-next' of
git://people.freedesktop.org/~thomash/linux into drm-next
      Merge tag 'drm-misc-next-2019-08-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'du-next-20190816' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge branch 'linux-5.4' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'drm-intel-next-2019-08-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'imx-drm-next-2019-08-23' of
git://git.pengutronix.de/pza/linux into drm-next
      Merge tag 'drm-hisilicon-hibmc-next-2019-08-26' of
https://github.com/xin3liang/linux into drm-next
      Merge tag 'drm-misc-next-2019-08-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-next-5.4-2019-08-23' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'exynos-drm-next-for-v5.4' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-next
      Merge tag 'drm-next-5.4-2019-08-30' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge tag 'drm-msm-next-2019-09-06' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'drm-misc-next-fixes-2019-09-06' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-09-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-5.4' of git://github.com/skeggsb/linux into drm-n=
ext

David Francis (8):
      drm/amd/display: Update drm_dsc to reflect native 4.2.0 DSC spec
      drm/amd/display: Remove drm_dsc_dc.c
      Revert "drm/amd/display: skip dsc config for navi10 bring up"
      Revert "drm/amd/display: navi10 bring up skip dsc encoder config"
      Revert "drm/amd/display: add global master update lock for DCN2"
      Revert "drm/amd/display: Fix underscan not using proper scaling"
      drm/amd/display: Enable SST DSC in DM
      drm/amd/display: MST topology debugfs

David Galiffi (3):
      drm/amd/display: Add ability to set preferred link training parameter=
s.
      drm/amd/display: Incorrect Read Interval Time For CR Sequence
      drm/amd/display: Synchronous DisplayPort Link Training

Deepak Rawat (2):
      drm/vmwgfx: Add debug message for layout change ioctl
      drm/vmwgfx: Use VMW_DEBUG_KMS for vmwgfx mode-setting user errors

Denis Efremov (2):
      drm/client: remove the exporting of drm_client_close
      drm/msm: remove unlikely() from WARN_ON() conditions

Dennis Li (6):
      drm/amd/include: add bitfield define for EDC registers
      drm/amd/include: add define of TCP_EDC_CNT_NEW
      drm/amdgpu: add define for gfx ras subblock
      drm/amdgpu: add RAS callback for gfx
      drm/amdgpu: support gfx ras error injection and err_cnt query
      drm/amdgpu: disable inject for failed subblocks of gfx

Derek Lai (3):
      drm/amd/display: Read max down spread
      drm/amd/display: allocate 4 ddc engines for RV2
      drm/amd/display: Use res_cap to acquire i2c instead of pipe count

Dhinakaran Pandiyan (1):
      drm/i915/vbt: Fix VBT parsing for the PSR section

Dingchen Zhang (3):
      drm/amd/display: add functionality to grab DPRX CRC entries.
      drm/amd/display: add functionality to get pipe CRC source.
      drm/amd/display: add pipe CRC sources without disabling dithering.

Dmytro Laktyushkin (16):
      drm/amd/display: fix dsc disable
      drm/amd/display: Set default block_size, even in unexpected cases
      drm/amd/display: add hdmi2.1 dsc pps packet programming
      drm/amd/display: Remove dsc disable_ich flag programming.
      drm/amd/display: use min disp and dpp clk debug option for dcn2
      drm/amd/display: add dcc programming for dual plane
      drm/amd/display: make firmware info only load once during dc_bios cre=
ate
      drm/amd/display: update optc odm interface for more than 2 opps
      drm/amd/display: fix dcn20 global sync dml param extraction
      drm/amd/display: fix calc_pll_max_vco_construct
      drm/amd/display: re structure odm to allow 4 to 1 support
      drm/amd/display: fix dp stream enable
      drm/amd/display: fix odm pipe copy
      drm/amd/display: fix dcn20 odm dpp programming
      drm/amd/display: fix odm stream release
      drm/amd/display: fix odm validation

Douglas Anderson (7):
      drm/panel: simple: Use display_timing for Innolux n116bge
      drm/panel: simple: Use display_timing for AUO b101ean01
      drm/panel: simple: document panel_desc; rename a few functions
      video: of: display_timing: Add of_node_put() in of_get_display_timing=
()
      video: of: display_timing: Don't yell if no timing node is present
      drm: panel-lvds: Spout an error if of_get_display_timing() gives an e=
rror
      video: amba-clcd: Spout an error if of_get_display_timing() gives an =
error

Emil Velikov (17):
      drm/tegra: remove irrelevant DRM_UNLOCKED flag
      drm/i915: remove irrelevant DRM_UNLOCKED flag
      drm/nouveau: remove open-coded drm_invalid_op()
      vmwgfx: drop empty lastclose stub
      drm/vmgfx: kill off unused init_mutex
      drm/vmwgfx: use core drm to extend/check vmw_execbuf_ioctl
      drm/etnaviv: drop DRM_AUTH usage from the driver
      drm/exynos: drop DRM_AUTH from DRM_RENDER_ALLOW ioctls
      drm/lima: drop DRM_AUTH usage from the driver
      drm/msm: drop DRM_AUTH usage from the driver
      drm/nouveau: drop DRM_AUTH from DRM_RENDER_ALLOW ioctls
      drm/omap: drop DRM_AUTH from DRM_RENDER_ALLOW ioctls
      drm/vgem: drop DRM_AUTH usage from the driver
      drm/virtio: drop DRM_AUTH usage from the driver
      drm/nouveau: remove open-coded drm_invalid_op()
      drm/msm: drop DRM_AUTH usage from the driver
      drm/vgem: drop DRM_AUTH usage from the driver

Eric Bernstein (1):
      drm/amd/display: Use helper for determining HDMI signal

Eric Yang (6):
      drm/amd/display: move bw calc code into helpers
      drm/amd/display: early return when pipe_cnt is 0 in bw validation
      drm/amd/display: put back front end initialization sequence
      drm/amd/display: do not read link setting if edp not connected
      drm/amd/display: fix mpcc assert condition
      drm/amd/display: Enable type C hotplug

Evan Quan (48):
      drm/amd/powerplay: correct SW SMU valid mapping check
      drm/amd/powerplay: input check for unsupported message/clock index
      drm/amd/powerplay: report bootup clock as max supported on dpm disabl=
ed
      drm/amd/powerplay: no pptable transfer and dpms enabled with "dpm=3D0=
"
      drm/amd/powerplay: some cosmetic fixes
      drm/amd/powerplay: minor fixes around SW SMU power and fan setting
      drm/amd/powerplay: fix null pointer dereference around dpm state rela=
tes
      drm/amd/powerplay: enable SW SMU reset functionality
      drm/amd/powerplay: add smcdpminfo table v4_6 support
      drm/amd/powerplay: add SW SMU interface for dumping pptable out (v2)
      drm/amd/powerplay: update smu11_driver_if_arcturus.h
      drm/amd/powerplay: update arcturus_ppsmc.h
      drm/amd/powerplay: update arcturus_ppt.c/h V3
      drm/amd/powerplay: enable SW SMU routine support for arcturus
      drm/amd/powerplay: initialize arcturus MP1 and THM base address
      drm/amd/powerplay: enable arcturus powerplay
      drm/amdgpu: correct VCN powergate routine for acturus
      drm/amd/powerplay: hold on the arcturus gfx dpm support in driver
      drm/amd/powerplay: add new sensor type for VCN powergate status
      drm/amd/powerplay: support VCN powergate status retrieval on Raven
      drm/amd/powerplay: support VCN powergate status retrieval for SW SMU
      drm/amd/powerplay: correct Navi10 VCN powergate control (v2)
      drm/amd/powerplay: correct UVD/VCE/VCN power status retrieval
      drm/amd/powerplay: init arcturus SMU metrics table on bootup
      drm/amd/powerplay: support sensor reading on arcturus
      drm/amd/powerplay: support real-time clock retrieval on arcturus
      drm/amd/powerplay: support fan speed retrieval on arcturus
      drm/amd/powerplay: add missing arcturus feature maps
      drm/amd/powerplay: correct the bitmask used in arcturus
      drm/amd/powerplay: fix arcturus real-time clock frequency retrieval
      drm/amd/powerplay: support UMD PSTATE settings on arcturus
      drm/amd/powerplay: correct arcturus current clock level calculation
      drm/amd/powerplay: make power limit retrieval as asic specific
      drm/amd/powerplay: determine the features to enable by pptable only
      drm/amd/powerplay: guard consistency between CPU copy and local VRAM
      drm/amd/powerplay: support power profile retrieval and setting on arc=
turus
      drm/amd/powerplay: enable SW SMU power profile switch support in KFD
      drm/amd/powerplay: correct navi10 vcn powergate
      drm/amd/powerplay: skip pcie params override on Arcturus V2
      drm/amd/powerplay: check before issuing messages for max
sustainable clocks
      drm/amd/powerplay: update Arcturus smc fw and driver interface header
      drm/amd/powerplay: expose supported clock domains only through sysfs
      drm/amd/powerplay: get bootup fclk value
      drm/amd/powerplay: set Arcturus default fclk as bootup value on
dpm disabled
      drm/amd/powerplay: correct SW smu11 thermal range settings
      drm/amd/powerplay: correct typo
      drm/amd/powerplay: correct Vega20 dpm level related settings
      drm/amd/powerplay: correct the pp_feature output on Arcturus

Fabio Estevam (2):
      drm/bridge: Improve the help text for DRM_ANALOGIX_ANX78XX
      drm/etnaviv: Use devm_platform_ioremap_resource()

Fabrizio Castro (1):
      drm: rcar-du: lvds: Fix bridge_to_rcar_lvds

Fatemeh Darbehani (2):
      drm/amd/display: Change min_h_sync_width from 8 to 4
      drm/amd/display: Add SMU version field to clk_mgr_internal

Feifei Xu (2):
      drm/amdgpu: add pci DID for Arcturus GL-XL.
      drm/amdgpu: Set no-retry as default.

Felix Kuehling (4):
      drm/ttm: Add release_notify callback to ttm_bo_driver
      drm/amdgpu: Add flag to wipe VRAM on release
      drm/amdgpu: Implement VRAM wipe on release
      drm/amdgpu: Mark KFD VRAM allocations for wipe on release

Frank.Min (4):
      drm/amdgpu: disable agp for sriov
      drm/amdgpu: unity mc base address for arcturus
      amd/amdgpu: add Arcturus vf DID support
      amd/amdkfd: add Arcturus vf DID support

Fuqian Huang (2):
      drm/ttm: use the same attributes when freeing d_page->vaddr
      video: fbdev-MMP: Remove call to memset after dma_alloc_coherent

Gang Ba (2):
      drm/amd/amdgpu: Update VM function pointer
      Revert "drm/amdgpu: free up the first paging queue v2"

Gao, Fred (3):
      drm/i915/gvt: Utility for valid command length check
      drm/i915/gvt: Add MI command valid length check
      drm/i915/gvt: Add valid length check for MI variable commands

Geert Uytterhoeven (1):
      drm/bridge: dumb-vga-dac: Fix dereferencing -ENODEV DDC channel

Gerd Hoffmann (17):
      drm/ttm: add gem base object
      drm/vram: use embedded gem object
      drm/qxl: use embedded gem object
      drm/radeon: use embedded gem object
      drm/amdgpu: use embedded gem object
      drm/nouveau: use embedded gem object
      drm/ttm: use gem reservation object
      drm/ttm: use gem vma_node
      drm/ttm: set both resv and base.resv pointers
      drm/ttm: switch ttm core from bo->resv to bo->base.resv
      drm/radeon: switch driver from bo->resv to bo->base.resv
      drm/vmwgfx: switch driver from bo->resv to bo->base.resv
      drm/amdgpu: switch driver from bo->resv to bo->base.resv
      drm/nouveau: switch driver from bo->resv to bo->base.resv
      drm/qxl: switch driver from bo->resv to bo->base.resv
      drm/virtio: switch driver from bo->resv to bo->base.resv
      drm/ttm: drop ttm_buffer_object->resv

Greg Kroah-Hartman (2):
      drm/i915/gvt: no need to check return value of debugfs_create functio=
ns
      omapdrm: no need to check return value of debugfs_create functions

Guchun Chen (2):
      drm/amdgpu: add check to avoid array bound issue
      drm/amdgpu: correct ras error count type

Guido G=C3=BCnther (9):
      MAINTAINERS: Add Purism mail alias as reviewer for their devkit's pan=
el
      drm/panel: jh057n00900: Don't use magic constant
      dt-bindings: display/panel: jh057n00900: Document power supply proper=
ties
      drm/panel: jh057n00900: Add regulator support
      drm/panel: jh057n00900: Move panel DSI init to enable()
      drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable(=
)
      drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
      drm/panel: jh057n00900: Use drm_panel_{unprepare, disable} consistent=
ly
      drm/imx: Drop unused imx-ipuv3-crtc.o build

Gustavo A. R. Silva (7):
      drm: sti: Mark expected switch fall-throughs
      drm/i915/kvmgt: Use struct_size() helper
      drm/komeda: Fix potential integer overflow in
komeda_crtc_update_clock_ratio
      video: fbdev: pvr2fb: remove unnecessary comparison of unsigned
integer with < 0
      video: fbdev/mmp/core: Use struct_size() in kzalloc()
      drm/nouveau/mmu: use struct_size() helper
      drm/msm: Use struct_size() helper

H. Nikolaus Schaller (5):
      dt-bindings: drm/panel: simple: add ortustech, com37h3m05dtc panel
      dt-bindings: drm/panel: simple: add ortustech, com37h3m99dtc panel
      dt-bindings: drm/panel: simple: add sharp, lq070y3dg3b panel
      drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
      drm/panel: simple: Add Ortustech COM37H3M panel support

Hans de Goede (6):
      drm: Add Grain Media GM12U320 driver v2
      drm: gm12u320: Some minor cleanups
      drm: gm12u320: Use DRM_DEV_ERROR everywhere
      drm: gm12u320: Do not take a mutex from a wait_event condition
      drm: gm12u320: Add -ENODEV to list of errors to ignore
      efifb: BGRT: Improve efifb_bgrt_sanity_check

Hariprasad Kelam (3):
      gpu: drm: amd: powerplay: Remove logically dead code
      drm/nouveau/dispnv04: subdev/bios.h is included more than once
      drm/nouveau: fix nvif/device.h is included more than once

Harmanprit Tatla (1):
      drm/amd/display: No audio endpoint for Dell MST display

Harry Wentland (1):
      drm/amd/display: Remove unnecessary NULL check in
set_preferred_link_settings

Hawking Zhang (21):
      drm/amdgpu: add arct sdma golden settings
      drm/amdgpu: add arct gc golden settings
      drm/amdgpu: init arct external rev id
      drm/amdgpu: keep stolen memory for arct
      drm/amdgpu: init gds config for arct
      drm/amdgpu: skip gfx 9 common golden settings for arct
      drm/amdgpu: do not create ras debugfs/sysfs node for ASICs that
don't have ras ability
      drm/amdgpu: disable GFX RAS by default
      drm/amdgpu: only allow error injection to UMC IP block
      drm/amdgpu: drop ras self test
      drm/amdgpu: set sdma irq src num according to sdma instances
      drm/amdgpu: correct irq type used for sdma ecc
      drm/amdgpu: move some ras data structure to amdgpu_ras.h
      drm/amdgpu: init RSMU and UMC ip base address for vega20
      drm/amdgpu: add amdgpu_umc_functions structure
      drm/amdgpu: add rsmu v_0_0_2 ip headers
      drm/amdgpu: add umc v6_1_1 IP headers
      drm/amdgpu: add umc v6_1 query error count support
      drm/amdgpu: init umc v6_1 functions for vega20
      drm/amdgpu: querry umc error count
      drm/amdgpu: correct in_suspend setting for navi series

Huang Rui (16):
      drm/amdgpu: add renoir header files (v2)
      drm/amdgpu: add renoir asic_type enum
      drm/amdgpu: add renoir support for gpu_info and ip block setting
      drm/amdgpu: add soc15 common ip block support for renoir
      drm/amdgpu: add gmc v9 supports for renoir
      drm/amdgpu: set fw load type for renoir
      drm/amdgpu: add gfx support for renoir
      drm/amdgpu: add sdma support for renoir
      drm/amdgpu: set ip blocks for renoir
      drm/amdgpu: add renoir pci id
      drm/amdgpu: add gfx golden settings for renoir (v2)
      drm/amdgpu: add sdma golden settings for renoir
      drm/amdgpu: use direct loading on renoir vcn for the moment
      drm/amdgpu: skip mec2 jump table loading for renoir
      drm/amdgpu: skip dpm init for renoir
      drm/amd/powerplay: powerup sdma/vcn for all apu series

Ilia Mirkin (4):
      drm/nouveau/kms/nv50-: add fp16 scanout support
      drm/nouveau/kms/nv50-: remove overlay alpha formats
      drm/nouveau/kms/gf119-: add ctm property support
      drm/nouveau/kms/nv50-: enable modern color management properties

Ilya Bakoulin (9):
      drm/amd/display: Expose enc2_set_dynamic_metadata
      drm/amd/display: Check for valid stream_encode
      drm/amd/display: Fix some HUBP programming issues
      drm/amd/display: Cache the use_pitch_c conditional
      drm/amd/display: Fixes for some MPO cases
      drm/amd/display: Update DML parameters
      drm/amd/display: HUBP/HUBBUB register programming fixes
      drm/amd/display: Fix type of ODMCombineType field
      drm/amd/display: set Hratio and VRatio in dml

Imre Deak (29):
      drm/i915/icl: Add support to read out the TBT PLL HW state
      drm/i915: Tune down WARNs about TBT AUX power well enabling
      drm/i915: Move the TypeC port handling code to a separate file
      drm/i915: Sanitize the terminology used for TypeC port modes
      drm/i915: Don't enable the DDI-IO power in the TypeC TBT-alt mode
      drm/i915: Fix the TBT AUX power well enabling
      drm/i915: Use the correct AUX power domain in TypeC TBT-alt mode
      drm/i915: Unify the TypeC port notation in debug/error messages
      drm/i915: Factor out common parts from TypeC port handling functions
      drm/i915: Wait for TypeC PHY complete flag to clear in safe mode
      drm/i915: Handle the TCCOLD power-down event
      drm/i915: Sanitize the TypeC connect/detect sequences
      drm/i915: Fix the TypeC port mode sanitization during loading/resume
      drm/i915: Keep the TypeC port mode fixed for detect/AUX transfers
      drm/i915: Sanitize the TypeC FIA lane configuration decoding
      drm/i915: Sanitize the shared DPLL reserve/release interface
      drm/i915: Sanitize the shared DPLL find/reference interface
      drm/i915/icl: Split getting the DPLLs to port type specific functions
      drm/i915/icl: Reserve all required PLLs for TypeC ports
      drm/i915: Keep the TypeC port mode fixed when the port is active
      drm/i915: Add state verification for the TypeC port mode
      drm/i915: Remove unneeded disconnect in TypeC legacy port mode
      drm/i915: WARN about invalid lane reversal in TBT-alt/DP-alt modes
      drm/i915: Clear the shared PLL from the put_dplls() hook
      drm/i915/icl: Clear the shared port PLLs from the new crtc state
      drm/i915/tgl: Add power well support
      drm/i915: Add support for retrying hotplug
      drm/i915: Fix HW readout for crtc_clock in HDMI mode
      drm/i915: Sanitize PHY state during display core uninit

Jack Xiao (3):
      drm/amdgpu/gfx10: fix programming of SC_HIZ_TILE_FIFO_SIZE field
      drm/amdgpu: enable gfxoff code path for navi14
      drm/amdgpu: correct smu rlc handshake enablement bit

Jaehyun Chung (3):
      drm/amd/display: Add work-around option to skip DCN20 clock updates
      drm/amd/display: Add VM page fault handle implementation
      drm/amd/display: Enable HW rotation

James Zhu (12):
      drm/amdgpu: Enable VCN on navi14
      drm/amdgpu: Clear build undefined warning
      drm/amdgpu/: add clientID for 2nd vcn instance
      drm/amdgpu/: add ucodeID for 2nd vcn instance
      drm/amdgpu/: add doorbell assignment for 2nd vcn instance
      drm/amdgpu/: increase AMDGPU_MAX_RINGS to add 2nd vcn instance
      drm/amdgpu: add vcn nbio doorbell range setting for 2nd vcn instance
      drm/amdgpu: modify amdgpu_vcn to support multiple instances
      drm/amdgpu: add multiple instances support for Arcturus
      drm/amdgpu: add harvest support for Arcturus
      drm/amdgpu:add all VCN rings into schedule request queue
      drm/amdgpu: use VCN firmware offset for cache window

Jani Nikula (42):
      drm/i915: prefix header search path with $(srctree)/
      drm/i915: add header search path to subdir Makefiles
      drm/i915: make i915_fixed.h self-contained
      drm/i915: make i915_globals.h self-contained
      drm/i915: make i915_pvinfo.h self-contained
      drm/i915: make i915_vgpu.h self-contained
      drm/i915: make intel_guc_ct.h self-contained
      drm/i915: make intel_guc_fwif.h self-contained
      drm/i915: make intel_guc_reg.h self-contained
      drm/i915: make intel_gvt.h self-contained
      drm/i915: make intel_uc_fw.h self-contained
      drm/panel: make drm_panel.h self-contained
      drm/i915: use upstream version of header tests
      drm/i915/oa: add content to Makefile
      drm/i915/oa: update the generated files
      drm/i915: move intel_display.c function declarations
      drm/i915/sprite: un-inline icl_is_hdr_plane()
      drm/i915/irq: un-inline functions to avoid i915_drv.h include
      drm/i915/bw: make intel_atomic_get_bw_state() static
      drm/i915/mst: un-inline intel_dp_mst_encoder_active_links()
      drm/i915/tc: un-inline intel_tc_port_ref_held()
      drm/i915: avoid including intel_drv.h via i915_drv.h->i915_trace.h
      drm/i915: rename intel_drv.h to display/intel_display_types.h
      drm/i915: remove unnecessary includes of intel_display_types.h header
      drm/i915: move property enums to intel_display_types.h
      drm/i915: split out intel_pch.[ch] from i915_drv.[ch]
      drm/i915: remove unused dev_priv->no_aux_handshake
      drm/i915: move add_taint_for_CI() to i915_utils.h
      drm/i915: move I915_STATE_WARN() and _ON() to intel_display.h
      drm/i915: move printing and load error inject to i915_utils.[ch]
      drm/i915: extract i915_perf.h from i915_drv.h
      drm/i915: extract i915_sysfs.h from i915_drv.h
      drm/i915: extract i915_suspend.h from i915_drv.h
      drm/i915: extract i915_memcpy.h from i915_drv.h
      drm/i915: extract gem/i915_gem_stolen.h from i915_drv.h
      drm/i915: extract i915_gem_shrinker.h from i915_drv.h
      drm/i915/dp: stylistic cleanup around hdcp2_msg_data
      drm/i915/dp: avoid shadowing variables
      drm/i915/dp: make hdcp2_dp_msg_data const
      drm/i915/hdmi: stylistic cleanup around hdcp2_msg_data
      drm/i915/hdmi: make hdcp2_msg_data const
      drm: fix module name in edid_firmware log message

Janusz Krzysztofik (6):
      drm/i915: Drop extern qualifiers from header function prototypes
      drm/i915: Rename "_load"/"_unload" to match PCI entry points
      drm/i915: Replace "_load" with "_probe" consequently
      drm/i915: Propagate "_release" function name suffix down
      drm/i915: Propagate "_remove" function name suffix down
      drm/i915: Propagate "_probe" function name suffix down

Jason Ekstrand (1):
      drm/syncobj: Add better overview documentation for syncobj (v2)

Jay Cornwall (9):
      drm/amdkfd: Merge gfx9/arcturus trap handlers, add ACC VGPR save
      drm/amdkfd: Use SQC when TCP would fail in gfx9 context save.
      drm/amdkfd: Fix lost single step exceptions in gfx9 trap handler
      drm/amdkfd: Replace gfx10 trap handler with correct branch
      drm/amdkfd: Remove dead code from gfx8/gfx9 trap handlers
      drm/amdkfd: Fix gfx10 wave64 VGPR context restore
      drm/amdkfd: Save/restore flat_scratch_lo/hi on gfx10
      drm/amdkfd: Save/restore vcc on gfx10
      drm/amdkfd: Extend CU mask to 8 SEs (v3)

Jean Delvare (2):
      drm/amd/amdgpu: hide voltage and power sensors on SI and KV parts
      drm/amdgpu/si: fix ASIC tests

Jean-Jacques Hiblot (1):
      drm/omap: Add 'alpha' and 'pixel blend mode' plane properties

Jeffrey Hugo (5):
      dt-bindings: panel: Add Sharp LD-D5116Z01B
      drm/panel: simple: Add support for Sharp LD-D5116Z01B panel
      drm/msm: Transition console to msm framebuffer
      drm/msm/mdp5: Add msm8998 support
      drm/msm/mdp5: Find correct node for creating gem address space

Jernej Skrabec (3):
      drm/sun4i: Introduce color encoding and range properties
      drm/sun4i: sun8i_csc: Simplify register writes
      drm/sun4i: sun8i-csc: Add support for color encoding and range

Jerome Brunet (8):
      drm/bridge: dw-hdmi-i2s: support more i2s format
      drm/bridge: dw-hdmi: move audio channel setup out of ahb
      drm/bridge: dw-hdmi: set channel count in the infoframes
      drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
      drm/bridge: dw-hdmi-i2s: set the channel allocation
      drm/bridge: dw-hdmi-i2s: reset audio fifo before applying new params
      drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
      drm/bridge: dw-hdmi-i2s: add .get_eld support

Jerry Han (1):
      dt-bindings: panel: Add Boe Himax8279d is 1200x1920, 4-lane
MIPI-DSI LCD panel

Jia-Ju Bai (1):
      gpu: drm: radeon: Fix a possible null-pointer dereference in
radeon_connector_set_property()

John Clements (7):
      drm/amdgpu: removed duplicate line
      drm/amdgpu: add PSP SW init support for Arcturus
      drm/amdgpu: add PSP KDB loading support for Arcturus
      drm/amdgpu: update PSP CMD fail response status print
      drm/amdgpu: disable MEC2 JT context init for Arcturus
      drm/amdgpu: extend PSP FW loading support to 8 SDMA instances
      drm/amdgpu: update SDMA V4 microcode init

John Harrison (3):
      drm/i915: Add test for invalid flag bits in whitelist entries
      drm/i915: Implement read-only support in whitelist selftest
      drm/i915: Add engine name to workaround debug print

John Keeping (1):
      drm/rockchip: fix VOP_WIN_GET macro

John Stultz (3):
      drm: kirin: Remove HISI_KIRIN_DW_DSI config option
      drm: kirin: Remove unreachable return
      drm: kirin: Move workqueue to ade_hw_ctx structure

Jonathan Kim (3):
      drm/amdgpu:  exposing fica registers to df offsets
      drm/amdgpu: add perfmon and fica atomics for df
      drm/amdgpu: adding xgmi error monitoring

Jonathan Neusch=C3=A4fer (1):
      drm/drv: Use // for comments in example code

Jordan Crouse (2):
      drm/msm: Use generic bulk clock function
      drm/msm: Remove Kconfig default

Jordan Justen (1):
      drm/i915/tgl: allow the reg_read ioctl to read the RCS TIMESTAMP regi=
ster

Joseph Gravenor (1):
      drm/amd/display: Implement voltage limitation stub

Joseph Greathouse (2):
      drm/amdgpu: Default disable GDS for compute VMIDs
      drm/amdgpu: Default disable GDS for compute+gfx

Joshua Aberback (2):
      drm/amd/display: Add debug option to disable timing sync
      drm/amd/display: Properly read LVTMA_PWRSEQ_CNTL

Joshua.Henderson@microchip.com (1):
      drm/atmel-hlcdc: set layer REP bit to enable replication logic

Josip Pavic (1):
      drm/amd/display: load iram for abm 2.3

Jos=C3=A9 Roberto de Souza (18):
      drm/i915/ehl/dsi: Enable AFE over PPI strap
      drm/i915/ehl: Add missing VECS engine
      drm/i915/icl: Add new supported CD clocks
      drm/i915/ehl: Remove unsupported cd clocks
      drm/i915/ehl: Add voltage level requirement table
      drm/i915/tgl: Check if pipe D is fused
      drm/i915/tgl: rename TRANSCODER_EDP_VDSC to use on transcoder A
      drm/i915/tgl: Update DPLL clock reference register
      drm/i915: Enable hotplug retry
      drm/i915/tgl: Update north display hotplug detection to TGL connectio=
ns
      drm/i915/ehl: Ungate DDIC and DDID
      drm/i915/tgl: Add and use new DC5 and DC6 residency counter registers
      drm/i915: Get transcoder power domain before reading its register
      drm/i915/tgl: Fix the read of the DDI that transcoder is attached to
      drm/i915/tgl: Fix missing parentheses on
TGL_TRANS_DDI_FUNC_CTL_VAL_TO_PORT
      drm/i915/bdw+: Move misc display IRQ handling to it own function
      drm/i915: Add _TRANS2()
      drm/i915/tgl: Move transcoders to pipes' powerwells

Julian Parkin (7):
      drm/amd/display: Poll for GPUVM context ready (v2)
      drm/amd/display: Fix dc_create failure handling and 666 color depths
      drm/amd/display: Clean up dynamic metadata logic
      drm/amd/display: Improve sharing of HUBBUB register lists
      drm/amd/display: Remove duplicate interface for programming FB
      drm/amd/display: Remove redundant definition of dwb_source enums
      drm/amd/display: Delete dead code in command_table_helper

Julien Masson (10):
      drm: meson: mask value when writing bits relaxed
      drm: meson: crtc: use proper macros instead of magic constants
      drm: meson: drv: use macro when initializing vpu
      drm: meson: vpp: use proper macros instead of magic constants
      drm: meson: viu: use proper macros instead of magic constants
      drm: meson: venc: use proper macros instead of magic constants
      drm: meson: global clean-up
      drm: meson: add macro used to enable HDMI PLL
      drm: meson: venc: set the correct macrovision max amplitude value
      drm: meson: use match data to detect vpu compatibility

Jun Lei (12):
      drm/amd/display: initialize p_state to proper value
      drm/amd/display: fix up HUBBUB hw programming for VM
      drm/amd/display: cap DCFCLK hardmin to 507 for NV10
      drm/amd/display: swap system aperture high/low
      drm/amd/display: populate last calculated bb state with max clocks
      drm/amd/display: support "dummy pstate"
      drm/amd/display: fixup DPP programming sequence
      drm/amd/display: wait for pending complete when enabling a plane
      drm/amd/display: clean up DML for DCN2x
      drm/amd/display: fix pipe selection logic in validate
      drm/amd/display: fix DML not calculating delivery time
      drm/amd/display: revert wait in pipelock

Jyri Sarha (1):
      drm/tilcdc: Remove obsolete crtc_mode_valid() hack

Kai-Heng Feng (1):
      drm/amdgpu: Add APTX quirk for Dell Latitude 5495

Kenneth Feng (3):
      drm/amdgpu/powerplay: provide the interface to disable uclk switch fo=
r DAL
      drm/amd/powerplay: change smu_read_sensor sequence in smu
      drm/amd/amdgpu: disable MMHUB PG for navi10

Kenneth Graunke (1):
      drm/i915: Disable SAMPLER_STATE prefetching on all Gen11 steppings.

Kent Russell (5):
      drm/amdkfd: Fix byte align on VegaM
      drm/amdgpu: Update NBIO headers to add TXCLK3/4
      drm/amdgpu: Fix pcie_bw on Vega20
      drm/powerplay: Fix Vega20 Average Power value v4
      drm/powerplay: Fix Vega20 power reading again

Kevin Wang (20):
      drm/amd/powerplay: change sysfs pp_dpm_xxx format for navi10
      drm/amd/powerplay: custom peak clock freq for navi10
      drm/amd/powerplay: remove redundancy debug log in smu
      drm/amd/powerplay: add callback function of get_thermal_temperature_r=
ange
      drm/amd/powerplay: fix temperature granularity error in smu11
      drm/amd/powerplay: move smu types to smu_types.h
      drm/amd/powerplay: add smu message name support
      drm/amd/powerplay: add smu feature name support
      drm/amd/powerplay: move smu_feature_update_enable_state to up level
      drm/amd/powerplay: implment sysfs feature status function in smu
      drm/amd/powerplay: remove redundancy debug log in smu
      drm/amd/powerplay: sort feature status index by asic feature id for s=
mu
      drm/amd/powerplay: honor hw limit on fetching metrics data for navi10
      drm/amd/powerplay: fix message of SetHardMinByFreq failed when
feature is disabled
      drm/amdgpu: fix typo error amdgput -> amdgpu
      drm/amdgpu: use exiting amdgpu_ctx_total_num_entities function
      drm/amd/powerplay: add smu_smc_read_sensor support for arcturus
      drm/amd/powerplay: fix variable type errors in smu_v11_0_setup_pptabl=
e
      drm/amd/powerplay: remove duplicate macro
smu_get_uclk_dpm_states in amdgpu_smu.h
      drm/amd/powerpaly: fix navi series custom peak level value error

Krunoslav Kovac (1):
      drm/amd/display: Optimize gamma calculations

Krzysztof Kozlowski (4):
      drm/lima: Mark 64-bit number as ULL
      drm/lima: Reduce the amount of logs on deferred probe
      drm/lima: Reduce number of PTR_ERR() calls
      drm/lima: Reduce the amount of logs on deferred probe of clocks
and reset controller

KyleMahlkuch (1):
      drm/radeon: Fix EEH during kexec

Laurent Pinchart (13):
      dt-bindings: Add vendor prefix for LG Display
      dt-bindings: Add legacy 'toppoly' vendor prefix
      dt-bindings: display: panel: Add bindings for NEC NL8048HL11 panel
      drm/panel: Add driver for the LG Philips LB035Q02 panel
      drm/panel: Add driver for the NEC NL8048HL11 panel
      drm/panel: Add driver for the Sharp LS037V7DW01 panel
      drm/panel: Add driver for the Sony ACX565AKM panel
      drm/panel: Add driver for the Toppoly TD028TTEC1 panel
      drm/panel: Add driver for the Toppoly TD043MTEA1 panel
      drm: Don't include drm/drm_encoder_slave.h when not needed
      drm: Remove bridge support from legacy helpers
      video: omapfb2: Make standard and custom panel drivers mutually exclu=
sive
      drm/omap: displays: Remove unused panel drivers

Le Ma (63):
      drm/amdgpu: add mmhub 9.4.1 header files for Acrturus
      drm/amdgpu: add sdma 4.2.2 header files for Arcturus
      drm/amdgpu: add Arcturus ip_offset header (v3)
      drm/amdgpu: add Arcturus asic type
      drm/amdgpu: add gmc basic support for Arcturus
      drm/amdgpu: rename AMDGPU_GFXHUB/MMHUB macro with hub number
      drm/amdgpu: add new member in amdgpu_device for vmhub counts per asic=
 chip
      drm/amdgpu: add one more mmhub instance for Arcturus (v2)
      drm/amdgpu: add mmhub v9.4.1 block for Arcturus (v2)
      drm/amdgpu: use new mmhub interfaces for Arcturus
      drm/amdgpu: add SDMA 2~7 interrupt client id for Arcturus
      drm/amdgpu: add SDMA 2~7 ip block type
      drm/amdgpu: increase max number of ip base instances to 8
      drm/amdgpu: dynamically initialize IP offset for Arcturus
      drm/amdgpu: add VMC1 interrupt client id for Arcturus
      drm/amdgpu: update vmc interrupt routine to support 3 vmhubs
      drm/amdgpu: reorganize sdma v4 code to support more instances
      drm/amdgpu: specify sdma instance 5~7 with second mmhub type
      drm/amdgpu: support hdp flush for more sdma instances
      drm/amdgpu/soc15: add Arcturus common ip blocks
      drm/amdgpu: add to set Arcturus ip blocks
      drm/amdgpu: set Arcturus fw load type as direct
      drm/amdgpu/dce_virtual: add Arcturus virtual display support
      drm/amdgpu: add support for Arcturus firmware
      drm/amdgpu: add gfx config for Arcturus
      drm/amdgpu: add number of mec for Arcturus
      drm/amdgpu: add to set rlc funcs for Arcturus
      drm/amdgpu: skip to get 3D engine clockgating state for Arcturus
      drm/amdgpu: skip pasid mapping for second mmhub on Arcturus
      drm/amdgpu: add Arcturus gpu info firmware
      drm/amdgpu: optimize gfx9 init_microcode function
      drm/amdgpu: skip load cp gfx firmware for Arcturus
      drm/amdgpu: skip all gfx ring settings for Arcturus
      drm/amdgpu: support sdma 2~7 doorbell range register offset
      drm/amdgpu: correct Arcturus SDMA address space base index
      drm/amdgpu: enable 8 SDMA instances for Arcturus
      drm/amdgpu: add Arcturus chip_name for init sdma microcode
      drm/amdgpu: correct programming of ih_chicken for Arcturus
      drm/amdgpu: add paging queue support for 8 SDMA instances on Arcturus
      drm/amdgpu: declare sdma firmware binary files for Arcturus
      drm/amdgpu: skip get/update xgmi topology info when no psp exists
      drm/amdgpu: set system aperture to cover whole FB region in mmhub v9.=
4
      drm/amdgpu: correct ip for mmHDP_READ_CACHE_INVALIDATE register acces=
s
      drm/amdgpu: assign fb_start/end in mmhub v9.4 interface
      drm/amdgpu: clean up nonexistent firmware declaration for Arcturus
      drm/amdgpu: limit sdma instances to 2 for Arcturus in BU phase
      drm/amdgpu: enable all 8 sdma instances for Arcturus silicon
      drm/amd/include: adjust base offset of SMUIO and THM for Arcturus
      drm/amdgpu: update more sdma instances irq support
      drm/amdgpu: support get_cu_info for Arcturus
      drm/amdgpu: add gfx clock gating for Arcturus
      drm/amdgpu: enable gfx clock gating for Arcturus
      drm/amdgpu: add hdp clock gating for Arcturus
      drm/amdgpu: enable hdp clock gating for Arcturus
      drm/amdgpu: support sdma clock gating for more instances
      drm/amdgpu: add sdma clock gating for Arcturus
      drm/amdgpu: enable sdma clock gating for Arcturus
      drm/amdgpu: split athub clock gating from mmhub
      drm/amdgpu: add GFX_CP_LS flag to Arcturus
      drm/amdgpu: increase CGCG gfx idle threshold for Arcturus
      drm/amdgpu: add mmhub clock gating for Arcturus
      drm/amdgpu: enable mmhub clock gating for Arcturus
      drm/amdgpu/powerplay: update Arcturus smu version in new place

Lee Shawn C (1):
      drm/i915: Check backlight type while doing eDP backlight initializait=
on

Leo Li (8):
      drm/dp: Use non-cyclic idr
      drm/nouveau: Use connector kdev as aux device parent
      drm/amd/display: Use connector kdev as aux device parent
      drm/amd/display: Implement MST Aux device registration
      drm/amd/display: Use switch table for dc_to_smu_clock_type
      drm/amd/display: Add ASICREV_IS_NAVI macros
      drm/amdgpu: Add nv12 DC ip block
      drm/amd/display: Load NV12 SOC BB from firmware

Leo Liu (18):
      drm/amdgpu: add VCN2.5 headers
      drm/amdgpu/VCN2: put IB internal registers offset to structure
      drm/amdgpu/VCN2: expose rings functions
      drm/amdgpu: add VCN2.5 basic supports
      drm/amdgpu: add VCN2.5 VCPU start and stop
      drm/amdgpu: add Arcturus to the VCN family
      drm/amdgpu/VCN2.5: set decode ring functions
      drm/amdgpu/VCN2.5: set encode ring functions
      drm/amdgpu: add JPEG2.5 HW start and stop
      drm/amdgpu/VCN2.5: set JPEG decode ring functions
      drm/amdgpu: enable VCN2.5 on Arcturus
      drm/amdgpu: add vcn doorbell range function to nbio7.4 (v2)
      drm/amdgpu: enable the Doorbell support for VCN2.5
      drm/amdgpu: use VCN firmware offset for cache window
      drm/amdgpu: enable Renoir VCN firmware loading
      drm/amdgpu: enable Doorbell support for Renoir (v2)
      drm/amdgpu: add VCN2.0 to Renoir IP blocks
      drm/amdgpu/powerplay: add Renoir VCN power management

Lewis Huang (2):
      drm/amd/display: Add debug entry to destroy disconnected edp link
      drm/amd/display: reprogram VM config when system resume

Likun Gao (1):
      drm/amdgpu: pin the csb buffer on hw init for gfx v8

Linus Walleij (14):
      drm/mcde: Fix uninitialized variable
      drm/pl111: Deprecate the pads from the DT binding
      drm/pl111: Drop special pads config check
      drm/bridge/megachips: Drop GPIO header
      drm/bridge/nxp-ptn3460: Drop legacy GPIO headers
      drm/bridge/parade: Drop legacy GPIO header
      drm/pl111: Support grayscale
      drm/panel: simple: Add TI nspire panel bindings
      drm/panel: simple: Support TI nspire panels
      drm/msm/mdp4: Drop unused GPIO include
      drm/msm/dsi: Drop unused GPIO includes
      drm/msm/dpu: Drop unused GPIO code
      drm/msm/hdmi: Convert to use GPIO descriptors
      drm/mcde: Fix DSI transfers

Lionel Landwerlin (8):
      drm/i915/perf: fix ICL perf register offsets
      drm/i915: fix whitelist selftests with readonly registers
      drm/i915: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/icl: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/perf: ensure we keep a reference on the driver
      drm/i915: enumerate scratch fields
      drm/i915: add infrastructure to hold off preemption on a request
      drm/i915/perf: add missing delay for OA muxes configuration

Liviu Dudau (1):
      drm/drm_debugfs_crc.c: Document that .verify_crc_source vfunc is
required for enabling CRC support.

Lucas De Marchi (21):
      drm/i915: rework reading pipe disable fuses
      drm/i915: make new intel_tc.c use uncore accessors
      drm/i915: fix include order in intel_tc.*
      drm/i915: move intel_ddi_set_fia_lane_count to intel_tc.c
      drm/i915: Add 4th pipe and transcoder
      drm/i915/tgl: Add TGL PCI IDs
      drm/i915/tgl: Add additional PHYs for Tiger Lake
      drm/i915/tgl: apply Display WA #1178 to fix type C dongles
      drm/i915/tgl: port to ddc pin mapping
      drm/i915/tgl: Add DPLL registers
      drm/i915/tgl: add modular FIA to device info
      drm/i915/tgl: skip setting PORT_CL_DW12_* on initialization
      drm/i915/tgl: Add hpd interrupt handling
      drm/i915/tgl: handle DP aux interrupts
      drm/i915: make i915_selftest.h self-contained
      drm/i915: remove dangling forward declaration
      drm/i915/tgl: Move fault registers to their new offset
      drm/i915/tgl: stop using ERROR_GEN6 and DONE_REG
      drm/i915/tgl: Introduce initial Tiger Lake workarounds
      drm/i915/tgl: disable DDIC
      drm/i915/tgl: update DMC firmware to 2.04

Lucas Stach (18):
      drm/bridge: tc358767: do a software reset if reset pin isn't connecte=
d
      drm/panel: simple: fix AUO g185han01 horizontal blanking
      drm/etnaviv: clean up includes
      drm/etnaviv: fix etnaviv_cmdbuf_suballoc_new return value
      drm/etnaviv: remove unused function etnaviv_gem_mapping_reference
      drm/etnaviv: dump only failing submit
      drm/etnaviv: pass mmu pointer to etnaviv_core_dump_mmu
      drm/etnaviv: simplify unbind checks
      drm/etnaviv: split out cmdbuf mapping into address space
      drm/etnaviv: share a single cmdbuf suballoc region across all GPUs
      drm/etnaviv: replace MMU flush marker with flush sequence
      drm/etnaviv: rework MMU handling
      drm/etnaviv: split out starting of FE idle loop
      drm/etnaviv: provide MMU context to etnaviv_gem_mapping_get
      drm/etnaviv: implement per-process address spaces on MMUv2
      drm/etnaviv: skip command stream validation on PPAS capable GPUs
      drm/etnaviv: allow to request specific virtual address for gem mappin=
g
      drm/etnaviv: implement softpin

Lyude Paul (3):
      drm/nouveau/dispnv04: Remove runtime PM
      drm/nouveau/dispnv50: Fix runtime PM ref tracking for
non-blocking modesets
      drm/nouveau/kms/nv50-: Don't create MSTMs for eDP connectors

Maarten Lankhorst (6):
      drm/i915: Pass intel_crtc_state to needs_modeset()
      drm/i915: Convert most of atomic commit to take more intel state
      drm/i915: Convert hw state verifier to take more intel state, v2.
      drm/i915: Use intel_crtc_state in sanitize_watermarks() too
      drm/i915: Pass intel state to plane functions as well
      drm/i915: Use intel state as much as possible in wm code

Mahesh Kumar (6):
      drm/i915/tgl: Add TGL PCH detection in virtualized environment
      drm/i915/tgl: init ddi port A-C for Tiger Lake
      drm/i915/tgl: Add gmbus gpio pin to port mapping
      drm/i915/tgl: Add vbt value mapping for DDC Bus pin
      drm/i915/tgl: select correct bit for port select
      drm/i915/tgl: update ddi/tc clock_off bits

Marek Ol=C5=A1=C3=A1k (1):
      Revert "drm/amdgpu: fix transform feedback GDS hang on gfx10 (v2)"

Marek Vasut (1):
      dt-bindings: display: Add ETM0700G0DH6 compatible string

Mark Menzynski (5):
      drm/nouveau/bios/gpio: sort gpios by values
      drm/nouveau/gpio: fail if gpu external power is missing
      drm/nouveau/gpio: check the gpio function 16 in the power check as we=
ll
      drm/nouveau/gpio: check function 76 in the power check as well
      drm/nouveau/volt: Fix for some cards having 0 maximum voltage

Marko Kohtala (6):
      video: ssd1307fb: Use screen_buffer instead of screen_base
      video: ssd1307fb: Remove unneeded semicolons
      video: ssd1307fb: Start page range at page_offset
      video: ssd1307fb: Handle width and height that are not multiple of 8
      dt-bindings: display: ssd1307fb: Add initialization properties
      video: ssd1307fb: Add devicetree configuration of display setup

Martin Leung (4):
      drm/amd/display: Make init_hw and init_pipes generic for seamless boo=
t
      drm/amd/display: fix dcn-specific clk_mgr init_clocks
      drm/amd/display: enabling seamless boot sequence for dcn2
      drm/amd/display: cleaned up coding error in init_hw

Masahiro Yamada (1):
      drm/amd: remove meaningless descending into amd/amdkfd/

Matt Coffin (1):
      drm/amd/powerplay: Allow changing of fan_control in smu_v11_0

Matt Redfearn (2):
      drm/bridge/synopsys: dsi: Allow VPG to be enabled via debugfs
      drm/bridge: adv7511: Attach to DSI host at probe time

Matt Roper (13):
      drm/i915/ehl: Allow combo PHY A to drive a third external display
      drm/i915/ehl: Add one additional PCH ID to MCC
      drm/i915/icl: Drop port parameter to icl_get_combo_buf_trans()
      drm/i915/ehl: Add third combo PHY offset
      drm/i915/ehl: Don't program PHY_MISC on EHL PHY C
      drm/i915/gen11: Start distinguishing 'phy' from 'port'
      drm/i915/gen11: Program ICL_DPCLKA_CFGCR0 according to PHY
      drm/i915/gen11: Convert combo PHY logic to use new 'enum phy' namespa=
ce
      drm/i915: Transition port type checks to phy checks
      drm/i915/ehl: Enable DDI-D
      drm/i915/ehl: Map MCC pins based on PHY, not port
      drm/i915/ehl: Don't forget to handle port C's hotplug interrupts
      drm/i915/gen11: Allow usage of all GPIO pins

Matthew Auld (10):
      drm/i915/blt: don't assume pinned intel_context
      drm/i915/blt: bump the size restriction
      drm/i915/selftests: move gpu-write-dw into utils
      drm/i915/gtt: enable GTT cache by default
      drm/i915/gtt: disable 2M pages for pre-gen11
      drm/i915/blt: support copying objects
      drm/i915: buddy allocator
      drm/i915/selftest/buddy: fixup igt_buddy_alloc_range
      drm/i915/buddy: tidy up i915_buddy_fini
      drm/i915/buddy: use kmemleak_update_trace

Matthew Ruffell (1):
      drm/hisilicon/hibmc: Make CONFIG_DRM_HISI_HIBMC depend on ARM64

Maxime Ripard (2):
      drm/connector: Fix warning in debug message
      Merge v5.3-rc1 into drm-misc-next

Maya Rashish (1):
      drm/agp: Remove unused function drm_agp_bind_pages

Michael Strauss (1):
      drm/amd/display: Enable MPO with pre-blend color processing (RGB)

Michal Wajdeczko (53):
      drm/i915: Move OA files to separate folder
      drm/i915/guc: Upgrade to GuC 33.0.0
      drm/i915/guc: Don't enable GuC/HuC in auto mode on pre-Gen11
      drm/i915/guc: Turn on GuC/HuC auto mode
      drm/i915/gtt: Don't try to clear failed empty pd allocation
      drm/i915: Fix GuC documentation links
      drm/i915/uc: Update drawing for firmware layout
      drm/i915/uc: Move uc firmware layout definitions to dedicated file
      drm/i915/uc: Reorder params in intel_uc_fw_fetch
      drm/i915/uc: Don't sanitize guc_log_level modparam
      drm/i915/uc: Remove redundant header_offset/size definitions
      drm/i915/uc: Remove redundant ucode offset definition
      drm/i915/uc: Remove redundant RSA offset definition
      drm/i915/uc: Don't fail on HuC firmware failure
      drm/i915/uc: Rename intel_uc_is_using* into intel_uc_supports*
      drm/i915/uc: Consider enable_guc modparam during fw selection
      drm/i915/guc: Use dedicated flag to track submission mode
      drm/i915/uc: Stop sanitizing enable_guc modparam
      drm/i915: Fix documentation for __intel_wait_for_register_fw*
      drm/i915: Add i915 to i915_inject_probe_failure
      drm/i915/uc: Do full sanitize instead of pure reset
      drm/i915/uc: Reorder firmware status codes
      drm/i915/uc: Move GuC error log to uc and release it on fini
      drm/i915/uc: Inject probe errors into intel_uc_init_hw
      drm/i915/wopcm: Don't fail on WOPCM partitioning failure
      drm/i915/guc: Prefer intel_guc_is_submission_supported
      drm/i915/huc: Prefer intel_huc_is_supported
      drm/i915/uc: Remove redundant GuC support checks
      drm/i915/uc: Don't fail on HuC early init errors
      drm/i915/uc: Prefer dev_info for reporting options
      drm/i915/uc: HuC firmware can't be supported without GuC
      drm/i915/uc: Don't fetch HuC fw if GuC fw fetch already failed
      drm/i915: Don't try to partition WOPCM without GuC firmware
      drm/i915: Make wopcm_to_i915() private
      drm/i915/uc: WOPCM programming errors are not always real
      drm/i915/uc: Hardening firmware fetch
      drm/i915/uc: Fail early if there is no GuC fw available
      drm/i915/uc: Include HuC firmware version in summary
      drm/i915/uc: Update messages from fw upload step
      drm/i915/uc: Use -EIO code for GuC initialization failures
      drm/i915/uc: Update copyright and license
      drm/i915/uc: Log fw status changes only under debug config
      drm/i915/wopcm: Check WOPCM layout separately from calculations
      drm/i915/wopcm: Try to use already locked WOPCM layout
      drm/i915/wopcm: Update error messages
      drm/i915/wopcm: Fix SPDX tag location
      drm/i915/uc: Add explicit DISABLED state for firmware
      drm/i915/uc: Cleanup fw fetch only if it was successful
      drm/i915/uc: Cleanup fw fetch on every GuC/HuC init failure
      drm/i915/uc: Never fail on uC preparation step
      drm/i915/guc: Don't open log relay if GuC is not running
      drm/i915/uc: Don't always fail on unavailable GuC firmware
      drm/i915/uc: Never fail on HuC firmware errors

Micha=C5=82 Winiarski (3):
      Revert "drm/i915: Introduce private PAT management"
      drm/i915/gtt: Don't check PPGTT presence on PPGTT-only platforms
      drm/i915/uc: Move FW size sanity check back to fetch

Michel D=C3=A4nzer (1):
      drm/amdgpu: Update pitch on page flips without DC as well

Michel Thierry (5):
      x86/gpu: add TGL stolen memory support
      drm/i915/tgl: Tigerlake only has global MOCS registers
      drm/i915/tgl: Report valid VDBoxes with SFC capability
      drm/i915/tgl: Updated Private PAT programming
      drm/i915/tgl: add support for reading the timestamp frequency

Mihail Atanassov (1):
      drm/komeda: Add support for 'memory-region' DT node property

Mika Kahola (2):
      drm/i915/icl: Add missing device ID
      drm/i915/tgl: Add power well to support 4th pipe

Mika Kuoppala (9):
      drm/i915: Fix memleak in runtime wakeref tracking
      drm/i915/gtt: pde entry encoding is identical
      drm/i915/gtt: Tear down setup and cleanup macros for page dma
      drm/i915/gtt: Setup phys pages for 3lvl pdps
      drm/i915/gtt: Introduce release_pd_entry
      drm/i915/icl: Implement gen11 flush including tile cache
      drm/i915/icl: Add command cache invalidate
      drm/i915/icl: Add gen11 specific render breadcrumbs
      drm/i915/gtt: Fold gen8 insertions into one

Monk Liu (4):
      drm/amdgpu: cleanup vega10 SRIOV code path
      drm/amdgpu: fix incorrect judge on sos fw version
      drm/amdgpu: fix double ucode load by PSP(v3)
      drm/amdgpu: introduce vram lost for reset (v2)

Murton Liu (4):
      drm/amd/display: Clock does not lower in Updateplanes
      drm/amd/display: Implement generic MUX registers (v2)
      drm/amd/display: Hook up calls to do stereo mux and dig
programming to stereo control interface
      drm/amd/display: Change offset_to_id to reflect what id_to_offset ret=
urns

Nathan Chancellor (3):
      drm/amd/display: Use proper enum conversion functions
      drm/amd/powerplay: Zero initialize some variables
      drm/amd/display: Fix 32-bit divide error in wait_for_alt_mode

Navid Emamdoost (1):
      drm/panel: check failure cases in the probe func

Neil Armstrong (6):
      MAINTAINERS: Update Maintainers and Reviewers of DRM Bridge Drivers
      drm/bridge: dw-hdmi: Use automatic CTS generation mode when
using non-AHB audio
      Revert "drm/radeon: Provide ddc symlink in connector sysfs directory"
      dt-bindings: display: amlogic, meson-dw-hdmi: convert to yaml
      dt-bindings: display: amlogic, meson-vpu: convert to yaml
      MAINTAINERS: Update with Amlogic DRM bindings converted as YAML

Nevenko Stupar (2):
      drm/amd/display:Use Pixel clock in 100Hz units for HDMI Audio
wall clock DTO
      drm/amd/display: Add DIG_CLOCK_PATTERN register

Nicholas Kazlauskas (16):
      drm/amd/display: Copy max_clks_by_state after dce_clk_mgr_construct
      drm/amd/display: Set enabled to false at start of audio disable
      drm/amd/display: Copy GSL groups when committing a new context
      drm/amd/display: Embed DCN2 SOC bounding box
      drm/amd/display: Support uclk switching for DCN2
      drm/amd/display: Allow cursor async updates for framebuffer swaps
      drm/amd/display: Skip determining update type for async updates
      drm/amd/display: Don't replace the dc_state for fast updates
      drm/amd/display: Validate dc_plane_info and dc_plane_size in atomic c=
heck
      drm/amd/display: Block immediate flips for non-fast updates
      drm/amd/display: Register VUPDATE_NO_LOCK interrupts for DCN2
      drm/amd/display: Calculate bpc based on max_requested_bpc
      drm/amd/display: Check return code for CRC drm_crtc_vblank_get
      drm/amd/display: Use connector list for finding DPRX CRC aux
      drm/amd/display: Split out DC programming for CRC capture
      drm/amd/display: Lock the CRTC when setting CRC source

Nick Desaulniers (1):
      drm/amd/display: readd -msse2 to prevent Clang from emitting
libcalls to undefined SW FP routines

Nickey Yang (1):
      dt-bindings: display: rockchip: update DSI controller

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: prevent memory leaks in AMDGPU_CS ioctl

Nikola Cornij (11):
      drm/amd/display: Set one 4:2:0-related PPS field as recommended
by DSC spec
      drm/amd/display: Power-gate all DSCs at driver init time
      drm/amd/display: Set FEC_READY always before link training
      drm/amd/display: Clear FEC_READY shadow register if DPCD write fails
      drm/amd/display: Change DSC policy from slices per column to
minimum slice height
      drm/amd/display: Set DSC before DIG front-end is connected to its bac=
k-end
      drm/amd/display: Remove 4:2:2 DSC support
      drm/amd/display: Correct DSC PPS log
      drm/amd/display: Add and refine DSC logs in enable sequence
      drm/amd/display: Zero-out dsc init regs
      drm/amd/display: Fix number of slices not being checked for dsc

Nishka Dasgupta (5):
      drm/pl111: pl111_vexpress.c: Add of_node_put() before return
      drm/aspeed: gfc_crtc: Make structure aspeed_gfx_funcs constant
      drm/vboxvideo: Make structure vbox_fb_helper_funcs constant
      drm/xen-front: Make structure fb_funcs constant
      udlfb: Make dlfb_ops constant

Noralf Tr=C3=B8nnes (23):
      drm: Add SPI connector type
      drm/tinydrm: Use DRM_MODE_CONNECTOR_SPI
      drm/tinydrm: Use spi_is_bpw_supported()
      drm/tinydrm: Remove spi debug buffer dumping
      drm/tinydrm: Remove tinydrm_spi_max_transfer_size()
      drm/tinydrm: Clean up tinydrm_spi_transfer()
      drm/tinydrm: Move tinydrm_spi_transfer()
      drm/tinydrm: Move tinydrm_machine_little_endian()
      drm/tinydrm/repaper: Don't use tinydrm_display_pipe_init()
      drm/tinydrm/mipi-dbi: Add mipi_dbi_init_with_formats()
      drm/tinydrm: Move tinydrm_display_pipe_init() to mipi-dbi
      drm/tinydrm/mipi-dbi: Move cmdlock mutex init
      drm/tinydrm: Rename variable mipi -> dbi
      drm/tinydrm: Rename remaining variable mipi -> dbidev
      drm/tinydrm: Split struct mipi_dbi in two
      drm/tinydrm/mipi-dbi: Remove CMA helper dependency
      drm/tinydrm/Kconfig: drivers: Select BACKLIGHT_CLASS_DEVICE
      drm/tinydrm/mipi-dbi: Select DRM_KMS_HELPER
      drm/tinydrm: Move mipi-dbi
      MAINTAINERS: Remove tinydrm entry
      drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
      drm/tinydrm: Rename folder to tiny
      drm/gm12u320: Move driver to drm/tiny

Oak Zeng (14):
      drm/amdgpu: Initialize asic functions for Arcturus
      drm/amdkfd: Extend PM4 packets to support 8 SDMA
      drm/amdkfd: Support bigger gds size
      drm/amdkfd: Change arcturus sdma engines number
      drm/amdkfd: Fix sdma_bitmap overflow issue
      drm/amdkfd: Implement kfd2kgd_calls for Arcturus
      drm/amdgpu: Hack xgmi topology info when there is no psp fw
      drm/amdgpu: Enable xgmi support for Arcturus
      drm/amdkfd: Set number of xgmi optimized SDMA engines for arcturus
      drm/amdkfd: Add arcturus CWSR trap handler
      drm/amdkfd: Add device id for real asics
      drm/amdkfd: Increase vcrat size for GPU
      drm/amdgpu: Export function to flush TLB of specific vm hub
      drm/amdkfd/gfx10: Calling amdgpu functions to invalidate TLB

Oded Gabbay (1):
      MAINTAINERS: update amdkfd maintainer (v3)

Olivier Moysan (4):
      drm/bridge: sii902x: fix missing reference to mclk clock
      dt-bindings: display: sii902x: Change audio mclk binding
      drm/bridge: sii902x: make audio mclk optional
      drm/bridge: sii902x: add audio graph card support

Ondrej Jirman (2):
      dt-bindings: display: hdmi-connector: Support DDC bus enable
      drm: sun4i: Add support for enabling DDC I2C bus to sun8i_dw_hdmi glu=
e

Paul Cercueil (11):
      dt-bindings: display: Add GiantPlus GPM940B0 panel documentation
      media: uapi: Add MEDIA_BUS_FMT_RGB888_3X8 media bus format
      drm/panel: simple: Add GiantPlus GPM940B0 panel support
      dt-bindings: display: Add King Display KD035G6-54NT panel documentati=
on
      drm/panel: Add Novatek NT39016 panel support
      dt-bindings: display: Add Sharp LS020B1DD01D panel documentation
      drm: Add bus flag for Sharp-specific signals
      drm/panel: simple: Add Sharp LS020B1DD01D panel support
      DRM: ingenic: Use devm_platform_ioremap_resource
      DRM: ingenic: Add support for Sharp panels
      DRM: ingenic: Add support for panels with 8-bit serial bus

Petr Cvek (1):
      drm/amdgpu: Fix undefined dm_ip_block for navi12

Philipp Zabel (9):
      gpu: ipu-v3: enable remaining 32-bit RGB V4L2 pixel formats
      gpu: ipu-v3: image-convert: enable V4L2_PIX_FMT_BGRX32 and _RGBX32
      gpu: ipu-v3: image-convert: move output seam valid interval
calculation into find_best_seam
      gpu: ipu-v3: image-convert: fix output seam valid interval
      gpu: ipu-v3: image-convert: limit input seam position to
hardware requirements
      gpu: ipu-v3: image-convert: fix image downsize coefficients and
tiling calculation
      gpu: ipu-v3: image-convert: bail on invalid tile sizes
      gpu: ipu-v3: image-convert: move tile burst alignment out of loop
      gpu: ipu-v3: image-convert: only sample into the next tile if necessa=
ry

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: fix gfx9 soft recovery

Prike Liang (19):
      drm/amdgpu: enable gfx clock gating for rn
      drm/amdgpu: enable mmhub clock gating for rn
      drm/amdgpu: enable sdma clock gating for rn
      drm/amdgpu: enable BIF clock gating for rn
      drm/amdgpu: enable HDP clock gating for rn
      drm/amdgpu: enable rom clock gating for rn
      drm/amdgpu: enable vcn clock gating for rn
      drm/amdgpu: enable IH clock gating for rn
      drm/amdgpu: enable athub clock gating for rn
      drm/amdgpu: enable DF clock gating for rn
      drm/amdgpu/mmhub1: set mmhub clock gating for rn
      drm/amdgpu/sdma4: set sdma clock gating for rn
      drm/amdgpu: enable SDMA power gating for rn
      drm/amd/powerplay: enable renoir dpm feature
      drm/amd/powerplay: Disable renoir smu feature retrieve for the moment
      drm/amdgpu: Initialize and update SDMA power gating
      drm/amd/powerplay: regards the APU always enable the dpm feature mask
      drm/amd/powerplay: enable populate DPM clocks table for swSMU APU
      drm/amd/powerplay: add the interface for getting ultimate frequency v=
3

Qian Cai (1):
      gpu/drm: fix a few kernel-doc "/**" mark warnings

Qingqing Zhuo (4):
      drm/amd/display: Add CM_BYPASS via debug option
      drm/amd/display: Add enum for H-timing divider mode
      drm/amd/display: refactor Device ID for external chips
      drm/amd/display: remove unused function

Radhakrishna Sripada (1):
      drm/i915/tgl: Introduce Tiger Lake PCH

Ramalingam C (7):
      drm/i915/hdcp: debug logs for sink related failures
      drm: Add Content protection type property
      drm/i915: Attach content type property
      drm: uevent for connector status change
      drm/hdcp: update content protection property with uevent
      drm/i915: update the hdcp state with uevent
      drm/hdcp: reference for srm file format

Reza Amini (1):
      drm/amd/display: Implement DAL3 GPU Integer Scaling

Rhys Kidd (3):
      drm/nouveau/bios: downgrade absence of tmds table to info from an err=
or
      drm/nouveau/bios/init: handle INIT_RESET_BEGUN devinit opcode
      drm/nouveau/bios/init: handle INIT_RESET_END devinit opcode

Rob Clark (22):
      drm/bridge: ti-sn65dsi86: add link to datasheet
      drm/bridge: ti-sn65dsi86: add debugfs
      drm/bridge: ti-sn65dsi86: correct dsi mode_flags
      drm/bridge: ti-sn65dsi86: use dev name for debugfs
      drm/msm/dpu: remove dpu_mdss:hwversion
      drm/msm/a6xx: add missing MODULE_FIRMWARE()
      drm/msm/dpu: fix "frame done" timeouts
      drm/msm/dpu: remove stray "\n"
      drm/msm/dpu: add rotation property
      drm/msm/dpu: remove some impossible error checking
      drm/msm/dpu: remove unused arg
      drm/msm/dpu: unwind async commit handling
      drm/msm/dpu: add real wait_for_commit_done()
      drm/msm/dpu: handle_frame_done() from vblank irq
      drm/msm: add kms->wait_flush()
      drm/msm: convert kms->complete_commit() to crtc_mask
      drm/msm: add kms->flush_commit()
      drm/msm: split power control from prepare/complete_commit
      drm/msm: async commit support
      drm/msm/dpu: async commit support
      drm/msm: add atomic traces
      drm/msm: Use the correct dma_sync calls harder

Rob Herring (45):
      dt-bindings: display: Convert tpo,tpg110 panel to DT schema
      dt-bindings: display: rockchip-lvds: Remove panel references
      Revert "drm/panfrost: Use drm_gem_map_offset()"
      Revert "drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offs=
et()"
      dt-bindings: display: Convert common panel bindings to DT schema
      dt-bindings: display: Convert ampire,am-480272h3tmqw-t01h panel
to DT schema
      dt-bindings: display: Convert armadeus,st0700-adapt panel to DT schem=
a
      dt-bindings: display: Convert bananapi,s070wv20-ct16 panel to DT sche=
ma
      dt-bindings: display: Convert dlc,dlc0700yzg-1 panel to DT schema
      dt-bindings: display: Convert pda,91-00156-a0 panel to DT schema
      dt-bindings: display: Convert raspberrypi,7inch-touchscreen
panel to DT schema
      dt-bindings: display: Convert tfc,s9700rtwv43tr-01b panel to DT schem=
a
      dt-bindings: display: Convert panel-lvds to DT schema
      dt-bindings: display: Convert innolux,ee101ia-01 panel to DT schema
      dt-bindings: display: Convert mitsubishi,aa104xd12 panel to DT schema
      dt-bindings: display: Convert mitsubishi,aa121td01 panel to DT schema
      dt-bindings: display: Convert sgd,gktw70sdae4se panel to DT schema
      Revert "drm/panfrost: Use drm_gem_map_offset()"
      Revert "drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offs=
et()"
      drm/panfrost: Remove completed features still in TODO
      drm/shmem: Add madvise state and purge helpers
      drm/panfrost: Add madvise and shrinker support
      drm/gem: Allow sparsely populated page arrays in drm_gem_put_pages
      drm/shmem: Put pages independent of a SG table being set
      drm/panfrost: Restructure the GEM object creation
      drm/panfrost: Split panfrost_mmu_map SG list mapping to its own funct=
ion
      drm/panfrost: Add a no execute flag for BO allocations
      drm/panfrost: Consolidate reset handling
      drm/panfrost: Convert MMU IRQ handler to threaded handler
      drm/panfrost: Add support for GPU heap allocations
      drm/panfrost: Bump driver version to 1.1
      drm/panfrost: Implement per FD address spaces
      drm/panfrost: Fix sleeping while atomic in panfrost_gem_open
      drm/panfrost: Fix possible suspend in panfrost_remove
      drm/shmem: Do dma_unmap_sg before purging pages
      drm/shmem: Use mutex_trylock in drm_gem_shmem_purge
      drm/panfrost: Use mutex_trylock in panfrost_gem_purge
      drm/panfrost: Rework runtime PM initialization
      drm/panfrost: Hold runtime PM reference until jobs complete
      drm/panfrost: Remove unnecessary mmu->lock mutex
      drm/panfrost: Rework page table flushing and runtime PM interaction
      drm/panfrost: Split mmu_hw_do_operation into locked and unlocked vers=
ion
      drm/panfrost: Add cache/TLB flush before switching address space
      drm/panfrost: Flush and disable address space when freeing page table=
s
      drm/panfrost: Remove unnecessary hwaccess_lock spin_lock

Robert Chiras (2):
      dt-bindings: display: panel: Add support for Raydium RM67191 panel
      drm/panel: Add support for Raydium RM67191 panel driver

Robert M. Fosha (1):
      drm/i915/guc: Add debug capture of GuC exception

Rodrigo Siqueira (2):
      drm/vkms: Avoid assigning 0 for possible_crtc
      drm/vkms: Rename vkms_crc.c into vkms_composer.c

Rodrigo Vivi (12):
      drm/i915: Update DRIVER_DATE to 20190708
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915/gen12: MBUS B credit change
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190730
      drm/i915: abstract display suspend/resume operations
      Merge tag 'gvt-next-2019-08-13' of
https://github.com/intel/gvt-linux into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190813
      drm/i915: Update DRIVER_DATE to 20190820
      Merge drm/drm-next into drm-intel-next-queued
      drm/i915: Update DRIVER_DATE to 20190822
      Merge tag 'gvt-next-fixes-2019-09-06' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Roman Li (4):
      drm/amd/display: Add missing NV12 asic IDs
      drm/amd/display: Correct order of RV family clk managers for Renoir
      drm/amd/display: Add DCN2.1 changes to DML
      drm/amdgpu: Enable DC on Renoir

Sam Ravnborg (75):
      drm/mga: drop dependency on drm_os_linux.h
      drm/mga: make header file self contained
      drm/mga: drop use of drmP.h
      drm/mgag200: drop use of drmP.h
      MAINTAINERS: add Sam Ravnborg for drm/atmel_hlcdc
      drm/stm: drop use of drmP.h
      drm/xen: drop use of drmP.h
      drm/tve200: drop use of drmP.h
      drm/mxsfb: drop use of drmP.h
      drm/fsl-dcu: drop use of drmP.h
      drm/qxl: drop use of drmP.h
      drm/vkms: drop use of drmP.h
      drm/scheduler: drop use of drmP.h
      drm/virtgpu: drop use of drmP.h
      drm: add missing include to drm_vram_mm_helper.h
      drm/bochs: drop use of drmP.h
      drm/ast: drop use of drmP.h
      drm/hisilicon: drop use of drmP.h
      drm/shmobile: drop use of drmP.h
      drm/atmel_hlcdc: drop use of drmP.h
      drm/meson: drop use of drmP.h
      drm/v3d: drop use of drmP.h
      drm/pl111: drop use of drmP.h
      drm/zte: drop use of drmP.h
      drm/sun4i: drop use of drmP.h
      drm/vc4: drop use of drmP.h
      drm/r128: drop use of drmP.h
      drm/udl: drop use of drmP.h
      drm/omapdrm: drop use of drmP.h
      drm/selftests: drop use of drmP.h
      drm/tdfx: drop use of drmP.h
      drm/vgem: drop use of drmP.h
      drm/i810: drop use of drmP.h
      drm/tilcdc: drop use of drmP.h
      drm/i2c/ch7006: drop use of drmP.h
      drm/i2c/sil164: drop use of drmP.h
      drm/imx: drop use of drmP.h
      drm/rockchip: drop use of drmP.h
      drm/mediatek: drop use of drmP.h
      drm: drop uapi dependency from drm_vblank.h
      drm/ati_pcigart: drop dependency on drm_os_linux.h
      drm: direct include of drm.h in drm_gem.c
      drm: direct include of drm.h in drm_gem_shmem_helper.c
      drm: direct include of drm.h in drm_prime.c
      drm: direct include of drm.h in drm_syncobj.c
      drm/mediatek: direct include of drm.h in mtk_drm_gem.c
      drm/fb: remove unused function: drm_gem_fbdev_fb_create()
      drm/via: drop use of DRM(READ|WRITE) macros
      drm/via: copy DRM_WAIT_ON as VIA_WAIT_ON and use it
      drm/via: make via_drv.h self-contained
      drm/via: drop use of drmP.h
      drm/etnaviv: drop use of drmP.h
      drm/vblank: drop use of DRM_WAIT_ON()
      backlight: drop EARLY_EVENT_BLANK support
      drm/sti: fix opencoded use of drm_panel_*
      drm/bridge: tc358767: fix opencoded use of drm_panel_*
      drm/imx: fix opencoded use of drm_panel_*
      drm/fsl-dcu: fix opencoded use of drm_panel_*
      drm/mxsfb: fix opencoded use of drm_panel_*
      drm/panel: ili9322: move bus_flags to get_modes()
      drm/panel: move drm_panel functions to .c file
      drm/panel: use inline comments in drm_panel.h
      drm/panel: drop return code from drm_panel_detach()
      drm/i2c/tda998x: drop use of drmP.h
      drm/tegra: drop use of drmP.h
      drm/armada: drop use of drmP.h
      drm/arm: drop use of drmP.h
      drm/vmwgfx: drop use of drmP.h in header files
      drm/vmwgfx: drop reminaing users of drmP.h
      drm/nouveau: drop use of DRM_UDELAY
      drm/nouveau: drop drmP.h from nouveau_drv.h
      drm/nouveau: drop drmP.h from all header files
      drm/nouveau: drop use of drmp.h
      drm/exynos: drop use of drmP.h
      drm/msm: drop use of drmP.h

Samson Tam (1):
      drm/amd/display: skip retrain in
dc_link_set_preferred_link_settings() if using passive dongle

Sean Paul (15):
      drm/panel: simple: Add ability to override typical timing
      drm: Make the bw/link rate calculations more forgiving
      drm/rockchip: Check for fast link training before enabling psr
      drm/rockchip: Use the helpers for PSR
      drm/rockchip: Use vop_win in vop_win_disable instead of vop_win_data
      drm/rockchip: Don't fully disable vop on self refresh
      drm/rockchip: Use drm_atomic_helper_commit_tail_rpm
      drm/mst: Fix sphinx warnings in drm_dp_msg_connector register functio=
ns
      Revert "Revert "drm/gem: Rename drm_gem_dumb_map_offset() to
drm_gem_map_offset()""
      Revert "Revert "drm/panfrost: Use drm_gem_map_offset()""
      Revert "drm/vgem: drop DRM_AUTH usage from the driver"
      Revert "drm/msm: drop DRM_AUTH usage from the driver"
      Revert "drm/nouveau: remove open-coded drm_invalid_op()"
      drm: Fix kerneldoc warns in connector-related docs
      drm/msm/dsi: Fix return value check for clk_get_parent

Shaokun Zhang (1):
      drm/pl111: Fix unused variable warning

Shirish S (1):
      drm/amd/display: enable S/G for RAVEN chip

SivapiriyanKumarasamy (1):
      drm/amd/display: Wait for backlight programming completion in
set backlight level

Souptick Joarder (4):
      video: fbdev: nvidia: Remove extra return
      video: fbdev: nvidia: Remove dead code
      video: fbdev: aty[128]fb: Remove dead code
      video: fbdev: viafb: Remove dead code

Stanislav Lisovskiy (1):
      drm/i915: Fix wrong escape clock divisor init for GLK

Stephen Rothwell (1):
      drm/amdgpu: MODULE_FIRMWARE requires linux/module.h

Steven Price (6):
      drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
      drm/panfrost: Use drm_gem_map_offset()
      drm/panfrost: Export all GPU feature registers
      drm/panfrost: Enable devfreq to work without regulator
      drm/panfrost: Remove opp table when unloading
      drm/panfrost: Add missing check for pfdev->regulator

Steven Rostedt (VMware) (1):
      drm/i915: Copy name string into ring buffer for
intel_update/disable_plane tracepoints

Stuart Summers (1):
      drm/i915: Print CCID for all renderCS

Su Sung Chung (4):
      drm/amd/display: refactor dump_clk_registers
      drm/amd/display: fix not calling ppsmu to trigger PME
      drm/amd/display: refactor gpio to allocate hw_container in constructo=
r
      drm/amd/display: fix audio endpoint not getting disabled issue

Tai Man (2):
      drm/amd/display: use encoder's engine id to find matched free audio d=
evice
      drm/amd/display: Increase size of audios array

Tao Zhou (34):
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu: add ras error count after each query (v2)
      drm/amdgpu: add RREG64/WREG64(_PCIE) operations
      drm/amdgpu: use 64bit operation macros for umc
      drm/amdgpu: switch to amdgpu_umc structure
      drm/amdgpu: update algorithm of umc uncorrectable error counting
      drm/amdgpu: add support for recording ras error address
      drm/amdgpu: add structures for umc error address translation
      drm/amdgpu: query umc ras error address
      drm/amdgpu: allow ras interrupt callback to return error data
      drm/amdgpu: update interrupt callback for all ras clients
      drm/amdgpu: add check for ras error type
      drm/amdgpu: remove ras_reserve_vram in ras injection
      drm/amdgpu: remove the clear of MCA_ADDR
      drm/amdgpu: add more parameters and functions to amdgpu_umc structure
      drm/amdgpu: initialize new parameters and functions for
amdgpu_umc structure
      drm/amdgpu: add macro of umc for each channel
      drm/amdgpu: apply umc_for_each_channel macro to umc_6_1
      drm/amdgpu: add error address query for umc ras
      drm/amdgpu: support ce interrupt in ras module
      drm/amdgpu: implement umc ras init function
      drm/amdgpu: update the calc algorithm of umc ecc error count
      drm/amdgpu: only uncorrectable error needs gpu reset
      drm/amdgpu: replace AMDGPU_RAS_UE with AMDGPU_RAS_SUCCESS
      drm/amdgpu: update ras sysfs feature info
      drm/amdgpu: replace readq/writeq with atomic64 operations
      drm/amdgpu: implement UMC 64 bits REG operations
      drm/amdgpu: remove RREG64/WREG64
      drm/amdgpu: add sub block parameter in ras inject command
      drm/amdgpu: add amdgpu_mmhub_funcs definition
      drm/amdgpu: support mmhub ras in amdgpu ras
      drm/amdgpu: create mmhub ras framework
      drm/amdgpu: remove ras block's feature status info in sysfs
      drm/amdgpu: implement querying ras error count for mmhub

Thierry Reding (5):
      drm/nouveau: Initialize GEM object before TTM object
      drm/nouveau: Fix fallout from reservation object rework
      drm/nouveau/prime: Extend DMA reservation object lock
      drm/nouveau: Fix ordering between TTM and GEM release
      drm/nouveau/bar/gm20b: Avoid BAR1 teardown during init

Thomas Hellstrom (2):
      drm/vmwgfx: Kill unneeded legacy security features
      drm/vmwgfx: Assign eviction priorities to resources

Thomas Zimmermann (16):
      drm/mgag200: Replace struct mga_framebuffer with GEM framebuffer help=
ers
      drm/ast: Replace struct ast_framebuffer with GEM framebuffer helpers
      drm/vram: Set GEM object functions for PRIME
      drm/bochs: Remove PRIME helpers from driver structure
      drm/hibmc: Update struct drm_driver for GEM object functions
      drm/vbox: Remove empty PRIME functions
      drm/vram: Don't export driver callback functions for PRIME
      drm/client: Support unmapping of DRM client buffers
      drm/fb-helper: Map DRM client buffer only when required
      drm/fb-helper: Instanciate shadow FB if configured in device's mode_c=
onfig
      drm/ast: Replace struct ast_fbdev with generic framebuffer emulation
      drm/bochs: Use shadow buffer for bochs framebuffer console
      drm/mgag200: Replace struct mga_fbdev with generic framebuffer emulat=
ion
      drm/mgag200: Pin displayed cursor BO to video memory
      drm/mgag200: Set cursor scanout address to correct BO
      drm/mgag200: Don't unpin the current cursor image's buffer.

Thong Thai (4):
      drm/amd/amdgpu/vcn_v2_0: Mark RB commands as KMD commands
      drm/amd/amdgpu/vcn_v2_0: Move VCN 2.0 specific dec ring test to vcn_v=
2_0
      Revert "drm/amdgpu: use direct loading on renoir vcn for the moment"
      drm/amdgpu: enable VCN DPG for Renoir

Tianci.Yin (3):
      drm/amdgpu/psp: move TMR to cpu invisible vram region
      drm/amdgpu: keep the stolen memory in visible vram region
      drm/amdgpu/psp: keep TMR in visible vram region for SRIOV

Tina Zhang (1):
      drm/i915/gvt: Double check batch buffer size after copy

Tomasz Lis (1):
      drm/i915/tgl: Define MOCS entries for Tigerlake

Tony Cheng (1):
      drm/amd/display: avoid power gate domains that doesn't exist

Tvrtko Ursulin (53):
      drm/i915: Convert intel_vgt_(de)balloon to uncore
      drm/i915: Introduce struct intel_gt as replacement for anonymous i915=
->gt
      drm/i915: Move intel_gt initialization to a separate file
      drm/i915: Store some backpointers in struct intel_gt
      drm/i915: Move intel_gt_pm_init under intel_gt_init_early
      drm/i915: Make i915_check_and_clear_faults take intel_gt
      drm/i915: Convert i915_gem_init_swizzling to intel_gt
      drm/i915: Use intel_uncore_rmw in intel_gt_init_swizzling
      drm/i915: Convert init_unused_rings to intel_gt
      drm/i915: Convert gt workarounds to intel_gt
      drm/i915: Store backpointer to intel_gt in the engine
      drm/i915: Convert intel_mocs_init_l3cc_table to intel_gt
      drm/i915: Convert i915_ppgtt_init_hw to intel_gt
      drm/i915: Consolidate some open coded mmio rmw
      drm/i915: Convert i915_gem_init_hw to intel_gt
      drm/i915: Move intel_engines_resume into common init
      drm/i915: Stop using I915_READ/WRITE in intel_wopcm_init_hw
      drm/i915: Compartmentalize i915_ggtt_probe_hw
      drm/i915: Compartmentalize i915_ggtt_init_hw
      drm/i915: Make ggtt invalidation work on ggtt
      drm/i915: Store intel_gt backpointer in vm
      drm/i915: Compartmentalize i915_gem_suspend/restore_gtt_mappings
      drm/i915: Convert i915_gem_flush_ggtt_writes to intel_gt
      drm/i915: Move i915_gem_chipset_flush to intel_gt
      drm/i915: Compartmentalize timeline_init/park/fini
      drm/i915: Compartmentalize i915_ggtt_cleanup_hw
      drm/i915: Compartmentalize i915_gem_init_ggtt
      drm/i915: Store ggtt pointer in intel_gt
      drm/i915: Compartmentalize ring buffer creation
      drm/i915: Save trip via top-level i915 in a few more places
      drm/i915: Make timelines gt centric
      drm/i915: Rename i915_timeline to intel_timeline and move under gt
      drm/i915: Eliminate dual personality of i915_scratch_offset
      drm/i915/hangcheck: Look at instdone for all engines
      drm/i915: Rework some interrupt handling functions to take intel_gt
      drm/i915: Remove some legacy mmio accessors from interrupt handling
      drm/i915: Move dev_priv->pm_i{m, e}r into intel_gt
      drm/i915: Remove unused i915_gem_context_lookup_engine
      drm/i915: Update description of i915.enable_guc modparam
      drm/i915: Fix GEN8_MCR_SELECTOR programming
      drm/i915: Trust programmed MCR in read_subslice_reg
      drm/i915: Fix and improve MCR selection logic
      drm/i915: Skip CS verification of L3 bank registers
      drm/i915/icl: Verify engine workarounds in GEN8_L3SQCREG4
      drm/i915/icl: Add Wa_1409178092
      Revert "drm/i915/guc: Turn on GuC/HuC auto mode"
      Revert "drm/i915: Update description of i915.enable_guc modparam"
      drm/i915: Do not rely on for loop caching the mask
      drm/i915: Move MOCS setup to intel_mocs.c
      drm/i915/pmu: Make more struct i915_pmu centric
      drm/i915/pmu: Convert engine sampling to uncore mmio
      drm/i915/pmu: Convert sampling to gt
      drm/i915/pmu: Make get_rc6 take intel_gt

Uma Shankar (3):
      drm/i915/icl: Handle YCbCr to RGB conversion for BT2020 case
      drm/i915/icl: Fix Y pre-offset for Full Range YCbCr
      drm/i915/icl: Fixed Input CSC Co-efficients for BT601/709

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Refactor oa object to better manage resources

Vandita Kulkarni (11):
      drm/i915/ehl/dsi: Set lane latency optimization for DW1
      drm/i915: Add icl mipi dsi properties
      drm/i915/tgl: Add new pll ids
      drm/i915/tgl: Add pll manager
      drm/i915/tgl: Add additional ports for Tiger Lake
      drm/i915/tgl/dsi: Program TRANS_VBLANK register
      drm/i915/tgl/dsi: Set latency PCS_DW1 for tgl
      drm/i915/tgl/dsi: Do not override TA_SURE
      drm/i915/tgl/dsi: Gate the ddi clocks after pll mapping
      drm/i915/tgl: Add mipi dsi support for TGL
      drm/i915/tgl/dsi: Enable blanking packets during BLLP for video mode

Ville Syrj=C3=A4l=C3=A4 (39):
      drm: Do not use bitwise OR to set picure_aspect_ratio
      drm: Do not accept garbage mode aspect ratio flags
      drm: WARN on illegal aspect ratio when converting a mode to umode
      drm/sun4i: Eliminate pointless on stack copy of drm_display_info
      drm/i915: Fix various tracepoints for gen2
      drm/i915: Switch to per-crtc vblank vfuncs
      drm/i915: Nuke drm_driver irq vfuncs
      drm/i915: Initialize drm_driver vblank funcs at compile time
      drm/i915: synchronize_irq() against the actual irq
      drm/i915: Deal with machines that expose less than three QGV points
      drm/i915: Add windowing for primary planes on gen2/3 and chv
      drm/i915: Disable sprite gamma on ivb-bdw
      drm/i915: Program plane gamma ramps
      drm/i915: Deal with cpp=3D=3D8 for g4x watermarks
      drm/i915: Cosmetic fix for skl+ plane switch statement
      drm/i915: Clean up skl vs. icl plane formats
      drm/sti: Remove pointless casts
      drm/sti: Try to fix up the tvout possible clones
      drm/i915/sdvo: Use named initializers for the SDVO command names
      drm/i915/sdvo: Remove duplicate SET_INPUT_TIMINGS_PART1 cmd name stri=
ng
      drm/i915/sdvo: Shrink sdvo_cmd_names[] strings
      drm/i915/sdvo: Add helpers to get the cmd/status string
      drm/i915/sdvo: Fix handling if zero hbuf size
      drm/i915: Use the "display core" power domain in vlv/chv set_cdclk()
      drm/i915: Check crtc_state->wm.need_postvbl_update before
grabbing wm.mutex
      drm/i915: Simplify modeset_get_crtc_power_domains() arguments
      drm/i915: Polish intel_shared_dpll_swap_state()
      drm/i915: Polish intel_atomic_track_fbs()
      drm/i915: Use intel_ types in intel_{lock,modeset}_all_pipes()
      drm/i915: Use intel_ types in intel_atomic_commit()
      drm/i915: Don't pass stack garbage to pcode in the second data regist=
er
      drm/i915: Don't overestimate 4:2:0 link symbol clock
      drm/i915: Skip SINK_COUNT read on CH7511
      drm/i915: Add gen8_de_pipe_fault_mask()
      drm/i915: Make sure cdclk is high enough for DP audio on VLV/CHV
      drm/dp_mst: Enable registration of AUX devices for MST ports
      drm/i915: Fix DP-MST crtc_mask
      drm/i915: Do not create a new max_bpc prop for MST connectors
      drm/nouveau: Disable atomic support on a per-device basis

Vitaly Prosyak (4):
      drm/amd/display: Add MPC 3DLUT resource management
      drm/amd/display: Add 22, 24, and 26 degamma
      drm/amd/display: Add HLG support in color module
      drm/amd/display: Check if set_blank_data_double_buffer exists before =
call

Vivek Kasireddy (2):
      drm/i915/ehl: Add support for DPLL4 (v10)
      drm/i915/ehl: Use an id of 4 while accessing DPLL4's CR0 and CR1

Wang Xiayang (1):
      drm/amdgpu: fix a potential information leaking bug

Wei Yongjun (3):
      drm/i915: fix possible memory leak in intel_hdcp_auth_downstream()
      drm/panfrost: Fix missing unlock on error in panfrost_mmu_map_fault_a=
ddr()
      drm/etnaviv: fix missing unlock on error in
etnaviv_iommuv1_context_alloc()

Weinan Li (1):
      drm/i915/gvt: update RING_START reg of vGPU when the context is
submitted to i915

Wenjing Liu (4):
      drm/amd/display: wait for the whole frame after global unlock
      drm/amd/display: reset drr programming on pipe reset
      drm/amd/display: reset hdmi tmds rate and data scramble on pipe reset
      drm/amd/display: check hpd before retry verify link cap

Wyatt Wood (4):
      drm/amd/display: Add Logging for Gamma Related information (1/2)
      drm/amd/display: Add Logging for Gamma Related information (2/2)
      drm/amd/display: add null checks before logging
      drm/amd/display: Add Logging for Gamma Related information

Xiaojie Yuan (90):
      drm/amdgpu: add navi14 asic type
      drm/amdgpu: add gpu_info firmware for navi14
      drm/amdgpu: set asic family and ip blocks for navi14
      drm/amdgpu: add navi14 ucode loading method
      drm/amdgpu/soc15: initialize reg base for navi14 (v2)
      drm/amdgpu/discovery: init reg base offset via ip discovery for navi1=
4
      drm/amdgpu: increase max instance number for hw ip
      drm/amdgpu/gmc10: add navi14 support
      drm/amdgpu/sdma5: add support for navi14 firmware
      drm/amdgpu/sdma5: add placeholder for navi14 golden settings
      drm/amdgpu/sdma5: add sdma5_0 golden settings for navi14
      drm/amdgpu/sdma5: set clock gating for navi14
      drm/amdgpu/gfx10: add support for navi14 firmware
      drm/amdgpu/gfx10: add placeholder for navi14 golden settings
      drm/amdgpu/gfx10: add gfx config for navi14
      drm/amdgpu/gfx10: add clockgating support for navi14
      drm/amdgpu: add me/mec configurations for navi14
      drm/amdgpu: set rlc funcs for navi14
      drm/amdgpu/gfx10: set tcp harvest for navi14
      drm/amdgpu/gfx: add definition of mmCGTT_GS_NGG_CLK_CTRL
      drm/amdgpu/gfx10: add gfx v10_1_1 golden settings for navi14
      drm/amdgpu/gfx: update gc_v10_1_1 golden setting
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/soc15: add support for navi14
      drm/amdgpu: add ip blocks for navi14
      drm/amdgpu: enable virtual display for navi14
      drm/amdgpu/psp: add psp support for navi14 (v3)
      drm/amdgpu: enable psp ip block for navi14
      drm/amdgpu/psp: start rlc autoload after psp received rlcg for navi14
      drm/amdgpu/smu11: add support for navi14
      drm/amdgpu: enable sw smu ip for navi14
      drm/amdgpu: skip to load ta firmware for navi14
      drm/amd/display: skip to load dmcu firmware for navi14
      drm/amdgpu: declare asd firmware for navi14
      drm/amdgpu/mmhub2: set clock gating for navi14
      drm/amdgpu/athub2: set clock gating for navi14
      drm/amdgpu: enable clock gatings for navi14
      drm/amdgpu: enable async gfx ring for navi14
      drm/amd/display: disable display writeback for navi14
      drm/amdgpu/nv: set vcn pg flag for navi14
      drm/amd/powerplay: disable gfxoff for navi14
      drm/amdgpu/vcn: enable indirect DPG SRAM mode for navi14
      drm/amdgpu: add ip offset header for navi12 (v2)
      drm/amdgpu: initialize reg base for navi12
      drm/amdgpu: add navi12 asic type
      drm/amdgpu: add gpu_info firmware for navi12
      drm/amdgpu: set asic family and ip blocks for navi12
      drm/amdgpu: use front door firmware loading for navi12
      drm/amdgpu: initialize cg/pg flags and external rev id for navi12
      drm/amdgpu: set nbio/hdp cg for navi12
      drm/amdgpu/gfx10: set gfx cg for navi12
      drm/amdgpu/gfx10: add gfx config for navi12
      drm/amdgpu/gfx10: declare cp/rlc firmwares for navi12
      drm/amdgpu/gfx10: add placeholder for navi12 golden settings
      drm/amdgpu/gfx10: set number of me(c)/pipe/queue for navi12
      drm/amdgpu/gfx10: set rlc funcs for navi12
      drm/amdgpu/sdma5: declare sdma firmwares for navi12
      drm/amdgpu/sdma5: add placeholder for navi12 golden settings
      drm/amdgpu/gmc10: set gart size and vm size for navi12
      drm/amdgpu: add ip blocks for navi12
      drm/amdgpu/gfx10: set tcp harvest for navi12
      drm/amdgpu: enable virtual display for navi12
      drm/amdgpu/gfx10: add golden settings for navi12 (v2)
      drm/amdgpu/sdma5: add golden settings for navi12 (v2)
      drm/amdgpu: add CGTT_GS_NGG_CLK_CTRL register to gc header
      drm/amdgpu/smu11: add smu support for navi12
      drm/amdgpu/psp11: add psp support for navi12
      drm/amdgpu: start autoload till RLCG fw for navi12
      drm/amdgpu: add smu ip block for navi12
      drm/amdgpu: add psp ip block for navi12
      drm/amdgpu/discovery: move common discovery code out of
navi1*_reg_base_init()
      drm/amdgpu: enable gfx clock gatings for navi12
      drm/amdgpu: enable hdp clock gating for navi12
      drm/amdgpu/sdma5: set sdma clock gating for navi12
      drm/amdgpu: enable sdma clock gating for navi12
      drm/amdgpu/mmhub2: set clock gating for navi12
      drm/amdgpu: enable mmhub clock gating for navi12
      drm/amdgpu: enable ih clock gating for navi12
      drm/amdgpu/athub2: set clock gating for navi12
      drm/amdgpu: enable athub clock gating for navi12
      drm/amdgpu: enable vcn clock gating for navi12
      drm/amdgpu: remove special autoload handling for navi12
      drm/amdgpu: fix debug level for ppt offset/size
      drm/amdgpu: add firmware header printing for psp fw loading (v2)
      drm/amdgpu: remove redundant argument for psp_funcs::cmd_submit callb=
ack
      drm/amdgpu/sdma5: fix number of sdma5 trap irq types for navi1x
      drm/amdgpu: add dummy read for some GCVM status registers
      drm/amdgpu: enable vcn powergating for navi12
      drm/amdgpu: enable athub powergating for navi12
      drm/amd/powerplay: enable jpeg powergating for navi1x

Xiaolin Zhang (2):
      drm/i915/gvt: update vgpu workload head pointer correctly
      drm/i915: to make vgpu ppgtt notificaiton as atomic operation

Xiong Zhang (1):
      drm/i915: Don't deballoon unused ggtt drm_mm_node in linux guest

Xu YiPing (21):
      drm: kirin: Remove uncessary parameter indirection
      drm: kirin: Remove out_format from ade_crtc
      drm: kirin: Rename ade_plane to kirin_plane
      drm: kirin: Rename ade_crtc to kirin_crtc
      drm: kirin: Dynamically allocate the hw_ctx
      drm: kirin: Move request irq handle in ade hw ctx alloc
      drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to kirin_drm_d=
rv.h
      drm: kirin: Reanme dc_ops to kirin_drm_data
      drm: kirin: Move ade crtc/plane help functions to driver_data
      drm: kirin: Move channel formats to driver data
      drm: kirin: Move mode config function to driver_data
      drm: kirin: Move plane number and primay plane in driver data
      drm: kirin: Move config max_width and max_height to driver data
      drm: kirin: Move drm driver to driver data
      drm: kirin: Add register connect helper functions in drm init
      drm: kirin: Rename plane_init and crtc_init
      drm: kirin: Fix dev->driver_data setting
      drm: kirin: Make driver_data variable non-global
      drm: kirin: Add alloc_hw_ctx/clean_hw_ctx ops in driver data
      drm: kirin: Pass driver data to crtc init and plane init
      drm: kirin: Move ade drm init to kirin drm drv

Yogesh Mohan Marimuthu (1):
      drm/amd/display: fix trigger not generated for freesync

Yong Zhao (12):
      amd/amdkfd: Add ASIC ARCTURUS to kfd
      drm/amdkfd: Expose function mmhub_v9_4_setup_vm_pt_regs() for kfd to =
use
      drm/amdkfd: Support two MMHUBs when setting up page table base in KFD
      drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION to 0 for MMHUB 9.=
4
      drm/amdkfd: Support MMHUB1 in kfd interrupt path
      amd/powerplay: No SW XGMI dpm for Arcturus rev 2
      drm/amdgpu: Add more detail to the VM fault printing
      drm/amdgpu: Add printing for RW extracted from
VM_L2_PROTECTION_FAULT_STATUS
      drm/amdgpu: Add more page fault info printing for GFX10
      drm/amdgpu: Set VM_L2_CNTL.PDE_FAULT_CLASSIFICATION to 0 for GFX10
      drm/amdkfd: Fill amdgpu_task_info for KFD VMs
      drm/amdkfd: Fill the name field in node topology with asic name v2

Yongqiang Sun (2):
      drm/amd/display: Add PIXEL_RATE control regs for more instances
      drm/amd/display: Add DFS reference clock field

Yue Hu (1):
      drm: Switch to use DEVFREQ_GOV_SIMPLE_ONDEMAND constant

YueHaibing (17):
      drm/sti: Remove duplicated include from sti_drv.c
      drm/bridge: sii902x: Make sii902x_audio_digital_mute static
      drm/i915: Remove set but not used variable 'encoder'
      drm/i915: Remove set but not used variable 'intel_dig_port'
      drm/i915: Remove set but not used variable 'src_y'
      drm/i915/dsi: remove set but not used variable 'hfront_porch'
      drm/komeda: remove set but not used variable 'old'
      drm/rockchip: Make analogix_dp_atomic_check static
      drm/amdgpu: remove set but not used variable 'psp_enabled'
      drm/amdgpu: remove duplicated include from gfx_v9_0.c
      drm/amd/display: remove duplicated include from dc_link.c
      drm/amdkfd: remove set but not used variable 'pdd'
      drm/amdkfd: Make deallocate_hiq_sdma_mqd static
      drm/nouveau/secboot: Make acr_r352_ls_gpccs_func static
      drm/hisilicon/hibmc: Using module_pci_driver.
      drm/amdgpu/display: fix build error without CONFIG_DRM_AMD_DC_DSC_SUP=
PORT
      drm/amd/display: remove unused function setFieldWithMask

Zhan Liu (1):
      drm/amd/display: drop ASSERT() if eDP panel is not connected

Zhenyu Wang (1):
      drm/i915/gvt: Fix typo of VBLANK_TIMER_PERIOD

Zhi Wang (1):
      drm/i915/gvt: factor out tlb and mocs register offset table

Zi Yu Liao (3):
      drm/amd/display: fix DMCU hang when going into Modern Standby
      drm/amd/display: fix MPO HUBP underflow with Scatter Gather
      drm/amd/display: fix stuck test pattern on right half of display

hersen wu (1):
      drm/amd/display: flicking observed while installing driver on Navi10 =
CF

james qian wang (Arm Technology China) (2):
      drm/komeda: Use drm_display_mode "crtc_" prefixed hardware timings
      drm/komeda: Enable dual-link support

shaoyunl (1):
      drm/amdgpu: enable Navi12 kfd support for amdgpu

tiancyin (5):
      drm/amdgpu/sdma5: update sdma5 golden settings for navi14
      drm/amdgpu/gmc10: fix pte mytpe field error for navi14
      drm/amdgpu/soc15: fix external_rev_id for navi14
      drm/amd/powerplay: re-define smu interface version for smu v11
      drm/amd/powerplay: update smu11_driver_if_navi10.h

xinhui pan (1):
      drm/amdgpu: Fix panic during gpu reset

yanyan kang (1):
      drm/amd/display: audio cannot switch to internal when display turns o=
ff

 .../bindings/display/amlogic,meson-dw-hdmi.txt     |   119 -
 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   150 +
 .../bindings/display/amlogic,meson-vpu.txt         |   121 -
 .../bindings/display/amlogic,meson-vpu.yaml        |   137 +
 .../devicetree/bindings/display/arm,pl11x.txt      |     9 +-
 .../devicetree/bindings/display/bridge/sii902x.txt |     5 +-
 .../bindings/display/connector/hdmi-connector.txt  |     1 +
 .../display/panel/ampire,am-480272h3tmqw-t01h.txt  |    26 -
 .../display/panel/ampire,am-480272h3tmqw-t01h.yaml |    42 +
 .../display/panel/arm,versatile-tft-panel.txt      |     2 +-
 .../display/panel/armadeus,st0700-adapt.txt        |     9 -
 .../display/panel/armadeus,st0700-adapt.yaml       |    33 +
 .../display/panel/bananapi,s070wv20-ct16.txt       |    12 -
 .../display/panel/bananapi,s070wv20-ct16.yaml      |    31 +
 .../bindings/display/panel/boe,himax8279d.txt      |    24 +
 .../bindings/display/panel/dlc,dlc0700yzg-1.txt    |    13 -
 .../bindings/display/panel/dlc,dlc0700yzg-1.yaml   |    31 +
 .../bindings/display/panel/edt,et-series.txt       |     2 +-
 .../bindings/display/panel/giantplus,gpm940b0.txt  |    12 +
 .../bindings/display/panel/innolux,ee101ia-01d.txt |     7 -
 .../display/panel/innolux,ee101ia-01d.yaml         |    31 +
 .../display/panel/kingdisplay,kd035g6-54nt.txt     |    42 +
 .../devicetree/bindings/display/panel/lvds.yaml    |   107 +
 .../display/panel/mitsubishi,aa104xd12.txt         |    47 -
 .../display/panel/mitsubishi,aa104xd12.yaml        |    75 +
 .../display/panel/mitsubishi,aa121td01.txt         |    47 -
 .../display/panel/mitsubishi,aa121td01.yaml        |    74 +
 .../bindings/display/panel/nec,nl8048hl11.yaml     |    62 +
 .../display/panel/ortustech,com37h3m05dtc.txt      |    12 +
 .../display/panel/ortustech,com37h3m99dtc.txt      |    12 +
 .../bindings/display/panel/panel-common.txt        |   101 -
 .../bindings/display/panel/panel-common.yaml       |   149 +
 .../bindings/display/panel/panel-lvds.txt          |   121 -
 .../devicetree/bindings/display/panel/panel.txt    |     4 -
 .../bindings/display/panel/pda,91-00156-a0.txt     |    14 -
 .../bindings/display/panel/pda,91-00156-a0.yaml    |    31 +
 .../panel/raspberrypi,7inch-touchscreen.txt        |    49 -
 .../panel/raspberrypi,7inch-touchscreen.yaml       |    71 +
 .../bindings/display/panel/raydium,rm67191.txt     |    41 +
 .../display/panel/rocktech,jh057n00900.txt         |     5 +
 .../bindings/display/panel/sgd,gktw70sdae4se.txt   |    41 -
 .../bindings/display/panel/sgd,gktw70sdae4se.yaml  |    68 +
 .../bindings/display/panel/sharp,ld-d5116z01b.txt  |    26 +
 .../bindings/display/panel/sharp,lq070y3dg3b.txt   |    12 +
 .../bindings/display/panel/sharp,ls020b1dd01d.txt  |    12 +
 .../bindings/display/panel/simple-panel.txt        |    29 +-
 .../display/panel/tfc,s9700rtwv43tr-01b.txt        |    15 -
 .../display/panel/tfc,s9700rtwv43tr-01b.yaml       |    33 +
 .../bindings/display/panel/ti,nspire.yaml          |    36 +
 .../bindings/display/panel/tpo,tpg110.txt          |    70 -
 .../bindings/display/panel/tpo,tpg110.yaml         |   101 +
 .../display/rockchip/dw_mipi_dsi_rockchip.txt      |    23 +-
 .../bindings/display/rockchip/rockchip-lvds.txt    |    11 -
 .../devicetree/bindings/display/ssd1307fb.txt      |    10 +
 .../devicetree/bindings/vendor-prefixes.yaml       |     5 +
 Documentation/gpu/drivers.rst                      |     1 -
 Documentation/gpu/drm-kms-helpers.rst              |    12 +
 Documentation/gpu/drm-mm.rst                       |    40 +-
 Documentation/gpu/i915.rst                         |    23 +-
 Documentation/gpu/introduction.rst                 |    16 +
 Documentation/gpu/tinydrm.rst                      |    30 -
 Documentation/gpu/todo.rst                         |    81 +-
 Documentation/media/uapi/v4l/subdev-formats.rst    |   107 +
 MAINTAINERS                                        |    64 +-
 arch/x86/kernel/early-quirks.c                     |     1 +
 drivers/dma-buf/Kconfig                            |     5 +
 drivers/dma-buf/Makefile                           |     8 +-
 drivers/dma-buf/dma-buf.c                          |    28 +-
 drivers/dma-buf/dma-fence-array.c                  |    32 +-
 drivers/dma-buf/dma-fence-chain.c                  |    24 +-
 drivers/dma-buf/dma-fence.c                        |    55 +-
 drivers/dma-buf/{reservation.c =3D> dma-resv.c}      |   251 +-
 drivers/dma-buf/selftest.c                         |   167 +
 drivers/dma-buf/selftest.h                         |    30 +
 drivers/dma-buf/selftests.h                        |    13 +
 drivers/dma-buf/st-dma-fence.c                     |   574 +
 drivers/dma-buf/sw_sync.c                          |    16 +-
 drivers/dma-buf/sync_file.c                        |     2 +-
 drivers/gpu/drm/Kconfig                            |     6 +-
 drivers/gpu/drm/Makefile                           |     4 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    48 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |     1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |   323 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |    42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   181 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |    69 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |    96 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |    72 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   172 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    48 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h        |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h       |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   137 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   115 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   120 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   218 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |   313 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |   493 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |    90 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h           |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |    16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |    82 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   210 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |    35 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    45 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    13 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c        |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |   114 +-
 drivers/gpu/drm/amd/amdgpu/arct_reg_init.c         |    59 +
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c            |   103 +
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.h            |    30 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c            |     2 +
 drivers/gpu/drm/amd/amdgpu/cik.c                   |     7 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |     4 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |     4 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |     4 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |     4 +
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |     7 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |   202 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   222 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    19 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    59 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  1347 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |     4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   122 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |    23 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |    28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   401 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h              |     7 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   132 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h            |     2 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |   642 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h            |    36 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    15 -
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |     3 +-
 drivers/gpu/drm/amd/amdgpu/navi10_reg_init.c       |    14 +-
 drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c       |    53 +
 drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c       |    54 +
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    21 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |    72 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   128 +-
 drivers/gpu/drm/amd/amdgpu/nv.h                    |     2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    11 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    26 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |   565 +
 .../intel_guc_fw.h =3D> amd/amdgpu/psp_v12_0.h}      |    25 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |     3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   678 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |    60 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    13 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         |   724 +
 .../intel_guc_ads.h =3D> amd/amdgpu/smu_v11_0_i2c.h} |    28 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   247 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |     1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |     5 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |   255 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h              |    51 +
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   116 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |   311 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h              |    38 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  1414 +
 .../amdgpu/vcn_v2_5.h}                             |    26 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    31 +-
 drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c       |     4 +
 drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c       |     6 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |     7 +
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  1455 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |  1992 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |   395 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |   547 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |     3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    44 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |     2 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue_v9.c   |    59 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |    10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |    18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h    |    24 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |    13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     4 +-
 drivers/gpu/drm/amd/display/Kconfig                |     8 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   258 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    17 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   231 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |    67 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    24 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    26 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |    51 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |     3 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |     3 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |     3 +-
 .../amd/display/dc/bios/command_table_helper2.c    |     5 +
 .../dc/bios/dce110/command_table_helper_dce110.c   |    36 +-
 .../dc/bios/dce112/command_table_helper2_dce112.c  |    36 +-
 .../dc/bios/dce112/command_table_helper_dce112.c   |    36 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |     4 +
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |    35 +-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |    12 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile    |    10 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |     9 +
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |    17 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |    12 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   170 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h   |     5 +
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   590 +
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h  |    39 +
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c        |   200 +
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h        |    40 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   186 +-
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |    40 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   249 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |     2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   689 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   204 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   305 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    27 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |     3 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    57 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |    24 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |    61 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    21 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    14 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |    34 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h     |     6 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     9 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    36 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.h  |    17 +
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h     |   168 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |    16 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |    10 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |    61 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |     6 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   113 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.h    |    10 +-
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    42 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |     6 +-
 .../drm/amd/display/dc/dce112/dce112_resource.c    |     2 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |     2 +-
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |    14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c |     7 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |    16 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h   |     2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c    |     4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |    81 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |    72 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |    53 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   416 +-
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |     2 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |    72 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |     3 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |    21 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   |     4 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    25 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |    14 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |    10 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |    59 +-
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |    22 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |     4 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |    31 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h  |     2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |    26 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h   |    21 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp_cm.c    |     7 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c   |   130 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h   |     4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c    |    99 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h    |    26 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |   772 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h  |   105 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   727 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h |    16 +-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |     1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |    40 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h   |     6 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c   |     1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |    95 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |     7 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   861 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.h  |    12 +
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |    39 +-
 .../amd/display/dc/dcn20/dcn20_stream_encoder.h    |     5 +
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      |    10 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |   595 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h    |   132 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |   244 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h  |   133 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  1680 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.h  |    45 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h         |    47 +
 drivers/gpu/drm/amd/display/dc/dm_services.h       |     1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    15 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |  5136 ++
 .../display/dc/dml/dcn20/display_mode_vba_20v2.h   |    32 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |  1701 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h        |    74 +
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |  6123 ++
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.h |    32 +
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |  1823 +
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.h  |    73 +
 .../drm/amd/display/dc/dml/display_mode_enums.h    |    22 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |    31 +
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |     4 +
 .../drm/amd/display/dc/dml/display_mode_structs.h  |     4 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    21 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |    18 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |     4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |    71 +-
 drivers/gpu/drm/amd/display/dc/dsc/drm_dsc_dc.c    |   388 -
 drivers/gpu/drm/amd/display/dc/gpio/Makefile       |     9 +-
 .../amd/display/dc/gpio/dce110/hw_factory_dce110.c |    18 +-
 .../amd/display/dc/gpio/dce120/hw_factory_dce120.c |    14 +-
 .../amd/display/dc/gpio/dce80/hw_factory_dce80.c   |    14 +-
 .../amd/display/dc/gpio/dcn10/hw_factory_dcn10.c   |    52 +-
 .../amd/display/dc/gpio/dcn20/hw_factory_dcn20.c   |    51 +-
 .../amd/display/dc/gpio/dcn20/hw_translate_dcn20.c |     2 +-
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.c   |   210 +
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.h   |    33 +
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c |   386 +
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.h |    35 +
 .../display/dc/gpio/diagnostics/hw_factory_diag.c  |    10 +-
 drivers/gpu/drm/amd/display/dc/gpio/generic_regs.h |    66 +
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c    |    74 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c |   117 +-
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.h |     6 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |    26 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.h       |     5 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |     8 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.h   |    51 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c   |   138 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.h   |    50 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c       |    31 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.h       |     5 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |     8 +
 drivers/gpu/drm/amd/display/dc/inc/core_status.h   |     3 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    19 +-
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |    10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   132 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |    15 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h       |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h        |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h        |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h        |    12 -
 drivers/gpu/drm/amd/display/dc/inc/hw/gpio.h       |    10 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |    13 +-
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |     3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h  |     6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |     8 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h        |     5 -
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |    20 +-
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    15 +-
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    51 +-
 drivers/gpu/drm/amd/display/dc/inc/link_hwss.h     |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     3 -
 drivers/gpu/drm/amd/display/dc/irq/Makefile        |    10 +
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |    28 +-
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |   374 +
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.h   |    34 +
 .../display/dc/virtual/virtual_stream_encoder.c    |     5 +
 drivers/gpu/drm/amd/display/include/audio_types.h  |     4 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |    15 +
 drivers/gpu/drm/amd/display/include/dal_types.h    |     3 +
 .../drm/amd/display/include/ddc_service_types.h    |    10 +-
 .../gpu/drm/amd/display/include/gpio_interface.h   |     9 +
 .../amd/display/include/gpio_service_interface.h   |    18 +-
 .../drm/amd/display/include/link_service_types.h   |    17 +-
 .../gpu/drm/amd/display/include/logger_interface.h |     2 +
 drivers/gpu/drm/amd/display/include/logger_types.h |     7 +
 .../drm/amd/display/modules/color/color_gamma.c    |   367 +-
 .../drm/amd/display/modules/color/color_gamma.h    |    10 +
 .../drm/amd/display/modules/freesync/freesync.c    |   303 +-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |     2 +
 .../drm/amd/display/modules/inc/mod_info_packet.h  |     2 +-
 .../amd/display/modules/info_packet/info_packet.c  |    69 +
 .../drm/amd/display/modules/power/power_helpers.c  |   121 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |     1 +
 drivers/gpu/drm/amd/include/arct_ip_offset.h       |  1650 +
 .../amd/include/asic_reg/clk/clk_10_0_2_offset.h   |    56 +
 .../amd/include/asic_reg/clk/clk_10_0_2_sh_mask.h  |    73 +
 .../amd/include/asic_reg/dcn/dcn_2_1_0_offset.h    | 13862 +++++
 .../amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h   | 56638 +++++++++++++++=
++++
 .../amd/include/asic_reg/dcn/dpcs_2_1_0_offset.h   |   565 +
 .../amd/include/asic_reg/dcn/dpcs_2_1_0_sh_mask.h  |  3430 ++
 .../drm/amd/include/asic_reg/df/df_3_6_offset.h    |     4 +
 .../drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h |     2 +
 .../amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h    |    39 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_offset.h    |     2 +
 .../drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h   |   157 +
 .../include/asic_reg/mmhub/mmhub_9_4_0_offset.h    |    21 +
 .../include/asic_reg/mmhub/mmhub_9_4_0_sh_mask.h   |   222 +
 .../include/asic_reg/mmhub/mmhub_9_4_1_default.h   |  3933 ++
 .../include/asic_reg/mmhub/mmhub_9_4_1_offset.h    |  7753 +++
 .../include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h   | 44884 +++++++++++++++
 .../drm/amd/include/asic_reg/mp/mp_12_0_0_offset.h |   336 +
 .../amd/include/asic_reg/mp/mp_12_0_0_sh_mask.h    |   866 +
 .../amd/include/asic_reg/nbio/nbio_7_0_sh_mask.h   |    30 +
 .../drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h   |     6 +
 .../amd/include/asic_reg/oss/osssys_4_0_sh_mask.h  |     4 +
 .../amd/include/asic_reg/rsmu/rsmu_0_0_2_offset.h  |    27 +
 .../amd/include/asic_reg/rsmu/rsmu_0_0_2_sh_mask.h |    32 +
 .../include/asic_reg/sdma0/sdma0_4_2_2_offset.h    |  1051 +
 .../include/asic_reg/sdma0/sdma0_4_2_2_sh_mask.h   |  3002 +
 .../include/asic_reg/sdma1/sdma1_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma1/sdma1_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma2/sdma2_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma2/sdma2_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma3/sdma3_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma3/sdma3_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma4/sdma4_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma4/sdma4_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma5/sdma5_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma5/sdma5_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma6/sdma6_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma6/sdma6_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/sdma7/sdma7_4_2_2_offset.h    |  1043 +
 .../include/asic_reg/sdma7/sdma7_4_2_2_sh_mask.h   |  2956 +
 .../include/asic_reg/smuio/smuio_11_0_0_offset.h   |    92 +
 .../include/asic_reg/smuio/smuio_11_0_0_sh_mask.h  |   231 +
 .../amd/include/asic_reg/umc/umc_6_1_1_offset.h    |    31 +
 .../amd/include/asic_reg/umc/umc_6_1_1_sh_mask.h   |    91 +
 .../drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h  |   979 +
 .../drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h |  3609 ++
 drivers/gpu/drm/amd/include/atomfirmware.h         |    86 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    11 +
 drivers/gpu/drm/amd/include/navi12_ip_offset.h     |  1119 +
 drivers/gpu/drm/amd/include/navi14_ip_offset.h     |  1119 +
 drivers/gpu/drm/amd/include/renoir_ip_offset.h     |  1364 +
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h    |    11 +-
 drivers/gpu/drm/amd/include/v9_structs.h           |     8 +-
 drivers/gpu/drm/amd/powerplay/Makefile             |     2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |    51 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   379 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  1938 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.h       |    72 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |     7 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |    12 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |    28 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |    26 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   114 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   241 +-
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h |   120 +
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    11 +
 drivers/gpu/drm/amd/powerplay/inc/rv_ppsmc.h       |     2 +-
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if.h    |     4 +-
 .../amd/powerplay/inc/smu11_driver_if_arcturus.h   |   891 +
 .../drm/amd/powerplay/inc/smu11_driver_if_navi10.h |    29 +-
 .../gpu/drm/amd/powerplay/inc/smu12_driver_if.h    |   217 +
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h      |   263 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |    27 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h      |    42 +
 .../gpu/drm/amd/powerplay/inc/smu_v12_0_ppsmc.h    |   106 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |   417 +-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         |   195 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h         |    28 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |   331 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          |   412 +
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |     4 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |     5 +-
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |     4 +
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |     4 +
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |    10 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.h   |     2 +
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |   270 +-
 drivers/gpu/drm/arc/arcpgu_drv.c                   |     5 +-
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |    42 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |    89 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |    14 +-
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c    |     8 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |     5 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |     4 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |    19 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |     6 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |     2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |     4 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    12 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                    |    13 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |    11 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |    13 +-
 drivers/gpu/drm/arm/malidp_drv.h                   |     7 +-
 drivers/gpu/drm/arm/malidp_hw.c                    |    10 +-
 drivers/gpu/drm/arm/malidp_mw.c                    |     5 +-
 drivers/gpu/drm/arm/malidp_planes.c                |     4 +-
 drivers/gpu/drm/armada/armada_crtc.c               |    10 +-
 drivers/gpu/drm/armada/armada_debugfs.c            |     8 +-
 drivers/gpu/drm/armada/armada_drm.h                |     5 +-
 drivers/gpu/drm/armada/armada_drv.c                |    11 +-
 drivers/gpu/drm/armada/armada_fb.c                 |     3 +
 drivers/gpu/drm/armada/armada_fbdev.c              |     3 +
 drivers/gpu/drm/armada/armada_gem.c                |    12 +-
 drivers/gpu/drm/armada/armada_gem.h                |     3 +-
 drivers/gpu/drm/armada/armada_overlay.c            |     8 +-
 drivers/gpu/drm/armada/armada_plane.c              |     4 +-
 drivers/gpu/drm/armada/armada_trace.h              |     5 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |     2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |     3 +-
 drivers/gpu/drm/ast/Makefile                       |     2 +-
 drivers/gpu/drm/ast/ast_dp501.c                    |     5 +-
 drivers/gpu/drm/ast/ast_drv.c                      |    22 +-
 drivers/gpu/drm/ast/ast_drv.h                      |    46 +-
 drivers/gpu/drm/ast/ast_fb.c                       |   346 -
 drivers/gpu/drm/ast/ast_main.c                     |    77 +-
 drivers/gpu/drm/ast/ast_mode.c                     |    60 +-
 drivers/gpu/drm/ast/ast_post.c                     |     7 +-
 drivers/gpu/drm/ast/ast_ttm.c                      |     7 +-
 drivers/gpu/drm/ati_pcigart.c                      |    10 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |    12 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |    18 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |    20 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   |     3 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |    12 +-
 drivers/gpu/drm/bochs/bochs.h                      |     6 +-
 drivers/gpu/drm/bochs/bochs_drv.c                  |    17 +-
 drivers/gpu/drm/bochs/bochs_hw.c                   |     4 +
 drivers/gpu/drm/bochs/bochs_kms.c                  |     8 +-
 drivers/gpu/drm/bridge/Kconfig                     |     2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |    12 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   295 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |     2 +-
 drivers/gpu/drm/bridge/dumb-vga-dac.c              |    13 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |     1 -
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |     3 -
 drivers/gpu/drm/bridge/parade-ps8622.c             |     1 -
 drivers/gpu/drm/bridge/sii902x.c                   |    44 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c    |    20 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h    |     1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c      |    13 +-
 .../gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c    |    60 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   134 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h          |    13 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |    47 +
 drivers/gpu/drm/bridge/tc358767.c                  |   683 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    46 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |     6 +-
 drivers/gpu/drm/cirrus/cirrus.c                    |     2 +-
 drivers/gpu/drm/drm_agpsupport.c                   |    45 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |     6 +-
 drivers/gpu/drm/drm_client.c                       |     1 -
 drivers/gpu/drm/drm_connector.c                    |   109 +-
 drivers/gpu/drm/drm_crtc_helper.c                  |    32 -
 drivers/gpu/drm/drm_debugfs_crc.c                  |    15 +-
 drivers/gpu/drm/drm_dma.c                          |     2 +-
 drivers/gpu/drm/drm_dp_aux_dev.c                   |    18 +-
 drivers/gpu/drm/drm_dp_helper.c                    |    31 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |   142 +-
 drivers/gpu/drm/drm_drv.c                          |    18 +-
 drivers/gpu/drm/drm_file.c                         |     9 +-
 drivers/gpu/drm/drm_gem.c                          |    37 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    74 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             |    71 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |    94 +-
 drivers/gpu/drm/drm_hdcp.c                         |    77 +-
 drivers/gpu/drm/drm_ioc32.c                        |    13 +-
 drivers/gpu/drm/drm_ioctl.c                        |   139 +-
 drivers/gpu/drm/drm_kms_helper_common.c            |     2 +-
 drivers/gpu/drm/drm_legacy_misc.c                  |     2 +-
 drivers/gpu/drm/drm_lock.c                         |     2 +-
 drivers/gpu/drm/drm_memory.c                       |     2 +-
 .../gpu/drm/{tinydrm/mipi-dbi.c =3D> drm_mipi_dbi.c} |   499 +-
 drivers/gpu/drm/drm_mm.c                           |     2 +-
 drivers/gpu/drm/drm_mode_object.c                  |     4 +
 drivers/gpu/drm/drm_modes.c                        |    17 +-
 drivers/gpu/drm/drm_panel.c                        |   102 +-
 drivers/gpu/drm/drm_prime.c                        |   868 +-
 drivers/gpu/drm/drm_scatter.c                      |     2 +-
 drivers/gpu/drm/drm_syncobj.c                      |   109 +-
 drivers/gpu/drm/drm_sysfs.c                        |    43 +
 drivers/gpu/drm/drm_vblank.c                       |    25 +-
 drivers/gpu/drm/drm_vm.c                           |     2 +-
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           |    93 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.c           |    58 +-
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.h           |    15 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |    96 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.h              |    27 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |    65 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.h             |     4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |    78 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |    13 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |     3 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |    59 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |   158 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h              |    11 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu.c            |   167 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu.h            |    20 -
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |   284 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   326 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h              |   114 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |    48 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |     4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |    29 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |     2 +
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |     2 +
 drivers/gpu/drm/exynos/exynos_drm_ipp.c            |     5 +-
 drivers/gpu/drm/exynos/exynos_drm_ipp.h            |     2 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |     2 +
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |     1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |     5 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |     9 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c          |     1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |     2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |    11 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig            |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |     6 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |    29 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |     9 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c  |     2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |     1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |     8 +-
 drivers/gpu/drm/hisilicon/kirin/Kconfig            |    10 +-
 drivers/gpu/drm/hisilicon/kirin/Makefile           |     3 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h    |     1 +
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |   359 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |   258 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h    |    48 +-
 drivers/gpu/drm/i2c/ch7006_priv.h                  |     1 -
 drivers/gpu/drm/i2c/sil164_drv.c                   |     3 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                  |     2 +-
 drivers/gpu/drm/i810/i810_dma.c                    |    17 +-
 drivers/gpu/drm/i810/i810_drv.c                    |     8 +-
 drivers/gpu/drm/i810/i810_drv.h                    |     2 +
 drivers/gpu/drm/i915/Kconfig.debug                 |    16 +
 drivers/gpu/drm/i915/Makefile                      |    93 +-
 drivers/gpu/drm/i915/Makefile.header-test          |    22 -
 drivers/gpu/drm/i915/display/Makefile              |     6 +-
 drivers/gpu/drm/i915/display/Makefile.header-test  |    16 -
 drivers/gpu/drm/i915/display/dvo_ch7017.c          |     2 +-
 drivers/gpu/drm/i915/display/dvo_ch7xxx.c          |     2 +-
 drivers/gpu/drm/i915/display/dvo_ivch.c            |     2 +-
 drivers/gpu/drm/i915/display/dvo_ns2501.c          |     2 +-
 drivers/gpu/drm/i915/display/dvo_sil164.c          |     2 +-
 drivers/gpu/drm/i915/display/dvo_tfp410.c          |     2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |   244 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |     2 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |    59 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.h  |     5 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |    83 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |    25 +-
 drivers/gpu/drm/i915/display/intel_bios.h          |     3 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |    18 +-
 drivers/gpu/drm/i915/display/intel_bw.h            |    15 -
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   106 +-
 drivers/gpu/drm/i915/display/intel_color.c         |     2 +-
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |   195 +-
 drivers/gpu/drm/i915/display/intel_combo_phy.h     |     4 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |     4 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |    17 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   469 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  1365 +-
 drivers/gpu/drm/i915/display/intel_display.h       |   239 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   779 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    73 +-
 .../{intel_drv.h =3D> display/intel_display_types.h} |   191 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   394 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |     2 -
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |     7 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |     2 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    27 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |     1 +
 drivers/gpu/drm/i915/display/intel_dpio_phy.c      |     8 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   698 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |    57 +-
 drivers/gpu/drm/i915/display/intel_dsi.h           |    15 +-
 .../gpu/drm/i915/display/intel_dsi_dcs_backlight.c |     2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |     2 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |     2 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |     7 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |    51 +-
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |     3 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |   257 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.h   |    70 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         |    19 +-
 drivers/gpu/drm/i915/display/intel_gmbus.h         |    22 +
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   104 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |     2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   118 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |    67 +-
 drivers/gpu/drm/i915/display/intel_hotplug.h       |     5 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |     2 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |     8 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |     2 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   149 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |     2 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |     4 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |     8 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        |     2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   316 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   344 +-
 drivers/gpu/drm/i915/display/intel_sprite.h        |     8 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |   544 +
 drivers/gpu/drm/i915/display/intel_tc.h            |    30 +
 drivers/gpu/drm/i915/display/intel_tv.c            |     2 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |     6 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |    16 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |    88 +-
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c         |    20 +-
 drivers/gpu/drm/i915/gem/Makefile                  |     6 +-
 drivers/gpu/drm/i915/gem/Makefile.header-test      |    16 -
 drivers/gpu/drm/i915/gem/i915_gem_busy.c           |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |   127 +-
 drivers/gpu/drm/i915/gem/i915_gem_client_blt.c     |    60 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   231 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |     8 -
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |     9 +-
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |     7 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |    49 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   343 +-
 drivers/gpu/drm/i915/gem/i915_gem_fence.c          |     5 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    32 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   159 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |    24 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |   376 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.h     |    25 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    10 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    13 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |    13 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |    51 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |     8 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   101 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.h       |    31 +
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |    11 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.h         |    35 +
 drivers/gpu/drm/i915/gem/i915_gem_throttle.c       |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |    14 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |    24 +-
 drivers/gpu/drm/i915/gem/i915_gemfs.c              |    31 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |   187 +-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |    42 +-
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |    13 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |   274 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |     8 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    66 +-
 .../drm/i915/gem/selftests/i915_gem_object_blt.c   |   141 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |   141 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.h |    16 +
 drivers/gpu/drm/i915/gt/Makefile                   |     5 +-
 drivers/gpu/drm/i915/gt/Makefile.header-test       |    16 -
 .../gen6_renderstate.c}                            |     0
 .../gen7_renderstate.c}                            |     0
 .../gen8_renderstate.c}                            |     0
 .../gen9_renderstate.c}                            |     0
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |    49 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |   180 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |    35 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |    15 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |    90 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   430 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    87 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |    20 +-
 drivers/gpu/drm/i915/gt/intel_engine_pool.c        |   177 +
 drivers/gpu/drm/i915/gt/intel_engine_pool.h        |    34 +
 drivers/gpu/drm/i915/gt/intel_engine_pool_types.h  |    29 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |   129 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |   303 +
 drivers/gpu/drm/i915/gt/intel_engine_user.h        |    25 +
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |    18 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |   268 +
 drivers/gpu/drm/i915/gt/intel_gt.h                 |    60 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |   455 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.h             |    44 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |    84 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |    41 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.c          |   109 +
 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.h          |    22 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |   102 +
 drivers/gpu/drm/i915/gt/intel_hangcheck.c          |    71 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  1377 +-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |     1 +
 drivers/gpu/drm/i915/gt/intel_mocs.c               |   218 +-
 drivers/gpu/drm/i915/gt/intel_mocs.h               |     7 +-
 .../intel_renderstate.c}                           |    17 +-
 drivers/gpu/drm/i915/{ =3D> gt}/intel_renderstate.h  |    10 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   633 +-
 drivers/gpu/drm/i915/gt/intel_reset.h              |    75 +-
 drivers/gpu/drm/i915/gt/intel_reset_types.h        |    50 +
 drivers/gpu/drm/i915/gt/intel_ringbuffer.c         |   339 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c               |     2 +-
 .../i915/{i915_timeline.c =3D> gt/intel_timeline.c}  |   304 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |    94 +
 .../intel_timeline_types.h}                        |    28 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   253 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.h        |     6 +-
 drivers/gpu/drm/i915/gt/intel_workarounds_types.h  |     1 +
 drivers/gpu/drm/i915/gt/mock_engine.c              |   104 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |   456 +
 drivers/gpu/drm/i915/gt/selftest_engine.c          |    28 +
 drivers/gpu/drm/i915/gt/selftest_engine.h          |    14 +
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c       |    26 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |    83 +
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |   528 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |   522 +-
 drivers/gpu/drm/i915/gt/selftest_reset.c           |   133 +-
 .../i915_timeline.c =3D> gt/selftest_timeline.c}     |   135 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   186 +-
 .../drm/i915/{ =3D> gt}/selftests/mock_timeline.c    |    10 +-
 .../drm/i915/{ =3D> gt}/selftests/mock_timeline.h    |     6 +-
 drivers/gpu/drm/i915/gt/uc/Makefile                |     5 +
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc.c       |   320 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc.h       |    76 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ads.c   |    52 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.h         |    15 +
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ct.c    |    44 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ct.h    |    33 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |   166 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.h          |    14 +
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_fwif.h  |   104 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_log.c   |    78 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_log.h   |    24 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_reg.h   |    62 +-
 .../drm/i915/{ =3D> gt/uc}/intel_guc_submission.c    |   590 +-
 .../drm/i915/{ =3D> gt/uc}/intel_guc_submission.h    |    28 +-
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_huc.c       |   112 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.h             |    54 +
 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c          |    58 +
 drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_huc_fw.h    |     5 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |   627 +
 drivers/gpu/drm/i915/gt/uc/intel_uc.h              |    67 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |   616 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h           |   241 +
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw_abi.h       |    82 +
 .../intel_guc.c =3D> gt/uc/selftest_guc.c}           |    70 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |    10 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   180 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                 |    47 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |     2 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |    13 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |     4 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |     8 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |     4 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |    15 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c            |    57 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |    83 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |     4 +-
 drivers/gpu/drm/i915/i915_active.c                 |   640 +-
 drivers/gpu/drm/i915/i915_active.h                 |    61 +-
 drivers/gpu/drm/i915/i915_active_types.h           |    30 +-
 drivers/gpu/drm/i915/i915_buddy.c                  |   428 +
 drivers/gpu/drm/i915/i915_buddy.h                  |   128 +
 drivers/gpu/drm/i915/i915_cmd_parser.c             |     4 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |   493 +-
 drivers/gpu/drm/i915/i915_drv.c                    |   919 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   766 +-
 drivers/gpu/drm/i915/i915_fixed.h                  |     5 +
 drivers/gpu/drm/i915/i915_gem.c                    |   586 +-
 drivers/gpu/drm/i915/i915_gem.h                    |     2 +
 drivers/gpu/drm/i915/i915_gem_batch_pool.c         |   140 -
 drivers/gpu/drm/i915/i915_gem_batch_pool.h         |    26 -
 drivers/gpu/drm/i915/i915_gem_evict.c              |     9 -
 drivers/gpu/drm/i915/i915_gem_fence_reg.c          |   140 +-
 drivers/gpu/drm/i915/i915_gem_fence_reg.h          |     5 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  2180 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h                |   206 +-
 drivers/gpu/drm/i915/i915_getparam.c               |   168 +
 drivers/gpu/drm/i915/i915_globals.c                |     1 +
 drivers/gpu/drm/i915/i915_globals.h                |     3 +
 drivers/gpu/drm/i915/i915_gpu_error.c              |   824 +-
 drivers/gpu/drm/i915/i915_gpu_error.h              |    78 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  1598 +-
 drivers/gpu/drm/i915/i915_irq.h                    |   110 +-
 drivers/gpu/drm/i915/i915_memcpy.c                 |     2 +-
 drivers/gpu/drm/i915/i915_memcpy.h                 |    32 +
 drivers/gpu/drm/i915/i915_mm.c                     |     5 +-
 drivers/gpu/drm/i915/i915_oa_bdw.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_bxt.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_cflgt2.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_cflgt3.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_chv.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_cnl.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_glk.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_hsw.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_icl.h                 |    15 -
 drivers/gpu/drm/i915/i915_oa_kblgt2.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_kblgt3.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_sklgt2.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_sklgt3.h              |    15 -
 drivers/gpu/drm/i915/i915_oa_sklgt4.h              |    15 -
 drivers/gpu/drm/i915/i915_params.c                 |     5 +-
 drivers/gpu/drm/i915/i915_params.h                 |     2 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    65 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   836 +-
 drivers/gpu/drm/i915/i915_perf.h                   |    32 +
 drivers/gpu/drm/i915/i915_pmu.c                    |   298 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |    15 +-
 drivers/gpu/drm/i915/i915_pvinfo.h                 |     7 +-
 drivers/gpu/drm/i915/i915_query.c                  |     5 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   356 +-
 drivers/gpu/drm/i915/i915_request.c                |   381 +-
 drivers/gpu/drm/i915/i915_request.h                |    29 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |     7 +-
 drivers/gpu/drm/i915/i915_scheduler_types.h        |     1 +
 drivers/gpu/drm/i915/i915_selftest.h               |    29 +-
 drivers/gpu/drm/i915/i915_suspend.c                |     3 +-
 drivers/gpu/drm/i915/i915_suspend.h                |    14 +
 drivers/gpu/drm/i915/i915_sw_fence.c               |    31 +-
 drivers/gpu/drm/i915/i915_sw_fence.h               |    11 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c          |    95 +
 drivers/gpu/drm/i915/i915_sw_fence_work.h          |    44 +
 drivers/gpu/drm/i915/i915_sysfs.c                  |     2 +-
 drivers/gpu/drm/i915/i915_sysfs.h                  |    14 +
 drivers/gpu/drm/i915/i915_timeline.h               |    94 -
 drivers/gpu/drm/i915/i915_trace.h                  |    24 +-
 drivers/gpu/drm/i915/i915_utils.c                  |    78 +
 drivers/gpu/drm/i915/i915_utils.h                  |    51 +
 drivers/gpu/drm/i915/i915_vgpu.c                   |    68 +-
 drivers/gpu/drm/i915/i915_vgpu.h                   |     7 +-
 drivers/gpu/drm/i915/i915_vma.c                    |   145 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    29 +-
 drivers/gpu/drm/i915/intel_csr.c                   |     7 +
 drivers/gpu/drm/i915/intel_device_info.c           |    45 +-
 drivers/gpu/drm/i915/intel_device_info.h           |     6 +-
 drivers/gpu/drm/i915/intel_guc_fw.c                |   308 -
 drivers/gpu/drm/i915/intel_gvt.c                   |     7 +-
 drivers/gpu/drm/i915/intel_gvt.h                   |     7 +-
 drivers/gpu/drm/i915/intel_huc.h                   |    65 -
 drivers/gpu/drm/i915/intel_huc_fw.c                |   215 -
 drivers/gpu/drm/i915/intel_pch.c                   |   201 +
 drivers/gpu/drm/i915/intel_pch.h                   |    73 +
 drivers/gpu/drm/i915/intel_pm.c                    |   460 +-
 drivers/gpu/drm/i915/intel_pm.h                    |     4 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |     3 +-
 drivers/gpu/drm/i915/intel_runtime_pm.h            |     2 +-
 drivers/gpu/drm/i915/intel_sideband.c              |     4 +-
 drivers/gpu/drm/i915/intel_uc.c                    |   561 -
 drivers/gpu/drm/i915/intel_uc.h                    |    64 -
 drivers/gpu/drm/i915/intel_uc_fw.c                 |   357 -
 drivers/gpu/drm/i915/intel_uc_fw.h                 |   155 -
 drivers/gpu/drm/i915/intel_uncore.c                |   558 +-
 drivers/gpu/drm/i915/intel_uncore.h                |    54 +-
 drivers/gpu/drm/i915/intel_wakeref.c               |    89 +-
 drivers/gpu/drm/i915/intel_wakeref.h               |    84 +-
 drivers/gpu/drm/i915/intel_wopcm.c                 |   268 +-
 drivers/gpu/drm/i915/intel_wopcm.h                 |    18 +-
 drivers/gpu/drm/i915/oa/Makefile                   |     7 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_bdw.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_bdw.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_bxt.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_bxt.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cflgt2.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cflgt3.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_chv.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_chv.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cnl.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_cnl.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_glk.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_glk.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_hsw.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_hsw.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_icl.c        |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_icl.h              |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_kblgt2.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_kblgt3.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt2.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt3.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h           |    16 +
 drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt4.c     |    35 +-
 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h           |    16 +
 drivers/gpu/drm/i915/selftests/i915_active.c       |   127 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |   720 +
 drivers/gpu/drm/i915/selftests/i915_gem.c          |    11 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |    22 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |     4 +-
 .../gpu/drm/i915/selftests/i915_live_selftests.h   |     6 +-
 .../gpu/drm/i915/selftests/i915_mock_selftests.h   |     3 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |    89 +-
 drivers/gpu/drm/i915/selftests/i915_selftest.c     |    67 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |    10 +
 drivers/gpu/drm/i915/selftests/igt_flush_test.c    |     5 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c         |    38 +-
 drivers/gpu/drm/i915/selftests/igt_reset.h         |    10 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |    34 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.h       |     9 +-
 drivers/gpu/drm/i915/selftests/igt_wedge_me.h      |    58 -
 drivers/gpu/drm/i915/selftests/lib_sw_fence.c      |     1 +
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |    19 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |     3 +
 drivers/gpu/drm/i915/selftests/mock_request.c      |     6 +-
 drivers/gpu/drm/i915/selftests/mock_request.h      |     4 +-
 drivers/gpu/drm/i915/selftests/mock_uncore.c       |     4 +-
 drivers/gpu/drm/imx/Makefile                       |     1 -
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |    16 +-
 drivers/gpu/drm/imx/imx-drm-core.c                 |    13 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |    40 +-
 drivers/gpu/drm/imx/imx-tve.c                      |    16 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |     8 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |     5 +-
 drivers/gpu/drm/imx/parallel-display.c             |    19 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |    75 +-
 drivers/gpu/drm/lima/lima_device.c                 |    41 +-
 drivers/gpu/drm/lima/lima_drv.c                    |    20 +-
 drivers/gpu/drm/lima/lima_gem.c                    |    10 +-
 drivers/gpu/drm/lima/lima_gem_prime.c              |     3 +-
 drivers/gpu/drm/lima/lima_object.c                 |     9 +-
 drivers/gpu/drm/lima/lima_object.h                 |     3 +-
 drivers/gpu/drm/lima/lima_vm.h                     |     4 +-
 drivers/gpu/drm/mcde/mcde_drv.c                    |    10 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |    70 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |     2 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |     2 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |     2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    18 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    10 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |     2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    33 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.c              |    35 +-
 drivers/gpu/drm/mediatek/mtk_drm_fb.h              |     1 -
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |     7 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |     4 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    14 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |    14 +-
 drivers/gpu/drm/meson/meson_crtc.c                 |    35 +-
 drivers/gpu/drm/meson/meson_drv.c                  |    73 +-
 drivers/gpu/drm/meson/meson_drv.h                  |    24 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |    23 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.h              |    12 +-
 drivers/gpu/drm/meson/meson_overlay.c              |    15 +-
 drivers/gpu/drm/meson/meson_plane.c                |    28 +-
 drivers/gpu/drm/meson/meson_registers.h            |   138 +-
 drivers/gpu/drm/meson/meson_vclk.c                 |    78 +-
 drivers/gpu/drm/meson/meson_vclk.h                 |     4 +
 drivers/gpu/drm/meson/meson_venc.c                 |   181 +-
 drivers/gpu/drm/meson/meson_venc.h                 |     2 +
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |    24 +-
 drivers/gpu/drm/meson/meson_viu.c                  |    99 +-
 drivers/gpu/drm/meson/meson_vpp.c                  |    42 +-
 drivers/gpu/drm/meson/meson_vpp.h                  |     3 +
 drivers/gpu/drm/mga/mga_dma.c                      |    13 +-
 drivers/gpu/drm/mga/mga_drv.c                      |     7 +-
 drivers/gpu/drm/mga/mga_drv.h                      |    27 +-
 drivers/gpu/drm/mga/mga_ioc32.c                    |     3 +-
 drivers/gpu/drm/mga/mga_irq.c                      |    12 +-
 drivers/gpu/drm/mga/mga_state.c                    |     8 +-
 drivers/gpu/drm/mga/mga_warp.c                     |     4 +-
 drivers/gpu/drm/mgag200/Makefile                   |     2 +-
 drivers/gpu/drm/mgag200/mgag200_cursor.c           |    11 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    10 +-
 drivers/gpu/drm/mgag200/mgag200_drv.h              |    40 +-
 drivers/gpu/drm/mgag200/mgag200_fb.c               |   315 -
 drivers/gpu/drm/mgag200/mgag200_i2c.c              |     6 +-
 drivers/gpu/drm/mgag200/mgag200_main.c             |    96 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    59 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c              |     3 +-
 drivers/gpu/drm/msm/Kconfig                        |     2 +-
 drivers/gpu/drm/msm/Makefile                       |     1 +
 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c          |     4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |     2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |     1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |    16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    95 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h           |     7 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |    75 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |    11 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |     3 -
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    44 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |     1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |     3 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c        |     1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.h        |     9 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   112 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |    10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |     9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    31 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h          |     2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           |    11 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |     1 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_irq.c           |     1 +
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c           |    51 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  |     2 +
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |     2 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |     2 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   132 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |     3 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_ctl.c           |     4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_irq.c           |     1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |    60 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |     2 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c           |     1 +
 drivers/gpu/drm/msm/disp/mdp_format.c              |     2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |    18 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |    12 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |     2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c    |     2 +
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h              |     2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |    66 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |     4 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |     2 +
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |    43 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c           |     1 +
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c           |     2 +
 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c           |     2 +
 drivers/gpu/drm/msm/msm_atomic.c                   |   236 +-
 drivers/gpu/drm/msm/msm_atomic_trace.h             |   110 +
 drivers/gpu/drm/msm/msm_atomic_tracepoints.c       |     3 +
 drivers/gpu/drm/msm/msm_debugfs.c                  |     5 +
 drivers/gpu/drm/msm/msm_drv.c                      |    76 +-
 drivers/gpu/drm/msm/msm_drv.h                      |     6 +-
 drivers/gpu/drm/msm/msm_fb.c                       |     2 +
 drivers/gpu/drm/msm/msm_fbdev.c                    |     4 +
 drivers/gpu/drm/msm/msm_gem.c                      |    32 +-
 drivers/gpu/drm/msm/msm_gem.h                      |     2 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |     6 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |    10 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |     5 +-
 drivers/gpu/drm/msm/msm_gpu_trace.h                |     2 +-
 drivers/gpu/drm/msm/msm_gpummu.c                   |     2 +
 drivers/gpu/drm/msm/msm_kms.h                      |   108 +-
 drivers/gpu/drm/msm/msm_perf.c                     |     3 +
 drivers/gpu/drm/msm/msm_rd.c                       |     7 +-
 drivers/gpu/drm/msm/msm_submitqueue.c              |     2 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 |    16 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |    18 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |     3 +-
 drivers/gpu/drm/nouveau/dispnv04/arb.c             |     2 -
 drivers/gpu/drm/nouveau/dispnv04/crtc.c            |    54 +-
 drivers/gpu/drm/nouveau/dispnv04/cursor.c          |     1 -
 drivers/gpu/drm/nouveau/dispnv04/dac.c             |     1 -
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |     2 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.c            |     3 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |     1 -
 drivers/gpu/drm/nouveau/dispnv04/hw.c              |     1 -
 drivers/gpu/drm/nouveau/dispnv04/hw.h              |     1 -
 drivers/gpu/drm/nouveau/dispnv04/overlay.c         |     1 -
 drivers/gpu/drm/nouveau/dispnv04/tvmodesnv17.c     |     1 -
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |     1 -
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |     1 -
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |    14 +
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |    26 +-
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |    11 +-
 drivers/gpu/drm/nouveau/dispnv50/base907c.c        |    65 +
 drivers/gpu/drm/nouveau/dispnv50/base917c.c        |     2 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |     2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |    46 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |    18 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c        |     3 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly827e.c        |     3 -
 drivers/gpu/drm/nouveau/dispnv50/ovly907e.c        |    13 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly917e.c        |     5 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   111 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |    10 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c        |    61 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |    72 +-
 .../drm/nouveau/include/nvkm/subdev/bios/extdev.h  |     2 +
 .../drm/nouveau/include/nvkm/subdev/bios/gpio.h    |     5 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h  |     1 +
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    10 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.h            |     1 -
 drivers/gpu/drm/nouveau/nouveau_bios.c             |     4 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    98 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h               |    11 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |     3 +-
 drivers/gpu/drm/nouveau/nouveau_crtc.h             |     2 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.h          |     2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |    14 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |     4 +
 drivers/gpu/drm/nouveau/nouveau_dma.c              |     2 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |     1 -
 drivers/gpu/drm/nouveau/nouveau_drm.c              |    36 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |     9 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |     2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |    15 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    51 +-
 drivers/gpu/drm/nouveau/nouveau_gem.h              |     5 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c            |     2 -
 drivers/gpu/drm/nouveau/nouveau_ioc32.c            |     3 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |    43 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |     1 -
 drivers/gpu/drm/nouveau/nvif/mmu.c                 |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c   |   188 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   |    28 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.h   |     6 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk110.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk208.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk20a.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm107.c   |    26 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm200.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm20b.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp100.c   |    27 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp10b.c   |     1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h    |     2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gm20b.c    |     1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/extdev.c  |    13 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c    |    28 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/volt.c    |     2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/base.c    |    32 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c     |    18 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c     |     3 +
 drivers/gpu/drm/omapdrm/displays/Kconfig           |    38 -
 drivers/gpu/drm/omapdrm/displays/Makefile          |     6 -
 .../omapdrm/displays/panel-lgphilips-lb035q02.c    |   251 -
 .../drm/omapdrm/displays/panel-nec-nl8048hl11.c    |   271 -
 .../drm/omapdrm/displays/panel-sharp-ls037v7dw01.c |   262 -
 .../drm/omapdrm/displays/panel-sony-acx565akm.c    |   755 -
 .../drm/omapdrm/displays/panel-tpo-td028ttec1.c    |   390 -
 .../drm/omapdrm/displays/panel-tpo-td043mtea1.c    |   513 -
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    11 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |     7 -
 drivers/gpu/drm/omapdrm/omap_crtc.c                |     4 +-
 drivers/gpu/drm/omapdrm/omap_debugfs.c             |     2 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    22 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |     5 +-
 drivers/gpu/drm/omapdrm/omap_fb.c                  |     4 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c               |     4 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |     2 +
 drivers/gpu/drm/omapdrm/omap_gem.h                 |     3 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |     8 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |     2 +
 drivers/gpu/drm/omapdrm/omap_plane.c               |     9 +-
 drivers/gpu/drm/panel/Kconfig                      |    64 +
 drivers/gpu/drm/panel/Makefile                     |     8 +
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |    34 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |   237 +
 drivers/gpu/drm/panel/panel-lvds.c                 |     5 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |   248 +
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |   359 +
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |    13 +
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |   668 +
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |    75 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c    |   226 +
 drivers/gpu/drm/panel/panel-simple.c               |   407 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |   701 +
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |   399 +
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |   509 +
 drivers/gpu/drm/panfrost/Makefile                  |     1 +
 drivers/gpu/drm/panfrost/TODO                      |    15 -
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |    22 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |     1 +
 drivers/gpu/drm/panfrost/panfrost_device.c         |    28 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |    31 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   196 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c            |   142 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |    23 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |   110 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |     2 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |    62 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |   442 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.h            |     9 +-
 drivers/gpu/drm/pl111/pl111_debugfs.c              |     4 +-
 drivers/gpu/drm/pl111/pl111_display.c              |    52 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |    11 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |    13 +-
 drivers/gpu/drm/pl111/pl111_nomadik.h              |     3 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |     9 +-
 drivers/gpu/drm/pl111/pl111_versatile.h            |     3 +
 drivers/gpu/drm/pl111/pl111_vexpress.c             |     1 +
 drivers/gpu/drm/qxl/qxl_cmd.c                      |     6 +-
 drivers/gpu/drm/qxl/qxl_debugfs.c                  |    10 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |    11 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |     2 +
 drivers/gpu/drm/qxl/qxl_drv.c                      |    21 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |    13 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |     3 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |     3 +
 drivers/gpu/drm/qxl/qxl_irq.c                      |     4 +
 drivers/gpu/drm/qxl/qxl_kms.c                      |     9 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |    20 +-
 drivers/gpu/drm/qxl/qxl_object.h                   |     6 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |    14 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    20 +-
 drivers/gpu/drm/r128/r128_ioc32.c                  |     3 +-
 drivers/gpu/drm/r128/r128_irq.c                    |     5 +-
 drivers/gpu/drm/radeon/cik.c                       |     2 +-
 drivers/gpu/drm/radeon/cik_sdma.c                  |     2 +-
 drivers/gpu/drm/radeon/evergreen_dma.c             |     2 +-
 drivers/gpu/drm/radeon/r100.c                      |     2 +-
 drivers/gpu/drm/radeon/r200.c                      |     2 +-
 drivers/gpu/drm/radeon/r600.c                      |     2 +-
 drivers/gpu/drm/radeon/r600_dma.c                  |     2 +-
 drivers/gpu/drm/radeon/radeon.h                    |    12 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |    18 +-
 drivers/gpu/drm/radeon/radeon_benchmark.c          |     6 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |     2 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |     6 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    21 +-
 drivers/gpu/drm/radeon/radeon_display.c            |     6 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |    31 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |     8 +-
 drivers/gpu/drm/radeon/radeon_mn.c                 |     2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    28 +-
 drivers/gpu/drm/radeon/radeon_object.h             |     4 +-
 drivers/gpu/drm/radeon/radeon_prime.c              |    20 +-
 drivers/gpu/drm/radeon/radeon_sync.c               |    10 +-
 drivers/gpu/drm/radeon/radeon_test.c               |     8 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |     6 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |     2 +-
 drivers/gpu/drm/radeon/radeon_vm.c                 |     6 +-
 drivers/gpu/drm/radeon/rv770_dma.c                 |     2 +-
 drivers/gpu/drm/radeon/si_dma.c                    |     2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |     5 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |     8 +-
 drivers/gpu/drm/rockchip/Makefile                  |     3 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   116 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |    17 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |     2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |     9 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |     5 +-
 drivers/gpu/drm/rockchip/inno_hdmi.c               |     3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |    17 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |    29 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |     8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |   282 -
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |    22 -
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   117 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |    16 +-
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |     9 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |    11 +-
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h    |     2 -
 drivers/gpu/drm/scheduler/sched_entity.c           |     7 +-
 drivers/gpu/drm/scheduler/sched_fence.c            |     6 +-
 drivers/gpu/drm/scheduler/sched_main.c             |     3 +-
 drivers/gpu/drm/selftests/test-drm_framebuffer.c   |     7 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |     3 +-
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h          |     4 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c           |     9 +-
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |     1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c         |     2 +-
 drivers/gpu/drm/shmobile/shmob_drm_plane.h         |     1 +
 drivers/gpu/drm/shmobile/shmob_drm_regs.h          |     3 +
 drivers/gpu/drm/sti/sti_drv.c                      |     6 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |     8 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |     9 +-
 drivers/gpu/drm/sti/sti_tvout.c                    |    16 +-
 drivers/gpu/drm/stm/drv.c                          |     5 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |    10 +-
 drivers/gpu/drm/stm/ltdc.c                         |     2 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    16 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |    13 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |     7 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |     1 -
 drivers/gpu/drm/sun4i/sun4i_frontend.c             |    10 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |    24 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |     3 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |     2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |     2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    28 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |     4 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |     9 +-
 drivers/gpu/drm/sun4i/sun8i_csc.c                  |   157 +-
 drivers/gpu/drm/sun4i/sun8i_csc.h                  |     6 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |    57 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |     2 +
 drivers/gpu/drm/sun4i/sun8i_mixer.c                |    14 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |     6 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |     2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    22 +-
 drivers/gpu/drm/tdfx/tdfx_drv.c                    |    11 +-
 drivers/gpu/drm/tegra/dc.c                         |    13 +-
 drivers/gpu/drm/tegra/dpaux.c                      |     5 +-
 drivers/gpu/drm/tegra/drm.c                        |    38 +-
 drivers/gpu/drm/tegra/drm.h                        |     3 +-
 drivers/gpu/drm/tegra/dsi.c                        |     8 +-
 drivers/gpu/drm/tegra/fb.c                         |     6 +-
 drivers/gpu/drm/tegra/gem.c                        |    10 +-
 drivers/gpu/drm/tegra/gem.h                        |     4 +-
 drivers/gpu/drm/tegra/gr2d.c                       |     1 +
 drivers/gpu/drm/tegra/hdmi.c                       |     5 +
 drivers/gpu/drm/tegra/hub.c                        |     3 +-
 drivers/gpu/drm/tegra/hub.h                        |     1 -
 drivers/gpu/drm/tegra/plane.c                      |     1 +
 drivers/gpu/drm/tegra/sor.c                        |     3 +
 drivers/gpu/drm/tegra/vic.c                        |     1 +
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    46 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |    25 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |    33 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |    89 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.h           |     1 -
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |    20 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |     4 +-
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c             |    17 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/Kconfig          |    64 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/Makefile         |     6 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |   804 +
 drivers/gpu/drm/{tinydrm =3D> tiny}/hx8357d.c        |    64 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/ili9225.c        |   185 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/ili9341.c        |    86 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/mi0283qt.c       |    93 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/repaper.c        |    61 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/st7586.c         |   134 +-
 drivers/gpu/drm/{tinydrm =3D> tiny}/st7735r.c        |    81 +-
 drivers/gpu/drm/tinydrm/core/Makefile              |     4 -
 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c     |   207 -
 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c        |   179 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |   158 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    20 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    15 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |    22 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |     2 +-
 drivers/gpu/drm/tve200/tve200_display.c            |     8 +-
 drivers/gpu/drm/tve200/tve200_drm.h                |    15 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |     8 +-
 drivers/gpu/drm/udl/udl_connector.c                |     4 +-
 drivers/gpu/drm/udl/udl_connector.h                |     2 +
 drivers/gpu/drm/udl/udl_dmabuf.c                   |    11 +-
 drivers/gpu/drm/udl/udl_drv.c                      |     9 +-
 drivers/gpu/drm/udl/udl_drv.h                      |    11 +-
 drivers/gpu/drm/udl/udl_encoder.c                  |     6 +-
 drivers/gpu/drm/udl/udl_fb.c                       |    15 +-
 drivers/gpu/drm/udl/udl_gem.c                      |     9 +-
 drivers/gpu/drm/udl/udl_main.c                     |     6 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |     6 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |     4 -
 drivers/gpu/drm/v3d/v3d_debugfs.c                  |     3 +-
 drivers/gpu/drm/v3d/v3d_drv.c                      |     6 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |    13 +-
 drivers/gpu/drm/v3d/v3d_gem.c                      |    16 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |     2 +
 drivers/gpu/drm/vboxvideo/Makefile                 |     2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |    15 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.h               |    12 -
 drivers/gpu/drm/vboxvideo/vbox_main.c              |     2 +-
 drivers/gpu/drm/vboxvideo/vbox_prime.c             |    56 -
 drivers/gpu/drm/vc4/vc4_bo.c                       |     7 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    11 +-
 drivers/gpu/drm/vc4/vc4_debugfs.c                  |     1 -
 drivers/gpu/drm/vc4/vc4_drv.c                      |     9 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |    20 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |    17 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |     8 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |     5 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |     4 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |     9 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |    14 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |     4 +
 drivers/gpu/drm/vgem/vgem_drv.c                    |    21 +-
 drivers/gpu/drm/vgem/vgem_drv.h                    |     1 -
 drivers/gpu/drm/vgem/vgem_fence.c                  |    40 +-
 drivers/gpu/drm/via/via_dma.c                      |    43 +-
 drivers/gpu/drm/via/via_dmablit.c                  |    41 +-
 drivers/gpu/drm/via/via_drv.c                      |     7 +-
 drivers/gpu/drm/via/via_drv.h                      |    75 +-
 drivers/gpu/drm/via/via_irq.c                      |    54 +-
 drivers/gpu/drm/via/via_map.c                      |     6 +-
 drivers/gpu/drm/via/via_mm.c                       |     7 +-
 drivers/gpu/drm/via/via_verifier.c                 |    22 +-
 drivers/gpu/drm/via/via_video.c                    |     5 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |     4 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |     7 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |     9 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h               |     8 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c             |     2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |     4 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |    30 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |     4 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |     8 +-
 drivers/gpu/drm/virtio/virtgpu_prime.c             |     5 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c               |    13 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c                |     7 +-
 drivers/gpu/drm/vkms/Makefile                      |     2 +-
 .../gpu/drm/vkms/{vkms_crc.c =3D> vkms_composer.c}   |   169 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   100 +-
 drivers/gpu/drm/vkms/vkms_drv.c                    |    50 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    44 +-
 drivers/gpu/drm/vkms/vkms_gem.c                    |     1 +
 drivers/gpu/drm/vkms/vkms_output.c                 |     6 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |    46 +-
 drivers/gpu/drm/vmwgfx/ttm_lock.c                  |   100 -
 drivers/gpu/drm/vmwgfx/ttm_lock.h                  |    32 +-
 drivers/gpu/drm/vmwgfx/ttm_object.h                |     7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.h            |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |    17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |     3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |     4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |    17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   200 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   135 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |    52 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.h              |     5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c               |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c                |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    41 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |     2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |    11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    62 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource_priv.h      |     2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |     1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |     3 +-
 drivers/gpu/drm/xen/xen_drm_front.c                |    16 +-
 drivers/gpu/drm/xen/xen_drm_front.h                |    11 +-
 drivers/gpu/drm/xen/xen_drm_front_cfg.c            |     4 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |     1 +
 drivers/gpu/drm/xen/xen_drm_front_conn.h           |     7 +-
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c        |     4 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |    11 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.h            |     7 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |     9 +-
 drivers/gpu/drm/zte/zx_drm_drv.c                   |     8 +-
 drivers/gpu/drm/zte/zx_hdmi.c                      |     2 +-
 drivers/gpu/drm/zte/zx_plane.c                     |     2 +-
 drivers/gpu/drm/zte/zx_tvenc.c                     |     4 +-
 drivers/gpu/drm/zte/zx_vga.c                       |     4 +-
 drivers/gpu/drm/zte/zx_vou.c                       |     5 +-
 drivers/gpu/ipu-v3/ipu-common.c                    |    16 +-
 drivers/gpu/ipu-v3/ipu-cpmem.c                     |    26 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c             |   230 +-
 drivers/video/backlight/lcd.c                      |     8 -
 drivers/video/fbdev/amba-clcd.c                    |     4 +-
 drivers/video/fbdev/aty/aty128fb.c                 |    18 -
 drivers/video/fbdev/aty/atyfb_base.c               |    29 -
 drivers/video/fbdev/aty/radeon_base.c              |     6 +-
 drivers/video/fbdev/au1200fb.c                     |     5 +-
 drivers/video/fbdev/core/fbmem.c                   |    14 +-
 drivers/video/fbdev/core/fbmon.c                   |    96 -
 drivers/video/fbdev/core/modedb.c                  |    57 -
 drivers/video/fbdev/efifb.c                        |    27 +-
 drivers/video/fbdev/mmp/core.c                     |     6 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c                 |     1 -
 drivers/video/fbdev/nvidia/nv_backlight.c          |     2 -
 drivers/video/fbdev/nvidia/nv_setup.c              |    24 -
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |     5 +
 drivers/video/fbdev/pvr2fb.c                       |     6 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |     2 +
 drivers/video/fbdev/sm712fb.c                      |     8 +-
 drivers/video/fbdev/ssd1307fb.c                    |   131 +-
 drivers/video/fbdev/udlfb.c                        |     2 +-
 drivers/video/fbdev/via/via-core.c                 |    43 -
 drivers/video/of_display_timing.c                  |    11 +-
 include/drm/amd_asic_type.h                        |     4 +
 include/drm/bridge/analogix_dp.h                   |     4 -
 include/drm/bridge/dw_hdmi.h                       |     2 +
 include/drm/drmP.h                                 |     2 +-
 include/drm/drm_agpsupport.h                       |    14 -
 include/drm/drm_connector.h                        |    32 +-
 include/drm/drm_crtc.h                             |     4 +
 include/drm/drm_dp_helper.h                        |     4 +
 include/drm/drm_dp_mst_helper.h                    |    11 +
 include/drm/drm_drv.h                              |   104 +-
 include/drm/drm_gem.h                              |    26 +-
 include/drm/drm_gem_framebuffer_helper.h           |     7 -
 include/drm/drm_gem_shmem_helper.h                 |    15 +
 include/drm/drm_gem_vram_helper.h                  |    30 +-
 include/drm/drm_hdcp.h                             |     9 +-
 include/drm/drm_ioctl.h                            |     3 +
 include/drm/drm_mipi_dbi.h                         |   188 +
 include/drm/drm_mode_config.h                      |     6 +
 include/drm/drm_panel.h                            |   184 +-
 include/drm/drm_prime.h                            |    41 +-
 include/drm/drm_sysfs.h                            |     5 +-
 include/drm/drm_vblank.h                           |     1 -
 include/drm/drm_vram_mm_helper.h                   |     2 +
 include/drm/i915_component.h                       |     2 +-
 include/drm/i915_drm.h                             |    13 +-
 include/drm/i915_pciids.h                          |    18 +-
 include/drm/tinydrm/mipi-dbi.h                     |   117 -
 include/drm/tinydrm/tinydrm-helpers.h              |    75 -
 include/drm/ttm/ttm_bo_api.h                       |    41 +-
 include/drm/ttm/ttm_bo_driver.h                    |    26 +-
 include/linux/amba/clcd-regs.h                     |     1 +
 include/linux/dma-buf.h                            |     4 +-
 include/linux/dma-fence.h                          |    34 +-
 include/linux/{reservation.h =3D> dma-resv.h}        |   186 +-
 include/linux/fb.h                                 |     7 -
 include/linux/lcd.h                                |    10 -
 include/linux/soc/amlogic/meson-canvas.h           |     1 +
 include/uapi/drm/amdgpu_drm.h                      |     4 +
 include/uapi/drm/drm_mode.h                        |     1 +
 include/uapi/drm/etnaviv_drm.h                     |    10 +-
 include/uapi/drm/i915_drm.h                        |     1 +
 include/uapi/drm/panfrost_drm.h                    |    64 +
 include/uapi/linux/media-bus-format.h              |     3 +-
 1623 files changed, 262796 insertions(+), 38510 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644
Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
 create mode 100644
Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h=
.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h=
.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/boe,himax8279d.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/giantplus,gpm940b0.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.tx=
t
 create mode 100644 Documentation/devicetree/bindings/display/panel/lvds.ya=
ml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m05dtc.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/ortustech,com37h3m99dtc.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/panel-common.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/panel-common.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/panel-lvds.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.t=
xt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscre=
en.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscre=
en.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ld-d5116z01b.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,lq070y3dg3b.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
 create mode 100644
Documentation/devicetree/bindings/display/panel/ti,nspire.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/panel/tpo,tpg110.txt
 create mode 100644
Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
 delete mode 100644 Documentation/gpu/tinydrm.rst
 rename drivers/dma-buf/{reservation.c =3D> dma-resv.c} (68%)
 create mode 100644 drivers/dma-buf/selftest.c
 create mode 100644 drivers/dma-buf/selftest.h
 create mode 100644 drivers/dma-buf/selftests.h
 create mode 100644 drivers/dma-buf/st-dma-fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/arct_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/athub_v1_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/navi12_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
 rename drivers/gpu/drm/{i915/intel_guc_fw.h =3D> amd/amdgpu/psp_v12_0.h} (=
53%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
 rename drivers/gpu/drm/{i915/intel_guc_ads.h =3D>
amd/amdgpu/smu_v11_0_i2c.h} (51%)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
 rename drivers/gpu/drm/{i915/i915_gem_render_state.h =3D>
amd/amdgpu/vcn_v2_5.h} (52%)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr=
.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dsc/drm_dsc_dc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dc=
n21.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_factory_dc=
n21.h
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
 create mode 100644
drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/generic_regs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dc=
n21.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dc=
n21.h
 create mode 100644 drivers/gpu/drm/amd/include/arct_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_10_0_2_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/clk/clk_10_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_2_1_0_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_2_1_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_default.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_12_0_0_offse=
t.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_12_0_0_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/rsmu/rsmu_0_0_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/rsmu/rsmu_0_0_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma2/sdma2_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma2/sdma2_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma3/sdma3_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma3/sdma3_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma4/sdma4_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma4/sdma4_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma5/sdma5_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma5/sdma5_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma6/sdma6_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma6/sdma6_4_2_2_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma7/sdma7_4_2_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma7/sdma7_4_2_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_1_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset=
.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mas=
k.h
 create mode 100644 drivers/gpu/drm/amd/include/navi12_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/navi14_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/renoir_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/arcturus_ppt.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arctu=
rus.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu12_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_types.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/renoir_ppt.c
 create mode 100644 drivers/gpu/drm/amd/powerplay/renoir_ppt.h
 create mode 100644 drivers/gpu/drm/amd/powerplay/smu_v12_0.c
 delete mode 100644 drivers/gpu/drm/ast/ast_fb.c
 rename drivers/gpu/drm/{tinydrm/mipi-dbi.c =3D> drm_mipi_dbi.c} (65%)
 delete mode 100644 drivers/gpu/drm/etnaviv/etnaviv_iommu.h
 delete mode 100644 drivers/gpu/drm/i915/Makefile.header-test
 delete mode 100644 drivers/gpu/drm/i915/display/Makefile.header-test
 rename drivers/gpu/drm/i915/{intel_drv.h =3D>
display/intel_display_types.h} (84%)
 create mode 100644 drivers/gpu/drm/i915/display/intel_tc.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_tc.h
 delete mode 100644 drivers/gpu/drm/i915/gem/Makefile.header-test
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_shrinker.h
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_stolen.h
 delete mode 100644 drivers/gpu/drm/i915/gt/Makefile.header-test
 rename drivers/gpu/drm/i915/{intel_renderstate_gen6.c =3D>
gt/gen6_renderstate.c} (100%)
 rename drivers/gpu/drm/i915/{intel_renderstate_gen7.c =3D>
gt/gen7_renderstate.c} (100%)
 rename drivers/gpu/drm/i915/{intel_renderstate_gen8.c =3D>
gt/gen8_renderstate.c} (100%)
 rename drivers/gpu/drm/i915/{intel_renderstate_gen9.c =3D>
gt/gen9_renderstate.c} (100%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pool.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pool.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_pool_types.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_user.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_user.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_irq.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_irq.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_types.h
 rename drivers/gpu/drm/i915/{i915_gem_render_state.c =3D>
gt/intel_renderstate.c} (93%)
 rename drivers/gpu/drm/i915/{ =3D> gt}/intel_renderstate.h (91%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_reset_types.h
 rename drivers/gpu/drm/i915/{i915_timeline.c =3D> gt/intel_timeline.c} (60=
%)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_timeline.h
 rename drivers/gpu/drm/i915/{i915_timeline_types.h =3D>
gt/intel_timeline_types.h} (60%)
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_context.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_engine.c
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_engine.h
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_engine_pm.c
 rename drivers/gpu/drm/i915/{selftests/i915_timeline.c =3D>
gt/selftest_timeline.c} (85%)
 rename drivers/gpu/drm/i915/{ =3D> gt}/selftests/mock_timeline.c (58%)
 rename drivers/gpu/drm/i915/{ =3D> gt}/selftests/mock_timeline.h (53%)
 create mode 100644 drivers/gpu/drm/i915/gt/uc/Makefile
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc.c (72%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc.h (70%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ads.c (75%)
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.h
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ct.c (92%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_ct.h (65%)
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.h
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_fwif.h (83%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_log.c (89%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_log.h (64%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_reg.h (68%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_submission.c (65%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_guc_submission.h (63%)
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_huc.c (58%)
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_huc.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
 rename drivers/gpu/drm/i915/{ =3D> gt/uc}/intel_huc_fw.h (70%)
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h
 create mode 100644 drivers/gpu/drm/i915/gt/uc/intel_uc_fw_abi.h
 rename drivers/gpu/drm/i915/{selftests/intel_guc.c =3D>
gt/uc/selftest_guc.c} (73%)
 create mode 100644 drivers/gpu/drm/i915/i915_buddy.c
 create mode 100644 drivers/gpu/drm/i915/i915_buddy.h
 delete mode 100644 drivers/gpu/drm/i915/i915_gem_batch_pool.c
 delete mode 100644 drivers/gpu/drm/i915/i915_gem_batch_pool.h
 create mode 100644 drivers/gpu/drm/i915/i915_getparam.c
 create mode 100644 drivers/gpu/drm/i915/i915_memcpy.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_bdw.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_bxt.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_cflgt2.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_cflgt3.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_chv.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_cnl.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_glk.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_hsw.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_icl.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_kblgt2.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_kblgt3.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_sklgt2.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_sklgt3.h
 delete mode 100644 drivers/gpu/drm/i915/i915_oa_sklgt4.h
 create mode 100644 drivers/gpu/drm/i915/i915_perf.h
 create mode 100644 drivers/gpu/drm/i915/i915_suspend.h
 create mode 100644 drivers/gpu/drm/i915/i915_sw_fence_work.c
 create mode 100644 drivers/gpu/drm/i915/i915_sw_fence_work.h
 create mode 100644 drivers/gpu/drm/i915/i915_sysfs.h
 delete mode 100644 drivers/gpu/drm/i915/i915_timeline.h
 create mode 100644 drivers/gpu/drm/i915/i915_utils.c
 delete mode 100644 drivers/gpu/drm/i915/intel_guc_fw.c
 delete mode 100644 drivers/gpu/drm/i915/intel_huc.h
 delete mode 100644 drivers/gpu/drm/i915/intel_huc_fw.c
 create mode 100644 drivers/gpu/drm/i915/intel_pch.c
 create mode 100644 drivers/gpu/drm/i915/intel_pch.h
 delete mode 100644 drivers/gpu/drm/i915/intel_uc.c
 delete mode 100644 drivers/gpu/drm/i915/intel_uc.h
 delete mode 100644 drivers/gpu/drm/i915/intel_uc_fw.c
 delete mode 100644 drivers/gpu/drm/i915/intel_uc_fw.h
 create mode 100644 drivers/gpu/drm/i915/oa/Makefile
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_bdw.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bdw.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_bxt.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_bxt.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cflgt2.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt2.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cflgt3.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cflgt3.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_chv.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_chv.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_cnl.c (65%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_cnl.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_glk.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_glk.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_hsw.c (70%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_hsw.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_icl.c (64%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_icl.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_kblgt2.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt2.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_kblgt3.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_kblgt3.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt2.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt2.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt3.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt3.h
 rename drivers/gpu/drm/i915/{ =3D> oa}/i915_oa_sklgt4.c (60%)
 create mode 100644 drivers/gpu/drm/i915/oa/i915_oa_sklgt4.h
 create mode 100644 drivers/gpu/drm/i915/selftests/i915_buddy.c
 delete mode 100644 drivers/gpu/drm/i915/selftests/igt_wedge_me.h
 delete mode 100644 drivers/gpu/drm/mgag200/mgag200_fb.c
 create mode 100644 drivers/gpu/drm/msm/msm_atomic_trace.h
 create mode 100644 drivers/gpu/drm/msm/msm_atomic_tracepoints.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q=
02.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw0=
1.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lb035q02.c
 create mode 100644 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt39016.c
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c
 create mode 100644 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
 create mode 100644 drivers/gpu/drm/panel/panel-sony-acx565akm.c
 create mode 100644 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
 create mode 100644 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
 delete mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_psr.c
 delete mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_psr.h
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/Kconfig (64%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/Makefile (76%)
 create mode 100644 drivers/gpu/drm/tiny/gm12u320.c
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/hx8357d.c (78%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/ili9225.c (64%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/ili9341.c (69%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/mi0283qt.c (70%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/repaper.c (94%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/st7586.c (74%)
 rename drivers/gpu/drm/{tinydrm =3D> tiny}/st7735r.c (69%)
 delete mode 100644 drivers/gpu/drm/tinydrm/core/Makefile
 delete mode 100644 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
 delete mode 100644 drivers/gpu/drm/tinydrm/core/tinydrm-pipe.c
 delete mode 100644 drivers/gpu/drm/vboxvideo/vbox_prime.c
 rename drivers/gpu/drm/vkms/{vkms_crc.c =3D> vkms_composer.c} (52%)
 create mode 100644 include/drm/drm_mipi_dbi.h
 delete mode 100644 include/drm/tinydrm/mipi-dbi.h
 delete mode 100644 include/drm/tinydrm/tinydrm-helpers.h
 rename include/linux/{reservation.h =3D> dma-resv.h} (63%)
