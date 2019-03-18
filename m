Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o/4MxDxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCRLdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:23 -0400
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:23441
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfCRLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK9Gbl0P4XLcr/I9gV0aHSS0MW5B3oyAsCDK9uPObiU=;
 b=o/4MxDxkIBc+L5POF9nK8Z3eSyKr7VGPboeSLQef732Q4TmEKAFCo2aoEUGkvoiXFI0V8o0eoa5Hz7wXkpBEz5RIE1Bt8rP3nqSUwmdg+3X/9xaY+btZNQJIrTJUFqvnLxMIVWV0rZrAZRg989bvbEZs07agO3vILSWP1oVVeV0=
Received: from CY4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:903:18::21)
 by DM6PR02MB4060.namprd02.prod.outlook.com (2603:10b6:5:96::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Mon, 18 Mar
 2019 11:33:10 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by CY4PR02CA0011.outlook.office365.com
 (2603:10b6:903:18::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50629 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVw-0004fs-KL; Mon, 18 Mar 2019 04:33:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVr-0008T7-GW; Mon, 18 Mar 2019 04:33:03 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVp-0008M3-Eq; Mon, 18 Mar 2019 04:33:01 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 3/6] net: can: xilinx_can: Add cantype parameter in xcan_devtype_data struct
Date:   Mon, 18 Mar 2019 17:02:43 +0530
Message-ID: <1552908766-26753-4-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(356004)(478600001)(6666004)(48376002)(36386004)(26005)(186003)(336012)(77096007)(47776003)(426003)(9786002)(54906003)(4326008)(110136005)(16586007)(316002)(107886003)(50466002)(8936002)(51416003)(7696005)(76176011)(2906002)(305945005)(106466001)(106002)(11346002)(2201001)(36756003)(5660300002)(6636002)(81166006)(63266004)(50226002)(486006)(81156014)(8676002)(446003)(126002)(476003)(2616005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4060;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c64045a2-c980-4ec2-d784-08d6ab957f65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB4060;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4060:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4060B747483F9A19CBC1F8C0DC470@DM6PR02MB4060.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UOP2H4pgfRXWSUqnU39F65BaL46vNT27TlsNDy8JI/AGajDNuR9QjbRaWnJHJmoEwkKcKE1vd7VazgSHTgvRXJjwDsx17j6+j7TfbOa2Hz79jtHxw/fLEoz8GLJF3VmFkA7oTZ5kTyN7Dec+aedP/KY+hTrXgaZs0PjSiXBO3I+u5Og6EFlXHYaGk814Qro6f44hN4axcoHmNbyAt+CK2jPFNZ3HdRGotxlnZVuWeAcBLtK20SNEhMVn4OrW650IxN/ebWAj29EooYiZksgKYm3Weq0wsq6UBl0zRk31tB4IelDpmgqVcJy7IZ18brBm8kKAzv2Xm+RlOt3bmvfSZo1HSTgLH70/lZMQW8IwNjQPL6Cs9qDD7/0yczp00ex2WZLJkA3xrP7PyhLz2tgEkdk96tvbCHTIvSQLbLnMmJ0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:09.0907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64045a2-c980-4ec2-d784-08d6ab957f65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To differentiate between different CAN IP's this patch adds
cantype enum variable in the xcan_devtype_data structure

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 22569ef..b45ece9 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -157,7 +157,15 @@ enum xcan_reg {
 #define XCAN_FLAG_RX_FIFO_MULTI	0x0010
 #define XCAN_FLAG_CANFD_2	0x0020
 
+enum xcan_ip_type {
+	XAXI_CAN = 0,
+	XZYNQ_CANPS,
+	XAXI_CANFD,
+	XAXI_CANFD_2_0,
+};
+
 struct xcan_devtype_data {
+	enum xcan_ip_type cantype;
 	unsigned int flags;
 	const struct can_bittiming_const *bittiming_const;
 	const char *bus_clk_name;
@@ -1428,6 +1436,7 @@ static const struct dev_pm_ops xcan_dev_pm_ops = {
 };
 
 static const struct xcan_devtype_data xcan_zynq_data = {
+	.cantype = XZYNQ_CANPS,
 	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
@@ -1436,6 +1445,7 @@ static const struct xcan_devtype_data xcan_zynq_data = {
 };
 
 static const struct xcan_devtype_data xcan_axi_data = {
+	.cantype = XAXI_CAN,
 	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
@@ -1444,6 +1454,7 @@ static const struct xcan_devtype_data xcan_axi_data = {
 };
 
 static const struct xcan_devtype_data xcan_canfd_data = {
+	.cantype = XAXI_CANFD,
 	.flags = XCAN_FLAG_EXT_FILTERS |
 		 XCAN_FLAG_RXMNF |
 		 XCAN_FLAG_TX_MAILBOXES |
@@ -1455,6 +1466,7 @@ static const struct xcan_devtype_data xcan_canfd_data = {
 };
 
 static const struct xcan_devtype_data xcan_canfd2_data = {
+	.cantype = XAXI_CANFD_2_0,
 	.flags = XCAN_FLAG_EXT_FILTERS |
 		 XCAN_FLAG_RXMNF |
 		 XCAN_FLAG_TX_MAILBOXES |
-- 
2.7.4

