Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C9C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ULlxq8np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfDDKiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:38:03 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:39139
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfDDKiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUzKsStMr+9TpwExXlpTkfXnMYDT0nXmYvPC5IsOCfk=;
 b=ULlxq8npsvGSiDOJrHnCimuwHlKgxCtxUZXHmx1LOrQ87mrx7exs7gwVE594cw2GXxF6HaOLvNmsumC55hjZkvsRRScqDAqex1tmglgQHSUorBEvzdTvpNWNvyUUBaRpm2Z068cl9sKyUPtujnjnUgTEpG8s5l7K5y5CUoSR37g=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1624.eurprd08.prod.outlook.com (10.169.225.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 10:37:49 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::1150:dc18:a9dc:e17f%2]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 10:37:49 +0000
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
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH] drm/komeda: Add writeback support
Thread-Topic: [PATCH] drm/komeda: Add writeback support
Thread-Index: AQHU6tJynitsSgK5uEmlJMw1WO/npQ==
Date:   Thu, 4 Apr 2019 10:37:48 +0000
Message-ID: <20190404103713.14283-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af76a471-3c29-4ca0-5c20-08d6b8e9948a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0801MB1624;
x-ms-traffictypediagnostic: DB6PR0801MB1624:
x-ms-exchange-purlcount: 4
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB16243BDF95A70310F1AFA6D5B3500@DB6PR0801MB1624.eurprd08.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(8676002)(6512007)(81156014)(81166006)(186003)(5024004)(14444005)(256004)(71190400001)(71200400001)(50226002)(478600001)(8936002)(6306002)(102836004)(103116003)(6506007)(386003)(55236004)(5660300002)(4326008)(97736004)(26005)(2616005)(486006)(476003)(2906002)(53936002)(2501003)(53946003)(66066001)(14454004)(25786009)(106356001)(105586002)(36756003)(7736002)(305945005)(966005)(6116002)(3846002)(316002)(110136005)(6486002)(54906003)(1076003)(99286004)(52116002)(6436002)(86362001)(30864003)(68736007)(2201001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1624;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Q+Qv09YWBFS2iFtC5jV6GQu9lQO6xmoGCM9ZTsiKRmxI8ZD+eqKYkHBioCLLiYQydMJaAE5HmhX465zOig8TiwqYiuqw4SjkAF5gOvjoMJHnVg264qP3oHDZKbih1CzMe4BpbHK6No8C9G70JwjAgM3IbcpPPicrzxCn6n/DXfXW+yiZALhLbt3bIhUFoqMqNDuTrkxc5/Q+T/YeBkqsvHjFBIeE72dL3hzZTZAr1WC/VQShoH5aytWg8JuB2kZiSuqscsrIShPcUA64UR2FPNoWE2EeAit5syH+nVd4VRgd67yNbOE6BBRNRYMdG39gS4Bh7YEgO7XUNL0zar5ObmKn1bcrhm4r6xjSfpeO7aKr3AxoKhDF713953U9c3ERFdXIvq8OFdKBUdMgrAgMD1smMZBqwxI2XEtxih2X1k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af76a471-3c29-4ca0-5c20-08d6b8e9948a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 10:37:48.8909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Komeda driver uses a individual component to describe the HW's writeback
caps, but drivers doesn't define a new structure and still uses the
existing "struct komeda_layer" to describe this new component.
The detailed changes as follow:

1. Initialize wb_layer according to HW and report it to CORE.
2. CORE exposes wb_layer as a resource to KMS by private_obj.
3. Report writeback supporting by add a wb_connector to KMS, and then
   wb_connector will take act as a component resources user,
   so the func komeda_wb_encoder_atomic_check claims komeda resources
   (scaler and wb_layer) accroding to its state configuration to the
   wb_connector. and the wb_state configuration will be validated on the
   specific component resources to see if the caps of component can
   meet the requirement of wb_connector. if not check failed.
4. Update irq_handler to notify the completion of writeback.

NOTE:
This change doesn't add scaling writeback support, that support will
be added in the future after the scaler support.

This patch depends on:
- https://patchwork.freedesktop.org/series/54448/
- https://patchwork.freedesktop.org/series/54449/
- https://patchwork.freedesktop.org/series/54450/
- https://patchwork.freedesktop.org/series/58976/

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../arm/display/komeda/d71/d71_component.c    |  90 ++++++++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  17 ++
 .../arm/display/komeda/komeda_framebuffer.c   |  19 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  26 +++
 .../drm/arm/display/komeda/komeda_pipeline.h  |   7 +
 .../display/komeda/komeda_pipeline_state.c    |  51 ++++-
 .../arm/display/komeda/komeda_private_obj.c   |   6 +
 .../arm/display/komeda/komeda_wb_connector.c  | 181 ++++++++++++++++++
 10 files changed, 399 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.=
c

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index 62bd1bff66a3..d7e29fc688c3 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -14,6 +14,7 @@ komeda-y :=3D \
 	komeda_kms.o \
 	komeda_crtc.o \
 	komeda_plane.o \
+	komeda_wb_connector.o \
 	komeda_private_obj.o
=20
 komeda-y +=3D \
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_component.c
index c56cfc2de147..b582afcf9210 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
@@ -288,10 +288,98 @@ static int d71_layer_init(struct d71_dev *d71,
 	return 0;
 }
=20
+static void d71_wb_layer_update(struct komeda_component *c,
+				struct komeda_component_state *state)
+{
+	struct komeda_layer_state *st =3D to_layer_st(state);
+	struct drm_connector_state *conn_st =3D state->wb_conn->state;
+	struct drm_framebuffer *fb =3D conn_st->writeback_job->fb;
+	struct komeda_fb *kfb =3D to_kfb(fb);
+	u32 __iomem *reg =3D c->reg;
+	u32 ctrl =3D L_EN | LW_OFM, mask =3D L_EN | LW_OFM | LW_TBU_EN;
+	int i;
+
+	for (i =3D 0; i < fb->format->num_planes; i++) {
+		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_PTR_LOW,
+			       lower_32_bits(st->addr[i]));
+		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_PTR_HIGH,
+			       upper_32_bits(st->addr[i]));
+
+		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_STRIDE,
+			       fb->pitches[i] & 0xFFFF);
+	}
+
+	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
+	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
+	malidp_write32(reg, BLK_INPUT_ID0, to_d71_input_id(&state->inputs[0]));
+	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
+}
+
+static void d71_wb_layer_dump(struct komeda_component *c, struct seq_file =
*sf)
+{
+	u32 v[12], i;
+
+	dump_block_header(sf, c->reg);
+
+	get_values_from_reg(c->reg, 0x80, 1, v);
+	seq_printf(sf, "LW_INPUT_ID0:\t\t0x%X\n", v[0]);
+
+	get_values_from_reg(c->reg, 0xD0, 3, v);
+	seq_printf(sf, "LW_CONTROL:\t\t0x%X\n", v[0]);
+	seq_printf(sf, "LW_PROG_LINE:\t\t0x%X\n", v[1]);
+	seq_printf(sf, "LW_FORMAT:\t\t0x%X\n", v[2]);
+
+	get_values_from_reg(c->reg, 0xE0, 1, v);
+	seq_printf(sf, "LW_IN_SIZE:\t\t0x%X\n", v[0]);
+
+	for (i =3D 0; i < 2; i++) {
+		get_values_from_reg(c->reg, 0x100 + i * 0x10, 3, v);
+		seq_printf(sf, "LW_P%u_PTR_LOW:\t\t0x%X\n", i, v[0]);
+		seq_printf(sf, "LW_P%u_PTR_HIGH:\t\t0x%X\n", i, v[1]);
+		seq_printf(sf, "LW_P%u_STRIDE:\t\t0x%X\n", i, v[2]);
+	}
+
+	get_values_from_reg(c->reg, 0x130, 12, v);
+	for (i =3D 0; i < 12; i++)
+		seq_printf(sf, "LW_RGB_YUV_COEFF%u:\t0x%X\n", i, v[i]);
+}
+
+static void d71_wb_layer_disable(struct komeda_component *c)
+{
+	malidp_write32(c->reg, BLK_INPUT_ID0, 0);
+	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
+}
+
+struct komeda_component_funcs d71_wb_layer_funcs =3D {
+	.update		=3D d71_wb_layer_update,
+	.disable	=3D d71_wb_layer_disable,
+	.dump_register	=3D d71_wb_layer_dump,
+};
+
 static int d71_wb_layer_init(struct d71_dev *d71,
 			     struct block_header *blk, u32 __iomem *reg)
 {
-	DRM_DEBUG("Detect D71_Wb_Layer.\n");
+	struct komeda_component *c;
+	struct komeda_layer *wb_layer;
+	u32 pipe_id, layer_id;
+
+	get_resources_id(blk->block_info, &pipe_id, &layer_id);
+
+	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*wb_layer),
+				 layer_id, BLOCK_INFO_INPUT_ID(blk->block_info),
+				 &d71_wb_layer_funcs,
+				 1, get_valid_inputs(blk), 0, reg,
+				 "LPU%d_LAYER_WR", pipe_id);
+	if (!c) {
+		DRM_ERROR("Failed to add wb_layer component\n");
+		return -EINVAL;
+	}
+
+	wb_layer =3D to_layer(c);
+	wb_layer->layer_type =3D KOMEDA_FMT_WB_LAYER;
+
+	set_range(&wb_layer->hsize_in, D71_MIN_LINE_SIZE, d71->max_line_size);
+	set_range(&wb_layer->vsize_in, D71_MIN_VERTICAL_SIZE, d71->max_vsize);
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index d335fec1b727..1988c1898267 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -165,6 +165,15 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kc=
rtc,
 	if (events & KOMEDA_EVENT_VSYNC)
 		drm_crtc_handle_vblank(crtc);
