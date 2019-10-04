Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD34C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F05B222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oMNPV5tP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oMNPV5tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfJDONL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:13:11 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:1863
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388417AbfJDONL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw7JRZIHKFb5y+T27fqtvJl9RwtTBn8opjA98fHySwM=;
 b=oMNPV5tPXJjR2VG7QgY9y6GjB1nEkeUGGx69IJLG686HWjl3qJBXD2p/tmcbEekgQo1TnHk7YvmZGkLl8xncDXTLvGgDXcpJxx0No2/pXVfh3YNiMsn3rLYoI5qNbIYSeeuk5cKinkfKGpHPiScsMuQYkq8EDIjqaeUig2S6U1Y=
Received: from VI1PR08CA0247.eurprd08.prod.outlook.com (2603:10a6:803:dc::20)
 by AM5PR0801MB1649.eurprd08.prod.outlook.com (2603:10a6:203:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 14:12:58 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0247.outlook.office365.com
 (2603:10a6:803:dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Fri, 4 Oct 2019 14:12:58 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:12:56 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 04 Oct 2019 14:12:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7d9885e1d27eba37
X-CR-MTA-TID: 64aa7808
Received: from bc5c134baa14.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50670DAA-8737-4981-809C-198C24081F0A.1;
        Fri, 04 Oct 2019 14:12:41 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bc5c134baa14.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU/suPgWAuZut1k8r5HYqCwR4Rv98lTcWiPa9eOH/hVXDrRkY39UHtrggoJSVAiYc/kqrs5pm9UCbvlRu+unjOgIry4o8OvC+WlHsZOWiQpfIjyi+LZIK4yBZKeZOz7OBHomujpiiyccpV1GyAa7vFys4GcRl/BrYHk9KzF3E5cphuNm+6hrXOs+B+OCGmAMmfy7Z7xyOyUbm8imcQemIdI+nHZnYYWna7LL9KKouAoxxDq4mUmxHptlRTQVYVdHfhHbnbMY/uIPRT6glywwb/H8D2Nvb/siIMa/KL+AaNM6Ah80twQ71b3BqH6sa9ShZf9sDPFhrrTFUbegnWfOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw7JRZIHKFb5y+T27fqtvJl9RwtTBn8opjA98fHySwM=;
 b=CsfiWscopGUQzBvm8uIC0uAnyCVFFrm5fKJqMtKYptItkT/vdqmsxEn1xi7tJ5lw2+4sIiotIbjVzqvk5jYUR7JrA9UaGQSOb/Cw4dhNUwDjGMNrHb1LGUCf0YglqVNtLnlxmagg/gBwQtNZK7Y2/+yMU/InMqToRtazsf12w/eiZ3bmDl6/FAULmByVPjNw4gEXNpvasBR0HZKTwit7KvAHWTYyzFjwfRQDW1fzyY5VzPlfAjV6NLyaLSXAtcY44JL48PRLbiGNjlXTq0zh5dKc8PbfHvfM1yTqweLLCCJqcMM9qP+J6wAjkhKu9arPV9UJz8tAB6ZMmPA7e8v/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw7JRZIHKFb5y+T27fqtvJl9RwtTBn8opjA98fHySwM=;
 b=oMNPV5tPXJjR2VG7QgY9y6GjB1nEkeUGGx69IJLG686HWjl3qJBXD2p/tmcbEekgQo1TnHk7YvmZGkLl8xncDXTLvGgDXcpJxx0No2/pXVfh3YNiMsn3rLYoI5qNbIYSeeuk5cKinkfKGpHPiScsMuQYkq8EDIjqaeUig2S6U1Y=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB3905.eurprd08.prod.outlook.com (20.178.82.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 14:12:39 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::748f:576b:c962:6a46]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::748f:576b:c962:6a46%3]) with mapi id 15.20.2327.023; Fri, 4 Oct 2019
 14:12:38 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Raymond Smith <Raymond.Smith@arm.com>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v3] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH v3] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVer3HxoO2jRYwYkCqyNFFHsjE5g==
