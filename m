Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793452184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l8+tOrAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfCTFGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:06:32 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:50901
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfCTFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DDHntRJDc2Ly+1AjriBqLso46eQEyMXGCj90AH/Rxk=;
 b=l8+tOrAT/TF3w3eqr7uCNYe0MzgApxq/GGftyIekqaOZuuh2rkTpCWRVITIX6oBNwl1NGi8qH7/s1aIiHnTeby0C1QMcmwMHjah/sh0d1FUGpv/t4hRLtQq+LHCOy7c0f3hROpWWcIBnMtx4yusIRB1tYNlXYhVN+NZg1DguQSo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3945.eurprd04.prod.outlook.com (52.134.65.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 05:06:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 05:06:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V7 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU3tqo2boXezZoJUaa/A7s1tKOsg==
Date:   Wed, 20 Mar 2019 05:06:21 +0000
Message-ID: <1553058067-18793-3-git-send-email-Anson.Huang@nxp.com>
References: <1553058067-18793-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553058067-18793-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ebf134-23ea-4c91-dd86-08d6acf1caec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3945;
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-microsoft-antispam-prvs: <DB3PR0402MB39450E5EADB0557A4A3B1C4BF5410@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(105586002)(316002)(2906002)(76176011)(186003)(110136005)(53936002)(6486002)(7736002)(26005)(6506007)(8936002)(106356001)(486006)(86362001)(386003)(476003)(11346002)(102836004)(305945005)(6512007)(8676002)(4326008)(50226002)(81156014)(7416002)(446003)(81166006)(6436002)(36756003)(2201001)(68736007)(2501003)(25786009)(2616005)(5660300002)(30864003)(6116002)(97736004)(99286004)(71200400001)(66066001)(478600001)(256004)(14444005)(14454004)(71190400001)(3846002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3945;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7wfmUM/I8jqVGgJENdtNqHeaEwOmdOjD451rKyEVhOQDBckiuqIUYzdWOf+98gF7ffyt9A8hL+Pk87kE+S2wEbL41oeLvWCgK3AtOUewt3ieT9KzVGcu+H9mQarsIF1SeSIUqQzwr1OsPsDcqlL/x0DSZedXQ2d4nA6gWBtD75pQg734Bwl9H/xDJvFAVohfxgCNbas4LBARUN/7abKL+wqZM6mUabp0/4dUTR7LM5bTqvub/QD8kdJ9tklXleyv2CDCbJ4D7/cyJjQxBrzJ/RrDmqanSvmF0+Aj376x3D9XuKpzo95B+fw5WbZmY4Zf8nr1vor35BdLi5UVY41KClmzTizSFJ6k+jRLoYXHiNyfiIYB02Qobuq4tDyn56kFR9+xEBSbRyMFaJeTJGSbV/jPsTthMeNJPuXlKuGFODg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ebf134-23ea-4c91-dd86-08d6acf1caec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 05:06:21.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, it can support multiple PWM channels, all the channels
share same counter and period setting, but each channel can
configure its duty and polarity independently.

There are several TPM modules in i.MX7ULP, the number of channels
in TPM modules are different, it can be read from each TPM module's
PARAM register.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V6:
	- merge "config" and "enable" functions into ONE function pwm_imx_tpm_appl=
y_hw;
	- save computation for confiuring counter, the "round_state" function will=
 return
	  the registers value directly;
	- improve the logic in .apply;
	- return error when there is still PWM active during suspend callback.
---
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 428 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 440 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 54f8238..3ea0391 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -210,6 +210,17 @@ config PWM_IMX27
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx27.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
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
index 448825e..c368599 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
+obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
 obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
new file mode 100644
index 0000000..02403d0
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ *
+ * Limitations:
+ * - The TPM counter and period counter are shared between
+ *   multiple channels, so all channels should use same period
+ *   settings.
+ */
+
+#include <linux/bitfield.h>
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
+
+#define PWM_IMX_TPM_PARAM	0x4
+#define PWM_IMX_TPM_GLOBAL	0x8
+#define PWM_IMX_TPM_SC		0x10
+#define PWM_IMX_TPM_CNT		0x14
+#define PWM_IMX_TPM_MOD		0x18
+#define PWM_IMX_TPM_CnSC(n)	(0x20 + (n) * 0x8)
+#define PWM_IMX_TPM_CnV(n)	(0x24 + (n) * 0x8)
+
+#define PWM_IMX_TPM_PARAM_CHAN			GENMASK(7, 0)
+
+#define PWM_IMX_TPM_SC_PS			GENMASK(2, 0)
+#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
+#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
+#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
+
+#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
+#define PWM_IMX_TPM_CnSC_MSB	BIT(5)
+#define PWM_IMX_TPM_CnSC_MSA	BIT(4)
+
+/*
+ * The reference manual describes this field as two separate bits. The
+ * samantic of the two bits isn't orthogonal though, so they are treated
+ * together as a 2-bit field here.
+ */
+#define PWM_IMX_TPM_CnSC_ELS	GENMASK(3, 2)
+#define PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED	0x1
+
+#define PWM_IMX_TPM_MOD_MOD	GENMASK(15, 0)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock;
+	u32 user_count;
+	u32 enable_count;
+	u32 real_period;
+};
+
+struct imx_tpm_pwm_param {
+	u8 prescale;
+	u32 mod;
+};
+
+static inline struct imx_tpm_pwm_chip *to_imx_tpm_pwm_chip(struct pwm_chip=
 *chip)
+{
+	return container_of(chip, struct imx_tpm_pwm_chip, chip);
+}
+
+static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
+				   struct imx_tpm_pwm_param *p,
+				   struct pwm_state *state,
+				   struct pwm_state *real_state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 rate, prescale, period_count, clock_unit;
+	u64 tmp;
+
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D (u64)state->period * rate;
+	clock_unit =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (clock_unit <=3D PWM_IMX_TPM_MOD_MOD) {
+		prescale =3D 0;
+	} else {
+		prescale =3D roundup_pow_of_two(clock_unit);
+		prescale =3D ilog2(prescale) - 16;
+	}
+
+	if ((!FIELD_FIT(PWM_IMX_TPM_SC_PS, prescale)))
+		return -ERANGE;
+	p->prescale =3D prescale;
+
+	period_count =3D (clock_unit + ((1 << prescale) >> 1)) >> prescale;
+	if (period_count > PWM_IMX_TPM_MOD_MOD)
+		return -ERANGE;
+	p->mod =3D period_count;
+
+	/* calculate real period HW can support */
+	tmp =3D (u64)period_count << prescale;
+	tmp *=3D NSEC_PER_SEC;
+	real_state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/*
+	 * if eventually the PWM output is LOW, either
+	 * duty cycle is 0 or status is disabled, need
+	 * to make sure the output pin is LOW.
+	 */
+	if (!state->enabled)
+		real_state->duty_cycle =3D 0;
+	else
+		real_state->duty_cycle =3D state->duty_cycle;
+
+	real_state->polarity =3D state->polarity;
+	real_state->enabled =3D state->enabled;
+
+	return 0;
+}
+
+static void pwm_imx_tpm_config_counter(struct pwm_chip *chip,
+				       struct imx_tpm_pwm_param p)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val, saved_cmod;
+
+	/* make sure counter is disabled for programming prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	saved_cmod =3D FIELD_GET(PWM_IMX_TPM_SC_CMOD, val);
+	if (saved_cmod) {
+		val &=3D ~PWM_IMX_TPM_SC_CMOD;
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	}
+
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D ~PWM_IMX_TPM_SC_PS;
+	val |=3D FIELD_PREP(PWM_IMX_TPM_SC_PS, p.prescale);
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/*
+	 * set period count: according to RM, the MOD register is
+	 * updated immediately after CMOD[1:0] =3D 2b'00 above
+	 */
+	writel(p.mod, tpm->base + PWM_IMX_TPM_MOD);
+
+	/* restore the clock mode if necessary */
+	if (saved_cmod) {
+		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+		val |=3D FIELD_PREP(PWM_IMX_TPM_SC_CMOD, saved_cmod);
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	}
+}
+
+static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 rate, val;
+	u64 tmp;
+
+	/* get period */
+	state->period =3D tpm->real_period;
+
+	/* get duty cycle */
+	rate =3D clk_get_rate(tpm->clk);
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val =3D FIELD_GET(PWM_IMX_TPM_SC_PS, val);
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) =3D=3D
+	    PWM_IMX_TPM_CnSC_ELS_POLARITY_INVERSED)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		/*
+		 * Assume reserved values (2b00 and 2b11) to yield
+		 * normal polarity.
+		 */
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
+}
+
+static void pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 struct pwm_state state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state c;
+	u32 val, sc_val;
+	u64 tmp;
+
+	pwm_imx_tpm_get_state(chip, pwm, &c);
+
+	if (state.duty_cycle !=3D c.duty_cycle) {
+		/* set duty counter */
+		tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD;
+		tmp *=3D state.duty_cycle;
+		val =3D DIV_ROUND_CLOSEST_ULL(tmp, state.period);
+		writel(val, tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+	}
+
+	if (state.enabled !=3D c.enabled) {
+		/*
+		 * set polarity (for edge-aligned PWM modes)
+		 *
+		 * ELS[1:0] =3D 2b10 yields normal polarity behaviour,
+		 * ELS[1:0] =3D 2b01 yields inversed polarity.
+		 * The other values are reserved.
+		 *
+		 * polarity settings will enabled/disable output status
+		 * immediately, so if the channel is disabled, need to
+		 * make sure MSA/MSB/ELS are set to 0 which means channel
+		 * disabled.
+		 */
+		val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+		val &=3D ~(PWM_IMX_TPM_CnSC_ELS | PWM_IMX_TPM_CnSC_MSA |
+			 PWM_IMX_TPM_CnSC_MSB);
+		sc_val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+		if (state.enabled) {
+			val |=3D PWM_IMX_TPM_CnSC_MSB;
+			val |=3D (state.polarity =3D=3D PWM_POLARITY_NORMAL) ?
+				FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x2) :
+				FIELD_PREP(PWM_IMX_TPM_CnSC_ELS, 0x1);
+			if (++tpm->enable_count =3D=3D 1) {
+				/* start TPM counter */
+				sc_val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+				writel(sc_val, tpm->base + PWM_IMX_TPM_SC);
+			}
+		} else {
+			if (--tpm->enable_count =3D=3D 0) {
+				/* stop TPM counter */
+				sc_val &=3D ~PWM_IMX_TPM_SC_CMOD;
+				writel(sc_val, tpm->base + PWM_IMX_TPM_SC);
+			}
+		}
+		writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	}
+}
+
+static int pwm_imx_tpm_apply(struct pwm_chip *chip,
+			      struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct imx_tpm_pwm_param param;
+	struct pwm_state real_state;
+	int ret;
+
+	ret =3D pwm_imx_tpm_round_state(chip, &param, state, &real_state);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&tpm->lock);
+
+	/*
+	 * TPM counter is shared by multiple channels, so
+	 * prescale and period can NOT be modified when
+	 * there are multiple channels in use with different
+	 * period settings.
+	 */
+	if (real_state.period !=3D tpm->real_period) {
+		if (tpm->user_count > 1) {
+			ret =3D -EBUSY;
+			goto exit;
+		}
+
+		pwm_imx_tpm_config_counter(chip, param);
+		tpm->real_period =3D real_state.period;
+	}
+
+	pwm_imx_tpm_apply_hw(chip, pwm, real_state);
+
+exit:
+	mutex_unlock(&tpm->lock);
+
+	return ret;
+}
+
+static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+
+	mutex_lock(&tpm->lock);
+	tpm->user_count++;
+	mutex_unlock(&tpm->lock);
+
+	return 0;
+}
+
+static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *pwm=
)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+
+	mutex_lock(&tpm->lock);
+	tpm->user_count--;
+	mutex_unlock(&tpm->lock);
+}
+
+static const struct pwm_ops imx_tpm_pwm_ops =3D {
+	.request =3D pwm_imx_tpm_request,
+	.free =3D pwm_imx_tpm_free,
+	.get_state =3D pwm_imx_tpm_get_state,
+	.apply =3D pwm_imx_tpm_apply,
+	.owner =3D THIS_MODULE,
+};
+
+static int pwm_imx_tpm_probe(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm;
+	int ret;
+	u32 val;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tpm);
+
+	tpm->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tpm->base))
+		return PTR_ERR(tpm->base);
+
+	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk)) {
+		ret =3D PTR_ERR(tpm->clk);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to get PWM clock: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to prepare or enable clock: %d\n", ret);
+		return ret;
+	}
+
+	tpm->chip.dev =3D &pdev->dev;
+	tpm->chip.ops =3D &imx_tpm_pwm_ops;
+	tpm->chip.base =3D -1;
+	tpm->chip.of_xlate =3D of_pwm_xlate_with_flags;
+	tpm->chip.of_pwm_n_cells =3D 3;
+
+	/* get number of channels */
+	val =3D readl(tpm->base + PWM_IMX_TPM_PARAM);
+	tpm->chip.npwm =3D FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
+
+	mutex_init(&tpm->lock);
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(tpm->clk);
+	}
+
+	return ret;
+}
+
+static int pwm_imx_tpm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+	int ret =3D pwmchip_remove(&tpm->chip);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return ret;
+}
+
+static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	if (tpm->enable_count > 0)
+		return -EBUSY;
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret =3D 0;
+
+	if (tpm->enable_count =3D=3D 0) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret)
+			dev_err(dev,
+				"failed to prepare or enable clock: %d\n",
+				ret);
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_tpm_pwm_pm,
+			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
+
+static const struct of_device_id imx_tpm_pwm_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx-tpm", },
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
+	.probe	=3D pwm_imx_tpm_probe,
+	.remove =3D pwm_imx_tpm_remove,
+};
+module_platform_driver(imx_tpm_pwm_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

