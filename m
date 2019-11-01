Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70380208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 01:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lJmFCSoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfKABU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 21:20:27 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:39879
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfKABU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR8ZgvhD3TKJi81/CiDKUAzso2pSbe0DQIDsyeCsKH8IYVYU/+me97Jb+X878wpl2WgS20SS8LKRr7Q7kNIwPd43mIhzZ3guqvgUubLNCp+KNji1KlVzZgih7mMv/XeFFn0r7ZpUzHR9emLPiqiEXfB6s3E20SPy7HmULNxt2uXH4bJ8t6vmKGIipIPYyx4gyvEYLlxYKKhdHMb6lWFjlM5M8Cu9Wfsf3ZmYFM3GTjKZQBKI+iLNn8vU5vCqV8qoKYfUxILBNUm0GAw5kLumwKC75X2+/YJtpl12uGfLsnm+CU23PINbSgEEj/oF/VwIh9Mp5N6HQJ7TVMt/TqPbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/QMYuCC/1N4dp1tGM+9XYnDee+YSkSoOub9mjAUhUM=;
 b=oEKB5Jj4QIrPuC0v3OordrLXZNl8vDfb7937p8juZA1O5UH0BiN1RNJbTPsDwRzIlK4jxadL6ew2qHppqob90jZRwNeoSTHjwinulUKsHCOPQtEsz7h60JioGUxzdyVmvRFti8LXAh5yYX5jPkVEDTf/yW8ZDD6dtRttke1+On1Qq9VtEHFJxjKhcd1NWFn1aoFny4Ia2MiKTOQFuQmBFf/luycKXFNNU0nQ3Q+WrNxcDajMqg4IHU2Yz06LGwqi/hVN/XOAPiFq1mAUFAQ52Vq9mXodnZpBDC9rDi9iUnSZRPKMMwa11EVWPUj7FGN5cHBXD4lHQqH1kl+FglU/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/QMYuCC/1N4dp1tGM+9XYnDee+YSkSoOub9mjAUhUM=;
 b=lJmFCSoOPF88nA2zYZjWrYnjc1IEzftecymf9iNgYzu8xnhh7z9dAumHSrd4udASArNobO71d/j+v9vLkeENFlFXOmCmzPOYMTUdsQDkpKqW1ojgYYyoHQ6cUbS6nxBwQ2NF/qViORK+PONHRtDwj9az3xvwKwN12FyIe7mJICE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6148.eurprd04.prod.outlook.com (20.179.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 01:20:22 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 01:20:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Thread-Topic: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Thread-Index: AQHVh/j+k1XoWkwF8kWzRGGsNvXoFad1lK+Q
Date:   Fri, 1 Nov 2019 01:20:22 +0000
Message-ID: <AM0PR04MB448130E87B85C5F5AB31496288620@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63dc22d6-544f-4045-3fc8-08d75e69aaa3
x-ms-traffictypediagnostic: AM0PR04MB6148:|AM0PR04MB6148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6148468A298E35FD86EB82BE88620@AM0PR04MB6148.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(3846002)(14454004)(8936002)(81166006)(229853002)(8676002)(476003)(81156014)(7696005)(478600001)(102836004)(86362001)(55016002)(66066001)(6116002)(26005)(6246003)(99286004)(186003)(52536014)(2501003)(66946007)(66476007)(76176011)(5660300002)(76116006)(305945005)(33656002)(316002)(66446008)(66556008)(74316002)(6436002)(256004)(7736002)(64756008)(53546011)(2906002)(486006)(44832011)(71190400001)(11346002)(446003)(9686003)(110136005)(6506007)(54906003)(25786009)(4326008)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6148;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkPUoFV1NEeZUQrIjNYUec2MjYkksfa4gAWni+q9fh6PybWVfWyT782qO6b5yXTfZ5rauLJF4WM95Kz4eKw+0TOg9czYUlsTntiwIpQarIUWFmjKrKy4fjY+Bgr2hC5tP3TBaH+5hjHWAOaq0IvE2PWUxDlT6cHRwy5Yy3h27mSOIZZ0QAGuMgWS6oNxUiqkkoYnAbDayinT2Eb454rVjbvItACoXTha8kIEAyrO/5ZwGtc51iPVZypO7jIGKm0qZI36Ms6n7GFMJTsaTe0XbwbCSQeotRtyOG97tyZT4o42wynevQRJ9NsVKVmDuIG7VqTxf6Fh1ym/R1tcPFLczPFtEP/3JuoW16TDg5I+34qaDIG7Ly08K4sL7bKkTxsCPPFjWxSJUEiMTC5mPlYEHROxqVzSRRfTZYXmaH/1B6KyTXCNDBhLpDt11ux02Nd2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dc22d6-544f-4045-3fc8-08d75e69aaa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 01:20:22.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbYErQWXZQpIjuK/pboxE6EFavLN5Nf9BlnXetQb7fg3TahKlKpdjtEUydal7dy8jmx2CB+zgctnrGRAvnLgXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios f=
or
> fec1
>=20
> On 21.10.2019 13:19, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > We should not rely on bootloader to configure the phy reset.
> > So introduce phy-reset-gpios property to let Linux handle phy reset
> > itself.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
>=20
> This broke NFS boot for me in next-20191031: board now hangs on DHCP.
>=20

Sorry for this. I not use sdcard when I did the test.

> It can be fixed by reverting this DT patch or by setting CONFIG_AT803X_PH=
Y
> to y instead of m.

I prefer setting CONFIG_AT803X_PHY.

Thanks,
Peng.

>=20
> Needing a phy module is not a bug but everybody will need to either
> adjust .config or build modules into an initramfs somehow.
>=20
> > ---
> >
> > V2:
> >   U-Boot->bootloader
> >   Add R-b tag
> >
> >   arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > index faefb7182af1..e4d66f7db09d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > @@ -80,6 +80,7 @@
> >   	pinctrl-0 =3D <&pinctrl_fec1>;
> >   	phy-mode =3D "rgmii-id";
> >   	phy-handle =3D <&ethphy0>;
> > +	phy-reset-gpios =3D <&gpio4 22 GPIO_ACTIVE_LOW>;
> >   	fsl,magic-packet;
> >   	status =3D "okay";
