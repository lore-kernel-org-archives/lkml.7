Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551EFC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169442083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="t0ASxXzO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jMYLHRbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfGUSdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:33:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58566 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbfGUSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:33:10 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LIVsoJ007161;
        Sun, 21 Jul 2019 11:33:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DORWcsGccgQUpAp9+GJy6ah0kMstAWJjJLiT1OEd6ps=;
 b=t0ASxXzOEMQzynDyB15Z6B+GqlHjHQ/Om0YlweCvrVS06u5OjlooxPTGPHgRN3SmC4mH
 nAPbPc1SzO5Qqd/DgYqbnNCwFPSgsOGwRvxpbGu80pU6d4wZfwutHsSy74V4CSl/w/RN
 tp0/UWLc8q6WM4E7ChXLJtQLKV0A3wC0NmhgbrrCfeaoYIz1rHt2E8lZp6RudCyUC6io
 7ym+tIEtOTlGQ1zLi6wwk9TbnDZySjKUeqqIKp/Q8REvIxj6D8nJcJaI9ey0rbil0wUn
 xUUoRW/+4Iz0rPGYzZs08pcdhPMB/e+950o/DS8N6lCo0Mdm/RX/Vb1FSmS2mPa5D2Vr 3Q== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tuygwkrqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 11:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip9YwohcuENCSJiVXYU6qd7+1S7pjk0UqsUhY5ZEnrTjhWFILQppbQPYR88u8A97UYA8POPcEkaS91ERtfvOmoMg2uXeXXnaW7lFgcM0tvWz0mM6mxgd/O4c9FOIS0N3C7DZL8BL4CpE39oYGEbDBup98mdvOayEByygAZc7m2X/8P86C2ysUhvBRzs61T8pF3XqWp0+uLRCb0U57mpvJ29l0lFlsQXlGhaPkw55bMqco7XvIHwNBujfwQDsWVgTyDxoZK0C38CUo2G4KZCN4X0x4JpZcdrGF4XMh2hSeLLB8RJrimPOM/6DjhmhjR7Ih655GZLzeTwNTLc1Firjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DORWcsGccgQUpAp9+GJy6ah0kMstAWJjJLiT1OEd6ps=;
 b=GVjeZEe92GZogJthuqa684ll/iCxBpVhq8bAAvVZMqnVfzYcCtheqNw/vD8B/yZ43UO/a+B0H5x4lpv1QvQVk48DloGwNL+DeiZ+LBAa0NLecjlUBFag9NZ/xnsPcasZfxxI7CTdW3azag1ORK4QrpP1Bkij6EW2gZU6boACQPJg8b2z1MYqpyAhFoIjpwQThh4N7gXAOsOXGN+gt8JgeqLg8Bcd+xaQmkzJXnfGNGX/bReQO5VjwP3nk1jeAuEbuRoTPQIfkYmTv7YjLdv4ISESKuo6l37UR2XIbJpkq9DXBNj5roBMAHVtXwv2d6T/m479HxL4CUMpPrsbALmjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DORWcsGccgQUpAp9+GJy6ah0kMstAWJjJLiT1OEd6ps=;
 b=jMYLHRbnte9Gi1WYyexnRP22yfeY7r7n9vBVPIC5dZFEObestvxG0w2cDt+97sqvpkN3aDZ1bb+wC+//eB+B7zvNf/rFgZbFxNt5xsZspR06TLSJ8/Gif5EucY6hiZwCtVE0lBObJcN2wtaSDdxfbdSvG/qGTJSBhu3IEHZ6GnE=
