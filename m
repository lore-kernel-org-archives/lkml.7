Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2908AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E012465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfLRS11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:27:27 -0500
Received: from foss.arm.com ([217.140.110.172]:56656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfLRS10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:27:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85AB2113E;
        Wed, 18 Dec 2019 10:27:25 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A09FB3F67D;
        Wed, 18 Dec 2019 10:27:23 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: use activity monitors for frequency invariance
Date:   Wed, 18 Dec 2019 18:26:07 +0000
Message-Id: <20191218182607.21607-7-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218182607.21607-1-ionela.voinescu@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Frequency Invariance Engine (FIE) is providing a frequency
scaling correction factor that helps achieve more accurate
load-tracking.

So far, for arm and arm64 platforms, this scale factor has been
obtained based on the ratio between the current frequency and the
maximum supported frequency recorded by the cpufreq policy. The
setting of this scale factor is triggered from cpufreq drivers by
calling arch_set_freq_scale. The current frequency used in computation
is the frequency requested by a governor, but it may not be the
frequency that was implemented by the platform.

This correction factor can also be obtained using a core counter and a
constant counter to get information on the performance (frequency based
only) obtained in a period of time. This will more accurately reflect
the actual current frequency of the CPU, compared with the alternative
implementation that reflects the request of a performance level from
the OS.

Therefore, implement arch_scale_freq_tick to use activity monitors, if
present, for the computation of the frequency scale factor.

The use of AMU counters depends on:
 - CONFIG_ARM64_AMU_EXTN - depents on the AMU extension being present
 - CONFIG_CPU_FREQ - the current frequency obtained using counter
   information is divided by the maximum frequency obtained from the
   cpufreq policy.

While it is possible to have a combination of CPUs in the system with
and without support for activity monitors, the use of counters for
frequency invariance is only enabled for a CPU, if all related CPUs
(CPUs in the same frequency domain) support and have enabled the core
and constant activity monitor counters. In this way, there is a clear
separation between the policies for which arch_set_freq_scale
(cpufreq based FIE) is used, and the policies for which
arch_scale_freq_tick (counter based FIE) is used to set the frequency
scale factor. For this purpose, a cpufreq notifier is registered to
trigger validation work for CPUs and policies at policy creation that
will enable or disable the use of AMU counters for frequency invariance.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/topology.h |   9 ++
 arch/arm64/kernel/topology.c      | 233 ++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c      |  16 ++
 3 files changed, 258 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index a4d945db95a2..98412dd27565 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -19,6 +19,15 @@ int pcibus_to_node(struct pci_bus *bus);
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
 
+#if defined(CONFIG_ARM64_AMU_EXTN) && defined(CONFIG_CPU_FREQ)
+void topology_scale_freq_tick(void);
+/*
+ * Replace task scheduler's default counter-based frequency-invariance
+ * scale factor setting.
+ */
+#define arch_scale_freq_tick topology_scale_freq_tick
+#endif
+
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index fa9528dfd0ce..61f8264afec9 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/cacheinfo.h>
+#include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
 
@@ -120,4 +121,236 @@ int __init parse_acpi_topology(void)
 }
 #endif
 
+#if defined(CONFIG_ARM64_AMU_EXTN) && defined(CONFIG_CPU_FREQ)
 
