Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9FECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A4320673
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="aWIMy4vT";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zobMOTkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfJMJUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 05:20:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23960 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbfJMJUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 05:20:50 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9D97EUi003551;
        Sun, 13 Oct 2019 02:20:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=DCOTJ96pcfXmMwOo6CynpV9dzD4++gCroomyf3NWXnQ=;
 b=aWIMy4vTX18QDrDwOX8ktnft1EXRzp2qCstngCR/QEc0rNF8Jm3VuEpsIWHahQg7QGed
 wSMTQ8P6Npo7ZSw6CY1GcWaEb7anpy5DR7nqVWYeWULSPcAAgpr3Zc+L4I8suxNiFkG7
 sCVbuXCglKwk7Dpxqatw4X2nHgCzhw6p6lwGvFVfsMVHDsL7OD7errWl0MCLkbpupUjx
 FQ7TL3upmxASkp7fFk3Eb6O8egq8nzig+qcPrJc1vA5kQEh4gRBXpddoByU0M7fQ2UyY
 ealde9seiZNlXoYTtqnBoDINF1lCR2Zyut1rHkaaZz6XN1+WHlopl5MsmI00Q4Yaf/tS xg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2050.outbound.protection.outlook.com [104.47.44.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd1jvj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 02:20:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4x9LF0BR6Jc3lYCAQxmE8CsLRqxZUnu6WC2PuiwTtSJxLNRXBrhvCtIwOBfTGQkh9I02BNy+7q2AXznq3E3L8Rxc5lLRY6Z1cc+Dms1/HFvpi4jrEYmK8g/6XNCVF+HdESAWaqeoNwt9/hLbKRvP+3pRqf6+IQPE8a97IKtE6O+EEQiO05j6koPtjlHAfztEpUAwqcaRZRMBG2SweW7FAOyuw5pSCNsjSMtQiyz7WMDQI5gOUz3Afvasq1uUTEtmHHcxRJ/zIKUgzMSG3T6pqHC8vtyOdkeWGfkXVsNFg06yn6L+Zuy2BVXB75/iAvwxYo7bVv6rvz2O3Qg0S+t6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCOTJ96pcfXmMwOo6CynpV9dzD4++gCroomyf3NWXnQ=;
 b=oYJLE67RghZ+roR9Qsox08rl8m2ZRNcEiOINo/UdsggRiKSWX66VLCJYjF+Xq4BqNgz8UAOddfpyJZDH86URsnUkTHNQsd0IAD4kPQuOExTce/LKd3IIqX8hHqogl+l53rKQjYmVxQ9s80XhQ9OhccyywOHRzKXUuNSr2nsLglxJRHbfuc740S7S2cdPdvHrvqBFMCpjxJ4QckztsADDZq0H64f6bro/WDVX0fCH02mvEV0nG9HeUFtiDPagXMpIoPlunO3LQkqAlCxpwWvFSumF20zDci8s/hJeuo4QrKS9CKTx+jVF4wHKax+/e3+sEtlAHbvQdUzlH7iGWjFdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCOTJ96pcfXmMwOo6CynpV9dzD4++gCroomyf3NWXnQ=;
 b=zobMOTkX2PV2Y7edsDaC9MhPlZToKqNMZsDgwb1A3NQYyjWrpgceCjEuowzbOq7ZJiTTKmIYI/lDa4ZHLC17xzr1SrVThbZbs/ebG77k4wm5EmaDFeIfFcWzfkGOTyexbcPgW4E9HoU3/nG0PLIMSpu/4/M+l+ULGaDYETnmyAs=
Received: from CH2PR07CA0031.namprd07.prod.outlook.com (2603:10b6:610:20::44)
 by BYAPR07MB6118.namprd07.prod.outlook.com (2603:10b6:a03:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Sun, 13 Oct
 2019 09:20:37 +0000
Received: from CO1NAM05FT004.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by CH2PR07CA0031.outlook.office365.com
 (2603:10b6:610:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.17 via Frontend
 Transport; Sun, 13 Oct 2019 09:20:37 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT004.mail.protection.outlook.com (10.152.96.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.5 via Frontend Transport; Sun, 13 Oct 2019 09:20:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x9D9KYh1024473
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 13 Oct 2019 02:20:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 13 Oct 2019 11:20:34 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 13 Oct 2019 11:20:34 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9D9KXXv022560;
        Sun, 13 Oct 2019 10:20:33 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9D9KXBb022551;
        Sun, 13 Oct 2019 10:20:33 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdns3: Fix dequeue implementation.
Date:   Sun, 13 Oct 2019 10:20:20 +0100
Message-ID: <1570958420-22196-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36092001)(189003)(199004)(50226002)(336012)(246002)(47776003)(316002)(8676002)(42186006)(54906003)(16586007)(2351001)(126002)(486006)(76130400001)(26826003)(426003)(478600001)(8936002)(36756003)(70586007)(4326008)(107886003)(5660300002)(476003)(70206006)(87636003)(2616005)(6666004)(26005)(51416003)(50466002)(186003)(6916009)(86362001)(48376002)(14444005)(2906002)(305945005)(4720700003)(7636002)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6118;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53d1db43-5d4b-4ef1-571a-08d74fbe9bd9
X-MS-TrafficTypeDiagnostic: BYAPR07MB6118:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6118BE6451BB4C01FA072A85DD910@BYAPR07MB6118.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 01894AD3B8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFbDirJmDNwbJpWPhX+JwXSx5fcn5rF9i24hjtgb0KhXS6FJHzir2MPwNI5ynjaeCu71wbB6KAenrFN3gj785vgSQRsmtKHte7r9KhmZtYboy07iU0J3XKi3Oz7l5d+YdjHvQURUJyr1sTrB+726/VSyXw14wLUQB+Hjk6zOwHObDcGRrGL4scaeF64zX2jD8Alnb2PQIRvg4I/8kTMJ80tlm6cLcY70NvLGEIQtjmCmoQoOYS3G3HU7Ryst7NzjGC4Y3jKuYkgCGcwxB9Qdl84I/CLOjqStp7s5zRVPwd0JZhk0iv99scUGMEfMyStGO7NrTZ/ZapRPvEoYAIR6GTMCcX8MkMFKPpd3C3EYdpesj4LBXdeM3/Y0FQxKtRoCqhyG5CHHcOdFQ+CwbdqVcIJmc/ry1672D3b/WHH9RqQ=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2019 09:20:37.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d1db43-5d4b-4ef1-571a-08d74fbe9bd9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6118
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-13_03:2019-10-10,2019-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=971 suspectscore=1 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910130093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dequeuing implementation in cdns3_gadget_ep_dequeue gets first request from
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
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
v1: Removed the typo at commit log.
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

