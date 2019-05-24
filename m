Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58307C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075B32168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 04:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csPt3kpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfEXE2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 00:28:22 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:46588 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEXE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 00:28:21 -0400
Received: by mail-qk1-f175.google.com with SMTP id a132so5418376qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dX1gAgyAdzMJi0GaHGS7cbC2Ct6z+9KB6whPdLfhPwk=;
        b=csPt3kpWzdOqRdPPJaEmrJF0sndRH6vTTYhcrCTCh9xZrqPTgOJAZXwN2cXQoEzs18
         oj8y/cJDfb2CmWRnDIESbvYFsfde8Gc3XDp3pqat4DzATdv+vRhXKn9/KtWrrfzT4MDo
         /o3VBRNhDWFqxQ8ey4Wq3woRRbB/gHgwAmG8LPNtVY/3pplZWh7XSVfKglokgw6rDHPu
         nEQHj/IbYweTOD93nhyNomfyW9WDObktgI28EAjC1fqtL4b+HUOUesXgv49pf/cQMfeD
         +YvJmqJaMvPmgKunBoJ3RHNwQYf5+mG4TXgNbGhyHV9EQV508z9R/n7b92TkZ7ABOZtt
         rVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dX1gAgyAdzMJi0GaHGS7cbC2Ct6z+9KB6whPdLfhPwk=;
        b=LKpk5hr+px0Zl89MUS553e9PBOXH1QrPrcyyTnfQNyhvtuNlMtzWGZuhCwNxjr4Vti
         eM4glGEOqdiweBbycxKh/xkYJnRZXrfTMvxAAxa7vBcL/EEPBT6HkgdTifndkSffuWvQ
         vmJKnk9Qq/tx+GbxwsS8oQ73yFPF0z3IFDj93dV0KBQGlH83Eh9iUYz0kA2N61NBy3G0
         GtC3xlKDif7dkBdBrd9nfiePUpjEtXSj/bBP2LAP3p0cY+F4qUVLyLGaK1qt4/paq2ue
         fRiHTn96+wUkmQAgfi7D4/Kt8aN0E/BYH3/iF7q/IMrjpFsMysyLwi48BQcr6mswfW0Y
         8A8A==
X-Gm-Message-State: APjAAAVcJLqcQlIkEwzKKE+Iy7RRXzBTO66yNBT1MSJ7oSqZgnVay7LD
        O5seB2Ka+F38pH1TPGko5vLjS9n6DGzPM6lA8hs=
X-Google-Smtp-Source: APXvYqyV+tgcdjP1W4JsbTT4pcvk7C99uUJZbn4Eg7Jxh5ewQFsRPLrcTgKhW2ADCMFvx9HIvVmr0ZDf4YbMDWpvHKE=
X-Received: by 2002:ac8:1b0a:: with SMTP id y10mr79375567qtj.91.1558672100610;
 Thu, 23 May 2019 21:28:20 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 24 May 2019 14:28:08 +1000
Message-ID: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.2-rc2
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

Nothing too unusual here for rc2.

i915:
- boosting fix
- bump ready task fixes
- GVT - reset fix, error return, TRTT handling fix

amdgpu:
- DMCU firmware loading fix
- Polaris 10 pci id for kfd
- picasso screen corruption fix
- SR-IOV fixes
- vega driver reload fixes
- SMU locking fix
- compute profile fix for kfd

vmwgfx:
- integer overflow fixes
- dma sg fix

sun4i:
- HDMI phy fixes

gma500:
- LVDS detection fix

panfrost:
- devfreq selection fix

drm-fixes-2019-05-24:
drm i915, amdgpu, vmwgfx, sun4i, panfrost, gma500 fixes.
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-24

for you to fetch changes up to e1e52981f292b4e321781794eaf6e8a087f4f300:

  Merge tag 'drm-intel-fixes-2019-05-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-05-24
14:01:00 +1000)

