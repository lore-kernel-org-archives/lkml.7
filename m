Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B87C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FHFikPl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfCKNiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:38:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45594 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfCKNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:38:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id 125so4044821pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ji/qwC/DQKZSBaaS9TqlAOwzz5Vf5lhGPWQ9JxpSNtE=;
        b=FHFikPl03Y/gVSgIWpbi7MkZhF6+/I73Hw5CFcVwMC41+qPKNtZpG9vu9IUDniIaR2
         yjOshoMkmvw99WUnSc2uhTWemZBsxMSIhmRzCArT8p5e35Vx/ltRv2k7rHQMPyK53eck
         tyDLK6jvWXcZM0JWHBZGkKBujmXS93fQ4Sws0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ji/qwC/DQKZSBaaS9TqlAOwzz5Vf5lhGPWQ9JxpSNtE=;
        b=j1l2I30a0g8kZ+s+WVAmEDe0QeUruzfzz9xlGNAeQk0zEyfzQa2jaCiGDrZarLdA5F
         8mkw8DKpdNeBnHeIpLm125gh/Wp3CNkkh1FlaKpoowsPXO9XNWkKK6yREYii7q3ALMAM
         sAtjPS1vKB8QBnae2P9x/EBFMO8ZDo7LwZPbVpK4ZdcPMYDrxJsOW7Xgpijcq1T2s82u
         GpMb1yrIqux7lQfRb6kbx28ut9UWHJkN6shHZdfwLdOHp2Hihw3g8bxKlBRQf0lTzkKT
         VruACvFlYEtjzv2M/w54EI4jH9F6n1A5zrXiKtBJERKFsqKA6cHPSW+Z80SaqRjA7wNh
         pexA==
X-Gm-Message-State: APjAAAWn28egWoJWjnV4dS+jY80N0xzA6nrNSXuDfVsZm8h1/CfLU597
        RB6sLafQ0sWeDbdGC4hsgoglIg==
X-Google-Smtp-Source: APXvYqxNcOxNAKyPN85uaNs0q6HZpl4SrIXm5s4xueRiKv3yknqulCYRfuqoFBK4pHQPZQCX+iZn1w==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr30943274pgv.37.1552311486234;
        Mon, 11 Mar 2019 06:38:06 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:38:05 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 10/15] drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
Date:   Mon, 11 Mar 2019 19:06:32 +0530
Message-Id: <20190311133637.18334-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311133637.18334-1-jagan@amarulasolutions.com>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
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

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 38 ++++++++++++++++++--------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 ++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index f42ea806f6c8..2a63e96aaff9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/crc-ccitt.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -1126,6 +1127,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->dev = dev;
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
+	dsi->variant = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
@@ -1153,17 +1155,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
@@ -1193,7 +1198,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(dev);
 err_unprotect_clk:
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 	return ret;
 }
 
@@ -1205,7 +1211,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	component_del(&pdev->dev, &sun6i_dsi_ops);
 	mipi_dsi_host_unregister(&dsi->host);
 	pm_runtime_disable(dev);
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 
 	return 0;
 }
@@ -1222,7 +1229,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 	}
 
 	reset_control_deassert(dsi->reset);
-	clk_prepare_enable(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_prepare_enable(dsi->mod_clk);
 
 	/*
 	 * Enable the DSI block.
@@ -1250,7 +1258,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
 	regulator_disable(dsi->regulator);
 
@@ -1263,9 +1272,16 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
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
index c570f2b3868f..5c4983212f89 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -15,6 +15,10 @@
 
 #include <linux/regulator/consumer.h>
 
+struct sun6i_dsi_variant {
+	bool			has_mod_clk;
+};
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -32,6 +36,7 @@ struct sun6i_dsi {
 	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
+	const struct sun6i_dsi_variant	*variant;
 };
 
 static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
-- 
2.18.0.321.gffc6fa0e3

