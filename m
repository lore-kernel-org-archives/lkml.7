Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F9DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B8F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uor4jY1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfE1HjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:39:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44157 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfE1HjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:39:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so10929095pfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQVJnM2sj4R+nYxUG9Nne9l7dh6fbmTdyutm/YwtMx0=;
        b=Uor4jY1MtEZkONU2usE/MnVQd5dj3Tfn6kmxvYM/+8zfdWScV+FayauoWdU3tq05Ju
         ih+RnNavqlRUxsaidguXi8Zd1fOeNUd5Ro9TRKv1PJXlxJQeHQL20L7ps+V88GEi7fcl
         rG465zYjyVAH/BeHRWJJqxw/6W3O9t+sVEalg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQVJnM2sj4R+nYxUG9Nne9l7dh6fbmTdyutm/YwtMx0=;
        b=ixL8zdKOLmcdKLgTFaV9HTUmWZX/5B5o2gxqPGm23U4VaUBnDzaQVy5gCNyxMkVl0N
         eSR985S/QAB3WNjWn27YVwn3sA5VX6TDVJWqIbktBczxHHF5C4KyE0IZa2LyWXPFJNo/
         pDFmgtXSa7QI/ulBoWtEK1kvBu8GSAQ8WqDIUS+17WSHejV0zYHWILbL26sF4T4ztPPY
         eYLRzEO/qlm/fwYTXUc0/wD50zTym/RcjdUG43ZEDZ2lH6/WmiCECmYmC85r0N+TuT/F
         NUXIQ0F/Z0AY7nxNbsirvKlCzdh63VRm1MPOWa1kwEqjePJ4UUU/WRCsu4PFO4HQaUNZ
         UOXg==
X-Gm-Message-State: APjAAAVMnk7aWncDSun4h+L3BgbNiiIKGX+cP5PXfZYCaUg/b6hefPTs
        a5ZxcwNYjGuilyRwTW46OZN9Yw==
X-Google-Smtp-Source: APXvYqywiAh3QaSgLPIyigYkRgvfuvWVKq0aWO68kqF5JZeJL6svt+W4rpHA95UclwnXxcNmKYqIow==
X-Received: by 2002:a63:af44:: with SMTP id s4mr129350119pgo.411.1559029156377;
        Tue, 28 May 2019 00:39:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id g8sm1628011pjp.17.2019.05.28.00.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 00:39:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
Date:   Tue, 28 May 2019 15:39:08 +0800
Message-Id: <20190528073908.633-1-hsinyi@chromium.org>
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
change log v2->v3:
* remove unnecessary codes in unbind
* based on discussion in v2, if we move mtk_dsi_start() to mtk_dsi_poweron(),
in order to make mtk_dsi_start() and mtk_dsi_stop() symmetric, will results in
no irq for panel with bridge. So we keep mtk_dsi_start() in original place.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..b7f829ecd3ad 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -630,6 +630,8 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
+	mtk_dsi_stop(dsi);
+
 	if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
 		if (dsi->panel) {
 			if (drm_panel_unprepare(dsi->panel)) {
@@ -696,7 +698,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
-	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
-- 
2.20.1

