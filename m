Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEC1C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kExovCP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGNdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:33:15 -0500
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:38976
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfCGNdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUDPjvmLyBvjQAv6i93+SSSyOAgaZCa71hjBzjERttY=;
 b=kExovCP9g/TjylsGcMbURCmzC0DuhFFOdLKhhBZd0XJ05jRhaQqPIlDM4pzTJXuHM33e2XddklOEzXCaw3J9MdGtMaWFD+HY5oO3qLAQQ4wK1x+2QOORwmqoP0qzgDsfGqQuHrthtUl5/zxkrJPjod6OUyuIkARzdXf1IyrwXNg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6611.eurprd04.prod.outlook.com (20.179.255.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Thu, 7 Mar 2019 13:33:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 13:33:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU07jNtorBWhAbJkylCtaCxH6iDKYAGsHA
Date:   Thu, 7 Mar 2019 13:33:05 +0000
Message-ID: <AM0PR04MB4211060E8DA8BA9CEAAA0F15804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac26b464-f9b0-43b2-d1b0-08d6a3016dd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6611;
x-ms-traffictypediagnostic: AM0PR04MB6611:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6611;23:t8QjMybwunYuqKX2n0lcoMNBLplih+qINQiX6PI00?=
 =?us-ascii?Q?SmJalTBmbHGES6AaoscDkqcUvaAowV0FoV1gEStG+5ro/9cl+mFJdhHEaY8b?=
 =?us-ascii?Q?dixGI6MtjedUXvyu0Rn1OJm6jLWx8mzaDIghN5CmPSi945TBo+X/xGS6WBwC?=
 =?us-ascii?Q?HU72cs4YRRP4dNLRLtGn0OMa1suQZ4mawpwDbITSKXYSCFbH359TIwEoQwLb?=
 =?us-ascii?Q?3HQXVidtLkLFcShsAWMQQl7KAxFDjbP3kIhE4+yGELUIEYiln+bXpK5cp3eM?=
 =?us-ascii?Q?BAqnpTNzcut+KmtbRKktyCuA/AnqqATq/YtD5DJN6bkGdRXujPviSFRlFJQG?=
 =?us-ascii?Q?47iad/0rNU5jHmLYYQ2IXqkRFSjI3zt/2Vmgb7fezOc8Naki/WStu/48OrNi?=
 =?us-ascii?Q?Sq8hEJvW7+cZjv/ItfJUWab3WqrAUvz5XgI7t/Rt+Nl+DXO18ho453e9az62?=
 =?us-ascii?Q?inwp4y+YTpwAmi2eeJsWV5J1NY50yEkhtFZramShj3bUM/noxiU7ZQQtaSOG?=
 =?us-ascii?Q?FDEw+Of2wJ8z94vuTnEb/dFLteiFo5NElZO6RlFdyIFD3CUeAZgsAJa8QDoz?=
 =?us-ascii?Q?y4bn2hWYjUnpYedgxyWGyrQQZ97J4oz3DSYlYuCv8OhEJaFXE91BzsRV8cmO?=
 =?us-ascii?Q?QIq9yxrvYLkIDxgbAclKld5zSBJbuRNXSDuPkb5wQQi17rBrbqgyPPwTLyoX?=
 =?us-ascii?Q?JpuaD6NAF4KMz4vep2Zi6L7uI5M6sKz9/z5kM3xh0wok7mWbKop0zYZfCQvV?=
 =?us-ascii?Q?M42bVmEXpk++xigP6IF/es0fqVSAhb0Xjx1sxmHG3kgvO8+EQDRnX5gGbyGp?=
 =?us-ascii?Q?sdZWdnMM1ro99yD5YRKW64boYEJ+FwKv5hBew12P0ytpisRES4f57f4CpBvB?=
 =?us-ascii?Q?QBBNWuKZPqsf4S2JFQzDxYtSk+nsN/y9ST2wND8lPGsfrELYhnNKNBsGoWKs?=
 =?us-ascii?Q?Vf5ATasSyxNcWGzH3mob2khiYCaUM2L8Z9ohWK8b29/0HQVjoiY8ZEO/ShBl?=
 =?us-ascii?Q?4D5qkDAVMvvS7zbwOuaXx0jrlJrzMgoXt/+Zyiy59UNeIjjE+fIUjE5cLKTI?=
 =?us-ascii?Q?3VXC8/Lx+/ShgcSyID89YSIqMP9h+5LLVs0lB8bCPavbZKY34Z+mlYt6uxd1?=
 =?us-ascii?Q?pCbQJLnhklGxyVljSDLrOLfdEeifGYVV7NSKBnUReXY43vy7oRCPlLEo/zXS?=
 =?us-ascii?Q?w8kPO0RnY7yMT6cGewV4YNDX2OJEPCvyeJ5xAb0QebbBTsymNLWFd0vI3YXW?=
 =?us-ascii?Q?QRS6Lslz9YgdqrFxHgqeHmLXFIak/wr1CtYzeOkJnuPIJXaZim/R5seeF3Cb?=
 =?us-ascii?Q?LVBGh+ZsiADhHFazhtqCc3Dj37zCjA7qt3FbbXgtlbq?=
x-microsoft-antispam-prvs: <AM0PR04MB661180985CA32EBF862CB57C804C0@AM0PR04MB6611.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(8676002)(81156014)(66066001)(8936002)(81166006)(7736002)(102836004)(6436002)(53936002)(9686003)(6246003)(6116002)(3846002)(14444005)(25786009)(256004)(4326008)(99286004)(7696005)(476003)(2201001)(86362001)(6506007)(26005)(186003)(74316002)(76176011)(11346002)(446003)(2501003)(44832011)(486006)(105586002)(7416002)(106356001)(316002)(305945005)(33656002)(478600001)(71190400001)(71200400001)(55016002)(110136005)(52536013)(2906002)(5660300002)(229853002)(14454004)(68736007)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6611;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M20fCWo0KwCgWpO1ibB5VLtE1yVb7MrLDJL0hPNHQsYanAWXNUAdJ0jOIolfAIxjMUQ/jNVUumwGhiQ5p1KKaVFYOcnJTVTeHXmlQbbQi9iEgMB+LZC3FBqUCuG+eZ6VQt39ay86RT7NsfWj9+hs1E7W82xrkZ65pU6ZUno9M+JXlQ3hVQzh8075T/Jeg+qcPy80kXcXvkn+0ZmsDxu++KAULqUYw32qwJZaKpA8aJ1hACymKaRP82AQ7jymQ4HZHpyHpUe1o6D9EjkNa56J8FMrmbVfckvd8f4p1Bn22hMp9dT22cDXasLUClU5JC0w9eGa7RzMq6OxCD0kkORhPWAUXKebKjpkyG2uWsyOQLmtUQrPqLDpRpXVU8h+xVzEYgiVxnU0DbbiWnXostRy7CT329Aem6rORwuX3JQPx2w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac26b464-f9b0-43b2-d1b0-08d6a3016dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 13:33:05.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Wednesday, March 6, 2019 9:06 AM
>=20
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller inside,
> the system controller is in charge of controlling power, clock and watchd=
og
> etc..
>=20
> This patch adds i.MX system controller watchdog driver support, watchdog
> operation needs to be done in secure EL3 mode via ARM-Trusted-Firmware,
> using SMC call, CPU will trap into ARM-Trusted-Firmware and then it will
> request system controller to do watchdog operation via IPC.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V6:
> 	- use module_platform_driver() instead of module_init/exit to make code
> simple.
> ---
>  drivers/watchdog/Kconfig      |  14 ++++
>  drivers/watchdog/Makefile     |   1 +
>  drivers/watchdog/imx_sc_wdt.c | 174
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 drivers/watchdog/imx_sc_wdt.c
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> 242eea8..33a6523 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -641,6 +641,20 @@ config IMX2_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx2_wdt.
>=20
> +config IMX_SC_WDT
> +	tristate "IMX SC Watchdog"
> +	depends on IMX_SCU

As I replied in another mail, it actually does not depend on SCU.
Let's wait for Rob's comment on whether we could move watchdog
Out of SCU node.

> +	depends on HAVE_ARM_SMCCC
> +	select WATCHDOG_CORE
> +	help
> +	  This is the driver for the system controller watchdog
> +	  on the NXP i.MX SoCs with system controller inside.
> +	  If you have one of these processors and wish to have
> +	  watchdog support enabled, say Y, otherwise say N.
> +

Nitpick:
If resend, please also add description here that we need to use
ARM SMC call as your commit message.

Regards
Dong Aisheng

> +	  To compile this driver as a module, choose M here: the
> +	  module will be called imx_sc_wdt.
> +
>  config UX500_WATCHDOG
>  	tristate "ST-Ericsson Ux500 watchdog"
>  	depends on MFD_DB8500_PRCMU
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile index
> ba930e4..136d9f0 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
>  obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
> +obj-$(CONFIG_IMX_SC_WDT) +=3D imx_sc_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
>  obj-$(CONFIG_RETU_WATCHDOG) +=3D retu_wdt.o
>  obj-$(CONFIG_BCM2835_WDT) +=3D bcm2835_wdt.o diff --git
> a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c new file
> mode 100644 index 0000000..ee48709
> --- /dev/null
> +++ b/drivers/watchdog/imx_sc_wdt.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2018-2019 NXP.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/watchdog.h>
> +
> +#define DEFAULT_TIMEOUT 60
> +/*
> + * Software timer tick implemented in scfw side, support 10ms to
> +0xffffffff ms
> + * in theory, but for normal case, 1s~128s is enough, you can change
> +this max
> + * value in case it's not enough.
> + */
> +#define MAX_TIMEOUT 128
> +
> +#define IMX_SIP_TIMER			0xC2000002
> +#define IMX_SIP_TIMER_START_WDOG		0x01
> +#define IMX_SIP_TIMER_STOP_WDOG		0x02
> +#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
> +#define IMX_SIP_TIMER_PING_WDOG		0x04
> +#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
> +#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
> +#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
> +
> +#define SC_TIMER_WDOG_ACTION_PARTITION	0
> +
> +static bool nowayout =3D WATCHDOG_NOWAYOUT; module_param(nowayout,
> bool,
> +0000); MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once
> +started (default=3D"
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static unsigned int timeout =3D DEFAULT_TIMEOUT;=20
> module_param(timeout,
> +uint, 0000); MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds
> +(default=3D"
> +		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
> +
> +static int imx_sc_wdt_ping(struct watchdog_device *wdog) {
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return 0;
> +}
> +
> +static int imx_sc_wdt_start(struct watchdog_device *wdog) {
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return -EACCES;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
> +		      SC_TIMER_WDOG_ACTION_PARTITION,
> +		      0, 0, 0, 0, 0, &res);
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static int imx_sc_wdt_stop(struct watchdog_device *wdog) {
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
> +		      0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
> +				unsigned int timeout)
> +{
> +	struct arm_smccc_res res;
> +
> +	wdog->timeout =3D timeout;
> +	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
> +		      timeout * 1000, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0 ? -EACCES : 0;
> +}
> +
> +static const struct watchdog_ops imx_sc_wdt_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.start =3D imx_sc_wdt_start,
> +	.stop  =3D imx_sc_wdt_stop,
> +	.ping  =3D imx_sc_wdt_ping,
> +	.set_timeout =3D imx_sc_wdt_set_timeout, };
> +
> +static const struct watchdog_info imx_sc_wdt_info =3D {
> +	.identity	=3D "i.MX SC watchdog timer",
> +	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT, };
> +
> +static int imx_sc_wdt_probe(struct platform_device *pdev) {
> +	struct watchdog_device *imx_sc_wdd;
> +	int ret;
> +
> +	imx_sc_wdd =3D devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd),
> GFP_KERNEL);
> +	if (!imx_sc_wdd)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, imx_sc_wdd);
> +
> +	imx_sc_wdd->info =3D &imx_sc_wdt_info;
> +	imx_sc_wdd->ops =3D &imx_sc_wdt_ops;
> +	imx_sc_wdd->min_timeout =3D 1;
> +	imx_sc_wdd->max_timeout =3D MAX_TIMEOUT;
> +	imx_sc_wdd->parent =3D &pdev->dev;
> +	imx_sc_wdd->timeout =3D DEFAULT_TIMEOUT;
> +
> +	ret =3D watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set timeout value, using
> default\n");
> +
> +	watchdog_stop_on_reboot(imx_sc_wdd);
> +	watchdog_stop_on_unregister(imx_sc_wdd);
> +
> +	ret =3D devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_suspend(struct device *dev) {
> +	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_stop(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_sc_wdt_resume(struct device *dev) {
> +	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
> +
> +	if (watchdog_active(imx_sc_wdd))
> +		imx_sc_wdt_start(imx_sc_wdd);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
> +			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
> +
> +static struct platform_driver imx_sc_wdt_driver =3D {
> +	.probe		=3D imx_sc_wdt_probe,
> +	.driver		=3D {
> +		.name	=3D "imx-sc-wdt",
> +		.pm	=3D &imx_sc_wdt_pm_ops,
> +	},
> +};
> +module_platform_driver(imx_sc_wdt_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4

