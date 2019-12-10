Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0030B20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FqxUtGPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfLJOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:42:13 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50030 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575988920; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2+/kJ0+3S6x9LjI8UpyG3lhPkfNRouukRngxphw6fA=;
        b=FqxUtGPlPhVyfxXRhspVU088fqYWSigP64Qr2ND4lLwMz1U+uIxKXVqP0lhckig7AlrPiY
        lK0eVE6d4MioOwLVXreMip2guNn8tV2DaPYmzTdWM1s6wSWzdK14EdqBg7meB6tdwtftkV
        bx3WYaFB19Qv8lCJMbn2GzxWcZcGBZY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/6] gpu/drm: ingenic: Use the plane's src_[x,y] to configure DMA length
Date:   Tue, 10 Dec 2019 15:41:39 +0100
Message-Id: <20191210144142.33143-3-paul@crapouillou.net>
In-Reply-To: <20191210144142.33143-1-paul@crapouillou.net>
References: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of obtaining the width/height of the framebuffer from the CRTC
state, obtain it from the current plane state.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index f156f245fdec..8713f09df448 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -375,8 +375,8 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 
 	if (state && state->fb) {
 		addr = drm_fb_cma_get_gem_addr(state->fb, state, 0);
-		width = state->crtc->state->adjusted_mode.hdisplay;
-		height = state->crtc->state->adjusted_mode.vdisplay;
+		width = state->src_w >> 16;
+		height = state->src_h >> 16;
 		cpp = state->fb->format->cpp[plane->index];
 
 		priv->dma_hwdesc->addr = addr;
-- 
2.24.0

