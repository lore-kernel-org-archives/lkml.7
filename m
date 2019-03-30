Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20216C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E3205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908140;
	bh=/toNsHkH2DSrApYmQeXO3RnXba+ZCLU4debtsAvH3F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRC6VbcI7JxYWVMKNSrpijCJkcwLmDt97PGMhjv+4920pEoCpCIhMCQNCLjU7ifJL
	 0zwXjGsf2RU6yFXkxCOuY8Qoh/AaF7pnBAuHAzaV9g6ngt1techFFYY8Ac0Q+SfR1G
	 j0rstjIzkzni8VmCHRWe+3UAmxF+CSIHKD7mnnxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfC3Awh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfC3Awf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AADC218FC;
        Sat, 30 Mar 2019 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907153;
        bh=/toNsHkH2DSrApYmQeXO3RnXba+ZCLU4debtsAvH3F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNtiibaGxPfjM189BsTXt1mMguCEAVxAfBTsUs+MT46zQGaQa6aoVcwHv2Ksgbe1C
         aN9Su5EYuYWcytnY2eqIOgWpcwhj4hMprXq63XC9MW1c5DvcrfWw+w4V0YoRZ6mhkD
         kIGDpH7/ofdBqc+em6C1sSx6D8xVOzri8sdqJek0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 52/67] drm/exynos/mixer: fix MIXER shadow registry synchronisation code
Date:   Fri, 29 Mar 2019 20:50:32 -0400
Message-Id: <20190330005047.25998-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit 6a3b45ada960ac475ec2b4103d43e57943b2b8d3 ]

MIXER on Exynos5 SoCs uses different synchronisation method than Exynos4
to update internal state (shadow registers).
Apparently the driver implements it incorrectly. The rule should be
as follows:
- do not request updating registers until previous request was finished,
  ie. MXR_CFG_LAYER_UPDATE_COUNT must be 0.
- before setting registers synchronisation on VSYNC should be turned off,
  ie. MXR_STATUS_SYNC_ENABLE should be reset,
- after finishing MXR_STATUS_SYNC_ENABLE should be set again.
The patch hopefully implements it correctly.
Below sample kernel log from page fault caused by the bug:

[   25.670038] exynos-sysmmu 14650000.sysmmu: 14450000.mixer: PAGE FAULT occurred at 0x2247b800
[   25.677888] ------------[ cut here ]------------
[   25.682164] kernel BUG at ../drivers/iommu/exynos-iommu.c:450!
[   25.687971] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[   25.693778] Modules linked in:
[   25.696816] CPU: 5 PID: 1553 Comm: fb-release_test Not tainted 5.0.0-rc7-01157-g5f86b1566bdd #136
[   25.705646] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   25.711710] PC is at exynos_sysmmu_irq+0x1c0/0x264
[   25.716470] LR is at lock_is_held_type+0x44/0x64

v2: added missing MXR_CFG_LAYER_UPDATE bit setting in mixer_enable_sync

Reported-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 110 +++++++++++++++-----------
 1 file changed, 66 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 0573eab0e190..f35e4ab55b27 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -20,6 +20,7 @@
 #include "regs-vp.h"
 
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/i2c.h>
@@ -352,15 +353,62 @@ static void mixer_cfg_vp_blend(struct mixer_context *ctx, unsigned int alpha)
 	mixer_reg_write(ctx, MXR_VIDEO_CFG, val);
 }
 
-static void mixer_vsync_set_update(struct mixer_context *ctx, bool enable)
+static bool mixer_is_synced(struct mixer_context *ctx)
 {
-	/* block update on vsync */
-	mixer_reg_writemask(ctx, MXR_STATUS, enable ?
-			MXR_STATUS_SYNC_ENABLE : 0, MXR_STATUS_SYNC_ENABLE);
+	u32 base, shadow;
 
+	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
+	    ctx->mxr_ver == MXR_VER_128_0_0_184)
+		return !(mixer_reg_read(ctx, MXR_CFG) &
+			 MXR_CFG_LAYER_UPDATE_COUNT_MASK);
+
+	if (test_bit(MXR_BIT_VP_ENABLED, &ctx->flags) &&
+	    vp_reg_read(ctx, VP_SHADOW_UPDATE))
+		return false;
+
+	base = mixer_reg_read(ctx, MXR_CFG);
+	shadow = mixer_reg_read(ctx, MXR_CFG_S);
+	if (base != shadow)
+		return false;
+
+	base = mixer_reg_read(ctx, MXR_GRAPHIC_BASE(0));
+	shadow = mixer_reg_read(ctx, MXR_GRAPHIC_BASE_S(0));
+	if (base != shadow)
+		return false;
+
+	base = mixer_reg_read(ctx, MXR_GRAPHIC_BASE(1));
+	shadow = mixer_reg_read(ctx, MXR_GRAPHIC_BASE_S(1));
+	if (base != shadow)
+		return false;
+
+	return true;
+}
+
+static int mixer_wait_for_sync(struct mixer_context *ctx)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), 100000);
+
+	while (!mixer_is_synced(ctx)) {
+		usleep_range(1000, 2000);
+		if (ktime_compare(ktime_get(), timeout) > 0)
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static void mixer_disable_sync(struct mixer_context *ctx)
+{
+	mixer_reg_writemask(ctx, MXR_STATUS, 0, MXR_STATUS_SYNC_ENABLE);
+}
+
+static void mixer_enable_sync(struct mixer_context *ctx)
+{
+	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
+	    ctx->mxr_ver == MXR_VER_128_0_0_184)
+		mixer_reg_writemask(ctx, MXR_CFG, ~0, MXR_CFG_LAYER_UPDATE);
+	mixer_reg_writemask(ctx, MXR_STATUS, ~0, MXR_STATUS_SYNC_ENABLE);
 	if (test_bit(MXR_BIT_VP_ENABLED, &ctx->flags))
-		vp_reg_write(ctx, VP_SHADOW_UPDATE, enable ?
-			VP_SHADOW_UPDATE_ENABLE : 0);
+		vp_reg_write(ctx, VP_SHADOW_UPDATE, VP_SHADOW_UPDATE_ENABLE);
 }
 
 static void mixer_cfg_scan(struct mixer_context *ctx, int width, int height)
