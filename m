Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4327DC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C4520844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V8Nv7QIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfGHG7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:59:51 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:54023
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729176AbfGHG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWtzVWm29lMeW7bLs8cDSUBSBDCuOadjFP/cGn0Kj1w=;
 b=V8Nv7QINPBEUAN/p4h7hfQptC8B0zsEBlZ9bdmo4EtopzzccxQMUYke7J35JvHjyODQYI3TyxL4ph0HVloir3S/kzjBF/glM4trmx8y0xLW9aglVLOHlnR4aDMvVxlo2qAeo8Mxfg8UOnZ2U2+V9nJ5QSkQFX9l7/jBbjfYlUOE=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5135.eurprd08.prod.outlook.com (20.179.30.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 06:59:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 06:59:46 +0000
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
Subject: [PATCH] drm/komeda: Computing layer_split internally
Thread-Topic: [PATCH] drm/komeda: Computing layer_split internally
Thread-Index: AQHVNVq5Ehj6G0Yo20GlV4OvbkFE9g==
Date:   Mon, 8 Jul 2019 06:59:45 +0000
Message-ID: <20190708065923.4887-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98af36ed-7087-46f2-0088-08d70371dc05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5135;
x-ms-traffictypediagnostic: VE1PR08MB5135:
x-microsoft-antispam-prvs: <VE1PR08MB5135358CC5CA0C71662358CDB3F60@VE1PR08MB5135.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(68736007)(1076003)(64756008)(66446008)(66476007)(66556008)(50226002)(2501003)(2201001)(486006)(5660300002)(71200400001)(71190400001)(256004)(14444005)(66946007)(73956011)(316002)(86362001)(476003)(2616005)(81156014)(110136005)(81166006)(54906003)(99286004)(6116002)(14454004)(6436002)(25786009)(8936002)(305945005)(8676002)(6486002)(7736002)(478600001)(52116002)(386003)(6506007)(103116003)(66066001)(4326008)(36756003)(102836004)(26005)(55236004)(53936002)(3846002)(2906002)(6512007)(186003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5135;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5WYDE8Na1NO46WIwaT34FsLl4oEHEo/f9hJD97BIrKbeacJtgzdyzILIjqswF64pDNmKG5+27ewjAf7qumvE4v1rqx+P3YOrje2Au5qG6SF/3RTfnJLUrm2c/Yf4VGm186kfvBazgPztzuag+8kLYyTh95WfD3hj04sYfmbeFCaiPi+86ZqkcfDOwqFFm9BAxyrtmUQfL0eKBJsO+xYoMkyQhjY/hrF4x1DqLca85/ReS/nzaMBGuDyZ8GPhQiCpi8jnF84JcuE0C/8JMTf+5Vc5IoXDBs8y3h85nbMlScfoFbk3rttBVhtGYxBOow+aqRZivaKtx4bAA5ttzNqCwoWeQX6iZXHXJAKINQ6MbcqcNuAvA50ncvkgIn1EVCWXLvn9LaJSiH47Rno4w9I8nST+ChIIJrMsRe7rracczFE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98af36ed-7087-46f2-0088-08d70371dc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 06:59:45.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For layer_split no need user to enable/disable it, but compute it in
komeda internally, komeda will enable it if the scaling exceed the
acceptable range of scaler.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h  |  3 ++-
 .../drm/arm/display/komeda/komeda_pipeline_state.c    | 11 ++++++++++-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c     |  3 +--
 .../gpu/drm/arm/display/komeda/komeda_wb_connector.c  | 10 +---------
 4 files changed, 14 insertions(+), 13 deletions(-)

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
index 2b415ef2b7d3..972a0f25254d 100644
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
@@ -803,6 +805,13 @@ void komeda_complete_data_flow_cfg(struct komeda_data_=
flow_cfg *dflow,
=20
 	dflow->en_scaling =3D (w !=3D dflow->out_w) || (h !=3D dflow->out_h);
 	dflow->is_yuv =3D fb->format->is_yuv;
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
index 5bb8553cc117..b1386438357b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -58,9 +58,8 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
 	}
=20
 	dflow->en_img_enhancement =3D !!kplane_st->img_enhancement;
-	dflow->en_split =3D !!kplane_st->layer_split;
=20
-	komeda_complete_data_flow_cfg(dflow, fb);
+	komeda_complete_data_flow_cfg(kplane->layer, dflow, fb);
=20
 	return 0;
 }
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

