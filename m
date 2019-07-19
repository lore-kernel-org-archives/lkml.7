Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC639C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C372186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N3X5DxHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfGSPnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 11:43:08 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38536 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:43:07 -0400
Received: by mail-ed1-f52.google.com with SMTP id r12so84126edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Oi8OWhfKyJqdwvba+M/GU5lc9d4mx9p2asVwJL4l1Uk=;
        b=N3X5DxHmXldKzL3aUafxfWJ87f8+r0zagqIbi9lh+c4TCalwDLXafDRKZSnMAWOLP3
         e/u0TalSic/iOTLOucs0O2t1jHZGCWamNB80xNCmL7CEL8PwBTAXS2sMfRkI9uBiV4TW
         kHjQnZAZYFTXgdaQui2gNbVCqs8efGDKixiew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Oi8OWhfKyJqdwvba+M/GU5lc9d4mx9p2asVwJL4l1Uk=;
        b=tiHmsHoZz9r7flmIWWUBECX94IMkc0a3wknbLWbF45+VhE2eubFg40jmDsJl9aXWbK
         kYlhYmTabHVVldY3+EqBf39uaNUjspZM4zjj/4pEir8rNV34Ktnr6KLNiHgn1n6C6maS
         LPReSrwbr49PbkFOvyfCidvntxATX7OfIJDf9Dn+wg3NsQ5Kpq0WiFvoEzr0He1NiEcw
         46hl30jdrTFGob4nXxFrNLWUpnkuDT26mRQIKuYrrFPu2zXwI9sWCSB3y232as0poz3m
         xf0pegGNsq5MmrleSCfLVIQjqeCn1i8Lzu5JSn9c156y3kKm/FuWGQZwsIJWVn0wLqHn
         rzaA==
X-Gm-Message-State: APjAAAV9xt+WwqprWeh9uPWmPEjbLb+oKFZke3XpdgBQH0xxmeZCv+kb
        QJBuz1jhRado0rgvsYwXzcI=
X-Google-Smtp-Source: APXvYqwbUvUeQjZGPqp3o454gYAb0F6CABQ6qjHwDRjl+UOofA+yCaEI9xi8NZsvL03AJTDsthGYng==
X-Received: by 2002:a17:906:ad82:: with SMTP id la2mr42357197ejb.123.1563550983280;
        Fri, 19 Jul 2019 08:43:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k20sm8898852ede.66.2019.07.19.08.43.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 08:43:02 -0700 (PDT)
Date:   Fri, 19 Jul 2019 17:42:56 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PULL] drm-next fixes for -rc1
Message-ID: <20190719154207.GA9708@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave is back in shape, but now family got it so I'm doing the pull. Two
things worthy of note:
- nouveau feature pull was way too late, Dave&me decided to not take that,
  so Ben spun up a pull with just the fixes.
- after some chatting with the arm display maintainers we decided to
  change a bit how that's maintained, for more oversight/review and cross
  vendor collab.

Details below&in the tag.

Cheers, Daniel

drm-next-2019-07-19:
drm fixes for -rc1:

nouveau:
- bugfixes + TU116 enabling (minor hw iteration)

amdgpu:
- large pile of fixes for new hw support this release (navi, vega20)
- audio hotplug fix
- bunch of corner cases and small fixes all over for amdgpu/kfd

komeda:
- back out some new properties (from this merge window) that needs
  more pondering.

bochs: fb pitch setup

... plus a new panel quirk

