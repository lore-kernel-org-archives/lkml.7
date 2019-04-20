Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C0C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD7B20675
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="duzDVshG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfDTKL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfDTKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KABCa7008024;
        Sat, 20 Apr 2019 05:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755072;
        bh=Jpngi4N4aX3vdHghHWz4EFEkrE/KOFJZOxjWb2uuxGU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=duzDVshGcxwTDwQe5bnJ62RBivrf4ML9m1/3xfHFc02jd2I+wE418n/nsNBfaBtag
         sMH79NmbFe4xFC2gPmnF5FnCooTB03kJ6yz6TRAEGnb0gbkaxQcalJu70ZeMOphzMd
         HX6KTBTgeaNoZN5bZv6P3CqWBAGe2IsGIRzb8cAA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KABCGS029262
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:11:12 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:11:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:11:12 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHa2070234;
        Sat, 20 Apr 2019 05:11:08 -0500
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
Subject: [PATCH v7 11/14] irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
Date:   Sat, 20 Apr 2019 15:39:47 +0530
Message-ID: <20190420100950.7997-12-lokeshvutla@ti.com>
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

Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
which is an interrupt controller that does the following:
- Converts events to interrupts that can be understood by
  an interrupt router.
- Allows for multiplexing of events to interrupts.

Configuration of the interrupt aggregator registers can only be done by
a system co-processor and the driver needs to send a message to this
co processor over TISCI protocol. This patch adds support for Interrupt
Aggregator irqdomain.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v6:
- Updated commit message.
- Arranged header files in alphabetical order
- Included vint_bit in struct ti_sci_inta_event_desc
- With the above change now the chip_data is event_desc instead of vint_desc
- No loops are used in atomic contexts.
- Fixed locking issue while freeing parent virq
- Fixed few other cosmetic changes.

 MAINTAINERS                       |   1 +
 drivers/irqchip/Kconfig           |  11 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-ti-sci-inta.c | 589 ++++++++++++++++++++++++++++++
 4 files changed, 602 insertions(+)
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 461db0a8233f..055467fb2019 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15352,6 +15352,7 @@ F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
+F:	drivers/irqchip/irq-ti-sci-inta.c
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4f84e7902626..7c84a71bcd88 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -436,6 +436,17 @@ config TI_SCI_INTR_IRQCHIP
 	  If you wish to use interrupt router irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
