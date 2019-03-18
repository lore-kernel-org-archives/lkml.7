Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075ACC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25CC2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gMEGBL1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCRLdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:31 -0400
Received: from mail-eopbgr800059.outbound.protection.outlook.com ([40.107.80.59]:57568
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfCRLd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgo/LjzNAlf1qs8SAUViZ26syvbhnVoD3u3SD4wxBJo=;
 b=gMEGBL1GjFYpmiBz+ZuCsCUJ36ecsqm1UCLBwcJhMy6o7NJuawZrwKvsrRn/3jJ6t9sLKc7/zt1mrW7i3/7H7bEqrepkcbTM9qTB8Gr5ZNWsglUVGqBi1JfApwJOmnZbWkPdLZLCGbIACAJzb9gFbZSsT7WHd2P18eaPUxiN4Us=
Received: from CY4PR02CA0032.namprd02.prod.outlook.com (2603:10b6:903:117::18)
 by CY4PR02MB2839.namprd02.prod.outlook.com (2603:10b6:903:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 11:33:20 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by CY4PR02CA0032.outlook.office365.com
 (2603:10b6:903:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW7-0007io-1O; Mon, 18 Mar 2019 04:33:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qW1-0008WO-Tn; Mon, 18 Mar 2019 04:33:13 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVs-0008M3-FM; Mon, 18 Mar 2019 04:33:04 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [PATCH 4/6] net: can: xilinx_can: Add support for CANFD FD frames
Date:   Mon, 18 Mar 2019 17:02:44 +0530
Message-ID: <1552908766-26753-5-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(336012)(106002)(81156014)(63266004)(7696005)(76176011)(51416003)(446003)(36756003)(2201001)(478600001)(11346002)(476003)(2616005)(8676002)(106466001)(110136005)(54906003)(126002)(2906002)(486006)(356004)(6666004)(48376002)(47776003)(107886003)(50226002)(16586007)(9786002)(14444005)(26005)(316002)(81166006)(6636002)(305945005)(4326008)(8936002)(426003)(186003)(36386004)(30864003)(77096007)(50466002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2839;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca61f2be-68b3-4c85-ad24-08d6ab95858a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2839;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2839:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2839CE1C5ADDBF3EF16A6F33DC470@CY4PR02MB2839.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RUaT+LkJnGJKgHrHljqo0vBVQpZ2zQEjjQgOw3FLsfhlvEAuGyDMbbGCIA/nPHJ2Amq/vhS1sF+M9bVBLk4MlmU5qoFzwGBXlyK93JI0gL7jKnL8Rly4jcv6XdH4Vmyst4PcYE1kN1AbTXJZrdgCH2PrbpIhGhMAzLbEBmsXJdD6Ti3i5H7qN7NqlJthctKy+xcATGGsTGeMUOaRUXz18B4l1yibW/pHhxf9jXyKhzR+VC4MkB1OSYCrrqHSILCTcGcXIET2HVtAKU/N2fRJ+i3CmepXffGtNfbFjSNVtzZRECmu8tpDf+eNZddvtqY0JhrVKPbr0bM2nh0DSK3eIv9zptQpIrb/T3EKzSoGjZ1P6NQ8iygYHf5K737GGmjdGJJ1L73jc6qURl9cSzR5rUsPJRE6h8JQv/4xrhUNeFc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:19.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca61f2be-68b3-4c85-ad24-08d6ab95858a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CANFD IP supports both CAN and CAN FD frames,
Existing driver supports only CAN frames, This patch
adds support for CAN FD frames.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 230 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 214 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index b45ece9..3d75a28 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -58,6 +58,10 @@ enum xcan_reg {
 	XCAN_AFR_OFFSET		= 0x60, /* Acceptance Filter */
 
 	/* only on CAN FD cores */
+	XCAN_F_BRPR_OFFSET	= 0x088, /* Data Phase Baud Rate
+					  * Prescalar
+					  */
+	XCAN_F_BTR_OFFSET	= 0x08C, /* Data Phase Bit Timing */
 	XCAN_TRR_OFFSET		= 0x0090, /* TX Buffer Ready Request */
 	XCAN_AFR_EXT_OFFSET	= 0x00E0, /* Acceptance Filter */
 	XCAN_FSR_OFFSET		= 0x00E8, /* RX FIFO Status */
@@ -70,6 +74,8 @@ enum xcan_reg {
 #define XCAN_FRAME_DLC_OFFSET(frame_base)	((frame_base) + 0x04)
 #define XCAN_FRAME_DW1_OFFSET(frame_base)	((frame_base) + 0x08)
 #define XCAN_FRAME_DW2_OFFSET(frame_base)	((frame_base) + 0x0C)
+#define XCANFD_FRAME_DW_OFFSET(frame_base, n)	(((frame_base) + 0x08) + \
+						 ((n) * XCAN_CANFD_FRAME_SIZE))
 
 #define XCAN_CANFD_FRAME_SIZE		0x48
 #define XCAN_TXMSG_FRAME_OFFSET(n)	(XCAN_TXMSG_BASE_OFFSET + \
@@ -128,6 +134,8 @@ enum xcan_reg {
 #define XCAN_FSR_FL_MASK		0x00003F00 /* RX Fill Level */
 #define XCAN_FSR_IRI_MASK		0x00000080 /* RX Increment Read Index */
 #define XCAN_FSR_RI_MASK		0x0000001F /* RX Read Index */
+#define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
+#define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BTR_SJW_SHIFT		7  /* Synchronous jump width */
@@ -141,6 +149,7 @@ enum xcan_reg {
 
 /* CAN frame length constants */
 #define XCAN_FRAME_MAX_DATA_LEN		8
+#define XCANFD_DW_BYTES			4
 #define XCAN_TIMEOUT			(1 * HZ)
 
 /* TX-FIFO-empty interrupt available */
@@ -221,6 +230,7 @@ static const struct can_bittiming_const xcan_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* AXI CANFD Arbitration Bittiming constants as per AXI CANFD 1.0 spec */
 static const struct can_bittiming_const xcan_bittiming_const_canfd = {
 	.name = DRIVER_NAME,
 	.tseg1_min = 1,
@@ -233,6 +243,20 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd = {
 	.brp_inc = 1,
 };
 
+/* AXI CANFD Data Bittiming constants as per AXI CANFD 1.0 specs */
+static struct can_bittiming_const xcan_data_bittiming_const_canfd = {
+	.name = DRIVER_NAME,
+	.tseg1_min = 1,
+	.tseg1_max = 16,
+	.tseg2_min = 1,
+	.tseg2_max = 8,
+	.sjw_max = 8,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
+/* AXI CANFD 2.0 Arbitration Bittiming constants as per AXI CANFD 2.0 spec */
 static const struct can_bittiming_const xcan_bittiming_const_canfd2 = {
 	.name = DRIVER_NAME,
 	.tseg1_min = 1,
@@ -245,6 +269,19 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd2 = {
 	.brp_inc = 1,
 };
 
+/* AXI CANFD 2.0 Data Bittiming constants as per AXI CANFD 2.0 spec */
+static struct can_bittiming_const xcan_data_bittiming_const_canfd2 = {
+	.name = DRIVER_NAME,
+	.tseg1_min = 1,
+	.tseg1_max = 32,
+	.tseg2_min = 1,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:	Driver private data structure
@@ -359,6 +396,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	struct can_bittiming *bt = &priv->can.bittiming;
+	struct can_bittiming *dbt = &priv->can.data_bittiming;
 	u32 btr0, btr1;
 	u32 is_config_mode;
 
@@ -388,6 +426,24 @@ static int xcan_set_bittiming(struct net_device *ndev)
 	priv->write_reg(priv, XCAN_BRPR_OFFSET, btr0);
 	priv->write_reg(priv, XCAN_BTR_OFFSET, btr1);
 
+	if (priv->devtype.cantype == XAXI_CANFD ||
+	    priv->devtype.cantype == XAXI_CANFD_2_0) {
+		/* Setting Baud Rate prescalar value in F_BRPR Register */
+		btr0 = dbt->brp - 1;
+
+		/* Setting Time Segment 1 in BTR Register */
+		btr1 = dbt->prop_seg + bt->phase_seg1 - 1;
+
+		/* Setting Time Segment 2 in BTR Register */
+		btr1 |= (dbt->phase_seg2 - 1) << priv->devtype.btr_ts2_shift;
+
+		/* Setting Synchronous jump width in BTR Register */
+		btr1 |= (dbt->sjw - 1) << priv->devtype.btr_sjw_shift;
+
+		priv->write_reg(priv, XCAN_F_BRPR_OFFSET, btr0);
+		priv->write_reg(priv, XCAN_F_BTR_OFFSET, btr1);
+	}
+
 	netdev_dbg(ndev, "BRPR=0x%08x, BTR=0x%08x\n",
 		   priv->read_reg(priv, XCAN_BRPR_OFFSET),
 		   priv->read_reg(priv, XCAN_BTR_OFFSET));
@@ -506,7 +562,8 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 			     int frame_offset)
 {
 	u32 id, dlc, data[2] = {0, 0};
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	u32 ramoff, dwindex = 0, i;
 
 	/* Watch carefully on the bit sequence */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -535,26 +592,44 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 			id |= XCAN_IDR_SRR_MASK;
 	}
 
-	dlc = cf->can_dlc << XCAN_DLCR_DLC_SHIFT;
-
-	if (cf->can_dlc > 0)
-		data[0] = be32_to_cpup((__be32 *)(cf->data + 0));
-	if (cf->can_dlc > 4)
-		data[1] = be32_to_cpup((__be32 *)(cf->data + 4));
+	dlc = can_len2dlc(cf->len) << XCAN_DLCR_DLC_SHIFT;
+	if (can_is_canfd_skb(skb)) {
+		if (cf->flags & CANFD_BRS)
+			dlc |= XCAN_DLCR_BRS_MASK;
+		dlc |= XCAN_DLCR_EDL_MASK;
+	}
 
 	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
 	/* If the CAN frame is RTR frame this write triggers transmission
 	 * (not on CAN FD)
 	 */
 	priv->write_reg(priv, XCAN_FRAME_DLC_OFFSET(frame_offset), dlc);
-	if (!(cf->can_id & CAN_RTR_FLAG)) {
-		priv->write_reg(priv, XCAN_FRAME_DW1_OFFSET(frame_offset),
-				data[0]);
-		/* If the CAN frame is Standard/Extended frame this
-		 * write triggers transmission (not on CAN FD)
-		 */
-		priv->write_reg(priv, XCAN_FRAME_DW2_OFFSET(frame_offset),
-				data[1]);
+	if (priv->devtype.cantype == XAXI_CANFD ||
+	    priv->devtype.cantype == XAXI_CANFD_2_0) {
+		for (i = 0; i < cf->len; i += 4) {
+			ramoff = XCANFD_FRAME_DW_OFFSET(frame_offset, dwindex) +
+					(dwindex * XCANFD_DW_BYTES);
+			priv->write_reg(priv, ramoff,
+					be32_to_cpup((__be32 *)(cf->data + i)));
+			dwindex++;
+		}
+	} else {
+		if (cf->len > 0)
+			data[0] = be32_to_cpup((__be32 *)(cf->data + 0));
+		if (cf->len > 4)
+			data[1] = be32_to_cpup((__be32 *)(cf->data + 4));
+
+		if (!(cf->can_id & CAN_RTR_FLAG)) {
+			priv->write_reg(priv,
+					XCAN_FRAME_DW1_OFFSET(frame_offset),
+					data[0]);
+			/* If the CAN frame is Standard/Extended frame this
+			 * write triggers transmission (not on CAN FD)
+			 */
+			priv->write_reg(priv,
+					XCAN_FRAME_DW2_OFFSET(frame_offset),
+					data[1]);
+		}
 	}
 }
 
@@ -728,6 +803,113 @@ static int xcan_rx(struct net_device *ndev, int frame_base)
 }
 
 /**
+ * xcanfd_rx -  Is called from CAN isr to complete the received
+ *		frame  processing
+ * @ndev:	Pointer to net_device structure
+ * @frame_base:	Register offset to the frame to be read
+ *
+ * This function is invoked from the CAN isr(poll) to process the Rx frames. It
+ * does minimal processing and invokes "netif_receive_skb" to complete further
+ * processing.
+ * Return: 1 on success and 0 on failure.
+ */
+static int xcanfd_rx(struct net_device *ndev, int frame_base)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	u32 id_xcan, dlc, data[2] = {0, 0}, dwindex = 0, i, fsr, readindex;
+
+	fsr = priv->read_reg(priv, XCAN_FSR_OFFSET);
+	if (fsr & XCAN_FSR_FL_MASK) {
+		readindex = fsr & XCAN_FSR_RI_MASK;
+		id_xcan = priv->read_reg(priv,
+					 XCAN_FRAME_ID_OFFSET(frame_base));
+		dlc = priv->read_reg(priv, XCAN_FRAME_DLC_OFFSET(frame_base));
+		if (dlc & XCAN_DLCR_EDL_MASK)
+			skb = alloc_canfd_skb(ndev, &cf);
+		else
+			skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
+
+		if (unlikely(!skb)) {
+			stats->rx_dropped++;
+			return 0;
+		}
+
+		/* Change Xilinx CANFD data length format to socketCAN data
+		 * format
+		 */
+		if (dlc & XCAN_DLCR_EDL_MASK)
+			cf->len = can_dlc2len((dlc & XCAN_DLCR_DLC_MASK) >>
+					  XCAN_DLCR_DLC_SHIFT);
+		else
+			cf->len = get_can_dlc((dlc & XCAN_DLCR_DLC_MASK) >>
+						  XCAN_DLCR_DLC_SHIFT);
+
+		/* Change Xilinx CAN ID format to socketCAN ID format */
+		if (id_xcan & XCAN_IDR_IDE_MASK) {
+			/* The received frame is an Extended format frame */
+			cf->can_id = (id_xcan & XCAN_IDR_ID1_MASK) >> 3;
+			cf->can_id |= (id_xcan & XCAN_IDR_ID2_MASK) >>
+					XCAN_IDR_ID2_SHIFT;
+			cf->can_id |= CAN_EFF_FLAG;
+			if (id_xcan & XCAN_IDR_RTR_MASK)
+				cf->can_id |= CAN_RTR_FLAG;
+		} else {
+			/* The received frame is a standard format frame */
+			cf->can_id = (id_xcan & XCAN_IDR_ID1_MASK) >>
+					XCAN_IDR_ID1_SHIFT;
+			if (!(dlc & XCAN_DLCR_EDL_MASK) && (id_xcan &
+						XCAN_IDR_SRR_MASK))
+				cf->can_id |= CAN_RTR_FLAG;
+		}
+
+		/* Check the frame received is FD or not*/
+		if (dlc & XCAN_DLCR_EDL_MASK) {
+			for (i = 0; i < cf->len; i += 4) {
+				if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
+					data[0] = priv->read_reg(priv,
+					(XCAN_RXMSG_2_FRAME_OFFSET(readindex) +
+					(dwindex * XCANFD_DW_BYTES)));
+				else
+					data[0] = priv->read_reg(priv,
+					(XCAN_RXMSG_FRAME_OFFSET(readindex) +
+						(dwindex * XCANFD_DW_BYTES)));
+				*(__be32 *)(cf->data + i) =
+						cpu_to_be32(data[0]);
+				dwindex++;
+			}
+		} else {
+			for (i = 0; i < cf->len; i += 4) {
+				if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
+					data[0] = priv->read_reg(priv,
+						XCAN_RXMSG_2_FRAME_OFFSET(readindex) + i);
+				else
+					data[0] = priv->read_reg(priv,
+						XCAN_RXMSG_FRAME_OFFSET(readindex) + i);
+				*(__be32 *)(cf->data + i) =
+						cpu_to_be32(data[0]);
+			}
+		}
+		/* Update FSR Register so that next packet will save to
+		 * buffer
+		 */
+		fsr = priv->read_reg(priv, XCAN_FSR_OFFSET);
+		fsr |= XCAN_FSR_IRI_MASK;
+		priv->write_reg(priv, XCAN_FSR_OFFSET, fsr);
+		fsr = priv->read_reg(priv, XCAN_FSR_OFFSET);
+		stats->rx_bytes += cf->len;
+		stats->rx_packets++;
+		netif_receive_skb(skb);
+
+		return 1;
+	}
+	/* If FSR Register is not updated with fill level */
+	return 0;
+}
+
+/**
  * xcan_current_error_state - Get current error state from HW
  * @ndev:	Pointer to net_device structure
  *
@@ -1037,7 +1219,10 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
 
 	while ((frame_offset = xcan_rx_fifo_get_next_frame(priv)) >= 0 &&
 	       (work_done < quota)) {
-		work_done += xcan_rx(ndev, frame_offset);
+		if (xcan_rx_int_mask(priv) & XCAN_IXR_RXOK_MASK)
+			work_done += xcanfd_rx(ndev, frame_offset);
+		else
+			work_done += xcan_rx(ndev, frame_offset);
 
 		if (priv->devtype.flags & XCAN_FLAG_RX_FIFO_MULTI)
 			/* increment read index */
@@ -1579,6 +1764,19 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->can.do_get_berr_counter = xcan_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_BERR_REPORTING;
+
+	if (devtype->cantype == XAXI_CANFD)
+		priv->can.data_bittiming_const =
+			&xcan_data_bittiming_const_canfd;
+
+	if (devtype->cantype == XAXI_CANFD_2_0)
+		priv->can.data_bittiming_const =
+			&xcan_data_bittiming_const_canfd2;
+
+	if (devtype->cantype == XAXI_CANFD ||
+	    devtype->cantype == XAXI_CANFD_2_0)
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+
 	priv->reg_base = addr;
 	priv->tx_max = tx_max;
 	priv->devtype = *devtype;
-- 
2.7.4

