Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB06CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD4821D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="i3MIHeuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfJYR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:57:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34511 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbfJYR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:57:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so2032823pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3Mki6uub+NAK80E3ntfBcsFK0xNEI4Pl6xkUsSgIeM=;
        b=i3MIHeuYlYEVmU4821ovZp6xUdW9w+0CO4+t4aQLQryHnwktMguR3UUD+Yd9ZkzbTJ
         4iQrMyZXSu1Za0QtBnk0m4NeXcBDnmIdW7LtsfXsM4RHfFgOEWbXEXuvHz130kkxKtiF
         fH4VjdQ2kJHmdErld9s1DPCCJz7NeHLkpyWIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3Mki6uub+NAK80E3ntfBcsFK0xNEI4Pl6xkUsSgIeM=;
        b=H3f1UyaEIH+x51Bfp+EGYRrnc0OimYbAe8tYloeBeg+CRGhseyrrzDcf8FJBMq0wnI
         XYqrNHSHPbm/jgMLd2ttefEFbaNmZFV/qlLVg1yeaNak6SJVmkpp5r0W0eUe7tjL4clU
         4cTVfsgvp8SkynlsQf4ej6ZNBftCsWLpWR/SRKBdwLa90V/VmFT3QRYbe0WtAvmvUM+R
         M9crS1g2N4l8Zr4FAZ7X2yMDM2xSGTTacJtv5RPq/Eg/xAGLs1AMwiZc228ErpCwqAnc
         jRkS7F+xwUOnlcapQnp9Da7E2HQuUMDce2Fq1ftKdqr1/woOzIgAU4VAGNeewvrpWKLF
         nUJQ==
X-Gm-Message-State: APjAAAUs+eFkBS+yoCtb14MnIgbMaNe/9hQaLvzfbkeHHX/9KEuzWOVH
        kIg3saS95TrwOgT433b2E10Spw==
X-Google-Smtp-Source: APXvYqwQDEhpc37JYujaBlS0c+W1Le7LhGIIS5sXpnrhe8K1umdFkvWh0OaUWV5zfFMK68Yte1XnMQ==
X-Received: by 2002:a62:58c2:: with SMTP id m185mr6044311pfb.10.1572026227045;
        Fri, 25 Oct 2019 10:57:07 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id n15sm2926580pfq.146.2019.10.25.10.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:57:06 -0700 (PDT)
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
Subject: [PATCH v11 4/7] =?UTF-8?q?drm/sun4i:=20dsi:=20Handle=20bus=20cloc?= =?UTF-8?q?k=20explicitly=C2=A0?=
Date:   Fri, 25 Oct 2019 23:26:22 +0530
Message-Id: <20191025175625.8011-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191025175625.8011-1-jagan@amarulasolutions.com>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of clocks are varies between different Allwinner
DSI controllers. Clocking in A33 would need bus and
mod clocks where as A64 would need only bus clock.

To support this kind of clocking structure variants
in the same dsi driver, explicit handling of common
clock would require since the A64 doesn't need to
mention the clock-names explicitly in dts since it
support only one bus clock.

Also pass clk_id NULL instead "bus" to regmap clock
init function since the single clock variants no need
to mention clock-names explicitly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8c4c541224dd..eacdfcff64ad 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1109,7 +1109,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->regulator);
 	}
 
-	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
+	dsi->regs = devm_regmap_init_mmio_clk(dev, NULL, base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
 		dev_err(dev, "Couldn't create the DSI encoder regmap\n");
@@ -1122,6 +1122,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
+	dsi->bus_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(dsi->bus_clk)) {
+		dev_err(dev, "Couldn't get the DSI bus clock\n");
+		return PTR_ERR(dsi->bus_clk);
+	}
+
 	if (dsi->variant->has_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
@@ -1196,6 +1202,7 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 	}
 
 	reset_control_deassert(dsi->reset);
+	clk_prepare_enable(dsi->bus_clk);
 	if (dsi->variant->has_mod_clk)
 		clk_prepare_enable(dsi->mod_clk);
 
@@ -1227,6 +1234,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 
 	if (dsi->variant->has_mod_clk)
 		clk_disable_unprepare(dsi->mod_clk);
+	clk_disable_unprepare(dsi->bus_clk);
 	reset_control_assert(dsi->reset);
 	regulator_disable(dsi->regulator);
 
-- 
2.18.0.321.gffc6fa0e3

