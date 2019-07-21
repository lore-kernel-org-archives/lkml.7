Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70542C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86442083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 18:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="rzvolQrC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gSUP7elq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGUSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 14:33:08 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48652 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbfGUSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:33:07 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LIT2er010946;
        Sun, 21 Jul 2019 11:33:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=rzvolQrCS9dwl73fY6714eje5anN4+pLbh9/7gQWU7xH7Lz5YH/zLvQo1FyO4zLnm/98
 8FDlEm0VhvTIGruuD0SUeoyYwgt1hWK47aSfLWWBlzG3PYaPxW/piUTF2yye/xDXdevo
 U/qgKFq0IMNKo6ZHUYOA5t/s2wHHOT0jL2F8hIg5jgWNdOV5BAYkNpzjyzJgidGufhFq
 5sbXMKGGPOgq2Wf17iSOzE+iePl41Z3bTsDdbyFlji65EcL7pS0RJBdiW/eVQkNYIZs/
 SJzfJTEOFPBtRCYv5gTpTneM0pYf3gkVjsGsiCVJT/aRgbUZPYfPKORVCHV8CSLmDfzM Sw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2tuxhwc1x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 11:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhQO0q7ihYXwWsrJO/+BnJaZlDK1yRficQVH+hGGbTlw/BccTg4L3LuXRZMIytl2/Fe2R1GvzB1of1q5FWCY/ACX50bE7nKxN/fj4L0MVP9mIZ7MW0eabIa5oV5VzQO48ZfebrnZvM5WEJAzAQf9cgOZUZ1Llvk0zR9caJcpNegC0odwHI39deziPYUZ+2YkCP2hJZaK6krAJ9zbtE/c/vw7febM1+N/fQ++ZwJcjr6dX1Ub+5g9OnCxF6fHezV6s7pPCYgaP/txjcfolM6z9CB9Q5HVuMYrlfSiWhnC4VO93mZYshIP9a3KE5RluOnKe5TpAFjGGlFmGB8KwFj0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=j083MuF+zn8Zsja8UU+rNBRrMm4G1/mmausaLbUPpeUfD6bq5qPQsqXG5s+jGzdmvzy40jbSkEdrsAnt/kib+UuYIXMzTyOOe0yWGfaPshTSiLoUXab1zgqYNSL222216v1qb3QJjJ93Y4+CAM19fWGaNUBZjfYrxxiZs7Wk1R6je+kfyWtJsrVb5hwZ/dfYbNAjUVrXVKQR1GplyhCPM6+m2lrhxqOJyk83YIrs4FuTQAtGn1S2P9Lf79a48cEe0FgFlApTP8sMYnCJWMJrNyK6sxjD81mv3Ux+s0cNDuVbXiVxTKO/zmcaG7zKmlhQqMiaLJnt/Oom7OF7EstrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=softfail (sender ip is
 199.43.4.28) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cadence.com;dmarc=fail (p=none sp=none pct=100) action=none
 header.from=cadence.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=gSUP7elqJwJO+/XDv4gXPaumAVdG7B0TdxLa2g6nGbiQYqcqq3Ye1chR5OmzJCGEVTLCpKWSZW/nYCBIAsAKufFHhMQJ6iHK5TKWYXio7U825zBKCAYVBGCz4lLb5OF0ofN7cnApaCp8oDG0D3STj6PO3aLJG/9OGAVsvMUwWok=
Received: from MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15)
 by MN2PR07MB6526.namprd07.prod.outlook.com (2603:10b6:208:163::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Sun, 21 Jul
 2019 18:32:58 +0000
Received: from CO1NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by MN2PR07CA0005.outlook.office365.com
 (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12 via Frontend
 Transport; Sun, 21 Jul 2019 18:32:58 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT039.mail.protection.outlook.com (10.152.96.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.4 via Frontend Transport; Sun, 21 Jul 2019 18:32:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWoeW006437
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 21 Jul 2019 14:32:55 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 21 Jul 2019 20:32:50 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 21 Jul 2019 20:32:50 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x6LIWoGF022412;
        Sun, 21 Jul 2019 19:32:50 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x6LIWomr022411;
        Sun, 21 Jul 2019 19:32:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v10 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Sun, 21 Jul 2019 19:32:16 +0100
Message-ID: <1563733939-21214-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(36092001)(199004)(189003)(305945005)(486006)(81156014)(81166006)(8676002)(36756003)(26826003)(8936002)(478600001)(5660300002)(356004)(6666004)(47776003)(446003)(4720700003)(6916009)(48376002)(86362001)(68736007)(50466002)(87636003)(54906003)(16586007)(42186006)(316002)(76130400001)(70586007)(186003)(26005)(336012)(69596002)(426003)(50226002)(70206006)(53936002)(2351001)(76176011)(2906002)(11346002)(4326008)(476003)(51416003)(107886003)(126002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6526;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b344dc-8d30-418f-d741-08d70e09da72
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MN2PR07MB6526;
X-MS-TrafficTypeDiagnostic: MN2PR07MB6526:
X-Microsoft-Antispam-PRVS: <MN2PR07MB65261F63BE0A6B3D328E962DDDC50@MN2PR07MB6526.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 0105DAA385
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PdEFqMG1onLHpMWRC9vdz7a6Ju5sptRYbfpY3GBpuj1pYUtbFdZidD1g2mDF2XQoYn0OLSPq8BfbyInbod/sRbtxgs5beTvGGM7Ww8P9scnUITGnzcG8q8edeA0L2UDnJgwV/uiNLZZBFszIYU3GCJZPuXlwNpfki+ewphE7Bz9i0dxnCJpsX3QiXaoeMxp/Q7OCrE9fIgMuseLtZPcVQXW4RyDH/f/2wgCzeoTYFpqwX0/XKm8sl/bXBDi3DCnNJfkpWI//FbT0M6GeibpjMso5agvPFvE0qVoOUNXoyfmdUnYo8ZCLfOtBs6FqGOgk1X7m/cxorXposmD8ItXH3Ipfmb0d4B4PsDEGA9HH9gO8DWb7rZEEwjN2DcYKP3yQKtRMblBpKyqNWmuqXxA8nijOT9AtZMF1j8kxdByDSts=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2019 18:32:57.4775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b344dc-8d30-418f-d741-08d70e09da72
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6526
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
 mlxlogscore=663 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210214
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
index d5a469bc67a3..60a9f70a0904 100644
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