=20
+	if (events & KOMEDA_EVENT_EOW) {
+		struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
+
+		if (wb_conn)
+			drm_writeback_signal_completion(&wb_conn->base, 0);
+		else
+			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
+				 drm_crtc_index(&kcrtc->base));
+	}
 	/* will handle it together with the write back support */
 	if (events & KOMEDA_EVENT_EOW)
 		DRM_DEBUG("EOW.\n");
@@ -201,6 +210,8 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
 	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc->state);
 	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
 	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
+	struct drm_connector_state *conn_st;
=20
 	DRM_DEBUG_ATOMIC("CRTC%d_FLUSH: active_pipes: 0x%x, affected: 0x%x.\n",
 			 drm_crtc_index(crtc),
@@ -210,6 +221,12 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
 	if (has_bit(master->id, kcrtc_st->affected_pipes))
 		komeda_pipeline_update(master, old->state);
=20
+	conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
+	if (conn_st && conn_st->writeback_job && conn_st->writeback_job->fb) {
+		drm_writeback_queue_job(&wb_conn->base, conn_st->writeback_job);
+		conn_st->writeback_job =3D NULL;
+	}
+
 	/* step 2: notify the HW to kickoff the update */
 	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
index 9cc9935024f7..4d8160cf09c3 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -165,3 +165,22 @@ komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x,=
 int y, int plane)
