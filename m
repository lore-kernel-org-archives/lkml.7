Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B89C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A7120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O86/E66U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfHTXHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45399 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfHTXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so74769pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KJXVIjjEjcS++SJh1XiEkct02jaX19GJ8MzEi/j2O6Y=;
        b=O86/E66UeBeESApeniO67zDOQ7uSYz51tlNrdPllkA5Ebv8MR1OX+O2o2DbxHxFHr2
         xjnC34UlJTendJgI0xPKBarRPKxLmQIlZ+OsKqYypVqyBA5xrw0kK9+3nSqTKoBFER+h
         KaYAt00cDh63+XQhMOB/dcUQM73+/WrvtEyGKKDJJR/Yqx3vXkrtQc8w8wIiRp0llmH+
         N5zeWh7JjIrrmTRATxkptT0KAY12fDMfr8zrEpXQffCpUEKUvkOKW1XtiA2ihZnDTrpy
         SFZMzL7WjANmzlRT6DCaP8IvqKt5ZRR4SLHlyphlGbwM2F4MPgxTvyBDu5cLPak5+4Ak
         eIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KJXVIjjEjcS++SJh1XiEkct02jaX19GJ8MzEi/j2O6Y=;
        b=UCY2rg9+M3u27JualtXzP0pR93Wnru0rS4a9cuWskS67YcB42ePYtC9aKkk8pst6Bt
         GVZo8Ljxqvw4CXqH9gpeoaRWBOt7T4QdEeH8Hw3LcVYsEwLBSuIPxpevExKqNMUHafSD
         BbDydTOsJexIp5ac1m7onMN6bmQLcAMPDML+vDiX+MjrAiAVh6TKwOKEYjMPeXB9L7HP
         9ogWR+Vgt+uRcHCUGL54wlHl0R3KdOhpsUoCXC57t8MBVKGNrstv1Y46RWI33rsN2qgD
         PhSxB/rNtxpLQ8Bep88krIg1J2I8hGNQeu5N30HXkpPPS51ubrpXZmRp6dMuBfSgd2H+
         4+Bg==
X-Gm-Message-State: APjAAAWhp1HZTvCDgoroBdK7XkivQJpMfARPfCQ/retjUzktKxjn+nuI
        0BMZZrecjgoqgtZTVWCUJWnns74AE70=
X-Google-Smtp-Source: APXvYqzkTPoH3ukxS5Wn0/KyT91dTrz5lXdrPCWUlIFdTnx3kYaikaoqgLJ9iXUI+R9eo95/dL4hRw==
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr32219595pfq.93.1566342429744;
        Tue, 20 Aug 2019 16:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:07:08 -0700 (PDT)
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
Subject: [PATCH v5 25/25] drm: kirin: Move ade drm init to kirin drm drv
Date:   Tue, 20 Aug 2019 23:06:26 +0000
Message-Id: <20190820230626.23253-26-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames ade_data to
kirin_drm_private, and moves crtc_init and plane_init to
kirin drm drv too. Now that they are generic the functions
can be shared between the kirin620 and (to be added later)
kirin960 specific support code.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 125 ----------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 141 ++++++++++++++++--
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |   5 -
 3 files changed, 129 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index bbdfeac946a7..73cd28a6ea07 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -53,13 +53,6 @@ struct ade_hw_ctx {
 	struct drm_crtc *crtc;
 };
 
-struct ade_data {
-	struct kirin_crtc crtc;
-	struct kirin_plane planes[ADE_CH_NUM];
-	struct ade_hw_ctx *hw_ctx;
-};
-
-/* ade-format info: */
 static const struct kirin_format ade_formats[] = {
 	/* 16bpp RGB: */
 	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
@@ -571,36 +564,6 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 	.disable_vblank	= ade_crtc_disable_vblank,
 };
 