Received: from DM5PR07CA0034.namprd07.prod.outlook.com (2603:10b6:3:16::20) by
 BYAPR07MB4344.namprd07.prod.outlook.com (2603:10b6:a02:c0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Sun, 21 Jul 2019 18:33:03 +0000
Received: from CO1NAM05FT026.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM5PR07CA0034.outlook.office365.com
 (2603:10b6:3:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12 via Frontend
 Transport; Sun, 21 Jul 2019 18:33:03 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT026.mail.protection.outlook.com (10.152.96.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.4 via Frontend Transport; Sun, 21 Jul 2019 18:33:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWoeZ006437
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 21 Jul 2019 14:33:00 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 21 Jul 2019 20:32:52 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 21 Jul 2019 20:32:51 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWpK2022433;
        Sun, 21 Jul 2019 19:32:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6LIWpcq022429;
        Sun, 21 Jul 2019 19:32:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v10 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
Date:   Sun, 21 Jul 2019 19:32:19 +0100
Message-ID: <1563733939-21214-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(8936002)(51416003)(2616005)(86362001)(69596002)(50226002)(76130400001)(11346002)(87636003)(26005)(8676002)(426003)(5660300002)(70206006)(186003)(53936002)(446003)(478600001)(26826003)(316002)(76176011)(476003)(81156014)(336012)(81166006)(70586007)(126002)(4720700003)(356004)(50466002)(2906002)(6666004)(54906003)(47776003)(48376002)(14444005)(16586007)(42186006)(2351001)(36756003)(486006)(30864003)(68736007)(107886003)(4326008)(6916009)(305945005)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4344;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d291dd73-9a73-4e09-4943-08d70e09dd5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BYAPR07MB4344;
X-MS-TrafficTypeDiagnostic: BYAPR07MB4344:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4344BF8F1EB5A241AC99A6B6DDC50@BYAPR07MB4344.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0105DAA385
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Q1aOd0SUKqfW3ug9YVHc/JX4X/3H9jg1mQPpzVLMYID7b9Ief0nrixDmbrOQxWwvAjgx4rFaFMm9CApj24VfSL1ZNzMyt7lAZGUJdvoBZy0leJpyIOSD9z3rg5/8r1jyJQ5JD4tNyAt7RkKj5EX0FbJkU0ZTOK/WYjscPBr2lNa182PqlsNxNSRDIH9ZtlkIfkYHULrO3NlWkhVBiI/XTFQF8wuRm8DeLGcQn1Tcb6SVlfw86nBvmYYlt2CO/KXb7g0puSRGi3c4nqAasUqLV2wZPJeWJMVIM9YpBC+w9uQn/xrZU69tmsDZBtZAsN2v1pzcSt5ZBEYP3nhLjdSTSJOnFpeMpWudTFhiTQ9WFyIdQgxgaGu0VI16pJmy5i8aSrE6CIBA4whM/f9HHmM9PC49ljtqLQxEJaol707pkVw=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2019 18:33:02.2858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d291dd73-9a73-4e09-4943-08d70e09dd5c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4344
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210215
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
 drivers/usb/cdns3/gadget.c | 338 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |  13 ++
 2 files changed, 349 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 291f08be56fe..a42e832b3c6a 100644
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
@@ -337,6 +374,254 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
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
@@ -370,6 +655,13 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
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
@@ -919,8 +1211,25 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
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
+	if (ep_sts_reg & EP_STS_DESCMIS && priv_dev->dev_ver < DEV_VER_V2)
+		cdns3_wa2_descmissing_packet(priv_ep);
 
 	return 0;
 }
@@ -1501,6 +1810,9 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
 			       BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
 
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		cdns3_wa2_enable_detection(priv_dev, priv_ep, reg);
+
 	writel(reg, &priv_dev->regs->ep_sts_en);
 
 	/*
@@ -1519,7 +1831,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 
 	ep->desc = desc;
 	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL |
-			    EP_QUIRK_ISO_OUT_EN);
+			    EP_QUIRK_ISO_OUT_EN | EP_QUIRK_EXTRA_BUF_EN);
 	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
 	priv_ep->wa1_set = 0;
 	priv_ep->enqueue = 0;
@@ -1544,6 +1856,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct cdns3_endpoint *priv_ep;
+	struct cdns3_request *priv_req;
 	struct cdns3_device *priv_dev;
 	struct usb_request *request;
 	unsigned long flags;
@@ -1596,6 +1909,16 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
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
 
@@ -1603,6 +1926,8 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 				      -ESHUTDOWN);
 	}
 
+	priv_ep->descmis_req = NULL;
+
 	ep->desc = NULL;
 	priv_ep->flags &= ~EP_ENABLED;
 
@@ -1633,6 +1958,14 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
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
@@ -2100,6 +2433,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		INIT_LIST_HEAD(&priv_ep->pending_req_list);
 		INIT_LIST_HEAD(&priv_ep->deferred_req_list);
+		INIT_LIST_HEAD(&priv_ep->wa2_descmiss_req_list);
 	}
 
 	return 0;
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 2a97c16aea4b..33c462bdb8e4 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1079,6 +1079,7 @@ struct cdns3_trb {
 #define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
+#define CDNS3_WA2_NUM_BUFFERS		128
 /*-------------------------------------------------------------------------*/
 /* Used structs */
 
@@ -1089,11 +1090,15 @@ struct cdns3_device;
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
@@ -1110,6 +1115,8 @@ struct cdns3_endpoint {
 	struct usb_ep		endpoint;
 	struct list_head	pending_req_list;
 	struct list_head	deferred_req_list;
+	struct list_head	wa2_descmiss_req_list;
+	int			wa2_counter;
 
 	struct cdns3_trb	*trb_pool;
 	dma_addr_t		trb_pool_dma;
@@ -1127,8 +1134,13 @@ struct cdns3_endpoint {
 #define EP_CLAIMED		BIT(7)
 #define EP_DEFERRED_DRDY	BIT(8)
 #define EP_QUIRK_ISO_OUT_EN	BIT(9)
+#define EP_QUIRK_EXTRA_BUF_DET	BIT(10)
+#define EP_QUIRK_EXTRA_BUF_EN	BIT(11)
+#define EP_QUIRK_END_TRANSFER	BIT(12)
 	u32			flags;
 
+	struct cdns3_request	*descmis_req;
+
 	u8			dir;
 	u8			num;
 	u8			type;
@@ -1176,6 +1188,7 @@ struct cdns3_aligned_buf {
  * @aligned_buf: object holds information about aligned buffer associated whit
  *               this endpoint
  * @flags: flag specifying special usage of request
+ * @list: used by internally allocated request to add to wa2_descmiss_req_list.
  */
 struct cdns3_request {
 	struct usb_request		request;
-- 
2.17.1

