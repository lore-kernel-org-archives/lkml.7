Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF9C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C552077B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 00:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h4fnttuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfD1A0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 20:26:22 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14543 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfD1A0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 20:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556411165; x=1587947165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rVPoCD5BlHsJ95B8dgXdUATFK4bPwMva+LB3eiX0SU=;
  b=h4fnttuCbSCRxE5keEQXQ+eiE9vpjJA5EASgclq095FFiywvFfoVJi+9
   evNvbfHQaYZK5PXf1n6EiJvwSJwiQbj8s+5Jv68Uu93ybZieWYKeku3ht
   x/bVdBj0zn4ZIQINvZ6XK1f+Bh7kPtFiL12ti2aAaqRn0d5GFQlts3iz+
   617tJWo0qyV2dO4PyQXN8hJtJFRUb08DUK4Ikn2wa7dMetOGJYuq/vYsM
   zf8XebIUmJQLeqnwy2S+ue7QY2E5aKdQnJL7OkfpCHQ1rSsOwRt6fGWWE
   auxPwnl2gQsWVZuueoPpmC79VKN+eHVMJO2XDfInBV5WMEpM0Kt3NpxeL
   w==;
X-IronPort-AV: E=Sophos;i="5.60,403,1549900800"; 
   d="scan'208";a="106993914"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2019 08:26:04 +0800
IronPort-SDR: EKOqW4fMOfK/iQYXOGATfD//p8z0OccT2TouXG067wDRuzEv1MycQR28t3LozwHFVEENN+D34E
 JQANyEpQld8b1Xejf8BooghUBCaqorSvPd5DFWYCI5F5KAaPXdtCNhWLskyQOzB0xAYwejLRCL
 dqViPPMwK6T0UzphziYCY79iB4lTn4PskMG0Or9aDMH2vyoGNu/4+iL4DcTPCkerxjvvYEr/hi
 i/8TZvEGWpFT2sNwsNCUa3cgT7bMMU06dbiP9UGFEjNtV08BL8IUe805Xcrn5Y5YHeyyUqErOU
 wOxbz4wOSd+8NcTB74XhWSk9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 27 Apr 2019 17:04:38 -0700
IronPort-SDR: ltUlUTYn/58wRG+/RVw7qGwsTvbacJK3sXk6CNOoVf5WWLpeSY44FU45733acXs75cZpnk7/uZ
 ED9bSdcxNtin1ZHUE/pCHoufeGJdyHEqbzTYHbVA9rfHEKDp2e+ukw8mj2pcxzmbaBoHwi3j5A
 eZou5uD/BIjQMxBcUfFft8fAizNf56hHgLbAO/YCYvyvbaQvWgg2K9CGtC7zpTDtet6dikGH1w
 J93CKJhHNfhDvdD5X+9BWt6sR4yLwnYqBHVIpP5wt/T0i7i4uxgcD07LsmqiAoGLN1Ub85yhTo
 wmA=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Apr 2019 17:26:04 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v4 4/5] arm: Use common cpu_topology structure and functions.
Date:   Sat, 27 Apr 2019 17:25:28 -0700
Message-Id: <20190428002529.14229-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190428002529.14229-1-atish.patra@wdc.com>
References: <20190428002529.14229-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ARM32 and ARM64 uses different data structures to represent
their cpu toplogies. Since, we are moving the ARM64 topology to common
code to be used by other architectures, we can reuse that for ARM32 as
well.

Take this opprtunity to remove the redundant functions from ARM32 and
reuse the common code instead.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm/include/asm/topology.h | 20 -----------
 arch/arm/kernel/topology.c      | 60 ++++-----------------------------
 drivers/base/arch_topology.c    |  4 ++-
 include/linux/arch_topology.h   |  6 ++--
 4 files changed, 11 insertions(+), 79 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 2a786f54d8b8..8a0fae94d45e 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -5,26 +5,6 @@
 #ifdef CONFIG_ARM_CPU_TOPOLOGY
 
 #include <linux/cpumask.h>
