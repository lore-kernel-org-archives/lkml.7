Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D17CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D945218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkgY6VB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfJ3I4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:56:23 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:16031
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfJ3I4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVMV/GeILdlW6qt69PbT+Anem+wbNNGQl7l3/PB08MmcaQGzG1HCuKVmdsMWLt0bhxz9LgHg5xGgv0pvCIhsnLtyHbrJBTDdmxuEV1adPjvsI4QVz592WIp3m1lLdJAVuecAqyHtejK+ib9+9JqJ/8wuoTOLPlWSbiDkTeNC1WNz7LZQk2vR+TWdaoefV95iqU7W4UcWXGZ+ukU0dlHpjrKwsF7dhHJ7KSqOi18aq+3WoDHKGc5rTgda4ECeYWrWr6G7BX88bP1z34jteXI4pr8TDONkpsldOEkNTUfx9LI3j/cOhI6ss4igLVU0VQcNrHyTHcIIcVUYNZoTkFrs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5sgLmUzdv+odArpVE69TZfKBkYg/LWobGzinrRAVc0=;
 b=eBZGqJO2os765+QnkmyjroYp9lzshYfE43nx/f5zBDL/M9Y4qsZAHuvoeCzWMZwpH+5lZnGsctTZMJ1HiPy0+Dl9FHwMpYosKoOKyiEQ3y6ud4b3eslKnWic8iy2dUo1ERS4eg8AfAFExW2qjv9seohYeTzr3YCBR5VmxexQsG+ZIBYwUUnPznUMXs9SGkM1nRxpBEsWdwPdbSK3NktNZKxccH4dwldwApHIIOI/XGM5MIDHe22bxLWKrI8KLX9qqxMQ5BzKUv6Ll5weQpdvIcLgfse7z2OdpFCYlbmOpxx6XdjUNDPkI6bqFeKQhqc/gfbop78UfJpHJeTLZdtxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5sgLmUzdv+odArpVE69TZfKBkYg/LWobGzinrRAVc0=;
 b=fkgY6VB14q6seopq3Fsh43/p6qnHMBeCI2wKhsrwFXIcytNSZXc8+mwCJxzxEi/hAS7ZQDqVIP4qgXbM0924Wg7DVbBuE3ogAiCI0iBrGnGXXlE2W0I4KVzID28kqnOLVzkwZFN85dfeSo8wYzJZZG3LaaopuW/m/wsFwAE9rl8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5824.eurprd04.prod.outlook.com (20.178.204.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 08:56:19 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Wed, 30 Oct 2019
 08:56:19 +0000
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
Thread-Index: AQHVjmu0ISNy1ghJZk6ChiNFIxaNSqdyu+kAgAAjpACAAANYAA==
Date:   Wed, 30 Oct 2019 08:56:19 +0000
Message-ID: <20191030085608.GA11664@b29397-desktop>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030063636.GE26815@b29397-desktop>
 <b780ffea-dca0-310e-1d66-4ceca380b4ee@ti.com>
In-Reply-To: <b780ffea-dca0-310e-1d66-4ceca380b4ee@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7261180-1ef7-4821-4674-08d75d1707e6
x-ms-traffictypediagnostic: VI1PR04MB5824:
x-microsoft-antispam-prvs: <VI1PR04MB582433809FD3EF00BB4DDCDF8B600@VI1PR04MB5824.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(43544003)(189003)(199004)(44832011)(66066001)(14444005)(86362001)(256004)(6916009)(14454004)(446003)(6512007)(186003)(6486002)(8676002)(3846002)(76176011)(229853002)(476003)(7736002)(6246003)(486006)(8936002)(6116002)(81166006)(4326008)(102836004)(81156014)(6436002)(9686003)(305945005)(25786009)(64756008)(54906003)(66476007)(26005)(66556008)(99286004)(11346002)(66446008)(33716001)(71190400001)(6506007)(5660300002)(53546011)(1076003)(76116006)(71200400001)(478600001)(91956017)(2906002)(33656002)(66946007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5824;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7mAYdJhpCVr6YvUNMT1uhlAQneTKg8J0b5WkAtXVsCPs+GyLo49JKlJDouzHNhPYSt5lv6hY9UxyUGR8mXyhDg8fcIG0Ew6Uxs4Y2Ij+i92u3OpW53F4P2Purm0DiX5TUoZAbRedXYV+kOBEL5NZAgRNRTFaX+sb9Mc7YmCr6kRkmxj2y4q51fCR8tdmWUmnJI2Q3mytvC+e1oI3kihpc5ddhgNfIP0K4EPr0SDa4WS2dr9WShOlINwjkeEZFTvr0ejusBoFPy3e4OqEwmFp38wA6ZQTmJz5jmcE60+e1mao9AnOyEmOCuFz1gpj2A+RnojU6rcTRtsfrifYUcYZVBebU2CeH/e9g3pPdyNkeFQvZPS6FoRYTnxXrau5ef664qEMXak1p4aK/STPQ1LX5M5HRmYi29DMtfbuFwhhNcP3H7UXnjb35oSTG2qg0hq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49ED2D1C0BBB7B48A45C798F05788BA6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7261180-1ef7-4821-4674-08d75d1707e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 08:56:19.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zN/iuEx2Pyzp7wXye7o0hjcdeeqyjhb1pOGXPqZ8mtIE67Z5iKvRZ+u6k0lmoaEDjExtmVD3vSbHnyz/d+6t4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-30 10:44:10, Roger Quadros wrote:
>=20
>=20
> On 30/10/2019 08:36, Peter Chen wrote:
> > On 19-10-29 17:15:14, Roger Quadros wrote:
> > > Take into account gadget driver's speed limit when programming
> > > controller speed.
> > >=20
> > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > ---
> > > Hi Greg,
> > >=20
> > > Please apply this for -rc.
> > > Without this, g_audio is broken on cdns3 USB controller is
> > > connected to a Super-Speed host.
> > >=20
> > > cheers,
> > > -roger
> > >=20
> > >   drivers/usb/cdns3/gadget.c | 31 ++++++++++++++++++++++++++-----
> > >   1 file changed, 26 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> > > index 40dad4e8d0dc..1c724c20d468 100644
> > > --- a/drivers/usb/cdns3/gadget.c
> > > +++ b/drivers/usb/cdns3/gadget.c
> > > @@ -2338,9 +2338,35 @@ static int cdns3_gadget_udc_start(struct usb_g=
adget *gadget,
> > >   {
> > >   	struct cdns3_device *priv_dev =3D gadget_to_cdns3_device(gadget);
> > >   	unsigned long flags;
> > > +	enum usb_device_speed max_speed =3D driver->max_speed;
> > >   	spin_lock_irqsave(&priv_dev->lock, flags);
> > >   	priv_dev->gadget_driver =3D driver;
> > > +
> > > +	/* limit speed if necessary */
> > > +	max_speed =3D min(driver->max_speed, gadget->max_speed);
> > > +
> > > +	switch (max_speed) {
> > > +	case USB_SPEED_FULL:
> > > +		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> > > +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> > > +		break;
> > > +	case USB_SPEED_HIGH:
> > > +		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> > > +		break;
> > > +	case USB_SPEED_SUPER:
> > > +		break;
> > > +	default:
> > > +		dev_err(priv_dev->dev,
> > > +			"invalid maximum_speed parameter %d\n",
> > > +			max_speed);
> > > +		/* fall through */
> > > +	case USB_SPEED_UNKNOWN:
> > > +		/* default to superspeed */
> > > +		max_speed =3D USB_SPEED_SUPER;
> > > +		break;
> > > +	}
> > > +
> > >   	cdns3_gadget_config(priv_dev);
> > >   	spin_unlock_irqrestore(&priv_dev->lock, flags);
> > >   	return 0;
> > > @@ -2570,12 +2596,7 @@ static int cdns3_gadget_start(struct cdns3 *cd=
ns)
> > >   	/* Check the maximum_speed parameter */
> > >   	switch (max_speed) {
> > >   	case USB_SPEED_FULL:
> > > -		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> > > -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> > > -		break;
> > >   	case USB_SPEED_HIGH:
> > > -		writel(USB_CONF_USB3DIS, &priv_dev->regs->usb_conf);
> > > -		break;
> > >   	case USB_SPEED_SUPER:
> > >   		break;
> > >   	default:
> >=20
> > Just a small comment:
> >=20
> > You could delete switch-case at cdns3_gadget_start, and just use
> > if() statement, eg:
> >=20
> > 	max_speed =3D usb_get_maximum_speed(cdns->dev);
> > 	if (max_speed =3D=3D USB_SPEED_UNKNOWN)
> > 		max_speed =3D USB_SPEED_SUPER;
>=20
> But then it will not take care of bailing out for USB_SPEED_WIRELESS,
> USB_SPEED_SUPER_PLUS and any future speeds.

This IP only supports FS/HS/SS. It doesn't a big issue, if you would
like to keep the code like your patch, it is also OK.

--=20

Thanks,
Peter Chen=
