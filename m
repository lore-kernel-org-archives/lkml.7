Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48BC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A962083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Gg2wjtKL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ElaS1UoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGUSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:33:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:10262 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbfGUSdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:33:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LITQYV011482;
        Sun, 21 Jul 2019 11:33:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=Gg2wjtKLHrvDgv56hS98RJmdHsd4DC3yiHsYhtVaogn4+npZ8DnnJLd4qp7YArNcAErX
 4zoWZ4ZugBp9j2t5Iul6qpDYtZlpjDXCg7+goqVLCtiYBEnqEvFrFUOCxsghgqiSjYi5
 p1XV14zs/ziLvmq9H8tp81StFciNPTKoKjkE63qwNSvbdwXce4wyOXqtOfa3m6AKtW/i
 kiUvn571MMrMPttzZMu76RwXN8k5Vm6XdCCbFVrxz21zV49q/teToNYNDgik13qbWCST
 Wl0mW1IKuBHEJKovHhFzsBAjKK2I5D/Qw0KHN62GIy6HuPxhIrVXho9NEoxJbTWvuPLe uA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwc1xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 11:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayZNpU/pp4YjyTGoVNUe/I4KtA8sSwyVNBmBERC3DyzV4/vtFAYVtzjfRIhm4I56kiCxtJjt3e9r2ZE1zj7BIEUVmM6PwVJe2NxvSR8Ei4/aLTVe+x6Q7ZlD0g/yTsti9QE0d6njh0mrji3gGsa6Pylm23P23Amg6e0XArekK8uUjzyhmY3iZU1T82DKD3RPIpuDEH2nR1SY5l8lnDUabuLR4oXUjTkewFCJpZLQpAjMqgmtxR2W2abMPrwUayiWB2KxHH1nudisgk4zDlEoo+9lXekEKkwMulEJoFuRSHTppfO6PweyVvn9LktL3hfWBUehfmbP0mzd5//bYrAeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=DH2RYAsNb9xwRbz6TwC/UkHlUs20QGQMWgeZdpYIKYZx5NXuWw/7SuLiyOhI9N3XLIsWEezaHILUBM6x0Vq3XjsvPIKe4TVg4qNxR+W+pDk5huQtju5D4DHC+OW1WEyZFt5zlmX6nelX29KxVBhWAmaMvsc/Me2brPC7A5W8QYI6kKIUIPB+jJMaZqwpwjAPZzEN8Ly7dHL82u/KdX6nMPUCixarF1FX9aEaFrkuqHHZavRELlYs/ezG54upTXPdnmUaROOt5hCk4pNMxpdqvVQZ7K+7VnfCKgTl+wMVFVPwRrCDTGc2Xx6nMVICGV3nGQ0/kff3mIBp+gDMv65ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttF9LdLW1QoeIMW0RBJXuLdOjIB/V+l2cxMscubrdY=;
 b=ElaS1UoO8PlCz0xuy+ROD4p3fjiTFermaos+Y64gMEG+2qZaUrblYKqZH8f8360GHmF1N57Y/NPnRMTFprN/QZYdEyKlz/yctnRnVDkcgthbIWhL+g1IcnXSdx2MP9tdOV+epG9wMXd3i+0V/4DqUZYCiOWS3eA2Q1PsomzUrJ8=
Received: from DM5PR07CA0028.namprd07.prod.outlook.com (2603:10b6:3:16::14) by
 DM6PR07MB4458.namprd07.prod.outlook.com (2603:10b6:5:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Sun, 21 Jul 2019 18:32:59 +0000
Received: from CO1NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM5PR07CA0028.outlook.office365.com
 (2603:10b6:3:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14 via Frontend
 Transport; Sun, 21 Jul 2019 18:32:59 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT011.mail.protection.outlook.com (10.152.96.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.4 via Frontend Transport; Sun, 21 Jul 2019 18:32:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWoeX006437
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 21 Jul 2019 14:32:56 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 21 Jul 2019 20:32:51 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 21 Jul 2019 20:32:51 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWpnh022416;
        Sun, 21 Jul 2019 19:32:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6LIWpn8022415;
        Sun, 21 Jul 2019 19:32:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v10 4/6] usb:common Simplify usb_decode_get_set_descriptor function.
Date:   Sun, 21 Jul 2019 19:32:17 +0100
Message-ID: <1563733939-21214-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(36092001)(189003)(199004)(478600001)(87636003)(26826003)(76176011)(356004)(51416003)(6666004)(26005)(186003)(50466002)(48376002)(36756003)(53936002)(2351001)(107886003)(68736007)(8676002)(486006)(305945005)(336012)(47776003)(446003)(11346002)(2616005)(476003)(69596002)(126002)(426003)(4326008)(50226002)(86362001)(4720700003)(5660300002)(81156014)(81166006)(70586007)(70206006)(8936002)(2906002)(316002)(6916009)(42186006)(54906003)(16586007)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4458;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8028d9ff-c8e3-4896-5e6f-08d70e09dafd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM6PR07MB4458;
X-MS-TrafficTypeDiagnostic: DM6PR07MB4458:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4458F730B076A3C33D6FF80ADDC50@DM6PR07MB4458.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 0105DAA385
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yMntEArZkPA9TvXtYui6QoDBAx+WN834zRLCDjocl+u/Z/AQzc5yeFWkPPItGdBpqYlbKkWmUqZOecbOj/uUGlD/HkIHLckKRyYb19RZDnhoHDbCmA3t9bl+LcyQm6/hugW8rylJhE9EnUF9VllBGJSdOzEZlTaa0rt73T/YBwsyshyXerYZvilyjruUSu1DCJXwb7RQgjrtPifFiAAKN/9+m9pvn2lA+93hHdq3OGjNlsbSAniNkMshoKgv3uSYNa7PLX0foIqMemY92UmkIm3Av8sOixj0o6hHfYjcB4yJ2CHJ2j75rGOYgkOt0MCNW96+Tu9+MB+rqIYgNdKetapEwpj9dkfpypweuO2A3I34tal3unv/koRcZ2DP1U0IMW5e+toX0GIPvzx6NbMdtTQ5epEUMcIDQ6wCH11cI8Y=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2019 18:32:58.4046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8028d9ff-c8e3-4896-5e6f-08d70e09dafd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4458
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=774 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210214
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

