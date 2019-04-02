Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCADC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502962084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfDBSZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:25:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731509AbfDBSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:25:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32IJJIH146241
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 14:25:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmbkxckqt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:25:21 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Tue, 2 Apr 2019 19:25:20 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 19:25:15 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32IPEQO24969296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 18:25:14 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E2CAE06F;
        Tue,  2 Apr 2019 18:25:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11585AE060;
        Tue,  2 Apr 2019 18:25:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.3.116.186])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 18:25:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        joel@jms.id.au, andrew@aj.id.au, mchehab@kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: [PATCH 4/5] clk: Aspeed: Setup video engine clocking
Date:   Tue,  2 Apr 2019 18:25:03 +0000
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040218-0060-0000-0000-00000327846C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183362; UDB=6.00619524; IPR=6.00964111;
 MB=3.00026264; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 18:25:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040218-0061-0000-0000-000048CFF8C0
Message-Id: <1554229504-5661-5-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eclk mux and clock divider table. Also change the video engine reset
to the correct clock; it was previously on the video capture but needs
to be on the video engine clock.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/clk/clk-aspeed.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 5961367..42b4df6 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -87,10 +87,10 @@ struct aspeed_clk_gate {
 /* TODO: ask Aspeed about the actual parent data */
 static const struct aspeed_gate_data aspeed_gates[] = {
 	/*				 clk rst   name			parent	flags */
-	[ASPEED_CLK_GATE_ECLK] =	{  0, -1, "eclk-gate",		"eclk",	0 }, /* Video Engine */
+	[ASPEED_CLK_GATE_ECLK] =	{  0,  6, "eclk-gate",		"eclk",	0 }, /* Video Engine */
 	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
 	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
-	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
+	[ASPEED_CLK_GATE_VCLK] =	{  3, -1, "vclk-gate",		NULL,	0 }, /* Video Capture */
 	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	CLK_IS_CRITICAL }, /* PCIe/PCI */
 	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	CLK_IS_CRITICAL }, /* DAC */
 	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
@@ -113,6 +113,24 @@ struct aspeed_clk_gate {
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
+static const char * const eclk_parent_names[] = {
+	"mpll",
+	"hpll",
+	"dpll",
+};
+
+static const struct clk_div_table ast2500_eclk_div_table[] = {
+	{ 0x0, 2 },
+	{ 0x1, 2 },
+	{ 0x2, 3 },
+	{ 0x3, 4 },
+	{ 0x4, 5 },
+	{ 0x5, 6 },
+	{ 0x6, 7 },
+	{ 0x7, 8 },
+	{ 0 }
+};
+
 static const struct clk_div_table ast2500_mac_div_table[] = {
 	{ 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
 	{ 0x1, 4 },
@@ -192,18 +210,21 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
 
 struct aspeed_clk_soc_data {
 	const struct clk_div_table *div_table;
+	const struct clk_div_table *eclk_div_table;
 	const struct clk_div_table *mac_div_table;
 	struct clk_hw *(*calc_pll)(const char *name, u32 val);
 };
 
 static const struct aspeed_clk_soc_data ast2500_data = {
 	.div_table = ast2500_div_table,
+	.eclk_div_table = ast2500_eclk_div_table,
 	.mac_div_table = ast2500_mac_div_table,
 	.calc_pll = aspeed_ast2500_calc_pll,
 };
 
 static const struct aspeed_clk_soc_data ast2400_data = {
 	.div_table = ast2400_div_table,
+	.eclk_div_table = ast2400_div_table,
 	.mac_div_table = ast2400_div_table,
 	.calc_pll = aspeed_ast2400_calc_pll,
 };
@@ -522,6 +543,22 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 		return PTR_ERR(hw);
 	aspeed_clk_data->hws[ASPEED_CLK_24M] = hw;
 
+	hw = clk_hw_register_mux(dev, "eclk-mux", eclk_parent_names,
+				 ARRAY_SIZE(eclk_parent_names), 0,
+				 scu_base + ASPEED_CLK_SELECTION, 2, 0x3, 0,
+				 &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
+
+	hw = clk_hw_register_divider_table(dev, "eclk", "eclk-mux", 0,
+					   scu_base + ASPEED_CLK_SELECTION, 28,
+					   3, 0, soc_data->eclk_div_table,
+					   &aspeed_clk_lock);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
+
 	/*
 	 * TODO: There are a number of clocks that not included in this driver
 	 * as more information is required:
@@ -531,7 +568,6 @@ static int aspeed_clk_probe(struct platform_device *pdev)
 	 *   RGMII
 	 *   RMII
 	 *   UART[1..5] clock source mux
-	 *   Video Engine (ECLK) mux and clock divider
 	 */
 
 	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
-- 
1.8.3.1