=20
 	return obj->paddr + offset;
 }
+
+/* if the fb can be supported by a specific layer */
+bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type)
+{
+	struct drm_framebuffer *fb =3D &kfb->base;
+	struct komeda_dev *mdev =3D fb->dev->dev_private;
+	const struct komeda_format_caps *caps;
+	u32 fourcc =3D fb->format->format;
+	u64 modifier =3D fb->modifier;
+
+	caps =3D komeda_get_format_caps(&mdev->fmt_tbl, fourcc, modifier);
+	if (!caps)
+		return false;
+
+	if (!(caps->supported_layer_types & layer_type))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 86f6542afb40..3e58901fb776 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -188,6 +188,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct komeda=
_dev *mdev)
 	if (err)
 		goto cleanup_mode_config;
=20
+	err =3D komeda_kms_add_wb_connectors(kms, mdev);
+	if (err)
+		goto cleanup_mode_config;
+
 	err =3D component_bind_all(mdev->dev, kms);
 	if (err)
 		goto cleanup_mode_config;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.h
index 1d9bc33ba54f..f16e9e577593 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -74,6 +74,9 @@ struct komeda_crtc {
 	 */
 	struct komeda_pipeline *slave;
=20
+	/** @wb_conn: komeda write back connector */
+	struct komeda_wb_connector *wb_conn;
+
 	/** @disable_done: this flip_done is for tracing the disable */
 	struct completion *disable_done;
 };
