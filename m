Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C6A2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e0qXwrwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCKNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:38:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfCKNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:38:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id 125so4044638pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TF5z7mL3PH3afkXmJ7BvBklURV/GryvaXbr0ZQUzq4M=;
        b=e0qXwrwYAH5wvRjseqC54KQNb4ukzeLU3kufN+UtKvhPVR09hRKJmyrpD3KYwZvFGl
         Y7kN1KHSPbJmGiAFL4yBcWA1cXcsu7ekGUz5TsUbbd3w13F3moEABCv/CQW9qVf46Hfy
         eHAh7coDA0ialcKVWxUz9TnjnR587fnxFyAs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TF5z7mL3PH3afkXmJ7BvBklURV/GryvaXbr0ZQUzq4M=;
        b=BKv8bE6jSUc9G259BWqkcjXkOgWKbXhydL5ccxCSYs1D3ECIwgJElqsB4W4OePXxPv
         IjChYR+7ONxwCOPfi4MYwWrFB0MuOtikx5xhWPxeVgOkD8RsOAe2zoL2DucAkc6OrKtt
         MV0uT93T9uZ8gVjs79C6n0q13sNR5LJT8SUmqaofmkWCnGvi1jgFHqr/tyf+ZacGrTRn
         +/69zcknLbcvZskhx9GibVhz6PdDDjEkUOAEJqa8dW+DVOHkdydfFHi8CC9gsXVHYfjG
         mb4p5L4aeJIOfxZ7lfafCJJubHKMn2aM9QTb1vRjYKAQyAGv3uHugnLVzx4vfkmrb/QV
         WXwA==
X-Gm-Message-State: APjAAAWIFBz1XwE6GSGT1MnZSOoUIxTtte2Y4dvYjbOQUObIS6ACt1Ty
        uE98A4q5PwnW7dzJdIoRGVQohg==
X-Google-Smtp-Source: APXvYqyJC2p8K5cK6E7JAsiCXSZTUkVUvhRCxGA756p4PUL0TBix90m2pMsAgir/muyoPHd97NuSbA==
X-Received: by 2002:a17:902:8602:: with SMTP id f2mr34360179plo.263.1552311480178;
        Mon, 11 Mar 2019 06:38:00 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:37:59 -0700 (PDT)
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
Subject: [PATCH v8 09/15] drm/sun4i: sun6i_mipi_dsi: Add has_mod_clk quirk
Date:   Mon, 11 Mar 2019 19:06:31 +0530
Message-Id: <20190311133637.18334-10-jagan@amarulasolutions.com>
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
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 388e1161974c..f42ea806f6c8 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1134,6 +1134,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
+	if (IS_ERR(dsi->regulator)) {
+		dev_err(dev, "Couldn't get VCC-DSI supply\n");
+		return PTR_ERR(dsi->regulator);
+	}
+
 	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
@@ -1207,6 +1213,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_enable(dsi->regulator);
+	if (err) {
+		dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
+		return err;
+	}
 
 	reset_control_deassert(dsi->reset);
 	clk_prepare_enable(dsi->mod_clk);
@@ -1239,6 +1252,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
+	regulator_disable(dsi->regulator);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 747c451a9a20..c570f2b3868f 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/regulator/consumer.h>
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -21,6 +23,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct phy		*dphy;
 
-- 
2.18.0.321.gffc6fa0e3

