Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73ACC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40E2224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfKTNXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:23:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56669 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfKTNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPun-00074R-5t; Wed, 20 Nov 2019 14:21:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D2E201C1998;
        Wed, 20 Nov 2019 14:21:00 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:00 -0000
From:   "tip-bot2 for Lina Iyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-pdc: Do not toggle IRQ_ENABLE during mask/unmask
Cc:     Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-4-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-4-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606074.12247.1499986640247864555.tip-bot2@tip-bot2>
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

Commit-ID:     da3f875a4189e643f8eec7f0bffa39c90d3418c6
Gitweb:        https://git.kernel.org/tip/da3f875a4189e643f8eec7f0bffa39c90d3418c6
Author:        Lina Iyer <ilina@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:46 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:20:49 

irqchip/qcom-pdc: Do not toggle IRQ_ENABLE during mask/unmask

When an interrupt is to be serviced, the convention is to mask the
interrupt at the chip and unmask after servicing the interrupt. Enabling
and disabling the interrupt at the PDC irqchip causes an interrupt storm
due to the way dual edge interrupts are handled in hardware.

Skip configuring the PDC when the IRQ is masked and unmasked, instead
use the irq_enable/irq_disable callbacks to toggle the IRQ_ENABLE
register at the PDC. The PDC's IRQ_ENABLE register is only used during
the monitoring mode when the system is asleep and is not needed for
active mode detection.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-4-git-send-email-ilina@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 690cf10..527c29e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -63,15 +63,25 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 	raw_spin_unlock(&pdc_lock);
 }
 
-static void qcom_pdc_gic_mask(struct irq_data *d)
+static void qcom_pdc_gic_disable(struct irq_data *d)
 {
 	pdc_enable_intr(d, false);
+	irq_chip_disable_parent(d);
+}
+
+static void qcom_pdc_gic_enable(struct irq_data *d)
+{
+	pdc_enable_intr(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static void qcom_pdc_gic_mask(struct irq_data *d)
+{
 	irq_chip_mask_parent(d);
 }
 
 static void qcom_pdc_gic_unmask(struct irq_data *d)
 {
-	pdc_enable_intr(d, true);
 	irq_chip_unmask_parent(d);
 }
 
@@ -148,6 +158,8 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= qcom_pdc_gic_mask,
 	.irq_unmask		= qcom_pdc_gic_unmask,
+	.irq_disable		= qcom_pdc_gic_disable,
+	.irq_enable		= qcom_pdc_gic_enable,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= qcom_pdc_gic_set_type,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
