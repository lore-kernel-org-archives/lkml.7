Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD03C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDC520857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PlBpEdHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCRLdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:25 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:48328
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfCRLdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQgmK2MtkXRhV0wbfhSCQ6YDSTfd0/j3kCjjaT2iHDw=;
 b=PlBpEdHkYWJEOuxiYheG5x9tTvw/S/wMyEKKVSlRZvRGMAOetiBInwSj87Nwt0tt6DkuSuy0g2yk0JBC9NcKmw9HClX0/F3kIXRK8b7jmvOck6cDAT57iA+w8fa095HiusgATDQoDZJwrDx72HAmbB6sgxiE22UhBi27QtcxNbE=
Received: from DM6PR02CA0074.namprd02.prod.outlook.com (10.141.168.143) by
 BYAPR02MB4056.namprd02.prod.outlook.com (20.176.248.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 11:33:20 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0074.outlook.office365.com
 (2603:10b6:5:1f4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW7-0007ip-34; Mon, 18 Mar 2019 04:33:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW1-0008WO-VL; Mon, 18 Mar 2019 04:33:14 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVv-0008M3-8F; Mon, 18 Mar 2019 04:33:07 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 5/6] net: can: xilinx_can: Add SPDX license
Date:   Mon, 18 Mar 2019 17:02:45 +0530
Message-ID: <1552908766-26753-6-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(189003)(199004)(336012)(486006)(2616005)(426003)(2201001)(446003)(126002)(476003)(11346002)(5660300002)(36756003)(106002)(16586007)(54906003)(110136005)(14444005)(6636002)(50226002)(9786002)(8936002)(8676002)(81156014)(81166006)(2906002)(36386004)(356004)(305945005)(6666004)(50466002)(186003)(48376002)(4326008)(106466001)(76176011)(7696005)(316002)(478600001)(51416003)(63266004)(107886003)(77096007)(47776003)(26005)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4056;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ced3c2-bd2b-47ef-3ff9-08d6ab958589
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR02MB4056;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4056:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4056D95B4A25D1E7F4581D4CDC470@BYAPR02MB4056.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AtEs3Y8Se0tigJ4wc1nxEGgB6hI6TZTZaPtHv4a3hmIA+EQfSClcEy5X6/F1XiDdWEHSOaZaSsnTkG2YQH/RmBjeRuqC4gFEZOaVM+cdJ4+YdYVnw4p7YnTtHZJc/Zo4DQGmTxVaONemo1c13mUlFgZ269nTh+XPaO3O3GxxK0AAM/DLtWKQWVcUmgmUbepGdGIFgsYA9YCu7aLFEsWfbnlk3AxbQ5m5FOKQiyojrtSSXDbCLSjjVd7pGkgSCU1F/Vyizb2jQxgErsbWfUmcCX22zuRfuj08fP3ZAcp3WKVfWNMKwpJpDGqFQPc0nSSb+YF7DdxL2Jq3M9+JlHn5u0BvaBk6gfnfMHVCeQX/8EPRvjEKotH3TXw+SCQLiiqv2hByvA3DLWHppORGtMW/sAOARhA2b6szJAdCKxOw48s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:19.6593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ced3c2-bd2b-47ef-3ff9-08d6ab958589
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update driver to have SPDX identifiers.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3d75a28..e1544e0 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1,20 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Xilinx CAN device driver
  *
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
  * Copyright (C) 2009 PetaLogix. All rights reserved.
  * Copyright (C) 2017 - 2018 Sandvik Mining and Construction Oy
  *
- * Description:
- * This driver is developed for Axi CAN IP and for Zynq CANPS Controller.
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
-- 
2.7.4

