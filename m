Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A9C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DEB20868
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vzgJfbo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbfFJIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:35:39 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:33678 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbfFJIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560155736; x=1591691736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=J2195HWkjPWDOiy35qa4GwVWFbxOSAajwm6A0Z3Kc4E=;
  b=vzgJfbo1G4desNdH8n/h1Q9S//Ihg4fipB26SRaiIm9WVnc4K+OaW0a4
   O86K4BXJcAnWfxBOggx2pESGnV1roR/CgWuarCtl5qpEHsbM9CPUneSlJ
   BO9slB+Gn5tI9lolOedsk6WqjYfl6ifTr48iLHWWhzxtmQVNCnLM1q7V3
   8=;
X-IronPort-AV: E=Sophos;i="5.60,573,1549929600"; 
   d="scan'208";a="804494740"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Jun 2019 08:35:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 611D3A0682;
        Mon, 10 Jun 2019 08:35:31 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:30 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Jun 2019 08:35:21 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>,
        Talel Shenhar <talel@amazon.com>
Subject: [PATCH v4 2/2] irqchip: al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt Controller Driver
Date:   Mon, 10 Jun 2019 11:34:43 +0300
Message-ID: <1560155683-29584-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560155683-29584-1-git-send-email-talel@amazon.com>
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D15UWB004.ant.amazon.com (10.43.161.61) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amazon's Annapurna Labs Fabric Interrupt Controller has 32 inputs.
A FIC (Fabric Interrupt Controller) may be cascaded into another FIC or
directly to the main CPU Interrupt Controller (e.g. GIC).

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 MAINTAINERS                  |   6 +
 drivers/irqchip/Kconfig      |   8 ++
 drivers/irqchip/Makefile     |   1 +
 drivers/irqchip/irq-al-fic.c | 278 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 drivers/irqchip/irq-al-fic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..b4f5255 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1209,6 +1209,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
 
+AMAZON ANNAPURNA LABS FIC DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
+F:	drivers/irqchip/irq-al-fic.c
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will.deacon@arm.com>
 R:	Robin Murphy <robin.murphy@arm.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 51a5ef0..7237892 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -89,6 +89,14 @@ config ALPINE_MSI
 	select PCI_MSI
 	select GENERIC_IRQ_CHIP
 
+config AL_FIC
+	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
+	depends on OF || COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Support Amazon's Annapurna Labs Fabric Interrupt Controller.
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 794c13d..a20eba5 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
+obj-$(CONFIG_AL_FIC)			+= irq-al-fic.o
 obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
