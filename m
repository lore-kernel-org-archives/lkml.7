Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E10217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qBmGlGot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCNG2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:28:03 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:3846
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726582AbfCNG2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozM8xJapVS1zhzY4f1DgtdESKk+5oo4+wHRFBNyuDDw=;
 b=qBmGlGotRdZjxXI1dblaM58DzxAR9zagZOlPMbXBxwh59D9HMZL8z2nBRmp5qFnQBM5EPBNwKhPzeaqnI8lOv0DKk/OuMG1Da14+K+erYRfcgnwNbFDrcoN5Ax9yrBCej03wdwHiT4rfSVCI+Al1ysLTzJgxItaM5vGQo6YGLzU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 14 Mar 2019 06:27:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 06:27:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V3 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2i764vOO5orQxk2KYZOvBbEwvg==
Date:   Thu, 14 Mar 2019 06:27:20 +0000
Message-ID: <1552544534-5295-3-git-send-email-Anson.Huang@nxp.com>
References: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552544534-5295-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d02e0d24-1513-47f5-3c03-08d6a8461c6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:T713Mj0A+lp5hIP1f4jk18t8Ont1jSlAeNXIg?=
 =?iso-8859-1?Q?18PvRYGAqhyT/6P1VW6dkum58dnEu+QbHpWny8fmBrKGBtwL/SoqhB2ItP?=
 =?iso-8859-1?Q?TAiqfBj35KqI9AFQUrGDnyFCfnjZvz4ZXiF25cnORhFCP+JV9ojbe4e6eR?=
 =?iso-8859-1?Q?MzGGnhqCNXxejgyRGe1DpE6yAX+DMlFp1TSHNDYWxjCgoUK7YLBilY76zH?=
 =?iso-8859-1?Q?0m7bv1WCcQbWPXvl6Zj52pckAA4QzK0s+OVO9PPtE5b4KBrYplQ/Ye6lUh?=
 =?iso-8859-1?Q?rY6ex9+bn+vnXiBYw49tTctF/KHajEygS4x5SEKzRJpGkQn/MNhO2EdkxK?=
 =?iso-8859-1?Q?02nRZw/A/XyQevyO50Zsi/TmifIy1ykENg5S0wpPvAiSRb4MVCtjz9tE7+?=
 =?iso-8859-1?Q?SgFXw2BOBLNDIlKlWDcVeOulFeqY9aFrMVz5WG5xokZmRA4t/HHl3AEFFH?=
 =?iso-8859-1?Q?UwekUliwg7AhZcbbWs2hAhfvhX5Ko0g55hBDr2ilocgz62nG/LrmXYuxzp?=
 =?iso-8859-1?Q?Q8EOk1vXFe9U+8I8bGrySuIcCrM1B47eEWUWYDzxJshA7mHKemR6NIbWVQ?=
 =?iso-8859-1?Q?LTeth6ULYMkmfs0yBXdnXfFJmIn2rb66BEVyAu2kQYaRm0wf/r7cJns04A?=
 =?iso-8859-1?Q?DauftKmLA1j+mhNYf7TIVVFDo8OS8BsMvzGYxfUYSOkRe0QputifIdhJvj?=
 =?iso-8859-1?Q?hbQh1nJCBKT+yRIOSZx6TMSCzAqW/dPjQuVIvqeg3XFPuLOUzUn/ge/cr9?=
 =?iso-8859-1?Q?/ZtdI9YFxoBK9MDYUOY+g1ixFEwMLH7Ay2mU3ED/xvtboCslWR6btWJIXW?=
 =?iso-8859-1?Q?a3LH3treyvkEyRoShrZrVTKa2l/qUKe2vgpWh6tg6UEs0mZY8u3xfFUK2l?=
 =?iso-8859-1?Q?+6S8zGCzp36Ld3Gh2b/5txBypk3D2xHm72b15tJjvCcGCJK2LDSFQLeskw?=
 =?iso-8859-1?Q?/Ws0Pts4AdHqPmLM3Q3QxnvSFbqIKUFmqS5USLHcrPU1yLnsyQzDYWc72H?=
 =?iso-8859-1?Q?mXZbbTJZUWs3otphc3ezca5pzF+fckNwSZaVW0mv826Exuw6D2FsoRhzJQ?=
 =?iso-8859-1?Q?Gsp0yk6DbvFDFjn7mxMp4rDXKPyYAGpASXCbKOcY078I93sY/LGC8+18EU?=
 =?iso-8859-1?Q?TB1mqki3pgjZ92zvn1+LudoSVkI2JbsE/PmGDk53e4hoInae7jMBwMHU/x?=
 =?iso-8859-1?Q?WJPd3bSiF/wQBRw2ftGMCM+WTjEP/bNOdGX9y4k1DxBnO6KmgwkuP8SFgB?=
 =?iso-8859-1?Q?Hw7tqkQ6hUCACRaiju+WdjVVTJXa/LUCR1RxJWvSrw+yY/jA/rbfauyKmT?=
 =?iso-8859-1?Q?Jwmk88/lF3Un/lJS6QTFoXD26N91iAwel7IlriRwXXsmiBA=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37071DE4EE3853765BF78AF6F54B0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(76176011)(478600001)(6436002)(26005)(97736004)(6506007)(476003)(7416002)(68736007)(30864003)(8676002)(102836004)(386003)(446003)(81166006)(11346002)(81156014)(305945005)(486006)(14454004)(186003)(110136005)(2906002)(2616005)(106356001)(105586002)(7736002)(71190400001)(71200400001)(52116002)(316002)(2501003)(6116002)(3846002)(66066001)(14444005)(50226002)(4326008)(5660300002)(256004)(36756003)(99286004)(86362001)(8936002)(6486002)(2201001)(25786009)(6512007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rrfUydfu/+HoTHpmQufCH0DXmukWEgDAWXN7EycLwADMILwWfXtY4vt04XfuLsuVso/MlNSFwk9BsZjpaveKKVUhmT9xKVOTUgVRrbwqxnPG68w2ZtzPynrl3TEUPQmPDS2WXN86/9hZwTrpPTNwizX59FrPl0Jo/hnkVnlyi7NkwZcCU8UsZHvpI/KPG3LtwCttBEY0MAEBS2rjF+LadY/i6ENpF+E0eKBOuEiil+zvTLI4yEVY2Ayid2dvAc2az/FJvsLcu/YU2+U6t3cNOAciZdWqxh9Dl7sxQSvsTmGaY58GXhx6aBJuOZy5Zp6Kx07g0uxPjPaXSeRT8uZJHCOpzvMhEBHgUQzSueSbDhoU/OSts7hlWFkZ+imSFL7wDyfrWnTg2Fa696Yab62FpntSkqJJ57pmi7O2e/l1uCY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02e0d24-1513-47f5-3c03-08d6a8461c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 06:27:20.1938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- Add "IMX_" as prefix to macro define as TPM is already used;
	- Use macro define for channel registers address instead of calculation in=
 everywhere.
	- Add limitations statement in copyright.
---
 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 343 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 354 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..c1cbb43 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,16 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX7ULP TPM module, TPM's full
+	  name is Low Power Timer/Pulse Width Modulation Module.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-imx-tpm.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0..64e036c 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX)		+=3D pwm-imx.o
+obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
new file mode 100644
index 0000000..cdb29f6
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ *
+ * Limitations:
+ * - The TPM counter and period counter are shared between
+ *   multiple channels, so all channels should use same period
+ *   settings.
+ * - When a channel is disabled, its polarity settings will be
+ *   saved and its output will be disabled by clearing polarity
+ *   setting, when channel is enabled, polarity settings will be
+ *   restored and output will be enabled again.
+ * - ONLY when all channels are disabled, then TPM counter will
+ *   be disabled.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define IMX_TPM_GLOBAL		0x8
+#define IMX_TPM_SC		0x10
+#define IMX_TPM_CNT		0x14
+#define IMX_TPM_MOD		0x18
+#define IMX_TPM_C0SC		0x20
+#define IMX_TPM_C0V		0x24
+
+#define IMX_TPM_SC_CMOD_SHIFT	3
+#define IMX_TPM_SC_CMOD_MASK	GENMASK(4, 3)
+#define IMX_TPM_SC_CPWMS	BIT(5)
+
+#define IMX_TPM_CnSC_CHF	BIT(7)
+#define IMX_TPM_CnSC_MSnB	BIT(5)
+#define IMX_TPM_CnSC_MSnA	BIT(4)
+#define IMX_TPM_CnSC_ELSnB	BIT(3)
+#define IMX_TPM_CnSC_ELSnA	BIT(2)
+
+#define IMX_TPM_SC_PS_MASK	0x7
+#define IMX_TPM_MOD_MOD_MASK	0xffff
+
+#define IMX_TPM_COUNT_MAX	0xffff
+
+#define IMX_TPM_DEFAULT_PWM_CHANNEL_NUM	2
+
+#define IMX_TPM_CnSC(n)	(IMX_TPM_C0SC + n * 0x8)
+#define IMX_TPM_CnV(n)	(IMX_TPM_C0V + n * 0x8)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	spinlock_t lock;
+	u32 chn_config[IMX_TPM_DEFAULT_PWM_CHANNEL_NUM];
+	bool chn_status[IMX_TPM_DEFAULT_PWM_CHANNEL_NUM];
+};
+
+#define to_imx_tpm_pwm_chip(_chip)	container_of(_chip, struct imx_tpm_pwm_=
chip, chip)
+
+static void imx_tpm_pwm_config_counter(struct pwm_chip *chip, u32 period)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	unsigned int period_cnt;
+	u32 val, div;
+	u64 tmp;
+
+	tmp =3D clk_get_rate(tpm->clk);
+	tmp *=3D period;
+	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (val < IMX_TPM_COUNT_MAX)
+		div =3D 0;
+	else
+		div =3D ilog2(roundup_pow_of_two(val / IMX_TPM_COUNT_MAX));
+	if (div > IMX_TPM_SC_PS_MASK) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return;
+	}
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + IMX_TPM_SC);
+	val &=3D ~IMX_TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + IMX_TPM_SC);
+
+	/* set period counter */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, 1 << div);
+	writel(period_cnt & IMX_TPM_MOD_MOD_MASK, tpm->base + IMX_TPM_MOD);
+}
+
+static void imx_tpm_pwm_config(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	static bool tpm_cnt_initialized;
+	unsigned int duty_cnt;
+	u32 val;
+	u64 tmp;
+
+	/*
+	 * TPM counter is shared by multi channels, let's make it to be
+	 * ONLY first channel can config TPM counter's precale and period
+	 * count.
+	 */
+	if (!tpm_cnt_initialized) {
+		imx_tpm_pwm_config_counter(chip, state->period);
+		tpm_cnt_initialized =3D true;
+	}
+
+	/* set duty counter */
+	tmp =3D readl(tpm->base + IMX_TPM_MOD) & IMX_TPM_MOD_MOD_MASK;
+	tmp *=3D state->duty_cycle;
+	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, state->period);
+	writel(duty_cnt & IMX_TPM_MOD_MOD_MASK,
+		 tpm->base + IMX_TPM_CnV(pwm->hwpwm));
+
+	/* set polarity */
+	val =3D readl(tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+	val &=3D ~(IMX_TPM_CnSC_ELSnB | IMX_TPM_CnSC_ELSnA | IMX_TPM_CnSC_MSnA);
+	val |=3D IMX_TPM_CnSC_MSnB;
+	val |=3D state->polarity ? IMX_TPM_CnSC_ELSnA : IMX_TPM_CnSC_ELSnB;
+	/*
+	 * polarity settings will enabled/disable output statue
+	 * immediately, so here ONLY save the config and will be
+	 * written into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] =3D val;
+}
+
+static void imx_tpm_pwm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val, i;
+
+	val =3D readl(tpm->base + IMX_TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+			tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+
+		/* start TPM counter anyway */
+		val |=3D 0x1 << IMX_TPM_SC_CMOD_SHIFT;
+		writel(val, tpm->base + IMX_TPM_SC);
+	} else {
+		/* save channel config */
+		tpm->chn_config[pwm->hwpwm] =3D readl(tpm->base +
+			IMX_TPM_CnSC(pwm->hwpwm));
+		/* disable channel */
+		writel(IMX_TPM_CnSC_CHF, tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+
+		for (i =3D 0; i < chip->npwm; i++)
+			if (i !=3D pwm->hwpwm && tpm->chn_status[i])
+				break;
+		if (i =3D=3D chip->npwm) {
+			/* stop TPM counter since all channels are disabled */
+			val &=3D ~IMX_TPM_SC_CMOD_MASK;
+			writel(val, tpm->base + IMX_TPM_SC);
+		}
+	}
+
+	/* update channel statue */
+	tpm->chn_status[pwm->hwpwm] =3D enable;
+}
+
+static void imx_tpm_pwm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	unsigned long rate, flags;
+	u64 tmp;
+	u32 val;
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	/* get period */
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D readl(tpm->base + IMX_TPM_MOD);
+	val =3D readl(tpm->base + IMX_TPM_SC);
+	val &=3D IMX_TPM_SC_PS_MASK;
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get duty cycle */
+	tmp =3D readl(tpm->base + IMX_TPM_CnV(pwm->hwpwm));
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val =3D readl(tpm->base + IMX_TPM_CnSC(pwm->hwpwm));
+	if (val & IMX_TPM_CnSC_ELSnA)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+}
+
+static int imx_tpm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
+			  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	unsigned long flags;
+
+	imx_tpm_pwm_get_state(chip, pwm, &curstate);
+
+	spin_lock_irqsave(&tpm->lock, flags);
+
+	if (state->period !=3D curstate.period ||
+	    state->duty_cycle !=3D curstate.duty_cycle ||
+	    state->polarity !=3D curstate.polarity)
+		imx_tpm_pwm_config(chip, pwm, state);
+
+	if (state->enabled !=3D curstate.enabled)
+		imx_tpm_pwm_enable(chip, pwm, state->enabled);
+
+	spin_unlock_irqrestore(&tpm->lock, flags);
+
+	return 0;
+}
+
+static const struct pwm_ops imx_tpm_pwm_ops =3D {
+	.get_state =3D imx_tpm_pwm_get_state,
+	.apply =3D imx_tpm_pwm_apply,
+	.owner =3D THIS_MODULE,
+};
+
+static int imx_tpm_pwm_probe(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm;
+	struct resource *res;
+	int ret;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tpm);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tpm->base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tpm->base)) {
+		ret =3D PTR_ERR(tpm->base);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "pwm ioremap failed %d\n", ret);
+		return ret;
+	}
+
+	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk)) {
+		ret =3D PTR_ERR(tpm->clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get pwm clk %d\n", ret);
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to prepare or enable clk %d\n", ret);
+		return ret;
+	}
+
+	tpm->chip.dev =3D &pdev->dev;
+	tpm->chip.ops =3D &imx_tpm_pwm_ops;
+	tpm->chip.base =3D -1;
+	tpm->chip.npwm =3D IMX_TPM_DEFAULT_PWM_CHANNEL_NUM;
+
+	spin_lock_init(&tpm->lock);
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+
+	return ret;
+}
+
+static int imx_tpm_pwm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused imx_tpm_pwm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused imx_tpm_pwm_resume(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret =3D clk_prepare_enable(tpm->clk);
+
+	if (ret)
+		dev_err(dev,
+			"failed to prepare or enable clk %d\n", ret);
+
+	return ret;
+};
+
+static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
+			 imx_tpm_pwm_suspend, imx_tpm_pwm_resume);
+
+static const struct of_device_id imx_tpm_pwm_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx-tpm-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_tpm_pwm_dt_ids);
+
+static struct platform_driver imx_tpm_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "imx-tpm-pwm",
+		.of_match_table =3D imx_tpm_pwm_dt_ids,
+		.pm =3D &imx_tpm_pwm_pm,
+	},
+	.probe	=3D imx_tpm_pwm_probe,
+	.remove =3D imx_tpm_pwm_remove,
+};
+module_platform_driver(imx_tpm_pwm_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

