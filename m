Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15946C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23C52087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCLCXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:23:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCLCXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:23:07 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9719:798c:6bb0:a97a:4a09:e6d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0E9D3260933;
        Tue, 12 Mar 2019 02:22:51 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Russell King <rmk+kernel@armlinux.org.uk>, eric@anholt.net,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Leo Li <sunpeng.li@amd.com>, linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        David Francis <David.Francis@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        freedreno@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 0/5] drm: Fix fb changes for async updates
Date:   Mon, 11 Mar 2019 23:21:58 -0300
Message-Id: <20190312022204.2775-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes the slow down in performance introduced by
"[PATCH v2] drm: Block fb changes for async plane updates" where async update
falls back to a sync update, causing igt failures of type:

    "CRITICAL: completed 97 cursor updated in a period of 30 flips, we
    expect to complete approximately 15360 updates, with the threshold set
    at 7680"

Please read the commit message of "drm: don't block fb changes for async
plane updates" to understand how it works.

I tested on the rockchip, on i915 and on vc4 with igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.

I couldn't test on MSM and AMD because I don't have the hardware
I would appreciate if anyone could help me testing those.

v1 link: https://patchwork.kernel.org/cover/10837847/

Thanks!
Helen

Changes in v2:
- added reviewed-by tag
- update CC stable and Fixes tag
- Added reviewed-by tag
- updated CC stable and Fixes tag
- Change the order of the patch in the series, add this as the last one.
- Add documentation
- s/ballanced/balanced

Helen Koike (5):
  drm/rockchip: fix fb references in async update
  drm/amd: fix fb references in async update
  drm/msm: fix fb references in async update
  drm/vc4: fix fb references in async update
  drm: don't block fb changes for async plane updates

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 20 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  4 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 42 +++++++++++--------
 drivers/gpu/drm/vc4/vc4_plane.c               |  2 +-
 include/drm/drm_modeset_helper_vtables.h      |  5 +++
 6 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.20.1

