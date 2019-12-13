Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC36C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695AC2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cHVb1dwa";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Wb8CkxDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfLMF0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:26:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:3858 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726998AbfLMF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:26:43 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBD5OcQO007505;
        Thu, 12 Dec 2019 21:26:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=9v9bGrVGKcHUTLhwrc6TUE2848b2qVYh9wDoM5osE2w=;
 b=cHVb1dwaYLk9wibB/54tmm7gn/SaLmU8ObUranfOiemZaMASznlyAgdvqGxizQBnQiew
 PoB7QodI6Qh6Ooz7VU2sYDeVAO/O71hU9BeXRpGeGLTqB6zVBcBQ5cBu6pYiKgFqPXVV
 XLKg5WqMWS9W+GKOBObdgTxt40z63uDLFpLIorKsvUA1DWWY/kUTcibsn9wmjaqX0T9h
 sGEhuKaShAkcmEXkckVGyLKn9hsx6Uq2eJDrXbFjx4thNvQz3FXiqFwWngsrEVYSJG9r
 62PROSv67ZsH5cpszgAnzvca5rfXHC4KssUCz2Qk5Gv+B/2a8kjAnT4uCrwN6bXjr/1v fQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfwcjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 21:26:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PorUEkbPZE+InlfD/qoaImYqttPUtA7oQozjLNsPUy7cpdf0bU2Aj2GkOZbxNeaUsplbf+cXFWz4cJH8biRAGQj11eKa62wY1AhVPptiI0wIDzolVo4+KG9H9cNERRozUVWZL2JPugIUokkRJsU+ywHZY940/6zcbrzHQ/Ho/p4bTHl2OKqBAibtd+GeKYsV9K7Z2Fn1zZ/bMDbrOW/QocSIlmPYgbt9rL/ba8d3eKuI+tkkxvJHcVi3Bzq/yF2RptEMfdBxXb/OUIWluZtgK09ZLgbZ+JphhnIPIdaONrw4Tso4wL0SNIHZ9k5QyNLJRFLTddbDdT3M/wT1/no3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v9bGrVGKcHUTLhwrc6TUE2848b2qVYh9wDoM5osE2w=;
 b=FVK2kMh3J0IAgWK1/9D71TIoebUF2zzO6GtZF4sdb/f1T57R52JOqHBceEdG3jnuF4Chuj8TyCBy+ru1MzOTnVxpADYB6DGNQaXnvd/FTtXUIGnEhYUKqQhvtzSULM4BpgI4APxV2C2yPZJdkg2ckD+BLHnsnUp+KTRsHEdn2Dmc//IFrwcf87EChDvvtJ4AaNCEPFF1RqcRhX5uis68aHxIQ1Jd4zqh63ikM/aLN/1/vGuJNrf7oagq3NmctlhOxOqPglPhuL3ZeQuaKh8ninJLsOXF5pewleq/SsbhRf3H2cd017y1+JMdyoSe+tgaK+y3E9T85sqp431Ky6eH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v9bGrVGKcHUTLhwrc6TUE2848b2qVYh9wDoM5osE2w=;
 b=Wb8CkxDQDRSrorChKeBohllmqoUmWpCPpOKdw4l2wSffm02XMZeBIl1dkAqvf7I/HzXuPnIpr0Yt5hVUnQZKthiSjVmMa6ncsovyF41+b6eEsEfYrTQiEdE6UCn12AF7tuwI4HhYzZvZjIEY+urULDSeTnKNBCuO/dqibS7sd3I=
