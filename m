Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A51AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D64206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWsvFZ1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKVAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:43:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46120 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKVAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:43:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so5273649ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/p+xhyzASM13QNfpuIBJtBQsTU+T9jGG2T6lsTO/bXw=;
        b=gWsvFZ1x+6hGOrmywCWYoZ3kDDPoWHGj7GPOXbz6nWA6PkrkA/j1HTuqUXmi9V2xlX
         YvFVkSwZ/kjklEjmUz5FYlREeZUoDne8OAMx+wAjAWG5qungiJfyflkkKstIAG3A0HOQ
         qGWqJ66kYQaSjCeEAj5V4MwAtKcM45v2pws0ZyykSnT6lSv/2f3f/1jMHPnEL2k4urkX
         b7bt1i6/bicWIR4uI5ldPqOJ4A3Qg44b0JuGxBHbPfaofHjPccg7ZuVi18RNYGGwz+He
         L+zXnVtD1RjEXfUTuaoCWyB5t95rdoR/yyYvewbMr/c4N/3OTF/FrIo0fWmXjHEQn6dJ
         3UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/p+xhyzASM13QNfpuIBJtBQsTU+T9jGG2T6lsTO/bXw=;
        b=VSxOhAsKfXpJrTYqnmMs0WwZw5ChHACNBEavNxg/FFPpNiBu0ljKfTNzt/RNjkyfNQ
         MPccIEBkhT3XvkUZ52gH6QLaLb4P/gvr0EVJxlz/GuaTxSz/OpRfvFHmcap+cCWWG1cM
         X813jsl7gCSI7KRnfnsumXp+M6Z7t9L/4ocbM7gGqaKHzC3nR8na3UN65omT1GJyYS7P
         5QmK37FLZ8TAsPrIP/RbXndQPLoCOkUJWuzXocil+pFuUsHPAGxWaY+iaQzqnEZnhM26
         NyDfJiEIc2+o8955z49d+1BFj05Qpd+dIGAsbLm7s/viLSuj2Y1Oe+KPqKkmqszOChVa
         lqdA==
X-Gm-Message-State: APjAAAULqrbl0Z+oxVSckahXpE7WwHkCwVlc/pvK91Jb8RXjHQNcFF+W
        RZvSKF1mf5iECB8EbvTSWfaPBNqRDMtk999Gs8c=
X-Google-Smtp-Source: APXvYqzqwvzdlXKKh1FdCVxdszFO5OSJ5QMkHfjHZzkmJ4A/q64CVwBbDumXaMWe1zyDV0IJjgdE0a44+9o0j+sm2sY=
X-Received: by 2002:a2e:b014:: with SMTP id y20mr9954063ljk.223.1574383420201;
 Thu, 21 Nov 2019 16:43:40 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Nov 2019 10:43:28 +1000
Message-ID: <CAPM=9txZ7F80TCRMtgRbkCGcv=gCp9_+YoZLZRBo2N7H09jN=Q@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4
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

Two sets of fixes in here, one for amdgpu, and one for i915. The
amdgpu ones are pretty small, i915's CI system seems to have a few
problems in the last week or so, there is one major regression fix for
fb_mmap, but there are a bunch of other issues fixed in there as well,
oops, screen flashes and rcu related.

Dave.

drm-fixes-2019-11-22:
drm fixes for 5.4

amdgpu:
- Remove experimental flag for navi14
- Fix confusing power message failures on older VI parts
- Hang fix for gfxoff when using the read register interface
- Two stability regression fixes for Raven

i915:
- Fix kernel oops on dumb_create ioctl on no crtc situation
- Fix bad ugly colored flash on VLV/CHV related to gamma LUT update
- Fix unity of the frequencies reported on PMU
- Fix kernel oops on set_page_dirty using better locks around it
- Protect the request pointer with RCU to prevent it being freed while
we might need still
- Make pool objects read-only
- Restore physical addresses for fb_map to avoid corrupted page table
The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb=
:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-22

for you to fetch changes up to 51658c04c338d7ef98d6c2c19009e4814632db50:

  Merge tag 'drm-intel-fixes-2019-11-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-11-22
10:29:52 +1000)

----------------------------------------------------------------
drm fixes for 5.4

amdgpu:
- Remove experimental flag for navi14
- Fix confusing power message failures on older VI parts
- Hang fix for gfxoff when using the read register interface
- Two stability regression fixes for Raven

i915:
- Fix kernel oops on dumb_create ioctl on no crtc situation
- Fix bad ugly colored flash on VLV/CHV related to gamma LUT update
- Fix unity of the frequencies reported on PMU
- Fix kernel oops on set_page_dirty using better locks around it
- Protect the request pointer with RCU to prevent it being freed while
we might need still
- Make pool objects read-only
- Restore physical addresses for fb_map to avoid corrupted page table

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu: remove experimental flag for Navi14
      drm/amdgpu: disable gfxoff when using register read interface
      drm/amdgpu: disable gfxoff on original raven
      Revert "drm/amd/display: enable S/G for RAVEN chip"

Chris Wilson (4):
      drm/i915/pmu: "Frequency" is reported as accumulated cycles
      drm/i915/userptr: Try to acquire the page lock around set_page_dirty(=
)
      drm/i915: Protect request peeking with RCU
      drm/i915/fbdev: Restore physical addresses for fb_mmap()

Dave Airlie (2):
      Merge tag 'drm-fixes-5.4-2019-11-20' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2019-11-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (2):
      drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on unsupported AS=
ICs
      drm/amd/powerplay: correct fine grained dpm force level setting

Matthew Auld (1):
      drm/i915: make pool objects read-only

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Don't oops in dumb_create ioctl if we have no crtcs
      drm/i915: Preload LUTs if the hw isn't currently using them

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  6 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  9 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 23 ++++++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  6 +++
 drivers/gpu/drm/i915/display/intel_atomic.c        |  1 +
 drivers/gpu/drm/i915/display/intel_color.c         | 61 ++++++++++++++++++=
++++
 drivers/gpu/drm/i915/display/intel_display.c       |  9 ++++
 drivers/gpu/drm/i915/display/intel_display_types.h |  1 +
 drivers/gpu/drm/i915/display/intel_fbdev.c         |  9 ++--
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        | 22 +++++++-
 drivers/gpu/drm/i915/gt/intel_engine_pool.c        |  2 +
 drivers/gpu/drm/i915/i915_pmu.c                    |  4 +-
 drivers/gpu/drm/i915/i915_scheduler.c              | 50 ++++++++++++++----
 16 files changed, 183 insertions(+), 32 deletions(-)
