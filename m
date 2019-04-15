Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A402C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6DB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XksSB4FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfDOH7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:59:35 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:34278
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfDOH7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIiUfHjfulzPeTS/O7wKDeEAsHJoRoUICoK9Lms/gPg=;
 b=XksSB4FCZfHRWQutYGNseIH7MMSKtXcJALUGvFimOKVY4HiJUGSH7R9cZfCMEJuLxnR0y3FmuQyjG4G7uHGhOIaJ8iJI/8ttFFmymhF9uh+1+NfViFsw0AZ5v29veMxR7YJ/sZF846DApBJJnmN+HcM2OtWCzDv8DfioAnwMAoc=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 07:59:30 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6ca6:1d85:8903:90d7%5]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 07:59:30 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ben Davis <Ben.Davis@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>
Subject: Re: [v2,1/2] drm: Add writeback_w,h properties
Thread-Topic: [v2,1/2] drm: Add writeback_w,h properties
Thread-Index: AQHU82Emr+L4Fng2UkyzLXjfphCwJg==
Date:   Mon, 15 Apr 2019 07:59:30 +0000
Message-ID: <20190415075922.GA24596@james-ThinkStation-P300>
References: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
In-Reply-To: <1555078094-6587-2-git-send-email-ben.davis@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:203:52::16) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c905391b-6083-48d0-c3d9-08d6c17848c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4637;
x-ms-traffictypediagnostic: VE1PR08MB4637:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB46370CA11DD00D7562B1BB97B32B0@VE1PR08MB4637.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(136003)(376002)(396003)(39850400004)(189003)(199004)(55236004)(1076003)(14454004)(9686003)(386003)(6506007)(6512007)(6636002)(229853002)(33716001)(8936002)(53936002)(81156014)(81166006)(33656002)(71190400001)(71200400001)(2906002)(97736004)(76176011)(8676002)(478600001)(3846002)(6116002)(25786009)(6486002)(66066001)(11346002)(486006)(316002)(54906003)(58126008)(99286004)(476003)(6436002)(26005)(52116002)(86362001)(68736007)(305945005)(7736002)(5024004)(6862004)(14444005)(105586002)(102836004)(6246003)(5660300002)(186003)(256004)(446003)(4326008)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4637;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c+2QiaF/NNthpAOKmQzu0SSfgmY+OzwF4H4kB3y2riYmDLKeKsjXEoNHv4vaCdQ4+bfwI/C0gGD/RaJI01D6BDftOv59rRc0cKeKhbqy/lWjGUXVZ/ceSFYO7awrBhbkU4LTHsvg4S0hzyHdw3SXYKF3+VoGSKnHgzlaKQwiGJN2GnWpQOh0WhCdfpAZrpRXaqOfi5+BF7IIEWMgEEkP4Zx8kMQLb38LuWHBUqVm9NYst/PLHFzEivS7KvwYaAt+lKfa8UgOl/87P6kespX0P5A7T+1/uipLDqu3Mpd9AjK6042A622Vq3LKfbzTGFw02oMEbdvbJdZSmEUw1EUVWQW85XJrP1Q91C05I9uj+5pa8T8fk+LMDDAny5QpySQ3XzQn96lGKG6NGb++tlZPZdOe52s5XprL7PxjHgdwXNY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB5937A17D4050419334FE4DF1818227@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c905391b-6083-48d0-c3d9-08d6c17848c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 07:59:30.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:08:28PM +0000, Ben Davis wrote:
> Add new properties to specify width and height for writeback.
>=20
> Signed-off-by: Ben Davis <ben.davis@arm.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++++++
>  drivers/gpu/drm/drm_writeback.c   | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_connector.h       |  4 ++++
>  include/drm/drm_mode_config.h     | 10 ++++++++++
>  4 files changed, 50 insertions(+)
>=20
> --=20
> 2.7.4
>=20
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index d520a04..1f68dce 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -765,6 +765,10 @@ static int drm_atomic_connector_set_property(struct =
drm_connector *connector,
>  			return -EINVAL;
>  		}
>  		state->content_protection =3D val;
> +	} else if (property =3D=3D config->prop_writeback_w) {
> +		state->writeback_w =3D val;
> +	} else if (property =3D=3D config->prop_writeback_h) {
> +		state->writeback_h =3D val;
>  	} else if (property =3D=3D config->writeback_fb_id_property) {
>  		struct drm_framebuffer *fb =3D drm_framebuffer_lookup(dev, NULL, val);
>  		int ret =3D drm_atomic_set_writeback_fb_for_connector(state, fb);
> @@ -837,6 +841,10 @@ drm_atomic_connector_get_property(struct drm_connect=
or *connector,
>  		*val =3D state->scaling_mode;
>  	} else if (property =3D=3D connector->content_protection_property) {
>  		*val =3D state->content_protection;
> +	} else if (property =3D=3D config->prop_writeback_w) {
> +		*val =3D state->writeback_w;
> +	} else if (property =3D=3D config->prop_writeback_h) {
> +		*val =3D state->writeback_h;
>  	} else if (property =3D=3D config->writeback_fb_id_property) {
>  		/* Writeback framebuffer is one-shot, write and forget */
>  		*val =3D 0;
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeb=
ack.c
> index c20e6fe..3d0453e 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -74,6 +74,12 @@
>   *	applications making use of writeback connectors *always* retrieve an
>   *	out-fence for the commit and use it appropriately.
>   *	From userspace, this property will always read as zero.
> + *
> + *  "WRITEBACK_W":
> + *	The width of the writeback buffer to write back. 0 acts as default.
> + *
> + *  "WRITEBACK_H":
> + *	The height of the writeback buffer to write back. 0 acts as default.
>   */
> =20
>  #define fence_to_wb_connector(x) container_of(x->lock, \
> @@ -141,6 +147,22 @@ static int create_writeback_properties(struct drm_de=
vice *dev)
>  		dev->mode_config.writeback_out_fence_ptr_property =3D prop;
>  	}
> =20
> +	if (!dev->mode_config.prop_writeback_w) {
> +		prop =3D drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_W", 1, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_w =3D prop;
> +	}
> +
> +	if (!dev->mode_config.prop_writeback_h) {
> +		prop =3D drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
> +						 "WRITEBACK_H", 1, UINT_MAX);
> +		if (!prop)
> +			return -ENOMEM;
> +		dev->mode_config.prop_writeback_h =3D prop;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -225,6 +247,12 @@ int drm_writeback_connector_init(struct drm_device *=
dev,
>  	drm_object_attach_property(&connector->base,
>  				   config->writeback_pixel_formats_property,
>  				   blob->base.id);
> +
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_w, 0);
> +	drm_object_attach_property(&connector->base,
> +				   config->prop_writeback_h, 0);

Hi Ben:
Do we real need these two individual properties for specifing the writeback
w/h, can we use fb->w/h ?
And since these two properties are added as common and standard properties,
it influnce all existing write-back implementation which all assumed
writeback size as fb->w/h.
To compatible with existing writeback support, I suggest to keep to
use fb->w/h or add these properties as malidp private.

Thanks
James


>  	wb_connector->pixel_formats_blob_ptr =3D blob;
> =20
>  	return 0;
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8fe22ab..51c4cb2 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -515,6 +515,10 @@ struct drm_connector_state {
>  	 */
>  	struct drm_writeback_job *writeback_job;
> =20
> +	/** @writeback_w: width of plane to write to wb buffer */
> +	/** @writeback_h: height of plane to write to wb buffer */
> +	uint32_t writeback_w, writeback_h;
> +
>  	/**
>  	 * @max_requested_bpc: Connector property to limit the maximum bit
>  	 * depth of the pixels.
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.=
h
> index 7f60e8e..a0c2133 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -622,6 +622,16 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *prop_crtc_h;
>  	/**
> +	 * @prop_writeback_w: Writeback connector property for the plane
> +	 * destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_w;
> +	/**
> +	 * @prop_writeback_h: Writeback connector property for the plane
> +	 * destination position in the writeback buffer.
> +	 */
> +	struct drm_property *prop_writeback_h;
> +	/**
>  	 * @prop_fb_id: Default atomic plane property to specify the
>  	 * &drm_framebuffer.
>  	 */

Pls del this window style line ending=20