Received: from MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25)
 by BY5PR07MB6514.namprd07.prod.outlook.com (2603:10b6:a03:1a7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Fri, 13 Dec
 2019 05:26:16 +0000
Received: from MW2NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::200) by MN2PR07CA0015.outlook.office365.com
 (2603:10b6:208:1a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Fri, 13 Dec 2019 05:26:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 MW2NAM12FT042.mail.protection.outlook.com (10.13.180.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Fri, 13 Dec 2019 05:26:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBD5QBIK030912
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 12 Dec 2019 21:26:12 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 13 Dec 2019 06:26:11 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 13 Dec 2019 06:26:10 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBD5QAoq018270;
        Fri, 13 Dec 2019 06:26:10 +0100
Received: (from jpawar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBD5Q810018267;
        Fri, 13 Dec 2019 06:26:08 +0100
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <peter.chen@nxp.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>, <sparmar@cadence.com>,
        <jpawar@cadence.com>
Subject: [PATCH] usb: cdns3: Add streams support to cadence USB3 DRD driver
Date:   Fri, 13 Dec 2019 06:25:42 +0100
Message-ID: <1576214742-18064-1-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(51234002)(189003)(199004)(42186006)(4326008)(7416002)(2616005)(8936002)(6666004)(26826003)(316002)(2906002)(86362001)(36756003)(107886003)(54906003)(8676002)(5660300002)(26005)(336012)(186003)(76130400001)(6916009)(478600001)(426003)(356004)(70586007)(70206006)(246002)(30864003)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6514;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87dfc585-d3ec-4865-b4b7-08d77f8cf94d
X-MS-TrafficTypeDiagnostic: BY5PR07MB6514:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6514EB87178D5ECB9629B870C1540@BY5PR07MB6514.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HV/qprwCAFj6FLWZaEU4FGWydHjP+ZxfNcK5acfaO6m3D5Vx5xLpvilYk3Uw5ibWidOm7vfk3XIKDyHsFpb7XmdiTcw40snxDBSqLXM5kBXJtkDX3NC9Cxj861wGVOx6lBxBV9uLqJvYZQ/Qqp7TdFWO4YDPoKKH09IlkPHi0wRpArMlY7n2WdZOJatu708jsOzDoTspAzOxAWYkPR2qMzMqK5LEFGRGgh3YWVYpNqwwCdfscoNA+/kYtyqB/OgklS9mD0AejKlwss74uX/QfutF4boAPwIIOOtisqQnNGwO1JtaCa2oGMXkJCVscrFFiUartEPI5VXbyY5z8Gk7KaaLoLR6Q0X+Fu8l9U8lYCQ6TeBL/lIK4d7e43A4PZiPnOLjw+4W4+lD526yhbMbLY9EM3mO8BJTaZzBFe7wWIPkYYs6F3pj3NxpnPA67Zr9quF05aVBwIXJVYbFV+euQ3QgSDtRTcgTKupA4mWs50iy80256Kx6Vn6JYCNOfz1CL/LVdKd+oAd1pSo2hbkOA==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 05:26:15.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dfc585-d3ec-4865-b4b7-08d77f8cf94d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6514
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=3 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes streams implementation changes.
The current changes has been validated on FPGA platform.

Enabled streams related interrupts only for streams capable endpoints.
Processed  PRIME and IOT interrupts related to streams capable endpoints.
Based on PRIME interrupt prime_flag is set and transfer is armed
otherwise just adding request to the deferred request queue.
For streams capable endpoints preparing TD with correct stream ID.

TDL calculation:
Updated tdl calculation based on controller versions.
1. For controller version DEV_VER_V2 :We have enabled USB_CONF2_EN_TDL_TRB
   bit in usb_conf2 register in DMULT configuration.
   This enables TDL calculation based on TRB, hence setting TDL in TRB.
2. For controller Version < DEV_VER_V2 : Writing TDL and STDL in ep_cmd
   register
3. For controller version > DEV_VER_V2 : Writing TDL in ep_tdl register.

Writing ERDY with correct Stream ID to ep_cmd register.
Added stream id related information to trace logs.

Signed-off-by: Rahul Kumar <kurahul@cadence.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 533 +++++++++++++++++++++++++++++++++----
 drivers/usb/cdns3/gadget.h |  26 +-
 drivers/usb/cdns3/trace.h  |  93 ++++++-
 3 files changed, 596 insertions(+), 56 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 2ca280f4c054..3bc5e66d9075 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -71,6 +71,23 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 				   struct usb_request *request,
 				   gfp_t gfp_flags);
 
+static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
+				 struct usb_request *request);
+
+static int cdns3_ep_run_stream_transfer(struct cdns3_endpoint *priv_ep,
+					struct usb_request *request);
+
+/**
+ * cdns3_clear_register_bit - clear bit in given register.
+ * @ptr: address of device controller register to be read and changed
+ * @mask: bits requested to clar
+ */
+void cdns3_clear_register_bit(void __iomem *ptr, u32 mask)
+{
+	mask = readl(ptr) & ~mask;
+	writel(mask, ptr);
+}
+
 /**
  * cdns3_set_register_bit - set bit in given register.
  * @ptr: address of device controller register to be read and changed
@@ -150,6 +167,21 @@ void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep)
 	writel(ep, &priv_dev->regs->ep_sel);
 }
 
+/**
+ * cdns3_get_tdl - gets current tdl for selected endpoint.
+ * @priv_dev:  extended gadget object
+ *
+ * Before calling this function the appropriate endpoint must
+ * be selected by means of cdns3_select_ep function.
+ */
+static int cdns3_get_tdl(struct cdns3_device *priv_dev)
+{
+	if (priv_dev->dev_ver < DEV_VER_V3)
+		return EP_CMD_TDL_GET(readl(&priv_dev->regs->ep_cmd));
+	else
+		return readl(&priv_dev->regs->ep_tdl);
+}
+
 dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
 				 struct cdns3_trb *trb)
 {
@@ -166,7 +198,22 @@ int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
 	case USB_ENDPOINT_XFER_CONTROL:
 		return TRB_CTRL_RING_SIZE;
 	default:
-		return TRB_RING_SIZE;
+		if (priv_ep->use_streams)
+			return TRB_STREAM_RING_SIZE;
+		else
+			return TRB_RING_SIZE;
+	}
+}
+
+static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	if (priv_ep->trb_pool) {
+		dma_free_coherent(priv_dev->sysdev,
+				  cdns3_ring_size(priv_ep),
+				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
+		priv_ep->trb_pool = NULL;
 	}
 }
 
@@ -180,8 +227,12 @@ int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	int ring_size = cdns3_ring_size(priv_ep);
+	int num_trbs = ring_size / TRB_SIZE;
 	struct cdns3_trb *link_trb;
 
+	if (priv_ep->trb_pool && priv_ep->alloc_ring_size < ring_size)
+		cdns3_free_trb_pool(priv_ep);
+
 	if (!priv_ep->trb_pool) {
 		priv_ep->trb_pool = dma_alloc_coherent(priv_dev->sysdev,
 						       ring_size,
@@ -189,32 +240,30 @@ int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep)
 						       GFP_DMA32 | GFP_ATOMIC);
 		if (!priv_ep->trb_pool)
 			return -ENOMEM;
-	} else {
+
+		priv_ep->alloc_ring_size = ring_size;
 		memset(priv_ep->trb_pool, 0, ring_size);
 	}
 
+	priv_ep->num_trbs = num_trbs;
+
 	if (!priv_ep->num)
 		return 0;
 
-	priv_ep->num_trbs = ring_size / TRB_SIZE;
-	/* Initialize the last TRB as Link TRB. */
+	/* Initialize the last TRB as Link TRB */
 	link_trb = (priv_ep->trb_pool + (priv_ep->num_trbs - 1));
-	link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma);
-	link_trb->control = TRB_CYCLE | TRB_TYPE(TRB_LINK) | TRB_TOGGLE;
-
-	return 0;
-}
 
-static void cdns3_free_trb_pool(struct cdns3_endpoint *priv_ep)
-{
-	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
-
-	if (priv_ep->trb_pool) {
-		dma_free_coherent(priv_dev->sysdev,
-				  cdns3_ring_size(priv_ep),
-				  priv_ep->trb_pool, priv_ep->trb_pool_dma);
-		priv_ep->trb_pool = NULL;
+	if (priv_ep->use_streams) {
+		/*
+		 * For stream capable endpoints driver use single correct TRB.
+		 * The last trb has zeroed cycle bit
+		 */
+		link_trb->control = 0;
+	} else {
+		link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma);
+		link_trb->control = TRB_CYCLE | TRB_TYPE(TRB_LINK) | TRB_TOGGLE;
 	}
+	return 0;
 }
 
 /**
@@ -253,6 +302,7 @@ void cdns3_hw_reset_eps_config(struct cdns3_device *priv_dev)
 	priv_dev->onchip_used_size = 0;
 	priv_dev->out_mem_is_allocated = 0;
 	priv_dev->wait_for_setup = 0;
+	priv_dev->using_streams = 0;
 }
 
 /**
@@ -356,17 +406,43 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 {
 	struct usb_request *request;
 	int ret = 0;
+	u8 pending_empty = list_empty(&priv_ep->pending_req_list);
+
+	/*
+	 * If the last pending transfer is INTERNAL
+	 * OR streams are enabled for this endpoint
+	 * do NOT start new transfer till the last one is pending
+	 */
+	if (!pending_empty) {
+		struct cdns3_request *priv_req;
+
+		request = cdns3_next_request(&priv_ep->pending_req_list);
+		priv_req = to_cdns3_request(request);
+		if ((priv_req->flags & REQUEST_INTERNAL) ||
+		    (priv_ep->flags & EP_TDLCHK_EN) ||
+			priv_ep->use_streams) {
+			trace_printk("Blocking external request\n");
+			return ret;
+		}
+	}
 
 	while (!list_empty(&priv_ep->deferred_req_list)) {
 		request = cdns3_next_request(&priv_ep->deferred_req_list);
 
-		ret = cdns3_ep_run_transfer(priv_ep, request);
+		if (!priv_ep->use_streams) {
+			ret = cdns3_ep_run_transfer(priv_ep, request);
+		} else {
+			priv_ep->stream_sg_idx = 0;
+			ret = cdns3_ep_run_stream_transfer(priv_ep, request);
+		}
 		if (ret)
 			return ret;
 
 		list_del(&request->list);
 		list_add_tail(&request->list,
 			      &priv_ep->pending_req_list);
+		if (request->stream_id != 0 || (priv_ep->flags & EP_TDLCHK_EN))
+			break;
 	}
 
 	priv_ep->flags &= ~EP_RING_FULL;
