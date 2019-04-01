Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C92206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139109;
	bh=191lzMHPkxWGmDTuymxtLjBtDXNxCLoZcSduJHGGDD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jf+w0a4IUSIU+wJMGi8DKyJTZXsDGQqs/2rz85Jd2fpSIq3GEQBXHjkiF/KoI+IH6
	 5UvVVen+PQtUegXz5eli9jGNSR00iY/hL2zQVQHgTnyKt5oorbWUAPvchQcgpjWCz5
	 0Tr5veu5nn+LRv+FX6b/f5LlscARlsaYtc84AyZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfDARS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731365AbfDARSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AB120856;
        Mon,  1 Apr 2019 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139103;
        bh=191lzMHPkxWGmDTuymxtLjBtDXNxCLoZcSduJHGGDD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrGHOVN89MWsh+ktMsZypI/lAB5z39LziZ6oYKtbcaTCBwxdFsPEucrTavCsZcFlN
         1MedK1hz/78gNrd5on4FxjhnkqK/xOF3iw9UEdLQOLBLdgyTFpVeFycGLcnllXN7zs
         7ufuF1YaolbdZ4994vfpG00I42KfcDsqP6f/vq1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 077/134] drm/rockchip: vop: reset scale mode when win is disabled
Date:   Mon,  1 Apr 2019 19:01:53 +0200
Message-Id: <20190401170051.606263072@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -505,6 +505,18 @@ static void vop_core_clks_disable(struct
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
@@ -550,7 +562,7 @@ static int vop_enable(struct drm_crtc *c
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win = vop_win->data;
 
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 	}
 	spin_unlock(&vop->reg_lock);
 
@@ -694,7 +706,7 @@ static void vop_plane_atomic_disable(str
 
 	spin_lock(&vop->reg_lock);
 
-	VOP_WIN_SET(vop, win, enable, 0);
+	vop_win_disable(vop, win);
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -1449,7 +1461,7 @@ static int vop_initial(struct vop *vop)
 		int channel = i * 2 + 1;
 
 		VOP_WIN_SET(vop, win, channel, (channel + 1) << 4 | channel);
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 		VOP_WIN_SET(vop, win, gate, 1);
 	}
 