+#undef pr_fmt
+#define pr_fmt(fmt) "AMU: " fmt
+
+static void init_fie_counters_done_workfn(struct work_struct *work);
+static DECLARE_WORK(init_fie_counters_done_work,
+		    init_fie_counters_done_workfn);
+
+static struct workqueue_struct *policy_amu_fie_init_wq;
+static struct workqueue_struct *cpu_amu_fie_init_wq;
+
+struct cpu_amu_work {
+	struct work_struct cpu_work;
+	struct work_struct policy_work;
+	unsigned int cpuinfo_max_freq;
+	struct cpumask policy_cpus;
+	bool cpu_amu_fie;
+};
+static struct cpu_amu_work __percpu *works;
+static cpumask_var_t cpus_to_visit;
+
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
+static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
+static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
+DECLARE_PER_CPU(u8, amu_scale_freq);
+
+static void cpu_amu_fie_init_workfn(struct work_struct *work)
+{
+	u64 core_cnt, const_cnt, ratio;
+	struct cpu_amu_work *amu_work;
+	int cpu = smp_processor_id();
+
+	if (!cpu_has_amu_feat()) {
+		pr_debug("CPU%d: counters are not supported.\n", cpu);
+		return;
+	}
+
+	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+
+	if (unlikely(!core_cnt || !const_cnt)) {
+		pr_err("CPU%d: cycle counters are not enabled.\n", cpu);
+		return;
+	}
+
+	amu_work = container_of(work, struct cpu_amu_work, cpu_work);
+	if (unlikely(!(amu_work->cpuinfo_max_freq))) {
+		pr_err("CPU%d: invalid maximum frequency.\n", cpu);
+		return;
+	}
+
+	/*
+	 * Pre-compute the fixed ratio between the frequency of the
+	 * constant counter and the maximum frequency of the CPU (hz).
+	 */
+	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
+	ratio = div64_u64(ratio, amu_work->cpuinfo_max_freq * 1000);
+	this_cpu_write(arch_max_freq_scale, (unsigned long)ratio);
+
+	this_cpu_write(arch_core_cycles_prev, core_cnt);
+	this_cpu_write(arch_const_cycles_prev, const_cnt);
+	amu_work->cpu_amu_fie = true;
+}
+
+static void policy_amu_fie_init_workfn(struct work_struct *work)
+{
+	struct cpu_amu_work *amu_work;
+	u8 enable;
+	int cpu;
+
+	amu_work = container_of(work, struct cpu_amu_work, policy_work);
+
+	flush_workqueue(cpu_amu_fie_init_wq);
+
+	for_each_cpu(cpu, &amu_work->policy_cpus)
+		if (!(per_cpu_ptr(works, cpu)->cpu_amu_fie))
+			break;
+
+	enable = (cpu >= nr_cpu_ids) ? 1 : 0;
+
+	for_each_cpu(cpu, &amu_work->policy_cpus)
+		per_cpu(amu_scale_freq, cpu) = enable;
+
+	pr_info("CPUs[%*pbl]: counters %s be used for FIE.",
+		cpumask_pr_args(&amu_work->policy_cpus),
+		enable ? "will" : "WON'T");
+}
+
+static int init_fie_counters_callback(struct notifier_block *nb,
+				      unsigned long val,
+				      void *data)
+{
+	struct cpufreq_policy *policy = data;
+	struct cpu_amu_work *work;
+	int cpu;
+
+	if (val != CPUFREQ_CREATE_POLICY)
+		return 0;
+
+	/* Return if not all related CPUs are online */
+	if (!cpumask_equal(policy->cpus, policy->related_cpus)) {
+		pr_info("CPUs[%*pbl]: counters WON'T be used for FIE.",
+			cpumask_pr_args(policy->related_cpus));
+		return 0;
+	}
+
+	/*
+	 * Queue functions on all online CPUs from policy to:
+	 *  - Check support and enablement for AMU counters
+	 *  - Store system freq to max freq ratio per cpu
+	 *  - Flag CPU as valid for use of counters for FIE
+	 */
+	for_each_cpu(cpu, policy->cpus) {
+		work = per_cpu_ptr(works, cpu);
+		work->cpuinfo_max_freq = policy->cpuinfo.max_freq;
+		work->cpu_amu_fie = false;
+		INIT_WORK(&work->cpu_work, cpu_amu_fie_init_workfn);
+		queue_work_on(cpu, cpu_amu_fie_init_wq, &work->cpu_work);
+	}
+
+	/*
+	 * Queue function to validate support at policy level:
+	 *  - Flush all work on online policy CPUs
+	 *  - Verify that all online policy CPUs are flagged as
+	 *    valid for use of counters for FIE
+	 *  - Enable or disable use of counters for FIE on CPUs
+	 */
+	work = per_cpu_ptr(works, cpumask_first(policy->cpus));
+	cpumask_copy(&work->policy_cpus, policy->cpus);
+	INIT_WORK(&work->policy_work, policy_amu_fie_init_workfn);
+	queue_work(policy_amu_fie_init_wq, &work->policy_work);
+
+	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->cpus);
+	if (cpumask_empty(cpus_to_visit))
+		schedule_work(&init_fie_counters_done_work);
+
+	return 0;
+}
+
+static struct notifier_block init_fie_counters_notifier = {
+	.notifier_call = init_fie_counters_callback,
+};
+
+static void init_fie_counters_done_workfn(struct work_struct *work)
+{
+	cpufreq_unregister_notifier(&init_fie_counters_notifier,
+				    CPUFREQ_POLICY_NOTIFIER);
+
+	/*
+	 * Destroy policy_amu_fie_init_wq first to ensure all policy
+	 * work is finished, which includes flushing of the per-CPU
+	 * work, before cpu_amu_fie_init_wq is destroyed.
+	 */
+	destroy_workqueue(policy_amu_fie_init_wq);
+	destroy_workqueue(cpu_amu_fie_init_wq);
+
+	free_percpu(works);
+	free_cpumask_var(cpus_to_visit);
+}
+
+static int __init register_fie_counters_cpufreq_notifier(void)
+{
+	int ret = -ENOMEM;
+
+	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
+		goto out;
+
+	cpumask_copy(cpus_to_visit, cpu_possible_mask);
+
+	cpu_amu_fie_init_wq = create_workqueue("cpu_amu_fie_init_wq");
+	if (!cpu_amu_fie_init_wq)
+		goto free_cpumask;
+
+	policy_amu_fie_init_wq = create_workqueue("policy_amu_fie_init_wq");
+	if (!cpu_amu_fie_init_wq)
+		goto free_cpu_wq;
+
+	works = alloc_percpu(struct cpu_amu_work);
+	if (!works)
+		goto free_policy_wq;
+
+	ret = cpufreq_register_notifier(&init_fie_counters_notifier,
+					CPUFREQ_POLICY_NOTIFIER);
+	if (ret)
+		goto free_works;
+
+	return 0;
+
+free_works:
+	free_percpu(works);
+free_policy_wq:
+	destroy_workqueue(policy_amu_fie_init_wq);
+free_cpu_wq:
+	destroy_workqueue(cpu_amu_fie_init_wq);
+free_cpumask:
+	free_cpumask_var(cpus_to_visit);
+out:
+	return ret;
+}
+core_initcall(register_fie_counters_cpufreq_notifier);
+
+void topology_scale_freq_tick(void)
+{
+	u64 prev_core_cnt, prev_const_cnt;
+	u64 core_cnt, const_cnt, scale;
+
+	if (!this_cpu_read(amu_scale_freq))
+		return;
+
+	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
+	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	if (unlikely(core_cnt <= prev_core_cnt ||
+		     const_cnt <= prev_const_cnt))
+		goto store_and_exit;
+
+	scale = core_cnt - prev_core_cnt;
+	scale *= this_cpu_read(arch_max_freq_scale);
+	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
+			  const_cnt - prev_const_cnt);
+
+	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
+	this_cpu_write(freq_scale, (unsigned long)scale);
+
+store_and_exit:
+	this_cpu_write(arch_core_cycles_prev, core_cnt);
+	this_cpu_write(arch_const_cycles_prev, const_cnt);
+}
+
+#endif
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f113786..3ae6091d845e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -23,12 +23,28 @@
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
+#if defined(CONFIG_ARM64_AMU_EXTN) && defined(CONFIG_CPU_FREQ)
+DEFINE_PER_CPU_READ_MOSTLY(u8, amu_scale_freq);
+#endif
+
 void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 			 unsigned long max_freq)
 {
 	unsigned long scale;
 	int i;
 
+#if defined(CONFIG_ARM64_AMU_EXTN) && defined(CONFIG_CPU_FREQ)
+	/*
+	 * This function will only be called from CPUFREQ drivers.
+	 * If the use of counters for FIE is enabled, establish if a CPU,
+	 * the first one, supports counters and if they are valid. If they
+	 * are, just return as we don't want to update with information
+	 * from CPUFREQ. In this case the scale factor will be updated
+	 * from arch_scale_freq_tick.
+	 */
+	if (per_cpu(amu_scale_freq, cpumask_first(cpus)))
+		return;
+#endif
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
 
 	for_each_cpu(i, cpus)
-- 
2.17.1