----------------------------------------------------------------
drm i915, amdgpu, vmwgfx, sun4i, panfrost, gma500 fixes.

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/soc15: skip reset on init
      drm/amdgpu/gmc9: set vram_width properly for SR-IOV

Chris Wilson (5):
      drm/i915: Rearrange i915_scheduler.c
      drm/i915: Pass i915_sched_node around internally
      drm/i915: Bump signaler priority on adding a waiter
      drm/i915: Downgrade NEWCLIENT to non-preemptive
      drm/i915: Truly bump ready tasks ahead of busywaits

Dan Carpenter (2):
      drm/amd/powerplay: fix locking in smu_feature_set_supported()
      drm/i915/gvt: Fix an error code in ppgtt_populate_spt_by_guest_entry()

Dave Airlie (4):
      Merge branch 'vmwgfx-fixes-5.2' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-05-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-05-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Ezequiel Garcia (1):
      drm/panfrost: Select devfreq

Flora Cui (1):
      drm/amdgpu: keep stolen memory on picasso

Harish Kasiviswanathan (1):
      drm/amdkfd: Fix compute profile switching

Harry Wentland (2):
      drm/amd/display: Add ASICREV_IS_PICASSO
      drm/amd/display: Don't load DMCU for Raven 1

Jagan Teki (1):
      drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow

Jernej Skrabec (2):
      drm/sun4i: Fix sun8i HDMI PHY clock initialization
      drm/sun4i: Fix sun8i HDMI PHY configuration for > 148.5 MHz

Joonas Lahtinen (1):
      Merge tag 'gvt-fixes-2019-05-21' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Kent Russell (1):
      drm/amdkfd: Add missing Polaris10 ID

Murray McAllister (2):
      drm/vmwgfx: NULL pointer dereference from vmw_cmd_dx_view_define()
      drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading
to an invalid read

Patrik Jakobsson (1):
      drm/gma500/cdv: Check vbt config bits when detecting lvds panels

Sean Paul (1):
      Merge drm-misc-next-fixes-2019-05-20 into drm-misc-fixes

Thomas Hellstrom (4):
      drm/vmwgfx: Don't send drm sysfs hotplug events on initial master set
      drm/vmwgfx: Fix user space handle equal to zero
      drm/vmwgfx: Fix compat mode shader operation
      drm/vmwgfx: Use the dma scatter-gather iterator to get dma addresses

Weinan (1):
      drm/i915/gvt: emit init breadcrumb for gvt request

Yan Zhao (4):
      drm/i915/gvt: use cmd to restore in-context mmios to hw for gen9 platform
      drm/i915/gvt: Tiled Resources mmios are in-context mmios for gen9+
      drm/i915/gvt: add 0x4dfc to gen9 save-restore list
      drm/i915/gvt: do not let TRTTE and 0x4dfc write passthrough to hardware

Yintian Tao (1):
      drm/amdgpu: skip fw pri bo alloc for SRIOV

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  17 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  11 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  17 ++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  12 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   7 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   2 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |   3 +
 drivers/gpu/drm/gma500/intel_bios.c                |   3 +
 drivers/gpu/drm/gma500/psb_drv.h                   |   1 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  14 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   4 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |  15 --
 drivers/gpu/drm/i915/gvt/mmio_context.c            |  23 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  23 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |   5 +-
 drivers/gpu/drm/i915/i915_request.c                |  42 ++--
 drivers/gpu/drm/i915/i915_scheduler.c              | 255 +++++++++++----------
 drivers/gpu/drm/i915/i915_scheduler_types.h        |   3 +-
 drivers/gpu/drm/i915/intel_lrc.c                   |   2 +-
 drivers/gpu/drm/i915/selftests/intel_lrc.c         |  12 +-
 drivers/gpu/drm/panfrost/Kconfig                   |   1 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  13 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   5 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |  29 +--
 drivers/gpu/drm/vmwgfx/ttm_object.c                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  27 +--
 32 files changed, 336 insertions(+), 265 deletions(-)
