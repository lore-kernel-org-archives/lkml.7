Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A376D20830
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KcOxNljK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfCaMf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:35:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51585 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035724; x=1585571724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aK/dwqxRLolKxmXgGMOppvigoDjjh6QbhPfu/gXZ3uo=;
  b=KcOxNljK4bxht5q50PGOWQ4+UGvQWfJ57O+mIcrM/9DdT+NrNlGQGEk8
   eE57wpdB7+SMtenyPZil4tqyCnZrjm7VB5ygD4IkymLJFkruwJ05kX9Gc
   gXxc9jWKsBAOi9wuP4aYBkWveKy7sbXZKygcLTBXvSG/DKA6aYxWBab4K
   g=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="791784899"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:35:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCZJHl072025
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:35:22 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:22 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.69) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:12 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <ronenk@amazon.com>, <dwmw@amazon.co.uk>, <vaerov@amazon.com>,
        <zeev@amazon.com>, <alisaidi@amazon.com>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 3/7] irqchip/al-msi: Rename AL-MSIx driver
Date:   Sun, 31 Mar 2019 15:34:11 +0300
Message-ID: <1554035655-11352-4-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpine is the name of the SoC family, while AL stands for Annapurna
Labs. Rename to the latter since the driver will appear in other SoC
families other than Alpine.

Add device tree match for "amazon/al-msix".

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 arch/arm/mach-alpine/Kconfig                       |  2 +-
 arch/arm64/Kconfig.platforms                       |  2 +-
 drivers/irqchip/Kconfig                            |  2 +-
 drivers/irqchip/Makefile                           |  2 +-
 drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} | 93 +++++++++++-----------
 5 files changed, 49 insertions(+), 52 deletions(-)
 rename drivers/irqchip/{irq-alpine-msi.c => irq-al-msi.c} (68%)

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index bc04c91..2d9879a 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -2,7 +2,7 @@
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
 	depends on ARCH_MULTI_V7
-	select ALPINE_MSI
+	select AL_MSI
 	select ARM_AMBA
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf3..e3e4c3c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -18,7 +18,7 @@ config ARCH_SUNXI
 
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
-	select ALPINE_MSI if PCI
+	select AL_MSI if PCI
 	help
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5dcb545..79683cd 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -83,7 +83,7 @@ config ARMADA_370_XP_IRQ
 	select PCI_MSI if PCI
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
-config ALPINE_MSI
+config AL_MSI
 	bool
 	depends on PCI
 	select PCI_MSI
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7acd0e3..c718ffc 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
-obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
+obj-$(CONFIG_AL_MSI)			+= irq-al-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-al-msi.c
similarity index 68%
rename from drivers/irqchip/irq-alpine-msi.c
rename to drivers/irqchip/irq-al-msi.c
index ec6a606..a1bbefc 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-al-msi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Annapurna Labs MSIX support services
+ * Amazon's Annapurna Labs MSIX support services.
  *
  * Copyright (C) 2016, Amazon.com, Inc. or its affiliates. All Rights Reserved.
  *
@@ -21,12 +21,11 @@
 #include <linux/slab.h>
 
 #include <asm/irq.h>
-#include <asm/msi.h>
 
 /* MSIX message address format: local GIC target */
-#define ALPINE_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
+#define AL_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
 
