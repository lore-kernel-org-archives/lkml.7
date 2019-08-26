Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23994C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE642070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="f2dRlRI1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AViT44/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfHZLUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:38 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34042 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726866AbfHZLUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBHkR4027355;
        Mon, 26 Aug 2019 04:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MUuRHAsmgvxHSfidBQBVUgX4QtNAPMsO+VeekMTbcl4=;
 b=f2dRlRI14qoTXZPoYk8z8+VEcmlfgueGohgmK+h8hFJIsS+QFiPOESyBsWxccCQqQbij
 WcdiSQUbeBrfT6sB28m8Ak7RXgZzur/DVuJhesrizxna8jSICMms7V6fTGtz956CJ3h+
 vQPLX1DDRkheW/SKAqIGqHUwtgsPYvWjFScAoJeb3wccW+DYpVrDo/IolRRdC05WkE8Y
 lYLVin1duuBGDOp1aZVfRosj5PjauBALaycJu3w5Okzsb24ZNObIGnplrjIutn+f/ApZ
 XUqxoKS9MDy8TeZwnZJP9OAx4Gu9XXnDHKss4XVfhvywRPzgnYhrl9QzcuRgFtJVKZvh sg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2uk28kx08r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuXLISLfktxNiKISaQrVtod26kRhakyNNghvYj09aZ6LhqKVzFS5XwS43t6CiFJ0gOGv1vXtTvPUebupdAeW4NFgIMaF8RIfRhr/uT1g9oSUglcYaA7eSQG9xDcYvIVBN1DmydRLWY8d/JeTHEUE3r7D1Hp1NIUf0+ocQVeXjiYKr1ERSIUxd5fiptpqeq/8KpiRcNM2IUyKaxZKdMGK3fLbmj0dKeNSjctuKSEDjrPefDt5wNy5WnCwBaZ0OtSZeQyCB+zuCI/C7zO4HppqIP64rlhZsTLoJ7ymlp7uEwXgqQtbjCYPq9B78iO+crpvIuCDRIKU/dg3X6moKKzwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUuRHAsmgvxHSfidBQBVUgX4QtNAPMsO+VeekMTbcl4=;
 b=EeTKPK+3F2tDkdcgiLvx4DMn2Ql35kMKbVpWWmRunex38hKj6Ks9tGSyYwKOc/fURo74voWGxmgjnCr2BKLatmjKFKJSm4fJomteSeC4I4stfEhMgi5s8J8hi1hAuYZMj2zF6UeY8yOFjPezksJl5h0WG2qUInEpGqz5ialR6byP59nXVHuUinwxurFUr7KvwEzZEFLrYEjuuHYVdYGnmDr5SAUpyX1B83H469X3njYj3k6ebogYxmd5k6g9GecguL4qKfODavHW/NI9WJjDhO7VSBHzGdNXJm+0nX+aFptPOdBGO7+8sMS7y2wrLgcNjY2mEko4w9uiw3OJalKhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUuRHAsmgvxHSfidBQBVUgX4QtNAPMsO+VeekMTbcl4=;
 b=AViT44/5u4QuPJFhQ9BY0wSNw0rYZC91sz1Gu1zRYP4Uea+IY4XJ2TzMwDt09NB1G4SBSKnUoUBKcUusmeIzQG7QBiiooZzzhV4yteT7k9mQ0HaSXOaSzvQa1eaXxMxQqPbdaQ7uzJRvE2S/JCpmCNBgt8vFufZ/pbReQRqpxUM=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 BYAPR07MB4344.namprd07.prod.outlook.com (2603:10b6:a02:c0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 26 Aug 2019 11:20:14 +0000
Received: from BY2NAM05FT040.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT040.mail.protection.outlook.com (10.152.100.177) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WS001206
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 26 Aug 2019 04:20:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 26 Aug 2019 13:20:10 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 13:20:10 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9ka029075;
        Mon, 26 Aug 2019 12:20:09 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBK96x029074;
        Mon, 26 Aug 2019 12:20:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 2/6] usb:common Separated decoding functions from dwc3 driver.
