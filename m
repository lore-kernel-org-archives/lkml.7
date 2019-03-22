Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E23C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FD320693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255340;
	bh=IA7wZ7d2N9CCRdbgs0Fil5bdcSPhHWjCvZpkP/QHN+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TdBosCf7rqmnWAgZqPqDqXSXmSP0pPudOPiFkMf4kpia4PYs7FMjRjDlBQNITq9Hf
	 v1aqvog7RrjhgGvPm2kEwbefm5UO2WPrrRDezps4JlAhuqjc/MjZi0GYgDK2iY2bnO
	 7hZ9IGpdZBnqZauH+Qo84tDQKpBFcvm9gwWT+T38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfCVLs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbfCVLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259752075E;
        Fri, 22 Mar 2019 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255335;
        bh=IA7wZ7d2N9CCRdbgs0Fil5bdcSPhHWjCvZpkP/QHN+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaupSeUzXOy3uBrtvo9Q5+0anA2JD/mO06QjPQHZvvha0dI82d/lRPgdbJ15bo8qw
         BwnbeW+dq/7pYrTYtU0rQFh3YKAEpA4M8iV28r3LJKYfrU2S9F3/7FDzm54KvwNmgY
         7FKzeoMxNhSZ95Ik7IaV5yg4Hgo9mt9A1Cv+QW0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 040/183] ARM: 8824/1: fix a migrating irq bug when hotplug cpu
Date:   Fri, 22 Mar 2019 12:14:28 +0100
Message-Id: <20190322111244.626791208@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d1346a160760..cf69aab648fb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1447,6 +1447,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index b6f319606e30..2de321e89b94 100644
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
index ece04a457486..5b07c7a31c31 100644
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
@@ -119,64 +118,3 @@ int __init arch_probe_nr_irqs(void)
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
index f57333f46242..65f85737c6a2 100644
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



