Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC5621848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRPr0uOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfEXSRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:17:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43032 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732068AbfEXSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:17:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id u27so7808989lfg.10;
        Fri, 24 May 2019 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O5pIm2m4NxOGlMxX/nLkxhizg0jCSEwFErx5xpnIiYo=;
        b=cRPr0uOL87KQTGE467IAVUAex9t3PIemIPFOnAnGTs4RWTvb4dpls9Cdnw/bkEdyf2
         czuUOA1G8fiqj95O7+NaIkNkg+gqXFGJsItpTI8mKUVQVPU0puYHH+8ZGKxhMAYlMoOt
         PTow7G91v58x2KPVKTUMPJBljyzg+r4ZtB8q/YkGipR1pRt5Bqawh15g9fqfW7hPg5y+
         u95bPBL/cDvPPjBi0LvyMdbnF4EH4X9kkEcSCrwG9nHkNsBEqKCHGdvXrt0X/NDKk9Wc
         4aS3hP9bF5rVMfkXuUu73NuyXy0JndD61kWYMVZFnLqv9cJ5ME517PRS3/g8YZDOKfCY
         IkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5pIm2m4NxOGlMxX/nLkxhizg0jCSEwFErx5xpnIiYo=;
        b=rhYaMAGPJA7gec0sM8C6d6iEdMiXmx7r1UVqLtlV6YM5qFPNTGxjasU11wUrZ9VrIY
         9lxXslq3TbYVUA0Oo5DD9yqDQ5r07l284mNKV2d2/dUj7GTSCI/GFCZpZxF0f1oISQw3
         OGJOHfZ9ws6pyGrzlRQgwZ8O3125Hj1JjkT1QAVxquj/x/kzOQj6L54zC3Wq2stEoAI5
         hwtetSamLUMmIMYRiQCEVp7NjhSTMFKDMMo28D/WLyHdQU6lnrXzO+cSdgBDThwKf3fl
         EOeC5hZvqmofvcDTtG9XmBC+vljmdi3ivuGaDu5zN4K32lcBD0UTVPoPY3+wj8L2USmS
         fCRg==
X-Gm-Message-State: APjAAAUVE/eZOHh9i5Zp4nHda+V7gy/y3kZqL1mHOyV1bTUOwlv2dRPe
        9aZQvsi2dkzd5tYvKGSsRog=
X-Google-Smtp-Source: APXvYqyfKxsqJfXhGE8s9zV2IKz5n6QvddanYpjfei/wrGKdsHf8ISHVAt4+GjIyE7Z05fE+xbpnVw==
X-Received: by 2002:ac2:533c:: with SMTP id f28mr41278686lfh.81.1558721859631;
        Fri, 24 May 2019 11:17:39 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id h10sm810376ljm.9.2019.05.24.11.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:17:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/tegra: Support PM QoS memory bandwidth management
Date:   Fri, 24 May 2019 21:16:27 +0300
Message-Id: <20190524181627.16490-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524181627.16490-1-digetx@gmail.com>
References: <20190524181627.16490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display controller (DC) performs isochronous memory transfers and thus
has a requirement for a minimum memory bandwidth that shall be fulfilled,
otherwise framebuffer data can't be fetched fast enough and this results
in a DC's data-FIFO underflow that follows by a visual corruption.

The External Memory Controller drivers will provide memory bandwidth
management facility via the generic Power Management QoS API soonish.
This patch wires up the PM QoS API support for the display driver
beforehand.

Display won't have visual corruption on coming up from suspend state when
devfreq driver is active once all prerequisite bits will get upstreamed.
The devfreq reaction has a quite significant latency and it also doesn't
take into account the ISO transfers which may result in assumption about
lower memory bandwidth requirement than actually needed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 232 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |   8 ++
 drivers/gpu/drm/tegra/drm.c   |  18 +++
 drivers/gpu/drm/tegra/plane.c |   1 +
 drivers/gpu/drm/tegra/plane.h |   4 +-
 5 files changed, 261 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index e537c0d4bfdd..1e0d5cf0343b 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -517,6 +517,123 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 		tegra_plane_setup_blending(plane, window);
 }
 
