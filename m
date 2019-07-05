Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03801C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9322133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="F/v7SKjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfGELos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:44:48 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:16001
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbfGELos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKsK/wofcQGnD67tOGoS7SlvTZ6SziwjPE/qMkgHKpI=;
 b=F/v7SKjOoQwGETBbXT4lq8pSQrxYp/TceYgSzDjGJwe8BohE/3dTiX5lbTJXIn0vfg8G1FqmojiclktD7I0ld4eOybIekkPnGNab+aLDQvOE2nGUwqg72nMWRwpFmF7WE435M2b9qqQHMoLueySq/w8DAMkvd0Rrv7wsgr94qkk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4797.eurprd08.prod.outlook.com (10.255.112.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 5 Jul 2019 11:44:45 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 11:44:45 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 2/2] drm/komeda: Computing layer_split and image_enhancer
 internally
Thread-Topic: [PATCH 2/2] drm/komeda: Computing layer_split and image_enhancer
 internally
Thread-Index: AQHVMycKXWrZUM5S4k2zCR4X2FJ5Yw==
Date:   Fri, 5 Jul 2019 11:44:45 +0000
Message-ID: <20190705114427.17456-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 188c5478-6b7b-41be-549b-08d7013e2cc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4797;
x-ms-traffictypediagnostic: VE1PR08MB4797:
x-microsoft-antispam-prvs: <VE1PR08MB4797E6EA92495797F2775D58B3F50@VE1PR08MB4797.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(52116002)(53936002)(6512007)(6436002)(66066001)(6506007)(25786009)(386003)(6486002)(478600001)(3846002)(6116002)(2501003)(68736007)(50226002)(99286004)(26005)(36756003)(316002)(4326008)(55236004)(103116003)(102836004)(54906003)(110136005)(186003)(71190400001)(71200400001)(5660300002)(2906002)(7736002)(305945005)(14444005)(476003)(2616005)(1076003)(8936002)(66476007)(66556008)(64756008)(66446008)(86362001)(2201001)(8676002)(256004)(486006)(73956011)(66946007)(81166006)(14454004)(81156014)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4797;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DUAJ+2jOq5oV7cyV8CsWFzCsjsh1sJwnJEz4vCZKNGqtb0EzbvO018Yo0YOebLL/Jx8EKWbfPG8YSd6Bn9+z3eye7rPO3zPv7k/ipqaWf0p33FWpXMNu1eINKX8BBeUtBLRq625kXYkTB3i3m2VFIAgmYprf0cWPl7ZWEkxQ2SVbO8No7oLLHNsawNiAxnAY+ts8TZzLAcjRaG3RDuUijkTo8qsvRCLkfoHj9NMN1pZYXf7ExvxFn8TGuDbNRVz2a/Uv7yeJXbLNRmKHGBSGejeFOI2S6YvSwLAIKlHn/aLmkDRbVp8lwJ5gEA63EwM6dQxWj3Tl2JUIINbESEHywMnJGvJjZKbdejFj811GIMZa/gQUAQ1ObX+jIWF43TlvNZMJgZ3NpNkOPrcthBeOsYsrj/Cyh/zqsA6MI9Myha8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188c5478-6b7b-41be-549b-08d7013e2cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 11:44:45.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For layer_split:
Enable it if the scaling exceed the accept range of scaler.

For image_enhancer:
Enable it if the scaling is a 2x+ scaling

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_pipeline.h  |  3 ++-
 .../arm/display/komeda/komeda_pipeline_state.c    | 15 ++++++++++++++-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  8 +-------
 .../drm/arm/display/komeda/komeda_wb_connector.c  | 10 +---------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index fc1b8613385e..a90bcbb3cb23 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -537,7 +537,8 @@ void komeda_pipeline_disable(struct komeda_pipeline *pi=
pe,
 void komeda_pipeline_update(struct komeda_pipeline *pipe,
 			    struct drm_atomic_state *old_state);
=20
-void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
+void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
+				   struct komeda_data_flow_cfg *dflow,
 				   struct drm_framebuffer *fb);
