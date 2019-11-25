Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E027C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 04:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9A320815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 04:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qx4oxid4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfKYEUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:20:47 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:65423
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfKYEUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 23:20:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAomdFpg7LGQvwRUGGv3gHno5EA5Pp38Da0sngNkBmpxDeTwdkVlXtoCSp0y1iiuth/mhDOcpaMWJ72RfnPFIyQrBZcHA6DflIGmP6KkFnXLw7QKdMVeeepPwl7hGJL/XWsCsnjpkbUi+wo9r7VMpLQhT5j5OFr0XeuaWxz7k4sY0KSxyTySEmnobZV381iecDjz/+eKPumq0hTmq20iJDYctnb7idbr54AB/XcZs6Mj0eCoEahW9L+DP0rHWw2Eq1whOcbsLh768tBmUkdy6shfstymE8wIeQQOAlxEqaPMrp8Gh8FCl+mXWlGUZN356YvvjdLS4yR9HCUDPN9RcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opkWY90ZME6YU5qDnpBVlkuhn/A8phiAeae6EWKgQ1s=;
 b=egMj/KwFk969AHortMbVJAZAJsvqCRb6xtqJyKrZL+Y8kvV31sW/Slu5+iNSPmaHpLS+WIxEvwdgTS8SMu5jFeH0vZ9d7eggS4x4Hvn2GyJMMpFMerdSQ/xkxfWYXayJEpkpNMUiqQETkCCDr6UEUSZ4Jjq8zzTTrhBx35s22Cnm8rMXuS69E3NWt1QqiYgSFIk994ieHpvz6nlTmrxmgOJeKzyI3GptSkg+yt49yekg2f6EA07B6MhIsV0Zm41EQYNIMsnTXCfUTIRXMxDC5Pktx98clz5lZHHdkggS90eugtqRzclc1DEwtALKt227jMLOyBkB+IJqSg0kTVa6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opkWY90ZME6YU5qDnpBVlkuhn/A8phiAeae6EWKgQ1s=;
 b=qx4oxid4V35G1aXKZJQCnjAnDWwwuE7xfzqL1ukqY31I3l43kX2dK5lIHS8+6grXrKn55l3jvvg8UH/+AIXfuq/4CaGX/JXqMsdqYnGBF9XH6acySdylUqeELa0o2BVlQGvjrt6NZ1JwS+qQRE8RE7DojubH+7Irn2nhqnMv5fk=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4061.eurprd04.prod.outlook.com (10.171.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 04:20:42 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 04:20:42 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Henry Lin <henryl@nvidia.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLqKGYVyVjGs0eFFEwrEIcffKebTxyA
Date:   Mon, 25 Nov 2019 04:20:42 +0000
Message-ID: <20191125042039.GA10953@b29397-desktop>
References: <20191121041858.15746-1-henryl@nvidia.com>
In-Reply-To: <20191121041858.15746-1-henryl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cee1ef73-0916-4f5b-f283-08d7715ed5ae
x-ms-traffictypediagnostic: VI1PR04MB4061:
x-microsoft-antispam-prvs: <VI1PR04MB4061B83F1EF9156BA0D8F1F48B4A0@VI1PR04MB4061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(71190400001)(6116002)(33656002)(3846002)(7736002)(71200400001)(229853002)(305945005)(81166006)(81156014)(8936002)(478600001)(6916009)(14454004)(2906002)(8676002)(5660300002)(26005)(1076003)(6506007)(53546011)(86362001)(102836004)(6246003)(66066001)(25786009)(316002)(6512007)(186003)(76116006)(99286004)(66446008)(66946007)(66476007)(66556008)(64756008)(33716001)(76176011)(44832011)(4326008)(446003)(11346002)(256004)(6436002)(54906003)(9686003)(6486002)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4061;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WOKQpCMeMT701tODKfRyOuZoSfY6Tn5wineIpMS8rmfQqsrT+OHl2r8OHwaEcCX13MQ9QI8vOa2RaGp/3j5hj+YtrRfYzxAZt22XX3preXZPs+fZtGOurEiMH/sRYnZWWH0ipD+0vP7CLKVOJXSUxH+Jncxs9ohxfh4PIdsbIXMV5Puh/+ZfVkFYtPLwKD7NaYoS9YL9AaS7Sv0VnJB3bBpaOqMvMtN5w5VzdScv1A+/T50XBdOBzs1II9WgXmRZ8cjHTcz9Aj82a2OW+JBI/Vds644lj2qoaZzKaJBNJbRAUVa/iD+W5pFlg65wfJfA0vYeqTc0EUOTVVVl4/G0KudEW7qgYWBSot0CkDFa19+EdiMH/MTzMtoClym4zX0Y7bP/OFnsPJkG5M+b5zRIPJ1zG9znR/nNT3ejMhDcuOps63T0KSrgASuo3YKC99I
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A862E450F1C70248B7A53919C1AC6362@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee1ef73-0916-4f5b-f283-08d7715ed5ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 04:20:42.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qV6xQgLbN33VXn70+AkjTrlKsqyTqbzc56m9Y3YRwWm4/2FaJZlLsITZSjizEb4UAEVaS40kkmMusL9ILzgv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-21 12:18:57, Henry Lin wrote:
> Gadget driver should always use config_ep_by_speed() to initialize
> usb_ep struct according to usb device's operating speed. Otherwise,
> usb_ep struct may be wrong if usb devcie's operating speed is changed.
>=20

Would you please share the use case how to reproduce it?

Peter
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index 2d6e76e4cffa..420b9c96f2fe 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -870,11 +870,10 @@ static int ncm_set_alt(struct usb_function *f, unsi=
gned intf, unsigned alt)
>  		DBG(cdev, "reset ncm control %d\n", intf);
>  		usb_ep_disable(ncm->notify);
> =20
> -		if (!(ncm->notify->desc)) {
> -			DBG(cdev, "init ncm ctrl %d\n", intf);
> -			if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
> -				goto fail;
> -		}
> +		DBG(cdev, "init ncm ctrl %d\n", intf);
> +		if (config_ep_by_speed(cdev->gadget, f, ncm->notify))
> +			goto fail;
> +
>  		usb_ep_enable(ncm->notify);
> =20
>  	/* Data interface has two altsettings, 0 and 1 */
> @@ -897,17 +896,14 @@ static int ncm_set_alt(struct usb_function *f, unsi=
gned intf, unsigned alt)
>  		if (alt =3D=3D 1) {
>  			struct net_device	*net;
> =20
> -			if (!ncm->port.in_ep->desc ||
> -			    !ncm->port.out_ep->desc) {
> -				DBG(cdev, "init ncm\n");
> -				if (config_ep_by_speed(cdev->gadget, f,
> -						       ncm->port.in_ep) ||
> -				    config_ep_by_speed(cdev->gadget, f,
> -						       ncm->port.out_ep)) {
> -					ncm->port.in_ep->desc =3D NULL;
> -					ncm->port.out_ep->desc =3D NULL;
> -					goto fail;
> -				}
> +			DBG(cdev, "init ncm\n");
> +			if (config_ep_by_speed(cdev->gadget, f,
> +					       ncm->port.in_ep) ||
> +			    config_ep_by_speed(cdev->gadget, f,
> +					       ncm->port.out_ep)) {
> +				ncm->port.in_ep->desc =3D NULL;
> +				ncm->port.out_ep->desc =3D NULL;
> +				goto fail;
>  			}
> =20
>  			/* TODO */
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
