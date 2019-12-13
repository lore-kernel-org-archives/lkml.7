Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6317C751E5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DA5247DA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec532aII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfLMQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:06:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42024 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbfLMQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:58 -0500
Received: by mail-yb1-f196.google.com with SMTP id z10so517791ybr.9;
        Fri, 13 Dec 2019 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJRp0zVXenPTDOj2+N1sqi3Za0T7/7Gs5s6eak/8py8=;
        b=Ec532aIIrIGX9CHDUvl5IcrdHxCiDLwypD1lwJOHQfnudfJNrVQhm0VRqk33uIvbUZ
         IfsDx4LaPg2I8o8xyio8/I+WFUFvWbRf2JqCRfTPCd5qrCsdIBwyM/fynfzhquFv4ztG
         AiOALw0zBX/LQKYOWPWbLYUCnMZN+IXEKBJxshnWsq3zbM7egHdRk8NdWX8zpLkDrWe6
         ThP28r9wNqZ+jTkM2YAH/lNrALzSIi9vJr4DT+1yNyOuITm2tMrVU0x3ClgM5/vF/22F
         ipgAkD4Dw9pijlv75bKIY8j6SGkn1LKHz497g7xNOLnRxKC4M+lY5FSSWP+Cn+seGAif
         fA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJRp0zVXenPTDOj2+N1sqi3Za0T7/7Gs5s6eak/8py8=;
        b=ulE/NWByPlJ+8xDZiL5rNgrhyeT3npojMgAzrAdeKWGwGu0yFhy+5CyGlPhtKa3jNa
         RCc3YQhRLBwbshjjEaDrrHpkaJquAkarIzWSJsL8ah565/h3chfKVl8Rj+89BZc0GUgJ
         YtkZPTftkZhd+tgJcmzukY/MX93kM852avEhYcfanJVzMb8wjn0VxAYwgLSX29qXUVk5
         gPd53ybuRvtQwRNn8fVJYKFJ7g2Ecr/OEoQ1vAzcgtt+RrEU8HMiappPceF2Y6j3z4ow
         x3Mjdw2r/oejRc421hjJkO2MSJXJjn6ZqvPt+8QAwbj0ZPzIonE7KRLqjNcLZUv2iuYo
         BAaw==
X-Gm-Message-State: APjAAAUM2INBj9b04j1Ha1QAkwErUCNTjlC9wkHT5ydrYIQbVmQQQLxY
        PsivuGR6cF0BdnoKc0VCp26GNrrB
X-Google-Smtp-Source: APXvYqxDaTa5aqCm+chgjHLGW2vqpptGzmRd3EK3DbPOIfwrrTG4NZ2TEJVaHKhObqr7tukwhXUn3Q==
X-Received: by 2002:a25:abcf:: with SMTP id v73mr9166953ybi.114.1576253156726;
        Fri, 13 Dec 2019 08:05:56 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:05:56 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/7] soc: imx: gpcv2: add support for i.MX8M Mini SoC
Date:   Fri, 13 Dec 2019 10:05:38 -0600
Message-Id: <20191213160542.15757-4-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPCv2 on the Freescale i.MX8M Mini SoC works in the same way as the
GPCv2 on the i.MX8MQ, but with slightly different power domains and
mapping.

This patch adds the necessary tables so the GPC can operate on the
i.MX8M Mini.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

 drivers/soc/imx/gpcv2.c | 244 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 250f740d2314..52668e985e8e 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -41,6 +41,20 @@
 #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
 #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
 
+#define IMX8MM_VPU_H1_A53_DOMAIN		BIT(15)
+#define IMX8MM_VPU_G2_A53_DOMAIN		BIT(14)
+#define IMX8MM_VPU_G1_A53_DOMAIN		BIT(13)
+#define IMX8MM_DISP_MIX_A53_DOMAIN		BIT(12)
+#define IMX8MM_GPU_3D_A53_DOMAIN		BIT(11)
+#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
+#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
+#define IMX8MM_GPU_2D_A53_DOMAIN		BIT(8)
+#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
+#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
+#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
+#define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
+#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
+
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
 
