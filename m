Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F99C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659CE206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="efRpoSGP";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TmV2RwL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgAHLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:38:10 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:22748 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgAHLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:38:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008BWPRr009143;
        Wed, 8 Jan 2020 03:38:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Fl7YkbROelntPxr5/EfTbD/lmJ+ufwYZ3R3oYWhPt0Y=;
 b=efRpoSGPrS3YP8rb6rg/zc3Lnfkoyk9kss+uZSHz+xyBk2AUXTQkAy4UIY+EYEQOQjUN
 XT6acK4pFYFhSKIUmfu8eT+cMa6pUVgrQ4IbaW2f0rJ48tLZHyWlB2PIMAlAnoLeiyFl
 P4dl/mmXlYnnqCFLELUnohVmA5tqp5Gxw8AbREAIFXK2bWw5ULwCXH10iQARgq3MiS0+
 FWNE0TaHIFWJ7SrXYXVszYQl/f6SUByGSlXg2Mi8gLsDwcuSdCBypPqZbD8WQKOTDNO1
 1ZK89kyYw4KGulc+lPqjqrqQ3oTljnZdd6T4ctROCeux67PEjc0Af/IIgSlWdfKdH7eE Fw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xar51w101-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 03:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGmotWdKUmt8qY/deXlbrmkP2VYU7EJeSd5+eGN5NEIqQd5Z9m9ADasRBSxu+MMZDUZvYO8nCYg84VFrSRrQ5Mez+gitTrwWbMOassS51eMMh3arc8YXttIUISnrGYNsualP9iw1e/I6OTA7ytNwozfZNqQs1+WoC2LOKzweYzwPhs3xyjTtdsIR1US/nM+bjcP1voAp36FFL9MIfrCc14WDf+EGmeeD7Bup21KR1rROK6wQ2WSRs8dNtoSpH7P1auYz76rX9cd7uDD85jVPC47MvCEus4aYTy0hhO7Z8IMxgjI6KPqgMZapM4+u+vXMdyt+Db6J/x3S/3D1YN1Y8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl7YkbROelntPxr5/EfTbD/lmJ+ufwYZ3R3oYWhPt0Y=;
 b=WRW5gbzJM9+Yv1DgjwkuOHQOfMmdiO7Mn9CnzowyUbW88YQnPwnU3wScusdXHMKXhZapL2jVj/P5GCl0rpoG1C/6EEI8G2CEIzv34l5epdGnX+3JZodFLublGQI7GtrKuSYznuTz8MHzsVKpmAGB79eZ7YEC2O2p6A3q/2zUXnR2Mgc0owVHigum02PxOGeYCYhHfe8KSyjbYdarKAX2GNNUmqan8gv7sIRkVuUJI3eR0ViBXdfdmsSCUN+3LkNqSwXQQE9CF53C24E/1DAQFFPbZYGvZACrWrLWbXathh3NF9jLNIrqP4cW1YH6ZePcOeg6XiVNbqCU5oT4NG7xKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl7YkbROelntPxr5/EfTbD/lmJ+ufwYZ3R3oYWhPt0Y=;
 b=TmV2RwL92bwx2Tm5Hov7ku7wwreoWtuRlS8Vkq7FHiokN+AT5/mH9aHsSmBcA7c+TtLoadGJZBZq4KuIvUW5rpjPYon8NgydzlLjvy5d+9X3wQqRV3wp1U4q+boCjtxHWniWG2vxIKUZKG2Hf0clQwS4ltlizv+SSkinTQrE3sY=
