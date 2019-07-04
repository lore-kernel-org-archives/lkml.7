Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE17C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A472189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PSFRAPWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGDGa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:30:58 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:4198
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVyNLvfisJfPXATCCp6wvOxKpnqE6PgX1ACMpSaAYxY=;
 b=PSFRAPWpdvimdQGKr2Ulw0DXH+I+E5StfeF1qUevSZYPNeEbCf0Jq95MJVw5QBGr9vWb89G4BsPTudsEKj8J+04rpk2IFPI7ASwN7hvs81YPzJ9DH9tVNg51sIHgaOaF7LHV9Jfjz3z74Lz/OAhYuQLBREc7yAwxXry1t3rLN5o=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5229.eurprd08.prod.outlook.com (10.255.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:30:53 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:30:53 +0000
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
Subject: [PATCH 1/6] drm/komeda: Add side by side assembling
Thread-Topic: [PATCH 1/6] drm/komeda: Add side by side assembling
Thread-Index: AQHVMjIHiQqcXatIJ0mfrkxe1DUmhw==
Date:   Thu, 4 Jul 2019 06:30:53 +0000
Message-ID: <20190704063011.7431-2-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: 2440661c-7c6d-429f-4dd5-08d700492948
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5229;
x-ms-traffictypediagnostic: VE1PR08MB5229:
x-microsoft-antispam-prvs: <VE1PR08MB52292EC696EF175B26FCABA7B3FA0@VE1PR08MB5229.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(76176011)(6506007)(66066001)(110136005)(386003)(54906003)(103116003)(2906002)(316002)(186003)(86362001)(2201001)(52116002)(55236004)(99286004)(26005)(102836004)(6486002)(50226002)(25786009)(478600001)(71200400001)(71190400001)(6512007)(6436002)(4326008)(68736007)(53936002)(14454004)(2616005)(476003)(486006)(36756003)(446003)(11346002)(81166006)(8676002)(256004)(14444005)(81156014)(8936002)(305945005)(7736002)(66946007)(6116002)(73956011)(66476007)(66556008)(64756008)(66446008)(3846002)(2501003)(5660300002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5229;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wC+GUNGESRI6YiBgBAXmSk9kpAUNaaxFY6ZvlKqY7K2ESj79WnRrZWPhPWUs46KhXzblOdeuZOiFcWN8p8uSmtRCXsvYIJMVWcK2GS1MWofLerrm73uMvO79NgUWtPKsng6tD03cq2OAepUZBtduVnp7zUzPlLqWtm4Cp5031X8MNPk0qqeMzp0UmZmBpSODiR7BSVpQdfP9wnj+Nq4ZfKrelTTYQT4ggAXaChPGc290GPTVgS8OSzHrLXWj5neNyYd3l2qSFDjQOeWClNRSA3PcqtyHNLXTuCkyDPhNXzrD/d+igbo1dLRWbVNKZLH8edBBkPFKkXprWlkNQNg8/uuJElUi1mDMej9PRBMGH1vnJGkjqQenSPWhuf8cOtwqGuQvFDbfB2LsdQ+Pc+GJ0EqoI0SZw1lYtxwQ2q7S9+c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2440661c-7c6d-429f-4dd5-08d700492948
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:30:53.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda HW can support side by side, which splits the internal display
processing to two single halves (LEFT/RIGHT) and handle them by two
pipelines separately.
komeda "side by side" is enabled by DT property: "side_by_side_master",
once DT configured side by side, komeda need to verify it with HW's
configuration, and assemble it for the further usage.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  9 +++-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  3 ++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  9 ++++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  3 ++
 .../drm/arm/display/komeda/komeda_pipeline.c  | 50 +++++++++++++++++--
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 6 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 3744e6d1ba96..c3bb111c454c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -591,16 +591,21 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms=
,

 		crtc->master =3D master;
 		crtc->slave  =3D komeda_pipeline_get_slave(master);
+		crtc->side_by_side =3D mdev->side_by_side;

 		if (crtc->slave)
 			sprintf(str, "pipe-%d", crtc->slave->id);
 		else
 			sprintf(str, "None");

-		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s).\n",
-			 kms->n_crtcs, master->id, str);
+		DRM_INFO("CRTC-%d: master(pipe-%d) slave(%s) sbs(%s).\n",
+			 kms->n_crtcs, master->id, str,
+			 crtc->side_by_side ? "On" : "Off");

 		kms->n_crtcs++;
