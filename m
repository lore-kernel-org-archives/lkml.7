Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769A4C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEF20843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5HSbBAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEPC2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 22:28:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33158 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEPC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 22:28:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id p18so791810qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Gsi/xowHDqQc+L7wbYbUushYjcSW4cSdMcLTZCUqgyQ=;
        b=D5HSbBAeNBSUATxaTtvok58HyJ0V1hj/He/ewRTq/BV/75UrTXs6rZY8iK3ecIO16I
         7NVx2EoPXsSJC9yxCA3d1ZOLI+PMfMaQR0csuutSATJS6qPD/cy8A+iskbdcK4irfyhC
         QCWpbsPTuyXRa3i5wkjI0PQ6MBpnNy1UEEtKopB9KFPNTqTiY1jysYcZ96jVOJh5LEhh
         4uXmONd52yhSSQnKyJPaH29xFqvxYHYq01jZ/cTZybpWEibcvSUpSbc8DwgkZ6Kz9euR
         C98pXAZcxpkzeOymxBBlEskK+QxeY2I9u4EqCSTI0dTDCGLKNL/buJFIk6fNJoWuFCwg
         KAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Gsi/xowHDqQc+L7wbYbUushYjcSW4cSdMcLTZCUqgyQ=;
        b=qyp3ziNkfY6sSNeLj/4wHUXNkE6Q14h+y8K/ebdwBHGF6J+wyfugATVuJ6qS2KygLz
         lUZ0JQdsNof90f7wOJd6sbndJi9Z+/MdPxc+NW9nbsVvnzqRbgDYq4gh9WqWp5jtIKbn
         Ybl+x8za+PUJpx2+QEt8z0Gwk7c0V7NL1ABUCHx7LRm6huZzdseBe6vhXSObSk4MxMYY
         gMGH2uldtKixfiCIp5F3Ttp1CdmcTdqrCAq81evSPCejdU8X6gHmfFSXxPbHKGPzU6Cz
         29XYrZTQ6VkfHNLjgLEhhL2u+H+nqlUkBe9c04wcHOfB7Rad3Io0kma+rEW8uQ9izD9F
         w6AQ==
X-Gm-Message-State: APjAAAVg35ltZ0pBTWDEPxkX4f/Qqw3Kv9/oUVYSRxk+vbw6K9IeKIIh
        MHUSJQCoIu+LUoDU5CNmsmo0M3nVLFu4t/sxfPiB8cfjIJ0=
X-Google-Smtp-Source: APXvYqyYB2yotkntdEIS3HiBlyAzLZqnXi2Fg3YkbdTZbk7re/0tICDkIjUtlWFhGJQU8HwK0Ih1s2CHHeJHZWCF848=
X-Received: by 2002:a37:a5c8:: with SMTP id o191mr35521444qke.303.1557973685642;
 Wed, 15 May 2019 19:28:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 16 May 2019 12:27:54 +1000
Message-ID: <CAPM=9tyXaYhQ5dFQMkrkpTJZDrjVJjEcKB2bcYi=BKdq7qnQvg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.2-rc1
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

Hey Linus,

Bunch of fixes for the merge window closure, doesn't seem to be
anything too major or serious in there.

It does add TU117 turing modesetting to nouveau but it's just an
enable for preexisting code.

Dave.

amdgpu:
- gpu reset at load crash fix
- ATPX hotplug fix for when dGPU is off
- SR-IOV fixes

radeon:
- r5xx pll fixes

i915:
- GVT (MCHBAR, buffer alignment, misc warnings fixes)
- Fixes for newly enabled semaphore code
- Geminilake disable framebuffer compression
- HSW edp fast modeset fix
- IRQ vs RCU race fix

nouveau:
- Turing modesetting fixes
- TU117 support

msm:
- SDM845 bringup fixes

panfrost:
- static checker fixes

pl111:
- spinlock init fix.

bridge:
- refresh rate register fix for adv7511

drm-next-2019-05-16:
drm i915, amdgpu, nouveau, msm, panfrost, bridge, pl111 fixes
The following changes since commit eb85d03e01c3e9f3b0ba7282b2e3515a635decb2=
:

  Merge tag 'drm-misc-next-fixes-2019-05-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-05-09
11:04:00 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-05-16

for you to fetch changes up to 8da0e1525b7f0d69c6cb44094963906282b32673:

  Merge tag 'drm-misc-next-fixes-2019-05-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-05-16
10:19:33 +1000)

----------------------------------------------------------------
drm i915, amdgpu, nouveau, msm, panfrost, bridge, pl111 fixes

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: remove ATPX_DGPU_REQ_POWER_FOR_DISPLAYS check when hotplu=
g-in

Aleksei Gimbitskii (4):
      drm/i915/gvt: Remove typedef and let the enumeration starts from zero
      drm/i915/gvt: Do not copy the uninitialized pointer from fb_info
      drm/i915/gvt: Use snprintf() to prevent possible buffer overflow.
      drm/i915/gvt: Check if get_next_pt_type() always returns a valid valu=
e

Alex Deucher (1):
      drm/amdgpu/psp: move psp version specific function pointers to early_=
init

Ben Skeggs (6):
      drm/nouveau/kms/gv100-: fix spurious window immediate interlocks
      drm/nouveau/kms/nv50-: fix bug preventing non-vsync'd page flips
      drm/nouveau/kms/gf119-gp10x: push HeadSetControlOutputResource()