Received: from CH2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:20::41)
 by MN2PR07MB6046.namprd07.prod.outlook.com (2603:10b6:208:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 11:37:59 +0000
Received: from DM6NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::203) by CH2PR07CA0028.outlook.office365.com
 (2603:10b6:610:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 11:37:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM6NAM12FT053.mail.protection.outlook.com (10.13.179.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4 via Frontend Transport; Wed, 8 Jan 2020 11:37:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 008Bbtbp008477
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 8 Jan 2020 03:37:57 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 8 Jan 2020 12:37:55 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 8 Jan 2020 12:37:55 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 008BbtBc023473;
        Wed, 8 Jan 2020 12:37:55 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 008Bbrha023211;
        Wed, 8 Jan 2020 12:37:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <rogerq@ti.com>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chan <peter.chan@nxp.com>
Subject: [PATCH] usb: cdns3: Fix: ARM core hang after connect/disconnect operation.
Date:   Wed, 8 Jan 2020 12:37:18 +0100
Message-ID: <20200108113719.21551-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(36092001)(26826003)(42186006)(426003)(8936002)(316002)(70586007)(70206006)(5660300002)(186003)(36756003)(86362001)(478600001)(336012)(2616005)(2906002)(6916009)(4326008)(246002)(7636002)(8676002)(356004)(1076003)(6666004)(54906003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6046;H:sjmaillnx2.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5db55812-dac6-4ff3-e8d5-08d7942f35ee
X-MS-TrafficTypeDiagnostic: MN2PR07MB6046:
X-Microsoft-Antispam-PRVS: <MN2PR07MB604622DF98E37D48CC258443DD3E0@MN2PR07MB6046.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IF2bwfqiv6MoUrS+Hv/2B4YKMlNFEh4teJpYrEixLumdPNI54p5mG/g6KuXqDZ/CP47rAwCsYvRf65Ic8HAkhvZAMj6BveRZpg5wRFVWInAl4egrXqfL69Q/s151rxMVbxZ0SswrKSsUFENG9vJKN10Fz/U+VAqQ0/ZSSKMeZBtV6osd6PaFAt5UsZ+6ydWpf4C5ASEzgiKdDG+G2wTUN7zU7IUb/fQirlwpAxOjZ6vlQJsQfwEKRSE+R7iU5jGc98tmopElE4xIBVYLH0dMrO78Iee+Jg8Wcdh30HSazlzYEWk8RujprDFB0n7WzwgPRBBw4juF3ovb+LwwNp25iyS39mPFHvtILfnoYd/B3/NTqBN0sT/6WuwS92n8oyvvTvvUfxpocZh5f4PTK90qlcj3qcac8eYqwH8v6tBxup3LKhIl5FMk6/yWt1wGxbbofKwN+CgvvqSuHl/y08oj8JbIr9tCuLV58I8dtvo8dxf6dI/cmBcXsY4prtcangH2
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 11:37:58.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db55812-dac6-4ff3-e8d5-08d7942f35ee
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6046
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=1 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001080099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM core hang when access USB register after tens of thousands
connect/disconnect operation.

The issue was observed on platform with android system and is not easy
to reproduce. During test controller works at HS device mode with host
connected.

The test is based on continuous disabling/enabling USB device function
what cause continuous setting DEVDS/DEVEN bit in USB_CONF register.

For testing was used composite device consisting from ADP and RNDIS
function.

Presumably the problem was caused by DMA transfer made after setting
DEVDS bit. To resolve this issue fix stops all DMA transfer before
setting DEVDS bit.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Peter Chan <peter.chan@nxp.com>
Reported-by: Peter Chan <peter.chan@nxp.com>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/gadget.c | 84 ++++++++++++++++++++++++++------------
 drivers/usb/cdns3/gadget.h |  1 +
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 4c1e75509303..277ed8484032 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1516,6 +1516,49 @@ static int cdns3_ep_onchip_buffer_reserve(struct cdns3_device *priv_dev,
 	return 0;
 }
 
+static int cdns3_disable_reset_ep(struct cdns3_device *priv_dev,
+				  struct cdns3_endpoint *priv_ep)
+{
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+
+	if (priv_ep->flags & EP_HW_RESETED) {
+		spin_unlock_irqrestore(&priv_dev->lock, flags);
+		return 0;
+	}
+
+	cdns3_select_ep(priv_dev, priv_ep->endpoint.desc->bEndpointAddress);
+
+	val = readl(&priv_dev->regs->ep_cfg);
+	val &= ~EP_CFG_ENABLE;
+	writel(val, &priv_dev->regs->ep_cfg);
+
+	/**
+	 * Driver needs some time before resetting endpoint.
+	 * It need waits for clearing DBUSY bit or for timeout expired.
+	 * 10us is enough time for controller to stop transfer.
+	 */
+	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
+				  !(val & EP_STS_DBUSY), 1, 10);
+	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+
+	ret = readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
+					!(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
+					1, 1000);
+
+	if (unlikely(ret))
+		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
+			priv_ep->name);
+
+	priv_ep->flags |= EP_HW_RESETED;
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
+
+	return ret;
+}
+
 void cdns3_configure_dmult(struct cdns3_device *priv_dev,
 			   struct cdns3_endpoint *priv_ep)
 {
@@ -1893,8 +1936,6 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 	struct usb_request *request;
 	unsigned long flags;
 	int ret = 0;
-	u32 ep_cfg;
-	int val;
 
 	if (!ep) {
 		pr_err("usbss: invalid parameters\n");
@@ -1908,32 +1949,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 			  "%s is already disabled\n", priv_ep->name))
 		return 0;
 
-	spin_lock_irqsave(&priv_dev->lock, flags);
-
 	trace_cdns3_gadget_ep_disable(priv_ep);
 
-	cdns3_select_ep(priv_dev, ep->desc->bEndpointAddress);
-
-	ep_cfg = readl(&priv_dev->regs->ep_cfg);
-	ep_cfg &= ~EP_CFG_ENABLE;
-	writel(ep_cfg, &priv_dev->regs->ep_cfg);
-
-	/**
-	 * Driver needs some time before resetting endpoint.
-	 * It need waits for clearing DBUSY bit or for timeout expired.
-	 * 10us is enough time for controller to stop transfer.
-	 */
-	readl_poll_timeout_atomic(&priv_dev->regs->ep_sts, val,
-				  !(val & EP_STS_DBUSY), 1, 10);
-	writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
-
-	readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
-				  !(val & (EP_CMD_CSTALL | EP_CMD_EPRST)),
-				  1, 1000);
-	if (unlikely(ret))
-		dev_err(priv_dev->dev, "Timeout: %s resetting failed.\n",
-			priv_ep->name);
+	cdns3_disable_reset_ep(priv_dev, priv_ep);
 
