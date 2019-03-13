Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BD8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zq7WZBXV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MrJMlvh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCMVTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:19:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46452 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfCMVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:19:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C01D160FF3; Wed, 13 Mar 2019 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511944;
        bh=vVmH9ebNSYRPvs+i65zmUb173kWZ0hjnHholva1D+2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zq7WZBXVTYAhuVT2RtD5PGEwT1rb6ZXRq2oSDPjYf7Z5mvfzYyh9CHf+qciF4b2V3
         zcJDmSTsCJEmPickjRQNP+Ugc+BK6qzjAmPzISzFwCpbfRiPbNvz5YKAAvQrsLbtqp
         VGqKfgYoM4bO6VEtsa1K6eMoUuhQj2O7H3R8hJTY=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5828B61112;
        Wed, 13 Mar 2019 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552511942;
        bh=vVmH9ebNSYRPvs+i65zmUb173kWZ0hjnHholva1D+2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrJMlvh/qyg1BkS6OwlLCmhMPmmCtZFVi4Ql1uE6NN89o/CjZip3yd1D6P2J3bxNI
         QZFGXeCFCphq9qBWzASWLLfoQZCDJ0la42RweM3ZF0nltkqaV9vizEtkN3PQHA0Kh8
         Z58WZ8NAVwMURBIM3Fk0kBenhjGa1ZH7N7KNpk5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5828B61112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 05/10] drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
Date:   Wed, 13 Mar 2019 15:18:39 -0600
Message-Id: <20190313211844.29416-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313211844.29416-1-ilina@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new domain for wakeup capable GPIOs. The domain can be
requested using the bus token DOMAIN_BUS_WAKEUP. In the following
patches, we will specify PDC as the wakeup-parent for the TLMM GPIO
irqchip. Requesting a wakeup GPIO will setup the GPIO and the
corresponding PDC interrupt as its parent.

Co-developed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v4:
	- Remove vestigial changes from v2
Changes in v3:
	- Remove PDC GPIO map data (moved to DT)
	- hwirq passed in .alloc() is a PDC pin now
Changes in v2:
	- Remove separate file for PDC GPIO map data
	- Error checks and return
	- Whitespace fixes
---
 drivers/irqchip/qcom-pdc.c   | 72 ++++++++++++++++++++++++++++++++++--
 include/linux/soc/qcom/irq.h | 23 ++++++++++++
 2 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/soc/qcom/irq.h

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index faa7d61b9d6c..29118f6d84c3 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -13,12 +13,13 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
 #define PDC_MAX_IRQS		126
+#define PDC_MAX_GPIO_IRQS	256
 
 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
 #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
@@ -169,7 +170,6 @@ static irq_hw_number_t get_parent_hwirq(int pin)
 			return (region->parent_base + pin - region->pin_base);
 	}
 
-	WARN_ON(1);
 	return ~0UL;
 }
 
@@ -232,6 +232,60 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int nr_irqs, void *data)
+{
+	struct qcom_irq_fwspec *qcom_fwspec = data;
+	struct irq_fwspec *fwspec = &qcom_fwspec->fwspec;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq, parent_hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return -EINVAL;
+
+	parent_hwirq = get_parent_hwirq(hwirq);
+	if (parent_hwirq == ~0UL)
+		return -EINVAL;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &qcom_pdc_gic_chip, NULL);
+	if (ret)
+		return ret;
+
+	qcom_fwspec->mask = true;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode      = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0]    = 0;
+	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[2]    = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       enum irq_domain_bus_token bus_token)
+{
+	return (bus_token == DOMAIN_BUS_WAKEUP);
+}
+
+static const struct irq_domain_ops qcom_pdc_gpio_ops = {
+	.select		= qcom_pdc_gpio_domain_select,
+	.alloc		= qcom_pdc_gpio_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n;
@@ -270,7 +324,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 
 static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *pdc_domain;
+	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
 	int ret;
 
 	pdc_base = of_iomap(node, 0);
@@ -301,6 +355,18 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 		goto fail;
 	}
 
+	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain, 0,
+						      PDC_MAX_GPIO_IRQS,
+						      of_fwnode_handle(node),
+						      &qcom_pdc_gpio_ops, NULL);
+	if (!pdc_gpio_domain) {
+		pr_err("%pOF: GIC domain add failed for GPIO domain\n", node);
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
+
 	return 0;
 
 fail:
diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
new file mode 100644
index 000000000000..bacc9edbce0d
--- /dev/null
+++ b/include/linux/soc/qcom/irq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_IRQ_H
+#define __QCOM_IRQ_H
+
+#include <linux/irqdomain.h>
+
+/**
+ * struct qcom_irq_fwspec - qcom specific irq fwspec wrapper
+ * @fwspec: irq fwspec
+ * @mask: if true, keep the irq masked in the gpio controller
+ *
+ * Use this structure to communicate between the parent irq chip, MPM or PDC,
+ * to the gpio chip, TLMM, about the gpio being allocated in the parent
+ * and if the gpio chip should keep the line masked because the parent irq
+ * chip is handling everything about the irq line.
+ */
+struct qcom_irq_fwspec {
+	struct irq_fwspec fwspec;
+	bool mask;
+};
+
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

