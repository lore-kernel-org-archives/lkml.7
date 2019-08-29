Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7BFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E924920828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQ1LpoJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfH2GGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:06:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46247 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfH2GGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:06:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so1299478pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eMIJ3TsGhGRnuDNUUwc9l4LSobYBmRitdXnR8ZzJ74U=;
        b=eQ1LpoJsZsj+y0hpH5fbRMtmOsIeHPLYeOUl7EV7TPv9Alp6hnVmYUlBqiJ1LPjKLc
         TZ3MvG2VKp8n7i1bTTjar/PCjptvFh/iTHeXAcKFcmJLt4oaJnpJY0yn5GjN3ARMrWUc
         tQj0cIlhCJj4R30g4+Huh6uF2W9e94AM42pZUebGhRLersAUdVLtzw1aM/N+32Oe/LdI
         KcGJGlfMYabqhQeABTnmZmmcwA3/Ux7HWLmk9In+wHtCQ1AE7nenJpkSAzqTfU7WkiKk
         BmU/zIFSLMUAucQHecW9+6PAUgr+Nzko5xNGAmt3QAAqyasd9s+mtXMXMXC0u5324V+d
         0jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eMIJ3TsGhGRnuDNUUwc9l4LSobYBmRitdXnR8ZzJ74U=;
        b=VnjcZBmF+nWegJduI/i0249azz20lQPvhM09fUU/3PSbNtqxUWwwj/SsTxJbeshgqR
         YsSlr+fE3X1o0Zr7pKMcp+oWWaXvXt1G1VFE7cOUVZN5wnv7A5zQ1bAoxlz3xVgrR42Y
         roderqLzoCv7suTAihnm8Rtb1DpRjRgncK+ob3j2hmh/9jDd5b3aKHwEmHLU/pueNDwV
         K1qZq+bNkFBBPyMQFC2vg7UzsrCsarlp7/t710rXonm5jANfUAG0gAyPnN6BV7A5w/a9
         s6x4bZIHfwhiHZUyut7B7nE8EGSOiaYnnfNCz9otUt/d0iwNFseInRH23poIxq7fQMXD
         1ppw==
X-Gm-Message-State: APjAAAXewTqTpNWglfN1Q3DBrYI2F2X7H67/6q1QBcLnOVb7P+gy/7Pa
        csDKsketpikFlGO6dzItjD+JWcSRdIg=
X-Google-Smtp-Source: APXvYqyNUXSxwwJvVKiyeJmH5S2YfzX34ueJxZOAozvHNaJhvrDmMYSk/wPXaSO8RPguBig9q6Iy7A==
X-Received: by 2002:a65:6152:: with SMTP id o18mr6507955pgv.279.1567058760907;
        Wed, 28 Aug 2019 23:06:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a6sm1504397pfa.162.2019.08.28.23.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 23:06:00 -0700 (PDT)
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
Subject: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
Date:   Thu, 29 Aug 2019 06:05:50 +0000
Message-Id: <20190829060550.62095-1-john.stultz@linaro.org>
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
---
Note: I'm really not super familiar with the DSI code here,
and am mostly just trying to refactor the existing code in a
similar fashion to the suggested dw-mipi-dsi-rockchip.c
implementation. Careful review would be greatly appreciated!

Also there is an outstanding regression on the db410c since it
similarly uses the adv7511 and probably needs a similar rework.
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 111 ++++++++++---------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 5bf8138941de..696cee1a1219 100644
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
@@ -862,15 +859,19 @@ static int dsi_probe(struct platform_device *pdev)
 	}
 	dsi = &data->dsi;
 	ctx = &data->ctx;
+	dsi->dev = &pdev->dev;
 	dsi->ctx = ctx;
 
 	ret = dsi_parse_dt(pdev, dsi);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, data);
+	ret = dsi_host_init(&pdev->dev, dsi);
+	if (ret)
+		return ret;
 
-	return component_add(&pdev->dev, &dsi_ops);
+	platform_set_drvdata(pdev, data);
+	return 0;
 }
 
 static int dsi_remove(struct platform_device *pdev)
-- 
2.17.1

