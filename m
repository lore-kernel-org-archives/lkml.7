Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29219C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD80B21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GLby5wWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGCH0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:26:31 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:33494
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfGCH0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p94gQcHHaYt181M+IKhIYpLo3Nz4FNMsEt2G88aW/oI=;
 b=GLby5wWgPfGDOcPiKH709/KQKqDSs+viE9AiUBBumMBqM3ySpIaFCBZj4idxXUcTwHe+LqphuqrkH6DFgl1mBkAAtAAYw0Vxb8P1PEk7pKV4bUWSBhcqFe4LHzh7DGfbZFmdNUTiJG+gPKK/1wDfnCjd10PR880P9RJ7G/gCsrY=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3887.eurprd08.prod.outlook.com (20.178.80.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 07:26:16 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::390b:b8a9:542b:9ef9]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::390b:b8a9:542b:9ef9%3]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 07:26:16 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH] drm/komeda: Adds VRR support
Thread-Topic: [PATCH] drm/komeda: Adds VRR support
Thread-Index: AQHVMXCZgYg0h2S+S0iZ8YXT6sjbYw==
Date:   Wed, 3 Jul 2019 07:26:16 +0000
Message-ID: <1562138723-29546-1-git-send-email-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5a257d2-b24d-46bf-cc34-08d6ff87bc3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3887;
x-ms-traffictypediagnostic: VI1PR08MB3887:
x-microsoft-antispam-prvs: <VI1PR08MB38873E9E3AF719D7176176A89FFB0@VI1PR08MB3887.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(68736007)(50226002)(66556008)(64756008)(66446008)(81156014)(81166006)(66066001)(66476007)(2501003)(2906002)(5660300002)(72206003)(7736002)(8676002)(478600001)(8936002)(305945005)(66946007)(52116002)(6636002)(71200400001)(4326008)(186003)(2201001)(6486002)(53936002)(14454004)(6436002)(99286004)(6512007)(71190400001)(26005)(256004)(3846002)(386003)(110136005)(5024004)(73956011)(14444005)(6506007)(55236004)(316002)(2616005)(486006)(476003)(86362001)(54906003)(6116002)(102836004)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3887;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DKGrf7a1hu0QScsDXkMu9QY+JDSpWsA9q/pE0IKvjMQYZiiDnpm8DX2e6BlZWQ7acplwBxgHxrLOJz+nytu79Qdlp7zWK+4i0i9OZxz7lsnJpLGu6pW4VwfL+Q6OYn50z/5hOjVLjbvPbfjCmgYroOXxxYug2F+bhTUICHi0WxHcJEPJOdt1aL921pvWbuuaywMJTe1lU5tJTGWDNw/mCNgRPNnqMeihEDZpZdGOzWJr7OCBEF3luNaEqzoODBKLFyZe6IIKJwqLyRqbnUVMKQP8L1x6YMiS+iagw8J3C27hMiCJobDcHW3Mkzd8Ih56VPr3DJ3gWaoT3joV2xj3d+GY4hpINqN0lFxataM8aQlCLhUTZu2HAndbgoeFKU0G9ziND6b5z8xkGK35C4i4QjLyrd+HtcwIljMgKtFEHIE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a257d2-b24d-46bf-cc34-08d6ff87bc3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 07:26:16.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lowry.Li@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new drm property "vrr" and "vrr_enable" and implemented
the set/get functions, through which userspace could set vfp
data to komeda.

Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
---
 .../gpu/drm/arm/display/komeda/d71/d71_component.c |  6 +++
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 62 ++++++++++++++++++=
++++
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    | 12 +++++
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  4 +-
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index ed3f273..c1355f5 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -1065,6 +1065,7 @@ static void d71_timing_ctrlr_update(struct komeda_com=
ponent *c,
 				    struct komeda_component_state *state)
 {
 	struct drm_crtc_state *crtc_st =3D state->crtc->state;
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
 	struct drm_display_mode *mode =3D &crtc_st->adjusted_mode;
 	u32 __iomem *reg =3D c->reg;
 	u32 hactive, hfront_porch, hback_porch, hsync_len;
@@ -1102,6 +1103,9 @@ static void d71_timing_ctrlr_update(struct komeda_com=
ponent *c,
 		value |=3D BS_CTRL_DL;
 	}
=20
+	if (kcrtc_st->en_vrr)
+		malidp_write32_mask(reg, BS_VINTERVALS, 0x3FFF, kcrtc_st->vfp);
+
 	malidp_write32(reg, BLK_CONTROL, value);
 }
=20
@@ -1171,6 +1175,8 @@ static int d71_timing_ctrlr_init(struct d71_dev *d71,
 	ctrlr =3D to_ctrlr(c);
=20
 	ctrlr->supports_dual_link =3D true;
+	ctrlr->supports_vrr =3D true;
+	set_range(&ctrlr->vfp_range, 0, 0x3FF);
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 4f580b0..3744e6d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -467,6 +467,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc)
=20
 	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
 	if (state) {
+		state->vfp =3D 0;
+		state->en_vrr =3D 0;
 		crtc->state =3D &state->base;
 		crtc->state->crtc =3D crtc;
 	}
