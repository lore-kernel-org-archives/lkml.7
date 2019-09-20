Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9133C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6742B217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+0UPmc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437129AbfITEJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 00:09:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36828 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfITEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 00:09:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so2586326plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0oUa+nPUEvwigLfR3fD8q9hrkFh2FBtsVieYBDhI8lY=;
        b=t+0UPmc6wGPCQgjN9ywEuN9WkeB4yE3EoKdnC8or0/CUcF7IpBsa4Rt0AeodxY9H26
         Sbke6hm2L/NupFGFy45tfdG3STwZqZf7Ua8kaKoewEJuk32RIYTE+pQPSgKJWoWpjJaf
         aC3BrfxI1C39ZD82M4DZGnVpeuO0VgypfiNmkLPu+MG6qaofXd5+96VqCG4juHyl7ZcZ
         vXXlBYVzt5WYfFy4groT8mAqQFms1w7IKufmCEOhiviYQVBboiVIAQjvndEfaOJNt6je
         yNELpJlBttA3BHjldBXrP+4GDVTQe3C1frBIjoOBib3P/wCY8v/25hqcWrINtPnfQDib
         mtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0oUa+nPUEvwigLfR3fD8q9hrkFh2FBtsVieYBDhI8lY=;
        b=IgOkyHauaflRnqqjgy7RbpBeMkmfRrWxsm8yIjWRDa+XKhcFLLJanHM/Zn3hYuud3V
         57hcevY6s2EJaNN9RrMkReM/4MySrphsCLfTaKVjwiqFVyRCZ5zTOAXMJmlm0k5fwxJj
         i3caru21kJhY6J+QZlNsHmDKcuDQaqQDGG0khF7V3vONpuwrdz4dI+V9FHcjU5o7Is9R
         mhzyjfsFZemXdXtEnavRT5eSuvAoHFIrkjfKnNsoVZosWi1muyO624WP/zLp0KduRbds
         DFp63VSZwKDLYKAgOTgqpm8IAk+gryXnGtH1CVViyg8ktc5UOKu7v69Q72+U9q0C0TWN
         W/rQ==
X-Gm-Message-State: APjAAAX+n8nBu3Gjz4br0cTyG8oTq/B7p/GjvJPNPXdmiQbA8zz/DFJp
        3oGKLbg5BsSfIco11qvQlOK2Ai8CvTQ=
X-Google-Smtp-Source: APXvYqzH4t1yaoaVE0lE/1Nd2Gz2y6Q1Kf1m10aa38+RZcv73Em0v3I7/rmIsWDBianbHj/CqX5Avg==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr14449000plo.152.1568952560554;
        Thu, 19 Sep 2019 21:09:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d5sm610016pfa.180.2019.09.19.21.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 21:09:19 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2] drm: kirin: Fix dsi probe/attach logic
Date:   Fri, 20 Sep 2019 04:09:15 +0000
Message-Id: <20190920040915.73599-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
host at probe time") landed in -next the HiKey board would fail
to boot, looping:

  adv7511 2-0039: failed to find dsi host

messages over and over. Andrzej Hajda suggested this is due to a
circular dependency issue, and that the adv7511 change is
correcting the improper order used earlier.

Unfortunately this means the DSI drivers that use adv7511 need
to also need to be updated to use the proper ordering to
continue to work.

This patch tries to reorder the initialization to register the
dsi_host first, and then call component_add via dsi_host_attach,
instead of doing that at probe time.

This seems to resolve the issue with the HiKey board.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Matt Redfearn <matt.redfearn@thinci.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Fixes: 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI host at probe time")
Signed-off-by: John Stultz <john.stultz@linaro.org>
Change-Id: Ia42345f81b4955a732d0251f1d1ddb118f885299
---
v2: Reordered platform_set_drvdata and dsi_host_init, suggested
    by Andrzej

