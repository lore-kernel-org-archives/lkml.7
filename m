Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6EAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E120854
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JyPekxMl";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ULQ0LE4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfDJFQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:16:06 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48008 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfDJFP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:15:57 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A5BaYc011870;
        Tue, 9 Apr 2019 22:15:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=xtLoXSnF7CxYZ6D9iQJNyKusO6MIK1J25Zbpwf17EWQ=;
 b=JyPekxMlL7PwAemkTRCoBK9ppxWUVD1RqozYml3whGzlIcBa7u7mvlMomPiD0yXnpmEb
 zBRMZOiGeAO56iypkql8uQ8soUNh7OKXJt5K8/TCslHlXSKsgn6wTgxBPu3EBL+VB6op
 WHWL4LavxjKv/3zO3qc2H/Lyui4DTfZseR8sw0ssvuw10oNGMkdqhhKEWnD4Z1qaITJx
 s/mrQFjuixFM2RaST/VYP9g9HRrf8IucS1eNhud74rmdx+WXLk+vJhaJLK0/CcNs36iB
 /VAvd4s7orcRX3Xy9xR9eiht1I2ltlyFJxWttLTsFiG2SfGuilC4IbNvK2QtBmLNgnbb XQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2rr9dfytdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 22:15:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtLoXSnF7CxYZ6D9iQJNyKusO6MIK1J25Zbpwf17EWQ=;
 b=ULQ0LE4DbL7DCs0MIREUVNGBQreHmEWY8eLZ79UzJ2R/1T5n++wtluryzQxw4plGVLG0PY/wLNBqGO1A2QC45IfurxL8y2uRbqo+5zLDGKbQZa5TfADV5N5PtMLcaXuPInFU3atvfqyr0EceBlTS7zqAivQiYuUIoivNp9md6ks=
Received: from CY1PR07CA0014.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::24) by BYAPR07MB5909.namprd07.prod.outlook.com
 (2603:10b6:a03:131::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.19; Wed, 10 Apr
 2019 05:15:34 +0000
Received: from CO1NAM05FT014.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::202) by CY1PR07CA0014.outlook.office365.com
 (2a01:111:e400:c60a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Wed, 10 Apr 2019 05:15:34 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT014.mail.protection.outlook.com (10.152.96.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1792.7 via Frontend Transport; Wed, 10 Apr 2019 05:15:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FQQC012370
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 9 Apr 2019 22:15:33 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 10 Apr 2019 07:15:27 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 10 Apr 2019 07:15:27 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FR22017354;
        Wed, 10 Apr 2019 06:15:27 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x3A5FRou017352;
        Wed, 10 Apr 2019 06:15:27 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
Date:   Wed, 10 Apr 2019 06:15:02 +0100
Message-ID: <1554873302-5624-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1554873302-5624-1-git-send-email-pawell@cadence.com>
References: <1554873302-5624-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(36092001)(189003)(199004)(305945005)(42186006)(76130400001)(446003)(16586007)(7636002)(2906002)(87636003)(51416003)(86362001)(8676002)(26826003)(5660300002)(30864003)(2351001)(6666004)(8936002)(50226002)(356004)(54906003)(48376002)(14444005)(4720700003)(486006)(246002)(107886003)(6916009)(105596002)(336012)(7416002)(11346002)(47776003)(478600001)(316002)(26005)(2616005)(426003)(186003)(476003)(126002)(36756003)(76176011)(50466002)(106466001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5909;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3582ef2a-84b7-4e65-fd99-08d6bd738f43
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:BYAPR07MB5909;
X-MS-TrafficTypeDiagnostic: BYAPR07MB5909:
X-Microsoft-Antispam-PRVS: <BYAPR07MB59095D95F0B08B1FA659C240DD2E0@BYAPR07MB5909.namprd07.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bLBwQX3dz7NbqW5GNzJ6XnIM6H883csXZ2rGj8bKEe1hHnaysYlR8GVX/a8HLiPei2nTAUpH4C9yfmCCOH3g1jHOluIbOH4PmKwSSdwwC/GqpsysdNW8akGfN9gyLEixm/E8KwDJ1TBOO2buOjFoGA5cqS3qCB7BIgIJ5SQXbPQBpYSf9LLEgmxsBxvSbOxPMyU/UM1+q9SsLWfslwlH9e0bWVThXAtAYbZhmDPTbflSNksPeSJlGkBM+ZLcwG/sV1aWBBpkMw6bOwUzILfisnwcSIjVno6Cl+J0PWK05Ahd7O18PTfE7q9BL31p75OFI8DWVadfA/dP4ti8+bF9UDLNSSE4BbXf0yQuVth14bvSjToF3SrNu+YMmzt4vLVYH9kuW+p5U1v/hfSH64Bg226sdRzBrVEUT8Fysbr32/Q=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 05:15:33.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3582ef2a-84b7-4e65-fd99-08d6bd738f43
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5909
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100037
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
 drivers/usb/cdns3/gadget.c | 316 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   9 +-
 2 files changed, 322 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 71569c9cf264..be7bf12f700e 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -28,6 +28,32 @@
  *
  * Issue has been fixed for DEV_VER_V2 version of controller.
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
+ * Issue has been fixed for DEV_VER_V2 version of controller.
+ *
  */
 
 #include <linux/dma-mapping.h>
@@ -87,6 +113,17 @@ struct cdns3_aligned_buf *cdns3_next_align_buf(struct list_head *list)
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
@@ -324,6 +361,237 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 	return ret;
 }
 
+/*
+ * WA2: Set flag for all not ISOC OUT endpoints. If this flag is set
+ * driver try to detect whether endpoint need additional internal
+ * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
+ * if before firet DESCMISS interrupt the DMA will be armed.
+ */
+#define cdns3_wa2_enable_detection(priv_dev, ep_priv, reg) do { \
+	if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) { \
+		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET; \
+		(reg) |= EP_STS_EN_DESCMISEN; \
+	} while(0)
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
+			list_add_tail(&priv_req->request.list,
+				      &priv_ep->pending_req_list);
+			cdns3_gadget_giveback(priv_ep, priv_req,
+					      priv_req->request.status);
+			return deferred;
+		}
+
+		/*
+		 * Driver will wait for completion DESCMISS transfer,
+		 * before starts new, not DESCMISS transfer.
+		 */
+		if (!pending_empty && !descmiss_empty)
+			deferred = 1;
+
+		if (priv_req->flags & REQUEST_INTERNAL)
+			list_add_tail(&priv_req->list,
+				      &priv_ep->wa2_descmiss_req_list);
+	}
+
+	return deferred;
+}
+
+static void cdsn3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_request *priv_req;
+
+	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
+		u8 chain;
+
+		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		chain = !!(priv_req->flags & REQUEST_INTERNAL_CH);
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
+	cdns3_dbg(priv_ep->cdns3_dev, "WA2: Description Missing detected\n");
+
+	if (priv_ep->wa2_counter >= CDNS3_WA2_NUM_BUFFERS)
+		cdsn3_wa2_remove_old_request(priv_ep);
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
@@ -357,6 +625,13 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	priv_req->flags &= ~(REQUEST_PENDING | REQUEST_UNALIGNED);
 	trace_cdns3_gadget_giveback(priv_req);
 