+static unsigned long
+tegra_plane_memory_bandwidth(struct drm_plane_state *state,
+			     struct tegra_dc_window *window)
+{
+	struct tegra_plane_state *tegra_state;
+	struct drm_crtc_state *crtc_state;
+	const struct drm_format_info *fmt;
+	struct tegra_dc_window win;
+	unsigned int bpp_plane;
+	unsigned int bpp;
+	unsigned int mul;
+	unsigned int i;
+
+	if (!state->fb || !state->visible)
+		return 0;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
+	tegra_state = to_tegra_plane_state(state);
+
+	if (!window)
+		window = &win;
+
+	window->src.w = drm_rect_width(&state->src) >> 16;
+	window->src.h = drm_rect_height(&state->src) >> 16;
+	window->dst.w = drm_rect_width(&state->dst);
+	window->dst.h = drm_rect_height(&state->dst);
+	window->tiling = tegra_state->tiling;
+
+	fmt = state->fb->format;
+
+	/*
+	 * Note that real memory bandwidth vary depending on format and
+	 * memory layout, we are not taking that into account because small
+	 * estimation error isn't important since bandwidth is rounded up
+	 * anyway.
+	 */
+	for (i = 0, bpp = 0; i < fmt->num_planes; i++) {
+		bpp_plane = fmt->cpp[i] * 8;
+
+		/*
+		 * Sub-sampling is relevant for chroma planes only and vertical
+		 * readouts are not cached, hence only horizontal sub-sampling
+		 * matters.
+		 */
+		if (i > 0)
+			bpp_plane /= fmt->hsub;
+
+		bpp += bpp_plane;
+	}
+
+	/*
+	 * Horizontal downscale takes extra bandwidth which roughly depends
+	 * on the scaled width.
+	 */
+	if (window->src.w > window->dst.w)
+		mul = (window->src.w - window->dst.w) * bpp / 2048 + 1;
+	else
+		mul = 1;
+
+	/*
+	 * Ignore window if its width is small enough such that data-prefetch
+	 * FIFO will easily help to overcome temporal memory pressure. This is
+	 * a typical case for the cursor's plane.
+	 */
+	if (mul == 1 && window->src.w * bpp <= 2048)
+		return 0;
+
+	/* mode.clock in kHz, bandwidth in Mbit/s */
+	return crtc_state->mode.clock / 1000 * bpp * mul;
+}
+
+static unsigned long
+tegra20_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	/* x2: ~50% efficiency */
+	return tegra_plane_memory_bandwidth(state, NULL) * 2;
+}
+
+static unsigned long
+tegra30_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	struct tegra_dc_window window;
+	unsigned long bandwidth;
+
+	bandwidth = tegra_plane_memory_bandwidth(state, &window);
+
+	/* x2 memory overfetch for tiled framebuffer and DDR3 */
+	if (window.tiling.mode == TEGRA_BO_TILING_MODE_TILED)
+		bandwidth *= 2;
+
+	/* x2: ~50% efficiency */
+	return bandwidth * 2;
+}
+
+static unsigned long
+tegra114_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	struct tegra_dc_window window;
+	unsigned long bandwidth;
+
+	bandwidth = tegra_plane_memory_bandwidth(state, &window);
+
+	/* x2 memory overfetch for tiled framebuffer and DDR3 */
+	if (window.tiling.mode == TEGRA_BO_TILING_MODE_TILED)
+		bandwidth *= 2;
+
+	/* 2-channel memory */
+	return bandwidth;
+}
+
+static unsigned long
+tegra124_plane_memory_bandwidth(struct drm_plane_state *state)
+{
+	/* 64bit memory bus */
+	return tegra_plane_memory_bandwidth(state, NULL);
+}
+
 static const u32 tegra20_primary_formats[] = {
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
@@ -606,8 +723,10 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	int err;
 
 	/* no need for further checks if the plane is being disabled */
-	if (!state->crtc)
+	if (!state->crtc) {
+		plane_state->memory_bandwidth = 0;
 		return 0;
+	}
 
 	err = tegra_plane_format(state->fb->format->format,
 				 &plane_state->format,
@@ -660,6 +779,8 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	if (err < 0)
 		return err;
 
+	plane_state->memory_bandwidth = dc->soc->plane_memory_bandwidth(state);
+
 	return 0;
 }
 
@@ -1182,6 +1303,7 @@ tegra_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
 	copy->pclk = state->pclk;
 	copy->div = state->div;
 	copy->planes = state->planes;
+	copy->memory_bandwidth = state->memory_bandwidth;
 
 	return &copy->base;
 }
@@ -1775,6 +1897,9 @@ static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
 	spin_unlock_irq(&crtc->dev->event_lock);
 
 	pm_runtime_put_sync(dc->dev);
