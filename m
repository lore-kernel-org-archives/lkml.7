Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3742EC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06662218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aWNyQl6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGDGSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:18:33 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:62404
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVJmM650iZrJXShIkidsXZ6RIhGHrmzctzH2PLmRtrY=;
 b=aWNyQl6lBrsVQzFyiA0Syhf89Y3cW0qyYHxiOG4Ghlr/h1AK5SGxWojJakXwSFENg7RW7Vfy6Q8nB2y8jyJQ/iV+3cKEPtQaP3fnHETZ4rJhZSjSqrKnl/3geUMBIHwmf5qMvqaH8cZ6JU4pWW2qWezSdZT9MZUu4Q0DYPYbcvs=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 06:18:27 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:18:27 +0000
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
Subject: [PATCH 2/6] drm/komeda: Add side by side plane_state split
Thread-Topic: [PATCH 2/6] drm/komeda: Add side by side plane_state split
Thread-Index: AQHVMjBKQnzmAbqxSkGNREzJRMThgw==
Date:   Thu, 4 Jul 2019 06:18:27 +0000
Message-ID: <20190704061717.6854-3-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: b1d003a2-e5d2-447c-7efa-08d700476cd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
x-microsoft-antispam-prvs: <VE1PR08MB463780919148DC4015ACEC85B3FA0@VE1PR08MB4637.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(99286004)(110136005)(30864003)(36756003)(68736007)(256004)(52116002)(102836004)(26005)(386003)(55236004)(3846002)(6116002)(6506007)(8676002)(5660300002)(103116003)(486006)(2906002)(54906003)(76176011)(2501003)(186003)(6436002)(81156014)(81166006)(2201001)(476003)(71200400001)(86362001)(305945005)(446003)(7736002)(11346002)(8936002)(478600001)(2616005)(6486002)(66476007)(64756008)(66066001)(66946007)(4326008)(53936002)(50226002)(66446008)(14454004)(316002)(73956011)(66556008)(71190400001)(6512007)(1076003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DzeJLFzwNRPTbbs/1QgDpxcSjSgx3kE2jgCminQ0vVNMbTyzd5Rn0rbbVD8b6IvGimx4J9CIqjnrNyevxqcW0IeAAfqIREpS5RhQhvPhPr9g15ukPDHm1o7noXZxgJIa41maXehzBdXl3S6yW5nWRpSi5De9k1B2unNaEEzmnnFyROeDuHu0LDKcc01knnUD5LEVGlzDU13AAalv9NPU5ZLvnLtNbKmZmhk5jqhfqd4sgvPnvKoQpdN4Hbo6MHpmVgHXWIxqtrOSlLhT/qMsWqxcesDwTbXG6YeLdsP13mBu3jPz81nFBV1gIEsL0hleNTUq5TsHPcV1Iya0cUSRv1ZJtodPi2LVnER80QsEiTaJqMhaEixIxSL5c7+2p75LeYeqdTC9sjtVnCUD/WzGYuE9xlx+8TPcXoFk2Zs8Aec=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d003a2-e5d2-447c-7efa-08d700476cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:18:27.0340
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

On side by side mode, The full display frame will be split into two parts
(Left/Right), and each part will be handled by a single pipeline separately
master pipeline for left part, slave for right.

To simplify the usage and implementation, komeda use the following scheme
to do the side by side split
1. The planes also have been grouped into two classes:
   master-planes and slave-planes.
2. The master plane can display its image on any location of the final/full
   display frame, komeda will help to split the plane configuration to two
   parts and fed them into master and slave pipelines.
3. The slave plane only can put its display rect on the right part of the
   final display frame, and its data is only can be fed into the slave
   pipeline.

From the perspective of resource usage and assignment:
The master plane can use the resources from the master pipeline and slave
pipeline both, but slave plane only can use the slave pipeline resources.

With such scheme, the usage of master planes are same as the none
side_by_side mode. user can easily skip the slave planes and no need to
consider side_by_side for them.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  33 ++-
 .../display/komeda/komeda_pipeline_state.c    | 188 ++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 3 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 6d3745bb8c1d..aa7c0fefa47e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -511,6 +511,20 @@ komeda_component_pickup_output(struct komeda_component=
 *c, u32 avail_comps)
 	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs);
 }

+static inline const char *
+komeda_data_flow_msg(struct komeda_data_flow_cfg *config)
+{
+	static char str[128];
+
+	snprintf(str, sizeof(str),
+		 "rot: %x src[x/y:%d/%d, w/h:%d/%d] disp[x/y:%d/%d, w/h:%d/%d]",
+		 config->rot,
+		 config->in_x, config->in_y, config->in_w, config->in_h,
+		 config->out_x, config->out_y, config->out_w, config->out_h);
+
+	return str;
+}
+
 struct komeda_plane_state;
 struct komeda_crtc_state;
 struct komeda_crtc;
