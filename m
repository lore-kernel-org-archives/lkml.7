Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D93C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC12075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HF/zJF0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfE0Evc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:51:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40876 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Evc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:51:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so6554991plb.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqtXYGK6k+BsF6lFW0Ln3+MfttYOEkXamBERmqOmC5Y=;
        b=HF/zJF0QdICLy7NJ4bW6FA9TCLsUv3ADJGYPEPuA3By1u7Y8V2Rl/zlVDy2sdKk81o
         IbxnGSFNNx2FgwLaedCVxPoaF9ANY3vK9P0MF5dAYMhvATfvsyTjwFBSMA0sEktklVak
         GoJSPLBV+x21zj7b9LVfsAHc8PGNEre2C1GFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqtXYGK6k+BsF6lFW0Ln3+MfttYOEkXamBERmqOmC5Y=;
        b=bjGhmYMxM2R6y2dOSrTqcql7oYngqoduLOavPCAkDwiKLnb80taIlu2Ibq+D6u79f5
         DNHiuIzRV3/aDSeJ080rK+ioghRAyWTwPeeeFfvGNzKIU2gookqEigLuGNC2PgUYNgcJ
         sNHHIYWUP+4qKQkRxBSVCDXc1wDyI1P2V1ZiMTt1EGI1Sk3UUMgvQWEdnV4PE8QZRWNU
         QAKBXD4vquY4VZzedERLJK8SkR+r7talZxS/r93d7iQoXMfHqetyTIXIfifYR5ua472d
         kTpT1Wq+A8FKMR9Nvh2fPqtSN1BgGfbovhzTUTtjXNkEn39IjZsvpccWfr0jzrZbc2ku
         g0Dw==
X-Gm-Message-State: APjAAAWv9nKH4RdAqwleLM26I86NeWGZMrMjN2aoPAJtkrDi5+MMKoiC
        h+9RJzzUKGdu7ngVyOhjs8y9pw==
X-Google-Smtp-Source: APXvYqx3i22O/tAoY6zgk8Ct9ltJx/aRFrpHG2CUs0/G8ATOoqFQULNscuyQ9TI0cY5+0fUmhDePyw==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr77262990plb.240.1558932691335;
        Sun, 26 May 2019 21:51:31 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id t18sm8082745pgm.69.2019.05.26.21.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:51:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm: mediatek: fix unbind functions
Date:   Mon, 27 May 2019 12:50:52 +0800
Message-Id: <20190527045054.113259-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527045054.113259-1-hsinyi@chromium.org>
References: <20190527045054.113259-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move mipi_dsi_host_unregister() to .remove since mipi_dsi_host_register()
is called in .probe.

detatch panel in mtk_dsi_destroy_conn_enc(), since .bind will try to
attach it again.

Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b00eb2d2e086..c9b6d3a68c8b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -844,6 +844,8 @@ static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
 	/* Skip connector cleanup if creation was delegated to the bridge */
 	if (dsi->conn.dev)
 		drm_connector_cleanup(&dsi->conn);
+	if (dsi->panel)
+		drm_panel_detach(dsi->panel);
 }
 
 static void mtk_dsi_ddp_start(struct mtk_ddp_comp *comp)
@@ -1073,7 +1075,6 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
 	struct mtk_dsi *dsi = dev_get_drvdata(dev);
 
 	mtk_dsi_destroy_conn_enc(dsi);
-	mipi_dsi_host_unregister(&dsi->host);
 	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
 }
 
@@ -1179,6 +1180,7 @@ static int mtk_dsi_remove(struct platform_device *pdev)
 
 	mtk_output_dsi_disable(dsi);
 	component_del(&pdev->dev, &mtk_dsi_component_ops);
+	mipi_dsi_host_unregister(&dsi->host);
 
 	return 0;
 }
-- 
2.20.1

