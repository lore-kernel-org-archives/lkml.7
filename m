Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC47C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A414222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RMmVC9GP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKMMQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:16:38 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:18262
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfKMMQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:16:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpnhJWZhgBQSXCu9yl7nK6tJMYKBQYtM8MvYmbBC7jh4V5cyqD9OU3/NAx2LdO6nXSmXefYFqeiuRoDkteTvbkLpLwtoP342k/wCppC6zg4NwNlj9PKrnYgU/EhP2OfQGEcfiITiKmhshIP9dmWCRcw4tyyRINJFXvGlJ6nSV+91lfd19vTQvgtcqsppcoAHbAag5WPW2Pz1rscecRg3d24YOVpuL0MDsA7QagJElrKitame+AEFTvqOAu7e+A5IoxzaCqzDOjKqk+M6jqeQ0Ff+lpA/EUgn6vGpLavcN9u3FKpmUFBzzflS99IMfC4KkUgdRBQYSk96eyFmQgwdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgGnlizYGK4KP1AejEyXY6WM5lwcXacZ05ifzCLVxBg=;
 b=J5nRbrbdFjQObUCH5PFfnR1LVH+aWToj6ZPswgzcB/ztJdmk2hag0EJ+w4i6bOjcZjTMJDSC+TttZ5JaeNrUjvwIKKSd4YK1ICmQ0PEb07wqq3OeInaSqnt6wyaY0bxAP7er3aQrCnYXf4RjIqRdEuJOceCOk5/yHABHNR1KWDuno8GUZzSh+NbGmZ8QnxlbC0aqqYUxifS13pVkOY3Ai95KHC3lK5/rTAW7Hgmn2JT3A7ccLNkpAUz8dqYDPd/WabISU+qY+9d4dNYg+P2GPDBEOl+RuNzmsoul0fEHDIVfcvuPAtBjonfMljy0w7Zd8zb3CwtYYLfGtK60jlwKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgGnlizYGK4KP1AejEyXY6WM5lwcXacZ05ifzCLVxBg=;
 b=RMmVC9GPfad42kSmCyncfcTPzAvQUZKpEyn3lFSKQlZfoeUeWRQu8C4568fYeBN8i8mfSXn6ZED9EfA3C7zPR2/ktkvcmi21RbjtIqENmTP4/JBDA0WJXIGgMDI/yMvG1cIYDRewsS4/td4kaHAWJMoZ5Hzjx1MoXa4AUToFM2Y=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5280.eurprd04.prod.outlook.com (20.177.51.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 12:16:33 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:16:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Topic: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Index: AQHVmfO4UT5wBnIiNkiEwV6EPli0Lg==
Date:   Wed, 13 Nov 2019 12:16:32 +0000
Message-ID: <VI1PR04MB7023CD16303E0CB6F524313DEE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1573629896-23954-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab9a7a5a-2e50-468e-aa13-08d768335263
x-ms-traffictypediagnostic: VI1PR04MB5280:|VI1PR04MB5280:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52809892D53551A3690A4604EE760@VI1PR04MB5280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(189003)(199004)(26005)(316002)(256004)(110136005)(86362001)(6116002)(102836004)(6436002)(3846002)(99286004)(25786009)(478600001)(71190400001)(74316002)(71200400001)(305945005)(4326008)(54906003)(966005)(486006)(81166006)(81156014)(6246003)(14454004)(8936002)(7736002)(8676002)(44832011)(2906002)(2201001)(446003)(9686003)(52536014)(55016002)(33656002)(2501003)(66946007)(5660300002)(76176011)(229853002)(6306002)(186003)(476003)(6506007)(53546011)(66066001)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5280;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkK6z7/mR/nsplt7rUoaA5SXjVH0DlcZswIhts+2j5c+gAWvll2mJPjgUlxL5hp8Ol12drjR3hrKcDw4upB+svOgNo5ElRpjCdXMkWk0VQoVHOlD8bp/Mbapyv7ssfon/Y7FpMKtufMBVbEWC6TZeAmZdkEspE4x4j6lP6UIuCahzE8yJwjFXDOFpVfAYri+LUeo3nhoWDR7jj2DnvhxovpxamnwN8I3AA11UH122Nzx1OEzXIP0K/izgn+b5JD715A8pjP0Gnu/oxF+RE05BoMRUiDhMsiFoXyqVs6Xh+5S39h3ltsgxFj1P1bU4Zel15C4BFi009ZkT5rQxQAexH3tLmzJ0gshNnUSdmNUa01CFcgKNvZK6Xiv9gzYAIQANt0sYLB9x+QyrV5FrK0DCP7sSITmk8m1MzFgkeJ0cnC8oooN558cKWVvaIg+5Yd72HpfssI0yneVJujSoL6xe8nGu5k6VmLgf9yWqNqZvXE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9a7a5a-2e50-468e-aa13-08d768335263
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:16:32.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLGuyh5fPOZun7mUCBgcMlQpvsyUdvJ02T3RvhWCCWoJxaYY+Ai2j7eeOT3EF2FRafLeV5/XxLOUdbTscivmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2019 09:26, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Introduce imx_clk_hw_pll14xx_flags, then no need to add new=0A=
> imx_pll14xx_clk variable for new flags.=0A=
> =0A=
> Since the original imx_pll14xx_clk flags is not used, so drop it.=0A=
> =0A=
> Signed-off-by: Peng Fan <peng.fan@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
Most other imx clock wrappers take flags as an argument so it's nice to =0A=
be consistent.=0A=
=0A=
> V1:=0A=
>   Based on https://patchwork.kernel.org/patch/11217889/=0A=
=0A=
In general if you sent patches on top of patches it makes sense to =0A=
resend as a series. That clk_hw series is not in yet.=0A=
=0A=
>   drivers/clk/imx/clk-pll14xx.c | 12 +++++++++++-=0A=
>   drivers/clk/imx/clk.h         |  7 ++++++-=0A=
>   2 files changed, 17 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c=0A=
> index 2bbcfbf8081a..a8af949f0848 100644=0A=
> --- a/drivers/clk/imx/clk-pll14xx.c=0A=
> +++ b/drivers/clk/imx/clk-pll14xx.c=0A=
> @@ -379,6 +379,16 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, =
const char *parent_name,=0A=
>   				  void __iomem *base,=0A=
>   				  const struct imx_pll14xx_clk *pll_clk)=0A=
>   {=0A=
> +=0A=
> +	return imx_clk_hw_pll14xx_flags(name, parent_name, base, pll_clk, 0);=
=0A=
> +}=0A=
> +=0A=
> +struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,=0A=
> +					const char *parent_name,=0A=
> +					void __iomem *base,=0A=
> +					const struct imx_pll14xx_clk *pll_clk,=0A=
> +					unsigned long flags)=0A=
> +{=0A=
>   	struct clk_pll14xx *pll;=0A=
>   	struct clk_hw *hw;=0A=
>   	struct clk_init_data init;=0A=
> @@ -390,7 +400,7 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, c=
onst char *parent_name,=0A=
>   		return ERR_PTR(-ENOMEM);=0A=
>   =0A=
>   	init.name =3D name;=0A=
> -	init.flags =3D pll_clk->flags;=0A=
> +	init.flags =3D flags;=0A=
>   	init.parent_names =3D &parent_name;=0A=
>   	init.num_parents =3D 1;=0A=
>   =0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index cd92d9fdccf4..c2851a82b4fd 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -48,7 +48,6 @@ struct imx_pll14xx_clk {=0A=
>   	enum imx_pll14xx_type type;=0A=
>   	const struct imx_pll14xx_rate_table *rate_table;=0A=
>   	int rate_count;=0A=
> -	int flags;=0A=
>   };=0A=
>   =0A=
>   extern struct imx_pll14xx_clk imx_1416x_pll;=0A=
> @@ -105,6 +104,12 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, =
const char *parent_name,=0A=
>   				  void __iomem *base,=0A=
>   				  const struct imx_pll14xx_clk *pll_clk);=0A=
>   =0A=
> +struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,=0A=
> +					const char *parent_name,=0A=
> +					void __iomem *base,=0A=
> +					const struct imx_pll14xx_clk *pll_clk,=0A=
> +					unsigned long flags);=0A=
> +=0A=
>   struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,=
=0A=
>   		const char *parent, void __iomem *base);=0A=
