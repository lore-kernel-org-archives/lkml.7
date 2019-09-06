Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC255C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4F206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404096AbfIFLJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47046 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392298AbfIFLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6G-00075z-1X; Fri, 06 Sep 2019 13:08:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 154511C0E1C;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Add quirks for HIP06/07 invalid
 GICD_TYPER erratum 161010803
Cc:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809602.24167.17230173797806822306.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7f2481b39b4c776fb9c03081ffcfe81f4961601c
Gitweb:        https://git.kernel.org/tip/7f2481b39b4c776fb9c03081ffcfe81f4961601c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 31 Jul 2019 17:29:33 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:35 +01:00

irqchip/gic-v3: Add quirks for HIP06/07 invalid GICD_TYPER erratum 161010803

It looks like the HIP06/07 SoCs have extra bits in their GICD_TYPER
registers, which confuse the GICv3.1 code (these systems appear to
expose ESPIs while they actually don't).

Detect these systems as early as possible and wipe the fields that
should be RES0 in the register.

Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arm64/silicon-errata.rst |  2 +-
 drivers/irqchip/irq-gic-v3.c           | 56 ++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 3e57d09..17ea3fe 100644
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
index 8af08dd..422664a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1441,6 +1441,48 @@ static bool gic_enable_quirk_msm8996(void *data)
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
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+		.desc	= "GICv3: HIP07 erratum 161010803",
+		.iidr	= 0x00000000,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+	}
+};
+
 static void gic_enable_nmi_support(void)
 {
 	int i;
@@ -1494,6 +1536,10 @@ static int __init gic_init_bases(void __iomem *dist_base,
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
@@ -1676,16 +1722,6 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
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
