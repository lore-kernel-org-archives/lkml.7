Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B30AC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C521B20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ynDBthGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfGHHBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:01:06 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:41198
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727163AbfGHHBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z70kcexbLeO0Hy6vrTImscr4g9/MuPHR8gD1w9lKGj8=;
 b=ynDBthGNGqnU/JT7tXvNgpkIoBu6LhNrjtm7yc7j3nfQ9UmN9eeWqC7tKXJq7Is6oa1SLcDt4Dsic2jxpos4uUN0b/uVkw5hSsEZEARvXWXXfXJadjgArs8hVx9KA5hbTSkZVbc17O7pOzFjDeGfylEx/kbmJtxfl0Rj1k4sdpI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5101.eurprd08.prod.outlook.com (20.179.30.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 07:00:22 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 07:00:22 +0000
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
Subject: [PATCH] drm/komeda: Computing image enhancer internally
Thread-Topic: [PATCH] drm/komeda: Computing image enhancer internally
Thread-Index: AQHVNVrPu6PYjuCA40ChWI9unR3hug==
Date:   Mon, 8 Jul 2019 07:00:22 +0000
Message-ID: <20190708070000.4945-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ebff02-b367-4f49-20e8-08d70371f188
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5101;
x-ms-traffictypediagnostic: VE1PR08MB5101:
x-microsoft-antispam-prvs: <VE1PR08MB51015A76BBE1B90816C84984B3F60@VE1PR08MB5101.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39850400004)(376002)(199004)(189003)(26005)(478600001)(99286004)(86362001)(2201001)(71190400001)(71200400001)(186003)(316002)(3846002)(52116002)(476003)(2501003)(66066001)(6116002)(102836004)(55236004)(25786009)(2616005)(7736002)(386003)(6506007)(486006)(8676002)(66446008)(81166006)(66556008)(64756008)(6486002)(66476007)(2906002)(4326008)(256004)(73956011)(6436002)(14444005)(68736007)(66946007)(14454004)(81156014)(50226002)(53936002)(54906003)(5660300002)(36756003)(110136005)(1076003)(8936002)(6512007)(305945005)(103116003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5101;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBYcCgdy8kTKb2hEE9jvxSuw0EvclRhzExehrYKE30sS6aqUUVSCRx8gwJgQHlWeId8TQSELAgCI4CccmXxQo53uY4fAqMXqrrKpVS+Y4kKXqu033f6459KdtQLVjtczoOV30gn0nxOjnVyI4Gax/WS+EHKOHNyPVFv9Xctp2tXW/uSDxFoYb77ghBRkB8lABBq1lcS7do8O8qX1EMQSiPByAIInjMpjAbcDjfIhmhI10t+7ayRYwllam5VtxM3Nu4jjIs3m+5DXJJd5cBpFTkd0HdoZDwox32K0NPqJQrgHJD5J3EA1MqsJtIWL6ITNKIN/DhiJg15pSi0af4x/f9md5G4jHShE2NLBdkeVaBCi5oZFg1hCGeOBqrOHJ883eVJhex8Rgb9c0to3wgNEuzF38rnR002htAuD6W7lFs4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ebff02-b367-4f49-20e8-08d70371f188
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 07:00:22.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable image enhancer when the input data flow is 2x+ upscaling.

Signed-off-by: james qian wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h            | 7 ++-----
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++++
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c          | 5 -----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 0c006576a25c..8c89fc245b83 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -47,11 +47,8 @@ struct komeda_plane_state {
 	/** @zlist_node: zorder list node */
 	struct list_head zlist_node;
=20
-	/* @img_enhancement: on/off image enhancement
-	 * @layer_split: on/off layer_split
-	 */
-	u8 img_enhancement : 1,
-	   layer_split : 1;
+	/** @layer_split: on/off layer_split */
+	u8 layer_split : 1;
 };
=20
 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 972a0f25254d..950235af1e79 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -806,6 +806,10 @@ void komeda_complete_data_flow_cfg(struct komeda_layer=
 *layer,
 	dflow->en_scaling =3D (w !=3D dflow->out_w) || (h !=3D dflow->out_h);
 	dflow->is_yuv =3D fb->format->is_yuv;
=20
+	/* try to enable image enhancer if data flow is a 2x+ upscaling */
+	dflow->en_img_enhancement =3D dflow->out_w >=3D 2 * w ||
+				    dflow->out_h >=3D 2 * h;
+
 	/* try to enable split if scaling exceed the scaler's acceptable
 	 * input/output range.
 	 */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index b1386438357b..c095af154216 100644
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
@@ -57,8 +56,6 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
 		return -EINVAL;
 	}
=20
-	dflow->en_img_enhancement =3D !!kplane_st->img_enhancement;
-
 	komeda_complete_data_flow_cfg(kplane->layer, dflow, fb);
=20
 	return 0;
@@ -174,8 +171,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *p=
lane)
=20
 	old =3D to_kplane_st(plane->state);
=20
-	new->img_enhancement =3D old->img_enhancement;
-
 	return &new->base;
 }
=20
--=20
2.20.1

