Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06854C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E5206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nItX16im";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="J44rp+1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFEKE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:04:57 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59680 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727076AbfFEKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:04:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x559xP42029998;
        Wed, 5 Jun 2019 03:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=r0gYiwJzQV92TMPBis9FVhjpBcWRDA0PLJpUyjsrBGc=;
 b=nItX16imn39HNQY6mS1mmfppfdRLq9ACo7YYq77Ujcuttn5UyathPUknISPGkjWQ0w7q
 o3RFFPriZu2wO/XOxPw1XToYzacnE0GNwxG5xYFmFzcXCPB/jOB9spgH9Gi1RsOq1zvt
 +cwyE/svVGlyG6eHwS3iUKbyzomI6JlLQ9yciPFQV/vv4KHCpDUXgJRmwFvuLc0lw9u7
 RqqCDfe5VaRYoZX+N+TE7SqzdV+Rq8n4XYONTuNs7wUqEe8VEGO+w6RwPAZ0Q8XguEQX
 pNLvkH5nC585+/1ODxnkqJGG7O5tdJnVduLz87aScmxDDF8VAmv1Ata3tg7A5SadEjEP Hg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2051.outbound.protection.outlook.com [104.47.34.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2sun4qyd7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 05 Jun 2019 03:04:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0gYiwJzQV92TMPBis9FVhjpBcWRDA0PLJpUyjsrBGc=;
 b=J44rp+1GVtEu3iLr/dAoqYmoGRLZVObdwRj8F8O0/iaBcnM0M/BazgXzD0Gmcood+jrKQr9lxRlxVaNlSyT3uMCI6TAzf9ul5YaPVVXG7XrPlHxSF5N07pdfIb8Bss7JzovqJTctnSMccbBHYYPoVQYvae2cbtUGKqyf7jarO3k=
Received: from CY1PR07CA0038.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::48) by SN2PR07MB2494.namprd07.prod.outlook.com
 (2603:10b6:804:17::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.16; Wed, 5 Jun
 2019 10:04:19 +0000
Received: from CO1NAM05FT058.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by CY1PR07CA0038.outlook.office365.com
 (2a01:111:e400:c60a::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.13 via Frontend
 Transport; Wed, 5 Jun 2019 10:04:18 +0000
Received-SPF: PermError (protection.outlook.com: domain of cadence.com used an
 invalid SPF mechanism)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT058.mail.protection.outlook.com (10.152.96.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.10 via Frontend Transport; Wed, 5 Jun 2019 10:04:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x55A4Dqs028887
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 5 Jun 2019 03:04:17 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 5 Jun 2019 12:04:13 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 5 Jun 2019 12:04:13 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x55A4Dbl017306;
        Wed, 5 Jun 2019 11:04:13 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x55A4D2E017305;
        Wed, 5 Jun 2019 11:04:13 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v7 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Wed, 5 Jun 2019 11:03:47 +0100
Message-ID: <1559729030-16390-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1559729030-16390-1-git-send-email-pawell@cadence.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(448002)(199004)(189003)(36092001)(356004)(11346002)(2616005)(126002)(70206006)(476003)(86362001)(8936002)(446003)(51416003)(70586007)(4326008)(6666004)(4720700003)(5660300002)(36756003)(246002)(76176011)(16586007)(50466002)(316002)(76130400001)(87636003)(42186006)(2906002)(478600001)(26005)(54906003)(26826003)(48376002)(7416002)(50226002)(186003)(6916009)(47776003)(486006)(336012)(2351001)(8676002)(426003)(107886003)(305945005)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2494;H:sjmaillnx1.cadence.com;FPR:;SPF:PermError;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4cd0515-d622-406c-fde1-08d6e99d2c81
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:SN2PR07MB2494;
X-MS-TrafficTypeDiagnostic: SN2PR07MB2494:
X-Microsoft-Antispam-PRVS: <SN2PR07MB2494AE13E58A9FE05990838EDD160@SN2PR07MB2494.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VBANNB+dcaQkHztrTGxbHVDg/QWzE1uCQIszfY9tKAA6kHsSE8AHMZH1v9HRiG47ULKoEjwZTn3rHMOSAZ9HL2poeZRM5gIRTKtJoPPLjk8bJFpX1NirIg1CQ5vtmis0kiReubZXeFIt849gLf2r2e6BYy+v26p6S/Wd+UXMEdEnH+h8FeELLyqtf1pMKO0IQB8pKS1rCqqfVu3MRskI0ka8J4foCJNlxhMzZzZKijY/Tx6neJG3MmswBZZmRQeKhj2jkunjQOztGysVYmTgmdIyTKoY0MLG4hkj/vxt02DGhaWs3OlrdIJ+wIfnqKdYj0C7R8HtcZRKrzygNpHQv3+SEz5hrB6oAayZJfDoxF3ZBR41wLsCXNW2m/HvEQ4V1eWIl/L2oRJpXo+PnN7s26LerJOgoNq9Eudq3Nc6XAE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 10:04:18.1544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd0515-d622-406c-fde1-08d6e99d2c81
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2494
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050063
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
index f7218d794aa6..f948eb7d51b8 100644
--- a/drivers/usb/common/debug.c
+++ b/drivers/usb/common/debug.c
@@ -33,58 +33,55 @@ static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
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

