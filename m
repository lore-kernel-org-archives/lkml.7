Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB4C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894CE2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bcjumDDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfDJEQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:16:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54286 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfDJEPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:15:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3A4F9te090138;
        Tue, 9 Apr 2019 23:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554869709;
        bh=Q43nU02y+wqlnIyUbcUafE3Nyo/EkaIJEtyWqRSojzo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bcjumDDyNIXaEDGyyBih48yl7D3tmlxcr6KqrrDHCazmoA/Mm1rRDiUJYpn6AMV7Y
         FQl3AUjzVb/04Ve922qaU+hxGhDOqlxw6uCOpyAF+DOUWCC+USaixo5FDzg+om4ZD7
         fMSq18DwxRi/ct+ygymNOP8D7KmkH4qqUHjnuH90=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3A4F95x071257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 23:15:09 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 23:15:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 23:15:09 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3A4EKZW029255;
        Tue, 9 Apr 2019 23:15:05 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 11/12] irqchip: ti-sci-inta: Add msi domain support
Date:   Wed, 10 Apr 2019 09:43:57 +0530
Message-ID: <20190410041358.16809-12-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410041358.16809-1-lokeshvutla@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
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
Changes since v5:
- New patch. Seperated out msi domain part from the intial patch.

Marc,
	I feel this is too simple to be a separate driver. So I am
	sticking it into the same file.

 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-ti-sci-inta.c | 39 ++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 946c062fcec0..e0a1ec55ca93 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -441,6 +441,7 @@ config TI_SCI_INTA_IRQCHIP
 	depends on TI_SCI_PROTOCOL && ARCH_K3
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
+	select TI_SCI_INTA_MSI_DOMAIN
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
 	  over TI System Control Interface available on some new TI's SoCs.
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 3eb935ebe10f..945e635847b2 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -18,6 +18,7 @@
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/irqchip/chained_irq.h>
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
@@ -528,9 +532,32 @@ static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
 	.free		= ti_sci_inta_irq_domain_free,
 };
 
+static struct irq_chip ti_sci_inta_msi_irq_chip = {
+	.name			= "MSI-INTA",
+	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+};
+
+static void ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
+				     struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = TO_HWIRQ(desc->inta.dev_id, desc->inta.index);
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
@@ -596,6 +623,16 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	msi_domain =
+		ti_sci_inta_msi_create_irq_domain(of_node_to_fwnode(node),
+						  &ti_sci_inta_msi_domain_info,
+						  domain);
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

