Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA6208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcDjH9sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfFGXIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:08:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43580 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfFGXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:08:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so4206872qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeNaU9aVGypnd3hIRZTgqzjnQOf3ATJ3f3X8w52nCxY=;
        b=dcDjH9sbMs5JwL+pN23wiprpa+qvGpbfTjgL2lMltR05KphsASrImNxXwF7fko2l0U
         +g3lr5+KvDyQxfZwtI1cSgpFwb83I3ZeYaG7wxJyLzHqWjPry+E2m8H7Nte/F1umN/cx
         YiIOwg4eDwDvBPSRKpW2LB6qhVsNPiaOvI3H1hsUr728CFEUbs7OWDwDCE/m1yYrddwK
         ifZ1gpdwVnaPdDyNQdH/QItNYJGarvDiBumu20fq0+Nego5Xznqi/M3dG5bxjYcvujbH
         Wp6iXkhF/YQpWd8H7pmzoozslr3uhZGpLPV5/iL9ebSuCJqU+t2vBphMyRxaXK3QIgZ1
         viiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeNaU9aVGypnd3hIRZTgqzjnQOf3ATJ3f3X8w52nCxY=;
        b=l7zxJlTM8zz6Bu22x1HR1kOQo8euSH4dOO7eaFaUw3ByHgnwHL9GGQyJ+mg9Usej03
         aKlbzyQPaVWGJ2bnd/m8AuXJKCbb5FGNDdkeSQSo7xpWkTdlYKGw+nZ2FP2R1uiRhSFU
         50AIqslZk6xVYCQwK/JbIiCiMRzGFoRPG/ToJ1KJSToV3AmeOpMD/F6FC0mvO3TLAZB3
         egK7brGa3zqTWaJpb+TnLLjn8sLVnaC/CvkSzg2Z1lcVc4d/VbMAuJ2eeos3gi8IdNNd
         E+UHhFTq47FjCKj/6vF8SVhebqB/S5uqNCRBKwPS0ark39ylIfl9o+P4Gr5nIvOtAOs7
         K8pg==
X-Gm-Message-State: APjAAAWe1aHtikymQojs+aFYNZ5FIpTgRrTNiumAIjT2Ibud83SwESki
        CFXwo8wTMsxxp+J6AH6FBGDagilf4r9JFtutt2CbzfN6
X-Google-Smtp-Source: APXvYqxc02ezOqgQ7kNpPeolZJ+kWSMpu8dJJW6WRR8SXjTW05J06sDwNFWl1oWcZtd6uYsLGI56PZtv8f8rKMyD4qM=
X-Received: by 2002:ac8:3221:: with SMTP id x30mr49272111qta.176.1559948924674;
 Fri, 07 Jun 2019 16:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx_2-ANvU3CsasrHkaJsyRV+NxP1AoM0ZSu8teht3FuEg@mail.gmail.com>
 <CAHk-=wgOGPPO6owAcRiBd0KJpmjH-C83-=_N6QeQzyiCW4kb0w@mail.gmail.com> <CAHk-=wipemA-iriz99pRYvoGszNjQn9cUHwzvV55HOrx-KEmWw@mail.gmail.com>
In-Reply-To: <CAHk-=wipemA-iriz99pRYvoGszNjQn9cUHwzvV55HOrx-KEmWw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 8 Jun 2019 09:08:33 +1000
Message-ID: <CAPM=9twF5Dcr+1UGMFcRJQjtYG0t5mTuC-QPV3o+YVmD-AE+CQ@mail.gmail.com>
Subject: Re: [git pull] drm fixes for v5.2-rc4 (v2)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2019 at 03:24, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jun 7, 2019 at 10:20 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The second one has the subject, and mentions nouveau, but doesn't
> > actually have the tag name or the expected diffstat and shortlog.
>
> Hmm. I'm guessing you meant for me to pull the
>
>   'tags/drm-fixes-2019-06-07-1'
>
> thing, which looks likely, but I'd like to have confirmation.
>
>                  Linus

Oh man, sorry have a cold/flu thing, brain isn't running so well.

Here's the missing bits.

drm-fixes-2019-06-07-1:
 drm i915, amdgpu, arm display, atomic update fixes + nouveau firmware
loading fix
The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-06-07-1

for you to fetch changes up to 671e2ee5ee2127179ca884b439ab6001a623edd6:

  Merge branch 'linux-5.2' of git://github.com/skeggsb/linux into
drm-fixes (2019-06-07 17:16:00 +1000)

----------------------------------------------------------------
 drm i915, amdgpu, arm display, atomic update fixes + nouveau firmware
loading fix

----------------------------------------------------------------
Aleksei Gimbitskii (2):
      drm/i915/gvt: Check if cur_pt_type is valid
      drm/i915/gvt: Assign NULL to the pointer after memory free.

Ben Skeggs (6):
      drm/nouveau/core: pass subdev into nvkm_firmware_get, rather than device
      drm/nouveau/core: support versioned firmware loading
      drm/nouveau/secboot: pass max supported FW version to LS load funcs
      drm/nouveau/secboot: split out FW version-specific LS function pointers
      drm/nouveau/secboot: enable loading of versioned LS PMU/SEC2 ACR