@@ -117,6 +120,27 @@ struct komeda_kms_dev {
 #define to_kcrtc(p)	container_of(p, struct komeda_crtc, base)
 #define to_kcrtc_st(p)	container_of(p, struct komeda_crtc_state, base)
 #define to_kdev(p)	container_of(p, struct komeda_kms_dev, base)
+#define to_wb_conn(x)	container_of(x, struct drm_writeback_connector, base=
)
+
+static inline bool is_writeback_only(struct drm_crtc_state *st)
+{
+	struct komeda_wb_connector *wb_conn =3D to_kcrtc(st->crtc)->wb_conn;
+	struct drm_connector *conn =3D wb_conn ? &wb_conn->base.base : NULL;
+
+	return conn && (st->connector_mask =3D=3D BIT(drm_connector_index(conn)))=
;
+}
+
+static inline bool
+is_only_changed_connector(struct drm_crtc_state *st, struct drm_connector =
*conn)
+{
+	struct drm_crtc_state *old_st;
+	u32 changed_connectors;
+
+	old_st =3D drm_atomic_get_old_crtc_state(st->state, st->crtc);
+	changed_connectors =3D st->connector_mask ^ old_st->connector_mask;
+
+	return BIT(drm_connector_index(conn)) =3D=3D changed_connectors;
+}
=20
 int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev);
=20
@@ -124,6 +148,8 @@ int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, st=
ruct komeda_dev *mdev);
 int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *m=
dev);
 int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
 				struct komeda_dev *mdev);
+int komeda_kms_add_wb_connectors(struct komeda_kms_dev *kms,
+				 struct komeda_dev *mdev);
 void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms);
=20
 void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index b1f813a349a4..7998a1e456b7 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -423,10 +423,17 @@ struct komeda_plane_state;
 struct komeda_crtc_state;
 struct komeda_crtc;
=20
+void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       u16 *hsize, u16 *vsize);
+
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_data_flow_cfg *dflow);
+int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
+			      struct drm_connector_state *conn_st,
+			      struct komeda_crtc_state *kcrtc_st,
+			      struct komeda_data_flow_cfg *dflow);
 int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
 				   struct komeda_crtc_state *kcrtc_st);
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 69a622f06453..944dca2e3379 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -306,8 +306,41 @@ komeda_layer_validate(struct komeda_layer *layer,
 	return 0;
 }
