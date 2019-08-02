Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91231C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A73C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV1yUR7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfHBCYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:24:02 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43354 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbfHBCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:23:58 -0400
Received: by mail-lf1-f43.google.com with SMTP id c19so51758327lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=avfAa/7L14uB9QkcSbxP0pdLgxgaet/skvZa0szQ5IY=;
        b=QV1yUR7ucwzp8P/EGXo8Gz3EwqkDbwjC37rULF73+IKsEBAorgPwmSp2Cy8WRcaqrV
         cB2eYJJQ0+83OrZjZR2BjY0SdLQz1NKVjQFRcwf2MREaXh9fsAzVJ43FxGM1+mfEiIj3
         jokJeHmzhfdNLH7xWUK+jRbyHMXitRgzl4OywY6NTO1oCuLjOYJ5kNWYpa68Xcf5hBQU
         RdtErgVmAILdCdcNJL4luRCuf291vQtNb17qqTPlXSKFRh+xZ6ek02PznHvqbAnErV29
         H4amLBJBpxSpC9UK3HDgniTrolnCiJVF2OLd1sIZRWrbkaEiHwgaqGgnedlEFEZ/jG9p
         cBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=avfAa/7L14uB9QkcSbxP0pdLgxgaet/skvZa0szQ5IY=;
        b=oJwz+cHpZPVpmyhPjdCt34ACbSL/0WMQzhLNAf0jd5yOXJGUIMV3ABfY8Fe5hq0CUU
         NrL7kW8mEOV4wGBvQ+uMOGM5EBCsoIdYNdJVWhkZlf1zhu0crxQNqGtzEPrva4iBIA4B
         Y7crT+4AYM5l//zZljZNtFuybJpD5TaA3akkbMR5Km28FHqttlB7nVS3FaTTEsPiS7vM
         lK9iwsxCe2AO8qhHwEadoEmqZOqchwHu8B+4Gb8RRbjxC9iJdjOBmQMi5G4IetaQT0C+
         0sDJqj0oVXZIcur34w6igfG4u23FGwWwQpeO0SwVwqeqU8l1my8NG8UIjx5BGC/Ouw0t
         Ps2g==
X-Gm-Message-State: APjAAAWFkvy8NXhv1iHiXy0i1r7jvnloFO9zJsC1X4HDtsldK7PBJ6yh
        An5qrEUAReCDkCZZbJMO/8CWQ4pBcHGJHYTQJUIo2Vmc
X-Google-Smtp-Source: APXvYqwx/g6dE/6hV5oTXlX6VP2+9JeyMq7cx9Mp5n4CGVHpBg1cjMn+Gymm/h6P6abHXBHTf6vDy1hDIvUX3J9Lg7M=
X-Received: by 2002:a05:6512:51c:: with SMTP id o28mr65112767lfb.67.1564712635593;
 Thu, 01 Aug 2019 19:23:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 2 Aug 2019 12:23:44 +1000
Message-ID: <CAPM=9twvuac3guTTT-Y5O65GscWLG-NwOdyUCmHFi0HOcQM1DA@mail.gmail.com>
Subject: drm fixes for 5.3-rc3
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

Thanks to Daniel for handling the email the last couple of weeks, flus
and break-ins combined to derail me. Surprised nothing materialised
today to take me out again.

I've also tried embedding the summary into the signed pull request,
since all the cool kids seemed to be doing it, it's a bit messy in my
workflow as I do most of my stuff remotely including signing, but I
usually edit the summary locally.

Otherwise, just more amdgpu navi fixes, msm fixes and a single nouveau
regression fix.

Thanks,
Dave.

drm-fixes-2019-08-02:
drm pull fixes for 5.3-rc3

amdgpu:
    navi10 temperature and pstate fixes
    vcn dynamic power management fix
    CS ioctl error handling fix
    debugfs info leak fix
    amdkfd VegaM fix.

msm:
    dma sync call fix
    mdp5 dsi command mode fix
    fall-through fixes
    disabled GPU fix

nouveau:
    regression fix for displayport MST support.
The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b=
:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-02

for you to fetch changes up to f8981e0309e9004c6e86d218049045700c79d740:

  Merge tag 'msm-fixes-2019_08_01' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2019-08-02
10:17:25 +1000)

----------------------------------------------------------------
drm pull fixes for 5.3-rc3

amdgpu:
    navi10 temperature and pstate fixes
    vcn dynamic power management fix
    CS ioctl error handling fix
    debugfs info leak fix
    amdkfd VegaM fix.

msm:
    dma sync call fix
    mdp5 dsi command mode fix
    fall-through fixes
    disabled GPU fix

nouveau:
    regression fix for displayport MST support.

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/powerplay: use proper revision id for navi

Brian Masney (1):
      drm/msm: add support for per-CRTC max_vblank_count on mdp5

Christian K=C3=B6nig (1):
      drm/amdgpu: fix error handling in amdgpu_cs_process_fence_dep

Dave Airlie (2):
      Merge tag 'drm-fixes-5.3-2019-07-31' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'msm-fixes-2019_08_01' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Evan Quan (7):
      drm/amd/powerplay: fix null pointer dereference around dpm state rela=
tes
      drm/amd/powerplay: enable SW SMU reset functionality
      drm/amd/powerplay: add new sensor type for VCN powergate status
      drm/amd/powerplay: support VCN powergate status retrieval on Raven
      drm/amd/powerplay: support VCN powergate status retrieval for SW SMU
      drm/amd/powerplay: correct Navi10 VCN powergate control (v2)
      drm/amd/powerplay: correct UVD/VCE/VCN power status retrieval

Jeffrey Hugo (1):
      drm: msm: Fix add_gpu_components

Jordan Crouse (1):
      drm/msm: Annotate intentional switch statement fall throughs

Kent Russell (1):
      drm/amdkfd: Fix byte align on VegaM

Kevin Wang (2):
      drm/amd/powerplay: add callback function of get_thermal_temperature_r=
ange
      drm/amd/powerplay: fix temperature granularity error in smu11

Lyude Paul (1):
      drm/nouveau: Only release VCPI slots on mode changes

Rob Clark (1):
      drm/msm: Use the correct dma_sync calls in msm_gem

Wang Xiayang (1):
      drm/amdgpu: fix a potential information leaking bug

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 26 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c            | 74 +++++++++++++++----=
----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c        | 23 ++++---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |  9 +++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c        | 48 +++++++++------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c         | 36 ++++++-----
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c        | 34 ++++-------
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c             |  2 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  1 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         | 16 ++++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c          |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                     |  3 +-
 drivers/gpu/drm/msm/msm_gem.c                     | 47 ++++++++++++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c           |  2 +-
 19 files changed, 215 insertions(+), 116 deletions(-)
