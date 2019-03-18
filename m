Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75FF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aKN5avXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCRMc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:32:27 -0400
Received: from mail-eopbgr820040.outbound.protection.outlook.com ([40.107.82.40]:13306
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727485AbfCRMc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KnhknoRcZM5UsADwYgMZNoiaoTSM5qU5DDbEz8y91s=;
 b=aKN5avXvgOKa9giG/+xv9wiWV4MCge1SPx9JXkHcQ7vcKjGsxyXo8dooipiolbcEmSdHcaUCByecDo1cFwmMXphFKeQTNBYrg7EPvbQJTC9Y9+jnFcFCV7YStjN9Qml5uATWWBrmHNm+mg3pLFf0r1Idh5wiZTi6ePPQU+wc4e4=
Received: from SN4PR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:803:2e::22) by BN6PR02MB2356.namprd02.prod.outlook.com
 (2603:10b6:404:29::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Mon, 18 Mar
 2019 12:32:21 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0036.outlook.office365.com
 (2603:10b6:803:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:32:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:32:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59386 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rRD-00056f-Sd; Mon, 18 Mar 2019 05:32:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rR8-0001XX-Oq; Mon, 18 Mar 2019 05:32:14 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICW5UD001254;
        Mon, 18 Mar 2019 05:32:06 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rQz-0001L5-CK; Mon, 18 Mar 2019 05:32:05 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <claudiu.beznea@microchip.com>,
        <rafalo@cadence.com>, <andrei.pistirica@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH 2/2] net: macb: Fix SUBNS increment and increase resolution
Date:   Mon, 18 Mar 2019 18:01:52 +0530
Message-ID: <1552912312-30837-3-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552912312-30837-1-git-send-email-harini.katakam@xilinx.com>
References: <1552912312-30837-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(426003)(81166006)(2616005)(106002)(486006)(316002)(446003)(50466002)(9786002)(11346002)(51416003)(8676002)(305945005)(36386004)(16586007)(4326008)(44832011)(5660300002)(54906003)(476003)(110136005)(81156014)(126002)(336012)(2906002)(48376002)(2201001)(107886003)(478600001)(50226002)(36756003)(77096007)(26005)(6666004)(356004)(47776003)(76176011)(186003)(106466001)(63266004)(8936002)(7696005)(14444005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2356;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d8b909f-8707-4e82-a1d4-08d6ab9dc41a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN6PR02MB2356;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2356:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2356E857AB75E79998372706C9470@BN6PR02MB2356.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: W07FbREu/NnMjtiuHPoSCXVUS+wpNZ+jTgPzXD2Jbs+8prnRPacGr60U/AdTvpTrgWa9/+LHUbF+71moqpdk50WXj3x4g52upvKqNQIjRfAZ1SkcBLqngvF46T5U7gJ+cAkNYJ99aFAefnlfVPCXyUZBkZTKbIXmtPwMDnwh5u1g4byrZ6mmE45jvNNjsy7KSbwfga28Y5IBWizf5U3doaHTKXjHJ5DjpZ1JOx/rjTJ34sbzPwVm+G//v3w7dBuqERFsEIObz5tPyevJVqrf9c3007Ts4YRWpiX1gP8EKDCq17QDuJSPbcHdZGZxkL1YSbgm/A0qSuxQsshEhC/oQ2I0J/GMwzn96VEseFuqvU6FJKf1IXUqlV61Uhve5Eyb0DZem3gLqAkbltwuF+QIHztMkB4u5ken58bEbBLzo3Y=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:32:20.2794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8b909f-8707-4e82-a1d4-08d6ab9dc41a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2356
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subns increment register has 24 bits as follows:
RegBit[15:0] = Subns[23:8]; RegBit[31:24] = Subns[7:0]

Fix the same in the driver and increase sub ns resolution to the
best capable, 24 bits. This should be the case on all GEM versions
that this PTP driver supports.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h     | 6 +++++-
 drivers/net/ethernet/cadence/macb_ptp.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 0993949..0fb51cd 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -499,7 +499,11 @@
 
 /* Bitfields in TISUBN */
 #define GEM_SUBNSINCR_OFFSET			0
-#define GEM_SUBNSINCR_SIZE			16
+#define GEM_SUBNSINCRL_OFFSET			24
+#define GEM_SUBNSINCRL_SIZE			8
+#define GEM_SUBNSINCRH_OFFSET			0
+#define GEM_SUBNSINCRH_SIZE			16
+#define GEM_SUBNSINCR_SIZE			24
 
 /* Bitfields in TI */
 #define GEM_NSINCR_OFFSET			0
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 46d9cdf..75dc4f8 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -115,7 +115,10 @@ static int gem_tsu_incr_set(struct macb *bp, struct tsu_incr *incr_spec)
 	 * to take effect.
 	 */
 	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
-	gem_writel(bp, TISUBN, GEM_BF(SUBNSINCR, incr_spec->sub_ns));
+	/* RegBit[15:0] = Subns[23:8]; RegBit[31:24] = Subns[7:0] */
+	gem_writel(bp, TISUBN, GEM_BF(SUBNSINCRL, incr_spec->sub_ns) |
+		   GEM_BF(SUBNSINCRH, (incr_spec->sub_ns >>
+			  GEM_SUBNSINCRL_SIZE)));
 	gem_writel(bp, TI, GEM_BF(NSINCR, incr_spec->ns));
 	spin_unlock_irqrestore(&bp->tsu_clk_lock, flags);
 
-- 
2.7.4

