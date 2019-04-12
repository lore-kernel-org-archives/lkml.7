Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F0FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ECE20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDLM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:58:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:58:55 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C0DC9281156;
        Fri, 12 Apr 2019 13:58:42 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, boris.brezillon@collabora.com,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        nicholas.kazlauskas@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Eric Anholt <eric@anholt.net>, Leo Li <sunpeng.li@amd.com>,
        linux-arm-msm@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        David Francis <David.Francis@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 0/4] async vs amend - UAPI
Date:   Fri, 12 Apr 2019 09:58:23 -0300
Message-Id: <20190412125827.5877-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch series is an attempt to clarify some concepts and how things
are hooked inside drm.

There are two main concepts that are similar but different and are
causing some confusion:

    - Asynchronous update: is the ability change the hw state at any time, not
    only during vblank.

    - Amend update: is the ability to perform 1000 commits to be applied as soon
    as possible without waiting for 1000 vblanks.

async updates can be seen as amend, but the opposite is not true.
Please see documentation on the commit
	"drm/atomic: rename async_{update,check} to amend_{update,check}"
for a more detailed explanation.

To perform an async update, we already have the DRM_MODE_PAGE_FLIP_ASYNC
flag in the atomic API and it is already being used by amdgpu in the
atomic path.

The first two commits clarifies these differences. The last two are
RFCs that exposes new async and amend features to userspace.

We introduce in this series the flag DRM_MODE_ATOMIC_AMEND to expose
the amend feature to userspace.
The main reasons to expose this through atomic api is to avoid mixing legacy
with modern/atomic API (since their interactions are not well defined)
and to be able to explicitly manage the cursor plane.

And the last commit hooks the current async implementations with the
DRM_MODE_PAGE_FLIP_ASYNC flag.

Please, see the message in each commit and the documentation that was
added for more details and let me know what you think.

Thanks
Helen

Changes in v3:
- rebase tree
- rebase on top of renaming async_update to amend_update
- improve documentation
- don't fall back to a normal commit if amend is not possible when
requested through the atomic api

Changes in v2:
- rebase tree
- do not fall back to a non-async update if if there isn't any
pending commit to amend

Changes in v1:
- https://patchwork.freedesktop.org/patch/243088/
- Only enable it if userspace requests it.
- Only allow async update for cursor type planes.
- Rename ASYNC_UPDATE for ATOMIC_AMEND.

Helen Koike (4):
  drm/uapi: add documentation for atomic flags
  drm/atomic: rename async_{update,check} to amend_{update,check}
  drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
  drm/atomic: hook atomic_async_{check,update} with PAGE_FLIP_ASYNC flag

 Documentation/gpu/drm-kms-helpers.rst         |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 157 ++++++++++++++----
 drivers/gpu/drm/drm_atomic_uapi.c             |   9 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |   6 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  12 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |   4 +-
 drivers/gpu/drm/vc4/vc4_plane.c               |   6 +
 include/drm/drm_atomic.h                      |   4 +-
 include/drm/drm_atomic_helper.h               |   9 +-
 include/drm/drm_modeset_helper_vtables.h      |  69 ++++++--
 include/uapi/drm/drm_mode.h                   |  27 ++-
 12 files changed, 264 insertions(+), 62 deletions(-)

-- 
2.20.1

