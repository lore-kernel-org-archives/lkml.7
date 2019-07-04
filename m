Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F62BC06510
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B4A2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="+SJVZczY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfGDGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:18:48 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:3812
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywYIGffmJVJTuipwozQ7D/vOtWbzSjF3LL/JViTvy1o=;
 b=+SJVZczY3YEuKbYCfEhn4/a78x3KyElHvavJYQU6AIsDCEA+fnOPNZtFoZ6XqoxkJTGIO8riJx7q3lFm6Ajht0OtIsVTVLCG/ysL2EpT5mgTjJtg0XZn4zBwIjoFmYAsFkH+CF0QYHi19fHVu0w/AgxzIztQX6B1bRMn8JpZo50=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 06:18:41 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:18:41 +0000
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
Subject: [PATCH 4/6] drm/komeda: Add side by side support for writeback
Thread-Topic: [PATCH 4/6] drm/komeda: Add side by side support for writeback
Thread-Index: AQHVMjBTbFY0GrGtY0Kn+yCBeCAL7A==
Date:   Thu, 4 Jul 2019 06:18:41 +0000
Message-ID: <20190704061717.6854-5-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: 74c61768-3ca0-4353-ac3c-08d7004775af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
x-microsoft-antispam-prvs: <VE1PR08MB46373ACC7D759A2C78724E48B3FA0@VE1PR08MB4637.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(99286004)(110136005)(14444005)(36756003)(68736007)(256004)(52116002)(102836004)(26005)(386003)(55236004)(3846002)(6116002)(6506007)(8676002)(5660300002)(103116003)(486006)(2906002)(54906003)(76176011)(2501003)(186003)(6436002)(81156014)(81166006)(2201001)(476003)(71200400001)(86362001)(305945005)(446003)(7736002)(11346002)(8936002)(478600001)(2616005)(6486002)(66476007)(64756008)(66066001)(66946007)(4326008)(53936002)(50226002)(66446008)(14454004)(316002)(73956011)(66556008)(71190400001)(6512007)(1076003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mvKGSR39R8xB12Uo8XM4gONHfmtHBk9duHs0ov6XcKu32afyUQxpWs+RqCRiVbkFtinO0ZK/NonLooRQwqCNQ7jfMrsbFlXSNDH2udraOr6qJuIbl329yiOruzsBagPkmzzp8PIr0eJ1ERIcRvW9aclvCUZD28hkuYlYALjmlv8S1FSXRM/NuVZA7VJZxhj4o5iAoRUkLrxdFcW7QGlGJN9fptzFKktfpzb/ZWUgloHCbJ9o9T+1J57H5oMq30fKxrtklonXvb+3grT7pzlFCO/VwB0VZxaptoZLr9YwaXGgYGfYrgnsZq4hmKF5uZgX6GoWoRpRAnVuVfzE6GRYXBTGqBHhBrkI7kvVA+vRMFTKnE7MN34RIjpwpjUcQmGLtubYT1RpVYyXW6WhUnrAWwMHSBfiCZeCNt3uGw2o5cs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c61768-3ca0-4353-ac3c-08d7004775af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:18:41.7637
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

In side by side mode, the master pipeline writeback the left frame and the
slave writeback the right part, the data flow as below:

  slave.compiz -> slave.wb_layer -> fb (right-part)
  master.compiz -> master.wb_layer -> fb (left-part)

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  4 ++
 .../display/komeda/komeda_pipeline_state.c    | 42 +++++++++++++++++++
 .../arm/display/komeda/komeda_wb_connector.c  |  6 ++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 3358bcea8f7d..9145af3355f4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -554,6 +554,10 @@ int komeda_build_wb_split_data_flow(struct komeda_laye=
r *wb_layer,
 				    struct drm_connector_state *conn_st,
 				    struct komeda_crtc_state *kcrtc_st,
 				    struct komeda_data_flow_cfg *dflow);
+int komeda_build_wb_sbs_data_flow(struct komeda_crtc *kcrtc,
+				  struct drm_connector_state *conn_st,
+				  struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg *wb_dflow);

 int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 				   struct komeda_crtc_state *kcrtc_st);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 4e5c891fbbd4..9fcd3d7cabe5 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1349,6 +1349,48 @@ int komeda_build_wb_split_data_flow(struct komeda_la=
yer *wb_layer,
 	return komeda_wb_layer_validate(wb_layer, conn_st, dflow);
 }

+/* writeback side by side split data path:
+ *
+ * slave.compiz -> slave.wb_layer - > fb (right-part)
+ * master.compiz -> master.wb_layer -> fb (left-part)
+ */
+int komeda_build_wb_sbs_data_flow(struct komeda_crtc *kcrtc,
+				  struct drm_connector_state *conn_st,
+				  struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg *wb_dflow)
+{
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_pipeline *slave =3D kcrtc->slave;
+	struct komeda_data_flow_cfg m_dflow, s_dflow;
+	int err;
+
+	if (wb_dflow->en_scaling || wb_dflow->en_img_enhancement) {
+		DRM_DEBUG_ATOMIC("sbs doesn't support WB_scaling\n");
+		return -EINVAL;
+	}
+
+	memcpy(&m_dflow, wb_dflow, sizeof(*wb_dflow));
+	memcpy(&s_dflow, wb_dflow, sizeof(*wb_dflow));
+
+	/* master writeout the left part */
+	m_dflow.in_w >>=3D 1;
+	m_dflow.out_w >>=3D 1;
+	m_dflow.input.component =3D &master->compiz->base;
+
+	/* slave writeout the right part */
+	s_dflow.in_w >>=3D 1;
+	s_dflow.out_w >>=3D 1;
+	s_dflow.in_x +=3D m_dflow.in_w;
+	s_dflow.out_x +=3D m_dflow.out_w;
+	s_dflow.input.component =3D &slave->compiz->base;
+
+	err =3D komeda_wb_layer_validate(master->wb_layer, conn_st, &m_dflow);
+	if (err)
+		return err;
+
+	return komeda_wb_layer_validate(slave->wb_layer, conn_st, &s_dflow);
+}
+
 /* build display output data flow, the data path is:
  * compiz -> improc -> timing_ctrlr
  */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index c1b0ad22422e..ea584b1e5bd2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -45,6 +45,7 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encode=
r,
 			       struct drm_crtc_state *crtc_st,
 			       struct drm_connector_state *conn_st)
 {
+	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc_st->crtc);
 	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
 	struct drm_writeback_job *writeback_job =3D conn_st->writeback_job;
 	struct komeda_layer *wb_layer;
@@ -73,7 +74,10 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encod=
er,
 	if (err)
 		return err;

-	if (dflow.en_split)
+	if (kcrtc->side_by_side)
+		err =3D komeda_build_wb_sbs_data_flow(kcrtc,
+				conn_st, kcrtc_st, &dflow);
+	else if (dflow.en_split)
 		err =3D komeda_build_wb_split_data_flow(wb_layer,
 				conn_st, kcrtc_st, &dflow);
 	else
--
2.20.1
