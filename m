Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01805C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4E22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Rjp8ynz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfEUIRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:17:32 -0400
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:34629
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfEUIRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au7OC2A7Guh99fx1B8y7qn2lZwtaJ2nyyc12g0STJmw=;
 b=Rjp8ynz2IT9lIFKD6w8xHeACgXGCtIotZV1RxNSZ1+G8xRy4owhFJjzwJwWYsUdRwRPAXPwXGrB5TBi4K1xcZn3vNMCNgX+B1Da1MKiAIBCGoIt8pwEHzIGo4SugVeTvDkWbAsciSRdlHKVEnUuUz8ONAvx09ys5zvwC75TQkpU=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4687.eurprd08.prod.outlook.com (10.255.115.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 08:17:23 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 08:17:23 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v3] drm/komeda: Add writeback support
Thread-Topic: [PATCH v3] drm/komeda: Add writeback support
Thread-Index: AQHVC789IjGa0UPk40CMGlet+6K8QA==
Date:   Tue, 21 May 2019 08:17:23 +0000
Message-ID: <20190521081716.GA20057@james-ThinkStation-P300>
References: <20190516081300.25530-1-james.qian.wang@arm.com>
 <20190516123344.GA1372@arm.com>
In-Reply-To: <20190516123344.GA1372@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b55c8e51-a894-4ecb-8beb-08d6ddc4c039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4687;
x-ms-traffictypediagnostic: VE1PR08MB4687:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4687C43787A1655F2224CEC5B3070@VE1PR08MB4687.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(9686003)(33716001)(55236004)(14454004)(476003)(6512007)(386003)(53946003)(33656002)(486006)(229853002)(256004)(6862004)(30864003)(71200400001)(1076003)(71190400001)(966005)(102836004)(6506007)(53936002)(66066001)(6116002)(3846002)(58126008)(14444005)(68736007)(54906003)(4326008)(99286004)(52116002)(25786009)(5024004)(76176011)(6636002)(86362001)(66476007)(316002)(64756008)(6246003)(66556008)(81156014)(81166006)(66946007)(11346002)(73956011)(8676002)(66446008)(8936002)(446003)(6486002)(6436002)(2906002)(7736002)(305945005)(26005)(5660300002)(186003)(6306002)(478600001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4687;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rCfW+Mxes/59BzGt28YRk+4ZT+OX+W4q7xSMQc2D5wdz3c4eRmCD1Cdna7qCleLnM6HRfpqs+697/1LAiFTTcsYmboy60OFz2kw+zd+aZxX4SbzI/g7kBQMHZTxtLNXSM5NJVbRxho6cPKO7OTv2I+02g9iGAhYSdDj1tiQG3TXD0NXzETMhJPXs0vEAIYdzpyiF37oEWaSZ7wgjIKQHz4Q4aGIze8cF7wyGlxSQ+nc80yf0ZnJGBQ1+U3eS7ZZBZ9KOZ+HIz0VEDMkG/oS85spGcB5ZEZ0F+qUs2EB9B2v1FqBzl9FKzSTWB9H+Scm0Sa6FAq32pGb7T9fAkaiYCG3oaH87UmTwV/qttpkd6R4I9DYT1/N8NxEMzZu5uwiG3JmRboGR/GoYxU6DWAK0EHBcPTQZ2zD3AXxA3krBDrQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E6A497499A3724D86BDA6095F101C9B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55c8e51-a894-4ecb-8beb-08d6ddc4c039
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:17:23.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayan:

Sorry for late.

On Thu, May 16, 2019 at 08:33:45PM +0800, Ayan Halder wrote:
> On Thu, May 16, 2019 at 09:13:27AM +0100, james qian wang (Arm Technology=
 China) wrote:
> > Komeda driver uses a individual component to describe the HW's writebac=
k
> > caps, but drivers doesn't define a new structure and still uses the
> > existing "struct komeda_layer" to describe this new component.
> > The detailed changes as follow:
> >=20
> > 1. Initialize wb_layer according to HW and report it to CORE.
> > 2. CORE exposes wb_layer as a resource to KMS by private_obj.
> > 3. Report writeback supporting by add a wb_connector to KMS, and then
> >    wb_connector will take act as a component resources user,
> >    so the func komeda_wb_encoder_atomic_check claims komeda resources
> >    (scaler and wb_layer) accroding to its state configuration to the
> >    wb_connector. and the wb_state configuration will be validated on th=
e
> >    specific component resources to see if the caps of component can
> >    meet the requirement of wb_connector. if not check failed.
> > 4. Update irq_handler to notify the completion of writeback.
> >=20
> > NOTE:
> > This change doesn't add scaling writeback support, that support will
> > be added in the future after the scaler support.
> >=20
> > v2: Rebase
> > v3: Rebase and constify the d71_wb_layer_funcs
> >=20
> > Depends on:
> > - https://patchwork.freedesktop.org/series/59915/
> >=20
> > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > ---
> >  drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
> >  .../arm/display/komeda/d71/d71_component.c    |  90 ++++++++-
> >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  15 ++
> >  .../arm/display/komeda/komeda_framebuffer.c   |  19 ++
> >  .../gpu/drm/arm/display/komeda/komeda_kms.c   |   4 +
> >  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  27 +++
> >  .../drm/arm/display/komeda/komeda_pipeline.h  |   7 +
> >  .../display/komeda/komeda_pipeline_state.c    |  51 ++++-
> >  .../arm/display/komeda/komeda_private_obj.c   |   6 +
> >  .../arm/display/komeda/komeda_wb_connector.c  | 181 ++++++++++++++++++
> >  10 files changed, 398 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_wb_connec=
tor.c
> >=20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/=
drm/arm/display/komeda/Makefile
> > index 62bd1bff66a3..d7e29fc688c3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> > +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> > @@ -14,6 +14,7 @@ komeda-y :=3D \
> >  	komeda_kms.o \
> >  	komeda_crtc.o \
> >  	komeda_plane.o \
> > +	komeda_wb_connector.o \
> >  	komeda_private_obj.o
> > =20
> >  komeda-y +=3D \
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index 6bab816ed8e7..67e698d0e6aa 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -288,10 +288,98 @@ static int d71_layer_init(struct d71_dev *d71,
> >  	return 0;
> >  }
> > =20
> > +static void d71_wb_layer_update(struct komeda_component *c,
> > +				struct komeda_component_state *state)
> > +{
> > +	struct komeda_layer_state *st =3D to_layer_st(state);
> > +	struct drm_connector_state *conn_st =3D state->wb_conn->state;
> > +	struct drm_framebuffer *fb =3D conn_st->writeback_job->fb;
> > +	struct komeda_fb *kfb =3D to_kfb(fb);
> > +	u32 __iomem *reg =3D c->reg;
> > +	u32 ctrl =3D L_EN | LW_OFM, mask =3D L_EN | LW_OFM | LW_TBU_EN;
> > +	int i;
> > +
> > +	for (i =3D 0; i < fb->format->num_planes; i++) {
> > +		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_PTR_LOW,
> > +			       lower_32_bits(st->addr[i]));
> > +		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_PTR_HIGH,
> > +			       upper_32_bits(st->addr[i]));
> > +
> > +		malidp_write32(reg + i * LAYER_PER_PLANE_REGS, BLK_P0_STRIDE,
> > +			       fb->pitches[i] & 0xFFFF);
> > +	}
> > +
> > +	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
> > +	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> > +	malidp_write32(reg, BLK_INPUT_ID0, to_d71_input_id(&state->inputs[0])=
);
> > +	malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
> > +}
> > +
> > +static void d71_wb_layer_dump(struct komeda_component *c, struct seq_f=
ile *sf)
> > +{
> > +	u32 v[12], i;
> > +
> > +	dump_block_header(sf, c->reg);
> > +
> > +	get_values_from_reg(c->reg, 0x80, 1, v);
> > +	seq_printf(sf, "LW_INPUT_ID0:\t\t0x%X\n", v[0]);
> > +
> > +	get_values_from_reg(c->reg, 0xD0, 3, v);
> > +	seq_printf(sf, "LW_CONTROL:\t\t0x%X\n", v[0]);
> > +	seq_printf(sf, "LW_PROG_LINE:\t\t0x%X\n", v[1]);
> > +	seq_printf(sf, "LW_FORMAT:\t\t0x%X\n", v[2]);
> > +
> > +	get_values_from_reg(c->reg, 0xE0, 1, v);
> > +	seq_printf(sf, "LW_IN_SIZE:\t\t0x%X\n", v[0]);
> > +
> > +	for (i =3D 0; i < 2; i++) {
> > +		get_values_from_reg(c->reg, 0x100 + i * 0x10, 3, v);
> > +		seq_printf(sf, "LW_P%u_PTR_LOW:\t\t0x%X\n", i, v[0]);
> > +		seq_printf(sf, "LW_P%u_PTR_HIGH:\t\t0x%X\n", i, v[1]);
> > +		seq_printf(sf, "LW_P%u_STRIDE:\t\t0x%X\n", i, v[2]);
> > +	}
> > +
> > +	get_values_from_reg(c->reg, 0x130, 12, v);
> > +	for (i =3D 0; i < 12; i++)
> > +		seq_printf(sf, "LW_RGB_YUV_COEFF%u:\t0x%X\n", i, v[i]);
> > +}
> > +
> > +static void d71_wb_layer_disable(struct komeda_component *c)
> > +{
> > +	malidp_write32(c->reg, BLK_INPUT_ID0, 0);
> > +	malidp_write32_mask(c->reg, BLK_CONTROL, L_EN, 0);
> > +}
> > +
> > +static const struct komeda_component_funcs d71_wb_layer_funcs =3D {
> > +	.update		=3D d71_wb_layer_update,
> > +	.disable	=3D d71_wb_layer_disable,
> > +	.dump_register	=3D d71_wb_layer_dump,
> > +};
> > +
> >  static int d71_wb_layer_init(struct d71_dev *d71,
> >  			     struct block_header *blk, u32 __iomem *reg)
> >  {
> > -	DRM_DEBUG("Detect D71_Wb_Layer.\n");
> > +	struct komeda_component *c;
> > +	struct komeda_layer *wb_layer;
> > +	u32 pipe_id, layer_id;
> > +
> > +	get_resources_id(blk->block_info, &pipe_id, &layer_id);
> > +
> > +	c =3D komeda_component_add(&d71->pipes[pipe_id]->base, sizeof(*wb_lay=
er),
> > +				 layer_id, BLOCK_INFO_INPUT_ID(blk->block_info),
> > +				 &d71_wb_layer_funcs,
> > +				 1, get_valid_inputs(blk), 0, reg,
> > +				 "LPU%d_LAYER_WR", pipe_id);
> > +	if (!c) {
> I think we should use 'IS_ERR(c)' as komeda_component_add() returns a val=
id
> error code.

Yes, you're right it should be IS_ERR(c).
thank you for pointing this out.
and seems I also need the check all the pending reviews. :)

>=20
> > +		DRM_ERROR("Failed to add wb_layer component\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	wb_layer =3D to_layer(c);
> > +	wb_layer->layer_type =3D KOMEDA_FMT_WB_LAYER;
> > +
> > +	set_range(&wb_layer->hsize_in, D71_MIN_LINE_SIZE, d71->max_line_size)=
;
> > +	set_range(&wb_layer->vsize_in, D71_MIN_VERTICAL_SIZE, d71->max_vsize)=
;
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_crtc.c
> > index 284ce079d8c4..6712603b8c7a 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > @@ -165,6 +165,15 @@ void komeda_crtc_handle_event(struct komeda_crtc  =
 *kcrtc,
> >  	if (events & KOMEDA_EVENT_VSYNC)
> >  		drm_crtc_handle_vblank(crtc);
> > =20
> > +	if (events & KOMEDA_EVENT_EOW) {
> > +		struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
> > +
> > +		if (wb_conn)
> > +			drm_writeback_signal_completion(&wb_conn->base, 0);
> > +		else
> > +			DRM_WARN("CRTC[%d]: EOW happen but no wb_connector.\n",
> > +				 drm_crtc_index(&kcrtc->base));
> > +	}
> >  	/* will handle it together with the write back support */
> >  	if (events & KOMEDA_EVENT_EOW)
> >  		DRM_DEBUG("EOW.\n");
> > @@ -201,6 +210,8 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
> >  	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc->state);
> >  	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
> >  	struct komeda_pipeline *master =3D kcrtc->master;
> > +	struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
> > +	struct drm_connector_state *conn_st;
> > =20
> >  	DRM_DEBUG_ATOMIC("CRTC%d_FLUSH: active_pipes: 0x%x, affected: 0x%x.\n=
",
> >  			 drm_crtc_index(crtc),
> > @@ -210,6 +221,10 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
> >  	if (has_bit(master->id, kcrtc_st->affected_pipes))
> >  		komeda_pipeline_update(master, old->state);
> > =20
> > +	conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
> > +	if (conn_st && conn_st->writeback_job)
> > +		drm_writeback_queue_job(&wb_conn->base, conn_st);
> > +
> >  	/* step 2: notify the HW to kickoff the update */
> >  	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
> >  }
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/=
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > index 9cc9935024f7..4d8160cf09c3 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> > @@ -165,3 +165,22 @@ komeda_fb_get_pixel_addr(struct komeda_fb *kfb, in=
t x, int y, int plane)
> > =20
> >  	return obj->paddr + offset;
> >  }
> > +
> > +/* if the fb can be supported by a specific layer */
> > +bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_typ=
e)
> > +{
> > +	struct drm_framebuffer *fb =3D &kfb->base;
> > +	struct komeda_dev *mdev =3D fb->dev->dev_private;
> > +	const struct komeda_format_caps *caps;
> > +	u32 fourcc =3D fb->format->format;
> > +	u64 modifier =3D fb->modifier;
> > +
> > +	caps =3D komeda_get_format_caps(&mdev->fmt_tbl, fourcc, modifier);
> > +	if (!caps)
> > +		return false;
> > +
> > +	if (!(caps->supported_layer_types & layer_type))
> > +		return false;
> > +
> > +	return true;
> > +}
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.c
> > index 86f6542afb40..3e58901fb776 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > @@ -188,6 +188,10 @@ struct komeda_kms_dev *komeda_kms_attach(struct ko=
meda_dev *mdev)
> >  	if (err)
> >  		goto cleanup_mode_config;
> > =20
> > +	err =3D komeda_kms_add_wb_connectors(kms, mdev);
> > +	if (err)
> > +		goto cleanup_mode_config;
> > +
> >  	err =3D component_bind_all(mdev->dev, kms);
> >  	if (err)
> >  		goto cleanup_mode_config;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/=
gpu/drm/arm/display/komeda/komeda_kms.h
> > index ac3d9209b4d9..f16e9e577593 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > @@ -12,6 +12,7 @@
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_device.h>
> >  #include <drm/drm_writeback.h>
> > +#include <drm/drm_print.h>
> >  #include <video/videomode.h>
> >  #include <video/display_timing.h>
> > =20
> > @@ -73,6 +74,9 @@ struct komeda_crtc {
> >  	 */
> >  	struct komeda_pipeline *slave;
> > =20
> > +	/** @wb_conn: komeda write back connector */
> > +	struct komeda_wb_connector *wb_conn;
> > +
> >  	/** @disable_done: this flip_done is for tracing the disable */
> >  	struct completion *disable_done;
> >  };
> > @@ -116,6 +120,27 @@ struct komeda_kms_dev {
> >  #define to_kcrtc(p)	container_of(p, struct komeda_crtc, base)
> >  #define to_kcrtc_st(p)	container_of(p, struct komeda_crtc_state, base)
> >  #define to_kdev(p)	container_of(p, struct komeda_kms_dev, base)
> > +#define to_wb_conn(x)	container_of(x, struct drm_writeback_connector, =
base)
> > +
> > +static inline bool is_writeback_only(struct drm_crtc_state *st)
> > +{
> > +	struct komeda_wb_connector *wb_conn =3D to_kcrtc(st->crtc)->wb_conn;
> > +	struct drm_connector *conn =3D wb_conn ? &wb_conn->base.base : NULL;
> > +
> > +	return conn && (st->connector_mask =3D=3D BIT(drm_connector_index(con=
n)));
> > +}
> > +
> > +static inline bool
> > +is_only_changed_connector(struct drm_crtc_state *st, struct drm_connec=
tor *conn)
> > +{
> > +	struct drm_crtc_state *old_st;
> > +	u32 changed_connectors;
> > +
> > +	old_st =3D drm_atomic_get_old_crtc_state(st->state, st->crtc);
> > +	changed_connectors =3D st->connector_mask ^ old_st->connector_mask;
> > +
> > +	return BIT(drm_connector_index(conn)) =3D=3D changed_connectors;
> > +}
> > =20
> >  int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_d=
ev *mdev);
> > =20
> > @@ -123,6 +148,8 @@ int komeda_kms_add_crtcs(struct komeda_kms_dev *kms=
, struct komeda_dev *mdev);
> >  int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_de=
v *mdev);
> >  int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
> >  				struct komeda_dev *mdev);
> > +int komeda_kms_add_wb_connectors(struct komeda_kms_dev *kms,
> > +				 struct komeda_dev *mdev);
> >  void komeda_kms_cleanup_private_objs(struct komeda_kms_dev *kms);
> > =20
> >  void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > index bae8a32b81a6..1b7e933ea303 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > @@ -423,10 +423,17 @@ struct komeda_plane_state;
> >  struct komeda_crtc_state;
> >  struct komeda_crtc;
> > =20
> > +void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
> > +			       u16 *hsize, u16 *vsize);
> > +
> >  int komeda_build_layer_data_flow(struct komeda_layer *layer,
> >  				 struct komeda_plane_state *kplane_st,
> >  				 struct komeda_crtc_state *kcrtc_st,
> >  				 struct komeda_data_flow_cfg *dflow);
> > +int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> > +			      struct drm_connector_state *conn_st,
> > +			      struct komeda_crtc_state *kcrtc_st,
> > +			      struct komeda_data_flow_cfg *dflow);
> >  int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
> >  				   struct komeda_crtc_state *kcrtc_st);
> > =20
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c=
 b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > index 36570d7dad61..9748c9438868 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> > @@ -308,8 +308,41 @@ komeda_layer_validate(struct komeda_layer *layer,
> >  	return 0;
> >  }
> > =20
> > -static void pipeline_composition_size(struct komeda_crtc_state *kcrtc_=
st,
> > -				      u16 *hsize, u16 *vsize)
> > +static int
> > +komeda_wb_layer_validate(struct komeda_layer *wb_layer,
> > +			 struct drm_connector_state *conn_st,
> > +			 struct komeda_data_flow_cfg *dflow)
> > +{
> > +	struct komeda_fb *kfb =3D to_kfb(conn_st->writeback_job->fb);
> > +	struct komeda_component_state *c_st;
> > +	struct komeda_layer_state *st;
> > +	int i;
> > +
> > +	if (!komeda_fb_is_layer_supported(kfb, wb_layer->layer_type))
> > +		return -EINVAL;
> > +
> > +	c_st =3D komeda_component_get_state_and_set_user(&wb_layer->base,
> > +			conn_st->state, conn_st->connector, conn_st->crtc);
> > +	if (IS_ERR(c_st))
> > +		return PTR_ERR(c_st);
> > +
> > +	st =3D to_layer_st(c_st);
> > +
> > +	st->hsize =3D dflow->out_w;
> > +	st->vsize =3D dflow->out_h;
> > +
> > +	for (i =3D 0; i < kfb->base.format->num_planes; i++)
> > +		st->addr[i] =3D komeda_fb_get_pixel_addr(kfb, dflow->out_x,
> > +						       dflow->out_y, i);
> > +
> > +	komeda_component_add_input(&st->base, &dflow->input, 0);
> > +	komeda_component_set_output(&dflow->input, &wb_layer->base, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
> > +			       u16 *hsize, u16 *vsize)
> >  {
> >  	struct drm_display_mode *m =3D &kcrtc_st->base.adjusted_mode;
> > =20
> > @@ -478,6 +511,20 @@ int komeda_build_layer_data_flow(struct komeda_lay=
er *layer,
> >  	return err;
> >  }
> > =20
> > +int komeda_build_wb_data_flow(struct komeda_layer *wb_layer,
> > +			      struct drm_connector_state *conn_st,
> > +			      struct komeda_crtc_state *kcrtc_st,
> > +			      struct komeda_data_flow_cfg *dflow)
> > +{
> > +	if ((dflow->in_w !=3D dflow->out_w) ||
> > +	    (dflow->in_h !=3D dflow->out_h)) {
> > +		DRM_DEBUG_ATOMIC("current do not support scaling writeback.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return komeda_wb_layer_validate(wb_layer, conn_st, dflow);
> > +}
> > +
> >  /* build display output data flow, the data path is:
> >   * compiz -> improc -> timing_ctrlr
> >   */
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/=
drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > index a54878cbd6e4..d53bd6c23c5d 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > @@ -252,6 +252,12 @@ int komeda_kms_add_private_objs(struct komeda_kms_=
dev *kms,
> >  				return err;
> >  		}
> > =20
> > +		if (pipe->wb_layer) {
> > +			err =3D komeda_layer_obj_add(kms, pipe->wb_layer);
> > +			if (err)
> > +				return err;
> > +		}
> > +
> >  		err =3D komeda_compiz_obj_add(kms, pipe->compiz);
> >  		if (err)
> >  			return err;
> > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > new file mode 100644
> > index 000000000000..0c1a4220c280
> > --- /dev/null
> > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> > @@ -0,0 +1,181 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > + *
> > + */
> > +#include "komeda_dev.h"
> > +#include "komeda_kms.h"
> > +
> > +static int
> > +komeda_wb_init_data_flow(struct komeda_layer *wb_layer,
> > +			 struct drm_connector_state *conn_st,
> > +			 struct komeda_crtc_state *kcrtc_st,
> > +			 struct komeda_data_flow_cfg *dflow)
> > +{
> > +	struct drm_framebuffer *fb =3D conn_st->writeback_job ?
> > +				     conn_st->writeback_job->fb : NULL;
> > +
> > +	if (!fb)
> > +		return -EINVAL;
> > +
> > +	memset(dflow, 0, sizeof(*dflow));
> > +
> > +	dflow->out_w =3D fb->width;
> > +	dflow->out_h =3D fb->height;
> > +
> > +	/* the write back data comes from the compiz */
> > +	pipeline_composition_size(kcrtc_st, &dflow->in_w, &dflow->in_h);
> > +	dflow->input.component =3D &wb_layer->base.pipeline->compiz->base;
> > +	/* compiz doesn't output alpha */
> > +	dflow->pixel_blend_mode =3D DRM_MODE_BLEND_PIXEL_NONE;
> > +	dflow->rot =3D DRM_MODE_ROTATE_0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +komeda_wb_encoder_atomic_check(struct drm_encoder *encoder,
> > +			       struct drm_crtc_state *crtc_st,
> > +			       struct drm_connector_state *conn_st)
> > +{
> > +	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
> > +	struct komeda_layer *wb_layer;
> > +	struct komeda_data_flow_cfg dflow;
> > +	int err;
> > +
> > +	if (!crtc_st->active) {
> > +		DRM_DEBUG_ATOMIC("Cannot write the composition result out on a inact=
ive CRTC.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	wb_layer =3D to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
> > +
> > +	/*
> > +	 * No need for a full modested when the only connector changed is the
> > +	 * writeback connector.
> > +	 */
> > +	if (crtc_st->connectors_changed &&
> > +	    is_only_changed_connector(crtc_st, conn_st->connector))
> > +		crtc_st->connectors_changed =3D false;
> > +
> > +	err =3D komeda_wb_init_data_flow(wb_layer, conn_st, kcrtc_st, &dflow)=
;
> > +	if (err)
> > +		return err;
> > +
> > +	return komeda_build_wb_data_flow(wb_layer, conn_st, kcrtc_st, &dflow)=
;
> > +}
> > +
> > +static const struct drm_encoder_helper_funcs komeda_wb_encoder_helper_=
funcs =3D {
> > +	.atomic_check =3D komeda_wb_encoder_atomic_check,
> > +};
> > +
> > +static int
> > +komeda_wb_connector_get_modes(struct drm_connector *connector)
> > +{
> > +	return 0;
> > +}
> Can we remove this ?
>

this function is for drm_connector_helper_funcs->get_modes, which is
essential, we can not set it to NULL.

> > +
> > +static enum drm_mode_status
> > +komeda_wb_connector_mode_valid(struct drm_connector *connector,
> > +			       struct drm_display_mode *mode)
> > +{
> > +	struct drm_device *dev =3D connector->dev;
> > +	struct drm_mode_config *mode_config =3D &dev->mode_config;
> > +	int w =3D mode->hdisplay, h =3D mode->vdisplay;
> > +
> > +	if ((w < mode_config->min_width) || (w > mode_config->max_width))
> > +		return MODE_BAD_HVALUE;
> > +
> > +	if ((h < mode_config->min_height) || (h > mode_config->max_height))
> > +		return MODE_BAD_VVALUE;
> > +
> > +	return MODE_OK;
> > +}
> > +
> > +static const struct drm_connector_helper_funcs komeda_wb_conn_helper_f=
uncs =3D {
> > +	.get_modes	=3D komeda_wb_connector_get_modes,
> > +	.mode_valid	=3D komeda_wb_connector_mode_valid,
> > +};
> > +
> > +static enum drm_connector_status
> > +komeda_wb_connector_detect(struct drm_connector *connector, bool force=
)
> > +{
> > +	return connector_status_connected;
> > +}
> > +
> > +static int
> > +komeda_wb_connector_fill_modes(struct drm_connector *connector,
> > +			       uint32_t maxX, uint32_t maxY)
> > +{
> > +	return 0;
> > +}
> Can we remove this as well ?

This function is for drm_connector_func->fill_modes which also is essential=
.
>=20
> > +
> > +static void komeda_wb_connector_destroy(struct drm_connector *connecto=
r)
> > +{
> > +	drm_connector_cleanup(connector);
> > +	kfree(to_kconn(to_wb_conn(connector)));
> > +}
> > +
> > +static const struct drm_connector_funcs komeda_wb_connector_funcs =3D =
{
> > +	.reset			=3D drm_atomic_helper_connector_reset,
> > +	.detect			=3D komeda_wb_connector_detect,
> > +	.fill_modes		=3D komeda_wb_connector_fill_modes,
> > +	.destroy		=3D komeda_wb_connector_destroy,
> > +	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_sta=
te,
> > +	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
> > +				   struct komeda_crtc *kcrtc)
> > +{
> > +	struct komeda_dev *mdev =3D kms->base.dev_private;
> > +	struct komeda_wb_connector *kwb_conn;
> > +	struct drm_writeback_connector *wb_conn;
> > +	u32 *formats, n_formats =3D 0;
> > +	int err;
> > +
> > +	if (!kcrtc->master->wb_layer)
> > +		return 0;
> > +
> > +	kwb_conn =3D kzalloc(sizeof(*wb_conn), GFP_KERNEL);
> > +	if (!kwb_conn)
> > +		return -ENOMEM;
> > +
> > +	kwb_conn->wb_layer =3D kcrtc->master->wb_layer;
> > +
> > +	wb_conn =3D &kwb_conn->base;
> > +	wb_conn->encoder.possible_crtcs =3D BIT(drm_crtc_index(&kcrtc->base))=
;
> > +
> > +	formats =3D komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
> > +					       kwb_conn->wb_layer->layer_type,
> > +					       &n_formats);
> > +
> We be doing a null check on formats here as we are dereferencing it
> in the next function.
>

Do you mean the valid check for formats,

I don't think it is necessary.=20

Since even it is a NULL ptr, and which may lead drm_writeback_connector_ini=
t
fail. and for the put_fourcc_list which is a kfree acctually. and
kfree always ignore the free if the input ptr is NULL.

> > +	err =3D drm_writeback_connector_init(&kms->base, wb_conn,
> > +					   &komeda_wb_connector_funcs,
> > +					   &komeda_wb_encoder_helper_funcs,
> > +					   formats, n_formats);
> > +	komeda_put_fourcc_list(formats);
> > +	if (err)
> > +		return err;
> > +
> > +	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs=
);
> > +
> > +	kcrtc->wb_conn =3D kwb_conn;
> > +
> > +	return 0;
> > +}
> > +
> > +int komeda_kms_add_wb_connectors(struct komeda_kms_dev *kms,
> > +				 struct komeda_dev *mdev)
> > +{
> > +	int i, err;
> > +
> > +	for (i =3D 0; i < kms->n_crtcs; i++) {
> > +		err =3D komeda_wb_connector_add(kms, &kms->crtcs[i]);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > --=20
> > 2.17.1
> >=20
