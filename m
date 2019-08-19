Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC13C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D7020644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S91jDQRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHSXDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39078 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfHSXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id z3so1685562pln.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDN5Qh2/00dJZLoF3M4SXeIuODTG/TUr5/kEaW32ueQ=;
        b=S91jDQRL9jZ6o61WERsOkpAq735GpQEx7mzFBahSeaojGWei75IuZ9lEJt4JNDB4DJ
         +Qr5LZTcdcOTP03dWfYoRxmJzhUpATZIidl+Naurvc/3Q2fryCIrFfafS/lqf2LolT4E
         A76Sttwj2xZ3n54YuwLd0LWJWdK+zXNK9GTuP3CTxChgWfDk2OvIwmmSGRID53MVITfx
         vIdJ3NxIZn0Vjp9j6CK/9L/jFys6iXz0o6uZHqRTYTk3BX0/J6WRPvarOgOD+HooDfgd
         YtwB9UT/PQ2R0S/HDKJn8m7SqFfUUSUzSA60L9yxxlSSs0IP7CoLYWmdrzq6ZuA5zmd5
         YbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDN5Qh2/00dJZLoF3M4SXeIuODTG/TUr5/kEaW32ueQ=;
        b=FlHDv9XJ/kII2hjqnUSIvl0aGyeXh6GJFQiqq+YLQnsnWtjdfN3FP+z58rIK13OQj6
         NwMwxp5wdcwukykimDBCM3zxGI+3Arv+YS3c8bXlZBrWEYmn8u5lRmn9++M4Uej/rLK/
         FgGBXkA8v6mrzlc3j7lGwPIKGb0SJt2CwAbVbn/r9l5QSSRW6d0Hj3g/cKZJtwOO0oXs
         9IfMYpi4nyUET5yI01ZUF59g/l16s1FrsfYff2aUV68wznTsC4k6mUKxQiuLTBAwiPYk
         4/Nm/N1fzhTb+aOQor5cfaabBQd/NhvXXAzGSjW1eNqqFgdmMlgiIqurioUjwRHpxOK3
         UZPg==
X-Gm-Message-State: APjAAAUviaLKVcSQyZA+9m8CsyO7NzAMoOlFw6/2msU/sf/uixElE7/V
        BLXrhIy0FL/gm8V9qD9MisS+UbVFq9g=
X-Google-Smtp-Source: APXvYqwFdxnlTiQNtFl98XWDzM4ANhPbVaXntyLUFZXzFhZG7o1TCYiMLoHN+uSOuXSnAf8SCO07Iw==
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr24644877pls.336.1566255814406;
        Mon, 19 Aug 2019 16:03:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 06/25] drm: kirin: Rename ade_plane to kirin_plane
Date:   Mon, 19 Aug 2019 23:03:02 +0000
Message-Id: <20190819230321.56480-7-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 57 ++++++++++---------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 65f1a57f7304..19d279167694 100644
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

