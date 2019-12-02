Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21ADC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A6206DC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rQinLrZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLBFn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:43:28 -0500
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:53134
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfLBFn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:43:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcO9+ZGNEmSIcisQ5xSS3PhebMGsNw5Wbdtp7pUtpEDoEXYnbuf4b8a1GzVMJKr/bvQHgjmReoFRFUrMmAmEbpzGnR90pKvp0iZIma2hnjhIzt7f+i18t7BU5bOkTrr7Dilo4DdpfGSCeA75EkNGifEb8gHDvpe0ZX+n6/higM5E0VEJ1PDvTOEsA8u5KN27wHrtIqgu99GXb1SQ6FnnoP5sZsEM0jOFscF8qaapfrMaUKweGD7Iy/fr3FAnSGjccCQ271oU6WFFQBrn+Jb4Owq/kKctwfQaOg+G9Heil77TycL29edVGo26LiTXgasE0QMn4oVK6iOnnY4oggpStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mGa9R5++e7rDSKn6rr1bc75KdorayaimobJ7+6+Ug=;
 b=cgXEZmGP5l9xuKiwQPPAAHYxFNVR4HDxwEUixkDaaCH6sDhjSLCjRJZ3VrPamAoa/GMA460dDJJY2UW2PgmlwPxFI1t84YHbMpxONsHr8KnAW98rKZ5zA6ibHPCeDZS6ohETKOD8QR/k5GAWLb5iPvA96pmxe9BKGLqu9YB6VBiBHcACoK2ERjbCQgH/tJTyWcz60fNyEywqu68arRCqgZxhNzJCcZaAyiAO0JBIPOYkovZlvHb2sMR0Opfx74FVVKzBCzitH3eMK65h5jTHFbJU+IVGheRyUEY0OITaH4w4wfxDHNzE8kwu+M0U92SHfekd/SasxrA/VnmcqOVEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mGa9R5++e7rDSKn6rr1bc75KdorayaimobJ7+6+Ug=;
 b=rQinLrZ4doCMFz+52/rilIABPn6Lv7n3EfEU9BGRmnYM8kZCjuCI4QX3s9vXB579vhB9rfUepBg0glXWY1UBgTmVmh5BZZXEcfJ+DIT+ww99Vcq10PQGhZkv9KSfEa0CRfZHLVOV7YvdB3sqjEaruAY3WlX7/GFAXnu2vRK5RJk=
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com (52.133.43.147) by
 AM0PR0402MB3569.eurprd04.prod.outlook.com (52.133.44.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 05:43:20 +0000
Received: from AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::e885:ac97:fca8:c4e]) by AM0PR0402MB3556.eurprd04.prod.outlook.com
 ([fe80::e885:ac97:fca8:c4e%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 05:43:20 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
Thread-Topic: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
Thread-Index: AQHVojp/XO5z0jeXk0+aNgRvimpOIKedAjswgAA8FYCACSO5MA==
Date:   Mon, 2 Dec 2019 05:43:20 +0000
Message-ID: <AM0PR0402MB35568D79CBFDC28B32561085E0430@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-4-michael@walle.cc>
 <AM0PR0402MB3556804FB47D182173C6A7AAE0450@AM0PR0402MB3556.eurprd04.prod.outlook.com>
 <afde04b888418e9e4f4fdb946a579e70@walle.cc>
In-Reply-To: <afde04b888418e9e4f4fdb946a579e70@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuldeep.singh@nxp.com; 
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7481655d-b4ca-4a14-3752-08d776ea89d2
x-ms-traffictypediagnostic: AM0PR0402MB3569:|AM0PR0402MB3569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3569AB53833C5DAC733B3F98E0430@AM0PR0402MB3569.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(13464003)(199004)(189003)(5660300002)(966005)(54906003)(229853002)(4326008)(6436002)(66066001)(81166006)(8936002)(11346002)(52536014)(102836004)(186003)(26005)(6506007)(53546011)(76176011)(7696005)(14444005)(256004)(44832011)(71200400001)(71190400001)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(14454004)(6246003)(55016002)(6116002)(3846002)(4001150100001)(446003)(86362001)(99286004)(316002)(7736002)(33656002)(6916009)(8676002)(81156014)(74316002)(305945005)(9686003)(6306002)(2906002)(25786009)(478600001)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3569;H:AM0PR0402MB3556.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgZdN5DE93MNvR3HO7CWqjsg1vxfhfplcYB/48z9mro+3EgBR531KekG+cSy+G/pLR0hBagZhJv5sn2Lkwb7Vj8KssPYXZSWL+zS59c3sO+vSBYM8WGCMsgn9deZZOlfcaS/1tvTztfaTQyVNkKwnfH0ZbswDyyBJQH64utckWNlbYstLjLA43DEHflod3iJieZVne/y79SNSArKgfhxsvQkvcS+7fzvTJ7H++HHBOp7uCtsoFZkqqe2hF2QseKHPyN1ft4Rtx2gRkT0/OJPXf0bhNB/iSitnSZivzaPeUgK9TEk7Otd0HVYA4AAzdcnttWFFq9RBv2UM68axdfemsKOnnop2FANfzigbeSm6Ae/KBCf70ofP2rgdiRQAXYb3kWe7j4q7JeYTFy2+tF2/T8GseGX3MmvzOkX9EeNRcDQuLQ5Zke1uSP0cdpZ2B6g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7481655d-b4ca-4a14-3752-08d776ea89d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 05:43:20.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ET/WXoyKIE3NktYwSfIxn3AG+RLmv8V8jE7Go88XrhzilqS7QYNxXGZyb5YEgQCVuPHk8Sn4ohPqVdccqc5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, November 26, 2019 3:38 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Shawn Guo <shawnguo@kernel.org>; Leo Li
> <leoyang.li@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>
> Subject: Re: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
>=20
> Caution: EXT Email
>=20
> Hi Kuldeep,
>=20
> Am 2019-11-26 07:40, schrieb Kuldeep Singh:
> > Hi Michael,
> >
> >> -----Original Message-----
> >> From: devicetree-owner@vger.kernel.org
> >> <devicetree-owner@vger.kernel.org>
> >> On Behalf Of Michael Walle
> >> Sent: Sunday, November 24, 2019 1:43 AM
> >> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> >> linux-
> >> kernel@vger.kernel.org
> >> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> Rob
> >> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> >> Michael Walle <michael@walle.cc>
> >> Subject: [EXT] [PATCH 3/4] arm64: dts: ls1028a: add FlexSPI node
> >
> > There's already a patch[1] sent upstream and is under review.
> > It includes dts(i) entries for LS1028. I will be sending the next
> > version
>=20
> I've seen that, but there wasn't any reply for almost two months now.
> But
> if you're sending your next version, this patch can be dropped from this
> series.

Okay.

--Kuldeep
>=20
> -michael
>=20
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> >
> hwork.kernel.org%2Fpatch%2F11139365%2F&amp;data=3D02%7C01%7Ckuld
> eep.sing
> >
> h%40nxp.com%7C327363e5ba97483c9add08d77258875d%7C686ea1d3bc2
> b4c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C637103596868168346&amp;sdata=3DyDJ1ggrIuR
> v1%2Br%2F
> > 9Ez1uvv0EpFB8Mns5%2Ffn%2F7zG5InA%3D&amp;reserved=3D0
> >>
> >> Caution: EXT Email
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> index 6730922c2d47..650b277ddd66 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> >> @@ -260,6 +260,19 @@
> >>                         status =3D "disabled";
> >>                 };
> >>
> >> +               fspi: spi@20c0000 {
> >> +                       compatible =3D "nxp,lx2160a-fspi";
> >> +                       #address-cells =3D <1>;
> >> +                       #size-cells =3D <0>;
> >> +                       reg =3D <0x0 0x20c0000 0x0 0x10000>,
> >> +                             <0x0 0x20000000 0x0 0x10000000>;
> >> +                       reg-names =3D "fspi_base", "fspi_mmap";
> >> +                       interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH=
>;
> >> +                       clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> >> +                       clock-names =3D "fspi_en", "fspi";
> >> +                       status =3D "disabled";
> >> +               };
> >> +
> >>                 esdhc: mmc@2140000 {
> >>                         compatible =3D "fsl,ls1028a-esdhc", "fsl,esdhc=
";
> >>                         reg =3D <0x0 0x2140000 0x0 0x10000>;
> >> --
> >> 2.20.1
> >
> > Regards
> > Kuldeep
