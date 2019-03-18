Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D27C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xQpl+9C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCRLd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:27 -0400
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:35200
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbfCRLdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irxE9mPOTe1f+rMN9CkG+svBXNKpnigSCZ327C2v+7k=;
 b=xQpl+9C0MDsMU+ZyKh+ZnOfiRnD9p477SvlBaUWpMjcguH0sDGZ0SeGYlwRPEQ0LagUHa6ZwAv6ge7xwil3mb5XXxqyrqHRZShiRnwYtSf4FSUj1cd8qGGGlNFT6o+K6ST7K3+02B6tMoOxL4FaAziqHV0nFbJa7nERSzQKv6qM=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by CY4PR02MB2840.namprd02.prod.outlook.com (2603:10b6:903:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 11:33:21 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50932 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW7-0004gF-4R; Mon, 18 Mar 2019 04:33:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW2-0008WO-0f; Mon, 18 Mar 2019 04:33:14 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVy-0008M3-2h; Mon, 18 Mar 2019 04:33:10 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 6/6] net: can: xilinx_can: Fix kernel doc warnings
Date:   Mon, 18 Mar 2019 17:02:46 +0530
Message-ID: <1552908766-26753-7-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(8676002)(356004)(6666004)(81156014)(81166006)(107886003)(36756003)(14444005)(48376002)(50466002)(305945005)(5660300002)(47776003)(51416003)(7696005)(36386004)(76176011)(6636002)(50226002)(446003)(486006)(2616005)(126002)(476003)(11346002)(478600001)(8936002)(426003)(63266004)(2201001)(4326008)(336012)(110136005)(54906003)(106466001)(9786002)(2906002)(77096007)(106002)(26005)(186003)(16586007)(316002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2840;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88bf0c1-d7b0-49ce-12f0-08d6ab9585a6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2840;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2840:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB284093CA5A9ED3BB553D7C14DC470@CY4PR02MB2840.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Kmw8e8uqQDu93HHgRGM2PH4tXnBTJzuGRtCWcTs4U7lxmA49vELgp1WVj4ap7pN6ov6zuM1wEaLi55i+so4/5cgN4aTVmBzqEemuHnd1rTgQZbtELfqS3/p7GfNkOpILtoUjxgvXk2iaLiIYf6yijSrlX3sgJoU9JNSrvDvPtM14oYulofokIZr0lTw4s6H4RPqiEkGrxu/A+XVReDpeHROZEjGW6r9iU3hexZRFxhn1P9aGxXnGhuWcXK6/HsMxCigpB7EmlrH3rkgA9KsWlkoMP4gl5v/GSFeCu7XS85x5sF1fs53OthgtiEgqFmxPlhWE/feVT2U5puw7sxM3+gkWRXsfGhl8q9i+NoYIhvvqSS1rwp4iO2Ro0cTVgJ0i2VN89keMl0EFoYH/1uWa5zNVLB2L950oQu/Th6k4y30=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:19.5980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88bf0c1-d7b0-49ce-12f0-08d6ab9585a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kernel doc warnings
warning: Function parameter or member 'priv' not described in
'xcan_write_frame'
warning: Function parameter or member 'skb' not described in
'xcan_start_xmit_fifo'
warning: Function parameter or member 'ndev' not described in
'xcan_start_xmit_fifo'
warning: Function parameter or member 'skb' not described in
'xcan_start_xmit_mailbox'
warning: Function parameter or member 'ndev' not described in
'xcan_start_xmit_mailbox'
warning: Function parameter or member 'priv' not described in
'xcan_rx_fifo_get_next_frame'

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e1544e0..ac6fcae 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -545,6 +545,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
 
 /**
  * xcan_write_frame - Write a frame to HW
+ * @priv:		Driver private data structure
  * @skb:		sk_buff pointer that contains data to be Txed
  * @frame_offset:	Register offset to write the frame to
  */
@@ -625,6 +626,8 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 
 /**
  * xcan_start_xmit_fifo - Starts the transmission (FIFO mode)
+ * @skb:	sk_buff pointer that contains data to be Txed
+ * @ndev:	Pointer to net_device structure
  *
  * Return: 0 on success, -ENOSPC if FIFO is full.
  */
@@ -661,6 +664,8 @@ static int xcan_start_xmit_fifo(struct sk_buff *skb, struct net_device *ndev)
 
 /**
  * xcan_start_xmit_mailbox - Starts the transmission (mailbox mode)
+ * @skb:	sk_buff pointer that contains data to be Txed
+ * @ndev:	Pointer to net_device structure
  *
  * Return: 0 on success, -ENOSPC if there is no space
  */
@@ -1148,6 +1153,7 @@ static void xcan_state_interrupt(struct net_device *ndev, u32 isr)
 
 /**
  * xcan_rx_fifo_get_next_frame - Get register offset of next RX frame
+ * @priv:	Driver private data structure
  *
  * Return: Register offset of the next frame in RX FIFO.
  */
-- 
2.7.4

