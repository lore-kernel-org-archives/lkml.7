Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C95C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F6222B48
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l1IwK6Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLEGhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:37:38 -0500
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:35200
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbfLEGhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:37:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8hu840KSCk8imC9F0AQID4xymmV+yC3EJf2BedsxE/JWLrkzeGXE/IVJa5fPRrvzWGyVxgX5bu/FeF8PTPM7yX51y4yOmtHc8aJ1U3OLtrZd8+BlIYs4Io0K1jbL3AfR6lD7OrSiqRsbyw5VxCYW1hXJwl9uqsEZ1i/DXIBFBmhxxxganiY7P8hdTKWzT2J1ZbE8/M80xf4zNvLWs92Q7YihSmG4pyLs0dh+hkymlgoGtkJshZs3chl/IuuSLouGuYVVFULrQyZhhlrEvuJBOp5/CMhz0uesqHMaSbGblhpDD6RYSTUaLnQxQKD74mH+AO2SyqYoDbEeviM67gCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=cZ+it4umzxIZMpE6ZpjqqJc2e4LrrCvK/5o7OYIhK9OhkQqEV9pksWzlEB1TcWfgq/owSKEROBnGucn698hlZsCpTt9c2cTlV07jRsQrkKtUGH2zlKlMmvbnPHukn7MCqyHRYTJimHnozjExDvNGFICxYB52wPYaa1XLWWXZSqifCNToA4whIW3E0ZCx/5qTWSPexqSbLi4xBnhliPWyJAJgzQhepjhHCox3JerRDKqf/jvWWYQ96yh0Yv6oeKmkCEu47UrQSdp5nF3fRRl+hvIk4BhC3ODrrCpbxM5q75atHDbRyO1sZ5d7xWN+rQNm3yDQRqkHp7bUO5qZjKc3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CHQI/shtHh7y7xVKO9wv5ZGzwFahyHkg96iYSppKM=;
 b=l1IwK6BnPGJTfJzXbfe890PqHvRuOBn9t0BquJN647rmtrH8qfPRVsZaYHgYbZMjPxk3giWtb1KeOHIoyamjrnaBB2US8fImydNs2DxkMK2oLqs137fS+BzeOulp7/OFPCNDDbrMfGT6RD11erE7ZNWpjDf8EWsSSaY/4B/fLX0=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by MN2PR02MB6989.namprd02.prod.outlook.com (2603:10b6:208:20f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Thu, 5 Dec
 2019 06:37:35 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Thu, 5 Dec 2019 06:37:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 5 Dec 2019 06:37:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ickla-0000xI-G7; Wed, 04 Dec 2019 22:37:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklV-0000XV-CV; Wed, 04 Dec 2019 22:37:29 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB56bJpk003539;
        Wed, 4 Dec 2019 22:37:20 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1icklL-0000WL-Qw; Wed, 04 Dec 2019 22:37:19 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        gustavo@embeddedor.com, tejas.patel@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v3 2/6] clk: zynqmp: Extend driver for versal
Date:   Wed,  4 Dec 2019 22:35:55 -0800
Message-Id: <1575527759-26452-3-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com>
 <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(426003)(36756003)(70206006)(2616005)(2906002)(70586007)(51416003)(14444005)(26005)(44832011)(336012)(7696005)(11346002)(186003)(316002)(16586007)(5660300002)(4326008)(107886003)(305945005)(81156014)(81166006)(76176011)(36386004)(6666004)(8936002)(356004)(50466002)(478600001)(4744005)(8676002)(7416002)(9786002)(50226002)(48376002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6989;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb32a81e-a208-49a9-fd25-08d7794d9d15
X-MS-TrafficTypeDiagnostic: MN2PR02MB6989:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6989186B3E7FF90FC10C0E23B75C0@MN2PR02MB6989.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 02426D11FE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY1Vcie4ejMmyJJk/LlT0RBNBCMTFsHYVmRCnQGWa0U7BtCaH/IKf+kaLajsD/aeOkEkQDGUY0q30qdpG0xg+ecYzzCUwYRHUtZbuzqIWIeEKA4I895DMmhA+CELDGzbjyZqo7V9qTGzyr/F+0woaL+HfwBGBKIvRrTFihRlJKeNIXu08jUHfwpuLyGlpvVcZLADsr7k13uwqyFgV51l2OPJrZfRghMnTJy9+qWkjPaexzCDyGKgJu3+Qh1f8NqxR5J9UGYTlh2gFh1QlVeqogL5FTDTD2aQGAfmjC/N1TjeaiKhm9h4EaKbCKg7f02GK2jwQ+Yo6s4us7wkk5NgxZlPaSvqDkvODO21ug3fBvxYQB0erUd9Xcg//NkSCwbhp/Hd42p6oBuq3RYRCYZfCvtk69S3FkoqWmXmpnSAmO3dH2FYsYHkS+3bBkRcZzvS9Ke+0hptYZXdnVe+kEgSISHhLi04J5Ovo0v4voxdtZADtFHEGUlix579pIxsFHLo
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 06:37:34.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb32a81e-a208-49a9-fd25-08d7794d9d15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6989
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Versal compatible string to support Versal
binding.

Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/zynqmp/clkc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index a11f93e..10e89f2 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -2,7 +2,7 @@
 /*
  * Zynq UltraScale+ MPSoC clock controller
  *
- *  Copyright (C) 2016-2018 Xilinx
+ *  Copyright (C) 2016-2019 Xilinx
  *
  * Based on drivers/clk/zynq/clkc.c
  */
@@ -749,6 +749,7 @@ static int zynqmp_clock_probe(struct platform_device *pdev)
 
 static const struct of_device_id zynqmp_clock_of_match[] = {
 	{.compatible = "xlnx,zynqmp-clk"},
+	{.compatible = "xlnx,versal-clk"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, zynqmp_clock_of_match);
-- 
2.7.4

