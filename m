Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E393C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LTb/hl0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfETFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:51:00 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:37508
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfETFu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlRklOFJ9ctjy9xcn/4SSyiX5hPBiZwEO6F0Zb4isrQ=;
 b=LTb/hl0xZ8x+NpkaGDKDdE9tG8NEEkA9v1Bgm7pr0FZEt61Ng1ufYUiDClwMHs65JttSXwaO3YDwtWkp3Yr8l1FmncxVVfjANFbsC+58cY90Lw356O2zHRg3uG3cFz77qSxDHzeyl+O/zyZ199BZ5El+FF95QM//9xJ1TZNq4Xg=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4736.eurprd08.prod.outlook.com (10.255.112.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 20 May 2019 05:50:51 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 05:50:51 +0000
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
Subject: Re: [PATCH v1 2/2] drm/komeda: Enable color-encoding (YUV format)
 support
Thread-Topic: [PATCH v1 2/2] drm/komeda: Enable color-encoding (YUV format)
 support
Thread-Index: AQHVDs/7vFgM5dRw00SFo47Uai6Ylg==
Date:   Mon, 20 May 2019 05:50:51 +0000
Message-ID: <20190520055045.GB2308@james-ThinkStation-P300>
References: <1557987170-24032-1-git-send-email-lowry.li@arm.com>
 <1557987170-24032-3-git-send-email-lowry.li@arm.com>