The following changes since commit 3729fe2bc2a01f4cc1aa88be8f64af06084c87d6:

  Revert "Merge branch 'vmwgfx-next' of git://people.freedesktop.org/~thomash/linux into drm-next" (2019-07-16 04:07:13 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-07-19

for you to fetch changes up to 8ee795625665208589a97972b01790bb04ea83e3:

  Merge branch 'linux-5.3' of git://github.com/skeggsb/linux into drm-next (2019-07-19 17:28:38 +1000)

----------------------------------------------------------------
drm fixes for -rc1:

nouveau:
- bugfixes + TU116 enabling (minor iteration):w

amdgpu:
- large pile of fixes for new hw support this release (navi, vega20)
- audio hotplug fix
- bunch of corner cases and small fixes all over for amdgpu/kfd

komeda:
- back out some new properties (from this merge window) that needs
  more pondering.

bochs: fb pitch setup

... plus a new panel quirk

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu/psp: add a mutex to protect access to the psp ring
      drm/amdgpu: enable IP discovery by default on navi
      drm/amdgpu: drop dead header
      drm/amdgpu/pm: remove check for pp funcs in freq sysfs handlers

Arnd Bergmann (5):
      drm/selftests: reduce stack usage
      drm: connector: remove bogus NULL check
      drm/amd/display: Support clang option for stack alignment
      drm/amd/display: return 'NULL' instead of 'false' from dcn20_acquire_idle_pipe_for_layer
      drm/amd/amdgpu: hide #warning for missing DC config

Ben Skeggs (6):
      drm/nouveau/kms: disallow dual-link harder if hdmi connection detected
      drm/nouveau/core: recognise TU116 chipset
      drm/nouveau/disp/tu102-: wire up scdc parameter setter
      drm/nouveau: fix bogus GPL-2 license header
      drm/nouveau/flcn/gp102-: improve implementation of bind_context() on SEC2/GSP
      drm/nouveau/secboot/gp102-: remove WAR for SEC2 RTOS start bug

Daniel Vetter (5):
      drm/komeda: Remove clock ratio property
      drm/komeda: remove slave_planes property
      drm/komeda: remove img_enhancement property
      drm/komeda: Remove layer_split property
      MAINTAINERS: maintain drm/arm drivers in drm-misc for now

Dave Airlie (3):
      Merge tag 'drm-misc-next-fixes-2019-07-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-next-5.3-2019-07-18' of git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'linux-5.3' of git://github.com/skeggsb/linux into drm-next

Dmitry Osipenko (1):
      drm/modes: Skip invalid cmdline mode

Emil Velikov (1):
      drm/amdgpu: extend AMDGPU_CTX_PRIORITY_NORMAL comment

Eric Huang (1):
      drm/amdkfd: fix cp hang in eviction

Evan Quan (7):
      drm/amd/powerplay: increase the SMU msg response waiting time
      drm/amd/powerplay: fix memory allocation failure check V2
      drm/amd/powerplay: avoid access before allocation
      drm/amd/powerplay: fix deadlock around smu_handle_task V2
      drm/amd/powerplay: correct smu_update_table usage
      drm/amd/powerplay: maintain SMU FW backward compatibility
      drm/amd/powerplay: update vega20 driver if to fit latest SMU firmware

Felix Kuehling (4):
      drm/amdgpu: Fix potential integer overflows
      drm/amdkfd: Consistently apply noretry setting
      drm/amdgpu: Fix unaligned memory copies
      drm/amdgpu: Fix silent amdgpu_bo_move failures

Fuqian Huang (1):
      drm/amdgpu: remove memset after kzalloc

Gerd Hoffmann (1):
      drm/bochs: fix framebuffer setup.

Hans de Goede (1):
      drm: panel-orientation-quirks: Add extra quirk table entry for GPD MicroPC

Hawking Zhang (3):
      drm/amdgpu: switch to macro for psp bootloader command
      drm/amdgpu: support key database loading for navi10
      drm/amdgpu: check kdb_bin_size to exclude kdb loading sequence

Ilia Mirkin (3):
      drm/nouveau/disp/nv50-: force scaler for any non-default LVDS/eDP modes
      drm/nouveau/disp/nv50-: fix center/aspect-corrected scaling
      drm/nouveau: fix bogus GPL-2 license header

Joseph Greathouse (1):
      drm/amdkfd: Remove GWS from process during uninit

Karol Herbst (1):
      drm/nouveau/hwmon: return EINVAL if the GPU is powered down for sensors reads

Kenneth Feng (2):
      drm/amd/powerplay: bug fix for sysfs
      drm/amd/powerplay: enable fw ctf,apcc dfll and gfx ss

Kent Russell (1):
      drm/amdgpu: Fix Vega20 Perf counter for pcie_bw

Kevin Wang (7):
      drm/amd/powerplay: fix smu clock type change miss error
      drm/amd/powerplay: add pstate mclk(uclk) support for navi10
      drm/amd/powerplay: add socclk profile dpm support.
      drm/amd/powerplay: add standard profile dpm support for smu
      drm/amd/powerplay: avoid double check feature enabled
      drm/amd/powerplay: fix save dpm level error for smu
      drm/amd/powerplay: add helper of smu_clk_dpm_is_enabled for smu

Lyude Paul (1):
      drm/nouveau/i2c: Enable i2c pads & busses during preinit

Nathan Chancellor (1):
      drm/amd/powerplay: Use proper enums in vega20_print_clk_levels

Nicholas Kazlauskas (3):
      drm/amd/display: Expose audio inst from DC to DM
      drm/amd/display: Add drm_audio_component support to amdgpu_dm
      drm/amd/display: Force uclk to max for every state

Nicolai Hähnle (1):
      drm/amdgpu/gfx10: set SH_MEM_CONFIG.INITIAL_INST_PREFETCH

Paul Menzel (1):
      drm/amdgpu: Print out voltage in DM_PPLIB

Ralph Campbell (1):
      drm/nouveau/dmem: missing mutex_lock in error path

Timo Wiren (1):
      drm/nouveau/mcp89/mmu: Use mcp77_mmu_new instead of g84_mmu_new on MCP89.

Tom St Denis (3):
      drm/amd/amdgpu: Add VMID to SRBM debugfs bank selection
      drm/amd/amdgpu: Add missing select_me_pipe_q() for gfx10
      drm/amd/amdgpu: Fix offset for vmid selection in debugfs interface

Wang Xiayang (1):
      drm/amdgpu: replace simple_strtol() by kstrtou32()

Yongxin Liu (1):
      drm/nouveau: fix memory leak in nouveau_conn_reset()

hersen wu (1):
      drm/amd/display: init res_pool dccg_ref, dchub_ref with xtalin_freq

james qian wang (Arm Technology China) (2):
      drm/komeda: Computing layer_split internally
      drm/komeda: Computing image enhancer internally

tiancyin (1):
      drm/amdgpu/discovery: fix DCE_HWIP mapping error in hw_id_map array

 MAINTAINERS                                        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  13 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  25 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  51 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  34 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   2 -
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  52 ++++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  14 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   1 -
 drivers/gpu/drm/amd/amdgpu/vi_dpm.h                |  32 ---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  16 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager_v9.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   3 +
 drivers/gpu/drm/amd/display/Kconfig                |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 222 +++++++++++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  25 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  45 ++---
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   1 +
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  25 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        |  16 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |   2 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  75 ++++---
 .../amd/powerplay/hwmgr/process_pptables_v1_0.c    |   2 -
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |   3 +-
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if.h    |   6 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  62 +++---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  16 +-
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |   2 -
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  |   2 -
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |   2 -
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |  41 ++--
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  63 ------
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  18 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |   3 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |  15 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  84 +-------
 .../drm/arm/display/komeda/komeda_wb_connector.c   |  10 +-
 drivers/gpu/drm/bochs/bochs.h                      |   2 +-
 drivers/gpu/drm/bochs/bochs_hw.c                   |  14 +-
 drivers/gpu/drm/bochs/bochs_kms.c                  |   3 +-
 drivers/gpu/drm/drm_client_modeset.c               |   3 +-
 drivers/gpu/drm/drm_connector.c                    |   2 +-
 drivers/gpu/drm/drm_modes.c                        |  14 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  12 ++
 drivers/gpu/drm/nouveau/Kbuild                     |   2 +-
 drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   2 +-
 drivers/gpu/drm/nouveau/dispnv04/cursor.c          |   2 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/Kbuild            |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   9 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |  28 ++-
 drivers/gpu/drm/nouveau/include/nvif/cl0002.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl0046.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl006b.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl506e.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl506f.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl5070.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl507a.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl507b.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl507c.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl507d.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl507e.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl826e.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl826f.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl906f.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cl9097.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/cla06f.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/class.h       |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/clc36f.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/clc37b.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/clc37e.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/client.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/device.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/driver.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/event.h       |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0000.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0001.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0002.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0003.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0004.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0005.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/ioctl.h       |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/notify.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/object.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/os.h          |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/unpack.h      |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/client.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/debug.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/engine.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/enum.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/event.h  |   2 +-
 .../gpu/drm/nouveau/include/nvkm/core/firmware.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/gpuobj.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/ioctl.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/memory.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/mm.h     |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/notify.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/object.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/oproxy.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/option.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/os.h     |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/pci.h    |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/ramht.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/bsp.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/ce.h   |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/cipher.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/dma.h  |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/falcon.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/mpeg.h |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/msenc.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/mspdec.h   |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/msppp.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/msvld.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/nvdec.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/nvenc.h    |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/pm.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec2.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sw.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/vic.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/vp.h   |   2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/xtensa.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bar.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bios.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/M0203.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/M0205.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/M0209.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/P0260.h   |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/bit.h |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/bmp.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/boost.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/conn.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/cstep.h   |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/disp.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/dp.h  |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/extdev.h  |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/fan.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/gpio.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/i2c.h |   2 +-
 .../nouveau/include/nvkm/subdev/bios/iccsense.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/image.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/init.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/mxm.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/npde.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/pcir.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/perf.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/pll.h |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/pmu.h |   2 +-
 .../include/nvkm/subdev/bios/power_budget.h        |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/ramcfg.h  |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/rammap.h  |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/therm.h   |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/timing.h  |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/vmap.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/volt.h    |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/vpstate.h |   2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/xpio.h    |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bus.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h  |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/devinit.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fuse.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gpio.h |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ibus.h |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/iccsense.h |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/instmem.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ltc.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mc.h   |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mmu.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mxm.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h  |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |   2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/timer.h    |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/top.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/vga.h  |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |   2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.h            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h               |   2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.h             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   9 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.h          |   2 +-
 drivers/gpu/drm/nouveau/nouveau_display.h          |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |   3 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_gem.h              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_hwmon.c            |  10 +
 drivers/gpu/drm/nouveau/nouveau_ioctl.h            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_reg.h              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.h              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_usif.h             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |   2 +-
 drivers/gpu/drm/nouveau/nouveau_vga.h              |   2 +-
 drivers/gpu/drm/nouveau/nv10_fence.h               |   2 +-
 drivers/gpu/drm/nouveau/nvif/Kbuild                |   2 +-
 drivers/gpu/drm/nouveau/nvkm/Kbuild                |   2 +-
 drivers/gpu/drm/nouveau/nvkm/core/Kbuild           |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/Kbuild         |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/bsp/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/Kbuild      |   2 +-
 .../drm/nouveau/nvkm/engine/ce/fuc/gf100.fuc3.h    |   2 +-
 .../drm/nouveau/nvkm/engine/ce/fuc/gt215.fuc3.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/cipher/Kbuild  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/Kbuild  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/acpi.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  38 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/conn.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.c    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/hdmi.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/sortu102.c    |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/dma/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/user.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/changf100.h   |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/changk104.h   |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/channv04.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/channv50.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv50.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/regsnv04.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxnv40.h   |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgf100.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgf117.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgk104.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgk110.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgk208.fuc5.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/gpcgm107.fuc5.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgf100.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgf117.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgk104.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgk110.fuc3.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgk208.fuc5.h |   2 +-
 .../drm/nouveau/nvkm/engine/gr/fuc/hubgm107.fuc5.h |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/fuc/os.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv10.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv25.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv2a.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv30.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv34.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv35.c      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv40.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv50.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/regs.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv31.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msenc/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/Kbuild  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/priv.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/priv.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/priv.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/priv.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gf100.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/nv40.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec/Kbuild     |   2 +-
 .../drm/nouveau/nvkm/engine/sec/fuc/g98.fuc0s.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/chan.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nvsw.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/vic/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/vp/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/Kbuild         |   2 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/priv.h         |   2 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/v1.c           |  36 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/Kbuild         |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/pll.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/seq.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/Kbuild |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv04.h |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv50.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h       |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramfuc.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv40.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramseq.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/regsnv04.h  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c     |  20 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/bus.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/pad.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/priv.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/iccsense/Kbuild    |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/iccsense/priv.h    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/Kbuild |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/Kbuild      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/priv.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/mxms.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.h      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/Kbuild     |   2 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h   |   2 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gf119.fuc4.h   |   2 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h   |   2 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/os.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/Kbuild |   2 +-
 .../nvkm/subdev/secboot/ls_ucode_msgqueue.c        |  29 ---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/Kbuild   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/priv.h   |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/timer/regsnv04.h   |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/Kbuild     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/priv.h     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/priv.h    |   2 +-
 .../gpu/drm/selftests/test-drm_cmdline_parser.c    | 136 +++++--------
 include/drm/drm_modes.h                            |   2 +-
 include/uapi/drm/amdgpu_drm.h                      |   7 +-
 412 files changed, 1253 insertions(+), 904 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/amdgpu/vi_dpm.h

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
