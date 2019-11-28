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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0561C33C8C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0320216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfK1GhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:37:17 -0500
Received: from mail-eopbgr690047.outbound.protection.outlook.com ([40.107.69.47]:11926
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfK1GhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:37:16 -0500
Received: from BN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:404:5f::16)
 by MWHPR02MB3328.namprd02.prod.outlook.com (2603:10b6:301:62::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 28 Nov
 2019 06:37:14 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN6PR02CA0030.outlook.office365.com
 (2603:10b6:404:5f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Thu, 28 Nov 2019 06:37:14 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:37:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQP-0007Z3-Ll; Wed, 27 Nov 2019 22:37:13 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQK-0005Gv-ID; Wed, 27 Nov 2019 22:37:08 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6b7gm007343;
        Wed, 27 Nov 2019 22:37:07 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDQJ-00059i-3I; Wed, 27 Nov 2019 22:37:07 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 10/10] clk: clock-wizard: Fix the compilation failure
Date:   Thu, 28 Nov 2019 12:06:17 +0530
Message-Id: <a0880cfbbcc729171a37e2a3bc27680efb06e398.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.920-7.0-31-1
X-imss-scan-details: No--5.920-7.0-31-1;No--5.920-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193966344852820;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(82202003)(356004)(446003)(11346002)(6666004)(8936002)(81166006)(50226002)(8676002)(81156014)(86362001)(426003)(9786002)(47776003)(118296001)(5660300002)(9686003)(50466002)(48376002)(305945005)(76482006)(498600001)(107886003)(73392003)(450100002)(2906002)(336012)(26005)(7696005)(51416003)(4326008)(76176011)(16586007)(36756003)(70206006)(70586007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3328;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8960153-af31-44ac-fa7d-08d773cd67d7
X-MS-TrafficTypeDiagnostic: MWHPR02MB3328:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3328A71624480BD0486F959D87470@MWHPR02MB3328.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ftl+ZRXdXsGRsP9gQNi5YR1sOOBW+62MJKXDY9HcWVBCVfjhsdX0oxP+50aYB47T9WwXusUSS8rErtX6+rmpQGvLLrQnLHHYkAdowCiA3GFMzAQKhQWNowv/iHZbAI+LJmjhodK4TuyBYnMjOBZgS3r7seTr11CQWQxZmcfdKniWaZ74fyDK9njA9O4WD9Kndl0UgnJgr+mn6tTiMx6T+J67J9GfX/DXcpYW5JlH/kZrmkvohxE6KZ9VxdJ49vYoAEwLRB4z2YFhJuH84G+8xPm32TW9/Se131nxr8BRXnHyRe6kx3xXsM9a5jWM2uO38jcMazCNWZaXKd8JYgyBdZu5CozIgI3GH4Os42cQaR+LeYWdmk8vyRblknM22LiBMXu+9m/FVnqyYw9vhnEiZfoF615rnb8V/uW1L1FWpdnlaisH0SXHHDzRjYwo4hbL
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:37:14.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8960153-af31-44ac-fa7d-08d773cd67d7
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

After 90b6c5c73 (clk: Remove CLK_IS_BASIC clk flag)
The CLK_IS_BASIC is deleted. Adapt the driver for the same.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 9993543..76cfa05 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -345,7 +345,7 @@ static struct clk *clk_wzrd_register_divf(struct device *dev,
 	else
 		init.ops = &clk_wzrd_clk_divider_ops_f;
 
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
@@ -402,7 +402,7 @@ static struct clk *clk_wzrd_register_divider(struct device *dev,
 		init.ops = &clk_divider_ro_ops;
 	else
 		init.ops = &clk_wzrd_clk_divider_ops;
-	init.flags = flags | CLK_IS_BASIC;
+	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
 	init.num_parents = (parent_name ? 1 : 0);
 
-- 
2.1.1

