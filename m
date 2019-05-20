Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D4C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683C720815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ufnb4FaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfETGFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:05:06 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:6785
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbfETGFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2esr8sEOD+pLEKC1/MQQ1/0YX8UDEiTqSITw6Pe/DY=;
 b=Ufnb4FaQZht50gz0GXmZNmU5+yJMcdxQzG5trwIu2qdIpreRLWGugYARMG2vmkuSNQR0RmLgq7iqsoqoZGVO9vNIW0uF8g1TequjU8uORj/9jmXPuF7Rdpr/PaoXhgXiYwUIzr22tSI7wOWbOPcT+fhxHu4VA52sHi6ZBSpvxl4=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4719.eurprd08.prod.outlook.com (10.255.115.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 06:05:00 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 06:05:00 +0000
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
Subject: Re: drm/komeda: Adds zorder support
Thread-Topic: drm/komeda: Adds zorder support
Thread-Index: AQHVDtH1paFJuJcA9UK8BsJySPMB7A==
Date:   Mon, 20 May 2019 06:05:00 +0000
Message-ID: <20190520060454.GA2774@james-ThinkStation-P300>
References: <1558323179-18857-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1558323179-18857-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde564ab-c128-4de0-a56f-08d6dce917ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4719;
x-ms-traffictypediagnostic: VE1PR08MB4719:
x-ms-exchange-purlcount: 7
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4719BBBC5A65DFE4E3E83E19B3060@VE1PR08MB4719.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(71200400001)(9686003)(71190400001)(6512007)(14444005)(256004)(6636002)(58126008)(26005)(229853002)(11346002)(476003)(2906002)(486006)(6486002)(54906003)(6436002)(6306002)(33716001)(53936002)(8936002)(6116002)(66066001)(66946007)(66476007)(7736002)(64756008)(3846002)(102836004)(305945005)(66556008)(55236004)(99286004)(52116002)(33656002)(316002)(6862004)(8676002)(6246003)(446003)(66446008)(73956011)(5660300002)(25786009)(4326008)(14454004)(86362001)(76176011)(186003)(81166006)(1076003)(386003)(6506007)(966005)(478600001)(81156014)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4719;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZYTxQMXQ3t3/WRvG5uhq/fKSH1WrPyScg0C80WbTsmX7AzqdOPR2S4ph+BNR+e0A0QifuPVqOHoT7QJuVzmZVOD7727f/gXGT8SDAnUzTkN6Gf8K1rgYLidHxAffDmfNPk+YNPJ8n2c/wv98JB+Y49dQui9MmpWfne5N1sYv6gQGc7U0xTBZWiqBTRzT2y5tKGN2dT0qQrRbFV3BdN78nyEz94/IxZdkKb5ZjAmOrxCOpbaq5KuMHiKoaGCin0z5i+zW8DCuUge5B/2uCrA8UgTJxyD+9UnKSYDdBJ8seX7Rrar74m6PM/m4tAVhq+L1DkYvWYeeK2rH5baVlB0mTW9ZiHrrLWmaPuWCNXkSr9lfU8lI9D/zkaG1DcJQTxAqPbtDWyccJe37peG2kA96t9DWUwfOxMlW1vgAaPwR8V0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <262F122D38B0C8489665AD35673B99D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde564ab-c128-4de0-a56f-08d6dce917ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 06:05:00.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:33:19AM +0000, Lowry Li (Arm Technology China) w=
rote:
> - Creates the zpos property.
> - Implement komeda_crtc_normalize_zpos to replace
> drm_atomic_normalize_zpos, reasons as the following:
>=20
> 1. The drm_atomic_normalize_zpos allows to configure same zpos for
> different planes, but komeda doesn't support such configuration.
> 2. For further slave pipline case, Komeda need to calculate the
> max_slave_zorder, we will merge such calculation into
> komed_crtc_normalize_zpos to save a separated plane_state loop.
> 3. For feature none-scaling layer_split, which a plane_state will be
> assigned to two individual layers(left/right), which requires two
> normalize_zpos for this plane, plane_st->normalize_zpos will be used
> by left layer, normalize_zpos + 1 for right_layer.
>=20
> This patch series depends on:
> - https://patchwork.freedesktop.org/series/58710/
> - https://patchwork.freedesktop.org/series/59000/
> - https://patchwork.freedesktop.org/series/59002/
> - https://patchwork.freedesktop.org/series/59747/
> - https://patchwork.freedesktop.org/series/59915/
> - https://patchwork.freedesktop.org/series/60083/
> - https://patchwork.freedesktop.org/series/60698/
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c   | 90 +++++++++++++++++=
+++++-
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h   |  3 +
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c |  6 +-
>  3 files changed, 97 insertions(+), 2 deletions(-)
>=20
> --=20
> 1.9.1
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 306ea06..0ec7665 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -100,6 +100,90 @@ static void komeda_kms_commit_tail(struct drm_atomic=
_state *old_state)
>  	.atomic_commit_tail =3D komeda_kms_commit_tail,
>  };
> =20
> +static int komeda_plane_state_list_add(struct drm_plane_state *plane_st,
> +				       struct list_head *zorder_list)
> +{
> +	struct komeda_plane_state *new =3D to_kplane_st(plane_st);
> +	struct komeda_plane_state *node, *last;
> +
> +	last =3D list_empty(zorder_list) ?
> +	       NULL : list_last_entry(zorder_list, typeof(*last), zlist_node);
> +
> +	/* Considering the list sequence is zpos increasing, so if list is empt=
y
> +	 * or the zpos of new node bigger than the last node in list, no need
> +	 * loop and just insert the new one to the tail of the list.
> +	 */
> +	if (!last || (new->base.zpos > last->base.zpos)) {
> +		list_add_tail(&new->zlist_node, zorder_list);
> +		return 0;
> +	}
> +
> +	/* Build the list by zpos increasing */
> +	list_for_each_entry(node, zorder_list, zlist_node) {
> +		if (new->base.zpos < node->base.zpos) {
> +			list_add_tail(&new->zlist_node, &node->zlist_node);
> +			break;
> +		} else if (node->base.zpos =3D=3D new->base.zpos) {
> +			struct drm_plane *a =3D node->base.plane;
> +			struct drm_plane *b =3D new->base.plane;
> +
> +			/* Komeda doesn't support setting a same zpos for
> +			 * different planes.
> +			 */
> +			DRM_DEBUG_ATOMIC("PLANE: %s and PLANE: %s are configured same zpos: %=
d.\n",
> +					 a->name, b->name, node->base.zpos);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
> +				      struct drm_crtc_state *crtc_st)
> +{
> +	struct drm_atomic_state *state =3D crtc_st->state;
> +	struct komeda_plane_state *kplane_st;
> +	struct drm_plane_state *plane_st;
> +	struct drm_framebuffer *fb;
> +	struct drm_plane *plane;
> +	struct list_head zorder_list;
> +	int order =3D 0, err;
> +
> +	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
> +			 crtc->base.id, crtc->name);
> +
> +	INIT_LIST_HEAD(&zorder_list);
> +
> +	/* This loop also added all effected planes into the new state */
> +	drm_for_each_plane_mask(plane, crtc->dev, crtc_st->plane_mask) {
> +		plane_st =3D drm_atomic_get_plane_state(state, plane);
> +		if (IS_ERR(plane_st))
> +			return PTR_ERR(plane_st);
> +
> +		/* Build a list by zpos increasing */
> +		err =3D komeda_plane_state_list_add(plane_st, &zorder_list);
> +		if (err)
> +			return err;
> +	}
> +
> +	list_for_each_entry(kplane_st, &zorder_list, zlist_node) {
> +		plane_st =3D &kplane_st->base;
> +		fb =3D plane_st->fb;
> +		plane =3D plane_st->plane;
> +
> +		plane_st->normalized_zpos =3D order++;
> +
> +		DRM_DEBUG_ATOMIC("[PLANE:%d:%s] zpos:%d, normalized zpos: %d\n",
> +				 plane->base.id, plane->name,
> +				 plane_st->zpos, plane_st->normalized_zpos);
> +	}
> +
> +	crtc_st->zpos_changed =3D true;
> +
> +	return 0;
> +}
> +
>  static int komeda_kms_check(struct drm_device *dev,
>  			    struct drm_atomic_state *state)
>  {
> @@ -111,7 +195,7 @@ static int komeda_kms_check(struct drm_device *dev,
>  	if (err)
>  		return err;
> =20
> -	/* komeda need to re-calculate resource assumption in every commit
> +	/* Komeda need to re-calculate resource assumption in every commit
>  	 * so need to add all affected_planes (even unchanged) to
>  	 * drm_atomic_state.
>  	 */
> @@ -119,6 +203,10 @@ static int komeda_kms_check(struct drm_device *dev,
>  		err =3D drm_atomic_add_affected_planes(state, crtc);
>  		if (err)
>  			return err;
> +
> +		err =3D komeda_crtc_normalize_zpos(crtc, new_crtc_st);
> +		if (err)
> +			return err;
>  	}
> =20
>  	err =3D drm_atomic_helper_check_planes(dev, state);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.h
> index 178bee6..d1cef46 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -7,6 +7,7 @@
>  #ifndef _KOMEDA_KMS_H_
>  #define _KOMEDA_KMS_H_
> =20
> +#include <linux/list.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -46,6 +47,8 @@ struct komeda_plane {
>  struct komeda_plane_state {
>  	/** @base: &drm_plane_state */
>  	struct drm_plane_state base;
> +	/** @zlist_node: zorder list node */
> +	struct list_head zlist_node;
> =20
>  	/* @img_enhancement: on/off image enhancement */
>  	u8 img_enhancement : 1;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/=
gpu/drm/arm/display/komeda/komeda_plane.c
> index bcf30a7..aad7663 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -21,7 +21,7 @@
> =20
>  	memset(dflow, 0, sizeof(*dflow));
> =20
> -	dflow->blending_zorder =3D st->zpos;
> +	dflow->blending_zorder =3D st->normalized_zpos;
> =20
>  	/* if format doesn't have alpha, fix blend mode to PIXEL_NONE */
>  	dflow->pixel_blend_mode =3D fb->format->has_alpha ?
> @@ -343,6 +343,10 @@ static int komeda_plane_add(struct komeda_kms_dev *k=
ms,
>  	if (err)
>  		goto cleanup;
> =20
> +	err =3D drm_plane_create_zpos_property(plane, layer->base.id, 0, 8);
> +	if (err)
> +		goto cleanup;
> +
>  	return 0;
>  cleanup:
>  	komeda_plane_destroy(plane);

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