=20
-static void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
-				      u16 *hsize, u16 *vsize)
+static int
+komeda_wb_layer_validate(struct komeda_layer *wb_layer,
+			 struct drm_connector_state *conn_st,
+			 struct komeda_data_flow_cfg *dflow)
+{
+	struct komeda_fb *kfb =3D to_kfb(conn_st->writeback_job->fb);
+	struct komeda_component_state *c_st;
+	struct komeda_layer_state *st;
+	int i;
+
+	if (!komeda_fb_is_layer_supported(kfb, wb_layer->layer_type))
+		return -EINVAL;
+
+	c_st =3D komeda_component_get_state_and_set_user(&wb_layer->base,
+			conn_st->state, conn_st->connector, conn_st->crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_layer_st(c_st);
+
+	st->hsize =3D dflow->out_w;
+	st->vsize =3D dflow->out_h;
+
+	for (i =3D 0; i < kfb->base.format->num_planes; i++)
+		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->out_x,
+						       dflow->out_y, i);
+
+	komeda_component_add_input(&st->base, &dflow->input, 0);
+	komeda_component_set_output(&dflow->input, &wb_layer->base, 0);
+
+	return 0;
+}
+
+void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
+			       u16 *hsize, u16 *vsize)
 {
 	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;
=20
@@ -476,6 +509,20 @@ int komeda_build_layer_data_flow(struct komeda_layer *=
layer,
 	return err;
 }
=20
+int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
+			      struct drm_connector_state *conn_st,
+			      struct komeda_crtc_state *kcrtc_st,
+			      struct komeda_data_flow_cfg *dflow)
+{
+	if ((dflow->in_w !=3D dflow->out_w) ||
+	    (dflow->in_h !=3D dflow->out_h)) {
+		DRM_DEBUG_ATOMIC("current do not support scaling writeback.\n");
+		return -EINVAL;
+	}
+
+	return komeda_wb_layer_validate(wb_layer, conn_st, dflow);
+}
+
 /* build display output data flow, the data path is:
  * compiz -> improc -> timing_ctrlr
  */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index a54878cbd6e4..d53bd6c23c5d 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -252,6 +252,12 @@ int komeda_kms_add_private_objs(struct komeda_kms_dev =
*kms,
 				return err;
 		}
=20
+		if (pipe->wb_layer) {
+			err =3D komeda_layer_obj_add(kms, pipe->wb_layer);
+			if (err)
+				return err;
+		}
+
 		err =3D komeda_compiz_obj_add(kms, pipe->compiz);
 		if (err)
 			return err;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
