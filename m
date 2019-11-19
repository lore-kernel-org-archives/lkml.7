Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F781C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074D8222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="U2Ab5tl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfKSOSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:18:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50122 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfKSOSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574173066; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OS0h2Ggg0b56cOSobtp4VRoJMemsoZrzaLZRtyDPpVY=;
        b=U2Ab5tl5RgP93po3s3jGRYQnUOPa+NEAxx4xgdMlmqap1W9fZu5mv9FMBgfJkvuBUt77Ei
        h2f6TRrhQ2d6H4DGVqAYY0syO7SCXoh2vzPWAsOIYCgg/GtXBhdblt2K7Z+Q8dthB/eJCp
        P1WZdmqVNi0KtuNolxBY55l0FrsQA28=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/6] gpu/drm: ingenic: Use the plane's src_[x,y] to configure DMA length
Date:   Tue, 19 Nov 2019 15:17:33 +0100
Message-Id: <20191119141736.74607-3-paul@crapouillou.net>
In-Reply-To: <20191119141736.74607-1-paul@crapouillou.net>
References: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of obtaining the width/height of the framebuffer from the CRTC
state, obtain it from the current plane state.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 6dc4b06e7e68..7a172271bd63 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -374,8 +374,8 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = state->fb;
 
 	if (fb) {
-		width = state->crtc->state->adjusted_mode.hdisplay;
-		height = state->crtc->state->adjusted_mode.vdisplay;
+		width = state->src_w >> 16;
+		height = state->src_h >> 16;
 		cpp = fb->format->cpp[plane->index];
 
 		priv->dma_hwdesc->addr = drm_fb_cma_get_gem_addr(fb, state, 0);
-- 
2.24.0

