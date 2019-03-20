Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62937C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B253218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="miJj6luU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCTXsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:48:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11921 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553125696; x=1584661696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amqP89gwPQFN9Tqm3LdMzVULIBgJF8Mj4/6iEK50OhA=;
  b=miJj6luUTGjNfoRQGVnBAbCcKFOtqJ8e2kyrFzA0DczQm0DeTOSAgtNG
   gbyfi/E6alVEZ0dqq+l8hszXG/3SQTeP1c5kqQH/WOYPLhyf0TK1oSPQS
   3nErrAgFsUTMhm4AJMp2CeH03uSDSsPmqCIJyQfd/7RxkXCZMjUsX32E2
   D91JtkpSktGWBNuPF2ALzI00+b66bSTn6yP4pBAR6y9vrKkEj4FrkYdIY
   OD84Gp6m1d226D164/3lq2i3u66ZbJJ5Y61Kyy0jeiuzFX2qDW3kaT9Mr
   EEGQTuqd9zdWUWJ0RnKEIoMTIcWIkYw7UcgAvAcya7CDrGmgR9f93P9Kc
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,250,1549900800"; 
   d="scan'208";a="103874320"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 07:48:15 +0800
IronPort-SDR: 7CYis8KrOmYkJMVIZMEtGnUOnAOTzwrYF9/ET/Q2lXK51OWdHiExQ3LyD/4/y9tgKMqX6Um3g0
 u1C4RlzInFbItq2yi9yQQfTVtHOjeXTN2m/yhoE4PlADsXIvPpsM932XuCtSjf87CVCcv6BhmX
 DSjsQQh3UBcNFJ1+QjJjmoJlva6DAlY/njJPDQ6G+BCwCHqK4vRsSa+300/P6HYISupePX7mVh
 UYnLXCajnHOkUiZUkhQwCm57+AAtfNjj2YVsNizuHd1cYxr+TzsChfRw+9OwDEhuSVKziue8cr
 LbDS5fXJTrXq4rfpGJua1wHc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Mar 2019 16:27:52 -0700
IronPort-SDR: 1M9uqKX9qOmXJiD6XtCNQgIEsMZLTK6UoMBx/th0jCeupbdjaF0aHF2wUq5qnVioVNiX8ZtYAp
 psL43Z/nyx/0BznAMJg7UWMkvPsiXSl36Vx9pqfiYHv9s8THdgGm/TQQPx56V7I9JqTuQ11BR+
 mPqT8hj6SbO0O0klJ3s7NRgI9nviZi8w25/L7vs2n65tJ1ODrsYloPyrnp+E1cdAZv9CYVyGhw
 MpIq9wEjphs+MD2uVbS8yyk6VuOXrLZkPiRtjdHR1E1/MFm4cuHFMRQmmRzjr9HLFUpjSnMf5z
 yLE=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Mar 2019 16:48:15 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johan Hovold <johan@kernel.org>,
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
        Will Deacon <will.deacon@arm.com>
Subject: [RFT/RFC PATCH v3 3/5] cpu-topology: Move cpu topology code to common code.
Date:   Wed, 20 Mar 2019 16:48:04 -0700
Message-Id: <20190320234806.19748-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190320234806.19748-1-atish.patra@wdc.com>
References: <20190320234806.19748-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both RISC-V & ARM64 are using cpu-map device tree to describe
their cpu topology. It's better to move the relevant code to
a common place instead of duplicate code.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 arch/arm64/include/asm/topology.h |  23 ---
 arch/arm64/kernel/topology.c      | 303 +-----------------------------
 drivers/base/arch_topology.c      | 298 ++++++++++++++++++++++++++++-
 drivers/base/topology.c           |   1 +
 include/linux/arch_topology.h     |  28 +++
 5 files changed, 330 insertions(+), 323 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0524f243..a4d945db 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -4,29 +4,6 @@
 
 #include <linux/cpumask.h>
 