In-Reply-To: <1557987170-24032-3-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93503e3-f3f4-4c91-846c-08d6dce71d8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4736;
x-ms-traffictypediagnostic: VE1PR08MB4736:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB47367A85DA85E36F77641C77B3060@VE1PR08MB4736.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(189003)(199004)(386003)(14454004)(4326008)(1076003)(66446008)(6506007)(2906002)(6862004)(5660300002)(25786009)(66476007)(6636002)(58126008)(52116002)(76176011)(64756008)(33656002)(26005)(6116002)(102836004)(55236004)(73956011)(66066001)(66556008)(54906003)(99286004)(66946007)(68736007)(3846002)(186003)(11346002)(6512007)(33716001)(446003)(86362001)(486006)(316002)(476003)(229853002)(6436002)(256004)(71190400001)(81156014)(8936002)(478600001)(7736002)(305945005)(9686003)(14444005)(71200400001)(6246003)(6486002)(81166006)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4736;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2hz8Br/2fAeh1qlhziq3aJikycHy5hjPNU/x740KSWvQY8Sr78mIpuZqCNLFTZ0paSTuB4pMouhhdg8xy4+GNLwUQowk7/nFKngDFCKwplqFUjeZlGFxn65LpOqndoR939d7MEvMGBELfOrSzkAnXjhDteqBOkEHSkl+z+EBtLFF54bd0n+DvE8cF/Ou7mUW73kK8i3DN9+hNyXfH+IQqnpmrDhaSZHr83wZRATRK1lKCgI+BIs1EYcnpilYx3tj+gXmwg5bztmruqoGxnoGdThnAP7GeXKLRl0dOZnNhg2Ke7uEUhY+sR6elmCcwy7gcAQgOCDDvmD5HauJ4LI0uzo5GSfzQpAIb4Dr+mb6HCgo0rtAoZwr6jADxeeaTR+etloYkshlZxdkXs+wgyYaVRTjPdRw54AbGGVB2Cd4us=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D37877883B0AAD4F9EAF426F1E9DDAEB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93503e3-f3f4-4c91-846c-08d6dce71d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 05:50:51.3507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 02:13:13PM +0800, Lowry Li (Arm Technology China) w=
rote:
> Adds color-encoding properties if layer can support YUV format.
> Updates HW YUV-RGB matrix state according to the color-encoding
> properties.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/Makefile        |  1 +
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c |  6 ++
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 67 ++++++++++++++++=
++++++
>  .../gpu/drm/arm/display/komeda/komeda_color_mgmt.h | 17 ++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c  | 13 +++++
>  5 files changed, 104 insertions(+)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.=
c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.=
h
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/dr=
m/arm/display/komeda/Makefile
> index d7e29fc..73b8e8b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -8,6 +8,7 @@ komeda-y :=3D \
>  	komeda_drv.o \
>  	komeda_dev.o \
>  	komeda_format_caps.o \
> +	komeda_color_mgmt.o \
>  	komeda_pipeline.o \
>  	komeda_pipeline_state.o \
>  	komeda_framebuffer.o \
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index dfc70f5..b85514b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -10,6 +10,7 @@
>  #include "komeda_kms.h"
>  #include "malidp_io.h"
>  #include "komeda_framebuffer.h"
> +#include "komeda_color_mgmt.h"
> =20
>  static void get_resources_id(u32 hw_id, u32 *pipe_id, u32 *comp_id)
>  {
> @@ -239,6 +240,11 @@ static void d71_layer_update(struct komeda_component=
 *c,
>  		}
> =20
>  		malidp_write32(reg, LAYER_R_CONTROL, upsampling);
> +		malidp_write_group(reg, LAYER_YUV_RGB_COEFF0,
> +				   KOMEDA_N_YUV2RGB_COEFFS,
> +				   komeda_select_yuv2rgb_coeffs(
> +					plane_st->color_encoding,
> +					plane_st->color_range));
>  	}
> =20
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> new file mode 100644
> index 0000000..9d14a92
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +
> +#include "komeda_color_mgmt.h"
> +
> +/* 10bit precision YUV2RGB matrix */
> +static const s32 yuv2rgb_bt601_narrow[KOMEDA_N_YUV2RGB_COEFFS] =3D {
> +	1192,    0, 1634,
> +	1192, -401, -832,
> +	1192, 2066,    0,
> +	  64,  512,  512
> +};
> +
> +static const s32 yuv2rgb_bt601_wide[KOMEDA_N_YUV2RGB_COEFFS] =3D {
> +	1024,    0, 1436,
> +	1024, -352, -731,
> +	1024, 1815,    0,
> +	   0,  512,  512
> +};
> +
> +static const s32 yuv2rgb_bt709_narrow[KOMEDA_N_YUV2RGB_COEFFS] =3D {
> +	1192,    0, 1836,
> +	1192, -218, -546,
> +	1192, 2163,    0,
> +	  64,  512,  512
> +};
> +
> +static const s32 yuv2rgb_bt709_wide[KOMEDA_N_YUV2RGB_COEFFS] =3D {
> +	1024,    0, 1613,
> +	1024, -192, -479,
> +	1024, 1900,    0,
> +	   0,  512,  512
> +};
> +
> +static const s32 yuv2rgb_bt2020[KOMEDA_N_YUV2RGB_COEFFS] =3D {
> +	1024,    0, 1476,
> +	1024, -165, -572,
> +	1024, 1884,    0,
> +	   0,  512,  512
> +};
> +
> +const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge)
> +{
> +	bool narrow =3D color_range =3D=3D DRM_COLOR_YCBCR_LIMITED_RANGE;
> +	const s32 *coeffs;
> +
> +	switch (color_encoding) {
> +	case DRM_COLOR_YCBCR_BT709:
> +		coeffs =3D narrow ? yuv2rgb_bt709_narrow : yuv2rgb_bt709_wide;
> +		break;
> +	case DRM_COLOR_YCBCR_BT601:
> +		coeffs =3D narrow ? yuv2rgb_bt601_narrow : yuv2rgb_bt601_wide;
> +		break;
> +	case DRM_COLOR_YCBCR_BT2020:
> +		coeffs =3D yuv2rgb_bt2020;
> +		break;
> +	default:
> +		coeffs =3D NULL;
> +		break;
> +	}
> +
> +	return coeffs;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h b/dri=
vers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> new file mode 100644
> index 0000000..a2df218
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2019 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +
> +#ifndef _KOMEDA_COLOR_MGMT_H_
> +#define _KOMEDA_COLOR_MGMT_H_
> +
> +#include <drm/drm_color_mgmt.h>
> +
> +#define KOMEDA_N_YUV2RGB_COEFFS		12
> +
> +const s32 *komeda_select_yuv2rgb_coeffs(u32 color_encoding, u32 color_ra=
nge);
> +
> +#endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index f344048..bcf30a7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -135,6 +135,8 @@ static void komeda_plane_reset(struct drm_plane *plan=
e)
>  		state->base.pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
>  		state->base.alpha =3D DRM_BLEND_ALPHA_OPAQUE;
>  		state->base.zpos =3D kplane->layer->base.id;
> +		state->base.color_encoding =3D DRM_COLOR_YCBCR_BT601;
> +		state->base.color_range =3D DRM_COLOR_YCBCR_LIMITED_RANGE;
>  		plane->state =3D &state->base;
>  		plane->state->plane =3D plane;
>  	}
> @@ -330,6 +332,17 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
ms,
>  	if (err)
>  		goto cleanup;
> =20
> +	err =3D drm_plane_create_color_properties(plane,
> +			BIT(DRM_COLOR_YCBCR_BT601) |
> +			BIT(DRM_COLOR_YCBCR_BT709) |
> +			BIT(DRM_COLOR_YCBCR_BT2020),
> +			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
> +			DRM_COLOR_YCBCR_BT601,
> +			DRM_COLOR_YCBCR_LIMITED_RANGE);
> +	if (err)
> +		goto cleanup;
> +
>  	return 0;
>  cleanup:
>  	komeda_plane_destroy(plane);
> --=20
> 1.9.1
>=20
=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>

Looks good to me

Thank you
