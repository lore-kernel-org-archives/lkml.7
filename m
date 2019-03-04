Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA38FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9867420815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfCDOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCDOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:49:24 -0500
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a1b1:9d17:4c45:79a4:9c61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 86EEA2822B8;
        Mon,  4 Mar 2019 14:49:18 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH 0/5] drm: Fix fb changes for async updates
Date:   Mon,  4 Mar 2019 11:49:04 -0300
Message-Id: <20190304144909.6267-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is a first attempt to fix the slow down in performance introduced by
"[PATCH v2] drm: Block fb changes for async plane updates" where async update
falls back to a sync update, causing igt failures of type:

    "CRITICAL: completed 97 cursor updated in a period of 30 flips, we
    expect to complete approximately 15360 updates, with the threshold set
    at 7680"

Please read the commit message of the first patch to understand how it works.

I tested on the rockchip and on i915 (with a patch I am still working on for
replacing cursors by async update), with igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.
I couldn't test on MSM and AMD because I don't have the hardware and my vc4
raspberry pi is not recognizing my display for some reason, I would appreciate
if anyone could help me testing those.
I also separated the patches per platform to be easier to get the tested-by tags,
please let me know if it should be a single patch.

Also, I added CC stable (as the "drm: Block fb changes for async plane updates"
was also CCed to stable).
I am not used to CC stable, please let me know if anything is off.

Thanks!
Helen


Helen Koike (5):
  drm: don't block fb changes for async plane updates
  drm/rockchip: fix fb references in async update
  drm/amd: fix fb references in async update
  drm/msm: fix fb references in async update
  drm/vc4: fix fb references in async update

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 20 ++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  4 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 42 +++++++++++--------
 drivers/gpu/drm/vc4/vc4_plane.c               |  2 +-
 5 files changed, 40 insertions(+), 31 deletions(-)

-- 
2.20.1

