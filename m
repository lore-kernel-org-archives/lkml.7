Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AE1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6370720803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bzQVtQsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLCNss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40535 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfLCNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so1705754pgt.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZ4/teiuFdafb5RuME47dUY85SO685foNncJ+cZhSOo=;
        b=bzQVtQsvU9O8dXv0M3xGbCqaL/q9CJlsqOgF/n0/hHdtOVxO72jDaIEkuyUHzEV57O
         qM3Bj9ZKAxHvUv3WI2J6Y5gAxkCp6TuLc2HzernLE1JTTaenMGcBkRIwMB42wg6gjvqY
         Utw7kPxSbcEWTXM9ZCgJpIMtVH6IzQLCePT74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZ4/teiuFdafb5RuME47dUY85SO685foNncJ+cZhSOo=;
        b=rUbM9LcoeOsY4LuHXrnF6JbDflhzi/oWfVip8josivWDBX3lcvli+ei0n0y7LDgIAb
         k5kTKRbIzmC7ZYLu2WdhxuUVocBHXFtRj3i++/XQ490+VFrkNbn8rlKAn86Cgl8xS4BJ
         AsDZb1hNYPFV+lztVirqcEH+u0MnMi6zMNK655eRXkD9Ooaio3h+RW4aML/vSASTk1Pg
         YYzzWTGyzjURbnfdkXJesl3BUFE0JTp/HNauoZ2jjB8A1xfAzrQcsh9GQKdoqgSwzrM0
         0pcFP0B5P4Za5xgGHfx2E6qXC62OHRz785dEud0gFTi2QYfC6yLucnFsrbTe+CXNb5ph
         Dn9w==
X-Gm-Message-State: APjAAAW73YNNwO8e6FdglxcWxvY5uU1cvSRitwruszSDR7HexUiir04f
        aSZ03p2ktL2YdgLHWtTGl63XGA==
X-Google-Smtp-Source: APXvYqzOhrp2vBfBWLr6WtTENMHpXtD/Gx6XDn+ryyG4N1W0Xbbc1zWvgIC4t9s/eR2eo7kqDboxPw==
X-Received: by 2002:a63:c652:: with SMTP id x18mr5478439pgg.211.1575380925537;
        Tue, 03 Dec 2019 05:48:45 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:48:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v12 3/7] drm/sun4i: dsi: Add has_mod_clk quirk
Date:   Tue,  3 Dec 2019 19:18:12 +0530
Message-Id: <20191203134816.5319-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191203134816.5319-1-jagan@amarulasolutions.com>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the user manual, look like mod clock is not mandatory
for all Allwinner MIPI DSI controllers, it is connected to
CLK_DSI_SCLK for A31 and not available in A64.

So add has_mod_clk quirk and process the mod clk accordingly.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v12:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++++--------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 ++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c958ca9bae63..8c4c541224dd 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -11,6 +11,7 @@
 #include <linux/crc-ccitt.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy-mipi-dphy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -1093,6 +1094,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->dev = dev;
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
+	dsi->variant = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
@@ -1120,17 +1122,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
-	dsi->mod_clk = devm_clk_get(dev, "mod");
-	if (IS_ERR(dsi->mod_clk)) {
-		dev_err(dev, "Couldn't get the DSI mod clock\n");
-		return PTR_ERR(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk) {
+		dsi->mod_clk = devm_clk_get(dev, "mod");
+		if (IS_ERR(dsi->mod_clk)) {
+			dev_err(dev, "Couldn't get the DSI mod clock\n");
+			return PTR_ERR(dsi->mod_clk);
+		}
 	}
 
 	/*
 	 * In order to operate properly, that clock seems to be always
 	 * set to 297MHz.
 	 */
-	clk_set_rate_exclusive(dsi->mod_clk, 297000000);
+	if (dsi->variant->has_mod_clk)
+		clk_set_rate_exclusive(dsi->mod_clk, 297000000);
 
 	dsi->dphy = devm_phy_get(dev, "dphy");
 	if (IS_ERR(dsi->dphy)) {
@@ -1160,7 +1165,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(dev);
 err_unprotect_clk:
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 	return ret;
 }
 
@@ -1172,7 +1178,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &sun6i_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->host);
 	pm_runtime_disable(dev);
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 
 	return 0;
 }
@@ -1189,7 +1196,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 	}
 
 	reset_control_deassert(dsi->reset);
-	clk_prepare_enable(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_prepare_enable(dsi->mod_clk);
 
 	/*
 	 * Enable the DSI block.
@@ -1217,7 +1225,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
 	regulator_disable(dsi->regulator);
 
@@ -1230,9 +1239,16 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
 			   NULL)
 };
 
+static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
+	.has_mod_clk = true,
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
-	{ .compatible = "allwinner,sun6i-a31-mipi-dsi" },
-	{ }
+	{
+		.compatible = "allwinner,sun6i-a31-mipi-dsi",
+		.data = &sun6i_a31_mipi_dsi,
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
 
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 3f4846f581ef..d791c9f6fccf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -15,6 +15,10 @@
 
 #define SUN6I_DSI_TCON_DIV	4
 
+struct sun6i_dsi_variant {
+	bool			has_mod_clk;
+};
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -31,6 +35,7 @@ struct sun6i_dsi {
 	struct sun4i_drv	*drv;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
+	const struct sun6i_dsi_variant	*variant;
 };
 
 static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
-- 
2.18.0.321.gffc6fa0e3

