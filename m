Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F94C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122272231C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKSCTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:19:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbfKSCTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:19:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBDB6AE12;
        Tue, 19 Nov 2019 02:19:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
Date:   Tue, 19 Nov 2019 03:19:11 +0100
Message-Id: <20191119021917.15917-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191119021917.15917-1-afaerber@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This irq mux driver implements the RTD1295 SoC's non-linear mapping
between status and enable bits.

Based in part on QNAP's arch/arm/mach-rtk119x/rtk_irq_mux.c and
Synology's drivers/irqchip/irq-rtk.c code.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Cc: Aleix Roca Nonell <kernelrocks@gmail.com>
Signed-off-by: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3 -> v4:
 * Drop no-op .irq_set_affinity callback (Thomas)
 * Clear all interrupts (James)
 * Updated SPDX-License-identifier
 * Use tabular formatting (Thomas)
 * Adopt different braces style (Thomas)
 * Use raw_spinlock_t (Thomas)
 * Shortened callback from isr_to_scpu_int_en_mask to isr_to_int_en_mask (Thomas)
 * Fixed of_iomap() error handling to not use IS_ERR()
 * Don't mask unmapped NMIs by checking for a non-zero mask
 * Cache SCPU_INT_EN to avoid superfluous reads (Thomas)
 * Renamed functions and variables from rtd119x to rtd1195
 
 v2 -> v3:
 * Adopted spin_lock_irq{save,restore}() (Marc)
 * Adopted single-write masking (Marc)
 * Adopted misc compatible string
 * Introduced explicit bit mapping
 * Adopted looped processing of pending interrupts (Marc)
 * Replaced unmask implementation with UMSK_ISR write
 * Introduced enable/disable ops and dropped no longer needed UART0 quirk
 
 v1 -> v2:
 * Renamed struct fields to avoid ambiguity (Marc)
 * Refactored offset lookup to avoid per-compatible init functions
 * Inserted white lines to clarify balanced locking (Marc)
 * Dropped forwarding of set_affinity to GIC (Marc)
 * Added spinlocks for consistency (Marc)
 * Limited initialization quirk to iso mux
 * Fixed spinlock initialization (Andrew)
 
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-rtd1195-mux.c | 283 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100644 drivers/irqchip/irq-rtd1195-mux.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..d678881eebc8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -104,3 +104,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
+obj-$(CONFIG_ARCH_REALTEK)		+= irq-rtd1195-mux.o
diff --git a/drivers/irqchip/irq-rtd1195-mux.c b/drivers/irqchip/irq-rtd1195-mux.c
new file mode 100644
index 000000000000..e6b08438b23c
--- /dev/null
+++ b/drivers/irqchip/irq-rtd1195-mux.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Realtek RTD1295 IRQ mux
+ *
+ * Copyright (c) 2017-2019 Andreas Färber
+ */
+
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+struct rtd1195_irq_mux_info {
+	unsigned int	isr_offset;
+	unsigned int	umsk_isr_offset;
+	unsigned int	scpu_int_en_offset;
+	const u32	*isr_to_int_en_mask;
+};
+
+struct rtd1195_irq_mux_data {
+	void __iomem				*reg_isr;
+	void __iomem				*reg_umsk_isr;
+	void __iomem				*reg_scpu_int_en;
+	const struct rtd1195_irq_mux_info	*info;
+	int					irq;
+	u32					scpu_int_en;
+	struct irq_domain			*domain;
+	raw_spinlock_t				lock;
+};
+
+static void rtd1195_mux_irq_handle(struct irq_desc *desc)
+{
+	struct rtd1195_irq_mux_data *data = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 isr, mask;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	isr = readl_relaxed(data->reg_isr);
+
+	while (isr) {
+		i = __ffs(isr);
+		isr &= ~BIT(i);
+
+		mask = data->info->isr_to_int_en_mask[i];
+		if (mask && !(data->scpu_int_en & mask))
+			continue;
+
+		if (!generic_handle_irq(irq_find_mapping(data->domain, i)))
+			writel_relaxed(BIT(i), data->reg_isr);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void rtd1195_mux_mask_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), mux_data->reg_isr);
+}
+
+static void rtd1195_mux_unmask_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(BIT(data->hwirq), mux_data->reg_umsk_isr);
+}
+
+static void rtd1195_mux_enable_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+
+	mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	raw_spin_lock_irqsave(&mux_data->lock, flags);
+
+	mux_data->scpu_int_en |= mask;
+	writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
+
+	raw_spin_unlock_irqrestore(&mux_data->lock, flags);
+}
+
+static void rtd1195_mux_disable_irq(struct irq_data *data)
+{
+	struct rtd1195_irq_mux_data *mux_data = irq_data_get_irq_chip_data(data);
+	unsigned long flags;
+	u32 mask;
+
+	mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
+	if (!mask)
+		return;
+
+	raw_spin_lock_irqsave(&mux_data->lock, flags);
+
+	mux_data->scpu_int_en &= ~mask;
+	writel_relaxed(mux_data->scpu_int_en, mux_data->reg_scpu_int_en);
+
+	raw_spin_unlock_irqrestore(&mux_data->lock, flags);
+}
+
+static struct irq_chip rtd1195_mux_irq_chip = {
+	.name		= "rtd1195-mux",
+	.irq_mask	= rtd1195_mux_mask_irq,
+	.irq_unmask	= rtd1195_mux_unmask_irq,
+	.irq_enable	= rtd1195_mux_enable_irq,
+	.irq_disable	= rtd1195_mux_disable_irq,
+};
+
+static int rtd1195_mux_irq_domain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hw)
+{
+	struct rtd1195_irq_mux_data *data = d->host_data;
+
+	irq_set_chip_and_handler(irq, &rtd1195_mux_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, data);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops rtd1195_mux_irq_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= rtd1195_mux_irq_domain_map,
+};
+
+enum rtd1295_iso_isr_bits {
+	RTD1295_ISO_ISR_UR0_SHIFT		= 2,
+	RTD1295_ISO_ISR_IRDA_SHIFT		= 5,
+	RTD1295_ISO_ISR_I2C0_SHIFT		= 8,
+	RTD1295_ISO_ISR_I2C1_SHIFT		= 11,
+	RTD1295_ISO_ISR_RTC_HSEC_SHIFT		= 12,
+	RTD1295_ISO_ISR_RTC_ALARM_SHIFT		= 13,
+	RTD1295_ISO_ISR_GPIOA_SHIFT		= 19,
+	RTD1295_ISO_ISR_GPIODA_SHIFT		= 20,
+	RTD1295_ISO_ISR_GPHY_DV_SHIFT		= 29,
+	RTD1295_ISO_ISR_GPHY_AV_SHIFT		= 30,
+	RTD1295_ISO_ISR_I2C1_REQ_SHIFT		= 31,
+};
+
+static const u32 rtd1295_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD1295_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD1295_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD1295_ISO_ISR_I2C1_SHIFT]		= BIT(11),
+	[RTD1295_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD1295_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD1295_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_ISO_ISR_GPHY_DV_SHIFT]		= BIT(29),
+	[RTD1295_ISO_ISR_GPHY_AV_SHIFT]		= BIT(30),
+	[RTD1295_ISO_ISR_I2C1_REQ_SHIFT]	= BIT(31),
+};
+
+enum rtd1295_misc_isr_bits {
+	RTD1295_ISR_UR1_SHIFT			= 3,
+	RTD1295_ISR_UR1_TO_SHIFT		= 5,
+	RTD1295_ISR_UR2_SHIFT			= 8,
+	RTD1295_ISR_RTC_MIN_SHIFT		= 10,
+	RTD1295_ISR_RTC_HOUR_SHIFT		= 11,
+	RTD1295_ISR_RTC_DATA_SHIFT		= 12,
+	RTD1295_ISR_UR2_TO_SHIFT		= 13,
+	RTD1295_ISR_I2C5_SHIFT			= 14,
+	RTD1295_ISR_I2C4_SHIFT			= 15,
+	RTD1295_ISR_GPIOA_SHIFT			= 19,
+	RTD1295_ISR_GPIODA_SHIFT		= 20,
+	RTD1295_ISR_LSADC0_SHIFT		= 21,
+	RTD1295_ISR_LSADC1_SHIFT		= 22,
+	RTD1295_ISR_I2C3_SHIFT			= 23,
+	RTD1295_ISR_SC0_SHIFT			= 24,
+	RTD1295_ISR_I2C2_SHIFT			= 26,
+	RTD1295_ISR_GSPI_SHIFT			= 27,
+	RTD1295_ISR_FAN_SHIFT			= 29,
+};
+
+static const u32 rtd1295_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1295_ISR_UR1_SHIFT]			= BIT(3),
+	[RTD1295_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD1295_ISR_UR2_TO_SHIFT]		= BIT(6),
+	[RTD1295_ISR_UR2_SHIFT]			= BIT(7),
+	[RTD1295_ISR_RTC_MIN_SHIFT]		= BIT(10),
+	[RTD1295_ISR_RTC_HOUR_SHIFT]		= BIT(11),
+	[RTD1295_ISR_RTC_DATA_SHIFT]		= BIT(12),
+	[RTD1295_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD1295_ISR_I2C4_SHIFT]		= BIT(15),
+	[RTD1295_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1295_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1295_ISR_LSADC0_SHIFT]		= BIT(21),
+	[RTD1295_ISR_LSADC1_SHIFT]		= BIT(22),
+	[RTD1295_ISR_SC0_SHIFT]			= BIT(24),
+	[RTD1295_ISR_I2C2_SHIFT]		= BIT(26),
+	[RTD1295_ISR_GSPI_SHIFT]		= BIT(27),
+	[RTD1295_ISR_I2C3_SHIFT]		= BIT(28),
+	[RTD1295_ISR_FAN_SHIFT]			= BIT(29),
+};
+
+static const struct rtd1195_irq_mux_info rtd1295_iso_irq_mux_info = {
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_int_en_mask	= rtd1295_iso_isr_to_scpu_int_en_mask,
+};
+
+static const struct rtd1195_irq_mux_info rtd1295_misc_irq_mux_info = {
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_int_en_mask	= rtd1295_misc_isr_to_scpu_int_en_mask,
+};
+
+static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1295-iso-irq-mux",
+		.data = &rtd1295_iso_irq_mux_info,
+	},
+	{
+		.compatible = "realtek,rtd1295-misc-irq-mux",
+		.data = &rtd1295_misc_irq_mux_info,
+	},
+	{
+	}
+};
+
+static int __init rtd1195_irq_mux_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	struct rtd1195_irq_mux_data *data;
+	const struct of_device_id *match;
+	const struct rtd1195_irq_mux_info *info;
+	void __iomem *base;
+
+	match = of_match_node(rtd1295_irq_mux_dt_matches, node);
+	if (!match)
+		return -EINVAL;
+
+	info = match->data;
+	if (!info)
+		return -EINVAL;
+
+	base = of_iomap(node, 0);
+	if (!base)
+		return -EIO;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->info		= info;
+	data->reg_isr		= base + info->isr_offset;
+	data->reg_umsk_isr	= base + info->umsk_isr_offset;
+	data->reg_scpu_int_en	= base + info->scpu_int_en_offset;
+
+	data->irq = irq_of_parse_and_map(node, 0);
+	if (data->irq <= 0) {
+		kfree(data);
+		return -EINVAL;
+	}
+
+	raw_spin_lock_init(&data->lock);
+
+	writel_relaxed(data->scpu_int_en, data->reg_scpu_int_en);
+
+	data->domain = irq_domain_add_linear(node, 32,
+				&rtd1195_mux_irq_domain_ops, data);
+	if (!data->domain) {
+		kfree(data);
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(data->irq, rtd1195_mux_irq_handle, data);
+
+	return 0;
+}
+IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1195_irq_mux_init);
+IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd1195_irq_mux_init);
-- 
2.16.4

