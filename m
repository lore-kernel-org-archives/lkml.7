Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C3F213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EldQzjUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfCLSQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:16:19 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:52547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfCLSQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+RoAtsBzsRFS/WNmxGxnFIy60QhyYXebH+DdT5AIxs=;
 b=EldQzjUAzw2X4dvMldfvZ4O9xePPZH1SVXDv1G8nKONYWKMAQ1rt/+siYxuicYT2tHQYw6ULz+sq3b02mn8dGcmZ1qBRN2WUQbQ3rolY7gPvBw1Gktf0640seQtWXn+A0x4FlWtnWDy7OBSl/n1dDUwxOmYb4AZKGiH51PDxX1Y=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5138.eurprd08.prod.outlook.com (10.255.30.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 18:16:11 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 18:16:11 +0000
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
Subject: [PATCH v4 02/10] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Topic: [PATCH v4 02/10] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Index: AQHU2P+rU5lRfkx6aEys/iwaQmq/mA==
Date:   Tue, 12 Mar 2019 18:16:11 +0000
Message-ID: <1552414556-5756-2-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 16f3ab22-4848-4410-e8d4-08d6a716ce48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5138;
x-ms-traffictypediagnostic: AM0PR08MB5138:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5138409EDC764FC1E1B331E6E4490@AM0PR08MB5138.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(2501003)(8936002)(6116002)(76176011)(4326008)(3846002)(53936002)(81156014)(81166006)(106356001)(8676002)(6512007)(102836004)(14454004)(105586002)(386003)(186003)(6506007)(256004)(99286004)(5660300002)(52116002)(2906002)(97736004)(68736007)(476003)(446003)(2201001)(50226002)(36756003)(6436002)(44832011)(86362001)(316002)(486006)(6486002)(11346002)(2616005)(478600001)(71200400001)(71190400001)(25786009)(110136005)(7736002)(72206003)(305945005)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5138;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /HOgRKVJI18BKTmcA3ZLOrL1abnvwvgBuN/bNbFLC6bs2noamGr/KAxi0hUV1wYgvQQu8nkEOPH7r8QWE8o3/tvmu9Ph9LHOpAixWse1ijs9TU864cr1Q7Tn4ba/+ve8vV1XHGtFkww1MmaRAlETPGymT7/7XKf9N7bRTcv8UrtxoxmU65Gb6qyxLN597CQntBltgADDu0Z9zFzmCtAkt1RJpvoVAPSswqsKzqJTuzdyv1VI7FJIQvuw/gkv94SKTwo85IkZk2SdYdC+S6P7mZKhlUf+oGFMpM2GiotoQscg1ZS8fud79OfCnVDuruUs+8YqZNXjWZDzUrrt2bFGTSXz9ftZLngO/a4D6vSzOHlxBQjrvs6PsD3oME+C7zJ7jwh+VvKj6dLtxr2AOVNSsVE7unEY8k5PAXJgz9a3rIs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f3ab22-4848-4410-e8d4-08d6a716ce48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 18:16:11.4319
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

This new format is supported by DP550 and DP650

Changes since v3 (series):
- Added the ack
- Rebased on the latest drm-misc-next

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index a9df743..3684c49 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -229,6 +229,7 @@ const struct drm_format_info *__drm_format_info(u32 for=
mat)
 		{ .format =3D DRM_FORMAT_VUY888,          .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y410,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .i=
s_yuv =3D true },
 		{ .format =3D DRM_FORMAT_AYUV,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .is_yuv =3D=
 true },
+		{ .format =3D DRM_FORMAT_XVYU2101010,	.depth =3D 0,  .num_planes =3D 1, =
.cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y210,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y212,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y216,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 2, .vsub =3D 1, .is_yuv =3D true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index b992a38..dc99e7f 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -153,6 +153,7 @@ extern "C" {
=20
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:=
Cr 8:8:8:8 little endian */
 #define DRM_FORMAT_XYUV8888		fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y=
:Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X=
:Cr:Y:Cb 2:10:10:10 little endian */
 #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:=
Y 8:8:8 little endian */
 #define DRM_FORMAT_Y410		fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:=
Cb 2:10:10:10 little endian */
 #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed=
 by U then V, 10:10:10. Non-linear modifier only */
--=20
2.7.4

