Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38312C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4E214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAubX0oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfHADq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:46:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33169 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfHADo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so1833090pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TafGTDaLfQIiKJYxJrrpSrigtAbrs7F+Anr4pE3NROk=;
        b=ZAubX0oegH5tBSxqyYzTmKkuh6MwE2oNG/rl//kpv5vB42IxMZ6QjzgrVhl+gq6+sq
         MI2sm/V0uzX6tJbaxyMJFcRCh8ZJx4LSNtWHmbAPC+Ntmwv/yrBnQuGPtesxy9Y9f/tf
         JJAjUo+b20mkv8RJpKuRYf2TfY0Bnj7trU38qyDV1xD+QXGI3Ae0nTL4Q/dw2Qa9MA3y
         GBoUyQskEB+L8X3FTNkzYVHxlltlBM7mh3Y90aZmvgXk4UsOhrO21bBKwNI8VrRhpEnK
         s1y7Zf5u4mibVvh3KLnrH9J0JHWAorKCO+p70KzGRud9ghzFqBmBKsuRif70peb2iv6k
         +W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TafGTDaLfQIiKJYxJrrpSrigtAbrs7F+Anr4pE3NROk=;
        b=eJFPjOZwsvpwb5eOgEEdHoZHnXQtXE47e1HvglNLmccJnwCTdcswjSQmZt9YzkbHuV
         VbaFpD94Q5Tb/tJEvkTFcfQS75AWxhCR3ix9HTE/fUtJGNkyTZ33l8q+/aUcqX8GFr5k
         RSmzJQ8uVOWC/B+LySOuJCQvxgIloFMzeSLOfpCfl2SgTmnDJol/KdWQ4k3xn+/zbdgb
         0jfgiqCYD/QUs3geXr600dXo9Zsdi5+Sm1cXSv3B9txXCyAb8eMCyBk8IB2tnP1ymKnN
         p73z1RWeVoSia7oG089DYczaNZZYphsTEOYSfydTr952gp4uNVHNq0Kxb+D6MIeriIxT
         pd8w==
X-Gm-Message-State: APjAAAUvk1v2gjd9yx8fjbTyhfS9lgHBQNp9u1NrANAjQfZrUUJCPIvX
        sPyUS4Pq+j8MZRFMjEL0sbFZ4vmiaM8=
X-Google-Smtp-Source: APXvYqzny3AHyMt5/ZveQdmI2/z/Y11lXel2SZs+jcWAzxgVZAm89DQZFbxQpL8AJ2BYJNRKjulrYg==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr119070666pga.429.1564631096077;
        Wed, 31 Jul 2019 20:44:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:55 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 07/26] drm: kirin: Rename ade_plane to kirin_plane
Date:   Thu,  1 Aug 2019 03:44:20 +0000
Message-Id: <20190801034439.98227-8-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames the
struct ade_plane to kirin_plane.

The struct kirin_plane will later used by both kirin620 and
future kirin960 driver, and will be moved to a common
kirin_drm_drv.h in a future patch

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 57 ++++++++++---------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 73dff21bed6a..c09040876e68 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -41,8 +41,9 @@
 #define to_ade_crtc(crtc) \
 	container_of(crtc, struct ade_crtc, base)
 
