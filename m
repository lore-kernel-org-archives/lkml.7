Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374AFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A32222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SiFDBZHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfKSORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:17:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50034 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfKSORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574173065; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQ6ngIJWRLOuCG2cCCxYITwp5Aw0SISHe37jQ3RI/Pw=;
        b=SiFDBZHxjXdT1eI0TcxM94DEsZd4E8+JXQ04hm8SG9wAVuYKPITQfTvTLM/zKWBI7YVXFw
        dDlgmHlDctrIE2GsVuGcRPlU1x7rAZ3fOEq+H4SSJmfA31tnn/ue9ou5UBw4rxD6rhj4q6
        ye6BlbGju0I/3eFJunLnjDm2N29zdMA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/6] gpu/drm: ingenic: Avoid null pointer deference in plane atomic update
Date:   Tue, 19 Nov 2019 15:17:32 +0100
Message-Id: <20191119141736.74607-2-paul@crapouillou.net>
In-Reply-To: <20191119141736.74607-1-paul@crapouillou.net>
References: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that there is no drm_framebuffer associated with a given
plane state.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 2e2ed653e9c6..6dc4b06e7e68 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -371,14 +371,17 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 	struct ingenic_drm *priv = drm_plane_get_priv(plane);
 	struct drm_plane_state *state = plane->state;
 	unsigned int width, height, cpp;
+	struct drm_framebuffer *fb = state->fb;
 
-	width = state->crtc->state->adjusted_mode.hdisplay;
-	height = state->crtc->state->adjusted_mode.vdisplay;
-	cpp = state->fb->format->cpp[plane->index];
+	if (fb) {
+		width = state->crtc->state->adjusted_mode.hdisplay;
+		height = state->crtc->state->adjusted_mode.vdisplay;
+		cpp = fb->format->cpp[plane->index];
 
-	priv->dma_hwdesc->addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
-	priv->dma_hwdesc->cmd = width * height * cpp / 4;
-	priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
+		priv->dma_hwdesc->addr = drm_fb_cma_get_gem_addr(fb, state, 0);
+		priv->dma_hwdesc->cmd = width * height * cpp / 4;
+		priv->dma_hwdesc->cmd |= JZ_LCD_CMD_EOF_IRQ;
+	}
 }
 
 static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
-- 
2.24.0

