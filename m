Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F00C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5C72070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RwOyeu/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfK0KE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:04:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45728 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK0KE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:04:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so10539613pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fla0mLE3kPARMpuw52rBb145CpRIcrUfv5y6FZzfYow=;
        b=RwOyeu/bPVGltW59qJ4ylCblmR5cOGkzUq9UNiaKHpWvfQPMChAxhON+4bSUJovU8n
         zUPQsv3tpq+x4Lwhx4KaW+DIEzK+DzY9Kc7Cg5Lh4sj0Tgu9zIi8ibZ8YPn58QTJuUO+
         G4lekg7BfIooWsOH7uQR0q7Y9LKF4gHyFwK9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fla0mLE3kPARMpuw52rBb145CpRIcrUfv5y6FZzfYow=;
        b=mVA9+6X0yREkS3Z9Nr7IaD/AZeL2O0x86nRjv3lRkd4XfZ4hah1rqTuRApROxEneo2
         0iRtzvsePGImBT16LqsHunTq/wKx9zHxjxeA8D8KfLAzZTuqm7GmIgLLYL9gTFli7gxA
         SZCLc38dc9rfxndtTO1ahBHMr2uRglYEVmHZVehZkj4KFIL8BuThh3a2uQI4hJpT1ga5
         /Nh2FS8YiPxQkBOxzVEz+CjzIiAlJx1L4UZNAQMInIYa/iGGgYA+lHYK6mjLnzbUK8rl
         E0gCThKSvcsZB2HdnEDqpNY/+d+4BbalRUVZaOd/UrwPWcLAMVcvimfj9GAaR0IoZDiU
         w+Fg==
X-Gm-Message-State: APjAAAUmT3HHThC1WUpSYz7XkqxCFOnOI6Gd74SMk5C+1xutRnPNvoOp
        hAMfBJJYaeBeQak8hKgs6Cde/Q==
X-Google-Smtp-Source: APXvYqzXspCMDcVbYgH/6lgSpThq/u782otjCOXgjkwhYm6xw8BQ13uACOi72z9Q3T6FJKzNAto7hg==
X-Received: by 2002:a65:4809:: with SMTP id h9mr3814513pgs.265.1574849067339;
        Wed, 27 Nov 2019 02:04:27 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id n18sm16063907pff.152.2019.11.27.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:04:26 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
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
Subject: [PATCH] drm/mediatek: Fix can't get component for external display plane.
Date:   Wed, 27 Nov 2019 18:04:19 +0800
Message-Id: <20191127100419.130300-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

The original logic is ok for primary display, but will not find out
component for external display.

For example, plane->index is 6 for external display, but there are only
2 layer nr in external display, and this condition will never happen:
if (plane->index < (count + mtk_ddp_comp_layer_nr(comp)))

Fix this by using the offset of the plane to mtk_crtc->planes as index,
instead of plane->index.

Fixes: d6b53f68356f ("drm/mediatek: Add helper to get component for a plane")
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index f80a8ba75977..b34e7d70702a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -215,11 +215,12 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	struct mtk_ddp_comp *comp;
 	int i, count = 0;
+	unsigned int local_index = plane - mtk_crtc->planes;
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		comp = mtk_crtc->ddp_comp[i];
-		if (plane->index < (count + mtk_ddp_comp_layer_nr(comp))) {
-			*local_layer = plane->index - count;
+		if (local_index < (count + mtk_ddp_comp_layer_nr(comp))) {
+			*local_layer = local_index - count;
 			return comp;
 		}
 		count += mtk_ddp_comp_layer_nr(comp);

base-commit: 1875ff320f14afe21731a6e4c7b46dd33e45dfaa
-- 
2.24.0.393.g34dc348eaf-goog

