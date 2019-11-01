Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53162CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188AA20663
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYopaUsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfKAFWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 01:22:03 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:32997 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKAFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:22:03 -0400
Received: by mail-lj1-f172.google.com with SMTP id t5so9039536ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QZf3EYixaJvougAQB2iFvKjlzd4ufigjPNZKaDKtVHE=;
        b=UYopaUsPgl7T6prQZf5HpgYJnllHNvacD2EJbz6Yqlw9la+pxsnH8qc5yws6f6sHCi
         FASvhTypXe0F1s5GqzU7XyTyFfAR67H9uGuDXjIC4PPGDSEjXT/HAG9UuegFeeVP0v8b
         W77DM0Rg5Q1ARYFscGmtolXtYYPO7yDOmB6nOG8i9d/Jc1oNGHG0/qW2jbLeyt4kPRKq
         CtrVrB+FOEfxncdKTmJ+QTrAeiNdTWefrbPSw3x9PRW9N26Tzsk/+/Coa/bFX70nMc9W
         Ax3emQE3v39emHoUrJITtoLCdjjWGYTUdD97twGPZHXXlXCY3sqnZLcG10gowzvkR1i4
         zUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QZf3EYixaJvougAQB2iFvKjlzd4ufigjPNZKaDKtVHE=;
        b=CpzIciTHfCrRMMQUYvIpMNgwYe+A4fgLjWZ+OE/IlFV35BiSfkfyW/0sKuXwzSl2kS
         WvzRcS9ps5z+NVzDvrY2u0QaJJ3yC/U4b7+SyMxmOASx7+TfJRexj3WPIdECQId2f5/i
         KW0ow6NcKy8sMxZD8e4MF0ONiMKJVQTu+ABctKqQmwvZ4Pl5vOJMJG08BfpQnEplFcCj
         kzWdfXttrhKKPYrJGHPJgSLC2ktVjso6af3QAImaYkMiSx3XjE7UmmRjNWiHDuYSWFGC
         kGGJD72gs81wsj59xAS/mcJsqWh5LxA4yLirFcsk5NA7UidWXgqJ0YKmNbFR2G3wMoe9
         jGpg==
X-Gm-Message-State: APjAAAUeDrCQupjmDyWbJZtYUfA7LO8V2eItJxgOdfdn0X23w7rzEd/e
        BpIZm50zrzXSUxmouXvVgnEvTuWBIDHkjocZMeVNV7qn
X-Google-Smtp-Source: APXvYqyh7HMRx3nnUiJ1DDD/9cwGmWkCd20/y7rYN1XxCB5KEeHEs8GmEcKcDLV877pMuIryusCBqsg8lNibLfhC2p4=
X-Received: by 2002:a2e:88cf:: with SMTP id a15mr3031348ljk.130.1572585720829;
 Thu, 31 Oct 2019 22:22:00 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 1 Nov 2019 15:21:49 +1000
Message-ID: <CAPM=9tx7omDCD2SmOaX9H1mO8=bDZWHw8aTJbp57bGQubYaHtQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc6
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

This is the regular drm fixes pull request for 5.4-rc6. It's a bit
larger than I'd like but then last week was quieter than usual.

The main fixes are amdgpu, and the two bigger area are navi fixes
which are the newest GPU range so still getting actively fixed up, but
also a bunch of clang stack alignment fixes (as amdgpu uses double in
some places). Otherwise it's all fairly run of the mill fixes, i915,
panfrost, etnaviv, v3d and radeon, along with a core scheduler fix.

Dave.

drm-fixes-2019-11-01:
drm fixes for 5.4-rc6

amdgpu:
- clang alignment fixes
- Updated golden settings
- navi: gpuvm, sdma and display fixes
- Freesync fix
- Gamma fix for DCN
- DP dongle detection fix
- vega10: Fix for undervolting

radeon:
- reenable kexec fix for ppc

scheduler:
- set an error if hw job failed

i915:
- fix PCH reference clock for HSW/BDW
- TGL display PLL doc fix

panfrost:
- warning fix
- runtime pm fix
- bad pointer dereference fix

v3d:
- memleak fix

etnaviv:
- memory corruption fix
- deadlock fix
- reintroduce lost debug message
The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02=
:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-01

