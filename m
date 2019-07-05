Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E644C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCBE21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Y+KfEQ4g";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RbnGIC9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfGEK6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:58:24 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52862 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728723AbfGEK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:58:21 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65AqjvU031355;
        Fri, 5 Jul 2019 03:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=Y+KfEQ4gyUx3QVXx7VyEdF0f6tXAdX/LbnOyvhQ9p2kheC3zx9hGORZDxTGhlfZw/x4e
 L8da5zsqsOHf6tM51vseLe9gQVc9o2fLLD+qdlz9iOSOSyi866lutF12jSMEk7miPn7b
 RHn3DMB+ddA47HgDlXXLonkDiBDfzejXUV5h/eU8GHCHTOGH47NfS6iqjySFdSf7AoDm
 DfVjADtRKuKUqspM5FEk7zWJj3Mc4O1KVxGDMdJ0pZ85LIcYT4VEgKn9ZbWZh5mY6PHS
 O9/M6SLdZGMFiPMapIoV7zKSrFfgR//G8Y6GQ5W9Bf/pxpaNu4BTTd6+DBG5gnuQ4Ksy 6A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2thby2w051-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 03:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=RbnGIC9p3NF4fS4qpTA+jR35cXEVmP0kZFW38Nd3DhOaqNTD3bThObGY+P+LVtlMIcdOdWHfBsuDtUnUHEMAQyziBM9/i3Bv0pgOpw6TxSpi4wq8M3VeRgZgO0vcv4kj0MZjfBMS20bU4a1gDi23+IhPwV/ACNVrO9x9e2oggDg=
Received: from CH2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:20::28)
 by CY4PR07MB3045.namprd07.prod.outlook.com (2603:10b6:903:cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Fri, 5 Jul
 2019 10:57:46 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by CH2PR07CA0015.outlook.office365.com
 (2603:10b6:610:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18 via Frontend
 Transport; Fri, 5 Jul 2019 10:57:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.8 via Frontend Transport; Fri, 5 Jul 2019 10:57:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x65Aveca001356
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 5 Jul 2019 03:57:44 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 5 Jul 2019 12:57:40 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 12:57:40 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x65Avep9017671;
        Fri, 5 Jul 2019 11:57:40 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x65Avedb017670;
        Fri, 5 Jul 2019 11:57:40 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v9 4/6] usb:gadget Simplify usb_decode_get_set_descriptor function.
Date:   Fri, 5 Jul 2019 11:57:16 +0100
Message-ID: <1562324238-16655-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562324238-16655-1-git-send-email-pawell@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(199004)(189003)(36092001)(11346002)(8936002)(446003)(50226002)(246002)(4720700003)(70206006)(16586007)(47776003)(42186006)(126002)(50466002)(316002)(26826003)(6916009)(7636002)(6666004)(86362001)(87636003)(305945005)(2906002)(476003)(2616005)(426003)(54906003)(70586007)(356004)(486006)(7416002)(478600001)(8676002)(76130400001)(51416003)(2351001)(107886003)(336012)(5660300002)(186003)(4326008)(48376002)(36756003)(76176011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3045;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 293e9026-0a1d-48d4-469d-08d701379c47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:CY4PR07MB3045;
X-MS-TrafficTypeDiagnostic: CY4PR07MB3045:
X-Microsoft-Antispam-PRVS: <CY4PR07MB30451DD532F2D665B4D7F475DDF50@CY4PR07MB3045.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 008960E8EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JHENSsUIJOPHc/Euy17j8FyianDL0BZJuTQwlUrLgzEKPq3OqxlU/J6moQL4WjAh9TXQnGKyXjVy/RxGI2bamRizG6O1kEYQAmq9IeGtEqATekvmyKSRIRCGEy9/NvVZpwz+fvNi53bE0RABvNAWiPFaP/l6bS91v58nShuMVA3Qd35W9VzUcIdUfOpIEOUgjMayaERJlypOlZTxEJS/X3ff1410yAtNGUL8nydj/0AncPULEZCbFFj4PBVa3DlA+iX5Rqe5SjnNDh48LpzEDINJ4DijwEskJHSWxKVHnzOJ406rlSKN+pdroRCRh0zW6OzWOwqeGGkhGupkjD0qEw+Paz5ZhIUjRuF0FV61IQ/nNL7gdJGFLKcp0NeA3YusIHZBuSYjc9NYNEpFYWRUXMHY48U7PLSSCINEDJXweHs=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2019 10:57:44.9067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293e9026-0a1d-48d4-469d-08d701379c47
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3045
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=703 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves switch responsible for decoding descriptor type
outside snprintf. It improves code readability a little.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 113 +++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 60a9f70a0904..92a986aeaa5d 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -105,62 +105,65 @@ static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
 					  __u16 wValue, __u16 wIndex,
 					  __u16 wLength, char *str, size_t size)
 {
+	char *s;
+
+	switch (wValue >> 8) {
+	case USB_DT_DEVICE:
+		s = "Device";
+		break;
+	case USB_DT_CONFIG:
+		s = "Configuration";
+		break;
+	case USB_DT_STRING:
+		s = "String";
+		break;
+	case USB_DT_INTERFACE:
+		s = "Interface";
+		break;
+	case USB_DT_ENDPOINT:
+		s = "Endpoint";
+		break;
+	case USB_DT_DEVICE_QUALIFIER:
+		s = "Device Qualifier";
+		break;
+	case USB_DT_OTHER_SPEED_CONFIG:
+		s = "Other Speed Config";
+		break;
+	case USB_DT_INTERFACE_POWER:
+		s = "Interface Power";
+		break;
+	case USB_DT_OTG:
+		s = "OTG";
+		break;
+	case USB_DT_DEBUG:
+		s = "Debug";
+		break;
+	case USB_DT_INTERFACE_ASSOCIATION:
+		s = "Interface Association";
+		break;
+	case USB_DT_BOS:
+		s = "BOS";
+		break;
+	case USB_DT_DEVICE_CAPABILITY:
+		s = "Device Capability";
+		break;
+	case USB_DT_PIPE_USAGE:
+		s = "Pipe Usage";
+		break;
+	case USB_DT_SS_ENDPOINT_COMP:
+		s = "SS Endpoint Companion";
+		break;
+	case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+		s = "SSP Isochronous Endpoint Companion";
+		break;
+	default:
+		s = "UNKNOWN";
+		break;
+	}
+
 	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		 bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		 ({ char *s;
-			switch (wValue >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), wValue & 0xff, wLength);
+		bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		s, wValue & 0xff, wLength);
 }
 
 static void usb_decode_get_configuration(__u16 wLength, char *str, size_t size)
-- 
2.17.1