@@ -522,22 +536,27 @@ int komeda_build_layer_data_flow(struct komeda_layer =
*layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_data_flow_cfg *dflow);
-int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
-			      struct drm_connector_state *conn_st,
-			      struct komeda_crtc_state *kcrtc_st,
-			      struct komeda_data_flow_cfg *dflow);
-int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
-				   struct komeda_crtc_state *kcrtc_st);
-
 int komeda_build_layer_split_data_flow(struct komeda_layer *left,
 				       struct komeda_plane_state *kplane_st,
 				       struct komeda_crtc_state *kcrtc_st,
 				       struct komeda_data_flow_cfg *dflow);
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow);
+
+int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
+			      struct drm_connector_state *conn_st,
+			      struct komeda_crtc_state *kcrtc_st,
+			      struct komeda_data_flow_cfg *dflow);
 int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
 				    struct drm_connector_state *conn_st,
 				    struct komeda_crtc_state *kcrtc_st,
 				    struct komeda_data_flow_cfg *dflow);

+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st);
+
 int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
 				       struct komeda_crtc_state *kcrtc_st);

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 9123284c98a1..c08d59ae7090 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -1102,6 +1102,194 @@ int komeda_build_layer_split_data_flow(struct komed=
a_layer *left,
 	return err;
 }

