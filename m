Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58144C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F6121850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MHVOYwAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfGDGbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:31:14 -0400
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:26919
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVRM3cE3gTYSYV1gfI1lyaN8EdenOI0Ejgkx7GicXUM=;
 b=MHVOYwAoYR2m0R81jQlyL+csbPybzQAa9M1ZCrDRfbXKdMIbTSizHEUZlnu/mWlLzk7i/9d+iB6iNyI3dcAxYGtfK3GyouM2YCA/F4/67eIIt3KF7n4UtSOxDKQGeguWB+8+IS2VyVVm7DLXA6df19l79ibnDTIzABrnC4Kfz7E=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5229.eurprd08.prod.outlook.com (10.255.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 06:31:06 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::4062:a380:35ba:11d1%3]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 06:31:06 +0000
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
Subject: [PATCH 3/6] drm/komeda: Build side by side display output pipeline
Thread-Topic: [PATCH 3/6] drm/komeda: Build side by side display output
 pipeline
Thread-Index: AQHVMjIOXxgMi3Y4jUq86Y5LP37WRQ==
Date:   Thu, 4 Jul 2019 06:31:05 +0000
Message-ID: <20190704063011.7431-4-james.qian.wang@arm.com>
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
x-ms-office365-filtering-correlation-id: a49622fa-1361-4f74-e551-08d700493149
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5229;
x-ms-traffictypediagnostic: VE1PR08MB5229:
x-microsoft-antispam-prvs: <VE1PR08MB5229BE5708A4CE6DA8DC60EDB3FA0@VE1PR08MB5229.eurprd08.prod.outlook.com>
nodisclaimer: True
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(76176011)(6506007)(66066001)(110136005)(386003)(54906003)(103116003)(2906002)(316002)(186003)(86362001)(2201001)(52116002)(55236004)(99286004)(26005)(102836004)(6486002)(50226002)(25786009)(478600001)(71200400001)(71190400001)(6512007)(6436002)(4326008)(68736007)(53936002)(14454004)(2616005)(476003)(486006)(36756003)(446003)(11346002)(81166006)(8676002)(256004)(14444005)(81156014)(8936002)(305945005)(7736002)(66946007)(6116002)(73956011)(66476007)(66556008)(64756008)(66446008)(3846002)(2501003)(5660300002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5229;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oFqP+2WQ2eeyZ29dDddWQJ60K3iN+Zt60rLimY6yWyqwKr6JSTeviWShEtWId/9+njR1mUPHwiN5stCwrm9AT2yauS9E4mcYja/m5520KJDDtCpx87Ns54Te7d3YqYe1+LXcUmgNYZOLgiWrEpl6NwyQPyZjBdVlnaVe6cqWTJCKzlDMPRs6DaHVqlrGPzHtlR5+w0YRUO1dSJI8GObJ61mbWWKlPNh6cdTb3NxbggX3T8rt3e1ceJZ+EAFcztjrUCYnfrpiE2ly5g5MJtxT2NMCe2XQxji8HxgtDWgIt7sUZ7i1wKqoOoZRqVS+ei8pb3MSEcpusLLxJmEBXLTyROBA6tcbw/WbEy0e+RB5Fhr4c9DhB6hQPf/GuryxueIRZYqbl5EBTG5Qe0upj5SysvJiFMlFcBm5XeklM0eKF7M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49622fa-1361-4f74-e551-08d700493149
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:31:05.8501
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

For side by side, the slave pipeline merges to master via image processor

 slave-layers -> slave-compiz-> slave-improc-
                                             \
 master-layers -> master-compiz -------------> master-improc ->

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../arm/display/komeda/d71/d71_component.c    |  4 ++
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 19 ++++---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 .../display/komeda/komeda_pipeline_state.c    | 51 ++++++++++++++-----
 .../arm/display/komeda/komeda_wb_connector.c  |  2 +-
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c1355f5cb47d..a68954bb594a 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -985,6 +985,10 @@ static void d71_improc_update(struct komeda_component =
*c,
 	else if (st->color_format =3D=3D DRM_COLOR_FORMAT_YCRCB444)
 		ctrl |=3D IPS_CTRL_YUV;

+	/* slave input has been enabled, means side by side */
+	if (has_bit(1, state->active_inputs))
+		ctrl |=3D IPS_CTRL_SBS;
+
 	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
 }

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index c3bb111c454c..133ea4728149 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -361,19 +361,26 @@ komeda_crtc_atomic_flush(struct drm_crtc *crtc,
 	komeda_crtc_do_flush(crtc, old);
 }

-/* Returns the minimum frequency of the aclk rate (main engine clock) in H=
z */
+/*
+ * Returns the minimum frequency of the aclk rate (main engine clock) in H=
z.
+ *
+ * The DPU output can be split into two halves, to stay within the bandwid=
th
+ * capabilities of the external link (dual-link mode).
+ * In these cases, each output link runs at half the pixel clock rate of t=
he
+ * combined display, and has half the number of pixels.
+ * Beside split the output, the DPU internal pixel processing also can be =
split
+ * into two halves (LEFT/RIGHT) and handles by two pipelines simultaneousl=
y.
+ * So if side by side, the pipeline (main engine clock) also can run at ha=
lf
+ * the clock rate of the combined display.
+ */
 static unsigned long
 komeda_calc_min_aclk_rate(struct komeda_crtc *kcrtc,
 			  unsigned long pxlclk)
 {
-	/* Once dual-link one display pipeline drives two display outputs,
-	 * the aclk needs run on the double rate of pxlclk
-	 */
-	if (kcrtc->master->dual_link)
+	if (kcrtc->master->dual_link && !kcrtc->side_by_side)
 		return pxlclk * 2;
 	else
 		return pxlclk;
-
 }

 /* Get current aclk rate that specified by state */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index aa7c0fefa47e..3358bcea8f7d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -530,6 +530,7 @@ struct komeda_crtc_state;
 struct komeda_crtc;

 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize);

 int komeda_build_layer_data_flow(struct komeda_layer *layer,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index c08d59ae7090..4e5c891fbbd4 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -637,12 +637,13 @@ komeda_merger_validate(struct komeda_merger *merger,
 }

 void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       bool side_by_side,
 			       u16 *hsize, u16 *vsize)
 {
 	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;

 	if (hsize)
-		*hsize =3D m->hdisplay;
+		*hsize =3D side_by_side ? m->hdisplay / 2 : m->hdisplay;
 	if (vsize)
 		*vsize =3D m->vdisplay;
 }
