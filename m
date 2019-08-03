Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF2C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9E20679
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfHCQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:38:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41001 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388205AbfHCQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:38:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htx2o-0000oY-ML; Sat, 03 Aug 2019 18:38:10 +0200
Date:   Sat, 03 Aug 2019 16:36:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.3-rc3
Message-ID: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  a5dbba8f443e: Merge tag 'irqchip-fixes-5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A small bunch of fixes from the irqchip department:
    
  - Fix a couple of UAF on error paths (RZA1, GICv3 ITS)
  - Fix iMX GPCv2 trigger setting
  - Add missing of_node_put() on error path in MBIGEN
  - Add another bunch of /* fall-through */ to silence warnings

Thanks,

	tglx

------------------>
Anders Roxell (1):
      irqchip/gic-v3: Mark expected switch fall-through

Lucas Stach (1):
      irqchip/irq-imx-gpcv2: Forward irq type to parent

Nianyao Tang (1):
      irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail

Nishka Dasgupta (1):
      irqchip/irq-mbigen: Add of_node_put() before return

Wen Yang (1):
      irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe()


 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 drivers/irqchip/irq-gic-v3.c     | 4 ++++
 drivers/irqchip/irq-imx-gpcv2.c  | 1 +
 drivers/irqchip/irq-mbigen.c     | 9 +++++++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 730fbe0e2a9d..1b5c3672aea2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3010,7 +3010,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 
 	if (!its_alloc_vpe_table(vpe_id)) {
 		its_vpe_id_free(vpe_id);
-		its_free_pending_table(vpe->vpt_page);
+		its_free_pending_table(vpt_page);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9bca4896fa6f..96d927f0f91a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -771,8 +771,10 @@ static void gic_cpu_sys_reg_init(void)
 		case 7:
 			write_gicreg(0, ICC_AP0R3_EL1);
 			write_gicreg(0, ICC_AP0R2_EL1);
+		/* Fall through */
 		case 6:
 			write_gicreg(0, ICC_AP0R1_EL1);
+		/* Fall through */
 		case 5:
 		case 4:
 			write_gicreg(0, ICC_AP0R0_EL1);
@@ -786,8 +788,10 @@ static void gic_cpu_sys_reg_init(void)
 	case 7:
 		write_gicreg(0, ICC_AP1R3_EL1);
 		write_gicreg(0, ICC_AP1R2_EL1);
+		/* Fall through */
 	case 6:
 		write_gicreg(0, ICC_AP1R1_EL1);
+		/* Fall through */
 	case 5:
 	case 4:
 		write_gicreg(0, ICC_AP1R0_EL1);
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index bf2237ac5d09..4f74c15c4755 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -131,6 +131,7 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 	.irq_unmask		= imx_gpcv2_irq_unmask,
 	.irq_set_wake		= imx_gpcv2_irq_set_wake,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 #endif
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 3dd28382d5f5..3f09f658e8e2 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -241,12 +241,15 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 
 		parent = platform_bus_type.dev_root;
 		child = of_platform_device_create(np, NULL, parent);
-		if (!child)
+		if (!child) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
+			of_node_put(np);
 			return -EINVAL;
 		}
 
@@ -254,8 +257,10 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 							   mbigen_write_msg,
 							   &mbigen_domain_ops,
 							   mgn_chip);
-		if (!domain)
+		if (!domain) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;

