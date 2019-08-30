Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6F21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A90Z7Hgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Dvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:51:45 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43873 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfH3Dvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:51:45 -0400
Received: by mail-lj1-f179.google.com with SMTP id h15so5066816ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hyJSGC81Q0n6R8fdT2tpbdChQ3Fli9gi9SBH1WBTCXc=;
        b=A90Z7HgbUS9iqb2gPQQdbqtD0UK7+QqBGjqarCRm+usXBsJOmKW9ZidB80eus7QKQc
         JHNoTEiLSJ0XJTflEW6BKG69L9tBIrqJY8xxJZfjfJZAl6aL0VrB/5Axnq2Vw05BkyAK
         zW/8qM8LWsDz6WzaD9X6FXzm2Y3G3IRaXdHGE0UMo6R6TnSioYMhptreFpTlpLvIIzzo
         /qBecL1RRKJ+FYiTLspdltz0NS0r2NvHMml3yF6WJHYia4zNPHFZ25vaSZOVh+2DBlvZ
         pjno02icEPFTQOub1T76pCw+/wwnA0p2thQ80i1wZm7rr+Gn+M+j31jeKtpqWriev8aB
         UQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hyJSGC81Q0n6R8fdT2tpbdChQ3Fli9gi9SBH1WBTCXc=;
        b=LpSSvcbYItGSWby7frzS3rM5UYxVWDHtGTJc3S4KCDn9WbTjuoJ2X8Hh62kSWcX79c
         FsSdVFZqBsnZgNlJy7RsMwBUekdHAT8B4abKxiWPsIjJ52MsBRQ08N3rHncyJ8t6Vh7Y
         SssV1I7yWlttsEVscNvInQL2ZsIdnDH1/rFTiwtzwX385C+PnriMXl3R7X3wuez0wFCo
         /icDDfaDiXYPMvTOoEgO9lST13+JZs1EtUKUm02KSPl3GML+tSCFCdwmEvrJL/5vnCLz
         /1U0tSH5IbZtcGgHKpHzQuSX+mAWhScDGuyd53n11GLtREGtc3slK7CSg8pLly8qbqjO
         ztQg==
X-Gm-Message-State: APjAAAXpBnABXVVJ2eZuBuanFYz+/KdpHB3TQQeB08LkJyxF6SJ4NilG
        p9ghrcb3GzQqEsUlZ9OZlQC5GeaMX35iPFGZWIPw5pRT
X-Google-Smtp-Source: APXvYqwVqKPeQoa36Zc62b73Iyn2ikt3K7kssJJnAXlWUQWFyuGs9pCWfaIOQrmiFfeOK+aIEpOIlQf/dZejFhJv+ck=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr7498256ljg.120.1567137102242;
 Thu, 29 Aug 2019 20:51:42 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 30 Aug 2019 13:51:31 +1000
Message-ID: <CAPM=9tzaHaDUoSGC6_ESxTFWQxqgAZnDWzYNqx0zX17bv4KTUQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.3-rc7
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

Nothing too crazy, there's probably more patches than I'd like at this
stage, but they are all pretty self contained.

Dave.

drm-fixes-2019-08-30:
drm fixes for 5.3-rc7

amdgpu:
- Fix GFXOFF regression for PCO and RV2
- Fix missing fence reference
- Fix VG20 power readings on certain SMU firmware versions
- Fix dpm level setup for VG20
- Add an ATPX laptop quirk

i915:
- Fix DP MST max BPC property creation after DRM register
- Fix unused ggtt deballooning and NULL dereference in guest
- Fix DSC eDP transcoder identification
- Fix WARN from DMA API debug by setting DMA max segment size

qxl:
- Make qxl reserve the vga ports using vgaarb to prevent switching to
vga compatibility mode.

omap:
- Fix omap port lookup for SDI output

virtio:
- Use virtio_max_dma_size to fix an issue with swiotlb.

komeda:
- Compiler fixes to komeda.
- Add missing of_node_get() call in komeda.
- Reorder the komeda de-init functions.
The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76=
:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-30

for you to fetch changes up to 1c0d63eb0e824cb2916a77523ec7a4fa0e9753c8:

  Merge tag 'drm-intel-fixes-2019-08-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-08-30
10:55:29 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc7

amdgpu:
- Fix GFXOFF regression for PCO and RV2
- Fix missing fence reference
- Fix VG20 power readings on certain SMU firmware versions
- Fix dpm level setup for VG20
- Add an ATPX laptop quirk

i915:
- Fix DP MST max BPC property creation after DRM register
- Fix unused ggtt deballooning and NULL dereference in guest
- Fix DSC eDP transcoder identification
- Fix WARN from DMA API debug by setting DMA max segment size

qxl:
- Make qxl reservel the vga ports using vgaargb to prevent switching
to vga compatibility mode.

omap:
- Fix omap port lookup for SDI output

virtio:
- Use virtio_max_dma_size to fix an issue with swiotlb.

komeda:
- Compiler fixes to komeda.
- Add missing of_node_get() call in komeda.
- Reorder the komeda de-init functions.

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: fix GFXOFF on Picasso and Raven2

Ayan Kumar Halder (1):
      drm/komeda: Reordered the komeda's de-init functions

Christian K=C3=B6nig (1):
      drm/amdgpu: fix dma_fence_wait without reference

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2019-08-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-fixes-5.3-2019-08-28' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-08-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/powerplay: correct Vega20 dpm level related settings

Gerd Hoffmann (2):
      drm/qxl: get vga ioports
      drm/virtio: use virtio_max_dma_size

Kai-Heng Feng (1):
      drm/amdgpu: Add APTX quirk for Dell Latitude 5495

Kent Russell (2):
      drm/powerplay: Fix Vega20 Average Power value v4
      drm/powerplay: Fix Vega20 power reading again

Laurent Pinchart (1):
      drm/omap: Fix port lookup for SDI output

Lyude Paul (1):
      drm/i915: Call dma_set_max_seg_size() in i915_driver_hw_probe()

Manasi Navare (1):
      drm/i915/dp: Fix DSC enable code to use cpu_transcoder instead
of encoder->type

Mihail Atanassov (1):
      drm/komeda: Add missing of_node_get() call

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Do not create a new max_bpc prop for MST connectors

Xiong Zhang (1):
      drm/i915: Don't deballoon unused ggtt drm_mm_node in linux guest

james qian wang (Arm Technology China) (3):
      drm/komeda: Fix error: not allocating enough data 1592 vs 1584
      drm/komeda: Fix warning -Wunused-but-set-variable
      drm/komeda: Clean warning 'komeda_component_add' might be a
candidate for 'gnu_printf'

 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c            | 27 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 14 ++---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 66 ++++++++++++++++++=
+---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c         | 11 +++-
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    | 29 ++++++----
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  1 +
 .../drm/arm/display/komeda/komeda_wb_connector.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 10 +++-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  2 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  6 ++
 drivers/gpu/drm/i915/i915_vgpu.c                   |  3 +
 drivers/gpu/drm/omapdrm/dss/output.c               |  4 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      | 20 ++++++-
 drivers/gpu/drm/virtio/virtgpu_object.c            | 10 +++-
 16 files changed, 161 insertions(+), 47 deletions(-)