mthd when encoders change
      drm/nouveau/core: allow detected chipset to be overridden
      drm/nouveau/core: initial support for boards with TU117 chipset
      drm/nouveau/disp/dp: respect sink limits when selecting failsafe
link configuration

Boris Brezillon (1):
      drm/panfrost: Add missing _fini() calls in panfrost_device_fini()

Brian Masney (2):
      drm/msm: remove resv fields from msm_gem_object struct
      drm/msm: correct attempted NULL pointer dereference in debugfs

Chris Wilson (3):
      drm/i915: Delay semaphore submission until the start of the signaler
      drm/i915: Disable semaphore busywaits on saturated systems
      drm/i915: Seal races between async GPU cancellation, retirement
and signaling

Christian K=C3=B6nig (1):
      drm/radeon: prefer lower reference dividers

Colin Xu (1):
      drm/i915/gvt: Add in context mmio 0x20D8 to gen9 mmio list

Daniel Drake (1):
      drm/i915/fbc: disable framebuffer compression on GeminiLake

Dave Airlie (5):
      Merge tag 'drm-intel-next-fixes-2019-05-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-5.2' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'linux-5.2' of git://github.com/skeggsb/linux into drm-n=
ext
      Merge tag 'drm-intel-next-fixes-2019-05-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2019-05-15' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Evan Quan (1):
      drm/amd/powerplay: check for invalid profile_exit setting

Guenter Roeck (1):
      drm/pl111: Initialize clock spinlock early

Joonas Lahtinen (1):
      Merge tag 'gvt-next-fixes-2019-05-07' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Matt Redfearn (1):
      drm/bridge: adv7511: Fix low refresh rate selection

Nicholas Kazlauskas (1):
      drm/amd/display: Use long for signed error code checks in commit plan=
es

Peteris Rudzusiks (1):
      drm/nouveau: fix duplication of nv50_head_atom struct

Sabyasachi Gupta (1):
      drm/msm/dpu: Remove duplicate header

Sean Paul (1):
      drm/msm: Upgrade gxpd checks to IS_ERR_OR_NULL

Tomeu Vizoso (1):
      drm/panfrost: Only put sync_out if non-NULL

Trigger Huang (4):
      drm/amdgpu: Rearm IRQ in Vega10 SR-IOV if IRQ lost
      drm/amdgpu: Fix VM clean check method
      drm/amdgpu: Add IDH_QUERY_ALIVE event for SR-IOV
      drm/amdgpu: Use FW addr returned by PSP for VF MM

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix fastset vs. pfit on/off on HSW EDP transcoder

Xiong Zhang (1):
      drm/i915/gvt: Change fb_info->size from pages to bytes

Zhao Yakui (1):
      drm/i915/gvt: Revert "drm/i915/gvt: Refine the snapshort range
of I915 MCHBAR to optimize gvt-g boot time"

 drivers/dma-buf/dma-fence.c                       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c            | 10 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           | 19 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            | 36 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c             |  3 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h             |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             | 16 +++--
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             | 17 +++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            | 37 ++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c      |  6 +-
 drivers/gpu/drm/i915/gvt/debugfs.c                |  4 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                 | 19 +++---
 drivers/gpu/drm/i915/gvt/gtt.c                    | 15 +++--
 drivers/gpu/drm/i915/gvt/gtt.h                    | 16 ++---
 drivers/gpu/drm/i915/gvt/handlers.c               |  4 +-
 drivers/gpu/drm/i915/gvt/mmio_context.c           |  1 +
 drivers/gpu/drm/i915/gvt/reg.h                    |  3 -
 drivers/gpu/drm/i915/gvt/scheduler.c              |  2 +-
 drivers/gpu/drm/i915/i915_request.c               | 60 ++++++++++++++++-
 drivers/gpu/drm/i915/intel_breadcrumbs.c          | 78 +++++++++++++++++--=
----
 drivers/gpu/drm/i915/intel_context.c              |  1 +
 drivers/gpu/drm/i915/intel_context_types.h        |  3 +
 drivers/gpu/drm/i915/intel_display.c              |  9 +++
 drivers/gpu/drm/i915/intel_fbc.c                  |  4 ++
 drivers/gpu/drm/i915/intel_guc_submission.c       |  1 -
 drivers/gpu/drm/i915/intel_pipe_crc.c             | 13 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c         |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c         |  4 +-
 drivers/gpu/drm/msm/msm_atomic.c                  |  4 +-
 drivers/gpu/drm/msm/msm_gem.c                     |  3 +-
 drivers/gpu/drm/msm/msm_gem.h                     |  4 --
 drivers/gpu/drm/nouveau/dispnv50/disp.h           |  1 +
 drivers/gpu/drm/nouveau/dispnv50/head.c           |  3 +-
 drivers/gpu/drm/nouveau/dispnv50/wimmc37b.c       |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c           |  4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c             |  3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c | 60 ++++++++++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c     | 11 +++-
 drivers/gpu/drm/panfrost/panfrost_device.c        |  4 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c           |  3 +-
 drivers/gpu/drm/pl111/pl111_display.c             |  5 +-
 drivers/gpu/drm/radeon/radeon_display.c           |  4 +-
 45 files changed, 388 insertions(+), 118 deletions(-)