+	spin_lock_irqsave(&priv_dev->lock, flags);
 	while (!list_empty(&priv_ep->pending_req_list)) {
 		request = cdns3_next_request(&priv_ep->pending_req_list);
 
@@ -1962,6 +1982,7 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	ep->desc = NULL;
 	priv_ep->flags &= ~EP_ENABLED;
+	priv_ep->flags |= EP_CLAIMED | EP_HW_RESETED;
 
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 
@@ -2282,11 +2303,20 @@ static int cdns3_gadget_set_selfpowered(struct usb_gadget *gadget,
 static int cdns3_gadget_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	int i;
 
-	if (is_on)
+	if (is_on) {
 		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
-	else
+	} else {
+		for (i = 1; i < CDNS3_ENDPOINTS_MAX_COUNT; i++) {
+			if (priv_dev->eps[i] &&
+			    priv_dev->eps[i]->flags & EP_ENABLED)
+				cdns3_disable_reset_ep(priv_dev,
+						       priv_dev->eps[i]);
+		}
+
 		writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index bc4024041ef2..b6cc222b9f58 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1142,6 +1142,7 @@ struct cdns3_endpoint {
 #define EP_QUIRK_END_TRANSFER	BIT(11)
 #define EP_QUIRK_EXTRA_BUF_DET	BIT(12)
 #define EP_QUIRK_EXTRA_BUF_EN	BIT(13)
+#define EP_HW_RESETED		BIT(14)
 	u32			flags;
 
 	struct cdns3_request	*descmis_req;
-- 
2.17.1

