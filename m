Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C42C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9F221479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfEUDkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:40:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19944 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbfEUDkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:40:19 -0400
X-UUID: 33c3fde398294b73ab9909cf30ce4232-20190521
X-UUID: 33c3fde398294b73ab9909cf30ce4232-20190521
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 367033608; Tue, 21 May 2019 11:40:14 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 11:40:12 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 11:40:12 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH] clk: mediatek: Remove MT8183 unused clock
Date:   Tue, 21 May 2019 11:40:01 +0800
Message-ID: <20190521034001.53365-1-erin.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 97CAF9D7C80D56F8BE6033CF8E65B654151A3B10C79D90FE75D003E4E7EEA6182000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove MT8183 sspm clock

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
This clock should only be set in secure world.
---
 drivers/clk/mediatek/clk-mt8183.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9d8651033ae9..1aa5f4059251 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -395,14 +395,6 @@ static const char * const atb_parents[] = {
 	"syspll_d5"
 };
 
-static const char * const sspm_parents[] = {
-	"clk26m",
-	"univpll_d2_d4",
-	"syspll_d2_d2",
-	"univpll_d2_d2",
-	"syspll_d3"
-};
-
 static const char * const dpi0_parents[] = {
 	"clk26m",
 	"tvdpll_d2",
@@ -606,9 +598,6 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_ATB, "atb_sel",
 		atb_parents, 0xa0,
 		0xa4, 0xa8, 0, 2, 7, 0x004, 24),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SSPM, "sspm_sel",
-		sspm_parents, 0xa0,
-		0xa4, 0xa8, 8, 3, 15, 0x004, 25),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_DPI0, "dpi0_sel",
 		dpi0_parents, 0xa0,
 		0xa4, 0xa8, 16, 4, 23, 0x004, 26),
@@ -947,12 +936,8 @@ static const struct mtk_gate infra_clks[] = {
 		"fufs_sel", 13),
 	GATE_INFRA2(CLK_INFRA_MD32_BCLK, "infra_md32_bclk",
 		"axi_sel", 14),
-	GATE_INFRA2(CLK_INFRA_SSPM, "infra_sspm",
-		"sspm_sel", 15),
 	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, "infra_unipro_mbist",
 		"axi_sel", 16),
-	GATE_INFRA2(CLK_INFRA_SSPM_BUS_HCLK, "infra_sspm_bus_hclk",
-		"axi_sel", 17),
 	GATE_INFRA2(CLK_INFRA_I2C5, "infra_i2c5",
 		"i2c_sel", 18),
 	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, "infra_i2c5_arbiter",
@@ -986,10 +971,6 @@ static const struct mtk_gate infra_clks[] = {
 		"msdc50_0_sel", 1),
 	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, "infra_msdc2_self",
 		"msdc50_0_sel", 2),
-	GATE_INFRA3(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self",
-		"f_f26m_ck", 3),
-	GATE_INFRA3(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self",
-		"f_f26m_ck", 4),
 	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi",
 		"axi_sel", 5),
 	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6",
-- 
2.18.0

