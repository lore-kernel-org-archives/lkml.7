Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C709F217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O39lymGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCOAfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:35:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34814 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCOAfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:35:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so8351763qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BwmR0YmFzxm3NfJys0OIa9ODO+C9Emn4YKlYCnNoSkA=;
        b=O39lymGCfLq3lolq/SicSvecBpBlSZGEGkYNkP4HyQ7XGlIlXMRv0pDBmsTPghwVEu
         tS1jg4myFp3dXFjdPFKIJ7vEasJog2QYsgfUAU9YQylNO5A36aC1OttUSGc+xgoGvcYH
         7hY8Gl8WbjlYFWMyQx+hNoFgcvxx37nVlhsp1N33HlaOt89M7yCM09fJZXnRTHUSzneH
         k11PMX3mXhedVT78xhNCxD41lHBvLXlAv5d4XoJvfASlBpdY0I2FAHr9igvHw3CHnGWe
         O0SUTqnI4Ci5MzcUOgjHitlaY8edtIVwMrEy/gz9n/+TUWBXqd8ypexP+hzWvvjhme5p
         eiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=BwmR0YmFzxm3NfJys0OIa9ODO+C9Emn4YKlYCnNoSkA=;
        b=CJPUqV7ifVJBACUpRYWHacHwV9U+Tom4ABy/qVfHJ/FpldmznD+N5lyRZQVIzOy5G8
         Xw+0/jmEFYPXUHI4mrd89i0a3ZQb0TIHqeMgRFyAWYoWf0yLXnj/keoofm18AuR+sxOZ
         XRcVZfQaMxRbC7B40qYRDkn+okpZ5mtMKpn14JXdyCMNuPlVUteofdJZf8Jn/tXYj+Dz
         YElWGbJEO+AIyXby/AzHqF9r5tzLOM9XlyqqhLoCSvchxbNPDfFBEuE4pPg1/rkxyRed
         kV9pjanzDf98Zo6rT3iALPR/e7XBo4blKbkuIDII/bNecOj363AoDUFTm4CYCWlu5F42
         lTdw==
X-Gm-Message-State: APjAAAVE4YTBkqMswY0swmNPngwDKWQ1U0iAIvBKMENt3Jq7Jgx7W9a4
        r9lVMysZ4QFeL3HNLjGkj4D+xRpND04T+Z9V84/ETZxW
X-Google-Smtp-Source: APXvYqxzuIqLIXqL3C0Gc8jMTslJp/P59WpMbtDVdtJ3ven0LJXPEfAEu07C7YoPXQMMjKnv0MEKODkO7H4NiW6SoJE=
X-Received: by 2002:ac8:170e:: with SMTP id w14mr732886qtj.356.1552610130584;
 Thu, 14 Mar 2019 17:35:30 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Mar 2019 10:35:19 +1000
Message-ID: <CAPM=9tykVGf4Y215gPygj==9wW0Bri7BADN6y9oPxcr6aS7M1g@mail.gmail.com>
Subject: [git pull] drm fixes for 5.1-rc1
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

A few various fixes pulls and one late -next pull but it was nearly
all fixes anyways.

etnaviv:
- late next pull
- mmu mapping fix
- build non-ARM arches
- misc fixes

i915:
- HDCP state handling fix
- shrinker interaction fix
- atomic state leak fix

qxl:
- kick out framebuffers early fix

amdgpu:
- Powerplay fixes
- DC fixes
- BACO turned off for now on vega20
- Locking fix
- KFD MQD fix
- gfx9 golden register updates.

Dave.

drm-next-2019-03-15:
drm i915, amdgpu, qxl and etnaviv fixes
The following changes since commit 4b057e73f28f1df13b77b77a52094238ffdf8abd=
:

  Merge tag 'drm-misc-fixes-2019-02-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2019-03-05
08:14:22 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-03-15

for you to fetch changes up to 0f1d37e65a59e9db33ab85f6e2c9784768ef80f4:

  Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2019-03-14
12:15:02 +1000)

----------------------------------------------------------------
drm i915, amdgpu, qxl and etnaviv fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/powerplay: add missing breaks in polaris10_smumgr

Anthony Koo (1):
      drm/amd/display: Fix issue with link_active state not correct for MST

Ben Dooks (1):
      drm: add __user attribute to ptr_to_compat()

Candice Li (1):
      Revert "drm/amdgpu: use BACO reset on vega20 if platform support"

Chris Wilson (4):
      drm/i915: Protect i915_active iterators from the shrinker
      drm/i915: Reacquire priolist cache after dropping the engine lock
      drm/i915/selftests: Always free spinner on __sseu_prepare error
      drm/i915: Acquire breadcrumb ref before cancelling

