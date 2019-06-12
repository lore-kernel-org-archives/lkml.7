Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E151CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A327208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gsT7VzB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408229AbfFLKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:51:52 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:47965
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408073AbfFLKvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQt6Yn+LnCU71XX3IdIBck7IbNoeUjeoQEqYJXFXp3E=;
 b=gsT7VzB8FhxaUBQ0NNkalJNS7aTjO1yEAK9lN87bL70Y8gpLgNMQYY9Cz7/4YMrtY0UARiZCtJu6MXep7WqG2qScq3J4eLl7LDKEGHsAq/dRpnUGZMIDtNSjPH3QVFsI4R87kOZ9/CBMPvnmtRtpNloaqVrE2oUv4wcZf7g+pDI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4813.eurprd08.prod.outlook.com (10.255.112.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 10:51:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1943.026; Wed, 12 Jun 2019
 10:51:46 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [v2,1/2] drm/komeda: Add slave pipeline support
Thread-Topic: [v2,1/2] drm/komeda: Add slave pipeline support
Thread-Index: AQHVIQzUbDTqvJhG4kKdY7fKPrzXBg==
Date:   Wed, 12 Jun 2019 10:51:46 +0000
Message-ID: <20190612105138.GA4466@james-ThinkStation-P300>
References: <1560251589-31827-2-git-send-email-lowry.li@arm.com>
In-Reply-To: <1560251589-31827-2-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e05996-b3ec-49fc-5f3d-08d6ef23f65c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4813;
x-ms-traffictypediagnostic: VE1PR08MB4813:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4813EB29E1C82D4FFFF8C1B2B3EC0@VE1PR08MB4813.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(305945005)(30864003)(68736007)(6862004)(73956011)(4326008)(66476007)(66556008)(64756008)(66446008)(6486002)(229853002)(1076003)(186003)(6246003)(66946007)(5024004)(14444005)(26005)(256004)(3846002)(6116002)(25786009)(316002)(76176011)(102836004)(99286004)(54906003)(55236004)(6506007)(386003)(58126008)(52116002)(6436002)(6512007)(9686003)(81156014)(81166006)(33716001)(486006)(8676002)(7736002)(6636002)(53936002)(476003)(446003)(86362001)(11346002)(8936002)(5660300002)(71200400001)(478600001)(33656002)(14454004)(2906002)(66066001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4813;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o3JlAW8vsG4H4L6ZbPvMQmkTd/3AiZTUzc+ME/gYY5yCRAhhX0QpDBxL+k/YeR0npms0KRpsBQRnzgklrXBQIS7GOH1JKhqhZRuV3htk/HJgPK/lu2PqSQGa1ksk3pDwXP6Lq8yOvsVBkMaensomxQnaWVzYRLwKDpYGm3q1TTdCijfBoAFxHQDAY0jLd8Ufb+JcqeTEP9cksXsv8MntoNdt34Rj5kIessY2Fv/AU26UhsyfDr/2ECghDRJ6FJwRA+z6XC8lfJWKKJxcny8OPFB+hC/WASJOEmY5SXOiWSfHapC8hItJTT3gsjX04IaBE4URuq9oo7i6HW4KaS4c26wSjRASDHG075+iBYIv/3GNpH56z4bTcMfOHYylsB44SvqABLWt4gcyt1YueNJt7urf0y31PALjkHMkTM03Mls=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04B8D5E1BC72BD47B42EFFD648ABFC50@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e05996-b3ec-49fc-5f3d-08d6ef23f65c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 10:51:46.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:13:39AM +0000, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> One crtc can use two komeda_pipeline, and one works as master and as
> slave. the slave pipeline doesn't have its own output and timing
> ctrlr, but pre-composite the input layer data flow and then feed the
> result to master. the pipeline configuration like:
>=20
> slave-layer-0 \
> ...            slave->CU
> slave-layer-4 /         \
>                         \
> master-layer-0 --------> master->CU -> ...
>  ...                  /
> master-layer-4 ------>
>=20
> Since komeda Compiz doesn't output alpha, so the slave->CU result
> only can be used as bottom input when blend it with master input data
> flows.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   | 41 ++++++++++++++++=
++++--
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c    | 10 ++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |  9 +++++
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.c   | 22 ++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  2 ++
>  .../drm/arm/display/komeda/komeda_pipeline_state.c | 15 ++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c  | 32 ++++++++++++++++=
-
>  7 files changed, 128 insertions(+), 3 deletions(-)
>=20
> --=20
> 1.9.1
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/g=
pu/drm/arm/display/komeda/komeda_crtc.c
> index a2d656f..cafb445 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -64,6 +64,10 @@ static void komeda_crtc_update_clock_ratio(struct kome=
da_crtc_state *kcrtc_st)
>  	}
> =20
>  	/* release unclaimed pipeline resources */
> +	err =3D komeda_release_unclaimed_resources(kcrtc->slave, kcrtc_st);
> +	if (err)
> +		return err;
> +
>  	err =3D komeda_release_unclaimed_resources(kcrtc->master, kcrtc_st);
>  	if (err)
>  		return err;
> @@ -226,6 +230,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>  	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc->state);
>  	struct komeda_dev *mdev =3D kcrtc->base.dev->dev_private;
>  	struct komeda_pipeline *master =3D kcrtc->master;
> +	struct komeda_pipeline *slave =3D kcrtc->slave;
>  	struct komeda_wb_connector *wb_conn =3D kcrtc->wb_conn;
>  	struct drm_connector_state *conn_st;
> =20
> @@ -237,6 +242,9 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>  	if (has_bit(master->id, kcrtc_st->affected_pipes))
>  		komeda_pipeline_update(master, old->state);
> =20
> +	if (slave && has_bit(slave->id, kcrtc_st->affected_pipes))
> +		komeda_pipeline_update(slave, old->state);
> +
>  	conn_st =3D wb_conn ? wb_conn->base.base.state : NULL;
>  	if (conn_st && conn_st->writeback_job)
>  		drm_writeback_queue_job(&wb_conn->base, conn_st);
> @@ -262,6 +270,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>  	struct komeda_crtc_state *old_st =3D to_kcrtc_st(old);
>  	struct komeda_dev *mdev =3D crtc->dev->dev_private;
>  	struct komeda_pipeline *master =3D kcrtc->master;
> +	struct komeda_pipeline *slave  =3D kcrtc->slave;
>  	struct completion *disable_done =3D &crtc->state->commit->flip_done;
>  	struct completion temp;
>  	int timeout;
> @@ -270,6 +279,9 @@ void komeda_crtc_handle_event(struct komeda_crtc   *k=
crtc,
>  			 drm_crtc_index(crtc),
>  			 old_st->active_pipes, old_st->affected_pipes);
> =20
> +	if (slave && has_bit(slave->id, old_st->active_pipes))
> +		komeda_pipeline_disable(slave, old->state);
> +
>  	if (has_bit(master->id, old_st->active_pipes))
>  		komeda_pipeline_disable(master, old->state);
> =20
> @@ -414,6 +426,7 @@ static void komeda_crtc_reset(struct drm_crtc *crtc)
> =20
>  	new->affected_pipes =3D old->active_pipes;
>  	new->clock_ratio =3D old->clock_ratio;
> +	new->max_slave_zorder =3D old->max_slave_zorder;
> =20
>  	return &new->base;
>  }
> @@ -488,7 +501,7 @@ int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms=
,
>  		master =3D mdev->pipelines[i];
> =20
>  		crtc->master =3D master;
> -		crtc->slave  =3D NULL;
> +		crtc->slave  =3D komeda_pipeline_get_slave(master);
> =20
>  		if (crtc->slave)
>  			sprintf(str, "pipe-%d", crtc->slave->id);
> @@ -522,6 +535,26 @@ static int komeda_crtc_create_clock_ratio_property(s=
truct komeda_crtc *kcrtc)
>  	return 0;
>  }
> =20
> +static int komeda_crtc_create_slave_planes_property(struct komeda_crtc *=
kcrtc)
> +{
> +	struct drm_crtc *crtc =3D &kcrtc->base;
> +	struct drm_property *prop;
> +
> +	if (kcrtc->slave_planes =3D=3D 0)
> +		return 0;
> +
> +	prop =3D drm_property_create_range(crtc->dev, DRM_MODE_PROP_IMMUTABLE,
> +					 "slave_planes", 0, U32_MAX);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&crtc->base, prop, kcrtc->slave_planes);
> +
> +	kcrtc->slave_planes_property =3D prop;
> +
> +	return 0;
> +}
> +
>  static struct drm_plane *
>  get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
>  {
> @@ -562,7 +595,11 @@ static int komeda_crtc_add(struct komeda_kms_dev *km=
s,
>  	if (err)
>  		return err;
> =20
> -	return 0;
> +	err =3D komeda_crtc_create_slave_planes_property(kcrtc);
> +	if (err)
> +		return err;
> +
> +	return err;
>  }
> =20
>  int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *=
mdev)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 5d10c55..8543860 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -143,6 +143,8 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc=
 *crtc,