new file mode 100644
index 0000000..1a57cee
--- /dev/null
+++ b/drivers/irqchip/irq-al-fic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/* FIC Registers */
+#define AL_FIC_CAUSE		0x00
+#define AL_FIC_MASK		0x10
+#define AL_FIC_CONTROL		0x28
+
+#define CONTROL_TRIGGER_RISING	BIT(3)
+#define CONTROL_MASK_MSI_X	BIT(5)
+
+#define NR_FIC_IRQS 32
+
+MODULE_AUTHOR("Talel Shenhar");
+MODULE_DESCRIPTION("Amazon's Annapurna Labs Interrupt Controller Driver");
+MODULE_LICENSE("GPL v2");
+
+enum al_fic_state {
+	AL_FIC_UNCONFIGURED = 0,
+	AL_FIC_CONFIGURED_LEVEL,
+	AL_FIC_CONFIGURED_RISING_EDGE,
+};
+
+struct al_fic {
+	void __iomem *base;
+	struct irq_domain *domain;
+	const char *name;
+	unsigned int parent_irq;
+	enum al_fic_state state;
+};
+
+static void al_fic_set_trigger(struct al_fic *fic,
+			       struct irq_chip_generic *gc,
+			       enum al_fic_state new_state)
+{
+	irq_flow_handler_t handler;
+	u32 control = readl_relaxed(fic->base + AL_FIC_CONTROL);
+
+	if (new_state == AL_FIC_CONFIGURED_LEVEL) {
+		handler = handle_level_irq;
+		control &= ~CONTROL_TRIGGER_RISING;
+	} else {
+		handler = handle_edge_irq;
+		control |= CONTROL_TRIGGER_RISING;
+	}
+	gc->chip_types->handler = handler;
+	fic->state = new_state;
+	writel_relaxed(control, fic->base + AL_FIC_CONTROL);
+}
+
+static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct al_fic *fic = gc->private;
+	enum al_fic_state new_state;
+	int ret = 0;
+
+	irq_gc_lock(gc);
+
+	if (((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_HIGH) &&
+	    ((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_EDGE_RISING)) {
+		pr_debug("fic doesn't support flow type %d\n", flow_type);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	new_state = (flow_type & IRQ_TYPE_LEVEL_HIGH) ?
+		AL_FIC_CONFIGURED_LEVEL : AL_FIC_CONFIGURED_RISING_EDGE;
+
+	/*
+	 * A given FIC instance can be either all level or all edge triggered.
+	 * This is generally fixed depending on what pieces of HW it's wired up
+	 * to.
+	 *
+	 * We configure it based on the sensitivity of the first source
+	 * being setup, and reject any subsequent attempt at configuring it in a
+	 * different way.
+	 */
+	if (fic->state == AL_FIC_UNCONFIGURED) {
+		al_fic_set_trigger(fic, gc, new_state);
+	} else if (fic->state != new_state) {
+		pr_debug("fic %s state already configured to %d\n",
+			 fic->name, fic->state);
+		ret = -EINVAL;
+		goto err;
+	}
+
+err:
+	irq_gc_unlock(gc);
+
+	return ret;
+}
+
+static void al_fic_irq_handler(struct irq_desc *desc)
+{
+	struct al_fic *fic = irq_desc_get_handler_data(desc);
+	struct irq_domain *domain = fic->domain;
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
+	unsigned long pending;
+	unsigned int irq;
+	u32 hwirq;
+
+	chained_irq_enter(irqchip, desc);
+
+	pending = readl_relaxed(fic->base + AL_FIC_CAUSE);
+	pending &= ~gc->mask_cache;
+
+	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS) {
+		irq = irq_find_mapping(domain, hwirq);
+		generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static int al_fic_register(struct device_node *node,
+			   struct al_fic *fic)
+{
+	struct irq_chip_generic *gc;
+	int ret;
+
+	fic->domain = irq_domain_add_linear(node,
+					    NR_FIC_IRQS,
+					    &irq_generic_chip_ops,
+					    fic);
+	if (!fic->domain) {
+		pr_err("fail to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(fic->domain,
+					     NR_FIC_IRQS,
+					     1, fic->name,
+					     handle_level_irq,
+					     0, 0, IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		pr_err("fail to allocate generic chip (%d)\n", ret);
+		goto err_domain_remove;
+	}
+
+	gc = irq_get_domain_generic_chip(fic->domain, 0);
+	gc->reg_base = fic->base;
+	gc->chip_types->regs.mask = AL_FIC_MASK;
+	gc->chip_types->regs.ack = AL_FIC_CAUSE;
+	gc->chip_types->chip.irq_mask = irq_gc_mask_set_bit;
+	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
+	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
+	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
+	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
+	gc->private = fic;
+
+	irq_set_chained_handler_and_data(fic->parent_irq,
+					 al_fic_irq_handler,
+					 fic);
+	return 0;
+
+err_domain_remove:
+	irq_domain_remove(fic->domain);
+
+	return ret;
+}
+
+/*
+ * al_fic_wire_init() - initialize and configure fic in wire mode
+ * @of_node: optional pointer to interrupt controller's device tree node.
+ * @base: mmio to fic register
+ * @name: name of the fic
+ * @parent_irq: interrupt of parent
+ *
+ * This API will configure the fic hardware to to work in wire mode.
+ * In wire mode, fic hardware is generating a wire ("wired") interrupt.
+ * Interrupt can be generated based on positive edge or level - configuration is
+ * to be determined based on connected hardware to this fic.
+ */
+static struct al_fic *al_fic_wire_init(struct device_node *node,
+				       void __iomem *base,
+				       const char *name,
+				       unsigned int parent_irq)
+{
+	struct al_fic *fic;
+	int ret;
+	u32 control = CONTROL_MASK_MSI_X;
+
+	fic = kzalloc(sizeof(*fic), GFP_KERNEL);
+	if (!fic)
+		return ERR_PTR(-ENOMEM);
+
+	fic->base = base;
+	fic->parent_irq = parent_irq;
+	fic->name = name;
+
+	/* mask out all interrupts */
+	writel_relaxed(0xFFFFFFFF, fic->base + AL_FIC_MASK);
+
+	/* clear any pending interrupt */
+	writel_relaxed(0, fic->base + AL_FIC_CAUSE);
+
+	writel_relaxed(control, fic->base + AL_FIC_CONTROL);
+
+	ret = al_fic_register(node, fic);
+	if (ret) {
+		pr_err("fail to register irqchip\n");
+		goto err_free;
+	}
+
+	pr_debug("%s initialized successfully in Legacy mode (parent-irq=%u)\n",
+		 fic->name, parent_irq);
+
+	return fic;
+
+err_free:
+	kfree(fic);
+	return ERR_PTR(ret);
+}
+
+static int __init al_fic_init_dt(struct device_node *node,
+				 struct device_node *parent)
+{
+	int ret;
+	void __iomem *base;
+	unsigned int parent_irq;
+	struct al_fic *fic;
+
+	if (!parent) {
+		pr_err("%s: unsupported - device require a parent\n",
+		       node->name);
+		return -EINVAL;
+	}
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: fail to map memory\n", node->name);
+		return -ENOMEM;
+	}
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("%s: fail to map irq\n", node->name);
+		ret = -EINVAL;
+		goto err_unmap;
+	}
+
+	fic = al_fic_wire_init(node,
+			       base,
+			       node->name,
+			       parent_irq);
+	if (IS_ERR(fic)) {
+		pr_err("%s: fail to initialize irqchip (%lu)\n",
+		       node->name,
+		       PTR_ERR(fic));
+		ret = PTR_ERR(fic);
+		goto err_irq_dispose;
+	}
+
+	return 0;
+
+err_irq_dispose:
+	irq_dispose_mapping(parent_irq);
+err_unmap:
+	iounmap(base);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(al_fic, "amazon,al-fic", al_fic_init_dt);
-- 
2.7.4