@@ -64,6 +78,20 @@
 #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
 #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
 
+#define IMX8MM_VPU_H1_SW_Pxx_REQ		BIT(13)
+#define IMX8MM_VPU_G2_SW_Pxx_REQ		BIT(12)
+#define IMX8MM_VPU_G1_SW_Pxx_REQ		BIT(11)
+#define IMX8MM_DISP_SW_Pxx_REQ			BIT(10)
+#define IMX8MM_GPU_3D_SW_Pxx_REQ		BIT(9)
+#define IMX8MM_VPU_SW_Pxx_REQ			BIT(8)
+#define IMX8MM_GPU_SW_Pxx_REQ			BIT(7)
+#define IMX8MM_GPU_2D_SW_PXX_REQ		BIT(6)
+#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
+#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
+#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
+#define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
+#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
+
 #define GPC_M4_PU_PDN_FLG		0x1bc
 
 #define GPC_PU_PWRHSK			0x1fc
@@ -72,6 +100,10 @@
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
 
+#define IMX8MM_GPU_HSK_PWRDNREQN		BIT(9)
+#define IMX8MM_VPU_HSK_PWRDNREQN		BIT(8)
+#define IMX8MM_DISP_HSK_PWRDNREQN		BIT(7)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -94,6 +126,24 @@
 #define IMX8M_PGC_MIPI_CSI2		28
 #define IMX8M_PGC_PCIE2			29
 
+/*
+ * Taken from i.MX8M Mini values from Reference
+ * Manual, Rev. 2, 08/2019
+ */
+#define IMX8MM_PGC_MIPI			16
+#define IMX8MM_PGC_PCIE			17
+#define IMX8MM_PGC_OTG1			18
+#define IMX8MM_PGC_OTG2			19
+#define IMX8MM_PGC_DDR1			21
+#define IMX8MM_PGC_GPU2D		22
+#define IMX8MM_PGC_GPU			23
+#define IMX8MM_PGC_VPU			24
+#define IMX8MM_PGC_GPU3D		25
+#define IMX8MM_PGC_DISP			26
+#define IMX8MM_PGC_VPU_G1		27
+#define IMX8MM_PGC_VPU_G2		28
+#define IMX8MM_PGC_VPU_H1		29
+
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -278,6 +328,7 @@ static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	.reg_access_table = &imx7_access_table,
 };
 
