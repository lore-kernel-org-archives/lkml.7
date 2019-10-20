Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596CDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A7D2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SO7qycVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJTOYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 10:24:38 -0400
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:52864
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfJTOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 10:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpVf9BTRjoskvxEc5j58WbltWIC+3s8qilONwx+hSBwzkdzUqsjFIWSqt+huept/5dbs5MKbsoIYgPSIVGUXYGcCT8koCEBCmlSU1AYXD8Q/X4I6jTLF33+oFJdrPZocGcNS9EdnIggrb9AZX3D9seH9DakT7l3uCIOmCpc8h8NQRrB1r/6ojPNQgBJ0jW8MpPq2SObWIefVVQBJsTif9ALitNArXE2N5a47UBdouBCpqOGfqpCqMPhm/YO9GJFEDxsP/OIO1N8MAhbWyeZSfsM6lSlnr94cnvYaD633IBAQSQempdLRJwMpRfStwFpDCu8xjMwzW+KVIqQHzlhJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxHkV/5Hlhgkc2c9pKbRzP3cQaWUTLXCFFifDeFuShA=;
 b=U9v8p1/MnJXh90s0gTg6LdsAu6Udc5bU8qnTmUQr2qXK9sZl6nPoX4i+UIOkW5t3dpIFtVxDvNTh/tsj7bsxnr3JWLzYNN6g/ZZnIX4lQSG080ebXxoawKsJOYmZEyLuRSbIHkgWvIkQPWTNFem9Ese6BRkIuIb37C8Uj7xqB3tkrLTFZVPxjin/Yh/MJYUqWVEkf0fkkG1ByHBKD3Ww/9kN4LVmRqa9EyJCChUzx+FrUQP+gqsM0fzP/4lSdhk5w8/ZxiLloOdKWHauevKK4O0sVuokiURx2sl7JEkAXezvCxX+KR1/8o7YtojxRdVAQrslYNccsNDL3YWMsVxBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxHkV/5Hlhgkc2c9pKbRzP3cQaWUTLXCFFifDeFuShA=;
 b=SO7qycVikloy+yLOyGBRq73aGQKQfdZNOBueCIYS8f5riOnbW1QYa4DcmtM6oLwuc+u7wbY+wyOGDCcLdNysTE368x+Es0C5yHAzt6FG3dK+BtMTjDzzRlkv8OktIPCyOtGRXK591JYbfrbToObl547L9OSN7CsXyJvDpDmxvas=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4017.eurprd04.prod.outlook.com (52.134.92.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Sun, 20 Oct 2019 14:24:32 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02%3]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 14:24:32 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Topic: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Index: AQHVfogREXMSqkErfE+B9jsiOEYyjqdjpxsA
Date:   Sun, 20 Oct 2019 14:24:32 +0000
Message-ID: <20191020141355.px6o3ifnjy45hli4@fsr-ub1664-175>
References: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0028.eurprd06.prod.outlook.com
 (2603:10a6:203:68::14) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed3f786e-eec7-4cc2-16a9-08d755693974
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4017:|AM0PR04MB4017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4017CF00E0B0A69D99814FD1F66E0@AM0PR04MB4017.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0196A226D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(3846002)(446003)(1076003)(316002)(11346002)(102836004)(44832011)(99286004)(66476007)(66556008)(64756008)(66446008)(476003)(53546011)(486006)(66946007)(71190400001)(71200400001)(54906003)(8676002)(76176011)(52116002)(8936002)(186003)(6506007)(26005)(5660300002)(81166006)(81156014)(66066001)(6116002)(25786009)(386003)(9686003)(6512007)(6636002)(86362001)(2906002)(4326008)(305945005)(7736002)(6246003)(6862004)(478600001)(229853002)(256004)(14454004)(33716001)(6486002)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4017;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUG079oKzexEOP4s/pAI3GvP/q8LM+qBk8PsoeREX4K6661tRhT+b0ETz/xG0t5rCt/iZo3hFMzHmNDQogQaC/Y+ruUaoiamr//dhPhK2BmZen8Im+CsdH+QQNwv/o1KnDROsH5AYTvAfUiIHSvg7L1hFZf6+Yrv5BjL38h5zaAdBtxh3MzjQcufxZ7KDl+l6CI6uQgkIDEsy1bdz0m/HBbKIDKAHE2gJ2JbarllWVQos3krA6JTDOkNJBeT+J92tT0R3DtbjbKpwiIqZy6+moyWkwC2Zg1JkvGuftC2lmTlEvPYuMeHeKfbTnOE7iy3jvYIrCst/qXm53/WbhtN61V3nW70PLOLMKeXXbQMFc4gGB9iMfaMBUuIhJBRuzGDqTatUgw5ZscK17Wx2N2jYdfx57ESK+M8zgIQo+P0ijg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D7E3E0C12D6B14B809F90044067B5F6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f786e-eec7-4cc2-16a9-08d755693974
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 14:24:32.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0Z9ZqCowJLvO0x0rHUh8+usw5DYfnoktaswke1nF1vGAETP9FpaBB++nbZDAqcSsz9IT2fRzx3I/pSiK3C99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-09 09:58:14, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> According Architecture definition guide, SYS_PLL1 is fixed at
> 800MHz, SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed
> to register the clocks and drop code that could change the rate.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

