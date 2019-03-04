Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B80C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB14A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="O60e3kd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfCDX2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:28:12 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:62272
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfCDX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP9ow76+2iHCis9tGduENGJXLBk6W+xs4yT24MZU1qw=;
 b=O60e3kd+/8CBH06RBsAp2wCw/YFGU0drNSwoSYCaPLdF1oz0nqk0qsESGnXLKan2GvvtGXaEwVzvQ5B2Jfdv5HmAi4YrnzJV5gOfE9bYXULjbkop4IAs2RJ/YAiOiX/PTNmX74SOw6tyPsMD6yhrpRDgn/DnyoOi2k9+6EDuD/o=
Received: from BYAPR02CA0033.namprd02.prod.outlook.com (2603:10b6:a02:ee::46)
 by SN6PR02MB4224.namprd02.prod.outlook.com (2603:10b6:805:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1665.19; Mon, 4 Mar
 2019 23:28:08 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0033.outlook.office365.com
 (2603:10b6:a02:ee::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.16 via Frontend
 Transport; Mon, 4 Mar 2019 23:28:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Mon, 4 Mar 2019 23:28:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59849 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0x0B-0001Hx-4T; Mon, 04 Mar 2019 15:28:07 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1h0x06-00079T-19; Mon, 04 Mar 2019 15:28:02 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x24NRq5U030278;
        Mon, 4 Mar 2019 15:27:52 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1h0wzw-00077M-Gg; Mon, 04 Mar 2019 15:27:52 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH] drivers: clk: zynqmp: Allow zero divisor value
Date:   Mon, 4 Mar 2019 15:27:46 -0800
Message-ID: <1551742066-10825-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(2201001)(106466001)(4326008)(50466002)(9786002)(26005)(47776003)(77096007)(356004)(48376002)(44832011)(110136005)(54906003)(2616005)(50226002)(6666004)(486006)(126002)(476003)(106002)(36386004)(16586007)(63266004)(316002)(336012)(51416003)(305945005)(7696005)(426003)(4744005)(107886003)(478600001)(2906002)(8936002)(186003)(72206003)(8676002)(81156014)(81166006)(5660300002)(36756003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4224;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85278b1-1233-4e79-a0ee-08d6a0f90efe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB4224;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4224:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4224;20:tbZuq20oM/0tCu2UsgQfNO6Vw1cIRiT70wL5IxXbMDSIRZav+TxMLugGF+9OZ56v9Cdx2D/ui94fpPGCnYXT7TFBWx7euPVluI+RxmyGoL8HlPjaXZVdL7gSKmcE4q/vZ1sYiJ9X3vsoGCHE2PHXJW4ki661Du1o59mpOySi4WMjEHTcaEIEHoVFyDOSGwbcWVePtcf7LSSRXLedksuurkr0/V15fG8/gJ1YwJIFbRyUGV4Mx/VNhu0m+hT7PfRS8kV/cAJgkLgU1Xhnb/uxibLIRQZYr8VG4C2IUCRoDUUfqnlBPG7UIGXvWBG9RsH3kRqhxAZWH1ai5l00ELIz6cGXByK0r2hsha+aBT2jVG3LbaOQVMcH+Wvh+bdRKEZu7FZxQLhKqM+IIb/98nv2dr51Tm2MqKu+VPfnwI1ASddQtsUuG+G4tWrHUoJ4TYz9uOqjOdQlCNA/lSAx1VlzvrzX1fd+WPdQdrrZpCo/NGv0uIZJETZzWUSWCaiSUdUh
X-Microsoft-Antispam-PRVS: <SN6PR02MB422401A64AAE1EE12C0E83E7B8710@SN6PR02MB4224.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09669DB681
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4224;23:c3hdkoqog1kA7HnW5rtHehESft/a93i5ZUJG2oD0M?=
 =?us-ascii?Q?jZTmgXtCkwUlN3bThh4VHdaYbtrPcdDZF4KLXx8mmFjN/uhDIEDzUprnzsyI?=
 =?us-ascii?Q?qupdR1CghnlEX8Xodq3Fg5xmX/FxAhNfhOi/5zteXqjVgOJqsjPrz7qaxGqm?=
 =?us-ascii?Q?7Hj04W2oc3hOpeIxIt85zjxEJQigNtfQv+kccrKl4+DxlUrZ4Ldbpz3SwWy2?=
 =?us-ascii?Q?lzXnr8w2VebKKWcLTPRDZ10GpyQ+C6QMeXsgSyJqAfQ1Sg/vXAmQE2TcDWiZ?=
 =?us-ascii?Q?EbLeirNbpbtn0WQ8AmygTdgdPUDm5Iu/LVoCcqFAqUKHkHv/xqBhG7iQxBtK?=
 =?us-ascii?Q?4ZgMUnGPPm+zDq3REm3PvZUbAMx/hnX08TFXBzOTrKnuS2fyEMYlCfuVjDFs?=
 =?us-ascii?Q?sas7eEW/MoRKtnOQOkO88ejZTBb9oFFXQTzgrmBFL29JC95K3X/UApjK/aKX?=
 =?us-ascii?Q?9bb2LQZlRhFa67724LC+Lcj9KXZAP3aPWck+Xy6bbubmHHEVnxcw+wEOONVq?=
 =?us-ascii?Q?NF1DBou0PUZBhOe1Rkru+FlacSEmxGZtzKicUejehI0ZJRusTRRzgoKicaVu?=
 =?us-ascii?Q?RAPXQt1V2Dbx7bg8cxHFf0sPMonLaEhzI0HjZzj0x4GyvQOEYgDJkrX01ZFw?=
 =?us-ascii?Q?IQ+eYe8KgMidRfgNvvArMVRiv95lVDA079qRyvxryHjSt1u9aVotqou7rj4N?=
 =?us-ascii?Q?KQ58WS5osgmJ4Fw5wp7hw8maYbA4Uto8qpL9b+rzJ6OzC/d9TafwQPY2fhn8?=
 =?us-ascii?Q?RbOugJw6VvNo6c6dhXCPHNRz+5vmON10hfo80cJzDbCJ2DbqX+BL77vEzMwn?=
 =?us-ascii?Q?UTFyXKr1zgRERnRfvi48hyIsMaF9iFU7MFc8y5OBGGCxw3MyzLpcbv1SBC6u?=
 =?us-ascii?Q?QF6L6/AKiGNbQBnv0Kxjv9GEvr5SsNHlU/5v3SeyNnhiXMqeWkVCa3j6ogMT?=
 =?us-ascii?Q?qOR8YJepyi8HEgjxv93Q+Hq0l/8mRwLz1dx/hSeBlODNY8Mvx3HbspQxw/M7?=
 =?us-ascii?Q?+MPV9TG630v2A/ZPSU9IEMEWR8kZFhqGxfL6wTVOtW64z58pTOxGUs3PgGEJ?=
 =?us-ascii?Q?7+V/AdNKhBKVZKNXWN048Dc43x3EfV3RCPN1ZLuJAWx2mXyU5PF2IuIzhQtD?=
 =?us-ascii?Q?0VBOQMEmaCwTwMuh/thLoz2UDiU+6a1?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aF4RJxHHJ8TLBEpnBkoy4dp6mQ8WHZZbUT6urqZ8qCdUs2NuhBg5ax9XM2VrA9KAcG/Qs+UvHa3JkG+1UxD+beiwwuAVKhh4JXgkmBmgo4gCrFXz7f0kc5Tbs406Jwx60rXvFe1eCCgyjZ8p0+RHMXrLaYLG45lJjgiKYeb5QceYtrmuArOMjiVc3IhtSRGp4Amq1cmfKHe07L6N+A2HbsnxvodDLy5SR2KjegRM60NUH2z+lvwa4XtMKat7XtRslKDVnxyeYhQzEdH0nMbUB2gL9E3nMKAk9m05XIDDac5M3TKyaGq4VCR6wLVzXYTzEvflwu54gV9lWS5f8/518WGRfpUOTh+yOwonlBuLPWfqmTBqbkoLoMnGDjnIFnoHImS7oCP0/WuVUNSX+4H5CSEnp6lEjWhZH3LRCSNI0kE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2019 23:28:07.5430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85278b1-1233-4e79-a0ee-08d6a0f90efe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Zero divider is valid and default for some of ZynqMP
clocks. Allow zero divisor when CLK_DIVIDER_ALLOW_ZERO
for the clock is set.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/clk/zynqmp/divider.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index a371c66..e146b6f 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -76,6 +76,13 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	else
 		value = div >> 16;
 
+	if (!value) {
+		WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
+		     "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+		     clk_name);
+		return parent_rate;
+	}
+
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
-- 
2.7.4

