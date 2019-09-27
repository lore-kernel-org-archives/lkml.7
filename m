Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33FC2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm8lp3is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfI0FTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:19:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37548 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfI0FTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:19:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so1193489lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=r8lBKoBJtqjx4pldSQUNGMPY5GHC/F6IscYKypNYQL8=;
        b=Tm8lp3isjjFbB7jRkT8sqQ/YpH3oj+5MW7Sdfohs6USuwLLlW0JPv0e+aLnCCoAxLr
         Vwns0cxgOGvK7uoQLjR2VRtbsNm8pxqyss4VK3Xap27puKNIwu8y2yIFMb83H7k+8aMf
         sPJfEiD4ucFCiiLrupN6eCywrHFAjmXzVdlCEcHtSvl/MsJICHCPa2TBKjf6VwWwyyLa
         onxha76Xd4JQIcg0Cf68g2rkCliHUHSqR/VrUNYjujXjxIKuTYZpRikjzw1L0wh6LAKP
         MKYvHC/o6jmA0zZ9+NHZhpp8PfqPeUurKCo3KJm3oQ9KrWsQjchB+DM+uvcTswoIoQEs
         vXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=r8lBKoBJtqjx4pldSQUNGMPY5GHC/F6IscYKypNYQL8=;
        b=VSCmnA/pm00mYk9j+j9qvzVmRGwbg4ceXDYprBmm5e5DurKmhQVnBLEjQ0/Biieudx
         315JF9isPkipqNKR780Tgf55pnug/bsxe828mWrGuOtVhPu/FIdlxuCwit7BJ7jtb9ca
         HM3xaDufGl1/9MJdjJdC2TQQC3ne+sVJezkhIVPgzyPPlz9LcgdEWjgbFWkxMe5b6tcO
         /hKPYn66UwnB1jtPo2QYBkixf5uar0IE+6GyHVQN5VrAHe67VE154mpqmErGXJhQuaxr
         yuGOwd5vsOgsHuje4IV7PGyEvEUIioM/RvKu5UIRMaCYWgnGl3i7nUmE6wyxLLygmQOq
         XkLQ==
X-Gm-Message-State: APjAAAWLeBcWWc1YfX5teHvrl1SI34RJbKXktjBsOYBbzgKGjNz2C0AZ
        oj9qyuAzanfbe5wOZmfrh8ce9yn5EvA85PuiSvzZ+Vcs
X-Google-Smtp-Source: APXvYqy5hsuzQsxZJCogBCCuF1PTWvD0iHDMCSuuLibiiNpnTmQlIRZ4u2IFba+kSCEYiZzSUYCd1QKinoVsHq1r0RA=
X-Received: by 2002:a2e:3808:: with SMTP id f8mr1372753lja.7.1569561549022;
 Thu, 26 Sep 2019 22:19:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Sep 2019 15:18:57 +1000
