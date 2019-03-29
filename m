Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F879206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoFU/wt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfC2D4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:56:16 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40353 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2D4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:56:15 -0400
Received: by mail-qt1-f179.google.com with SMTP id x12so1109053qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V0xHRh5KE9Ntoi5SC1Gp/b2IOyox5IKXBPHddXx3hVM=;
        b=VoFU/wt/AJrhOvCHAeA918MvCJRDMhOhfz3mUWPGfriGLZQBMM6bDe7NWPoIiMqTK0
         Ivf7K2QiWDHYJCEejKzbuyRtToFyjwWMVobNvMq/TW2iN0sCdNQcgnJGU1Sp1luHqovp
         DLiBK1NmSXz2l5GU0RclbIN3R7c82g6s0KbEGG9LHmM+d8zTlpGb4Tv/WzD3kFFH3wyA
         YzdyB411iJJd98eE2s+ixVg3Zyi5c/EFWosgMUnWCe5M/MSD6uSXllcfYhuUB1+M/Gzy
         7dYmGTARcUXpMv9xMY2m0iEgx9erRN7J840+N4KmjPpGJNYQnZxt96Jf9+dYvatp8p/5
         qf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V0xHRh5KE9Ntoi5SC1Gp/b2IOyox5IKXBPHddXx3hVM=;
        b=AU3yc04tZjz/pVvaeWgVrFLBe42u1tN5awsMGYh4T16E9XVH2xW+u6ysHZPvTG/TCx
         u6rDkiytexSVOp1aHooEtvqHEHsDg3Ywt/NcAtQi+SDPewxid7gz0BekFY8o/YpzR6ac
         15Euot/F5TTfqKGyGFPL6N/aQuOG3Syof0Pv+BS6Z2uBrs8dl8psS09PtbOtIXYPM9i9
         w/zjpL0QSd3KMO84Hxt7ZD6nisWKkga/57b5RRaBhyUK6L5XVWOfHphqa8xjT2jSXN0e
         hhQEilIYzfNVVhJiHTWMmeS8v2v7xwjyGUGEhIw2ialg0wN+6r+sDa9m2CksAV3AYmaG
         pbOA==
X-Gm-Message-State: APjAAAXLw8PpkdicYVnZK9nsDSLtIbnLHrc72U7DbVHHKmanSib9hkrQ
        Hvr4xGnPlVs+phG+zFQ36qw3xZINPImsYWoA3KU=
X-Google-Smtp-Source: APXvYqxtgGnUfhOFSVEWJTYoGDGeaBC93g3ZDXBRPxlZlwJOa1UuBT28gSltOpXqxEPnvQx03MiuMGZtcKyABfPweUw=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr38579735qtv.76.1553831774177;
 Thu, 28 Mar 2019 20:56:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Mar 2019 13:56:02 +1000
Message-ID: <CAPM=9tw-yPL8ZOxNO7zu3scG8PjAuKOwR=7JMDJ_93M8avVkOA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Weekly fixes roundup, nothing two serious, some usb device regressions
are fixed, and i915 GVT has a bigger fix but otherwise not really much
happening here.

Thanks,
Dave.

core:
- fb bpp check regression fix
- release/unplug fix
- use after free fixes

i915:
- fix mmap range checks
- fix gvt ppgtt mm LRU list access races
- fix selftest error pointer check
- fix a macro definition (pre-emptive for potential further backports)
- fix one AML SKU ULX status

amdgpu:
- one variable refresh rate fix

udl:
- fix EDID reading

tegra:
- build/warning fixes

meson:
- cleanup path fixes
- TMDS clock filter fix

rockchip:
- NV12 buffers and scalar fix


drm-fixes-2019-03-29:
drm amdgpu, i915, meson, udl, tegra fixes
The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00=
:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-03-29

for you to fetch changes up to 0271ab11790cd5ab8ec38e0e669e13c1009f271a:

  Merge tag 'drm-intel-fixes-2019-03-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-03-29
10:45:11 +1000)

----------------------------------------------------------------
drm amdgpu, i915, meson, udl, tegra fixes

----------------------------------------------------------------
Anders Roxell (1):
      drm/tegra: vic: Fix implicit function declaration warning

Colin Xu (1):
      drm/i915/gvt: Add in context mmio 0x20D8 to gen9 mmio list

Dan Carpenter (1):
      drm/i915/selftests: Fix an IS_ERR() vs NULL check

Dave Airlie (5):
      drm/fb: avoid setting 0 depth.
      Merge tag 'drm/tegra/for-5.1-rc2' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-03-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-03-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Eric Biggers (2):
      drm/vgem: fix use-after-free when drm_gem_handle_create() fails
      drm/vkms: fix use-after-free when drm_gem_handle_create() fails

Jean-Philippe Brucker (2):
      drm/meson: Fix invalid pointer in meson_drv_unbind()
      drm/meson: Uninstall IRQ handler

Jonas Karlman (1):
      drm/rockchip: vop: reset scale mode when win is disabled

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/icl: Fix VEBOX mismatch BUG_ON()

Manasi Navare (1):
      drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro

Neil Armstrong (1):
      drm/meson: fix TMDS clock filtering for DMT monitors

Nicholas Kazlauskas (1):
      drm/amd/display: Only allow VRR when vrefresh is within supported ran=
ge

Noralf Tr=C3=B8nnes (1):
      drm: Fix drm_release() and device unplug

Robert Tarasov (1):
      drm/udl: Refactor edid retrieving in UDL driver (v2)

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2019-03-21' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Thierry Reding (1):
      drm/tegra: hub: Fix dereference before check

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Mark AML 0x87CA as ULX

Weinan Li (1):
      drm/i915/gvt: stop scheduling workload when vgpu is inactive

Zhenyu Wang (4):
      drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check
      drm/i915/gvt: Don't submit request for error workload dispatch
      drm/i915/gvt: Only assign ppgtt root at dispatch time
      drm/i915/gvt: Add mutual lock for ppgtt mm LRU list

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 drivers/gpu/drm/drm_drv.c                         |  6 +-
 drivers/gpu/drm/drm_fb_helper.c                   |  2 +-
 drivers/gpu/drm/drm_file.c                        |  6 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c             |  2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                    | 14 ++++-
 drivers/gpu/drm/i915/gvt/gtt.h                    |  1 +
 drivers/gpu/drm/i915/gvt/mmio_context.c           |  1 +
 drivers/gpu/drm/i915/gvt/scheduler.c              | 28 ++++++---
 drivers/gpu/drm/i915/i915_drv.h                   |  3 +-
 drivers/gpu/drm/i915/i915_reg.h                   |  4 +-
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c   |  2 +-
 drivers/gpu/drm/meson/meson_drv.c                 |  9 ++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c             |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c       | 18 +++++-
 drivers/gpu/drm/tegra/hub.c                       |  4 +-
 drivers/gpu/drm/tegra/vic.c                       |  2 +
 drivers/gpu/drm/udl/udl_connector.c               | 72 ++++---------------=
----
 drivers/gpu/drm/vgem/vgem_drv.c                   |  6 +-
 drivers/gpu/drm/vkms/vkms_gem.c                   |  5 +-
 20 files changed, 89 insertions(+), 103 deletions(-)
