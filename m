Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454BC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA7B20659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0ivlzNsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfGHFh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 01:37:56 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:65040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbfGHFhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWtzVWm29lMeW7bLs8cDSUBSBDCuOadjFP/cGn0Kj1w=;
 b=0ivlzNsR6Xf9vl4KqrtO1Zd5tXNwB9FFL5F7+vP/27qBp4hJSG90iYkZMVZXztrd7hFQdVTN301wvSJ0N6ATisCbgpdXAaNSgoUG5TpQDxy5z68ruSE43woHsxABxqoevpqFG3of4umGqwB8swNaX8vMAkNQQB1bhouKcs4g3Go=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5181.eurprd08.prod.outlook.com (20.179.31.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 05:37:50 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 05:37:50 +0000
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
Subject: [PATCH 1/2] drm/komeda: Computing layer_split internally
Thread-Topic: [PATCH 1/2] drm/komeda: Computing layer_split internally
Thread-Index: AQHVNU9H6u/+WBtsXEalJYGmE2ppQg==
Date:   Mon, 8 Jul 2019 05:37:50 +0000
Message-ID: <20190708053729.3502-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:203:52::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3396cd9f-f9e9-450a-56a9-08d703666a2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5181;
x-ms-traffictypediagnostic: VE1PR08MB5181:
x-microsoft-antispam-prvs: <VE1PR08MB51810DB52DFD5CF6AA60A4A9B3F60@VE1PR08MB5181.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(366004)(376002)(396003)(189003)(199004)(2906002)(99286004)(478600001)(8936002)(53936002)(6116002)(52116002)(3846002)(5660300002)(26005)(64756008)(86362001)(14454004)(71190400001)(66066001)(2201001)(66556008)(71200400001)(66446008)(73956011)(305945005)(66476007)(6486002)(1076003)(66946007)(25786009)(103116003)(14444005)(256004)(2616005)(6512007)(186003)(6436002)(316002)(102836004)(110136005)(6506007)(2501003)(476003)(386003)(54906003)(55236004)(36756003)(7736002)(81166006)(8676002)(486006)(50226002)(68736007)(4326008)(81156014)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5181;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xxlGQUQiQ/q4andzhrDJyhVBeDglWi7waFg5Gy7Hve35nOXYFgRj0PysRRr2DBuJ5Og3ucOlz5mZeBx3YPbhEbrmhgVTIqEZA+XPuVd8/Wbj5gYp+8hIhR+qgYqHafGWZWo7vlYDq+WxaGoFs0WsNaTTaZuC2QLyUyhiu1fbbeXmnACv/GAzDOpk1JW5aKJSoeNMr6kZYEGuBEv2Mo6Q5KrJNQnijYa5xLOzblWPPIqAujGdNWweiBst5nUWyyeUv+wW2FhvO+na0r68uYRXf+WBlnHhukzCCN5DPSeOP8/aR+dVJXL6dopHZVvrcwRMhqfb8xByTGm1GQb/Wk2Y49d2Fn8bg4Xzz7M6xHPZtmK9lMMXA9wK0WUvVOaghtLpyM4w3LNKpi3d5YxJweWAcX8N/WwgOgs6zNzMURpeDoM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3396cd9f-f9e9-450a-56a9-08d703666a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 05:37:50.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5181
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