-struct cpu_topology {
-	int thread_id;
-	int core_id;
-	int package_id;
-	int llc_id;
-	cpumask_t thread_sibling;
-	cpumask_t core_sibling;
-	cpumask_t llc_sibling;
-};
-
-extern struct cpu_topology cpu_topology[NR_CPUS];
-
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
-#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
-#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
-#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-#define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
-
-void init_cpu_topology(void);
-void store_cpu_topology(unsigned int cpuid);
-void remove_cpu_topology(unsigned int cpuid);
-const struct cpumask *cpu_coregroup_mask(int cpu);
-
 #ifdef CONFIG_NUMA
 
 struct pci_bus;
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0825c4a8..6b95c91e 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -14,250 +14,13 @@
 #include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/cacheinfo.h>
-#include <linux/cpu.h>
-#include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
-#include <linux/node.h>
-#include <linux/nodemask.h>
-#include <linux/of.h>
-#include <linux/sched.h>
-#include <linux/sched/topology.h>
-#include <linux/slab.h>
-#include <linux/smp.h>
-#include <linux/string.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-static int __init get_cpu_for_node(struct device_node *node)
-{
-	struct device_node *cpu_node;
-	int cpu;
-
-	cpu_node = of_parse_phandle(node, "cpu", 0);
-	if (!cpu_node)
-		return -1;
-
-	cpu = of_cpu_node_to_id(cpu_node);
-	if (cpu >= 0)
-		topology_parse_cpu_capacity(cpu_node, cpu);
-	else
-		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
-
-	of_node_put(cpu_node);
-	return cpu;
-}
-
-static int __init parse_core(struct device_node *core, int package_id,
-			     int core_id)
-{
-	char name[10];
-	bool leaf = true;
-	int i = 0;
-	int cpu;
-	struct device_node *t;
-
-	do {
-		snprintf(name, sizeof(name), "thread%d", i);
-		t = of_get_child_by_name(core, name);
-		if (t) {
-			leaf = false;
-			cpu = get_cpu_for_node(t);
-			if (cpu >= 0) {
-				cpu_topology[cpu].package_id = package_id;
-				cpu_topology[cpu].core_id = core_id;
-				cpu_topology[cpu].thread_id = i;
-			} else {
-				pr_err("%pOF: Can't get CPU for thread\n",
-				       t);
-				of_node_put(t);
-				return -EINVAL;
-			}
-			of_node_put(t);
-		}
-		i++;
-	} while (t);
-
-	cpu = get_cpu_for_node(core);
-	if (cpu >= 0) {
-		if (!leaf) {
-			pr_err("%pOF: Core has both threads and CPU\n",
-			       core);
-			return -EINVAL;
-		}
-
-		cpu_topology[cpu].package_id = package_id;
-		cpu_topology[cpu].core_id = core_id;
-	} else if (leaf) {
-		pr_err("%pOF: Can't get CPU for leaf core\n", core);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init parse_cluster(struct device_node *cluster, int depth)
-{
-	char name[10];
-	bool leaf = true;
-	bool has_cores = false;
-	struct device_node *c;
-	static int package_id __initdata;
-	int core_id = 0;
-	int i, ret;
-
-	/*
-	 * First check for child clusters; we currently ignore any
-	 * information about the nesting of clusters and present the
-	 * scheduler with a flat list of them.
-	 */
-	i = 0;
-	do {
-		snprintf(name, sizeof(name), "cluster%d", i);
-		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			leaf = false;
-			ret = parse_cluster(c, depth + 1);
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
-		i++;
-	} while (c);
-
-	/* Now check for cores */
-	i = 0;
-	do {
-		snprintf(name, sizeof(name), "core%d", i);
-		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			has_cores = true;
-
-			if (depth == 0) {
-				pr_err("%pOF: cpu-map children should be clusters\n",
-				       c);
-				of_node_put(c);
-				return -EINVAL;
-			}
-
-			if (leaf) {
-				ret = parse_core(c, package_id, core_id++);
-			} else {
-				pr_err("%pOF: Non-leaf cluster with core %s\n",
-				       cluster, name);
-				ret = -EINVAL;
-			}
-
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
-		i++;
-	} while (c);
-
-	if (leaf && !has_cores)
-		pr_warn("%pOF: empty cluster\n", cluster);
-
-	if (leaf)
-		package_id++;
-
-	return 0;
-}
-
-static int __init parse_dt_topology(void)
-{
-	struct device_node *cn, *map;
-	int ret = 0;
-	int cpu;
-
-	cn = of_find_node_by_path("/cpus");
-	if (!cn) {
-		pr_err("No CPU information found in DT\n");
-		return 0;
-	}
-
-	/*
-	 * When topology is provided cpu-map is essentially a root
-	 * cluster with restricted subnodes.
-	 */
-	map = of_get_child_by_name(cn, "cpu-map");
-	if (!map)
-		goto out;
-
-	ret = parse_cluster(map, 0);
-	if (ret != 0)
-		goto out_map;
-
-	topology_normalize_cpu_scale();
-
-	/*
-	 * Check that all cores are in the topology; the SMP code will
-	 * only mark cores described in the DT as possible.
-	 */
-	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].package_id == -1)
-			ret = -EINVAL;
-
-out_map:
-	of_node_put(map);
-out:
-	of_node_put(cn);
-	return ret;
-}
-
-/*
- * cpu topology table
- */
-struct cpu_topology cpu_topology[NR_CPUS];
-EXPORT_SYMBOL_GPL(cpu_topology);
-
-const struct cpumask *cpu_coregroup_mask(int cpu)
-{
-	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
-
-	/* Find the smaller of NUMA, core or LLC siblings */
-	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
-		/* not numa in package, lets use the package siblings */
-		core_mask = &cpu_topology[cpu].core_sibling;
-	}
-	if (cpu_topology[cpu].llc_id != -1) {
-		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
-			core_mask = &cpu_topology[cpu].llc_sibling;
-	}
-
-	return core_mask;
-}
-
-static void update_siblings_masks(unsigned int cpuid)
-{
-	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
-	int cpu;
-
-	/* update core and thread sibling masks */
-	for_each_online_cpu(cpu) {
-		cpu_topo = &cpu_topology[cpu];
-
-		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
-			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
-			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
-		}
-
-		if (cpuid_topo->package_id != cpu_topo->package_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
-
-		if (cpuid_topo->core_id != cpu_topo->core_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-		cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
-	}
-}
-
 void store_cpu_topology(unsigned int cpuid)
 {
 	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
@@ -296,59 +59,19 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }
 
-static void clear_cpu_topology(int cpu)
-{
-	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
-
-	cpumask_clear(&cpu_topo->llc_sibling);
-	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
-
-	cpumask_clear(&cpu_topo->core_sibling);
-	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
-	cpumask_clear(&cpu_topo->thread_sibling);
-	cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
-}
-
-static void __init reset_cpu_topology(void)
-{
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
-
-		cpu_topo->thread_id = -1;
-		cpu_topo->core_id = 0;
-		cpu_topo->package_id = -1;
-		cpu_topo->llc_id = -1;
-
-		clear_cpu_topology(cpu);
-	}
-}
-
-void remove_cpu_topology(unsigned int cpu)
-{
-	int sibling;
-
-	for_each_cpu(sibling, topology_core_cpumask(cpu))
-		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
-	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
-		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
-	for_each_cpu(sibling, topology_llc_cpumask(cpu))
-		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
-
-	clear_cpu_topology(cpu);
-}
-
 #ifdef CONFIG_ACPI
 /*
  * Propagate the topology information of the processor_topology_node tree to the
  * cpu_topology array.
  */