-
-struct cputopo_arm {
-	int thread_id;
-	int core_id;
-	int socket_id;
-	cpumask_t thread_sibling;
-	cpumask_t core_sibling;
-};
-
-extern struct cputopo_arm cpu_topology[NR_CPUS];
-
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
-#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
-#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
-#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-
-void init_cpu_topology(void);
-void store_cpu_topology(unsigned int cpuid);
-const struct cpumask *cpu_coregroup_mask(int cpu);
-
 #include <linux/arch_topology.h>
 
 /* Replace task scheduler's default frequency-invariant accounting */
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 60e375ce1ab2..238f1da0219c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -177,17 +177,6 @@ static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
- /*
- * cpu topology table
- */
-struct cputopo_arm cpu_topology[NR_CPUS];
-EXPORT_SYMBOL_GPL(cpu_topology);
-
-const struct cpumask *cpu_coregroup_mask(int cpu)
-{
-	return &cpu_topology[cpu].core_sibling;
-}
-
 /*
  * The current assumption is that we can power gate each core independently.
  * This will be superseded by DT binding once available.
@@ -197,32 +186,6 @@ const struct cpumask *cpu_corepower_mask(int cpu)
 	return &cpu_topology[cpu].thread_sibling;
 }
 
-static void update_siblings_masks(unsigned int cpuid)
-{
-	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
-	int cpu;
-
-	/* update core and thread sibling masks */
-	for_each_possible_cpu(cpu) {
-		cpu_topo = &cpu_topology[cpu];
-
-		if (cpuid_topo->socket_id != cpu_topo->socket_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
-
-		if (cpuid_topo->core_id != cpu_topo->core_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
-	}
-	smp_wmb();
-}
-
 /*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
@@ -230,7 +193,7 @@ static void update_siblings_masks(unsigned int cpuid)
  */
 void store_cpu_topology(unsigned int cpuid)
 {
-	struct cputopo_arm *cpuid_topo = &cpu_topology[cpuid];
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
 
 	/* If the cpu topology has been already set, just return */
@@ -250,12 +213,12 @@ void store_cpu_topology(unsigned int cpuid)
 			/* core performance interdependency */
 			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 		} else {
 			/* largely independent cores */
 			cpuid_topo->thread_id = -1;
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 		}
 	} else {
 		/*
@@ -265,7 +228,7 @@ void store_cpu_topology(unsigned int cpuid)
 		 */
 		cpuid_topo->thread_id = -1;
 		cpuid_topo->core_id = 0;
-		cpuid_topo->socket_id = -1;
+		cpuid_topo->package_id = -1;
 	}
 
 	update_siblings_masks(cpuid);
@@ -275,7 +238,7 @@ void store_cpu_topology(unsigned int cpuid)
 	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
 		cpu_topology[cpuid].core_id,
-		cpu_topology[cpuid].socket_id, mpidr);
+		cpu_topology[cpuid].package_id, mpidr);
 }
 
 static inline int cpu_corepower_flags(void)
@@ -298,18 +261,7 @@ static struct sched_domain_topology_level arm_topology[] = {
  */
 void __init init_cpu_topology(void)
 {
-	unsigned int cpu;
-
-	/* init core mask and capacity */
-	for_each_possible_cpu(cpu) {
-		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
-
-		cpu_topo->thread_id = -1;
-		cpu_topo->core_id =  -1;
-		cpu_topo->socket_id = -1;
-		cpumask_clear(&cpu_topo->core_sibling);
-		cpumask_clear(&cpu_topo->thread_sibling);
-	}
+	reset_cpu_topology();
 	smp_wmb();
 
 	parse_dt_topology();
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 2b0758c01cee..b5fa72b42907 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -460,6 +460,7 @@ static int __init parse_dt_topology(void)
 	of_node_put(cn);
 	return ret;
 }
+#endif
 
 /*
  * cpu topology table
@@ -525,7 +526,7 @@ static void clear_cpu_topology(int cpu)
 	cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
 }
 
-static void __init reset_cpu_topology(void)
+void __init reset_cpu_topology(void)
 {
 	unsigned int cpu;
 
@@ -560,6 +561,7 @@ __weak int __init parse_acpi_topology(void)
 	return 0;
 }
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d4e76e0a283f..d4311127970d 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -54,11 +54,9 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
-#endif
-
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void update_siblings_masks(unsigned int cpu);
-#endif
 void remove_cpu_topology(unsigned int cpuid);
+void reset_cpu_topology(void);
+#endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.21.0