Message-ID: <CAPM=9txTwuNKGpVGEr=GScQV1FKEJUubyM8UorvUVSHEXEJOkw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Fixes built up over the past 1.5 weeks or so, it's two weeks of
amdgpu, some core cleanups and some panfrost fixes. I also finally
figured out why my desktop was slow to do a bunch of stuff (someone
gave it an IPv6 address which can't reach anything!).

Dave.

drm-next-2019-09-27:
drm fixes for 5.4-rc1

core:
- Some cleanups and fixes in the self-refresh helpers
- Some cleanups and fixes in the atomic helpers

amdgpu:
- Fix a 64 bit divide
- Prevent a memory leak in a failure case in dc
- Load proper gfx firmware on navi14 variants
- Add more navi12 and navi14 PCI ids
- Misc fixes for renoir
- Fix bandwidth issues with multiple displays on vega20
- Support for Dali
- Fix a possible oops with KFD on hawaii
- Fix for backlight level after resume on some APUs
- Other misc fixes

panfrost:
- Multiple panfrost fixes for regulator support and page fault handling
The following changes since commit 945b584c94f8c665b2df3834a8a6a8faf256cd5f:

  Merge branch 'linux-5.4' of git://github.com/skeggsb/linux into
drm-next (2019-09-17 16:31:34 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-09-27

for you to fetch changes up to 3e2cb6d89325dc36a03937a2b82fc7eb902c96b0:

  Merge tag 'drm-fixes-5.4-2019-09-25' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2019-09-26
11:59:40 +1000)

----------------------------------------------------------------
drm fixes for 5.4-rc1

core:
- Some cleanups and fixes in the self-refresh helpers
- Some cleanups and fixes in the atomic helpers

amdgpu:
- Fix a 64 bit divide
- Prevent a memory leak in a failure case in dc
- Load proper gfx firmware on navi14 variants
- Add more navi12 and navi14 PCI ids
- Misc fixes for renoir
- Fix bandwidth issues with multiple displays on vega20
- Support for Dali
- Fix a possible oops with KFD on hawaii
- Fix for backlight level after resume on some APUs
- Other misc fixes

panfrost:
- Multiple panfrost fixes for regulator support and page fault handling

----------------------------------------------------------------
Aaron Liu (3):
      drm/amdgpu: disable stutter mode for renoir
      drm/amd/display: update renoir_ip_offset.h
      drm/amdgpu: remove program of lbpw for renoir

Alex Deucher (3):
      drm/amdgpu: flag navi12 and 14 as experimental for 5.4
      drm/amdgpu/display: fix 64 bit divide
      drm/amdgpu/display: include slab.h in dcn21_resource.c

Andrey Grodzovsky (2):
      drm/amdgpu: Add smu lock around in pp_smu_i2c_bus_access
      drm/amdgpu: Remove clock gating restore.

Bhawanpreet Lakha (2):
      drm/amd/display: add Asic ID for Dali
      drm/amd/display: Implement voltage limitation for dali

Charlene Liu (1):
      drm/amd/display: dce11.x /dce12 update formula input

Daniel Vetter (4):
      drm/kms: Duct-tape for mode object lifetime checks
      drm/atomic: Take the atomic toys away from X
      drm/atomic: Reject FLIP_ASYNC unconditionally
      drm/atomic: Rename crtc_state->pageflip_flags to async_flip

Dave Airlie (2):
      Merge tag 'drm-misc-next-fixes-2019-09-23' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-fixes-5.4-2019-09-25' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Felix Kuehling (1):
      drm/amdgpu: Fix KFD-related kernel oops on Hawaii

Hans de Goede (1):
      drm/radeon: Bail earlier when radeon.cik_/si_support=0 is passed

Jay Cornwall (1):
      drm/amdkfd: Swap trap temporary registers in gfx10 trap handler

Kai-Heng Feng (1):
      drm/amd/display: Restore backlight brightness after system resume

Mark Brown (1):
      drm/panfrost: Fix regulator_get_optional() misuse

Navid Emamdoost (1):
      drm/amd/display: prevent memory leak

Prike Liang (2):
      drm/amd/amdgpu: power up sdma engine when S3 resume back
      drm/amd/powerplay: implement sysfs for getting dpm clock

Rob Clark (1):
      Revert "drm/bridge: adv7511: Attach to DSI host at probe time"

Roman Li (1):
      drm/amd/display: Add stereo mux and dig programming calls for dcn21

Sean Paul (2):
      drm: Fix kerneldoc and remove unused struct member in self_refresh helper
      drm: Measure Self Refresh Entry/Exit times to avoid thrashing

Steven Price (2):
      drm/panfrost: Remove NULL checks for regulator
      drm/panfrost: Prevent race when handling page fault

Tianci.Yin (3):
      drm/amdgpu: add navi14 PCI ID for work station SKU
      drm/amdgpu: add navi12 pci id
      drm/amdgpu/gfx10: add support for wks firmware loading

Trek (1):
      drm/amdgpu: Check for valid number of registers to read

Zhan Liu (1):
      drm/amd/display: Add missing HBM support and raise Vega20's uclk.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 22 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             | 10 +--
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 10 ++-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |  6 +-
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm | 10 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  8 ++-
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c   |  4 ++
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 27 ++++++--
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c |  4 +-
 .../drm/amd/display/dc/dce100/dce100_resource.c    |  1 +
 .../drm/amd/display/dc/dce110/dce110_resource.c    |  1 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    | 17 +++--
 .../drm/amd/display/dc/dce120/dce120_resource.c    | 12 +++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  2 +
 .../amd/display/dc/gpio/dcn21/hw_factory_dcn21.c   | 38 ++++++++++-
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c |  3 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |  2 +
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |  7 ++-
 drivers/gpu/drm/amd/include/renoir_ip_offset.h     |  2 +-
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  7 ++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         |  3 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 70 +++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h         | 25 ++++++++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       | 12 +---
 drivers/gpu/drm/drm_atomic_helper.c                | 22 ++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c          |  2 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  |  3 +-
 drivers/gpu/drm/drm_drv.c                          |  4 +-
 drivers/gpu/drm/drm_ioctl.c                        |  7 ++-
 drivers/gpu/drm/drm_mode_object.c                  |  4 +-
 drivers/gpu/drm/drm_self_refresh_helper.c          | 73 +++++++++++++++++++---
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  4 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        | 10 ++-
 drivers/gpu/drm/panfrost/panfrost_device.c         |  8 +--
 drivers/gpu/drm/panfrost/panfrost_mmu.c            | 55 ++++++++++------
 drivers/gpu/drm/radeon/radeon_drv.c                | 31 +++++++++
 drivers/gpu/drm/radeon/radeon_kms.c                | 25 --------
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  5 +-
 include/drm/drm_crtc.h                             | 10 +--
 include/drm/drm_self_refresh_helper.h              |  6 +-
 46 files changed, 444 insertions(+), 146 deletions(-)