Date:   Mon, 26 Aug 2019 12:19:27 +0100
Message-ID: <1566818371-27721-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1566818371-27721-1-git-send-email-pawell@cadence.com>
References: <1566818371-27721-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(36092001)(189003)(199004)(76176011)(478600001)(51416003)(11346002)(316002)(8936002)(48376002)(126002)(26826003)(966005)(426003)(50466002)(54906003)(4720700003)(336012)(30864003)(5660300002)(4326008)(76130400001)(42186006)(87636003)(50226002)(446003)(2351001)(70586007)(2616005)(476003)(70206006)(486006)(6306002)(7636002)(86362001)(8676002)(305945005)(26005)(186003)(6916009)(16586007)(6666004)(36756003)(356004)(14444005)(107886003)(53386004)(246002)(7416002)(47776003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4344;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a920c4-da20-4477-ed91-08d72a175d3c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328);SRVR:BYAPR07MB4344;
X-MS-TrafficTypeDiagnostic: BYAPR07MB4344:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BYAPR07MB43448D0640ACD060AA242383DDA10@BYAPR07MB4344.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZbZ47znY92CoOts9+Cl0QJjp/vOgBLPlGx1H/D+T0+lPowSKeJhGkJUfyLRR4eX8bg5NdHnJgaMibQPD2yyBoQPvwYHZUcd2Zd6Ut0/vp/WGpFmqqp/vJMegMEe6Ew+Uo2eeuJYLRJCOP0KvSSedISNZrnU9dMdZqbsO9l1zfclHGZURzRfWqVpSg2Yg5hAry4YlPc+G6JMKG66WOI7EsjHfA44p9dFnWNYh2kYfxDwgCJpKhNGpJ9tMDq9E8Xxugezl8qTzyvyBJEWKBhgsd5wE4Pv8nLW9MoxNgylpNpbEJICbYpejme2H97U8Q9hgEp6KEnjNKvPop7p0vOd3BBdvAAvFl0HOTciwwbziLcpR+ZKB+5EG622PULvtq4tE55CclJ8zZfL6AWkcDyZHh7Rl++W5pIh8ODrWzmhTEzs=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:13.2422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a920c4-da20-4477-ed91-08d72a175d3c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4344
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=1 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908260126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
to driver/usb/common/debug.c file. These moved functions include:
    dwc3_decode_get_status
    dwc3_decode_set_clear_feature
    dwc3_decode_set_address
    dwc3_decode_get_set_descriptor
    dwc3_decode_get_configuration
    dwc3_decode_set_configuration
    dwc3_decode_get_intf
    dwc3_decode_set_intf
    dwc3_decode_synch_frame
    dwc3_decode_set_sel
    dwc3_decode_set_isoch_delay
    dwc3_decode_ctrl

These functions are used also in inroduced cdns3 driver.

All functions prefixes were changed from dwc3 to usb.
Also, function's parameters has been extended according to the name
of fields in standard SETUP packet.
Additionally, patch adds usb_decode_ctrl function to
include/linux/usb/ch9.h file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/common/Makefile |   1 +
 drivers/usb/common/debug.c  | 268 ++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/debug.h    | 252 ---------------------------------
 drivers/usb/dwc3/trace.h    |   2 +-
 include/linux/usb/ch9.h     |  27 ++++
 5 files changed, 297 insertions(+), 253 deletions(-)
 create mode 100644 drivers/usb/common/debug.c

diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 0a7c45e85481..76f3e80623db 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_USB_COMMON)	  += usb-common.o
 usb-common-y			  += common.o
