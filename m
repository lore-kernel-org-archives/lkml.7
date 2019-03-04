Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5013A20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfCDOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCDOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:49:38 -0500
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a1b1:9d17:4c45:79a4:9c61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8DC2C2807B0;
        Mon,  4 Mar 2019 14:49:32 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH 3/5] drm/amd: fix fb references in async update
Date:   Mon,  4 Mar 2019 11:49:07 -0300
Message-Id: <20190304144909.6267-4-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304144909.6267-1-helen.koike@collabora.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Async update callbacks are expected to set the old_fb in the new_state
so prepare/cleanup framebuffers are balanced.

Calling drm_atomic_set_fb_for_plane() (which gets a reference of the new
fb and put the old fb) is not required, as it's taken care by
drm_mode_cursor_universal() when calling drm_atomic_helper_update_plane().

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

As mentioned in the cover letter,
I tested on the rockchip and on i915 using igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.
But I couldn't test on AMD because I don't have the hardware and I would
appreciate if anyone could test it.

Also, I didn't CC to stable here as I saw the async_update function was only
added on v4.20, please let me know if I should CC to stable.

Thanks!
Helen

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3a6f595f295e..bc02800254bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3760,8 +3760,7 @@ static void dm_plane_atomic_async_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(new_state->state, plane);
 
-	if (plane->state->fb != new_state->fb)
-		drm_atomic_set_fb_for_plane(plane->state, new_state->fb);
+	swap(plane->state->fb, new_state->fb);
 
 	plane->state->src_x = new_state->src_x;
 	plane->state->src_y = new_state->src_y;
-- 
2.20.1

