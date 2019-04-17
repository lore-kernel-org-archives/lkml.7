Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65929C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F332173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ATjwNDsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfDQNDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:03:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52540 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729940AbfDQNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:03:50 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3HCfRTY002921;
        Wed, 17 Apr 2019 15:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=QIJsH9geqDRq0HWPa7PuJtTHkpaSU8IP25VAjP/6WV8=;
 b=ATjwNDsFResZNg1GU4is541/+kCZWHJIvU++J7V9ubeSIjwBpnhOlyq9cFscmsvKRX6f
 FSlazRMD9mP/JOo4xmJXRwAJyCCXgdcIYDZz8XSzkCLiSpB12/277vvnyn/fdqKEmS+q
 sHvVDtfBWWz4TZ0arsTQXZk9mHjgGc7VojuMJ9+b5a7xStDU5iIteivXUey/3DAVEU/u
 aclpWgRZlESJn1gq65loovedLcbJlyqiOgO0DEg1K1urKeoXF0B0VgyygeEXQI5bfWfz
 Eq0KzAxjWWU8mZy8ifQpvHVtzF8IFlQgbtMHf9QXC4u1T+FRH5hrZFiTzABSyJF1Nbfs mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6ngyhxf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 17 Apr 2019 15:03:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C022551;
        Wed, 17 Apr 2019 13:03:16 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89A7B261A;
        Wed, 17 Apr 2019 13:03:16 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 17 Apr
 2019 15:03:16 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 17 Apr 2019 15:03:16
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] irqchip: stm32: use a platform driver for stm32mp1-exti device
Date:   Wed, 17 Apr 2019 15:02:56 +0200
Message-ID: <1555506176-7148-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This irqchip driver uses the hwspinlock framework (coprocessor HW regs
access concurrency) for the stm32mp1-exti device.
Hence, this driver needs to handle the hwspinlock driver dependency
using the deferred probe mechanism which requires to move this driver
into a platform one with a probe() ops.
This applies only for the device which is "st,stm32mp1-exti" compatible,
the management of the other devices (st,stm32h7-exti / st,stm32-exti) is
kept unchanged (use IRQCHIP_DECLARE)

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 233 +++++++++++++++++++++++----------------
 1 file changed, 140 insertions(+), 93 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6b19bff..528be78 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -14,8 +14,10 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -37,12 +39,6 @@ struct stm32_exti_bank {
 
 #define UNDEF_REG ~0
 
-enum stm32_exti_hwspinlock {
-	HWSPINLOCK_UNKNOWN,
-	HWSPINLOCK_NONE,
-	HWSPINLOCK_READY,
-};
-
 struct stm32_desc_irq {
 	u32 exti;
 	u32 irq_parent;
@@ -69,8 +65,6 @@ struct stm32_exti_host_data {
 	void __iomem *base;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct device_node *node;
-	enum stm32_exti_hwspinlock hwlock_state;
 	struct hwspinlock *hwlock;
 };
 
@@ -285,49 +279,27 @@ static int stm32_exti_set_type(struct irq_data *d,
 
 static int stm32_exti_hwspin_lock(struct stm32_exti_chip_data *chip_data)
 {
-	struct stm32_exti_host_data *host_data = chip_data->host_data;
-	struct hwspinlock *hwlock;
-	int id, ret = 0, timeout = 0;
-
-	/* first time, check for hwspinlock availability */
-	if (unlikely(host_data->hwlock_state == HWSPINLOCK_UNKNOWN)) {
-		id = of_hwspin_lock_get_id(host_data->node, 0);
-		if (id >= 0) {
-			hwlock = hwspin_lock_request_specific(id);
-			if (hwlock) {
-				/* found valid hwspinlock */
-				host_data->hwlock_state = HWSPINLOCK_READY;
-				host_data->hwlock = hwlock;
-				pr_debug("%s hwspinlock = %d\n", __func__, id);
-			} else {
-				host_data->hwlock_state = HWSPINLOCK_NONE;
-			}
-		} else if (id != -EPROBE_DEFER) {
-			host_data->hwlock_state = HWSPINLOCK_NONE;
-		} else {
-			/* hwspinlock driver shall be ready at that stage */
-			ret = -EPROBE_DEFER;
-		}
-	}
+	int ret, timeout = 0;
 
-	if (likely(host_data->hwlock_state == HWSPINLOCK_READY)) {
-		/*
-		 * Use the x_raw API since we are under spin_lock protection.
-		 * Do not use the x_timeout API because we are under irq_disable
-		 * mode (see __setup_irq())
-		 */
-		do {
-			ret = hwspin_trylock_raw(host_data->hwlock);
-			if (!ret)
-				return 0;
-
-			udelay(HWSPNLCK_RETRY_DELAY);
-			timeout += HWSPNLCK_RETRY_DELAY;
-		} while (timeout < HWSPNLCK_TIMEOUT);
-
-		if (ret == -EBUSY)
-			ret = -ETIMEDOUT;
-	}
+	if (!chip_data->host_data->hwlock)
+		return 0;
+
+	/*
+	 * Use the x_raw API since we are under spin_lock protection.
+	 * Do not use the x_timeout API because we are under irq_disable
+	 * mode (see __setup_irq())
+	 */
+	do {
+		ret = hwspin_trylock_raw(chip_data->host_data->hwlock);
+		if (!ret)
+			return 0;
+
+		udelay(HWSPNLCK_RETRY_DELAY);
+		timeout += HWSPNLCK_RETRY_DELAY;
+	} while (timeout < HWSPNLCK_TIMEOUT);
+
+	if (ret == -EBUSY)
+		ret = -ETIMEDOUT;
 
 	if (ret)
 		pr_err("%s can't get hwspinlock (%d)\n", __func__, ret);
@@ -337,7 +309,7 @@ static int stm32_exti_hwspin_lock(struct stm32_exti_chip_data *chip_data)
 
 static void stm32_exti_hwspin_unlock(struct stm32_exti_chip_data *chip_data)
 {
-	if (likely(chip_data->host_data->hwlock_state == HWSPINLOCK_READY))
+	if (chip_data->host_data->hwlock)
 		hwspin_unlock_raw(chip_data->host_data->hwlock);
 }
 
@@ -586,8 +558,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM
-static int stm32_exti_h_suspend(void)
+static int __maybe_unused stm32_exti_h_suspend(void)
 {
 	struct stm32_exti_chip_data *chip_data;
 	int i;
@@ -602,7 +573,7 @@ static int stm32_exti_h_suspend(void)
 	return 0;
 }
 
-static void stm32_exti_h_resume(void)
+static void __maybe_unused stm32_exti_h_resume(void)
 {
 	struct stm32_exti_chip_data *chip_data;
 	int i;
@@ -616,17 +587,22 @@ static void stm32_exti_h_resume(void)
 }
 
 static struct syscore_ops stm32_exti_h_syscore_ops = {
+#ifdef CONFIG_PM_SLEEP
 	.suspend	= stm32_exti_h_suspend,
 	.resume		= stm32_exti_h_resume,
+#endif
 };
 
-static void stm32_exti_h_syscore_init(void)
+static void stm32_exti_h_syscore_init(struct stm32_exti_host_data *host_data)
 {
+	stm32_host_data = host_data;
 	register_syscore_ops(&stm32_exti_h_syscore_ops);
 }
-#else
-static inline void stm32_exti_h_syscore_init(void) {}
-#endif
+
+static void stm32_exti_h_syscore_deinit(void)
+{
+	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
+}
 
 static struct irq_chip stm32_exti_h_chip = {
 	.name			= "stm32-exti-h",
@@ -683,8 +659,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		return NULL;
 
 	host_data->drv_data = dd;
-	host_data->node = node;
-	host_data->hwlock_state = HWSPINLOCK_UNKNOWN;
 	host_data->chips_data = kcalloc(dd->bank_nr,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
@@ -711,7 +685,8 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 
 static struct
 stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
-					   u32 bank_idx)
+					   u32 bank_idx,
+					   struct device_node *node)
 {
 	const struct stm32_exti_bank *stm32_bank;
 	struct stm32_exti_chip_data *chip_data;
@@ -731,7 +706,7 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
 	writel_relaxed(0, base + stm32_bank->emr_ofst);
 
-	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
+	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
 }
@@ -771,7 +746,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 		struct stm32_exti_chip_data *chip_data;
 
 		stm32_bank = drv_data->exti_banks[i];
-		chip_data = stm32_exti_chip_init(host_data, i);
+		chip_data = stm32_exti_chip_init(host_data, i, node);
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
@@ -814,50 +789,130 @@ static const struct irq_domain_ops stm32_exti_h_domain_ops = {
 	.free	= irq_domain_free_irqs_common,
 };
 
-static int
-__init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
-				 struct device_node *node,
-				 struct device_node *parent)
+static void stm32_exti_remove_irq(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
+static int stm32_exti_remove(struct platform_device *pdev)
+{
+	stm32_exti_h_syscore_deinit();
+	return 0;
+}
+
+static int stm32_exti_probe(struct platform_device *pdev)
 {
+	int ret, i;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct irq_domain *parent_domain, *domain;
 	struct stm32_exti_host_data *host_data;
-	int ret, i;
+	const struct stm32_exti_drv_data *drv_data;
+	struct resource *res;
 
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("interrupt-parent not found\n");
-		return -EINVAL;
+	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
+
+	/* check for optional hwspinlock which may be not available yet */
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret == -EPROBE_DEFER)
+		/* hwspinlock framework not yet ready */
+		return ret;
+
+	if (ret >= 0) {
+		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
+		if (!host_data->hwlock) {
+			dev_err(dev, "Failed to request hwspinlock\n");
+			return -EINVAL;
+		}
+	} else if (ret != -ENOENT) {
+		/* note: ENOENT is a valid case (means 'no hwspinlock') */
+		dev_err(dev, "Failed to get hwspinlock\n");
+		return ret;
 	}
 
-	host_data = stm32_exti_host_init(drv_data, node);
-	if (!host_data)
+	/* initialize host_data */
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data) {
+		dev_err(dev, "no of match data\n");
+		return -ENODEV;
+	}
+	host_data->drv_data = drv_data;
+
+	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
+					     sizeof(*host_data->chips_data),
+					     GFP_KERNEL);
+	if (!host_data->chips_data)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	host_data->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(host_data->base)) {
+		dev_err(dev, "Unable to map registers\n");
+		return PTR_ERR(host_data->base);
+	}
+
 	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i);
