Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA4C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2082D214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqzcRmtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfLECTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:51 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40963 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfLECTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:48 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so612275ywc.8;
        Wed, 04 Dec 2019 18:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=621Cm7dZoaPTmqRDbrz7D11MnF6YUOXkh/EGWPUzymQ=;
        b=OqzcRmtuqTW5DEpxYJ32kr7tOzbTpmAqLhj/7BfbD9zxBW5SIIrLA7VN1+79dlTCNI
         o5R3dMuHzcz3b/qiMxZy4eB5VlNLkWtIOCnnLxI6V6INbGlGjdrKRpK0yLrOjhdl7/y3
         g2Glx999iiwbqnY5vfoHu0Ww4pv9QpCuDnLNWURlX9ZLagyTSVc1hAVAzmR6yBhI5fAx
         EO7VSV6H9xessVubW3v+qkSJP9MiwYX/ROp9HeSZIVvDzTlKjsjOCkyNpMmyscDYkojG
         /v8J+WN+t/1HIVBUoo6vzbGL5jQVTyhpY9tPWl29j39Bp0KfzZ111/stJpm5to0J1zUR
         dscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=621Cm7dZoaPTmqRDbrz7D11MnF6YUOXkh/EGWPUzymQ=;
        b=cq6IUSosPnzrDO3Ox4vN1GifIBtwJnTAxGVgf4MS0dR1i0uOvwdUFq4pKCrzzVqFfZ
         vKkw3EDRyc4yKezv092i5CdKG6dcl6I0qEndmYvqqth0n7UJWYPnTdjpCwzZiHeeD67a
         PEN8hm07F9kZRycwL35YsLyILskunLyAj26HBnR1IODztPNKu/RJGZpbBpLZu4AgaVMv
         CytpHJGGU5zVO13HpRANqB4jiYAgtvWxu771TxczA3h68dg4g/9T4YIvpyhRjmqfhWEQ
         C/tJg2QF35NoD8YEVKIEkGepgwinsUgg/lX+TioiISYQCqDCWPaAkNYy3A/wsHZe3+wZ
         5Glw==
X-Gm-Message-State: APjAAAWbOnIO0iG5YxJ1E6iU96JaXJxsUqpE3Yb5kiQngSTVSVD51MGB
        Z4XduVQmtXNo1p59fhwrZZ8=
X-Google-Smtp-Source: APXvYqxb5JgWmenHFyBQgj4zZQaeIydNE8xKMGtxGuoQRII2pBRRqqfBR4c/j9X5nUWoXQ9p8ZiHYA==
X-Received: by 2002:a81:3d0e:: with SMTP id k14mr2685477ywa.35.1575512386803;
        Wed, 04 Dec 2019 18:19:46 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:46 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] soc: imx: gpcv2: add support for i.MX8M Mini SoC
Date:   Wed,  4 Dec 2019 20:19:19 -0600
Message-Id: <20191205021924.25188-4-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
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

