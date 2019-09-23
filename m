Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C15C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB020820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502106AbfIWM4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:56:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:48504 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437533AbfIWM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:56:08 -0400
Received: from localhost (unknown [192.168.167.227])
        by lucky1.263xmail.com (Postfix) with ESMTP id DE03566909;
        Mon, 23 Sep 2019 20:48:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14169T140710336407296S1569242883858959_;
        Mon, 23 Sep 2019 20:48:21 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <029ba5340883946e18a39005adc9a83e>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/36] drm/mediatek: use bpp instead of cpp for drm_format_info
Date:   Mon, 23 Sep 2019 20:47:39 +0800
Message-Id: <1569242880-182878-5-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
References: <1569242880-182878-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpp[BytePerPlane] can't describe the 10bit data format correctly,
So we use bpp[BitPerPlane] to instead cpp.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_fb.c    | 2 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
index 3f230a2..fd80548 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
@@ -69,7 +69,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
 	if (!gem)
 		return ERR_PTR(-ENOENT);
 
-	bpp = info->cpp[0];
+	bpp = info->bpp[0] / 8;
 	size = (height - 1) * cmd->pitches[0] + width * bpp;
 	size += cmd->offsets[0];
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 584a9ec..97d38db 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -121,7 +121,7 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	pitch = fb->pitches[0];
 	format = fb->format->format;
 
-	addr += (plane->state->src.x1 >> 16) * fb->format->cpp[0];
+	addr += (plane->state->src.x1 >> 16) * fb->format->bpp[0] / 8;
 	addr += (plane->state->src.y1 >> 16) * pitch;
 
 	state->pending.enable = true;
-- 
2.7.4