+
+	pm_qos_update_request(&dc->pm_qos_req,
+			      PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE);
 }
 
 static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
@@ -1785,6 +1910,8 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct tegra_dc *dc = to_tegra_dc(crtc);
 	u32 value;
 
+	pm_qos_update_request(&dc->pm_qos_req, state->memory_bandwidth);
+
 	pm_runtime_get_sync(dc->dev);
 
 	/* initialize display controller */
@@ -1894,6 +2021,9 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_crtc_state)
 {
+	struct tegra_dc_state *dc_old_state = to_dc_state(old_crtc_state);
+	struct tegra_dc_state *dc_state = to_dc_state(crtc->state);
+	struct tegra_dc *dc = to_tegra_dc(crtc);
 	unsigned long flags;
 
 	if (crtc->state->event) {
@@ -1908,6 +2038,23 @@ static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
 
 		crtc->state->event = NULL;
 	}
+
+	if (old_crtc_state && old_crtc_state->active) {
+		/*
+		 * Raise memory bandwidth before changes take effect if it
+		 * goes from low to high.
+		 */
+		if (dc_old_state->memory_bandwidth < dc_state->memory_bandwidth)
+			pm_qos_update_request(&dc->pm_qos_req,
+					      dc_state->memory_bandwidth);
+	} else {
+		/*
+		 * Raise memory bandwidth before changes take effect if
+		 * CRTC is turning on.
+		 */
+		pm_qos_update_request(&dc->pm_qos_req,
+				      dc_state->memory_bandwidth);
+	}
 }
 
 static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
@@ -1926,7 +2073,78 @@ static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
 	value = tegra_dc_readl(dc, DC_CMD_STATE_CONTROL);
 }
 
+static bool
+tegra_plane_intersects_with_other_plane(struct drm_crtc_state *state,
+					const struct drm_plane_state *plane_state)
+{
+	const struct drm_plane_state *other_state;
+	struct drm_plane *plane;
+	struct drm_rect rect;
+
+	drm_atomic_crtc_state_for_each_plane_state(plane, other_state, state) {
+		rect = plane_state->dst;
+
+		if (other_state == plane_state)
+			continue;
+
+		if (!other_state->visible || !other_state->fb)
+			continue;
+
+		if (drm_rect_intersect(&rect, &other_state->dst))
+			return true;
+	}
+
+	return false;
+}
+
+static int tegra_crtc_atomic_check(struct drm_crtc *crtc,
+				   struct drm_crtc_state *state)
+{
+	struct tegra_dc_state *dc_state = to_dc_state(state);
+	const struct drm_plane_state *plane_state;
+	const struct tegra_plane_state *tegra;
+	unsigned long bandwidth = 0;
+	struct drm_plane *plane;
+
+	/*
+	 * For overlapping planes pixel's data is fetched for each plane at
+	 * the same time, hence bandwidth is accumulated in this case.
+	 */
+	drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, state) {
+		tegra = to_tegra_plane_state(plane_state);
+
+		if (tegra_plane_intersects_with_other_plane(state, plane_state))
+			bandwidth += tegra->memory_bandwidth;
+		else
+			bandwidth = max(bandwidth, tegra->memory_bandwidth);
+	}
+
+	dc_state->memory_bandwidth = bandwidth;
+
+	return 0;
+}
+
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_crtc_state *old_crtc_state)
+{
+	struct tegra_dc_state *dc_old_state = to_dc_state(old_crtc_state);
+	struct tegra_dc_state *dc_state = to_dc_state(crtc->state);
+	struct tegra_dc *dc = to_tegra_dc(crtc);
+
+	if (!dc_old_state)
+		return;
+
+	/*
+	 * Drop memory bandwidth after changes take effect if it goes from
+	 * high to low.
+	 */
+	if (dc_old_state->memory_bandwidth > dc_state->memory_bandwidth)
+		pm_qos_update_request(&dc->pm_qos_req,
+				      dc_state->memory_bandwidth);
+}
+
 static const struct drm_crtc_helper_funcs tegra_crtc_helper_funcs = {
+	.atomic_check = tegra_crtc_atomic_check,
 	.atomic_begin = tegra_crtc_atomic_begin,
 	.atomic_flush = tegra_crtc_atomic_flush,
 	.atomic_enable = tegra_crtc_atomic_enable,
@@ -2082,6 +2300,9 @@ static int tegra_dc_init(struct host1x_client *client)
 		goto cleanup;
 	}
 
