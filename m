Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F866C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAE221537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfGKUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:05:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfGKUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:05:17 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlfJa-0005Rb-Tf; Thu, 11 Jul 2019 22:05:15 +0200
Date:   Thu, 11 Jul 2019 20:02:36 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.3-rc1
References: <156287535656.8320.16630272660351040656.tglx@nanos.tec.linutronix.de>
Message-ID: <156287535656.8320.2782582303624911598.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  20faba848752: irqchip/gic-v3-its: Fix misuse of GENMASK macro

Two small fixes for interrupt chip drivers:

    - Prevent UAF in the new RZA1 chip driver

    - Fix the wrong argument order of the GENMASK macro in the GIC code

Thanks,

	tglx

------------------>
Joe Perches (1):
      irqchip/gic-v3-its: Fix misuse of GENMASK macro

Wen Yang (1):
      irqchip/renesas-rza1: Prevent use-after-free in rza1_irqc_probe()


 drivers/irqchip/irq-gic-v3-its.c   |  2 +-
 drivers/irqchip/irq-renesas-rza1.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 35500801dc2b..730fbe0e2a9d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -185,7 +185,7 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 
 static struct its_collection *valid_col(struct its_collection *col)
 {
-	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(0, 15)))
+	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(15, 0)))
 		return NULL;
 
 	return col;
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index b1f19b210190..b0d46ac42b89 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -208,20 +208,19 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	gic_node = of_irq_find_parent(np);
-	if (gic_node) {
+	if (gic_node)
 		parent = irq_find_host(gic_node);
-		of_node_put(gic_node);
-	}
 
 	if (!parent) {
 		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	ret = rza1_irqc_parse_map(priv, gic_node);
 	if (ret) {
 		dev_err(dev, "cannot parse %s: %d\n", "interrupt-map", ret);
-		return ret;
+		goto out_put_node;
 	}
 
 	priv->chip.name = "rza1-irqc",
@@ -237,10 +236,12 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 						    priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(gic_node);
+	return ret;
 }
 
 static int rza1_irqc_remove(struct platform_device *pdev)

