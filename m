Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50833C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB88206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392281AbfIFLIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392195AbfIFLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6B-00072g-QV; Fri, 06 Sep 2019 13:08:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 966EC1C0E1C;
        Fri,  6 Sep 2019 13:08:14 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:14 -0000
From:   "tip-bot2 for Andres Salomon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mmp: Mask off interrupts from other cores
Cc:     Andres Salomon <dilinger@queued.net>,
        Lubomir Rintel <lkundrak@v3.sk>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822092643.593488-9-lkundrak@v3.sk>
References: <20190822092643.593488-9-lkundrak@v3.sk>
MIME-Version: 1.0
Message-ID: <156776809457.24167.5698425115585991112.tip-bot2@tip-bot2>
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

Commit-ID:     9e8e8912b05f276dd02d39cb596dc3cf03718377
Gitweb:        https://git.kernel.org/tip/9e8e8912b05f276dd02d39cb596dc3cf03718377
Author:        Andres Salomon <dilinger@queued.net>
AuthorDate:    Thu, 22 Aug 2019 11:26:31 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 30 Aug 2019 15:23:30 +01:00

irqchip/mmp: Mask off interrupts from other cores

On mmp3, there's an extra set of ICU registers (ICU2) that handle
interrupts on the extra cores.  When masking off interrupts on MP1,
these should be masked as well.

We add a new interrupt controller via device tree to identify when we're
looking at an mmp3 machine via compatible field of "marvell,mmp3-intc".

[lkundrak@v3.sk: Changed "mrvl,mmp3-intc" compatible strings to
"marvell,mmp3-intc". Tidied up the subject line a bit.]

Signed-off-by: Andres Salomon <dilinger@queued.net>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20190822092643.593488-9-lkundrak@v3.sk
--
Changes since v1:
- Moved mmp3-specific mmp_icu2_base initialization from mmp_init_bases() to
  mmp3_of_init() so that we don't have to check for marvell,mmp3-intc
  compatibility twice.
- Drop an superfluous call to irq_set_default_host()

 arch/arm/mach-mmp/regs-icu.h |  3 +++
 drivers/irqchip/irq-mmp.c    | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Signed-off-by: Andres Salomon <dilinger@queued.net>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20190822092643.593488-9-lkundrak@v3.sk
---
 arch/arm/mach-mmp/regs-icu.h |  3 ++-
 drivers/irqchip/irq-mmp.c    | 48 +++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-mmp/regs-icu.h b/arch/arm/mach-mmp/regs-icu.h
index 0375d5a..410743d 100644
--- a/arch/arm/mach-mmp/regs-icu.h
+++ b/arch/arm/mach-mmp/regs-icu.h
@@ -11,6 +11,9 @@
 #define ICU_VIRT_BASE	(AXI_VIRT_BASE + 0x82000)
 #define ICU_REG(x)	(ICU_VIRT_BASE + (x))
 
+#define ICU2_VIRT_BASE	(AXI_VIRT_BASE + 0x84000)
+#define ICU2_REG(x)	(ICU2_VIRT_BASE + (x))
+
 #define ICU_INT_CONF(n)		ICU_REG((n) << 2)
 #define ICU_INT_CONF_MASK	(0xf)
 
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index fa23947..da290d8 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -44,6 +44,7 @@ struct icu_chip_data {
 	unsigned int		conf_enable;
 	unsigned int		conf_disable;
 	unsigned int		conf_mask;
+	unsigned int		conf2_mask;
 	unsigned int		clr_mfp_irq_base;
 	unsigned int		clr_mfp_hwirq;
 	struct irq_domain	*domain;
@@ -53,9 +54,11 @@ struct mmp_intc_conf {
 	unsigned int	conf_enable;
 	unsigned int	conf_disable;
 	unsigned int	conf_mask;
+	unsigned int	conf2_mask;
 };
 
 static void __iomem *mmp_icu_base;
+static void __iomem *mmp_icu2_base;
 static struct icu_chip_data icu_data[MAX_ICU_NR];
 static int max_icu_nr;
 
@@ -98,6 +101,16 @@ static void icu_mask_irq(struct irq_data *d)
 		r &= ~data->conf_mask;
 		r |= data->conf_disable;
 		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
+
+		if (data->conf2_mask) {
+			/*
+			 * ICU1 (above) only controls PJ4 MP1; if using SMP,
+			 * we need to also mask the MP2 and MM cores via ICU2.
+			 */
+			r = readl_relaxed(mmp_icu2_base + (hwirq << 2));
+			r &= ~data->conf2_mask;
+			writel_relaxed(r, mmp_icu2_base + (hwirq << 2));
+		}
 	} else {
 		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
 		writel_relaxed(r, data->reg_mask);
@@ -201,6 +214,14 @@ static const struct mmp_intc_conf mmp2_conf = {
 			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
+static struct mmp_intc_conf mmp3_conf = {
+	.conf_enable	= 0x20,
+	.conf_disable	= 0x0,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
+	.conf2_mask	= 0xf0,
+};
+
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
 {
 	int hwirq;
@@ -426,6 +447,33 @@ static int __init mmp2_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
 
+static int __init mmp3_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	int ret;
+
+	mmp_icu2_base = of_iomap(node, 1);
+	if (!mmp_icu2_base) {
+		pr_err("Failed to get interrupt controller register #2\n");
+		return -ENODEV;
+	}
+
+	ret = mmp_init_bases(node);
+	if (ret < 0) {
+		iounmap(mmp_icu2_base);
+		return ret;
+	}
+
+	icu_data[0].conf_enable = mmp3_conf.conf_enable;
+	icu_data[0].conf_disable = mmp3_conf.conf_disable;
+	icu_data[0].conf_mask = mmp3_conf.conf_mask;
+	icu_data[0].conf2_mask = mmp3_conf.conf2_mask;
+	set_handle_irq(mmp2_handle_irq);
+	max_icu_nr = 1;
+	return 0;
+}
+IRQCHIP_DECLARE(mmp3_intc, "marvell,mmp3-intc", mmp3_of_init);
+
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