@@ -379,7 +455,7 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
  * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
  * if before first DESCMISS interrupt the DMA will be armed.
  */
-#define cdns3_wa2_enable_detection(priv_dev, ep_priv, reg) do { \
+#define cdns3_wa2_enable_detection(priv_dev, priv_ep, reg) do { \
 	if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) { \
 		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET; \
 		(reg) |= EP_STS_EN_DESCMISEN; \
@@ -450,10 +526,17 @@ struct usb_request *cdns3_wa2_gadget_giveback(struct cdns3_device *priv_dev,
 		if (!req)
 			return NULL;
 
+		/* unmap the gadget request before copying data */
+		usb_gadget_unmap_request_by_dev(priv_dev->sysdev, req,
+						priv_ep->dir);
+
 		cdns3_wa2_descmiss_copy_data(priv_ep, req);
 		if (!(priv_ep->flags & EP_QUIRK_END_TRANSFER) &&
 		    req->length != req->actual) {
 			/* wait for next part of transfer */
+			/* re-map the gadget request buffer*/
+			usb_gadget_map_request_by_dev(priv_dev->sysdev, req,
+				usb_endpoint_dir_in(priv_ep->endpoint.desc));
 			return NULL;
 		}
 
@@ -570,6 +653,13 @@ static void cdns3_wa2_descmissing_packet(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_request *priv_req;
 	struct usb_request *request;
+	u8 pending_empty = list_empty(&priv_ep->pending_req_list);
+
+	/* check for pending transfer */
+	if (!pending_empty) {
+		trace_cdns3_wa2(priv_ep, "Ignoring Descriptor missing IRQ\n");
+		return;
+	}
 
 	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
 		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
@@ -578,8 +668,10 @@ static void cdns3_wa2_descmissing_packet(struct cdns3_endpoint *priv_ep)
 
 	trace_cdns3_wa2(priv_ep, "Description Missing detected\n");
 
-	if (priv_ep->wa2_counter >= CDNS3_WA2_NUM_BUFFERS)
+	if (priv_ep->wa2_counter >= CDNS3_WA2_NUM_BUFFERS) {
+		trace_cdns3_wa2(priv_ep, "WA2 overflow\n");
 		cdns3_wa2_remove_old_request(priv_ep);
+	}
 
 	request = cdns3_gadget_ep_alloc_request(&priv_ep->endpoint,
 						GFP_ATOMIC);
@@ -621,6 +713,78 @@ static void cdns3_wa2_descmissing_packet(struct cdns3_endpoint *priv_ep)
 		"Failed: No sufficient memory for DESCMIS\n");
 }
 
+static void cdns3_wa2_reset_tdl(struct cdns3_device *priv_dev)
+{
+	u16 tdl = EP_CMD_TDL_GET(readl(&priv_dev->regs->ep_cmd));
+
+	if (tdl) {
+		u16 reset_val = EP_CMD_TDL_MAX + 1 - tdl;
+
+		writel(EP_CMD_TDL_SET(reset_val) | EP_CMD_STDL,
+		       &priv_dev->regs->ep_cmd);
+	}
+}
+
+static void cdns3_wa2_check_outq_status(struct cdns3_device *priv_dev)
+{
+	u32 ep_sts_reg;
+
+	/* select EP0-out */
+	cdns3_select_ep(priv_dev, 0);
+
+	ep_sts_reg = readl(&priv_dev->regs->ep_sts);
+
+	if (EP_STS_OUTQ_VAL(ep_sts_reg)) {
+		u32 outq_ep_num = EP_STS_OUTQ_NO(ep_sts_reg);
+		struct cdns3_endpoint *outq_ep = priv_dev->eps[outq_ep_num];
+
+		if ((outq_ep->flags & EP_ENABLED) && !(outq_ep->use_streams) &&
+		    outq_ep->type != USB_ENDPOINT_XFER_ISOC && outq_ep_num) {
+			u8 pending_empty = list_empty(&outq_ep->pending_req_list);
+
+			if ((outq_ep->flags & EP_QUIRK_EXTRA_BUF_DET) ||
+			    (outq_ep->flags & EP_QUIRK_EXTRA_BUF_EN) ||
+			    !pending_empty) {
+			} else {
+				u32 ep_sts_en_reg;
+				u32 ep_cmd_reg;
+
+				cdns3_select_ep(priv_dev, outq_ep->num |
+						outq_ep->dir);
+				ep_sts_en_reg = readl(&priv_dev->regs->ep_sts_en);
+				ep_cmd_reg = readl(&priv_dev->regs->ep_cmd);
+
+				outq_ep->flags |= EP_TDLCHK_EN;
+				cdns3_set_register_bit(&priv_dev->regs->ep_cfg,
+						       EP_CFG_TDL_CHK);
+
+				cdns3_wa2_enable_detection(priv_dev, outq_ep,
+							   ep_sts_en_reg);
+				writel(ep_sts_en_reg,
+				       &priv_dev->regs->ep_sts_en);
+				/* reset tdl value to zero */
+				cdns3_wa2_reset_tdl(priv_dev);
+				/*
+				 * Memory barrier - Reset tdl before ringing the
+				 * doorbell.
+				 */
+				wmb();
+				if (EP_CMD_DRDY & ep_cmd_reg) {
+					trace_cdns3_wa2(outq_ep, "Enabling WA2 skipping doorbell\n");
+
+				} else {
+					trace_cdns3_wa2(outq_ep, "Enabling WA2 ringing doorbell\n");
+					/*
+					 * ring doorbell to generate DESCMIS irq
+					 */
+					writel(EP_CMD_DRDY,
+					       &priv_dev->regs->ep_cmd);
+				}
+			}
+		}
+	}
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
@@ -807,14 +971,120 @@ static void cdns3_wa1_tray_restore_cycle_bit(struct cdns3_device *priv_dev,
 		cdns3_wa1_restore_cycle_bit(priv_ep);
 }
 
+static int cdns3_ep_run_stream_transfer(struct cdns3_endpoint *priv_ep,
+					struct usb_request *request)
+{
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_request *priv_req;
+	struct cdns3_trb *trb;
+	dma_addr_t trb_dma;
+	int address;
+	u32 control;
+	u32 length;
+	u32 tdl;
+	unsigned int sg_idx = priv_ep->stream_sg_idx;
+
+	priv_req = to_cdns3_request(request);
+	address = priv_ep->endpoint.desc->bEndpointAddress;
+
+	priv_ep->flags |= EP_PENDING_REQUEST;
+
+	/* must allocate buffer aligned to 8 */
+	if (priv_req->flags & REQUEST_UNALIGNED)
+		trb_dma = priv_req->aligned_buf->dma;
+	else
+		trb_dma = request->dma;
+
+	/*  For stream capable endpoints driver use only single TD. */
+	trb = priv_ep->trb_pool + priv_ep->enqueue;
+	priv_req->start_trb = priv_ep->enqueue;
+	priv_req->end_trb = priv_req->start_trb;
+	priv_req->trb = trb;
+
+	cdns3_select_ep(priv_ep->cdns3_dev, address);
+
+	control = TRB_TYPE(TRB_NORMAL) | TRB_CYCLE |
+		  TRB_STREAM_ID(priv_req->request.stream_id) | TRB_ISP;
+
+	if (!request->num_sgs) {
+		trb->buffer = TRB_BUFFER(trb_dma);
+		length = request->length;
+	} else {
+		trb->buffer = TRB_BUFFER(request->sg[sg_idx].dma_address);
+		length = request->sg[sg_idx].length;
+	}
+
+	tdl = DIV_ROUND_UP(length, priv_ep->endpoint.maxpacket);
+
+	trb->length = TRB_BURST_LEN(16 /*priv_ep->trb_burst_size*/) |
+				  TRB_LEN(length);
+
+	/*
+	 * For DEV_VER_V2 controller version we have enabled
+	 * USB_CONF2_EN_TDL_TRB in DMULT configuration.
+	 * This enables TDL calculation based on TRB, hence setting TDL in TRB.
+	 */
+	if (priv_dev->dev_ver >= DEV_VER_V2) {
+		if (priv_dev->gadget.speed == USB_SPEED_SUPER)
+			trb->length |= TRB_TDL_SS_SIZE(tdl);
+	}
+	priv_req->flags |= REQUEST_PENDING;
+
+	trb->control = control;
+
+	trace_cdns3_prepare_trb(priv_ep, priv_req->trb);
+
+	/*
+	 * Memory barrier - Cycle Bit must be set before trb->length  and
+	 * trb->buffer fields.
+	 */
+	wmb();
+
+	/* always first element */
+	writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma),
+	       &priv_dev->regs->ep_traddr);
+
+	if (!(priv_ep->flags & EP_STALLED)) {
+		trace_cdns3_ring(priv_ep);
+		/*clearing TRBERR and EP_STS_DESCMIS before seting DRDY*/
+		writel(EP_STS_TRBERR | EP_STS_DESCMIS, &priv_dev->regs->ep_sts);
+
+		priv_ep->prime_flag = false;
+
+		/*
+		 * Controller version DEV_VER_V2 tdl calculation
+		 * is based on TRB
+		 */
+
+		if (priv_dev->dev_ver < DEV_VER_V2)
+			writel(EP_CMD_TDL_SET(tdl) | EP_CMD_STDL,
+			       &priv_dev->regs->ep_cmd);
+		else if (priv_dev->dev_ver > DEV_VER_V2)
+			writel(tdl, &priv_dev->regs->ep_tdl);
+
+		priv_ep->last_stream_id = priv_req->request.stream_id;
+		writel(EP_CMD_DRDY, &priv_dev->regs->ep_cmd);
+		writel(EP_CMD_ERDY_SID(priv_req->request.stream_id) |
+		       EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
+
+		trace_cdns3_doorbell_epx(priv_ep->name,
+					 readl(&priv_dev->regs->ep_traddr));
+	}
+
+	/* WORKAROUND for transition to L0 */
+	__cdns3_gadget_wakeup(priv_dev);
+
+	return 0;
+}
+
 /**
  * cdns3_ep_run_transfer - start transfer on no-default endpoint hardware
  * @priv_ep: endpoint object
  *
  * Returns zero on success or negative value on failure
  */
-int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
-			  struct usb_request *request)
+static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
+				 struct usb_request *request)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	struct cdns3_request *priv_req;
@@ -826,6 +1096,7 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	int address;
 	u32 control;
 	int pcs;
