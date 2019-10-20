Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB68CA9EAE
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EE821897
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5KHl+cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJTOfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 10:35:54 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:60193
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfJTOfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 10:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/NRTe9QbYqtq+8ebXEIemLMFdeiJtPCKTuuFGQvaF3AO6NTi5T1AOUDpgeoIMsgpBXaWCwO2P0P943WvK6XJpkAGebl5dO0K9mRn4M6Ig4wWrCklnfBIAvE7HhDcjouZcPXww6Pwj5tcwoLnVhh2+phuvd+SIQYh59Q2xbxq18iyb+HHBTVBrAMrq7Fu1r9K+x3m/qcy9CTBowvJA6y4MGx7R1Qg6IvBP5TP9blXGPLxL7nhbetTw4cjPaWQUwaNoUSUqHaTmwE4C2zlnUJzKjICcW6za6oFiLNoz4dORkEakyeUFdsyTDSdUcacWPNKzi6NeYxociFeVM/u2x8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZunBzdSgqBn83vfFWhTnPpKuEPQF6jQl+q0Vn5Js/uo=;
 b=b/cmwZ1z+Wl6eNgBhv5m+bZ+XpztWFGocXSDD6BKhex0v0lp6IgHg+3wcw1SHvy4T95vdikx2YzLCvP/4McHuZ1Vl4JPcZ+5rSjGuHxoBtHyZUmLXHWCfBua7watEoJzThfdQB+j2T0AJX0eD/6cB3eakONDMrLpamt4hZYq3RH28OZD3rrRiaiFqm52+r1WE1oTlZYQtloUJOUQ3gvHOk5SWfFaUe+ffq26P1hUafD587Igsg6pdpK91VsBx+Qcpygvy//KeTsjdDcxebgYsLILi/gRr+PH020Seo30KSmTvLmpelWtHcE3smPUD8dbOGdLGfekqPsB0l33lT0vOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZunBzdSgqBn83vfFWhTnPpKuEPQF6jQl+q0Vn5Js/uo=;
 b=S5KHl+cRFBuMCen/Hht51k5T7zqT5LbG5DzrqNGmEPjOaqGKkVvPYmWw+FAnuPor5Kot2HoB7Z7IDMzppZitPBTUK6v5D99wWpBsaBchObAilvZpRc8UZBEoysOWZYXmNWW0KJ3PzW5bAPfcdSMmIcNgMnHBAePgQkXxqcMvLkQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4644.eurprd04.prod.outlook.com (52.135.149.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sun, 20 Oct 2019 14:35:47 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02%3]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 14:35:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>, Jun Li <jun.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "angus@akkea.ca" <angus@akkea.ca>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        "dafna.hirschfeld@collabora.com" <dafna.hirschfeld@collabora.com>,
        Richard Hu <richard.hu@technexion.com>,
        "andradanciu1997@gmail.com" <andradanciu1997@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Thread-Topic: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Thread-Index: AQHVg8fd9TcILJytHEmYMksBHN4gSadjn8CA
