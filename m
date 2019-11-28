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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8526621736
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfK1GhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:37:10 -0500
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:45792
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfK1GhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:37:08 -0500
Received: from DM6PR02CA0056.namprd02.prod.outlook.com (2603:10b6:5:177::33)
 by DM5PR02MB2827.namprd02.prod.outlook.com (2603:10b6:3:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Thu, 28 Nov
 2019 06:37:05 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by DM6PR02CA0056.outlook.office365.com
 (2603:10b6:5:177::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Thu, 28 Nov 2019 06:37:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:37:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQG-0007Yf-M5; Wed, 27 Nov 2019 22:37:04 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQB-0005Ep-IW; Wed, 27 Nov 2019 22:36:59 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6awt7004652;
        Wed, 27 Nov 2019 22:36:58 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQA-00059i-3G; Wed, 27 Nov 2019 22:36:58 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 08/10] clk: clock-wizard: Make the output names unique
Date:   Thu, 28 Nov 2019 12:06:15 +0530
Message-Id: <d9277db2692bb77a41dfed927cfb791bdcced17d.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.385-7.0-31-1
X-imss-scan-details: No--5.385-7.0-31-1;No--5.385-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193966255371613;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(5660300002)(305945005)(450100002)(9686003)(2906002)(118296001)(4326008)(107886003)(82202003)(70206006)(70586007)(498600001)(316002)(86362001)(48376002)(76482006)(50466002)(9786002)(8676002)(81156014)(8936002)(81166006)(36756003)(50226002)(16586007)(47776003)(446003)(26005)(336012)(51416003)(426003)(356004)(73392003)(14444005)(76176011)(11346002)(7696005)(6666004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2827;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3688dd17-45cd-41e2-8f4d-08d773cd6288
X-MS-TrafficTypeDiagnostic: DM5PR02MB2827:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2827BFCCE07F158461EF9BCC87470@DM5PR02MB2827.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2qYCgHezNkj2vRVZ4Vdy+4qYHjhTzQ/YvMh8f5xiErYmYRZdKjkv3jIajZPWM8T/Z8p1QCIm47UtlqsFHW5/7E2peB9qC66ymtdnOzjcip09fZT9B3k5fWWRECOTId6DQ6hvK2ui2KzvptGWyxnfzqQlKSb7XKVxTbBb6lcRxKf1ssjZ4/QIlUxa0xScyFoUlW3Lb2n0h685grNX7K0imSQFBL4KuEyoyIDuQNh+6xF9+q/hSW3ywEA3JWDn4nV1b8DJPhejPuYyYgg7t4phmCMqd/9ghwZQoTE4lQHf7tK+AdZts/P+PNn7ynx/9Dr8533DpRSZxkFziL9v4R/6eeRiFiNPvRWX82SwtSBYSNay+DYC6OiWxLLQRaYs+e8NhXM5FqxeZY1P2XFKEIeOAUNAty9sfgNp+f9OzdsabPCOk9leR/smXFQdn0dTUJg
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:37:05.2779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3688dd17-45cd-41e2-8f4d-08d773cd6288
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2827
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Incase there are more than one instance of the clocking wizard.
And if the output name given is the same then the probe fails.
Fix the same by appending the device name to the output name to
make it unique.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 75ea745..9993543 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -555,6 +555,9 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_disable_clk;
 	}
+	outputs = of_property_count_strings(np, "clock-output-names");
+	if (outputs == 1)
+		flags = CLK_SET_RATE_PARENT;
 	clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
 			(&pdev->dev, clk_name,
 			 __clk_get_name(clk_wzrd->clk_in1),
@@ -566,9 +569,6 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	outputs = of_property_count_strings(np, "clock-output-names");
-	if (outputs == 1)
-		flags = CLK_SET_RATE_PARENT;
 	clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
 	if (!clk_name) {
 		ret = -ENOMEM;
@@ -591,6 +591,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 	/* register div per output */
 	for (i = outputs - 1; i >= 0 ; i--) {
 		const char *clkout_name;
+		const char *clkout_name_wiz;
 
 		if (of_property_read_string_index(np, "clock-output-names", i,
 						  &clkout_name)) {
@@ -599,9 +600,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_rm_int_clks;
 		}
+		clkout_name_wiz = kasprintf(GFP_KERNEL, "%s_%s",
+					    dev_name(&pdev->dev), clkout_name);
 		if (!i)
 			clk_wzrd->clkout[i] = clk_wzrd_register_divf
-				(&pdev->dev, clkout_name,
+				(&pdev->dev, clkout_name_wiz,
 				clk_name, flags,
 				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
 				WZRD_CLKOUT_DIVIDE_SHIFT,
@@ -610,7 +613,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 				NULL, &clkwzrd_lock);
 		else
 			clk_wzrd->clkout[i] = clk_wzrd_register_divider
-				(&pdev->dev, clkout_name,
+				(&pdev->dev, clkout_name_wiz,
 				clk_name, 0,
 				clk_wzrd->base, (WZRD_CLK_CFG_REG(2) + i * 12),
 				WZRD_CLKOUT_DIVIDE_SHIFT,
-- 
2.1.1