+	u16 total_tdl = 0;
 
 	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
 		num_trb = priv_ep->interval;
@@ -910,6 +1181,9 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		if (likely(priv_dev->dev_ver >= DEV_VER_V2))
 			td_size = DIV_ROUND_UP(length,
 					       priv_ep->endpoint.maxpacket);
+		else if (priv_ep->flags & EP_TDLCHK_EN)
+			total_tdl += DIV_ROUND_UP(length,
+					       priv_ep->endpoint.maxpacket);
 
 		trb->length = TRB_BURST_LEN(priv_ep->trb_burst_size) |
 					TRB_LEN(length);
@@ -954,6 +1228,23 @@ int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	if (sg_iter == 1)
 		trb->control |= TRB_IOC | TRB_ISP;
 
+	if (priv_dev->dev_ver < DEV_VER_V2 &&
+	    (priv_ep->flags & EP_TDLCHK_EN)) {
+		u16 tdl = total_tdl;
+		u16 old_tdl = EP_CMD_TDL_GET(readl(&priv_dev->regs->ep_cmd));
+
+		if (tdl > EP_CMD_TDL_MAX) {
+			tdl = EP_CMD_TDL_MAX;
+			priv_ep->pending_tdl = total_tdl - EP_CMD_TDL_MAX;
+		}
+
+		if (old_tdl < tdl) {
+			tdl -= old_tdl;
+			writel(EP_CMD_TDL_SET(tdl) | EP_CMD_STDL,
+			       &priv_dev->regs->ep_cmd);
+		}
+	}
+
 	/*
 	 * Memory barrier - cycle bit must be set before other filds in trb.
 	 */
@@ -1145,29 +1436,56 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 		request = cdns3_next_request(&priv_ep->pending_req_list);
 		priv_req = to_cdns3_request(request);
 
