Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1674208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392254AbfIFLIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbfIFLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6C-000730-PB; Fri, 06 Sep 2019 13:08:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 248DD1C0E22;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Jerome Brunet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/meson-gpio: Add support for meson sm1 SoCs
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190829161635.25067-3-jbrunet@baylibre.com>
References: <20190829161635.25067-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Message-ID: <156776809510.24167.14866614709961308411.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b2fb4b77994abc1107c35547f3e123dce8e9f67d
Gitweb:        https://git.kernel.org/tip/b2fb4b77994abc1107c35547f3e123dce8e9f67d
Author:        Jerome Brunet <jbrunet@baylibre.com>
AuthorDate:    Thu, 29 Aug 2019 18:16:35 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 30 Aug 2019 15:01:06 +01:00

irqchip/meson-gpio: Add support for meson sm1 SoCs

The meson sm1 SoCs uses the same type of GPIO interrupt controller IP
block as the other meson SoCs, A total of 100 pins can be spied on:

- 223:100 undefined (no interrupt)
- 99:97   3 pins on bank GPIOE
- 96:77   20 pins on bank GPIOX
- 76:61   16 pins on bank GPIOA
- 60:53   8 pins on bank GPIOC
- 52:37   16 pins on bank BOOT
- 36:28   9 pins on bank GPIOH
- 27:12   16 pins on bank GPIOZ
- 11:0    12 pins in the AO domain

Mapping is the same as the g12a family but the sm1 controller
allows to trig an irq on both edges of the input signal. This was
not possible with the previous SoCs families

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Link: https://lore.kernel.org/r/20190829161635.25067-3-jbrunet@baylibre.com
---
 drivers/irqchip/irq-meson-gpio.c | 52 ++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index dcdc23b..829084b 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -24,14 +24,25 @@
 #define REG_PIN_47_SEL	0x08
 #define REG_FILTER_SEL	0x0c
 
-#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
+/*
+ * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
+ * bits 24 to 31. Tests on the actual HW show that these bits are
+ * stuck at 0. Bits 8 to 15 are responsive and have the expected
+ * effect.
+ */
 #define REG_EDGE_POL_EDGE(x)	BIT(x)
 #define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
+#define REG_BOTH_EDGE(x)	BIT(8 + (x))
+#define REG_EDGE_POL_MASK(x)    (	\
+		REG_EDGE_POL_EDGE(x) |	\
+		REG_EDGE_POL_LOW(x)  |	\
+		REG_BOTH_EDGE(x))
 #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
 #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
 
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	bool support_edge_both;
 };
 
 static const struct meson_gpio_irq_params meson8_params = {
@@ -54,6 +65,11 @@ static const struct meson_gpio_irq_params axg_params = {
 	.nr_hwirq = 100,
 };
 
+static const struct meson_gpio_irq_params sm1_params = {
+	.nr_hwirq = 100,
+	.support_edge_both = true,
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -61,11 +77,12 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
 	{ }
 };
 
 struct meson_gpio_irq_controller {
-	unsigned int nr_hwirq;
+	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
 	u32 channel_irqs[NUM_CHANNEL];
 	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
@@ -168,14 +185,22 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 */
 	type &= IRQ_TYPE_SENSE_MASK;
 
-	if (type == IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
+	/*
+	 * New controller support EDGE_BOTH trigger. This setting takes
+	 * precedence over the other edge/polarity settings
+	 */
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		if (!ctl->params->support_edge_both)
+			return -EINVAL;
 
-	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
-		val |= REG_EDGE_POL_EDGE(idx);
+		val |= REG_BOTH_EDGE(idx);
+	} else {
+		if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+			val |= REG_EDGE_POL_EDGE(idx);
 
-	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
-		val |= REG_EDGE_POL_LOW(idx);
+		if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
+			val |= REG_EDGE_POL_LOW(idx);
+	}
 
 	spin_lock(&ctl->lock);
 
@@ -199,7 +224,7 @@ static unsigned int meson_gpio_irq_type_output(unsigned int type)
 	 */
 	if (sense & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
 		type |= IRQ_TYPE_LEVEL_HIGH;
-	else if (sense & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+	else
 		type |= IRQ_TYPE_EDGE_RISING;
 
 	return type;
@@ -328,15 +353,13 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 					  struct meson_gpio_irq_controller *ctl)
 {
 	const struct of_device_id *match;
-	const struct meson_gpio_irq_params *params;
 	int ret;
 
 	match = of_match_node(meson_irq_gpio_matches, node);
 	if (!match)
 		return -ENODEV;
 
-	params = match->data;
-	ctl->nr_hwirq = params->nr_hwirq;
+	ctl->params = match->data;
 
 	ret = of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
@@ -385,7 +408,8 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	if (ret)
 		goto free_channel_irqs;
 
-	domain = irq_domain_create_hierarchy(parent_domain, 0, ctl->nr_hwirq,
+	domain = irq_domain_create_hierarchy(parent_domain, 0,
+					     ctl->params->nr_hwirq,
 					     of_node_to_fwnode(node),
 					     &meson_gpio_irq_domain_ops,
 					     ctl);
@@ -396,7 +420,7 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	}
 
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, NUM_CHANNEL);
 
 	return 0;
 
