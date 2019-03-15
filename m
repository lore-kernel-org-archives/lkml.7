Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850922186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B2hki3AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfCONIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:08:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33557 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCONIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:08:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so6345467pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUOsJO/ekVDHiTmtCVq8d27ElQS89ZxoIWk8a+ZsNC8=;
        b=B2hki3AVn28hYRpt5WblRY/Vca49463pFaNwvrqpHWdi3Q+mwBSfv1Vs2vjfcAGpRm
         7h24qEjbfhNQ/C15zsOs0GEucNfdebhmiBYEC71Sl8tHFCMhamO1C/BCjEuHSy5LPNdX
         22yifrbUWp3bv2AUBl5Qu6ljUpOc/zESnsyIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUOsJO/ekVDHiTmtCVq8d27ElQS89ZxoIWk8a+ZsNC8=;
        b=OH4xHnAkUsA6CWCZ27k6JaKnbfSFQ5FMI5uCjh5IVGfPAvdKetXUwzDNLM8QREr8aU
         Nk7b2Pa1BY0R8jjzgOswXUMeClzXn5nhVPDE9cvz9uDqoPC1MOQSGslEBtEeWH2HIIxa
         tAIf9gtbEyaU9kqEL46U80PWkYRx7flMH9a/ig7RjfOJaUypCWZGoc8YCZPiOFZLT9fm
         i0KySfiFD1+PfHTSJ4Qa0KbM9aIRbeZV8tf39neWQDS1Tw/87X84F2JXIOQlBH4DQ5hN
         XjezeFSo3A4g8SuN1zRC5UAkBtjk2hZVh+UZOGlCxJdt0iztn3aj25JmwG6IcoJqRRxO
         JSdA==
X-Gm-Message-State: APjAAAWOCADc5Bci/8ciuN77iRFmh8U+t5tT4X3pzCtFhsIohiL29oKo
        vBmJ3L60ZEcCnn8teYVkdZ/ycA==
X-Google-Smtp-Source: APXvYqyPmR5Date1E23A+mrwxJzoBMabdA1BAZmkp5dMCISLQ8NpBn1aclAupLxAkrJgT0eBGNdF0A==
X-Received: by 2002:a63:5321:: with SMTP id h33mr3378181pgb.168.1552655332222;
        Fri, 15 Mar 2019 06:08:52 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.185])
        by smtp.gmail.com with ESMTPSA id e2sm854008pfa.64.2019.03.15.06.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:08:51 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/6] drm/sun4i: dsi: Add bridge support
Date:   Fri, 15 Mar 2019 18:38:22 +0530
Message-Id: <20190315130825.9005-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190315130825.9005-1-jagan@amarulasolutions.com>
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some display panels would come up with a non-DSI output which
can have an option to connect DSI interface by means of bridge
convertor.

This DSI to non-DSI bridge convertor would require a bridge
driver that would communicate the DSI controller for bridge
functionalities.

So, add support for bridge functionalities in Allwinner DSI
controller.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 65 +++++++++++++++++++-------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  1 +
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 0960b96b62cc..64d74313b842 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -781,6 +781,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	if (!IS_ERR(dsi->panel))
 		drm_panel_prepare(dsi->panel);
 
+	if (!IS_ERR(dsi->bridge))
+		drm_bridge_pre_enable(dsi->bridge);
+
 	/*
 	 * FIXME: This should be moved after the switch to HS mode.
 	 *
@@ -796,6 +799,9 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	if (!IS_ERR(dsi->panel))
 		drm_panel_enable(dsi->panel);
 
+	if (!IS_ERR(dsi->bridge))
+		drm_bridge_enable(dsi->bridge);
+
 	sun6i_dsi_start(dsi, DSI_START_HSC);
 
 	udelay(1000);
@@ -812,6 +818,9 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
 	if (!IS_ERR(dsi->panel)) {
 		drm_panel_disable(dsi->panel);
 		drm_panel_unprepare(dsi->panel);
+	} else if (!IS_ERR(dsi->bridge)) {
+		drm_bridge_disable(dsi->bridge);
+		drm_bridge_post_disable(dsi->bridge);
 	}
 
 	phy_power_off(dsi->dphy);
@@ -973,11 +982,16 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
 
 	dsi->device = device;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (IS_ERR(dsi->panel))
-		return PTR_ERR(dsi->panel);
 
-	dev_info(host->dev, "Attached device %s\n", device->name);
+	dsi->bridge = of_drm_find_bridge(device->dev.of_node);
+	if (!dsi->bridge) {
+		dsi->panel = of_drm_find_panel(device->dev.of_node);
+		if (IS_ERR(dsi->panel))
+			return PTR_ERR(dsi->panel);
+	}
+
+	dev_info(host->dev, "Attached %s %s\n",
+		 dsi->bridge ? "bridge" : "panel", device->name);
 
 	return 0;
 }
@@ -1055,8 +1069,10 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
 	int ret;
 
-	if (!dsi->panel)
+	if (!(dsi->panel || dsi->bridge)) {
+		dev_info(drm->dev, "No panel or bridge found... DSI output disabled\n");
 		return -EPROBE_DEFER;
+	}
 
 	dsi->drv = drv;
 
@@ -1078,19 +1094,29 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	}
 	dsi->encoder.possible_crtcs = BIT(0);
 
-	drm_connector_helper_add(&dsi->connector,
-				 &sun6i_dsi_connector_helper_funcs);
-	ret = drm_connector_init(drm, &dsi->connector,
-				 &sun6i_dsi_connector_funcs,
-				 DRM_MODE_CONNECTOR_DSI);
-	if (ret) {
-		dev_err(dsi->dev,
-			"Couldn't initialise the DSI connector\n");
-		goto err_cleanup_connector;
+	if (dsi->panel) {
+		drm_connector_helper_add(&dsi->connector,
+					 &sun6i_dsi_connector_helper_funcs);
+		ret = drm_connector_init(drm, &dsi->connector,
+					 &sun6i_dsi_connector_funcs,
+					 DRM_MODE_CONNECTOR_DSI);
+		if (ret) {
+			dev_err(dsi->dev,
+				"Couldn't initialise the DSI connector\n");
+			goto err_cleanup_connector;
+		}
+
+		drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
+		drm_panel_attach(dsi->panel, &dsi->connector);
 	}
 
-	drm_connector_attach_encoder(&dsi->connector, &dsi->encoder);
-	drm_panel_attach(dsi->panel, &dsi->connector);
+	if (dsi->bridge) {
+		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
+		if (ret) {
+			dev_err(dsi->dev, "Couldn't attach the DSI bridge\n");
+			goto err_cleanup_connector;
+		}
+	}
 
 	return 0;
 
@@ -1104,7 +1130,12 @@ static void sun6i_dsi_unbind(struct device *dev, struct device *master,
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-	drm_panel_detach(dsi->panel);
+	if (dsi->panel)
+		drm_panel_detach(dsi->panel);
+
+	if (dsi->bridge)
+		drm_bridge_detach(dsi->bridge);
+
 }
 
 static const struct component_ops sun6i_dsi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 5c4983212f89..76874ff8e3ef 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -36,6 +36,7 @@ struct sun6i_dsi {
 	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
+	struct drm_bridge	*bridge;
 	const struct sun6i_dsi_variant	*variant;
 };
 
-- 
2.18.0.321.gffc6fa0e3

