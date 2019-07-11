Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A10C74A50
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CFA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TVq+40TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGKITN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:19:13 -0400
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:27524
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbfGKITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvgKQOx3TQOMnqFyD2o+7crNPLMTxXcy//5zmcmS2vQ=;
 b=TVq+40TBC2nARFt0rUIlhqnp1WxUuetfHry5RHjtLCUKPqPE7J2CLKwJ+Vg5+Rgb0u5UXi7qbpIrTJn4E9aPmOj5xVVB3G7ydH7P31LODwgi/+hKDGLHji3f+xJw4KnHcyFoFBXLogIpEP7ytHxG4+tS/SB8FVCjrxzGlWfK/rQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 08:19:09 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2052.022; Thu, 11 Jul 2019
 08:19:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/4] clk: imx8mm: Add system counter to clock tree
Thread-Topic: [PATCH 3/4] clk: imx8mm: Add system counter to clock tree
Thread-Index: AQHVJ/++eyD/ffxNeUuXAhbVfUjkiabFMp8A
Date:   Thu, 11 Jul 2019 08:19:09 +0000
Message-ID: <20190711081908.ray2pjtigbjaezyc@fsr-ub1664-175>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190621070720.12395-3-Anson.Huang@nxp.com>
In-Reply-To: <20190621070720.12395-3-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5431ea-9207-4b60-2ca8-08d705d872d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5042;
x-ms-traffictypediagnostic: AM0PR04MB5042:
x-microsoft-antispam-prvs: <AM0PR04MB50425AC223D7AC8D924927F3F6F30@AM0PR04MB5042.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:337;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(4326008)(81156014)(81166006)(8676002)(186003)(66066001)(102836004)(26005)(54906003)(8936002)(11346002)(6862004)(71200400001)(446003)(7416002)(229853002)(99286004)(476003)(305945005)(3846002)(71190400001)(7736002)(2906002)(6116002)(486006)(6506007)(53546011)(5660300002)(316002)(25786009)(76176011)(6636002)(53936002)(68736007)(66946007)(86362001)(6512007)(9686003)(478600001)(1076003)(44832011)(33716001)(6246003)(64756008)(66476007)(76116006)(91956017)(14454004)(66556008)(66446008)(256004)(6486002)(6436002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rm6YTvqApxJjTFgcSp4Vj8A4skF1vxoxCBpM0HWi1zjXa4zyIsBY1Veg46KNfXqTcPXe2LGOYgShpv9KndG5AkhSI1/h0nJMuRdyc97OIpN9JqZxGojr/2hGahLz17QK+kJBHrjD4SdufZ/GD81NxElf3jLuOF/iK4WEgoL6qOnZW4jbXv9LulsFL0R4BNYJsugKE3kTUT48CyyNSr8IYChl/y+7Q3XoQ/WAsE5XL6zXH2QBVGlxpdcXulbbXhq1syCXZLxkoGJWlKFwnkJM5r7Qn+pMf33Tq0NOAhlTIiQnIKrZZ1Y6etrkazleeaKu6YAGqVgU6/eMxs8UWOX94ZcBHUD5cot2xE0v7Yc50SjMcSU37ae4Rf9dqmYPg5aiwy1sFwgSkU3MdZGCVkgSnZlV+0Zy5A0Z5NwzosyaQ8g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D9D0CDF90B35D4FB3BC742B2D394AB9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5431ea-9207-4b60-2ca8-08d705d872d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 08:19:09.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-21 15:07:19, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> i.MX8MM timer-imx-sysctr driver needs system counter clock
> for proper function, add it into clock tree.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 43fa9c3..56d53dd 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -645,6 +645,8 @@ static int __init imx8mm_clocks_init(struct device_no=
de *ccm_node)
>  	clks[IMX8MM_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root"=
, "dram_alt", 1, 4);
>  	clks[IMX8MM_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base=
 + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels),=
 CLK_IS_CRITICAL);
> =20
> +	clks[IMX8MM_CLK_SYS_CTR] =3D imx_clk_fixed_factor("sys_ctr", "osc_24m",=
 1, 3);
> +
>  	clks[IMX8MM_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
>  					   clks[IMX8MM_CLK_A53_DIV],
>  					   clks[IMX8MM_CLK_A53_SRC],
> --=20
> 2.7.4
> =