>  				      struct drm_crtc_state *crtc_st)
>  {
>  	struct drm_atomic_state *state =3D crtc_st->state;
> +	struct komeda_crtc *kcrtc =3D to_kcrtc(crtc);
> +	struct komeda_crtc_state *kcrtc_st =3D to_kcrtc_st(crtc_st);
>  	struct komeda_plane_state *kplane_st;
>  	struct drm_plane_state *plane_st;
>  	struct drm_framebuffer *fb;
> @@ -167,6 +169,8 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc=
 *crtc,
>  			return err;
>  	}
> =20
> +	kcrtc_st->max_slave_zorder =3D 0;
> +
>  	list_for_each_entry(kplane_st, &zorder_list, zlist_node) {
>  		plane_st =3D &kplane_st->base;
>  		fb =3D plane_st->fb;
> @@ -185,6 +189,12 @@ static int komeda_crtc_normalize_zpos(struct drm_crt=
c *crtc,
>  		DRM_DEBUG_ATOMIC("[PLANE:%d:%s] zpos:%d, normalized zpos: %d\n",
>  				 plane->base.id, plane->name,
>  				 plane_st->zpos, plane_st->normalized_zpos);
> +
> +		/* calculate max slave zorder */
> +		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes))
> +			kcrtc_st->max_slave_zorder =3D
> +				max(plane_st->normalized_zpos,
> +				    kcrtc_st->max_slave_zorder);
>  	}
> =20
>  	crtc_st->zpos_changed =3D true;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 9dcfe5a..219fa3f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -86,6 +86,9 @@ struct komeda_crtc {
>  	 */
>  	struct komeda_pipeline *slave;
> =20
> +	/** @slave_planes: komeda slave planes mask */
> +	u32 slave_planes;
> +
>  	/** @wb_conn: komeda write back connector */
>  	struct komeda_wb_connector *wb_conn;
> =20
> @@ -94,6 +97,9 @@ struct komeda_crtc {
> =20
>  	/** @clock_ratio_property: property for ratio of (aclk << 32)/pxlclk */
>  	struct drm_property *clock_ratio_property;
> +
> +	/** @slave_planes_property: property for slaves of the planes */
> +	struct drm_property *slave_planes_property;
>  };
> =20
>  /**
> @@ -119,6 +125,9 @@ struct komeda_crtc_state {
> =20
>  	/** @clock_ratio: ratio of (aclk << 32)/pxlclk */
>  	u64 clock_ratio;
> +
> +	/** @max_slave_zorder: the maximum of slave zorder */
> +	u32 max_slave_zorder;
>  };
> =20
>  /** struct komeda_kms_dev - for gather KMS related things */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.c
> index eb9e0c0..a3d90d8 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -142,6 +142,14 @@ struct komeda_component *
>  	return c;
>  }
> =20
> +static struct komeda_component *
> +komeda_component_pickup_input(struct komeda_component *c, u32 avail_comp=
s)
> +{
> +	u32 avail_inputs =3D c->supported_inputs & (avail_comps);
> +
> +	return komeda_pipeline_get_first_component(c->pipeline, avail_inputs);
> +}
> +
>  /** komeda_component_add - Add a component to &komeda_pipeline */
>  struct komeda_component *
>  komeda_component_add(struct komeda_pipeline *pipe,
> @@ -296,6 +304,20 @@ static void komeda_pipeline_assemble(struct komeda_p=
ipeline *pipe)
>  	}
>  }
> =20
> +/* if pipeline_A accept another pipeline_B's component as input, treat
> + * pipeline_B as slave of pipeline_A.
> + */
> +struct komeda_pipeline *
> +komeda_pipeline_get_slave(struct komeda_pipeline *master)
> +{
> +	struct komeda_component *slave;
> +
> +	slave =3D komeda_component_pickup_input(&master->compiz->base,
> +					      KOMEDA_PIPELINE_COMPIZS);
> +
> +	return slave ? slave->pipeline : NULL;
> +}
> +
>  int komeda_assemble_pipelines(struct komeda_dev *mdev)
>  {
>  	struct komeda_pipeline *pipe;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drive=
rs/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index f6a4a51..2a67c8a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -452,6 +452,8 @@ struct komeda_pipeline *
>  		    const struct komeda_pipeline_funcs *funcs);
>  void komeda_pipeline_destroy(struct komeda_dev *mdev,
>  			     struct komeda_pipeline *pipe);
> +struct komeda_pipeline *
> +komeda_pipeline_get_slave(struct komeda_pipeline *master);
>  int komeda_assemble_pipelines(struct komeda_dev *mdev);
>  struct komeda_component *
>  komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 23182ed..6c35afd 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -1032,10 +1032,25 @@ int komeda_build_display_data_flow(struct komeda_=
crtc *kcrtc,
>  				   struct komeda_crtc_state *kcrtc_st)
>  {
>  	struct komeda_pipeline *master =3D kcrtc->master;
> +	struct komeda_pipeline *slave  =3D kcrtc->slave;
>  	struct komeda_data_flow_cfg m_dflow; /* master data flow */
> +	struct komeda_data_flow_cfg s_dflow; /* slave data flow */
>  	int err;
> =20
>  	memset(&m_dflow, 0, sizeof(m_dflow));
> +	memset(&s_dflow, 0, sizeof(s_dflow));
> +
> +	if (slave && has_bit(slave->id, kcrtc_st->active_pipes)) {
> +		err =3D komeda_compiz_validate(slave->compiz, kcrtc_st, &s_dflow);
> +		if (err)
> +			return err;
> +
> +		/* merge the slave dflow into master pipeline */
> +		err =3D komeda_compiz_set_input(master->compiz, kcrtc_st,
> +					      &s_dflow);
> +		if (err)
> +			return err;
> +	}
> =20
>  	err =3D komeda_compiz_validate(master->compiz, kcrtc_st, &m_dflow);
>  	if (err)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index d1c58a8..04b122f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -14,15 +14,27 @@
> =20
>  static int
>  komeda_plane_init_data_flow(struct drm_plane_state *st,
> +			    struct komeda_crtc_state *kcrtc_st,
>  			    struct komeda_data_flow_cfg *dflow)
>  {
> +	struct komeda_plane *kplane =3D to_kplane(st->plane);
>  	struct komeda_plane_state *kplane_st =3D to_kplane_st(st);
>  	struct drm_framebuffer *fb =3D st->fb;
>  	const struct komeda_format_caps *caps =3D to_kfb(fb)->format_caps;
> +	struct komeda_pipeline *pipe =3D kplane->layer->base.pipeline;
> =20
>  	memset(dflow, 0, sizeof(*dflow));
> =20
>  	dflow->blending_zorder =3D st->normalized_zpos;
> +	if (pipe =3D=3D to_kcrtc(st->crtc)->master)
> +		dflow->blending_zorder -=3D kcrtc_st->max_slave_zorder;
> +	if (dflow->blending_zorder < 0) {
> +		DRM_DEBUG_ATOMIC("%s zorder:%d < max_slave_zorder: %d.\n",
> +				 st->plane->name, st->normalized_zpos,
> +				 kcrtc_st->max_slave_zorder);
> +		return -EINVAL;
> +	}
> +
>  	dflow->pixel_blend_mode =3D st->pixel_blend_mode;
>  	dflow->layer_alpha =3D st->alpha >> 8;
> =20
> @@ -88,7 +100,7 @@
> =20
>  	kcrtc_st =3D to_kcrtc_st(crtc_st);
> =20
> -	err =3D komeda_plane_init_data_flow(state, &dflow);
> +	err =3D komeda_plane_init_data_flow(state, kcrtc_st, &dflow);
>  	if (err)
>  		return err;
> =20
> @@ -288,6 +300,22 @@ static u32 get_possible_crtcs(struct komeda_kms_dev =
*kms,
>  	return possible_crtcs;
>  }
> =20
> +static void
> +komeda_set_crtc_plane_mask(struct komeda_kms_dev *kms,
> +			   struct komeda_pipeline *pipe,
> +			   struct drm_plane *plane)
> +{
> +	struct komeda_crtc *kcrtc;
> +	int i;
> +
> +	for (i =3D 0; i < kms->n_crtcs; i++) {
> +		kcrtc =3D &kms->crtcs[i];
> +
> +		if (pipe =3D=3D kcrtc->slave)
> +			kcrtc->slave_planes |=3D BIT(drm_plane_index(plane));
> +	}
> +}
> +
>  /* use Layer0 as primary */
>  static u32 get_plane_type(struct komeda_kms_dev *kms,
>  			  struct komeda_component *c)
> @@ -366,6 +394,8 @@ static int komeda_plane_add(struct komeda_kms_dev *km=
s,
>  	if (err)
>  		goto cleanup;
> =20
> +	komeda_set_crtc_plane_mask(kms, c->pipeline, plane);
> +
>  	return 0;
>  cleanup:
>  	komeda_plane_destroy(plane);


Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
