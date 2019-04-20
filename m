Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1914CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9602186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dpkeC95P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfDTKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59444 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfDTKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KABL8e081031;
        Sat, 20 Apr 2019 05:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755081;
        bh=fwMtKmHI0LHaI4B1vd4OY0LZJNxjgh5qJQeE541Muvs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dpkeC95P7Hw6dJpY+q/b1ONrGi4GZ0dyciymRt5gazeATIkGoS1mF6mfgsh+4WcYb
         TnIuY7IO1HIbeelBuXiCALkiBb3lDLNAT4r7PNeUcVpy7pnNL82qnbGug37QZWexNW
         9sJ2F/5+fSu6WVmxBtdnCYCVHUb262vh6U02ntas=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KABLnL098500
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:11:21 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:11:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:11:21 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHa4070234;
        Sat, 20 Apr 2019 05:11:17 -0500
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
Subject: [PATCH v7 13/14] irqchip: ti-sci-inta: Add msi domain support
Date:   Sat, 20 Apr 2019 15:39:49 +0530
Message-ID: <20190420100950.7997-14-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420100950.7997-1-lokeshvutla@ti.com>
References: <20190420100950.7997-1-lokeshvutla@ti.com>
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
Changes since v6:
- Updated to get device id from platform device. 

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
index 71e5b45ab4ce..53a356795ebf 100644
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
@@ -496,9 +500,34 @@ static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
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
@@ -563,6 +592,15 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
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

