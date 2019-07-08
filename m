Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D76C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB46720659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 05:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i8xjNfGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfGHFio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 01:38:44 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:27776
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727286AbfGHFin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z70kcexbLeO0Hy6vrTImscr4g9/MuPHR8gD1w9lKGj8=;
 b=i8xjNfGqNBVF3qWo1B8IR35Fsk10jjHN2Iv29BYlJFFyGUqMuwVBXos9HqtNPLOQeSL9+LZxDI/X8cjxbMyqAmH1FrDXP7geDBeRzu6YSK+taQYb0SvsU8yxssDYywXo1QbPocEx0O+KhLoIjqXCN7eBms3qJ12moeiosSLnedk=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5181.eurprd08.prod.outlook.com (20.179.31.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 05:38:39 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Mon, 8 Jul 2019
 05:38:39 +0000
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
Subject: [PATCH 2/2] drm/komeda: Computing image enhancer internally
Thread-Topic: [PATCH 2/2] drm/komeda: Computing image enhancer internally
Thread-Index: AQHVNU9lN59GOuQcEkeNTfkO8UQO6Q==
Date:   Mon, 8 Jul 2019 05:38:39 +0000
Message-ID: <20190708053819.3574-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR04CA0072.apcprd04.prod.outlook.com
 (2603:1096:202:15::16) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2278cffa-255a-4770-7aea-08d703668781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5181;
x-ms-traffictypediagnostic: VE1PR08MB5181:
x-microsoft-antispam-prvs: <VE1PR08MB518167C7B0C9B3C90E268733B3F60@VE1PR08MB5181.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(366004)(376002)(396003)(189003)(199004)(2906002)(99286004)(478600001)(8936002)(53936002)(6116002)(52116002)(3846002)(5660300002)(26005)(64756008)(86362001)(14454004)(71190400001)(66066001)(2201001)(66556008)(71200400001)(66446008)(73956011)(305945005)(66476007)(6486002)(1076003)(66946007)(25786009)(103116003)(14444005)(256004)(2616005)(6512007)(186003)(6436002)(316002)(102836004)(110136005)(6506007)(2501003)(476003)(386003)(54906003)(55236004)(36756003)(7736002)(81166006)(8676002)(486006)(50226002)(68736007)(4326008)(81156014)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5181;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ylkJiGCSOXfjqMr6/NSldKdqtSn+HXgEvQEYsapdO56tX9b9GHESBHIr6r6P1JZm78aUn3YbkUXQaD4IjzAiw19aIl27FYm9oNsGbb+pNLILhtjf7Uwlw6k5dRFr59y/UWaly3tD3XIVuJcGEon87An7Gg3RvsQsIXrrU8QVBQUSJ4tqRZEkGer9ZNFACxULytcxiECcYLd3YFOVa0J3bn5aYK4t5ybDygfF3qodMW8JtiCUX6q8H7egqZktNi83vFchMPvNlgJZwc47ypiiL09IaineDkRPGyGA6QZjtTU9RJOYfTihco12QStuCpFmn4EBgYkzzXo4ZhdDrc0mUIF753yDFUxSYAleU/T0qlwPQW+4Ti3fd9XAibAB4sHgECmd5JmfTzAclPM3G1/BXk9HFEHMMB6aiz51Rfetbqo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2278cffa-255a-4770-7aea-08d703668781
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 05:38:39.4639
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