For the entire series:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mm.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 04876ec66127..ae7321ab7837 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -34,8 +34,6 @@ static const char *dram_pll_bypass_sels[] =3D {"dram_pl=
l", "dram_pll_ref_sel", };
>  static const char *gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_ref_se=
l", };
>  static const char *vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_ref_se=
l", };
>  static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_se=
l", };
> -static const char *sys_pll1_bypass_sels[] =3D {"sys_pll1", "sys_pll1_ref=
_sel", };
> -static const char *sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_pll2_ref=
_sel", };
>  static const char *sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_pll3_ref=
_sel", };
> =20
>  /* CCM ROOT */
> @@ -325,8 +323,6 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MM_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + =
0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	clks[IMX8MM_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + =
0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	clks[IMX8MM_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + =
0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> -	clks[IMX8MM_SYS_PLL1_REF_SEL] =3D imx_clk_mux("sys_pll1_ref_sel", base =
+ 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> -	clks[IMX8MM_SYS_PLL2_REF_SEL] =3D imx_clk_mux("sys_pll2_ref_sel", base =
+ 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base =
+ 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> =20
>  	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
> @@ -336,8 +332,8 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
>  	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
>  	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
> -	clks[IMX8MM_SYS_PLL1] =3D imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel=
", base + 0x94, &imx_1416x_pll);
> -	clks[IMX8MM_SYS_PLL2] =3D imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel=
", base + 0x104, &imx_1416x_pll);
> +	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
> +	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
>  	clks[IMX8MM_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel=
", base + 0x114, &imx_1416x_pll);
> =20
>  	/* PLL bypass out */
> @@ -348,8 +344,6 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", bas=
e + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
>  	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", bas=
e + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
>  	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", bas=
e + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
> -	clks[IMX8MM_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", b=
ase + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), =
CLK_SET_RATE_PARENT);
> -	clks[IMX8MM_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", b=
ase + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels),=
 CLK_SET_RATE_PARENT);
>  	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", b=
ase + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels),=
 CLK_SET_RATE_PARENT);
> =20
>  	/* PLL out gate */
> @@ -360,8 +354,8 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
>  	clks[IMX8MM_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypas=
s", base + 0x64, 11);
>  	clks[IMX8MM_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypas=
s", base + 0x74, 11);
>  	clks[IMX8MM_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypas=
s", base + 0x84, 11);
> -	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1_by=
pass", base + 0x94, 11);
> -	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2_by=
pass", base + 0x104, 11);
> +	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", =
base + 0x94, 11);
> +	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", =
base + 0x104, 11);
>  	clks[IMX8MM_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_by=
pass", base + 0x114, 11);
> =20
>  	/* SYS PLL fixed output */
> --=20
> 2.16.4
>=20
