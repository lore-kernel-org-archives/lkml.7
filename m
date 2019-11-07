Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12689C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACFE21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="C3AscfCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfKGMVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:21:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45258 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbfKGMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:21:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so1413236lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1mxuXjxfCqQhp+uBh7WWSAYhYziJmfNPt1DYeMchE8=;
        b=C3AscfCWJv3rBaYzemuteNZAfpK/qdRtL7Ka7AITp8CNsLTVUi4AMOcJ39lBxD4nhx
         qpZrBV3fw4mqHkWfkjqkPpQ+KHjyk++ADont5M88CeHSaHMr+7S600zfcPKFwgzOy932
         PUinddGH7KqhIqcvoS9rYynyBdlD6w+1HaHPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1mxuXjxfCqQhp+uBh7WWSAYhYziJmfNPt1DYeMchE8=;
        b=RyonnrCMKMxUnTuaX9W6Z8ALNb7w7kL9v9weALI7Z2kwLNnxyvT04DDkuOieADI8I5
         WAn4bkJtGl8Ualp11BJnWa3Diig6u1uW7G3pJGDGe9wMCn9e5i6ZG8D1H8QmrhgnbH4/
         WIrQSs0076xqgwazf8QCyuGOtZ9QsY8dJykMm7LijRhLgwpH2lTOkwp/buPKBqgIZNmp
         3vBEP60k1TAftBHiBDDwJ1o2v49/KQx4OFAjAet7TNmonW3MlOQ77IdPjxpHOiZjqYpE
         PTeuUhIq1YVdq7Dqa2GpNXc8PVdvbgkCVX7tK+VcoTfE9IC5qx2arEiIfWjOIiJctop7
         BZGw==
X-Gm-Message-State: APjAAAX37/Ek8F154XFi75BZ6mM/syVlhzA9BUbwWvVD+qpHJYyaTZ4l
        dfeH4bc1aszXJ86g0UMdOC9YKQ==
X-Google-Smtp-Source: APXvYqwmvgtvPO2R7WpZh3KziZ9ZOupco9LlQ/K9Z/OVdEHffhbl9Vuu/PWb9EGgxRFfC+NJScagHw==
X-Received: by 2002:a19:7511:: with SMTP id y17mr2291998lfe.19.1573129281011;
        Thu, 07 Nov 2019 04:21:21 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x1sm1937325lff.90.2019.11.07.04.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 04:21:20 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v7 2/2] irqchip: add support for Layerscape external interrupt lines
Date:   Thu,  7 Nov 2019 13:21:15 +0100
Message-Id: <20191107122115.6244-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A allows inverting the polarity of six interrupt lines
IRQ[0:5] via the scfg_intpcr register, effectively allowing
IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING for those. We just need to
check the type, set the relevant bit in INTPCR accordingly, and fixup
the type argument before calling the GIC's irq_set_type.

In fact, the power-on-reset value of the INTPCR register on the LS1021A
is so that all six lines have their polarity inverted. Hence any
hardware connected to those lines is unusable without this: If the line
is indeed active low, the generic GIC code will reject an irq spec with
IRQ_TYPE_LEVEL_LOW, while if the line is active high, we must obviously
disable the polarity inversion (writing 0 to the relevant bit) before
unmasking the interrupt.

Some other Layerscape SOCs (LS1043A, LS1046A) have a similar feature,
just with a different number of external interrupt lines (and a
different POR value for the INTPCR register). This driver should be
prepared for supporting those by properly filling out the device tree
node. I have the reference manuals for all three boards, but I've only
tested the driver on an LS1021A.

Unfortunately, the Kconfig symbol ARCH_LAYERSCAPE only exists on
arm64, so do as is done for irq-ls-scfg-msi.c: introduce a new symbol
which is set when either ARCH_LAYERSCAPE or SOC_LS1021A is set.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/irqchip/Kconfig         |   4 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-ls-extirq.c | 197 ++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ccbb8973a324..bbb323462912 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -370,6 +370,10 @@ config MVEBU_PIC
 config MVEBU_SEI
         bool
 
