Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8E8C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FC920867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BsvBkiMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfJEOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:19:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41748 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfJEOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so4531244plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yjltb6EvZLpV/+AdDfNmytRgVwPyoroHREU7ngUBNNM=;
        b=BsvBkiMo6DBm6cGJzBJNLd228Tf08EuUIIJf0BeR+EclTzRIGbZJMtDdSUHhx8OpIc
         F+Xlh4k/QcWS0fSGqmBja22wVRjDO4om5x1FxgaX54ITrqAmrZhzcLgvaI9V0bXa21Ih
         maP8pxRVMj+RDb9fN2biqLwIEgDR2kU7jDQt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yjltb6EvZLpV/+AdDfNmytRgVwPyoroHREU7ngUBNNM=;
        b=OBwQOcD9JPIYdZwICHo+K+0ExjBjpF6ROeWtFl4cAqta327JZzhblFF0II4q4gQ0V5
         i+tY4VTfqnyoTg5TCJD2JJdz5FeuypRNhUIIIzIiZKnnEY1nCFi+5Q7NX5Wq8Ku2PrUZ
         kXae1Q9Axy44TnsVsASeD2I1dz/ZL/gIECDa/vF5sxFp1Xd0AWHAl512CV3o3rfy6sIu
         0vr29vimp22rtIoRXrxIAVUZT+Dd8jg9npkl2MRXqeVAagJuTGMhUKpzYXK6cEEVJ/wx
         sH/aVL+FzLWr5YfZ+x9FeVc0ITy/xVaZJY+hfKFtJIe4+9zc23Dv+QDPhc5cajUD++VA
         CR0g==
X-Gm-Message-State: APjAAAXECCVQvQcawqeDrFC5mtB2o6oEkTqIA1j3JY+KCAKlEFXWY66L
        AycVPGYq3lxN2FEhELIz1voZBQ==
X-Google-Smtp-Source: APXvYqxSOBdDN0cLa9J71egXj5f8+hpjG/uMA+wSULo66K7IF9WjoNStfIDY2/ojjM0bWat7opVIGw==
X-Received: by 2002:a17:902:d887:: with SMTP id b7mr19889219plz.297.1570285176389;
        Sat, 05 Oct 2019 07:19:36 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:35 -0700 (PDT)
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
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 3/6] drm/sun4i: dsi: Add has_mod_clk quirk
Date:   Sat,  5 Oct 2019 19:49:10 +0530
Message-Id: <20191005141913.22020-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191005141913.22020-1-jagan@amarulasolutions.com>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the user manual, look like mod clock is not mandatory
for all Allwinner MIPI DSI controllers, it is connected to
CLK_DSI_SCLK for A31 and not available in A64.

So add has_mod_clk quirk and process the clk accordingly.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 35 ++++++++++++++++++--------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 ++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b8a0d0501ca7..6724a14c816d 100644
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
@@ -1092,6 +1093,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->dev = dev;
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
+	dsi->variant = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
@@ -1119,17 +1121,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
@@ -1159,7 +1164,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(dev);
 err_unprotect_clk:
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 	return ret;
 }
 
@@ -1171,7 +1177,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &sun6i_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->host);
 	pm_runtime_disable(dev);
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 
 	return 0;
 }
@@ -1188,7 +1195,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 	}
 
 	reset_control_deassert(dsi->reset);
-	clk_prepare_enable(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_prepare_enable(dsi->mod_clk);
 
 	/*
 	 * Enable the DSI block.
@@ -1229,9 +1237,16 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
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

