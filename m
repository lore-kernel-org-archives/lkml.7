Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4562AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B902071E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXpHZhA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfKRGSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:18:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34008 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfKRGSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:18:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so9184458plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In3dXboSGxSDc4571/sMxtCG8no6hvyudyiC85O5ndo=;
        b=BXpHZhA/xlBopIauk0uUtCcrKTLJpeohwqpkdx+pyeB6cHC23OkMv5szao3WoFQgWG
         bpGQhs8COapoRUFUUwCikZIhzDyoPIVni7BgFnJxCR8+nXcXKRftiZoiC0dq8IG2LBaL
         aXBBWuLKQw+ZwkDv48ctSYKopX322s7+2kZLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In3dXboSGxSDc4571/sMxtCG8no6hvyudyiC85O5ndo=;
        b=WXchEEwRMpIB5UYI7qggeOpkV34QJxjkTsEXE9RS2xJQK+CT5HffdKoKq6s5Yimgvy
         XbMWgOeothCIIEIsSC/ntpUtra8EDF5fWovlspVxCQX3IlU1Fe5777tIQ9PlEUuQP8/g
         tYPjiYuDLGbkGFDv8z6Q6QanHZrIHXwIedvWDGwjPoYnZJWQHyWRxnFonrCMheH/CfQ0
         aWc0c64wn1npPrbGZ9lD2Zbo72OBer7kKlyHG2MA5F9hDDfBuSR0ZDjRh26hmsxt42Zk
         B3pPvMvR2Lo+LHbKFu4tjPv2LLf1if35r54BmUqvdufxXksqsW/DsFQRR1C/PAwR9mB6
         BEnA==
X-Gm-Message-State: APjAAAXSuOQLHP6HiO//tAnaXDEE1fexiqHz5iU/OO8ps1otsvCvz7ug
        EztvQx5redUyQpO+t/C0SIqVcg==
X-Google-Smtp-Source: APXvYqxnGeAgTQrGlxhEM7cTtw/taIbeaI+NICqi0AiVOjf/RFlGTltFPJg8umDnYkhUrvkNVqGXOw==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr21453839plo.35.1574057915737;
        Sun, 17 Nov 2019 22:18:35 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id g4sm18589682pfh.172.2019.11.17.22.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 22:18:35 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/mediatek: Check return value of mtk_drm_ddp_comp_for_plane.
Date:   Mon, 18 Nov 2019 14:18:05 +0800
Message-Id: <20191118061806.52781-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_drm_ddp_comp_for_plane can return NULL, but the usage doesn't
check for it. Add check for it.

Fixes: d6b53f68356f ("drm/mediatek: Add helper to get component for a plane")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index f80a8ba75977..4c4f976c994e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -310,7 +310,9 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 
 		plane_state = to_mtk_plane_state(plane->state);
 		comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
-		mtk_ddp_comp_layer_config(comp, local_layer, plane_state);
+		if (comp)
+			mtk_ddp_comp_layer_config(comp, local_layer,
+						  plane_state);
 	}
 
 	return 0;
@@ -386,8 +388,9 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 			comp = mtk_drm_ddp_comp_for_plane(crtc, plane,
 							  &local_layer);
 
-			mtk_ddp_comp_layer_config(comp, local_layer,
-						  plane_state);
+			if (comp)
+				mtk_ddp_comp_layer_config(comp, local_layer,
+							  plane_state);
 			plane_state->pending.config = false;
 		}
 		mtk_crtc->pending_planes = false;
@@ -401,7 +404,9 @@ int mtk_drm_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
 	struct mtk_ddp_comp *comp;
 
 	comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
-	return mtk_ddp_comp_layer_check(comp, local_layer, state);
+	if (comp)
+		return mtk_ddp_comp_layer_check(comp, local_layer, state);
+	return 0;
 }
 
 static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,

base-commit: 5a6fcbeabe3e20459ed8504690b2515dacc5246f
-- 
2.24.0.432.g9d3f5f5b63-goog

