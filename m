Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24107217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfKFK0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:26:54 -0500
Received: from mx.socionext.com ([202.248.49.38]:44272 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfKFK0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:26:51 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 06 Nov 2019 19:26:49 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9FE5A605F8;
        Wed,  6 Nov 2019 19:26:49 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 6 Nov 2019 19:26:59 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 0A8F81A04FC;
        Wed,  6 Nov 2019 19:26:49 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 4/6] phy: uniphier-usb3hs: Add legacy SoC support for Pro5
Date:   Wed,  6 Nov 2019 19:26:17 +0900
Message-Id: <1573035979-32200-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add legacy SoC support that needs to manage gio clock and reset.
This supports Pro5.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-usb3hs.c | 68 ++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
index 1d3f9e8..bdf696e 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3hs.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
@@ -66,13 +66,14 @@ struct uniphier_u3hsphy_trim_param {
 struct uniphier_u3hsphy_priv {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk, *clk_parent, *clk_ext;
-	struct reset_control *rst, *rst_parent;
+	struct clk *clk, *clk_parent, *clk_ext, *clk_parent_gio;
+	struct reset_control *rst, *rst_parent, *rst_parent_gio;
 	struct regulator *vbus;
 	const struct uniphier_u3hsphy_soc_data *data;
 };
 
 struct uniphier_u3hsphy_soc_data {
+	bool is_legacy;
 	int nparams;
 	const struct uniphier_u3hsphy_param param[MAX_PHY_PARAMS];
 	u32 config0;
@@ -256,11 +257,20 @@ static int uniphier_u3hsphy_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(priv->rst_parent);
+	ret = clk_prepare_enable(priv->clk_parent_gio);
 	if (ret)
 		goto out_clk_disable;
 
-	if (!priv->data->config0 && !priv->data->config1)
+	ret = reset_control_deassert(priv->rst_parent);
+	if (ret)
+		goto out_clk_gio_disable;
+
+	ret = reset_control_deassert(priv->rst_parent_gio);
+	if (ret)
+		goto out_rst_assert;
+
+	if ((priv->data->is_legacy)
+	    || (!priv->data->config0 && !priv->data->config1))
 		return 0;
 
 	config0 = priv->data->config0;
@@ -280,6 +290,8 @@ static int uniphier_u3hsphy_init(struct phy *phy)
 
 out_rst_assert:
 	reset_control_assert(priv->rst_parent);
+out_clk_gio_disable:
+	clk_disable_unprepare(priv->clk_parent_gio);
 out_clk_disable:
 	clk_disable_unprepare(priv->clk_parent);
 
@@ -290,7 +302,9 @@ static int uniphier_u3hsphy_exit(struct phy *phy)
 {
 	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
 
+	reset_control_assert(priv->rst_parent_gio);
 	reset_control_assert(priv->rst_parent);
+	clk_disable_unprepare(priv->clk_parent_gio);
 	clk_disable_unprepare(priv->clk_parent);
 
 	return 0;
@@ -325,22 +339,34 @@ static int uniphier_u3hsphy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(dev, "phy");
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	if (!priv->data->is_legacy) {
+		priv->clk = devm_clk_get(dev, "phy");
+		if (IS_ERR(priv->clk))
+			return PTR_ERR(priv->clk);
+
+		priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
+		if (IS_ERR(priv->clk_ext))
+			return PTR_ERR(priv->clk_ext);
+
+		priv->rst = devm_reset_control_get_shared(dev, "phy");
+		if (IS_ERR(priv->rst))
+			return PTR_ERR(priv->rst);
+
+	} else {
+		priv->clk_parent_gio = devm_clk_get(dev, "gio");
+		if (IS_ERR(priv->clk_parent_gio))
+			return PTR_ERR(priv->clk_parent_gio);
+
+		priv->rst_parent_gio =
+			devm_reset_control_get_shared(dev, "gio");
+		if (IS_ERR(priv->rst_parent_gio))
+			return PTR_ERR(priv->rst_parent_gio);
+	}
 
 	priv->clk_parent = devm_clk_get(dev, "link");
 	if (IS_ERR(priv->clk_parent))
 		return PTR_ERR(priv->clk_parent);
 
-	priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
-	if (IS_ERR(priv->clk_ext))
-		return PTR_ERR(priv->clk_ext);
-
-	priv->rst = devm_reset_control_get_shared(dev, "phy");
-	if (IS_ERR(priv->rst))
-		return PTR_ERR(priv->rst);
-
 	priv->rst_parent = devm_reset_control_get_shared(dev, "link");
 	if (IS_ERR(priv->rst_parent))
 		return PTR_ERR(priv->rst_parent);
@@ -362,11 +388,18 @@ static int uniphier_u3hsphy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct uniphier_u3hsphy_soc_data uniphier_pro5_data = {
+	.is_legacy = true,
+	.nparams = 0,
+};
+
 static const struct uniphier_u3hsphy_soc_data uniphier_pxs2_data = {
+	.is_legacy = false,
 	.nparams = 0,
 };
 
 static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
+	.is_legacy = false,
 	.nparams = 2,
 	.param = {
 		{ LS_SLEW, 1 },
@@ -378,6 +411,7 @@ static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
 };
 
 static const struct uniphier_u3hsphy_soc_data uniphier_pxs3_data = {
+	.is_legacy = false,
 	.nparams = 0,
 	.trim_func = uniphier_u3hsphy_trim_ld20,
 	.config0 = 0x92316680,
@@ -386,6 +420,10 @@ static const struct uniphier_u3hsphy_soc_data uniphier_pxs3_data = {
 
 static const struct of_device_id uniphier_u3hsphy_match[] = {
 	{
+		.compatible = "socionext,uniphier-pro5-usb3-hsphy",
+		.data = &uniphier_pro5_data,
+	},
+	{
 		.compatible = "socionext,uniphier-pxs2-usb3-hsphy",
 		.data = &uniphier_pxs2_data,
 	},
-- 
2.7.4