-		/* Re-select endpoint. It could be changed by other CPU during
-		 * handling usb_gadget_giveback_request.
-		 */
-		cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
+		if (!request->stream_id) {
+			/* Re-select endpoint. It could be changed by other CPU
+			 * during handling usb_gadget_giveback_request.
+			 */
+			cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
+
+			if (!cdns3_request_handled(priv_ep, priv_req))
+				goto prepare_next_td;
+
+			trb = priv_ep->trb_pool + priv_ep->dequeue;
+			trace_cdns3_complete_trb(priv_ep, trb);
+
+			if (trb != priv_req->trb)
+				dev_warn(priv_dev->dev,
+					 "request_trb=0x%p, queue_trb=0x%p\n",
+					 priv_req->trb, trb);
+
+			request->actual = TRB_LEN(le32_to_cpu(trb->length));
+			cdns3_move_deq_to_next_trb(priv_req);
+			cdns3_gadget_giveback(priv_ep, priv_req, 0);
 
-		if (!cdns3_request_handled(priv_ep, priv_req))
-			goto prepare_next_td;
+			if (priv_ep->type != USB_ENDPOINT_XFER_ISOC &&
+			    TRBS_PER_SEGMENT == 2)
+				break;
+		} else {
+			/* Re-select endpoint. It could be changed by other CPU
+			 * during handling usb_gadget_giveback_request.
+			 */
+			cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
 
-		trb = priv_ep->trb_pool + priv_ep->dequeue;
-		trace_cdns3_complete_trb(priv_ep, trb);
+			trb = priv_ep->trb_pool;
+			trace_cdns3_complete_trb(priv_ep, trb);
 
-		if (trb != priv_req->trb)
-			dev_warn(priv_dev->dev,
-				 "request_trb=0x%p, queue_trb=0x%p\n",
-				 priv_req->trb, trb);
+			if (trb != priv_req->trb)
+				dev_warn(priv_dev->dev,
+					 "request_trb=0x%p, queue_trb=0x%p\n",
+					 priv_req->trb, trb);
 
-		request->actual = TRB_LEN(le32_to_cpu(trb->length));
-		cdns3_move_deq_to_next_trb(priv_req);
-		cdns3_gadget_giveback(priv_ep, priv_req, 0);
+			request->actual += TRB_LEN(le32_to_cpu(trb->length));
 
-		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC &&
-		    TRBS_PER_SEGMENT == 2)
+			if (!request->num_sgs ||
+			    (request->num_sgs == (priv_ep->stream_sg_idx + 1))) {
+				priv_ep->stream_sg_idx = 0;
+				cdns3_gadget_giveback(priv_ep, priv_req, 0);
+			} else {
+				priv_ep->stream_sg_idx++;
+				cdns3_ep_run_stream_transfer(priv_ep, request);
+			}
 			break;
+		}
 	}
 	priv_ep->flags &= ~EP_PENDING_REQUEST;
 
@@ -1197,6 +1515,21 @@ void cdns3_rearm_transfer(struct cdns3_endpoint *priv_ep, u8 rearm)
 	}
 }
 
+static void cdns3_reprogram_tdl(struct cdns3_endpoint *priv_ep)
+{
+	u16 tdl = priv_ep->pending_tdl;
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+
+	if (tdl > EP_CMD_TDL_MAX) {
+		tdl = EP_CMD_TDL_MAX;
+		priv_ep->pending_tdl -= EP_CMD_TDL_MAX;
+	} else {
+		priv_ep->pending_tdl = 0;
+	}
+
+	writel(EP_CMD_TDL_SET(tdl) | EP_CMD_STDL, &priv_dev->regs->ep_cmd);
+}
+
 /**
  * cdns3_check_ep_interrupt_proceed - Processes interrupt related to endpoint
  * @priv_ep: endpoint object
@@ -1207,6 +1540,9 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	u32 ep_sts_reg;
+	struct usb_request *deferred_request;
+	struct usb_request *pending_request;
+	u32 tdl = 0;
 
 	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
 
@@ -1215,6 +1551,36 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 	ep_sts_reg = readl(&priv_dev->regs->ep_sts);
 	writel(ep_sts_reg, &priv_dev->regs->ep_sts);
 
+	if ((ep_sts_reg & EP_STS_PRIME) && priv_ep->use_streams) {
+		bool dbusy = !!(ep_sts_reg & EP_STS_DBUSY);
+
+		tdl = cdns3_get_tdl(priv_dev);
+
+		/*
+		 * Continue the previous transfer:
+		 * There is some racing between ERDY and PRIME. The device send
+		 * ERDY and almost in the same time Host send PRIME. It cause
+		 * that host ignore the ERDY packet and driver has to send it
+		 * again.
+		 */
+		if (tdl && (dbusy | !EP_STS_BUFFEMPTY(ep_sts_reg) |
+		    EP_STS_HOSTPP(ep_sts_reg))) {
+			writel(EP_CMD_ERDY |
+			       EP_CMD_ERDY_SID(priv_ep->last_stream_id),
+			       &priv_dev->regs->ep_cmd);
+			ep_sts_reg &= ~(EP_STS_MD_EXIT | EP_STS_IOC);
+		} else {
+			priv_ep->prime_flag = true;
+
+			pending_request = cdns3_next_request(&priv_ep->pending_req_list);
+			deferred_request = cdns3_next_request(&priv_ep->deferred_req_list);
+
+			if (deferred_request && !pending_request) {
+				cdns3_start_all_request(priv_dev, priv_ep);
+			}
+		}
+	}
+
 	if (ep_sts_reg & EP_STS_TRBERR) {
 		if (priv_ep->flags & EP_STALL_PENDING &&
 		    !(ep_sts_reg & EP_STS_DESCMIS &&
@@ -1251,7 +1617,8 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 		}
 	}
 
-	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP) ||
+	    (ep_sts_reg & EP_STS_IOT)) {
 		if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
 			if (ep_sts_reg & EP_STS_ISP)
 				priv_ep->flags |= EP_QUIRK_END_TRANSFER;
@@ -1259,6 +1626,29 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 				priv_ep->flags &= ~EP_QUIRK_END_TRANSFER;
 		}
 