-static int __init parse_acpi_topology(void)
+int __init parse_acpi_topology(void)
 {
 	bool is_threaded;
 	int cpu, topology_id;
 
+	if (acpi_disabled)
+		return 0;
+
 	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
 
 	for_each_possible_cpu(cpu) {
@@ -384,24 +107,6 @@ static int __init parse_acpi_topology(void)
 
 	return 0;
 }
-
-#else
-static inline int __init parse_acpi_topology(void)
-{
-	return -EINVAL;
-}
 #endif
 
-void __init init_cpu_topology(void)
-{
-	reset_cpu_topology();
 
-	/*
-	 * Discard anything that was parsed if we hit an error so we
-	 * don't use partial information.
-	 */
-	if (!acpi_disabled && parse_acpi_topology())
-		reset_cpu_topology();
-	else if (of_have_populated_dt() && parse_dt_topology())
-		reset_cpu_topology();
-}
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index edfcf8d9..6cc6a860 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -6,8 +6,8 @@
  * Written by: Juri Lelli, ARM Ltd.
  */
 
-#include <linux/acpi.h>
 #include <linux/arch_topology.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -16,6 +16,11 @@
 #include <linux/string.h>
 #include <linux/sched/topology.h>
 #include <linux/cpuset.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -278,3 +283,294 @@ static void parsing_done_workfn(struct work_struct *work)
 #else
 core_initcall(free_raw_capacity);
 #endif
+
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+static int __init get_cpu_for_node(struct device_node *node)
+{
+	struct device_node *cpu_node;
+	int cpu;
+
+	cpu_node = of_parse_phandle(node, "cpu", 0);
+	if (!cpu_node)
+		return -1;
+
+	cpu = of_cpu_node_to_id(cpu_node);
+	if (cpu >= 0)
+		topology_parse_cpu_capacity(cpu_node, cpu);
+	else
+		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
+
+	of_node_put(cpu_node);
+	return cpu;
+}
+
+static int __init parse_core(struct device_node *core, int package_id,
+			     int core_id)
+{
+	char name[10];
+	bool leaf = true;
+	int i = 0;
+	int cpu;
+	struct device_node *t;
+
+	do {
+		snprintf(name, sizeof(name), "thread%d", i);
+		t = of_get_child_by_name(core, name);
+		if (t) {
+			leaf = false;
+			cpu = get_cpu_for_node(t);
+			if (cpu >= 0) {
+				cpu_topology[cpu].package_id = package_id;
+				cpu_topology[cpu].core_id = core_id;
+				cpu_topology[cpu].thread_id = i;
+			} else {
+				pr_err("%pOF: Can't get CPU for thread\n",
+				       t);
+				of_node_put(t);
+				return -EINVAL;
+			}
+			of_node_put(t);
+		}
+		i++;
+	} while (t);
+
+	cpu = get_cpu_for_node(core);
+	if (cpu >= 0) {
+		if (!leaf) {
+			pr_err("%pOF: Core has both threads and CPU\n",
+			       core);
+			return -EINVAL;
+		}
+
+		cpu_topology[cpu].package_id = package_id;
+		cpu_topology[cpu].core_id = core_id;
+	} else if (leaf) {
+		pr_err("%pOF: Can't get CPU for leaf core\n", core);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init parse_cluster(struct device_node *cluster, int depth)
+{
+	char name[10];
+	bool leaf = true;
+	bool has_cores = false;
+	struct device_node *c;
+	static int package_id __initdata;
+	int core_id = 0;
+	int i, ret;
+
+	/*
+	 * First check for child clusters; we currently ignore any
+	 * information about the nesting of clusters and present the
+	 * scheduler with a flat list of them.
+	 */
+	i = 0;
+	do {
+		snprintf(name, sizeof(name), "cluster%d", i);
+		c = of_get_child_by_name(cluster, name);
+		if (c) {
+			leaf = false;
+			ret = parse_cluster(c, depth + 1);
+			of_node_put(c);
+			if (ret != 0)
+				return ret;
+		}
+		i++;
+	} while (c);
+
+	/* Now check for cores */
+	i = 0;
+	do {
+		snprintf(name, sizeof(name), "core%d", i);
+		c = of_get_child_by_name(cluster, name);
+		if (c) {
+			has_cores = true;
+
+			if (depth == 0) {
+				pr_err("%pOF: cpu-map children should be clusters\n",
+				       c);
+				of_node_put(c);
+				return -EINVAL;
+			}
+
+			if (leaf) {
+				ret = parse_core(c, package_id, core_id++);
+			} else {
+				pr_err("%pOF: Non-leaf cluster with core %s\n",
+				       cluster, name);
+				ret = -EINVAL;
+			}
+
+			of_node_put(c);
+			if (ret != 0)
+				return ret;
+		}
+		i++;
+	} while (c);
+
+	if (leaf && !has_cores)
+		pr_warn("%pOF: empty cluster\n", cluster);
+
+	if (leaf)
+		package_id++;
+
+	return 0;
+}
+
+static int __init parse_dt_topology(void)
+{
+	struct device_node *cn, *map;
+	int ret = 0;
+	int cpu;
+
+	cn = of_find_node_by_path("/cpus");
+	if (!cn) {
+		pr_err("No CPU information found in DT\n");
+		return 0;
+	}
+
+	/*
+	 * When topology is provided cpu-map is essentially a root
+	 * cluster with restricted subnodes.
+	 */
+	map = of_get_child_by_name(cn, "cpu-map");
+	if (!map)
+		goto out;
+
+	ret = parse_cluster(map, 0);
+	if (ret != 0)
+		goto out_map;
+
+	topology_normalize_cpu_scale();
+
+	/*
+	 * Check that all cores are in the topology; the SMP code will
+	 * only mark cores described in the DT as possible.
+	 */
+	for_each_possible_cpu(cpu)
+		if (cpu_topology[cpu].package_id == -1)
+			ret = -EINVAL;
+
+out_map:
+	of_node_put(map);
+out:
+	of_node_put(cn);
+	return ret;
+}
+
+/*
+ * cpu topology table
+ */
+struct cpu_topology cpu_topology[NR_CPUS];
+EXPORT_SYMBOL_GPL(cpu_topology);
+
+const struct cpumask *cpu_coregroup_mask(int cpu)
+{
+	const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
+
+	/* Find the smaller of NUMA, core or LLC siblings */
+	if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
+		/* not numa in package, lets use the package siblings */
+		core_mask = &cpu_topology[cpu].core_sibling;
+	}
+	if (cpu_topology[cpu].llc_id != -1) {
+		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
+			core_mask = &cpu_topology[cpu].llc_sibling;
+	}
+
+	return core_mask;
+}
+
+void update_siblings_masks(unsigned int cpuid)
+{
+	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
+	int cpu;
+
+	/* update core and thread sibling masks */
+	for_each_online_cpu(cpu) {
+		cpu_topo = &cpu_topology[cpu];
+
+		if (cpuid_topo->llc_id == cpu_topo->llc_id) {
+			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
+			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
+		}
+
+		if (cpuid_topo->package_id != cpu_topo->package_id)
+			continue;
+
+		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
+
+		if (cpuid_topo->core_id != cpu_topo->core_id)
+			continue;
+
+		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
+		cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
+	}
+}
+
+static void clear_cpu_topology(int cpu)
+{
+	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
+
+	cpumask_clear(&cpu_topo->llc_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
+
+	cpumask_clear(&cpu_topo->core_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
+	cpumask_clear(&cpu_topo->thread_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
+}
+
+static void __init reset_cpu_topology(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
+
+		cpu_topo->thread_id = -1;
+		cpu_topo->core_id = 0;
+		cpu_topo->package_id = -1;
+		cpu_topo->llc_id = -1;
+
+		clear_cpu_topology(cpu);
+	}
+}
+
+void remove_cpu_topology(unsigned int cpu)
+{
+	int sibling;
+
+	for_each_cpu(sibling, topology_core_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+	for_each_cpu(sibling, topology_llc_cpumask(cpu))
+		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
+
+	clear_cpu_topology(cpu);
+}
+
+__weak int __init parse_acpi_topology(void)
+{
+	return 0;
+}
+
+void __init init_cpu_topology(void)
+{
+	reset_cpu_topology();
+
+	/*
+	 * Discard anything that was parsed if we hit an error so we
+	 * don't use partial information.
+	 */
+	if (parse_acpi_topology())
+		reset_cpu_topology();
+	else if (of_have_populated_dt() && parse_dt_topology())
+		reset_cpu_topology();
+}
+#endif
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5fd9f167..c17d5434 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -8,6 +8,7 @@
  *
  * All rights reserved.
  */
+#include <linux/arch_topology.h>
 #include <linux/mm.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d9bdc1a7..d4e76e0a 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -33,4 +33,32 @@ unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+struct cpu_topology {
+	int thread_id;
+	int core_id;
+	int package_id;
+	int llc_id;
+	cpumask_t thread_sibling;
+	cpumask_t core_sibling;
+	cpumask_t llc_sibling;
+};
+
+#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+extern struct cpu_topology cpu_topology[NR_CPUS];
+
+#define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
+#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
+#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
+#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
+#define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
+void init_cpu_topology(void);
+void store_cpu_topology(unsigned int cpuid);
+const struct cpumask *cpu_coregroup_mask(int cpu);
+#endif
+
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
+void update_siblings_masks(unsigned int cpu);
+#endif
+void remove_cpu_topology(unsigned int cpuid);
+
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.21.0

