Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D721850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QbsInh8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfGDGbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:31:25 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:33143
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5cDa+jXFxFlTb5B+nQ6ibtWucIh9j1Ger14n2h7rdc=;
 b=QbsInh8LcK/O2V3rUfiTt9bDY0/pmPf1RLp0sI68/Pz29osGdAAxivprHhHm8yRX6SdPqCmELCDcCw+2usIgQTeZqYwzHTglLn/9BJnbxXRhhc1EBXMLYGKSqOAVUJXLp9ycsBWlvl2LaYREr6Pg80qiIsQu+IRfkxcKtxtTgqY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4799.eurprd08.prod.outlook.com (10.255.112.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:31:18 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:31:18 +0000
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
Thread-Index: AQHVMjIW57fi7f1cWEmHuaNvRgUuoQ==
Date:   Thu, 4 Jul 2019 06:31:18 +0000
Message-ID: <20190704063011.7431-6-james.qian.wang@arm.com>
References: <20190704063011.7431-1-james.qian.wang@arm.com>
In-Reply-To: <20190704063011.7431-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:2e::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb4eee5-faf0-4a65-022e-08d7004938e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4799;
x-ms-traffictypediagnostic: VE1PR08MB4799:
x-microsoft-antispam-prvs: <VE1PR08MB47998ADD4B364EB5451D79E8B3FA0@VE1PR08MB4799.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(256004)(305945005)(8936002)(4326008)(99286004)(36756003)(110136005)(2616005)(486006)(2501003)(5660300002)(2906002)(316002)(3846002)(50226002)(1076003)(102836004)(26005)(55236004)(6116002)(66066001)(446003)(11346002)(52116002)(476003)(7736002)(66946007)(76176011)(66446008)(54906003)(66476007)(73956011)(386003)(64756008)(68736007)(66556008)(6506007)(6486002)(103116003)(186003)(53936002)(478600001)(25786009)(86362001)(6436002)(2201001)(6512007)(14454004)(81156014)(81166006)(8676002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4799;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WdwE9KMyxbRD5BAympbM8wviAI8/4Dse3BRn+5cnfpQsDqqz9BZugB8H8z3O0jVARd40n6Xa+mDUDHNWVCaHw5ZGuTE9olZOo897+xZ9MlFKpOOO1MOHgX4OXZovE+tia3awrF1buvtPrtYBAQvN3Nwk+zeztQxI91/pgG7Td1GhsI/rzMDS0Rn6c99YZYGhU5H8EUxqXU6lMwK8O+Nbr5wdK8XRa+Sjk/LaSx0TT6yR7dBvA+Md939djIwYLG1FQ6S/brIlETrJQptEEUPn0uYS/xhWsyHvtzh91LMyXnUoX2MHcj+UH3I4i9MVYGnBToA3IxbJmk5Guv977P+/c6UtpGvwr+Qq5H4/DAX53PxssaGi9AHf8LOucPK/rw+Q4Ct4ou+fHjhIfMEItcUjowO81nsBU2Xt2n0V/bxw+qk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb4eee5-faf0-4a65-022e-08d7004938e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:31:18.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4799
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
