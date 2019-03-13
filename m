Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C97CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5CB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505673;
	bh=Ppn8+bdfsUUwtWZ7R6Za/wGqhmWCoKfSGXIn6qJvydM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f5872G1x7DdyOryB+ZwynVHjO9YkwuF3eCirRBD4QVXS94ai3onpIU5vQlrTC9Qxw
	 R4KTQqtAqSycgLd/ToF84sweLYnQemEk9+zIaROTgp5r6jX+oI26/7ZcfpoH7+K39N
	 CEP6f7VFQvEjJvs47ZeHZRHD4YC1mjwu3Mk6sFy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCMTeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfCMTKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B222146E;
        Wed, 13 Mar 2019 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504232;
        bh=Ppn8+bdfsUUwtWZ7R6Za/wGqhmWCoKfSGXIn6qJvydM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuJDfzFfD26GDduFxkZRYzhBifhu+stXD+vAJVE6+ioy6rKtMr48ouN9gFyy/uBFj
         CQikI8mxTvSN+9hm/rHQfpP2EOEkD8pr+uDVxik+jMbp/B75OileCy66gNp4AW5IqF
         QDNyvCSwN17KEZtYnjAw9rCrw4ibHrdzHGhrIiTo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 05/60] ARM: 8824/1: fix a migrating irq bug when hotplug cpu
Date:   Wed, 13 Mar 2019 15:09:26 -0400
Message-Id: <20190313191021.158171-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

[ Upstream commit 1b5ba350784242eb1f899bcffd95d2c7cff61e84 ]

Arm TC2 fails cpu hotplug stress test.

This issue was tracked down to a missing copy of the new affinity
cpumask for the vexpress-spc interrupt into struct
irq_common_data.affinity when the interrupt is migrated in
migrate_one_irq().

Fix it by replacing the arm specific hotplug cpu migration with the
generic irq code.

This is the counterpart implementation to commit 217d453d473c ("arm64:
fix a migrating irq bug when hotplug cpu").

Tested with cpu hotplug stress test on Arm TC2 (multi_v7_defconfig plus
CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y).
The vexpress-spc interrupt (irq=22) on this board is affine to CPU0.
Its affinity cpumask now changes correctly e.g. from 0 to 1-4 when
CPU0 is hotplugged out.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/irq.h |  1 -
 arch/arm/kernel/irq.c      | 62 --------------------------------------
 arch/arm/kernel/smp.c      |  2 +-
 4 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d8df65..428ea6debcc6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1443,6 +1443,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index c883fcbe93b6..46d41140df27 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -25,7 +25,6 @@
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
-extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9908dacf9229..844861368cd5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -31,7 +31,6 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
@@ -109,64 +108,3 @@ int __init arch_probe_nr_irqs(void)
 	return nr_irqs;
 }
 #endif
-
-#ifdef CONFIG_HOTPLUG_CPU
-static bool migrate_one_irq(struct irq_desc *desc)
-{
-	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
-	struct irq_chip *c;
-	bool ret = false;
-
-	/*
-	 * If this is a per-CPU interrupt, or the affinity does not
-	 * include this CPU, then we have nothing to do.
-	 */
-	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
-		return false;
-
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
-		ret = true;
-	}
-
-	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
-		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
-
-	return ret;
-}
-
-/*
- * The current CPU has been marked offline.  Migrate IRQs off this CPU.
- * If the affinity settings do not allow other CPUs, force them onto any
- * available CPU.
- *
- * Note: we must iterate over all IRQs, whether they have an attached
- * action structure or not, as we need to get chained interrupts too.
- */
-void migrate_irqs(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	for_each_irq_desc(i, desc) {
-		bool affinity_broken;
-
-		raw_spin_lock(&desc->lock);
-		affinity_broken = migrate_one_irq(desc);
-		raw_spin_unlock(&desc->lock);
-
-		if (affinity_broken)
-			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
-				i, smp_processor_id());
-	}
-
-	local_irq_restore(flags);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3bf82232b1be..1d6f5ea522f4 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -254,7 +254,7 @@ int __cpu_disable(void)
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
-	migrate_irqs();
+	irq_migrate_all_off_this_cpu();
 
 	/*
 	 * Flush user cache and TLB mappings, and then remove this CPU
-- 
2.19.1

