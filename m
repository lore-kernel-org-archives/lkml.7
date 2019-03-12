Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE604213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WEEbOIVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCLSQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:16:25 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:52547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfCLSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e28KKf4VMf+YS+AdQqcxt10NRQ10CwblxvP0/6BZOvs=;
 b=WEEbOIVjC5s4VemrntuhimHlPd6qk5M6SNfUIzTWKcIGx50XgbAPPd7iX/0pfmBMY3B/HqZ5xwh/QbUPUpZQq+Bh4tClGBxTJQsg+/qS4q/jKbQqLSj8ci8mtGTe19pN/pW5SxkHe7uJv3L0ulufIzGvopsmlWJ4kos2hM42PNY=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5138.eurprd08.prod.outlook.com (10.255.30.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 18:16:13 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 18:16:13 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>
CC:     nd <nd@arm.com>
Subject: [PATCH v4 04/10] drm/arm/malidp:- Added support for new YUV formats
 for DP500, DP550 and DP650
Thread-Topic: [PATCH v4 04/10] drm/arm/malidp:- Added support for new YUV
 formats for DP500, DP550 and DP650
Thread-Index: AQHU2P+tqJozVjLgsUGlRDgVDtbnEA==
Date:   Tue, 12 Mar 2019 18:16:13 +0000
Message-ID: <1552414556-5756-4-git-send-email-ayan.halder@arm.com>
References: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1552414556-5756-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::32) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6fb4227-c2c8-47a8-f4c0-08d6a716cf74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5138;
x-ms-traffictypediagnostic: AM0PR08MB5138:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB51385E12F6668A8A108637EFE4490@AM0PR08MB5138.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(2501003)(8936002)(6116002)(76176011)(4326008)(3846002)(53936002)(81156014)(81166006)(106356001)(8676002)(6512007)(102836004)(14454004)(105586002)(386003)(186003)(6506007)(256004)(99286004)(5660300002)(52116002)(14444005)(2906002)(97736004)(68736007)(476003)(446003)(2201001)(50226002)(36756003)(6436002)(44832011)(86362001)(316002)(486006)(6486002)(11346002)(2616005)(478600001)(71200400001)(71190400001)(25786009)(110136005)(7736002)(72206003)(305945005)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5138;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n2du3SHYsIfr1PXM1iFqncTgLGbJ/FMJyQDN0lGVvVKsv8XjKGpzgR01XcrvwOtvfHw7wjF9i0irnPhZXtJlM+HwlOqK6G2M7hrOGtLyGK306HfBdBvLOVTGbQQYqOMNNbIHFxJeiEFlUqDOQUPWAq3F7cCeUt6WpeGMZT/sAHZpnwaZQAYJcLwbx8TVcwzgeWNDjjh7rFlHyS8X6+BzgwiqZwFEDRdOlE4BEklHi7S8Ki4irg4JHFek+xsiXpFYiAc1GlE6/OUJ5pWu9EHl6a9xnTHjAbZMCeXhYxyxgyraGgXxibEftNh9/Af5eUmFx2F1pCNhkbM/xloCiFDrLO93L2DsGVyGyZ8A8w8De/hvK7mRCGWlRperKoO6Iwa68bom3Fi902ZUxgtjdic/G3CD6qbOraV2cK/2HSxGw0g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb4227-c2c8-47a8-f4c0-08d6a716cf74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 18:16:13.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Kumar Halder <ayan.halder@arm.com>

We have added support for some AFBC only pixel formats like :-
DRM_FORMAT_YUV420_8BIT (single plane YUV 420 8 bit format)
DRM_FORMAT_VUY888 (single plane YUV 444 8 bit format)
DRM_FORMAT_VUY101010 (single plane YUV 444 10 bit format)
DRM_FORMAT_YUV420_10BIT (single plane YUV 420 10 bit format)

Generally, these formats are supported by our hardware using the same
hw-ids as the equivalent multi plane pixel formats.

Also we have added support for XYUV 444 8 and 10 bit formats

Changes since v3 (series):
- Added the ack
- Rebased on the latest drm-misc-next

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 64c2ca3..b4a0e11 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -49,6 +49,12 @@ static const struct malidp_format_id malidp500_de_format=
s[] =3D {
 	{ DRM_FORMAT_YUYV, DE_VIDEO1, 13 },
 	{ DRM_FORMAT_NV12, DE_VIDEO1 | SE_MEMWRITE, 14 },
 	{ DRM_FORMAT_YUV420, DE_VIDEO1, 15 },
+	{ DRM_FORMAT_XYUV8888, DE_VIDEO1, 16 },
+	/* These are supported with AFBC only */
+	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1, 14 },
+	{ DRM_FORMAT_VUY888, DE_VIDEO1, 16 },
+	{ DRM_FORMAT_VUY101010, DE_VIDEO1, 17 },
+	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1, 18 }
 };
=20
 #define MALIDP_ID(__group, __format) \
@@ -74,11 +80,25 @@ static const struct malidp_format_id malidp500_de_forma=
ts[] =3D {
 	{ DRM_FORMAT_ABGR1555, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4,=
 1) }, \
 	{ DRM_FORMAT_RGB565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 2=
) }, \
 	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 3=
) }, \
+	/* This is only supported with linear modifier */	\
+	{ DRM_FORMAT_XYUV8888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) },\
+	/* This is only supported with AFBC modifier */		\
+	{ DRM_FORMAT_VUY888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) }, \
 	{ DRM_FORMAT_YUYV, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 2) },	\
+	/* This is only supported with linear modifier */ \
 	{ DRM_FORMAT_UYVY, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 3) },	\
 	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(5, 6) }=
,	\
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 6) }, \
 	{ DRM_FORMAT_YUV420, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 7) }, \
-	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}
+	/* This is only supported with linear modifier */ \
+	{ DRM_FORMAT_XVYU2101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_VUY101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
+	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}, \
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}, \
+	{ DRM_FORMAT_P010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}
=20
 static const struct malidp_format_id malidp550_de_formats[] =3D {
 	MALIDP_COMMON_FORMATS,
--=20
2.7.4