+		if (!priv_ep->use_streams) {
+			if ((ep_sts_reg & EP_STS_IOC) ||
+			    (ep_sts_reg & EP_STS_ISP)) {
+				cdns3_transfer_completed(priv_dev, priv_ep);
+			} else if ((priv_ep->flags & EP_TDLCHK_EN) &
+				   priv_ep->pending_tdl) {
+				/* handle IOT with pending tdl */
+				cdns3_reprogram_tdl(priv_ep);
+			}
+		} else if (priv_ep->dir == USB_DIR_OUT) {
+			priv_ep->ep_sts_pending |= ep_sts_reg;
+		} else if (ep_sts_reg & EP_STS_IOT) {
+			cdns3_transfer_completed(priv_dev, priv_ep);
+		}
+	}
+
+	/*
+	 * MD_EXIT interrupt sets when stream capable endpoint exits
+	 * from MOVE DATA state of Bulk IN/OUT stream protocol state machine
+	 */
+	if (priv_ep->dir == USB_DIR_OUT && (ep_sts_reg & EP_STS_MD_EXIT) &&
+	    (priv_ep->ep_sts_pending & EP_STS_IOT) && priv_ep->use_streams) {
+		priv_ep->ep_sts_pending = 0;
 		cdns3_transfer_completed(priv_dev, priv_ep);
 	}
 
@@ -1266,7 +1656,7 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 	 * WA2: this condition should only be meet when
 	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET or
 	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN.
-	 * In other cases this interrupt will be disabled/
+	 * In other cases this interrupt will be disabled.
 	 */
 	if (ep_sts_reg & EP_STS_DESCMIS && priv_dev->dev_ver < DEV_VER_V2 &&
 	    !(priv_ep->flags & EP_STALLED))
@@ -1454,6 +1844,9 @@ static irqreturn_t cdns3_device_thread_irq_handler(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
+	if (priv_dev->dev_ver < DEV_VER_V2 && priv_dev->using_streams)
+		cdns3_wa2_check_outq_status(priv_dev);
+
 irqend:
 	writel(~0, &priv_dev->regs->ep_ien);
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
@@ -1508,6 +1901,27 @@ static int cdns3_ep_onchip_buffer_reserve(struct cdns3_device *priv_dev,
 	return 0;
 }
 
+void cdns3_stream_ep_reconfig(struct cdns3_device *priv_dev,
+			      struct cdns3_endpoint *priv_ep)
+{
+	if (!priv_ep->use_streams || priv_dev->gadget.speed < USB_SPEED_SUPER)
+		return;
+
+	if (priv_dev->dev_ver >= DEV_VER_V3) {
+		u32 mask = BIT(priv_ep->num + (priv_ep->dir ? 16 : 0));
+
+		/*
+		 * Stream capable endpoints are handled by using ep_tdl
+		 * register. Other endpoints use TDL from TRB feature.
+		 */
+		cdns3_clear_register_bit(&priv_dev->regs->tdl_from_trb, mask);
+	}
+
+	/*  Enable Stream Bit TDL chk and SID chk */
+	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_STREAM_EN |
+			       EP_CFG_TDL_CHK | EP_CFG_SID_CHK);
+}
+
 void cdns3_configure_dmult(struct cdns3_device *priv_dev,
 			   struct cdns3_endpoint *priv_ep)
 {
@@ -1769,6 +2183,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 {
 	struct cdns3_endpoint *priv_ep;
 	struct cdns3_device *priv_dev;
+	const struct usb_ss_ep_comp_descriptor *comp_desc;
 	u32 reg = EP_STS_EN_TRBERREN;
 	u32 bEndpointAddress;
 	unsigned long flags;
@@ -1778,6 +2193,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 
 	priv_ep = ep_to_cdns3_ep(ep);
 	priv_dev = priv_ep->cdns3_dev;
+	comp_desc = priv_ep->endpoint.comp_desc;
 
 	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
 		dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
@@ -1808,6 +2224,24 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 		goto exit;
 	}
 
+	bEndpointAddress = priv_ep->num | priv_ep->dir;
+	cdns3_select_ep(priv_dev, bEndpointAddress);
+
+	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
+		/*
+		 * Enable stream support (SS mode) related interrupts
+		 * in EP_STS_EN Register
+		 */
+		if (priv_dev->gadget.speed >= USB_SPEED_SUPER) {
+			reg |= EP_STS_EN_IOTEN | EP_STS_EN_PRIMEEEN |
+				EP_STS_EN_SIDERREN | EP_STS_EN_MD_EXITEN |
+				EP_STS_EN_STREAMREN;
+			priv_ep->use_streams = true;
+			cdns3_stream_ep_reconfig(priv_dev, priv_ep);
+			priv_dev->using_streams |= true;
+		}
+	}
+
 	ret = cdns3_allocate_trb_pool(priv_ep);
 
 	if (ret)
@@ -1954,6 +2388,7 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	ep->desc = NULL;
 	priv_ep->flags &= ~EP_ENABLED;
+	priv_ep->use_streams = false;
 
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 
@@ -2002,13 +2437,21 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	list_add_tail(&request->list, &priv_ep->deferred_req_list);
 
 	/*
+	 * For stream capable endpoint if prime irq flag is set then only start
+	 * request.
 	 * If hardware endpoint configuration has not been set yet then
 	 * just queue request in deferred list. Transfer will be started in
 	 * cdns3_set_hw_configuration.
 	 */