+config LS_EXTIRQ
+	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
+	select MFD_SYSCON
+
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 	depends on PCI && PCI_MSI
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index cc7c43932f16..e806dda690ea 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
+obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
new file mode 100644
index 000000000000..4d1179fed77c
--- /dev/null
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "irq-ls-extirq: " fmt
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define MAXIRQ 12
+#define LS1021A_SCFGREVCR 0x200
+
+struct ls_extirq_data {
+	struct regmap		*syscon;
+	u32			intpcr;
+	bool			bit_reverse;
+	u32			nirq;
+	struct irq_fwspec	map[MAXIRQ];
+};
+
+static int
+ls_extirq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct ls_extirq_data *priv = data->chip_data;
+	irq_hw_number_t hwirq = data->hwirq;
+	u32 value, mask;
+
+	if (priv->bit_reverse)
+		mask = 1U << (31 - hwirq);
+	else
+		mask = 1U << hwirq;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		value = mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		value = mask;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_EDGE_RISING:
+		value = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip ls_extirq_chip = {
+	.name			= "ls-extirq",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= ls_extirq_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int
+ls_extirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+		       unsigned int nr_irqs, void *arg)
+{
+	struct ls_extirq_data *priv = domain->host_data;
+	struct irq_fwspec *fwspec = arg;
+	irq_hw_number_t hwirq;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= priv->nirq)
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &ls_extirq_chip,
+				      priv);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &priv->map[hwirq]);
+}
+
+static const struct irq_domain_ops extirq_domain_ops = {
+	.xlate		= irq_domain_xlate_twocell,
+	.alloc		= ls_extirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int
+ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
+{
+	const __be32 *map;
+	u32 mapsize;
+	int ret;
+
+	map = of_get_property(node, "interrupt-map", &mapsize);
+	if (!map)
+		return -ENOENT;
+	if (mapsize % sizeof(*map))
+		return -EINVAL;
+	mapsize /= sizeof(*map);
+
+	while (mapsize) {
+		struct device_node *ipar;
+		u32 hwirq, intsize, j;
+
+		if (mapsize < 3)
+			return -EINVAL;
+		hwirq = be32_to_cpup(map);
+		if (hwirq >= MAXIRQ)
+			return -EINVAL;
+		priv->nirq = max(priv->nirq, hwirq + 1);
+
+		ipar = of_find_node_by_phandle(be32_to_cpup(map + 2));
+		map += 3;
+		mapsize -= 3;
+		if (!ipar)
+			return -EINVAL;
+		priv->map[hwirq].fwnode = &ipar->fwnode;
+		ret = of_property_read_u32(ipar, "#interrupt-cells", &intsize);
+		if (ret)
+			return ret;
+
+		if (intsize > mapsize)
+			return -EINVAL;
+
+		priv->map[hwirq].param_count = intsize;
+		for (j = 0; j < intsize; ++j)
+			priv->map[hwirq].param[j] = be32_to_cpup(map++);
+		mapsize -= intsize;
+	}
+	return 0;
+}
+
+static int __init
+ls_extirq_of_init(struct device_node *node, struct device_node *parent)
+{
+
+	struct irq_domain *domain, *parent_domain;
+	struct ls_extirq_data *priv;
+	int ret;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Cannot find parent domain\n");
+		return -ENODEV;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->syscon = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(priv->syscon)) {
+		ret = PTR_ERR(priv->syscon);
+		pr_err("Failed to lookup parent regmap\n");
+		goto out;
+	}
+	ret = of_property_read_u32(node, "reg", &priv->intpcr);
+	if (ret) {
+		pr_err("Missing INTPCR offset value\n");
+		goto out;
+	}
+
+	ret = ls_extirq_parse_map(priv, node);
+	if (ret)
+		goto out;
+
+	if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
+		u32 revcr;
+
+		ret = regmap_read(priv->syscon, LS1021A_SCFGREVCR, &revcr);
+		if (ret)
+			goto out;
+		priv->bit_reverse = (revcr != 0);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
+					  &extirq_domain_ops, priv);
+	if (!domain)
+		ret = -ENOMEM;
+
+out:
+	if (ret)
+		kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
-- 
2.23.0

