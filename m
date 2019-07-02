Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740BAC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394C921479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pZ93zdRq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fevUCKJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGBNj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:39:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29922 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfGBNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:39:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62DSmUh025110;
        Tue, 2 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GNgMm9XPwhweQlNx7kt/iMw6LkU8ToUPf30LRLYSw0Q=;
 b=pZ93zdRqPfTxboaaLKjAzD/9BMy0bV4XTHzNsapve9JaEu1Fe+OcmBMzlPIsgBqJ2f31
 gydbnGlaCuh08E+nWUAzU4pA7uvtekcSxCZJ8WPcSJeBVfQFKLHMs5hobNoYclCxHUk1
 QRY8KshDZPY23ZIOXfExI9FORr3VDsgqF+NUrErcEwdAp8/4zpFwOT0mZeMbdAReQ1hJ
 lmpG8nT9J2aKO9rGPTSPebkLG3q7Fns8MdUr/Lp2euf1ScxBJxVlv7hqOIW2jO+M27/U
 S8+IB2lJdOZSxdiX8VsilRr080yK9tcZponBlpNnZ+NPtASPl6WuWTmsh9p8VFBF9LIl eA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2052.outbound.protection.outlook.com [104.47.33.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2te3jx49rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 06:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNgMm9XPwhweQlNx7kt/iMw6LkU8ToUPf30LRLYSw0Q=;
 b=fevUCKJYN21fK/S2WUUXaL1DE7xZvZSk7E0z68jztUJp7ULyVLMt5UMoS0zPFhJXYbE3321qkXMLilB57EFCnwC0Z/aFVUIFarxQJpqKsII7sqahOEUMs2ktoc0j5a8TM3Vjt110p84yR8+GO6qalEtJsZmO3fbh4mwO/uNLAhw=
Received: from DM5PR07CA0047.namprd07.prod.outlook.com (2603:10b6:3:16::33) by
 DM5PR07MB3593.namprd07.prod.outlook.com (2603:10b6:4:68::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 13:38:27 +0000
Received: from CO1NAM05FT046.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by DM5PR07CA0047.outlook.office365.com
 (2603:10b6:3:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.18 via Frontend
 Transport; Tue, 2 Jul 2019 13:38:26 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT046.mail.protection.outlook.com (10.152.96.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.8 via Frontend Transport; Tue, 2 Jul 2019 13:38:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKK0032652
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 2 Jul 2019 06:38:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 2 Jul 2019 15:38:20 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 2 Jul 2019 15:38:20 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x62DcKYT032134;
        Tue, 2 Jul 2019 14:38:20 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x62DcKPn032133;
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
Subject: [PATCH v8 4/6] usb:gadget Simplify usb_decode_get_set_descriptor function.
Date:   Tue, 2 Jul 2019 14:38:00 +0100
Message-ID: <1562074682-31579-5-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1562074682-31579-1-git-send-email-pawell@cadence.com>
References: <1562074682-31579-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(36092001)(199004)(189003)(50466002)(54906003)(356004)(16586007)(70586007)(316002)(8936002)(50226002)(26005)(76176011)(26826003)(42186006)(70206006)(7636002)(426003)(51416003)(305945005)(4720700003)(186003)(36756003)(476003)(11346002)(76130400001)(6666004)(486006)(2616005)(246002)(446003)(126002)(47776003)(48376002)(8676002)(6916009)(107886003)(86362001)(478600001)(87636003)(7416002)(2351001)(5660300002)(2906002)(336012)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3593;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a6f812-12f8-4461-a264-08d6fef28fc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5PR07MB3593;
X-MS-TrafficTypeDiagnostic: DM5PR07MB3593:
X-Microsoft-Antispam-PRVS: <DM5PR07MB359365902DDA370664FF2E66DDF80@DM5PR07MB3593.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-Forefront-PRVS: 008663486A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: y4vykuFRTm6k1Xjn5Rp7x9Ru3ZKWq+WUOk44OGRTX5ZoBc/N8mPD0irogkttYPCquHSEwQVxi7nqXwb7C3rMkESz2dUBEgKk4zfbcwon6wd8JjYHlpAHy+Tv/AlXw/v9nXiJw986pUqdo2TTZLDBpT4Ri3DVCdM8apx0vnnC45dPcm5+B9S8TRh0KgWdxrKXThfcWzX8nIZrXURsCmh9hjjd9LQRqrm04xh+ulAC1PLU60ak6AHCjoIOAH6K+1Rgc/JhAxlt8U0KSQr+vyTd7S10YN19oY+4+7Gy0BR+9sdpbrfzGmI2HPJjYX50KvYB983h2m91CuFl4V3KJGefffppbwOt8yCMS9HEla64D/xMrow4G8guFYb0XSaqheXf518sHvpwmy5U4T7adyufIQ0E78czgru7paDoTvbgADc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2019 13:38:26.3044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a6f812-12f8-4461-a264-08d6fef28fc3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3593
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
 mlxlogscore=741 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves switch responsible for decoding descriptor type
outside snprintf. It improves code readability a little.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/gadget/debug.c | 113 +++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/gadget/debug.c b/drivers/usb/gadget/debug.c
index 60a9f70a0904..92a986aeaa5d 100644
--- a/drivers/usb/gadget/debug.c
+++ b/drivers/usb/gadget/debug.c
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

