Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B437206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ID7OU4Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfCAGfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:35:41 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:26558
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfCAGfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWQA1Mb7Vzc0MD6WL9LZC9+bVxC2Qb/9LtBypadIIfE=;
 b=ID7OU4Ektx3A0EkAhPcatSaWptKanXVoiEuh96Tj4hicA9aJoIwYfi9F/V/k/LmanHNgUVfDv1kMjTT3KUuslI/SazJw1Fg3wGMEHAwOSVDLoxOx+Ys06DR+2gVdzxXosjO0WmsFHNhyHHvRAfEybtWOVa/dgT1yHIDD8rbZJY0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 06:35:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 06:35:31 +0000
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
Subject: [PATCH V5 1/2] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V5 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUz/j3fx/UZgPASUehlWlciSAbcg==
Date:   Fri, 1 Mar 2019 06:35:31 +0000
Message-ID: <1551421837-21230-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fafc8d9-c4cb-41ac-8d93-08d69e1019f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3899;23:kaI+t8bF5wJ5TA/genho2gjhGyUweS5rZiM2Y?=
 =?iso-8859-1?Q?RmfRMXimBTWuq8W56eFyi9wdiSxqlo5GLkeKsgZtC6v7PyRQf/w1qdsyUc?=
 =?iso-8859-1?Q?1MRSojaO7YFi2BsECYC6FEy6es7fwMpJWVhdl3+5Q+15RQDQudZgNgZiYY?=
 =?iso-8859-1?Q?7z0Nfl+rnznjZY+fHL9xlswhqxhM6PxYHe3HmN/87exLVXTctBKDGu5Lwk?=
 =?iso-8859-1?Q?kPxbbMVUEpr6LOmZgD8EfbadE8gPLIlZ3H7mglytG47N5xZ3Agtlj5xnib?=
 =?iso-8859-1?Q?FO7BNfG9OOv+ZHWi3DrJUtSQW0mQ47D5kKEiBuD/176jrWL9knwMskPNSz?=
 =?iso-8859-1?Q?M+w/b0mZU5Q95YGnEE1dHgEOiRLyyutGnorEr8DxewuoMqAnRjmh/TB9nD?=
 =?iso-8859-1?Q?3osrJ51qRHX9GlLq1fO/r6myf+zjAciqrcmER7lkU5YVRL0mUNfHTFSqG0?=
 =?iso-8859-1?Q?2B6w+USbF3qfYeAemDIuJKPk610EvKS7MUb9WK+M1qQ9kXgyuyGIc3Kmwa?=
 =?iso-8859-1?Q?A3F9cYQODNC7BpqzRvPfENA4AXytG+02sc9GDIO9yy5PWc675xaLbj3yzX?=
 =?iso-8859-1?Q?skJabuC3pWKOqVXQ+YxM6Zg42tsUcbhBFvm+wh6sUU06AOS4G0D4dp6ZeU?=
 =?iso-8859-1?Q?5OlbckwAknTi4aoAuAeV8E8uO/xrBgwAahOUJ2ooU4Ntm/BIjxYSo4XFki?=
 =?iso-8859-1?Q?qoQLIo2lq92ffsetpAfjeOh+LJYygIrybJamdzwM8PtmAhCkzUSRFd01GR?=
 =?iso-8859-1?Q?hL8pfx8uw63EO3olgGRtQRa66t2CQqID8DO65uxBL2QH4m3XrGUsbqTqar?=
 =?iso-8859-1?Q?iD/cm/4ukHKZv/S5rqbgQyCkMaeYQPOanB/UlmVFlrAPKBUh86AFrDuUSZ?=
 =?iso-8859-1?Q?Zpd9vNFtKxwEnc0EnMApBXlC/c4yJXVM8RFJTiLdY7lTj+hzHmgb358gtT?=
 =?iso-8859-1?Q?GOydmb+dd4YLkamYHH2+W24PKGg1hwMmpe4JT4GrI1OXV5xtWdidBZ9ImB?=
 =?iso-8859-1?Q?2g73vFbeS8euVOlGEAC0iNl9KIVBb2bRv4vA8EwfBBy9zqsTfMy3XXPaVf?=
 =?iso-8859-1?Q?AGDbRqRLR1zm3kA3cmq6yi+2gB/fPnNwDqKh08ZxScdWJTAU1WbfR0WC0z?=
 =?iso-8859-1?Q?vL+zl7c0IxZ/yI1A7GZD2wFFEfJ/i+cW9Sr11PEFQYuGRbLG+k2DUK030J?=
 =?iso-8859-1?Q?8Um8I0l68WBEr/vZiAU7cSwixbg8iFfEc5eMNf3nFjDwPqJ6UJr5DPuWq/?=
 =?iso-8859-1?Q?ZftbMH2kMBXxaU2apHpQ7OguQJlh5FCYSDt/CFXW+TMtyY78qUF9dUwIV3?=
 =?iso-8859-1?Q?EkGqA2I5B4T9Kkl9W4TX5qzwLyq8oUr6ch5AR2eNNcgGFVmMkyjd+MqWAL?=
 =?iso-8859-1?Q?MSXKPlTFQM=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB389974F9A54ABC90C09A971CF5760@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(26005)(476003)(2616005)(316002)(99286004)(36756003)(386003)(6506007)(68736007)(50226002)(52116002)(305945005)(7736002)(102836004)(5660300002)(8676002)(486006)(106356001)(81166006)(7416002)(105586002)(81156014)(53936002)(2501003)(256004)(6486002)(25786009)(4326008)(478600001)(71190400001)(14444005)(186003)(110136005)(6512007)(97736004)(86362001)(66066001)(2201001)(6116002)(8936002)(2906002)(3846002)(71200400001)(14454004)(6436002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FOD1UChP6CRufB+ngLmLgYUiIErb412vqJparhhR/4D1GBUzOCsSR+/1zBekMq7gvBaCYAFkVZpKa8QjzPOt9iWzp49VWVjuepJ1jJBKTG8LvE2f6OrgG4zh8Duw9TtDwVVCysRQMzcRxLbfy1xTjSB9hN+Lo5FWOdH7rg9NtVOSrirxQg6O8cJHsMDPEUh8qb8vZMSQhMd0KD+DB20RqqxyvYxkrXkxvuY/UryFGWg/Ff+KkGfcHiVzn+mhWYlwJeeIBtfWGVfz501eFLKJS5QRaL9mutXuiOaZHh+u2yS5OLTW/2f/vUuocBGVXjTUBMXYg67yZgE+l6XsTo5vgtw+StMwoKNDPjajvEgpEDso1jZ18CZDT8BDyfufGnt2lYYiDC4r+F0nOVLabE5GdYDevZiIa/Tim+TyqaZVeVs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fafc8d9-c4cb-41ac-8d93-08d69e1019f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 06:35:31.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
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
Changes since V4:
	- change the module build dependency as depends on IMX_SCU and HAVE_ARM_SM=
CCC, as this
	  driver is ONLY for i.MX SoC with SCU inside and it uses ARM SMC call.
---
 drivers/watchdog/Kconfig      |  14 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 201 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 216 insertions(+)
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
index 0000000..50b49b2
--- /dev/null
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -0,0 +1,201 @@
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

