Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B752084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4aeuvuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLDH5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:57:51 -0500
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:10334
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfLDH5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:57:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oddgk5emZ/9rmt2eXAGkggwHlxSjrEzivhHb6Jks3t1B138dzdBX/VDhkVsMjjbvQchtzKm5cPrsNrEnC9xBFrm7vUisGbJet6rEHa1rlT6hYbrk0nCqMmJgWeziPGjSOY1El8JK4tornvHrbCES4dUJ3rWhgpuJyJnJ1sJdLhFjTKLYSS0+vnTzTFQSH2YGBv6BnV1vJ046Q+tsgELL8RiJNcirU2XmwlM2z2s244cDgSHVpzOIBpM44Sz5t/IoApz8Udg2QtkqCkyFatY9/RNbSlHs3rFEKH51IWOBaaVDW7EvW6tQj1TAFzLR7diTvYUwLyKVc9HjsE8vYwleIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNBwfBphWok68qArDfVrKzceyopGvWWaTxHNseMa7fU=;
 b=mbG5rES27Snmhua2K6hxkbr/0Ql9VCKvIJAEmcFM8VpMhhila4j8oNY9MV1WT2vOge8Nfcxpj1t2s4JLHV1EiBQaA/AohQJuqPBgqglO9FV0hIKPElotfETuaKVVNRkUF/ExcJBRxUc4TGB18bB5OOTFEbeSDkz3bQ4S48s6fgqpBMViEs1aPxAlr1kpd9zTk2YsF9lfOaVmfoOaVcFRjcd8pCN0kvSNAOc9kCFL7rikfhPSpm2j516dTcZa07O72oIRXdizPSeDvhS0MDkf4koqSA5mTKUN4pxFbHmLqrFb9GiJTRNwT37aR8DkqOp6DclgcVPf0jSi3xJjthXToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNBwfBphWok68qArDfVrKzceyopGvWWaTxHNseMa7fU=;
 b=S4aeuvuFX/Sb2k5yWPjtoFN1Bje4LS/CTN2d1UfrX7MJWsdUQJ6gaJq3+mKnndAgVHEscJOjsNDtcoFO7mzgho8AzmrDRcVslXH1AqQvMf4RxuOO4RzNPh1uPV4rEVeioaDgELSECsLZTmfFnSwEhrJtl63mSV78ryHMHd1iPZo=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3198.eurprd04.prod.outlook.com (10.170.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 07:57:40 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2516.013; Wed, 4 Dec 2019
 07:57:40 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Jayshri Pawar <jpawar@cadence.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [RFC PATCH] usb:gadget: Fixed issue with config_ep_by_speed
 function.
Thread-Topic: [RFC PATCH] usb:gadget: Fixed issue with config_ep_by_speed
 function.
Thread-Index: AQHVqQDSjpIjKonPh0ifbtrLO8MZGaepnvuA
Date:   Wed, 4 Dec 2019 07:57:40 +0000
Message-ID: <20191204075737.GB25122@b29397-desktop>
References: <1575284847-3388-1-git-send-email-jpawar@cadence.com>
In-Reply-To: <1575284847-3388-1-git-send-email-jpawar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9546a580-7446-45b1-566e-08d7788fa2e5
x-ms-traffictypediagnostic: VI1PR04MB3198:
x-microsoft-antispam-prvs: <VI1PR04MB31983265AA6B2EA4C85EACA48B5D0@VI1PR04MB3198.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(478600001)(6486002)(229853002)(9686003)(14454004)(186003)(44832011)(6436002)(2906002)(26005)(6512007)(6916009)(6116002)(33716001)(102836004)(11346002)(3846002)(6506007)(446003)(53546011)(256004)(99286004)(14444005)(66556008)(64756008)(66446008)(91956017)(76116006)(66946007)(30864003)(8676002)(81156014)(86362001)(71200400001)(71190400001)(4326008)(5660300002)(33656002)(1076003)(8936002)(76176011)(316002)(7416002)(7736002)(25786009)(305945005)(54906003)(66476007)(6246003)(81166006)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3198;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6RBSzb+KCkgxku6s31WkKWSq+Rj8MB2eoMeNXJ7Ao65TW/0M9iumBZzeYSxn/4ZHF1Pt5IgsKuXi+9leaoDg10MTeec7QbHULTNpLbi0fbnkYtFrgQZvGeie5V+a5CzpIKKLoTlQ+uqQ3sbLuOyCZA+ZOuItnVmikgYMJ5loBnnV2EfTcb1eT+t1lH81sbYYKKyMBjehXD9DZA3lXXB9eBhTe4AnyhGBAXs4E7T4iLdqlKUf6BtI36WYQIQHNSSarMBMwzb8go6TcI4KcNpRCSE8XMcofVSNIeKxA1opZv4o3G/F2HZstKTOETEdQM2bLTgHwak02XhVKUYhCccrd18PBmIyBtmeGY4M/8Lu59HihEVoetJB9nDym77u3rV3cHZHENnM1gHTICjLMG/CfanLO/mD//Hxbb4SkSW5ZOEKj7RdxhVvRTBBMzkPCjg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A7BED4A7FA80A40989039E75B033413@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9546a580-7446-45b1-566e-08d7788fa2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:57:40.2830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItKjz17idYuRDhMmdYW3gOutH6IfN1SenmHkIcu7h3ZE3TL9NA7Q/DMu2vnHpQes7+pr/X9uz86WtdBd0yCFhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-02 12:07:27, Jayshri Pawar wrote:
> This patch adds additional parameter alt to config_ep_by_speed function.
> This additional parameter allows to improve this function and
> find proper usb_ss_ep_comp_descriptor.
>=20
> Problem has appeared during testing f_tcm (BOT/UAS) driver function.
>=20
> f_tcm function for SS use array of headers for both  BOT/UAS alternate
> setting:
>=20
> static struct usb_descriptor_header *uasp_ss_function_desc[] =3D {
>         (struct usb_descriptor_header *) &bot_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
>=20
>         (struct usb_descriptor_header *) &uasp_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_status_desc,
>         (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_status_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
>         NULL,
> };
>=20
> The first 5 descriptors are associated with BOT alternate setting,
> and others are associated  with UAS.
>=20
> During handling UAS alternate setting f_tcm drivr invokes
> config_ep_by_speed and this function sets incorrect companion endpoint
> descriptor in usb_ep object.
>=20
> Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
> case set ep->comp_desc to uasp_ss_bi_desc.
>=20
> This is due to the fact that it search endpoint based on endpoint
> address:
>=20
>         for_each_ep_desc(speed_desc, d_spd) {
>                 chosen_desc =3D (struct usb_endpoint_descriptor *)*d_spd;
>                 if (chosen_desc->bEndpoitAddress =3D=3D _ep->address)
>                         goto ep_found;
>         }
>=20
> And in result it uses the descriptor from BOT alternate setting
> instead UAS.
>=20
> Finally, it causes that controller driver during enabling endpoints
> detect that just enabled endpoint is not stream capable.

enabled endpoint for bot.

>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> ---
>  drivers/usb/gadget/composite.c               | 42 ++++++++++++++------
>  drivers/usb/gadget/function/f_acm.c          |  7 ++--
>  drivers/usb/gadget/function/f_ecm.c          |  7 ++--
>  drivers/usb/gadget/function/f_eem.c          |  4 +-
>  drivers/usb/gadget/function/f_fs.c           |  3 +-
>  drivers/usb/gadget/function/f_hid.c          |  4 +-
>  drivers/usb/gadget/function/f_loopback.c     |  2 +-
>  drivers/usb/gadget/function/f_mass_storage.c |  5 ++-
>  drivers/usb/gadget/function/f_midi.c         |  2 +-
>  drivers/usb/gadget/function/f_ncm.c          |  7 ++--
>  drivers/usb/gadget/function/f_obex.c         |  4 +-
>  drivers/usb/gadget/function/f_phonet.c       |  4 +-
>  drivers/usb/gadget/function/f_rndis.c        |  7 ++--
>  drivers/usb/gadget/function/f_serial.c       |  4 +-
>  drivers/usb/gadget/function/f_sourcesink.c   | 11 +++--
>  drivers/usb/gadget/function/f_subset.c       |  4 +-
>  drivers/usb/gadget/function/f_tcm.c          | 12 +++---
>  drivers/usb/gadget/function/f_uac1_legacy.c  |  2 +-
>  drivers/usb/gadget/function/f_uvc.c          |  5 ++-
>  drivers/usb/gadget/function/u_audio.c        |  4 +-
>  include/linux/usb/composite.h                |  2 +-
>  21 files changed, 85 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composit=
e.c
> index bb0c744d5b44..b2ced8a7b591 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -96,33 +96,35 @@ function_descriptors(struct usb_function *f,
>  }
> =20
>  /**
> - * next_ep_desc() - advance to the next EP descriptor
> + * next_for_each_desc_desc() - advance to the next desc_type descriptor

%s/next_for_each_desc_desc/next_desc

>   * @t: currect pointer within descriptor array
> + * @desc_type: descriptor type
>   *
> - * Return: next EP descriptor or NULL
> + * Return: next desc_type descriptor or NULL
>   *
> - * Iterate over @t until either EP descriptor found or
> + * Iterate over @t until either desc_type descriptor found or
>   * NULL (that indicates end of list) encountered
>   */
>  static struct usb_descriptor_header**
> -next_ep_desc(struct usb_descriptor_header **t)
> +next_desc(struct usb_descriptor_header **t, u8 desc_type)
>  {
>  	for (; *t; t++) {
> -		if ((*t)->bDescriptorType =3D=3D USB_DT_ENDPOINT)
> +		if ((*t)->bDescriptorType =3D=3D desc_type)
>  			return t;
>  	}
>  	return NULL;
>  }
> =20
>  /*
> - * for_each_ep_desc()- iterate over endpoint descriptors in the
> + * for_each_desc()- iterate over desc_type descriptors in the
>   *		descriptors list
>   * @start:	pointer within descriptor array.
> - * @ep_desc:	endpoint descriptor to use as the loop cursor
> + * @iter_desc:	desc_type descriptor to use as the loop cursor
> + * @desc_type	wanted descriptr type

Align the comment format please.

>   */
> -#define for_each_ep_desc(start, ep_desc) \
> -	for (ep_desc =3D next_ep_desc(start); \
> -	      ep_desc; ep_desc =3D next_ep_desc(ep_desc+1))
> +#define for_each_desc(start, iter_desc, desc_type) \
> +	for (iter_desc =3D next_desc(start, desc_type); \
> +	      iter_desc; iter_desc =3D next_desc(iter_desc + 1, desc_type))
> =20
>  /**
>   * config_ep_by_speed() - configures the given endpoint
> @@ -144,9 +146,11 @@ next_ep_desc(struct usb_descriptor_header **t)
>   */

You may update the kernel doc accordingly.
And u8 is ok for the parameter 'alt'.

>  int config_ep_by_speed(struct usb_gadget *g,
>  			struct usb_function *f,
> -			struct usb_ep *_ep)
> +			struct usb_ep *_ep,
> +			unsigned alt)
>  {
>  	struct usb_endpoint_descriptor *chosen_desc =3D NULL;
> +	struct usb_interface_descriptor *int_desc =3D NULL;
>  	struct usb_descriptor_header **speed_desc =3D NULL;
> =20
>  	struct usb_ss_ep_comp_descriptor *comp_desc =3D NULL;
> @@ -182,9 +186,23 @@ int config_ep_by_speed(struct usb_gadget *g,
>  	default:
>  		speed_desc =3D f->fs_descriptors;
>  	}
> +
> +	/* find correct alternate setting descriptor */
> +	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
> +		int_desc =3D (struct usb_interface_descriptor *)*d_spd;
> +
> +		if (int_desc->bAlternateSetting =3D=3D alt) {
> +			speed_desc =3D d_spd;
> +			goto intf_found;
> +		}
> +	}
> +	return -EIO;
> +
> +intf_found:
>  	/* find descriptors */
> -	for_each_ep_desc(speed_desc, d_spd) {
> +	for_each_desc(speed_desc, d_spd, USB_DT_ENDPOINT) {
>  		chosen_desc =3D (struct usb_endpoint_descriptor *)*d_spd;
> +

Blank line is not needed.

Peter

>  		if (chosen_desc->bEndpointAddress =3D=3D _ep->address)
>  			goto ep_found;
>  	}
> diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/fun=
ction/f_acm.c
> index 7c152c28b26c..0be4a07f1624 100644
> --- a/drivers/usb/gadget/function/f_acm.c
> +++ b/drivers/usb/gadget/function/f_acm.c
> @@ -430,7 +430,8 @@ static int acm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  		usb_ep_disable(acm->notify);
> =20
>  		if (!acm->notify->desc)
> -			if (config_ep_by_speed(cdev->gadget, f, acm->notify))
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       acm->notify, alt))
>  				return -EINVAL;
> =20
>  		usb_ep_enable(acm->notify);
> @@ -445,9 +446,9 @@ static int acm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  			dev_dbg(&cdev->gadget->dev,
>  				"activate acm ttyGS%d\n", acm->port_num);
>  			if (config_ep_by_speed(cdev->gadget, f,
> -					       acm->port.in) ||
> +					       acm->port.in, alt) ||
>  			    config_ep_by_speed(cdev->gadget, f,
> -					       acm->port.out)) {
> +					       acm->port.out, alt)) {
>  				acm->port.in->desc =3D NULL;
>  				acm->port.out->desc =3D NULL;
>  				return -EINVAL;
> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/fun=
ction/f_ecm.c
> index 6ce044008cf6..6ff82bd8b921 100644
> --- a/drivers/usb/gadget/function/f_ecm.c
> +++ b/drivers/usb/gadget/function/f_ecm.c
> @@ -541,7 +541,8 @@ static int ecm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  		usb_ep_disable(ecm->notify);
>  		if (!(ecm->notify->desc)) {
>  			VDBG(cdev, "init ecm ctrl %d\n", intf);
> -			if (config_ep_by_speed(cdev->gadget, f, ecm->notify))
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       ecm->notify, alt))
>  				goto fail;
>  		}
>  		usb_ep_enable(ecm->notify);
> @@ -560,9 +561,9 @@ static int ecm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  		    !ecm->port.out_ep->desc) {
>  			DBG(cdev, "init ecm\n");
>  			if (config_ep_by_speed(cdev->gadget, f,
> -					       ecm->port.in_ep) ||
> +					       ecm->port.in_ep, alt) ||
>  			    config_ep_by_speed(cdev->gadget, f,
> -					       ecm->port.out_ep)) {
> +					       ecm->port.out_ep, alt)) {
>  				ecm->port.in_ep->desc =3D NULL;
>  				ecm->port.out_ep->desc =3D NULL;
>  				goto fail;
> diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/fun=
ction/f_eem.c
> index b81a91d504bd..2cfb1ceb45f1 100644
> --- a/drivers/usb/gadget/function/f_eem.c
> +++ b/drivers/usb/gadget/function/f_eem.c
> @@ -196,9 +196,9 @@ static int eem_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  		if (!eem->port.in_ep->desc || !eem->port.out_ep->desc) {
>  			DBG(cdev, "init eem\n");
>  			if (config_ep_by_speed(cdev->gadget, f,
> -					       eem->port.in_ep) ||
> +					       eem->port.in_ep, alt) ||
>  			    config_ep_by_speed(cdev->gadget, f,
> -					       eem->port.out_ep)) {
> +					       eem->port.out_ep, alt)) {
>  				eem->port.in_ep->desc =3D NULL;
>  				eem->port.out_ep->desc =3D NULL;
>  				goto fail;
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/func=
tion/f_fs.c
> index 59d9d512dcda..0dcbc44298a9 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1963,7 +1963,8 @@ static int ffs_func_eps_enable(struct ffs_function =
*func)
>  	while(count--) {
>  		ep->ep->driver_data =3D ep;
> =20
> -		ret =3D config_ep_by_speed(func->gadget, &func->function, ep->ep);
> +		ret =3D config_ep_by_speed(func->gadget, &func->function,
> +					 ep->ep, 0);
>  		if (ret) {
>  			pr_err("%s: config_ep_by_speed(%s) returned %d\n",
>  					__func__, ep->ep->name, ret);
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/fun=
ction/f_hid.c
> index f3816a5c861e..9cbf622dc33c 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -647,7 +647,7 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>  		usb_ep_disable(hidg->in_ep);
> =20
>  		status =3D config_ep_by_speed(f->config->cdev->gadget, f,
> -					    hidg->in_ep);
> +					    hidg->in_ep, alt);
>  		if (status) {
>  			ERROR(cdev, "config_ep_by_speed FAILED!\n");
>  			goto fail;
> @@ -672,7 +672,7 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>  		usb_ep_disable(hidg->out_ep);
> =20
>  		status =3D config_ep_by_speed(f->config->cdev->gadget, f,
> -					    hidg->out_ep);
> +					    hidg->out_ep, alt);
>  		if (status) {
>  			ERROR(cdev, "config_ep_by_speed FAILED!\n");
>  			goto free_req_in;
> diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadge=
t/function/f_loopback.c
> index 1803646b3678..6ff45212bf8e 100644
> --- a/drivers/usb/gadget/function/f_loopback.c
> +++ b/drivers/usb/gadget/function/f_loopback.c
> @@ -362,7 +362,7 @@ static int enable_endpoint(struct usb_composite_dev *=
cdev,
>  {
>  	int					result;
> =20
> -	result =3D config_ep_by_speed(cdev->gadget, &(loop->function), ep);
> +	result =3D config_ep_by_speed(cdev->gadget, &loop->function, ep, 0);
>  	if (result)
>  		goto out;
> =20
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/g=
adget/function/f_mass_storage.c
> index 7c96c4665178..9aa9fd4e4785 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2241,7 +2241,8 @@ static int do_set_interface(struct fsg_common *comm=
on, struct fsg_dev *new_fsg)
>  	fsg =3D common->fsg;
> =20
>  	/* Enable the endpoints */
> -	rc =3D config_ep_by_speed(common->gadget, &(fsg->function), fsg->bulk_i=
n);
> +	rc =3D config_ep_by_speed(common->gadget, &fsg->function,
> +				fsg->bulk_in, 0);
>  	if (rc)
>  		goto reset;
>  	rc =3D usb_ep_enable(fsg->bulk_in);
> @@ -2251,7 +2252,7 @@ static int do_set_interface(struct fsg_common *comm=
on, struct fsg_dev *new_fsg)
>  	fsg->bulk_in_enabled =3D 1;
> =20
>  	rc =3D config_ep_by_speed(common->gadget, &(fsg->function),
> -				fsg->bulk_out);
> +				fsg->bulk_out, 0);
>  	if (rc)
>  		goto reset;
>  	rc =3D usb_ep_enable(fsg->bulk_out);
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/fu=
nction/f_midi.c
> index 46af0aa07e2e..f371ef38a251 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -343,7 +343,7 @@ static int f_midi_start_ep(struct f_midi *midi,
> =20
>  	usb_ep_disable(ep);
> =20
> -	err =3D config_ep_by_speed(midi->gadget, f, ep);
> +	err =3D config_ep_by_speed(midi->gadget, f, ep, 0);
>  	if (err) {
>  		ERROR(cdev, "can't configure %s: %d\n", ep->name, err);
>  		return err;
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index 2d6e76e4cffa..168412be9964 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -872,7 +872,8 @@ static int ncm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
> =20
>  		if (!(ncm->notify->desc)) {
>  			DBG(cdev, "init ncm ctrl %d\n", intf);
> -			if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       ncm->notify, alt))
>  				goto fail;
>  		}
>  		usb_ep_enable(ncm->notify);
> @@ -901,9 +902,9 @@ static int ncm_set_alt(struct usb_function *f, unsign=
ed intf, unsigned alt)
>  			    !ncm->port.out_ep->desc) {
>  				DBG(cdev, "init ncm\n");
>  				if (config_ep_by_speed(cdev->gadget, f,
> -						       ncm->port.in_ep) ||
> +						       ncm->port.in_ep, alt) ||
>  				    config_ep_by_speed(cdev->gadget, f,
> -						       ncm->port.out_ep)) {
> +						       ncm->port.out_ep, alt)) {
>  					ncm->port.in_ep->desc =3D NULL;
>  					ncm->port.out_ep->desc =3D NULL;
>  					goto fail;
> diff --git a/drivers/usb/gadget/function/f_obex.c b/drivers/usb/gadget/fu=
nction/f_obex.c
> index ab26d84ed95e..bacceced3bba 100644
> --- a/drivers/usb/gadget/function/f_obex.c
> +++ b/drivers/usb/gadget/function/f_obex.c
> @@ -212,9 +212,9 @@ static int obex_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>  			dev_dbg(&cdev->gadget->dev,
>  				"init obex ttyGS%d\n", obex->port_num);
>  			if (config_ep_by_speed(cdev->gadget, f,
> -					       obex->port.in) ||
> +					       obex->port.in, alt) ||
>  			    config_ep_by_speed(cdev->gadget, f,
> -					       obex->port.out)) {
> +					       obex->port.out, alt)) {
>  				obex->port.out->desc =3D NULL;
>  				obex->port.in->desc =3D NULL;
>  				goto fail;
> diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/=
function/f_phonet.c
> index 8b72b192c747..e1f04447c6da 100644
> --- a/drivers/usb/gadget/function/f_phonet.c
> +++ b/drivers/usb/gadget/function/f_phonet.c
> @@ -416,8 +416,8 @@ static int pn_set_alt(struct usb_function *f, unsigne=
d intf, unsigned alt)
>  		if (alt =3D=3D 1) {
>  			int i;
> =20
> -			if (config_ep_by_speed(gadget, f, fp->in_ep) ||
> -			    config_ep_by_speed(gadget, f, fp->out_ep)) {
> +			if (config_ep_by_speed(gadget, f, fp->in_ep, alt) ||
> +			    config_ep_by_speed(gadget, f, fp->out_ep, alt)) {
>  				fp->in_ep->desc =3D NULL;
>  				fp->out_ep->desc =3D NULL;
>  				spin_unlock(&port->lock);
> diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/f=
unction/f_rndis.c
> index d48df36622b7..1d3497bcb808 100644
> --- a/drivers/usb/gadget/function/f_rndis.c
> +++ b/drivers/usb/gadget/function/f_rndis.c
> @@ -547,7 +547,8 @@ static int rndis_set_alt(struct usb_function *f, unsi=
gned intf, unsigned alt)
> =20
>  		if (!rndis->notify->desc) {
>  			VDBG(cdev, "init rndis ctrl %d\n", intf);
> -			if (config_ep_by_speed(cdev->gadget, f, rndis->notify))
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       rndis->notify, alt))
>  				goto fail;
>  		}
>  		usb_ep_enable(rndis->notify);
> @@ -563,9 +564,9 @@ static int rndis_set_alt(struct usb_function *f, unsi=
gned intf, unsigned alt)
>  		if (!rndis->port.in_ep->desc || !rndis->port.out_ep->desc) {
>  			DBG(cdev, "init rndis\n");
>  			if (config_ep_by_speed(cdev->gadget, f,
> -					       rndis->port.in_ep) ||
> +					       rndis->port.in_ep, alt) ||
>  			    config_ep_by_speed(cdev->gadget, f,
> -					       rndis->port.out_ep)) {
> +					       rndis->port.out_ep, alt)) {
>  				rndis->port.in_ep->desc =3D NULL;
>  				rndis->port.out_ep->desc =3D NULL;
>  				goto fail;
> diff --git a/drivers/usb/gadget/function/f_serial.c b/drivers/usb/gadget/=
function/f_serial.c
> index 1406255d0865..784455c57dd5 100644
> --- a/drivers/usb/gadget/function/f_serial.c
> +++ b/drivers/usb/gadget/function/f_serial.c
> @@ -158,8 +158,8 @@ static int gser_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>  	if (!gser->port.in->desc || !gser->port.out->desc) {
>  		dev_dbg(&cdev->gadget->dev,
>  			"activate generic ttyGS%d\n", gser->port_num);
> -		if (config_ep_by_speed(cdev->gadget, f, gser->port.in) ||
> -		    config_ep_by_speed(cdev->gadget, f, gser->port.out)) {
> +		if (config_ep_by_speed(cdev->gadget, f, gser->port.in, alt) ||
> +		    config_ep_by_speed(cdev->gadget, f, gser->port.out, alt)) {
>  			gser->port.in->desc =3D NULL;
>  			gser->port.out->desc =3D NULL;
>  			return -EINVAL;
> diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gad=
get/function/f_sourcesink.c
> index ed68a4860b7d..86124149de7d 100644
> --- a/drivers/usb/gadget/function/f_sourcesink.c
> +++ b/drivers/usb/gadget/function/f_sourcesink.c
> @@ -650,7 +650,8 @@ enable_source_sink(struct usb_composite_dev *cdev, st=
ruct f_sourcesink *ss,
> =20
>  	/* one bulk endpoint writes (sources) zeroes IN (to the host) */
>  	ep =3D ss->in_ep;
> -	result =3D config_ep_by_speed(cdev->gadget, &(ss->function), ep);
> +	result =3D config_ep_by_speed(cdev->gadget, &ss->function,
> +				    ep, alt);
>  	if (result)
>  		return result;
>  	result =3D usb_ep_enable(ep);
> @@ -668,7 +669,7 @@ enable_source_sink(struct usb_composite_dev *cdev, st=
ruct f_sourcesink *ss,
> =20
>  	/* one bulk endpoint reads (sinks) anything OUT (from the host) */
>  	ep =3D ss->out_ep;
> -	result =3D config_ep_by_speed(cdev->gadget, &(ss->function), ep);
> +	result =3D config_ep_by_speed(cdev->gadget, &ss->function, ep, alt);
>  	if (result)
>  		goto fail;
>  	result =3D usb_ep_enable(ep);
> @@ -690,7 +691,8 @@ enable_source_sink(struct usb_composite_dev *cdev, st=
ruct f_sourcesink *ss,
>  	/* one iso endpoint writes (sources) zeroes IN (to the host) */
>  	ep =3D ss->iso_in_ep;
>  	if (ep) {
> -		result =3D config_ep_by_speed(cdev->gadget, &(ss->function), ep);
> +		result =3D config_ep_by_speed(cdev->gadget, &ss->function,
> +					    ep, alt);
>  		if (result)
>  			goto fail2;
>  		result =3D usb_ep_enable(ep);
> @@ -711,7 +713,8 @@ enable_source_sink(struct usb_composite_dev *cdev, st=
ruct f_sourcesink *ss,
>  	/* one iso endpoint reads (sinks) anything OUT (from the host) */
>  	ep =3D ss->iso_out_ep;
>  	if (ep) {
> -		result =3D config_ep_by_speed(cdev->gadget, &(ss->function), ep);
> +		result =3D config_ep_by_speed(cdev->gadget, &ss->function,
> +					    ep, alt);
>  		if (result)
>  			goto fail3;
>  		result =3D usb_ep_enable(ep);
> diff --git a/drivers/usb/gadget/function/f_subset.c b/drivers/usb/gadget/=
function/f_subset.c
> index 4d945254905d..5362ae567f6c 100644
> --- a/drivers/usb/gadget/function/f_subset.c
> +++ b/drivers/usb/gadget/function/f_subset.c
> @@ -264,8 +264,8 @@ static int geth_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>  	}
> =20
>  	DBG(cdev, "init + activate cdc subset\n");
> -	if (config_ep_by_speed(cdev->gadget, f, geth->port.in_ep) ||
> -	    config_ep_by_speed(cdev->gadget, f, geth->port.out_ep)) {
> +	if (config_ep_by_speed(cdev->gadget, f, geth->port.in_ep, alt) ||
> +	    config_ep_by_speed(cdev->gadget, f, geth->port.out_ep, alt)) {
>  		geth->port.in_ep->desc =3D NULL;
>  		geth->port.out_ep->desc =3D NULL;
>  		return -EINVAL;
> diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/fun=
ction/f_tcm.c
> index 36504931b2d1..0d9fa4637414 100644
> --- a/drivers/usb/gadget/function/f_tcm.c
> +++ b/drivers/usb/gadget/function/f_tcm.c
> @@ -392,12 +392,12 @@ static void bot_set_alt(struct f_uas *fu)
> =20
>  	fu->flags =3D USBG_IS_BOT;
> =20
> -	config_ep_by_speed(gadget, f, fu->ep_in);
> +	config_ep_by_speed(gadget, f, fu->ep_in, USB_G_ALT_INT_BBB);
>  	ret =3D usb_ep_enable(fu->ep_in);
>  	if (ret)
>  		goto err_b_in;
> =20
> -	config_ep_by_speed(gadget, f, fu->ep_out);
> +	config_ep_by_speed(gadget, f, fu->ep_out, USB_G_ALT_INT_BBB);
>  	ret =3D usb_ep_enable(fu->ep_out);
>  	if (ret)
>  		goto err_b_out;
> @@ -849,21 +849,21 @@ static void uasp_set_alt(struct f_uas *fu)
>  	if (gadget->speed >=3D USB_SPEED_SUPER)
>  		fu->flags |=3D USBG_USE_STREAMS;
> =20
> -	config_ep_by_speed(gadget, f, fu->ep_in);
> +	config_ep_by_speed(gadget, f, fu->ep_in, USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_in);
>  	if (ret)
>  		goto err_b_in;
> =20
> -	config_ep_by_speed(gadget, f, fu->ep_out);
> +	config_ep_by_speed(gadget, f, fu->ep_out, USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_out);
>  	if (ret)
>  		goto err_b_out;
> =20
> -	config_ep_by_speed(gadget, f, fu->ep_cmd);
> +	config_ep_by_speed(gadget, f, fu->ep_cmd, USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_cmd);
>  	if (ret)
>  		goto err_cmd;
> -	config_ep_by_speed(gadget, f, fu->ep_status);
> +	config_ep_by_speed(gadget, f, fu->ep_status, USB_G_ALT_INT_UAS);
>  	ret =3D usb_ep_enable(fu->ep_status);
>  	if (ret)
>  		goto err_status;
> diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/ga=
dget/function/f_uac1_legacy.c
> index 6677ae932de0..3db9ae71a452 100644
> --- a/drivers/usb/gadget/function/f_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/f_uac1_legacy.c
> @@ -601,7 +601,7 @@ static int f_audio_set_alt(struct usb_function *f, un=
signed intf, unsigned alt)
>  		return 0;
>  	} else if (intf =3D=3D audio->as_intf) {
>  		if (alt =3D=3D 1) {
> -			err =3D config_ep_by_speed(cdev->gadget, f, out_ep);
> +			err =3D config_ep_by_speed(cdev->gadget, f, out_ep, alt);
>  			if (err)
>  				return err;
> =20
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/fun=
ction/f_uvc.c
> index fb0a892687c0..7d4a479baebb 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -290,7 +290,8 @@ uvc_function_set_alt(struct usb_function *f, unsigned=
 interface, unsigned alt)
>  		usb_ep_disable(uvc->control_ep);
> =20
>  		if (!uvc->control_ep->desc)
> -			if (config_ep_by_speed(cdev->gadget, f, uvc->control_ep))
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       uvc->control_ep, alt))
>  				return -EINVAL;
> =20
>  		usb_ep_enable(uvc->control_ep);
> @@ -341,7 +342,7 @@ uvc_function_set_alt(struct usb_function *f, unsigned=
 interface, unsigned alt)
>  		usb_ep_disable(uvc->video.ep);
> =20
>  		ret =3D config_ep_by_speed(f->config->cdev->gadget,
> -				&(uvc->func), uvc->video.ep);
> +					&uvc->func, uvc->video.ep, alt);
>  		if (ret)
>  			return ret;
>  		usb_ep_enable(uvc->video.ep);
> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/f=
unction/u_audio.c
> index 56906d15fb55..37a0817707d7 100644
> --- a/drivers/usb/gadget/function/u_audio.c
> +++ b/drivers/usb/gadget/function/u_audio.c
> @@ -375,7 +375,7 @@ int u_audio_start_capture(struct g_audio *audio_dev)
> =20
>  	ep =3D audio_dev->out_ep;
>  	prm =3D &uac->c_prm;
> -	config_ep_by_speed(gadget, &audio_dev->func, ep);
> +	config_ep_by_speed(gadget, &audio_dev->func, ep, 0);
>  	req_len =3D prm->max_psize;
> =20
>  	prm->ep_enabled =3D true;
> @@ -428,7 +428,7 @@ int u_audio_start_playback(struct g_audio *audio_dev)
> =20
>  	ep =3D audio_dev->in_ep;
>  	prm =3D &uac->p_prm;
> -	config_ep_by_speed(gadget, &audio_dev->func, ep);
> +	config_ep_by_speed(gadget, &audio_dev->func, ep, 0);
> =20
>  	ep_desc =3D ep->desc;
> =20
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.=
h
> index 8675e145ea8b..f2374a9c5a12 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -250,7 +250,7 @@ int usb_function_activate(struct usb_function *);
>  int usb_interface_id(struct usb_configuration *, struct usb_function *);
> =20
>  int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
> -			struct usb_ep *_ep);
> +			struct usb_ep *_ep, unsigned alt);
> =20
>  #define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
> =20
> --=20
> 2.20.1
>=20

--=20

Thanks,
Peter Chen=