-#define to_ade_plane(plane) \
-	container_of(plane, struct ade_plane, base)
+#define to_kirin_plane(plane) \
+	container_of(plane, struct kirin_plane, base)
+
 
 struct ade_hw_ctx {
 	void __iomem  *base;
@@ -62,15 +63,15 @@ struct ade_crtc {
 	bool enable;
 };
 
-struct ade_plane {
+struct kirin_plane {
 	struct drm_plane base;
-	void *ctx;
-	u8 ch; /* channel */
+	void *hw_ctx;
+	u32 ch;
 };
 
 struct ade_data {
 	struct ade_crtc acrtc;
-	struct ade_plane aplane[ADE_CH_NUM];
+	struct kirin_plane planes[ADE_CH_NUM];
 	struct ade_hw_ctx ctx;
 };
 
@@ -795,16 +796,16 @@ static void ade_compositor_routing_disable(void __iomem *base, u32 ch)
 /*
  * Typicaly, a channel looks like: DMA-->clip-->scale-->ctrans-->compositor
  */
-static void ade_update_channel(struct ade_plane *aplane,
+static void ade_update_channel(struct kirin_plane *kplane,
 			       struct drm_framebuffer *fb, int crtc_x,
 			       int crtc_y, unsigned int crtc_w,
 			       unsigned int crtc_h, u32 src_x,
 			       u32 src_y, u32 src_w, u32 src_h)
 {
-	struct ade_hw_ctx *ctx = aplane->ctx;
+	struct ade_hw_ctx *ctx = kplane->hw_ctx;
 	void __iomem *base = ctx->base;
 	u32 fmt = ade_get_format(fb->format->format);
-	u32 ch = aplane->ch;
+	u32 ch = kplane->ch;
 	u32 in_w;
 	u32 in_h;
 
@@ -828,11 +829,11 @@ static void ade_update_channel(struct ade_plane *aplane,
 	ade_compositor_routing_set(base, ch, crtc_x, crtc_y, in_w, in_h, fmt);
 }
 
-static void ade_disable_channel(struct ade_plane *aplane)
+static void ade_disable_channel(struct kirin_plane *kplane)
 {
-	struct ade_hw_ctx *ctx = aplane->ctx;
+	struct ade_hw_ctx *ctx = kplane->hw_ctx;
 	void __iomem *base = ctx->base;
-	u32 ch = aplane->ch;
+	u32 ch = kplane->ch;
 
 	DRM_DEBUG_DRIVER("disable channel%d\n", ch + 1);
 
@@ -894,10 +895,10 @@ static int ade_plane_atomic_check(struct drm_plane *plane,
 static void ade_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_plane_state *old_state)
 {
-	struct drm_plane_state	*state	= plane->state;
-	struct ade_plane *aplane = to_ade_plane(plane);
+	struct drm_plane_state *state = plane->state;
+	struct kirin_plane *kplane = to_kirin_plane(plane);
 
-	ade_update_channel(aplane, state->fb, state->crtc_x, state->crtc_y,
+	ade_update_channel(kplane, state->fb, state->crtc_x, state->crtc_y,
 			   state->crtc_w, state->crtc_h,
 			   state->src_x >> 16, state->src_y >> 16,
 			   state->src_w >> 16, state->src_h >> 16);
@@ -906,9 +907,9 @@ static void ade_plane_atomic_update(struct drm_plane *plane,
 static void ade_plane_atomic_disable(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
-	struct ade_plane *aplane = to_ade_plane(plane);
+	struct kirin_plane *kplane = to_kirin_plane(plane);
 
-	ade_disable_channel(aplane);
+	ade_disable_channel(kplane);
 }
 
 static const struct drm_plane_helper_funcs ade_plane_helper_funcs = {
@@ -926,7 +927,7 @@ static struct drm_plane_funcs ade_plane_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
-static int ade_plane_init(struct drm_device *dev, struct ade_plane *aplane,
+static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 			  enum drm_plane_type type)
 {
 	const u32 *fmts;
@@ -934,18 +935,18 @@ static int ade_plane_init(struct drm_device *dev, struct ade_plane *aplane,
 	int ret = 0;
 
 	/* get  properties */
-	fmts_cnt = ade_get_channel_formats(aplane->ch, &fmts);
+	fmts_cnt = ade_get_channel_formats(kplane->ch, &fmts);
 	if (ret)
 		return ret;
 
-	ret = drm_universal_plane_init(dev, &aplane->base, 1, &ade_plane_funcs,
+	ret = drm_universal_plane_init(dev, &kplane->base, 1, &ade_plane_funcs,
 				       fmts, fmts_cnt, NULL, type, NULL);
 	if (ret) {
-		DRM_ERROR("fail to init plane, ch=%d\n", aplane->ch);
+		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
 	}
 
-	drm_plane_helper_add(&aplane->base, &ade_plane_helper_funcs);
+	drm_plane_helper_add(&kplane->base, &ade_plane_helper_funcs);
 
 	return 0;
 }
@@ -1007,7 +1008,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct ade_data *ade;
 	struct ade_hw_ctx *ctx;
 	struct ade_crtc *acrtc;
-	struct ade_plane *aplane;
+	struct kirin_plane *kplane;
 	enum drm_plane_type type;
 	int ret;
 	int i;
@@ -1033,19 +1034,19 @@ static int ade_drm_init(struct platform_device *pdev)
 	 * need to do.
 	 */
 	for (i = 0; i < ADE_CH_NUM; i++) {
-		aplane = &ade->aplane[i];
-		aplane->ch = i;
-		aplane->ctx = ctx;
+		kplane = &ade->planes[i];
+		kplane->ch = i;
+		kplane->hw_ctx = ctx;
 		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
 			DRM_PLANE_TYPE_OVERLAY;
 
-		ret = ade_plane_init(dev, aplane, type);
+		ret = ade_plane_init(dev, kplane, type);
 		if (ret)
 			return ret;
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &acrtc->base, &ade->aplane[PRIMARY_CH].base);
+	ret = ade_crtc_init(dev, &acrtc->base, &ade->planes[PRIMARY_CH].base);
 	if (ret)
 		return ret;
 
-- 
2.17.1

