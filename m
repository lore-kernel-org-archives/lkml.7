Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C30C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DB221655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TQFHEmAU";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pq07ZWhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfJGMGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:06:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7116 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727467AbfJGMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:06:37 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97C3o9x002479;
        Mon, 7 Oct 2019 05:06:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Pbt+t44q0yRHePx4Np8lx3JtERU/igRpGSwlYHPD3YU=;
 b=TQFHEmAUZe8ZFKSeALINm9MSm0n08dR6SYjLYoW7plEM6OzS/UNzCd9FlP0gncE+QTo3
 mKp4LS20fsIZJ84OKIECl7oUBl7CrSkIKCEbpGAVL/mXAHkG/dw9qYyRagQuTY4zGUX5
 UPLyN522TbZJFVSvZQkoHGQB23RejPxZDQb5XJFE2zSueiE2N/mXJLjIIm5fGJFpkKlc
 eJaqmSV65F545OTSL/FLI9QMA0Jz/ziTJzf1F5sQBA+i5KY5XTdlYlQSVSCsIuIlfSju
 yiU0gjtAL9y9jelbFeCVXpNvpUdXTcGj7ynIrmCum0ywaV34zqPX/U+/MviEXiXtDPCh dA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vepry68a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 05:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNN0h6xaRIEqX6sKupzBpYVfy5W0aH5osiGaCBL416p+Yj1BcSTYX6JNYz35zPYIEOd32Q0hnB/NuGY3eXcUE8vSSuWowxHdAzzwoImg4cNVhuQzv6HE247OSZlMU9lbl696GYbFbGsquu9H+wrBUw+ivfz1GQVl078ygA+8yxLz79pnX1xVtKiM2zUZm3ZK6SCze/ubCBV8cz9wgwIar4VMWvpO7TRAzWyhUR4Vg1ZJenVZeTpZUZ0juwEVfmv+x37bzgRibLszX7svW6SOR+aCC5O6u4B0FEs4/vkV0dUmT1wekhZYi+0K3yN6H+uMRs5+W9JZgVEH/M/el/y3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbt+t44q0yRHePx4Np8lx3JtERU/igRpGSwlYHPD3YU=;
 b=BvuSoX/vQoxzSNDlq/rkdPXqQkkxCfrWmXvt9k+UboAcgQk/CJndEox96D7f4ZVj7uN8eGI20ikGoresn4/t3ZaxM6K4wAa3mHYBsGmdkriQ0XjGrSD30VLcfVpuRwHmwxokRmKnwjabDxNQHwbZchrpzqybmqYbfwg22Me3VACNSHXvAW8sXxtkxv+Z4HlE3MbOv8xJTYJzGj6Z864DGtL1dVwJMA60K2MT4n5k+Wivkp60ccyImhi2aGgJKWQgPwHUPR9Md3Wh0VsV3ptuvZw2rtw8LtKljpedp/EKWLGTKlRy1Y0DxuTAz0HDSMIfWTj+wWsnb8X+IaHLu+Ze2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbt+t44q0yRHePx4Np8lx3JtERU/igRpGSwlYHPD3YU=;
 b=pq07ZWhjel9mlR3wwJpF6pwnL4Uuw1Q9c2KIE+JLyBbWtUEdlqr+8wpMw/JM5usswe8h8+z/3+8u4SRJz7cMcTePWV3DlvkKX631TQxqMf+hO8YojDASGGCaTSuMiZG20iUpwtNkuQAHndpeR97Er22oY8nX9GZtnvGErcWwafI=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 SN6PR07MB5117.namprd07.prod.outlook.com (2603:10b6:805:6b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 12:06:25 +0000
Received: from BY2NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 7 Oct 2019 12:06:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT057.mail.protection.outlook.com (10.152.100.194) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.8 via Frontend Transport; Mon, 7 Oct 2019 12:06:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x97C6MRl029405
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Oct 2019 05:06:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Oct 2019 14:06:22 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Oct 2019 14:06:22 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x97C6LVv019394;
        Mon, 7 Oct 2019 13:06:21 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x97C6LuS019393;
        Mon, 7 Oct 2019 13:06:21 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Fix dequeue implementation.
Date:   Mon, 7 Oct 2019 13:06:18 +0100
Message-ID: <1570449978-19145-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36092001)(189003)(199004)(48376002)(86362001)(2906002)(54906003)(42186006)(16586007)(316002)(50466002)(6666004)(356004)(14444005)(336012)(6916009)(426003)(4720700003)(51416003)(26005)(486006)(476003)(186003)(26826003)(305945005)(478600001)(7636002)(107886003)(87636003)(4326008)(50226002)(8936002)(8676002)(246002)(47776003)(126002)(2616005)(5660300002)(36756003)(70206006)(76130400001)(70586007)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5117;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fec2e3c6-76e0-4099-843e-08d74b1ec66f
X-MS-TrafficTypeDiagnostic: SN6PR07MB5117:
X-Microsoft-Antispam-PRVS: <SN6PR07MB511746877D91FD089550E606DD9B0@SN6PR07MB5117.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01834E39B7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTGWk6TtVPOIFw2Xxg8BbQdSytvyOcjypd1v9PEqbdv+Rt8cX9/OrN/+2X1N8XcO6VpTHXwysifFWluazq5hlRujq2GL21UmfPrfSeIHSJ4wpnz0zE55CwpTAma3TFUBkdv/5hES3SByRsbwOEh2pPshvGH5UTrffRkr0pgNJ3xHNYy1kK84LYgcMkoXSwBNiGWiNstyxTU/y6L9OkzZEg8S8QMVMSDudPrzkqm6VHoIATAkYyaFoMhABhCkNS7yOJ160HfGnzoMdon4JrD8R3L3M/XvIac/1V1Cw4HWfCSvbhc6y9T3m+ns11kC9HB1bn90uR3pDzVtQkJ2jQ+7oeSWSAytgF+DKEKl6ngGm2O7PixJmVo399/iFPJbAEnMALznlgVR3ocSno+7auPK2hfmXa5LU7R00EZaPHYUPys=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2019 12:06:24.6233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec2e3c6-76e0-4099-843e-08d74b1ec66f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5117
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=837 phishscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dequeuing implementation in cdns3_gadget_ep_dequeu gets first request from
deferred_req_list and changed TRB associated with it to LINK TRB.
This approach is incorrect because deferred_req_list contains requests
that have not been placed on hardware RING.  In this case driver should
just giveback this request to gadget driver.

