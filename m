Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2F5C32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A419B20863
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XrhJoKJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgAAQbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:31:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34664 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgAAQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:31:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id c127so3488915wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P5gcp8jIwlMlhfhGOxLkJPAb88nDGX2ujZMaHgP9/W0=;
        b=XrhJoKJbQRExNFti0kMwDLAzp0S+NSzIhbKuIYC8w1mnxFJSKDcwAAiXfm4FBeCnIJ
         Qo2fBIDpJKTN0XtijveXmDroFU5Mi/iSBNGD23YDJX1mp3NBzPczmlEoMvFujf7MN7Js
         6NXZufugfGdxSRl7t/YyMMtDeVg34A0GYwD04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P5gcp8jIwlMlhfhGOxLkJPAb88nDGX2ujZMaHgP9/W0=;
        b=pWaZhT3m7HucSqjLbv3KKC7loj4bHXwNUzKdsSFtnRKkxGLb1TZx5GbfBNftkuI2dM
         93rpPt68Pios1i+lOK+V/N8hA2+FeV2EarY+Criow6yx9MqeIzwanHE/MdvFQ3DX9GIB
         2tYvTrN5V+tgYknAn5hSOV7cwhghkmng8TVjWucVeq53E9Bc+Pc3tqv9NnddKX5igEpX
         tqKOFiD8356H4oaHrUekDqmUJTrAB+D+apa5Fj1/kUfz/kOrOhSXhut1BZEsdrw9+cwb
         eDbtrJOri+WAYvibLaGaw/HdR0lXDbZzL3ZaTHT6YvXbDRm/VMu6FM2d13VBcXavHjKt
         ECZw==
X-Gm-Message-State: APjAAAWAvA5TU1jz0iV9wHRegufgL6pLr1sgVPHGk4WNV9/Ej5VoaxAk
        osiHMwd6wjqwANjnNe1UmXE5KQ==
X-Google-Smtp-Source: APXvYqzyCqNI+hQChtNv+8k7Qpq+1EPqbn+aZkknE+byT1tLYtzhPovzew9UfcDU8bZ9VYyM/i95AQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr10763156wmc.78.1577896299551;
        Wed, 01 Jan 2020 08:31:39 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id u13sm6108580wmd.36.2020.01.01.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 08:31:39 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH 1/3] soc: imx: gpcv2: add support for i.MX8MM SoC
Date:   Wed,  1 Jan 2020 17:31:34 +0100
Message-Id: <20200101163136.1586-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101163136.1586-1-michael@amarulasolutions.com>
References: <20200101163136.1586-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPCv2 on the Freescale i.MX8MM SoC works in the same way as the
GPCv2 on the i.MX8MQ, with a slight different mapping.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../bindings/power/fsl,imx-gpcv2.txt          |   4 +-
 drivers/soc/imx/gpcv2.c                       | 110 ++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
index 61649202f6f5..fde651cd06d0 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible: Should be one of:
 	- "fsl,imx7d-gpc"
 	- "fsl,imx8mq-gpc"
+	- "fsl,imx8mm-gpc"
 
 - reg: should be register base and length as documented in the
   datasheet
@@ -25,7 +26,8 @@ Required properties:
 
 - reg: Power domain index. Valid values are defined in
   include/dt-bindings/power/imx7-power.h for fsl,imx7d-gpc and
-  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc
+  include/dt-bindings/power/imx8m-power.h for fsl,imx8mq-gpc and
+  include/dt-bindings/power/imx8mm-power.h for fsl,imx8mm-gpc
 
 - #power-domain-cells: Should be 0
 
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b0dffb06c05d..d3c012a61c11 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
+#include <dt-bindings/power/imx8mm-power.h>
 
 #define GPC_LPCR_A_CORE_BSC			0x000
 
@@ -41,6 +42,20 @@
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MM_VPU_H1_A53_DOMAIN		BIT(15)
+#define IMX8MM_VPU_G2_A53_DOMAIN		BIT(14)
+#define IMX8MM_VPU_G1_A53_DOMAIN		BIT(13)
+#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_GPU_3D_A53_DOMAIN		BIT(11)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_2D_A53_DOMAIN		BIT(8)
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
+#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
+#define IMX8MM_PCIE1_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -64,6 +79,20 @@
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MM_VPU_H1_SW_Pxx_REQ		BIT(13)
+#define IMX8MN_VPU_G2_SW_Pxx_REQ		BIT(12)
+#define IMX8MN_VPU_G1_SW_Pxx_REQ		BIT(11)
+#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
+#define IMX8MM_GPU_3D_SW_Pxx_REQ		BIT(9)
+#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
+#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
+#define IMX8MM_GPU_2D_SW_Pxx_REQ		BIT(6)
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
+#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
+#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8MM_PCIE1_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -94,6 +123,20 @@
 #define IMX8M_PGC_MIPI_CSI2		28
 #define IMX8M_PGC_PCIE2			29
 
+#define IMX8MM_PGC_MIPI			16
+#define IMX8MM_PGC_PCIE1		17
+#define IMX8MM_PGC_OTG1			18
+#define IMX8MM_PGC_OTG2			19
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU_2D		22
+#define IMX8MM_PGC_GPUMIX		17
+#define IMX8MM_PGC_VPUMIX		18
+#define IMX8MM_PGC_GPU_3D		19
+#define IMX8MM_PGC_DSPMIX		20
+#define IMX8MM_PGC_VPU_G1		21
+#define IMX8MM_PGC_VPU_G2		22
+#define IMX8MM_PGC_VPU_H1		22
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -442,6 +485,72 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
+	[IMX8MM_POWER_DOMAIN_USB_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
+			.map = IMX8MM_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_USB_OTG2] = {
+		.genpd = {
+			.name = "usb-otg2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG2_SW_Pxx_REQ,
+			.map = IMX8MM_OTG2_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_OTG2,
+	},
+};
+
+static const struct regmap_range imx8mm_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_PU_PWRHSK),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_MIPI),
+				 GPC_PGC_SR(IMX8MM_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_PCIE1),
+				 GPC_PGC_SR(IMX8MM_PGC_PCIE1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DDR1),
+				 GPC_PGC_SR(IMX8MM_PGC_DDR1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU_2D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU_2D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_GPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_VPUMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU_3D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU_3D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DSPMIX),
+				 GPC_PGC_SR(IMX8MM_PGC_DSPMIX)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPU_G1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPU_G1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPU_G2),
+				 GPC_PGC_SR(IMX8MM_PGC_VPU_G2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPU_H1),
+				 GPC_PGC_SR(IMX8MM_PGC_VPU_H1)),
+};
+
+static const struct regmap_access_table imx8mm_access_table = {
+	.yes_ranges	= imx8mm_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(imx8mm_yes_ranges),
+};
+
+static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
+	.domains = imx8mm_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8mm_pgc_domains),
+	.reg_access_table = &imx8mm_access_table,
+};
+
 static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
 {
 	int i, ret;
@@ -641,6 +750,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ }
 };
 
-- 
2.17.1