-struct alpine_msix_data {
+struct al_msix_data {
 	spinlock_t msi_map_lock;
 	phys_addr_t addr;
 	u32 spi_first;		/* The SGI number that MSIs start */
@@ -34,27 +33,27 @@ struct alpine_msix_data {
 	unsigned long *msi_map;
 };
 
-static void alpine_msix_mask_msi_irq(struct irq_data *d)
+static void al_msix_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
 	irq_chip_mask_parent(d);
 }
 
-static void alpine_msix_unmask_msi_irq(struct irq_data *d)
+static void al_msix_unmask_msi_irq(struct irq_data *d)
 {
 	pci_msi_unmask_irq(d);
 	irq_chip_unmask_parent(d);
 }
 
-static struct irq_chip alpine_msix_irq_chip = {
+static struct irq_chip al_msix_irq_chip = {
 	.name			= "MSIx",
-	.irq_mask		= alpine_msix_mask_msi_irq,
-	.irq_unmask		= alpine_msix_unmask_msi_irq,
+	.irq_mask		= al_msix_mask_msi_irq,
+	.irq_unmask		= al_msix_unmask_msi_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
+static int al_msix_allocate_sgi(struct al_msix_data *priv, int num_req)
 {
 	int first;
 
@@ -74,8 +73,8 @@ static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
 	return priv->spi_first + first;
 }
 
-static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
-				 int num_req)
+static void al_msix_free_sgi(struct al_msix_data *priv, unsigned int sgi,
+			     int num_req)
 {
 	int first = sgi - priv->spi_first;
 
@@ -86,10 +85,9 @@ static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
 	spin_unlock(&priv->msi_map_lock);
 }
 
-static void alpine_msix_compose_msi_msg(struct irq_data *data,
-					struct msi_msg *msg)
+static void al_msix_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct alpine_msix_data *priv = irq_data_get_irq_chip_data(data);
+	struct al_msix_data *priv = irq_data_get_irq_chip_data(data);
 	phys_addr_t msg_addr = priv->addr;
 
 	msg_addr |= (data->hwirq << 3);
@@ -105,23 +103,23 @@ static void alpine_msix_compose_msi_msg(struct irq_data *data,
 	iommu_dma_map_msi_msg(data->irq, msg);
 }
 
-static struct msi_domain_info alpine_msix_domain_info = {
+static struct msi_domain_info al_msix_domain_info = {
 	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_PCI_MSIX,
-	.chip	= &alpine_msix_irq_chip,
+	.chip	= &al_msix_irq_chip,
 };
 
 static struct irq_chip middle_irq_chip = {
-	.name			= "alpine_msix_middle",
+	.name			= "al_msix_middle",
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.irq_compose_msi_msg	= alpine_msix_compose_msi_msg,
+	.irq_compose_msi_msg	= al_msix_compose_msi_msg,
 };
 
-static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
-					unsigned int virq, int sgi)
+static int al_msix_gic_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, int sgi)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -146,19 +144,19 @@ static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
-static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
-					   unsigned int virq,
-					   unsigned int nr_irqs, void *args)
+static int al_msix_middle_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int nr_irqs, void *args)
 {
-	struct alpine_msix_data *priv = domain->host_data;
+	struct al_msix_data *priv = domain->host_data;
 	int sgi, err, i;
 
-	sgi = alpine_msix_allocate_sgi(priv, nr_irqs);
+	sgi = al_msix_allocate_sgi(priv, nr_irqs);
 	if (sgi < 0)
 		return sgi;
 
 	for (i = 0; i < nr_irqs; i++) {
-		err = alpine_msix_gic_domain_alloc(domain, virq + i, sgi + i);
+		err = al_msix_gic_domain_alloc(domain, virq + i, sgi + i);
 		if (err)
 			goto err_sgi;
 
@@ -171,28 +169,28 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 err_sgi:
 	while (--i >= 0)
 		irq_domain_free_irqs_parent(domain, virq, i);
-	alpine_msix_free_sgi(priv, sgi, nr_irqs);
+	al_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
 
-static void alpine_msix_middle_domain_free(struct irq_domain *domain,
-					   unsigned int virq,
-					   unsigned int nr_irqs)
+static void al_msix_middle_domain_free(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct alpine_msix_data *priv = irq_data_get_irq_chip_data(d);
+	struct al_msix_data *priv = irq_data_get_irq_chip_data(d);
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	alpine_msix_free_sgi(priv, d->hwirq, nr_irqs);
+	al_msix_free_sgi(priv, d->hwirq, nr_irqs);
 }
 
-static const struct irq_domain_ops alpine_msix_middle_domain_ops = {
-	.alloc	= alpine_msix_middle_domain_alloc,
-	.free	= alpine_msix_middle_domain_free,
+static const struct irq_domain_ops al_msix_middle_domain_ops = {
+	.alloc	= al_msix_middle_domain_alloc,
+	.free	= al_msix_middle_domain_free,
 };
 
-static int alpine_msix_init_domains(struct alpine_msix_data *priv,
-				    struct device_node *node)
+static int al_msix_init_domains(struct al_msix_data *priv,
+				struct device_node *node)
 {
 	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
 	struct device_node *gic_node;
@@ -209,8 +207,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 		return -ENXIO;
 	}
 
-	middle_domain = irq_domain_add_tree(NULL,
-					    &alpine_msix_middle_domain_ops,
+	middle_domain = irq_domain_add_tree(NULL, &al_msix_middle_domain_ops,
 					    priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSIX middle domain\n");
@@ -220,7 +217,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 	middle_domain->parent = gic_domain;
 
 	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
-					       &alpine_msix_domain_info,
+					       &al_msix_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
 		pr_err("Failed to create MSI domain\n");
@@ -231,10 +228,9 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 	return 0;
 }
 
-static int alpine_msix_init(struct device_node *node,
-			    struct device_node *parent)
+static int al_msix_init(struct device_node *node, struct device_node *parent)
 {
-	struct alpine_msix_data *priv;
+	struct al_msix_data *priv;
 	struct resource res;
 	int ret;
 
@@ -257,8 +253,8 @@ static int alpine_msix_init(struct device_node *node,
 	 * To select the primary GIC as the target GIC, bits [18:17] must be set
 	 * to 0x0. In this case, bit 16 (SPI_TARGET_CLUSTER0) must be set.
 	 */
-	priv->addr = res.start & GENMASK_ULL(63,20);
-	priv->addr |= ALPINE_MSIX_SPI_TARGET_CLUSTER0;
+	priv->addr = res.start & GENMASK_ULL(63, 20);
+	priv->addr |= AL_MSIX_SPI_TARGET_CLUSTER0;
 
 	if (of_property_read_u32(node, "al,msi-base-spi", &priv->spi_first)) {
 		pr_err("Unable to parse MSI base\n");
@@ -283,7 +279,7 @@ static int alpine_msix_init(struct device_node *node,
 	pr_debug("Registering %d msixs, starting at %d\n",
 		 priv->num_spis, priv->spi_first);
 
-	ret = alpine_msix_init_domains(priv, node);
+	ret = al_msix_init_domains(priv, node);
 	if (ret)
 		goto err_map;
 
@@ -295,4 +291,5 @@ static int alpine_msix_init(struct device_node *node,
 	kfree(priv);
 	return ret;
 }
-IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", alpine_msix_init);
+IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", al_msix_init);
+IRQCHIP_DECLARE(al_msix, "amazon,al-msix", al_msix_init);
-- 
2.7.4

