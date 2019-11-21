Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0F2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF344208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUFCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:02:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:36406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfKUFCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B77BB00A;
        Thu, 21 Nov 2019 05:02:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v5 3/9] irqchip: rtd1195-mux: Implement irq_get_irqchip_state
Date:   Thu, 21 Nov 2019 06:02:02 +0100
Message-Id: <20191121050208.11324-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the .irq_get_irqchip_state callback to retrieve pending,
active and masked interrupt status.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v5: New
 
 drivers/irqchip/irq-rtd1195-mux.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/irqchip/irq-rtd1195-mux.c b/drivers/irqchip/irq-rtd1195-mux.c
index 0e86973aafca..2f1bcfd9d5d6 100644
--- a/drivers/irqchip/irq-rtd1195-mux.c
+++ b/drivers/irqchip/irq-rtd1195-mux.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitops.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -96,10 +97,45 @@ static void rtd1195_mux_unmask_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&mux->lock, flags);
 }
 
+static int rtd1195_mux_get_irqchip_state(struct irq_data *data,
+	enum irqchip_irq_state which, bool *state)
+{
+	struct rtd1195_irq_mux_data *mux = irq_data_get_irq_chip_data(data);
+	u32 val;
+
+	switch (which) {
+	case IRQCHIP_STATE_PENDING:
+		/*
+		 * UMSK_ISR provides the unmasked pending interrupts,
+		 * except UART and I2C.
+		 */
+		val = readl_relaxed(mux->reg_umsk_isr);
+		*state = !!(val & BIT(data->hwirq));
+		break;
+	case IRQCHIP_STATE_ACTIVE:
+		/*
+		 * ISR provides the masked pending interrupts,
+		 * including UART and I2C.
+		 */
+		val = readl_relaxed(mux->reg_isr);
+		*state = !!(val & BIT(data->hwirq));
+		break;
+	case IRQCHIP_STATE_MASKED:
+		val = mux->info->isr_to_int_en_mask[data->hwirq];
+		*state = !(mux->scpu_int_en & val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct irq_chip rtd1195_mux_irq_chip = {
 	.irq_ack		= rtd1195_mux_ack_irq,
 	.irq_mask		= rtd1195_mux_mask_irq,
 	.irq_unmask		= rtd1195_mux_unmask_irq,
+	.irq_get_irqchip_state	= rtd1195_mux_get_irqchip_state,
 };
 
 static int rtd1195_mux_irq_domain_map(struct irq_domain *d,
-- 
2.16.4

