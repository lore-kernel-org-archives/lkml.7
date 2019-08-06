Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A90C2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565085709;
	bh=dbagpd1f3vFYvPzsOay2Yx9hxmhTyX0CC0TGAp5UngI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q34IjNxJhj3czGXhfbWXlgKF5K479KqOE1fV0iWKyfGMtIVKDIaca0UNRgZn2dIpt
	 aSNiGNFZSdNzqug/BhIvfJtj5LeuqDO2e4UVGghDEiRVTMLy8Cbdyk4vh7GGKVIWlx
	 vXSWXln2zjYB+SQg9RosxpRm0v8AEAPny9L9XJ3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfHFKBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:01:48 -0400
Received: from foss.arm.com ([217.140.110.172]:59538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbfHFKBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:01:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07BB337;
        Tue,  6 Aug 2019 03:01:45 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680773F706;
        Tue,  6 Aug 2019 03:01:44 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/12] irqchip/gic-v3: Add quirks for HIP06/07 invalid GICD_TYPER erratum 161010803
Date:   Tue,  6 Aug 2019 11:01:21 +0100
Message-Id: <20190806100121.240767-13-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806100121.240767-1-maz@kernel.org>
References: <20190806100121.240767-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the HIP06/07 SoCs have extra bits in their GICD_TYPER
registers, which confuse the GICv3.1 code (these systems appear to
expose ESPIs while they actually don't).

Detect these systems as early as possible and wipe the fields that
should be RES0 in the register.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  2 +
 drivers/irqchip/irq-gic-v3.c           | 54 +++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 3e57d09246e6..17ea3fecddaa 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -115,6 +115,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip0{6,7}       | #161010803      | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 334a10d9dbfb..bee141613b67 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1441,6 +1441,46 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_hip06_07(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	/*
+	 * HIP06 GICD_IIDR clashes with GIC-600 product number (despite
+	 * not being an actual ARM implementation). The saving grace is
+	 * that GIC-600 doesn't have ESPI, so nothing to do in that case.
+	 * HIP07 doesn't even have a proper IIDR, and still pretends to
+	 * have ESPI. In both cases, put them right.
+	 */
+	if (d->rdists.gicd_typer & GICD_TYPER_ESPI) {
+		/* Zero both ESPI and the RES0 field next to it... */
+		d->rdists.gicd_typer &= ~GENMASK(9, 8);
+		return true;
+	}
+
+	return false;
+}
+
+static const struct gic_quirk gic_quirks[] = {
+	{
+		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
+		.compatible = "qcom,msm8996-gic-v3",
+		.init	= gic_enable_quirk_msm8996,
+	},
+	{
+		.desc	= "GICv3: HIP06 erratum 161010803",
+		.iidr	= 0x0204043b,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+		.desc	= "GICv3: HIP07 erratum 161010803",
+		.iidr	= 0x00000000,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+	}
+};
+
 static void gic_enable_nmi_support(void)
 {
 	int i;
@@ -1494,6 +1534,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	 */
 	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
 	gic_data.rdists.gicd_typer = typer;
+
+	gic_enable_quirks(readl_relaxed(gic_data.dist_base + GICD_IIDR),
+			  gic_quirks, &gic_data);
+
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
@@ -1676,16 +1720,6 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
-static const struct gic_quirk gic_quirks[] = {
-	{
-		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
-		.compatible = "qcom,msm8996-gic-v3",
-		.init	= gic_enable_quirk_msm8996,
-	},
-	{
-	}
-};
-
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
-- 
2.20.1

