Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B9C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A823217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aai8wEzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfKELjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:39:51 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:64054
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730627AbfKELjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:39:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUfiAg3RDemcFq+yecl+tFfpwhSDvEpCot0PYQXvkcvQd4o1xubF0X/qEG/Tw+LvKhVho8vTUqz2j1HCbpL+cv0kVQXj1uGfYQ4PRY/Xky84vEVN9D94shPPEoeERkfNtmBG3S7eBEZDzM5KQrl3bDWZ7thuaFtZJfP1MhUzmDoSjtBTpWXZnIVuxQkYVuxvP9NNWaKcwCeMRgPasoR76vVJaUYofJWVS7d4hzKDWlzjtzvcVqUNacWXJcg6iPnWQPcllfZoSA8JG6a/k++DBGx0AWAntMs+3lc14eL2aTcWq2uTL2qxpJoHKRJPta0DIXdHKwh1ye3q9Nl00Ujfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co10EceoP8k5b6+u8JrWt23Rva32Co8eW5KjxfbTWFs=;
 b=TKRBoUnhl7S3vAnIyeIa23baYPzUvWuNYWNrdXltyl5k7r+iDsQal+Z1OxbdpBQxqUQqeALc2bh7gNhCK8k5m2X7qeu1/DzLMoYXOS8bRadUeVGMPHLU+0sWPfee7382SN4dS7SlURP3erLQKCz2Qpok9TGl1nP79bidX9QodN8L2znCPJ/av9soTLUzYjR/n1oUsXebQ3zdtMomf6b3KW47qTgiXzbjxKiDEcnOWMzYgceHNTGWyoqvMtnmL6HFSqwivBsWr5F/pxpakhllHU0HyAOIpmD04lPkYbSed+zFFpvLl4n21G7aLG2TiPCqgBo7W+rQbWTicspVk2+igA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co10EceoP8k5b6+u8JrWt23Rva32Co8eW5KjxfbTWFs=;
 b=Aai8wEzKlxBb6fFX6HhqQ4263livWhcN4UItPqH5lyVKSsibnj58gA6zKeAxHIGyUIGXqhm4HfZfJSD1fk2PCZP3AiPR06ScnCP9XqfbjPeQzYtzWj6XWPB5T7oi2ouY2/FrVSJtghPf01KlR/iubezWRpNENpvb0K9VypxmxZc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4595.eurprd04.prod.outlook.com (52.135.148.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 11:39:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 11:39:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Topic: [PATCH] clk: imx: pll14xx: initialize flags to 0
Thread-Index: AQHVk6mXpyRie0JbfEaM7Eg+PLW60ad8dBoA
Date:   Tue, 5 Nov 2019 11:39:43 +0000
Message-ID: <20191105113942.hivtjq56cztcqaix@fsr-ub1664-175>
References: <1572938372-7006-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572938372-7006-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:205:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f13fd1d-64bd-4700-c2ce-08d761e4da2a
x-ms-traffictypediagnostic: AM0PR04MB4595:|AM0PR04MB4595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB45956B4A9B0D7339AAB5EE42F67E0@AM0PR04MB4595.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(86362001)(476003)(478600001)(5660300002)(81156014)(6436002)(1076003)(44832011)(14454004)(486006)(25786009)(33716001)(6636002)(71190400001)(305945005)(71200400001)(7736002)(11346002)(9686003)(6506007)(6512007)(99286004)(229853002)(102836004)(53546011)(52116002)(6486002)(76176011)(316002)(2906002)(386003)(54906003)(6246003)(4326008)(256004)(66476007)(66556008)(66946007)(64756008)(66066001)(66446008)(446003)(6862004)(8936002)(81166006)(186003)(26005)(8676002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4595;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/4u+rp8zQSd//r8VrB23fQaWXUEjgYThgYEqkBN5iY8uEYo2hjUkqbEsbUxezHzUwv0Yp8BFJOiG0gd5IMQBvDLAufoU0DrIbKShuyFVw+CITKuT1hNt+ANkSvm1jrcT1Vg/uVce92UdyJFwAq/FHK7/vFEs2ly4uRCLC40rzptebv9lubNL74WBGqKnUkIAbbnMHJQHHRE1hDjOgI6XynPZy4CFXYL43/0asOuTn/eXDD1j1FJibJWxlJ4rz/vPr8AQx8yzbgHAzuSOMRcxzs/3pgrYxl6u/fqZhMoj5ArReh/ZkqwshSNkOSDsnhxGT19N1FoKci1vSDLilTm7V1eJu+XH3P5CSUC6ldUlNkaBoTCagxVUUZHgSFAxVpnsWbIWFWSPvuCW960WsM44V5w5r2zZ8xVm66vvv3v5lSrwUOvW4pQFVsUDkFkbjgN
Content-Type: text/plain; charset="us-ascii"
Content-ID: <822144FEAF0B9C44929279CD056F3D87@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f13fd1d-64bd-4700-c2ce-08d761e4da2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 11:39:43.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5fEDKjSNHKUW/5rtGTbpTw7yOhNMaVJ87BwOMbRDvuc3zrrRgCfVTIWNY9N3gYzNsiB9E64kRWAYt0EfZxEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-05 07:21:08, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> init.flags is initialized with value from pll_clk->flags, however
> imx_1443x_pll and imx_1416x_pll are not static structure, so flags
> might be random value. So let's initialize flags as 0 now.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-pll14xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c
> index fa76e04251c4..a7f1c1abe664 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -65,12 +65,14 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
>  	.type =3D PLL_1443X,
>  	.rate_table =3D imx_pll1443x_tbl,
>  	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
> +	.flags =3D 0,
>  };
> =20
>  struct imx_pll14xx_clk imx_1416x_pll =3D {
>  	.type =3D PLL_1416X,
>  	.rate_table =3D imx_pll1416x_tbl,
>  	.rate_count =3D ARRAY_SIZE(imx_pll1416x_tbl),
> +	.flags =3D 0,
>  };
> =20
>  static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
> --=20
> 2.16.4
>=20
