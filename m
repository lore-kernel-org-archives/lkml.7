Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA3BC10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B31F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E1spJU6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCFBGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:06:24 -0500
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:7087
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbfCFBGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lstlvRVFaNybFNYyRP0/WcidFtx3xmweWnbVkiSHfUA=;
 b=E1spJU6cFror6/LXSesMgz2se1KaNN24aXCNZWBDa3+JNDUlDnP/8TYJ3LIvcp8wMPQVG2I0+6YzBc8aOqPFgORB/bbkkmS3nOh2CRDQK4qsobl/FX4zVHLPDy8IPOkFzwYTJha02tyn083yF3BvP7O/4o+3DDAtuQDfj8Oqq6Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Wed, 6 Mar 2019 01:06:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 01:06:18 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU07jNtorBWhAbJkylCtaCxH6iDA==
Date:   Wed, 6 Mar 2019 01:06:17 +0000
Message-ID: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 610a886a-ed35-406c-a46d-08d6a1cfefea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3723;23:/Zsl+xT7jTwfVfI5wsL0ncHdtqinoEDdxxtqR?=
 =?iso-8859-1?Q?eolxsM15JtNZEQ0kbFQd0U4ryPJuuUEBzWeb7s2WDY6H+f9mHFMbVtCrgt?=
 =?iso-8859-1?Q?f8Q6fvV3mB7CMNwhPZ0CKXSjYLeVk8aHXu80jE1ZsbQNGJa+wYokbVv6Ba?=
 =?iso-8859-1?Q?cq7QMxSOJEiQqW8L4TfiC6M1gwGSAVLVYZD89FZtm/l7Y8UlOaWT7L+HHc?=
 =?iso-8859-1?Q?/RYodo7Hg/xiaa3EP6qSZLhXK6fiYzcabhIT/Y4oaXhWULfXt/6/IUZxX7?=
 =?iso-8859-1?Q?hU/HqPokyBa7MYXs52S1LiNK+UStjlDcZzmEj6Q117ytjthTfUDLJ0RhW2?=
 =?iso-8859-1?Q?jpCcPEKtvLkCQ/cEGDveI0emZG9u/G/wGtjgV5UDIL9c13Epjh0TEs5iVX?=
 =?iso-8859-1?Q?6EFp16RwxAjBZzEBot1H8hprTlIUzMTJor2hBhiE/J8pHp16C+WVFVm20x?=
 =?iso-8859-1?Q?7jfyIgKF/9ebyYtsFswzb6JY02LtJmGC0T/UjtySXXFAgsvtH7wUi0fVNX?=
 =?iso-8859-1?Q?LLADnV12w95YsY0pEf5F1lQ83V7RfR4uAA1CwenntJVEmq8/KuiX3COoFe?=
 =?iso-8859-1?Q?LLhVPHIgZZHhDtplS54UmncGWxE24L2Rmb4oLsG/Ikkt5qIsHUesFn6Mut?=
 =?iso-8859-1?Q?Ad9dCtVVoFyOmSHBc6ahSSyUD3n5FRxJ2NxKdEH2P0oTv4ePHDsiY3p9q+?=
 =?iso-8859-1?Q?+u1SCG0o89xbZCT6Wc2IE9Y/ov4Ilv08RByEGcCQqrZcs6tFkSn51RUx0U?=
 =?iso-8859-1?Q?+AjIjjHxPbRUeHc2lyqXa/8YkDFJnuW/EwIdEbOcoPkk8wRJLMk+x1KV2V?=
 =?iso-8859-1?Q?dXdM2zC4AuOxUmQ+0l04BAw9YAAjO/I+mwkM69SEMU7Vpx8bPh5thUmE8Q?=
 =?iso-8859-1?Q?EUWMXTd+0KoSrMk+2QiggCp8ctmDaIV45Hez9XvCI5Sh3PQ5DLfsyKho4B?=
 =?iso-8859-1?Q?+nN3sEMcl8QRgi/yTkVdxb/Q1PuylIFkJs68Ip4CuwO0Ggf+WOX6/j8nNp?=
 =?iso-8859-1?Q?jg4mfEa0wF5SCdXXkBA/K1l+PiBpWY8JVdzkGf0H5jKHy44EwLYu9ClKeD?=
 =?iso-8859-1?Q?+PYhEaybRDtdgzBfRC1CFsaLtciMsXrVKbtijgWDe0Tk9y7wTLBzKYyydf?=
 =?iso-8859-1?Q?q6oHsRDipDAJdXeEQopvEpzfTYBFUkTUEC/Xc0RXJTtZjytxd7YlrvzAEg?=
 =?iso-8859-1?Q?B5ac1fN1Lv2e93DXF4K3I0tZCd7W+PhuCBD0Fd8P/snIOovKJFTG5XPmBD?=
 =?iso-8859-1?Q?LcX0EoYq1IdF/Xjkb4md4B76YZasT/8GzqsX/9Y9A=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3723CF859A3E45031FDA781EF5730@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(36756003)(68736007)(71190400001)(14444005)(71200400001)(86362001)(256004)(2906002)(110136005)(316002)(105586002)(106356001)(6436002)(2501003)(6512007)(7736002)(305945005)(2201001)(6486002)(53936002)(478600001)(8936002)(7416002)(476003)(2616005)(486006)(4326008)(14454004)(81156014)(5660300002)(3846002)(6116002)(25786009)(81166006)(8676002)(50226002)(52116002)(6506007)(99286004)(386003)(26005)(66066001)(102836004)(97736004)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HodDSv+kuRYCdITK21gNj2GVqiR59iaH5YPkI2wR3OfuxIcmLHoXrx7MczlRLkshpLD83pk7XhFpSYUnHSOFiTiSCwfJp2zDF/WhuDcwBGFkgLY/zTYpp6r4y5tj1iqKCGZa0dXdQnyre9OqpRfRvxbmr3uxeycsWgVTxLby/J88tk//o3Vuc1icCWNIKzTUgQMVYaSstMo5Nh3xCvH2jqdTU4PkqmUYrXzWwlOzbw1RJPU6Oq+RipGZHdUcOCDtkEenfgArckG8ERO9YZlh0LmjApIUXoMSj4tw0FAyYAmQLu/uu1KMr1O1UL/66+Gc1yYP3ESiRDK5zYjDFcrJosAWnl4OvpQQbnJf4hD3FC93xfRZ7iElOZPXgUIgQU5TBjtdzebNRF6itfwKylSOXy7/wFt8ilrXdjU575u5Klw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a886a-ed35-406c-a46d-08d6a1cfefea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 01:06:17.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
