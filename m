Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A08C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52FF2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfKTNW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfKTNVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPum-00073V-Do; Wed, 20 Nov 2019 14:21:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1E72B1C19FE;
        Wed, 20 Nov 2019 14:21:00 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:00 -0000
From:   "tip-bot2 for Lina Iyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl/msm: Setup GPIO chip in hierarchy
Cc:     Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-9-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-9-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606002.12247.16978526106461109680.tip-bot2@tip-bot2>
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

Commit-ID:     e35a6ae0eb3a7cc451e8d8db55e9b938a95de416
Gitweb:        https://git.kernel.org/tip/e35a6ae0eb3a7cc451e8d8db55e9b938a95de416
Author:        Lina Iyer <ilina@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:51 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:23:15 

pinctrl/msm: Setup GPIO chip in hierarchy

Some GPIOs are marked as wakeup capable and are routed to another
interrupt controller that is an always-domain and can detect interrupts
even when most of the SoC is powered off. The wakeup interrupt
controller wakes up the GIC and replays the interrupt at the GIC.

Setup the TLMM irqchip in hierarchy with the wakeup interrupt controller
and ensure the wakeup GPIOs are handled correctly.

Co-developed-by: Maulik Shah <mkshah@codeaurora.org>

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-9-git-send-email-ilina@codeaurora.org

----
Changes in v2:
	- Address review comments
	- Fix Co-developed-by tag
Changes in v1:
	- Address minor review comments
	- Remove redundant call to set irq handler
	- Move irq_domain_qcom_handle_wakeup() to this patch
Changes in RFC v2:
	- Rebase on top of GPIO hierarchy support in linux-next
	- Set the chained irq handler for summary line
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 112 +++++++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.h |  14 ++++-
 include/linux/soc/qcom/irq.h       |  13 +++-
 3 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 763da0b..9788384 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -23,6 +23,8 @@
 #include <linux/pm.h>
 #include <linux/log2.h>
 
+#include <linux/soc/qcom/irq.h>
+
 #include "../core.h"
 #include "../pinconf.h"
 #include "pinctrl-msm.h"
@@ -44,6 +46,7 @@
  * @enabled_irqs:   Bitmap of currently enabled irqs.
  * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
  *                  detection.
+ * @skip_wake_irqs: Skip IRQs that are handled by wakeup interrupt controller
  * @soc;            Reference to soc_data of platform specific data.
  * @regs:           Base addresses for the TLMM tiles.
  */
@@ -61,6 +64,7 @@ struct msm_pinctrl {
 
 	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
 	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
+	DECLARE_BITMAP(skip_wake_irqs, MAX_NR_GPIO);
 
 	const struct msm_pinctrl_soc_data *soc;
 	void __iomem *regs[MAX_NR_TILES];
@@ -707,6 +711,12 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
+
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return;
+
 	g = &pctrl->soc->groups[d->hwirq];
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -751,6 +761,12 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
 	unsigned long flags;
 	u32 val;
 
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
+
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return;
+
 	g = &pctrl->soc->groups[d->hwirq];
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -778,10 +794,35 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
 
 static void msm_gpio_irq_enable(struct irq_data *d)
 {
+	/*
+	 * Clear the interrupt that may be pending before we enable
+	 * the line.
+	 * This is especially a problem with the GPIOs routed to the
+	 * PDC. These GPIOs are direct-connect interrupts to the GIC.
+	 * Disabling the interrupt line at the PDC does not prevent
+	 * the interrupt from being latched at the GIC. The state at
+	 * GIC needs to be cleared before enabling.
+	 */
+	if (d->parent_data) {
+		irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, 0);
+		irq_chip_enable_parent(d);
+	}
 
 	msm_gpio_irq_clear_unmask(d, true);
 }
 
