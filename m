Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF38C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA682084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfCAM6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:58:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49347 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCAM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:58:43 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id be5838474f9f798c; Fri, 1 Mar 2019 13:58:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU frequency on global turbo changes
Date:   Fri, 01 Mar 2019 13:57:06 +0100
Message-ID: <3017597.CVkTxgYgAs@aspire.rjw.lan>
In-Reply-To: <2046937.YMVy5Qh3Pm@aspire.rjw.lan>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <2046937.YMVy5Qh3Pm@aspire.rjw.lan>
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

Note that policy_is_inactive() and cpufreq_set_policy() need to be
made available to it for this purpose.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Update, because the patch sent previously doesn't build, due to an extra
arg declared for intel_pstate_update_max_freq().

---
 drivers/cpufreq/cpufreq.c      |   12 ++----------
 drivers/cpufreq/intel_pstate.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/cpufreq.h        |    7 +++++++
 3 files changed, 41 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -897,6 +897,36 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
+static void intel_pstate_update_max_freq(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy new_policy;
+	struct cpudata *cpudata;
+
+	if (!policy)
+		return;
+
+	down_write(&policy->rwsem);
+
+	if (policy_is_inactive(policy))
+		goto unlock;
+
+	cpudata = all_cpu_data[cpu];
+	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
+			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+
+	memcpy(&new_policy, policy, sizeof(*policy));
+	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
+	new_policy.min = min(policy->user_policy.min, new_policy.max);
+
+	cpufreq_set_policy(policy, &new_policy);
+
+unlock:
+	up_write(&policy->rwsem);
+
+	cpufreq_cpu_put(policy);
+}
+
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	mutex_lock(&intel_pstate_driver_lock);
@@ -908,7 +938,8 @@ static void intel_pstate_update_limits(u
 	 */
 	if (global.turbo_disabled_upd != global.turbo_disabled) {
 		global.turbo_disabled_upd = global.turbo_disabled;
-		intel_pstate_update_policies();
+		for_each_possible_cpu(cpu)
+			intel_pstate_update_max_freq(cpu);
 	} else {
 		cpufreq_update_policy(cpu);
 	}
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
@@ -675,9 +670,6 @@ static ssize_t show_scaling_cur_freq(str
 	return ret;
 }
 
-static int cpufreq_set_policy(struct cpufreq_policy *policy,
-				struct cpufreq_policy *new_policy);
-
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
  */
@@ -2235,8 +2227,8 @@ EXPORT_SYMBOL(cpufreq_get_policy);
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
@@ -194,6 +199,8 @@ void disable_cpufreq(void);
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
+int cpufreq_set_policy(struct cpufreq_policy *policy,
+		       struct cpufreq_policy *new_policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);

