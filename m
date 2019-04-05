Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02300206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 02:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPjDWpSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfDECVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:21:22 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:37444 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDECVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 22:21:22 -0400
Received: by mail-qt1-f174.google.com with SMTP id z16so5765102qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3AOoDELgikDzOK8DN0YtCwdVkb86otM6u4oUHmzN0Lo=;
        b=rPjDWpSGGGOmLgFGB6aBZYy8He+qhmPAW50vzNBnBjj5F0ktBeofTKsmU+8neAKUL2
         DZR6/hZqMlp7KkJg8JfFcQoSRabfovuie0mP+iNiz1CP8v2LEp1PJ9dsYRWe0T9CoizA
         LCvHSqcJRPMwNgFuhTGdGDhJmufV1sz/AyHgLl3wfGdc3cVmWPCkqWBWN56IlcapTxWF
         hNQ9J7jS8y8oWUTAY/TF9p9/nasIgR6W62uLFz93+2tXWrlQX9qx/yxU6H5PBT5cbKyS
         ttqWiBkjOcykRfJocrubrVyfd/L0cBo7/nOdp5ARi/DFhYDOIr9yPlR38D3wcXQqO5iG
         5D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3AOoDELgikDzOK8DN0YtCwdVkb86otM6u4oUHmzN0Lo=;
        b=g9g+7Nrzmd6hAj/185DrsttxMiK0og3KDNJtEX922nEsGVCsRUK9eoBSHjRjGh4l+N
         StwCQtDc6h+ofBubJBPZjg+lyeRUT2YyFArC1KH5cCjY7MfuZMER9eOIGFPz14E7KzFu
         ju2NhVOx1Kbu9fblwyFXi5b/gqoCm1fg6yU9Nhb52ywIZGq/Rje+0oeoYCxmG7nEWi6K
         0blNUxNkoP7yoyTq0IYTg0z1s7G4deHR3XfaeQO7rSofIV35IbB/24lDzw8OndpqzwDE
         Ttoa5c42FEru1fj9qidNVBbL9PQo7PKNK8A55j2+HhO79f/oKrtkfp7mquWABtQ46kYU
         Yi+A==
X-Gm-Message-State: APjAAAWrhl5A9XpRv2D881Bori62O59Jsl9dDUv9KEXUhOlqP5iSL0GO
        2fjnlaVEbxgHTn3EwGiUoKQNwNX3DrwdePoNamU=
X-Google-Smtp-Source: APXvYqwk6/KoBwmjdXPY/tSeg3bnSZA5wd4PuiiyF/ljASxiSNTD48olx9LUcMlwOns9wxUkVhSPbThKzwEgSe6+4VU=
X-Received: by 2002:a0c:e587:: with SMTP id t7mr8185344qvm.114.1554430881330;
 Thu, 04 Apr 2019 19:21:21 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 Apr 2019 12:21:09 +1000
Message-ID: <CAPM=9txdKn5TUM=CLQgfVfw9v9fwkn+MgfUkVX69uvst=KfxkA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc4
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

Pretty quiet week, just some amdgpu and i915 fixes.

i915:
- deadlock fix
- gvt fixes

amdgpu:
- PCIE dpm feature fix
- Powerplay fixes

Thanks,
Dave.

drm-fixes-2019-04-05:
drm: i915 and amdgpu fixes
The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-04-05

for you to fetch changes up to 23b5f422e8f42d9d3b7063c05c839a8b0ff5adf5:

  Merge tag 'drm-intel-fixes-2019-04-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-04-05
10:45:32 +1000)

----------------------------------------------------------------
drm: i915 and amdgpu fixes

----------------------------------------------------------------
Chengming Gui (1):
      drm/amd/amdgpu: fix PCIe dpm feature issue (v3)

Chris Wilson (2):
      drm/i915: Always backoff after a drm_modeset_lock() deadlock
      drm/i915/gvt: Fix kerneldoc typo for intel_vgpu_emulate_hotplug

Dave Airlie (2):
      Merge branch 'drm-fixes-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-04-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (3):
      drm/amd/powerplay: add ECC feature bit
      drm/amd/powerplay: correct data type to avoid overflow
      drm/amd/powerplay: fix possible hang with 3+ 4K monitors

Le Ma (1):
      drm/amdgpu: remove unnecessary rlc reset function on gfx9

Paul Hsieh (1):
      drm/amd/display: VBIOS can't be light up HDMI when restart system

Rodrigo Vivi (1):
      Merge tag 'gvt-fixes-2019-04-04' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Xiong Zhang (1):
      drm/i915/gvt: Correct the calculation of plane size

Yan Zhao (2):
      drm/i915/gvt: do not deliver a workload if its creation fails
      drm/i915/gvt: do not let pin count of shadow mm go negative

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c          |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c               |  2 --
 drivers/gpu/drm/amd/display/dc/core/dc_link.c       |  6 ++++++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c  | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h  |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if.h |  5 +++--
 drivers/gpu/drm/i915/gvt/display.c                  |  2 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                   |  8 ++------
 drivers/gpu/drm/i915/gvt/gtt.c                      |  2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c                |  5 +++--
 drivers/gpu/drm/i915/i915_debugfs.c                 |  5 ++++-
 11 files changed, 44 insertions(+), 17 deletions(-)