=20
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 2b415ef2b7d3..709870bdaa4f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -784,9 +784,11 @@ komeda_timing_ctrlr_validate(struct komeda_timing_ctrl=
r *ctrlr,
 	return 0;
 }
=20
-void komeda_complete_data_flow_cfg(struct komeda_data_flow_cfg *dflow,
+void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
+				   struct komeda_data_flow_cfg *dflow,
 				   struct drm_framebuffer *fb)
 {
+	struct komeda_scaler *scaler =3D layer->base.pipeline->scalers[0];
 	u32 w =3D dflow->in_w;
 	u32 h =3D dflow->in_h;
=20
@@ -803,6 +805,17 @@ void komeda_complete_data_flow_cfg(struct komeda_data_=
flow_cfg *dflow,
=20
 	dflow->en_scaling =3D (w !=3D dflow->out_w) || (h !=3D dflow->out_h);
 	dflow->is_yuv =3D fb->format->is_yuv;
+
+	/* try to enable image enhancer if it is a 2x+ upscaling */
+	dflow->en_img_enhancement =3D dflow->out_w >=3D 2 * w ||
+				    dflow->out_h >=3D 2 * h;
+
+	/* try to enable split if scaling exceed the scaler's acceptable
+	 * input/output range.
+	 */
+	if (dflow->en_scaling && scaler)
+		dflow->en_split =3D !in_range(&scaler->hsize, dflow->in_w) ||
+				  !in_range(&scaler->hsize, dflow->out_w);
 }
=20
 static bool merger_is_available(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index 5bb8553cc117..c095af154216 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -18,7 +18,6 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
 			    struct komeda_data_flow_cfg *dflow)
 {
 	struct komeda_plane *kplane =3D to_kplane(st->plane);
-	struct komeda_plane_state *kplane_st =3D to_kplane_st(st);
 	struct drm_framebuffer *fb =3D st->fb;
 	const struct komeda_format_caps *caps =3D to_kfb(fb)->format_caps;
 	struct komeda_pipeline *pipe =3D kplane->layer->base.pipeline;
@@ -57,10 +56,7 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
 		return -EINVAL;
 	}
=20
-	dflow->en_img_enhancement =3D !!kplane_st->img_enhancement;
-	dflow->en_split =3D !!kplane_st->layer_split;
-
-	komeda_complete_data_flow_cfg(dflow, fb);
+	komeda_complete_data_flow_cfg(kplane->layer, dflow, fb);
=20
 	return 0;
 }
@@ -175,8 +171,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *p=
lane)
=20
 	old =3D to_kplane_st(plane->state);
=20
-	new->img_enhancement =3D old->img_enhancement;
-
 	return &new->base;
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index bb8a61f6e9a4..617e1f7b8472 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -13,7 +13,6 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
 			 struct komeda_crtc_state *kcrtc_st,
 			 struct komeda_data_flow_cfg *dflow)
 {
-	struct komeda_scaler *scaler =3D wb_layer->base.pipeline->scalers[0];
 	struct drm_framebuffer *fb =3D conn_st->writeback_job->fb;
=20
 	memset(dflow, 0, sizeof(*dflow));
@@ -28,14 +27,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
 	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
 	dflow->rot =3D DRM_MODE_ROTATE_0;
=20
-	komeda_complete_data_flow_cfg(dflow, fb);
-
-	/* if scaling exceed the acceptable scaler input/output range, try to
-	 * enable split.
-	 */
-	if (dflow->en_scaling && scaler)
-		dflow->en_split =3D !in_range(&scaler->hsize, dflow->in_w) ||
-				  !in_range(&scaler->hsize, dflow->out_w);
+	komeda_complete_data_flow_cfg(wb_layer, dflow, fb);
=20
 	return 0;
 }
--=20
2.20.1

