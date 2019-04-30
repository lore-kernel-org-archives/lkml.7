Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB86C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E33021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vOP3IF7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfD3KOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:14:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37082 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfD3KO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:14:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UAE5GO044451;
        Tue, 30 Apr 2019 05:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556619245;
        bh=9T1+9YJFLids0gdsas5L4APsMX65K8+z0t8DADJ616k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vOP3IF7HsaYfY131hD9QwEuI2zZ164xqYnP1dsKwho3tN+rOJft3gAtUEmQMIDO2o
         6sD64+Uh2JjCHC4GShfe0rdbyXpGCPx7Yivrj+0FMVBGSO8nF69GWZY6kwlTJ9NLPU
         TNArGxbIlk5+kevAfdKypGkW9eCBxig9rQUZZNg4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UAE5V2022606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 05:14:05 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 05:14:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 05:14:04 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UAD0YF085082;
        Tue, 30 Apr 2019 05:14:00 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: [PATCH v8 13/14] irqchip: ti-sci-inta: Add msi domain support
Date:   Tue, 30 Apr 2019 15:42:29 +0530
Message-ID: <20190430101230.21794-14-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430101230.21794-1-lokeshvutla@ti.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a msi domain that is child to the INTA domain. Clients
uses the INTA msi bus layer to allocate irqs in this
msi domain.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes sinece v7:
-None

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-ti-sci-inta.c | 40 ++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7c84a71bcd88..1fab40487d63 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -441,6 +441,7 @@ config TI_SCI_INTA_IRQCHIP
 	depends on TI_SCI_PROTOCOL
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
+	select TI_SCI_INTA_MSI_DOMAIN
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
 	  over TI System Control Interface available on some new TI's SoCs.
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 87e0abe0041f..011b60a49e3f 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -18,6 +18,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <asm-generic/msi.h>
 
@@ -28,6 +29,9 @@
 #define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
 				 (TI_SCI_DEV_ID_MASK))
 #define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
+#define TO_HWIRQ(dev, index)	((((dev) & TI_SCI_DEV_ID_MASK) << \
+				 TI_SCI_DEV_ID_SHIFT) | \
+				((index) & TI_SCI_IRQ_ID_MASK))
 
 #define MAX_EVENTS_PER_VINT	64
 #define VINT_ENABLE_SET_OFFSET	0x0
@@ -484,9 +488,34 @@ static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
 	.alloc		= ti_sci_inta_irq_domain_alloc,
 };
 
+static struct irq_chip ti_sci_inta_msi_irq_chip = {
+	.name			= "MSI-INTA",
+	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+};
+
+static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
+				     struct msi_desc *desc)
+{
+	struct platform_device *pdev = to_platform_device(desc->dev);
+
+	arg->desc = desc;
+	arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
+}
+
+static struct msi_domain_ops ti_sci_inta_msi_ops = {
+	.set_desc	= ti_sci_inta_msi_set_desc,
+};
+
+static struct msi_domain_info ti_sci_inta_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_LEVEL_CAPABLE),
+	.ops	= &ti_sci_inta_msi_ops,
+	.chip	= &ti_sci_inta_msi_irq_chip,
+};
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
-	struct irq_domain *parent_domain, *domain;
+	struct irq_domain *parent_domain, *domain, *msi_domain;
 	struct device_node *parent_node, *node;
 	struct ti_sci_inta_irq_domain *inta;
 	struct device *dev = &pdev->dev;
@@ -551,6 +580,15 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	msi_domain = ti_sci_inta_msi_create_irq_domain(of_node_to_fwnode(node),
+						&ti_sci_inta_msi_domain_info,
+						domain);
+	if (!msi_domain) {
+		irq_domain_remove(domain);
+		dev_err(dev, "Failed to allocate msi domain\n");
+		return -ENOMEM;
+	}
+
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
-- 
2.21.0

