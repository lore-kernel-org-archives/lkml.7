Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F493C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBE4206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="DMc1lo3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfE1GOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:14:18 -0400
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:37701
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbfE1GOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbrcwcL9T2eZpmf3WrA8VvNtBVqy9OnFaTEVUJlZowU=;
 b=DMc1lo3Na3QneqcdbVklf8DuBvA/ETf1hhDwwJJB7yUK0MBGSZNfSR6fbZRjleubewHTHwSKcbo4xUbIIr9m/7GsYhNjLc5ehCBSFxUBFGTE5ilYyYtBEW7LAhK7OC2ydiEJar7v08sidkGY5zXfNyw2gvXckGo6ak7VxfJhFHQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4703.eurprd08.prod.outlook.com (10.255.114.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Tue, 28 May 2019 06:14:08 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:14:08 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v3 2/2] drm/komeda: Adds limitation check for AFBC wide
 block not support Rot90
Thread-Topic: [PATCH v3 2/2] drm/komeda: Adds limitation check for AFBC wide
 block not support Rot90
Thread-Index: AQHVFRyPEKY9mC6X0Ei+tL8MecHyLw==
Date:   Tue, 28 May 2019 06:14:08 +0000
Message-ID: <20190528061400.GB14743@james-ThinkStation-P300>
References: <1559015784-18998-1-git-send-email-lowry.li@arm.com>
 <1559015784-18998-3-git-send-email-lowry.li@arm.com>
