Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F5BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCFF2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="0YsyGrNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfE1GIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:08:14 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:27300
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbfE1GIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHJz+Qa/IUF53j0nhwlXZzG6ST0QTj2xiPN+k0O6zLA=;
 b=0YsyGrNEhg0E78nepQOgoXcTCGUiAygbiUiFZPnewpCirQs15sxWex/9f4WIcQ6Y/syO/MrPto4xjRJSPkfYixi401+F8QjY165N8Wp6+/hbY5j2aU+wYuc76bWKETYbrA5r5f4Qfuc3QqBF+yjqDPMeoapfkwEqZdjocQqQgCo=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5037.eurprd08.prod.outlook.com (10.255.159.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 06:08:08 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 06:08:08 +0000
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
Subject: Re: [PATCH v3 1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Topic: [PATCH v3 1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Index: AQHVFRu4JBxnsw+4AU2JU8mJVT7HnA==
Date:   Tue, 28 May 2019 06:08:08 +0000
Message-ID: <20190528060800.GA14743@james-ThinkStation-P300>
References: <1559015784-18998-1-git-send-email-lowry.li@arm.com>
 <1559015784-18998-2-git-send-email-lowry.li@arm.com>
In-Reply-To: <1559015784-18998-2-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SL2P216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:1a::23) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 066f9e36-c32b-4bde-624b-08d6e332db10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5037;
x-ms-traffictypediagnostic: VE1PR08MB5037:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5037F6BB68BCA2A0878ACE19B31E0@VE1PR08MB5037.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:111;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(189003)(199004)(8936002)(81166006)(81156014)(1076003)(11346002)(446003)(53936002)(6246003)(8676002)(33716001)(71190400001)(33656002)(2906002)(66066001)(256004)(14444005)(6862004)(71200400001)(86362001)(5660300002)(6512007)(102836004)(478600001)(66946007)(73956011)(6436002)(186003)(476003)(14454004)(68736007)(25786009)(99286004)(316002)(55236004)(7736002)(305945005)(229853002)(76176011)(58126008)(66446008)(64756008)(66556008)(66476007)(26005)(4326008)(486006)(386003)(6506007)(3846002)(6116002)(9686003)(54906003)(6636002)(6486002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5037;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CZ84ZUeC6Hb6F4to37UqbJ64cT2rUAmREh21V6cQaHK/VET4YyzRXcK0xl5l/vGQSl0ByVX2NuqsyiSgJIR4rK0vu1AB+rSPZugWM6aOmt0bkUj57ML+3HFVhr0En5Q63kGuXXOvy6o1br8/sGKEnVOWi9fFHhL3Fy9bT1q/XV374At3UBE5b8CE9bvyQJimcK7eSaMtnF/bB5jaA9OYGncaRmXL/bQiGGGrL+pxiECZRvbuLzwCojeqCQIj0r65qLqTYap9CkkmcApQZ19gA4NjEjosHADJWaX733GGmxgnSpYAVigZjyXYU7Ce7rpcwwmHxWth8Ywvfw/ht6/xwZXAq/lv+zkkBB0xuC8Une8s63x0XFtY3eiiiZuEmv7QEiZR5m0+GJSEHEqBP0fvIdDy9fhN3pVJJ9wd2LswQIU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F57110043732E4EA82BB1C59FBCA830@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066f9e36-c32b-4bde-624b-08d6e332db10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 06:08:08.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:57:00AM +0800, Lowry Li (Arm Technology China) w=
rote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>=20
> - Adds rotation property to plane.
> - Komeda display rotation support diverges from the specific formats,
> so need to check the user required rotation type with the format caps
> and reject the commit if it can not be supported.
> - In the layer validate flow, sets the rotation value to the layer
> state. If r90 or r270, swap the width and height of the data flow
> for next stage.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h  | 11 ++++++++++=
+
>  .../gpu/drm/arm/display/komeda/komeda_pipeline_state.c   |  7 +++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c        | 16 ++++++++++=
++++++
>  3 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> index bc3b2df36..96de22e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -79,6 +79,17 @@ struct komeda_format_caps_table {
> =20
>  extern u64 komeda_supported_modifiers[];
> =20
> +static inline const char *komeda_get_format_name(u32 fourcc, u64 modifie=
r)
> +{
> +	struct drm_format_name_buf buf;
> +	static char name[64];
> +
> +	snprintf(name, sizeof(name), "%s with modifier: 0x%llx.",
> +		 drm_get_format_name(fourcc, &buf), modifier);
> +
> +	return name;
> +}
> +
>  const struct komeda_format_caps *
>  komeda_get_format_caps(struct komeda_format_caps_table *table,
>  		       u32 fourcc, u64 modifier);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b=
/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index db34ea2..34737c0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -339,6 +339,13 @@ struct komeda_pipeline_state *
>  	/* update the data flow for the next stage */
>  	komeda_component_set_output(&dflow->input, &layer->base, 0);
> =20
> +	/*
> +	 * The rotation has been handled by layer, so adjusted the data flow fo=
r
> +	 * the next stage.
> +	 */
> +	if (drm_rotation_90_or_270(st->rot))
> +		swap(dflow->in_h, dflow->in_w);
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index 9b87c25..c9f37ff 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -10,6 +10,7 @@
>  #include <drm/drm_print.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> +#include "komeda_framebuffer.h"
> =20
>  static int
>  komeda_plane_init_data_flow(struct drm_plane_state *st,
> @@ -17,6 +18,7 @@
>  {
>  	struct komeda_plane_state *kplane_st =3D to_kplane_st(st);
>  	struct drm_framebuffer *fb =3D st->fb;
> +	const struct komeda_format_caps *caps =3D to_kfb(fb)->format_caps;
> =20
>  	memset(dflow, 0, sizeof(*dflow));
> =20
> @@ -37,6 +39,15 @@
>  	dflow->in_w =3D st->src_w >> 16;
>  	dflow->in_h =3D st->src_h >> 16;
> =20
> +	dflow->rot =3D drm_rotation_simplify(st->rotation, caps->supported_rots=
);
> +	if (!has_bits(dflow->rot, caps->supported_rots)) {
> +		DRM_DEBUG_ATOMIC("rotation(0x%x) isn't supported by %s.\n",
> +				 dflow->rot,
> +				 komeda_get_format_name(caps->fourcc,
> +							fb->modifier));
> +		return -EINVAL;
> +	}
> +
>  	dflow->en_img_enhancement =3D kplane_st->img_enhancement;
> =20
>  	komeda_complete_data_flow_cfg(dflow);
> @@ -303,6 +314,11 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
ms,
> =20
>  	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
> =20
> +	err =3D drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
> +						 layer->supported_rots);
> +	if (err)
> +		goto cleanup;
> +
>  	err =3D drm_plane_create_alpha_property(plane);
>  	if (err)
>  		goto cleanup;
> --=20
> 1.9.1
>=20

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
