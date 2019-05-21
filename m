Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3174C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCBC21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g/JEyZal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfEUXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 19:31:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8294 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfEUXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 19:31:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce48a470000>; Tue, 21 May 2019 16:31:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 May 2019 16:31:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 May 2019 16:31:18 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:18 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 May
 2019 23:31:18 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 May 2019 23:31:18 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.174]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce48a460003>; Tue, 21 May 2019 16:31:18 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <jckuo@nvidia.com>, <talho@nvidia.com>, <josephl@nvidia.com>,
        <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V1 10/12] gpio: tegra: implement wake event support for Tegra210 and prior GPIO
Date:   Tue, 21 May 2019 16:31:21 -0700
Message-ID: <1558481483-22254-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558481479; bh=ExiJeA8xgoubQVl+RE6ANcLUd8QRDyP6miirB8jIpLk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=g/JEyZalwv/EMUZ4iImIObKXvQGg5wqbH34xV2dNhmyFZ1k3lIMRhVfNZeEMFijec
         nGWc6S2XroJ5Cc0eZe/wRMHQL9ynW0I7C1T8hrrW4sL3zyQR4Kcm1/mAsRxAblUMwS
         WTq/+EpKv4G3tSSFyK9hbpWBWD1972TY1ITNz3rMd/PrXu4MWeJJrhiEw+k+Alj3sP
         MvF8CpONd5G1FkVyWA0euGHR1zg4iGlOqvDBGVbqLmjvBgPTh7ZLKtj60ANqfPhbhz
         uyZSiLtksB+C4kLg/mXfj0MMdoCicJpwhWusQR8vsyacfMZJhwxLzzhRFgPmiqpnT/
         FCU0KbUehch8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller doesn't have any controls to enable the system to
wake up from low power states based on activity on GPIO pins. An extra
hardware block that is part of the power management controller (PMC)
contains these controls. In order for the GPIO controller to be able
to cooperate with the PMC, obtain a reference to the PMC's IRQ domain
and make it a parent to the GPIO controller's IRQ domain. This way the
PMC gets an opportunity to program the additional registers required
to enable wakeup sources on suspend.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/gpio/gpio-tegra.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 6d9b6906b9d0..d57e33050d0c 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -32,6 +32,8 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 #define GPIO_BANK(x)		((x) >> 5)
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
 #define GPIO_BIT(x)		((x) & 0x7)
@@ -275,8 +277,22 @@ static int tegra_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
+	struct irq_domain *domain = tgi->irq_domain;
+
+	if (!gpiochip_irqchip_irq_valid(chip, offset))
+		return -ENXIO;
+
+	if (irq_domain_is_hierarchy(domain)) {
+		struct irq_fwspec spec;
+
+		spec.fwnode = domain->fwnode;
+		spec.param_count = 2;
+		spec.param[0] = offset;
+		spec.param[1] = IRQ_TYPE_NONE;
+		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
+	}
 
-	return irq_find_mapping(tgi->irq_domain, offset);
+	return irq_find_mapping(domain, offset);
 }
 
 static void tegra_gpio_irq_ack(struct irq_data *d)
@@ -365,7 +381,10 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	return 0;
+	if (d->parent_data)
+		return irq_chip_set_type_parent(d, type);
+	else
+		return 0;
 }
 
 static void tegra_gpio_irq_shutdown(struct irq_data *d)
@@ -566,10 +585,79 @@ static const struct dev_pm_ops tegra_gpio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
 };
 
+static int tegra_gpio_irq_domain_translate(struct irq_domain *domain,
+					   struct irq_fwspec *fwspec,
+					   unsigned long *hwirq,
+					   unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	*hwirq = fwspec->param[0];
+
+	return 0;
+}
+
+static int tegra_gpio_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int num_irqs, void *data)
+{
+	struct tegra_gpio_info *tgi = gpiochip_get_data(domain->host_data);
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec spec;
+	struct tegra_gpio_bank *bank;
+	unsigned long hwirq;
+	unsigned int type;
+	int err = 0;
+
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+
+	if (!irq_domain_get_of_node(domain->parent))
+		return -EINVAL;
+
+	err = tegra_gpio_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
+
+	bank = &tgi->bank_info[GPIO_BANK(hwirq)];
+	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &tgi->ic, bank);
+
+	if (err < 0)
+		return err;
+
+	spec.fwnode = domain->parent->fwnode;
+	spec.param_count = 3;
+	spec.param[0] = GIC_SPI;
+	spec.param[1] = fwspec->param[0];
+	spec.param[2] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &spec);
+}
+
+static const struct irq_domain_ops tegra_gpio_irq_domain_ops = {
+	.translate = tegra_gpio_irq_domain_translate,
+	.alloc = tegra_gpio_irq_domain_alloc,
+};
+
+static const struct of_device_id tegra_pmc_of_match[] = {
+	{ .compatible = "nvidia,tegra210-pmc" },
+	{ .compatible = "nvidia,tegra132-pmc" },
+	{ .compatible = "nvidia,tegra124-pmc" },
+	{ .compatible = "nvidia,tegra114-pmc" },
+	{ .compatible = "nvidia,tegra30-pmc" },
+	{ .compatible = "nvidia,tegra20-pmc" },
+	{ }
+};
+
 static int tegra_gpio_probe(struct platform_device *pdev)
 {
 	struct tegra_gpio_info *tgi;
 	struct tegra_gpio_bank *bank;
+	struct device_node *np;
+	struct irq_domain *parent_domain = NULL;
 	unsigned int gpio, i, j;
 	int ret;
 
@@ -612,8 +700,15 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	tgi->ic.irq_set_type		= tegra_gpio_irq_set_type;
 	tgi->ic.irq_shutdown		= tegra_gpio_irq_shutdown;
 #ifdef CONFIG_PM_SLEEP
-	tgi->ic.irq_set_wake		= tegra_gpio_irq_set_wake;
+	tgi->ic.irq_set_wake		= irq_chip_set_wake_parent;
 #endif
+	np = of_find_matching_node(NULL, tegra_pmc_of_match);
+	if (np) {
+		parent_domain = irq_find_host(np);
+		of_node_put(np);
+		if (!parent_domain)
+			return -EPROBE_DEFER;
+	}
 
 	platform_set_drvdata(pdev, tgi);
 
@@ -625,9 +720,11 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	if (!tgi->bank_info)
 		return -ENOMEM;
 
-	tgi->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
-						tgi->gc.ngpio,
-						&irq_domain_simple_ops, NULL);
+	tgi->irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
+						   tgi->gc.ngpio,
+						   pdev->dev.of_node,
+						   &tegra_gpio_irq_domain_ops,
+						   &tgi->gc);
 	if (!tgi->irq_domain)
 		return -ENODEV;
 
-- 
2.7.4

