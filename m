Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52828217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpUtjj1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfJ3Ggx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:36:53 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:1407
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfJ3Ggw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5l3f56YlKRMMQykGfCRAulAKAmtyGVoy08jNagHgEkaJgTA90tL6T3n6QNUcKuY9Cy9evfsyIP3OjAaxcQvIlJ8fD2SSZh7xi7rJER5IOGbJt4rrtMS/rmiub/5KmIuBmz69o/FiuCck0YOrID9nX25RtF2s5WNRYzSJLJAprNBFn097+8CLBqQkur5jgy2ADfQ2kLVSK0zH2Ohazg9yz0i5eVCWmh3nmhdvxjI6JZFuyIwJV1+A/RJdx8Ma9LGA+oYr98SUcPG386ge++TrztCdRlXSAZYcWnuiOucP7Kf4SgEaW8SO+P6e4Y9z3LWFSv8iU9Ry4298YZnaEAvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIR6/puCddDfU+GG5Jj1YElq4fXJL0K7yORxdxuJBWc=;
 b=jAtncD1OecwnQgCFGSkZrGo453iyhLCDqY4p4rBlyw8C7FUEJoXvi6cPUz+urtCoxh+SI3Nlma6uzenuhT4xg2rxgmxydiEgSxbK/0+VQV7sV3JgQiqTMt+NuJ5t6r/GVsn2FhUxukRTvsBNoz6GEek8mmBn6SNwQwHiyHCPH0lN5XADtIAl78w1yNTGzbJuktOT56Y5QptLaAHQDWgI8DlBRQy34f928i/dZXRQtj6GAKy56JpTj0bgw4JSVicE9nJpu7dEPNzVqjnUqpOOiUS3uSuycOYHu0Sk1A9egb1gguPfVWF32QMoTVFvkUpcZjEjUYEjriQaRVUSXxKS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIR6/puCddDfU+GG5Jj1YElq4fXJL0K7yORxdxuJBWc=;
 b=bpUtjj1r/Fu+sdUcKpR56CEpxP1uLT7EyeeHYLQWAV/bXQIS4Z9/a1Lhv789FjcU6xGj6sOuNXFD2y+xjMcnV4UKB5xHKwscGPr7wWwcq4IWkhOA/y1QxIBLL7OLtXwsfGZ8rYOHcH9YC9yqejGZ451MAbv3QEs3/I6njkWJTo0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.127.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Wed, 30 Oct 2019 06:36:48 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Wed, 30 Oct 2019
 06:36:48 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected
 to Super-Speed host
Thread-Topic: [PATCH] usb: cdns3: gadget: Fix g_audio use case when connected
 to Super-Speed host
Thread-Index: AQHVjmu0ISNy1ghJZk6ChiNFIxaNSqdyu+kA
Date:   Wed, 30 Oct 2019 06:36:47 +0000
Message-ID: <20191030063636.GE26815@b29397-desktop>
References: <20191029151514.28495-1-rogerq@ti.com>
In-Reply-To: <20191029151514.28495-1-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da0cd372-67ea-40d6-a740-08d75d038a3e
x-ms-traffictypediagnostic: VI1PR04MB5661:
x-microsoft-antispam-prvs: <VI1PR04MB5661EE29D44F0C457AE5617D8B600@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(14444005)(2906002)(25786009)(6116002)(33656002)(8936002)(81166006)(3846002)(54906003)(33716001)(8676002)(81156014)(316002)(71200400001)(256004)(66946007)(66556008)(64756008)(66446008)(76116006)(91956017)(66476007)(14454004)(4326008)(11346002)(66066001)(478600001)(486006)(229853002)(6246003)(1076003)(71190400001)(476003)(6486002)(186003)(6512007)(9686003)(6436002)(76176011)(53546011)(99286004)(6916009)(44832011)(5660300002)(305945005)(86362001)(7736002)(446003)(102836004)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otzobNNspM0zQ8PAdGuntPIVxOmjkdGqdk2F265joqZHiEqbyosvFYdZHu9ATOtwi7dyEmpphH8fdJP2zgGort3npJRfhfI5MPxA5Bn3ej2c70Ihw1xv2kwIKcXeHYhpYGL+Z0Bd/zAVFlSnORNyElRHg5E2rNq55HND0icWK1iCxri69jMY3s6Dj+RbzZWWiOgmvdRRgtxIMQWB8m7JJff/X9nJFVT1kF5H96yCVB3F1+l45fJC7jk+W22uAMCjJuBVwrnEcY8Ku/GnrdtNM1IBRK8587lUQix2XJ7eP7QF0eAVTtrrMRuFQIAwejLxFLB5RHZSbWvJZ7tjGqeO50WKNI3b0lrJg3Uk6GO9SBEoA0MCE9GMmERo5+Vw62M0WQVmBC/gqpPMNQF4nyLoLAaBNaaWN6YY3F0STiY+jIVINh+99pnk6HPQtY2ojBIa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <373EDC61533FB64CB7E12F58BD4B60AD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0cd372-67ea-40d6-a740-08d75d038a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 06:36:48.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk2g1x1lFOpNIasSc4hBaoS7gxjNKRmcUY8clzMPFHI4/xFTjf8khQoalSQ1UeS0Ar/G6zNRcE2w6mtmleogqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-29 17:15:14, Roger Quadros wrote:
> Take into account gadget driver's speed limit when programming
> controller speed.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Hi Greg,
>=20
> Please apply this for -rc.
> Without this, g_audio is broken on cdns3 USB controller is
> connected to a Super-Speed host.
>=20
> cheers,
> -roger
>=20
>  drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 40dad4e8d0dc..1c724c20d468 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_gadge=
t *gadget,
>  {
>  	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
>  	unsigned long flags;
> +	enum usb_device_speed max_speed =3D driver->max_speed;
> =20
>  	spin_lock_irqsave(&priv_dev->lock, flags);
>  	priv_dev->gadget_driver =3D driver;
> +
> +	/* limit speed if necessary */
> +	max_speed =3D min(driver->max_speed, gadget->max_speed);
> +
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_HIGH:
> +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> +		break;
> +	case USB_SPEED_SUPER:
> +		break;
> +	default:
> +		dev_err(priv_dev->dev,
> +			"invalid maximum_speed parameter %d\n",
> +			max_speed);
> +		/* fall through */
> +	case USB_SPEED_UNKNOWN:
> +		/* default to superspeed */
> +		max_speed =3D USB_SPEED_SUPER;
> +		break;
> +	}
> +
>  	cdns3_gadget_config(priv_dev);
>  	spin_unlock_irqrestore(&priv_dev->lock, flags);
>  	return 0;
> @@ -2570,12 +2596,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
>  	/* Check the maximum_speed parameter */
>  	switch (max_speed) {
>  	case USB_SPEED_FULL:
> -		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> -		break;
>  	case USB_SPEED_HIGH:
> -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> -		break;
>  	case USB_SPEED_SUPER:
>  		break;
>  	default:

Just a small comment:

You could delete switch-case at cdns3_gadget_start, and just use
if() statement, eg:

	max_speed =3D usb_get_maximum_speed(cdns->dev);
	if (max_speed =3D=3D USB_SPEED_UNKNOWN)
		max_speed =3D USB_SPEED_SUPER;

Otherwise:

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
