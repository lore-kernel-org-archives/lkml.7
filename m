Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10DC2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883A520674
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 01:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OqYt9BiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfLEBip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:38:45 -0500
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:35994
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfLEBip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 20:38:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/SD23e+TElT/aWa5ywIyRJqriVxGbRGX6cMKQZy+hcVEbDrg1yifeodIkyo4FCMBz+rhT6evvyc/97m/HVkftgCnXxv38AfmCwsoCawoj0sUmyW/Z17/tUXo6VjY6/aOnOWkDx0A88AZnv2RlPpQ2gqW3NaVKiCv9/WHc8zf8LeRjdtdxjKgzJWZLuf9IlUA55pKwImwsxSVCoIl3EWLhGbcnPiiwnlwI40J5FgjZXA1TzTmjpqtHWvlXMKvrJ4ZPyNB6Hinlv7ohyAwQkM/5LQHGJFRGTkdaAcpmH4vYZKdSEvZQtlacPfx1De19jOGyUksQ0ENSUbkSrc3Q5IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBnpDcN5yK/3mX2A+pTFoqZcr0kZgbfYt+qJs7S99V8=;
 b=ZkNJtR+gj8WZkEJEg/ImBp/QZ0TlI7fu3ZdhxTp6hjsn9DJn/u5HXa0LEO0cjXSGuwop6VRaeogmvLnRFXT3ZR7R6Cjlel68ovZo4JZassG+eBsmxgpU/lh6jQQbUcUbZKdr9xtp3SgdlWucXi6lXwUJ0zTNlEbmZc/MwMcARQW80WYHHjj5dpLPEAmkG4SHYQegh1zTCU5OzR7v4nUj3U4R6VZ31T7or1JhPwlouJLPtwQxzro/sembV0lAdGgGOwgURmSUAYXUO962n34hY1WwzzFsOiP0L1ewvmIImI2fLvd/HbqjzfNxO6/ZtKrZ031ZByeBfotjsfORJ59Whg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBnpDcN5yK/3mX2A+pTFoqZcr0kZgbfYt+qJs7S99V8=;
 b=OqYt9BiW3yWPdL0EneZxRTPLmq5wjR+0CzAAsagtap5JT5K6ZASTX5cruKP8Dmi/Bp+PK5o+JDn9U3Ymw19/5AGuyBhhXNLvCSCwTNoMysXj6BmQuCbsDFmNYf/eTqUggsqHvJpCjn/4DZLKaoPV4CrK1hktR4n/N2yLO8vYnb4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4723.eurprd04.prod.outlook.com (20.176.214.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 01:37:59 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 01:37:59 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH] clk: imx: imx8qxp-lpcg: use
 devm_platform_ioremap_resource
Thread-Topic: [PATCH] clk: imx: imx8qxp-lpcg: use
 devm_platform_ioremap_resource
