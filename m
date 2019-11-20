Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A122429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfKTKmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:42:24 -0500
Received: from foss.arm.com ([217.140.110.172]:37092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfKTKmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:42:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 269311FB;
        Wed, 20 Nov 2019 02:42:23 -0800 (PST)
Received: from macbook.cambridge.arm.com (macbook.cambridge.arm.com [10.1.194.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25F2B3F6C4;
        Wed, 20 Nov 2019 02:42:22 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC
Date:   Wed, 20 Nov 2019 10:42:12 +0000
Message-Id: <20191120104212.14791-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca74b316df96 ("arm: Use common cpu_topology structure and
functions.") changed cpu_coregroup_mask() from the ARM32 specific
implementation in arch/arm/include/asm/topology.h to the one shared
with ARM64 and RISCV in drivers/base/arch_topology.c.

Currently on Arm32 (TC2 w/ CONFIG_SCHED_MC) the task scheduler setup
code (w/ CONFIG_SCHED_DEBUG) shows this during CPU hotplug:

  ERROR: groups don't span domain->span

It happens to CPUs of the cluster of the CPU which gets hot-plugged
out on scheduler domain MC.

Turns out that the shared cpu_coregroup_mask() requires that the
hot-plugged CPU is removed from the core_sibling mask via
remove_cpu_topology(). Otherwise the 'is core_sibling subset of
cpumask_of_node()' doesn't work. In this case the task scheduler has to
deal with cpumask_of_node instead of core_sibling which is wrong on
scheduler domain MC.

e.g. CPU3 hot-plugged out on TC2 [cluster0: 0,3-4 cluster1: 1-2]:

  cpu_coregroup_mask(): CPU3 cpumask_of_node=0-2,4 core_sibling=0,3-4
                                                                  ^
should be:

  cpu_coregroup_mask(): CPU3 cpumask_of_node=0-2,4 core_sibling=0,4

Add remove_cpu_topology() to __cpu_disable() to remove the CPU from the
topology masks in case of a CPU hotplug out operation.

At the same time tweak store_cpu_topology() slightly so it will call
update_siblings_masks() in case of CPU hotplug in operation via
secondary_start_kernel()->smp_store_cpu_info().

This aligns the Arm32 implementation with the Arm64 one.

Fixes: ca74b316df96 ("arm: Use common cpu_topology structure and functions")
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/smp.c      |  2 ++
 arch/arm/kernel/topology.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4b0bab2607e4..139c0d98fa29 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -240,6 +240,8 @@ int __cpu_disable(void)
 	if (ret)
 		return ret;
 
+	remove_cpu_topology(cpu);
+
 	/*
 	 * Take this CPU offline.  Once we clear this, we can't return,
 	 * and we must not schedule until we're ready to give up the cpu.
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 5b9faba03afb..b37b0a340991 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -196,9 +196,8 @@ void store_cpu_topology(unsigned int cpuid)
 	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
 
-	/* If the cpu topology has been already set, just return */
-	if (cpuid_topo->core_id != -1)
-		return;
+	if (cpuid_topo->package_id != -1)
+		goto topology_populated;
 
 	mpidr = read_cpuid_mpidr();
 
@@ -231,14 +230,14 @@ void store_cpu_topology(unsigned int cpuid)
 		cpuid_topo->package_id = -1;
 	}
 
-	update_siblings_masks(cpuid);
-
 	update_cpu_capacity(cpuid);
 
 	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
-		cpuid, cpu_topology[cpuid].thread_id,
-		cpu_topology[cpuid].core_id,
-		cpu_topology[cpuid].package_id, mpidr);
+		cpuid, cpuid_topo->thread_id, cpuid_topo->core_id,
+		cpuid_topo->package_id, mpidr);
+
+topology_populated:
+	update_siblings_masks(cpuid);
 }
 
 static inline int cpu_corepower_flags(void)
-- 
2.17.1