Christian K=C3=B6nig (1):
      drm/amdgpu: clear PDs/PTs only after initializing them

Dan Carpenter (3):
      drm/etnaviv: fix some off by one bugs
      drm/etnaviv: NULL vs IS_ERR() buf in etnaviv_core_dump()
      drm/etnaviv: potential NULL dereference

Dave Airlie (6):
      Merge tag 'drm-misc-next-fixes-2019-03-06' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge branch 'etnaviv/next' of
https://git.pengutronix.de/git/lst/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2019-03-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-fixes-2019-03-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'drm-next-5.1' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Evan Quan (11):
      drm/amd/powerplay: fix the confusing ppfeature mask calculations
      drm/amd/powerplay: drop redundant soft min/max settings
      drm/amd/powerplay: need to reapply the dpm level settings
      drm/amd/powerplay: force FCLK to highest also for 5K or higher displa=
ys
      drm/amd/powerplay: overwrite ODSettingsMin for UCLK_FMAX feature
      drm/amd/powerplay: support retrieving clock information from other sy=
splls
      drm/amd/powerplay: set default fclk for no fclk dpm support case
      drm/amd/powerplay: honor the OD settings
      drm/amd/powerplay: show the right override pcie parameters
      drm/amd/powerplay: set max fan target temperature as 105C
      drm/amd/powerplay: correct power reading on fiji

Gerd Hoffmann (3):
      drm: move i915_kick_out_vgacon to vgaarb
      drm/fb-helper: call vga_remove_vgacon automatically.
      drm/qxl: remove conflicting framebuffers earlier

Harry Wentland (1):
      drm/amd/display: don't call dm_pp_ function from an fpu block

Huang Rui (2):
      drm/amd/powerplay: use REG32_PCIE wrapper instead for powerplay
      drm/amdgpu: use REG32_PCIE wrapper instead for psp

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Fix atomic state leak when resetting HDMI link

Kevin Wang (1):
      drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)

Lucas Stach (3):
      drm/etnaviv: move job context pointer to etnaviv_gem_submit
      drm/etnaviv: don't restrict to certain architectures
      drm/etnaviv: mmuv2: don't map zero page

Mathias Fr=C3=B6hlich (1):
      drm/amd/display: Fix reference counting for struct dc_sink.

Matthew Wilcox (2):
      etnaviv mailing list is moderated
      Build etnaviv on non-ARM architectures

Nathan Chancellor (1):
      drm/amd/display: Pass app_tf by value rather than by reference

Ramalingam C (1):
      drm/i915: HDCP state handling in ddi_update_pipe

Sean Paul (1):
      drm: Merge __drm_atomic_helper_disable_all() into
drm_atomic_helper_disable_all()

Tvrtko Ursulin (1):
      drm/i915: Relax mmap VMA check

shaoyunl (2):
      drm/powerplay: print current clock level when dpm is disabled on vg20
      drm/amdgpu: Update gc golden setting for vega family

 MAINTAINERS                                        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   1 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |  52 +----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  43 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   1 +
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  16 +-
 .../drm/amd/display/modules/freesync/freesync.c    |   7 +-
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |   2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   3 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.c |  30 +--
 drivers/gpu/drm/amd/powerplay/hwmgr/ppatomfwctrl.h |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |   6 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |   8 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 222 +++++++++++------=
----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h |   7 +
 .../amd/powerplay/hwmgr/vega20_processpptables.c   |  17 ++
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   2 +
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c |   6 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   |   6 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  59 +++---
 drivers/gpu/drm/drm_ioc32.c                        |   6 +-
 drivers/gpu/drm/etnaviv/Kconfig                    |   1 -
 drivers/gpu/drm/etnaviv/etnaviv_cmdbuf.h           |   2 -
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.h              |   1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c         |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_perfmon.c          |   6 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |   2 +-
 drivers/gpu/drm/i915/i915_active.c                 |  36 +++-
 drivers/gpu/drm/i915/i915_drv.c                    |  35 +---
 drivers/gpu/drm/i915/i915_gem.c                    |   3 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |  27 ++-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |  18 +-
 drivers/gpu/drm/i915/intel_ddi.c                   |  14 +-
 drivers/gpu/drm/i915/selftests/i915_gem_context.c  |  69 ++++---
 drivers/gpu/drm/qxl/qxl_drv.c                      |   5 +-
 drivers/gpu/vga/vgaarb.c                           |  49 +++++
 include/drm/drm_fb_helper.h                        |  14 +-
 include/linux/vgaarb.h                             |   2 +
 46 files changed, 449 insertions(+), 373 deletions(-)
