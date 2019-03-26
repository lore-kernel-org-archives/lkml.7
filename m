Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC092C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB329206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfCZLWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:22:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60762 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:22:10 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 8383dce57708b6d8; Tue, 26 Mar 2019 12:22:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 1/4] cpufreq: intel_pstate: Driver-specific handling of _PPC updates
Date:   Tue, 26 Mar 2019 12:15:13 +0100
Message-ID: <3509971.Tn8qtb9ZzE@aspire.rjw.lan>
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

In some cases, the platform firmware disables or enables turbo
frequencies for all CPUs globally before triggering a _PPC change
notification for one of them.  Obviously, that global change affects
all CPUs, not just the notified one, and it needs to be acted upon by
cpufreq.

The intel_pstate driver is able to detect such global changes of
the settings, but it also needs to update policy limits for all
CPUs if that happens, in particular if turbo frequencies are
enabled globally - to allow them to be used.

For this reason, introduce a new cpufreq driver callback to be
invoked on _PPC notifications, if present, instead of simply
calling cpufreq_update_policy() for the notified CPU and make
intel_pstate use it to trigger policy updates for all CPUs
in the system if global settings change.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

v2 -> v3:
  * Added Acked-by from Viresh.

---
 drivers/acpi/processor_perflib.c |    2 +-
 drivers/cpufreq/cpufreq.c        |   16 ++++++++++++++++
 drivers/cpufreq/intel_pstate.c   |   24 ++++++++++++++++++++++++
 include/linux/cpufreq.h          |    4 ++++
 4 files changed, 45 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -181,7 +181,7 @@ void acpi_processor_ppc_has_changed(stru
 			acpi_processor_ppc_ost(pr->handle, 0);
 	}
 	if (ret >= 0)
-		cpufreq_update_policy(pr->id);
+		cpufreq_update_limits(pr->id);
 }
 
 int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2370,6 +2370,22 @@ unlock:
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
+/**
+ * cpufreq_update_limits - Update policy limits for a given CPU.
+ * @cpu: CPU to update the policy limits for.
+ *
+ * Invoke the driver's ->update_limits callback if present or call
+ * cpufreq_update_policy() for @cpu.
+ */
+void cpufreq_update_limits(unsigned int cpu)
+{
+	if (cpufreq_driver->update_limits)
+		cpufreq_driver->update_limits(cpu);
+	else
+		cpufreq_update_policy(cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_update_limits);
+
 /*********************************************************************
  *               BOOST						     *
  *********************************************************************/
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -179,6 +179,7 @@ struct vid_data {
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
+ * @turbo_disabled_s:	Saved @turbo_disabled value.
  * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
  *			P-state capacity.
  * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
@@ -187,6 +188,7 @@ struct vid_data {
 struct global_params {
 	bool no_turbo;
 	bool turbo_disabled;
+	bool turbo_disabled_s;
 	int max_perf_pct;
 	int min_perf_pct;
 };
@@ -894,6 +896,25 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
+static void intel_pstate_update_limits(unsigned int cpu)
+{
+	mutex_lock(&intel_pstate_driver_lock);
+
+	update_turbo_state();
+	/*
+	 * If turbo has been turned on or off globally, policy limits for
+	 * all CPUs need to be updated to reflect that.
+	 */
+	if (global.turbo_disabled_s != global.turbo_disabled) {
+		global.turbo_disabled_s = global.turbo_disabled;
+		intel_pstate_update_policies();
+	} else {
+		cpufreq_update_policy(cpu);
+	}
+
+	mutex_unlock(&intel_pstate_driver_lock);
+}
+
 /************************** sysfs begin ************************/
 #define show_one(file_name, object)					\
 	static ssize_t show_##file_name					\
@@ -2135,6 +2156,7 @@ static int __intel_pstate_cpu_init(struc
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
+	global.turbo_disabled_s = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
@@ -2179,6 +2201,7 @@ static struct cpufreq_driver intel_pstat
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
 
@@ -2313,6 +2336,7 @@ static struct cpufreq_driver intel_cpufr
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };
 
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -195,6 +195,7 @@ void disable_cpufreq(void);
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 void cpufreq_update_policy(unsigned int cpu);
+void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
@@ -322,6 +323,9 @@ struct cpufreq_driver {
 	/* should be defined, if possible */
 	unsigned int	(*get)(unsigned int cpu);
 
+	/* Called to update policy limits on firmware notifications. */
+	void		(*update_limits)(unsigned int cpu);
+
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 