@@ -653,12 +654,14 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 			struct komeda_data_flow_cfg *dflow)
 {
 	struct drm_atomic_state *drm_st =3D kcrtc_st->base.state;
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct komeda_component_state *c_st, *old_st;
 	struct komeda_compiz_input_cfg *cin;
 	u16 compiz_w, compiz_h;
 	int idx =3D dflow->blending_zorder;

-	pipeline_composition_size(kcrtc_st, &compiz_w, &compiz_h);
+	pipeline_composition_size(kcrtc_st, to_kcrtc(crtc)->side_by_side,
+				  &compiz_w, &compiz_h);
 	/* check display rect */
 	if ((dflow->out_x + dflow->out_w > compiz_w) ||
 	    (dflow->out_y + dflow->out_h > compiz_h) ||
@@ -670,7 +673,7 @@ komeda_compiz_set_input(struct komeda_compiz *compiz,
 	}

 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base, drm_st,
-			kcrtc_st->base.crtc, kcrtc_st->base.crtc);
+			crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);

@@ -704,17 +707,19 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 		       struct komeda_crtc_state *state,
 		       struct komeda_data_flow_cfg *dflow)
 {
+	struct drm_crtc *crtc =3D state->base.crtc;
 	struct komeda_component_state *c_st;
 	struct komeda_compiz_state *st;

 	c_st =3D komeda_component_get_state_and_set_user(&compiz->base,
-			state->base.state, state->base.crtc, state->base.crtc);
+			state->base.state, crtc, crtc);
 	if (IS_ERR(c_st))
 		return PTR_ERR(c_st);

 	st =3D to_compiz_st(c_st);

-	pipeline_composition_size(state, &st->hsize, &st->vsize);
+	pipeline_composition_size(state, to_kcrtc(crtc)->side_by_side,
+				  &st->hsize, &st->vsize);

 	komeda_component_set_output(&dflow->input, &compiz->base, 0);