+	pm_qos_add_request(&dc->pm_qos_req, PM_QOS_MEMORY_BANDWIDTH,
+			   PM_QOS_MEMORY_BANDWIDTH_DEFAULT_VALUE);
+
 	return 0;
 
 cleanup:
@@ -2102,6 +2323,8 @@ static int tegra_dc_exit(struct host1x_client *client)
 	struct tegra_dc *dc = host1x_client_to_dc(client);
 	int err;
 
+	pm_qos_remove_request(&dc->pm_qos_req);
+
 	if (!tegra_dc_has_window_groups(dc))
 		return 0;
 
@@ -2141,6 +2364,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = true,
 	.has_win_c_without_vert_filter = true,
+	.plane_memory_bandwidth = tegra20_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2160,6 +2384,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra30_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2179,6 +2404,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.modifiers = tegra20_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra114_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2198,6 +2424,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2217,6 +2444,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.modifiers = tegra124_modifiers,
 	.has_win_a_without_filters = false,
 	.has_win_c_without_vert_filter = false,
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2265,6 +2493,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2313,6 +2542,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.has_nvdisplay = true,
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
+	.plane_memory_bandwidth = tegra124_plane_memory_bandwidth,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index ab25157c948e..e224fb9dd187 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -11,6 +11,7 @@
 #define TEGRA_DC_H 1
 
 #include <linux/host1x.h>
+#include <linux/pm_qos.h>
 
 #include <drm/drm_crtc.h>
 
@@ -26,6 +27,8 @@ struct tegra_dc_state {
 	unsigned int div;
 
 	u32 planes;
+
+	unsigned long memory_bandwidth;
 };
 
 static inline struct tegra_dc_state *to_dc_state(struct drm_crtc_state *state)
@@ -74,6 +77,7 @@ struct tegra_dc_soc_info {
 	const u64 *modifiers;
 	bool has_win_a_without_filters;
 	bool has_win_c_without_vert_filter;
+	unsigned long (*plane_memory_bandwidth)(struct drm_plane_state *state);
 };
 
 struct tegra_dc {
@@ -100,6 +104,8 @@ struct tegra_dc {
 	const struct tegra_dc_soc_info *soc;
 
 	struct iommu_group *group;
+
+	struct pm_qos_request pm_qos_req;
 };
 
 static inline struct tegra_dc *
@@ -160,6 +166,8 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 			       struct drm_crtc_state *crtc_state,
 			       struct clk *clk, unsigned long pclk,
 			       unsigned int div);
+void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
+				   struct drm_crtc_state *old_crtc_state);
 
 /* from rgb.c */
 int tegra_dc_rgb_probe(struct tegra_dc *dc);
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 0c5f1e6a0446..d2080bd7d392 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -19,6 +19,7 @@
 #include <asm/dma-iommu.h>
 #endif
 
+#include "dc.h"
 #include "drm.h"
 #include "gem.h"
 
@@ -58,6 +59,21 @@ static const struct drm_mode_config_funcs tegra_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static void tegra_atomic_post_commit(struct drm_device *drm,
+				     struct drm_atomic_state *old_state)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
+		if (!new_crtc_state->active)
+			continue;
+
+		tegra_crtc_atomic_post_commit(crtc, old_crtc_state);
+	}
+}
+
 static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *drm = old_state->dev;
@@ -74,6 +90,8 @@ static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
 	} else {
 		drm_atomic_helper_commit_tail_rpm(old_state);
 	}
+
+	tegra_atomic_post_commit(drm, old_state);
 }
 
 static const struct drm_mode_config_helper_funcs
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 5a8a3387f5ee..e7cd21a0d7d9 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -58,6 +58,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->swap = state->swap;
 	copy->bottom_up = state->bottom_up;
 	copy->opaque = state->opaque;
+	copy->memory_bandwidth = state->memory_bandwidth;
 
 	for (i = 0; i < 2; i++)
 		copy->blending[i] = state->blending[i];
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index e79e6b4a8e0a..357174bff2fd 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -51,10 +51,12 @@ struct tegra_plane_state {
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
+
+	unsigned long memory_bandwidth;
 };
 
 static inline struct tegra_plane_state *
-to_tegra_plane_state(struct drm_plane_state *state)
+to_tegra_plane_state(const struct drm_plane_state *state)
 {
 	if (state)
 		return container_of(state, struct tegra_plane_state, base);
-- 
2.21.0