Date:   Fri, 4 Oct 2019 14:12:38 +0000
Message-ID: <20191004141222.22337-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::15) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6cab3d-e5b0-4f44-03a6-08d748d4f4ac
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM0PR08MB3905:|AM0PR08MB3905:|AM5PR0801MB1649:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB164980151CFA4BADA5F5036DE49E0@AM5PR0801MB1649.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3968;OLM:3968;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(2501003)(26005)(110136005)(36756003)(54906003)(316002)(25786009)(66066001)(81166006)(6116002)(81156014)(50226002)(8936002)(8676002)(86362001)(6506007)(186003)(99286004)(2201001)(52116002)(14444005)(2906002)(256004)(486006)(305945005)(7736002)(476003)(2616005)(3846002)(6436002)(71190400001)(71200400001)(44832011)(14454004)(5660300002)(386003)(66946007)(64756008)(478600001)(66476007)(66446008)(4326008)(66556008)(102836004)(1076003)(6512007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3905;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cBY6hTaII7jgrmBSkCAoi2M+QBQifZ6kF/f7tFOETPZJpwCbHB7kO9nVkx07owJpe+LyqsZl9CvfyfIdJfS61SkqQLeuPbcVAiPicVWHHUcxEobkltLzaNmwt/f/XGabL/V4G+5HQ7f15lkEjIkcWA2v8jIjMCCM58rVRardXjPb5z4/2WphavFl/COdiO5D5ofr1NqqtvHO6jq9tzNYq29bHXEe/18mPn/HdoHdkYRT/Exirhx1fG9Yxw6I/AhdB6T6ztRTJcSr2ovGwc1jfzFWpmRJNAQLJree/jTQ/8wyPNEuQByu5YzW7vvF1fZC62ZInSg05cimqxkdJYySrlLE5XJtPJq5qZs+sUXWNYv07HTF62k2RHDGtVKr7BISP7Zqtqx/0wTtNpdyfpuUEQyrp8GUTmpO+lHChcVDgrU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3905
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(25786009)(7736002)(305945005)(14454004)(5660300002)(2501003)(478600001)(22756006)(26826003)(99286004)(6486002)(63350400001)(36756003)(486006)(186003)(126002)(386003)(6506007)(476003)(26005)(336012)(102836004)(2616005)(36906005)(54906003)(81156014)(110136005)(81166006)(1076003)(2201001)(4326008)(6116002)(50226002)(6512007)(8936002)(8746002)(3846002)(23756003)(316002)(66066001)(47776003)(2906002)(8676002)(86362001)(50466002)(356004)(70586007)(107886003)(70206006)(14444005)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1649;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 123f9216-17a4-4d50-3e28-08d748d4e99b
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TLVL4dM8KfQfH3ZtmQ3+KVkNcoegvk2PRkBtn5WS91mFR6sHYm7luXvgkrOsQgXwr4EVk3+zquLDxUGdmOUvimvA6HK/2NPH/8eXuLizbNt8/Tq3f8dRFjzaYDXxHhgMTWueK7ivZ3eL2ExSxhE7CyguUztM7T+Br0V62f0OLbrS7OyG7gsy0zJx9ixDaINKE4BQD8EbNp+M1XSq3lFT9SHMFBo96Or4bfcRlyxUY2kEnL9h8YoEv9i/2GtlEUXxPWvWGdivt5O87vV89RHBBwinzsKsrpucMgz+Ah4PdGZ1hs1U6PWDRU6K01lwnCnCrEkO0rg/GDcTQMzeCmUklXGkKUxtjd2nsbbjRl+cO+7LqOkuTeeagDEvMpw7OP+dhZClzYNjchk/T70DAlvQ3F6yIMpQeM//HUnmpXxbac=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:12:56.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6cab3d-e5b0-4f44-03a6-08d748d4f4ac
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1649
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raymond Smith <raymond.smith@arm.com>

Add the DRM_FORMAT_MOD_ARM_16X16_BLOCK_U_INTERLEAVED modifier to
denote the 16x16 block u-interleaved format used in Arm Utgard and
Midgard GPUs.

Changes from v1:-
1. Reserved the upper four bits (out of the 56 bits assigned to each vendor=
)
to denote the category of Arm specific modifiers. Currently, we have two
categories ie AFBC and MISC.

Changes from v2:-
1. Preserved Ray's authorship
2. Cleanups/changes suggested by Brian
3. Added r-bs of Brian and Qiang

Signed-off-by: Raymond Smith <raymond.smith@arm.com>
Signed-off-by: Ayan kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Qiang Yu <yuq825@gmail.com>
---
 include/uapi/drm/drm_fourcc.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 3feeaa3f987a..2376d36ea573 100644
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
+#define DRM_FORMAT_MOD_ARM_CODE(__type, __val) \
+	fourcc_mod_code(ARM, ((__u64)(__type) << 52) | ((__val) & 0x000ffffffffff=
fffULL))
+
+#define DRM_FORMAT_MOD_ARM_TYPE_AFBC 0x00
+#define DRM_FORMAT_MOD_ARM_TYPE_MISC 0x01
+
+#define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode) \
+	DRM_FORMAT_MOD_ARM_CODE(DRM_FORMAT_MOD_ARM_TYPE_AFBC, __afbc_mode)
=20
 /*
  * AFBC superblock size
@@ -742,6 +756,16 @@ extern "C" {
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
 /*
  * Allwinner tiled modifier
  *
--=20
2.23.0

