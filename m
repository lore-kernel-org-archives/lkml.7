Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB5FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE8E20830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvD3aFqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbfIMXXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:23:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38370 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404236AbfIMXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so16047812pgo.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eYw60uWgiucpq0NsOdQOa275Rmsv5UQrIaWUqume84=;
        b=dvD3aFqUY6LgGTZVTpIcsbJrFu853dWhhlI8S2bMfs83jr4oySTL6/Ido+Wq21dR/S
         Bxp/9RZnKH0UQPUq4IIxV3Ku7TbH4+IcFKKIE2N/uE5K4Z2NKd+7cEcB0ayyCYCTTxp0
         z51o6bXbkIZQcXpw9u5tvdHhFKN5+KFFGrkeP4kWyc2MZZGPyOO+5mG80HzdrdCEDbc/
         bj/9SqFF9EzgPLP2HyY6ERtherkiV6aOZCFsVNcbCwnguq1tOOSoX/aKSsGfTx38DB3u
         dtZwlPGfFHO9owkaSa2jZyXO5BHzQ3t0/SESUF2z6bwuDcQa/uAwL2vgiX5wK45RlDg9
         7dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eYw60uWgiucpq0NsOdQOa275Rmsv5UQrIaWUqume84=;
        b=T3Q8zw4QeyXqLy/WXlh9eu44srYmYuhakla2A/h9St0y6WNGBT2nXXoHM0hdvL82eW
         1ZLhO+TndKHyJRYL59TZgTMOgFxQ54z0DJ72wk05qxkODQ5D1VdXu0FeDDdn5l3HW3Cx
         aK69pKP8YTOb05sq0KnVwu2ZaIB1RKwlK4vj/lXBZmziDWqVaCKoXH8ll+BhsHxTrzq6
         punDBcth+OL+zYj/lXWd3JqB5Cagi3qdIF3E0lyYeUVOFJUVIGpZkmLWqFwggqCD5Yc/
         KY6S9bmnNiAmomiFpvnAhzQEO2zBytxLMNTJcQeXDtqbduw3JLzuoD5bXMhwvClGt+8h
         X4kA==
X-Gm-Message-State: APjAAAVvmsrQNMgA4PX1nAY9wIGlMCqpyLeTTo87NGJyHVOCLWe1lQyk
        fPDNGcT0f7sBBIL5fM0ZZTj0Ee+pn8U=
X-Google-Smtp-Source: APXvYqxols2DrPKF4q2IEsc9zRbPegqIph0CtL06LycuSAYmkzVy2nEs6PP6A+n02zIR8u0q/whFsg==
X-Received: by 2002:a63:784c:: with SMTP id t73mr46896894pgc.268.1568416967754;
        Fri, 13 Sep 2019 16:22:47 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:47 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/7] irqchip/irq-bcm2835: Add support for 7211 interrupt controller
Date:   Fri, 13 Sep 2019 16:22:32 -0700
Message-Id: <20190913232236.10200-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 has a number of similarities with BCM2836, except the register
offsets are different and the bank bits are also different, account for
all of these differences.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm2835.c | 86 +++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 418245d31921..55afc3487723 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -57,19 +57,34 @@
 #define SHORTCUT_SHIFT		10
 #define BANK1_HWIRQ		BIT(8)
 #define BANK2_HWIRQ		BIT(9)
+#define BANK1_HWIRQ_BCM7211	BIT(24)
+#define BANK2_HWIRQ_BCM7211	BIT(25)
 #define BANK0_VALID_MASK	(BANK0_HWIRQ_MASK | BANK1_HWIRQ | BANK2_HWIRQ \
 					| SHORTCUT1_MASK | SHORTCUT2_MASK)
+#define BANK0_VALID_MASK_BCM7211 (BANK0_HWIRQ_MASK | BANK1_HWIRQ_BCM7211 | \
+				  BANK2_HWIRQ_BCM7211 | SHORTCUT1_MASK | \
+				  SHORTCUT2_MASK)
 
 #define REG_FIQ_CONTROL		0x0c
 
 #define NR_BANKS		3
 #define IRQS_PER_BANK		32
 