+/* split func will split configuration of master plane to two layer data
+ * flows, which will be fed into master and slave pipeline then.
+ * NOTE: @m_dflow is first used as input argument to pass the configuratio=
n of
+ *	 master_plane. when the split is done, @*m_dflow @*s_dflow are the
+ *	 output data flow for pipeline.
+ */
+static int
+komeda_split_sbs_master_data_flow(struct komeda_crtc_state *kcrtc_st,
+				  struct komeda_data_flow_cfg **m_dflow,
+				  struct komeda_data_flow_cfg **s_dflow)
+{
+	struct komeda_data_flow_cfg *master =3D *m_dflow;
+	struct komeda_data_flow_cfg *slave =3D *s_dflow;
+	u32 disp_end =3D master->out_x + master->out_w;
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (disp_end <=3D boundary) {
+		/* the master viewport only located in master side, no need
+		 * slave anymore
+		 */
+		*s_dflow =3D NULL;
+	} else if ((master->out_x < boundary) && (disp_end > boundary)) {
+		/* the master viewport across two pipelines, split it */
+		bool flip_h =3D has_flip_h(master->rot);
+		bool r90  =3D drm_rotation_90_or_270(master->rot);
+		u32 src_x =3D master->in_x;
+		u32 src_y =3D master->in_y;
+		u32 src_w =3D master->in_w;
+		u32 src_h =3D master->in_h;
+
+		if (master->en_scaling || master->en_img_enhancement) {
+			DRM_DEBUG_ATOMIC("sbs doesn't support to split a scaling image.\n");
+			return -EINVAL;
+		}
+
+		memcpy(slave, master, sizeof(*master));
+
+		/* master for left part of display, slave for the right part */
+		/* split the disp_rect */
+		master->out_w =3D boundary - master->out_x;
+		slave->out_w  =3D disp_end - boundary;
+		slave->out_x  =3D 0;
+
+		if (r90) {
+			master->in_h =3D master->out_w;
+			slave->in_h =3D slave->out_w;
+
+			if (flip_h)
+				master->in_y =3D src_y + src_h - master->in_h;
+			else
+				slave->in_y =3D src_y + src_h - slave->in_h;
+		} else {
+			master->in_w =3D master->out_w;
+			slave->in_w =3D slave->out_w;
+
+			/* on flip_h, the left display content from the right-source */
+			if (flip_h)
+				master->in_x =3D src_w + src_x - master->in_w;
+			else
+				slave->in_x =3D src_w + src_x - slave->in_w;
+		}
+	} else if (master->out_x >=3D boundary) {
+		/* disp_rect only locate in right part, move the dflow to slave */
+		master->out_x -=3D boundary;
+		*s_dflow =3D master;
+		*m_dflow =3D NULL;
+	}
+
+	return 0;
+}
+
+static int
+komeda_split_sbs_slave_data_flow(struct komeda_crtc_state *kcrtc_st,
+				 struct komeda_data_flow_cfg *slave)
+{
+	u16 boundary;
+
+	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+
+	if (slave->out_x < boundary) {
+		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
+		return -EINVAL;
+	}
+
+	/* slave->disp_rect locate in the right part */
+	slave->out_x -=3D boundary;
+
+	return 0;
+}
+
+/* On side by side mode, The full display frame will be split to two parts
+ * (Left/Right), and each part will be handled by a single pipeline separa=
tely,
+ * master pipeline for left part, slave for right.
+ *
+ * To simplify the usage and implementation, komeda use the following sche=
me
+ * to do the side by side split
+ * 1. The planes also have been grouped into two classes:
+ *    master-planes and slave-planes.
+ * 2. The master plane can display its image on any location of the final/=
full
+ *    display frame, komeda will help to split the plane configuration to =
two
+ *    parts and fed them into master and slave pipelines.
+ * 3. The slave plane only can put its display rect on the right part of t=
he
+ *    final display frame, and its data is only can be fed into the slave
+ *    pipeline.
+ *
+ * From the perspective of resource usage and assignment:
+ * The master plane can use the resources from the master pipeline and sla=
ve
+ * pipeline both, but slave plane only can use the slave pipeline resource=
s.
+ *
+ * With such scheme, the usage of master planes are same as the none
+ * side_by_side mode. user can easily skip the slave planes and no need to
+ * consider side_by_side for them.
+ *
+ * NOTE: side_by_side split is occurred on pipeline level which split the =
plane
+ *	 data flow into pipelines, but the layer split is a pipeline
+ *	 internal split which splits the data flow into pipeline layers.
+ *	 So komeda still supports to apply a further layer split to the sbs
+ *	 split data flow.
+ */
+int komeda_build_layer_sbs_data_flow(struct komeda_layer *layer,
+				     struct komeda_plane_state *kplane_st,
+				     struct komeda_crtc_state *kcrtc_st,
+				     struct komeda_data_flow_cfg *dflow)
+{
+	struct komeda_crtc *kcrtc =3D to_kcrtc(kcrtc_st->base.crtc);
+	struct drm_plane *plane =3D kplane_st->base.plane;
+	struct komeda_data_flow_cfg temp, *master_dflow, *slave_dflow;
+	struct komeda_layer *master, *slave;
+	bool master_plane =3D layer->base.pipeline =3D=3D kcrtc->master;
+	int err;
+
+	DRM_DEBUG_ATOMIC("SBS prepare %s-[PLANE:%d:%s]: %s.\n",
+			 master_plane ? "Master" : "Slave",
+			 plane->base.id, plane->name,
+			 komeda_data_flow_msg(dflow));
+
+	if (master_plane) {
+		master =3D layer;
+		slave =3D layer->sbs_slave;
+		master_dflow =3D dflow;
+		slave_dflow  =3D &temp;
+		err =3D komeda_split_sbs_master_data_flow(kcrtc_st,
+				&master_dflow, &slave_dflow);
+	} else {
+		master =3D NULL;
+		slave =3D layer;
+		master_dflow =3D NULL;
+		slave_dflow =3D dflow;
+		err =3D komeda_split_sbs_slave_data_flow(kcrtc_st, slave_dflow);
+	}
+
+	if (err)
+		return err;
+
+	if (master_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Master-%s assigned: %s\n",
+			master->base.name, komeda_data_flow_msg(master_dflow));
+
+		if (master_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(master,
+					kplane_st, kcrtc_st, master_dflow);
+
+		if (err)
+			return err;
+	}
+
+	if (slave_dflow) {
+		DRM_DEBUG_ATOMIC("SBS Slave-%s assigned: %s\n",
+			slave->base.name, komeda_data_flow_msg(slave_dflow));
+
+		if (slave_dflow->en_split)
+			err =3D komeda_build_layer_split_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		else
+			err =3D komeda_build_layer_data_flow(slave,
+					kplane_st, kcrtc_st, slave_dflow);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* writeback data path: compiz -> scaler -> wb_layer -> memory */
 int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
 			      struct drm_connector_state *conn_st,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_plane.c
index a5625f46120f..436dda1ca6dd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -81,6 +81,7 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	struct komeda_plane_state *kplane_st =3D to_kplane_st(state);
 	struct komeda_layer *layer =3D kplane->layer;
 	struct drm_crtc_state *crtc_st;
+	struct komeda_crtc *kcrtc;
 	struct komeda_crtc_state *kcrtc_st;
 	struct komeda_data_flow_cfg dflow;
 	int err;
@@ -98,13 +99,17 @@ komeda_plane_atomic_check(struct drm_plane *plane,
 	if (!crtc_st->active)
 		return 0;

+	kcrtc =3D to_kcrtc(crtc_st->crtc);
 	kcrtc_st =3D to_kcrtc_st(crtc_st);

 	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
 	if (err)
 		return err;

-	if (dflow.en_split)
+	if (kcrtc->side_by_side)
+		err =3D komeda_build_layer_sbs_data_flow(layer,
+				kplane_st, kcrtc_st, &dflow);
+	else if (dflow.en_split)
 		err =3D komeda_build_layer_split_data_flow(layer,
 				kplane_st, kcrtc_st, &dflow);
 	else
--
2.20.1
