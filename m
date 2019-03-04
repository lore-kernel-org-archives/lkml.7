Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6E208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="juF4GTj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCDEZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:25:33 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:23360
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfCDEZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USPVWPzI2/7V9HrcsVX6udDqEOsTAhAi4I/sDejX9aA=;
 b=juF4GTj2yqd3sPCvSJL++bhRRtm44uoK1BjhoaDQyYbUeew++HALQaB2V4b0gPFnzfGs+Jpy/4/+iq8bc5EMFqSbC+wf3rs40VyhV8Cbiq4uEVIsJc/49VePVK1uNiehuXL1d8XDctAPo/USwQG3uKUlcrFjbZBBOxvDU4JhLK8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 04:25:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 04:25:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 1/2] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V6 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU0kJHl6Gk6fg170aPbIypHs8nmw==
Date:   Mon, 4 Mar 2019 04:25:21 +0000
Message-ID: <1551673236-27834-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48e82230-582c-43a7-5cb6-08d6a05969eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3852;23:U8AmwI4ALONXKAokOnWiHb7IOKBAJLygf2cTa?=
 =?iso-8859-1?Q?2JZt4e0yuXhlRSGIf7/6Tovy1mALePdh4ZQ53SbouktBUx7N9C1DB/9ljQ?=
 =?iso-8859-1?Q?hkQQI/bLn1c+yljrrS+gVTfpA9jCQh1TNupMiv+rUTkkWGt6ZjlMkxy6so?=
 =?iso-8859-1?Q?gzrK14L3epSxGfYZhb6N6bYoLN8ysojr9mgBS47MttgZjga4riZvZrCII/?=
 =?iso-8859-1?Q?OmHamIAWHst3IntlyELa5cm3aDb5w+53yv+ucJo+mzvYxTD6YgbdImhiNb?=
 =?iso-8859-1?Q?fwYS8NLqgUx9Krdik3Ahc9YLM1mawqNecm7xvSCuvK36hKu1BxqTPTUmTk?=
 =?iso-8859-1?Q?6VCmAq5IrNV/9GKnUgHNaPlbWIoPkMBC5nKRTchGcLua2RpzD8IENuJk9j?=
 =?iso-8859-1?Q?pYsJADOlE3ncydq42DkLaVw78nVp/lI/fFOH3bYtVqlXkCb5cwgdU9Fuvu?=
 =?iso-8859-1?Q?+CehYjK2W8PQ6to3RNiLAWhvnZRAkNun6UtZYoE/OjMPBMyWNGmcAQmW6H?=
 =?iso-8859-1?Q?TxHxYRJ0FAZITlzsLo5nlfOnAp8jKGMJxAmIhJ7HapxkrXk51fyBHSMwsN?=
 =?iso-8859-1?Q?fb1y/D2BZsIXjoLsyRz9F+w29PWcELo/srHJQ0SOXiRfIkjfX5SI+FG9lw?=
 =?iso-8859-1?Q?5AtH7eaX19DdizRpFddXykMncqlaa71cLRoBG9aMxtNvmcPXr2UHTrwd52?=
 =?iso-8859-1?Q?bQO1mJCR+5977TJbc+RyghWrjhoDS+GSQVQqSE8fL6rWra/ZfYFtcbU4zY?=
 =?iso-8859-1?Q?ytoSr9QN/oFjrIr04dftb7iNejDFJOI9HWx0LthOeEngT1mOsFuxldXkMQ?=
 =?iso-8859-1?Q?XOV5Xdo7mD5Q+Ncnmp5Y42N5FuY+0Y7eVG6EF9Znie9QZPneSbOw/m5aex?=
 =?iso-8859-1?Q?RXwOCQwGLEzj94TpNaqkEirKubSmXwk/oz5GLz9cq4zRGs4znRM7CvtPT0?=
 =?iso-8859-1?Q?fUt8zkyuShX4TS2T2bzXdzrYPw82GG76PhkDa8F2KCreLEubTUhYKljF+5?=
 =?iso-8859-1?Q?ys6FDpqQXXXccLHGdn9yXNr9SgQ1ex9IOiyWn6dLmlPgpkXD9jcmvLBY+v?=
 =?iso-8859-1?Q?DtQqow+76Bm8DcW0NkoitlyEEAZPCJ4zuuzCru3qV8g3E3R3YdRvVVRV0n?=
 =?iso-8859-1?Q?ws2MJTLczihE4N+5NsRVdxSIIx6ORZ4bYRl25hMtMdAlSAWeqDwtX9NQDR?=
 =?iso-8859-1?Q?BwiaMO+wXgzLSgdo/V8xPF4yG+q+wvONBc9KwL5eeNSdTMiYf7mh7Hjh02?=
 =?iso-8859-1?Q?sLKybC69VHAq50c+dz167Zq8Ufwk3CkHN/9a5zsmg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB38520D4BCEE8A547DB681D3EF5710@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(256004)(102836004)(6506007)(476003)(386003)(106356001)(8676002)(81156014)(186003)(4326008)(316002)(110136005)(2501003)(25786009)(105586002)(5660300002)(7416002)(3846002)(97736004)(486006)(81166006)(86362001)(6116002)(52116002)(99286004)(2201001)(26005)(2616005)(305945005)(14454004)(8936002)(66066001)(6486002)(50226002)(7736002)(478600001)(6512007)(53936002)(68736007)(6436002)(36756003)(71200400001)(2906002)(71190400001)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0qY8+9k8GVkcU/tUGWPopPBMz5eUsuu8vf4CiRHg3+8n/oXMMOchMdKdwZKp2TFlf5nkAI6KF42C+a2xAwIW51mC4nwn6/BkxN3k7O/Da2XPyqbFfAELN3L0KFoBnNXKVyq+h+i4y1hQR9TW++wLPA5uvAArEivkXCYYVfikWhqv4Z1PlQLqtmQxvvcinXeCU4qcWIz0aMCpAOxPhtu/GKjHXJGA4MbQa2DIQWHnGVV1RTbytghPvIY8q8BIOcnBi8BnCHZmyAZCahZS9XQB2rJXgxBjtYr8pzkObWxr6XsNZAZ9+wxqoS81jvYbtgLYzbSU4DU189Y9x/UUObhGmTo9a+ljOE3AciZ/NRccqYVY30WxzCpQCZmlBmE4DWeZJ3qQYbfHb8UiDxDjhvQ5Ud5pOA3aq740nv+4S0OfM0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e82230-582c-43a7-5cb6-08d6a05969eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 04:25:21.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
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
Changes since V5:
	- add "fsl,imx-scu" node check in imx_sc_wdt_init() function to decide whe=
