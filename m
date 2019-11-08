Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC814FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB20214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 06:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLbNTeRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfKHG6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 01:58:14 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39786 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfKHG6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 01:58:14 -0500
Received: by mail-lj1-f180.google.com with SMTP id p18so5020161ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 22:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gdPITI2A3Z21awYG83k2Hr0hbFqbOJbcn29CctYW1hU=;
        b=eLbNTeRZJqJEEW+8I0Xl0K2C9RBUbqn9/l0HZem8EglxaLbZ/YVzJQG3/Cb34N7baK
         mS8nmlwIXP26/WPBlkLUZz+IrwZHjM4CcFNfPdGtZ6JnTG0gVobdxIBzBgDk3apkKkB/
         JSumeG6UZXJG/8Qy0XvaKncJZOA6kIuM8ibWrK3ys+48YEPoOr2IswWG6GFVxxTszdxo
         n106KuZlhvy3WpQkgupTJIDtflsDnQCaCl2OEJUpNsQBx7X1XXjG+bc6ivakCKugzHTX
         zgp/rdeNWZprloRPAXygBtJ296FcqA6V4Fl8JTjlfvi4B6R4PufS5Agp+B4CmuNUOH7R
         cg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gdPITI2A3Z21awYG83k2Hr0hbFqbOJbcn29CctYW1hU=;
        b=CKabW/CtH9ZBWez6yjBj5WmtZ1xnuFt/MXJaNsIqk+TYineAo2aDSggIs/75qketiK
         5z0g1WNid6WHb+u4sLnecLdu1utK3vvN1ynA2ajb75wBGUQ4f45kg9MtwaZtQ7lJx0nt
         8Jv45mqHSyc3dnEq3JEOPJPe+O5EhZ2udFz4RwGMcYXG9C3l3UPRUuPHLNa5yajkYpyD
         c1yYAkoW9WgMHQykMcm8iwZJXV5sfybEocd+UXkKnoDwYrUtobt3ZoSePfXWBGDqMtLB
         8O5uofVC1XsiUrZfgyU8J8ZjpCK0ci1qzncmujQFhhp482iqNC5yz6mCUUFX4IyypPA7
         4h0w==
X-Gm-Message-State: APjAAAV52VkkRjBZ4ZhFcbJI6l9KO7n+1EKYV1Tqxg1TEKxcwXtlZbg5
        f8Kg/ZkAvM2T6bkAi8K/PtN46qj8z5uj9PyLlMs=
X-Google-Smtp-Source: APXvYqxoWxypO+yTl5yzA2iVsweYX3ha+OcqyfdRu5XvXolUlrCNaHcyzV4n/Po3dzYsdDtOfYV1taHsXCf5w08rmaw=
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr5346340ljk.21.1573196290883;
 Thu, 07 Nov 2019 22:58:10 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 Nov 2019 16:57:59 +1000
Message-ID: <CAPM=9tzkQsv1s4ZXAyKDNVdXg_T0h4ZDODq68j4dLbACS_w4dw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc7
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

Weekly fixes for drm, summary below, amdgpu has a few but they are
pretty scattered fixes, the fbdev one is a build regression fix that
we didn't want to risk leaving out, otherwise a couple of i915, one
radeon and a core atomic fix.

Dave.

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9=
:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-08

for you to fetch changes up to ff9234583d4fb53d4bcf57916ddfb16c53c81c88:

  Merge tag 'drm-fixes-5.4-2019-11-06' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-11-08
13:07:58 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc7

core:
- add missing documentation for GEM shmem madvise helpers
- Fix for a state dereference in atomic self-refresh helpers

fbdev:
- One compilation fix for c2p fbdev helpers

amdgpu:
- Fix navi14 display issue root cause and revert workaround
- GPU reset scheduler interaction fix
- Fix fan boost on multi-GPU
- Gfx10 and sdma5 fixes for navi
- GFXOFF fix for renoir
- Add navi14 PCI ID
- GPUVM fix for arcturus

radeon:
- Port an SI power fix from amdgpu

i915:
- Fix HPD poll to avoid kworker consuming a lot of cpu cycles.
- Do not use TBT type for non Type-C ports.

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/arcturus: properly set BANK_SELECT and FRAGMENT_SIZE
      drm/amdgpu/renoir: move gfxoff handling into gfx9 module
      drm/radeon: fix si_enable_smc_cac() failed issue

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2019-11-07-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-11-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-11-06' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amdgpu: register gpu instance before fan boost feature enablment

Geert Uytterhoeven (1):
      fbdev: c2p: Fix link failure on non-inlining

Imre Deak (1):
      drm/i915: Avoid HPD poll detect triggering a new detect cycle

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/dp: Do not switch aux to TBT mode for non-TC ports

Kevin Wang (1):
      drm/amd/swSMU: fix smu workload bit map error

Rob Clark (1):
      drm/atomic: fix self-refresh helpers crtc state dereference

Rob Herring (1):
      drm/shmem: Add docbook comments for drm_gem_shmem_object madvise fiel=
ds

Shirish S (1):
      drm/amdgpu: dont schedule jobs while in reset

Tianci.Yin (1):
      drm/amdgpu: add navi14 PCI ID

Zhan Liu (2):
      drm/amd/display: Add ENGINE_ID_DIGD condition check for Navi14
      Revert "drm/amd/display: setting the DIG_MODE to the correct value."

changzhu (2):
      drm/amdgpu: add dummy read by engines for some GCVM status
registers in gfx10
      drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 48 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 13 ++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  8 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |  9 ++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  5 ---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  9 ----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  5 +++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  2 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         |  2 +-
 drivers/gpu/drm/drm_atomic_helper.c                | 15 ++++++-
 drivers/gpu/drm/drm_self_refresh_helper.c          | 18 ++++----
 drivers/gpu/drm/i915/display/intel_crt.c           |  7 ++++
 drivers/gpu/drm/i915/display/intel_dp.c            | 12 +++++-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  6 +++
 drivers/gpu/drm/radeon/si_dpm.c                    |  1 +
 drivers/video/fbdev/c2p_core.h                     |  8 ++--
 include/drm/drm_gem_shmem_helper.h                 | 13 ++++++
 include/drm/drm_self_refresh_helper.h              |  3 +-
 24 files changed, 174 insertions(+), 38 deletions(-)