@@ -498,7 +546,6 @@ static void vp_video_buffer(struct mixer_context *ctx,
 
 	spin_lock_irqsave(&ctx->reg_slock, flags);
 
-	vp_reg_write(ctx, VP_SHADOW_UPDATE, 1);
 	/* interlace or progressive scan mode */
 	val = (test_bit(MXR_BIT_INTERLACE, &ctx->flags) ? ~0 : 0);
 	vp_reg_writemask(ctx, VP_MODE, val, VP_MODE_LINE_SKIP);
@@ -553,11 +600,6 @@ static void vp_video_buffer(struct mixer_context *ctx,
 	vp_regs_dump(ctx);
 }
 
-static void mixer_layer_update(struct mixer_context *ctx)
-{
-	mixer_reg_writemask(ctx, MXR_CFG, ~0, MXR_CFG_LAYER_UPDATE);
-}
-
 static void mixer_graph_buffer(struct mixer_context *ctx,
 			       struct exynos_drm_plane *plane)
 {
@@ -640,11 +682,6 @@ static void mixer_graph_buffer(struct mixer_context *ctx,
 	mixer_cfg_layer(ctx, win, priority, true);
 	mixer_cfg_gfx_blend(ctx, win, pixel_alpha, state->base.alpha);
 
-	/* layer update mandatory for mixer 16.0.33.0 */
-	if (ctx->mxr_ver == MXR_VER_16_0_33_0 ||
-		ctx->mxr_ver == MXR_VER_128_0_0_184)
-		mixer_layer_update(ctx);
-
 	spin_unlock_irqrestore(&ctx->reg_slock, flags);
 
 	mixer_regs_dump(ctx);
@@ -709,7 +746,7 @@ static void mixer_win_reset(struct mixer_context *ctx)
 static irqreturn_t mixer_irq_handler(int irq, void *arg)
 {
 	struct mixer_context *ctx = arg;
-	u32 val, base, shadow;
+	u32 val;
 
 	spin_lock(&ctx->reg_slock);
 
@@ -723,26 +760,9 @@ static irqreturn_t mixer_irq_handler(int irq, void *arg)
 		val &= ~MXR_INT_STATUS_VSYNC;
 
 		/* interlace scan need to check shadow register */
-		if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)) {
-			if (test_bit(MXR_BIT_VP_ENABLED, &ctx->flags) &&
-			    vp_reg_read(ctx, VP_SHADOW_UPDATE))
-				goto out;
-
-			base = mixer_reg_read(ctx, MXR_CFG);
-			shadow = mixer_reg_read(ctx, MXR_CFG_S);
-			if (base != shadow)
-				goto out;
-
-			base = mixer_reg_read(ctx, MXR_GRAPHIC_BASE(0));
-			shadow = mixer_reg_read(ctx, MXR_GRAPHIC_BASE_S(0));
-			if (base != shadow)
-				goto out;
-
-			base = mixer_reg_read(ctx, MXR_GRAPHIC_BASE(1));
-			shadow = mixer_reg_read(ctx, MXR_GRAPHIC_BASE_S(1));
-			if (base != shadow)
-				goto out;
-		}
+		if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)
+		    && !mixer_is_synced(ctx))
+			goto out;
 
 		drm_crtc_handle_vblank(&ctx->crtc->base);
 	}
@@ -917,12 +937,14 @@ static void mixer_disable_vblank(struct exynos_drm_crtc *crtc)
 
 static void mixer_atomic_begin(struct exynos_drm_crtc *crtc)
 {
-	struct mixer_context *mixer_ctx = crtc->ctx;
+	struct mixer_context *ctx = crtc->ctx;
 
-	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
+	if (!test_bit(MXR_BIT_POWERED, &ctx->flags))
 		return;
 
-	mixer_vsync_set_update(mixer_ctx, false);
+	if (mixer_wait_for_sync(ctx))
+		dev_err(ctx->dev, "timeout waiting for VSYNC\n");
+	mixer_disable_sync(ctx);
 }
 
 static void mixer_update_plane(struct exynos_drm_crtc *crtc,
@@ -964,7 +986,7 @@ static void mixer_atomic_flush(struct exynos_drm_crtc *crtc)
 	if (!test_bit(MXR_BIT_POWERED, &mixer_ctx->flags))
 		return;
 
-	mixer_vsync_set_update(mixer_ctx, true);
+	mixer_enable_sync(mixer_ctx);
 	exynos_crtc_handle_event(crtc);
 }
 
@@ -979,7 +1001,7 @@ static void mixer_enable(struct exynos_drm_crtc *crtc)
 
 	exynos_drm_pipe_clk_enable(crtc, true);
 
-	mixer_vsync_set_update(ctx, false);
+	mixer_disable_sync(ctx);
 
 	mixer_reg_writemask(ctx, MXR_STATUS, ~0, MXR_STATUS_SOFT_RESET);
 
@@ -992,7 +1014,7 @@ static void mixer_enable(struct exynos_drm_crtc *crtc)
 
 	mixer_commit(ctx);
 
-	mixer_vsync_set_update(ctx, true);
+	mixer_enable_sync(ctx);
 
 	set_bit(MXR_BIT_POWERED, &ctx->flags);
 }
-- 
2.19.1

