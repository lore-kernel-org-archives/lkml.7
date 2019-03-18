Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07778C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF7B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wKBmBbEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCRLdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:33:19 -0400
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:23472
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfCRLdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxCgXtWgOCGFaandX+L+7vMKJRB1bAfcIVTHL7ayB8o=;
 b=wKBmBbEC+I5kRBsZ5oDp/Yics644/NnKw07AatXZqGJB78Wmq3+Et4qF/2PJ+TLmOC1+NLD4zqXLWIreCyaZgpKt2QdmKcwEy9yClua/ZbvEZUfTxs6T61Ry98f+fMW3PfGOlM7LzfaxOJR1VcDIygmN0L0ctwxRAXi573c9k3E=
Received: from MWHPR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:301:73::15) by CY4PR02MB2839.namprd02.prod.outlook.com
 (2603:10b6:903:121::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 11:33:10 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR0201CA0038.outlook.office365.com
 (2603:10b6:301:73::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 11:33:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; grandegger.com; dkim=none (message not signed)
 header.d=none;grandegger.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 11:33:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50614 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVw-0004fr-E6; Mon, 18 Mar 2019 04:33:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVr-0008T7-AH; Mon, 18 Mar 2019 04:33:03 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h5qVj-0008M3-Ra; Mon, 18 Mar 2019 04:32:56 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <michal.simek@xilinx.com>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 1/6] net: can: xilinx_can: Fix style issues
Date:   Mon, 18 Mar 2019 17:02:41 +0530
Message-ID: <1552908766-26753-2-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(336012)(106002)(81156014)(63266004)(7696005)(76176011)(51416003)(446003)(36756003)(2201001)(478600001)(11346002)(476003)(2616005)(8676002)(106466001)(110136005)(54906003)(126002)(2906002)(486006)(356004)(6666004)(48376002)(47776003)(107886003)(50226002)(16586007)(9786002)(14444005)(26005)(316002)(81166006)(6636002)(305945005)(4326008)(8936002)(426003)(186003)(36386004)(77096007)(50466002)(5660300002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2839;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db94384-80e6-40b0-cad0-08d6ab957f52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2839;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2839:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB28396A161C673981562A564DDC470@CY4PR02MB2839.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZB2wcrCdtNPjqPKni6ETytP1duEd6NSQ2gIqg+9JZiyvvIPuCWB0g9M82UgvUOgcQRwohftewsUnFARayFKgTGYfXnmzCzFl46wCPEpTTsx+6kYSSu8hork+uBZUfG/egGX989XGkvFqJaA5lKodjOX7kskZhQWBMU0kyfCK9bZUJrFIKuYSwfHacIfa49BONf9zNyrLc8Rzukfmz/bMnMEV1AuA0imT9lK7h+3SOThqFFJvL0KXzWCZzg02KtqU7QiI6x6mPgNWRm6fLVucqKzYjqxhNiWMKjQUQZ/jDnzsr9ziOss1J3t0kr41mLm1rv1buwWmWt7Cfus513zL/rAWZNipgtBqYclxxEsCIFHqqWdZInIiJ5JB6WvwqeiWOKMOF8pqkHYAzKHgaREPgJuK9g0AX4X7L4SKDGwWH9o=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 11:33:08.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db94384-80e6-40b0-cad0-08d6ab957f52
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch warnings and checks in the driver.

CHECK: Alignment should match open parenthesis
+       void (*write_reg)(const struct xcan_priv *priv, enum xcan_reg reg,
+                       u32 val);

CHECK: Alignment should match open parenthesis
+static void xcan_write_reg_le(const struct xcan_priv *priv, enum xcan_reg reg,
+                       u32 val)

CHECK: Alignment should match open parenthesis
+static void xcan_write_reg_be(const struct xcan_priv *priv, enum xcan_reg reg,
+                       u32 val)

CHECK: Alignment should match open parenthesis
+       netdev_dbg(ndev, "BRPR=0x%08x, BTR=0x%08x\n",
+                       priv->read_reg(priv, XCAN_BRPR_OFFSET),

CHECK: Alignment should match open parenthesis
+                       netdev_warn(ndev,
+                               "timed out for correct mode\n");

CHECK: Alignment should match open parenthesis
+       netdev_dbg(ndev, "status:#x%08x\n",
+                       priv->read_reg(priv, XCAN_SR_OFFSET));

CHECK: spaces preferred around that '-' (ctx:VxV)
+                       (CAN_EFF_ID_BITS-CAN_SFF_ID_BITS)) <<
                                        ^

CHECK: Alignment should match open parenthesis
+       netdev_dbg(ndev, "%s: error status register:0x%x\n",
+                       __func__, priv->read_reg(priv, XCAN_ESR_OFFSET));

WARNING: line over 80 characters
+                       offset = XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);

WARNING: line over 80 characters
+                       offset = XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);

WARNING: line over 80 characters
+               while ((isr & XCAN_IXR_TXOK_MASK) && !WARN_ON(++retries == 100)) {

WARNING: line over 80 characters
+                       priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);

CHECK: Alignment should match open parenthesis
+               netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
+                               __func__, ret);

CHECK: Alignment should match open parenthesis
+       ret = request_irq(ndev->irq, xcan_interrupt, priv->irq_flags,
+                       ndev->name, ndev);

CHECK: Alignment should match open parenthesis
+static int xcan_get_berr_counter(const struct net_device *ndev,
+                                       struct can_berr_counter *bec)

CHECK: Alignment should match open parenthesis
+               netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
+                               __func__, ret);

CHECK: Please don't use multiple blank lines
+
+

