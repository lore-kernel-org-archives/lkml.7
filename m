Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738DA2189D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MFRIOOuz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nvkHmUoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfHZLUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:54 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37148 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730672AbfHZLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBHkR5027355;
        Mon, 26 Aug 2019 04:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=FjSXBjyH6koSTLtPPlZSOYmu/GdyomvrNMPPs4J3C/w=;
 b=MFRIOOuzAmu61d3RXiwWUIALeILe3aazONNdaTAK+oUaDN0G+QrDkLkAXW+jwfKUc+3W
 hbCvtB48QmjR9C3Zfis/l/xRIEWl6NOd48fhfyUxGKrIvmkRtefTQRwyP4aRUbBjOEHE
 ZpAa8hX+3ivcClMCy7/sxL3N04zA/jWDGSnLTKXsdULL/0WXMqfMO0vFaaZEQSyRGu4R
 sK+4xyiC4UOSgGGHRn42yVyODeKa2u+moiv5AN1Bu7MKxeHcUWlsOFM5dN/SeJlvKuB8
 YNgGh2HOHkCOl82rmaOKRDvRuxgML0ROhFLm1WjBhXbwhnLEx6kCb9+HWKBObkemMJvr wg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2uk28kx08x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAPhVY3GWH1302Z+9j4FzFhpKL6e5tz6uJmUxqJv5IChbb8RMvsKON6QEoOPDKvPHXpFbCCfyWFD6O+qHIUQGuVEbwruOR4gxG5xVHqiYIf5eVW48Rx+xW17DZ3xFR91SoqHj54CJPiTHtl9bU24I4l4ChZmcyIWNGVzDaVSfehsR+9fluc9iZPZPWOt/cqnzk+6KaVnY/mdWNEy8fY6DmF/fUfwktqy8PSAP7/CjHYX0qV0J4+M2NqtifC96uyNFJE36dHNuq81rNSEFx4CQZAPMy2gFbQYdifkonJpvADNHJDCJghsDRJlAumrTSfIMOWXgh1h6xNc+aBO9+T10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjSXBjyH6koSTLtPPlZSOYmu/GdyomvrNMPPs4J3C/w=;
 b=CibMZUo0meGnxp8AOzvF3RpF+6ljM3HFsCXDsK3tKXBKVNMR55INrWCFwZrPocVhX/rQZPA3BlwWZm88rfmzRJ90CHegO0axvJ9mjXEI2P323fXcqaj+KP/nMiCvpMEK7zm0VveAVL/+criwf6Z1xHmPZjKWBKObwsc6TMACEivCA1hAX1YRBoF/vbEnnO/Lz9CqLcnMHKblWzHDXD7MAeGaTs4/Z30TZSq87/Hu799AFghjMVl0biTsTDW+84qs0YwdFWsxXBxnU/Lak/ie1nANTzrW6wGnqFcDBzOrYr93p041DVjW4jG6Tk7Jxl+LV/m7ARxZeA6Oj10+eZsNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjSXBjyH6koSTLtPPlZSOYmu/GdyomvrNMPPs4J3C/w=;
 b=nvkHmUoaaBHALJbmK/NuE0o7iBWkZtnjLOY9HG3ZfQIS6jvKlHjrqopSzTRGvJIjmM1gncAm9/e6a5NZU/8YB/IH3NSNmU9GDKrm9p+d+H8EIJ47UeDDDNbNY4YbjNcPhR7eieUZWrQ/OcJh0gw5OyJxn7bfGJcUwefWhlkBolg=