inside, the system controller is in charge of controlling power,
clock and watchdog etc..

This patch adds i.MX system controller watchdog driver support,
watchdog operation needs to be done in secure EL3 mode via
ARM-Trusted-Firmware, using SMC call, CPU will trap into
ARM-Trusted-Firmware and then it will request system controller
to do watchdog operation via IPC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V6:
	- use module_platform_driver() instead of module_init/exit to make code si=
mple.
---
 drivers/watchdog/Kconfig      |  14 ++++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 174 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 189 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 242eea8..33a6523 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -641,6 +641,20 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
=20
+config IMX_SC_WDT
+	tristate "IMX SC Watchdog"
+	depends on IMX_SCU
+	depends on HAVE_ARM_SMCCC
+	select WATCHDOG_CORE
+	help
+	  This is the driver for the system controller watchdog
+	  on the NXP i.MX SoCs with system controller inside.
+	  If you have one of these processors and wish to have
+	  watchdog support enabled, say Y, otherwise say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx_sc_wdt.
+
 config UX500_WATCHDOG
 	tristate "ST-Ericsson Ux500 watchdog"
 	depends on MFD_DB8500_PRCMU
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ba930e4..136d9f0 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
 obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
+obj-$(CONFIG_IMX_SC_WDT) +=3D imx_sc_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
 obj-$(CONFIG_RETU_WATCHDOG) +=3D retu_wdt.o
 obj-$(CONFIG_BCM2835_WDT) +=3D bcm2835_wdt.o
diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
new file mode 100644
index 0000000..ee48709
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define DEFAULT_TIMEOUT 60
+/*
+ * Software timer tick implemented in scfw side, support 10ms to 0xfffffff=
f ms
+ * in theory, but for normal case, 1s~128s is enough, you can change this =
max
+ * value in case it's not enough.
+ */
+#define MAX_TIMEOUT 128
+
+#define IMX_SIP_TIMER			0xC2000002
+#define IMX_SIP_TIMER_START_WDOG		0x01
+#define IMX_SIP_TIMER_STOP_WDOG		0x02
+#define IMX_SIP_TIMER_SET_WDOG_ACT	0x03
+#define IMX_SIP_TIMER_PING_WDOG		0x04
+#define IMX_SIP_TIMER_SET_TIMEOUT_WDOG	0x05
+#define IMX_SIP_TIMER_GET_WDOG_STAT	0x06
+#define IMX_SIP_TIMER_SET_PRETIME_WDOG	0x07
+
+#define SC_TIMER_WDOG_ACTION_PARTITION	0
+
+static bool nowayout =3D WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0000);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defau=
lt=3D"
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static unsigned int timeout =3D DEFAULT_TIMEOUT;
+module_param(timeout, uint, 0000);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default=3D"
+		 __MODULE_STRING(DEFAULT_TIMEOUT) ")");
+
+static int imx_sc_wdt_ping(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_PING_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return 0;
+}
+
+static int imx_sc_wdt_start(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_START_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EACCES;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_WDOG_ACT,
+		      SC_TIMER_WDOG_ACTION_PARTITION,
+		      0, 0, 0, 0, 0, &res);
+	return res.a0 ? -EACCES : 0;
+}
+
+static int imx_sc_wdt_stop(struct watchdog_device *wdog)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_STOP_WDOG,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0 ? -EACCES : 0;
+}
+
+static int imx_sc_wdt_set_timeout(struct watchdog_device *wdog,
+				unsigned int timeout)
+{
+	struct arm_smccc_res res;
+
+	wdog->timeout =3D timeout;
+	arm_smccc_smc(IMX_SIP_TIMER, IMX_SIP_TIMER_SET_TIMEOUT_WDOG,
+		      timeout * 1000, 0, 0, 0, 0, 0, &res);
+
+	return res.a0 ? -EACCES : 0;
+}
+
+static const struct watchdog_ops imx_sc_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D imx_sc_wdt_start,
+	.stop  =3D imx_sc_wdt_stop,
+	.ping  =3D imx_sc_wdt_ping,
+	.set_timeout =3D imx_sc_wdt_set_timeout,
+};
+
+static const struct watchdog_info imx_sc_wdt_info =3D {
+	.identity	=3D "i.MX SC watchdog timer",
+	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE | WDIOF_PRETIMEOUT,
+};
+
+static int imx_sc_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *imx_sc_wdd;
+	int ret;
+
+	imx_sc_wdd =3D devm_kzalloc(&pdev->dev, sizeof(*imx_sc_wdd), GFP_KERNEL);
+	if (!imx_sc_wdd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, imx_sc_wdd);
+
+	imx_sc_wdd->info =3D &imx_sc_wdt_info;
+	imx_sc_wdd->ops =3D &imx_sc_wdt_ops;
+	imx_sc_wdd->min_timeout =3D 1;
+	imx_sc_wdd->max_timeout =3D MAX_TIMEOUT;
+	imx_sc_wdd->parent =3D &pdev->dev;
+	imx_sc_wdd->timeout =3D DEFAULT_TIMEOUT;
+
+	ret =3D watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to set timeout value, using default\n");
+
+	watchdog_stop_on_reboot(imx_sc_wdd);
+	watchdog_stop_on_unregister(imx_sc_wdd);
+
+	ret =3D devm_watchdog_register_device(&pdev->dev, imx_sc_wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register watchdog device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_stop(imx_sc_wdd);
+
+	return 0;
+}
+
+static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *imx_sc_wdd =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(imx_sc_wdd))
+		imx_sc_wdt_start(imx_sc_wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
+			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
+
+static struct platform_driver imx_sc_wdt_driver =3D {
+	.probe		=3D imx_sc_wdt_probe,
+	.driver		=3D {
+		.name	=3D "imx-sc-wdt",
+		.pm	=3D &imx_sc_wdt_pm_ops,
+	},
+};
+module_platform_driver(imx_sc_wdt_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