+
+		if (mdev->side_by_side)
+			break;
 	}

 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index bb72642cfd67..2aee735a683f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -191,6 +191,9 @@ static int komeda_parse_dt(struct device *dev, struct k=
omeda_dev *mdev)
 		}
 	}

+	mdev->side_by_side =3D !of_property_read_u32(np, "side_by_side_master",
+					&mdev->side_by_side_master);
+
 	return ret;
 }

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index e863ec327790..c70cc25d246f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -176,6 +176,15 @@ struct komeda_dev {

 	/** @irq: irq number */
 	int irq;
+	/**
+	 * @side_by_side:
+	 *
+	 * on sbs the whole display frame will be split to two halves (1:2),
+	 * master pipeline handles the left part, slave for the right part
+	 */
+	bool side_by_side;
+	/** @side_by_side_master: master pipe id for side by side */
+	int side_by_side_master;

 	/** @lock: used to protect dpmode */
 	struct mutex lock;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index d0cf8381d2ab..0dbfd7ad7805 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -84,6 +84,9 @@ struct komeda_crtc {
 	 */
 	struct komeda_pipeline *slave;

+	/** @side_by_side: if the master and slave works on side by side mode */
+	bool side_by_side;
+
 	/** @slave_planes: komeda slave planes mask */
 	u32 slave_planes;

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 452e505a1fd3..104e27cc1dc3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -326,14 +326,56 @@ static void komeda_pipeline_assemble(struct komeda_pi=
peline *pipe)
 struct komeda_pipeline *
 komeda_pipeline_get_slave(struct komeda_pipeline *master)
 {
-	struct komeda_component *slave;
+	struct komeda_dev *mdev =3D master->mdev;
+	struct komeda_component *comp, *slave;
+	u32 avail_inputs;
+
+	/* on SBS, slave pipeline merge to master via image processor */
+	if (mdev->side_by_side) {
+		comp =3D &master->improc->base;
+		avail_inputs =3D KOMEDA_PIPELINE_IMPROCS;
+	} else {
+		comp =3D &master->compiz->base;
+		avail_inputs =3D KOMEDA_PIPELINE_COMPIZS;
+	}

-	slave =3D komeda_component_pickup_input(&master->compiz->base,
-					      KOMEDA_PIPELINE_COMPIZS);
+	slave =3D komeda_component_pickup_input(comp, avail_inputs);

 	return slave ? slave->pipeline : NULL;
 }

+static int komeda_assemble_side_by_side(struct komeda_dev *mdev)
+{
+	struct komeda_pipeline *master, *slave;
+	int i;
+
+	if (!mdev->side_by_side)
+		return 0;
+
+	if (mdev->side_by_side_master >=3D mdev->n_pipelines) {
+		DRM_ERROR("DT configured side by side master-%d is invalid.\n",
+			  mdev->side_by_side_master);
+		return -EINVAL;
+	}
+
+	master =3D mdev->pipelines[mdev->side_by_side_master];
+	slave =3D komeda_pipeline_get_slave(master);
+	if (!slave || slave->n_layers !=3D master->n_layers) {
+		DRM_ERROR("Current HW doesn't support side by side.\n");
+		return -EINVAL;
+	}
+
+	if (!master->dual_link) {
+		DRM_DEBUG_ATOMIC("SBS can not work without dual link.\n");
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < master->n_layers; i++)
+		master->layers[i]->sbs_slave =3D slave->layers[i];
+
+	return 0;
+}
+
 int komeda_assemble_pipelines(struct komeda_dev *mdev)
 {
 	struct komeda_pipeline *pipe;
@@ -346,7 +388,7 @@ int komeda_assemble_pipelines(struct komeda_dev *mdev)
 		komeda_pipeline_dump(pipe);
 	}

-	return 0;
+	return komeda_assemble_side_by_side(mdev);
 }

 void komeda_pipeline_dump_register(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 66d76642bc5b..6d3745bb8c1d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -236,6 +236,7 @@ struct komeda_layer {
 	 * not the source buffer.
 	 */
 	struct komeda_layer *right;
+	struct komeda_layer *sbs_slave;
 };

 struct komeda_layer_state {
--
2.20.1
