Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751ECC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4317623402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+6IOZ3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbfHWCH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:07:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44322 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbfHWCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:07:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id e24so7354837ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m9UCiBbxvX2eiPGCEuc+8rk/jAlLT2u6YhaD43bOE3Q=;
        b=W+6IOZ3+IGe2nww+GHWztKNNycbSJYGgW3a7sxIoWwir4HmtA7b3cP1VnVL9CHgR6f
         aytAtaCe4xWHkgE5ehi9zJPHZxMevPVKrtoJ3nlBulaqGsLUOYhA/1HZMKRe6cBZWwP+
         GfhcSN8hzW5D0OEMY0hEQiJF4MfjdEFHSncNsxjZbkdaSMOaOYHjVpV5ukgUcrOAm505
         1+Lg2y98i7Ie68Hd/lMCcdxQerCDdbkgXNN2C7KkIcGClIXmsxaD4K+sX26PwYY5NgJY
         VBfyqB+Pu7OYTVfv934gxgDrmefGQW1jD2VQavmsMvfigXevekWx8THYHVjj7sUQnHp6
         P/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=m9UCiBbxvX2eiPGCEuc+8rk/jAlLT2u6YhaD43bOE3Q=;
        b=l0mkzKErdOtVSxWrrXZIsvIVgqC//xpqhQyn7YV6FvPKjQGHBtREGtUHXnzEGNoWtp
         cdL/5qxZHa3EyLy/+NswVOUi7zDQfkSgtTMQj5l/PZNL8dsPucwRpbdf6ESgvsdbTQiM
         AyfynrCiHSdmzzfe66bpGvVlq+Ew9zE5NU5chIA2OO/0a5HhP9aOn+Y/2xDx30KiP2wr
         mYaPlpwFO7FBZB2G/T2d2X5+1aIxKbfQ3k0c1kERfFSjcwZchYGIOprqWjX2egCDUewL
         gRefKP7A1p8m2d1jAQq0aj6Rdw6i/1mBk3bonRU88tV5GyWH/6TPvSnnWPMSDUaG6Ff8
         D9mA==
X-Gm-Message-State: APjAAAXMzuJmg67cybMnm5DuetSpbZd58iFVMEDfKNOTinzHwUN+I1vA
        yhguDVH3CDzmDO/p7Iakm1zP09EnjYIMEle23Go=
X-Google-Smtp-Source: APXvYqwVrx50QJgmSpZP/Mu6Qfet2mOs4gqN481mNJFCQpM74D9tfSA0J8HkZlPeDZR7ph1BwzB33uxWwqmgTbHhbWY=
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr1258718ljm.238.1566526043784;
 Thu, 22 Aug 2019 19:07:23 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Aug 2019 12:07:12 +1000
Message-ID: <CAPM=9tw7pU3_Y=2b0G1u12cn6ZRAB4ypabJz=HopbQ-JLP2zwA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.3-rc6
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
Hi Linus,

Live from the laundromat after my washing machine broke down, we have
the 5.3-rc6 fixes.  Changelog is in the tag below, but nothing too
noteworthy in here.

Dave.

drm-fixes-2019-08-23:
drm fixes for 5.3-rc6

rcar-du:
- LVDS dual-link mode fix

mediatek:
- of node refcount fix
- prime buffer import fix
- dma max seg fix

komeda:
- output polling fix
- abfc format fix
- memory-region DT fix

amdgpu:
- bpc display fix
- ioctl memory leak fix
- gfxoff fix
- smu warnings fix

i915:
- HDMI mode readout fix
The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1=
:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-23

for you to fetch changes up to 75710f08ea7e41b2f7010da3f6deab061f7a853b:

  drm/amdgpu/powerplay: silence a warning in smu_v11_0_setup_pptable
(2019-08-23 11:46:32 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc6

rcar-du:
- LVDS dual-link mode fix

mediatek:
- of node refcount fix
- prime buffer import fix
- dma max seg fix

komeda:
- output polling fix
- abfc format fix
- memory-region DT fix

amdgpu:
- bpc display fix
- ioctl memory leak fix
- gfxoff fix
- smu warnings fix

i915:
- HDMI mode readout fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/gfx9: update pg_flags after determining if gfx off is poss=
ible
      drm/amdgpu/powerplay: silence a warning in smu_v11_0_setup_pptable

Alexandre Courbot (2):
      drm/mediatek: use correct device to import PRIME buffers
      drm/mediatek: set DMA max segment size

Dave Airlie (5):
      Merge tag 'du-fixes-20190816' of
git://linuxtv.org/pinchartl/media into drm-fixes
      Merge tag 'mediatek-drm-fixes-5.3' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge tag 'drm-fixes-5.3-2019-08-21' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-08-22' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2019-08-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Imre Deak (1):
      drm/i915: Fix HW readout for crtc_clock in HDMI mode

Jacopo Mondi (1):
      drm: rcar_lvds: Fix dual link mode operations

Kenneth Feng (1):
      drm/amd/amdgpu: disable MMHUB PG for navi10

Kevin Wang (2):
      drm/amd/powerplay: fix variable type errors in smu_v11_0_setup_pptabl=
e
      drm/amd/powerplay: remove duplicate macro
smu_get_uclk_dpm_states in amdgpu_smu.h

Lowry Li (Arm Technology China) (2):
      drm/komeda: Initialize and enable output polling on Komeda
      drm/komeda: Adds internal bpp computing for arm afbc only format YU08=
 YU10

Maarten Lankhorst (1):
      Merge remote-tracking branch 'drm/drm-fixes' into drm-misc-fixes

Mihail Atanassov (1):
      drm/komeda: Add support for 'memory-region' DT node property

Nicholas Kazlauskas (1):
      drm/amd/display: Calculate bpc based on max_requested_bpc

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: prevent memory leaks in AMDGPU_CS ioctl

Nishka Dasgupta (1):
      drm/mediatek: mtk_drm_drv.c: Add of_node_put() before goto

Tomi Valkeinen (1):
      drm/omap: ensure we have a valid dma_mask

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  9 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  4 ++
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  5 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 16 ++++++-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  2 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          |  6 ++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  9 ++++
 .../drm/arm/display/komeda/komeda_format_caps.c    | 19 ++++++++
 .../drm/arm/display/komeda/komeda_format_caps.h    |  3 ++
 .../drm/arm/display/komeda/komeda_framebuffer.c    |  5 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  5 ++
 drivers/gpu/drm/i915/display/intel_ddi.c           |  4 +-
 drivers/gpu/drm/i915/intel_drv.h                   |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 54 ++++++++++++++++++=
++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |  2 +
 drivers/gpu/drm/omapdrm/omap_drv.c                 |  2 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c                |  6 +--
 18 files changed, 126 insertions(+), 28 deletions(-)
