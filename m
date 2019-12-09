Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF6CC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629A206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9lrbQYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLITup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:50:45 -0500
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:42819
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbfLITuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:50:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOGL+utWNTDRvyeUq6Oy5JLVoxBAj04zk3YlRJMvKNtQPxnN5Yk12UQLKcY9QbCX8DSFVsgOBA3N+w8qSDaHGQcwaPBJuUOqGKdVlOckSHbrq9r6eylN4kemeAtqTfSJW/fNohmfcIxvz1fDUkb23h5WdNyBcCwjStokC0yCFaUU/ftwEXqUHkbi2wHJ7A+DNRUm2r1E49a/WKH115h+vlyhV7lbFxRNNH8arzYiaMdUQ1Ykyqqak10SQ9gOrse3RhMtLEk5rMKdJ2PSn/HpvoiIUiE3l2Rp0yW/3Z/vvYbz/MmITOGqrEWHDLB4xuSCug1xBpRPVsqRkXkPwNqoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuL3k3OMRAuDSx5j/pqvS5ffTbqocxDy5N8f1ScvhN0=;
 b=aSsn8OEGskpZn+3m+9zWXcGH4yxwoOLnNlX1pzIpX/Ab1NFfCjI4aJXlKssOL9gAjjm7+wXvV7FcgR0WsORCk53GninhJG0CNSEszcX4LozmNdWPqDbkwNrlxbaju8+XfzenWGcdoN6Wz1/VXxGVWKSrsGuO77xV5Q57vbyhFnCAQ8yzvV99+N70GmDrzd8lxqllCdWZ8mDTB4CtQBiX4ivGw01pDecqXvFWzz2t+NA+fbYFSYTNtC3xf09mYKcVom0+AqmEczOloHbsNv998MtyZbu5Yvoy0wKsJx5h+5OK1ia7XU++IYyPoHp1YLKDqK7GD7hkAyd/008B/49wJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuL3k3OMRAuDSx5j/pqvS5ffTbqocxDy5N8f1ScvhN0=;
 b=A9lrbQYpGwWyPg6EsM16e0T64Zrk21bwwuTZ9W8A/XDzALiMMK4QnH4bnzdpHBAqQ2z7MtVYzVtq9tYCgn2PbInihKKysEpZpdKQzHCCgDTZh6O78pNhofUR8c6Yz4474/aBgEUTqSuEmHE40Vl6WqYv8JDawMdfiFLRxp48Dn8=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6445.eurprd04.prod.outlook.com (20.179.232.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 19:50:40 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::d91b:86b1:7d97:944d]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::d91b:86b1:7d97:944d%7]) with mapi id 15.20.2516.017; Mon, 9 Dec 2019
 19:50:40 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v2] arm64: dts: ls1028a: fix reboot node
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: fix reboot node
Thread-Index: AQHVrsESw4ah5znw0UmG0v9WXCnxKKeyNhjA
Date:   Mon, 9 Dec 2019 19:50:40 +0000
Message-ID: <VE1PR04MB6687035009C691D31844C51D8F580@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20191209184644.14057-1-michael@walle.cc>
In-Reply-To: <20191209184644.14057-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce08cba7-a2af-4def-7b48-08d77ce111f3
x-ms-traffictypediagnostic: VE1PR04MB6445:
x-microsoft-antispam-prvs: <VE1PR04MB64458244C962DFC2567EB58B8F580@VE1PR04MB6445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(13464003)(66476007)(4326008)(478600001)(64756008)(66946007)(66446008)(76116006)(66556008)(33656002)(52536014)(186003)(229853002)(9686003)(55016002)(26005)(53546011)(5660300002)(2906002)(54906003)(7696005)(305945005)(81156014)(8936002)(8676002)(110136005)(71200400001)(6506007)(81166006)(86362001)(316002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6445;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsB/40aM/00u7wMeZ3DaKsPoByMxhnYRBkfnac0SgpGWjXsCBRt6yGEen/Bje6LXn7V9xfHn1uECXrhcObsY3ufom+AseW1XX5Ji/YvXnq7Wev37CQkqoLLp+4uAPwKJQSkmeRViA6ItDF4uE3VC9o8Jez4htyBU4C1ZS1acEZ2qqcOilP9hXM23ZAqtpvqtA/ZGXKKfPD2kUe7zxTp2E3wLGkuw5U2yshu/pH2cbyd/Wde3q5+oCkd4h/U8Dqs3MlgnTf+MXpaRbktAOtJgV6rxuc3U7wQHsXGOIO11tTMYYYVq70Qwwu6Y4u23/39mfB/+AFuGiMe5DCgY+DRTohoigqC4FcbUL3gENcYCqxy3EbJzzBhpfmkb5tXbwbSQrq63rhWgp01ypVFe+1t0b0HXXAZT9WjST9WxZclXcakSH70L0Squeg8L6i7quETuHpI4QcSaD2jnKT5Mr4FWF1IdzcYxVVZfSwX/wo9MMyPc95s6oQkIUUeEPOPk5AR0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce08cba7-a2af-4def-7b48-08d77ce111f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 19:50:40.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uk5sKrQqzteuRlDg0QAtG48JrNrfAcqQJqEVw6f8xCF+HcSFq1z1/LgXvObiwrOkEupuGivffiCF41JjCTX3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Monday, December 9, 2019 12:47 PM
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Michael Walle <michael@walle.cc>
> Subject: [PATCH v2] arm64: dts: ls1028a: fix reboot node
>=20
> The reboot register isn't located inside the DCFG controller, but in its =
own RST
> controller. Fix it.
>=20
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>=20
> changes since v1:
>  - add fixes tag
>  - remove "ls1028a-rst" compatible string, because there is no actual
>    driver for it. It just use the syscon driver.
>=20
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8b28fda2ca20..7825550b7cef 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -88,7 +88,7 @@
>=20
>  	reboot {
>  		compatible =3D"syscon-reboot";
> -		regmap =3D <&dcfg>;
> +		regmap =3D <&rst>;
>  		offset =3D <0xb0>;
>  		mask =3D <0x02>;
>  	};
> @@ -178,6 +178,12 @@
>  			little-endian;
>  		};
>=20
> +		rst: syscon@1e60000 {
> +			compatible =3D "syscon";
> +			reg =3D <0x0 0x1e60000 0x0 0x10000>;
> +			little-endian;
> +		};
> +
>  		scfg: syscon@1fc0000 {
>  			compatible =3D "fsl,ls1028a-scfg", "syscon";
>  			reg =3D <0x0 0x1fc0000 0x0 0x10000>;
> --
> 2.20.1

