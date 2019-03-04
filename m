Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1238C20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCDOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49346 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCDOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:49:47 -0500
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a1b1:9d17:4c45:79a4:9c61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 585DD2807B1;
        Mon,  4 Mar 2019 14:49:42 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH 5/5] drm/vc4: fix fb references in async update
Date:   Mon,  4 Mar 2019 11:49:09 -0300
Message-Id: <20190304144909.6267-6-helen.koike@collabora.com>
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

Cc: <stable@vger.kernel.org> # v4.19+: 25dc194b34dd: drm: Block fb changes for async plane updates
Cc: <stable@vger.kernel.org> # v4.19+: 8105bbaf9afd: drm: don't block fb changes for async plane updates
Fixes: 25dc194b34dd ("drm: Block fb changes for async plane updates")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

As mentioned in the cover letter,
I tested on the rockchip and on i915 using igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.
But I couldn't test on VC4. I have a Raspberry pi model B rev2, when
FB_SIMPLE is running I can see output on the screen, but when vc4 is
loaded my hdmi display is not detected anymore, I am still debugging
this, probably some config in the firmware, but I would appreciate if
anyone could help me testing it.

Also the Cc statble commit hash dependency needs to be updated once the
refered commit is merged.

Thanks!
Helen

 drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 1babfeca0c92..1235e53b22a3 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -968,7 +968,7 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
 {
 	struct vc4_plane_state *vc4_state, *new_vc4_state;
 
-	drm_atomic_set_fb_for_plane(plane->state, state->fb);
+	swap(plane->state->fb, state->fb);
 	plane->state->crtc_x = state->crtc_x;
 	plane->state->crtc_y = state->crtc_y;
 	plane->state->crtc_w = state->crtc_w;
-- 
2.20.1

