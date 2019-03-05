Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F309120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZO/gRIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfCEDiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:38:01 -0500
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:61813
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfCEDiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+wWz95AMiDNXtfNDWx1y8SuYgMBszwnk3I5dxhEqRo=;
 b=eZO/gRIalbHY2B4SxMWsD7EmDloLfAjCNvt1Ue079pmwcacaA/jMmBIDGzn0+x8qjdPq05hzuAgf27D0fSSWKnbQ0y0FF/hFiqxrHWBbXPF31vFyTqNf6koLDh1KVrLIPs5XFFf4jIbqDsNzngpsJb+gV482aaHbpEWRJjhUVhc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 03:37:52 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 03:37:52 +0000
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
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V6 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH RESEND V6 1/3] watchdog: imx_sc: Add i.MX system
 controller watchdog support
Thread-Index: AQHU0wTQ33Evge0D1ECrmYOlf3SLWQ==
Date:   Tue, 5 Mar 2019 03:37:52 +0000
Message-ID: <1551756791-31401-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 24b7ca06-aedf-4866-ca83-08d6a11bf21d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3737;23:3zUWMQXZZiTM0qUEzx0ojkHETXNBuwic5fNbL?=
 =?iso-8859-1?Q?LG8aOEqVUY9CEOiEf1zzuDjX6NOD7OJG082rMlG8O4iXLd9N8FHhQ86oNM?=
 =?iso-8859-1?Q?V5/WQhEADfQ1OSE8vyZ7ioHEEtktjTw+r4mhjjQK45CkjXHK9F7mnRpY88?=
 =?iso-8859-1?Q?l/u7Mbr60maD/YqgCbYRHscpxwVGfvB0AAjUElxJoxHJlff9+Z7073sHGB?=
 =?iso-8859-1?Q?FKEclclGQ9om52ALjmGpCRJUYZ4Cqg+BeZuaxll2qkqFQoG9+NdnPzVWy0?=
 =?iso-8859-1?Q?juL1rn/2Dz6iCFVUB8hQcxU+Xlw+7tlgGtjd3bThyE/6CljXdrJMRGg6sK?=
 =?iso-8859-1?Q?1uPi3Khd+AJ1eTzisCzrptnvg7HqBHXy9VaJF0XjAV/F20dKoT3ZCXiKJ8?=
 =?iso-8859-1?Q?iRiqL++W6xY1jVxk5xOXqcTXLve6kDxyg3yK86pdtYYeORiKY5BjzYLJeD?=
 =?iso-8859-1?Q?MjaokeU5ISZka3SMfLLCaCwwguymiNhEYkCZ8GzZyjBivJIWCWh1YoJ0dz?=
 =?iso-8859-1?Q?bAaPvVWJ1Ayzt3mWmid6eVijvZ+V3uRqEQ8Xw3a0lBIPVK+Uu9ihW/P3jZ?=
 =?iso-8859-1?Q?7wL+baXn3AAHkdKH2VbCb2t6EKPyvKFggAndVf5MjkhZuCgmUqyg7eJks1?=
 =?iso-8859-1?Q?5QbjiCqxI9aYqCb790HxxFWMKKu2LSYvclryHNADdIo4QbJv97awBLPolQ?=
 =?iso-8859-1?Q?Tp4cKe2bhnjhOocaDfClNFqW7XtiqNwwj2IacFo7i0ct/BmVxNFWz1T6tX?=
 =?iso-8859-1?Q?xLAap6Xboj3rntakc7Yae3dFvd8izYKddse+q0+k3Zzo20obTXTdryWNap?=
 =?iso-8859-1?Q?NC2u6bqqZjmz1v6GjYDzgGt0oYj2hkZufm4Gktx5og5YkHRQJZ5+1Lks2H?=
 =?iso-8859-1?Q?HPZomFHWLxxU07XiBq0zVA3KfnIDH0WWlMWjz69H8zwcS8PKc3tIXDrjz3?=
 =?iso-8859-1?Q?7ahVMHdDqODUvps6Rt3gDfpHutua8xwZ1bgXCOoIs40OBOh3d1rExr0xPe?=
 =?iso-8859-1?Q?VqMZsI+1i5EFjJ6+Sf2QXfbvbawsV6cgnfv5fJ4naZysSKQhx+4MLbONKw?=
 =?iso-8859-1?Q?NBZSnaAiqWHkroy4rmVXWWL3w/lJcKTwJrzq92HbbaMwIOlTqCd8aKc+gV?=
 =?iso-8859-1?Q?gHN5f0dpeDX+5eYQ0Mm+Qoh/6n0oRnF63PXXJnFqHYtN8kZOu9qJ3RIId5?=
 =?iso-8859-1?Q?aIOeRb7A4FH64a0u+gc9bU1Lc8FTndFs4GnnSacnPjrwU1creEFwuXjJms?=
 =?iso-8859-1?Q?y2HsQeHUB8T/HQPZEdtNVpCS+PkObAC25yBB6tZCw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3737EB27EAB56247FA7DA62EF5720@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(53936002)(8936002)(81156014)(71190400001)(476003)(2906002)(8676002)(81166006)(97736004)(6506007)(386003)(2616005)(50226002)(6512007)(486006)(106356001)(68736007)(66066001)(105586002)(71200400001)(2501003)(7416002)(305945005)(110136005)(99286004)(7736002)(25786009)(4326008)(186003)(26005)(3846002)(14444005)(36756003)(86362001)(5660300002)(6486002)(6436002)(102836004)(316002)(14454004)(478600001)(6116002)(256004)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hnShTGPi6AIY2CMohfeYihn+dJSnIEgxYbWnpS+eRhYtRCibEwEdV0PT83w+ZJse8v+wiID/ws8w7A9KRGv/Tye2UFMX98qQGBR24qj8yBKtS1Jb+6EO9nBG+vpTx2ytc5GCKSL/lJ23uT0sXxgW8R4zc84Br6NgtBd/JRKEvmqq07zQLPwjnWyk3QuUBPdYpuzFmh3bNyPEiuT30esRCpI8HmseRaN2cuv8tZryJoS71/r2W/7uS72qsLAEKh/CYuk6AQAjRE58cmX0nSuvBdldWlRjMuUlANMnImVkbQc0Aekv/xDoDH+8+v7kDt2fByEsIHEif81KR2OkkF+bMyg78HRuIZgVoLlR/LitvPCMTLp2l0mEgcT7oZHO7vdVY7CAt6jmXV8lyjgBMypr4tpYcSxIvO9jKPIXWvXcCOM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b7ca06-aedf-4866-ca83-08d6a11bf21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 03:37:52.5676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
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
	- move the watchdog platform device register to SCU driver probe, be child=
 device of
	  SCU device.
---
 drivers/watchdog/Kconfig      |  14 ++++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 185 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 200 insertions(+)
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
index 0000000..2645203
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,185 @@
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
+
+static int __init imx_sc_wdt_init(void)
+{
+	return platform_driver_register(&imx_sc_wdt_driver);
+}
+module_init(imx_sc_wdt_init);
+
+static void __exit imx_sc_wdt_exit(void)
+{
+	platform_driver_unregister(&imx_sc_wdt_driver);
+}
+module_exit(imx_sc_wdt_exit);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX system controller watchdog driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