msgqueue FW
      drm/nouveau/secboot/gp10[2467]: support newer FW to fix SEC2
failures on some boards

Chengming Gui (1):
      drm/amd/powerplay: add set_power_profile_mode for raven1_refresh

Colin Xu (3):
      drm/i915/gvt: Update force-to-nonpriv register whitelist
      drm/i915/gvt: Fix GFX_MODE handling
      drm/i915/gvt: Fix vGPU CSFE_CHICKEN1_REG mmio handler

Dan Carpenter (1):
      drm/komeda: Potential error pointer dereference

Dave Airlie (6):
      Merge tag 'drm-intel-fixes-2019-06-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'drm-fixes-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-06-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'malidp-fixes' of git://linux-arm.org/linux-ld into drm-fixes
      Merge tag 'drm-intel-fixes-2019-06-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'linux-5.2' of git://github.com/skeggsb/linux into drm-fixes

Gao, Fred (1):
      drm/i915/gvt: Fix cmd length of VEB_DI_IECP

Helen Koike (5):
      drm/rockchip: fix fb references in async update
      drm/amd: fix fb references in async update
      drm/msm: fix fb references in async update
      drm/vc4: fix fb references in async update
      drm: don't block fb changes for async plane updates

Joonas Lahtinen (2):
      Merge tag 'gvt-fixes-2019-05-30' of
https://github.com/intel/gvt-linux into drm-intel-fixes
      Merge tag 'gvt-fixes-2019-06-05' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Louis Li (1):
      drm/amdgpu: fix ring test failure issue during s3 in vce 3.0 (V2)

Lowry Li (Arm Technology China) (1):
      drm/komeda: fixing of DMA mapping sg segment warning

Lucas Stach (1):
      udmabuf: actually unmap the scatterlist

Prike Liang (1):
      drm/amd/amdgpu: add RLC firmware to support raven1 refresh

Robin Murphy (2):
      drm/arm/hdlcd: Actually validate CRTC modes
      drm/arm/hdlcd: Allow a bit of clock tolerance

Tina Zhang (1):
      drm/i915/gvt: Initialize intel_gvt_gtt_entry in stack

Tvrtko Ursulin (1):
      drm/i915/icl: Add WaDisableBankHangMode

Weinan Li (1):
      drm/i915/gvt: add F_CMD_ACCESS flag for wa regs

Wen He (1):
      drm/arm/mali-dp: Add a loop around the second set CVAL and try 5 times

Xiaolin Zhang (1):
      drm/i915/gvt: save RING_HEAD into vreg when vgpu switched out

Xiong Zhang (1):
      drm/i915/gvt: refine ggtt range validation

YueHaibing (1):
      drm/komeda: remove set but not used variable 'kcrtc'

james qian wang (Arm Technology China) (1):
      drm/komeda: Constify the usage of komeda_component/pipeline/dev_funcs

 drivers/dma-buf/udmabuf.c                          |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 12 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 15 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h             |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 12 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |  1 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  | 31 ++++++++++--
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 +
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |  8 ++--
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   |  4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |  2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  6 ++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  8 ++--
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  4 +-
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   | 10 ++--
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  4 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 14 +++---
 drivers/gpu/drm/arm/malidp_drv.c                   | 13 ++++-
 drivers/gpu/drm/drm_atomic_helper.c                | 22 +++++----
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     | 38 +++++++++++----
 drivers/gpu/drm/i915/gvt/handlers.c                | 49 ++++++++++++++++---
 drivers/gpu/drm/i915/gvt/reg.h                     |  2 +
 drivers/gpu/drm/i915/gvt/scheduler.c               | 25 ++++++++++
 drivers/gpu/drm/i915/gvt/scheduler.h               |  1 +
 drivers/gpu/drm/i915/i915_reg.h                    |  3 ++
 drivers/gpu/drm/i915/intel_workarounds.c           |  6 +++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  4 ++
 .../gpu/drm/nouveau/include/nvkm/core/firmware.h   | 16 +++----
 drivers/gpu/drm/nouveau/nvkm/core/firmware.c       | 33 +++++++++++--
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr.c  |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 56 ++++++++++++++++------
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.h | 22 ++++++---
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.c | 50 +++++++++++++++----
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r361.h |  3 +-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r367.c | 33 +++++++++----
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.c | 36 +++++++++++---
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r370.h |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/secboot/acr_r375.c | 12 ++++-
 .../gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode.h | 12 +++--
 .../drm/nouveau/nvkm/subdev/secboot/ls_ucode_gr.c  | 22 +++++----
 .../nvkm/subdev/secboot/ls_ucode_msgqueue.c        | 38 ++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        | 51 ++++++++++----------
 drivers/gpu/drm/vc4/vc4_plane.c                    |  2 +-
 include/drm/drm_modeset_helper_vtables.h           |  8 ++++
 48 files changed, 510 insertions(+), 197 deletions(-)