for you to fetch changes up to e54de91a24753da713b9bcf9fcd93eec246e45e7:

  Merge tag 'drm-fixes-5.4-2019-10-30' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2019-11-01
11:27:39 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc6

amdgpu:
- clang alignment fixes
- Updated golden settings
- navi: gpuvm, sdma and display fixes
- Freesync fix
- Gamma fix for DCN
- DP dongle detection fix
- vega10: Fix for undervolting

radeon:
- reenable kexec fix for ppc

scheduler:
- set an error if hw job failed

i915:
- fix PCH reference clock for HSW/BDW
- TGL display PLL doc fix

panfrost:
- warning fix
- runtime pm fix
- bad pointer dereference fix

v3d:
- memleak fix

etnaviv:
- memory corruption fix
- deadlock fix
- reintroduce lost debug message

----------------------------------------------------------------
Aidan Yang (1):
      drm/amd/display: Allow inverted gamma

Alex Deucher (1):
      drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE

Andrey Grodzovsky (2):
      drm/sched: Set error to s_fence if HW job submission failed.
      drm/amdgpu: If amdgpu_ib_schedule fails return back the error.

Anna Karas (1):
      drm/i915/tgl: Fix doc not corresponding to code

Christian Gmeiner (1):
      drm/etnaviv: fix dumping of iommuv2

Dave Airlie (4):
      Merge branch 'etnaviv/fixes' of
https://git.pengutronix.de/git/lst/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-10-30-1' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-10-31' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-fixes-5.4-2019-10-30' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Jun Lei (2):
      drm/amd/display: do not synchronize "drr" displays
      drm/amd/display: add 50us buffer as WA for pstate switch in active

Kyle Mahlkuch (1):
      drm/radeon: Fix EEH during kexec

Lucas Stach (2):
      drm/etnaviv: fix deadlock in GPU coredump
      drm/etnaviv: reinstate MMUv1 command buffer window check

Michael Strauss (1):
      drm/amd/display: Passive DP->HDMI dongle detection fix

Navid Emamdoost (1):
      drm/v3d: Fix memory leak in v3d_submit_cl_ioctl

Nick Desaulniers (3):
      drm/amdgpu: fix stack alignment ABI mismatch for Clang
      drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
      drm/amdgpu: enable -msse2 for GCC 7.1+ users

Pelle van Gils (1):
      drm/amdgpu/powerplay/vega10: allow undervolting in p7

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)

Robin Murphy (1):
      drm/panfrost: Don't dereference bogus MMU pointers

Tianci.Yin (3):
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings for navi12

Tomeu Vizoso (1):
      panfrost: Properly undo pm_runtime_enable when deferring a probe

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix PCH reference clock for FDI on HSW/BDW

Yi Wang (1):
      drm/panfrost: fix -Wmissing-prototypes warnings

Zhan liu (2):
      drm/amd/display: Change Navi14's DWB flag to 1
      drm/amd/display: setting the DIG_MODE to the correct value.

chen gong (1):
      drm/amdgpu: Fix SDMA hang when performing VKexample test

zhongshiqi (1):
      dc.c:use kzalloc without test

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |  9 ++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |  9 ++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  1 +
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      | 19 ++++++++++-------
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  4 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  9 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  | 24 ++++++++++++++++--=
----
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  6 ++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 22 ++++++++----------=
--
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile      | 19 ++++++++++-------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile      | 19 ++++++++++-------
 drivers/gpu/drm/amd/display/dc/dml/Makefile        | 19 ++++++++++-------
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile        | 19 ++++++++++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  4 +---
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |  4 ++--
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |  6 ++++--
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              | 17 ++++++++++++---
 drivers/gpu/drm/i915/display/intel_display.c       | 11 +++++-----
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      | 15 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |  4 ++--
 drivers/gpu/drm/i915/i915_drv.h                    |  2 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c            |  2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            | 15 +++++++-------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        |  1 +
 drivers/gpu/drm/radeon/radeon_drv.c                | 14 +++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c             | 19 ++++++++++++++---
 drivers/gpu/drm/v3d/v3d_gem.c                      |  5 ++++-
 32 files changed, 224 insertions(+), 90 deletions(-)