Thread-Index: AQHVqoum7IH7ZRFDgESKl5wnHnxd3aeqw/Ew
Date:   Thu, 5 Dec 2019 01:37:59 +0000
Message-ID: <AM0PR04MB4481FC4A8FD76A01242424B5885C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575454349-5762-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023E9790323200A4B122445EE5D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023E9790323200A4B122445EE5D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d3936dd-d7d2-4caf-cd09-08d77923c2d5
x-ms-traffictypediagnostic: AM0PR04MB4723:|AM0PR04MB4723:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB47238F3A5623A76AB4820180885C0@AM0PR04MB4723.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(6116002)(2501003)(86362001)(2906002)(3846002)(8676002)(966005)(14454004)(33656002)(478600001)(14444005)(81166006)(305945005)(81156014)(74316002)(71200400001)(8936002)(7736002)(6636002)(71190400001)(229853002)(25786009)(6436002)(110136005)(76176011)(66946007)(54906003)(76116006)(6246003)(4326008)(9686003)(55016002)(99286004)(7696005)(6306002)(66446008)(53546011)(64756008)(66556008)(66476007)(11346002)(186003)(6506007)(5660300002)(26005)(52536014)(102836004)(44832011)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4723;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFEoVQISX54BfRSyEXkUh2aDa/cs6zHWele1TTzedkK2olV59pxAennHBxy2Nva4QVfwLZ4P737CNy8qcH98aNzkIrbwanL2giyGlYEqoD6cFYhNPqjlXyN92rFifWBXJjqMFaZqWuVgfUErL0o317ZcRlFBBIbn8/CG1+hVj5wFTLGa5sMirEHEHGEhMqqif5ytBn2eVFia51ZwwlnzbJL1wu8UU/q1/PxqNnVr3Qw5PHg8lblSlMwapoH+BakJ5MyfZIalb4w37rgQB8xFkTQZO+BjJokknmrbPobVxLC1QTzjftghRqUdUPIIdM6zHR99tbSQwM+ycfIugg1h65/O+mAZsEInplnSZUP3whrC8Bj5F1JcJvu4paxHgDfQUt3MpafatcmHZy+palG7h9AdVT+ZVQ1WG/KKBWG/KB4n7zKThI+nOrR4NQ3Kh7joA04OlCe8kM5Meop7PoPNdOemYXGB25urnAkHhpmnj3G+hXuUO09/s0MO//xnTrBBbyNiF0qL8pPpyaAlmxAhDQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3936dd-d7d2-4caf-cd09-08d77923c2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 01:37:59.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzsFxphH313WphDGJBKw9D+OHvAahXPSj7U2979XVIb2DWwKeyQ8LoGjOyrioVhLgGs3f65KEkhHgm/9tVpjYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] clk: imx: imx8qxp-lpcg: use
> devm_platform_ioremap_resource
>=20
> On 2019-12-04 12:14 PM, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > devm_platform_ioremap_resource() wraps platform_get_resource() and
> > devm_ioremap_resource(), we could use this API to simplify the code.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> This patch has been posted before and it breaks uart on imx8qxp-mek and
> possibly other things.
>=20
> The old and new paths are not equivalent: devm_platform_ioremap_resource
> calls devm_ioremap_resource differs from devm_ioremap by also calling
> devm_request_mem_region.
>=20
> This prevents other mappings in the area; this is not an issue for most d=
rivers
> but imx8qxp-lpcg maps whole subsystems. For example:
>=20
>                  adma_lpcg: clock-controller@59000000 {
>                          compatible =3D "fsl,imx8qxp-lpcg-adma";
>                          reg =3D <0x59000000 0x2000000>;
>                          #clock-cells =3D <1>;
>                  };
>=20
>                  adma_lpuart0: serial@5a060000 {
>                          reg =3D <0x5a060000 0x1000>;
> 			...
> 		};
>=20
> Previously: https://patchwork.kernel.org/patch/10908807/

Thanks. I think at least need to provide some comments in code.

Thanks,
Peng.

>=20
> > ---
> >   drivers/clk/imx/clk-imx8qxp-lpcg.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > index c0aff7ca6374..3f2c2b068c73 100644
> > --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> > @@ -164,7 +164,6 @@ static int imx8qxp_lpcg_clk_probe(struct
> platform_device *pdev)
> >   	struct clk_hw_onecell_data *clk_data;
> >   	const struct imx8qxp_ss_lpcg *ss_lpcg;
> >   	const struct imx8qxp_lpcg_data *lpcg;
> > -	struct resource *res;
> >   	struct clk_hw **clks;
> >   	void __iomem *base;
> >   	int i;
> > @@ -173,12 +172,9 @@ static int imx8qxp_lpcg_clk_probe(struct
> platform_device *pdev)
> >   	if (!ss_lpcg)
> >   		return -ENODEV;
> >
> > -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!res)
> > -		return -EINVAL;
> > -	base =3D devm_ioremap(dev, res->start, resource_size(res));
> > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> >   	if (!base)
> > -		return -ENOMEM;
> > +		return PTR_ERR(base);
> >
> >   	clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
> >   				ss_lpcg->num_max), GFP_KERNEL);
> >