+	if (priv_dev->dev_ver < DEV_VER_V2) {
+		request = cdns3_wa2_gadget_giveback(priv_dev, priv_ep,
+						    priv_req);
+		if (!request)
+			return;
+	}
+
 	/* Start all not pending request */
 	if (priv_ep->flags & EP_RING_FULL)
 		cdns3_start_all_request(priv_dev, priv_ep);
@@ -844,8 +1119,25 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 			cdns3_rearm_transfer(priv_ep, priv_ep->wa1_set);
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
+	if (ep_sts_reg & EP_STS_DESCMIS && priv_dev->dev_ver < DEV_VER_V2)
+		cdns3_wa2_descmissing_packet(priv_ep);
 
 	return 0;
 }
@@ -1344,12 +1636,16 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
 			       BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
 
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		cdns3_wa2_enable_detection(priv_dev, priv_ep, reg);
+
 	writel(reg, &priv_dev->regs->ep_sts_en);
 
 	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
 
 	ep->desc = desc;
-	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL);
+	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL |
+			    EP_QUIRK_EXTRA_BUF_EN);
 	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
 	priv_ep->wa1_set = 0;
 	priv_ep->enqueue = 0;
@@ -1374,6 +1670,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct cdns3_endpoint *priv_ep;
+	struct cdns3_request *priv_req;
 	struct cdns3_device *priv_dev;
 	struct usb_request *request;
 	unsigned long flags;
@@ -1413,6 +1710,16 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
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
 
@@ -1453,6 +1760,10 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	priv_req = to_cdns3_request(request);
 	trace_cdns3_ep_queue(priv_req);
 
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		deferred = cdns3_wa2_gadget_ep_queue(priv_dev, priv_ep,
+						     priv_req);
+
 	ret = cdns3_prepare_aligned_request_buf(priv_req);
 	if (ret < 0)
 		return ret;
@@ -1894,6 +2205,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		INIT_LIST_HEAD(&priv_ep->pending_req_list);
 		INIT_LIST_HEAD(&priv_ep->deferred_req_list);
+		INIT_LIST_HEAD(&priv_ep->wa2_descmiss_req_list);
 	}
 
 	return 0;
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 8a665bc07299..c3679c472483 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1040,6 +1040,7 @@ struct cdns3_trb {
 #define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
+#define CDNS3_WA2_NUM_BUFFERS		128
 /*-------------------------------------------------------------------------*/
 /* Used structs */
 
@@ -1050,6 +1051,7 @@ struct cdns3_device;
  * @endpoint: usb endpoint
  * @pending_req_list: list of requests queuing on transfer ring.
  * @deferred_req_list: list of requests waiting for queuing on transfer ring.
+ * @wa2_descmiss_req_list: list of requests internally allocated by driver.
  * @trb_pool: transfer ring - array of transaction buffers
  * @trb_pool_dma: dma address of transfer ring
  * @cdns3_dev: device associated with this endpoint
@@ -1074,6 +1076,8 @@ struct cdns3_endpoint {
 	struct usb_ep		endpoint;
 	struct list_head	pending_req_list;
 	struct list_head	deferred_req_list;
+	struct list_head	wa2_descmiss_req_list;
+	int			wa2_counter;
 
 	struct cdns3_trb	*trb_pool;
 	dma_addr_t		trb_pool_dma;
@@ -1089,6 +1093,9 @@ struct cdns3_endpoint {
 #define EP_PENDING_REQUEST	BIT(5)
 #define EP_RING_FULL		BIT(6)
 #define EP_CLAIMED		BIT(7)
+#define EP_QUIRK_EXTRA_BUF_DET	BIT(8)
+#define EP_QUIRK_EXTRA_BUF_EN	BIT(9)
+#define EP_QUIRK_END_TRANSFER	BIT(10)
 
 	u32			flags;
 
@@ -1141,7 +1148,7 @@ struct cdns3_aligned_buf {
  * @aligned_buf: object holds information about aligned buffer associated whit
  *               this endpoint
  * @flags: flag specifying special usage of request
- * @list: used by internally allocated request to add to descmiss_req_list.
+ * @list: used by internally allocated request to add to wa2_descmiss_req_list.
  */
 struct cdns3_request {
 	struct usb_request		request;
-- 
2.17.1

