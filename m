Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEB9213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0PJfQVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCVCUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:20:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34419 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:20:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so977875qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1MvPNuO+byblhHFNuunkHvUF5WwirpET03+zoAj65qw=;
        b=Q0PJfQVk5owALzwQKpZEGR5MxuGIAgs3Dx0weCyJm1tYPicIbZ/w/GYfEMz8Klp8k/
         ZTiU0QjtEz5MyRi375S0lUIKn01Ybm14LS4jvE/5fvYk7Sgbmeyu0+etkJpngilLsge6
         SM5ox5XhvZnirAUmn84z3i/FzcDnl+n7GXEwAz+pZAVrvj90kpyHlK2akqLZh1+4jhVA
         cgAHzOC/277Qx1oJGCxOKtamvzMVAGOak0vTB7GS1hWJCwE4/zFeMqGgSXvm96mxlz60
         JJyheKFH5O0nkm6TIJdeVwclY3c4VmBV7J+deL09BUVwKzRUe17S49ThxdX8VPRnyrKR
         l7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1MvPNuO+byblhHFNuunkHvUF5WwirpET03+zoAj65qw=;
        b=s02+uozeB1Gqy8C+Mh2yvB+o80fxHJAZNRHoSIuYegf6ck/Lfw1blnDhRkRvd7rX3h
         0tGOuVnqA8JVCGZFrDXmSTkiliIXAFUZqHZYn1IBEI/XFdzREAjc24Fi9Np6ubZr9Wsv
         uDm+TBZnls3VTo3NHvLcTEMks1Hv+YFRDsQkHZ6MPpSoz2q9iUjw11v5Iu7Drl2Rb/cy
         hjao8Z4Ql/3T6M2uZZaNtibVVOYrh/CJ1e3OG/267GKKBtJo743pP55E283Ex9n6BSwO
         LRI5neKXP385xw7U5VFBh3BtrMyOXw+15vkdKudPsm8ozrRKdklnoHRbO30LUU8s3u7n
         QyFQ==
X-Gm-Message-State: APjAAAXcoZfUL3FAZwhh07viu6ij/A3aBzI8/xHJWem/08+1ih3NNza3
        mlnD479NdlOn08biu/5yrWs4fP1+UoxQAGjvLPs=
X-Google-Smtp-Source: APXvYqyMFdBA3Biw7AdQJxBncPbWOHpSweXplWW1ws7LHsufoGPp/0qs8ftuTSuwX2GUAqqZbQrdM8GFSoeQR3MdICg=
X-Received: by 2002:a0c:871a:: with SMTP id 26mr5879106qvh.203.1553221239997;
 Thu, 21 Mar 2019 19:20:39 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Mar 2019 12:20:28 +1000
Message-ID: <CAPM=9twckrmLPgfXChh6L1U-fZBr9G=s2JvXUjgorM4x4djAbA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc2
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

Fixes for rc2, seems to be lots of little minor ones for regressions
in rc1, and some cleanups, the exynos one is the largest one, and is
for a hw difference between exynos versions.

Regards,
Dave.

drm-fixes-2019-03-22:
drm i915, amdgpu, vmwgfx, exynos, nouveau and udl fixes
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b=
:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-22

for you to fetch changes up to 8e078788b57df678d2d469a8489748bf856d6f28:

  Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-03-22
12:08:44 +1000)

----------------------------------------------------------------
drm i915, amdgpu, vmwgfx, exynos, nouveau and udl fixes

----------------------------------------------------------------
Andrzej Hajda (1):
      drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Chris Wilson (2):
      drm/i915: Fix off-by-one in reporting hanging process
      drm/i915: Sanity check mmap length against object size

Christian K=C3=B6nig (2):
      drm/amdgpu: revert "cleanup setting bulk_movable"
      drm/amdgpu: fix invalid use of change_bit

Dan Carpenter (1):
      drm/nouveau/dmem: Fix a NULL vs IS_ERR() check

Dave Airlie (6):
      drm/udl: use drm_gem_object_put_unlocked.
      Merge branch 'linux-5.1' of git://github.com/skeggsb/linux into drm-f=
ixes
      Merge tag 'drm-intel-fixes-2019-03-20' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'exynos-drm-fixes-for-5.1-rc2' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge branch 'vmwgfx-fixes-5.1' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Deepak Rawat (1):
      drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

J=C3=A9r=C3=B4me Glisse (1):
      drm/nouveau/dmem: empty chunk do not have a buffer object
associated with them.

Thomas Preston (1):
      drm/i915/bios: assume eDP is present on port A when there is no VBT

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

YueHaibing (2):
      drm/nouveau/dmem: remove set but not used variable 'drm'
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   2 +-
 drivers/gpu/drm/exynos/exynos_mixer.c         | 110 +++++++++++++++-------=
----
 drivers/gpu/drm/i915/i915_gem.c               |  15 ++--
 drivers/gpu/drm/i915/i915_gpu_error.c         |   2 +-
 drivers/gpu/drm/i915/intel_bios.c             |   1 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |  12 +--
 drivers/gpu/drm/udl/udl_gem.c                 |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c            |  12 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c |   2 +-
 11 files changed, 87 insertions(+), 75 deletions(-)
