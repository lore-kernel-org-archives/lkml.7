Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477C9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0571E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="IAyw2yPp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UuOz512q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfHZLU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:20:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31342 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbfHZLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:20:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBJPU7004607;
        Mon, 26 Aug 2019 04:20:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=IAyw2yPpce8zxDN4PONI/gDy8j5OR5fQPkv5Wczr3xR3QEt3hVR1kxJeZraak2XbENul
 QUIsOxOV+KBa4UggFBs+bR+NWrcsIXSYgarOWw2DV6adDvWJV4HQisyEniosYJpTppNB
 Gsvbou3yCDqL5jy7mSKdRZsZvt1YmQmaWUm9YXEJ5P0MvJo9kTolZBYo0zUSPUnBvcCL
 +mNGJ/MRqurGN2dsYbvbo57iGZ5H935AHg03yl46k/MCeR4DDmzBISFxSlhqZvdNSfhY
 a0k7A0R8+u4KKlk7F0iADaf9s+Bxio06HWxcdvYlhxfu+pB6KFSg8HEgjMqe05XzQCL0 Ng== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2uk21yp6gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IILpTQuLy8EO+XyNJmcDzuHvRQVH5d1rjz4JnDNPgOunKKta9kxNDiFTnS8HTejojaGTFIvB9bkMapPTo6r3lxSL7+tDUno6ZO4BW046SJEDlqC6t2zmaviTZXHHySKZHWSIGgk7BV/gw38enWZiTD1ChHoZksGETlrSD4/iAJg5+u4OSmlxaHRFzdHfiwSW+wl7GytyfddoynnEp+Pd7QYaHmeaBsfny6KnEZt8ToalTtc3ZPuSGCa/aySjlPovcg/hVTzu264qMiR4PTrgbNFXGhsNGO/tjRewzRW+BR/S25Kxd0FxHK/7it6FKigFMtUL7JjASJ7DeEtJL8DNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=lKpSQ6AUp57q0OVNZutgtGoKWwOq8LkNo0yDZ8hAM4R0Dz8VWTMllZU2/5zYRjOUayTSsgM9jzfG+JaDrOL7PxkmVJWP9hbycigzUyWV4pUzxJskqEfmAMw+IZTMzLDaMde1HXIuhQiTg9/oalUN/P2yCWzhYgIyEEcmzl3/ePwUdEvAyiOQe4Ips+gYtGzx4ekIS1wbpWSyIKlNgQgEoORasiq24XJ5cteomu0vuIwxzFNLAO3quprE+jSPZi7XH4BqNMGp22v4aD4UFTKJmP2YruRwGh3MfARgJazEQakE3DjZ/oTFS6O+4jiSCEUhpnO33EW6BAm9LFvOdWrMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFzmH40W4nlaFBfgvdMHuYDWx8WPVgnsyZjQ3haaA4=;
 b=UuOz512qu+vpYoDMdb6LVOtv4knGpzi2HasL1eFCMEc895LcaVoRbzsdT48cZeiySrMyMxs5Dy2tahzqELoza8w80HaQfcExMduG7S1rpBko16xSyvq5b8cF52WfEiq92aTCYYSQPe27s5wf/JBm+qoFF9ipBZp5igQSu59VLEw=
Received: from DM5PR07CA0086.namprd07.prod.outlook.com (2603:10b6:4:ae::15) by
 SN6PR07MB4352.namprd07.prod.outlook.com (2603:10b6:805:57::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:20:14 +0000
Received: from BY2NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by DM5PR07CA0086.outlook.office365.com
 (2603:10b6:4:ae::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.14 via Frontend
 Transport; Mon, 26 Aug 2019 11:20:14 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT016.mail.protection.outlook.com (10.152.100.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.7 via Frontend Transport; Mon, 26 Aug 2019 11:20:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9WT001206
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
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x7QBK9QM029097;
        Mon, 26 Aug 2019 12:20:09 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x7QBK9AK029083;
        Mon, 26 Aug 2019 12:20:09 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v11 3/6] usb:common Patch simplify usb_decode_set_clear_feature function.
Date:   Mon, 26 Aug 2019 12:19:28 +0100
Message-ID: <1566818371-27721-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1566818371-27721-1-git-send-email-pawell@cadence.com>
References: <1566818371-27721-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(36092001)(199004)(189003)(6916009)(11346002)(76176011)(2616005)(107886003)(48376002)(4326008)(5660300002)(446003)(36756003)(86362001)(486006)(50466002)(6666004)(356004)(476003)(2906002)(426003)(126002)(51416003)(8936002)(47776003)(8676002)(16586007)(76130400001)(54906003)(26005)(70206006)(70586007)(7416002)(50226002)(7636002)(42186006)(305945005)(336012)(4720700003)(26826003)(2351001)(478600001)(186003)(87636003)(316002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4352;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd3e4266-0fb8-4cef-793c-08d72a175d8d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328);SRVR:SN6PR07MB4352;
X-MS-TrafficTypeDiagnostic: SN6PR07MB4352:
X-Microsoft-Antispam-PRVS: <SN6PR07MB435227225A0DFCAF382B129CDDA10@SN6PR07MB4352.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-Forefront-PRVS: 01415BB535
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Ybmp/xmqjokoZX+H1FIRkrYovE/eSNO8xa1x9Qew04VPXDkjVAC0EOXdygZowl29aNGYhq4pmaEAm4ycTSMKVlBJ9QMwPngvUbAOhWEb6bTVAMoTqFeGvFIntVfotbtcyND6bGghwgtxZzINlP5x8JnbKDg2hEi4htXNJqvC8pMtQK+b8jEptCEA3HnxXVu4UyPhiadVpxSn2Vd+pyuCuMjtwJn7zg0V91bzJxDPNgMTW5JCdB7QI2XUFvBbmurEQGKJeYYfJHrbujLxsfp+/MGrifDw2YnEBMv9gDbB2lwQqirVP2qLLHA4s0Bmu24d1Xg9qEOpFkNwTOTU+F1nX0V8lKJ2nd3WoxkVZtxD/FRa50vgar7p6y4SKdeNaudVxvNE8uIM5tMWF96bPoz1GLgWdDlnzdQEZDnjWDxI2Hc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2019 11:20:13.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3e4266-0fb8-4cef-793c-08d72a175d8d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4352
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_06:2019-08-26,2019-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=1 clxscore=1015 mlxlogscore=685
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908260127
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

