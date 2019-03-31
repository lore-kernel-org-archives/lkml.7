Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7457C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9632620872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TQjsvR+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfCaMgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:36:08 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21097 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035767; x=1585571767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=f75KH28fv28tMQnTi4YCDX6svGZMrzqSuQYdRGpSroY=;
  b=TQjsvR+MGpFDKSiBPB5p/Jh6nCuDCdtd18ooTJkhiDh4/0x9suJQ2MPy
   uGTOofAbkyJG7f7e8YgplhZbf4Gmww0ANwGTnqzBpUS3IcFb2/VQYlFJA
   XJ7QUvKpkATGJWkOGdHHqj0YurhOXDBJUZSgmA71UPVZXIXyGJxZ2u1UP
   U=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="796653386"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:36:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCa1fM066769
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:36:06 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:36:05 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.161.164) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:55 +0000
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
Subject: [PATCH 6/7] irqchip/al-msi: Refactor in preparation to add ACPI support
Date:   Sun, 31 Mar 2019 15:35:32 +0300
Message-ID: <1554035733-11827-2-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
References: <1554035733-11827-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.164]
X-ClientProxiedBy: EX13D20UWC002.ant.amazon.com (10.43.162.163) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common parts which will be shared between DT and ACPI parsing, to
a common function.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/irqchip/irq-al-msi.c | 87 +++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/irq-al-msi.c b/drivers/irqchip/irq-al-msi.c
index f04a311c..ec27455 100644
--- a/drivers/irqchip/irq-al-msi.c
+++ b/drivers/irqchip/irq-al-msi.c
@@ -26,6 +26,7 @@
 #define AL_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
 
 struct al_msix_data {
+	struct fwnode_handle *msi_domain_handle;
 	spinlock_t msi_map_lock;
 	phys_addr_t addr;
 	u32 spi_first;		/* The SPI number that MSIs start */
@@ -190,22 +191,9 @@ static const struct irq_domain_ops al_msix_middle_domain_ops = {
 };
 
 static int al_msix_init_domains(struct al_msix_data *priv,
-				struct device_node *node)
+				struct irq_domain *gic_domain)
 {
-	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
-	struct device_node *gic_node;
-
-	gic_node = of_irq_find_parent(node);
-	if (!gic_node) {
-		pr_err("Failed to find the GIC node\n");
-		return -ENODEV;
-	}
-
-	gic_domain = irq_find_host(gic_node);
-	if (!gic_domain) {
-		pr_err("Failed to find the GIC domain\n");
-		return -ENXIO;
-	}
+	struct irq_domain *middle_domain, *msi_domain;
 
 	middle_domain = irq_domain_add_tree(NULL, &al_msix_middle_domain_ops,
 					    priv);
@@ -216,7 +204,7 @@ static int al_msix_init_domains(struct al_msix_data *priv,
 
 	middle_domain->parent = gic_domain;
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->msi_domain_handle,
 					       &al_msix_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -228,34 +216,62 @@ static int al_msix_init_domains(struct al_msix_data *priv,
 	return 0;
 }
 
+static int al_msix_init_common(struct al_msix_data *priv, u64 base_address)
+{
+	spin_lock_init(&priv->msi_map_lock);
+
+	/*
+	 * The 20 least significant bits of addr provide direct information
+	 * regarding the interrupt destination.
+	 *
+	 * To select the primary GIC as the target GIC, bits [18:17] must be set
+	 * to 0x0. In this case, bit 16 (SPI_TARGET_CLUSTER0) must be set.
+	 */
+	priv->addr = base_address & GENMASK_ULL(63, 20);
+	priv->addr |= AL_MSIX_SPI_TARGET_CLUSTER0;
+
+	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
+				sizeof(*priv->msi_map),
+				GFP_KERNEL);
+	if (!priv->msi_map)
+		return -ENOMEM;
+
+	pr_debug("Registering %d msixs, starting at %d\n", priv->num_spis,
+		 priv->spi_first);
+
+	return 0;
+}
+
 static int al_msix_init(struct device_node *node, struct device_node *parent)
 {
 	struct al_msix_data *priv;
 	struct resource res;
+	struct device_node *gic_node;
+	struct irq_domain *gic_domain;
 	int ret;
 
+	gic_node = of_irq_find_parent(node);
+	if (!gic_node) {
+		pr_err("Failed to find the GIC node\n");
+		return -ENODEV;
+	}
+
+	gic_domain = irq_find_host(gic_node);
+	if (!gic_domain) {
+		pr_err("Failed to find the GIC domain\n");
+		return -ENXIO;
+	}
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->msi_map_lock);
-
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("Failed to allocate resource\n");
 		goto err_priv;
 	}
 
-	/*
-	 * The 20 least significant bits of addr provide direct information
-	 * regarding the interrupt destination.
-	 *
-	 * To select the primary GIC as the target GIC, bits [18:17] must be set
-	 * to 0x0. In this case, bit 16 (SPI_TARGET_CLUSTER0) must be set.
-	 */
-	priv->addr = res.start & GENMASK_ULL(63, 20);
-	priv->addr |= AL_MSIX_SPI_TARGET_CLUSTER0;
-
 	if (of_property_read_u32(node, "al,msi-base-spi", &priv->spi_first)) {
 		pr_err("Unable to parse MSI base\n");
 		ret = -EINVAL;
@@ -268,18 +284,13 @@ static int al_msix_init(struct device_node *node, struct device_node *parent)
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret = -ENOMEM;
-		goto err_priv;
-	}
+	priv->msi_domain_handle = of_node_to_fwnode(node);
 
-	pr_debug("Registering %d msixs, starting at %d\n",
-		 priv->num_spis, priv->spi_first);
+	ret = al_msix_init_common(priv, res.start);
+	if (ret)
+		goto err_priv;
 
-	ret = al_msix_init_domains(priv, node);
+	ret = al_msix_init_domains(priv, gic_domain);
 	if (ret)
 		goto err_map;
 
-- 
2.7.4