CHECK: Alignment should match open parenthesis
+               netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
+                       __func__, ret);`

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 97d0933..2de51ac 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -191,7 +191,7 @@ struct xcan_priv {
 	struct napi_struct napi;
 	u32 (*read_reg)(const struct xcan_priv *priv, enum xcan_reg reg);
 	void (*write_reg)(const struct xcan_priv *priv, enum xcan_reg reg,
-			u32 val);
+			  u32 val);
 	struct device *dev;
 	void __iomem *reg_base;
 	unsigned long irq_flags;
@@ -246,7 +246,7 @@ static const struct can_bittiming_const xcan_bittiming_const_canfd2 = {
  * Write data to the paricular CAN register
  */
 static void xcan_write_reg_le(const struct xcan_priv *priv, enum xcan_reg reg,
-			u32 val)
+			      u32 val)
 {
 	iowrite32(val, priv->reg_base + reg);
 }
@@ -273,7 +273,7 @@ static u32 xcan_read_reg_le(const struct xcan_priv *priv, enum xcan_reg reg)
  * Write data to the paricular CAN register
  */
 static void xcan_write_reg_be(const struct xcan_priv *priv, enum xcan_reg reg,
-			u32 val)
+			      u32 val)
 {
 	iowrite32be(val, priv->reg_base + reg);
 }
@@ -381,8 +381,8 @@ static int xcan_set_bittiming(struct net_device *ndev)
 	priv->write_reg(priv, XCAN_BTR_OFFSET, btr1);
 
 	netdev_dbg(ndev, "BRPR=0x%08x, BTR=0x%08x\n",
-			priv->read_reg(priv, XCAN_BRPR_OFFSET),
-			priv->read_reg(priv, XCAN_BTR_OFFSET));
+		   priv->read_reg(priv, XCAN_BRPR_OFFSET),
+		   priv->read_reg(priv, XCAN_BTR_OFFSET));
 
 	return 0;
 }
@@ -447,12 +447,12 @@ static int xcan_chip_start(struct net_device *ndev)
 	while (!(priv->read_reg(priv, XCAN_SR_OFFSET) & reg_sr_mask)) {
 		if (time_after(jiffies, timeout)) {
 			netdev_warn(ndev,
-				"timed out for correct mode\n");
+				    "timed out for correct mode\n");
 			return -ETIMEDOUT;
 		}
 	}
 	netdev_dbg(ndev, "status:#x%08x\n",
-			priv->read_reg(priv, XCAN_SR_OFFSET));
+		   priv->read_reg(priv, XCAN_SR_OFFSET));
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	return 0;
@@ -506,7 +506,7 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 		id = ((cf->can_id & CAN_EFF_MASK) << XCAN_IDR_ID2_SHIFT) &
 			XCAN_IDR_ID2_MASK;
 		id |= (((cf->can_id & CAN_EFF_MASK) >>
-			(CAN_EFF_ID_BITS-CAN_SFF_ID_BITS)) <<
+			(CAN_EFF_ID_BITS - CAN_SFF_ID_BITS)) <<
 			XCAN_IDR_ID1_SHIFT) & XCAN_IDR_ID1_MASK;
 
 		/* The substibute remote TX request bit should be "1"
@@ -942,7 +942,7 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 	}
 
 	netdev_dbg(ndev, "%s: error status register:0x%x\n",
-			__func__, priv->read_reg(priv, XCAN_ESR_OFFSET));
+		   __func__, priv->read_reg(priv, XCAN_ESR_OFFSET));
 }
 
 /**
@@ -990,9 +990,11 @@ static int xcan_rx_fifo_get_next_frame(struct xcan_priv *priv)
 			return -ENOENT;
 
 		if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
-			offset = XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
+			offset =
+			  XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
 		else
-			offset = XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
+			offset =
+			  XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
 
 	} else {
 		/* check if RX FIFO is empty */
@@ -1102,8 +1104,10 @@ static void xcan_tx_interrupt(struct net_device *ndev, u32 isr)
 		 *     via TXFEMP handling as we read TXFEMP *after* TXOK
 		 *     clear to satisfy (1).
 		 */
-		while ((isr & XCAN_IXR_TXOK_MASK) && !WARN_ON(++retries == 100)) {
-			priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
+		while ((isr & XCAN_IXR_TXOK_MASK) &&
+		       !WARN_ON(++retries == 100)) {
+			priv->write_reg(priv, XCAN_ICR_OFFSET,
+					XCAN_IXR_TXOK_MASK);
 			isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
 		}
 
@@ -1216,12 +1220,12 @@ static int xcan_open(struct net_device *ndev)
 	ret = pm_runtime_get_sync(priv->dev);
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
-				__func__, ret);
+			   __func__, ret);
 		return ret;
 	}
 
 	ret = request_irq(ndev->irq, xcan_interrupt, priv->irq_flags,
-			ndev->name, ndev);
+			  ndev->name, ndev);
 	if (ret < 0) {
 		netdev_err(ndev, "irq allocation for CAN failed\n");
 		goto err;
@@ -1292,7 +1296,7 @@ static int xcan_close(struct net_device *ndev)
  * Return: 0 on success and failure value on error
  */
 static int xcan_get_berr_counter(const struct net_device *ndev,
-					struct can_berr_counter *bec)
+				 struct can_berr_counter *bec)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
@@ -1300,7 +1304,7 @@ static int xcan_get_berr_counter(const struct net_device *ndev,
 	ret = pm_runtime_get_sync(priv->dev);
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
-				__func__, ret);
+			   __func__, ret);
 		return ret;
 	}
 
@@ -1313,7 +1317,6 @@ static int xcan_get_berr_counter(const struct net_device *ndev,
 	return 0;
 }
 
-
 static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
@@ -1597,7 +1600,7 @@ static int xcan_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
-			__func__, ret);
+			   __func__, ret);
 		goto err_pmdisable;
 	}
 
-- 
2.7.4