@@ -740,7 +745,8 @@ komeda_compiz_validate(struct komeda_compiz *compiz,
 static int
 komeda_improc_validate(struct komeda_improc *improc,
 		       struct komeda_crtc_state *kcrtc_st,
-		       struct komeda_data_flow_cfg *dflow)
+		       struct komeda_data_flow_cfg *m_dflow,
+		       struct komeda_data_flow_cfg *s_dflow)
 {
 	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
 	struct drm_crtc_state *crtc_st =3D &kcrtc_st->base;
@@ -754,8 +760,8 @@ komeda_improc_validate(struct komeda_improc *improc,

 	st =3D to_improc_st(c_st);

-	st->hsize =3D dflow->in_w;
-	st->vsize =3D dflow->in_h;
+	st->hsize =3D m_dflow->in_w;
+	st->vsize =3D m_dflow->in_h;

 	if (drm_atomic_crtc_needs_modeset(crtc_st)) {
 		u32 output_depths, output_formats;
@@ -793,8 +799,10 @@ komeda_improc_validate(struct komeda_improc *improc,
 		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
 	}

-	komeda_component_add_input(&st->base, &dflow->input, 0);
-	komeda_component_set_output(&dflow->input, &improc->base, 0);
+	komeda_component_add_input(&st->base, &m_dflow->input, 0);
+	if (s_dflow)
+		komeda_component_add_input(&st->base, &s_dflow->input, 1);
+	komeda_component_set_output(&m_dflow->input, &improc->base, 0);

 	return 0;
 }
@@ -1118,7 +1126,7 @@ komeda_split_sbs_master_data_flow(struct komeda_crtc_=
state *kcrtc_st,
 	u32 disp_end =3D master->out_x + master->out_w;
 	u16 boundary;

-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);

 	if (disp_end <=3D boundary) {
 		/* the master viewport only located in master side, no need
@@ -1181,7 +1189,7 @@ komeda_split_sbs_slave_data_flow(struct komeda_crtc_s=
tate *kcrtc_st,
 {
 	u16 boundary;

-	pipeline_composition_size(kcrtc_st, &boundary, NULL);
+	pipeline_composition_size(kcrtc_st, true, &boundary, NULL);

 	if (slave->out_x < boundary) {
 		DRM_DEBUG_ATOMIC("SBS Slave plane is only allowed to configure the right=
 part frame.\n");
@@ -1356,7 +1364,20 @@ int komeda_build_display_data_flow(struct komeda_crt=
c *kcrtc,
 	memset(&m_dflow, 0, sizeof(m_dflow));
 	memset(&s_dflow, 0, sizeof(s_dflow));

-	if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
+	/* build slave output data flow */
+	if (kcrtc->side_by_side) {
+		/* on side by side, the slave data flows into the improc of
+		 * itself first, and then merge it into master's image processor
+		 */
+		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
+		if (err)
+			return err;
+
+		err =3D komeda_improc_validate(slave->improc, kcrtc_st,
+					     &s_dflow, NULL);
+		if (err)
+			return err;
+	} else if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
 		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
 		if (err)
 			return err;
@@ -1372,7 +1393,9 @@ int komeda_build_display_data_flow(struct komeda_crtc=
 *kcrtc,
 	if (err)
 		return err;

-	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow);
+	/* on side by side, merge the slave dflow into master */
+	err =3D komeda_improc_validate(master->improc, kcrtc_st, &m_dflow,
+				     kcrtc->side_by_side ? &s_dflow : NULL);
 	if (err)
 		return err;

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index e6f66922843c..c1b0ad22422e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -22,7 +22,7 @@ komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
 	dflow->out_h =3D fb->height;

 	/* the write back data comes from the compiz */
-	pipeline_composition_size(kcrtc_st, &dflow->in_w, &dflow->in_h);
+	pipeline_composition_size(kcrtc_st, false, &dflow->in_w, &dflow->in_h);
 	dflow->input.component =3D &wb_layer->base.pipeline->compiz->base;
 	/* compiz doesn't output alpha */
 	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
--
2.20.1