+		stm32_exti_chip_init(host_data, i, np);
+
+	parent_domain = irq_find_host(of_irq_find_parent(np));
+	if (!parent_domain) {
+		dev_err(dev, "GIC interrupt-parent not found\n");
+		return -EINVAL;
+	}
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0,
 					  drv_data->bank_nr * IRQS_PER_BANK,
-					  node, &stm32_exti_h_domain_ops,
+					  np, &stm32_exti_h_domain_ops,
 					  host_data);
 
 	if (!domain) {
-		pr_err("%pOFn: Could not register exti domain.\n", node);
-		ret = -ENOMEM;
-		goto out_unmap;
+		dev_err(dev, "Could not register exti domain\n");
+		return -ENOMEM;
 	}
 
-	stm32_exti_h_syscore_init();
+	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
+	if (ret)
+		return ret;
+
+	stm32_exti_h_syscore_init(host_data);
 
 	return 0;
+}
 
-out_unmap:
-	iounmap(host_data->base);
-	kfree(host_data->chips_data);
-	kfree(host_data);
-	return ret;
+/* platform driver only for MP1 */
+static const struct of_device_id stm32_exti_ids[] = {
+	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_exti_ids);
+
+static struct platform_driver stm32_exti_driver = {
+	.probe		= stm32_exti_probe,
+	.remove		= stm32_exti_remove,
+	.driver		= {
+		.name	= "stm32_exti",
+		.of_match_table = stm32_exti_ids,
+	},
+};
+
+static int __init stm32_exti_arch_init(void)
+{
+	return platform_driver_register(&stm32_exti_driver);
 }
 
+static void __exit stm32_exti_arch_exit(void)
+{
+	return platform_driver_unregister(&stm32_exti_driver);
+}
+
+arch_initcall(stm32_exti_arch_init);
+module_exit(stm32_exti_arch_exit);
+
+/* no platform driver for F4 and H7 */
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
@@ -873,11 +928,3 @@ static int __init stm32h7_exti_of_init(struct device_node *np,
 }
 
 IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
-
-static int __init stm32mp1_exti_of_init(struct device_node *np,
-					struct device_node *parent)
-{
-	return stm32_exti_hierarchy_init(&stm32mp1_drv_data, np, parent);
-}
-
-IRQCHIP_DECLARE(stm32mp1_exti, "st,stm32mp1-exti", stm32mp1_exti_of_init);
-- 
2.7.4