+static void msm_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+
+	if (d->parent_data)
+		irq_chip_disable_parent(d);
+
+	if (!test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		msm_gpio_irq_mask(d);
+}
+
 static void msm_gpio_irq_unmask(struct irq_data *d)
 {
 	msm_gpio_irq_clear_unmask(d, false);
@@ -795,6 +836,9 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return;
+
 	g = &pctrl->soc->groups[d->hwirq];
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -820,6 +864,12 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	unsigned long flags;
 	u32 val;
 
+	if (d->parent_data)
+		irq_chip_set_type_parent(d, type);
+
+	if (test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return 0;
+
 	g = &pctrl->soc->groups[d->hwirq];
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -912,6 +962,15 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned long flags;
 
+	/*
+	 * While they may not wake up when the TLMM is powered off,
+	 * some GPIOs would like to wakeup the system from suspend
+	 * when TLMM is powered on. To allow that, enable the GPIO
+	 * summary line to be wakeup capable at GIC.
+	 */
+	if (d->parent_data)
+		irq_chip_set_wake_parent(d, on);
+
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
 	irq_set_irq_wake(pctrl->irq, on);
@@ -990,6 +1049,30 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int msm_gpio_wakeirq(struct gpio_chip *gc,
+			    unsigned int child,
+			    unsigned int child_type,
+			    unsigned int *parent,
+			    unsigned int *parent_type)
+{
+	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
+	const struct msm_gpio_wakeirq_map *map;
+	int i;
+
+	*parent = GPIO_NO_WAKE_IRQ;
+	*parent_type = IRQ_TYPE_EDGE_RISING;
+
+	for (i = 0; i < pctrl->soc->nwakeirq_map; i++) {
+		map = &pctrl->soc->wakeirq_map[i];
+		if (map->gpio == child) {
+			*parent = map->wakeirq;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 {
 	if (pctrl->soc->reserved_gpios)
@@ -1002,8 +1085,10 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
 	struct gpio_irq_chip *girq;
-	int ret;
-	unsigned ngpio = pctrl->soc->ngpios;
+	int i, ret;
+	unsigned gpio, ngpio = pctrl->soc->ngpios;
+	struct device_node *np;
+	bool skip;
 
 	if (WARN_ON(ngpio > MAX_NR_GPIO))
 		return -EINVAL;
@@ -1020,17 +1105,40 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 
 	pctrl->irq_chip.name = "msmgpio";
 	pctrl->irq_chip.irq_enable = msm_gpio_irq_enable;
+	pctrl->irq_chip.irq_disable = msm_gpio_irq_disable;
 	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
 	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
 	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
+	pctrl->irq_chip.irq_eoi = irq_chip_eoi_parent;
 	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
 	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
 	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
 	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 
+	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
+	if (np) {
+		chip->irq.parent_domain = irq_find_matching_host(np,
+						 DOMAIN_BUS_WAKEUP);
+		of_node_put(np);
+		if (!chip->irq.parent_domain)
+			return -EPROBE_DEFER;
+		chip->irq.child_to_parent_hwirq = msm_gpio_wakeirq;
+
+		/*
+		 * Let's skip handling the GPIOs, if the parent irqchip
+		 * is handling the direct connect IRQ of the GPIO.
+		 */
+		skip = irq_domain_qcom_handle_wakeup(chip->irq.parent_domain);
+		for (i = 0; skip && i < pctrl->soc->nwakeirq_map; i++) {
+			gpio = pctrl->soc->wakeirq_map[i].gpio;
+			set_bit(gpio, pctrl->skip_wake_irqs);
+		}
+	}
+
 	girq = &chip->irq;
 	girq->chip = &pctrl->irq_chip;
 	girq->parent_handler = msm_gpio_irq_handler;
+	girq->fwnode = pctrl->dev->fwnode;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(pctrl->dev, 1, sizeof(*girq->parents),
 				     GFP_KERNEL);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 48569cd..9452da1 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -92,6 +92,16 @@ struct msm_pingroup {
 };
 
 /**
+ * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
+ * @gpio:          The GPIOs that are wakeup capable
+ * @wakeirq:       The interrupt at the always-on interrupt controller
+ */
+struct msm_gpio_wakeirq_map {
+	unsigned int gpio;
+	unsigned int wakeirq;
+};
+
+/**
  * struct msm_pinctrl_soc_data - Qualcomm pin controller driver configuration
  * @pins:	    An array describing all pins the pin controller affects.
  * @npins:	    The number of entries in @pins.
@@ -101,6 +111,8 @@ struct msm_pingroup {
  * @ngroups:	    The numbmer of entries in @groups.
  * @ngpio:	    The number of pingroups the driver should expose as GPIOs.
  * @pull_no_keeper: The SoC does not support keeper bias.
+ * @wakeirq_map:    The map of wakeup capable GPIOs and the pin at PDC/MPM
+ * @nwakeirq_map:   The number of entries in @wakeirq_map
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -114,6 +126,8 @@ struct msm_pinctrl_soc_data {
 	const char *const *tiles;
 	unsigned int ntiles;
 	const int *reserved_gpios;
+	const struct msm_gpio_wakeirq_map *wakeirq_map;
+	unsigned int nwakeirq_map;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
index 637c0bf..9e1ece5 100644
--- a/include/linux/soc/qcom/irq.h
+++ b/include/linux/soc/qcom/irq.h
@@ -18,4 +18,17 @@
 #define IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP		(IRQ_DOMAIN_FLAG_NONCORE << 0)
 #define IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP		(IRQ_DOMAIN_FLAG_NONCORE << 1)
 
+/**
+ * irq_domain_qcom_handle_wakeup: Return if the domain handles interrupt
+ *                                configuration
+ * @d: irq domain
+ *
+ * This QCOM specific irq domain call returns if the interrupt controller
+ * requires the interrupt be masked at the child interrupt controller.
+ */
+static inline bool irq_domain_qcom_handle_wakeup(const struct irq_domain *d)
+{
+	return (d->flags & IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP);
+}
+
 #endif
