Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F4F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JWZr/bQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCRMcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:32:17 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:4422
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbfCRMcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2jYlz40sx6gTtQ5drQFRJcKaKeWv9I/gLOZWQwnGrQ=;
 b=JWZr/bQ7Bu5mmHijHMzvx6jl76QMkU8yV/zVUoWHVisenQXECG1a4ZMdJFumwoB8Tj7//veSqm7dXqldE0N97+i+Mg8IOxbPnzrCVHOZFZ1D1lLJuwwDAle/vbOELMl6iI7vKDZqwSy6fy7MiFLvn6L2vU0mPJOf2Y5YXwqSD1Q=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by DM5PR02MB2842.namprd02.prod.outlook.com
 (2603:10b6:3:108::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Mon, 18 Mar
 2019 12:32:10 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:32:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:32:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rR3-0008Ch-NI; Mon, 18 Mar 2019 05:32:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rQy-0001QP-J3; Mon, 18 Mar 2019 05:32:04 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICW2Xm001196;
        Mon, 18 Mar 2019 05:32:02 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rQw-0001L5-0n; Mon, 18 Mar 2019 05:32:02 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <claudiu.beznea@microchip.com>,
        <rafalo@cadence.com>, <andrei.pistirica@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH 1/2] net: macb: Add separate definition for PPM fraction
Date:   Mon, 18 Mar 2019 18:01:51 +0530
Message-ID: <1552912312-30837-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552912312-30837-1-git-send-email-harini.katakam@xilinx.com>
References: <1552912312-30837-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(199004)(189003)(48376002)(4326008)(50466002)(6666004)(47776003)(316002)(16586007)(478600001)(110136005)(54906003)(36756003)(77096007)(8676002)(2201001)(26005)(5660300002)(305945005)(81156014)(81166006)(14444005)(186003)(356004)(336012)(7696005)(36386004)(51416003)(486006)(63266004)(126002)(44832011)(2906002)(2616005)(11346002)(426003)(446003)(106002)(476003)(106466001)(9786002)(107886003)(76176011)(50226002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2842;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59881aba-3627-4ade-913c-08d6ab9dbdfa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM5PR02MB2842;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2842:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB2842B875B9A4742245038ACCC9470@DM5PR02MB2842.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XrXco3WRDvmdmBw/Lhltd0kSrXeigUwhq9g8mqAoDXwHK1MpfnYnoJKk9K+PcE0fpqhq6+6HLhOmZMA/wmAHNjdS86lBTvrbNIL2w36Z1VArdu2uxT0J5SgROXTIdtjwTgF9UQBvX1bM8RZiWTH5ATypUR+SBnjJ3s9P62gOi7tO5viBS+nmtYcu3JIIetd87NDu2p+pufPlnLxpthvgUl0+jjSbRLmrNYFQy0nlgNShZfwZSjjGQGb3Mqf2qPxlNoXsBXfl5HjdKi7HvcJjCG0+gP6OB4weFCk7d6figwRg0wT/kcQ63D8FwgnPQetxROE6sxKCLtXYeLfWJO1kPMpFYiotsF+vXvMuoXlQ2hLFsEzEn8cZuq9xRxupmOdUha46LEWVcljfmSh67pxmaRjcvQvLreERCzfIEgfkE2Y=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:32:10.1421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59881aba-3627-4ade-913c-08d6ab9dbdfa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scaled ppm parameter passed to _adjfine() contains a 16 bit
fraction. This just happens to be the same as SUBNSINCR_SIZE now.
Hence define this separately.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h     | 3 +++
 drivers/net/ethernet/cadence/macb_ptp.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index acc66a7..0993949 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -837,6 +837,9 @@ struct gem_tx_ts {
 /* limit RX checksum offload to TCP and UDP packets */
 #define GEM_RX_CSUM_CHECKED_MASK		2
 
+/* Scaled PPM fraction */
+#define PPM_FRACTION	16
+
 /* struct macb_tx_skb - data about an skb which is being transmitted
  * @skb: skb currently being transmitted, only set for the last buffer
  *       of the frame
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index a6dc47e..46d9cdf 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -146,7 +146,7 @@ static int gem_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	 * (temp / USEC_PER_SEC) + 0.5
 	 */
 	adj += (USEC_PER_SEC >> 1);
-	adj >>= GEM_SUBNSINCR_SIZE; /* remove fractions */
+	adj >>= PPM_FRACTION; /* remove fractions */
 	adj = div_u64(adj, USEC_PER_SEC);
 	adj = neg_adj ? (word - adj) : (word + adj);
 
-- 
2.7.4

