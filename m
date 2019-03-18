Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5572085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vv2+JK0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfCREJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:09:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCREJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:09:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so3542095pff.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 21:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5EKXBALYEwdk9E9LRVZlQ6e7qbUkPvzI+TKapn/pPc=;
        b=Vv2+JK0g+Q3XAT84IcZLW9ZhWuuBF7Ger9uIs5AEOIUsO6v0XTJPss7XXf+1HMuJzB
         Ny/PFZ2ubwiSyCl06zztNTJEbRwBlBt59wir15qLkoXTQDZmkDJseV8rY+a9+dh5hIM1
         lDqIip/t31OoVJNjIrBYVefSCa73QXBBCxYQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i5EKXBALYEwdk9E9LRVZlQ6e7qbUkPvzI+TKapn/pPc=;
        b=nEYTd077FGwNfvmWNNak2EJlx5LCBstwPPkXdYtH3SHjvchGchC586Bs6FNtvIcGuh
         ie2fXDHE6Ua2jLp1R/34r2C+gAaQP519ZDXi7VxGB5+HoBmua0E99ukOAwubORwyQ2aS
         50E828QdLb9Y+pfoRJsmq3pwoUajqARH1rcO0NBPcZd35JdD0Mjt0vRPNv99DFCJeQLV
         IgISkoXC4tuQUQysZuRL2Im/FMXgnU+D+YApaMIAeMersltLpFZZRwpWxoVAgfvsMJ7p
         IwHv+9flH0bi3C5EU80ki2jlOMun75WCjGp4koDo2mzBJmk7mbxzT1eflDjMQrcbuVwI
         v2Ig==
X-Gm-Message-State: APjAAAXDdSqNuBiIopG1PW8G+rsf035xj27VOAFoonc9lN5eLV9/6Wzs
        w4XeaCMNFyPuZfgICLreLK3RAw==
X-Google-Smtp-Source: APXvYqzDJRpIyEqsZICxFfV0bdzLRJ6o67alJ+dyAvsWtaokWT6OL1N3yfo3KGLp5baYHDZFa7FbJQ==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr17209005pfi.138.1552882166442;
        Sun, 17 Mar 2019 21:09:26 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id k16sm5859126pfa.17.2019.03.17.21.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 21:09:25 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm: mediatek: call mtk_dsi_stop() after mtk_drm_crtc_atomic_disable()
Date:   Mon, 18 Mar 2019 12:09:15 +0800
Message-Id: <20190318040915.101218-1-hsinyi@chromium.org>
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

Change to make mtk_dsi_stop() called in mtk_dsi_ddp_stop() instead of
mtk_output_dsi_disable().

Fixes: 0707632b5bac ("drm/mediatek: update DSI sub driver flow for sending commands to panel")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..cdd9637dd517 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -696,7 +696,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 		}
 	}
 
-	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 
 	dsi->enabled = false;
@@ -857,6 +856,7 @@ static void mtk_dsi_ddp_stop(struct mtk_ddp_comp *comp)
 {
 	struct mtk_dsi *dsi = container_of(comp, struct mtk_dsi, ddp_comp);
 
+	mtk_dsi_stop(dsi);
 	mtk_dsi_poweroff(dsi);
 }
 
@@ -1178,6 +1178,8 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 	struct mtk_dsi *dsi = platform_get_drvdata(pdev);
 
 	mtk_output_dsi_disable(dsi);
+	mtk_dsi_stop(dsi);
+	mtk_dsi_poweroff(dsi);
 	component_del(&pdev->dev, &mtk_dsi_component_ops);
 
 	return 0;
-- 
2.20.1

