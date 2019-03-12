Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E28BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541BD2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LesJaopJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfCLSQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:16:40 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:52547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727098AbfCLSQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K72lOfDIceB4snouQF5VaUapGvg/d/sb1xFo3AMkMUw=;
 b=LesJaopJ2bGX/6QubBjmzHKZmvjFSMk8gXU+auVdOFxPaeHWPmRk7R0/Xn6fV0gwsJ/DUfChaWmK01xH7uHk+ITFB/61ExPrFAn7gHnJce8ix3Pl4hedpJJi1OeirZ/NZG4WX2sMxGuK9rJDueq3WgeoznQG+fLcCEgr92mPaJ4=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5138.eurprd08.prod.outlook.com (10.255.30.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 18:16:19 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 18:16:19 +0000
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
Subject: [PATCH v4 10/10] drm/arm/malidp: Added support for AFBC modifiers for
 all layers except DE_SMART
Thread-Topic: [PATCH v4 10/10] drm/arm/malidp: Added support for AFBC
 modifiers for all layers except DE_SMART
Thread-Index: AQHU2P+wTO+4Eeh3tky3q1d2JhVpeQ==
Date:   Tue, 12 Mar 2019 18:16:19 +0000
Message-ID: <1552414556-5756-10-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: a9b50abe-2a81-4ad1-0bf5-08d6a716d2d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5138;
x-ms-traffictypediagnostic: AM0PR08MB5138:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5138B51F283EAC56C09BE16DE4490@AM0PR08MB5138.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(2501003)(8936002)(6116002)(76176011)(4326008)(3846002)(53936002)(81156014)(81166006)(106356001)(8676002)(6512007)(102836004)(14454004)(105586002)(386003)(186003)(6506007)(256004)(99286004)(5660300002)(52116002)(2906002)(97736004)(68736007)(476003)(446003)(2201001)(50226002)(36756003)(6436002)(44832011)(86362001)(316002)(486006)(6486002)(11346002)(2616005)(478600001)(71200400001)(71190400001)(25786009)(110136005)(7736002)(72206003)(305945005)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5138;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MmLanvkgrTtGtD6XDZ4/YBttBlcxWs4LUH2f6moyWdE9QX8dF1YNgsFnwi7+0BeJKYii67sZgtex6v0ESoX5r3xwfUWOGRruqywlaszqrQiRmvD9b6RpmdEUvqOKT6ua9gHJJ5rINmZCV51U1vcFO0BdACvsx1XlgH75niKlTuMiN2S+PmJpZyoXW13Kf+Kj80BsdgpiPJR6gArLt2d9xcHauK9tYqWhnkYbAq4I/6u8cfrckbRKy9pVt2z1HGi8h1+bOC4kynmUOYMFTmixDPWh3LsB5QKKSPR7h7ITvLAbqVlfToYc1EjzzjDgwXA+jaR1q0ECUBeekvrFV4C72Z5g7Tq3kYWnMhAkSxcHst8vypWRsmOHPKey1QEyg/gMT2slKjEcOHGxrRjdvKMZQuGTJn8viAyS9hoqYZ/TEqY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b50abe-2a81-4ad1-0bf5-08d6a716d2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 18:16:19.0863
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

The list of modifiers to be supported for each plane has been dynamically g=
enerated
from 'malidp_format_modifiers[]' and 'malidp_hw_regmap->features'.

Changes from v1:-
1. Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_supported=
()
to report unsupported modifiers.

Changes from v2:-
1. Removed malidp_format_mod_supported() from the current patch. This has b=
een added
in "PATCH 7/12"
2. Dynamically generate the list of modifiers (to be supported for each pla=
ne) from
'malidp_format_modifiers' and features.

Changes since v3 (series):
- Added the ack
- Rebased on the latest drm-misc-next

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/arm/malidp_drv.c    |  1 +
 drivers/gpu/drm/arm/malidp_planes.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index 4106f5d..21725c9 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -391,6 +391,7 @@ static int malidp_init(struct drm_device *drm)
 	drm->mode_config.max_height =3D hwdev->max_line_size;
 	drm->mode_config.funcs =3D &malidp_mode_config_funcs;
 	drm->mode_config.helper_private =3D &malidp_mode_config_helpers;
+	drm->mode_config.allow_fb_modifiers =3D true;
=20
 	ret =3D malidp_crtc_init(drm);
 	if (ret)
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index 044bf7f..d42e0ea 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -939,7 +939,26 @@ int malidp_de_planes_init(struct drm_device *drm)
 				  BIT(DRM_MODE_BLEND_PREMULTI)   |
 				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
-	int ret, i, j, n;
+	int ret, i =3D 0, j =3D 0, n;
+	u64 supported_modifiers[MODIFIERS_COUNT_MAX];
+	const u64 *modifiers;
+
+	modifiers =3D malidp_format_modifiers;
+
+	if (!(map->features & MALIDP_DEVICE_AFBC_SUPPORT_SPLIT)) {
+		/*
+		 * Since our hardware does not support SPLIT, so build the list
+		 * of supported modifiers excluding SPLIT ones.
+		 */
+		while (*modifiers !=3D DRM_FORMAT_MOD_INVALID) {
+			if (!(*modifiers & AFBC_SPLIT))
+				supported_modifiers[j++] =3D *modifiers;
+
+			modifiers++;
+		}
+		supported_modifiers[j++] =3D DRM_FORMAT_MOD_INVALID;
+		modifiers =3D supported_modifiers;
+	}
=20
 	formats =3D kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
 	if (!formats) {
@@ -964,9 +983,15 @@ int malidp_de_planes_init(struct drm_device *drm)
=20
 		plane_type =3D (i =3D=3D 0) ? DRM_PLANE_TYPE_PRIMARY :
 					DRM_PLANE_TYPE_OVERLAY;
+
+		/*
+		 * All the layers except smart layer supports AFBC modifiers.
+		 */
 		ret =3D drm_universal_plane_init(drm, &plane->base, crtcs,
-					       &malidp_de_plane_funcs, formats,
-					       n, NULL, plane_type, NULL);
+				&malidp_de_plane_funcs, formats, n,
+				(id =3D=3D DE_SMART) ? NULL : modifiers, plane_type,
+				NULL);
+
 		if (ret < 0)
 			goto cleanup;
=20
--=20
2.7.4

