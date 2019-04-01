Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C13C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693D9208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142229;
	bh=fQQDvux8nnoTJk5jJnKdXYY0oK6niHNNEQVSvn21rh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rz5bZFX5MOf34AjsvbgItmKHzL90CymPy/WmP6SKdNdZJRYRpPBaSAm+qKBrxjjq7
	 CjV9J7oM+mEQ2XWnyeVSiJSA/wAdNuO70Wu72WutgoXGcEyjJss7IKTHc+g4VUhZ55
	 59S2A/kHkSHZm4kJyHRZM5CqcC0mOG8p1QNHKtug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDASK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbfDARH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472B921924;
        Mon,  1 Apr 2019 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138475;
        bh=fQQDvux8nnoTJk5jJnKdXYY0oK6niHNNEQVSvn21rh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue/3J15Yr0slFKjUgEWZ26IFLOIX5s4p6DZbCxRUpZtH9uyKrHyR9swOcKw2Og+WB
         /u0c7XiEl4rymZatbRlhM2VSL9nI8bYvVBlxIjth5O6R2nUap6eOBl6dnPEh/YFjsG
         T2RbomGD04LeffikQu1v65J+Milb+pkZLvW4BQeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.0 076/146] drm/rockchip: vop: reset scale mode when win is disabled
Date:   Mon,  1 Apr 2019 19:01:28 +0200
Message-Id: <20190401170055.250377321@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

commit e9abc611a941d4051cde1d94b2ab7473fdb50102 upstream.

NV12 framebuffers produced by the VPU shows distorted on RK3288
after win has been disabled when scaling is active.

This issue can be reproduced using a 1080p modeset by:
- Scale a 1280x720 NV12 framebuffer to 1920x1080 on win0
- Disable win0
- Display a 1920x1080 NV12 framebuffer without scaling on win0
- Output will now show the framebuffer distorted

And by:
- Scale a 1280x720 NV12 framebuffer to 1920x1080
- Change to a 720p modeset (win gets disabled and scaling reset to none)
- Output will now show the framebuffer distorted

Fix this by setting scale mode to none when win is disabled.

Fixes: 4c156c21c794 ("drm/rockchip: vop: support plane scale")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/AM3PR03MB0966DE3E19BACE07328CD637AC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -511,6 +511,18 @@ static void vop_core_clks_disable(struct
 	clk_disable(vop->hclk);
 }
 
+static void vop_win_disable(struct vop *vop, const struct vop_win_data *win)
+{
+	if (win->phy->scl && win->phy->scl->ext) {
+		VOP_SCL_SET_EXT(vop, win, yrgb_hor_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, yrgb_ver_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, cbcr_hor_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, cbcr_ver_scl_mode, SCALE_NONE);
+	}
+
+	VOP_WIN_SET(vop, win, enable, 0);
+}
+
 static int vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
@@ -556,7 +568,7 @@ static int vop_enable(struct drm_crtc *c
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win = vop_win->data;
 
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 	}
 	spin_unlock(&vop->reg_lock);
 
@@ -700,7 +712,7 @@ static void vop_plane_atomic_disable(str
 
 	spin_lock(&vop->reg_lock);
 
-	VOP_WIN_SET(vop, win, enable, 0);
+	vop_win_disable(vop, win);
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -1476,7 +1488,7 @@ static int vop_initial(struct vop *vop)
 		int channel = i * 2 + 1;
 
 		VOP_WIN_SET(vop, win, channel, (channel + 1) << 4 | channel);
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 		VOP_WIN_SET(vop, win, gate, 1);
 	}
 