Received: from BYAPR07CA0085.namprd07.prod.outlook.com (2603:10b6:a03:12b::26)
 by CY1PR07MB2474.namprd07.prod.outlook.com (2a01:111:e400:c613::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Mon, 26 Aug
 2019 11:20:16 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by BYAPR07CA0085.outlook.office365.com
 (2603:10b6:a03:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:16 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WV001206
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 26 Aug 2019 04:20:14 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 26 Aug 2019 13:20:11 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 13:20:11 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBKAnP029122;
        Mon, 26 Aug 2019 12:20:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBKAN8029121;
        Mon, 26 Aug 2019 12:20:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
Date:   Mon, 26 Aug 2019 12:19:31 +0100
Message-ID: <1566818371-27721-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1566818371-27721-1-git-send-email-pawell@cadence.com>
References: <1566818371-27721-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(199004)(189003)(36092001)(7416002)(426003)(476003)(2616005)(11346002)(126002)(316002)(486006)(50466002)(186003)(42186006)(336012)(86362001)(16586007)(30864003)(48376002)(7636002)(305945005)(446003)(50226002)(478600001)(47776003)(8676002)(6666004)(6916009)(356004)(87636003)(14444005)(76176011)(26826003)(2906002)(4326008)(70586007)(70206006)(54906003)(5660300002)(26005)(76130400001)(2351001)(36756003)(8936002)(4720700003)(51416003)(246002)(107886003)(414714003)(473944003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2474;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fa6e949-7ee8-44e4-a6d9-08d72a175ed9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328);SRVR:CY1PR07MB2474;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2474:
X-Microsoft-Antispam-PRVS: <CY1PR07MB24744C032B5AB325D9F37E0EDDA10@CY1PR07MB2474.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XswJ5Tbk9cIyocGc6Fdfb0Opi3CBu/LZZO7iFBq/+H0f7KbjjVC02vX9TdQM1ZoBEwHbSKGfVjtTbqQl2faral5vLv1POcWBvTlD2YTqJnFuBB5E2j+1J1KGsSZ6JS0AvbJoIVtjzTlLLhGiaH4w1RK5WD/sX8ESvzCs4kDy5NgoFt3loRKDVRFV5Xf26E1riSZKhjsRaPMGO0O97SS5M3x1PMnvcUE0NcYf+ooQSf9uxcYP+RGeZLwFP2N123fuwKLQVqiAsqum62XlEAPXHdmFY36A7gGPwRvKpj44RZvZAmN8s3mefTN7JjN/PZsYLQuG92+WVf50+93p/mcmKn8fxZ8ruZy0TOmR1b97cHHbVTH8ssjNRO+q8o64/Qzy5ryaIg1DXbstkci4qJX65rsywsGiJqvKBWc53JT8DNA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:15.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa6e949-7ee8-44e4-a6d9-08d72a175ed9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2474
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=3 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908260126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller for OUT endpoints has shared on-chip buffers for all incoming
packets, including ep0out. It's FIFO buffer, so packets must be handled
by DMA in correct order. If the first packet in the buffer will not be
handled, then the following packets directed for other endpoints and
functions will be blocked.

Additionally the packets directed to one endpoint can block entire on-chip
buffers. In this case transfer to other endpoints also will blocked.

To resolve this issue after raising the descriptor missing interrupt
driver prepares internal usb_request object and use it to arm DMA
transfer.

The problematic situation was observed in case when endpoint has
been enabled but no usb_request were queued. Driver try detects
such endpoints and will use this workaround only for these endpoint.

Driver use limited number of buffer. This number can be set by macro
CDNS_WA2_NUM_BUFFERS.

Such blocking situation was observed on ACM gadget. For this function
host send OUT data packet but ACM function is not prepared for
this packet. It's cause that buffer placed in on chip memory block
transfer to other endpoints.

Issue has been fixed for DEV_VER_V2 version of controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 339 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |  13 ++
 2 files changed, 350 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 49ba253d81be..3094ad65ffc9 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -28,6 +28,32 @@
  *
  * Issue has been fixed in DEV_VER_V3 version of controller.
  *
+ * Work around 2:
+ * Controller for OUT endpoints has shared on-chip buffers for all incoming
+ * packets, including ep0out. It's FIFO buffer, so packets must be handle by DMA
+ * in correct order. If the first packet in the buffer will not be handled,
+ * then the following packets directed for other endpoints and  functions
+ * will be blocked.
+ * Additionally the packets directed to one endpoint can block entire on-chip
+ * buffers. In this case transfer to other endpoints also will blocked.
+ *
+ * To resolve this issue after raising the descriptor missing interrupt
+ * driver prepares internal usb_request object and use it to arm DMA transfer.
+ *
+ * The problematic situation was observed in case when endpoint has been enabled
+ * but no usb_request were queued. Driver try detects such endpoints and will
+ * use this workaround only for these endpoint.
+ *
+ * Driver use limited number of buffer. This number can be set by macro
+ * CDNS3_WA2_NUM_BUFFERS.
+ *
+ * Such blocking situation was observed on ACM gadget. For this function
+ * host send OUT data packet but ACM function is not prepared for this packet.
+ * It's cause that buffer placed in on chip memory block transfer to other
+ * endpoints.
+ *
+ * Issue has been fixed in DEV_VER_V2 version of controller.
+ *
  */
 
 #include <linux/dma-mapping.h>
@@ -99,6 +125,17 @@ struct cdns3_aligned_buf *cdns3_next_align_buf(struct list_head *list)
 	return list_first_entry_or_null(list, struct cdns3_aligned_buf, list);
 }
 
+/**
+ * cdns3_next_priv_request - returns next request from list
+ * @list: list containing requests
+ *
+ * Returns request or NULL if no requests in list
+ */
+struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct cdns3_request, list);
+}
+
 /**
  * select_ep - selects endpoint
  * @priv_dev:  extended gadget object
@@ -338,6 +375,254 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 	return ret;
 }
 
+/*
+ * WA2: Set flag for all not ISOC OUT endpoints. If this flag is set
+ * driver try to detect whether endpoint need additional internal
+ * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
+ * if before first DESCMISS interrupt the DMA will be armed.
+ */
+#define cdns3_wa2_enable_detection(priv_dev, ep_priv, reg) do { \
+	if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) { \
+		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET; \
+		(reg) |= EP_STS_EN_DESCMISEN; \
+	} } while (0)
+
+/**
+ * cdns3_wa2_descmiss_copy_data copy data from internal requests to
+ * request queued by class driver.
+ * @priv_ep: extended endpoint object
+ * @request: request object
+ */
+static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
+					 struct usb_request *request)
+{
+	struct usb_request *descmiss_req;
+	struct cdns3_request *descmiss_priv_req;
+
+	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
+		int chunk_end;
+		int length;
+
+		descmiss_priv_req =
+			cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		descmiss_req = &descmiss_priv_req->request;
+
+		/* driver can't touch pending request */
+		if (descmiss_priv_req->flags & REQUEST_PENDING)
+			break;
+
+		chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
+		length = request->actual + descmiss_req->actual;
+
+		request->status = descmiss_req->status;
+
+		if (length <= request->length) {
+			memcpy(&((u8 *)request->buf)[request->actual],
+			       descmiss_req->buf,
+			       descmiss_req->actual);
+			request->actual = length;
+		} else {
+			/* It should never occures */
+			request->status = -ENOMEM;
+		}
+
+		list_del_init(&descmiss_priv_req->list);
+
+		kfree(descmiss_req->buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, descmiss_req);
+		--priv_ep->wa2_counter;
+
+		if (!chunk_end)
+			break;
+	}
+}
+
+struct usb_request *cdns3_wa2_gadget_giveback(struct cdns3_device *priv_dev,
+					      struct cdns3_endpoint *priv_ep,
+					      struct cdns3_request *priv_req)
+{
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN &&
+	    priv_req->flags & REQUEST_INTERNAL) {
+		struct usb_request *req;
+
+		req = cdns3_next_request(&priv_ep->deferred_req_list);
+
+		priv_ep->descmis_req = NULL;
+
+		if (!req)
+			return NULL;
+
+		cdns3_wa2_descmiss_copy_data(priv_ep, req);
+		if (!(priv_ep->flags & EP_QUIRK_END_TRANSFER) &&
+		    req->length != req->actual) {
+			/* wait for next part of transfer */
+			return NULL;
+		}
+
+		if (req->status == -EINPROGRESS)
+			req->status = 0;
+
+		list_del_init(&req->list);
+		cdns3_start_all_request(priv_dev, priv_ep);
+		return req;
+	}
+
+	return &priv_req->request;
+}
+
+int cdns3_wa2_gadget_ep_queue(struct cdns3_device *priv_dev,
+			      struct cdns3_endpoint *priv_ep,
+			      struct cdns3_request *priv_req)
+{
+	int deferred = 0;
+
+	/*
+	 * If transfer was queued before DESCMISS appear than we
+	 * can disable handling of DESCMISS interrupt. Driver assumes that it
+	 * can disable special treatment for this endpoint.
+	 */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		u32 reg;
+
+		cdns3_select_ep(priv_dev, priv_ep->num | priv_ep->dir);
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		reg = readl(&priv_dev->regs->ep_sts_en);
+		reg &= ~EP_STS_EN_DESCMISEN;
+		trace_cdns3_wa2(priv_ep, "workaround disabled\n");
+		writel(reg, &priv_dev->regs->ep_sts_en);
+	}
+
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+		u8 pending_empty = list_empty(&priv_ep->pending_req_list);
+		u8 descmiss_empty = list_empty(&priv_ep->wa2_descmiss_req_list);
+
+		/*
+		 *  DESCMISS transfer has been finished, so data will be
+		 *  directly copied from internal allocated usb_request
+		 *  objects.
+		 */
+		if (pending_empty && !descmiss_empty &&
+		    !(priv_req->flags & REQUEST_INTERNAL)) {
+			cdns3_wa2_descmiss_copy_data(priv_ep,
+						     &priv_req->request);
+
+			trace_cdns3_wa2(priv_ep, "get internal stored data");
+
+			list_add_tail(&priv_req->request.list,
+				      &priv_ep->pending_req_list);
+			cdns3_gadget_giveback(priv_ep, priv_req,
+					      priv_req->request.status);
+
+			/*
+			 * Intentionally driver returns positive value as
+			 * correct value. It informs that transfer has
+			 * been finished.
+			 */
+			return EINPROGRESS;
+		}
+
+		/*
+		 * Driver will wait for completion DESCMISS transfer,
+		 * before starts new, not DESCMISS transfer.
+		 */
+		if (!pending_empty && !descmiss_empty) {
+			trace_cdns3_wa2(priv_ep, "wait for pending transfer\n");
+			deferred = 1;
+		}
+
+		if (priv_req->flags & REQUEST_INTERNAL)
+			list_add_tail(&priv_req->list,
+				      &priv_ep->wa2_descmiss_req_list);
+	}
+
+	return deferred;
+}
+
+static void cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_request *priv_req;
+
+	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
+		u8 chain;
+
+		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		chain = !!(priv_req->flags & REQUEST_INTERNAL_CH);
+
+		trace_cdns3_wa2(priv_ep, "removes eldest request");
+
+		kfree(priv_req->request.buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
+					     &priv_req->request);
+		list_del_init(&priv_req->list);
+		--priv_ep->wa2_counter;
+
+		if (!chain)
+			break;
+	}
+}
+
+/**
+ * cdns3_wa2_descmissing_packet - handles descriptor missing event.
+ * @priv_dev: extended gadget object
+ *
+ * This function is used only for WA2. For more information see Work around 2
+ * description.
+ */
+static void cdns3_wa2_descmissing_packet(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_request *priv_req;
+	struct usb_request *request;
+
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_EN;
+	}
+
+	trace_cdns3_wa2(priv_ep, "Description Missing detected\n");
+
+	if (priv_ep->wa2_counter >= CDNS3_WA2_NUM_BUFFERS)
+		cdns3_wa2_remove_old_request(priv_ep);
+
+	request = cdns3_gadget_ep_alloc_request(&priv_ep->endpoint,
+						GFP_ATOMIC);
+	if (!request)
+		goto err;
+
+	priv_req = to_cdns3_request(request);
+	priv_req->flags |= REQUEST_INTERNAL;
+
+	/* if this field is still assigned it indicate that transfer related
+	 * with this request has not been finished yet. Driver in this
+	 * case simply allocate next request and assign flag REQUEST_INTERNAL_CH
+	 * flag to previous one. It will indicate that current request is
+	 * part of the previous one.
+	 */
+	if (priv_ep->descmis_req)
+		priv_ep->descmis_req->flags |= REQUEST_INTERNAL_CH;
+
+	priv_req->request.buf = kzalloc(CDNS3_DESCMIS_BUF_SIZE,
+					GFP_ATOMIC);
+	priv_ep->wa2_counter++;
+
+	if (!priv_req->request.buf) {
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
+		goto err;
+	}
+
+	priv_req->request.length = CDNS3_DESCMIS_BUF_SIZE;
+	priv_ep->descmis_req = priv_req;
+
+	__cdns3_gadget_ep_queue(&priv_ep->endpoint,
+				&priv_ep->descmis_req->request,
+				GFP_ATOMIC);
+
+	return;
+
+err:
+	dev_err(priv_ep->cdns3_dev->dev,
+		"Failed: No sufficient memory for DESCMIS\n");
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
@@ -371,6 +656,13 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
 	trace_cdns3_gadget_giveback(priv_req);
 