new file mode 100644
index 000000000000..0c1a4220c280
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+
+static int
+komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
+			 struct drm_connector_state *conn_st,
+			 struct komeda_crtc_state *kcrtc_st,
+			 struct komeda_data_flow_cfg *dflow)
+{
+	struct drm_framebuffer *fb =3D conn_st->writeback_job ?
+				     conn_st->writeback_job->fb : NULL;
+
+	if (!fb)
+		return -EINVAL;
+
+	memset(dflow, 0, sizeof(*dflow));
+
+	dflow->out_w =3D fb->width;
+	dflow->out_h =3D fb->height;
+
+	/* the write back data comes from the compiz */
+	pipeline_composition_size(kcrtc_st, &dflow->in_w, &dflow->in_h);
+	dflow->input.component =3D &wb_layer->base.pipeline->compiz->base;
+	/* compiz doesn't output alpha */
+	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
+	dflow->rot =3D DRM_MODE_ROTATE_0;
+
+	return 0;
+}
+
+static int
+komeda_wb_encoder_atomic_check(struct drm_encoder *encoder,
+			       struct drm_crtc_state *crtc_st,
+			       struct drm_connector_state *conn_st)
+{
+	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
+	struct komeda_layer *wb_layer;
+	struct komeda_data_flow_cfg dflow;
+	int err;
+
+	if (!crtc_st->active) {
+		DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inactive =
CRTC.\n");
+		return -EINVAL;
+	}
+
+	wb_layer =3D to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
+
+	/*
+	 * No need for a full modested when the only connector changed is the
+	 * writeback connector.
+	 */
+	if (crtc_st->connectors_changed &&
+	    is_only_changed_connector(crtc_st, conn_st->connector))
+		crtc_st->connectors_changed =3D false;
+
+	err =3D komeda_wb_init_data_flow(wb_layer, conn_st, kcrtc_st, &dflow);
+	if (err)
+		return err;
+
+	return komeda_build_wb_data_flow(wb_layer, conn_st, kcrtc_st, &dflow);
+}
+
+static const struct drm_encoder_helper_funcs komeda_wb_encoder_helper_func=
s =3D {
+	.atomic_check =3D komeda_wb_encoder_atomic_check,
+};
+
+static int
+komeda_wb_connector_get_modes(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static enum drm_mode_status
+komeda_wb_connector_mode_valid(struct drm_connector *connector,
+			       struct drm_display_mode *mode)
+{
+	struct drm_device *dev =3D connector->dev;
+	struct drm_mode_config *mode_config =3D &dev->mode_config;
+	int w =3D mode->hdisplay, h =3D mode->vdisplay;
+
+	if ((w < mode_config->min_width) || (w > mode_config->max_width))
+		return MODE_BAD_HVALUE;
+
+	if ((h < mode_config->min_height) || (h > mode_config->max_height))
+		return MODE_BAD_VVALUE;
+
+	return MODE_OK;
+}
+
+static const struct drm_connector_helper_funcs komeda_wb_conn_helper_funcs=
 =3D {
+	.get_modes	=3D komeda_wb_connector_get_modes,
+	.mode_valid	=3D komeda_wb_connector_mode_valid,
+};
+
+static enum drm_connector_status
+komeda_wb_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static int
+komeda_wb_connector_fill_modes(struct drm_connector *connector,
+			       uint32_t maxX, uint32_t maxY)
+{
+	return 0;
+}
+
+static void komeda_wb_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_cleanup(connector);
+	kfree(to_kconn(to_wb_conn(connector)));
+}
+
+static const struct drm_connector_funcs komeda_wb_connector_funcs =3D {
+	.reset			=3D drm_atomic_helper_connector_reset,
+	.detect			=3D komeda_wb_connector_detect,
+	.fill_modes		=3D komeda_wb_connector_fill_modes,
+	.destroy		=3D komeda_wb_connector_destroy,
+	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
+};
+
+static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
+				   struct komeda_crtc *kcrtc)
+{
+	struct komeda_dev *mdev =3D kms->base.dev_private;
+	struct komeda_wb_connector *kwb_conn;
+	struct drm_writeback_connector *wb_conn;
+	u32 *formats, n_formats =3D 0;
+	int err;
+
+	if (!kcrtc->master->wb_layer)
+		return 0;
+
+	kwb_conn =3D kzalloc(sizeof(*wb_conn), GFP_KERNEL);
+	if (!kwb_conn)
+		return -ENOMEM;
+
+	kwb_conn->wb_layer =3D kcrtc->master->wb_layer;
+
+	wb_conn =3D &kwb_conn->base;
+	wb_conn->encoder.possible_crtcs =3D BIT(drm_crtc_index(&kcrtc->base));
+
+	formats =3D komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
+					       kwb_conn->wb_layer->layer_type,
+					       &n_formats);
+
+	err =3D drm_writeback_connector_init(&kms->base, wb_conn,
+					   &komeda_wb_connector_funcs,
+					   &komeda_wb_encoder_helper_funcs,
+					   formats, n_formats);
+	komeda_put_fourcc_list(formats);
+	if (err)
+		return err;
+
+	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
+
+	kcrtc->wb_conn =3D kwb_conn;
+
+	return 0;
+}
+
+int komeda_kms_add_wb_connectors(struct komeda_kms_dev *kms,
+				 struct komeda_dev *mdev)
+{
+	int i, err;
+
+	for (i =3D 0; i < kms->n_crtcs; i++) {
+		err =3D komeda_wb_connector_add(kms, &kms->crtcs[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
--=20
2.17.1