+config TI_SCI_INTA_IRQCHIP
+	bool
+	depends on TI_SCI_PROTOCOL
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables the irqchip driver support for K3 Interrupt aggregator
+	  over TI System Control Interface available on some new TI's SoCs.
+	  If you wish to use interrupt aggregator irq resources managed by the
+	  TI System Controller, say Y here. Otherwise, say N.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index fa5c865788b5..8a33013da953 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -98,3 +98,4 @@ obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
+obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
new file mode 100644
index 000000000000..71e5b45ab4ce
--- /dev/null
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments' K3 Interrupt Aggregator irqchip driver
+ *
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Lokesh Vutla <lokeshvutla@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <asm-generic/msi.h>
+
+#define TI_SCI_DEV_ID_MASK	0xffff
+#define TI_SCI_DEV_ID_SHIFT	16
+#define TI_SCI_IRQ_ID_MASK	0xffff
+#define TI_SCI_IRQ_ID_SHIFT	0
+#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
+				 (TI_SCI_DEV_ID_MASK))
+#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
+
+#define MAX_EVENTS_PER_VINT	64
+#define VINT_ENABLE_SET_OFFSET	0x0
+#define VINT_ENABLE_CLR_OFFSET	0x8
+#define VINT_STATUS_OFFSET	0x18
+
+/**
+ * struct ti_sci_inta_event_desc - Description of an event coming to
+ *				   Interrupt Aggregator. This serves
+ *				   as a mapping table for global event,
+ *				   hwirq and vint bit.
+ * @global_event:	Global event number corresponding to this event
+ * @hwirq:		Hwirq of the incoming interrupt
+ * @vint_bit:		Corresponding vint bit to which this event is attached.
+ */
+struct ti_sci_inta_event_desc {
+	u16 global_event;
+	u32 hwirq;
+	u8 vint_bit;
+};
+
+/**
+ * struct ti_sci_inta_vint_desc - Description of a virtual interrupt coming out
+ *				  of Interrupt Aggregator.
+ * @domain:		Pointer to IRQ domain to which this vint belongs.
+ * @list:		List entry for the vint list
+ * @event_map:		Bitmap to manage the allocation of events to vint.
+ * @event_mutex:	Mutex to protect allocation of events.
+ * @events:		Array of event descriptors assigned to this vint.
+ * @parent_virq:	Linux IRQ number that gets attached to parent
+ * @vint_id:		TISCI vint ID
+ */
+struct ti_sci_inta_vint_desc {
+	struct irq_domain *domain;
+	struct list_head list;
+	DECLARE_BITMAP(event_map, MAX_EVENTS_PER_VINT);
+	/* Mutex to protect allocation of events */
+	struct mutex event_mutex;
+	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
+	unsigned int parent_virq;
+	u16 vint_id;
+};
+
+/**
+ * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
+ *				   Interrupt Aggregator IRQ domain.
+ * @sci:		Pointer to TISCI handle
+ * @vint:		TISCI resource pointer representing IA inerrupts.
+ * @global_event:	TISCI resource pointer representing global events.
+ * @vint_list:		List of the vints active in the system
+ * @vint_mutex:		Mutex to protect vint_list
+ * @base:		Base address of the memory mapped IO registers
+ * @pdev:		Pointer to platform device.
+ */
+struct ti_sci_inta_irq_domain {
+	const struct ti_sci_handle *sci;
+	struct ti_sci_resource *vint;
+	struct ti_sci_resource *global_event;
+	struct list_head vint_list;
+	/* Mutex to protect vint list */
+	struct mutex vint_mutex;
+	void __iomem *base;
+	struct platform_device *pdev;
+};
+
+#define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
+					events[i])
+
+/**
+ * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
+ * @desc:	Pointer to irq_desc corresponding to the irq
+ */
+static void ti_sci_inta_irq_handler(struct irq_desc *desc)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+	struct irq_domain *domain;
+	unsigned int virq, bit;
+	unsigned long val;
+
+	vint_desc = irq_desc_get_handler_data(desc);
+	domain = vint_desc->domain;
+	inta = domain->host_data;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
+			    VINT_STATUS_OFFSET);
+
+	for_each_set_bit(bit, &val, MAX_EVENTS_PER_VINT) {
+		virq = irq_find_mapping(domain, vint_desc->events[bit].hwirq);
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+/**
+ * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
+ * @domain:	IRQ domain corresponding to Interrupt Aggregator
+ *
+ * Return 0 if all went well else corresponding error value.
+ */
+static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_domain *domain)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_fwspec parent_fwspec;
+	unsigned int parent_virq;
+	u16 vint_id;
+
+	vint_id = ti_sci_get_free_resource(inta->vint);
+	if (vint_id == TI_SCI_RESOURCE_NULL)
+		return ERR_PTR(-EINVAL);
+
+	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
+	if (!vint_desc)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&vint_desc->event_mutex);
+
+	vint_desc->domain = domain;
+	vint_desc->vint_id = vint_id;
+	INIT_LIST_HEAD(&vint_desc->list);
+
+	parent_fwspec.fwnode = of_node_to_fwnode(of_irq_find_parent(dev_of_node(&inta->pdev->dev)));
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = inta->pdev->id;
+	parent_fwspec.param[1] = vint_desc->vint_id;
+	parent_fwspec.param[2] = 1;
+
+	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
+	if (parent_virq <= 0) {
+		kfree(vint_desc);
+		return ERR_PTR(parent_virq);
+	}
+	vint_desc->parent_virq = parent_virq;
+
+	mutex_lock(&inta->vint_mutex);
+	list_add_tail(&vint_desc->list, &inta->vint_list);
+	mutex_unlock(&inta->vint_mutex);
+
+	irq_set_chained_handler_and_data(vint_desc->parent_virq,
+					 ti_sci_inta_irq_handler, vint_desc);
+
+	return vint_desc;
+}
+
+/**
+ * ti_sci_inta_alloc_event() - Attach an event to a IA vint.
+ * @vint_desc:	Pointer to vint_desc to which the event gets attached
+ * @free_bit:	Bit inside vint to which event gets attached
+ * @hwirq:	hwirq of the input event
+ *
+ * Return event_desc pointer if all went ok else appropriate error value.
+ */
+static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta_vint_desc *vint_desc,
+							      u16 free_bit,
+							      u32 hwirq)
+{
+	struct ti_sci_inta_irq_domain *inta = vint_desc->domain->host_data;
+	struct ti_sci_inta_event_desc *event_desc;
+	u16 dev_id, dev_index;
+	int err;
+
+	dev_id = HWIRQ_TO_DEVID(hwirq);
+	dev_index = HWIRQ_TO_IRQID(hwirq);
+
+	mutex_lock(&vint_desc->event_mutex);
+	event_desc = &vint_desc->events[free_bit];
+	event_desc->hwirq = hwirq;
+	event_desc->vint_bit = free_bit;
+	event_desc->global_event = ti_sci_get_free_resource(inta->global_event);
+	if (event_desc->global_event == TI_SCI_RESOURCE_NULL) {
+		err = -EINVAL;
+		goto free_vint_bit;
+	}
+
+	err = inta->sci->ops.rm_irq_ops.set_event_map(inta->sci,
+						      dev_id, dev_index,
+						      inta->pdev->id,
+						      vint_desc->vint_id,
+						      event_desc->global_event,
+						      free_bit);
+	if (err)
+		goto free_global_event;
+
+	mutex_unlock(&vint_desc->event_mutex);
+	return event_desc;
+free_global_event:
+	ti_sci_release_resource(inta->global_event, event_desc->global_event);
+free_vint_bit:
+	clear_bit(free_bit, vint_desc->event_map);
+	mutex_unlock(&vint_desc->event_mutex);
+	return ERR_PTR(err);
+}
+
+/**
+ * ti_sci_inta_alloc_irq() -  Allocate an irq within INTA domain
+ * @domain:	irq_domain pointer corresponding to INTA
+ * @hwirq:	hwirq of the input event
+ *
+ * Note: Allocation happens in the following manner:
+ *	- Find a free bit available in any of the vints available in the list.
+ *	- If not found, allocate a vint from the vint pool
+ *	- Attach the free bit to input hwirq.
+ * Return event_desc if all went ok else appropriate error value.
+ */
+static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *domain,
+							    u32 hwirq)
+{
+	struct ti_sci_inta_irq_domain *inta = domain->host_data;
+	struct ti_sci_inta_vint_desc *vint_desc = NULL;
+	u16 free_bit;
+
+	mutex_lock(&inta->vint_mutex);
+	list_for_each_entry(vint_desc, &inta->vint_list, list) {
+		mutex_lock(&vint_desc->event_mutex);
+		free_bit = find_first_zero_bit(vint_desc->event_map,
+					       MAX_EVENTS_PER_VINT);
+		if (free_bit != MAX_EVENTS_PER_VINT) {
+			set_bit(free_bit, vint_desc->event_map);
+			mutex_unlock(&vint_desc->event_mutex);
+			mutex_unlock(&inta->vint_mutex);
+			goto alloc_event;
+		}
+		mutex_unlock(&vint_desc->event_mutex);
+	}
+	mutex_unlock(&inta->vint_mutex);
+
+	/* No free bits available. Allocate a new vint */
+	vint_desc = ti_sci_inta_alloc_parent_irq(domain);
+	if (IS_ERR(vint_desc))
+		return ERR_PTR(PTR_ERR(vint_desc));
+
+	mutex_lock(&vint_desc->event_mutex);
+	free_bit = find_first_zero_bit(vint_desc->event_map,
+				       MAX_EVENTS_PER_VINT);
+	set_bit(free_bit, vint_desc->event_map);
+	mutex_unlock(&vint_desc->event_mutex);
+
+alloc_event:
+	return ti_sci_inta_alloc_event(vint_desc, free_bit, hwirq);
+}
+
+/**
+ * ti_sci_inta_free_parent_irq() - Free a parent irq to INTA
+ * @inta:	Pointer to inta domain.
+ * @vint_desc:	Pointer to vint_desc that needs to be freed.
+ */
+static void ti_sci_inta_free_parent_irq(struct ti_sci_inta_irq_domain *inta,
+					struct ti_sci_inta_vint_desc *vint_desc)
+{
+	mutex_lock(&inta->vint_mutex);
+	mutex_lock(&vint_desc->event_mutex);
+	if (find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT) == MAX_EVENTS_PER_VINT) {
+		list_del(&vint_desc->list);
+		mutex_unlock(&vint_desc->event_mutex);
+		mutex_unlock(&inta->vint_mutex);
+		ti_sci_release_resource(inta->vint, vint_desc->vint_id);
+		irq_dispose_mapping(vint_desc->parent_virq);
+		kfree(vint_desc);
+		return;
+	}
+	mutex_unlock(&vint_desc->event_mutex);
+	mutex_unlock(&inta->vint_mutex);
+}
+
+/**
+ * ti_sci_inta_free_irq() - Free an IRQ within INTA domain
+ * @event_desc:	Pointer to event_desc that needs to be freed.
+ * @hwirq:	Hwirq number within INTA domain that needs to be freed
+ */
+static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
+				 u32 hwirq)
+{
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+
+	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
+	inta = vint_desc->domain->host_data;
+	/* free event irq */
+	mutex_lock(&vint_desc->event_mutex);
+	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
+						 HWIRQ_TO_DEVID(hwirq),
+						 HWIRQ_TO_IRQID(hwirq),
+						 inta->pdev->id,
+						 vint_desc->vint_id,
+						 event_desc->global_event,
+						 event_desc->vint_bit);
+
+	clear_bit(event_desc->vint_bit, vint_desc->event_map);
+	ti_sci_release_resource(inta->global_event, event_desc->global_event);
+	event_desc->global_event = TI_SCI_RESOURCE_NULL;
+	event_desc->hwirq = 0;
+	mutex_unlock(&vint_desc->event_mutex);
+
+	ti_sci_inta_free_parent_irq(inta, vint_desc);
+}
+
+/**
+ * ti_sci_inta_request_resources() - Allocate resources for input irq
+ * @data: Pointer to corresponding irq_data
+ *
+ * Note: This is the core api where the actual allocation happens for input
+ *	 hwirq. This allocation involves creating a parent irq for vint.
+ *	 If this is done in irq_domain_ops.alloc() then a deadlock is reached
+ *	 for allocation. So this allocation is being done in request_resources()
+ *
+ * Return: 0 if all went well else corresponding error.
+ */
+static int ti_sci_inta_request_resources(struct irq_data *data)
+{
+	struct ti_sci_inta_event_desc *event_desc;
+
+	event_desc = ti_sci_inta_alloc_irq(data->domain, data->hwirq);
+	if (IS_ERR(event_desc))
+		return PTR_ERR(event_desc);
+
+	data->chip_data = event_desc;
+
+	return 0;
+}
+
+/**
+ * ti_sci_inta_release_resources - Release resources for input irq
+ * @data: Pointer to corresponding irq_data
+ *
+ * Note: Corresponding to request_resources(), all the unmapping and deletion
+ *	 of parent vint irqs happens in this api.
+ */
+static void ti_sci_inta_release_resources(struct irq_data *data)
+{
+	struct ti_sci_inta_event_desc *event_desc;
+
+	event_desc = irq_data_get_irq_chip_data(data);
+	ti_sci_inta_free_irq(event_desc, data->hwirq);
+}
+
+/**
+ * ti_sci_inta_manage_event() - Control the event based on the offset
+ * @data:	Pointer to corresponding irq_data
+ * @offset:	register offset using which event is controlled.
+ */
+static void ti_sci_inta_manage_event(struct irq_data *data, u32 offset)
+{
+	struct ti_sci_inta_event_desc *event_desc;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct ti_sci_inta_irq_domain *inta;
+
+	event_desc = irq_data_get_irq_chip_data(data);
+	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
+	inta = data->domain->host_data;
+
+	writeq_relaxed(BIT(event_desc->vint_bit),
+		       inta->base + vint_desc->vint_id * 0x1000 + offset);
+}
+
+/**
+ * ti_sci_inta_mask_irq() - Mask an event
+ * @data:	Pointer to corresponding irq_data
+ */
+static void ti_sci_inta_mask_irq(struct irq_data *data)
+{
+	ti_sci_inta_manage_event(data, VINT_ENABLE_CLR_OFFSET);
+}
+
+/**
+ * ti_sci_inta_unmask_irq() - Unmask an event
+ * @data:	Pointer to corresponding irq_data
+ */
+static void ti_sci_inta_unmask_irq(struct irq_data *data)
+{
+	ti_sci_inta_manage_event(data, VINT_ENABLE_SET_OFFSET);
+}
+
+/**
+ * ti_sci_inta_ack_irq() - Ack an event
+ * @data:	Pointer to corresponding irq_data
+ */
+static void ti_sci_inta_ack_irq(struct irq_data *data)
+{
+	ti_sci_inta_manage_event(data, VINT_STATUS_OFFSET);
+}
+
+static int ti_sci_inta_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask_val, bool force)
+{
+	return -EINVAL;
+}
+
+/**
+ * ti_sci_inta_set_type() - Update the trigger type of the irq.
+ * @data:	Pointer to corresponding irq_data
+ * @type:	Trigger type as specified by user
+ *
+ * Note: This updates the handle_irq callback for level msi.
+ *
+ * Return 0 if all went well else appropriate error.
+ */
+static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_desc *desc = irq_to_desc(data->irq);
+
+	/*
+	 * .alloc default sets handle_edge_irq. But if the user specifies
+	 * that IRQ is level MSI, then update the handle to handle_level_irq
+	 */
+	if (type & IRQF_TRIGGER_HIGH)
+		desc->handle_irq = handle_level_irq;
+
+	return 0;
+}
+
+static struct irq_chip ti_sci_inta_irq_chip = {
+	.name			= "INTA",
+	.irq_ack		= ti_sci_inta_ack_irq,
+	.irq_mask		= ti_sci_inta_mask_irq,
+	.irq_set_type		= ti_sci_inta_set_type,
+	.irq_unmask		= ti_sci_inta_unmask_irq,
+	.irq_set_affinity	= ti_sci_inta_set_affinity,
+	.irq_request_resources	= ti_sci_inta_request_resources,
+	.irq_release_resources	= ti_sci_inta_release_resources,
+};
+
+/**
+ * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
+ * @domain:	Domain to which the irqs belong
+ * @virq:	base linux virtual IRQ to be freed.
+ * @nr_irqs:	Number of continuous irqs to be freed
+ */
+static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+
+	irq_domain_reset_irq_data(data);
+}
+
+/**
+ * ti_sci_inta_irq_domain_alloc() - Allocate Interrupt aggregator IRQs
+ * @domain:	Point to the interrupt aggregator IRQ domain
+ * @virq:	Corresponding Linux virtual IRQ number
+ * @nr_irqs:	Continuous irqs to be allocated
+ * @data:	Pointer to firmware specifier
+ *
+ * No actual allocation happens here.
+ *
+ * Return 0 if all went well else appropriate error value.
+ */
+static int ti_sci_inta_irq_domain_alloc(struct irq_domain *domain,
+					unsigned int virq, unsigned int nr_irqs,
+					void *data)
+{
+	msi_alloc_info_t *arg = data;
+
+	irq_domain_set_info(domain, virq, arg->hwirq, &ti_sci_inta_irq_chip,
+			    NULL, handle_edge_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
+	.free		= ti_sci_inta_irq_domain_free,
+	.alloc		= ti_sci_inta_irq_domain_alloc,
+};
+
+static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct device_node *parent_node, *node;
+	struct ti_sci_inta_irq_domain *inta;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	node = dev_of_node(dev);
+	parent_node = of_irq_find_parent(node);
+	if (!parent_node) {
+		dev_err(dev, "Failed to get IRQ parent node\n");
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
+	inta = devm_kzalloc(dev, sizeof(*inta), GFP_KERNEL);
+	if (!inta)
+		return -ENOMEM;
+
+	inta->pdev = pdev;
+	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(inta->sci)) {
+		ret = PTR_ERR(inta->sci);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "ti,sci read fail %d\n", ret);
+		inta->sci = NULL;
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &pdev->id);
+	if (ret) {
+		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
+		return -EINVAL;
+	}
+
+	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
+						 "ti,sci-rm-range-vint");
+	if (IS_ERR(inta->vint)) {
+		dev_err(dev, "VINT resource allocation failed\n");
+		return PTR_ERR(inta->vint);
+	}
+
+	inta->global_event = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
+						"ti,sci-rm-range-global-event");
+	if (IS_ERR(inta->global_event)) {
+		dev_err(dev, "Global event resource allocation failed\n");
+		return PTR_ERR(inta->global_event);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	inta->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(inta->base))
+		return -ENODEV;
+
+	domain = irq_domain_add_linear(dev_of_node(dev),
+				       ti_sci_get_num_resources(inta->vint),
+				       &ti_sci_inta_irq_domain_ops, inta);
+	if (!domain) {
+		dev_err(dev, "Failed to allocate IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&inta->vint_list);
+	mutex_init(&inta->vint_mutex);
+
+	return 0;
+}
+
+static const struct of_device_id ti_sci_inta_irq_domain_of_match[] = {
+	{ .compatible = "ti,sci-inta", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ti_sci_inta_irq_domain_of_match);
+
+static struct platform_driver ti_sci_inta_irq_domain_driver = {
+	.probe = ti_sci_inta_irq_domain_probe,
+	.driver = {
+		.name = "ti-sci-inta",
+		.of_match_table = ti_sci_inta_irq_domain_of_match,
+	},
+};
+module_platform_driver(ti_sci_inta_irq_domain_driver);
+
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
+MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