+enum armctrl_type {
+	ARMCTRL_BCM2835 = 0,
+	ARMCTRL_BCM2836,
+	ARMCTRL_BCM7211
+};
+
 static const int reg_pending[] __initconst = { 0x00, 0x04, 0x08 };
 static const int reg_enable[] __initconst = { 0x18, 0x10, 0x14 };
 static const int reg_disable[] __initconst = { 0x24, 0x1c, 0x20 };
 static const int bank_irqs[] __initconst = { 8, 32, 32 };
 
+static const int reg_pending_bcm7211[] __initconst = { 0x08, 0x00, 0x04 };
+static const int reg_enable_bcm7211[] __initconst = { 0x18, 0x10, 0x14 };
+static const int reg_disable_bcm7211[] __initconst = { 0x28, 0x20, 0x24 };
+
 static const int shortcuts[] = {
 	7, 9, 10, 18, 19,		/* Bank 1 */
 	21, 22, 23, 24, 25, 30		/* Bank 2 */
@@ -87,6 +102,7 @@ static struct armctrl_ic intc __read_mostly;
 static void __exception_irq_entry bcm2835_handle_irq(
 	struct pt_regs *regs);
 static void bcm2836_chained_handle_irq(struct irq_desc *desc);
+static void bcm7211_chained_handle_irq(struct irq_desc *desc);
 
 static void armctrl_mask_irq(struct irq_data *d)
 {
@@ -131,11 +147,14 @@ static const struct irq_domain_ops armctrl_ops = {
 
 static int __init armctrl_of_init(struct device_node *node,
 				  struct device_node *parent,
-				  bool is_2836)
+				  enum armctrl_type type)
 {
 	void __iomem *base;
 	int irq, b, i;
 
+	if (type > ARMCTRL_BCM7211)
+		return -EINVAL;
+
 	base = of_iomap(node, 0);
 	if (!base)
 		panic("%pOF: unable to map IC registers\n", node);
@@ -146,9 +165,19 @@ static int __init armctrl_of_init(struct device_node *node,
 		panic("%pOF: unable to create IRQ domain\n", node);
 
 	for (b = 0; b < NR_BANKS; b++) {
-		intc.pending[b] = base + reg_pending[b];
-		intc.enable[b] = base + reg_enable[b];
-		intc.disable[b] = base + reg_disable[b];
+		if (type <= ARMCTRL_BCM2836) {
+			intc.pending[b] = base + reg_pending[b];
+			intc.enable[b] = base + reg_enable[b];
+			intc.disable[b] = base + reg_disable[b];
+		} else {
+			intc.pending[b] = base + reg_pending_bcm7211[b];
+			intc.enable[b] = base + reg_enable_bcm7211[b];
+			intc.disable[b] = base + reg_disable_bcm7211[b];
+		}
+
+		if (type == ARMCTRL_BCM7211)
+			armctrl_chip.flags |= IRQCHIP_MASK_ON_SUSPEND |
+					      IRQCHIP_SKIP_SET_WAKE;
 
 		for (i = 0; i < bank_irqs[b]; i++) {
 			irq = irq_create_mapping(intc.domain, MAKE_HWIRQ(b, i));
@@ -159,14 +188,19 @@ static int __init armctrl_of_init(struct device_node *node,
 		}
 	}
 
-	if (is_2836) {
+	if (type >= ARMCTRL_BCM2836) {
 		int parent_irq = irq_of_parse_and_map(node, 0);
 
 		if (!parent_irq) {
 			panic("%pOF: unable to get parent interrupt.\n",
 			      node);
 		}
-		irq_set_chained_handler(parent_irq, bcm2836_chained_handle_irq);
+		if (type == ARMCTRL_BCM2836)
+			irq_set_chained_handler(parent_irq,
+						bcm2836_chained_handle_irq);
+		else
+			irq_set_chained_handler(parent_irq,
+						bcm7211_chained_handle_irq);
 	} else {
 		set_handle_irq(bcm2835_handle_irq);
 	}
@@ -177,13 +211,19 @@ static int __init armctrl_of_init(struct device_node *node,
 static int __init bcm2835_armctrl_of_init(struct device_node *node,
 					  struct device_node *parent)
 {
-	return armctrl_of_init(node, parent, false);
+	return armctrl_of_init(node, parent, ARMCTRL_BCM2835);
 }
 
 static int __init bcm2836_armctrl_of_init(struct device_node *node,
 					  struct device_node *parent)
 {
-	return armctrl_of_init(node, parent, true);
+	return armctrl_of_init(node, parent, ARMCTRL_BCM2836);
+}
+
+static int __init bcm7211_armctrl_of_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	return armctrl_of_init(node, parent, ARMCTRL_BCM7211);
 }
 
 
@@ -205,9 +245,11 @@ static u32 armctrl_translate_shortcut(int bank, u32 stat)
 	return MAKE_HWIRQ(bank, shortcuts[ffs(stat >> SHORTCUT_SHIFT) - 1]);
 }
 
-static u32 get_next_armctrl_hwirq(void)
+static u32 get_next_armctrl_hwirq(u32 valid_mask,
+				  u32 bank1_mask,
+				  u32 bank2_mask)
 {
-	u32 stat = readl_relaxed(intc.pending[0]) & BANK0_VALID_MASK;
+	u32 stat = readl_relaxed(intc.pending[0]) & valid_mask;
 
 	if (stat == 0)
 		return ~0;
@@ -217,9 +259,9 @@ static u32 get_next_armctrl_hwirq(void)
 		return armctrl_translate_shortcut(1, stat & SHORTCUT1_MASK);
 	else if (stat & SHORTCUT2_MASK)
 		return armctrl_translate_shortcut(2, stat & SHORTCUT2_MASK);
-	else if (stat & BANK1_HWIRQ)
+	else if (stat & bank1_mask)
 		return armctrl_translate_bank(1);
-	else if (stat & BANK2_HWIRQ)
+	else if (stat & bank2_mask)
 		return armctrl_translate_bank(2);
 	else
 		BUG();
@@ -230,7 +272,9 @@ static void __exception_irq_entry bcm2835_handle_irq(
 {
 	u32 hwirq;
 
-	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
+	while ((hwirq = get_next_armctrl_hwirq(BANK0_VALID_MASK,
+					       BANK1_HWIRQ,
+					       BANK2_HWIRQ)) != ~0)
 		handle_domain_irq(intc.domain, hwirq, regs);
 }
 
@@ -238,7 +282,19 @@ static void bcm2836_chained_handle_irq(struct irq_desc *desc)
 {
 	u32 hwirq;
 
-	while ((hwirq = get_next_armctrl_hwirq()) != ~0)
+	while ((hwirq = get_next_armctrl_hwirq(BANK0_VALID_MASK,
+					       BANK1_HWIRQ,
+					       BANK2_HWIRQ)) != ~0)
+		generic_handle_irq(irq_linear_revmap(intc.domain, hwirq));
+}
+
+static void bcm7211_chained_handle_irq(struct irq_desc *desc)
+{
+	u32 hwirq;
+
+	while ((hwirq = get_next_armctrl_hwirq(BANK0_VALID_MASK_BCM7211,
+					       BANK1_HWIRQ_BCM7211,
+					       BANK2_HWIRQ_BCM7211)) != ~0)
 		generic_handle_irq(irq_linear_revmap(intc.domain, hwirq));
 }
 
@@ -246,3 +302,5 @@ IRQCHIP_DECLARE(bcm2835_armctrl_ic, "brcm,bcm2835-armctrl-ic",
 		bcm2835_armctrl_of_init);
 IRQCHIP_DECLARE(bcm2836_armctrl_ic, "brcm,bcm2836-armctrl-ic",
 		bcm2836_armctrl_of_init);
+IRQCHIP_DECLARE(bcm7211_armctrl_ic, "brcm,bcm7211-armctrl-ic",
+		bcm7211_armctrl_of_init);
-- 
2.17.1

