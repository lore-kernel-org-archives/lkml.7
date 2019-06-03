Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF4C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0D272AC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MU9p6u1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFCHa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:30:27 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:41538
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbfFCHa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0styPCxA2kXlg4P9JLhrWY2z3+c+PAly9DON3UUT0M=;
 b=MU9p6u1k/BOgFJMSe6V6ZX5i5KlXgKFMgbcoNEuTBBnuOwygwc3sMG6SruHe3GG0HNVzsL8KcBkfJOzUZteT/J63reauKt86MNsxhnyZ/Fe1B7Fs1uGhtNQuuVvuWKtasPBx11RbeG7FLk1KfcAQbJlHqlypEM4hoaiFHCPAcmc=
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com (20.178.127.224) by
 VI1PR04MB5805.eurprd04.prod.outlook.com (20.178.204.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Mon, 3 Jun 2019 07:30:20 +0000
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e]) by VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 07:30:20 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGaxevUMbLPz7GEiRBakv1/ckCqaJiQoA
Date:   Mon, 3 Jun 2019 07:30:20 +0000
Message-ID: <20190603073018.j236j57ooc7t5hp6@fsr-ub1664-175>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
 <20190603013503.40626-2-Anson.Huang@nxp.com>
In-Reply-To: <20190603013503.40626-2-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3081f70e-89dd-41c4-bf65-08d6e7f5552d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5805;
x-ms-traffictypediagnostic: VI1PR04MB5805:
x-microsoft-antispam-prvs: <VI1PR04MB5805D57728B5DF413B81A950F6140@VI1PR04MB5805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(53936002)(476003)(486006)(256004)(26005)(81156014)(7416002)(446003)(44832011)(8936002)(11346002)(305945005)(33716001)(68736007)(4326008)(7736002)(25786009)(186003)(229853002)(6636002)(6862004)(6486002)(6436002)(99286004)(66446008)(5660300002)(81166006)(66066001)(6246003)(64756008)(66556008)(8676002)(66476007)(66946007)(73956011)(6512007)(9686003)(71190400001)(71200400001)(14454004)(76116006)(54906003)(6506007)(86362001)(2906002)(3846002)(53546011)(6116002)(102836004)(478600001)(1076003)(76176011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5805;H:VI1PR04MB5790.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qaotL9fdM+dVKd4ZPG3fiJg7l1Na5uRru6qhe7eHg0Bk8jizNjkX9RATm/5YlEOECvFA6rlQWZKChqiYR3XGDkzhLuFDK8vGNGQqJFxYOZTJ9GWP6r8xMH/yUE63uiYh4zz/9rkYc3OQcrRG3G3MS/9dc+qxeXt8d12Ciit8bq5eLJu+nFw7mu2V4kYG4knuauTIn4PvWIUbuxeIOGavQhtzg8IYSekOpFAgMdMjvlc66xH5VArVx6Uzr8FCMWRbSe1B3pMGO8FEgYlGZzaMKxCFm0pn9vsFLtjvvW95360SqM3ASu1A9iITyritHBIf0DN3doKzPXvSVlExCPYlweZAp5IRkAfFnxprnv8HK3qvnKKoN4uffR5swtQrgAbQTnzmknqEybSKNKnjcpC1DfKcuJZiq9jDpMtBXSEiS1Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <051749EE44B0A8469CD620AEC45CD774@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081f70e-89dd-41c4-bf65-08d6e7f5552d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 07:30:20.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-03 09:35:02, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> This patch adds i.MX8MN clock driver support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add GPIOx clocks.

...

> +static struct imx_pll14xx_clk imx8mn_sys_pll __initdata =3D {
> +		.type =3D PLL_1416X,
> +		.rate_table =3D imx8mn_pll1416x_tbl,
> +};
> +
> +static const char *pll_ref_sels[] =3D { "osc_24m", "dummy", "dummy", "du=
mmy", };

All of these should be "static const char * const ".

> +static const char *audio_pll1_bypass_sels[] =3D {"audio_pll1", "audio_pl=
l1_ref_sel", };
> +static const char *audio_pll2_bypass_sels[] =3D {"audio_pll2", "audio_pl=
l2_ref_sel", };

...

> +	clk_data.clks =3D clks;
> +	clk_data.clk_num =3D ARRAY_SIZE(clks);
> +	ret =3D of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +	if (ret < 0) {
> +		pr_err("failed to register clks for i.MX8MN\n");
> +		return -EINVAL;
> +	}
> +
> +	imx_register_uart_clocks(uart_clks);
> +
> +	return 0;
> +}
> +CLK_OF_DECLARE_DRIVER(imx8mn, "fsl,imx8mn-ccm", imx8mn_clocks_init);

Any reason why this cannot be a platform driver ?

> --=20
> 2.7.4
> =
