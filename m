Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7825FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB922168B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK1GhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:37:07 -0500
Received: from mail-eopbgr680052.outbound.protection.outlook.com ([40.107.68.52]:3765
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfK1GhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:37:05 -0500
Received: from BN7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:20::34)
 by DM5PR02MB2699.namprd02.prod.outlook.com (2603:10b6:3:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Thu, 28 Nov
 2019 06:37:03 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN7PR02CA0021.outlook.office365.com
 (2603:10b6:408:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Thu, 28 Nov 2019 06:37:03 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:37:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQE-0007Ye-97; Wed, 27 Nov 2019 22:37:02 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQ9-0005Ei-5W; Wed, 27 Nov 2019 22:36:57 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6asYH007316;
        Wed, 27 Nov 2019 22:36:54 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQ5-00059i-VB; Wed, 27 Nov 2019 22:36:54 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 07/10] clk: clock-wizard: Update the fixed factor divisors
Date:   Thu, 28 Nov 2019 12:06:14 +0530
Message-Id: <55183b0a7c466528361802fabef65a57f969d07b.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.597-7.0-31-1
X-imss-scan-details: No--1.597-7.0-31-1;No--1.597-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193966228577311;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(14444005)(50466002)(81156014)(70586007)(5660300002)(76482006)(73392003)(70206006)(36756003)(107886003)(9786002)(118296001)(4326008)(50226002)(86362001)(336012)(446003)(426003)(11346002)(82202003)(450100002)(9686003)(305945005)(8676002)(498600001)(81166006)(15650500001)(2906002)(8936002)(356004)(6666004)(26005)(47776003)(16586007)(7696005)(51416003)(316002)(76176011)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2699;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c48aa87-fb15-490f-cde9-08d773cd60f7
X-MS-TrafficTypeDiagnostic: DM5PR02MB2699:
X-Microsoft-Antispam-PRVS: <DM5PR02MB26999F34F39747E18B2F6F9887470@DM5PR02MB2699.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aqNuIf3VfArfihCByujgJm0C1LFCDKnMf1DiGXChQGIEMqa5OiMrsPAgWcZzAVXN7mKw6Yi/7oj/C0ph3TWpZx4zXcYF4p/aOV5JPI+pGBULv0c2Y+LHTq961QHZzDIn9mCQoj3jfJfkfz1OpQRwYhAdfg9XmyrwKQe8l19O5xLr3TpBGQfsbw4nOShMkHP2E8ifRrLZ64ElDQnpAu3j6q63GlBg71O4HlGAMrNHjumii0Y8aMgPBHZln0vrz3ePNOqF58eVp+/CXgnJsnnejwdXktZllm4eFt2cEowShOSX3JaGg/HqMRny4oEBs5YTkRmiBJG/o/5eL8ElA37iN8R14AeXtppBmGyipxQ1Dk5zbNCAIZcxGPWcctlvpA3v3NN3PWHkXwBwGj7VXZ0hfFtICzdHDKm/1D4zcnsVE2IjhdFz/Uvx+GDKIR/S0uD
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:37:02.7196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c48aa87-fb15-490f-cde9-08d773cd60f7
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Update the fixed factor clock registration to register the divisors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 4c6155b..75ea745 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -491,9 +491,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	u32 reg, reg_f, mult;
 	unsigned long rate;
 	const char *clk_name;
+	void __iomem *ctrl_reg;
 	struct clk_wzrd *clk_wzrd;
 	struct resource *mem;
 	int outputs;
+	unsigned long flags = 0;
 	struct device_node *np = pdev->dev.of_node;
 
 	clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
@@ -564,19 +566,22 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	/* register div */
-	reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
-			WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
+	outputs = of_property_count_strings(np, "clock-output-names");
+	if (outputs == 1)
+		flags = CLK_SET_RATE_PARENT;
 	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
 	if (!clk_name) {
 		ret = -ENOMEM;
 		goto err_rm_int_clk;
 	}
 
-	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_fixed_factor
+	ctrl_reg = clk_wzrd->base + WZRD_CLK_CFG_REG(0);
+	/* register div */
+	clk_wzrd->clks_internal[wzrd_clk_mul_div] = clk_register_divider
 			(&pdev->dev, clk_name,
 			 __clk_get_name(clk_wzrd->clks_internal[wzrd_clk_mul]),
-			 0, 1, reg);
+			flags, ctrl_reg, 0, 8, CLK_DIVIDER_ONE_BASED |
+			CLK_DIVIDER_ALLOW_ZERO, &clkwzrd_lock);
 	if (IS_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div])) {
 		dev_err(&pdev->dev, "unable to register divider clock\n");
 		ret = PTR_ERR(clk_wzrd->clks_internal[wzrd_clk_mul_div]);
@@ -597,7 +602,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		if (!i)
 			clk_wzrd->clkout[i] = clk_wzrd_register_divf
 				(&pdev->dev, clkout_name,
-				clk_name, 0,
+				clk_name, flags,
 				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
 				WZRD_CLKOUT_DIVIDE_SHIFT,
 				WZRD_CLKOUT_DIVIDE_WIDTH,
-- 
2.1.1

