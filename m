Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7937C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B37D215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V9dDU36S";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V9dDU36S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfI3QpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:45:06 -0400
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:33617
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbfI3QpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0hCAxunk1g1TCBVqy7T3+YW73qmUeUrNNk6KoNXGQY=;
 b=V9dDU36Sg4Hz72SRBpAR0ZTDTRaztCRD5ovXZsGSq9O/cdwxvxPa37jLu32RZc7IFihgVKGq40vClgRNr53eDAPc0Zo4X0/aSNg5F3hbJWWly7Q9iJDNoKd2ZGzR/tsdCHjnH+ZhFrQcwikR8xjpI/VUrswBe0AjkIFV3U+QctU=
Received: from AM4PR08CA0049.eurprd08.prod.outlook.com (2603:10a6:205:2::20)
 by AM0PR08MB5377.eurprd08.prod.outlook.com (2603:10a6:208:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17; Mon, 30 Sep
 2019 16:44:56 +0000
Received: from AM5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by AM4PR08CA0049.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Mon, 30 Sep 2019 16:44:56 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT034.mail.protection.outlook.com (10.152.16.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 30 Sep 2019 16:44:55 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 30 Sep 2019 16:44:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1fb8d32b80e5cacf
X-CR-MTA-TID: 64aa7808
Received: from f24e1f42cc6d.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4F678C47-68D6-4648-BBF8-9F1141784315.1;
        Mon, 30 Sep 2019 16:44:42 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f24e1f42cc6d.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 30 Sep 2019 16:44:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLHYCHl+fWxvt+2kETGVoauXFmWY5gg+TR1HNPVJMEuWQcVxqKt9CjtGcmQoRO+mL2pavW1P2U1MVy0XZBBIJrJdvANlfsTewipSCf8+BTCW5E8TU7Ug4JR2Hovvnx90hDVnn8bxeA28lV71/lCtnX0k6Z+MJLitq0A4JBqeq2WZbewaycSp8hRgV7Fty7olY39GP1uFJaJyl04ZVMBJEvSeix6S9GukpETN4m3x+z3QZkzGImCmpi8oBhnvyznxD5oQy7x1NFg+W5qQTXRWroDIzowrgS443BS8pPoQQZZiel84nDRYXM9xvRTFp2ZAMJtVRHKiSzVPg9urLLhmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0hCAxunk1g1TCBVqy7T3+YW73qmUeUrNNk6KoNXGQY=;
 b=BtZtHfM622n9OufIu65gkIkgOQJhPqeKFjaj23v58T2H37PrxnCsuIEJk4KwALWbtW63WZ07YkmUmRGjclJaJvMoRkt0/k4VirPU6PdVbYYsg9fFok1Hz0HEXDacygW1+qtL/e7w4I1sTe8GyRqPmtNqox3vplGhf8KlnQ+U+U14hhTQMTg03+1L3UAgvGWV0c1mRn2UH9u3BMXuX+L5KGDNMfiMmQ8NQhUP6GFSTi370CwuaheraTfDFIpRiskOwBLJzIEz+eUPq7rONdFa95WjVe14njdb7rYBomP7psmLjTQcZBde8fCUbTqYYWJ/ti3bjYHmaugN7spnDGo63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0hCAxunk1g1TCBVqy7T3+YW73qmUeUrNNk6KoNXGQY=;
 b=V9dDU36Sg4Hz72SRBpAR0ZTDTRaztCRD5ovXZsGSq9O/cdwxvxPa37jLu32RZc7IFihgVKGq40vClgRNr53eDAPc0Zo4X0/aSNg5F3hbJWWly7Q9iJDNoKd2ZGzR/tsdCHjnH+ZhFrQcwikR8xjpI/VUrswBe0AjkIFV3U+QctU=
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com (10.141.172.139) by
 AM7PR08MB5301.eurprd08.prod.outlook.com (10.141.171.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 16:44:39 +0000
Received: from AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0]) by AM7PR08MB5352.eurprd08.prod.outlook.com
 ([fe80::1c78:bb51:3634:9cf0%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 16:44:39 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>
CC:     nd <nd@arm.com>, Raymond Smith <Raymond.Smith@arm.com>
Subject: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH v2] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVd65ZjChaP0zoZUGEUL74H9varg==
Date:   Mon, 30 Sep 2019 16:44:38 +0000
Message-ID: <20190930164425.20282-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To AM7PR08MB5352.eurprd08.prod.outlook.com
 (2603:10a6:20b:106::11)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ff6b52fb-e86b-4775-9b83-08d745c585c0
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:|AM7PR08MB5301:|AM0PR08MB5377:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB53774553CD8ACE4B06AE5C01E4820@AM0PR08MB5377.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 01762B0D64
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(6512007)(305945005)(2501003)(7736002)(2906002)(316002)(99286004)(66446008)(64756008)(66556008)(66476007)(66946007)(6486002)(6436002)(110136005)(2201001)(50226002)(86362001)(54906003)(14454004)(8936002)(478600001)(4326008)(256004)(14444005)(44832011)(1076003)(8676002)(81166006)(71200400001)(71190400001)(476003)(2616005)(386003)(6506007)(6116002)(25786009)(102836004)(186003)(26005)(5660300002)(36756003)(52116002)(66066001)(3846002)(81156014)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5301;H:AM7PR08MB5352.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: O/4tSPnfEs7KGeSpaW1Un1FWzBVPBqRQGEkz0kRM6g8UVWUgVrEqK+GjXn9turlwdc7JW5mthKcLpb9xizVCeMaQAMX6Xq5V8T2s0YiXuk9bAAWlOv6rgOFJu2UiEe1SrF5APDopQNgVC+Vka9B9SbfGhNIl2wn+fnYFjdr9uH4AHyfuXPFeiGLULJQhe0SgSzpyNNhx0bP+zuyuQafAstsH7976VzjrgBdmZN1bAKyAAdi9WNKVT3RR+MdZQ6vsaorP/9VSSRHtKS8ov+kiizONe2s6Lx5sllcKOmXmn7RFljLlNnJIWZPaK2bfn8HcM2Nrf88YrStGzJCY4iJej33bD7RpCMhr6V8Gd11qQ7g6mY9q9dyGG9erZk9l92tmGuAgw9ZglpVaNyrKPd19lBKkjfLZ6670xdGPpb7wGyk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(7736002)(36906005)(386003)(102836004)(6506007)(26005)(6512007)(186003)(1076003)(14444005)(6486002)(305945005)(110136005)(54906003)(99286004)(23756003)(316002)(2616005)(63350400001)(336012)(476003)(356004)(126002)(486006)(5660300002)(86362001)(6116002)(3846002)(2501003)(478600001)(76130400001)(47776003)(50466002)(2906002)(2201001)(70206006)(8746002)(66066001)(22756006)(81156014)(81166006)(4326008)(26826003)(50226002)(36756003)(14454004)(70586007)(8676002)(25786009)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5377;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 111ed03c-9ec6-4160-d097-08d745c57c16
NoDisclaimer: True
X-Forefront-PRVS: 01762B0D64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2YvFawufNLVFuM8J7I59W7QhfOgJghl/+jLeuULhCxDRgNvy6MkIGdRZkdjeKObODAODnwI6riK3hYWvzBRNFJxS+z/2nP3S/SX30tk+LNumagGLqzjeSqGZvkYESFzBsbemfxogUlElKsS7bpRoLqxXHI36olo0tsyndlSimvZhEwDOolw+wJEqq2sNsbPLdj7AQmBQEmY9YSVlwwydLxDtkzO8aNFFAkT8lijHKD72a5yRag6kHwp38oIWi+T3puBqT+0BT5REUrP+YGJ72wxh1gklSZXMlQZBF/nfdRq6dyu44ogMKtOzTzEa48f8WNOlxkQxP0OOEKRyeQoGNDcFdcfAII2G2lN6dY4cEL8C9gNaVW5gL56p1DingceNivxA3zGN42MyZogBUZOQT3Pk9E8+pyG+vSa4bj8PYY=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 16:44:55.0530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b52fb-e86b-4775-9b83-08d745c585c0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
denote the 16x16 block u-interleaved format used in Arm Utgard and
Midgard GPUs.

Changes from v1:-
1. Reserved the upper four bits (out of the 56 bits assigned to each vendor=
)
to denote the category of Arm specific modifiers. Currently, we have two
categories ie AFBC and MISC.

Signed-off-by: Raymond Smith <raymond.smith@arm.com>
Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
---
 include/uapi/drm/drm_fourcc.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3feeaa3f987a..b1d3de961109 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -648,7 +648,21 @@ extern "C" {
  * Further information on the use of AFBC modifiers can be found in
  * Documentation/gpu/afbc.rst
  */
-#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_m=
ode)
+
+/*
+ * The top 4 bits (out of the 56 bits alloted for specifying vendor specif=
ic
+ * modifiers) denote the category for modifiers. Currently we have only tw=
o
+ * categories of modifiers ie AFBC and MISC. We can have a maximum of sixt=
een
+ * different categories.
+ */
+#define DRM_FORMAT_MOD_ARM_CODE(type, val) \
+	fourcc_mod_code(ARM, ((__u64)type << 52) | ((val) & 0x000fffffffffffffULL=
))
+
+#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
+#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
+
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
=20
 /*
  * AFBC superblock size
@@ -742,6 +756,17 @@ extern "C" {
  */
 #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
=20
+/*
+ * Arm 16x16 Block U-Interleaved modifier
+ *
+ * This is used by Arm Mali Utgard and Midgard GPUs. It divides the image
+ * into 16x16 pixel blocks. Blocks are stored linearly in order, but pixel=
s
+ * in the block are reordered.
+ */
+#define DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_MISC, 1ULL)
+
+
 /*
  * Allwinner tiled modifier
  *
--=20
2.23.0

