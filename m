Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADBC2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A572206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ymnxi+6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLJJN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:13:28 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:37634
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbfLJJN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:13:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+BhXKt0zjvmmJuiG+cs6A1sB/qoRNeSIc5x4iK272H+PpyMW3NGQEPABlz940Bfm/flrC52mcgLDL1s2v0DJJ5rc9fzDFLiyACqK8dOch9FHePa0oeZ4Rzj9UmiEOPJrJkgvWpTrUXX5wSlp4Q326uhuwGlHjIojKspo0wAnAw8LaXaaa5lkTpD6LWGIRdVPHJLQmFB5BxuMRTm+DiU6aQx8LBwtkkFcVn9lsf+cX4wtichrVoxPKO8JvDS86zx7FBisyq2qdJLbiqmuDy0T2kPA9MbdWhOPbTul4+gTJcwM1TS0oeXmExPBTBqg/FR72TR+Ev4QDQkbWPXa7ojJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gB01iLhhHSWa1fDX3dD170nxdlDdIgKTd8vkpg2j2M=;
 b=CoVyIapBydXT62pjnEI27EE+LEYj4fe8+BW4jqUT7bzzgoIUyfgfKwhghDrJqPtYVLUA4VPpPoMq8NnQDSkAlj4DFkow1Z6KuyFxC9lB3gllR6+4U8kXgs06ujSX4e+6QsN1xU15Zjwim7k0fKx6zGjColVHsDDhCmwqUydMYc/euh7DZl+AnJFjcol92eJrXg8DOVjmZanZvqQehd+0ql5QhtAFgYobgifhRrP0mrK4Cos3x7sx8yLkx1NbOWuPixTRxuh2Wu7X0c0SptI+5m12FLgPz8MJOWVmfh1b0kCKdrhIREeLJQPi4tjmswAvkUw9LoQwgtyTzRKmBfsuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gB01iLhhHSWa1fDX3dD170nxdlDdIgKTd8vkpg2j2M=;
 b=Ymnxi+6t0Zz8h/mJET7sxU7NQe/NdNG9Nj1a0rBAHb4hqgoJ91JApGNsbF6DttSEwIgabZt3PjdSC0u088piqxD0OCcN2exrKaPfFLMMS+LXfVqIVwtfYvg+KRoFdgFqwAVp5wXrNdCTzwA7+AqxoCusX9VyxhiEKCVy3C0AveM=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (52.133.12.32) by
 VI1PR04MB4349.eurprd04.prod.outlook.com (52.133.12.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 09:13:23 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::20fe:3e38:4eec:ea03%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 09:13:23 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [EXT] Re: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
Thread-Topic: [EXT] Re: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
Thread-Index: AQHVrnBLtaYchIru+E6aNXw66ImuFqeyq8zwgABj3QCAAASy0A==
Date:   Tue, 10 Dec 2019 09:13:23 +0000
Message-ID: <VI1PR04MB406255C30EDF41634C01EE2DF45B0@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20191129210937.26808-1-michael@walle.cc>
 <20191209090840.GL3365@dragon>
 <VI1PR04MB4062D212996FE37A72DE3557F45B0@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <83445bed8b838b56e7d041915f1849f8@walle.cc>
In-Reply-To: <83445bed8b838b56e7d041915f1849f8@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31770836-91c0-4337-fef6-08d77d51354a
x-ms-traffictypediagnostic: VI1PR04MB4349:|VI1PR04MB4349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB43495B519E629F8334128972F45B0@VI1PR04MB4349.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(13464003)(199004)(189003)(4001150100001)(53546011)(186003)(7696005)(5660300002)(54906003)(6506007)(26005)(44832011)(71190400001)(71200400001)(52536014)(33656002)(4326008)(64756008)(66946007)(66476007)(66556008)(76116006)(305945005)(2906002)(66446008)(8936002)(9686003)(55016002)(229853002)(316002)(86362001)(8676002)(478600001)(6916009)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4349;H:VI1PR04MB4062.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WZm5Opry7qedfgQi7MglZcqjxFWkDOFLN1X0Gmbq0BVkOsmRU8/H3wC9j6Q6b82611XxQsddob4cTyrB1aTLk8WuLjaXhEBflbdWolKlRGnLTu4BxxorKFkUrHNLA6U1NCORVCYME6rbeQydzdec3KyZJ5YspZMvXezd9/8iDN7YzZSTn2i71LQNU/RNekdrwxzxzC0fgmsRpPQS4ABCa/4ptW/4UMnvAGJQA3tfQLIbcrgXTzKSIp7+F2Ix4aXutuimcRKYIMnmWW1oIrtoG5WwBjyUEzPCvCYhvdg1Jmb1dUQO7CV8y+SKsYkqCV5XLlLLDVj7aHeUO0hTx9CG7wE7cHLa35TKVlQKt7Iy+16vCMy+WYEj8lpodTVXIvjUBXTZWiINIpt4QXiEv8CdtbMPtsf9Wq99qBWdhpUqhpq2i3O9FTIFoCYRXso+qevXa2I1loPJhiQ20J+qvaujNO6SpLfMbygzsC41WLUQJGJRRaQ0xjp1dDwFTOu49iF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31770836-91c0-4337-fef6-08d77d51354a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 09:13:23.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qElqFmhZjB3vxL3li3qfREJvYm5JIvPfzDMcuHZDJ7UeRW7aoXC4s/nx8anxMc9707jnS/JoX3Z2iEscTgYwrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

> Caution: EXT Email
>=20
> Hi Alison,
>=20
> Am 2019-12-10 06:35, schrieb Alison Wang:
> > Hi, Michael,
> >
> > In most of our cases, TX and RX are using the same BCLK and SYNC
> > clocks. So the default synchronous mode (sync Rx with Tx) is used,
> > which means both transmitter and receiver will send and receive data
> > by following clocks of transmitter. It is verified on our boards.
>=20
>=20
> I get that, but it doesn't make sense for the LS1028A SoC because, there =
is no
> way you have have the TX data and the RX clocks or vice versa. The hardwa=
re
> of the SoC doesn't allow that. I cannot speak of the QDS variant of the S=
oC, but
> the LS1028ARDB only has a transmitter. So there is no problem, because it=
 will
> default to the TX clock. But as soon as you also have a receiver you have=
 to use
> the clock of the receiver block. You could say, use fsl,sai-synchronous-r=
x, but
> that will only work if the SAI is used in RX mode. fsl,sai-asynchronous m=
ode
> works for both on the other hand and can therefore be the default mode.
>=20
> -michael
[Alison] Your explanation is reasonable. LS1028A SoC is a specific one. Usi=
ng fsl,sai-asynchronous
mode is the preferred choice.

Acked-by: Alison Wang <alison.wang@nxp.com>


Best Regards,
Alison Wang

>=20
>=20
> >
> >
> > Best Regards,
> > Alison Wang
> >
> >> -----Original Message-----
> >> From: Shawn Guo <shawnguo@kernel.org>
> >> Sent: Monday, December 9, 2019 5:09 PM
> >> To: Michael Walle <michael@walle.cc>; Alison Wang
> >> <alison.wang@nxp.com>
> >> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>; Rob
> >> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>
> >> Subject: [EXT] Re: [PATCH] arm64: dts: ls1028a: put SAIs into async
> >> mode
> >>
> >> Caution: EXT Email
> >>
> >> + Alison Wang
> >>
> >> On Fri, Nov 29, 2019 at 10:09:37PM +0100, Michael Walle wrote:
> >> > The LS1028A SoC has only unidirectional SAIs. Therefore, it doesn't
> >> > make sense to have the RX and TX part synchronous. Even worse, the
> >> > RX part wont work out of the box because by default it is
> >> > configured as synchronous to the TX part. And as said before, the
> >> > pinmux of the SoC can only be configured to route either the RX or
> >> > the TX signals to the SAI but never both at the same time. Thus
> >> > configure the asynchronous mode by default.
> >> >
> >> > Signed-off-by: Michael Walle <michael@walle.cc>
> >>
> >> Alison, Leo,
> >>
> >> Looks good to you?
> >>
> >> Shawn
> >>
> >> > ---
> >> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> > index 379913756e90..9be33426e5ce 100644
> >> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> > @@ -637,6 +637,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 4>,
> >> >                              <&edma0 1 3>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > @@ -651,6 +652,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 6>,
> >> >                              <&edma0 1 5>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > @@ -665,6 +667,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 8>,
> >> >                              <&edma0 1 7>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > @@ -679,6 +682,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 10>,
> >> >                              <&edma0 1 9>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > @@ -693,6 +697,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 12>,
> >> >                              <&edma0 1 11>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > @@ -707,6 +712,7 @@
> >> >                       dma-names =3D "tx", "rx";
> >> >                       dmas =3D <&edma0 1 14>,
> >> >                              <&edma0 1 13>;
> >> > +                     fsl,sai-asynchronous;
> >> >                       status =3D "disabled";
> >> >               };
> >> >
> >> > --
> >> > 2.20.1
> >> >