Date:   Sun, 20 Oct 2019 14:35:46 +0000
Message-ID: <20191020143545.we56f4epnbgjr5lw@fsr-ub1664-175>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0073.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::14) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35bc6452-3df7-4ee2-39f1-08d7556acb9d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4644:|AM0PR04MB4644:|AM0PR04MB4644:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4644B26C226E1890CD2135CDF66E0@AM0PR04MB4644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0196A226D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(6246003)(25786009)(66946007)(6436002)(71200400001)(5660300002)(52116002)(76176011)(26005)(71190400001)(6862004)(6486002)(66476007)(66556008)(64756008)(66446008)(386003)(6506007)(53546011)(229853002)(6512007)(4326008)(9686003)(186003)(33716001)(66066001)(476003)(486006)(256004)(6636002)(2906002)(44832011)(54906003)(14444005)(14454004)(3846002)(6116002)(86362001)(102836004)(81156014)(81166006)(7736002)(11346002)(8676002)(446003)(305945005)(8936002)(99286004)(7416002)(478600001)(1076003)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4644;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LN4tolFxqJRH8nh5vr8WB+TS2sD8bkkBeDOL4Cb1t0GiHDhnS+5GcKISAYn3N83hUbyR/MALaoBYshwRyUlVM59seDb+E4jcJR2BRZB4gSoxhBuD8YvhuJWJq9/32gknscFvRl612iB+Qz+4TS6aLvtSsPoyY8Wue+VeSlaRak1ZClJawfi0/VjF2CVGLIzOLrHHXeyxh0KJHN5dqmC9mryiMn6D6RFO6rHdOCyPgY37VtoBBuUAbJl1CSHKOC2CSvqF5mOTJHnCjCmu1PVbc4GhqNhAs0iMDJyVNaRk5zz0ikoQRDxRpI90alwe2yjexpP0TxjI66olTvRTJPXrRLIDsR4cJST1zoC8WRd5uDCtCTjy9ZgegVXfeaxsZxx/MlS99yYVOi+ycbgFhDVpgUBu4oVpyBBkpDvY1Nm7EA4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEBBB76B9937294C881230836D0D6976@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bc6452-3df7-4ee2-39f1-08d7556acb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 14:35:46.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7yG0oOLB3WuPSGrrzplBkEBZ4J03TgkvH3DDwgtxMjpY/9UwgaSQE2bRzPKArHpJU8yCrBvYLeMkJvCslnp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-16 10:14:23, Anson Huang wrote:
> usdhc's clock rate is different according to different devices
> connected, so clock rate assignment should be placed in board
> DT according to different devices connected on each usdhc port.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

For the entire patchset:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi      | 6 ------
>  3 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64=
/boot/dts/freescale/imx8qxp-ai_ml.dts
> index 91eef97..a3f8cf1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
> @@ -133,6 +133,8 @@
>  &usdhc1 {
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> +	assigned-clocks =3D <&clk IMX_CONN_SDHC0_CLK>;
> +	assigned-clock-rates =3D <200000000>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usdhc1>;
>  	bus-width =3D <4>;
> @@ -149,6 +151,8 @@
> =20
>  /* SD */
>  &usdhc2 {
> +	assigned-clocks =3D <&clk IMX_CONN_SDHC1_CLK>;
> +	assigned-clock-rates =3D <200000000>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usdhc2>;
>  	bus-width =3D <4>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/b=
oot/dts/freescale/imx8qxp-mek.dts
> index 88dd9132..d3d26cc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -137,6 +137,8 @@
>  };
> =20
>  &usdhc1 {
> +	assigned-clocks =3D <&clk IMX_CONN_SDHC0_CLK>;
> +	assigned-clock-rates =3D <200000000>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usdhc1>;
>  	bus-width =3D <8>;
> @@ -147,6 +149,8 @@
>  };
> =20
>  &usdhc2 {
> +	assigned-clocks =3D <&clk IMX_CONN_SDHC1_CLK>;
> +	assigned-clock-rates =3D <200000000>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_usdhc2>;
>  	bus-width =3D <4>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot=
/dts/freescale/imx8qxp.dtsi
> index 2d69f1a..9646a41 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -368,8 +368,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
>  			clock-names =3D "ipg", "per", "ahb";
> -			assigned-clocks =3D <&clk IMX_CONN_SDHC0_CLK>;
> -			assigned-clock-rates =3D <200000000>;
>  			power-domains =3D <&pd IMX_SC_R_SDHC_0>;
>  			status =3D "disabled";
>  		};
> @@ -383,8 +381,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
>  			clock-names =3D "ipg", "per", "ahb";
> -			assigned-clocks =3D <&clk IMX_CONN_SDHC1_CLK>;
> -			assigned-clock-rates =3D <200000000>;
>  			power-domains =3D <&pd IMX_SC_R_SDHC_1>;
>  			fsl,tuning-start-tap =3D <20>;
>  			fsl,tuning-step=3D <2>;
> @@ -400,8 +396,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
>  			clock-names =3D "ipg", "per", "ahb";
> -			assigned-clocks =3D <&clk IMX_CONN_SDHC2_CLK>;
> -			assigned-clock-rates =3D <200000000>;
>  			power-domains =3D <&pd IMX_SC_R_SDHC_2>;
>  			status =3D "disabled";
>  		};
> --=20
> 2.7.4
>=20