+usb-common-$(CONFIG_TRACING)	  += debug.o
 usb-common-$(CONFIG_USB_LED_TRIG) += led.o
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
diff --git a/drivers/usb/common/debug.c b/drivers/usb/common/debug.c
new file mode 100644
index 000000000000..d5a469bc67a3
--- /dev/null
+++ b/drivers/usb/common/debug.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Common USB debugging functions
+ *
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: Felipe Balbi <balbi@ti.com>,
+ *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+ */
+
+#include <linux/usb/ch9.h>
+
+static void usb_decode_get_status(__u8 bRequestType, __u16 wIndex,
+				  __u16 wLength, char *str, size_t size)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "Get Device Status(Length = %d)", wLength);
+		break;
+	case USB_RECIP_INTERFACE:
+		snprintf(str, size,
+			 "Get Interface Status(Intf = %d, Length = %d)",
+			 wIndex, wLength);
+		break;
+	case USB_RECIP_ENDPOINT:
+		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
+			 wIndex & ~USB_DIR_IN,
+			 wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_clear_feature(__u8 bRequestType, __u8 bRequest,
+					 __u16 wValue, __u16 wIndex,
+					 char *str, size_t size)
+{
+	switch (bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "%s Device Feature(%s%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 ({char *s;
+				switch (wValue) {
+				case USB_DEVICE_SELF_POWERED:
+					s = "Self Powered";
+					break;
+				case USB_DEVICE_REMOTE_WAKEUP:
+					s = "Remote Wakeup";
+					break;
+				case USB_DEVICE_TEST_MODE:
+					s = "Test Mode";
+					break;
+				case USB_DEVICE_U1_ENABLE:
+					s = "U1 Enable";
+					break;
+				case USB_DEVICE_U2_ENABLE:
+					s = "U2 Enable";
+					break;
+				case USB_DEVICE_LTM_ENABLE:
+					s = "LTM Enable";
+					break;
+				default:
+					s = "UNKNOWN";
+				} s; }),
+			 wValue == USB_DEVICE_TEST_MODE ?
+			 ({ char *s;
+				switch (wIndex) {
+				case TEST_J:
+					s = ": TEST_J";
+					break;
+				case TEST_K:
+					s = ": TEST_K";
+					break;
+				case TEST_SE0_NAK:
+					s = ": TEST_SE0_NAK";
+					break;
+				case TEST_PACKET:
+					s = ": TEST_PACKET";
+					break;
+				case TEST_FORCE_EN:
+					s = ": TEST_FORCE_EN";
+					break;
+				default:
+					s = ": UNKNOWN";
+				} s; }) : "");
+		break;
+	case USB_RECIP_INTERFACE:
+		snprintf(str, size, "%s Interface Feature(%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 wValue == USB_INTRF_FUNC_SUSPEND ?
+			 "Function Suspend" : "UNKNOWN");
+		break;
+	case USB_RECIP_ENDPOINT:
+		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
+			 bRequest == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			 wValue == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
+			 wIndex & ~USB_DIR_IN,
+			 wIndex & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static void usb_decode_set_address(__u16 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Address(Addr = %02x)", wValue);
+}
+
+static void usb_decode_get_set_descriptor(__u8 bRequestType, __u8 bRequest,
+					  __u16 wValue, __u16 wIndex,
+					  __u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
+		 bRequest == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		 ({ char *s;
+			switch (wValue >> 8) {
+			case USB_DT_DEVICE:
+				s = "Device";
+				break;
+			case USB_DT_CONFIG:
+				s = "Configuration";
+				break;
+			case USB_DT_STRING:
+				s = "String";
+				break;
+			case USB_DT_INTERFACE:
+				s = "Interface";
+				break;
+			case USB_DT_ENDPOINT:
+				s = "Endpoint";
+				break;
+			case USB_DT_DEVICE_QUALIFIER:
+				s = "Device Qualifier";
+				break;
+			case USB_DT_OTHER_SPEED_CONFIG:
+				s = "Other Speed Config";
+				break;
+			case USB_DT_INTERFACE_POWER:
+				s = "Interface Power";
+				break;
+			case USB_DT_OTG:
+				s = "OTG";
+				break;
+			case USB_DT_DEBUG:
+				s = "Debug";
+				break;
+			case USB_DT_INTERFACE_ASSOCIATION:
+				s = "Interface Association";
+				break;
+			case USB_DT_BOS:
+				s = "BOS";
+				break;
+			case USB_DT_DEVICE_CAPABILITY:
+				s = "Device Capability";
+				break;
+			case USB_DT_PIPE_USAGE:
+				s = "Pipe Usage";
+				break;
+			case USB_DT_SS_ENDPOINT_COMP:
+				s = "SS Endpoint Companion";
+				break;
+			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+				s = "SSP Isochronous Endpoint Companion";
+				break;
+			default:
+				s = "UNKNOWN";
+				break;
+			} s; }), wValue & 0xff, wLength);
+}
+
+static void usb_decode_get_configuration(__u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "Get Configuration(Length = %d)", wLength);
+}
+
+static void usb_decode_set_configuration(__u8 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Configuration(Config = %d)", wValue);
+}
+
+static void usb_decode_get_intf(__u16 wIndex, __u16 wLength, char *str,
+				size_t size)
+{
+	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)",
+		 wIndex, wLength);
+}
+
+static void usb_decode_set_intf(__u8 wValue, __u16 wIndex, char *str,
+				size_t size)
+{
+	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)",
+		 wIndex, wValue);
+}
+
+static void usb_decode_synch_frame(__u16 wIndex, __u16 wLength,
+				   char *str, size_t size)
+{
+	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)",
+		 wIndex, wLength);
+}
+
+static void usb_decode_set_sel(__u16 wLength, char *str, size_t size)
+{
+	snprintf(str, size, "Set SEL(Length = %d)", wLength);
+}
+
+static void usb_decode_set_isoch_delay(__u8 wValue, char *str, size_t size)
+{
+	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", wValue);
+}
+
+/**
+ * usb_decode_ctrl - returns a string representation of ctrl request
+ */
+const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
+			    __u8 bRequest, __u16 wValue, __u16 wIndex,
+			    __u16 wLength)
+{
+	switch (bRequest) {
+	case USB_REQ_GET_STATUS:
+		usb_decode_get_status(bRequestType, wIndex, wLength, str, size);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+		usb_decode_set_clear_feature(bRequestType, bRequest, wValue,
+					     wIndex, str, size);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		usb_decode_set_address(wValue, str, size);
+		break;
+	case USB_REQ_GET_DESCRIPTOR:
+	case USB_REQ_SET_DESCRIPTOR:
+		usb_decode_get_set_descriptor(bRequestType, bRequest, wValue,
+					      wIndex, wLength, str, size);
+		break;
+	case USB_REQ_GET_CONFIGURATION:
+		usb_decode_get_configuration(wLength, str, size);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		usb_decode_set_configuration(wValue, str, size);
+		break;
+	case USB_REQ_GET_INTERFACE:
+		usb_decode_get_intf(wIndex, wLength, str, size);
+		break;
+	case USB_REQ_SET_INTERFACE:
+		usb_decode_set_intf(wValue, wIndex, str, size);
+		break;
+	case USB_REQ_SYNCH_FRAME:
+		usb_decode_synch_frame(wIndex, wLength, str, size);
+		break;
+	case USB_REQ_SET_SEL:
+		usb_decode_set_sel(wLength, str, size);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		usb_decode_set_isoch_delay(wValue, str, size);
+		break;
+	default:
+		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
+			 bRequestType, bRequest,
+			 (u8)(cpu_to_le16(wValue) & 0xff),
+			 (u8)(cpu_to_le16(wValue) >> 8),
+			 (u8)(cpu_to_le16(wIndex) & 0xff),
+			 (u8)(cpu_to_le16(wIndex) >> 8),
+			 (u8)(cpu_to_le16(wLength) & 0xff),
+			 (u8)(cpu_to_le16(wLength) >> 8));
+	}
+
+	return str;
+}
+EXPORT_SYMBOL_GPL(usb_decode_ctrl);
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 068259fdfb0c..9baabed87d61 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -246,258 +246,6 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
-		size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "Get Device Status(Length = %d)", l);
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
-				i, l);
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-		__u16 i, char *str, size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "%s Device Feature(%s%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (v) {
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
-			v == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (i) {
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
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "%s Interface Feature(%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_INTRF_FUNC_SUSPEND ?
-			"Function Suspend" : "UNKNOWN");
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_address(__u16 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Address(Addr = %02x)", v);
-}
-
-static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-		__u16 i, __u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (v >> 8) {
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
-			} s; }), v & 0xff, l);
-}
-
-
-static inline void dwc3_decode_get_configuration(__u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Configuration(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_configuration(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Configuration(Config = %d)", v);
-}
-
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str, size_t size)
-{
-	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
-}
-
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_sel(__u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "Set SEL(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", v);
-}
-
-/**
- * dwc3_decode_ctrl - returns a string represetion of ctrl request
- */
-static inline const char *dwc3_decode_ctrl(char *str, size_t size,
-		__u8 bRequestType, __u8 bRequest, __u16 wValue, __u16 wIndex,
-		__u16 wLength)
-{
-	switch (bRequest) {
-	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str,
-				size);
-		break;
-	case USB_REQ_CLEAR_FEATURE:
-	case USB_REQ_SET_FEATURE:
-		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-				wIndex, str, size);
-		break;
-	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str, size);
-		break;
-	case USB_REQ_GET_DESCRIPTOR:
-	case USB_REQ_SET_DESCRIPTOR:
-		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-				wIndex, wLength, str, size);
-		break;
-	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str, size);
-		break;
-	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str, size);
-		break;
-	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str, size);
-		break;
-	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str, size);
-		break;
-	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str, size);
-		break;
-	default:
-		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
-			bRequestType, bRequest,
-			cpu_to_le16(wValue) & 0xff,
-			cpu_to_le16(wValue) >> 8,
-			cpu_to_le16(wIndex) & 0xff,
-			cpu_to_le16(wIndex) >> 8,
-			cpu_to_le16(wLength) & 0xff,
-			cpu_to_le16(wLength) >> 8);
-	}
-
-	return str;
-}
-
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index 818a63da1a44..9edff17111f7 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -86,7 +86,7 @@ DECLARE_EVENT_CLASS(dwc3_log_ctrl,
 		__entry->wIndex = le16_to_cpu(ctrl->wIndex);
 		__entry->wLength = le16_to_cpu(ctrl->wLength);
 	),
