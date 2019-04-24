Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D401C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A68217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfDXB0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:26:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50986 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbfDXB0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:26:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 39A931A004D;
        Wed, 24 Apr 2019 03:26:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 484AB1A0023;
        Wed, 24 Apr 2019 03:26:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 17ACA402A3;
        Wed, 24 Apr 2019 09:26:38 +0800 (SGT)
From:   andy.tang@nxp.com
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] clk: qoriq: Add ls1028a clock configuration
Date:   Wed, 24 Apr 2019 09:19:12 +0800
Message-Id: <20190424011912.2179-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Enable clock driver by adding clock configuration for ls1028a chip.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/clk/clk-qoriq.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 1212a9b..8b0cb0b 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -245,6 +245,58 @@ static u32 cg_in(struct clockgen *cg, u32 __iomem *reg)
 	},
 };
 
+static const struct clockgen_muxinfo ls1028a_hwa1 = {
+	{
+		{ CLKSEL_VALID, PLATFORM_PLL, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV4 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
+static const struct clockgen_muxinfo ls1028a_hwa2 = {
+	{
+		{ CLKSEL_VALID, PLATFORM_PLL, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV4 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+	},
+};
+
+static const struct clockgen_muxinfo ls1028a_hwa3 = {
+	{
+		{ CLKSEL_VALID, PLATFORM_PLL, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV4 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
+static const struct clockgen_muxinfo ls1028a_hwa4 = {
+	{
+		{ CLKSEL_VALID, PLATFORM_PLL, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV4 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+	},
+};
+
 static const struct clockgen_muxinfo ls1043a_hwa1 = {
 	{
 		{},
@@ -508,6 +560,21 @@ static void __init t4240_init_periph(struct clockgen *cg)
 		.pll_mask = 0x03,
 	},
 	{
+		.compat = "fsl,ls1028a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12
+		},
+		.hwaccel = {
+			&ls1028a_hwa1, &ls1028a_hwa2,
+			&ls1028a_hwa3, &ls1028a_hwa4
+		},
+		.cmux_to_group = {
+			0, 0, 0, 0, -1
+		},
+		.pll_mask = 0x07,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,ls1043a-clockgen",
 		.init_periph = t2080_init_periph,
 		.cmux_groups = {
@@ -1423,6 +1490,7 @@ static void __init clockgen_init(struct device_node *np)
 CLK_OF_DECLARE(qoriq_clockgen_b4860, "fsl,b4860-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1028a, "fsl,ls1028a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
-- 
1.7.1