-	if (priv_dev->hw_configured_flag && !(priv_ep->flags & EP_STALLED) &&
-	    !(priv_ep->flags & EP_STALL_PENDING))
-		cdns3_start_all_request(priv_dev, priv_ep);
+	if (!request->stream_id) {
+		if (priv_dev->hw_configured_flag &&
+		    !(priv_ep->flags & EP_STALLED) &&
+		    !(priv_ep->flags & EP_STALL_PENDING))
+			cdns3_start_all_request(priv_dev, priv_ep);
+	} else {
+		if (priv_dev->hw_configured_flag && priv_ep->prime_flag)
+			cdns3_start_all_request(priv_dev, priv_ep);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index bc4024041ef2..f003a7801872 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -599,6 +599,7 @@ struct cdns3_usb_regs {
 #define EP_CMD_TDL_MASK		GENMASK(15, 9)
 #define EP_CMD_TDL_SET(p)	(((p) << 9) & EP_CMD_TDL_MASK)
 #define EP_CMD_TDL_GET(p)	(((p) & EP_CMD_TDL_MASK) >> 9)
+#define EP_CMD_TDL_MAX		(EP_CMD_TDL_MASK >> 9)
 
 /* ERDY Stream ID value (used in SS mode). */
 #define EP_CMD_ERDY_SID_MASK	GENMASK(31, 16)
@@ -969,10 +970,18 @@ struct cdns3_usb_regs {
 
 #define ISO_MAX_INTERVAL	10
 
+#define MAX_TRB_LENGTH          BIT(16)
+
 #if TRBS_PER_SEGMENT < 2
 #error "Incorrect TRBS_PER_SEGMENT. Minimal Transfer Ring size is 2."
 #endif
 
+#define TRBS_PER_STREAM_SEGMENT 2
+
+#if TRBS_PER_STREAM_SEGMENT < 2
+#error "Incorrect TRBS_PER_STREAMS_SEGMENT. Minimal Transfer Ring size is 2."
+#endif
+
 /*
  *Only for ISOC endpoints - maximum number of TRBs is calculated as
  * pow(2, bInterval-1) * number of usb requests. It is limitation made by
@@ -1000,6 +1009,7 @@ struct cdns3_trb {
 
 #define TRB_SIZE		(sizeof(struct cdns3_trb))
 #define TRB_RING_SIZE		(TRB_SIZE * TRBS_PER_SEGMENT)
+#define TRB_STREAM_RING_SIZE	(TRB_SIZE * TRBS_PER_STREAM_SEGMENT)
 #define TRB_ISO_RING_SIZE	(TRB_SIZE * TRBS_PER_ISOC_SEGMENT)
 #define TRB_CTRL_RING_SIZE	(TRB_SIZE * 2)
 
@@ -1078,7 +1088,7 @@ struct cdns3_trb {
 #define CDNS3_ENDPOINTS_MAX_COUNT	32
 #define CDNS3_EP_ZLP_BUF_SIZE		1024
 
-#define CDNS3_EP_BUF_SIZE		2	/* KB */
+#define CDNS3_EP_BUF_SIZE		4	/* KB */
 #define CDNS3_EP_ISO_HS_MULT		3
 #define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
@@ -1109,6 +1119,7 @@ struct cdns3_device;
  * @interval: interval between packets used for ISOC endpoint.
  * @free_trbs: number of free TRBs in transfer ring
  * @num_trbs: number of all TRBs in transfer ring
+ * @alloc_ring_size: size of the allocated TRB ring
  * @pcs: producer cycle state
  * @ccs: consumer cycle state
  * @enqueue: enqueue index in transfer ring
@@ -1142,6 +1153,7 @@ struct cdns3_endpoint {
 #define EP_QUIRK_END_TRANSFER	BIT(11)
 #define EP_QUIRK_EXTRA_BUF_DET	BIT(12)
 #define EP_QUIRK_EXTRA_BUF_EN	BIT(13)
+#define EP_TDLCHK_EN		BIT(15)
 	u32			flags;
 
 	struct cdns3_request	*descmis_req;
@@ -1153,6 +1165,7 @@ struct cdns3_endpoint {
 
 	int			free_trbs;
 	int			num_trbs;
+	int			alloc_ring_size;
 	u8			pcs;
 	u8			ccs;
 	int			enqueue;
@@ -1163,6 +1176,14 @@ struct cdns3_endpoint {
 	struct cdns3_trb	*wa1_trb;
 	unsigned int		wa1_trb_index;
 	unsigned int		wa1_cycle_bit:1;
+
+	/* Stream related */
+	unsigned int		use_streams:1;
+	unsigned int		prime_flag:1;
+	u32			ep_sts_pending;
+	u16			last_stream_id;
+	u16			pending_tdl;
+	unsigned int		stream_sg_idx;
 };
 
 /**
@@ -1290,6 +1311,7 @@ struct cdns3_device {
 	int				hw_configured_flag:1;
 	int				wake_up_flag:1;
 	unsigned			status_completion_no_call:1;
+	unsigned			using_streams:1;
 	int				out_mem_is_allocated;
 
 	struct work_struct		pending_status_wq;
@@ -1310,8 +1332,6 @@ void cdns3_set_hw_configuration(struct cdns3_device *priv_dev);
 void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
 void cdns3_allow_enable_l1(struct cdns3_device *priv_dev, int enable);
 struct usb_request *cdns3_next_request(struct list_head *list);
-int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
-			  struct usb_request *request);
 void cdns3_rearm_transfer(struct cdns3_endpoint *priv_ep, u8 rearm);
 int cdns3_allocate_trb_pool(struct cdns3_endpoint *priv_ep);
 u8 cdns3_ep_addr_to_index(u8 ep_addr);
diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/trace.h
index e92348c9b4d7..8d121e207fd8 100644
--- a/drivers/usb/cdns3/trace.h
+++ b/drivers/usb/cdns3/trace.h
@@ -122,18 +122,24 @@ DECLARE_EVENT_CLASS(cdns3_log_epx_irq,
 		__string(ep_name, priv_ep->name)
 		__field(u32, ep_sts)
 		__field(u32, ep_traddr)
+		__field(u32, ep_last_sid)
+		__field(u32, use_streams)
 		__dynamic_array(char, str, CDNS3_MSG_MAX)
 	),
 	TP_fast_assign(
 		__assign_str(ep_name, priv_ep->name);
 		__entry->ep_sts = readl(&priv_dev->regs->ep_sts);
 		__entry->ep_traddr = readl(&priv_dev->regs->ep_traddr);
+		__entry->ep_last_sid = priv_ep->last_stream_id;
+		__entry->use_streams = priv_ep->use_streams;
 	),
-	TP_printk("%s, ep_traddr: %08x",
+	TP_printk("%s, ep_traddr: %08x ep_last_sid: %08x use_streams: %d",
 		  cdns3_decode_epx_irq(__get_str(str),
 				       __get_str(ep_name),
 				       __entry->ep_sts),
-		  __entry->ep_traddr)
+		  __entry->ep_traddr,
+		  __entry->ep_last_sid,
+		  __entry->use_streams)
 );
 
 DEFINE_EVENT(cdns3_log_epx_irq, cdns3_epx_irq,
@@ -210,6 +216,7 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
 		__field(int, end_trb)
 		__field(struct cdns3_trb *, start_trb_addr)
 		__field(int, flags)
+		__field(unsigned int, stream_id)
 	),
 	TP_fast_assign(
 		__assign_str(name, req->priv_ep->name);
@@ -225,9 +232,10 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
 		__entry->end_trb = req->end_trb;
 		__entry->start_trb_addr = req->trb;
 		__entry->flags = req->flags;
+		__entry->stream_id = req->request.stream_id;
 	),
 	TP_printk("%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d,"
-		  " trb: [start:%d, end:%d: virt addr %pa], flags:%x ",
+		  " trb: [start:%d, end:%d: virt addr %pa], flags:%x SID: %u",
 		__get_str(name), __entry->req, __entry->buf, __entry->actual,
 		__entry->length,
 		__entry->zero ? "Z" : "z",
@@ -237,7 +245,8 @@ DECLARE_EVENT_CLASS(cdns3_log_request,
 		__entry->start_trb,
 		__entry->end_trb,
 		__entry->start_trb_addr,
-		__entry->flags
+		__entry->flags,
+		__entry->stream_id
 	)
 );
 
@@ -281,6 +290,39 @@ TRACE_EVENT(cdns3_ep0_queue,
 		  __entry->length)
 );
 
+DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
+	TP_PROTO(struct cdns3_request *req),
+	TP_ARGS(req),
+	TP_STRUCT__entry(
+		__string(name, req->priv_ep->name)
+		__field(struct cdns3_request *, req)
+		__field(unsigned int, length)
+		__field(unsigned int, actual)
+		__field(unsigned int, stream_id)
+	),
+	TP_fast_assign(
+		__assign_str(name, req->priv_ep->name);
+		__entry->req = req;
+		__entry->actual = req->request.length;
+		__entry->length = req->request.actual;
+		__entry->stream_id = req->request.stream_id;
+	),
+	TP_printk("%s: req: %p,request length: %u actual length: %u  SID: %u",
+		  __get_str(name), __entry->req, __entry->length,
+		  __entry->actual, __entry->stream_id)
+);
+
+DEFINE_EVENT(cdns3_stream_split_transfer_len, cdns3_stream_transfer_split,
+	     TP_PROTO(struct cdns3_request *req),
+	     TP_ARGS(req)
+);
+
+DEFINE_EVENT(cdns3_stream_split_transfer_len,
+	     cdns3_stream_transfer_split_next_part,
+	     TP_PROTO(struct cdns3_request *req),
+	     TP_ARGS(req)
+);
+
 DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 	TP_PROTO(struct cdns3_request *priv_req),
 	TP_ARGS(priv_req),
@@ -319,6 +361,34 @@ DEFINE_EVENT(cdns3_log_aligned_request, cdns3_prepare_aligned_request,
 	TP_ARGS(req)
 );
 
+DECLARE_EVENT_CLASS(cdns3_log_map_request,
+	TP_PROTO(struct cdns3_request *priv_req),
+	TP_ARGS(priv_req),
+	TP_STRUCT__entry(
+		__string(name, priv_req->priv_ep->name)
+		__field(struct usb_request *, req)
+		__field(void *, buf)
+		__field(dma_addr_t, dma)
+	),
+	TP_fast_assign(
+		__assign_str(name, priv_req->priv_ep->name);
+		__entry->req = &priv_req->request;
+		__entry->buf = priv_req->request.buf;
+		__entry->dma = priv_req->request.dma;
+	),
+	TP_printk("%s: req: %p, req buf %p, dma %p",
+		  __get_str(name), __entry->req, __entry->buf, &__entry->dma
+	)
+);
+DEFINE_EVENT(cdns3_log_map_request, cdns3_map_request,
+	     TP_PROTO(struct cdns3_request *req),
+	     TP_ARGS(req)
+);
+DEFINE_EVENT(cdns3_log_map_request, cdns3_mapped_request,
+	     TP_PROTO(struct cdns3_request *req),
+	     TP_ARGS(req)
+);
+
 DECLARE_EVENT_CLASS(cdns3_log_trb,
 	TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
 	TP_ARGS(priv_ep, trb),
@@ -329,6 +399,7 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__field(u32, length)
 		__field(u32, control)
 		__field(u32, type)
+		__field(unsigned int, last_stream_id)
 	),
 	TP_fast_assign(
 		__assign_str(name, priv_ep->name);
@@ -337,8 +408,9 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__entry->length = trb->length;
 		__entry->control = trb->control;
 		__entry->type = usb_endpoint_type(priv_ep->endpoint.desc);
+		__entry->last_stream_id = priv_ep->last_stream_id;
 	),
-	TP_printk("%s: trb %p, dma buf: 0x%08x, size: %ld, burst: %d ctrl: 0x%08x (%s%s%s%s%s%s%s)",
+	TP_printk("%s: trb %p, dma buf: 0x%08x, size: %ld, burst: %d ctrl: 0x%08x (%s%s%s%s%s%s%s) SID:%lu LAST_SID:%u",
 		__get_str(name), __entry->trb, __entry->buffer,
 		TRB_LEN(__entry->length),
 		(u8)TRB_BURST_LEN_GET(__entry->length),
@@ -349,7 +421,9 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__entry->control & TRB_FIFO_MODE ? "FIFO, " : "",
 		__entry->control & TRB_CHAIN ? "CHAIN, " : "",
 		__entry->control & TRB_IOC ? "IOC, " : "",
-		TRB_FIELD_TO_TYPE(__entry->control) == TRB_NORMAL ? "Normal" : "LINK"
+		TRB_FIELD_TO_TYPE(__entry->control) == TRB_NORMAL ? "Normal" : "LINK",
+		TRB_FIELD_TO_STREAMID(__entry->control),
+		__entry->last_stream_id
 	)
 );
 
@@ -398,6 +472,7 @@ DECLARE_EVENT_CLASS(cdns3_log_ep,
 		__field(unsigned int, maxpacket)
 		__field(unsigned int, maxpacket_limit)
 		__field(unsigned int, max_streams)
+		__field(unsigned int, use_streams)
 		__field(unsigned int, maxburst)
 		__field(unsigned int, flags)
 		__field(unsigned int, dir)
@@ -409,16 +484,18 @@ DECLARE_EVENT_CLASS(cdns3_log_ep,
 		__entry->maxpacket = priv_ep->endpoint.maxpacket;
 		__entry->maxpacket_limit = priv_ep->endpoint.maxpacket_limit;
 		__entry->max_streams = priv_ep->endpoint.max_streams;
+		__entry->use_streams = priv_ep->use_streams;
 		__entry->maxburst = priv_ep->endpoint.maxburst;
 		__entry->flags = priv_ep->flags;
 		__entry->dir = priv_ep->dir;
 		__entry->enqueue = priv_ep->enqueue;
 		__entry->dequeue = priv_ep->dequeue;
 	),
-	TP_printk("%s: mps: %d/%d. streams: %d, burst: %d, enq idx: %d, "
-		  "deq idx: %d, flags %s%s%s%s%s%s%s%s, dir: %s",
+	TP_printk("%s: mps: %d/%d. streams: %d, stream enable: %d, burst: %d, "
+		  "enq idx: %d, deq idx: %d, flags %s%s%s%s%s%s%s%s, dir: %s",
 		__get_str(name), __entry->maxpacket,
 		__entry->maxpacket_limit, __entry->max_streams,
+		__entry->use_streams,
 		__entry->maxburst, __entry->enqueue,
 		__entry->dequeue,
 		__entry->flags & EP_ENABLED ? "EN | " : "",
-- 
2.20.1