In-Reply-To: <1559015784-18998-3-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SLXP216CA0007.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:6::17) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1c9d8de-8969-4a26-2afc-08d6e333b1ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4703;
x-ms-traffictypediagnostic: VE1PR08MB4703:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4703C83E3AEE05810603FA65B31E0@VE1PR08MB4703.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(81166006)(81156014)(8936002)(1076003)(53936002)(6246003)(8676002)(33716001)(6862004)(2906002)(66066001)(33656002)(256004)(71190400001)(71200400001)(86362001)(5660300002)(6436002)(66946007)(6512007)(102836004)(186003)(476003)(14454004)(68736007)(73956011)(446003)(11346002)(25786009)(99286004)(316002)(55236004)(6486002)(7736002)(305945005)(229853002)(76176011)(9686003)(26005)(58126008)(4326008)(66446008)(64756008)(66556008)(66476007)(478600001)(386003)(6506007)(3846002)(6116002)(54906003)(6636002)(486006)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4703;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GyV/Ygh7STI6hCHCGaa5F05+OR3AzymR/I0d7bCBVw9gzwoj01bn3GOeze/skzYMMbj0N1LJCK+lSW6Vnm6M7bPNk9OFPwQku90dXvWeU6Qffr3iRmpldMgbcW1Cv4++jB4y56YZyxAQt6KRToO2pkYDg3PmifrTxxuuI4IK2q0Vg3SifnuoQ4VSXCe6jjs5bQnzswu2WceR43iInVJo9Sfiy4X27uQWkq1AR8LhWCgmn83CDzu9H40CnUXh6mf0oa5OVCZ1BgTvmbNyp6zPqwKf5J3eBQJBD6mwCWkeIsRbwzsvC+hnVuOfRonhjZFwJzxFxXZVFG0rcoNI27iITz2OFVFNKkh6av6rGtPF5vZlZGksIMCHjKXVazmBs1dOYwlwe4zncRy1KIefuVVZyAsL6tdfGhcCozfe703c8oE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A86CF4E9FD87DD429AA70F7679C84732@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c9d8de-8969-4a26-2afc-08d6e333b1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:14:08.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:57:05AM +0800, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> Komeda series hardware doesn't support Rot90 for AFBC wide block. So
> add limitation check to reject it if such configuration has been posted.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c       | 15 ++++++++++++=
+++
>  .../gpu/drm/arm/display/komeda/komeda_format_caps.c    |  7 ++++++-
>  .../gpu/drm/arm/display/komeda/komeda_format_caps.h    |  8 +++++++-
>  .../gpu/drm/arm/display/komeda/komeda_framebuffer.c    | 18 +++++++++---=
------
>  .../gpu/drm/arm/display/komeda/komeda_framebuffer.h    |  5 +++--
>  .../gpu/drm/arm/display/komeda/komeda_pipeline_state.c |  8 +++++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c      |  2 +-
>  7 files changed, 48 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 1c914f8..4563c2a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -494,11 +494,26 @@ static int d71_enum_resources(struct komeda_dev *md=
ev)
>  	{__HW_ID(6, 7),	0/*DRM_FORMAT_YUV420_10BIT*/, 1,	RICH,	Rot_ALL_H_V,	LYT=
_NM, AFB_TH},
>  };
> =20
> +static bool d71_format_mod_supported(const struct komeda_format_caps *ca=
ps,
> +				     u32 layer_type, u64 modifier, u32 rot)
> +{
> +	uint64_t layout =3D modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK;
> +
> +	if ((layout =3D=3D AFBC_FORMAT_MOD_BLOCK_SIZE_32x8) &&
> +	    drm_rotation_90_or_270(rot)) {
> +		DRM_DEBUG_ATOMIC("D71 doesn't support ROT90 for WB-AFBC.\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static void d71_init_fmt_tbl(struct komeda_dev *mdev)
>  {
>  	struct komeda_format_caps_table *table =3D &mdev->fmt_tbl;
> =20
>  	table->format_caps =3D d71_format_caps_table;
> +	table->format_mod_supported =3D d71_format_mod_supported;
>  	table->n_formats =3D ARRAY_SIZE(d71_format_caps_table);
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> index b219514..cd4d9f5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> @@ -74,7 +74,8 @@
>  };
> =20
>  bool komeda_format_mod_supported(struct komeda_format_caps_table *table,
> -				 u32 layer_type, u32 fourcc, u64 modifier)
> +				 u32 layer_type, u32 fourcc, u64 modifier,
> +				 u32 rot)
>  {
>  	const struct komeda_format_caps *caps;
> =20
> @@ -85,6 +86,10 @@ bool komeda_format_mod_supported(struct komeda_format_=
caps_table *table,
>  	if (!(caps->supported_layer_types & layer_type))
>  		return false;
> =20
> +	if (table->format_mod_supported)
> +		return table->format_mod_supported(caps, layer_type, modifier,
> +						   rot);
> +
>  	return true;
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index 96de22e..381e873 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -71,10 +71,15 @@ struct komeda_format_caps {
>   *
>   * @n_formats: the size of format_caps list.
>   * @format_caps: format_caps list.
> + * @format_mod_supported: Optional. Some HW may have special requirement=
s or
> + * limitations which can not be described by format_caps, this func supp=
ly HW
> + * the ability to do the further HW specific check.
>   */
>  struct komeda_format_caps_table {
>  	u32 n_formats;
>  	const struct komeda_format_caps *format_caps;
> +	bool (*format_mod_supported)(const struct komeda_format_caps *caps,
> +				     u32 layer_type, u64 modifier, u32 rot);
>  };
> =20
>  extern u64 komeda_supported_modifiers[];
> @@ -100,6 +105,7 @@ u32 *komeda_get_layer_fourcc_list(struct komeda_forma=
t_caps_table *table,
>  void komeda_put_fourcc_list(u32 *fourcc_list);
> =20
>  bool komeda_format_mod_supported(struct komeda_format_caps_table *table,
> -				 u32 layer_type, u32 fourcc, u64 modifier);
> +				 u32 layer_type, u32 fourcc, u64 modifier,
> +				 u32 rot);
> =20
>  #endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index d0e713a..5f63dec 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -240,20 +240,20 @@ struct drm_framebuffer *
>  }
> =20
>  /* if the fb can be supported by a specific layer */
> -bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type)
> +bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type,
> +				  u32 rot)
>  {
>  	struct drm_framebuffer *fb =3D &kfb->base;
>  	struct komeda_dev *mdev =3D fb->dev->dev_private;
> -	const struct komeda_format_caps *caps;
>  	u32 fourcc =3D fb->format->format;
>  	u64 modifier =3D fb->modifier;
> +	bool supported;
> =20
> -	caps =3D komeda_get_format_caps(&mdev->fmt_tbl, fourcc, modifier);
> -	if (!caps)
> -		return false;
> +	supported =3D komeda_format_mod_supported(&mdev->fmt_tbl, layer_type,
> +						fourcc, modifier, rot);
> +	if (!supported)
> +		DRM_DEBUG_ATOMIC("Layer TYPE: %d doesn't support fb FMT: %s.\n",
> +			layer_type, komeda_get_format_name(fourcc, modifier));
> =20
> -	if (!(caps->supported_layer_types & layer_type))
> -		return false;
> -
> -	return true;
> +	return supported;
>  }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> index e3bab0d..6cbb2f6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -35,9 +35,10 @@ struct komeda_fb {
> =20
>  struct drm_framebuffer *
>  komeda_fb_create(struct drm_device *dev, struct drm_file *file,
> -		 const struct drm_mode_fb_cmd2 *mode_cmd);
> +		const struct drm_mode_fb_cmd2 *mode_cmd);
>  dma_addr_t
>  komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x, int y, int plane)=
;
> -bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type)=
;
> +bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type,
> +		u32 rot);
> =20
>  #endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 34737c0..042d4d7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -274,6 +274,11 @@ struct komeda_pipeline_state *
>  		       struct komeda_plane_state *kplane_st,
>  		       struct komeda_data_flow_cfg *dflow)
>  {
> +	struct komeda_fb *kfb =3D to_kfb(kplane_st->base.fb);
> +
> +	if (!komeda_fb_is_layer_supported(kfb, layer->layer_type, dflow->rot))
> +		return -EINVAL;
> +
>  	if (!in_range(&layer->hsize_in, dflow->in_w)) {
>  		DRM_DEBUG_ATOMIC("src_w: %d is out of range.\n", dflow->in_w);
>  		return -EINVAL;
> @@ -359,7 +364,8 @@ struct komeda_pipeline_state *
>  	struct komeda_layer_state *st;
>  	int i;
> =20
> -	if (!komeda_fb_is_layer_supported(kfb, wb_layer->layer_type))
> +	if (!komeda_fb_is_layer_supported(kfb, wb_layer->layer_type,
> +					  dflow->rot))
>  		return -EINVAL;
> =20
>  	c_st =3D komeda_component_get_state_and_set_user(&wb_layer->base,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index c9f37ff..798ee24 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -216,7 +216,7 @@ static void komeda_plane_reset(struct drm_plane *plan=
e)
>  	u32 layer_type =3D kplane->layer->layer_type;
> =20
>  	return komeda_format_mod_supported(&mdev->fmt_tbl, layer_type,
> -					   format, modifier);
> +					   format, modifier, 0);
>  }
> =20
>  static const struct drm_plane_funcs komeda_plane_funcs =3D {
> --=20
> 1.9.1
>=20

LGTM.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
