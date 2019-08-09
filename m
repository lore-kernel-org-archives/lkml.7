Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD926C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE8217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chum987Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405638AbfHIGan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:30:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46429 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405510AbfHIGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:30:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so277466lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 23:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mLNLvsMNd5hZfz3AvWEuXX3/4mciucSpeiAVx2FfSSM=;
        b=Chum987QEniQ3NEVSqlTuKJstbfFlkhJxhNWa5tRdHXwmaUX+oBUCxvXk9nemaeGmc
         whlUof/rE2cHxqg2jmTVv7t0pCSLx0RT+5+IKkZw5NDhKRcG51ymTW2AsBlxpiUThP4N
         CiUxa5lKXiPqhyZLHogRa9EK92Fvlt1mE8Ds2cIiB67rFHKJl9726YBZWMoCqC6z5XQS
         oydW3OO/Sl55bWuGala3uH7UujJvf0aBJi1lJUjMzI0FY+A0d7qnwRLGhm7jBUXu8tMj
         I34JIk1DV7dGXipTgXvi2g7HnzWS57+MvuMS2Yu0mVahtbDOhRgXYRyGjaSZzvPTymvR
         06BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mLNLvsMNd5hZfz3AvWEuXX3/4mciucSpeiAVx2FfSSM=;
        b=llGMt7Ym0MFM1VLXhgO2g76ebaFOn9jN8qTBWD58V3EcFcFP1bkwyB2rSYw9xF+Ulh
         9llnkeOAVWAQlEiMFA86S/wpmFX2BC/UIsooZBseyC/Tq3EbLDDChIO69YnivmhUrLSu
         jeOmxk99hZSAYa3JGKOfzMiB5q/tQl/mtq61zJrWca6XoWh2X5/gAapIMeve6KoNewq+
         Ifl6y4YEp73V3djrJXvL/QTvV3nKdQVZm67YDzzAOPoCmFc4kdQUJmloFXfBorRPQTZq
         E2o3AuQbeDYy0sSYtbcyJY/ZrOApdTMSE49+tYUGOeSQo3ovLKYoOiQPcyuBEYUx5I8y
         Ttgw==
X-Gm-Message-State: APjAAAXB9rwyJICSKjLRXHfJgYBRfx41VhynmQca2m5nL79itTgxLESD
        5ivh4CQaMMCk9zYPy8c71RLiddUYh96DFfZyb5JsTK0W
X-Google-Smtp-Source: APXvYqzOoTfW7BQn5i881qWqR4A7xUBWAQT3fYXHgvSmf5b5VCvArBbu1qrpKAf97nDpR04u2tWU8gxQrLs6snuF2Jk=
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr11767580lfq.134.1565332240143;
 Thu, 08 Aug 2019 23:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 9 Aug 2019 16:30:28 +1000
Message-ID: <CAPM=9tyN19sYgfkDqdegE7YV+GmNj5uOb2PjGM7bPriONMBDUA@mail.gmail.com>
Subject: drm fixes for 5.3-rc4
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

Usual fixes roundup, summary below in the signed tag. Nothing too
crazy or serious, one non-released ioctl is removed in the amdkfd
driver.

Dave.

drm-fixes-2019-08-09:
drm fixes for 5.3-rc4

core:
- mode parser strncpy fix

i915:
- GLK DSI escape clock setting
- HDCP memleak fix

tegra:
- one gpiod/of regression fix

amdgpu:
- Fixes VCN to handle the latest navi10 firmware
- Fixes for fan control on navi10
- Properly handle SMU metrics table on navi10
- Fix a resume regression on Stoney
- kfd revert a GWS ioctl

vmwgfx:
- memory leak fix

rockchip:
- suspend fix
The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d=
:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-09

for you to fetch changes up to a111ef6b082270f6cbeea5556caf1cbb0143b812:

  Merge tag 'drm-intel-fixes-2019-08-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2019-08-09
15:46:10 +1000)

----------------------------------------------------------------
drm fixes for 5.3-rc4

core:
- mode parser strncpy fix

i915:
- GLK DSI escape clock setting
- HDCP memleak fix

tegra:
- one gpiod/of regression fix

amdgpu:
- Fixes VCN to handle the latest navi10 firmware
- Fixes for fan control on navi10
- Properly handle SMU metrics table on navi10
- Fix a resume regression on Stoney
- kfd revert a GWS ioctl

vmwgfx:
- memory leak fix

rockchip:
- suspend fix

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdkfd: New IOCTL to allocate queue GWS"

Chuhong Yuan (1):
      drm/modes: Fix unterminated strncpy

Colin Ian King (1):
      drm/vmwgfx: fix memory leak when too many retries have occurred

Dave Airlie (5):
      Merge tag 'drm/tegra/for-5.3-rc4' of
git://anongit.freedesktop.org/tegra/linux into drm-fixes
      Merge tag 'drm-fixes-5.3-2019-08-07' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge branch 'vmwgfx-fixes-5.3' of
git://people.freedesktop.org/~thomash/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2019-08-08' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2019-08-08' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dmitry Osipenko (1):
      drm/tegra: Fix gpiod_get_from_of_node() regression

Douglas Anderson (1):
      drm/rockchip: Suspend DP late

Evan Quan (1):
      drm/amd/powerplay: correct navi10 vcn powergate

Kevin Wang (1):
      drm/amd/powerplay: honor hw limit on fetching metrics data for navi10

Likun Gao (1):
      drm/amdgpu: pin the csb buffer on hw init for gfx v8

Marek Ol=C5=A1=C3=A1k (1):
      Revert "drm/amdgpu: fix transform feedback GDS hang on gfx10 (v2)"

Matt Coffin (1):
      drm/amd/powerplay: Allow changing of fan_control in smu_v11_0

Stanislav Lisovskiy (1):
      drm/i915: Fix wrong escape clock divisor init for GLK

Thong Thai (2):
      drm/amd/amdgpu/vcn_v2_0: Mark RB commands as KMD commands
      drm/amd/amdgpu/vcn_v2_0: Move VCN 2.0 specific dec ring test to vcn_v=
2_0

Wei Yongjun (1):
      drm/i915: fix possible memory leak in intel_hdcp_auth_downstream()

 drivers/gpu/drm/amd/amdgpu/amdgpu_gds.h         |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c          | 12 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           | 40 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c           | 44 +++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 28 ---------
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c      |  4 +-
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h  |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c      | 79 +++++++++++++++++----=
----
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c       |  2 +-
 drivers/gpu/drm/drm_modes.c                     |  4 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c       |  3 +-
 drivers/gpu/drm/i915/display/vlv_dsi_pll.c      |  4 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  2 +-
 drivers/gpu/drm/tegra/output.c                  |  8 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c             |  4 +-
 include/uapi/linux/kfd_ioctl.h                  | 20 +------
 17 files changed, 155 insertions(+), 102 deletions(-)
