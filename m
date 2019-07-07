Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD1AC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFC3206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4g+ILO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGGNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:23:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44766 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:23:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so3075642wrf.11;
        Sun, 07 Jul 2019 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=LyYBGxHT/004Saj+ocWmEaZSx8BFQAFIp/D2dJigCMs=;
        b=S4g+ILO3vrb41nkdmpbVyAsZwBAepFd5CaMZ+oHkyGeeFkNsUXw15F1VMh7SiOTsPt
         rtPDj7CYLRs5DWG3bthqoma6fG5zDSqq5OwbBvw4e/T3PoeuxcpEUKwMZJnsLLTR+BGt
         CA9Kc13sPgOCIJUlrZjRsvWplvzwvMUD4u7gJO+R/ZYcTqe3KH1UmT03prdfrE7le2Z+
         o+XYqnJVqr42mcnQJynRGm88kR3Q3qA+N47UCLxm/ROhcyUeMA4XuhYnQGiGoDHGGDq6
         5468/8Hqwo8hrzq07JEGaYirAM4zmYk3JujrneVY4UGXpGAAZ9S5mlaaC1Pwvh9gkl1e
         aXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=LyYBGxHT/004Saj+ocWmEaZSx8BFQAFIp/D2dJigCMs=;
        b=czql19GPcRxfRF1UC3WWHwJvTK9dAbpd9Ds47t9p9XVDCVg6VKnnsSTyUsHuJ2IQhE
         B+j2POaC2rxxQTY33fimhgW3EX0WzCDjqfuF4X8WiD7vo7fuSuXNOHvARepdIgEQehoY
         GNHOZPtsqjTmWsnuwREfZ3FKs5SNpfGH0LPVCR7wh2R6pA2bLNZxvOGjS12iH43X/s/r
         ZtCtginBAuyuXyeuuXYCXOZ3tNBNGjnknO5dHzEHQ1titm+TptrLgVqJjr8LKW3U1iun
         rmOCtA7C9PBu16G62KBqvow5I386oz1oD9JxE/N4b9JP0RYX6ndXDefE6Ev0Yt4APbJu
         FwCQ==
X-Gm-Message-State: APjAAAWomRY50fGZtIq2stL6xkiEOGZUfLRxrzK4qTRJp4qspMnzlShF
        iXvpWbncqo9dY3f2TgQKPf5H4zz8xzA=
X-Google-Smtp-Source: APXvYqx9Zj8jXvvLZLBwd2T+QW2bgwFqamzJnEhZf5zfb1Y8O81ATciuWDlaUFw3WGah9U53AWIkIg==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr14191207wrk.121.1562505780290;
        Sun, 07 Jul 2019 06:23:00 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id a12sm13653386wrr.70.2019.07.07.06.22.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:22:59 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:22:56 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] irqchip: Add Realtek RTD129x intc driver
Message-ID: <20190707132256.GC13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for the RTD1296 and RTD1295 interrupt
controller (intc). It is based on both the BPI-SINOVOIP project and
Andreas Färber's previous attempt to submit a similar driver.

There is currently no publicly available datasheet on this SoC and the
exact behaviour of the registers controlling the intc remain uncertain.

This driver controls two intcs: "iso" and "misc". Each intc has its own
Interrupt Enable Register (IER) and Interrupt Status Resgister (ISR).
However, not all "misc" intc irqs have the same offsets for both ISR and
IER. For this reason an ISR to IER offsets table is defined.

The driver catches the IER value to reduce accesses to the table inside the
interrupt handler. Actually, the driver stores the ISR offsets of currently
enabled interrupts in a variable.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 drivers/irqchip/Makefile      |   1 +
 drivers/irqchip/irq-rtd129x.c | 371 ++++++++++++++++++++++++++++++++++
 2 files changed, 372 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtd129x.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 606a003a0000..0689c3956250 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -100,3 +100,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
+obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd129x.o
diff --git a/drivers/irqchip/irq-rtd129x.c b/drivers/irqchip/irq-rtd129x.c
new file mode 100644
index 000000000000..76358ca50f10
--- /dev/null
+++ b/drivers/irqchip/irq-rtd129x.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/irqchip.h>
+#include <linux/bits.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define RTD129X_INTC_NR_IRQS 32
+#define DEV_NAME "RTD1296_INTC"
+
+/*
+ * This interrupt controller (hereinafter intc) driver controls two intcs: "iso"
+ * and "misc". Each intc has its own Interrupt Enable Register (IER) and
+ * Interrupt Status Resgister (ISR). However, not all "misc" intc irqs have the
+ * same offsets for both ISR and IER. For this reason an ISR to IER offsets
+ * table is defined. Also, to reduce accesses to this table in the interrupt
+ * handler, the driver stores the ISR offsets of currently enabled interrupts in
+ * a variable.
+ */
+
+enum misc_int_en {
+	MISC_INT_FAIL		= 0xFF,
+	MISC_INT_RVD		= 0xFE,
+	MISC_INT_EN_FAN		= 29,
+	MISC_INT_EN_I2C3	= 28,
+	MISC_INT_EN_GSPI	= 27,
+	MISC_INT_EN_I2C2	= 26,
+	MISC_INT_EN_SC0		= 24,
+	MISC_INT_EN_LSADC1	= 22,
+	MISC_INT_EN_LSADC0	= 21,
+	MISC_INT_EN_GPIODA	= 20,
+	MISC_INT_EN_GPIOA	= 19,
+	MISC_INT_EN_I2C4	= 15,
+	MISC_INT_EN_I2C5	= 14,
+	MISC_INT_EN_RTC_DATA	= 12,
+	MISC_INT_EN_RTC_HOUR	= 11,
+	MISC_INT_EN_RTC_MIN	= 10,
+	MISC_INT_EN_UR2		= 7,
+	MISC_INT_EN_UR2_TO	= 6,
+	MISC_INT_EN_UR1_TO	= 5,
+	MISC_INT_EN_UR1		= 3,
+};
+
+enum iso_int_en {
+	ISO_INT_FAIL		= 0xFF,
+	ISO_INT_RVD		= 0xFE,
+	ISO_INT_EN_I2C1_REQ	= 31,
+	ISO_INT_EN_GPHY_AV	= 30,
+	ISO_INT_EN_GPHY_DV	= 29,
+	ISO_INT_EN_GPIODA	= 20,
+	ISO_INT_EN_GPIOA	= 19,
+	ISO_INT_EN_RTC_ALARM	= 13,
+	ISO_INT_EN_RTC_HSEC	= 12,
+	ISO_INT_EN_I2C1		= 11,
+	ISO_INT_EN_I2C0		= 8,
+	ISO_INT_EN_IRDA		= 5,
+	ISO_INT_EN_UR0		= 2,
+};
+
+unsigned char rtd129x_intc_enable_map_misc[RTD129X_INTC_NR_IRQS] = {
+	MISC_INT_FAIL,		/* Bit0 */
+	MISC_INT_FAIL,		/* Bit1 */
+	MISC_INT_RVD,		/* Bit2 */
+	MISC_INT_EN_UR1,	/* Bit3 */
+	MISC_INT_FAIL,		/* Bit4 */
+	MISC_INT_EN_UR1_TO,	/* Bit5 */
+	MISC_INT_RVD,		/* Bit6 */
+	MISC_INT_RVD,		/* Bit7 */
+	MISC_INT_EN_UR2,	/* Bit8 */
+	MISC_INT_RVD,		/* Bit9 */
+	MISC_INT_EN_RTC_MIN,	/* Bit10 */
+	MISC_INT_EN_RTC_HOUR,	/* Bit11 */
+	MISC_INT_EN_RTC_DATA,	/* Bit12 */
+	MISC_INT_EN_UR2_TO,	/* Bit13 */
+	MISC_INT_EN_I2C5,	/* Bit14 */
+	MISC_INT_EN_I2C4,	/* Bit15 */
+	MISC_INT_FAIL,		/* Bit16 */
+	MISC_INT_FAIL,		/* Bit17 */
+	MISC_INT_FAIL,		/* Bit18 */
+	MISC_INT_EN_GPIOA,	/* Bit19 */
+	MISC_INT_EN_GPIODA,	/* Bit20 */
+	MISC_INT_EN_LSADC0,	/* Bit21 */
+	MISC_INT_EN_LSADC1,	/* Bit22 */
+	MISC_INT_EN_I2C3,	/* Bit23 */
+	MISC_INT_EN_SC0,	/* Bit24 */
+	MISC_INT_FAIL,		/* Bit25 */
+	MISC_INT_EN_I2C2,	/* Bit26 */
+	MISC_INT_EN_GSPI,	/* Bit27 */
+	MISC_INT_FAIL,		/* Bit28 */
+	MISC_INT_EN_FAN,	/* Bit29 */
+	MISC_INT_FAIL,		/* Bit30 */
+	MISC_INT_FAIL		/* Bit31 */
+};
+
+unsigned char rtd129x_intc_enable_map_iso[RTD129X_INTC_NR_IRQS] = {
+	ISO_INT_FAIL,		/* Bit0 */
+	ISO_INT_RVD,		/* Bit1 */
+	ISO_INT_EN_UR0,		/* Bit2 */
+	ISO_INT_FAIL,		/* Bit3 */
+	ISO_INT_FAIL,		/* Bit4 */
+	ISO_INT_EN_IRDA,	/* Bit5 */
+	ISO_INT_FAIL,		/* Bit6 */
+	ISO_INT_RVD,		/* Bit7 */
+	ISO_INT_EN_I2C0,	/* Bit8 */
+	ISO_INT_RVD,		/* Bit9 */
+	ISO_INT_FAIL,		/* Bit10 */
+	ISO_INT_EN_I2C1,	/* Bit11 */
+	ISO_INT_EN_RTC_HSEC,	/* Bit12 */
+	ISO_INT_EN_RTC_ALARM,	/* Bit13 */
+	ISO_INT_FAIL,		/* Bit14 */
+	ISO_INT_FAIL,		/* Bit15 */
+	ISO_INT_FAIL,		/* Bit16 */
+	ISO_INT_FAIL,		/* Bit17 */
+	ISO_INT_FAIL,		/* Bit18 */
+	ISO_INT_EN_GPIOA,	/* Bit19 */
+	ISO_INT_EN_GPIODA,	/* Bit20 */
+	ISO_INT_RVD,		/* Bit21 */
+	ISO_INT_RVD,		/* Bit22 */
+	ISO_INT_RVD,		/* Bit23 */
+	ISO_INT_RVD,		/* Bit24 */
+	ISO_INT_FAIL,		/* Bit25 */
+	ISO_INT_FAIL,		/* Bit26 */
+	ISO_INT_FAIL,		/* Bit27 */
+	ISO_INT_FAIL,		/* Bit28 */
+	ISO_INT_EN_GPHY_DV,	/* Bit29 */
+	ISO_INT_EN_GPHY_AV,	/* Bit30 */
+	ISO_INT_EN_I2C1_REQ	/* Bit31 */
+};
+
+struct rtd129x_intc_data {
+	void __iomem		*unmask;
+	void __iomem		*isr;
+	void __iomem		*ier;
+	u32			ier_cached;
+	u32			isr_en;
+	raw_spinlock_t		lock;
+	unsigned int		parent_irq;
+	const unsigned char	*en_map;
+};
+
+static struct irq_domain *rtd129x_intc_domain;
+
+static void rtd129x_intc_irq_handle(struct irq_desc *desc)
+{
+	struct rtd129x_intc_data *priv = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int local_irq;
+	u32 status;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	raw_spin_lock(&priv->lock);
+	status = readl_relaxed(priv->isr);
+	status &= priv->isr_en;
+	raw_spin_unlock(&priv->lock);
+
+	while (status) {
+		i = __ffs(status);
+		status &= ~BIT(i);
+
+		local_irq = irq_find_mapping(rtd129x_intc_domain, i);
+		if (likely(local_irq)) {
+			if (!generic_handle_irq(local_irq))
+				writel_relaxed(BIT(i), priv->isr);
+		} else {
+			handle_bad_irq(desc);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd129x_intc_mask(struct irq_data *data)
+{
+	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), priv->isr);
+}
+
+static void rtd129x_intc_unmask(struct irq_data *data)
+{
+	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), priv->unmask);
+}
+
+static void rtd129x_intc_enable(struct irq_data *data)
+{
+	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u8 en_offset;
+
+	en_offset = priv->en_map[data->hwirq];
+
+	if ((en_offset != MISC_INT_RVD) && (en_offset != MISC_INT_FAIL)) {
+		raw_spin_lock_irqsave(&priv->lock, flags);
+
+		priv->isr_en |= BIT(data->hwirq);
+		priv->ier_cached |= BIT(en_offset);
+		writel_relaxed(priv->ier_cached, priv->ier);
+
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
+	} else if (en_offset == MISC_INT_FAIL) {
+		pr_err("[%s] Enable irq(%lu) failed\n", DEV_NAME, data->hwirq);
+	}
+}
+
+static void rtd129x_intc_disable(struct irq_data *data)
+{
+	struct rtd129x_intc_data *priv = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u8 en_offset;
+
+	en_offset = priv->en_map[data->hwirq];
+
+	if ((en_offset != MISC_INT_RVD) && (en_offset != MISC_INT_FAIL)) {
+		raw_spin_lock_irqsave(&priv->lock, flags);
+
+		priv->isr_en &= ~BIT(data->hwirq);
+		priv->ier_cached &= ~BIT(en_offset);
+		writel_relaxed(priv->ier_cached, priv->ier);
+
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
+	} else if (en_offset == MISC_INT_FAIL) {
+		pr_err("[%s] Disable irq(%lu) failed\n", DEV_NAME, data->hwirq);
+	}
+}
+
+static struct irq_chip rtd129x_intc_chip = {
+	.name		= DEV_NAME,
+	.irq_mask	= rtd129x_intc_mask,
+	.irq_unmask	= rtd129x_intc_unmask,
+	.irq_enable	= rtd129x_intc_enable,
+	.irq_disable	= rtd129x_intc_disable,
+};
+
+static int rtd129x_intc_map(struct irq_domain *d, unsigned int virq,
+			    irq_hw_number_t hw_irq)
+{
+	struct rtd129x_intc_data *priv = d->host_data;
+
+	irq_set_chip_and_handler(virq, &rtd129x_intc_chip, handle_level_irq);
+	irq_set_chip_data(virq, priv);
+	irq_set_probe(virq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rtd129x_intc_domain_ops = {
+	.xlate			= irq_domain_xlate_onecell,
+	.map			= rtd129x_intc_map,
+};
+
+static const struct of_device_id rtd129x_intc_matches[] = {
+	{ .compatible = "realtek,rtd129x-intc-misc",
+		.data = rtd129x_intc_enable_map_misc
+	},
+	{ .compatible = "realtek,rtd129x-intc-iso",
+		.data = rtd129x_intc_enable_map_iso
+	},
+	{ }
+};
+
+static int rtd129x_intc_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	struct rtd129x_intc_data *priv;
+	const struct of_device_id *match;
+	u32 isr_tmp, ier_tmp, ier_bit;
+	int ret, i;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	priv->isr = of_iomap(node, 0);
+	if (!priv->isr) {
+		pr_err("unable to obtain status reg iomap address\n");
+		ret = -ENOMEM;
+		goto free_priv;
+	}
+
+	priv->ier = of_iomap(node, 1);
+	if (!priv->ier) {
+		pr_err("unable to obtain enable reg iomap address\n");
+		ret = -ENOMEM;
+		goto iounmap_status;
+	}
+
+	priv->unmask = of_iomap(node, 2);
+	if (!priv->unmask) {
+		pr_err("unable to obtain unmask reg iomap address\n");
+		ret = -ENOMEM;
+		goto iounmap_enable;
+	}
+
+	priv->parent_irq = irq_of_parse_and_map(node, 0);
+	if (!priv->parent_irq) {
+		pr_err("failed to map parent interrupt %d\n", priv->parent_irq);
+		ret = -EINVAL;
+		goto iounmap_all;
+	}
+
+	match = of_match_node(rtd129x_intc_matches, node);
+	if (!match) {
+		pr_err("failed to find matching node\n");
+		ret = -ENODEV;
+		goto iounmap_all;
+	}
+	priv->en_map = match->data;
+
+	// initialize enabled irq's map to its matching status bit in isr by
+	// inverse walking the enable to status offsets map. Only needed for
+	// misc
+	priv->ier_cached = readl_relaxed(priv->ier);
+	if (priv->en_map == rtd129x_intc_enable_map_misc) {
+		ier_tmp = priv->ier_cached;
+		isr_tmp = 0;
+		while (ier_tmp) {
+			ier_bit = __ffs(ier_tmp);
+			ier_tmp &= ~BIT(ier_bit);
+			for (i = 0; i < RTD129X_INTC_NR_IRQS; i++)
+				if (priv->en_map[i] == ier_bit)
+					isr_tmp |= BIT(i);
+		}
+		priv->isr_en = isr_tmp;
+	} else {
+		priv->isr_en = priv->ier_cached;
+	}
+
+	rtd129x_intc_domain = irq_domain_add_linear(node, RTD129X_INTC_NR_IRQS,
+						    &rtd129x_intc_domain_ops,
+						    priv);
+	if (!rtd129x_intc_domain) {
+		pr_err("failed to create irq domain\n");
+		ret = -ENOMEM;
+		goto iounmap_all;
+	}
+
+	irq_set_chained_handler_and_data(priv->parent_irq,
+					 rtd129x_intc_irq_handle, priv);
+
+	return 0;
+
+iounmap_all:
+	iounmap(priv->unmask);
+iounmap_enable:
+	iounmap(priv->ier);
+iounmap_status:
+	iounmap(priv->isr);
+free_priv:
+	kfree(priv);
+err:
+	return ret;
+}
+
+IRQCHIP_DECLARE(rtd129x_intc_misc, "realtek,rtd129x-intc-misc",
+		rtd129x_intc_of_init);
+IRQCHIP_DECLARE(rtd129x_intc_iso, "realtek,rtd129x-intc-iso",
+		rtd129x_intc_of_init);
-- 
2.21.0

