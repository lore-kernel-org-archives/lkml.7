Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EE32070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehuU7Vmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgAHJY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:24:29 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:57762
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgAHJY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:24:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh0fQb7sUMOChzXDPzmIqMHtU30axxE/Muf/JSFkyPw5SEr8f7O9sTvVUv6tM/QoQPasvQTIpjuck68ural7K/npozc/vNqw9FYx5AkfX+yUCXcelggYlW8tSks/FvgbaD5fC8iL6gFBS0+Bb3qzxqUJPCmWBRSTDR0vIhKTFSJWgpZ3f43p4OBnv92xVtmSXdOwyz50tII9arxaQaP3sHHyKb59DfZRw91Mf1wIrJ2zhH9a6C2RvOxPmWRf4B3Cm8nkgtRI7YTNxsDhoV+iBOWocti69hsqrkbm3yLFmrBxcPYpWokLEHLcGTLBbd7Vf+fXRQWLmRy/IPbiQF6tiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P0BfBckPYteBZ4wnxpx8Pb7QdbPpGw8N4C8ZiEuevg=;
 b=ikQ8/ajqLEKjxTQsKynTmWW/uhXOyzt1ghpOb8wnpzXMIzIIaI+eLJEr4ECcysRlUo34Xx+QIUavdPL1x+ehzNwxIhNiljE1+3lx89hUvt15HHRpkBEvTjeq8jVawbqHy5zHXD52o7xrdv5JxnSaiMCs3EAsoBONx9uQFM2/ZGNeZCPO4TWw4HWJJZa20Sh+kYoaUMKInCdbwQku1iC2NGn3hRIExH88ek0uwI+IQXxmpatHM8SNlmm43H7hM6vuaWA/1b4XcSeMifltOHi4wsBlX/Jgelh/7ajX6sT2xCmodPaQd9NigSjkhI/qIDV7S5Q9Y5pfPvvfXZQJAQAYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P0BfBckPYteBZ4wnxpx8Pb7QdbPpGw8N4C8ZiEuevg=;
 b=ehuU7VmvZb6bXHa8/vzPoe4ZnyLGMDR2URm+vhS51v/IY2lF/W9DY3ZBcpYlHC7j08zKoYpX7JKaZFIHlbL1Y5+6Lw3UL8m4wsuoveCbTu6aWQZlu3tMBqZhu3u1Nl9EIkgTjohTl00k7+wddZLFFCFyOi/InFA5rwuL8mMif6o=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4882.eurprd04.prod.outlook.com (20.176.215.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 09:24:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2602.015; Wed, 8 Jan 2020
 09:24:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Jun Li <jun.li@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board DT
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board
 DT
Thread-Index: AQHVxfVdclGKJZdXA0CpCbMA+bQZVKfgcJZA
Date:   Wed, 8 Jan 2020 09:24:25 +0000
Message-ID: <AM0PR04MB4481882847C1233593E84DE8883E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4454dd86-d085-46cb-28c6-08d7941c8d9a
x-ms-traffictypediagnostic: AM0PR04MB4882:|AM0PR04MB4882:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4882332655AE82F0EB41A824883E0@AM0PR04MB4882.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(33656002)(86362001)(52536014)(6506007)(5660300002)(8936002)(316002)(4326008)(110136005)(7696005)(8676002)(2906002)(66946007)(81156014)(81166006)(66476007)(64756008)(66556008)(55016002)(76116006)(9686003)(66446008)(186003)(71200400001)(26005)(7416002)(478600001)(44832011)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4882;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49+Qs5/hWKThs8j4aiIZ5btnVP6etT0SWUNMKN6j9MV0kYP+bZtxJlNtt0psb2e0uXaeD3hp7J8EEdBUKkk07FjJuZwn2QK26SEdrMenoCjQ5rzPagMNr0brVGeTkC5GyFtybE0ZfEU6EAYMhMkOoQmY7Eogd9lq9m3yNSOLw2qFBF/HbGf+36n6WqL6JcmRUK4txmGpaHTLDlT1hyMo78HvCjIrK1Jv3ABQKwIfO6V5r5Cu0aEOMqn0EMFvfddF8peMnRbvb9oM77p3OUDLHuuufmXl2bLdreWDZDoe1kabfcuzdAYdcdxD8gLwzTwMcIgpYSTAmTLFf5f3lDrtWZK+C/73W32z9oJHaDwZc4n/gcA1LRghSsbFKGsXpzFjcs85Qr+Q9AENiUFn3GHDr6Y2CKCQNNHFjS/UipuSFgz/FIP/tLNU/iUOagbvIR5Vg93IVQYcVAi70FAHiXrhxcMrvtxot4Z80RBoSvlAI28yGo2hm+u9AdaAFNIXlfODsFnoTS5HO5YVaBVPWcyB8Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4454dd86-d085-46cb-28c6-08d7941c8d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 09:24:25.0770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwx3Y9vFk9TXlq5q3mtJa0Sl9SLJ4EafPY6K5GdYHeQav4/ekJ04npPtV/B/eIIPtdrYNwXr8owMKPSSX96p/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board
> DT
>=20
> Memory address/size depends on board design, so memory node should be in
> board DT.

Not sure it really matters, bootloader will update/create memory node of de=
vice
tree.

Regards,
Peng.

>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 5 +++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index cf044dd..9e54747 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -16,6 +16,11 @@
>  		stdout-path =3D &uart2;
>  	};
>=20
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x40000000 0 0x80000000>;
> +	};
> +
>  	leds {
>  		compatible =3D "gpio-leds";
>  		pinctrl-names =3D "default";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index a3d179b..1e5e115 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -140,11 +140,6 @@
>  		};
>  	};
>=20
> -	memory@40000000 {
> -		device_type =3D "memory";
> -		reg =3D <0x0 0x40000000 0 0x80000000>;
> -	};
> -
>  	osc_32k: clock-osc-32k {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> --
> 2.7.4

