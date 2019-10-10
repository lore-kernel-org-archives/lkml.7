Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B861214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MRUNDfqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfJJWbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:31:21 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:7045
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfJJWbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AewdmOUQ0tSDNLZYYFm4STu1CbIVIAHhlfQH+R8V5S4UxK7FbhweS3LOZqdlRA30bA6kOUvzmXfTr2nw88CjmiiXzVEGJpoH4X2Bxn1krhg5fLotshaEfnqsFMJvqPeRRCGEl1ob2PiQRejdf+bbMTZ3Rd4zhRhPZkoTAFqtECd9/Xctrm+nXN05GI7lEOc38efGmicgp8e/xujfb+ZJ5lYCK6189SfetijJd6XdAcPSbu+mA2rXjADezCafdQuqw8/YkKjWLoAXCxaLGNIgjEzshYh9ffdWMPZds0gCexBk7xC4sEtkJJ3p2MYQYcpgHlTGjDR4PtXqcc1hTAdztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnN/7CJrC76VnTCk66pmfUbRG8pLOyVhaJQYFwMrhNE=;
 b=KrtkhNoLP0NJBDtKDwKy7XfNtq2nOVkd/wEgJPw65x0lPx0CVwwLWWVhqmV70Im17lYnaDec9GIZ+FA37tbiHPuxtchlZ1Lic62jxkRYvstK5FKm5c7PC9hgU7cxZfaSTr5sLmuB+KMb+9Sq9OjQfdyF4h479LfudlrRbSGoTX2PLgO8L/iyUeM5Sdmo58uwDptWvTlOMWzXikpFwmtR0lyooF80WBeu6Zv5Zb98SnvuGO/DrvHQPm0aosAB94ehuB9OLmjH9AuW0p5ZKFAAmRUbm6Zf9guWL+o+sUTl6XtImRz+isGdsBR/pYpsqhxITl+zU5YnSYIrAZuV2CK6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnN/7CJrC76VnTCk66pmfUbRG8pLOyVhaJQYFwMrhNE=;
 b=MRUNDfqm1vDpKcpAj8DLJo77YCEDGFkn8OkIphgg9Q9JqP7yIFGpMDvT4r/jDmYvS3tSUbNSyBM0FOD1ubPNmJ1p3qmf+N90G3om1keQi9p4nuzrEvxrWz3X50h27JLH90fxjpO6MQQTxyT47X3O06ZKtfrRCCmchPIDAIly8uY=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6639.eurprd04.prod.outlook.com (10.255.118.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 10 Oct 2019 22:31:16 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::c93:c279:545b:b6b6]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::c93:c279:545b:b6b6%3]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 22:31:16 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Andy Tang <andy.tang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [PATCH v2] arm64: dts: ls1028a: fix a compatible issue
Thread-Topic: [PATCH v2] arm64: dts: ls1028a: fix a compatible issue
Thread-Index: AQHVf0brHYC8TgXW1EGDttx7++luRKdUdjcw
Date:   Thu, 10 Oct 2019 22:31:16 +0000
Message-ID: <VE1PR04MB6687C0E8739C82D1DAFC71D58F940@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20191010083334.7037-1-andy.tang@nxp.com>
In-Reply-To: <20191010083334.7037-1-andy.tang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b802e09c-64b9-48ed-a286-08d74dd190c3
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6639:|VE1PR04MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6639E67272C69A7001D208DC8F940@VE1PR04MB6639.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(13464003)(189003)(199004)(55016002)(8936002)(8676002)(9686003)(6436002)(7736002)(6116002)(11346002)(25786009)(446003)(486006)(476003)(66066001)(6246003)(81156014)(4326008)(86362001)(26005)(14444005)(66446008)(3846002)(71190400001)(71200400001)(81166006)(256004)(14454004)(66946007)(186003)(76116006)(5660300002)(102836004)(64756008)(66556008)(66476007)(2906002)(6506007)(53546011)(2501003)(110136005)(54906003)(74316002)(52536014)(99286004)(229853002)(305945005)(478600001)(33656002)(316002)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6639;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZqcARqLaMF5Hte8a3gstWR7f33ki+MMV+X4Gn4zqP7u1bZOXYRYgxHV8I4Cam9yozZFK8ADs8rZHPYQFY8cw4suQpLb3kuIfwBDvv5089U7MdO6MN7gGM7bqXYcYHyIAr2ANrlN6dmj3xBF7kby6MizVI3MR+Rlf+Q+vtD4d/h+Rq/gBkZ6VmAP5EVK62svka01nTL8utftZGMEg0hNCg6EW/+oGA/iMleG9ORIaDstR9kwEEHPrifPLWK1DMGIGK6ciWXkyp/TWRZ0ZxqSHt/xg88O6p59YtO+xjln5oNHm28zdlQ3SPcMTpdMUYeK9vvFJ+I3BpJWY/zDUAQ9W3n+gt434zBOGcwe8Be28nW8fQ883a6kr0isZS0A4dReUShyJkLYb4X84nLqiKzdujcf5J/cevvDKozo26mGvtQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b802e09c-64b9-48ed-a286-08d74dd190c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 22:31:16.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bu858TigHGrFGhBTyL6okp9rIxeQQxBVTnapFT0u1TV5A72uWD1b0HpDS82BLHIy0is2Y6c5nsafkgRk7Q/hew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yuantian Tang <andy.tang@nxp.com>
> Sent: Thursday, October 10, 2019 3:34 AM
> To: shawnguo@kernel.org
> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
> <andy.tang@nxp.com>
> Subject: [PATCH v2] arm64: dts: ls1028a: fix a compatible issue
>=20
> The I2C multiplexer used on ls1028aqds is PCA9547, not PCA9847.
> If the wrong compatible was used, this chip will not be able to be probed
> correctly and hence fail to work.
>=20
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
> v2:
> 	- refine the description
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 5e14e5a19744..f5da9e8b0d9d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -107,7 +107,7 @@
>  	status =3D "okay";
>=20
>  	i2c-mux@77 {
> -		compatible =3D "nxp,pca9847";
> +		compatible =3D "nxp,pca9547";
>  		reg =3D <0x77>;
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> --
> 2.17.1

