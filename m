Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC3C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E29222C2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BndzLWYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfJAWtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:49:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34144 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbfJAWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so9185737pfa.1;
        Tue, 01 Oct 2019 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eYw60uWgiucpq0NsOdQOa275Rmsv5UQrIaWUqume84=;
        b=BndzLWYU3N0x4HupmZ04OhEWkaWRJjUwzb40jDKKddfi6Kj+aGjXSenJuPtrADlMpR
         AqKgvnuhBgO9GfuhkqjiJgNIBnXhYuK/Tf5ZFEqC6XUq1GgR7nxs61CBirFAmLoDHk2U
         iKjKMgh++1Bsh+iwebY/mMfG4B+o+EoaHCNhuX6PVzou5G+mEuxgBy3RE7+2lLdcQCY6
         DJUne1NRpmhA0RNd1gQM0dQUgyNp3y4NsxwHKY98MKjH1VyWRy2f3MENfrZnvARcvKry
         /cIpLUAAY1FCy6ZOoe0kRhEqbFphGs8+lAQcLtjQ37VB//s6iBO92Is8av4wopfvx96z
         tSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6eYw60uWgiucpq0NsOdQOa275Rmsv5UQrIaWUqume84=;
        b=aAb29oGO5409V2M05MR3HrqitxWNrFbUW69Hd+/inJfhaETOLgMFp0PWS81va1oxEv
         5uR6Ml3oUsTSS3PaBA45nuuqcXgtzgwI5bf0KQLRbpRMXXCkTsTX8I81OI4sx5e4qTek
         DjSmJn4Gz/d5MGw1zUPbCCveU8xvI9aOnciiqN1rgmJF6yDb9uosL/G5LbihpyGdqNIz
         9uZQWlCF7c/4nWDMTZGI+HWp7ocI82mN3BVbGCrcP/f1IgyZaVGmNS9zvZX/+SoRQ3rK
         eI97c4vGw/ICm5wAlGHC6srt3VPMGyDSq+7B7VpIJYqCGEeIviWlVF5i6mIG/JglFp7b
         rBNA==
X-Gm-Message-State: APjAAAWOx7Emicn1UbSUwkmM3Itk4rTKDOa2NBJpTnFeZJlC+t9VJItW
        Nb1TufEKYGa4x9lesYyEYhFsf05O
X-Google-Smtp-Source: APXvYqztuMn8by8WrfkDSgfAbRBAuNf4fTFiNyfi8g3wBSmKTIuh1Wkid7GbwPKuMueG659hiJVUig==
X-Received: by 2002:a65:49c5:: with SMTP id t5mr233139pgs.373.1569970139174;
        Tue, 01 Oct 2019 15:48:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:48:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 3/7] irqchip/irq-bcm2835: Add support for 7211 interrupt controller
Date:   Tue,  1 Oct 2019 15:48:38 -0700
Message-Id: <20191001224842.9382-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
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

