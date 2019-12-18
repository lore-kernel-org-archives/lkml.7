Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D3C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5BE24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YxQafe8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLRTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:10:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35248 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so1322521pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qISq29HsJqizQ/dr9IDqB+kkI7D+OvUtJAFPrAy/nl4=;
        b=YxQafe8jh4QPqCjejR3M34Sd/4XpSYiKBWIcOBezUR1fhLtoc82k5kx5ExrQXHKQ2C
         vS2dLSfQvTrP8O11GKbHUhcEP9GDLGdcKLUU5I2q28k6yi1c1DgTTaNzcbSVB1iyx4KX
         Cen3RsibAKaJgtVRu+yHWhpGxscNR6JCAxUXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qISq29HsJqizQ/dr9IDqB+kkI7D+OvUtJAFPrAy/nl4=;
        b=OogWnkkXKXeRKOFMOOYXH/R3qldtR2eX0ZE91kPoLvrZNwBWZaMQ3XK3v69JmtcSqK
         y+XBJW8zoAAPoc81XaFzGQyfSzGnae9/Jf5RBEvKjjb4p0ThN2HZJgGjvileNypbOuGL
         MHmhV3lZLLrwtkHorXlgTM6G5BWPmsZEaWcgayM1RgInVgymrJKjMlklfTCrFR37uZkN
         Nlu3W4X6DXSJWVfRAlcU+8VqrGIaFgWq/kMcxB1MPCRLcyxE5tO05XdekWpiZfnOjs+A
         NVNbqG1Jr8NXmYT5/gLLfmcg6IHNq1qZQC4voYFA9abw6CbiWXmFzL+aHRUpKQ3SSz6t
         l/tg==
X-Gm-Message-State: APjAAAVotgLcSqT9gPR1AyWmaHBxRg3Qtgev1dSOyqrPjQDx1KEFEWMe
        gxYevn4fmdXe7zt9DvhyKC7D/A==
X-Google-Smtp-Source: APXvYqx6pZtGD5CankRw2wtkMvreOH4b8xo+2gm+PpxrsNSXLh1P6DrOeczRQv/iXcWiQlhsiKLRBQ==
X-Received: by 2002:a17:90a:3747:: with SMTP id u65mr2730117pjb.25.1576696245276;
        Wed, 18 Dec 2019 11:10:45 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:78ea:e014:edb4:e862])
        by smtp.gmail.com with ESMTPSA id q7sm3745855pjd.3.2019.12.18.11.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:10:44 -0800 (PST)
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
Subject: [PATCH v13 4/7] drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
Date:   Thu, 19 Dec 2019 00:40:14 +0530
Message-Id: <20191218191017.2895-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191218191017.2895-1-jagan@amarulasolutions.com>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap has special API to enable the controller bus clock while
initializing register space, and current driver is using
devm_regmap_init_mmio_clk which require to specify bus
clk_id argument as "bus"

But, the usage of clocks are varies between different Allwinner
DSI controllers. Clocking in A33 would need bus and mod clocks
where as A64 would need only bus clock.

Since A64 support only single bus clock, it is optional to
specify the clock-names on the controller device tree node.
So using NULL on clk_id would get the attached clock.

To support clk_id as "bus" and "NULL" during clock enablement
between controllers, this patch add generic code to handle
the bus clock using regmap_mmio_attach_clk with associated
regmap APIs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v13:
- update the changes since has_mod_clk is dropped in previous patch

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 45 +++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 68b88a3dc4c5..de8955fbeb00 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1081,6 +1081,7 @@ static const struct component_ops sun6i_dsi_ops = {
 static int sun6i_dsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const char *bus_clk_name = NULL;
 	struct sun6i_dsi *dsi;
 	struct resource *res;
 	void __iomem *base;
@@ -1094,6 +1095,10 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
 
+	if (of_device_is_compatible(dev->of_node,
+				    "allwinner,sun6i-a31-mipi-dsi"))
+		bus_clk_name = "bus";
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base)) {
@@ -1107,25 +1112,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->regulator);
 	}
 
-	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
-					      &sun6i_dsi_regmap_config);
-	if (IS_ERR(dsi->regs)) {
-		dev_err(dev, "Couldn't create the DSI encoder regmap\n");
-		return PTR_ERR(dsi->regs);
-	}
-
 	dsi->reset = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(dsi->reset)) {
 		dev_err(dev, "Couldn't get our reset line\n");
 		return PTR_ERR(dsi->reset);
 	}
 
+	dsi->regs = devm_regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);
+	if (IS_ERR(dsi->regs)) {
+		dev_err(dev, "Couldn't init regmap\n");
+		return PTR_ERR(dsi->regs);
+	}
+
+	dsi->bus_clk = devm_clk_get(dev, bus_clk_name);
+	if (IS_ERR(dsi->bus_clk)) {
+		dev_err(dev, "Couldn't get the DSI bus clock\n");
+		ret = PTR_ERR(dsi->bus_clk);
+		goto err_regmap;
+	} else {
+		ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
+		if (ret)
+			goto err_bus_clk;
+	}
+
 	if (of_device_is_compatible(dev->of_node,
 				    "allwinner,sun6i-a31-mipi-dsi")) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
 			dev_err(dev, "Couldn't get the DSI mod clock\n");
-			return PTR_ERR(dsi->mod_clk);
+			ret = PTR_ERR(dsi->mod_clk);
+			goto err_attach_clk;
 		}
 	}
 
@@ -1164,6 +1180,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 err_unprotect_clk:
 	clk_rate_exclusive_put(dsi->mod_clk);
+err_attach_clk:
+	if (!IS_ERR(dsi->bus_clk))
+		regmap_mmio_detach_clk(dsi->regs);
+err_bus_clk:
+	if (!IS_ERR(dsi->bus_clk))
+		clk_put(dsi->bus_clk);
+err_regmap:
+	regmap_exit(dsi->regs);
 	return ret;
 }
 
@@ -1177,6 +1201,11 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	clk_rate_exclusive_put(dsi->mod_clk);
 
+	if (!IS_ERR(dsi->bus_clk))
+		regmap_mmio_detach_clk(dsi->regs);
+
+	regmap_exit(dsi->regs);
+
 	return 0;
 }
 
-- 
2.18.0.321.gffc6fa0e3

