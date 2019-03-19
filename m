Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4690820872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SPNuDFv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCSFya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:54:30 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:45287
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfCSFya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIO0Bgxrku/dps7aMfToPcX2HZnqevpe1XUahI9WU2M=;
 b=SPNuDFv83/Z+bzcdZscK3HCebaJTjRCcOzM0/b2dAUX5UlIp6POmYftS61OyTF/b8Gq+lBSCosYcuCu7dcogCwtMFBrBwhUS8uVq6CjDIeP7xQC4l521toHQc/x1tdfCAX9nSRwwKZdwMmmWWQvsZCr0MiuNyOi1BspLS6S3bt4=
Received: from BN7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:20::38)
 by CY4PR02MB2357.namprd02.prod.outlook.com (2603:10b6:903:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 05:54:26 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN7PR02CA0025.outlook.office365.com
 (2603:10b6:408:20::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 05:54:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 05:54:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h67hg-0000ax-TM; Mon, 18 Mar 2019 22:54:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h67hb-0005jC-Qb; Mon, 18 Mar 2019 22:54:19 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2J5s9RZ008873;
        Mon, 18 Mar 2019 22:54:10 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h67hR-0005iU-Dq; Mon, 18 Mar 2019 22:54:09 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH] net: macb: Add null check for PCLK and HCLK
Date:   Tue, 19 Mar 2019 11:24:05 +0530
Message-ID: <1552974845-1590-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(4326008)(50226002)(478600001)(47776003)(50466002)(2906002)(63266004)(16586007)(48376002)(305945005)(316002)(110136005)(9786002)(54906003)(8676002)(26005)(77096007)(6666004)(5660300002)(6346003)(186003)(36756003)(81156014)(36386004)(44832011)(107886003)(8936002)(486006)(336012)(356004)(81166006)(476003)(126002)(426003)(106002)(106466001)(51416003)(7696005)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2357;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e8ea282-b3d2-4b3e-d832-08d6ac2f57fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR02MB2357;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2357:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB235730D32DCC1ABBA2FE3D6AC9400@CY4PR02MB2357.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cVOmOwnvth6Fr8aK5onQkTrEjxjTIcc8ZuUyZxZtJETcikzgYL83/7/fRvYJwi0cQPfDgT/2HAjartyGbw3I4sF6CXz6JNDKS07bELSSYm28h85JnOvHOQ+GtlsnWVkBfGzRvgtmemlM/p3WkpD1F8ePiAXzoy6BCjxSw+eWHC1ts6El/KFUOmRs3PLO0T2vJqMziVv7wdSjIWgxG3idr+EtOo1RqW0ecgalTkyRZAiCdN4vHvq6O6aJTLMX9N2apxwTHKTYk6ZHDAatPSLGgvkVqUgLFL+klhe7L6nd55gJNHeZGEmCpbipO/UUu7vTWp+JzTgM1XlFCoaQoP6goBS2du5LiChcAWpGHE0NwPEJNfDd4uc6ThtEtkYJCOG0/wyimWWZkwhZzk1dt12k6j5mikna0kp8ZmFSnpcL5ng=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 05:54:25.7385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8ea282-b3d2-4b3e-d832-08d6ac2f57fc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both PCLK and HCLK are "required" clocks according to macb devicetree
documentation. There is a chance that devm_clk_get doesn't return a
negative error but just a NULL clock structure instead. In such a case
the driver proceeds as usual and uses pclk value 0 to calculate MDC
divisor which is incorrect. Hence fix the same in clock initialization.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ad099fd..d12d815 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3370,13 +3370,13 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		*hclk = devm_clk_get(&pdev->dev, "hclk");
 	}
 
-	if (IS_ERR(*pclk)) {
+	if (IS_ERR(*pclk) || (*pclk == NULL)) {
 		err = PTR_ERR(*pclk);
 		dev_err(&pdev->dev, "failed to get macb_clk (%u)\n", err);
 		return err;
 	}
 
-	if (IS_ERR(*hclk)) {
+	if (IS_ERR(*hclk) || (*hclk == NULL)) {
 		err = PTR_ERR(*hclk);
 		dev_err(&pdev->dev, "failed to get hclk (%u)\n", err);
 		return err;
-- 
2.7.4

