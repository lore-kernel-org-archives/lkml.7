Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8E208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="A+3K+7We";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OaVzu/pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGBNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:39:57 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5742 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfGBNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:39:57 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62Db6x1025548;
        Tue, 2 Jul 2019 06:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VOdplaV2+pR+xHGJesxGPR9cmVOMXdmBssd0b917VX4=;
 b=A+3K+7WewurkO11v4NUP9DOZjiMxV8PdU3kQq3oLK4u6h3qmaeQy6b4s66CJuDhsIqwN
 hMy2IYfL1pg762FZNhL51AzWTOh3o/loy8O5Q+PxN4Soq4a0U6Et/EsX0jvJKWMRYnkK
 VM4OYtfIELgT1Kq10jq2kSVkcCCwjcLCPHTl39S+4I/xhawshUkYcGhN8SmaUQyWTWbc
 FdQ8Y1gpE6bPhY5SAcHKlaR+8GzT5VI4OBvdsNv3fH4h7ODzOZgJiPqLLQP0CZ7xmsx5
 J8wz0zLKPX7szCVzBUuak/AgfWY8jJOy9WmGBRzX4cJgpBsA6p2LEftk4FxiRuiaX3Og eQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2054.outbound.protection.outlook.com [104.47.40.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2tg6v7rawr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 06:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOdplaV2+pR+xHGJesxGPR9cmVOMXdmBssd0b917VX4=;
 b=OaVzu/prQQyl3XXIJA9xUDC6R4Jfh2mUYENbfbvmMOeGoZiuQFMrGfdD/WUim4r4UBoOt9PUeMUpA3Si4JibR4oM//HemUUgHvxjyQnZSN/qjWF6zj8oD5SgNR2Ejg++MNEgTjsH5y8DDtKZiI0mn0ZGXdPWUkzPIj263EAkt9g=
Received: from DM5PR07CA0029.namprd07.prod.outlook.com (2603:10b6:3:16::15) by
 BN3PR07MB2626.namprd07.prod.outlook.com (2a01:111:e400:c5f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Tue, 2 Jul
 2019 13:38:26 +0000
Received: from CO1NAM05FT034.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by DM5PR07CA0029.outlook.office365.com
 (2603:10b6:3:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Tue, 2 Jul 2019 13:38:25 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT034.mail.protection.outlook.com (10.152.96.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.8 via Frontend Transport; Tue, 2 Jul 2019 13:38:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKJw032652
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
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcJnX032120;
        Tue, 2 Jul 2019 14:38:19 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x62DcJ0s032119;
        Tue, 2 Jul 2019 14:38:19 +0100
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
Subject: [PATCH v8 2/6] usb:gadget Separated decoding functions from dwc3 driver.
Date:   Tue, 2 Jul 2019 14:37:58 +0100
Message-ID: <1562074682-31579-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562074682-31579-1-git-send-email-pawell@cadence.com>
References: <1562074682-31579-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(36092001)(76176011)(478600001)(87636003)(2351001)(54906003)(5660300002)(107886003)(26005)(7636002)(42186006)(246002)(2616005)(36756003)(6306002)(476003)(446003)(53386004)(186003)(50466002)(30864003)(11346002)(16586007)(7416002)(336012)(126002)(4720700003)(6666004)(70586007)(316002)(4326008)(14444005)(70206006)(305945005)(50226002)(356004)(48376002)(86362001)(8936002)(51416003)(76130400001)(966005)(486006)(8676002)(2906002)(47776003)(26826003)(6916009)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2626;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba25787-a2f4-4e00-30ca-08d6fef28f28
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN3PR07MB2626;
X-MS-TrafficTypeDiagnostic: BN3PR07MB2626:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN3PR07MB2626FE57B830335E37528B78DDF80@BN3PR07MB2626.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-Forefront-PRVS: 008663486A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BUyYvrHYqagNVFjRNxkapvgTSkZwFQgMxLDo5Strwx8XOjx7Fxy+OAuC02NYEg4bcYaOFaxNL1dyp8ZTFgcCzubPdoYyLg+irveA3SMybY4Pxitw5gYghW/hWNTk0aTA49uiMcuEAmpracgfJDJ7FOYmrSiFrLJl0Fusy+IL1EwIkKIEjVszW2rRYTVZJm6iyyRWby+cESy3sk0Z0iqKCooh2jetPxIA7xSCXpNIaKXv8+G9le2tiPH1AgLeQv8AmGi2F8Snttt9yxicn/VK+LXeL2wYce0HVnUOKmyHSToH/jLNSh9saaXXUv363jizcMAgZf1ZMPJ6QKBB8Xscn4TUXzgOuXVaZ7M79JtL7Rcepf7kmIqc+Afz/NvfCeECOkxcGFB1xBAzFuoUTtNhN6kpSzK7x7L4X4lz+V2DH8E=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2019 13:38:25.2637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba25787-a2f4-4e00-30ca-08d6fef28f28
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2626
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
to driver/usb/gadget/debug.c file. These moved functions include:
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
include/linux/usb/gadget.h file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/dwc3/debug.h    | 252 ---------------------------------
 drivers/usb/dwc3/trace.h    |   2 +-
 drivers/usb/gadget/Makefile |   1 +
 drivers/usb/gadget/debug.c  | 268 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h  |  26 ++++
 5 files changed, 296 insertions(+), 253 deletions(-)
 create mode 100644 drivers/usb/gadget/debug.c

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
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 130dad7130b6..500a5a592abe 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -9,5 +9,6 @@ ccflags-y				+= -I$(srctree)/drivers/usb/gadget/udc
 obj-$(CONFIG_USB_LIBCOMPOSITE)	+= libcomposite.o
 libcomposite-y			:= usbstring.o config.o epautoconf.o
 libcomposite-y			+= composite.o functions.o configfs.o u_f.o
+libcomposite-y			+= debug.o
 
 obj-$(CONFIG_USB_GADGET)	+= udc/ function/ legacy/
diff --git a/drivers/usb/gadget/debug.c b/drivers/usb/gadget/debug.c
new file mode 100644
index 000000000000..d5a469bc67a3
--- /dev/null
+++ b/drivers/usb/gadget/debug.c
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
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index fb19141151d8..42902fcc8696 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -889,4 +889,30 @@ extern void usb_ep_autoconfig_release(struct usb_ep *);
 
 extern void usb_ep_autoconfig_reset(struct usb_gadget *);
 
+/*-------------------------------------------------------------------------*/
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
+			__u8 bRequest, __u16 wValue, __u16 wIndex,
+			__u16 wLength);
+
 #endif /* __LINUX_USB_GADGET_H */
-- 
2.17.1

