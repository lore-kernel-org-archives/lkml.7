Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C16253A5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CafCN9m8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfE3JSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:18:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40007 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfE3JSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:18:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so1656452pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiM9lQChj12NVhLaqvQMt0hxwIJhnj7lqdz7I6Ifl9k=;
        b=CafCN9m8YypnM2GI7SEoCWLj8aK6f3cTJiEE3GUT0CIR1isix8CftjLmtVJNfjlFWw
         SPB9eFwkyaw6VXXg2KN2vlPYwFj0jhn1+6k3hZX3oAaJ8LMlzseUF7qEqNiHaqfdEL+a
         b3DdhF8j/Wt6ijQK6bSDDPS6TLrQZ+6ZbPfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiM9lQChj12NVhLaqvQMt0hxwIJhnj7lqdz7I6Ifl9k=;
        b=CkRUpWQyEgGVOyYw5StlD+QhULN/BMmzsEsQELwpNwqZNYbEyZopqaHU8q2KQnKdEd
         BWNM3bnHtsFo7ELf3mmUiz8k5mmiftC+f9q8YBR9fzDAcXpOzzhZXELogCThN4Nx1sgG
         qC+d1e+DzeeHp35IMNWU0SKsES21nTb1/fAh3f2meG8kfZGd2/fq4r/SyEfCB8fKtUQ4
         AytsDDRTwYpyxv5PCP2i3lTW9dpOfOSdy2XOqwIYQGByBTTSOm18Fd1/etFD0n+YVyC6
         lpxSEhzgTkqghM1TRQrnanvEsOPQKUoIhlNdCfIS0Aeqs0djWfPZJ1i0zvRUtWbaEjS+
         FeTA==
X-Gm-Message-State: APjAAAVz/lh+MF9vwt0YXCdCD0ZfBTVUnQspdmR1q9U1VceGjhgs84QW
        ipCSjgJt0kmh+MJErPB/NWjfTg==
X-Google-Smtp-Source: APXvYqyR2TapAsuf4Y55MbptIVWHJtSABFxvasONsBUaove+y19OR5W0sbkiLKtro5lpzENh/qk8+g==
X-Received: by 2002:a05:6a00:cc:: with SMTP id e12mr2753772pfj.207.1559207933788;
        Thu, 30 May 2019 02:18:53 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id o2sm1720924pgm.51.2019.05.30.02.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 02:18:52 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
Date:   Thu, 30 May 2019 17:18:47 +0800
Message-Id: <20190530091847.90263-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(), which needs
ovl irq for drm_crtc_wait_one_vblank(), since after mtk_dsi_stop() is called,
ovl irq will be disabled. If drm_crtc_wait_one_vblank() is called after last
irq, it will timeout with this message: "vblank wait timed out on crtc 0". This
happens sometimes when turning off the screen.

In drm_atomic_helper.c#disable_outputs(),
the calling sequence when turning off the screen is:

1. mtk_dsi_encoder_disable()
     --> mtk_output_dsi_disable()
       --> mtk_dsi_stop();  // sometimes make vblank timeout in atomic_disable
       --> mtk_dsi_poweroff();
2. mtk_drm_crtc_atomic_disable()
     --> drm_crtc_wait_one_vblank();
     ...
       --> mtk_dsi_ddp_stop()
         --> mtk_dsi_poweroff();

mtk_dsi_poweroff() has reference count design, change to make mtk_dsi_stop()
called in mtk_dsi_poweroff() when refcount is 0.

Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change log v3->v4:
* add comment in code.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..730594a91440 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -630,6 +630,15 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
+	/* 
+	 * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
+	 * mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(),
+	 * which needs irq for vblank, and mtk_dsi_stop() will disable irq.
+	 * mtk_dsi_start() needs to be called in mtk_output_dsi_enable(),
+	 * after dsi is fully set.
+	 */
+	mtk_dsi_stop(dsi);
+
 	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
 		if (dsi->panel) {
 			if (drm_panel_unprepare(dsi->panel)) {
@@ -696,7 +705,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
-	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
-- 
2.20.1

