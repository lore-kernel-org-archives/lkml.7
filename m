Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21384C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB9B2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 12:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NJVvC6rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLRMK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 07:10:57 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:60325
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfLRMK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:10:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWL2JCRW3AKSwCUd61trl8rKgXpBpJ1eSV0zVPRIXaDDaSQ0tUJc96ydQ5cWR/fEjNZjGUJvH1tCanOYLSo3RLfwk9MYAfcNCHjcz/GOi7F4+CPzOLfb/eZgf76aBsW/q5y9JEUpyk9qNVqadZ7VfiGPUEpIAcAnsQ5HleZIIZYA9Xz7DlPMZR+BR98X3M/T6Kb49V0KMKnUIiklZHGYyE7nHPOywhJzfX6eNoCGwG5zOz2f791Z4mT1usNVhTIGWgqQnlYLYAWU4geeDLWvesnXjBljEsgb1PTndZVdt5RpYuel6er8DliWCjwwmlMcaqtr9yWXlI98vqp8bn8lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj4KIseQf1CFxpdp5TzyRqtkovICeRio2uAcZAu2nxc=;
 b=NVpnbEJWNot3Om6tS/auwzeMN4rFu7wF3X7R9jk3GHv/B5QC3gmUMk7wqenkt0HKAlV00P8W6gjjrp2kEEUWobyD0ckSH4f42BW5E23U3PPb6qAbj6RfiQNh/bICosuSWPG4xQCBIm1/ra0D02C7hX2DFjz8HBh7gMa9SUAimE5F9clnRFBDZZkAuzUldPEvsmosJnmvSCeQsX6chHlySnBr8g4dSjRwzqWq0IqqKmxqYtmJwrl0OnceUsv9E59l2Ofayx1HJw1AgsCP/qIfihf1TeD2ziMyQlmfnBoDJ87uorNMNnSjcUr4LKU6dLpqMGu9fk0c5zdgWcOhIjNlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj4KIseQf1CFxpdp5TzyRqtkovICeRio2uAcZAu2nxc=;
 b=NJVvC6rqe0Qo5CC2Znmu7Ka7JLaD58EndTDRt/vL7rc0mPchTMdElxnw5HiLIkGbI7wjB3zgRRoSEe1vMRt8nQ1CQ4BZ1K4un6m2RHt76CotbKdv64+qJ2Nq+Z8Y3E9GdglQe0AuQj6+DN0OLeWmuw7ZJfHIS3lSwYi42iZigs4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5986.eurprd04.prod.outlook.com (20.178.116.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 18 Dec 2019 12:10:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 12:10:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Baruch Siach <baruch@tkos.co.il>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
Thread-Topic: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
Thread-Index: AQHVtZsmfGvwTi+ciE+LrR2fcO2bIqe/zFuAgAAATaA=
Date:   Wed, 18 Dec 2019 12:10:53 +0000
Message-ID: <AM0PR04MB4481AF61BEF33C37AC1B20AC88530@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1576670430-14226-1-git-send-email-peng.fan@nxp.com>
 <87lfr9suoy.fsf@tarshish>
In-Reply-To: <87lfr9suoy.fsf@tarshish>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ea820e2-8c88-42e4-b129-08d783b354aa
x-ms-traffictypediagnostic: AM0PR04MB5986:|AM0PR04MB5986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB598605B3C2E62725962FF99D88530@AM0PR04MB5986.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(189003)(199004)(66946007)(33656002)(186003)(478600001)(71200400001)(26005)(110136005)(52536014)(81156014)(86362001)(54906003)(6506007)(4326008)(55016002)(9686003)(5660300002)(66446008)(2906002)(44832011)(76116006)(81166006)(8936002)(64756008)(66476007)(7696005)(8676002)(66556008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5986;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SwFTgkTdOSKiFcoiVhX8YU8C6kO2shhF9EykILh1YTY8w6W1gtXxw6lpnDWXo7mW8Ktv6uhY0MrBSDAPhsxNSWJ9oPdV6FiRs2Znj7ex7wIVpuIOQK7kw5Im+MdmVHoUFzUekwuTtKJw8Qmb+FBKeb/J76gqe5WKLdHBiVPZ316QgsGBnnpPvGBQlonXdTmosPVccBi22ncDRkMsOpI/YYNHvLc0nDQCXnwOfBHfdqUEXO8g3Tet22PLHbkwZlXkh8F57AwvY6XD/bxamD3NgYUEb2RuaxIFkSjAvdYZ09DMGewGI01XTXqjM+nfMRaiiEDxgp9BTiGBfrLWpu1iQDZ6SBtj+CSihBI7f1tBrncRXDSKLv2A/ViGiOWKDBfbUSJNWcylnS4OkFVDfdV+7h1Frp4LaAqkEhzCTF9Q+MEZwLy5JfQkKRXc616PevEP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea820e2-8c88-42e4-b129-08d783b354aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 12:10:53.7852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYvjc+H8mzOu1LlmRKiKKMuSv1ra2dE4y0jb3c2bpKuyXziLtADZLvq3sI4uVlLglKC+/p5qMmcPhfo8dp2fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Subject: Re: [PATCH] arm: dts: imx7ulp: fix reg of cpu node
>=20
> Hi Peng,
>=20
> On Wed, Dec 18 2019, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > According to arm cpus binding doc,
> > "
> >       On 32-bit ARM v7 or later systems this property is
> >         required and matches the CPU MPIDR[23:0] register
> >         bits.
> >
> >         Bits [23:0] in the reg cell must be set to
> >         bits [23:0] in MPIDR.
> >
> >         All other bits in the reg cell must be set to 0.
> > "
> >
> > In i.MX7ULP, the MPIDR[23:0] is 0xf00, not 0, so fix it.
> > Otherwise there will be warning:
> > "DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map"
> >
> > Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx7ulp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx7ulp.dtsi
> > b/arch/arm/boot/dts/imx7ulp.dtsi index d37a1927c88e..aa9e50178d6b
> > 100644
> > --- a/arch/arm/boot/dts/imx7ulp.dtsi
> > +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> > @@ -40,7 +40,7 @@
> >  		cpu0: cpu@0 {
>=20
> The address suffix in the node name should update to match 'reg'.

Yes, indeed, I will change to "cpu0: cpu@f00".

Thanks,
Peng.

>=20
> >  			compatible =3D "arm,cortex-a7";
> >  			device_type =3D "cpu";
> > -			reg =3D <0>;
> > +			reg =3D <0xf00>;
> >  		};
> >  	};
>=20
> baruch
>=20