+	if (priv_dev->dev_ver < DEV_VER_V2) {
+		request = cdns3_wa2_gadget_giveback(priv_dev, priv_ep,
+						    priv_req);
+		if (!request)
+			return;
+	}
+
 	if (request->complete) {
 		spin_unlock(&priv_dev->lock);
 		usb_gadget_giveback_request(&priv_ep->endpoint,
@@ -961,8 +1253,26 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 		}
 	}
 
-	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP))
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+		if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+			if (ep_sts_reg & EP_STS_ISP)
+				priv_ep->flags |= EP_QUIRK_END_TRANSFER;
+			else
+				priv_ep->flags &= ~EP_QUIRK_END_TRANSFER;
+		}
+
 		cdns3_transfer_completed(priv_dev, priv_ep);
+	}
+
+	/*
+	 * WA2: this condition should only be meet when
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET or
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN.
+	 * In other cases this interrupt will be disabled/
+	 */
+	if (ep_sts_reg & EP_STS_DESCMIS && priv_dev->dev_ver < DEV_VER_V2 &&
+	    !(priv_ep->flags & EP_STALLED))
+		cdns3_wa2_descmissing_packet(priv_ep);
 
 	return 0;
 }
@@ -1526,6 +1836,9 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
 			       BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
 
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		cdns3_wa2_enable_detection(priv_dev, priv_ep, reg);
+
 	writel(reg, &priv_dev->regs->ep_sts_en);
 
 	/*
@@ -1544,7 +1857,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 
 	ep->desc = desc;
 	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALLED | EP_STALL_PENDING |
-			    EP_QUIRK_ISO_OUT_EN);
+			    EP_QUIRK_ISO_OUT_EN | EP_QUIRK_EXTRA_BUF_EN);
 	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
 	priv_ep->wa1_set = 0;
 	priv_ep->enqueue = 0;
@@ -1569,6 +1882,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct cdns3_endpoint *priv_ep;
+	struct cdns3_request *priv_req;
 	struct cdns3_device *priv_dev;
 	struct usb_request *request;
 	unsigned long flags;
@@ -1621,6 +1935,16 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 				      -ESHUTDOWN);
 	}
 
+	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
+		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+
+		kfree(priv_req->request.buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
+					     &priv_req->request);
+		list_del_init(&priv_req->list);
+		--priv_ep->wa2_counter;
+	}
+
 	while (!list_empty(&priv_ep->deferred_req_list)) {
 		request = cdns3_next_request(&priv_ep->deferred_req_list);
 
@@ -1628,6 +1952,8 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 				      -ESHUTDOWN);
 	}
 
+	priv_ep->descmis_req = NULL;
+
 	ep->desc = NULL;
 	priv_ep->flags &= ~EP_ENABLED;
 
@@ -1658,6 +1984,14 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	priv_req = to_cdns3_request(request);
 	trace_cdns3_ep_queue(priv_req);
 
+	if (priv_dev->dev_ver < DEV_VER_V2) {
+		ret = cdns3_wa2_gadget_ep_queue(priv_dev, priv_ep,
+						priv_req);
+
+		if (ret == EINPROGRESS)
+			return 0;
+	}
+
 	ret = cdns3_prepare_aligned_request_buf(priv_req);
 	if (ret < 0)
 		return ret;
@@ -2163,6 +2497,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		INIT_LIST_HEAD(&priv_ep->pending_req_list);
 		INIT_LIST_HEAD(&priv_ep->deferred_req_list);
+		INIT_LIST_HEAD(&priv_ep->wa2_descmiss_req_list);
 	}
 
 	return 0;
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index a4652d2e9bf9..bc4024041ef2 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1083,6 +1083,7 @@ struct cdns3_trb {
 #define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
+#define CDNS3_WA2_NUM_BUFFERS		128
 /*-------------------------------------------------------------------------*/
 /* Used structs */
 
