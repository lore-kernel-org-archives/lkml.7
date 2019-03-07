Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30106C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78FE2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGQYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:24:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfCGQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:24:09 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27GBGfO011976;
        Thu, 7 Mar 2019 17:23:55 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r315ut3eq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 07 Mar 2019 17:23:55 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 435AE31;
        Thu,  7 Mar 2019 16:23:55 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 12F8F53E5;
        Thu,  7 Mar 2019 16:23:55 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019
 17:23:55 +0100
Received: from localhost (10.129.4.33) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 7 Mar 2019 17:23:54 +0100
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
Subject: [PATCH] irqchip: stm32: add a second level init to request hwspinlock
Date:   Thu, 7 Mar 2019 17:23:49 +0100
Message-ID: <1551975829-16350-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.33]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting hwspinlock, at the first time it is used, is not correct:
indeed, at that moment we are under raw_spin_lock_irqsave() context and
hwspin_lock_request_specific() may sleep ("BUG: sleeping function called
from invalid context").
Requesting hwspinlock during the init (stm32*_exti_of_init()) is also
not possible (the hwspinlock framework is not ready at that stage of the
kernel init).
As a consequence, add a second level init (probed with arch_initcall)
where we can safely request hwspinlock.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 160 +++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 58 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 6edfd4b..2a5cc00 100644
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
 
@@ -683,8 +655,6 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 		return NULL;
 
 	host_data->drv_data = dd;
-	host_data->node = node;
-	host_data->hwlock_state = HWSPINLOCK_UNKNOWN;
 	host_data->chips_data = kcalloc(dd->bank_nr,
 					sizeof(struct stm32_exti_chip_data),
 					GFP_KERNEL);
@@ -711,7 +681,8 @@ stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 
 static struct
 stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
-					   u32 bank_idx)
+					   u32 bank_idx,
+					   struct device_node *node)
 {
 	const struct stm32_exti_bank *stm32_bank;
 	struct stm32_exti_chip_data *chip_data;
@@ -741,7 +712,7 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
 		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
-	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
+	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
 }
@@ -781,7 +752,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 		struct stm32_exti_chip_data *chip_data;
 
 		stm32_bank = drv_data->exti_banks[i];
-		chip_data = stm32_exti_chip_init(host_data, i);
+		chip_data = stm32_exti_chip_init(host_data, i, node);
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
@@ -844,7 +815,7 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 		return -ENOMEM;
 
 	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i);
+		stm32_exti_chip_init(host_data, i, node);
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0,
 					  drv_data->bank_nr * IRQS_PER_BANK,
@@ -868,6 +839,71 @@ __init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
 	return ret;
 }
 
+/* Note : stm32_exti_probe() is called after stm32*_exti_of_init() */
+static int stm32_exti_probe(struct platform_device *pdev)
+{
+	int id, ret = 0;
+
+	id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
+
+	if (id == -EPROBE_DEFER)
+		/* hwspinlock framework not ready */
+		return -EPROBE_DEFER;
+
+	if (id == -ENOENT)
+		/* no hwspinlock defined (not an error, it is optional) */
+		return 0;
+
+	if (id >= 0) {
+		stm32_host_data->hwlock = hwspin_lock_request_specific(id);
+		if (!stm32_host_data->hwlock) {
+			dev_err(&pdev->dev, "Failed to request hwspinlock\n");
+			ret = -EINVAL;
+		}
+	} else {
+		dev_err(&pdev->dev, "Failed to get hwspinlock\n");
+		ret = id;
+	}
+
+	return ret;
+}
+
+static int stm32_exti_remove(struct platform_device *pdev)
+{
+	if (stm32_host_data->hwlock)
+		return hwspin_lock_free(stm32_host_data->hwlock);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_exti_ids[] = {
+	{ .compatible = "st,stm32mp1-exti", },
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
+}
+
+static void __exit stm32_exti_arch_exit(void)
+{
+	return platform_driver_unregister(&stm32_exti_driver);
+}
+
+arch_initcall(stm32_exti_arch_init);
+module_exit(stm32_exti_arch_exit);
+
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
@@ -887,7 +923,15 @@ IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
 static int __init stm32mp1_exti_of_init(struct device_node *np,
 					struct device_node *parent)
 {
-	return stm32_exti_hierarchy_init(&stm32mp1_drv_data, np, parent);
+	int ret;
+
+	ret = stm32_exti_hierarchy_init(&stm32mp1_drv_data, np, parent);
+
+	/* Clear the OF_POPULATED flag so that stm32_exti_probe can be called */
+	if (!ret)
+		of_node_clear_flag(np, OF_POPULATED);
+
+	return ret;
 }
 
 IRQCHIP_DECLARE(stm32mp1_exti, "st,stm32mp1-exti", stm32mp1_exti_of_init);
-- 
2.7.4

