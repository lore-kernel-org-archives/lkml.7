Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5455DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238A52063A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="elp3iMXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLVN3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39695 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so6273039pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EK74rOb2z7EDUkpcZJ+pjm2y3iAMcEo48mh6FOoxhw=;
        b=elp3iMXtldViCwMF3JjT3bZYVczFV91HufAwoMDwVKUlMBQTJzocTtRCPkNBZMIA9g
         2VG1BztxAum0YPvU8OBwZOSVW5E9wgbKIBqnXdWU8ONLA/+ucglW6TcP3PR9UVYG6GNo
         SfCb4jXdvRDs/0qiGzLsCQH00UaN3uPOVome4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EK74rOb2z7EDUkpcZJ+pjm2y3iAMcEo48mh6FOoxhw=;
        b=csdfcuhxl4Ql9AnnvhpbGEuIfQjdII34WD+eCOffuREvPfbEWCDwXxr8ea8gs8UA9y
         jjiUzZCFRYnBkru9cw24r/6kUoHB7Wo2BknB+Ba6gp/oOQqRdCKIWJumi1Di3uJWnROU
         ugXOprK06JCYla96w0rdDka4zzMQ0KkkQz4G4uQbKsskHRnWPhxU65409gzsweI6E2Xd
         zIBJ7jaQw+3DpXsPRWRrbi9zDzHGLVEPCGgkxZpN/2gS85yx/i7DWRGsInJM13+JYiOY
         hjgKUeB78dmQvPcCJuNd8pbut40+iqRZ+fpDhO/sycxmBxmoggEp8XyQZ5MYg9z525AM
         yHsg==
X-Gm-Message-State: APjAAAWfMXOD6io6NmvKGGdRXs2PY4dmTHrEDNUcMz4N8Rg6Qlee+EtH
        4+3eTiKvJ392WYa5yI+3g9iumg==
X-Google-Smtp-Source: APXvYqwbCvY+32jV+/QgjoePmeG6bzYo9uGs3ZgswBABaoyGH34YZ1Q2hfocbLiZGUbMXhjjrYPS2A==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr7360374pjx.54.1577021385351;
        Sun, 22 Dec 2019 05:29:45 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:44 -0800 (PST)
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
Subject: [PATCH v14 4/7] drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
Date:   Sun, 22 Dec 2019 18:52:26 +0530
Message-Id: <20191222132229.30276-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
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
Changes for v14:
- drop regmap_exit, clk_put

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 37 ++++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 68b88a3dc4c5..2577b237d06a 100644
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
@@ -1107,25 +1112,35 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
+		return PTR_ERR(dsi->bus_clk);
+	} else {
+		ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
+		if (ret)
+			return ret;
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
 
@@ -1164,6 +1179,9 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 err_unprotect_clk:
 	clk_rate_exclusive_put(dsi->mod_clk);
+err_attach_clk:
+	if (!IS_ERR(dsi->bus_clk))
+		regmap_mmio_detach_clk(dsi->regs);
 	return ret;
 }
 
@@ -1177,6 +1195,9 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	clk_rate_exclusive_put(dsi->mod_clk);
 
+	if (!IS_ERR(dsi->bus_clk))
+		regmap_mmio_detach_clk(dsi->regs);
+
 	return 0;
 }
 
-- 
2.18.0.321.gffc6fa0e3

