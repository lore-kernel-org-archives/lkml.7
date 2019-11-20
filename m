Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE485C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0F5224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfKTNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:23:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbfKTNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuq-000756-NS; Wed, 20 Nov 2019 14:21:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F43F1C1A0B;
        Wed, 20 Nov 2019 14:21:01 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:01 -0000
From:   "tip-bot2 for Maulik Shah" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Introduce irq_chip_get/set_parent_state calls
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-7-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-7-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606136.12247.11166423156373394360.tip-bot2@tip-bot2>
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

Commit-ID:     4a169a95d885fe5c050bac1a21d43c86ba955bcf
Gitweb:        https://git.kernel.org/tip/4a169a95d885fe5c050bac1a21d43c86ba955bcf
Author:        Maulik Shah <mkshah@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:49 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:20:02 

genirq: Introduce irq_chip_get/set_parent_state calls

On certain QTI chipsets some GPIOs are direct-connect interrupts to the
GIC to be used as regular interrupt lines. When the GPIOs are not used
for interrupt generation the interrupt line is disabled. But disabling
the interrupt at GIC does not prevent the interrupt to be reported as
pending at GIC_ISPEND. Later, when drivers call enable_irq() on the
interrupt, an unwanted interrupt occurs.

Introduce get and set methods for irqchip's parent to clear it's pending
irq state. This then can be invoked by the GPIO interrupt controller on
the parents in it hierarchy to clear the interrupt before enabling the
interrupt.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-7-git-send-email-ilina@codeaurora.org

[updated commit text and minor code fixes]
---
 include/linux/irq.h |  6 ++++++-
 kernel/irq/chip.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fb301cf..7853eb9 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -610,6 +610,12 @@ extern int irq_chip_pm_put(struct irq_data *data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern void handle_fasteoi_ack_irq(struct irq_desc *desc);
 extern void handle_fasteoi_mask_irq(struct irq_desc *desc);
+extern int irq_chip_set_parent_state(struct irq_data *data,
+				     enum irqchip_irq_state which,
+				     bool val);
+extern int irq_chip_get_parent_state(struct irq_data *data,
+				     enum irqchip_irq_state which,
+				     bool *state);
 extern void irq_chip_enable_parent(struct irq_data *data);
 extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b76703b..b3fa2d8 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1298,6 +1298,50 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
 #endif /* CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS */
 
 /**
+ * irq_chip_set_parent_state - set the state of a parent interrupt.
+ *
+ * @data: Pointer to interrupt specific data
+ * @which: State to be restored (one of IRQCHIP_STATE_*)
+ * @val: Value corresponding to @which
+ *
+ * Conditional success, if the underlying irqchip does not implement it.
+ */
+int irq_chip_set_parent_state(struct irq_data *data,
+			      enum irqchip_irq_state which,
+			      bool val)
+{
+	data = data->parent_data;
+
+	if (!data || !data->chip->irq_set_irqchip_state)
+		return 0;
+
+	return data->chip->irq_set_irqchip_state(data, which, val);
+}
+EXPORT_SYMBOL_GPL(irq_chip_set_parent_state);
+
+/**
+ * irq_chip_get_parent_state - get the state of a parent interrupt.
+ *
+ * @data: Pointer to interrupt specific data
+ * @which: one of IRQCHIP_STATE_* the caller wants to know
+ * @state: a pointer to a boolean where the state is to be stored
+ *
+ * Conditional success, if the underlying irqchip does not implement it.
+ */
+int irq_chip_get_parent_state(struct irq_data *data,
+			      enum irqchip_irq_state which,
+			      bool *state)
+{
+	data = data->parent_data;
+
+	if (!data || !data->chip->irq_get_irqchip_state)
+		return 0;
+
+	return data->chip->irq_get_irqchip_state(data, which, state);
+}
+EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
+
+/**
  * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
  * NULL)
  * @data:	Pointer to interrupt specific data
