Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7120C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7241C21537
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Cxlshnxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfFSU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:59:57 -0400
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:37070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfFSU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTHGYOhpatmnEqkiw9CQVzMRW8PafcxSLjZyEiD7N64=;
 b=CxlshnxovhlTt/G0xAgrLQ5pdxXnsE/jSIx+STMI4KRAIzw0yeFnD1AMNxFa5Mu52v0aulKxhSM/JMkwNxEfyh/Wg1+jU8WqjgV6Y+/faM+c8BHqbPsC2VUy5kOQ0YHj3p6uXwGMFGVOCahjLhzTYVOWTn6S+3YxVMGK2gGNcZA=
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by DM6PR02MB6234.namprd02.prod.outlook.com (2603:10b6:5:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Wed, 19 Jun
 2019 20:59:54 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Wed, 19 Jun 2019 20:59:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Wed, 19 Jun 2019 20:59:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34414 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hdhgP-0002H1-Al; Wed, 19 Jun 2019 13:59:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hdhgK-0001oK-6L; Wed, 19 Jun 2019 13:59:48 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5JKxauR005191;
        Wed, 19 Jun 2019 13:59:37 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1hdhg8-0001ng-P6; Wed, 19 Jun 2019 13:59:36 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH] firmware: xilinx: zynqmp: Remove unused macro
Date:   Wed, 19 Jun 2019 13:59:34 -0700
Message-Id: <1560977974-6267-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(486006)(70586007)(48376002)(356004)(126002)(476003)(50466002)(63266004)(336012)(70206006)(9786002)(426003)(478600001)(14444005)(72206003)(107886003)(6636002)(4326008)(2906002)(16586007)(2616005)(44832011)(305945005)(8936002)(50226002)(36386004)(36756003)(7696005)(51416003)(316002)(47776003)(8676002)(54906003)(186003)(5660300002)(106002)(26005)(81156014)(81166006)(4744005)(7416002)(77096007)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6234;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90178417-2cde-445f-b72d-08d6f4f91449
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB6234;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6234:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB6234D26C8ADBE5DD066DEF63B8E50@DM6PR02MB6234.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0073BFEF03
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: EdWSZxSpjtW0TITjbQ4sPnxodwfUt3NN5Qe5d7N5RuBaA8U+++E+yJuYxC0gy3wGcsK2w68779dEXS/7gE1az/iC/RUlsQlanOHsLUeyTN6nEgl9S+2rUcCqsZZqfdcSO0PGOL3oFlGQG00B9j0zOWTeEMYjO02XyveyumiyF3orzvBnvQKfvVwoS4RBvLaIk6oRmtre03VJIpRPwXNReIos+31H+ALVR+8Cq3EEGotcB75AHjNAVdQ8wWiERIUjp6a0Xrr4QWBxPWqUdYguelI0MNk9NZoOCFtX8w4I5t1+6RulkoKSo1wNjlvfyJdEA4+1jWcuGEfnSKKxkE38C+MVvuuPt1OfVwwG4fezuSkAC82Qpa3UL80qFFdX/IvSig4z3flBBtoyJmvVXFC3DHAvFp5pM4r1Snqf7pZUNLg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2019 20:59:53.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90178417-2cde-445f-b72d-08d6f4f91449
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZYNQMP_PM_CAPABILITY_POWER capability is not supported by firmware
and hence needs to be removed

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1262ea6..778abbb 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -46,7 +46,6 @@
 #define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
-#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
 
 /*
  * Firmware FPGA Manager flags
-- 
2.7.4

