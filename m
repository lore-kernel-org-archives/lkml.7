Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD7C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4CF20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="dbkvczIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfKFOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:46:26 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:48294 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbfKFOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:46:26 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6EheJ4001564;
        Wed, 6 Nov 2019 09:46:05 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w2a75rgj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 09:46:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuHfSu61n0Sd97TSbE0c6Kn1AXp8tGWSUNDyI2TFJxg1SFfjRYaobzuJbnMHsY7gom86P2Lcxhvf2atSxL1OeGIAdYThBebOxh5f5b04RuGN/WfyGOkCVWJu6cU3/WHq8Bxo61rAWneK5ZXc9Bu/vVgmdwD4TL216dgZG8+cWVPtT3wqvXwCqfu+5yzJFuWlzcBzMSwKPpYelGPwOWaIXGZjRLWg1Ksb8ETLvgGTp0TvBt1SWvdS1bNNIxd3WjPk9aKxwQfpNm2wnQ54YUObFz0dBOpfoYxjYer5LNYM1SqISqGCo61+J5ozaxZEaqXAXXgNT10eYVJYad+AIItiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahpW0b/Oe1Z8UABL2r6l6FeqzX/Rahl9EYdYT+UgzsA=;
 b=Z15d8I1+rhMR5dQKDMPiSeQfpxxktqVj06BRDCgoVONB7A9M69SELmy+nRVWyL5lC7fy2k9Wvk9DSmwTUdFGLs0ItoJnp44JfQMDvBB6Dgc0iPMl8nvDJnOFV5kyuGBMUFWQCemOOWKiNGCGqQwAt4ZLkXaB0TjsEFT3kGNz5Wu4QIDIKggWrKpB2H2UcegBPS4QILIX5ToH95Mo31Y0+cmZHykeFzR7OIjtHWHxsvP+E1dlKK0z288BMEddWGg143TDoHZI4qLEXTX+C2BtXMASv2zvBXqgGYzIsQxpgi6QgLWqabxwJ8QKrjGVyiXozosfi+W+bMufJ8c1nJAJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahpW0b/Oe1Z8UABL2r6l6FeqzX/Rahl9EYdYT+UgzsA=;
 b=dbkvczIS+tkqFQpXKnMK8M7s8zdTfhVXerhS/OV7MCwZ19wTMz3Gp5QwvACTOK9t5DqA75IP4I211ys6zFjd41qO1y9WxvS/SyZraEcvJ3IvvIQe+pv83gOP+bmAQLieUTgTv1k78dbMKNwSgPGIFw+qP4P5RkYlVNZYbh2jfbI=
Received: from BN3PR03CA0114.namprd03.prod.outlook.com (2603:10b6:400:4::32)
 by BY5PR03MB5235.namprd03.prod.outlook.com (2603:10b6:a03:21b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Wed, 6 Nov
 2019 14:46:02 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN3PR03CA0114.outlook.office365.com
 (2603:10b6:400:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 14:46:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Wed, 6 Nov 2019 14:46:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA6Ejo59027660
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 6 Nov 2019 06:45:50 -0800
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Nov 2019 09:45:58 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <bigeasy@linutronix.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] usb: dwc3: gadget: Handle dequeuing of non queued URB gracefully
Date:   Wed, 6 Nov 2019 16:45:53 +0200
Message-ID: <20191106144553.16956-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(2906002)(86362001)(106002)(2870700001)(51416003)(50226002)(336012)(7696005)(48376002)(356004)(6666004)(107886003)(4326008)(36756003)(54906003)(316002)(47776003)(478600001)(186003)(70586007)(70206006)(8676002)(110136005)(5660300002)(26005)(44832011)(1076003)(426003)(246002)(14444005)(50466002)(305945005)(7636002)(8936002)(476003)(2616005)(486006)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5235;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6c7db5a-266d-41e8-b1e0-08d762c80b8c
X-MS-TrafficTypeDiagnostic: BY5PR03MB5235:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5235CC2EBA7DE2AD23257005F9790@BY5PR03MB5235.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHh1gJQwDOjSsB6nu0ZZnwea6MX14vsuIETpsjuMZgpND1QjC5W6igTvReFJMKh298jf99fsyfSr3cMMzH7NzfMCl0Ae+QPyoYydLGjXu3cFR5McqK1I9uLaWg9ZZBbr5lKuLB+CYKlFB2w0jDiJiKmg7bad8wiNZxwZKRjaJYVAism3wXC3DZiKbs8JbpOS+2/yKXCzQhNdmyA8HxGVJUb5lnIax9mQ8Gd1XKxfb6LQVPWupMt3cYClsFgNMdIqeLsGUL9BHApKfCxKb3rlvosMIVnuvvh6YQN5xyPYlytBq5SxNNpS9lFi1Nxwzi86Qbvpb6V5tn6rZ1pGVGCQ5Ym6HLUNuLxw+AoW0npaLGbEnww5aHtfXmF6+MkcAfj5oOE7NsDzKOiUoe+WA9gaT3wVxHRwWvm0D6R5Vrhrz9mJCc+sS1i1IhV1BB6cdQ/e
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 14:46:02.1554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c7db5a-266d-41e8-b1e0-08d762c80b8c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5235
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_04:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=767 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911060146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Trying to dequeue and URB that is currently not queued should be a no-op
and be handled gracefully.

Use the list field of the URB to indicate whether it is queued or not by
setting it to the empty list when it is not queued.

Handling this gracefully allows for race condition free synchronization
between the complete callback being called to to a completed transfer and
trying to call usb_ep_dequeue() at the same time.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a9aba716bf80..b500ec6b0aa8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -174,7 +174,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 {
 	struct dwc3			*dwc = dep->dwc;
 
-	list_del(&req->list);
+	list_del_init(&req->list);
 	req->remaining = 0;
 	req->needs_extra_trb = false;
 
@@ -844,6 +844,7 @@ static struct usb_request *dwc3_gadget_ep_alloc_request(struct usb_ep *ep,
 	req->epnum	= dep->number;
 	req->dep	= dep;
 	req->status	= DWC3_REQUEST_STATUS_UNKNOWN;
+	INIT_LIST_HEAD(&req->list);
 
 	trace_dwc3_alloc_request(req);
 
@@ -1540,6 +1541,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
+	/* Not queued, nothing to do */
+	if (list_empty(&req->list))
+		goto out0;
+
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req)
 			break;
-- 
2.20.1

