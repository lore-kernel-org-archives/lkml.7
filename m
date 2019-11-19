Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4EC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE616222F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S0fK+1Za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfKSQcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:32:33 -0500
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:57078
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727299AbfKSQcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:32:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnU7+JqXtGw5TKHrfJ5cebMN6FgpRqT2zrFW2B/ib8b2gqFLvnObhkdyJhk4zlDd19SWKSLkLQbubdSjH0zWsT0marHDeqQSlv/NvZ655Dnfr9OpCF5zJ8xYxG3xuMVRkn2Ov1cqhlFluUSFCBdKJE1Z/phJqliGqT/5wHTmFTH3vi61roOHOuXinlxWEhKrWPBB8t82DmDTzqNze0FM4X4gDOD/CYSmS1k1S6oeC0Iyxs+Ry2UGLzKVnFqmR77mU/QDtm0dIw6bLdr3Mk0cfOSgPhhqhyXQ1CFZNRLoxGmNpyUzSFdlgq4g3e+eojhgJaji0Bq1jN3+3ekci9MzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8H5EYfKGTwvH5MfYXExnVjcRuozl4n4nEalVrilFxw=;
 b=MHr+QgAtRqljhr6orJzWNHoxU4JhkftdmjqlMIhfoiNuHQ7/rvw2p3cJgsQYCzmhW30A2GthSZ3cXpw2JkU+m8u8RZFdi65UynFOsyrH1+xahleGYrC7ieErmzgVpc/u2h07Uhw4ZHXmiot2MlSMNkCBTfvnwksIEV3QN6FXQnT8DVNmLhyNIkUGPuSQGvgEM9mXax7HsuJN9dSWhz9H5C5McrZ03vy2tIIIjEwvmOA9JKPLqnccuv9xOBlE1EQTE0JEXd5Wrf+EPmZeyzG83PGU+bLHWRddkY9WQNseLyrDcie+akO/Qa6i9lUo06a01xXKTZT4TKnlVhcVPPjl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8H5EYfKGTwvH5MfYXExnVjcRuozl4n4nEalVrilFxw=;
 b=S0fK+1ZaUQn2s4Bj4KXIaZt3KjoKXh0P9z8SpfEeGOjB+/xy55rmt47k+abfzYtNVh9z4rLO3lF99Jb5a+c9TXTdBNBdGH0+L4Fmh1q5S4l5hy167IdKoFJIETcYo6CCFr4KAGpq4z6XcEoImHHnYDy5CrdSyQRuQOAgV0xa+cM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4351.eurprd04.prod.outlook.com (52.134.122.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 19 Nov 2019 16:32:27 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:32:27 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] clk: imx: Rename sccg and frac pll register to
 suggest clk_hw
Thread-Topic: [PATCH 5/9] clk: imx: Rename sccg and frac pll register to
 suggest clk_hw
Thread-Index: AQHVnuLaLySjs9P8E0eseKYJ9/xfoA==
Date:   Tue, 19 Nov 2019 16:32:27 +0000
Message-ID: <VI1PR04MB702360DD60D297B19F346B7FEE4C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
 <1574172496-12987-6-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 797010f2-4026-4d44-6531-08d76d0e10eb
