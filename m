Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BC02087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pXzZGbcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCLSQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:16:32 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:52547
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbfCLSQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R7/qRTmpJ4pJjEsqouf0ukDqjFATSu9FREFFVX7cT4=;
 b=pXzZGbcln7EAKqIQCOftRGDD2wHXtOhz+sKhwiuAMNQZq62sNZ5VRBzwgHrAl5q2HW2j9ev1N5b2vI8x2g6FXCVKHapH9DGrh80/gzepX9dUHSW44gk2g4F2qicP+U7zQvt7QH0ZSXnAtD+5/tDoAVjkQV18prVNLIn1TUoHkX4=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB5138.eurprd08.prod.outlook.com (10.255.30.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 18:16:17 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::28b7:8370:ebf7:591c%4]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 18:16:17 +0000
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
Subject: [PATCH v4 08/10] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Topic: [PATCH v4 08/10] drm/arm/malidp:- Use the newly introduced
 malidp_format_get_bpp() instead of relying on cpp for calculating framebuffer
 size
Thread-Index: AQHU2P+v5YhSKw7tJEWHvyCsptgpqQ==
Date:   Tue, 12 Mar 2019 18:16:17 +0000
Message-ID: <1552414556-5756-8-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 913750ec-360c-4dc5-05ee-08d6a716d1b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB5138;
x-ms-traffictypediagnostic: AM0PR08MB5138:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB5138EE273D3FA607B08DDA3AE4490@AM0PR08MB5138.eurprd08.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(2501003)(8936002)(6116002)(76176011)(4326008)(3846002)(53936002)(81156014)(81166006)(106356001)(8676002)(6512007)(102836004)(14454004)(105586002)(386003)(186003)(6506007)(256004)(99286004)(5660300002)(52116002)(14444005)(2906002)(97736004)(68736007)(476003)(446003)(2201001)(50226002)(36756003)(6436002)(44832011)(86362001)(316002)(486006)(6486002)(11346002)(2616005)(478600001)(71200400001)(71190400001)(25786009)(110136005)(7736002)(72206003)(305945005)(66066001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5138;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bWVVCQwBCHyhuKzfZ60GLksNYV9aEjShl5tvXydcO78byJWw7ObWzEDPfwgmCjdXw+zS9daOu84ZJymkPINTfDcGJlcW5vcvik19JdvReXd3RBimGSeSGLAV4isSuxE9lc4mvqcgbsTnTzchA4GknQ0deuCeSlta5gq4wnyy+PDo2+BeeKD6zS6gKc/28RTEuBNDyfbY9Tkap17/2ZYUUWJ8iNaxlrZxnbte25ajdpbZ3+eB0B6eQ4uAK7nlHH9aABbvMM0l89vVAkMXd4OjlkPhY5l3zuvqmsgb982RsHI2ezAZClNXeyE2+H0EuHKl0lAFYZpCby3cTt0zx6Nq8mWO6Abk33NQkY52Cxvgh06R40krQq+o12sSK0zm8KEnAXu2OoBR5MCow6esadVJ19WggBxz1hiE5SN7Fwl/ygA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913750ec-360c-4dc5-05ee-08d6a716d1b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 18:16:17.1099
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

Formats like DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
DRM_FORMAT_YUV420_10BIT are expressed in bits per pixel as they have a non
integer value of cpp (thus denoted as '0' in drm_format_info[]). Therefore,
the calculation of AFBC framebuffer size needs to use malidp_format_get_bpp=
().

Changes since v3 (series):
- Added the ack
- Rebased on the latest drm-misc-next

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/gpu/drm/arm/malidp_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index c697664..4106f5d 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -298,6 +298,7 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *=
dev,
 	struct drm_gem_object *objs =3D NULL;
 	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
 	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
+	int bpp =3D 0;
=20
 	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
 	case AFBC_SIZE_16X16:
@@ -314,15 +315,19 @@ malidp_verify_afbc_framebuffer_size(struct drm_device=
 *dev,
 	n_superblocks =3D (mode_cmd->width / afbc_superblock_width) *
 		(mode_cmd->height / afbc_superblock_height);
=20
-	afbc_superblock_size =3D info->cpp[0] * afbc_superblock_width *
-		afbc_superblock_height;
+	bpp =3D malidp_format_get_bpp(info->format);
+
+	afbc_superblock_size =3D (bpp * afbc_superblock_width * afbc_superblock_h=
eight)
+				/ BITS_PER_BYTE;
=20
 	afbc_size =3D ALIGN(n_superblocks * AFBC_HEADER_SIZE, AFBC_SUPERBLK_ALIGN=
MENT);
 	afbc_size +=3D n_superblocks * ALIGN(afbc_superblock_size, AFBC_SUPERBLK_=
ALIGNMENT);
=20
-	if (mode_cmd->width * info->cpp[0] !=3D mode_cmd->pitches[0]) {
-		DRM_DEBUG_KMS("Invalid value of pitch (=3D%u) should be same as width (=
=3D%u) * cpp (=3D%u)\n",
-			      mode_cmd->pitches[0], mode_cmd->width, info->cpp[0]);
+	if ((mode_cmd->width * bpp) !=3D (mode_cmd->pitches[0] * BITS_PER_BYTE)) =
{
+		DRM_DEBUG_KMS("Invalid value of (pitch * BITS_PER_BYTE) (=3D%u) "
+			      "should be same as width (=3D%u) * bpp (=3D%u)\n",
+			      (mode_cmd->pitches[0] * BITS_PER_BYTE),
+			      mode_cmd->width, bpp);
 		return false;
 	}
=20
--=20
2.7.4

