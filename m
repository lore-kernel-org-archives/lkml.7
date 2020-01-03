Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B31C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AF922B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTv3levr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgACG5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 01:57:52 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:35666 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 01:57:52 -0500
Received: by mail-lf1-f48.google.com with SMTP id 15so31315052lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 22:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cI5dJ5uXWY3xWZKUs3Uuw1PY+H/R9kRSLoYee4iD0CA=;
        b=UTv3levrXIbAc8/TmHr64J63WvrchvvnUspsP0fTM9g7Qt+9/1xcHCjL/M8000dkoa
         1aDaEDm6QZ+QTZv7v+lxCEPZCGIHJVJdNkAYGzAaq8cknzX62Vhum0QQsZFGdofPnrk2
         OPVbhN7IFqFgrYHkSc9lpVPo2Z4VUFAskr9jHgaO7TaFC/nZ8ErgGFA3Y4rDU1VdnO+P
         cBVlvluMAiDK2NyRlGbuePygzf2m1qm/SBivylaHgPu+jMNE/8NSUEjFQYIjrAaAspiV
         n+iIl6Ppns+Fvsccx1yy6yj+xDtd62yr+9s84EMLlOSZ1AHJ9DisEav1hLFz7q0W81sU
         JLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cI5dJ5uXWY3xWZKUs3Uuw1PY+H/R9kRSLoYee4iD0CA=;
        b=pg+jGySGzs2angvQxP4e9lU95NPV2K3gu+hvz9nm+ab1KtUr+RIv6sTYdW52T7Lfyn
         hRSLjCfp9RNtTcSMVHDUubQUAvyDQwgNcr7NRF7mfiZ83ZNX2GTGhiZpuwvUSiiejUF2
         FELTwz3VFKbwiccvARUemdzKJ/+eAvAWKS1IKg7RLr3BE5VaqdPI/FFKY1Sw3oefoqPM
         gaoDfESIUNdRLQXOGoP+s93Po6x04YIrmQC3bDOAmnJbUOhwPGehvMcbLi/i5dnH/bmh
         kfzqQ78e97Aw8SPvg9xmgNtOLixenNw6ZmBot2c1CFEN5OhkFaxl8HfdQOpIzXn/Qq5l
         FCjQ==
X-Gm-Message-State: APjAAAXl5HO2PD1laQ6WeWCvVUgTJUKJANYcj/G9TFDVw1I5WuNgbcTn
        y2jpRtfFF6BbEsM61Zj3TewUd/6wQOnFl9PoSlkMPfsv
X-Google-Smtp-Source: APXvYqzjCIUYUsR5o17WTHsEmmfTw5WkUqsWP/dnDkeb7hw35ENaG7dNVEir1uySAHb8khcwPQWO15buVSi1oNXU51E=
X-Received: by 2002:ac2:5975:: with SMTP id h21mr48175706lfp.165.1578034669925;
 Thu, 02 Jan 2020 22:57:49 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Jan 2020 16:57:38 +1000
Message-ID: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.5-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

New Years fixes! Mostly amdgpu with a light smattering of arm
graphics, and two AGP warning fixes.

Quiet as expected, hopefully we don't get a post holiday rush.

Dave.

drm-fixes-2020-01-03:
drm fixes for 5.5-rc5

agp:
- two unused variable removed

amdgpu:
- ATPX regression fix
- SMU metrics table locking fixes
- gfxoff fix for raven
- RLC firmware loading stability fix

mediatek:
- external display fix
- dsi timing fix

sun4i:
- Fix double-free in connector/encoder cleanup (Stefan)

maildp:
- Make vtable static (Ben)
The following changes since commit fd6988496e79a6a4bdb514a4655d2920209eb85d:

  Linux 5.5-rc4 (2019-12-29 15:29:16 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-03

for you to fetch changes up to a6204fc7b83cbe3398f61cf1742b09f66f0ae220:

  agp: remove unused variable arqsz in agp_3_5_enable() (2020-01-03
16:08:05 +1000)

----------------------------------------------------------------
drm fixes for 5.5-rc5

agp:
- two unused variable removed

amdgpu:
- ATPX regression fix
- SMU metrics table locking fixes
- gfxoff fix for raven
- RLC firmware loading stability fix

mediatek:
- external display fix
- dsi timing fix

sun4i:
- Fix double-free in connector/encoder cleanup (Stefan)

maildp:
- Make vtable static (Ben)

----------------------------------------------------------------
Alex Deucher (5):
      Revert "drm/amdgpu: simplify ATPX detection"
      drm/amdgpu/smu: add metrics table lock
      drm/amdgpu/smu: add metrics table lock for arcturus (v2)
      drm/amdgpu/smu: add metrics table lock for navi (v2)
      drm/amdgpu/smu: add metrics table lock for vega20 (v2)

Ben Dooks (Codethink) (1):
      drm/arm/mali: make malidp_mw_connector_helper_funcs static

Dave Airlie (3):
      Merge tag 'mediatek-drm-fixes-5.5' of
https://github.com/ckhu-mediatek/linux.git-tags into drm-fixes
      Merge tag 'drm-misc-fixes-2019-12-31' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.5-2020-01-01' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amdgpu: correct RLC firmwares loading sequence

Jitao Shi (1):
      drm/mediatek: reduce the hbp and hfp for phy timing

Pi-Hsun Shih (1):
      drm/mediatek: Check return value of mtk_drm_ddp_comp_for_plane.

Stefan Mavrodiev (1):
      drm/sun4i: hdmi: Remove duplicate cleanup calls

Yongqiang Niu (1):
      drm/mediatek: Fix can't get component for external display plane.

Yunfeng Ye (2):
      agp: remove unused variable mcapndx
      agp: remove unused variable arqsz in agp_3_5_enable()

changzhu (1):
      drm/amdgpu: enable gfxoff for raven1 refresh

 drivers/char/agp/isoch.c                         |  9 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 12 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 15 ++----
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c       |  1 +
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c     |  3 ++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h   |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c       |  3 ++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c       |  3 ++
 drivers/gpu/drm/arm/malidp_mw.c                  |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c          | 18 ++++---
 drivers/gpu/drm/mediatek/mtk_dsi.c               | 67 ++++++++++++++----------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c           |  2 -
 14 files changed, 80 insertions(+), 60 deletions(-)