x-ms-traffictypediagnostic: VI1PR04MB4351:|VI1PR04MB4351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB435193A81862390CF8D4BA83EE4C0@VI1PR04MB4351.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(316002)(6436002)(256004)(5660300002)(9686003)(229853002)(52536014)(7696005)(8936002)(55016002)(76176011)(4326008)(54906003)(110136005)(86362001)(8676002)(81156014)(81166006)(99286004)(6246003)(186003)(4001150100001)(478600001)(26005)(66946007)(102836004)(64756008)(91956017)(66446008)(76116006)(53546011)(6506007)(446003)(66556008)(66476007)(71200400001)(71190400001)(305945005)(74316002)(25786009)(486006)(33656002)(7736002)(3846002)(476003)(6116002)(14454004)(66066001)(44832011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4351;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NC2YCxtS7C7v2b+qIWCSVVNsvW7DqydGmv50WFswLj8zF/oRXekq9bb6JcMhTTqEBDDekCRwAqHEdcRrTVKSR6Gs9+4knfehTHJaSmwrNCcOhl1mGW2IUgEUSozBze8UzKJIeti/vT6ugscGGiModHgmxET3lWp2mlP40TaL1ZOPpItshO6yFQzkHuC7AT+qX8JPx0T00pqZOsAVyRI6iLN9tauyj2Mx5C6K4bkAi8XPzoU+q+h5w86FEAygOZtmeUteohYTz0Hbq2Jx1GHQT/IguW9RjRpPhIVeGwIS598BYjj8T6/DP8sedJ+l4Zb0g1ioTrx606D7R4y4V83+39l4bs2eZy3CrFgwZNftHjW6zCTIOgA+Bq7NEnL9XQ+dRkg7iOVvozn+j9FNqSTwdmGUe5Be+jP3DpIQkgGOo2tK7xDsmDBu+uhW7h22shEV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797010f2-4026-4d44-6531-08d76d0e10eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 16:32:27.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqSLlQ6l68t3C/gD99wBcRL8sjAFsCXLvtdUEEeG+2bv/DG32A8k+6CSDMkRE/x4yVANh3BVdD98ezN2oDyitQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4351
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 4:08 PM, Abel Vesa wrote:=0A=
> Renaming the imx_clk_frac_pll and imx_clk_sccg_pll register functions to=
=0A=
> imx_clk_hw_frac_pll, respectively imx_clk_hw_sccg_pll to be more obvious=
=0A=
> that they are clk_hw based=0A=
On a somewake unrelated note there is no "SCCG", reference manual refers =
=0A=
to this as "SSCG": "Spread Sprectum Clock Generator"=0A=
=0A=
These wrapping macros don't correctly forward null or error either.=0A=
=0A=
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>=0A=
> ---=0A=
>   drivers/clk/imx/clk-frac-pll.c |  7 ++++---=0A=
>   drivers/clk/imx/clk-sccg-pll.c |  4 ++--=0A=
>   drivers/clk/imx/clk.h          | 12 ++++++++++--=0A=
>   3 files changed, 16 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pl=
l.c=0A=
> index fece503..101e0a3 100644=0A=
> --- a/drivers/clk/imx/clk-frac-pll.c=0A=
> +++ b/drivers/clk/imx/clk-frac-pll.c=0A=
> @@ -201,8 +201,9 @@ static const struct clk_ops clk_frac_pll_ops =3D {=0A=
>   	.set_rate	=3D clk_pll_set_rate,=0A=
>   };=0A=
>   =0A=
> -struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,=
=0A=
> -			     void __iomem *base)=0A=
> +struct clk_hw *imx_clk_hw_frac_pll(const char *name,=0A=
> +				   const char *parent_name,=0A=
> +				   void __iomem *base)=0A=
>   {=0A=
>   	struct clk_init_data init;=0A=
>   	struct clk_frac_pll *pll;=0A=
> @@ -230,5 +231,5 @@ struct clk *imx_clk_frac_pll(const char *name, const =
char *parent_name,=0A=
>   		return ERR_PTR(ret);=0A=
>   	}=0A=
>   =0A=
> -	return hw->clk;=0A=
> +	return hw;=0A=
>   }=0A=
> diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pl=
l.c=0A=
> index 5d65f65..2cf8748 100644=0A=
> --- a/drivers/clk/imx/clk-sccg-pll.c=0A=
> +++ b/drivers/clk/imx/clk-sccg-pll.c=0A=
> @@ -506,7 +506,7 @@ static const struct clk_ops clk_sccg_pll_ops =3D {=0A=
>   	.determine_rate	=3D clk_sccg_pll_determine_rate,=0A=
>   };=0A=
>   =0A=
> -struct clk *imx_clk_sccg_pll(const char *name,=0A=
> +struct clk_hw *imx_clk_hw_sccg_pll(const char *name,=0A=
>   				const char * const *parent_names,=0A=
>   				u8 num_parents,=0A=
>   				u8 parent, u8 bypass1, u8 bypass2,=0A=
> @@ -545,5 +545,5 @@ struct clk *imx_clk_sccg_pll(const char *name,=0A=
>   		return ERR_PTR(ret);=0A=
>   	}=0A=
>   =0A=
> -	return hw->clk;=0A=
> +	return hw;=0A=
>   }=0A=
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h=0A=
> index 71b21ab..15c6f54 100644=0A=
> --- a/drivers/clk/imx/clk.h=0A=
> +++ b/drivers/clk/imx/clk.h=0A=
> @@ -115,6 +115,14 @@ extern struct imx_pll14xx_clk imx_1443x_pll;=0A=
>   #define imx_clk_pllv2(name, parent, base) \=0A=
>   	imx_clk_hw_pllv2(name, parent, base)->clk=0A=
>   =0A=
> +#define imx_clk_frac_pll(name, parent_name, base) \=0A=
> +	imx_clk_hw_frac_pll(name, parent_name, base)->clk=0A=
> +=0A=
> +#define imx_clk_sccg_pll(name, parent_names, num_parents, parent,\=0A=
> +				bypass1, bypass2, base, flags) \=0A=
> +	imx_clk_hw_sccg_pll(name, parent_names, num_parents, parent,\=0A=
> +				bypass1, bypass2, base, flags)->clk \=0A=
> +=0A=
>   struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,=
=0A=
>   		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);=0A=
>   =0A=
> @@ -124,10 +132,10 @@ struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type=
 type, const char *name,=0A=
>   struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,=
=0A=
>   		void __iomem *base);=0A=
>   =0A=
> -struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,=
=0A=
> +struct clk_hw *imx_clk_hw_frac_pll(const char *name, const char *parent_=
name,=0A=
>   			     void __iomem *base);=0A=
>   =0A=
> -struct clk *imx_clk_sccg_pll(const char *name,=0A=
> +struct clk_hw *imx_clk_hw_sccg_pll(const char *name,=0A=
>   				const char * const *parent_names,=0A=
>   				u8 num_parents,=0A=
>   				u8 parent, u8 bypass1, u8 bypass2,=0A=
> =0A=
=0A=
