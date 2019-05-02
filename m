Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BBBC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E9B20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gBg2aOhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfEBTuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:50:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39010 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEBTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:50:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id l15so1640684qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8Cg/N5P25Jdo4dS96m6R9OsUU24NMu8tqGMqDHvGoY=;
        b=gBg2aOhv8H/BPabSpi7+ULC39G22QbLXumxx9Pv61ulSzm/Ni/jGHNxb6J50GX0Jbk
         Nugx5P87X/plg4hR+KcaQizxqchYiC4hpZZXRJDOsUJvOM1K00wzBT29FLsnPJZrP31N
         7zVM+SSgAJpivVrhDuwPW6vseUugaBAPBkA0FWbPWFkJOEVnLq7YH8aN91k5emVfP+Hy
         4yyce5HlM3doAyWIGYxvylxfFIeoPrsWioTOYSGExMCVJgh1s25WifivQ+WktWhfKIyH
         bJ/qher37dhjI4+XXQtBrnq78MTsOJCzh9pYAQZfbxanyQB/8jBjuCOwyQnGub7v8+Qo
         53Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8Cg/N5P25Jdo4dS96m6R9OsUU24NMu8tqGMqDHvGoY=;
        b=fxkK/DjeEnYKB1wO19bw4Vgx0Dwf2MD9p6IYAUHlWZqGoNU1q9AdSADXX1gVZG93KV
         bTJqSf0F59Oy8WP9Uv2CXY1704YBeaXSUdBIs4S1vf8lchvBnyh9TgESqtkQzOIzIn2G
         YFJkFJMimIUQMscujxFMGSjGdC+DS2jQhvmqXb8Y8W3oi1hU0ZsECFypsXR1nDJ3VVfc
         KIc5M/bATmygJFGKBJJrZMnz0Xx13TQB1UuIPYhspBCA2xZ4pKwlRoSlS0i6746UUQJ5
         uQKfwcpqA8JX2QGMJJqPMFtwpMJI2fww0lzv8AF1qC5q8r0IqfQaBakk+CutTJ+76uLs
         tayA==
X-Gm-Message-State: APjAAAUnflRvIgkcRMjrUE29ZQuQjEePBHavoDZPHnjM/nAuku5XE6VF
        QEIvZQ8sBEi9UAbf/yzLRoE0gQ==
X-Google-Smtp-Source: APXvYqxk3KZ08hW57VjKsGseG0EJUgFCoJcuMmA5WITPFsUJcPS4+YbDDiB0uZWlj3zJKFjQ5af/qQ==
X-Received: by 2002:a05:620a:1585:: with SMTP id d5mr4491002qkk.212.1556826635623;
        Thu, 02 May 2019 12:50:35 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id k36sm34366qtc.52.2019.05.02.12.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:50:35 -0700 (PDT)
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
Subject: [PATCH v3 09/10] drm/rockchip: Don't fully disable vop on self refresh
Date:   Thu,  2 May 2019 15:49:51 -0400
Message-Id: <20190502194956.218441-10-sean@poorly.run>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190502194956.218441-1-sean@poorly.run>
References: <20190502194956.218441-1-sean@poorly.run>
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

Link to v1: https://patchwork.freedesktop.org/patch/msgid/20190228210939.83386-5-sean@poorly.run
Link to v2: https://patchwork.freedesktop.org/patch/msgid/20190326204509.96515-4-sean@poorly.run

Cc: Zain Wang <wzz@rock-chips.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 45a38a332827..d171d90418c8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -134,6 +134,7 @@ struct vop {
 	bool is_enabled;
 
 	struct completion dsp_hold_completion;
+	unsigned int win_enabled;
 
 	/* protected by dev->event_lock */
 	struct drm_pending_vblank_event *event;
@@ -594,6 +595,7 @@ static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
 			const struct vop_win_data *win = vop_win->data;
 
 			VOP_WIN_SET(vop, win, enable, 0);
+			vop->win_enabled &= ~BIT(i);
 		}
 	}
 	spin_unlock(&vop->reg_lock);
@@ -624,6 +626,25 @@ static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
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
@@ -631,9 +652,15 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	WARN_ON(vop->event);
 
+	if (crtc->state->self_refresh_active)
+		rockchip_drm_set_win_enabled(crtc, false);
+
 	mutex_lock(&vop->vop_lock);
 	drm_crtc_vblank_off(crtc);
 
+	if (crtc->state->self_refresh_active)
+		goto out;
+
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
@@ -664,6 +691,8 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	clk_disable(vop->dclk);
 	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
+
+out:
 	mutex_unlock(&vop->vop_lock);
 
 	if (crtc->state->event && !crtc->state->active) {
@@ -744,6 +773,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 	spin_lock(&vop->reg_lock);
 
 	VOP_WIN_SET(vop, win, enable, 0);
+	vop->win_enabled &= ~BIT(VOP_WIN_TO_INDEX(vop_win));
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -882,6 +912,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	VOP_WIN_SET(vop, win, enable, 1);
+	vop->win_enabled |= BIT(win_index);
 	spin_unlock(&vop->reg_lock);
 }
 
@@ -1038,6 +1069,12 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
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
@@ -1648,6 +1685,7 @@ static int vop_initial(struct vop *vop)
 		VOP_WIN_SET(vop, win, channel, (channel + 1) << 4 | channel);
 		VOP_WIN_SET(vop, win, enable, 0);
 		VOP_WIN_SET(vop, win, gate, 1);
+		vop->win_enabled &= ~BIT(i);
 	}
 
 	vop_cfg_done(vop);
-- 
Sean Paul, Software Engineer, Google / Chromium OS

