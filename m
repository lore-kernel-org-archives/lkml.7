Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C2DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD6120644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="V9GXqoO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfEHQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46531 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfEHQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id i31so1112103qti.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMYs8c+Tum5RlcWDu+Yjp2ss6Gwc93s4y2RXr302wBc=;
        b=V9GXqoO00IQawyAit26xGWHY+niy9Pe4noR5ZtzE7XaUhHzxNPBhX6heQEDbjay49Z
         xkJ4IzbsvL8tEUDZoydoxCXl2A9z/GZI5D5jWIzNq8f3wfhKb07n49CTcw8WlLhmXMtE
         TaEB3wvfBZKMhqCGoDaugHZvUVad3S96FLtKafp69w1aw539RLitBbFVlZhg1uN/Ethv
         oezSDrd7k0BCVmzekKQ4H0oXS5udyTb5739nCq6lBAD8iunjYSYceo+T696JaZhqljb8
         sSiHZGUhexQhh6g0lxTburkg/6oM8Tp9x5F1Ovd9Unwn4cBJsbGBX5eJJWQGCDPeZGL5
         hKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMYs8c+Tum5RlcWDu+Yjp2ss6Gwc93s4y2RXr302wBc=;
        b=rEYilYeKdDsd7PWTzp7ESzsDnLWbt7NhUYMIqzliilo0CfcDi3ZkKn09zhNG3vOQyA
         9J7zOr/pWQW8fqSIvVlVdHYGhZLDNgQMQnU16PMxX+kzj+OoTuH2TfFi2DyQQYpfG4DU
         0vtbdmM/3Ghhw1G+Cw4HVrTVaD77V9gjLM0ZG1NqEOpD6N/YLuzkvx1HgBFQ2XY+Z2FF
         FqINRzFAw+Am7aCAjCf+xduwX6vycIFVdHbs0QyIGhif+XFuBkxnWG3os0LIDaoEoS50
         49vKM1ZrWFLmkub/ni+BtafCyTawIvnSHARVuArprRHy3ZiH6mSksemrsGyAWDbmLt0P
         WDRQ==
X-Gm-Message-State: APjAAAX58jjpxVel9lLnyh9hSNESS/ONPh77zPIv4BYwzxt8yjJ2NeUu
        HLYnKHnwzOqL2iOzZ00Abehelg==
X-Google-Smtp-Source: APXvYqxEXJQfeSOuHsS9Kxc7CZkRGu6Bnk5tH6UETK9HU4JMYas/R8DIjUhhkcfh/hFGdmsGaq/udw==
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr30829373qvj.17.1557331783753;
        Wed, 08 May 2019 09:09:43 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:43 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>, Zain Wang <wzz@rock-chips.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] drm/rockchip: Don't fully disable vop on self refresh
Date:   Wed,  8 May 2019 12:09:15 -0400
Message-Id: <20190508160920.144739-11-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190508160920.144739-1-sean@poorly.run>
References: <20190508160920.144739-1-sean@poorly.run>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Instead of fully disabling and re-enabling the vop on self refresh
transitions, only disable the active windows. This will speed up
self refresh exits substantially and is still a power-savings win.

This patch integrates portions of Zain's patch from here:
https://patchwork.kernel.org/patch/9615063/

Changes in v2:
- None
Changes in v3:
- None
Changes in v4:
- Adjust for preceding vop_win_disable changes

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-5-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-4-sean@poorly.run
Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-10-sean@poorly.run

Cc: Zain Wang <wzz@rock-chips.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 41 ++++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 15a5b44eb7e7..acdc86a9144b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -134,6 +134,7 @@ struct vop {
 	bool is_enabled;
 
 	struct completion dsp_hold_completion;
+	unsigned int win_enabled;
 
 	/* protected by dev->event_lock */
 	struct drm_pending_vblank_event *event;
@@ -555,6 +556,7 @@ static void vop_win_disable(struct vop *vop, const struct vop_win *vop_win)
 	}
 
 	VOP_WIN_SET(vop, win, enable, 0);
+	vop->win_enabled &= ~BIT(VOP_WIN_TO_INDEX(vop_win));
 }
 
 static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
@@ -637,6 +639,25 @@ static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
 	return ret;
 }
 
+static void rockchip_drm_set_win_enabled(struct drm_crtc *crtc, bool enabled)
+{
+        struct vop *vop = to_vop(crtc);
+        int i;
+
+        spin_lock(&vop->reg_lock);
+
+        for (i = 0; i < vop->data->win_size; i++) {
+                struct vop_win *vop_win = &vop->win[i];
+                const struct vop_win_data *win = vop_win->data;
+
+                VOP_WIN_SET(vop, win, enable,
+                            enabled && (vop->win_enabled & BIT(i)));
+        }
+        vop_cfg_done(vop);
+
+        spin_unlock(&vop->reg_lock);
+}
+
 static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
@@ -644,15 +665,16 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
-	mutex_lock(&vop->vop_lock);
+	if (crtc->state->self_refresh_active)
+		rockchip_drm_set_win_enabled(crtc, false);
 
-	if (!vop->is_enabled) {
-		mutex_unlock(&vop->vop_lock);
-		return;
-	}
+	mutex_lock(&vop->vop_lock);
 
 	drm_crtc_vblank_off(crtc);
 
+	if (crtc->state->self_refresh_active)
+		goto out;
+
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
@@ -683,6 +705,8 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable(vop->dclk);
 	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
+
+out:
 	mutex_unlock(&vop->vop_lock);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -900,6 +924,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
+	vop->win_enabled |= BIT(win_index);
 	spin_unlock(&vop->reg_lock);
 }
 
@@ -1056,6 +1081,12 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 	int dither_bpc = s->output_bpc ? s->output_bpc : 10;
 	int ret;
 
+	if (old_state && old_state->self_refresh_active) {
+		drm_crtc_vblank_on(crtc);
+		rockchip_drm_set_win_enabled(crtc, true);
+		return;
+	}
+
 	mutex_lock(&vop->vop_lock);
 
 	WARN_ON(vop->event);
-- 
Sean Paul, Software Engineer, Google / Chromium OS

