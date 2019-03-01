Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DCEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D361B2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fsLaLx6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfCAJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:37:54 -0500
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:8992
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbfCAJhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKFc99TszkQPWD0BXLhaOJ/CnMlOpCo1QkwGE2QZKNs=;
 b=fsLaLx6QDGfdPNfTNnpQSwaUW5nDzZOwRI5VyMMOK4yXWxNRPVMU2G58H199J1GVPncp4TCB7QkzPlDRslp3OVBB5Mvj70bW2XyyL1h+9acwN1LQjxYy+N0/lz+oVOyVjyy1bY2pnvbIZfW2qlnfZlIFMKLIr+Z4x9CMQi+Z2Oc=
Received: from BL0PR02CA0071.namprd02.prod.outlook.com (2603:10b6:207:3d::48)
 by BN6PR02MB2753.namprd02.prod.outlook.com (2603:10b6:404:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.18; Fri, 1 Mar
 2019 09:37:49 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BL0PR02CA0071.outlook.office365.com
 (2603:10b6:207:3d::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.18 via Frontend
 Transport; Fri, 1 Mar 2019 09:37:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Fri, 1 Mar 2019 09:37:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57423 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gzebz-0001DO-Sn; Fri, 01 Mar 2019 01:37:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gzebu-0007rT-Ok; Fri, 01 Mar 2019 01:37:42 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x219bbiB025540;
        Fri, 1 Mar 2019 01:37:37 -0800
Received: from [172.19.2.152] (helo=xsjsatishna40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1gzebp-0007qc-3b; Fri, 01 Mar 2019 01:37:37 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <michals@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <anirudh@xilinx.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] tty: xilinx_uartps: Correct return value in probe
Date:   Fri, 1 Mar 2019 01:37:08 -0800
Message-ID: <1551433028-25207-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
References: <1543927882-15091-1-git-send-email-rajan.vaja@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(189003)(199004)(47776003)(54906003)(305945005)(110136005)(81156014)(16586007)(316002)(8936002)(356004)(2201001)(106466001)(6666004)(50226002)(63266004)(6636002)(44832011)(486006)(8676002)(126002)(81166006)(4326008)(2616005)(476003)(14444005)(106002)(50466002)(48376002)(51416003)(76176011)(72206003)(446003)(36386004)(11346002)(478600001)(77096007)(336012)(426003)(186003)(5660300002)(26005)(2906002)(7696005)(36756003)(9786002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2753;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5659b3-3e2a-482b-8cb4-08d69e299131
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2753;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2753:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2753;20:4G8l6+A7QZ6jKfZF+MSRe1eTe91dfkm3nKcwUUHaNx/cu4A33Ynji/wKkoW3iSfPreVeELbUSczgDZhUekMG3kxO9AjmH1tn5FDqp95rDRK9ZxEYuKM9u/xOm/xy/9380NEGQXrovmNvcQbUPYClEX4hm4FMdCRYJf7s1PousHJtsLYIuDexHQmKxL57TWcz9LptV8HT9kTsNEAggqi9O9+IL8DTyrnbM2fNBLFNGQ7J6D3nQK+LseUbPs97s5mBm5RMXaPSfkqCVVsXiWUVBSxA5e/JA45GnA0eC9fCw0pKVgcjDWMJ4hQQyibYgSeoWBZbyZ2SqUkG7kp4mOc8MTZIjND+k23O4Mid19buUJtq7zCfftXobXgNph99XrXE8lHKrDTTH5Yg5rQ3HAO4mjXnAQXngWXq03Q217W+i8vKTdtdlnCu32hkHGCee0PWHy7FBLFfHCNUUUKpjAb+xaBRDA7mRJDmI6rq6m4uJEBouIKwEaLLYpGR9TnDlg+B
X-Microsoft-Antispam-PRVS: <BN6PR02MB2753AD9C2BF865C0F13BFEBCB7760@BN6PR02MB2753.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09634B1196
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2753;23:+oJfQsy9bXgQA9lYfAO1o25ssSuu9LfJ3/l2qGzmK?=
 =?us-ascii?Q?oNvMrTOmNJx8SC1AJdApu28oyF4boAUAJ3KwqptwrJiQC7ByJXgtqWNgd7xS?=
 =?us-ascii?Q?Ee4lpKs2Rs2ABEmAYa+Hd6Ij5O4mW+yLaDD3du2eXTYm62aTFKja8/7zI7Xu?=
 =?us-ascii?Q?nDJ4fa6wEAA1JryXx4AK4PiF+f2omwFa+GFoCR1CenvB5ZnzrINDY9Bcl1lG?=
 =?us-ascii?Q?fN1aToMtsnFVhUwpcc+2xKlyva6iXWdu0tFNHnXndgP1fqtIMSK1zBzrXfQL?=
 =?us-ascii?Q?j1OPu4Ua+VS86COvePcB9VvkR2WYdqh9QxFo3A+xjdSVTavx0MFaf917KEgT?=
 =?us-ascii?Q?oLKISzVuOim1KXLI5I2DW/8rMP52cPZr9GwTLXjqlZFT2GcA/W/O8NDUVWff?=
 =?us-ascii?Q?0VD4hjzHYcrrXfUpTp1z8REfjRMPL7y+MUx7b1HnnpVkIt7Wxi0OIRovDlax?=
 =?us-ascii?Q?BowuiIIsRSYbVymDbhFcdJq4/Jb5s42vs/IzWNarFabt3waSicO4oMzHJUCp?=
 =?us-ascii?Q?wMn9K/gVIfqAieg8zseAd+YkDbRGzDF+oWkCem+/juO/womYmDdE88ggTCE/?=
 =?us-ascii?Q?o7mEo61M7F7dGvf3YIcmMjjdiEHG+a+5M6sYnE8s7n+9b8HwTNV9IS56OX9y?=
 =?us-ascii?Q?CXUAv+wXuAGB4pmTKfUmDMSISHeQRCPaAIW9EUGT/FvonmREeSvrrE4TyQhb?=
 =?us-ascii?Q?Vbzvaxef5Zru6DmJtHmnfszdLwekkI8x+mpkPsM6FwID+ymabupMGR+nXKIZ?=
 =?us-ascii?Q?GfyFaJ2Fc9+qSDqKm6o8cBQVw1CZ6GHt+9KpIiPRNxSGpoZ5+3A8c6XwJSWC?=
 =?us-ascii?Q?7ZqPOyeDQwiAILJnM3rPd5W5guViOY+9ghoB9d7kQd7HEX4xt0xsvfJCznbD?=
 =?us-ascii?Q?JTQtFnoYFUuFcZhCdnc9WHP+tLIk6pbOqFy3uaLAJVBfLSW2AQDRKpX6iCuQ?=
 =?us-ascii?Q?P5DaYuRETiIxbVxo6tJ53mTxb6t4gCSErZkZLKe1seJATpGiGlTPY+o6GkZh?=
 =?us-ascii?Q?gxBlQTNRnMumBJBt/99E+U6id94IuqAV2L0Rpp0X/7FntPNmZ6Q1L5160IuS?=
 =?us-ascii?Q?Zyw+iRtSrXXXF6TrH6Hmz2QrkpAy1pG6AGcsq6j4/J2Bci0OpNs+GK/h45T6?=
 =?us-ascii?Q?5uirvowKLIRvBngjpJ+HTkGCZtV55msS8YkbeTV0vx2z2qf6Yod4EqsSNhCJ?=
 =?us-ascii?Q?DPBd6VWPSIUN1lPduMrVXYB/pKd2hx/Zc6p?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qCuNd6tsJxgUGP4zfu8oVV7HXuqDY/CMRL2ToSbjvGsNUUDU9UL5+eNHeiXKs0zkQ5vlV02W7xaLD9Onh5r+QV1bmfe8WuQ1U+DPuwI/e9O2IXIA+mkeVcmvWWPW2vMm/JtrUjHaDmbBS929lE2KtX7qTuPrdp85S6hAX/x+FvqRqkj/nggIsCGul0G5/itNNE6LB++NT8U7HfXWXFJ+NhWGjxTVhLrwdB4NNt7TfnV3P1AnBWCwcl2NN2kDJs9P3Hc5IqulxbR4v9TcLSQBzErPbQJU1IkkV6Hp5jXjb4ERPvRjwvEPSqurpHuLjllQewV0EXalO3TZmOIuJU1wqoBuqS6+9nZPRaos+flXF8fpTc5TaXqQjZnZZCaY9XF6xJYFSKrs2W3iPO0QaAH69qBgCZzlo8B2r5vZFCHKv14=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2019 09:37:48.3364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5659b3-3e2a-482b-8cb4-08d69e299131
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing driver checks for alternate clock if devm_clk_get() fails
and returns error code for last clock failure. If xilinx_uartps is
called before clock driver, devm_clk_get() returns -EPROBE_DEFER.
In this case, probe should not check for alternate clock as main
clock is already present in DTS and return -EPROBE_DEFER only.

This patch fixes it by not checking for alternate clock when main
clock get returns -EPROBE_DEFER.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
Changes in v2:
  * Handle dynamic port allocation error cases
---
 drivers/tty/serial/xilinx_uartps.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 094f295..f7ae73e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1547,27 +1547,33 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
+		rc = PTR_ERR(cdns_uart_data->pclk);
+		goto err_out_unregister_driver;
+	}
+
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "aper_clk");
-		if (!IS_ERR(cdns_uart_data->pclk))
-			dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
+		if (IS_ERR(cdns_uart_data->pclk)) {
+			rc = PTR_ERR(cdns_uart_data->pclk);
+			goto err_out_unregister_driver;
+		}
+		dev_err(&pdev->dev, "clock name 'aper_clk' is deprecated.\n");
 	}
-	if (IS_ERR(cdns_uart_data->pclk)) {
-		dev_err(&pdev->dev, "pclk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->pclk);
+
+	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
+	if (PTR_ERR(cdns_uart_data->uartclk) == -EPROBE_DEFER) {
+		rc = PTR_ERR(cdns_uart_data->uartclk);
 		goto err_out_unregister_driver;
 	}
 
-	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "ref_clk");
-		if (!IS_ERR(cdns_uart_data->uartclk))
-			dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
-	}
-	if (IS_ERR(cdns_uart_data->uartclk)) {
-		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		rc = PTR_ERR(cdns_uart_data->uartclk);
-		goto err_out_unregister_driver;
+		if (IS_ERR(cdns_uart_data->uartclk)) {
+			rc = PTR_ERR(cdns_uart_data->uartclk);
+			goto err_out_unregister_driver;
+		}
+		dev_err(&pdev->dev, "clock name 'ref_clk' is deprecated.\n");
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
-- 
2.7.4

