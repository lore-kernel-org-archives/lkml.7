Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461DFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6E42073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dljMBjZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLCNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34615 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfLCNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so1724231pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lDJf2uYfDmQWtbbV6ZzytU1h+3qcWlYg0vHzuCFbvic=;
        b=dljMBjZTTzYVZx3NJIiaTEKY+fBL1rJ0VhDMi5ObHjHZmD6d6/YkIak3capZ8MXAcl
         0HHbF26ngBJZQ8gJi72dDs2EJfcuSffsgquhnS4ZKAxUvU+FNQDus06hoTP4S7gV2V4D
         p5ozM+tkWAxjwq6p5k8NVEHgMcFwOo6kIyG9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lDJf2uYfDmQWtbbV6ZzytU1h+3qcWlYg0vHzuCFbvic=;
        b=f13KwOqmE5Noyf+5YogMahGHvTTx4MVSxiksDe5lNFWnA2IGmbkFAS/2SMTNOe3e0T
         JgweMerPl807BdqzPOPL/m/uLe3Z5WP+jmz+0SVeiEwUGrp5OwbaF3nRP2HkD9Ax/nfG
         yfwzIDmwAi8075ipMAZKbBjMtj919S3AxYoAefqBZ5+KP9sEuAlXL5YNYjtR1EuFW8Lv
         gG3TGwAOu1jV/HLzkvTQcosHBQArWY0aOyUmhUFVQwAoRwLwSEf5i7vU8oVvhn6qnI/h
         0TqsFg0WfyncjkKqv/+uAECi/qQRrNoLiHLEB72ea/IJGtiwmghorbi1r5U7uWvF6+Or
         24sA==
X-Gm-Message-State: APjAAAXFGTMsRXrQgvpkyC2sMjgpojrWZgUzvbL8nfil6gpTTWQ74T2Z
        sa36RBcU+vs5tT7Trod7HtEfDg==
X-Google-Smtp-Source: APXvYqwQHjJFEEwhVh4UAmgN93Bdic+cbDd2uJ8/t2CawkxL9VtbaPUQzrKhamJ0900Y+rNZOt7WkQ==
X-Received: by 2002:a63:4466:: with SMTP id t38mr5499310pgk.316.1575380930403;
        Tue, 03 Dec 2019 05:48:50 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:48:49 -0800 (PST)
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
Subject: [PATCH v12 4/7] drm/sun4i: dsi: Handle bus clock via regmap_mmio_attach_clk
Date:   Tue,  3 Dec 2019 19:18:13 +0530
Message-Id: <20191203134816.5319-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191203134816.5319-1-jagan@amarulasolutions.com>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
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
Changes for v12:
- get bus clock only when mod clock present
- use regmap_mmio_attach_clk

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 43 +++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8c4c541224dd..6085ad2eafc3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1082,6 +1082,7 @@ static const struct component_ops sun6i_dsi_ops = {
 static int sun6i_dsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const char *clk_name = NULL;
 	struct sun6i_dsi *dsi;
 	struct resource *res;
 	void __iomem *base;
@@ -1095,6 +1096,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
 	dsi->variant = of_device_get_match_data(dev);
+	if (dsi->variant->has_mod_clk)
+		clk_name = "bus";
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
@@ -1109,24 +1112,35 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
+	dsi->bus_clk = devm_clk_get(dev, clk_name);
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
 	if (dsi->variant->has_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
 			dev_err(dev, "Couldn't get the DSI mod clock\n");
-			return PTR_ERR(dsi->mod_clk);
+			ret = PTR_ERR(dsi->mod_clk);
+			goto err_attach_clk;
 		}
 	}
 
@@ -1167,6 +1181,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 err_unprotect_clk:
 	if (dsi->variant->has_mod_clk)
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
 
@@ -1181,6 +1203,11 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	if (dsi->variant->has_mod_clk)
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

