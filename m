Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED17EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA022075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QAHlgMWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbfEXILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:11:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37411 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbfEXILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:11:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id f4so6399207oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us9j8Qv6OMFnKeLnWHWw0zFzdODRSnv2Sbiwznmf4+4=;
        b=QAHlgMWR8vi5wL/6KTdGIPZfDv+i9ibsg6jV6aGFbs3GrStORPGbLRZykZdA1P03YJ
         UvH4AzIB4rhNt07EshNV6sCwvkVgnX1aFs7TmhAXAi2hIiLtF80zDZJpqxdE7apF0sLL
         yd3RhTfP/xV/KRUoYbVyDEkJW6ktehnP6cq4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us9j8Qv6OMFnKeLnWHWw0zFzdODRSnv2Sbiwznmf4+4=;
        b=mPpOD1NDn2DVopQS2hMrpSjT8MEWN370CJ09THf/OTz1ayyxqGhZHpGww73WJ1EJde
         2vGOPeKgZDuIsA/L4HZWOiuzosxvt6fwrcPcY/t+2WSLYs7Gpiqc2YRq8+IXQN5Q7nb7
         47W1lYOeVrxUiCdfgKz4gjeqfHbxo2LIW9+zEzhknhZ8Rm0D4V44EupyhqkgTRpG4Q3V
         k8nKGXf3sBQzTBLh9YpS+UHUOivng1XKhP6fbtTpK25PuvkkHlEVmBvlFi4wZNsycHRn
         VrZPIr2VqErWnq+E5wa6V05WsSyEMt1dKNmRu9DFn2kEm61Uh59bLpfFGtJbWXuRkKqa
         xTQQ==
X-Gm-Message-State: APjAAAXUleEV+mqOxTQPKo6BU79ydNvN/6ujPfnH0jnk/oKiVzZQtLs2
        CGsH25szasCvMLtk85RRwYtHupG9j+mGm2R1S3GjFA==
X-Google-Smtp-Source: APXvYqyKI1D4RsxJ2qXXMmM2FBpMsp7DklcezQfcnJyaMtA2wHjA/UtQYBfCehVrKMxnvvavJf/r5mu+Bm4YAXF5T2k=
X-Received: by 2002:aca:6208:: with SMTP id w8mr5628178oib.128.1558685511042;
 Fri, 24 May 2019 01:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