-	TP_printk("%s", dwc3_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
+	TP_printk("%s", usb_decode_ctrl(__get_str(str), DWC3_MSG_MAX,
 					__entry->bRequestType,
 					__entry->bRequest, __entry->wValue,
 					__entry->wIndex, __entry->wLength)
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index da82606be605..58b83066bea4 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -70,4 +70,31 @@ extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
  */
 extern const char *usb_state_string(enum usb_device_state state);
 
+#ifdef CONFIG_TRACING
+/**
+ * usb_decode_ctrl - Returns human readable representation of control request.
+ * @str: buffer to return a human-readable representation of control request.
+ *       This buffer should have about 200 bytes.
+ * @size: size of str buffer.
+ * @bRequestType: matches the USB bmRequestType field
+ * @bRequest: matches the USB bRequest field
+ * @wValue: matches the USB wValue field (CPU byte order)
+ * @wIndex: matches the USB wIndex field (CPU byte order)
+ * @wLength: matches the USB wLength field (CPU byte order)
+ *
+ * Function returns decoded, formatted and human-readable description of
+ * control request packet.
+ *
+ * The usage scenario for this is for tracepoints, so function as a return
+ * use the same value as in parameters. This approach allows to use this
+ * function in TP_printk
+ *
+ * Important: wValue, wIndex, wLength parameters before invoking this function
+ * should be processed by le16_to_cpu macro.
+ */
+extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
+				   __u8 bRequest, __u16 wValue, __u16 wIndex,
+				   __u16 wLength);
+#endif
+
 #endif /* __LINUX_USB_CH9_H */
-- 
2.17.1

