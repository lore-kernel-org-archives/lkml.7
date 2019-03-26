Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670182070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfCZLWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:22:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46301 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCZLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:22:08 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 4d81d33998130d4f; Tue, 26 Mar 2019 12:22:04 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 4/4] cpufreq: intel_pstate: Update max frequency on global turbo changes
Date:   Tue, 26 Mar 2019 12:19:52 +0100
Message-ID: <5631958.Dv2x2rzsZ4@aspire.rjw.lan>
In-Reply-To: <11953735.uMqeHy63Iu@aspire.rjw.lan>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While the cpuinfo.max_freq value doesn't really matter for
intel_pstate in the active mode, in the passive mode it is used by
governors as the maximum physical frequency of the CPU and the
results of governor computations generally depend on it.  Also it
is made available to user space via sysfs and it should match the
current HW configuration.

For this reason, make intel_pstate update cpuinfo.max_freq for all
CPUs if it detects a global change of turbo frequency settings from
"disable" to "enable" or the other way associated with a _PPC change
notification from the platform firmware.

Note that policy_is_inactive(),  cpufreq_cpu_acquire(),
cpufreq_cpu_release(), and cpufreq_set_policy() need to be made
available to it for this purpose.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

v2 -> v3:
  * Added Acked-by from Viresh.

---
 drivers/cpufreq/cpufreq.c      |   16 ++++------------
 drivers/cpufreq/intel_pstate.c |   35 +++++++++++++++++++++++++++++------
 include/linux/cpufreq.h        |   10 ++++++++++
 3 files changed, 43 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -179,7 +179,7 @@ struct vid_data {
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
- * @turbo_disabled_s:	Saved @turbo_disabled value.
+ * @turbo_disabled_mf:	The @turbo_disabled value reflected by cpuinfo.max_freq.
  * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
  *			P-state capacity.
  * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
@@ -188,7 +188,7 @@ struct vid_data {
 struct global_params {
 	bool no_turbo;
 	bool turbo_disabled;
-	bool turbo_disabled_s;
+	bool turbo_disabled_mf;
 	int max_perf_pct;
 	int min_perf_pct;
 };
@@ -896,6 +896,28 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
+static void intel_pstate_update_max_freq(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
+	struct cpufreq_policy new_policy;
+	struct cpudata *cpudata;
+
+	if (!policy)
+		return;
+
+	cpudata = all_cpu_data[cpu];
+	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
+			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+
+	memcpy(&new_policy, policy, sizeof(*policy));
+	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
+	new_policy.min = min(policy->user_policy.min, new_policy.max);
+
+	cpufreq_set_policy(policy, &new_policy);
+
+	cpufreq_cpu_release(policy);
+}
+
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	mutex_lock(&intel_pstate_driver_lock);
@@ -905,9 +927,10 @@ static void intel_pstate_update_limits(u
 	 * If turbo has been turned on or off globally, policy limits for
 	 * all CPUs need to be updated to reflect that.
 	 */
-	if (global.turbo_disabled_s != global.turbo_disabled) {
-		global.turbo_disabled_s = global.turbo_disabled;
-		intel_pstate_update_policies();
+	if (global.turbo_disabled_mf != global.turbo_disabled) {
+		global.turbo_disabled_mf = global.turbo_disabled;
+		for_each_possible_cpu(cpu)
+			intel_pstate_update_max_freq(cpu);
 	} else {
 		cpufreq_update_policy(cpu);
 	}
@@ -2156,7 +2179,7 @@ static int __intel_pstate_cpu_init(struc
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
-	global.turbo_disabled_s = global.turbo_disabled;
+	global.turbo_disabled_mf = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -34,11 +34,6 @@
 
 static LIST_HEAD(cpufreq_policy_list);
 
-static inline bool policy_is_inactive(struct cpufreq_policy *policy)
-{
-	return cpumask_empty(policy->cpus);
-}
-
 /* Macros to iterate over CPU policies */
 #define for_each_suitable_policy(__policy, __active)			 \
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
@@ -254,7 +249,7 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
  * cpufreq_cpu_release - Unlock a policy and decrement its usage counter.
  * @policy: cpufreq policy returned by cpufreq_cpu_acquire().
  */
-static void cpufreq_cpu_release(struct cpufreq_policy *policy)
+void cpufreq_cpu_release(struct cpufreq_policy *policy)
 {
 	if (WARN_ON(!policy))
 		return;
@@ -278,7 +273,7 @@ static void cpufreq_cpu_release(struct c
  * cpufreq_cpu_release() in order to release its rwsem and balance its usage
  * counter properly.
  */
-static struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
+struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 
@@ -714,9 +709,6 @@ static ssize_t show_scaling_cur_freq(str
 	return ret;
 }
 
-static int cpufreq_set_policy(struct cpufreq_policy *policy,
-				struct cpufreq_policy *new_policy);
-
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
  */
@@ -2274,8 +2266,8 @@ EXPORT_SYMBOL(cpufreq_get_policy);
  *
  * The cpuinfo part of @policy is not updated by this function.
  */
-static int cpufreq_set_policy(struct cpufreq_policy *policy,
-			      struct cpufreq_policy *new_policy)
+int cpufreq_set_policy(struct cpufreq_policy *policy,
+		       struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
 	int ret;
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -178,6 +178,11 @@ static inline struct cpufreq_policy *cpu
 static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
 #endif
 
+static inline bool policy_is_inactive(struct cpufreq_policy *policy)
+{
+	return cpumask_empty(policy->cpus);
+}
+
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
 {
 	return cpumask_weight(policy->cpus) > 1;
@@ -193,7 +198,12 @@ unsigned int cpufreq_quick_get_max(unsig
 void disable_cpufreq(void);
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
+
+struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu);
+void cpufreq_cpu_release(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
+int cpufreq_set_policy(struct cpufreq_policy *policy,
+		       struct cpufreq_policy *new_policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);

