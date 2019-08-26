Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919CCC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6602070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EnrZDHhX";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jE0dFYfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfHZLV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:21:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43200 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbfHZLV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:21:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBJPU8004607;
        Mon, 26 Aug 2019 04:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=EnrZDHhXEQHatOQXRMtvwiQ8w5LSYn1lD7GAuiSoY5tBu72uMzHCBG5sbFoLY1hSych9
 PKcZ22NwX0f+qPTFAowMlF34uHftZzXuofoz7o+Sm/AktK7ECyEHiWgxctmi/sTC3sPZ
 JFTSRpYyitQD4TUwyW685nqtReqJAEe4HSxbsy5ZByOXsbXp4IEQK5BIQ7dj0HPpiF20
 6OiupEgh61ba2D16lCNguLXWcmkqmcZXkiUUcJpjJjOEtJB8THvhd1lhu+t4XPvRCobB
 UPFGg/t3391rRQeRcl9uj5Pbg4DSrdIgi/ka8VG5W7DbavwJQjDMUXFchVcEuswpAUaO Uw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uk21yp6h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k00OVGQgskclVRZEI9JAcYPQoejba/KNjSvPRQ6VMoa3Iqvz5U7oE+mqeYd93afQW5Y7MYBTz4sRKbXdfwopdxFVwg0zhebQfK76+LFhbr1lIVAF9+MZDdJpyWY1Nkpwr42QQXB1c3Ctov27vitEL3wQzM3hKffvPVtD6jcd87Lkfj6g2yZN9X1I2dCv1E1PPYa/VKc9ORE9gEIiYCrZUiCopsmnyy6uooTn+40MqhMQAQ4xLvcueeSS9SRvBE7wZJTsMPQ/qo9SR9TnF/AH7Ckqqfg9kcxquxLy9lTc5tp6EF4FA9Y0JK9/ZuKMbr82i3cfFdBpU8VFP3EvR8jigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=nlNoGnzaRGnOABw8PW5+2t2rlRQ2NptEwCdV2tTS16Ge0P8TK8Eyk6FXlRGPLK/dAf3elZNeejUsTDQY7CDBNQPqypXL8akdBOVx7WA5Nh41+/mC3TCLiCCjWdCUT8wOAjOq2BKzRiPy8jCs4C2U21jaZifoLgN+WEZG3C+4FmXmqxgq7/Uq1untXlRS+WMuWYUWpiov0Y9r5u2trW53QDsj1gAVkIgRjAsZQol2ad7oDEd9IP75F4Cn3k37LPajsdLtW/WDYpE1YSd8WvsIzbF/x125fjmggxQXiBN6tT/iEfqHxkgSEo8O+ylpVmIoRjG5vvT37AbyRU0RbubLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=jE0dFYfezSKbhrfLAJqWx4x7Y7H8gZsOWse+YJ/DBslUYFkzqNgQC5GrYuB8ZcfGLy2WEUCGjzfteeGyD1Jf/lxqN6RCly9ED7cA/scQIDZzY0BsOjjzlV5bsMir+ZuDqSHXOzqxN2y6lyQAZjaGF9Nmq9fkP8WycTzgzoB5ZbY=
Received: from CY1PR07CA0042.namprd07.prod.outlook.com (10.166.202.52) by
 BYAPR07MB4456.namprd07.prod.outlook.com (52.135.225.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 26 Aug 2019 11:20:15 +0000
Received: from BY2NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by CY1PR07CA0042.outlook.office365.com
 (2a01:111:e400:c60a::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.17 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:14 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT047.mail.protection.outlook.com (10.152.100.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WU001206
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 26 Aug 2019 04:20:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 26 Aug 2019 13:20:10 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 13:20:10 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBKAsR029112;
        Mon, 26 Aug 2019 12:20:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBK92H029111;
        Mon, 26 Aug 2019 12:20:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 4/6] usb:common Simplify usb_decode_get_set_descriptor function.
Date:   Mon, 26 Aug 2019 12:19:29 +0100
Message-ID: <1566818371-27721-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1566818371-27721-1-git-send-email-pawell@cadence.com>
References: <1566818371-27721-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(36092001)(189003)(199004)(486006)(6666004)(11346002)(16586007)(70586007)(186003)(8676002)(76130400001)(48376002)(356004)(54906003)(47776003)(107886003)(42186006)(305945005)(2906002)(50226002)(476003)(7416002)(5660300002)(26005)(426003)(316002)(50466002)(446003)(8936002)(6916009)(36756003)(51416003)(246002)(2616005)(76176011)(4720700003)(126002)(4326008)(26826003)(87636003)(478600001)(70206006)(336012)(2351001)(7636002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4456;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e56d95-12d6-4baa-1274-08d72a175dfc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR07MB4456;
X-MS-TrafficTypeDiagnostic: BYAPR07MB4456:
X-Microsoft-Antispam-PRVS: <BYAPR07MB445674ADC4BF4132D4683264DDA10@BYAPR07MB4456.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Wbaj3ZckewRtVpfvSMxjmE+Qf5AUJS45KJfBH5dOuhI/fmfJBwCBuGz8Hz0MuXVcsGpuM4yvESHEElymzpSrlzv43bD8UUmfeR1na9NRT7qCNWhBbkx4cb9BxMdcSZ+MTF+3twTb6sEfA8TPtIXBx/wlQRNjaP0Hyn2bMOR2vuMBnWO/udtSBTXV9rLwaOnG/RKpPUVBQLuCM0/AFvK0GXK2cOH5HbY2rudsbwbrKYYDmXYFDk4SDDPOvMlQFTNoYAcfByxiw9oLznT4FEEkyNtRfrIHrtl6TUZIUsnh5JAUZ4ap7ylfFKyVr5kpos8x9Jfy4pWwerZuxCuP5uwppD52MwQPESen+2RSjoct6j6/WH88ekCEtVJo80/XBP0VEyzvO1XKf09TglNfGGgR4Zdw5V7m8l8fA8uNMNgOUc8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:14.5029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e56d95-12d6-4baa-1274-08d72a175dfc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4456
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=1 clxscore=1015 mlxlogscore=841
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260127
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

