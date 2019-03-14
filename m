Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10767C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6BE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfCNAVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:21:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfCNAVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:21:12 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9719:798c:867b:ebff:fe52:de60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CB7E826016E;
        Thu, 14 Mar 2019 00:21:06 +0000 (GMT)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Helen Koike <helen.koike@collabora.com>,
        stable@vger.kernel.org, eric@anholt.net,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 4/5] drm/vc4: fix fb references in async update
Date:   Wed, 13 Mar 2019 21:20:25 -0300
Message-Id: <20190314002027.7833-5-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314002027.7833-1-helen.koike@collabora.com>
References: <20190314002027.7833-1-helen.koike@collabora.com>
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

Cc: <stable@vger.kernel.org> # v4.19+
Fixes: 539c320bfa97 ("drm/vc4: update cursors asynchronously through atomic")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

---
Hello,

I tested on a Raspberry Pi model B rev2 with igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.

Changes in v3: None
Changes in v2:
- Added reviewed-by tag
- updated CC stable and Fixes tag

 drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 4d918d3e4858..afc80b245ea3 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1025,7 +1025,7 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
 {
 	struct vc4_plane_state *vc4_state, *new_vc4_state;
 
-	drm_atomic_set_fb_for_plane(plane->state, state->fb);
+	swap(plane->state->fb, state->fb);
 	plane->state->crtc_x = state->crtc_x;
 	plane->state->crtc_y = state->crtc_y;
 	plane->state->crtc_w = state->crtc_w;
-- 
2.20.1