Note: I'm really not super familiar with the DSI code here,
and am mostly just trying to refactor the existing code in a
similar fashion to the suggested dw-mipi-dsi-rockchip.c
implementation. Careful review would be greatly appreciated!
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 107 +++++++++----------
 1 file changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 5bf8138941de..0ddf22a8be0f 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -79,6 +79,7 @@ struct dsi_hw_ctx {
 };
 
 struct dw_dsi {
+	struct device *dev;
 	struct drm_encoder encoder;
 	struct drm_bridge *bridge;
 	struct mipi_dsi_host host;
@@ -724,51 +725,6 @@ static int dw_drm_encoder_init(struct device *dev,
 	return 0;
 }
 
-static int dsi_host_attach(struct mipi_dsi_host *host,
-			   struct mipi_dsi_device *mdsi)
-{
-	struct dw_dsi *dsi = host_to_dsi(host);
-
-	if (mdsi->lanes < 1 || mdsi->lanes > 4) {
-		DRM_ERROR("dsi device params invalid\n");
-		return -EINVAL;
-	}
-
-	dsi->lanes = mdsi->lanes;
-	dsi->format = mdsi->format;
-	dsi->mode_flags = mdsi->mode_flags;
-
-	return 0;
-}
-
-static int dsi_host_detach(struct mipi_dsi_host *host,
-			   struct mipi_dsi_device *mdsi)
-{
-	/* do nothing */
-	return 0;
-}
-
-static const struct mipi_dsi_host_ops dsi_host_ops = {
-	.attach = dsi_host_attach,
-	.detach = dsi_host_detach,
-};
-
-static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
-{
-	struct mipi_dsi_host *host = &dsi->host;
-	int ret;
-
-	host->dev = dev;
-	host->ops = &dsi_host_ops;
-	ret = mipi_dsi_host_register(host);
-	if (ret) {
-		DRM_ERROR("failed to register dsi host\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int dsi_bridge_init(struct drm_device *dev, struct dw_dsi *dsi)
 {
 	struct drm_encoder *encoder = &dsi->encoder;
@@ -796,10 +752,6 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	ret = dsi_host_init(dev, dsi);
-	if (ret)
-		return ret;
-
 	ret = dsi_bridge_init(drm_dev, dsi);
 	if (ret)
 		return ret;
@@ -817,13 +769,22 @@ static const struct component_ops dsi_ops = {
 	.unbind	= dsi_unbind,
 };
 
-static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
+static int dsi_host_attach(struct mipi_dsi_host *host,
+			   struct mipi_dsi_device *mdsi)
 {
-	struct dsi_hw_ctx *ctx = dsi->ctx;
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
+	struct dw_dsi *dsi = host_to_dsi(host);
+	struct device_node *np = dsi->dev->of_node;
 	int ret;
 
+	if (mdsi->lanes < 1 || mdsi->lanes > 4) {
+		DRM_ERROR("dsi device params invalid\n");
+		return -EINVAL;
+	}
+
+	dsi->lanes = mdsi->lanes;
+	dsi->format = mdsi->format;
+	dsi->mode_flags = mdsi->mode_flags;
+
 	/*
 	 * Get the endpoint node. In our case, dsi has one output port1
 	 * to which the external HDMI bridge is connected.
@@ -832,6 +793,42 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
 	if (ret)
 		return ret;
 
+	return component_add(dsi->dev, &dsi_ops);
+}
+
+static int dsi_host_detach(struct mipi_dsi_host *host,
+			   struct mipi_dsi_device *mdsi)
+{
+	/* do nothing */
+	return 0;
+}
+
+static const struct mipi_dsi_host_ops dsi_host_ops = {
+	.attach = dsi_host_attach,
+	.detach = dsi_host_detach,
+};
+
+static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
+{
+	struct mipi_dsi_host *host = &dsi->host;
+	int ret;
+
+	host->dev = dev;
+	host->ops = &dsi_host_ops;
+	ret = mipi_dsi_host_register(host);
+	if (ret) {
+		DRM_ERROR("failed to register dsi host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
+{
+	struct dsi_hw_ctx *ctx = dsi->ctx;
+	struct resource *res;
+
 	ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(ctx->pclk)) {
 		DRM_ERROR("failed to get pclk clock\n");
@@ -862,6 +859,7 @@ static int dsi_probe(struct platform_device *pdev)
 	}
 	dsi = &data->dsi;
 	ctx = &data->ctx;
+	dsi->dev = &pdev->dev;
 	dsi->ctx = ctx;
 
 	ret = dsi_parse_dt(pdev, dsi);
@@ -869,8 +867,7 @@ static int dsi_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, data);
-
-	return component_add(&pdev->dev, &dsi_ops);
+	return dsi_host_init(&pdev->dev, dsi);
 }
 
 static int dsi_remove(struct platform_device *pdev)
-- 
2.17.1