@@ -1093,11 +1094,15 @@ struct cdns3_device;
  * @endpoint: usb endpoint
  * @pending_req_list: list of requests queuing on transfer ring.
  * @deferred_req_list: list of requests waiting for queuing on transfer ring.
+ * @wa2_descmiss_req_list: list of requests internally allocated by driver.
  * @trb_pool: transfer ring - array of transaction buffers
  * @trb_pool_dma: dma address of transfer ring
  * @cdns3_dev: device associated with this endpoint
  * @name: a human readable name e.g. ep1out
  * @flags: specify the current state of endpoint
+ * @descmis_req: internal transfer object used for getting data from on-chip
+ *     buffer. It can happen only if function driver doesn't send usb_request
+ *     object on time.
  * @dir: endpoint direction
  * @num: endpoint number (1 - 15)
  * @type: set to bmAttributes & USB_ENDPOINT_XFERTYPE_MASK
@@ -1114,6 +1119,8 @@ struct cdns3_endpoint {
 	struct usb_ep		endpoint;
 	struct list_head	pending_req_list;
 	struct list_head	deferred_req_list;
+	struct list_head	wa2_descmiss_req_list;
+	int			wa2_counter;
 
 	struct cdns3_trb	*trb_pool;
 	dma_addr_t		trb_pool_dma;
@@ -1132,8 +1139,13 @@ struct cdns3_endpoint {
 #define EP_CLAIMED		BIT(8)
 #define EP_DEFERRED_DRDY	BIT(9)
 #define EP_QUIRK_ISO_OUT_EN	BIT(10)
+#define EP_QUIRK_END_TRANSFER	BIT(11)
+#define EP_QUIRK_EXTRA_BUF_DET	BIT(12)
+#define EP_QUIRK_EXTRA_BUF_EN	BIT(13)
 	u32			flags;
 
+	struct cdns3_request	*descmis_req;
+
 	u8			dir;
 	u8			num;
 	u8			type;
@@ -1181,6 +1193,7 @@ struct cdns3_aligned_buf {
  * @aligned_buf: object holds information about aligned buffer associated whit
  *               this endpoint
  * @flags: flag specifying special usage of request
+ * @list: used by internally allocated request to add to wa2_descmiss_req_list.
  */
 struct cdns3_request {
 	struct usb_request		request;
-- 
2.17.1

