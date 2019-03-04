Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B29C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0BC20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfCDOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49334 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCDOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:49:43 -0500
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a1b1:9d17:4c45:79a4:9c61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C37A328079A;
        Mon,  4 Mar 2019 14:49:36 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>
Subject: [PATCH 4/5] drm/msm: fix fb references in async update
Date:   Mon,  4 Mar 2019 11:49:08 -0300
Message-Id: <20190304144909.6267-5-helen.koike@collabora.com>
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

Cc: <stable@vger.kernel.org> # v4.14+: 25dc194b34dd: drm: Block fb changes for async plane updates
Cc: <stable@vger.kernel.org> # v4.14+: 8105bbaf9afd: drm: don't block fb changes for async plane updates
Fixes: 25dc194b34dd ("drm: Block fb changes for async plane updates")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

As mentioned in the cover letter,
I tested on the rockchip and on i915 using igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.
But I couldn't test on MSM because I don't have the hardware and I would
appreciate if anyone could test it.

In other platforms (VC4, AMD, Rockchip), there is a hidden
drm_framebuffer_get(new_fb)/drm_framebuffer_put(old_fb) in async_update
that is wrong, but I couldn't identify those here, not sure if it is hidden
somewhere else, but if tests fail this is probably the cause.

Thanks!
Helen

 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index be13140967b4..b854f471e9e5 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -502,6 +502,8 @@ static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
 static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
 					   struct drm_plane_state *new_state)
 {
+	struct drm_framebuffer *old_fb = plane->state->fb;
+
 	plane->state->src_x = new_state->src_x;
 	plane->state->src_y = new_state->src_y;
 	plane->state->crtc_x = new_state->crtc_x;
@@ -524,6 +526,8 @@ static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
 
 	*to_mdp5_plane_state(plane->state) =
 		*to_mdp5_plane_state(new_state);
+
+	new_state->fb = old_fb;
 }
 
 static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
-- 
2.20.1

