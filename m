Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412DD2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fgz3tME/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfDJEPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:15:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44136 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfDJEPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:15:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3A4F50q070396;
        Tue, 9 Apr 2019 23:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554869705;
        bh=2Ri3fN8cm0qUGrchZJxhQ2C+jhTX/z/duqEtN9Id0pQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Fgz3tME/zTgGl2QevyuNesaALe1MPpygSgnO87tV6sLowsAYqTAbmKchQfmpGz4Fb
         dGJr5TVTlzGK+rimwKWXCFUkctnrdcrZcdJCLLvwz+4ay9cCI6VVXtYYeH3AlEvXA4
         HmqTPIw2/NtyyEz+GWUAzDePPUCoLVO9QzXUt3mk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3A4F5fv071124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 23:15:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 23:15:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 23:15:05 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3A4EKZV029255;
        Tue, 9 Apr 2019 23:15:01 -0500
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
Subject: [PATCH v6 10/12] soc: ti: Add MSI domain bus support for Interrupt Aggregator
Date:   Wed, 10 Apr 2019 09:43:56 +0530
Message-ID: <20190410041358.16809-11-lokeshvutla@ti.com>
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

With the system coprocessor managing the range allocation of the
inputs to Interrupt Aggregator, it is difficult to represent
the device IRQs from DT.

The suggestion is to use MSI in such cases where devices wants
to allocate and group interrupts dynamically.

Create a MSI domain bus layer that allocates and frees MSIs for
a device.

APIs that are implemented:
- ti_sci_inta_msi_create_irq_domain() that creates a MSI domain
- ti_sci_inta_msi_domain_alloc_irqs() that creates MSIs for the
  specified device and resource.
- ti_sci_inta_msi_domain_free_irqs() frees the irqs attached to the device.
- ti_sci_inta_msi_get_virq() for getting the virq attached to a specific event.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v5:
- Updated the input parametes to all apis
- Updated the default chip ops.
- Prefixed all the apis with ti_sci_inta_

Marc,
	Right now ti_sci_resource is being passed for irq allocatons.
I couldn't get to use resources attached to platform_device. Because
platform_device resources are allocated in of_device_alloc() and number
of resources are fixed in it. In order to update the resources, driver
has to do a krealloc(pdev->resources) and update the num of resources.
Is it allowed to update the pdev->resources during probe time? If yes,
Ill be happy to update the patch to use platform_dev resources.


 MAINTAINERS                            |   2 +
 drivers/soc/ti/Kconfig                 |   6 +
 drivers/soc/ti/Makefile                |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c       | 167 +++++++++++++++++++++++++
 include/linux/irqdomain.h              |   1 +
 include/linux/msi.h                    |   6 +
 include/linux/soc/ti/ti_sci_inta_msi.h |  23 ++++
 7 files changed, 206 insertions(+)
 create mode 100644 drivers/soc/ti/ti_sci_inta_msi.c
 create mode 100644 include/linux/soc/ti/ti_sci_inta_msi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ba88b3033fe4..dd31d7cb2fc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15353,6 +15353,8 @@ F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/irqchip/irq-ti-sci-inta.c
+F:	include/linux/soc/ti/ti_sci_inta_msi.h
+F:	drivers/soc/ti/ti_sci_inta_msi.c
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index be4570baad96..82f110fe4953 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -73,4 +73,10 @@ config TI_SCI_PM_DOMAINS
 	  called ti_sci_pm_domains. Note this is needed early in boot before
 	  rootfs may be available.
 
+config TI_SCI_INTA_MSI_DOMAIN
+	bool
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Driver to enable Interrupt Aggregator specific MSI Domain.
+
 endif # SOC_TI
diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index a22edc0b258a..b3868d392d4f 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
+obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
new file mode 100644
index 000000000000..247a5e5f216b
--- /dev/null
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator MSI bus
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/soc/ti/ti_sci_inta_msi.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+
+static void ti_sci_inta_msi_write_msg(struct irq_data *data,
+				      struct msi_msg *msg)
+{
+	/* Nothing to do */
+}
+
+static void ti_sci_inta_msi_compose_msi_msg(struct irq_data *data,
+					    struct msi_msg *msg)
+{
+	/* Nothing to do */
+}
+
+static int ti_sci_inta_msi_request_resources(struct irq_data *data)
+{
+	data = data->parent_data;
+
+	return data->chip->irq_request_resources(data);
+}
+
+static void ti_sci_inta_msi_release_resources(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_release_resources(data);
+}
+
+static void ti_sci_inta_msi_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip = info->chip;
+
+	WARN_ON(!chip);
+	if (!chip->irq_mask)
+		chip->irq_mask = irq_chip_mask_parent;
+	if (!chip->irq_unmask)
+		chip->irq_unmask = irq_chip_unmask_parent;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
+	if (!chip->irq_set_type)
+		chip->irq_set_type = irq_chip_set_type_parent;
+	if (!chip->irq_write_msi_msg)
+		chip->irq_write_msi_msg = ti_sci_inta_msi_write_msg;
+	if (!chip->irq_compose_msi_msg)
+		chip->irq_compose_msi_msg = ti_sci_inta_msi_compose_msi_msg;
+	if (!chip->irq_request_resources)
+		chip->irq_request_resources = ti_sci_inta_msi_request_resources;
+	if (!chip->irq_release_resources)
+		chip->irq_release_resources = ti_sci_inta_msi_release_resources;
+}
+
+struct irq_domain
+*ti_sci_inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
+				   struct msi_domain_info *info,
+				   struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
+		ti_sci_inta_msi_update_chip_ops(info);
+
+	domain = msi_create_irq_domain(fwnode, info, parent);
+	if (domain)
+		irq_domain_update_bus_token(domain, DOMAIN_BUS_TI_SCI_INTA_MSI);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(ti_sci_inta_msi_create_irq_domain);
+
+static void ti_sci_inta_msi_free_descs(struct device *dev)
+{
+	struct msi_desc *desc, *tmp;
+
+	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+}
+
+static int ti_sci_inta_msi_alloc_descs(struct device *dev, u32 dev_id,
+				       struct ti_sci_resource *res)
+{
+	struct msi_desc *msi_desc;
+	int set, i, count = 0;
+
+	for (set = 0; set < res->sets; set++) {
+		for (i = 0; i < res->desc[set].num; i++) {
+			msi_desc = alloc_msi_entry(dev, 1, NULL);
+			if (!msi_desc) {
+				ti_sci_inta_msi_free_descs(dev);
+				return -ENOMEM;
+			}
+
+			msi_desc->inta.index = res->desc[set].start + i;
+			msi_desc->inta.dev_id = dev_id;
+			INIT_LIST_HEAD(&msi_desc->list);
+			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
+			count++;
+		}
+	}
+
+	return count;
+}
+
+int ti_sci_inta_msi_domain_alloc_irqs(struct platform_device *pdev,
+				      struct ti_sci_resource *res)
+{
+	struct irq_domain *msi_domain;
+	int ret, nvec;
+
+	msi_domain = dev_get_msi_domain(&pdev->dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	if (pdev->id < 0)
+		return -ENODEV;
+
+	nvec = ti_sci_inta_msi_alloc_descs(&pdev->dev, pdev->id, res);
+	if (nvec <= 0)
+		return nvec;
+
+	ret = msi_domain_alloc_irqs(msi_domain, &pdev->dev, nvec);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to allocate IRQs %d\n", ret);
+		goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	ti_sci_inta_msi_free_descs(&pdev->dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
+
+void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
+{
+	msi_domain_free_irqs(dev->msi_domain, dev);
+	ti_sci_inta_msi_free_descs(dev);
+}
+EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
+
+unsigned int ti_sci_inta_msi_get_virq(struct platform_device *pdev, u32 index)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, &pdev->dev)
+		if (desc->inta.index == index && desc->inta.dev_id == pdev->id)
+			return desc->irq;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 61706b430907..07ec8b390161 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -82,6 +82,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
+	DOMAIN_BUS_TI_SCI_INTA_MSI,
 };
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..7e12dfc4cb39 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,11 @@ struct fsl_mc_msi_desc {
 	u16				msi_index;
 };
 
+struct ti_sci_inta_msi_desc {
+	u16	dev_id;
+	u16	index;
+};
+
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
@@ -106,6 +111,7 @@ struct msi_desc {
 		 */
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
+		struct ti_sci_inta_msi_desc inta;
 	};
 };
 
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
new file mode 100644
index 000000000000..b0ca20ab3f49
--- /dev/null
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Texas Instruments' K3 TI SCI INTA MSI helper
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#ifndef __INCLUDE_LINUX_TI_SCI_INTA_MSI_H
+#define __INCLUDE_LINUX_TI_SCI_INTA_MSI_H
+
+#include <linux/msi.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+
+struct irq_domain
+*ti_sci_inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
+				   struct msi_domain_info *info,
+				   struct irq_domain *parent);
+int ti_sci_inta_msi_domain_alloc_irqs(struct platform_device *pdev,
+				      struct ti_sci_resource *res);
+unsigned int ti_sci_inta_msi_get_virq(struct platform_device *dev, u32 index);
+void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
+#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
-- 
2.21.0