The patch implements new approach that first checks where dequeuing
request is located and only when it's on Transfer Ring then changes TRB
associated with it to LINK TRB.
During processing completed transfers such LINK TRB will be ignored.

Reported-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
---
 drivers/usb/cdns3/gadget.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 2ca280f4c054..9050b380ab83 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1145,6 +1145,14 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 		request = cdns3_next_request(&priv_ep->pending_req_list);
 		priv_req = to_cdns3_request(request);
 
+		trb = priv_ep->trb_pool + priv_ep->dequeue;
+
+		/* Request was dequeued and TRB was changed to TRB_LINK. */
+		if (TRB_FIELD_TO_TYPE(trb->control) == TRB_LINK) {
+			trace_cdns3_complete_trb(priv_ep, trb);
+			cdns3_move_deq_to_next_trb(priv_req);
+		}
+
 		/* Re-select endpoint. It could be changed by other CPU during
 		 * handling usb_gadget_giveback_request.
 		 */
@@ -2067,6 +2075,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 	struct usb_request *req, *req_temp;
 	struct cdns3_request *priv_req;
 	struct cdns3_trb *link_trb;
+	u8 req_on_hw_ring = 0;
 	unsigned long flags;
 	int ret = 0;
 
@@ -2083,8 +2092,10 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry_safe(req, req_temp, &priv_ep->pending_req_list,
 				 list) {
-		if (request == req)
+		if (request == req) {
+			req_on_hw_ring = 1;
 			goto found;
+		}
 	}
 
 	list_for_each_entry_safe(req, req_temp, &priv_ep->deferred_req_list,
@@ -2096,27 +2107,21 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 	goto not_found;
 
 found:
-
-	if (priv_ep->wa1_trb == priv_req->trb)
-		cdns3_wa1_restore_cycle_bit(priv_ep);
-
 	link_trb = priv_req->trb;
-	cdns3_move_deq_to_next_trb(priv_req);
-	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
-
-	/* Update ring */
-	request = cdns3_next_request(&priv_ep->deferred_req_list);
-	if (request) {
-		priv_req = to_cdns3_request(request);
 
+	/* Update ring only if removed request is on pending_req_list list */
+	if (req_on_hw_ring) {
 		link_trb->buffer = TRB_BUFFER(priv_ep->trb_pool_dma +
 					      (priv_req->start_trb * TRB_SIZE));
 		link_trb->control = (link_trb->control & TRB_CYCLE) |
-				    TRB_TYPE(TRB_LINK) | TRB_CHAIN | TRB_TOGGLE;
-	} else {
-		priv_ep->flags |= EP_UPDATE_EP_TRBADDR;
+				    TRB_TYPE(TRB_LINK) | TRB_CHAIN;
+
+		if (priv_ep->wa1_trb == priv_req->trb)
+			cdns3_wa1_restore_cycle_bit(priv_ep);
 	}
 
+	cdns3_gadget_giveback(priv_ep, priv_req, -ECONNRESET);
+
 not_found:
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return ret;
-- 
2.17.1

