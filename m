Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8542133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cbi/TELh";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bMHAsw8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfDJFQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:16:52 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49964 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726978AbfDJFQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:16:52 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A5DVvf027669;
        Tue, 9 Apr 2019 22:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pQX05cqqIRIAlv/yFLTspatrIQjT2YjfWniHaF+2AbE=;
 b=Cbi/TELh/DjfXgZjGZfql1OyyD+7uYNXIkRG7zPA0qZKvTfaZv9N2xJOG4pFZU+SawyQ
 cSCbCe1lTgD5EUBHsOsoha0YG0sMu1bCZNu431jEfbH48OPIGptcBnShGMJZcqiHN5LM
 vLNbIiEBYE6n1j6kgoN6Nb3Pl+RfNxipYHnAalIrf6Wi5C9iNCDu7eqKp3wtbERGK5Yj
 lOYxos2E8Ngo88oxMLKrD4ofSOdx6Lm6/sJ2NfDZSTq7wvGpiUWGz25VzqOiRFdieKaL
 PPTO1S+HuazrSZJKfkJhz2pSDFu9D+PpC+mloLlKLYoc58CSWfCPAh71n+2U8I+P5NCi 0A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2050.outbound.protection.outlook.com [104.47.42.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2rsa27r11r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Apr 2019 22:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQX05cqqIRIAlv/yFLTspatrIQjT2YjfWniHaF+2AbE=;
 b=bMHAsw8yKKVtkt2fiWuwvhoweDw3BvILsXWPGCn8YkGXkmm2cpva5c0/vM5G3zHbeCS5g6FNYF1Ed9EOFYVp+8VuOnmeKAQyz/OllRww1Sacf37AvaIcJwnpSRizZbH1PURWZEKZbWAz4/WJ8NohKvevAc3UtZCZD/8JUYpUikY=
Received: from DM6PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:94::24) by
 SN1PR07MB2301.namprd07.prod.outlook.com (2a01:111:e400:7a45::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.21; Wed, 10 Apr
 2019 05:15:31 +0000
Received: from BY2NAM05FT033.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by DM6PR07CA0011.outlook.office365.com
 (2603:10b6:5:94::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.13 via Frontend
 Transport; Wed, 10 Apr 2019 05:15:31 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT033.mail.protection.outlook.com (10.152.100.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1792.7 via Frontend Transport; Wed, 10 Apr 2019 05:15:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FQQ9012370
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 9 Apr 2019 22:15:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 10 Apr 2019 07:15:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 10 Apr 2019 07:15:26 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x3A5FQxJ017236;
        Wed, 10 Apr 2019 06:15:26 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x3A5FQEn017235;
        Wed, 10 Apr 2019 06:15:26 +0100
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
Subject: [PATCH v5 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Wed, 10 Apr 2019 06:14:59 +0100
Message-ID: <1554873302-5624-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1554873302-5624-1-git-send-email-pawell@cadence.com>
References: <1554873302-5624-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(2980300002)(199004)(189003)(36092001)(76130400001)(6666004)(478600001)(2616005)(186003)(87636003)(476003)(4720700003)(6916009)(7416002)(47776003)(336012)(4326008)(26005)(356004)(11346002)(446003)(486006)(126002)(26826003)(36756003)(86362001)(107886003)(426003)(246002)(48376002)(5660300002)(76176011)(2351001)(8936002)(106466001)(2906002)(8676002)(50226002)(50466002)(54906003)(7636002)(105596002)(305945005)(51416003)(42186006)(316002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2301;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6faa391-4359-42e2-d4ce-08d6bd738d8c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328);SRVR:SN1PR07MB2301;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2301:
X-Microsoft-Antispam-PRVS: <SN1PR07MB230132D010103C46F748C6E6DD2E0@SN1PR07MB2301.namprd07.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RDvyXCSaTZQdF5nVkLZzBZAN2IdW015b859AqkWZYiKW5n2mSA60IM7UC9EPwi5hKpsxAPlcroPgLWQ6S+Utel8VDb50IShkzxI3s+GPMiAye73n3v3RAdVtcixQUcriAvmb+u8TaNyCcuoCaaAO22UnpTYJmvgcyC2RqPcsQM07GWs3j225XXMnRau5qlFir5XQjVF8r26CigzZpXf1ulaKDTA9evUk8TAB/W4g4120T/dYlJ8WW7begh0sJd+i6GzzyQ6YotDwAo6BOWWYt7JN+pobHmCq9+UR5YWphWGhxRQjiCvVum982UBrGK4zhKyt6SW4PMd1dHvNF8pNOsGYTIkn8qwwOHE9GXBXIjYQKZFLxR1mJnoJ/s8d5QvqdmIsCRKKP0/qohGDcc8X/i+1EvAsZjs3aGQtuvfhGDo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 05:15:31.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6faa391-4359-42e2-d4ce-08d6bd738d8c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2301
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=739 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
which allow to make more readable and simplify the
usb_decode_set_clear_feature function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/debug.c | 89 ++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
index 3fdf116da909..ad6c96aa45b0 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -30,58 +30,55 @@ static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
 	}
 }
 
-static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
-					 __u16 wValue, __u16 wIndex,
-					 char *str, size_t size)
+static const char *usb_decode_device_feature(u16 wValue)
+{
+	switch (wValue) {
+	case USB_DEVICE_SELF_POWERED:
+		return "Self Powered";
+	case USB_DEVICE_REMOTE_WAKEUP:
+		return "Remote Wakeup";
+	case USB_DEVICE_TEST_MODE:
+		return "Test Mode";
+	case USB_DEVICE_U1_ENABLE:
+		return "U1 Enable";
+	case USB_DEVICE_U2_ENABLE:
+		return "U2 Enable";
+	case USB_DEVICE_LTM_ENABLE:
+		return "LTM Enable";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static const char *usb_decode_test_mode(u16 wIndex)
+{
+	switch (wIndex) {
+	case TEST_J:
+		return ": TEST_J";
+	case TEST_K:
+		return ": TEST_K";
+	case TEST_SE0_NAK:
+		return ": TEST_SE0_NAK";
+	case TEST_PACKET:
+		return ": TEST_PACKET";
+	case TEST_FORCE_EN:
+		return ": TEST_FORCE_EN";
+	default:
+		return ": UNKNOWN";
+	}
+}
+
+static void usb_decode_set_clear_feature(__u8 bRequestType,
+					 __u8 bRequest, __u16 wValue,
+					 __u16 wIndex, char *str, size_t size)
 {
 	switch (bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
 		snprintf(str, size, "%s Device Feature(%s%s)",
 			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			 ({char *s;
-				switch (wValue) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
+			 usb_decode_device_feature(wValue),
 			 wValue == USB_DEVICE_TEST_MODE ?
-			 ({ char *s;
-				switch (wIndex) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
+			 usb_decode_test_mode(wIndex) : "");
 		break;
 	case USB_RECIP_INTERFACE:
 		snprintf(str, size, "%s Interface Feature(%s)",
-- 
2.17.1

