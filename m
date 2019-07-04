Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF45C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E45216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="sPtul+51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfGDGSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:18:54 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:64834
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5cDa+jXFxFlTb5B+nQ6ibtWucIh9j1Ger14n2h7rdc=;
 b=sPtul+51vrBvhbhBzoYKO8PAI5Iw5luyTaaKHKXP8zTY4DgqKHN6UdlWodwAks4dT/YlkKPFvB2vq1VvD02b5h6ewDKHHSuW4IkWQHE1fzbK+5M2spsxgdoFR544ibD56bXhR1719683x0CnDNW3prgII8YICVMtu3RMMu4VM7c=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 06:18:49 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:18:49 +0000
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
Subject: [PATCH 5/6] drm/komeda: Update writeback signal for side_by_side
Thread-Topic: [PATCH 5/6] drm/komeda: Update writeback signal for side_by_side
Thread-Index: AQHVMjBXsi95oRG0aUKNUDy22dS6Ow==
Date:   Thu, 4 Jul 2019 06:18:49 +0000
Message-ID: <20190704061717.6854-6-james.qian.wang@arm.com>
References: <20190704061717.6854-1-james.qian.wang@arm.com>
In-Reply-To: <20190704061717.6854-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 438e669d-937d-4595-8557-08d700477a26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
x-microsoft-antispam-prvs: <VE1PR08MB463736D78B4A257856A41AC3B3FA0@VE1PR08MB4637.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(99286004)(110136005)(36756003)(68736007)(256004)(52116002)(102836004)(26005)(386003)(55236004)(3846002)(6116002)(6506007)(8676002)(5660300002)(103116003)(486006)(2906002)(54906003)(76176011)(2501003)(186003)(6436002)(81156014)(81166006)(2201001)(476003)(71200400001)(86362001)(305945005)(446003)(7736002)(11346002)(8936002)(478600001)(2616005)(6486002)(66476007)(64756008)(66066001)(66946007)(4326008)(53936002)(50226002)(66446008)(14454004)(316002)(73956011)(66556008)(71190400001)(6512007)(1076003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y/bf+jm6LC616ZSjlQodJ23eEqYfzQoFIoizEIR482AB+99dddqTHEFoIjb1SG56qUJ4WY5phxVABTBo+GX6wRbfJ9S+R4rG36u/ot/av2pnqBvXpPC4IxboZAtLzC7Gg1sBk6hhvYerkMzwoebIk/Bhzt2gi71oLEM/SUSGSI+MpK2UKohBOVn8f4rhvhPEH454oOb061w52Jcxb8x5jhyZC7sq5LyFj2OwBpgjtcKPOeUpJ4Trrb8Az1ic4VBQzOUeEGSTOyQkO4yzppH/G0a95/+smJ9UU0apdTm8zq0KIAxOndL3T6MzRpOCRSaS40NaH8/ClDIxHV5EgVbAVPDuHgnkLDC9g9EFb+/A/DejLhR6W6UGvcoCUgjsfnXEfuoBwwwGTX21v5Ed2Fu55lHoYI7sUdfzCm3QKbP8ky8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438e669d-937d-4595-8557-08d700477a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:18:49.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In side by side mode, a writeback job is completed by two pipelines: left
by master and right by slave, we need to wait both pipeline finished (EOW),
then can signal the writeback job completion.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 23 ++++++++++---------
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  5 ++++
 .../arm/display/komeda/komeda_wb_connector.c  |  3 +++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 133ea4728149..ca1bef8fb8dc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -194,27 +194,28 @@ komeda_crtc_unprepare(struct komeda_crtc *kcrtc)
 	return err;
 }

-void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
+void komeda_crtc_handle_event(struct komeda_crtc *kcrtc,
 			      struct komeda_events *evts)
 {
 	struct drm_crtc *crtc =3D &kcrtc->base;
+	struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
 	u32 events =3D evts->pipes[kcrtc->master->id];

 	if (events & KOMEDA_EVENT_VSYNC)
 		drm_crtc_handle_vblank(crtc);

-	if (events & KOMEDA_EVENT_EOW) {
-		struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
+	/* handles writeback event */
+	if (events & KOMEDA_EVENT_EOW)
+		wb_conn->complete_pipes |=3D BIT(kcrtc->master->id);

-		if (wb_conn)
-			drm_writeback_signal_completion(&wb_conn->base, 0);
-		else
-			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
-				 drm_crtc_index(&kcrtc->base));
+	if (kcrtc->side_by_side &&
+	    (evts->pipes[kcrtc->slave->id] & KOMEDA_EVENT_EOW))
+		wb_conn->complete_pipes |=3D BIT(kcrtc->slave->id);
+
+	if (wb_conn->expected_pipes =3D=3D wb_conn->complete_pipes) {
+		wb_conn->complete_pipes =3D 0;
+		drm_writeback_signal_completion(&wb_conn->base, 0);
 	}
-	/* will handle it together with the write back support */
-	if (events & KOMEDA_EVENT_EOW)
-		DRM_DEBUG("EOW.\n");

 	if (events & KOMEDA_EVENT_FLIP) {
 		unsigned long flags;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 0dbfd7ad7805..3cb57ea82192 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -66,6 +66,11 @@ struct komeda_wb_connector {

 	/** @wb_layer: represents associated writeback pipeline of komeda */
 	struct komeda_layer *wb_layer;
+
+	/** @expected_pipes: pipelines are used for the writeback job */
+	u32 expected_pipes;
+	/** @complete_pipes: pipelines which have finished writeback */
+	u32 complete_pipes;
 };

 /**
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index ea584b1e5bd2..9787745713df 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -165,6 +165,9 @@ static int komeda_wb_connector_add(struct komeda_kms_de=
v *kms,
 		return -ENOMEM;

 	kwb_conn->wb_layer =3D kcrtc->master->wb_layer;
+	kwb_conn->expected_pipes =3D BIT(kcrtc->master->id);
+	if (kcrtc->side_by_side)
+		kwb_conn->expected_pipes |=3D BIT(kcrtc->slave->id);

 	wb_conn =3D &kwb_conn->base;
 	wb_conn->encoder.possible_crtcs =3D BIT(drm_crtc_index(&kcrtc->base));
--
2.20.1