+/* i.MX8M dual/QuadLite/Quad */
 static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 	[IMX8M_POWER_DOMAIN_MIPI] = {
 		.genpd = {
@@ -442,6 +493,198 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
 	.reg_access_table = &imx8m_access_table,
 };
 
+/* i.MX8M Mini */
+static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
+	[IMX8MM_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name      = "mipi",
+		},
+		.bits  = {
+			.pxx = IMX8MM_MIPI_SW_Pxx_REQ,
+			.map = IMX8MM_MIPI_A53_DOMAIN,
+		},
+		.pgc	   = IMX8M_PGC_MIPI,
+	},
+
+	[IMX8MM_POWER_DOMAIN_PCIE] = {
+		.genpd = {
+			.name = "pcie1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_PCIE_SW_Pxx_REQ,
+			.map = IMX8MM_PCIE_A53_DOMAIN,
+		},
+		.pgc   = IMX8MM_PGC_PCIE,
+	},
+
+	[IMX8MM_POWER_DOMAIN_USB_OTG1] = {
+		.genpd = {
+			.name = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
+			.map = IMX8MM_OTG1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_OTG1,
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
+		.pgc   = IMX8M_PGC_OTG2,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DDR1] = {
+		.genpd = {
+			.name = "ddr1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_DDR1_SW_Pxx_REQ,
+			.map = IMX8MM_DDR1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_DDR1,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU2D] = {
+		.genpd = {
+			.name = "gpu2d",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPU_2D_SW_PXX_REQ,
+			.map = IMX8MM_GPU_2D_A53_DOMAIN,
+			.hsk = IMX8MM_GPU_HSK_PWRDNREQN,
+		},
+		.pgc   = IMX8MM_PGC_GPU2D,
+	},
+
+
+	[IMX8MM_POWER_DOMAIN_GPU] = {
+		.genpd = {
+			.name = "gpu",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
+			.map = IMX8MM_GPUMIX_A53_DOMAIN,
+			.hsk = IMX8MM_GPU_HSK_PWRDNREQN,
+		},
+		.pgc   = IMX8M_PGC_GPU,
+	},
+
+	[IMX8MM_POWER_DOMAIN_VPU] = {
+		.genpd = {
+			.name = "vpu",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPU_SW_Pxx_REQ,
+			.map = IMX8MM_VPUMIX_A53_DOMAIN,
+			.hsk = IMX8MM_VPU_HSK_PWRDNREQN,
+		},
+		.pgc   = IMX8M_PGC_VPU,
+	},
+
+	[IMX8MM_POWER_DOMAIN_GPU3D] = {
+		.genpd = {
+			.name = "gpu3d",
+		},
+		.bits  = {
+			.pxx = IMX8MM_GPU_3D_SW_Pxx_REQ,
+			.map = IMX8MM_GPU_3D_A53_DOMAIN,
+			.hsk = IMX8MM_GPU_HSK_PWRDNREQN,
+		},
+		.pgc   = IMX8MM_PGC_GPU2D,
+	},
+
+	[IMX8MM_POWER_DOMAIN_DISP] = {
+		.genpd = {
+			.name = "disp",
+		},
+		.bits  = {
+			.pxx = IMX8MM_DISP_SW_Pxx_REQ,
+			.map = IMX8MM_DISP_MIX_A53_DOMAIN,
+			.hsk = IMX8MM_DISP_HSK_PWRDNREQN,
+		},
+		.pgc   = IMX8M_PGC_DISP,
+	},
+
+	[IMX8MM_POWER_VPU_G1] = {
+		.genpd = {
+			.name = "vpu_g1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPU_G1_SW_Pxx_REQ,
+			.map = IMX8MM_VPU_G1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_MIPI_CSI1,
+	},
+
+	[IMX8MM_POWER_VPU_G2] = {
+		.genpd = {
+			.name = "vpu_g2",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPU_G2_SW_Pxx_REQ,
+			.map = IMX8MM_VPU_G2_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_MIPI_CSI2,
+	},
+
+	[IMX8MM_POWER_VPU_H1] = {
+		.genpd = {
+			.name = "vpu_h1",
+		},
+		.bits  = {
+			.pxx = IMX8MM_VPU_H1_SW_Pxx_REQ,
+			.map = IMX8MM_VPU_H1_A53_DOMAIN,
+		},
+		.pgc   = IMX8M_PGC_PCIE2,
+	},
+};
+
+static const struct regmap_range imx8mm_yes_ranges[] = {
+		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+				 GPC_PU_PWRHSK),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_MIPI),
+				 GPC_PGC_SR(IMX8MM_PGC_MIPI)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_PCIE),
+				 GPC_PGC_SR(IMX8MM_PGC_PCIE)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
+				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DDR1),
+				 GPC_PGC_SR(IMX8MM_PGC_DDR1)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU2D),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU2D)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU),
+				 GPC_PGC_SR(IMX8MM_PGC_GPU)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPU),
+				 GPC_PGC_SR(IMX8MM_PGC_VPU)),
+		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DISP),
+				 GPC_PGC_SR(IMX8MM_PGC_DISP)),
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
@@ -641,6 +884,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
 	{ }
 };
 
-- 
2.20.1

