Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BD320675
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n9qZ3SbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfDTKLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59442 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfDTKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KABHex081016;
        Sat, 20 Apr 2019 05:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755077;
        bh=ZJ7suusii44CrYsn3kDjnXK6reKLp45jPmnmJlOfVQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n9qZ3SbI2YP/GQFXJ+7dmfRRao+QmkTX8GXX419o/eb/SJJpQn12WhNzeI/0qf8Wz
         3I424lpxrmT6KV+v6N5BhnE9pVXKEUQzrquGre44HwXXyYL4VZQNn7EBNUiJFbNhHg
         E3Kt6lejoGG165uaGsIKn5ldBrCinOGygDPD+Kwo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KABHu2043048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:11:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:11:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:11:16 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHa3070234;
        Sat, 20 Apr 2019 05:11:12 -0500
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
Subject: [PATCH v7 12/14] soc: ti: Add MSI domain bus support for Interrupt Aggregator
Date:   Sat, 20 Apr 2019 15:39:48 +0530
Message-ID: <20190420100950.7997-13-lokeshvutla@ti.com>
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
Changes since v6:
- Arranged header files in alphabetical order.
- Dropped dev_id from struct ti_sci_inta_msi_desc
- Renamed index to dev_index in struct ti_sci_inta_msi_desc
- Fixed few cosmetic changes.

 MAINTAINERS                            |   2 +
 drivers/soc/ti/Kconfig                 |   6 +
 drivers/soc/ti/Makefile                |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c       | 146 +++++++++++++++++++++++++
 include/linux/irqdomain.h              |   1 +
 include/linux/msi.h                    |  10 ++
 include/linux/soc/ti/ti_sci_inta_msi.h |  23 ++++
 7 files changed, 189 insertions(+)
 create mode 100644 drivers/soc/ti/ti_sci_inta_msi.c
 create mode 100644 include/linux/soc/ti/ti_sci_inta_msi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 055467fb2019..96159e502e6c 100644
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
index 000000000000..0eb9462f609e
--- /dev/null
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator MSI bus
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
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
+static void ti_sci_inta_msi_update_chip_ops(struct msi_domain_info *info)
+{
+	struct irq_chip *chip = info->chip;
+
+	if (WARN_ON(!chip))
+		return;
+
+	chip->irq_request_resources = irq_chip_request_resources_parent;
+	chip->irq_release_resources = irq_chip_release_resources_parent;
+	chip->irq_compose_msi_msg = ti_sci_inta_msi_compose_msi_msg;
+	chip->irq_write_msi_msg = ti_sci_inta_msi_write_msg;
+	chip->irq_set_type = irq_chip_set_type_parent;
+	chip->irq_unmask = irq_chip_unmask_parent;
+	chip->irq_mask = irq_chip_mask_parent;
+	chip->irq_ack = irq_chip_ack_parent;
+}
+
+struct irq_domain *ti_sci_inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
+						     struct msi_domain_info *info,
+						     struct irq_domain *parent)
+{
+	struct irq_domain *domain;
+
+	ti_sci_inta_msi_update_chip_ops(info);
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
+static int ti_sci_inta_msi_alloc_descs(struct device *dev,
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
+			msi_desc->inta.dev_index = res->desc[set].start + i;
+			INIT_LIST_HEAD(&msi_desc->list);
+			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
+			count++;
+		}
+	}
+
+	return count;
+}
+
+int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
+				      struct ti_sci_resource *res)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct irq_domain *msi_domain;
+	int ret, nvec;
+
+	msi_domain = dev_get_msi_domain(dev);
+	if (!msi_domain)
+		return -EINVAL;
+
+	if (pdev->id < 0)
+		return -ENODEV;
+
+	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
+	if (nvec <= 0)
+		return nvec;
+
+	ret = msi_domain_alloc_irqs(msi_domain, dev, nvec);
+	if (ret) {
+		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
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
+unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, dev)
+		if (desc->inta.dev_index == dev_index)
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
index 7e9b81c3b50d..7c28762851a3 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,14 @@ struct fsl_mc_msi_desc {
 	u16				msi_index;
 };
 
+/**
+ * ti_sci_inta_msi_desc - TISCI based INTA specific msi descriptor data
+ * @dev_index: TISCI device index
+ */
+struct ti_sci_inta_msi_desc {
+	u16	dev_index;
+};
+
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
@@ -68,6 +76,7 @@ struct fsl_mc_msi_desc {
  * @mask_base:	[PCI MSI-X] Mask register base address
  * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
+ * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
 struct msi_desc {
 	/* Shared device/bus type independent data */
@@ -106,6 +115,7 @@ struct msi_desc {
 		 */
 		struct platform_msi_desc platform;
 		struct fsl_mc_msi_desc fsl_mc;
+		struct ti_sci_inta_msi_desc inta;
 	};
 };
 
diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
new file mode 100644
index 000000000000..11fb5048f5f6
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
+int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
+				      struct ti_sci_resource *res);
+unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 index);
+void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
+#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
-- 
2.21.0

