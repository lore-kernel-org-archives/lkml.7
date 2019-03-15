Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CDA21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 00:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FktGjn+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfCOArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 20:47:01 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:27465
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfCOArA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 20:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT6h7tHYD8fBFnnYDf6pkpu04pOkM0uc982e8rAbEz0=;
 b=FktGjn+CPxHLYTeGqpUAvgrputztvadgHoqSZksR6ps5fmQU6F2Fr6oXPfeJy+st6ftW8kqX5kgkk18RnUxb9jzzflxmcTfrhj+/mEl32JUH7UmSWnaFlG/q0Xv7xYFLHrxu+Wxj70CnbhCMfl/0Aj4WBD7xcsonNOrGIIFAJ6Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Fri, 15 Mar 2019 00:46:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 00:46:51 +0000
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
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH V4 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU2siU0bWGOMWkiUi6PBGed50RsA==
Date:   Fri, 15 Mar 2019 00:46:51 +0000
Message-ID: <1552610505-13568-3-git-send-email-Anson.Huang@nxp.com>
References: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552610505-13568-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46be7dfa-4619-4a69-47f3-08d6a8dfb66f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3772;23:9pDnh1RCDkueAWgiFRq0Q6/ko5zzCld3HLzWx?=
 =?iso-8859-1?Q?DnbSj8amDV7T01kFF7wbQkNsFfoU5eSnpKqf+aJxOPfKRhCMsckxQNyePk?=
 =?iso-8859-1?Q?+d4nbNFQ+hymrRy1fmP+A7f+T5V7gdMoKuzaRJY6fA8WURmF1xcMS1a0z4?=
 =?iso-8859-1?Q?nk5Pjpt8qnvuMa21wlfDaP6dZ0SjKHmzUricLIZZswiEHvgYLP2pEnfNs6?=
 =?iso-8859-1?Q?W042IXya0o36kvlxc4v/YnqKJ3JivDXSNna3r20uclS31K02lP4vUFW3Vg?=
 =?iso-8859-1?Q?wZtg7FjHvHpjmxGqJsT6FhGTGQLRxIzH+CuOiojSj50eGNohFG/eer6n0t?=
 =?iso-8859-1?Q?k1zZpqGJW6RJUZw+pq8rxXEHNoya+BQeF8jlsk+MP2biolmFVpCd/Ft+DL?=
 =?iso-8859-1?Q?vQGcSc+JIE8eCn30DVSSkglfn0OJCpiQBelenw17bH+KQWVJCc7/Ka36g3?=
 =?iso-8859-1?Q?TFZyvsiFosRqWxuJJnjZrzV8ZEmw4jwZL4GoNLpvkg0zXSFINflQpCSz/b?=
 =?iso-8859-1?Q?dmTci4vaCIBB/NtuzyoCI6BBBTvNNTDT2EvPl2fhyPIqEBIllMA7v8ROPc?=
 =?iso-8859-1?Q?azdMutJB1vdJDm4AoOJEVeRaEzTM8rVk09J3pP1BsXExjg5Y1uIyHtPID+?=
 =?iso-8859-1?Q?/RgoyoN2bSyFszCQIIrM5hioEJNeiytaOVB5X2j4HA1wUIwntdnm0tNwd+?=
 =?iso-8859-1?Q?4gE8H5lcaoCWgMBXR0mZ1pHWMdbMSErJRIfy7/651eJQFyoIQAXTyfSoJ8?=
 =?iso-8859-1?Q?Tcw1aZ3zV6XAa+zEqnwH3mGFUsXXgFAYiS/9mrdfHUk86evi6audC8o58l?=
 =?iso-8859-1?Q?0yoZqiaqJCKJozo2hPvPZrOVsHhH0CnpVqln/sH7Crt0SQ/FZIg/H4wjEG?=
 =?iso-8859-1?Q?VzghDgKusNLD8oj4b/mwD1hLCb9GVDex6gUD2KYEfDxk4HLI3v7y9unsPr?=
 =?iso-8859-1?Q?zC2uywQAIp/9qIf0SJ8H5kU+0s7vYlumvMz2TCGofAJTi7d1UNMj7QG/Mb?=
 =?iso-8859-1?Q?5nzZqjObv9E662KHahcF7wcf9RJdgxqVSVsw83NL8FPt63/iPTyUqhrbCb?=
 =?iso-8859-1?Q?mZusnuYzF9DvkJjJKcQW6hvk2Pv4iA2mBY5c97FB0NLz5JVIeguZO061si?=
 =?iso-8859-1?Q?nbA9dgVqbEyBYApJHIVmbw76uDkOHdCo+Gr+2k2K1wiV+rZWy0A/nHFHgs?=
 =?iso-8859-1?Q?aURY2x5XpxSw19kkwFqTssSUTO16+Dihw06sApIwPR1QY1TbEcH7aYLtno?=
 =?iso-8859-1?Q?okxEORTRGMaYOZHrIZq1bgk72pTe83f3EK2yLJgyLPTwfo/kkAYkBEA1xf?=
 =?iso-8859-1?Q?2BZIVI/Zo8K58D3CiHqN3hWDmjMDJSaUJDitt0gg5IcZb+CIckAzGeFzUb?=
 =?iso-8859-1?Q?ZNhRcPSJNU=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3772DF60788A4FA5DB574622F5440@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(2616005)(7416002)(66066001)(14444005)(97736004)(186003)(6512007)(11346002)(446003)(2501003)(53936002)(76176011)(7736002)(2906002)(476003)(6346003)(305945005)(106356001)(68736007)(102836004)(81166006)(8676002)(81156014)(386003)(6506007)(105586002)(52116002)(50226002)(30864003)(316002)(6486002)(110136005)(486006)(36756003)(3846002)(5660300002)(478600001)(6436002)(6116002)(256004)(8936002)(4326008)(25786009)(14454004)(99286004)(71190400001)(86362001)(71200400001)(26005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1R3CUhmONvz7XfR9DizlMhJxxsXJugtk+mCuhResf3SR4ttd936BbShV7DyfhoSpMuvfol+Mj4zF1PtwP3ishJnlaP+VdmbkClM9rUijv9RaH8AD8SukX0GwzDeUfx33aXR5E/96PT0BDoTG3WddYjwyvJ7qtpQtKkowcmC94hTN2N0dBfnZvrri0GDxHjuTBw+2R4/HpOqiba+7WmkF5pFB5Mfgf9Sf0Wi+AVhSCl6SFfYkYI1I7UJaMyfvwsPSZazb+Y9MSew8SpoFKva19H0OIoEGn5v1Ejs1I5Hx79XqJhPNrIBKQwp7rinTeeuGpHg3N177gFeAYUemECLdFrNXofwECGlD1QtYbtJMoCVflIMv7trUMANW/8vzh57psfMeRC6QBJGapGParJqTY07MU8c5f35KebCyUAVEJh4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46be7dfa-4619-4a69-47f3-08d6a8dfb66f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 00:46:51.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- use "PWM_IMX_" as macro definition prefix and "pwm_imx_" as function pre=
fix;
	- improve the limitation txt;
	- return error for configuring period/prescale fail;
	- disable clock when driver probe failed and remove;
	- improve module build dependency;
	- introduce user_count to determine whether configuing period is allowed;
	- some logic improvement for setting duty/status etc.;
---
 drivers/pwm/Kconfig       |  12 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 396 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 409 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..6117fe6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,18 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+
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
index 0000000..f108f75
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,396 @@
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
+#define PWM_IMX_TPM_GLOBAL	0x8
+#define PWM_IMX_TPM_SC		0x10
+#define PWM_IMX_TPM_CNT		0x14
+#define PWM_IMX_TPM_MOD		0x18
+#define PWM_IMX_TPM_C0SC	0x20
+#define PWM_IMX_TPM_C0V		0x24
+
+#define PWM_IMX_TPM_SC_CMOD			GENMASK(4, 3)
+#define PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK	BIT(3)
+#define PWM_IMX_TPM_SC_CPWMS			BIT(5)
+
+#define PWM_IMX_TPM_CnSC_CHF	BIT(7)
+#define PWM_IMX_TPM_CnSC_MSnB	BIT(5)
+#define PWM_IMX_TPM_CnSC_MSnA	BIT(4)
+#define PWM_IMX_TPM_CnSC_ELSnB	BIT(3)
+#define PWM_IMX_TPM_CnSC_ELSnA	BIT(2)
+
+#define PWM_IMX_TPM_SC_PS_MASK		0x7
+#define PWM_IMX_TPM_MOD_MOD_MASK	0xffff
+
+#define PWM_IMX_TPM_MAX_COUNT		0xffff
+
+#define PWM_IMX_TPM_MAX_CHANNEL_NUM	6
+
+#define PWM_IMX_TPM_CnSC(n)	(PWM_IMX_TPM_C0SC + n * 0x8)
+#define PWM_IMX_TPM_CnV(n)	(PWM_IMX_TPM_C0V + n * 0x8)
+
+struct imx_tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock;
+	u32 user_count;
+	u32 chn_config[PWM_IMX_TPM_MAX_CHANNEL_NUM];
+	bool chn_status[PWM_IMX_TPM_MAX_CHANNEL_NUM];
+};
+
+#define to_imx_tpm_pwm_chip(_chip)	\
+		container_of(_chip, struct imx_tpm_pwm_chip, chip)
+
+static int pwm_imx_tpm_config_counter(struct pwm_chip *chip, u32 period)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 period_cnt, val, div, saved_cmod;
+	u64 tmp;
+
+	tmp =3D clk_get_rate(tpm->clk);
+	tmp *=3D period;
+	val =3D DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
+	if (val < PWM_IMX_TPM_MAX_COUNT)
+		div =3D 0;
+	else
+		div =3D ilog2(roundup_pow_of_two(val /
+			(PWM_IMX_TPM_MAX_COUNT + 1)));
+	if (div > PWM_IMX_TPM_SC_PS_MASK) {
+		dev_err(chip->dev,
+			"failed to find valid prescale value!\n");
+		return -EINVAL;
+	}
+
+	/* make sure counter is disabled for programming prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	saved_cmod =3D val & PWM_IMX_TPM_SC_CMOD;
+	val &=3D ~PWM_IMX_TPM_SC_CMOD;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/* set TPM counter prescale */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D ~PWM_IMX_TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	/*
+	 * set period counter: according to RM, the MOD register is
+	 * updated immediately when CMOD[1:0] =3D 2b'00 (counter disabled).
+	 */
+	do_div(tmp, NSEC_PER_SEC);
+	period_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, 1 << div)
+			& PWM_IMX_TPM_MOD_MOD_MASK;
+	writel(period_cnt, tpm->base + PWM_IMX_TPM_MOD);
+
+	/* restore the clock mode */
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val |=3D saved_cmod;
+	writel(val, tpm->base + PWM_IMX_TPM_SC);
+
+	return 0;
+}
+
+static void pwm_imx_tpm_config(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       u32 period,
+			       u32 duty_cycle,
+			       enum pwm_polarity polarity)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 duty_cnt, val;
+	u64 tmp;
+
+	/* set duty counter */
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD) & PWM_IMX_TPM_MOD_MOD_MASK;
+	tmp *=3D duty_cycle;
+	duty_cnt =3D DIV_ROUND_CLOSEST_ULL(tmp, period);
+	writel(duty_cnt & PWM_IMX_TPM_MOD_MOD_MASK,
+		 tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+
+	/* set polarity */
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	val &=3D ~(PWM_IMX_TPM_CnSC_ELSnB | PWM_IMX_TPM_CnSC_ELSnA |
+		 PWM_IMX_TPM_CnSC_MSnA);
+	val |=3D PWM_IMX_TPM_CnSC_MSnB;
+	val |=3D polarity ? PWM_IMX_TPM_CnSC_ELSnA : PWM_IMX_TPM_CnSC_ELSnB;
+	/*
+	 * polarity settings will enabled/disable output statue
+	 * immediately, so here ONLY save the config and will be
+	 * written into register when channel is enabled/disabled.
+	 */
+	tpm->chn_config[pwm->hwpwm] =3D val;
+}
+
+static void pwm_imx_tpm_enable(struct pwm_chip *chip,
+			       struct pwm_device *pwm,
+			       bool enable)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u32 val, i;
+
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	if (enable) {
+		/* restore channel config */
+		writel(tpm->chn_config[pwm->hwpwm],
+			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		/* start TPM counter anyway */
+		val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+		writel(val, tpm->base + PWM_IMX_TPM_SC);
+	} else {
+		/*
+		 * When a channel is disabled, its polarity settings will be
+		 * saved and its output will be disabled by clearing polarity
+		 * setting, when channel is enabled, polarity settings will be
+		 * restored and output will be enabled again.
+		 */
+		/* save channel config */
+		tpm->chn_config[pwm->hwpwm] =3D readl(tpm->base +
+			PWM_IMX_TPM_CnSC(pwm->hwpwm));
+		/* disable channel */
+		writel(PWM_IMX_TPM_CnSC_CHF,
+			tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+
+		for (i =3D 0; i < chip->npwm; i++)
+			if (i !=3D pwm->hwpwm && tpm->chn_status[i])
+				break;
+		if (i =3D=3D chip->npwm) {
+			/* stop TPM counter since all channels are disabled */
+			val &=3D ~PWM_IMX_TPM_SC_CMOD;
+			writel(val, tpm->base + PWM_IMX_TPM_SC);
+		}
+	}
+
+	/* update channel statue */
+	tpm->chn_status[pwm->hwpwm] =3D enable;
+}
+
+static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	u64 tmp;
+	u32 val, rate;
+
+	mutex_lock(&tpm->lock);
+
+	/* get period */
+	rate =3D clk_get_rate(tpm->clk);
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_MOD);
+	val =3D readl(tpm->base + PWM_IMX_TPM_SC);
+	val &=3D PWM_IMX_TPM_SC_PS_MASK;
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get duty cycle */
+	tmp =3D readl(tpm->base + PWM_IMX_TPM_CnV(pwm->hwpwm));
+	tmp *=3D (1 << val) * NSEC_PER_SEC;
+	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, rate);
+
+	/* get polarity */
+	val =3D readl(tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
+	if (val & PWM_IMX_TPM_CnSC_ELSnA)
+		state->polarity =3D PWM_POLARITY_INVERSED;
+	else
+		state->polarity =3D PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	state->enabled =3D tpm->chn_status[pwm->hwpwm] ? true : false;
+
+	mutex_unlock(&tpm->lock);
+}
+
+static int pwm_imx_tpm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
+			     struct pwm_state *state)
+{
+	struct imx_tpm_pwm_chip *tpm =3D to_imx_tpm_pwm_chip(chip);
+	struct pwm_state curstate;
+	u32 duty_cycle =3D state->duty_cycle;
+	int ret;
+
+	pwm_imx_tpm_get_state(chip, pwm, &curstate);
+
+	mutex_lock(&tpm->lock);
+
+	if (state->period !=3D curstate.period) {
+		/*
+		 * TPM counter is shared by multiple channels, so
+		 * the prescale and period can NOT be modified when
+		 * there are multiple channels used.
+		 */
+		if (tpm->user_count !=3D 1)
+			return -EBUSY;
+		ret =3D pwm_imx_tpm_config_counter(chip, state->period);
+		if (ret)
+			return ret;
+	}
+
+	if (!state->enabled)
+		duty_cycle =3D 0;
+
+	if (state->duty_cycle !=3D curstate.duty_cycle ||
+	    state->polarity !=3D curstate.polarity)
+		pwm_imx_tpm_config(chip, pwm,
+			state->period, duty_cycle, state->polarity);
+
+	if (state->enabled !=3D curstate.enabled)
+		pwm_imx_tpm_enable(chip, pwm, state->enabled);
+
+	mutex_unlock(&tpm->lock);
+
+	return 0;
+}
+
+static int pwm_imx_tpm_request(struct pwm_chip *chip, struct pwm_device *d=
ev)
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
+static void pwm_imx_tpm_free(struct pwm_chip *chip, struct pwm_device *dev=
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
+	.get_state =3D pwm_imx_tpm_get_state,
+	.request =3D pwm_imx_tpm_request,
+	.apply =3D pwm_imx_tpm_apply,
+	.free =3D pwm_imx_tpm_free,
+	.owner =3D THIS_MODULE,
+};
+
+static int pwm_imx_tpm_probe(struct platform_device *pdev)
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
+	tpm->chip.npwm =3D PWM_IMX_TPM_MAX_CHANNEL_NUM;
+
+	mutex_init(&tpm->lock);
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		clk_disable_unprepare(tpm->clk);
+	}
+
+	return ret;
+}
+
+static int pwm_imx_tpm_remove(struct platform_device *pdev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
+{
+	struct imx_tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
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
+			 pwm_imx_tpm_suspend, pwm_imx_tpm_resume);
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

