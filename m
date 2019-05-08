Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B27620644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="YZjrGZw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfEHQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:09:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45369 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfEHQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:09:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id j1so6849979qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2jyUkK54dAtzW9q8l1lAlimvgbuYWM4fIyCnzJ6lOg=;
        b=YZjrGZw4u8UksJvAyaMTuVDWWzwcGobAms8CYvmqGVTNQzjWx1Hs2NxmZRsbQ8Uvd7
         amxnG6rrNuM0R+TDYWmmVRb/whuXLWPYJY1Y2Tt93+PXLZ/66MuhMNS/OUQd1iAdBH5d
         uRtfclY/vY6HiefGGfPOVD9k4p1MDxoANLs/ucwu9yDzjWPFlg1ollOsJMAeK0RyjKvn
         wKn0nF0rNWppHeNYi2zDH+5dMNBIVa1/XEww0rLUGW5Q07HiRTXCQ46Jmv1WSn2+kuAc
         mA3yksNEo40IXs+eVz+YXfRdrFH6ok/60pWp86Qt6C/Qjc00KsQOA2FaDJO41NfcIyZd
         Xm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2jyUkK54dAtzW9q8l1lAlimvgbuYWM4fIyCnzJ6lOg=;
        b=SsaJDA0Xr7vxUlClD00rw53Wa2q7dUnOwgwhCSZKmkwBqqj6MOrzyJ+al9JqM9f1pl
         joZ7RoEJu2XUlUgJwF9oRxUw+Z8exl/6RXyy3ka5nNvUqsw0Eigfgpl1doxuwHVe3Lr3
         /AGrXFdNmDQdxonbzANBdH831SPS+WsBa1h7CPq/9kWL2xISopn3xPFWMRt4WAKxmdBJ
         HrCSRFyLlD/i0hDcpzmTs7fD/Jb9w+/QATaB5nsjbVnZ5y/sMUHhBe+yXvWcUf22cgUv
         pqzsZYa37sq5TgxIFhmJln/yrhys1xBvlke1oxpUkm9y8x102m55pVQ6wSPRUk+Ya2Al
         X33g==
X-Gm-Message-State: APjAAAVbVQ6y7MObYpaiQKSSPmRCPVVaCDMP4b3ejmwnTAUO5y62YjCW
        qShfwVeYOSLlbrVpJ1oGMoDPEw==
X-Google-Smtp-Source: APXvYqzRA5IObRuPx+SY8SNlAyq+nRRa4bmVL8DgjSZ9iDXAEVZOvPWti3Ep53uWLeh2NRo1+SzXzA==
X-Received: by 2002:a37:6c81:: with SMTP id h123mr29498480qkc.201.1557331781702;
        Wed, 08 May 2019 09:09:41 -0700 (PDT)
Received: from rosewood.cam.corp.google.com ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id s50sm10936877qts.39.2019.05.08.09.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:09:41 -0700 (PDT)
From:   Sean Paul <sean@poorly.run>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] drm/rockchip: Use vop_win in vop_win_disable instead of vop_win_data
Date:   Wed,  8 May 2019 12:09:14 -0400
Message-Id: <20190508160920.144739-10-sean@poorly.run>
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

Change the argument to vop_win_disable to vop_win to accomodate future
changes to the function.

Changes in v4:
- Added to the patchset

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f89d41425be0..15a5b44eb7e7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -543,8 +543,10 @@ static void vop_core_clks_disable(struct vop *vop)
 	clk_disable(vop->hclk);
 }
 
-static void vop_win_disable(struct vop *vop, const struct vop_win_data *win)
+static void vop_win_disable(struct vop *vop, const struct vop_win *vop_win)
 {
+	const struct vop_win_data *win = vop_win->data;
+
 	if (win->phy->scl && win->phy->scl->ext) {
 		VOP_SCL_SET_EXT(vop, win, yrgb_hor_scl_mode, SCALE_NONE);
 		VOP_SCL_SET_EXT(vop, win, yrgb_ver_scl_mode, SCALE_NONE);
@@ -603,9 +605,8 @@ static int vop_enable(struct drm_crtc *crtc, struct drm_crtc_state *old_state)
 	if (!old_state || !old_state->self_refresh_active) {
 		for (i = 0; i < vop->data->win_size; i++) {
 			struct vop_win *vop_win = &vop->win[i];
-			const struct vop_win_data *win = vop_win->data;
 
-			vop_win_disable(vop, win);
+			vop_win_disable(vop, vop_win);
 		}
 	}
 	spin_unlock(&vop->reg_lock);
@@ -753,7 +754,6 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
 	struct vop_win *vop_win = to_vop_win(plane);
-	const struct vop_win_data *win = vop_win->data;
 	struct vop *vop = to_vop(old_state->crtc);
 
 	if (!old_state->crtc)
@@ -761,7 +761,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 
 	spin_lock(&vop->reg_lock);
 
-	vop_win_disable(vop, win);
+	vop_win_disable(vop, vop_win);
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -1592,7 +1592,6 @@ static void vop_destroy_crtc(struct vop *vop)
 
 static int vop_initial(struct vop *vop)
 {
-	const struct vop_data *vop_data = vop->data;
 	struct reset_control *ahb_rst;
 	int i, ret;
 
@@ -1659,12 +1658,13 @@ static int vop_initial(struct vop *vop)
 	VOP_REG_SET(vop, misc, global_regdone_en, 1);
 	VOP_REG_SET(vop, common, dsp_blank, 0);
 
-	for (i = 0; i < vop_data->win_size; i++) {
-		const struct vop_win_data *win = &vop_data->win[i];
+	for (i = 0; i < vop->data->win_size; i++) {
+		struct vop_win *vop_win = &vop->win[i];
+		const struct vop_win_data *win = vop_win->data;
 		int channel = i * 2 + 1;
 
 		VOP_WIN_SET(vop, win, channel, (channel + 1) << 4 | channel);
-		vop_win_disable(vop, win);
+		vop_win_disable(vop, vop_win);
 		VOP_WIN_SET(vop, win, gate, 1);
 	}
 
-- 
Sean Paul, Software Engineer, Google / Chromium OS

