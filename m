Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFA3C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6D2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NUVysX37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfLDOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:24:25 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:11852
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbfLDOYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1keSxXBbCq870iTf4OuCpMdSdYS5aV+iphwTPjvTMhWyfbXOStKuRneOcgr9zGpefIuVc64Xzsa63BgCtVnpZ6+XoozuHMqfhcJznsu6p0Oj6kgxyriFni07GYI6pVZb8hBnE8qEatnIPxaltsxGIt60CD/8lFgF3j9Cf7jSfTlkt2zTRf9Z0E4fhh3nDC6zsH1hJ+eOlYwXZGvdyD2nwEmUaQsa4ZANM+l+1zgy1cPeuS/A9pIDTRoHA35Hy0FdqnOMBdC5w1r0f4lPPdQ3UDa9FO8SODeWBkxcEnIjoXJ5RwfEgsUkUDXQQkqNbWjHRNm2nJDDs2ioaIMB4iRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7j7aJXfTDk/nWSdaitOd5xH+tnOTAj2jBBJxWViXyg=;
 b=iU6oXiCXdNq2Ei28RXXekmwPT3llKLKPVv5JcOqhKXjUSC9Lb3yM4mvM2Ra4ewGKP6IQze5ld+w6QyFbOJ6CHEY5GEfYpgdD16gy2PsdwJAy7jbVjDpuuJn3EaTeMhxuiAI8ayam/DLc6zaAKJO0CSCAjabuCg9vtA5Q/wTcFlXyHwu+U7nNjZ1DrKStvpZvyudFFINd/Hq8CdR7ufj6RjqyAgJ2pu86zAPXICP34CjTdiZ64jnZW+1BMZ+dCukw/aj32naA0gp7nEMNYNLcpvE5miAzqF+PYBsdpTK2u5v/dWFleJBbvrbyNCdGlhVKVbJbgbWxxhPKRRMpL3bO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7j7aJXfTDk/nWSdaitOd5xH+tnOTAj2jBBJxWViXyg=;
 b=NUVysX37Sby2dHLjGFU8Lmcggpg8cYkcpKwo28HMnzDi/cHFzIgC+bS1kpxMlhtRxkpT+aEs1FeHrZaGcNtfuhULOsSvjXMQIeh/U4YdfvWxvMB2qO6ZIr7urNceu/DNX76/pUGkCQ0qEFDRTW+ABX7WctBwhmqZn1oSU/mzcdM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4608.eurprd04.prod.outlook.com (20.177.56.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 14:24:19 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2516.013; Wed, 4 Dec 2019
 14:24:19 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Subject: Re: [PATCH] clk: imx: imx8qxp-lpcg: use
 devm_platform_ioremap_resource
Thread-Topic: [PATCH] clk: imx: imx8qxp-lpcg: use
 devm_platform_ioremap_resource
Thread-Index: AQHVqoum7IH7ZRFDgESKl5wnHnxd3Q==
Date:   Wed, 4 Dec 2019 14:24:19 +0000
Message-ID: <VI1PR04MB7023E9790323200A4B122445EE5D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1575454349-5762-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee1fab81-8c6b-4fe7-3af1-08d778c5a6a3
x-ms-traffictypediagnostic: VI1PR04MB4608:|VI1PR04MB4608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB460809EF836DC2D628C2BEE9EE5D0@VI1PR04MB4608.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(44832011)(2906002)(110136005)(54906003)(99286004)(4326008)(7696005)(76176011)(74316002)(7736002)(305945005)(66946007)(91956017)(76116006)(6246003)(6436002)(64756008)(66476007)(66556008)(55016002)(53546011)(6506007)(316002)(26005)(66446008)(6306002)(9686003)(8676002)(81156014)(229853002)(102836004)(186003)(81166006)(25786009)(6116002)(3846002)(52536014)(71200400001)(71190400001)(8936002)(33656002)(5660300002)(14444005)(86362001)(966005)(2501003)(6636002)(14454004)(478600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4608;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbQAC+A+DuR0xMs7mdzvhEKlr7Kns14iWW2PldxawYoIPEbYXhqI032vEVrwpMGP8DvuA+6j+/ydsmQCxkCSd1OPliguA53CbUEsL491pE2IOtdVqWUFRhA9rWB/BqjqldmPwwFaRI2hSpfAYgW5Jjx1ivqR5rOzUiPiiCcaik5dM5kWja0e5mI92Le5JJwNITNdHlMiwk7TVE6XjJxAbBnVmCPIUslV376x7J5ZnC8BQpxDaKeig2UNwDPL1PM9ukNBiQH9zHsjTPt492VV7OVgwKd5qe+XzAFYtb0tlQ+p2IV68sFqjjmKy4GaxtUVxlAOYm/rBgsgpq70DAuFLZWiJdEg7ZiTLgJC+APgrQ7tlfTe4fW1VxlMl6NDqIj46o/mQkCO6Fzh3ijykaTXsSsK6vGhnmJhpTnj5/LPksqMt02/iTRCq8x9QUFgkeyto5yIbytqX7OyT6o9OvkMjzbIeT2uvQwq6Cq3WLrxou88OLzr8vroN2uqN9olKwkS/EDZw7NjJ1/SPT4bsoMdHw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1fab81-8c6b-4fe7-3af1-08d778c5a6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 14:24:19.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBgNrtTyFOcyH4cB8tQbFr8xiFawxnwJUK7O9yERsVUD5nA1aPYUo/ELpENXbRcfl+lTOJ6+rn1Vn2D2sQ2S/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-04 12:14 PM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> devm_platform_ioremap_resource() wraps platform_get_resource() and=0A=
> devm_ioremap_resource(), we could use this API to simplify the code.=0A=
> =0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
This patch has been posted before and it breaks uart on imx8qxp-mek and =0A=
possibly other things.=0A=
=0A=
The old and new paths are not equivalent: devm_platform_ioremap_resource =
=0A=
calls devm_ioremap_resource differs from devm_ioremap by also calling =0A=
devm_request_mem_region.=0A=
=0A=
This prevents other mappings in the area; this is not an issue for most =0A=
drivers but imx8qxp-lpcg maps whole subsystems. For example:=0A=
=0A=
                 adma_lpcg: clock-controller@59000000 {=0A=
                         compatible =3D "fsl,imx8qxp-lpcg-adma";=0A=
                         reg =3D <0x59000000 0x2000000>;=0A=
                         #clock-cells =3D <1>;=0A=
                 };=0A=
=0A=
                 adma_lpuart0: serial@5a060000 {=0A=
                         reg =3D <0x5a060000 0x1000>;=0A=
			...=0A=
		};=0A=
=0A=
Previously: https://patchwork.kernel.org/patch/10908807/=0A=
=0A=
> ---=0A=
>   drivers/clk/imx/clk-imx8qxp-lpcg.c | 8 ++------=0A=
>   1 file changed, 2 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx=
8qxp-lpcg.c=0A=
> index c0aff7ca6374..3f2c2b068c73 100644=0A=
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> @@ -164,7 +164,6 @@ static int imx8qxp_lpcg_clk_probe(struct platform_dev=
ice *pdev)=0A=
>   	struct clk_hw_onecell_data *clk_data;=0A=
>   	const struct imx8qxp_ss_lpcg *ss_lpcg;=0A=
>   	const struct imx8qxp_lpcg_data *lpcg;=0A=
> -	struct resource *res;=0A=
>   	struct clk_hw **clks;=0A=
>   	void __iomem *base;=0A=
>   	int i;=0A=
> @@ -173,12 +172,9 @@ static int imx8qxp_lpcg_clk_probe(struct platform_de=
vice *pdev)=0A=
>   	if (!ss_lpcg)=0A=
>   		return -ENODEV;=0A=
>   =0A=
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);=0A=
> -	if (!res)=0A=
> -		return -EINVAL;=0A=
> -	base =3D devm_ioremap(dev, res->start, resource_size(res));=0A=
> +	base =3D devm_platform_ioremap_resource(pdev, 0);=0A=
>   	if (!base)=0A=
> -		return -ENOMEM;=0A=
> +		return PTR_ERR(base);=0A=
>   =0A=
>   	clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,=0A=
>   				ss_lpcg->num_max), GFP_KERNEL);=0A=
> =0A=
=0A=
