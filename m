Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3236AC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AB521775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 02:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WT60HEnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgAFCiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 21:38:25 -0500
Received: from mail-vi1eur05on2040.outbound.protection.outlook.com ([40.107.21.40]:64865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbgAFCiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 21:38:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx1JFiJSa/V4E8o6wwcOR0BR46H0Kp/c03LUnuXGKisu7pgqdaeD9OfD/axCHrXSrL8wxE2JnJkq7nR49VciJegQZ/pVKflBDTyUxuGvXwNgiXR8Ma9lOtEBbG3cXxQjcwMNMGCJJ7Enci/cWLQw09LZaFLRsHDzZVdlzS8jdTUc4YrAxz6ZSKt6bDjFmRqlCwhgguS5abBWdmYWjZ97xwg26r1lU1Cde526b2IhedUG82AHvDIrcu7yX9XS6C674FwApMkmziaZSbMFSQsogCA6myWwV9e/xCcmEYTsBYeHOEjbIrifH+2l10FQVaKa42yDk339sxnQoRHbzvRXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+vc845n2eKAdY0NzzJ2bu6akDIeYUsr49pGJqJ+k2w=;
 b=m/Vs3Rd1aD6UJOp/5OdqqYFMyKhzpY9kLgVplJ26uySTNmAmXio1e+J1MNyr5utNOeKszOdi2zQOyYLXKIwJtBBa2SEPRrEM+X1kc0dUqD52M76DYJHYmO6ZHfOP3+XeYGKScFGGgBfuicnowHEFqKRVN2iShAL1a4H1R439AI8+2q/JjsTJjEfDS9L8NSCDmLGXmuwJN5QvC5Vk+EmrQifH3anUB+Gg9Xtj7LY1pOVPWR9aOeKzUPgxbxNdi0wY5uF4Cnj+i2jfAH4wk7q9h2o+aJphyvtdjuP65Jd2H2NMKKmpT2o1HI4DdIVi+VfOzivzU0+c6ijmoNALmqb/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+vc845n2eKAdY0NzzJ2bu6akDIeYUsr49pGJqJ+k2w=;
 b=WT60HEnYCz58XsspIqkctPruMoa6ReC6SEXH6CGH2VZORkcecWjdGrv6/ekU1mQesWER/+r55Zp/ZcxHSiUT3Uc+jt8HAJ9qftmyIgRpw/Df497oQjDM38YuHNaPKBpJV/hO+lSu7pXAv2hs7+xnrsdfxyJu+KM5pU3BJqj24yI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5682.eurprd04.prod.outlook.com (20.178.202.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 02:38:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 02:38:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
Thread-Topic: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
Thread-Index: AQHVvu9AXeMfpR61Rke6CNGr+daIZKfZsCkAgANF9OA=
Date:   Mon, 6 Jan 2020 02:38:18 +0000
Message-ID: <AM0PR04MB4481917D6A969053CB85276F883C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1577696078-21720-1-git-send-email-peng.fan@nxp.com>
 <20200104003634.GA6058@bogus>
In-Reply-To: <20200104003634.GA6058@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00c7e4fc-4ba0-4415-da5c-08d792517d4b
x-ms-traffictypediagnostic: AM0PR04MB5682:|AM0PR04MB5682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB56828C7631B05CD71CB47B41883C0@AM0PR04MB5682.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(86362001)(66476007)(71200400001)(2906002)(76116006)(26005)(9686003)(66946007)(186003)(66446008)(66556008)(55016002)(8936002)(64756008)(4326008)(6506007)(478600001)(44832011)(7696005)(6916009)(8676002)(316002)(81156014)(81166006)(54906003)(52536014)(5660300002)(33656002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5682;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgqgflOtkZ76FcdnsnCIeNqw6MhVFupfv1qhQ8EdJM4CNBEzDBQ1mYHnm44kZzOWvzTfJQ6azne3Po6NEHg+xkMT5Mpq2wWgZqYh6Zv+I7nCcZ6rK2JnZg14hvIsKM5MQfHSL4QgbRY0WKdIKmkr7D9zmHtYuw3oeKfaTOu10kTAzwNHadfEjGH1AkqzbC+hrcK8fY0v1eNbtdJpqYIik46MEKSHy6HWXG1S2RaPj+zfOZP7d6FrM+bYHhtFPH1K0zUlJ2okbTb+dUOH+AUwtzkF3FWGX9Gfmo0sr71WX7COwr88j6bTKXCBLb/gUdvot2yLolLgMrd5YMG/xEsfUAHOx//C8EIeYMxMjQDRp64hqSALwa8Kd1eCoCt1JzbwGVYZqlYx+ZJjdj9slvk3xbgLB5sAOpBQv+1z/UC9WJSsAorVoPYws4XfytJSt8eSVD4CMudLOhA445eFF0rhF54fsosQcmeg7ze2KYKsNxY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7e4fc-4ba0-4415-da5c-08d792517d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 02:38:18.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJ+C0IEYdTEE8+dijL6O0ivqG2h76WQnDnylZtiRIg/ml6v2IejhJqXo6uZV3zsbhSJ7un/S+zQanZ9gv489GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH] ARM: dts: imx: drop "fsl,aips-bus"
>=20
> On Mon, Dec 30, 2019 at 08:58:05AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is no binding doc for "fsl,aips-bus", "simple-bus" is enough for
> > aips usage, so drop it.
>=20
> NAK. The AIPS bus has registers, so 'simple-bus' alone is not enough.

You mean the "reg" property below, right?
                aips-bus@2000000 { /* AIPS1 */
-                       compatible =3D "fsl,aips-bus", "simple-bus";
+                       compatible =3D "simple-bus";
                        #address-cells =3D <1>;
                        #size-cells =3D <1>;
                        reg =3D <0x02000000 0x100000>;

But the reg property is not required, I think it could be removed.
There is no binding doc and driver for "fsl,aips-bus", so I think
It not make sense to have that compatible in dts.

>=20
> What you should do is change 'aips' node names to 'bus'.

How do you think about below change, with reg removed?
                aips-bus@2000000 { /* AIPS1 */
-                       compatible =3D "fsl,aips-bus", "simple-bus";
+                       compatible =3D "simple-bus";
                        #address-cells =3D <1>;
                        #size-cells =3D <1>;
-                       reg =3D <0x02000000 0x100000>;

Thanks,
Peng.
>=20
> >
> > Scirpt:
> > sed -i 's/compatible =3D "fsl,aips-bus", "simple-bus";/compatible =3D
> "simple-bus";/'
> > arch/arm/boot/dts/imx*
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx25.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx31.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx50.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx51.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx53.dtsi   | 4 ++--
> >  arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
> > arch/arm/boot/dts/imx6sl.dtsi  | 4 ++--
> > arch/arm/boot/dts/imx6sll.dtsi | 4 ++--  arch/arm/boot/dts/imx6sx.dtsi
> > | 6 +++---  arch/arm/boot/dts/imx6ul.dtsi  | 4 ++--
> > arch/arm/boot/dts/imx6ull.dtsi | 2 +-
> >  arch/arm/boot/dts/imx7s.dtsi   | 6 +++---
> >  12 files changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx25.dtsi
> > b/arch/arm/boot/dts/imx25.dtsi index 40b95a290bd6..3b7a0b249d80
> 100644
> > --- a/arch/arm/boot/dts/imx25.dtsi
> > +++ b/arch/arm/boot/dts/imx25.dtsi
> > @@ -76,7 +76,7 @@
> >  		ranges;
> >
> >  		aips@43f00000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x43f00000 0x100000>;
> > @@ -333,7 +333,7 @@
> >  		};
> >
> >  		aips@53f00000 { /* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x53f00000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx31.dtsi
> > b/arch/arm/boot/dts/imx31.dtsi index 6b62f0745b82..b0e7e3bf8a1a
> 100644
> > --- a/arch/arm/boot/dts/imx31.dtsi
> > +++ b/arch/arm/boot/dts/imx31.dtsi
> > @@ -64,7 +64,7 @@
> >  		};
> >
> >  		aips@43f00000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x43f00000 0x100000>;
> > @@ -226,7 +226,7 @@
> >  		};
> >
> >  		aips@53f00000 { /* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x53f00000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx50.dtsi
> > b/arch/arm/boot/dts/imx50.dtsi index 0bfe7c91d0eb..961de09b571d
> 100644
> > --- a/arch/arm/boot/dts/imx50.dtsi
> > +++ b/arch/arm/boot/dts/imx50.dtsi
> > @@ -102,7 +102,7 @@
> >  		ranges;
> >
> >  		aips@50000000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x50000000 0x10000000>;
> > @@ -390,7 +390,7 @@
> >  		};
> >
> >  		aips@60000000 {	/* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x60000000 0x10000000>;
> > diff --git a/arch/arm/boot/dts/imx51.dtsi
> > b/arch/arm/boot/dts/imx51.dtsi index dea86b98e9c3..86708688371b
> 100644
> > --- a/arch/arm/boot/dts/imx51.dtsi
> > +++ b/arch/arm/boot/dts/imx51.dtsi
> > @@ -159,7 +159,7 @@
> >  		};
> >
> >  		aips@70000000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x70000000 0x10000000>;
> > @@ -441,7 +441,7 @@
> >  		};
> >
> >  		aips@80000000 {	/* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x80000000 0x10000000>;
> > diff --git a/arch/arm/boot/dts/imx53.dtsi
> > b/arch/arm/boot/dts/imx53.dtsi index ed341cfd9d09..f46a83c7d2c4
> 100644
> > --- a/arch/arm/boot/dts/imx53.dtsi
> > +++ b/arch/arm/boot/dts/imx53.dtsi
> > @@ -223,7 +223,7 @@
> >  		};
> >
> >  		aips@50000000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x50000000 0x10000000>;
> > @@ -655,7 +655,7 @@
> >  		};
> >
> >  		aips@60000000 {	/* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x60000000 0x10000000>;
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> > b/arch/arm/boot/dts/imx6qdl.dtsi index e6b4b8525f98..9b7635e9cf3c
> > 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -295,7 +295,7 @@
> >  		};
> >
> >  		aips-bus@2000000 { /* AIPS1 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02000000 0x100000>;
> > @@ -936,7 +936,7 @@
> >  		};
> >
> >  		aips-bus@2100000 { /* AIPS2 */
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02100000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> > b/arch/arm/boot/dts/imx6sl.dtsi index 59c54e6ad09a..4b4f22217dfe
> > 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -144,7 +144,7 @@
> >  		};
> >
> >  		aips1: aips-bus@2000000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02000000 0x100000>;
> > @@ -787,7 +787,7 @@
> >  		};
> >
> >  		aips2: aips-bus@2100000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02100000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx6sll.dtsi
> > b/arch/arm/boot/dts/imx6sll.dtsi index a1bc5bb31756..fac8f22255aa
> > 100644
> > --- a/arch/arm/boot/dts/imx6sll.dtsi
> > +++ b/arch/arm/boot/dts/imx6sll.dtsi
> > @@ -145,7 +145,7 @@
> >  		};
> >
> >  		aips1: aips-bus@2000000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02000000 0x100000>;
> > @@ -664,7 +664,7 @@
> >  		};
> >
> >  		aips2: aips-bus@2100000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02100000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx6sx.dtsi
> > b/arch/arm/boot/dts/imx6sx.dtsi index 59bad60a47dc..4499be62c8bb
> > 100644
> > --- a/arch/arm/boot/dts/imx6sx.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx.dtsi
> > @@ -236,7 +236,7 @@
> >  		};
> >
> >  		aips1: aips-bus@2000000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02000000 0x100000>;
> > @@ -831,7 +831,7 @@
> >  		};
> >
> >  		aips2: aips-bus@2100000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02100000 0x100000>;
> > @@ -1189,7 +1189,7 @@
> >  		};
> >
> >  		aips3: aips-bus@2200000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02200000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx6ul.dtsi
> > b/arch/arm/boot/dts/imx6ul.dtsi index d9fdca12819b..63d276fc2477
> > 100644
> > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > @@ -205,7 +205,7 @@
> >  		};
> >
> >  		aips1: aips-bus@2000000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02000000 0x100000>;
> > @@ -772,7 +772,7 @@
> >  		};
> >
> >  		aips2: aips-bus@2100000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02100000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx6ull.dtsi
> > b/arch/arm/boot/dts/imx6ull.dtsi index b7e67d121322..633fa08bc972
> > 100644
> > --- a/arch/arm/boot/dts/imx6ull.dtsi
> > +++ b/arch/arm/boot/dts/imx6ull.dtsi
> > @@ -52,7 +52,7 @@
> >  / {
> >  	soc {
> >  		aips3: aips-bus@2200000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x02200000 0x100000>;
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi index 139ab9b98472..552b14be14a1
> 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -317,7 +317,7 @@
> >  		};
> >
> >  		aips1: aips-bus@30000000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x30000000 0x400000>;
> > @@ -669,7 +669,7 @@
> >  		};
> >
> >  		aips2: aips-bus@30400000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x30400000 0x400000>;
> > @@ -809,7 +809,7 @@
> >  		};
> >
> >  		aips3: aips-bus@30800000 {
> > -			compatible =3D "fsl,aips-bus", "simple-bus";
> > +			compatible =3D "simple-bus";
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >  			reg =3D <0x30800000 0x400000>;
> > --
> > 2.16.4
> >
