Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="a+EaCWXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfD3HWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:22:06 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:26485
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbfD3HWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNjyS4WPZRJjNQ1gVe1kwFE4rShUMbpk+kQ81dvzpEg=;
 b=a+EaCWXrs1NfPDz3ChoGNun7paJXx0iRtDDNjrF88KGE2xrCFcL7ogvpC4hH52x6mTMJNOZYI9vTOP8OtP6SHdoaw9EdMK9xHfBTpAOQZLHovU7hROGeSNLrmUg8Duo3KVCQyBi1Xdpl8J71nAgwWIqcPhltAiX0SpzYtv/jePQ=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4877.eurprd08.prod.outlook.com (10.255.113.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 07:21:22 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759%4]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 07:21:22 +0000
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
Subject: Re: [v1,1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Topic: [v1,1/2] drm/komeda: Add rotation support on Komeda driver
Thread-Index: AQHU/yVQOcJma0mqM0egze7YrU4xXw==
Date:   Tue, 30 Apr 2019 07:21:22 +0000
Message-ID: <20190430072111.GA8277@james-ThinkStation-P300>
References: <1555902945-2877-2-git-send-email-lowry.li@arm.com>
In-Reply-To: <1555902945-2877-2-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d933466-9c70-42b4-8e1a-08d6cd3c7288
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4877;
x-ms-traffictypediagnostic: VE1PR08MB4877:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4877F1521F656AF617EC455AB33A0@VE1PR08MB4877.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:111;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(478600001)(6862004)(316002)(86362001)(11346002)(26005)(14454004)(4326008)(53936002)(14444005)(6636002)(446003)(66066001)(54906003)(58126008)(6512007)(186003)(52116002)(256004)(9686003)(6246003)(476003)(102836004)(76176011)(99286004)(55236004)(25786009)(386003)(1076003)(6506007)(33656002)(7736002)(97736004)(73956011)(6116002)(305945005)(229853002)(64756008)(66556008)(68736007)(66946007)(3846002)(2906002)(8936002)(81156014)(6486002)(6436002)(8676002)(33716001)(5660300002)(66446008)(81166006)(71200400001)(486006)(66476007)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4877;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SpF7GCiNaNKBw5CNueMBc3QeZktIaMFupIxnKTLMI0F6OQcfSvOFAavqq+ucNrd5er8+Pz7kGsdVYHrRtrp8DyQnxneDxceod/1xGWtVSSP50mwxkl6o+Bv1qvOufo4WJZYIF/m+OCQeo/hIEk9eGM0kdmIWQdfzNDCFzYwyDDn1XHo9pCO2Als/IssqwEtNIIer7RpJbZjO0/ih/ZhTph9b1FqDwcET9zBrxxd8JZi+vkuIbtDJARrd+2SMtLNJ9ZkoVXHVhQtJowg/i5prM/qg6RfM/DAdYf8bszVOjg0W+kdpGbuTNJv3IZVBiaSmNua4JciFnkqy0TdXfogT1aHJvXIn9vjgRCDESN5GH4emhgb830iCOfwmkgpEWZziXjJydX2eayIBbpoVruqNZoBaXrJdNJ4/yi9GVzmL3d0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D76CE9544FA6394A988C0330002574AA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d933466-9c70-42b4-8e1a-08d6cd3c7288
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 07:21:22.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 03:16:26AM +0000, Lowry Li (Arm Technology China) w=
rote:
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
> --=20
> 1.9.1
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
> index 9b29e9a..8c133e4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -317,6 +317,13 @@ struct komeda_pipeline_state *
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
> index 14d6861..5e5bfdb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -9,12 +9,14 @@
>  #include <drm/drm_plane_helper.h>
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
> +#include "komeda_framebuffer.h"
> =20
>  static int
>  komeda_plane_init_data_flow(struct drm_plane_state *st,
>  			    struct komeda_data_flow_cfg *dflow)
>  {
>  	struct drm_framebuffer *fb =3D st->fb;
> +	const struct komeda_format_caps *caps =3D to_kfb(fb)->format_caps;
> =20
>  	memset(dflow, 0, sizeof(*dflow));
> =20
> @@ -35,6 +37,15 @@
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
>  	return 0;
>  }
> =20
> @@ -233,6 +244,11 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
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

Looks good to me.

James.
--=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
