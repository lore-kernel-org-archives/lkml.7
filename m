Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23621224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfKTNVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56663 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfKTNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPum-00073W-NM; Wed, 20 Nov 2019 14:21:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 59B431C1A01;
        Wed, 20 Nov 2019 14:21:00 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:00 -0000
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-pdc: Add irqchip set/get state calls
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-8-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-8-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606029.12247.1129726844288422234.tip-bot2@tip-bot2>
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

Commit-ID:     e71374c07564536d38caed3e80a1ff1c4609161d
Gitweb:        https://git.kernel.org/tip/e71374c07564536d38caed3e80a1ff1c4609161d
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:50 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:22:01 

irqchip/qcom-pdc: Add irqchip set/get state calls

Add irqchip calls to set/get interrupt state from the parent interrupt
controller. When GPIOs are renabled as interrupt lines, it is desirable
to clear the interrupt state at the GIC. This avoids any unwanted
interrupt as a result of stale pending state recorded when the line was
used as a GPIO.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
[Lina: updated commit text, rearranged code]
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-8-git-send-email-ilina@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 4f2c762..6ae9e1f 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -5,6 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
@@ -50,6 +51,26 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
+static int qcom_pdc_gic_get_irqchip_state(struct irq_data *d,
+					  enum irqchip_irq_state which,
+					  bool *state)
+{
+	if (d->hwirq == GPIO_NO_WAKE_IRQ)
+		return 0;
+
+	return irq_chip_get_parent_state(d, which, state);
+}
+
+static int qcom_pdc_gic_set_irqchip_state(struct irq_data *d,
+					  enum irqchip_irq_state which,
+					  bool value)
+{
+	if (d->hwirq == GPIO_NO_WAKE_IRQ)
+		return 0;
+
+	return irq_chip_set_parent_state(d, which, value);
+}
+
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out = d->hwirq;
@@ -178,6 +199,8 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_unmask		= qcom_pdc_gic_unmask,
 	.irq_disable		= qcom_pdc_gic_disable,
 	.irq_enable		= qcom_pdc_gic_enable,
+	.irq_get_irqchip_state	= qcom_pdc_gic_get_irqchip_state,
+	.irq_set_irqchip_state	= qcom_pdc_gic_set_irqchip_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
