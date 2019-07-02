Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE8C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4421479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iCBXr4id";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iexk2RXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGBNje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:39:34 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58166 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfGBNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:39:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62Db6x0025548;
        Tue, 2 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Y2YVSDcRYFsEN/CXbtkMobb4WgcXYr2WrvILIkho6/8=;
 b=iCBXr4idcl8tXdu/pn9XRm3Jck7YJ3V2x2Re002bJ7LbL/IYczQlHEKvFR9zwM7mIPun
 udMb75AyBicBtJRniXfeSOuBDSFoHMApuGnkdm+QLdsfKShJvD4CHsrZxeMnkOD5C/wc
 +P2F0KNxP7pnUAQfS0ldAs9n3Yq0AIwXixKzwBUOSXOSpEXIAbNcKt6q9Fb6fGoOLslj
 qa2fOMHjqtiYN3IJpXN0eK+c66/ywKNyxB/eUOd9c9dDMXK7XKVt3YEh0BHEPz3wCjpO
 tXbwxxYGm0OxCoCX3j7qomo+/WgvD3DJ7n2iOPOFlyjftMvM6querAnOdlmSK6A4fen6 Eg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2056.outbound.protection.outlook.com [104.47.49.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tg6v7rawp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2YVSDcRYFsEN/CXbtkMobb4WgcXYr2WrvILIkho6/8=;
 b=iexk2RXLpFitR7JLC9Y9qc2JKUat6q9Q/iMebQ0a2EWrP6U+gcqkZx17rfn5OBO9idq4XnvnhJ93u0h2bjsXyjO/yVUH+EZwvZGmmaDhWv02/sY4vVBha6wPuDApMthiMEotsD5qislWQ/lgC+e5eRU5gcFF5q0ZBe64Fqjcvhc=
Received: from CH2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:20::21)
 by SN6PR07MB5581.namprd07.prod.outlook.com (2603:10b6:805:ef::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Tue, 2 Jul
 2019 13:38:26 +0000
Received: from CO1NAM05FT059.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by CH2PR07CA0008.outlook.office365.com
 (2603:10b6:610:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.17 via Frontend
 Transport; Tue, 2 Jul 2019 13:38:26 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT059.mail.protection.outlook.com (10.152.96.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.8 via Frontend Transport; Tue, 2 Jul 2019 13:38:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKJx032652
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Jul 2019 06:38:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 2 Jul 2019 15:38:20 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 2 Jul 2019 15:38:20 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKVR032125;
        Tue, 2 Jul 2019 14:38:20 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x62DcKbq032124;
        Tue, 2 Jul 2019 14:38:20 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <robh+dt@kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <jpawar@cadence.com>,
        <kurahul@cadence.com>, <aniljoy@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v8 3/6] usb:gadget Patch simplify usb_decode_set_clear_feature function.
Date:   Tue, 2 Jul 2019 14:37:59 +0100
Message-ID: <1562074682-31579-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562074682-31579-1-git-send-email-pawell@cadence.com>
References: <1562074682-31579-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(36092001)(189003)(199004)(426003)(2351001)(51416003)(6666004)(316002)(7416002)(356004)(446003)(126002)(16586007)(4720700003)(54906003)(42186006)(476003)(107886003)(186003)(486006)(2616005)(76176011)(11346002)(36756003)(50466002)(26005)(6916009)(4326008)(76130400001)(70206006)(48376002)(50226002)(8676002)(7636002)(70586007)(478600001)(336012)(47776003)(8936002)(305945005)(26826003)(2906002)(246002)(87636003)(5660300002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5581;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9621b9bf-2d63-4d07-cf69-08d6fef28f5a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:SN6PR07MB5581;
X-MS-TrafficTypeDiagnostic: SN6PR07MB5581:
X-Microsoft-Antispam-PRVS: <SN6PR07MB558154E937E7044637E6F5CBDDF80@SN6PR07MB5581.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 008663486A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BtswPz/NSDcNAYvxYsAB5bC1Za+/L7pnkKWG6yQrAld16+YyBbTlvwjhAvEGn4OenP6ZurIcuRcrm/Sdvu/sNQ73NLYDKvm3ODAt9KQ8y7TfgNbo0zzsrkrm5VpGw/c4j+BSAik3Cj5fZUOekLnBOUaVh2nFF6z5j2mlfWIvhHYDHDo/RVbIn8COsOvI6aNL77IyXCwrK+sf2yNw+6B3O/7wTAEWQjQoZztl8ZpxAkxGROUnMoNYjaliDB3BcDBwqBAtRC40M9nSky5xVOTqqIEAUhjwPc7SUQ1NGBaR0iZGwG6Vz+hNT2tt4SyoICl0OCIvv+igRWmVH7zfO1tgB7UMoPkZ/27bYQ75CO2HMvzmYQmHgZY2N8yHOb2y2iJr5Q/NfHZrX+PJUoCx6V+uSBGNzolZDiXdBCe2fuWloVE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2019 13:38:25.6044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9621b9bf-2d63-4d07-cf69-08d6fef28f5a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5581
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=635 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usb_decode_test_mode and usb_decode_device_feature functions,
which allow to make more readable and simplify the
usb_decode_set_clear_feature function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/debug.c | 89 ++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/gadget/debug.c b/drivers/usb/gadget/debug.c
index d5a469bc67a3..60a9f70a0904 100644
--- a/drivers/usb/gadget/debug.c
+++ b/drivers/usb/gadget/debug.c
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

