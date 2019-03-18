Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66998C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E1B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Kz1b2MbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCRLdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:14 -0400
Received: from mail-eopbgr780057.outbound.protection.outlook.com ([40.107.78.57]:47104
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfCRLdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qQxcYaoxTnDCnpnjnSWtFHSTiXz1mL+gmo3jXWm8zo=;
 b=Kz1b2MbAYGk2iFeZtnajWELeyDBB7qcry7aAQHgCAt1pmOST2GCp5S/kD0yS78A/ty+POVRiTOAkx3/c2dpdX5FUqsZW3awBKFnqLb+mAMge0W54GFLp3bp1GL55p9lXbJw8qXGadbXuFEI5+HZM7j83R3GQDjlwrQL1zJRJE9s=
Received: from MWHPR02CA0041.namprd02.prod.outlook.com (2603:10b6:301:60::30)
 by BN6PR02MB2834.namprd02.prod.outlook.com (2603:10b6:404:fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 11:33:10 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR02CA0041.outlook.office365.com
 (2603:10b6:301:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVw-0007ii-Lp; Mon, 18 Mar 2019 04:33:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVr-0008T7-I6; Mon, 18 Mar 2019 04:33:03 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVh-0008M3-14; Mon, 18 Mar 2019 04:32:53 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Date:   Mon, 18 Mar 2019 17:02:40 +0530
Message-ID: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(199004)(189003)(81156014)(8676002)(2906002)(7696005)(9786002)(316002)(51416003)(81166006)(77096007)(16586007)(26005)(50226002)(186003)(110136005)(478600001)(106466001)(54906003)(107886003)(106002)(4326008)(8936002)(305945005)(336012)(486006)(36386004)(36756003)(4744005)(476003)(50466002)(48376002)(426003)(126002)(6636002)(2616005)(63266004)(2201001)(6666004)(356004)(47776003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2834;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9adeb19-78dc-438a-ba3c-08d6ab957f52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2834;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2834:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB28341F16FEC0DC1F22511B4CDC470@BN6PR02MB2834.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: P057M+rz25Lz2BMHAw6dyjiOC7fEBPTjlcx5C5xDatEOJlfXEaib+bVOBx+5Trb4EUFLbtdVhhOL0JwEWtqjqvV/heVgYDSD+KBGmgpgJAQjrQs0ypgFgqnOWFK0VlNCaNehdgk/A4kT9UzmAdmXsKq4qMLP5bz2CHELqSFGDT8QxGLZeQksigV7RPGSWvWDRMsJEOVVFItsULl3mgjGDzfjsfWZFdquklP/T8nYRE553fqYGJ054pWE5jTuz5Jm9Mc4Ph5tKkUHXHpE4u987fw/K00+ciWUq3XYBDH2ARSYAVnEOJghxRT2rJLm+ANDb4nwjo+gCa/IdbeXqwWQJjLb4ZI5ekFVRqiEPAnh6DZmG2UYydAYKM9K4ngA0KyQckU8JaidbMh9fxsVnEpFxrP5UW1T5JJAi8V4Hv8Bk5o=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:09.2367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9adeb19-78dc-438a-ba3c-08d6ab957f52
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the below
--> Added support for CANFD FD frames
--> Fix Checkpatch reported warnings and checks

Appana Durga Kedareswara rao (6):
  net: can: xilinx_can: Fix style issues
  net: can: xilinx_can: Fix flags field initialization for axi can and
    canps
  net: can: xilinx_can: Add cantype parameter in xcan_devtype_data
    struct
  net: can: xilinx_can: Add support for CANFD FD frames
  net: can: xilinx_can: Add SPDX license
  net: can: xilinx_can: Fix kernel doc warnings

 drivers/net/can/xilinx_can.c | 303 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 257 insertions(+), 46 deletions(-)

-- 
2.7.4