In-Reply-To: <CAPM=9txEn_xBG7fW+P40v6VZW8txMUn9usQnC4L_KXumXNXMjw@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 24 May 2019 10:11:39 +0200
Message-ID: <CAKMK7uGL3gFb-_RoNe5oLS51VLuKy5sZXS9g5w=_FzcdXo_LPA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.2-rc2
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fyi sfr reported that 55143dc23ca4 ("drm/amd/display: Don't load DMCU
for Raven 1") breaks the build on x86-64. But I can't repro and didn't
immediately see what Kconfig it would need to trigger this, so no
idea. So just heads up in case this is real and there's some odd
config that hits a bug here ...
-Daniel


On Fri, May 24, 2019 at 6:28 AM Dave Airlie <airlied@gmail.com> wrote:
>
> Hey Linus,
>
> Nothing too unusual here for rc2.
>
> i915:
> - boosting fix
> - bump ready task fixes
> - GVT - reset fix, error return, TRTT handling fix
>
> amdgpu:
> - DMCU firmware loading fix
> - Polaris 10 pci id for kfd
> - picasso screen corruption fix
> - SR-IOV fixes
> - vega driver reload fixes
> - SMU locking fix
> - compute profile fix for kfd
>
> vmwgfx:
> - integer overflow fixes
> - dma sg fix
>
> sun4i:
> - HDMI phy fixes
>
> gma500:
> - LVDS detection fix
>
> panfrost:
> - devfreq selection fix
>
> drm-fixes-2019-05-24:
> drm i915, amdgpu, vmwgfx, sun4i, panfrost, gma500 fixes.
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-05-24
>
> for you to fetch changes up to e1e52981f292b4e321781794eaf6e8a087f4f300:
>
>   Merge tag 'drm-intel-fixes-2019-05-23' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-05-24
> 14:01:00 +1000)
>
> ----------------------------------------------------------------
> drm i915, amdgpu, vmwgfx, sun4i, panfrost, gma500 fixes.
>
> ----------------------------------------------------------------
> Alex Deucher (2):
>       drm/amdgpu/soc15: skip reset on init
>       drm/amdgpu/gmc9: set vram_width properly for SR-IOV
>
> Chris Wilson (5):
>       drm/i915: Rearrange i915_scheduler.c
>       drm/i915: Pass i915_sched_node around internally
>       drm/i915: Bump signaler priority on adding a waiter
>       drm/i915: Downgrade NEWCLIENT to non-preemptive
>       drm/i915: Truly bump ready tasks ahead of busywaits
>
> Dan Carpenter (2):
>       drm/amd/powerplay: fix locking in smu_feature_set_supported()
>       drm/i915/gvt: Fix an error code in ppgtt_populate_spt_by_guest_entry()
>
> Dave Airlie (4):
>       Merge branch 'vmwgfx-fixes-5.2' of
> git://people.freedesktop.org/~thomash/linux into drm-fixes
>       Merge tag 'drm-misc-fixes-2019-05-22' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
>       Merge branch 'drm-fixes-5.2' of
> git://people.freedesktop.org/~agd5f/linux into drm-fixes
>       Merge tag 'drm-intel-fixes-2019-05-23' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
>
> Ezequiel Garcia (1):
>       drm/panfrost: Select devfreq
>
> Flora Cui (1):
>       drm/amdgpu: keep stolen memory on picasso
>
> Harish Kasiviswanathan (1):
>       drm/amdkfd: Fix compute profile switching
>
> Harry Wentland (2):
>       drm/amd/display: Add ASICREV_IS_PICASSO
>       drm/amd/display: Don't load DMCU for Raven 1
>
> Jagan Teki (1):
>       drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
>
> Jernej Skrabec (2):
>       drm/sun4i: Fix sun8i HDMI PHY clock initialization
>       drm/sun4i: Fix sun8i HDMI PHY configuration for > 148.5 MHz
>
> Joonas Lahtinen (1):
>       Merge tag 'gvt-fixes-2019-05-21' of
> https://github.com/intel/gvt-linux into drm-intel-fixes
>
> Kent Russell (1):
>       drm/amdkfd: Add missing Polaris10 ID
>
> Murray McAllister (2):
>       drm/vmwgfx: NULL pointer dereference from vmw_cmd_dx_view_define()
>       drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading
> to an invalid read
>
> Patrik Jakobsson (1):
>       drm/gma500/cdv: Check vbt config bits when detecting lvds panels
>
> Sean Paul (1):
>       Merge drm-misc-next-fixes-2019-05-20 into drm-misc-fixes
>
> Thomas Hellstrom (4):
>       drm/vmwgfx: Don't send drm sysfs hotplug events on initial master set
>       drm/vmwgfx: Fix user space handle equal to zero
>       drm/vmwgfx: Fix compat mode shader operation
>       drm/vmwgfx: Use the dma scatter-gather iterator to get dma addresses
>
> Weinan (1):
>       drm/i915/gvt: emit init breadcrumb for gvt request
>
> Yan Zhao (4):
>       drm/i915/gvt: use cmd to restore in-context mmios to hw for gen9 platform
>       drm/i915/gvt: Tiled Resources mmios are in-context mmios for gen9+
>       drm/i915/gvt: add 0x4dfc to gen9 save-restore list
>       drm/i915/gvt: do not let TRTTE and 0x4dfc write passthrough to hardware
>
> Yintian Tao (1):
>       drm/amdgpu: skip fw pri bo alloc for SRIOV
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  17 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  11 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c                 |   5 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  17 ++
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  11 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   7 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  12 +-
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   7 +-
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |   2 +-
>  drivers/gpu/drm/gma500/cdv_intel_lvds.c            |   3 +
>  drivers/gpu/drm/gma500/intel_bios.c                |   3 +
>  drivers/gpu/drm/gma500/psb_drv.h                   |   1 +
>  drivers/gpu/drm/i915/gvt/cmd_parser.c              |  14 +-
>  drivers/gpu/drm/i915/gvt/gtt.c                     |   4 +-
>  drivers/gpu/drm/i915/gvt/handlers.c                |  15 --
>  drivers/gpu/drm/i915/gvt/mmio_context.c            |  23 +-
>  drivers/gpu/drm/i915/gvt/scheduler.c               |  23 +-
>  drivers/gpu/drm/i915/i915_priolist_types.h         |   5 +-
>  drivers/gpu/drm/i915/i915_request.c                |  42 ++--
>  drivers/gpu/drm/i915/i915_scheduler.c              | 255 +++++++++++----------
>  drivers/gpu/drm/i915/i915_scheduler_types.h        |   3 +-
>  drivers/gpu/drm/i915/intel_lrc.c                   |   2 +-
>  drivers/gpu/drm/i915/selftests/intel_lrc.c         |  12 +-
>  drivers/gpu/drm/panfrost/Kconfig                   |   1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c        |  13 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   5 +-
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |  29 +--
>  drivers/gpu/drm/vmwgfx/ttm_object.c                |   2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   8 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  20 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  27 +--
>  32 files changed, 336 insertions(+), 265 deletions(-)



--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
