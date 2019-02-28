Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8C12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UCfSTszj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfB1H74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:59:56 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:26017
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731807AbfB1H7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZJ8SMxLcko6bIe3fn56loucvzyfS6dgeEvqREv5BIQ=;
 b=UCfSTszjxOuSu+zw5nww3Pxqu72z1nLJGL7fzMIIxuoRbZzM+4Inq5554pET/239OnAIpmE9dhhjBmwCymHF4TdSFkDKY1UtafUYndkXCFbKIptaVKZ+WAZqZzSCrPcoiSw1RztE9uQa8+ZYgDju3delkhK6f9NFxhPw3M1JIfk=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3604.eurprd04.prod.outlook.com (52.133.46.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Thu, 28 Feb 2019 07:59:44 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec%7]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 07:59:44 +0000
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
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller watchdog
 support
Thread-Topic: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHUzzuQ+7Ug3zH4/EOjIZQiRro2RQ==
Date:   Thu, 28 Feb 2019 07:59:44 +0000
Message-ID: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ba0ade1-3d0c-4fea-29e6-08d69d52b311
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3604;
x-ms-traffictypediagnostic: AM0PR0402MB3604:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3604;23:RZQ3ITifScshQqfZzsfcIQ/DS/2dD7WujomLz?=
 =?iso-8859-1?Q?KSg8loVMY+p4YcJIL2IbtpdbkcpZfgDgWYggAuWigKyTrYCcQnleSI86pC?=
 =?iso-8859-1?Q?Q3TntktqrA7dQuq7qUC9oR9ZCFGxe/2afv12ZUUWnbnSafBzndrxBfZZsU?=
 =?iso-8859-1?Q?CXUEvS0PcYOQ7AIgTuDsBw70URL9XoiA6+fwD8l7KMgKVzAXByErM2OCs9?=
 =?iso-8859-1?Q?sUDsqEW6fDvjXJ10M2VkDcuOCoVuWb2r0aL9bZDJ7Dv1QCVPPn3KldCLOq?=
 =?iso-8859-1?Q?yX8h9YuGfWzgtZAhgquYoNmhCEs3UWOrpB6x4Rl3qSyQKjHNBa68Ow65P6?=
 =?iso-8859-1?Q?CxFbaDgq4LcOM783KEo7AUSfFl4m83HIT5KAGfsonEOQLZarDMgoTPJDSP?=
 =?iso-8859-1?Q?uKuDxjzCVmiA89RN0PykLpAz3mipJzNbw/c1pkNRlVVsGncE2WkDtGghdk?=
 =?iso-8859-1?Q?2m0VL/zymFyOfH9dSFH0GmtOusLfmADAEU92/J6Qs8eTy44uB0+mvrOM4F?=
 =?iso-8859-1?Q?cUeAhdvpdpl8ojg/7MDzrg3+5cdiqgC7LRgvxhB+yUMDxVAr5aQNQDR1k3?=
 =?iso-8859-1?Q?3qkAvkfpmVPior0FLQhcJoCzNX6utcJ7JNmzVS9yJywM/EKGQbya+I+wwZ?=
 =?iso-8859-1?Q?vknrr39Pwb5E44+mUsrlSUP/JoILl/cJJAabhgt+TM7gFFnoRIsoORhYHb?=
 =?iso-8859-1?Q?WeuAnuph5bVFTQzEtrlS/Cc9/tn3bEQdDXRfPbV1Eidwg/2yRe4AJ8sQx5?=
 =?iso-8859-1?Q?PCJS8N41yFI6JNtByxQueNEYuvYXM0SYqYbcT8bEeXcY8dRL0+DEbhMxiR?=
 =?iso-8859-1?Q?o/prB4H69AjaRW5YfNBe0uubXqLutm4B8lRwQ3l5obGN7azeYhQHeenYSm?=
 =?iso-8859-1?Q?cm7woHPFzG3TUZMVc1/9E1vFhXbkTBbJPAyqMbv+HUnWgdDP1kjHgdN85E?=
 =?iso-8859-1?Q?OgFtQH8g3gJxbg6QDTPd1bDEPRTDPRtDch3SDiK4sDBl7Im749c4EDRDW9?=
 =?iso-8859-1?Q?82IttC0EuD4EuoDRfXl9cXw/WW2mVv0xcwP4hj9V1/Q76ExAm0hdxutta0?=
 =?iso-8859-1?Q?4uPLG6aMmGiMuWQIDzrAcsOzW8LrCLzgK3TILcrapK/Wz3hG5enIzllpKC?=
 =?iso-8859-1?Q?0QVJHdqbIi/me9SGvOKk5EVEuAk0tFgWtyplLbrCZYUdbU3dHl29QW47Oo?=
 =?iso-8859-1?Q?g2VUhZ4ZL6KlFL9XFYGZbHrJFpk0ApfbpZKso1gm7K5DXcBf4APVqGelBQ?=
 =?iso-8859-1?Q?HuM7BPSRQeIZAEbwjrmDT/sl9Ncf9qV8LMRCtgl/A=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR0402MB3604EFEDC2356DE8885E6366F5750@AM0PR0402MB3604.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(68736007)(36756003)(50226002)(2501003)(7416002)(478600001)(71200400001)(71190400001)(305945005)(7736002)(97736004)(66066001)(14454004)(81166006)(8936002)(8676002)(2906002)(81156014)(52116002)(316002)(386003)(6506007)(6512007)(110136005)(6436002)(99286004)(53936002)(3846002)(6116002)(5660300002)(4326008)(486006)(256004)(2616005)(476003)(106356001)(105586002)(86362001)(25786009)(2201001)(186003)(102836004)(14444005)(6486002)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3604;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: elw365xgGbqBBxq7YVRrRzu27OIjK0ez+7zc1h+aMoSPaedFeKSk/Pj25p4WZMc63AOvvPD7idlfKHOCf5gvjDGuDxfw87PB1/HRu4uunoojjWOJ3AIb40EMkdrX4OJfhy7tb6xPISso+6yLUApQdL3FP6F9OoWZanduX3bFhhqoS3Obw5BaY3H9ISyJfANjK5HU1fI9I40KCQLtlmEk4xEJL6rmgfCOYe5Bio0YM+HHunZcWJaGADRbqzCZqPE3S6QAUJWU+ZdqLD1wTe2/ovwXnEoHE2srFGLrbRG4j5ke04Tnhnqe5bB6exChYaUHbl/tVwBv582ZrOEc5z+N4l2ILUmt+k2Esf9QzH8XO0VrU/mVC9VpplE/1tcKYzXA9HvQaRnhldqBcrkQytWY9N4vVfDKrmebfFgXRSE8k3U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba0ade1-3d0c-4fea-29e6-08d69d52b311
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 07:59:37.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3604
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
Changes since V3:
        - add ARM64 dependency for this driver;
        - change SPDX license to GPL-2.0 to match module license;
        - register platform device in driver instead of getting from dts;
	- return linux error code instead of system controller firmware error code=
 for watchdog operation
	  failed case.
---
 drivers/watchdog/Kconfig      |  13 +++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/imx_sc_wdt.c | 201 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/watchdog/imx_sc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 65c3c42..8c6575e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -625,6 +625,19 @@ config IMX2_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called imx2_wdt.
=20
+config IMX_SC_WDT
+	tristate "IMX SC Watchdog"
+	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
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

