Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B50C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E089920663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/IwKd0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDHL1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:27:43 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:18543
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfDHL1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwVh4t5amvHOga3CxFZQiTpiu76Tycpk6CPafN8wUus=;
 b=T/IwKd0iZIoiW6bbsHxriH1S+KaaV9qVbeD+NumZXN2uHhSoiFadLhs4jz+dzD1CnKNTXooQ5hTXlPufunMWEWNGMKGweK/+VrFAhwqMXSAm8A41vG+iSTxDu/++a5c0u6XkiP7C+OqMdIyOIDlK2LQkrtuxOQBeFvOWl6UpUoU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6067.eurprd04.prod.outlook.com (20.179.32.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.18; Mon, 8 Apr 2019 11:27:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 11:27:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH v2] pinctrl: pinctrl-imx8mq: Add suspend/resume ops
Thread-Topic: [PATCH v2] pinctrl: pinctrl-imx8mq: Add suspend/resume ops
Thread-Index: AQHU7ffGuIssFgd2ckqu0X9l+Jf5e6YyHgWQ
Date:   Mon, 8 Apr 2019 11:27:37 +0000
Message-ID: <AM0PR04MB4211EFD7CA34B33F3B9CE9E7802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554720120-6617-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1554720120-6617-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a68ca2ae-f536-4f7d-15f8-08d6bc153479
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6067;
x-ms-traffictypediagnostic: AM0PR04MB6067:
x-microsoft-antispam-prvs: <AM0PR04MB60670A9D3712F9F9A45B5D8C802C0@AM0PR04MB6067.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(189003)(199004)(6246003)(14454004)(74316002)(478600001)(15650500001)(102836004)(9686003)(6116002)(55016002)(3846002)(99286004)(97736004)(53546011)(6506007)(316002)(53936002)(54906003)(110136005)(305945005)(186003)(4326008)(7736002)(25786009)(256004)(14444005)(33656002)(26005)(229853002)(446003)(11346002)(66066001)(105586002)(5660300002)(486006)(106356001)(2906002)(476003)(52536014)(44832011)(68736007)(8936002)(71200400001)(81156014)(71190400001)(81166006)(86362001)(76176011)(7696005)(8676002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6067;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1T/f7zDeYPDtIiCNz8iJkjQB3THoG0Mi/J72pzeKiY3nAH/izrChSAciy368e4R9RYIrf4wZk0oCA7iVGRf5IbtgWH/luzURySeDKsoEb7z55bDZAkn+zlmPu7MAe0UIXypU4+us9WzVkdQjKr1XhSwxqu06hoL9uXjK2mWXZTZjuSvElz2uFVc2wT72PYlnWl9DM0xp/FWnHdQayUPPX4pco/kM/BMxuHyPMRqM72LIsVpEJdHHm7It/AvkWUzcIg/IItlzv7T3etDFxMMoJ5gLWRAKrPkeMxLIehpV+hDzVy8VLe67GzI/Fn74CpmjjKKc3JQxsmhFoeHjt1PSgi7Ou7ahECqUazGdqvC2y9zh2MrvhHtwRxMYLvT8cF/XYJkMeJAVnUXRRF10Y3ZtT+tK693xiYaVocngvBk0lh8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ca2ae-f536-4f7d-15f8-08d6bc153479
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 11:27:37.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Monday, April 8, 2019 6:43 PM
> Subject: [PATCH v2] pinctrl: pinctrl-imx8mq: Add suspend/resume ops

pinctrl: imx8mq: xxxx

> To support pinctl hog restore after LPSR resume back, add the generic
> suspend/resume in pinctrl-imx along with the generic pm opsto be used by
> platform specific drivers. Then make use of the newly added ops in i.MX8M=
Q
> platform specific driver.
>=20
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>=20
> Changes since v1:
>  - Replaced the imx8mq specific ops with generic ones.
>=20
>  drivers/pinctrl/freescale/pinctrl-imx.c    | 25
> +++++++++++++++++++++++++
>  drivers/pinctrl/freescale/pinctrl-imx.h    |  4 ++++
>  drivers/pinctrl/freescale/pinctrl-imx8mq.c |  1 +
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 188001b..ee120ee 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -887,3 +887,28 @@ int imx_pinctrl_probe(struct platform_device *pdev,
>=20
>  	return ret;
>  }
> +
> +int imx_pinctrl_suspend(struct device *dev) {

Static __maybe_unused

> +	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
> +
> +	if (!ipctl)
> +		return -EINVAL;

I think we do not need this check as it's within the driver control.

> +
> +	return pinctrl_force_sleep(ipctl->pctl); }
> +
> +int imx_pinctrl_resume(struct device *dev) {

Ditto

> +	struct imx_pinctrl *ipctl =3D dev_get_drvdata(dev);
> +
> +	if (!ipctl)
> +		return -EINVAL;

Ditto

> +
> +	return pinctrl_force_default(ipctl->pctl);
> +}
> +
> +const struct dev_pm_ops imx_pinctrl_pm_ops =3D {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend,
> +					imx_pinctrl_resume)
> +};
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h
> b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 98a4889..ae78314 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -17,6 +17,7 @@
>  struct platform_device;
>=20
>  extern struct pinmux_ops imx_pmx_ops;
> +extern const struct dev_pm_ops imx_pinctrl_pm_ops;
>=20
>  /**
>   * struct imx_pin_mmio - MMIO pin configurations @@ -136,6 +137,9 @@
> struct imx_pinctrl {  int imx_pinctrl_probe(struct platform_device *pdev,
>  			const struct imx_pinctrl_soc_info *info);
>=20
> +int imx_pinctrl_suspend(struct device *dev); int
> +imx_pinctrl_resume(struct device *dev);

Not need export this two functions

Regards
Dong Aisheng

> +
>  #ifdef CONFIG_PINCTRL_IMX_SCU
>  #define BM_PAD_CTL_GP_ENABLE		BIT(30)
>  #define BM_PAD_CTL_IFMUX_ENABLE		BIT(31)
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> index 8d39af5..50aa1c0 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> @@ -339,6 +339,7 @@ static struct platform_driver imx8mq_pinctrl_driver =
=3D
> {
>  	.driver =3D {
>  		.name =3D "imx8mq-pinctrl",
>  		.of_match_table =3D of_match_ptr(imx8mq_pinctrl_of_match),
> +		.pm =3D &imx_pinctrl_pm_ops,
>  		.suppress_bind_attrs =3D true,
>  	},
>  	.probe =3D imx8mq_pinctrl_probe,
> --
> 2.7.4