ther to instantiate
	  the imx scu watchdog platform driver/device.
---
 drivers/watchdog/Kconfig      |  14 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 204 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 65c3c42..a6bfa54 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -625,6 +625,20 @@ config IMX2_WDT
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
index 4e78a8c..0c9da63 100644
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
index 0000000..df8b3e3
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,204 @@
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
+#include <linux/of.h>
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
+static struct platform_device *imx_sc_wdt_pdev;
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
+
+static int __init imx_sc_wdt_init(void)
+{
+	int ret;
+
+	if (!of_find_compatible_node(NULL, NULL, "fsl,imx-scu"))
+		return -ENODEV;
+
+	ret =3D platform_driver_register(&imx_sc_wdt_driver);
+	if (ret)
+		return ret;
+
+	imx_sc_wdt_pdev =3D platform_device_register_simple("imx-sc-wdt", -1, NUL=
L, 0);
+	if (IS_ERR(imx_sc_wdt_pdev)) {
+		platform_driver_unregister(&imx_sc_wdt_driver);
+		return PTR_ERR(imx_sc_wdt_pdev);
+	}
+
+	return 0;
+}
+module_init(imx_sc_wdt_init);
+
+static void __exit imx_sc_wdt_exit(void)
+{
+	platform_driver_unregister(&imx_sc_wdt_driver);
+	platform_device_unregister(imx_sc_wdt_pdev);
+}
+module_exit(imx_sc_wdt_exit);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