-static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-			       struct drm_plane *plane,
-			       const struct kirin_drm_data *driver_data)
-{
-	struct device_node *port;
-	int ret;
-
-	/* set crtc port so that
-	 * drm_of_find_possible_crtcs call works
-	 */
-	port = of_get_child_by_name(dev->dev->of_node, "port");
-	if (!port) {
-		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
-		return -EINVAL;
-	}
-	of_node_put(port);
-	crtc->port = port;
-
-	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					driver_data->crtc_funcs, NULL);
-	if (ret) {
-		DRM_ERROR("failed to init crtc.\n");
-		return ret;
-	}
-
-	drm_crtc_helper_add(crtc, driver_data->crtc_helper_funcs);
-
-	return 0;
-}
-
 static void ade_rdma_set(void __iomem *base, struct drm_framebuffer *fb,
 			 u32 ch, u32 y, u32 in_h, u32 fmt)
 {
@@ -893,28 +856,6 @@ static struct drm_plane_funcs ade_plane_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
-static int kirin_drm_plane_init(struct drm_device *dev,
-				struct kirin_plane *kplane,
-				enum drm_plane_type type,
-				const struct kirin_drm_data *driver_data)
-{
-	int ret = 0;
-
-	ret = drm_universal_plane_init(dev, &kplane->base, 1,
-				       driver_data->plane_funcs,
-				       driver_data->channel_formats,
-				       driver_data->channel_formats_cnt,
-				       NULL, type, NULL);
-	if (ret) {
-		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
-		return ret;
-	}
-
-	drm_plane_helper_add(&kplane->base, driver_data->plane_helper_funcs);
-
-	return 0;
-}
-
 static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 			      struct drm_crtc *crtc)
 {
@@ -984,73 +925,10 @@ static void *ade_hw_ctx_alloc(struct platform_device *pdev,
 	return ctx;
 }
 
-static int ade_drm_init(struct platform_device *pdev)
-{
-	struct drm_device *dev = platform_get_drvdata(pdev);
-	struct ade_data *ade;
-	struct ade_hw_ctx *ctx;
-	struct kirin_crtc *kcrtc;
-	struct kirin_plane *kplane;
-	enum drm_plane_type type;
-	int prim_plane;
-	int ret;
-	u32 ch;
-
-	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
-	if (!ade) {
-		DRM_ERROR("failed to alloc ade_data\n");
-		return -ENOMEM;
-	}
-
-	ctx = ade_driver_data.alloc_hw_ctx(pdev, &ade->crtc.base);
-	if (IS_ERR(ctx)) {
-		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
-		return -EINVAL;
-	}
-	ade->hw_ctx = ctx;
-
-	kcrtc = &ade->crtc;
-	kcrtc->hw_ctx = ctx;
-
-	/*
-	 * plane init
-	 * TODO: Now only support primary plane, overlay planes
-	 * need to do.
-	 */
-	for (ch = 0; ch < ade_driver_data.num_planes; ch++) {
-		kplane = &ade->planes[ch];
-		kplane->ch = ch;
-		kplane->hw_ctx = ctx;
-
-		if (ch == ade_driver_data.prim_plane)
-			type = DRM_PLANE_TYPE_PRIMARY;
-		else
-			type = DRM_PLANE_TYPE_OVERLAY;
-
-		ret = kirin_drm_plane_init(dev, kplane, type, &ade_driver_data);
-		if (ret)
-			return ret;
-	}
-
-	/* crtc init */
-	prim_plane = ade_driver_data.prim_plane;
-	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
-				  &ade->planes[prim_plane].base,
-				  &ade_driver_data);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static void ade_hw_ctx_cleanup(void *hw_ctx)
 {
 }
 
-static void ade_drm_cleanup(struct platform_device *pdev)
-{
-}
-
 static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.atomic_check = drm_atomic_helper_check,
@@ -1098,7 +976,4 @@ struct kirin_drm_data ade_driver_data = {
 
 	.alloc_hw_ctx = ade_hw_ctx_alloc,
 	.cleanup_hw_ctx = ade_hw_ctx_cleanup,
-
-	.init = ade_drm_init,
-	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index f5df88378591..d3145ae877d7 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -29,6 +29,130 @@
 
 #include "kirin_drm_drv.h"
 
+#define KIRIN_MAX_PLANE	2
+
+struct kirin_drm_private {
+	struct kirin_crtc crtc;
+	struct kirin_plane planes[KIRIN_MAX_PLANE];
+	void *hw_ctx;
+};
+
+static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+			       struct drm_plane *plane,
+			       const struct kirin_drm_data *driver_data)
+{
+	struct device_node *port;
+	int ret;
+
+	/* set crtc port so that
+	 * drm_of_find_possible_crtcs call works
+	 */
+	port = of_get_child_by_name(dev->dev->of_node, "port");
+	if (!port) {
+		DRM_ERROR("no port node found in %pOF\n", dev->dev->of_node);
+		return -EINVAL;
+	}
+	of_node_put(port);
+	crtc->port = port;
+
+	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
+					driver_data->crtc_funcs, NULL);
+	if (ret) {
+		DRM_ERROR("failed to init crtc.\n");
+		return ret;
+	}
+
+	drm_crtc_helper_add(crtc, driver_data->crtc_helper_funcs);
+
+	return 0;
+}
+
+static int kirin_drm_plane_init(struct drm_device *dev, struct drm_plane *plane,
+				enum drm_plane_type type,
+				const struct kirin_drm_data *data)
+{
+	int ret = 0;
+
+	ret = drm_universal_plane_init(dev, plane, 1, data->plane_funcs,
+				       data->channel_formats,
+				       data->channel_formats_cnt,
+				       NULL, type, NULL);
+	if (ret) {
+		DRM_ERROR("fail to init plane, ch=%d\n", 0);
+		return ret;
+	}
+
+	drm_plane_helper_add(plane, data->plane_helper_funcs);
+
+	return 0;
+}
+
+static void kirin_drm_private_cleanup(struct drm_device *dev)
+{
+	struct kirin_drm_private *kirin_priv = dev->dev_private;
+	struct kirin_drm_data *data;
+
+	data = (struct kirin_drm_data *)of_device_get_match_data(dev->dev);
+	if (data->cleanup_hw_ctx)
+		data->cleanup_hw_ctx(kirin_priv->hw_ctx);
+
+	devm_kfree(dev->dev, kirin_priv);
+	dev->dev_private = NULL;
+}
+
+static int kirin_drm_private_init(struct drm_device *dev,
+				  const struct kirin_drm_data *driver_data)
+{
+	struct platform_device *pdev = to_platform_device(dev->dev);
+	struct kirin_drm_private *kirin_priv;
+	struct drm_plane *prim_plane;
+	enum drm_plane_type type;
+	void *ctx;
+	int ret;
+	u32 ch;
+
+	kirin_priv = devm_kzalloc(dev->dev, sizeof(*kirin_priv), GFP_KERNEL);
+	if (!kirin_priv) {
+		DRM_ERROR("failed to alloc kirin_drm_private\n");
+		return -ENOMEM;
+	}
+
+	ctx = driver_data->alloc_hw_ctx(pdev, &kirin_priv->crtc.base);
+	if (IS_ERR(ctx)) {
+		DRM_ERROR("failed to initialize kirin_priv hw ctx\n");
+		return -EINVAL;
+	}
+	kirin_priv->hw_ctx = ctx;
+
+	/*
+	 * plane init
+	 * TODO: Now only support primary plane, overlay planes
+	 * need to do.
+	 */
+	for (ch = 0; ch < driver_data->num_planes; ch++) {
+		if (ch == driver_data->prim_plane)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+		ret = kirin_drm_plane_init(dev, &kirin_priv->planes[ch].base,
+					   type, driver_data);
+		if (ret)
+			return ret;
+		kirin_priv->planes[ch].ch = ch;
+		kirin_priv->planes[ch].hw_ctx = ctx;
+	}
+
+	/* crtc init */
+	prim_plane = &kirin_priv->planes[driver_data->prim_plane].base;
+	ret = kirin_drm_crtc_init(dev, &kirin_priv->crtc.base,
+				  prim_plane, driver_data);
+	if (ret)
+		return ret;
+	kirin_priv->crtc.hw_ctx = ctx;
+	dev->dev_private = kirin_priv;
+
+	return 0;
+}
 
 static int kirin_drm_kms_init(struct drm_device *dev,
 			      const struct kirin_drm_data *driver_data)