@@ -487,6 +489,8 @@ static void komeda_crtc_reset(struct drm_crtc *crtc)
 	new->affected_pipes =3D old->active_pipes;
 	new->clock_ratio =3D old->clock_ratio;
 	new->max_slave_zorder =3D old->max_slave_zorder;
+	new->vfp =3D old->vfp;
+	new->en_vrr =3D old->en_vrr;
=20
 	return &new->base;
 }
@@ -525,6 +529,30 @@ static void komeda_crtc_vblank_disable(struct drm_crtc=
 *crtc)
=20
 	if (property =3D=3D kcrtc->clock_ratio_property) {
 		*val =3D kcrtc_st->clock_ratio;
+	} else if (property =3D=3D kcrtc->vrr_property) {
+		*val =3D kcrtc_st->vfp;
+	} else if (property =3D=3D kcrtc->vrr_enable_property) {
+		*val =3D kcrtc_st->en_vrr;
+	} else {
+		DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int komeda_crtc_atomic_set_property(struct drm_crtc *crtc,
+					   struct drm_crtc_state *state,
+					   struct drm_property *property,
+					   uint64_t val)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(state);
+
+	if (property =3D=3D kcrtc->vrr_property) {
+		kcrtc_st->vfp =3D val;
+	} else if (property =3D=3D kcrtc->vrr_enable_property) {
+		kcrtc_st->en_vrr =3D val;
 	} else {
 		DRM_DEBUG_DRIVER("Unknown property %s\n", property->name);
 		return -EINVAL;
@@ -544,6 +572,7 @@ static void komeda_crtc_vblank_disable(struct drm_crtc =
*crtc)
 	.enable_vblank		=3D komeda_crtc_vblank_enable,
 	.disable_vblank		=3D komeda_crtc_vblank_disable,
 	.atomic_get_property	=3D komeda_crtc_atomic_get_property,
+	.atomic_set_property	=3D komeda_crtc_atomic_set_property,
 };
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
@@ -613,6 +642,35 @@ static int komeda_crtc_create_slave_planes_property(st=
ruct komeda_crtc *kcrtc)
 	return 0;
 }
=20
+static int komeda_crtc_create_vrr_property(struct komeda_crtc *kcrtc)
+{
+	struct drm_crtc *crtc =3D &kcrtc->base;
+	struct drm_property *prop;
+	struct komeda_timing_ctrlr *ctrlr =3D kcrtc->master->ctrlr;
+
+	if (!ctrlr->supports_vrr)
+		return 0;
+
+	prop =3D drm_property_create_range(crtc->dev, DRM_MODE_PROP_ATOMIC, "vrr"=
,
+					 ctrlr->vfp_range.start,
+					 ctrlr->vfp_range.end);
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&crtc->base, prop, 0);
+	kcrtc->vrr_property =3D prop;
+
+	prop =3D drm_property_create_bool(crtc->dev, DRM_MODE_PROP_ATOMIC,
+					"enable_vrr");
+	if (!prop)
+		return -ENOMEM;
+
+	drm_object_attach_property(&crtc->base, prop, 0);
+	kcrtc->vrr_enable_property =3D prop;
+
+	return 0;
+}
+
 static struct drm_plane *
 get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
 {
@@ -659,6 +717,10 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
 	if (err)
 		return err;
=20
+	err =3D komeda_crtc_create_vrr_property(kcrtc);
+	if (err)
+		return err;
+
 	return err;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index dc1d436..d0cf838 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -98,6 +98,12 @@ struct komeda_crtc {
=20
 	/** @slave_planes_property: property for slaves of the planes */
 	struct drm_property *slave_planes_property;
+
+	/** @vrr_property: property for variable refresh rate */
+	struct drm_property *vrr_property;
+
+	/** @vrr_enable_property: property for enable/disable the vrr */
+	struct drm_property *vrr_enable_property;
 };
=20
 /**
@@ -126,6 +132,12 @@ struct komeda_crtc_state {
=20
 	/** @max_slave_zorder: the maximum of slave zorder */
 	u32 max_slave_zorder;
+
+	/** @vfp: the value of vertical front porch */
+	u32 vfp;
+
+	/** @en_vrr: enable status of variable refresh rate */
+	u8 en_vrr : 1;
 };
=20
 /** struct komeda_kms_dev - for gather KMS related things */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 00e8083..66d7664 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -336,7 +336,9 @@ struct komeda_improc_state {
 /* display timing controller */
 struct komeda_timing_ctrlr {
 	struct komeda_component base;
-	u8 supports_dual_link : 1;
+	u8 supports_dual_link : 1,
+	   supports_vrr : 1;
+	struct malidp_range vfp_range;
 };
=20
 struct komeda_timing_ctrlr_state {
--=20
1.9.1

