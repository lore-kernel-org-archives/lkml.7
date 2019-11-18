Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E1C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D0020748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FTIG7pGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKRNGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:06:31 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:49476
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfKRNGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:06:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jiet+1mJ72DgSf6ca0A9NlYQUTs+U9QL+J2MrO+7h9ogT80DIAlgvPbMiX28DX8IlRo0Ip3J2Ed4Sy55NPslSshNftVI9sVRqlLeYae+L2gBBG8GF5K+2I2E8vcZ8cfehV1v9pr3b52+c15aghUlumCcUmVOT6cj/LbcVPnzEtizDMeEYUCRg8k8DwrdSdrpcYA72zLzp4++bREz2yDyWQndZoM7GUqKOYHJA/PDtcttkFeXL3iXYbZk5cAB1aodYwJpX4r3lP6hLkCvJLkvXh1TKs2sR5zyQfQe883s3BBSHa8qFFQzTwGjjLqnEJvFq8/FTS3JemvbG4RVEeHecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNeyeaM9yksRv7AN9YynCmrXyC4SHLHoY5MlTjMtTro=;
 b=IL3EXiJXdxV0UIXddJ7aQ3MpEHQzNHGDTzwX+Xd0gTyGNTB4VFiYn9Js2XimZM12nsV6jicdcvFa3jc87SfHMTRVyav7DUA27evv7erGj2OwiNNvFk1/0oG0Pxr8A8olhIY6qIhtvSVMLr8uXleMUiZvMkxugVv62m+GTH7c/caiNjRnks0WxY6TGFm2+qUbtXSZQA0qkz7IpVrEfOrywETIqpsxlAUblXTwJ+Dyjj5emyM1mpHCNF/yMfB2rcpbIuM6im9fkDymmv0reuBcuKtoBw63HnPCrSx/+R6BmZlsY8KISUhDjZOpzbCJ+I0/AT7D7HE84ydheTVb3V/UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNeyeaM9yksRv7AN9YynCmrXyC4SHLHoY5MlTjMtTro=;
 b=FTIG7pGkBfVzevw8UjlscSOXNztJ7JH+BSdUrTjbuk84iCf9CR/TFC954Q90cXtoJ5Yqdeo5dWnTnWKBWN1UuX1QnuVqPJ3vMx5ZHzpcl748LEE1RupP9JBTdGVP5/aQsfYx8Q7zOQyhyQ7C18Of4BnI8fJCIKJuF8M6DJcN5xM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4846.eurprd04.prod.outlook.com (20.177.50.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Mon, 18 Nov 2019 13:06:26 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 13:06:26 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/4] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Index: AQHVktMr9vdJ3yj43k2cixXCwuTSvQ==
Date:   Mon, 18 Nov 2019 13:06:26 +0000
Message-ID: <VI1PR04MB7023CC47DC123A66627940E9EE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1572846270-24375-1-git-send-email-peng.fan@nxp.com>
 <1572846270-24375-3-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 627280d4-78d6-4979-99c9-08d76c281e98
x-ms-traffictypediagnostic: VI1PR04MB4846:|VI1PR04MB4846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4846A4D4C5B9E460CB80FBF4EE4D0@VI1PR04MB4846.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(86362001)(7696005)(446003)(9686003)(55016002)(71200400001)(2906002)(305945005)(74316002)(6436002)(8936002)(66066001)(4326008)(7736002)(6116002)(3846002)(186003)(26005)(52536014)(81166006)(81156014)(76176011)(54906003)(476003)(102836004)(478600001)(6506007)(53546011)(110136005)(5660300002)(2501003)(8676002)(316002)(256004)(71190400001)(6246003)(229853002)(99286004)(486006)(44832011)(14454004)(33656002)(25786009)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(2201001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4846;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUHuOxCmYGgZ2AKlvKaT17n/7iAX8MgVdEfqvB10/nBk5eHAAdKxx+bTjQ8oJafK0Co5JsdqG66Pw+A16srLdJ52qmlsEiKc6Xrsud7wHGiwPoH9IWkxHtj5E9AXvlJPSxAlAm6OgzUKFKtE9N0E1Uo9/IFfLJxccD/bLMIojuI/5xeOUBBJzUKdCQzUPrJDTcGta6T2E6+xfbxy4Rsk7wxsbNL4+RwWnJatoBnK0LM8l7JiWejcYTXDJVXR4h/2uGkGqvNSgbyok9bRFQCsNmxl+YRWDtAMnl9nuLy1rS4cG+REHHaIbV5vNHi3M0Rja9nkWmjBO1xCELr8b4K+g1SCjWjB7vaoOQ+wQXWDJ06AmCbQC3W30uoRG4hxhEqNt7SGv6OKANPuuJokGTnBfOg/2qKGfijzylwSVhs/X4X7NgI3nc+5V/vpcRMEp6sT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627280d4-78d6-4979-99c9-08d76c281e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 13:06:26.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIcpygG943t6Lbkw3x4HE92SPTJToxdzQDq5xJl7Q9T3DGvv5G3Xdqa/rqJgNqS/wQ8EIcVEjQ9IIB68zkMrpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-04 7:46 AM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> Switch the entire clk-imx8mn driver to clk_hw based API.=0A=
> This allows us to move closer to a clear split between=0A=
> consumer and provider clk APIs.=0A=
=0A=
> -	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);=0A=
> -	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);=0A=
> -	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);=0A=
> -	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_pll);=0A=
> -	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);=0A=
> -	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);=0A=
> -	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);=0A=
> -	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);=0A=
> -	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);=0A=
> -	clks[IMX8MN_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel=
", base + 0x114, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1", "audio_pll=
1_ref_sel", base, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2", "audio_pll=
2_ref_sel", base + 0x14, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1", "video_pll=
1_ref_sel", base + 0x28, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_=
sel", base + 0x50, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel=
", base + 0x64, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel=
", base + 0x74, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel=
", base + 0x84, &imx_1416x_pll);=0A=
> +	clks[IMX8MN_SYS_PLL1] =3D imx_clk_hw_fixed("sys_pll1", 800000000);=0A=
> +	clks[IMX8MN_SYS_PLL2] =3D imx_clk_hw_fixed("sys_pll2", 1000000000);=0A=
> +	clks[IMX8MN_SYS_PLL3] =3D imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_=
sel", base + 0x114, &imx_1416x_pll);=0A=
=0A=
You are switching audio/video/dram PLL from imx_1443x_pll to =0A=
imx_1416x_pll, are you sure this is correct?=0A=
=0A=
If this is intentional it should be an separate patch.=0A=
=0A=
> -	clks[IMX8MN_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",=0A=
> -					   clks[IMX8MN_CLK_A53_DIV],=0A=
> -					   clks[IMX8MN_CLK_A53_SRC],=0A=
> -					   clks[IMX8MN_ARM_PLL_OUT],=0A=
> -					   clks[IMX8MN_CLK_24M]);=0A=
=0A=
> +	clks[IMX8MN_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",=0A=
> +					      clks[IMX8MN_CLK_A53_DIV]->clk,=0A=
> +					      clks[IMX8MN_CLK_A53_SRC]->clk,=0A=
> +					      clks[IMX8MN_ARM_PLL_OUT]->clk,=0A=
> +					      clks[IMX8MN_CLK_24M]->clk);=0A=
=0A=
This series seems to be against Shawn's clk/imx but there is an =0A=
additional patch in Stephen's tree which changes this 24M to PLL1_800M. =0A=
Maybe that should be pulled into clk/imx? Otherwise it might spawn an =0A=
unreadable merge conflicts since almost the entire file is rewritten.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