@@ -44,7 +168,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	dev->mode_config.funcs = driver_data->mode_config_funcs;
 
 	/* display controller init */
-	ret = driver_data->init(to_platform_device(dev->dev));
+	ret = kirin_drm_private_init(dev, driver_data);
 	if (ret)
 		goto err_mode_config_cleanup;
 
@@ -52,7 +176,7 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 	ret = component_bind_all(dev->dev, dev);
 	if (ret) {
 		DRM_ERROR("failed to bind all component.\n");
-		goto err_dc_cleanup;
+		goto err_private_cleanup;
 	}
 
 	/* vblank init */
@@ -74,11 +198,10 @@ static int kirin_drm_kms_init(struct drm_device *dev,
 
 err_unbind_all:
 	component_unbind_all(dev->dev, dev);
-err_dc_cleanup:
-	driver_data->cleanup(to_platform_device(dev->dev));
+err_private_cleanup:
+	kirin_drm_private_cleanup(dev);
 err_mode_config_cleanup:
 	drm_mode_config_cleanup(dev);
-
 	return ret;
 }
 
@@ -89,14 +212,8 @@ static int compare_of(struct device *dev, void *data)
 
 static int kirin_drm_kms_cleanup(struct drm_device *dev)
 {
-	const struct kirin_drm_data *driver_data;
-
 	drm_kms_helper_poll_fini(dev);
-
-	driver_data = of_device_get_match_data(dev->dev);
-	if (driver_data->cleanup)
-		driver_data->cleanup(to_platform_device(dev->dev));
-
+	kirin_drm_private_cleanup(dev);
 	drm_mode_config_cleanup(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 1663610d2cd8..4d5c05a24065 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -7,8 +7,6 @@
 #ifndef __KIRIN_DRM_DRV_H__
 #define __KIRIN_DRM_DRV_H__
 
-#define MAX_CRTC	2
-
 #define to_kirin_crtc(crtc) \
 	container_of(crtc, struct kirin_crtc, base)
 
@@ -53,9 +51,6 @@ struct kirin_drm_data {
 	void *(*alloc_hw_ctx)(struct platform_device *pdev,
 			      struct drm_crtc *crtc);
 	void (*cleanup_hw_ctx)(void *hw_ctx);
-
-	int (*init)(struct platform_device *pdev);
-	void (*cleanup)(struct platform_device *pdev);
 };
 
 extern struct kirin_drm_data ade_driver_data;
-- 
2.17.1

