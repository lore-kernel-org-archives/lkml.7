Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A52075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lsusO9D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCKHRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:17:04 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:53313
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbfCKHRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bpd/fL98pP+NX3PZGyCDkkSYEBL3ecIr3PSVBzOCc4=;
 b=lsusO9D0a4A4gDiHCvH+8M3phzVAcH76HeUdo7TgM330aCcZ+r0zc7X8xuatORHBUhCk7ZJBrujh8AfXkOf1DFDvbd2G/WXtEsMxo+CelmVOg6mgLXOA+ha9ihuIsLIWu2mXeg5jBToV2TDi27egExwtyruKD6c7Us31vPupRR0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 07:16:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 07:16:53 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Topic: [PATCH 2/5] pwm: Add i.MX TPM PWM driver support
Thread-Index: AQHU19pRLIP7E/b7ake3rSFDebhjpw==
Date:   Mon, 11 Mar 2019 07:16:16 +0000
Message-ID: <1552288273-31028-3-git-send-email-Anson.Huang@nxp.com>
References: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552288273-31028-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b9ddab-bd09-450e-839f-08d6a5f17374
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3724;23:HVQzNF0uTmuGp2sBA6dO6Hz8wgQWRCydjVhv6?=
 =?iso-8859-1?Q?Y91psyWAzfuau/on7T6I/TxHsIQFc6R0RESXNoKGMaoqLSXr0bzX84gDOw?=
 =?iso-8859-1?Q?ZZfHDM0Df8WIBQrJH0GdTa467Nx9CQsXiJthOtJ3e68LlDI3m3pRG75+1V?=
 =?iso-8859-1?Q?kGM2/Ay9ahxlbT+wDwXyyEwJR8W3xodNHOwJJU30A9aG2c6rWTxSleW6w0?=
 =?iso-8859-1?Q?dxLvGI+SPcfKEpE1tMy0Q5i7thzpjmSqTtujvxeNqHNhfC44LzQbUPjZoA?=
 =?iso-8859-1?Q?k5Ohq+YdGnm7IBP8ZF3xAbzYjIL1ifwcnx4qPkp+aRcoPQRCyF3A2WxoU2?=
 =?iso-8859-1?Q?1x8Inf8F/WbztQF1cFY8ruOrwyF6N3yETA4zLtQK9E2PjXao+Hv8wA7nS5?=
 =?iso-8859-1?Q?CA223zxcweRWIzCX6jEXRgc5jVUf0fRXeouDTeLBAkSFjTQv58QNDm/HS8?=
 =?iso-8859-1?Q?j7jmT8cxPsZQLBc796AFh2xq5PWPOwbDYWpX2CuKbCZUPKgBGz1/QMH75l?=
 =?iso-8859-1?Q?sEIcsqWiyY6gFZ8ig1ZrjwTTGhE9egeb/2Vy9VrSE/psw4ZkHTmjCW48PT?=
 =?iso-8859-1?Q?IZLALleUi0o7cxQ8zzBflaS7se/a08MyJTgxe3vXVWUIKso+vq4J9oPlu4?=
 =?iso-8859-1?Q?lLccqyWDUga96pqYRQcXaW2cegTocOdQETEdbWX1fd3anYRnnIFfz0uKWy?=
 =?iso-8859-1?Q?jN9M5MO+Nif2svzJx/YM3heX6zx6lpAhQmpJysp7uFFruliFxFDoSQ57JX?=
 =?iso-8859-1?Q?3vdzF9e/JWdz88pru+BmrqCwKhR+ntK8zYXY38BawjSSLHHzHBpAvL6dsM?=
 =?iso-8859-1?Q?caoolMFwD0NnQqcPw8zIqBSMBS76wekIKzCtnRGsea4POVn1R0jeIh5KPP?=
 =?iso-8859-1?Q?JDEFw5DHLVoRWAS+au2CtAB2YfNuWXl1sIts598yOj8Pt/Y/uAGt/+5X6p?=
 =?iso-8859-1?Q?cFTZdMpsTFLbpxWGU1D5sNRCZx3nq7VvTa/0uUKSpv2iW5kZ2hmc7A1Xw+?=
 =?iso-8859-1?Q?DLKEoJiJPzhI/TpbIJNFd4bw7/ii5D3oAD5Glv/EmgoOYMgwF2oLTqc1xU?=
 =?iso-8859-1?Q?YXFuIl0JERQeKiEOqhg1YzYlT9q/Th6jCHfV2PYJtZQMwosMGblxar5ENF?=
 =?iso-8859-1?Q?b7yIrRga0xq2hFL4eGA+mhHZYsORa05mhCfPwcQIuK+3nFvtHJWaXrrtVH?=
 =?iso-8859-1?Q?O09TCm2tG5JDHX1qRCetmZAhaG1B0+2u+UMQZ+yF/8qMpYXq2ZW99COGXB?=
 =?iso-8859-1?Q?8dCSf26dxkLmMdWAboJbcSzOFNt3aMErhpB73LTfnL8i+JWf7NuuPm1XGl?=
 =?iso-8859-1?Q?mKrvzeGu/9Y0Wkv6MwsuYhB1fH1j3ny/4BqXMYWs4jhcEtw=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3724669954A1D24DF013124EF5480@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(105586002)(6512007)(6486002)(2501003)(6436002)(97736004)(446003)(110136005)(2616005)(81166006)(81156014)(8676002)(11346002)(106356001)(478600001)(6116002)(3846002)(4326008)(25786009)(486006)(476003)(2906002)(305945005)(316002)(7736002)(102836004)(7416002)(14454004)(52116002)(256004)(6666004)(8936002)(66066001)(186003)(6506007)(386003)(71200400001)(99286004)(5660300002)(71190400001)(86362001)(76176011)(14444005)(26005)(53936002)(68736007)(50226002)(36756003)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9kdperg0u+TdwPmLAN+SY4rQiNz4Q+AgGdn1BAXSxr8/NNp3Tfx93pfKw/kNm5gsG0m3l7gE3yARnTU0owBVgBTA4N1n6ihBYgSJugoaRQrnhR0i9Xa+A6y1RoerX/T4F0cNaryQ71fSYvuJb+tYYRHH0qfmb3PxYoLLuPGpENHlZx8ECDYdyoA8fE7LxYdGIkoTAS9OFTs0936UF9h0nr7+yeiS/qCvT5iMNZRKtSEvyiV8NE+B2NeyRRYReGWA/oFht7eywn4AZvX8z234KoMbwcCCIQYhfBKghDCLufd58GNr5OUQpoaqGDW3X/8eB7vKFJANwZqf4uFFz7+MnvDDuoyxCFzmnZZmNeKsiiin5LXSKFHKOBXeW8NLsa1BSt9kYORcbnBAmq/cp7D8vapyAYkbPT0xmAsESWJgktA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b9ddab-bd09-450e-839f-08d6a5f17374
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 07:16:16.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has TPM(Low Power Timer/Pulse Width Modulation Module)
inside, add TPM PWM driver support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/Kconfig       |   9 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-imx-tpm.c | 277 ++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/pwm/pwm-imx-tpm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..23839ad 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -201,6 +201,15 @@ config PWM_IMX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx.
=20
+config PWM_IMX_TPM
+	tristate "i.MX TPM PWM support"
+	depends on ARCH_MXC
+	help
+	  Generic PWM framework driver for i.MX TPM.
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
index 0000000..a53256a
--- /dev/null
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018-2019 NXP.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define TPM_GLOBAL	0x8
+#define TPM_SC		0x10
+#define TPM_CNT		0x14
+#define TPM_MOD		0x18
+#define TPM_C0SC	0x20
+#define TPM_C0V		0x24
+
+#define SC_CMOD		3
+#define SC_CPWMS	BIT(5)
+#define MSnB		BIT(5)
+#define MSnA		BIT(4)
+#define ELSnB		BIT(3)
+#define ELSnA		BIT(2)
+
+#define TPM_SC_PS_MASK		0x7
+#define TPM_MOD_MOD_MASK	0xffff
+
+#define PERIOD_PERIOD_MAX	0x10000
+#define PERIOD_DIV_MAX		8
+
+#define TPM_CHn_ADDR_OFFSET	0x8
+#define DEFAULT_PWM_CHANNEL_NUM	2
+
+struct tpm_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static const unsigned int prediv[8] =3D {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+#define to_tpm_pwm_chip(_chip)	container_of(_chip, struct tpm_pwm_chip, ch=
ip)
+
+static int tpm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	unsigned int period_cycles, duty_cycles;
+	unsigned long rate;
+	u32 val, div =3D 0;
+	u64 c;
+	int ret;
+
+	rate =3D clk_get_rate(tpm->clk);
+	/* calculate the period_cycles and duty_cycles */
+	while (1) {
+		c =3D rate / prediv[div];
+		c =3D c * period_ns;
+		do_div(c, 1000000000);
+		if (c < PERIOD_PERIOD_MAX)
+			break;
+		div++;
+		if (div >=3D 8)
+			return -EINVAL;
+	}
+
+	/* enable the clock before writing the register */
+	if (!pwm_is_enabled(pwm)) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret) {
+			dev_err(chip->dev,
+				"failed to prepare or enable clk %d\n", ret);
+			return ret;
+		}
+	}
+
+	val =3D readl(tpm->base + TPM_SC);
+	val &=3D ~TPM_SC_PS_MASK;
+	val |=3D div;
+	writel(val, tpm->base + TPM_SC);
+
+	period_cycles =3D c;
+	c *=3D duty_ns;
+	do_div(c, period_ns);
+	duty_cycles =3D c;
+
+	writel(period_cycles & TPM_MOD_MOD_MASK, tpm->base + TPM_MOD);
+	writel(duty_cycles & TPM_MOD_MOD_MASK, tpm->base +
+	       TPM_C0V + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* if pwm is not enabled, disable clk after setting */
+	if (!pwm_is_enabled(pwm))
+		clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int tpm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	int ret;
+	u32 val;
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(chip->dev,
+			"failed to prepare or enable clk %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * To enable a tpm channel, CPWMS =3D 0, MSnB:MSnA =3D 0x0,
+	 * for TPM normal polarity ELSnB:ELSnA =3D 2b'10,
+	 * inverse ELSnB:ELSnA =3D 2b'01
+	 */
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	val &=3D ~(MSnB | MSnA | ELSnB | ELSnA);
+	val |=3D MSnB;
+	val |=3D pwm->state.polarity ? ELSnA : ELSnB;
+
+	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* start the counter */
+	val =3D readl(tpm->base + TPM_SC);
+	val |=3D 0x1 << SC_CMOD;
+	writel(val, tpm->base + TPM_SC);
+
+	return 0;
+}
+
+static void tpm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+
+	clk_disable_unprepare(tpm->clk);
+}
+
+static int tpm_pwm_set_polarity(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	struct tpm_pwm_chip *tpm =3D to_tpm_pwm_chip(chip);
+	int ret;
+	u32 val;
+
+	/* enable the clock before writing the register */
+	if (!pwm_is_enabled(pwm)) {
+		ret =3D clk_prepare_enable(tpm->clk);
+		if (ret) {
+			dev_err(chip->dev,
+				"failed to prepare or enable clk %d\n", ret);
+			return ret;
+		}
+	}
+
+	val =3D readl(tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+	val &=3D ~(ELSnB | ELSnA);
+	val |=3D pwm->state.polarity ? ELSnA : ELSnB;
+	writel(val, tpm->base + TPM_C0SC + pwm->hwpwm * TPM_CHn_ADDR_OFFSET);
+
+	/* disable the clock after writing the register */
+	if (!pwm_is_enabled(pwm))
+		clk_disable_unprepare(tpm->clk);
+
+	return  0;
+}
+
+static const struct pwm_ops tpm_pwm_ops =3D {
+	.config		=3D tpm_pwm_config,
+	.enable		=3D tpm_pwm_enable,
+	.disable	=3D tpm_pwm_disable,
+	.set_polarity	=3D tpm_pwm_set_polarity,
+	.owner		=3D THIS_MODULE,
+};
+
+static int tpm_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct tpm_pwm_chip *tpm;
+	struct resource *res;
+	int ret;
+
+	tpm =3D devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
+	if (!tpm)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tpm->base =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tpm->base))
+		return PTR_ERR(tpm->base);
+
+	tpm->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpm->clk))
+		return PTR_ERR(tpm->clk);
+
+	tpm->chip.dev =3D &pdev->dev;
+	tpm->chip.ops =3D &tpm_pwm_ops;
+	tpm->chip.base =3D -1;
+	tpm->chip.npwm =3D DEFAULT_PWM_CHANNEL_NUM;
+
+	/* init pwm channel number if "fsl,pwm-number" is found in DT */
+	ret =3D of_property_read_u32(np, "fsl,pwm-number", &tpm->chip.npwm);
+	if (ret)
+		dev_warn(&pdev->dev, "two pwm channels by default\n");
+
+	ret =3D pwmchip_add(&tpm->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, tpm);
+
+	return 0;
+}
+
+static int tpm_pwm_remove(struct platform_device *pdev)
+{
+	struct tpm_pwm_chip *tpm =3D platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&tpm->chip);
+}
+
+static int __maybe_unused tpm_pwm_suspend(struct device *dev)
+{
+	struct tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(tpm->clk);
+
+	return 0;
+}
+
+static int __maybe_unused tpm_pwm_resume(struct device *dev)
+{
+	struct tpm_pwm_chip *tpm =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(tpm->clk);
+	if (ret) {
+		dev_err(dev, "could not prepare or enable tpm clock\n");
+		return ret;
+	}
+
+	return 0;
+};
+
+static SIMPLE_DEV_PM_OPS(tpm_pwm_pm,
+		 tpm_pwm_suspend, tpm_pwm_resume);
+
+static const struct of_device_id tpm_pwm_dt_ids[] =3D {
+	{ .compatible =3D "fsl,imx-tpm-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tpm_pwm_dt_ids);
+
+static struct platform_driver tpm_pwm_driver =3D {
+	.driver =3D {
+		.name =3D "tpm-pwm",
+		.of_match_table =3D tpm_pwm_dt_ids,
+		.pm =3D &tpm_pwm_pm,
+	},
+	.probe	=3D tpm_pwm_probe,
+	.remove =3D tpm_pwm_remove,
+};
+module_platform_driver(tpm_pwm_driver);
+
+MODULE_AUTHOR("Jacky Bai <ping.bai@nxp.com>");
+MODULE_DESCRIPTION("i.MX TPM PWM Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4

