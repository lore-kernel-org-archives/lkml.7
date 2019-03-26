Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DAD206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfCZLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:22:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53358 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:22:08 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 0c7d4342ac95eade; Tue, 26 Mar 2019 12:22:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 2/4] cpufreq: Add cpufreq_cpu_acquire() and cpufreq_cpu_release()
Date:   Tue, 26 Mar 2019 12:16:58 +0100
Message-ID: <4367018.ucxPRbh1Da@aspire.rjw.lan>
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

It sometimes is necessary to find a cpufreq policy for a given CPU
and acquire its rwsem (for writing) immediately after that, so
introduce cpufreq_cpu_acquire() as a helper for that and the
complementary cpufreq_cpu_release().

Make cpufreq_update_policy() use the new functions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

v2 -> v3:
  * Added Acked-by from Viresh.

---
 drivers/cpufreq/cpufreq.c |   56 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -250,6 +250,51 @@ void cpufreq_cpu_put(struct cpufreq_poli
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
+/**
+ * cpufreq_cpu_release - Unlock a policy and decrement its usage counter.
+ * @policy: cpufreq policy returned by cpufreq_cpu_acquire().
+ */
+static void cpufreq_cpu_release(struct cpufreq_policy *policy)
+{
+	if (WARN_ON(!policy))
+		return;
+
+	lockdep_assert_held(&policy->rwsem);
+
+	up_write(&policy->rwsem);
+
+	cpufreq_cpu_put(policy);
+}
+
+/**
+ * cpufreq_cpu_acquire - Find policy for a CPU, mark it as busy and lock it.
+ * @cpu: CPU to find the policy for.
+ *
+ * Call cpufreq_cpu_get() to get a reference on the cpufreq policy for @cpu and
+ * if the policy returned by it is not NULL, acquire its rwsem for writing.
+ * Return the policy if it is active or release it and return NULL otherwise.
+ *
+ * The policy returned by this function has to be released with the help of
+ * cpufreq_cpu_release() in order to release its rwsem and balance its usage
+ * counter properly.
+ */
+static struct cpufreq_policy *cpufreq_cpu_acquire(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return NULL;
+
+	down_write(&policy->rwsem);
+
+	if (policy_is_inactive(policy)) {
+		cpufreq_cpu_release(policy);
+		return NULL;
+	}
+
+	return policy;
+}
+
 /*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
@@ -2337,17 +2382,12 @@ static int cpufreq_set_policy(struct cpu
  */
 void cpufreq_update_policy(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
 	struct cpufreq_policy new_policy;
 
 	if (!policy)
 		return;
 
-	down_write(&policy->rwsem);
-
-	if (policy_is_inactive(policy))
-		goto unlock;
-
 	/*
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
@@ -2364,9 +2404,7 @@ void cpufreq_update_policy(unsigned int
 	cpufreq_set_policy(policy, &new_policy);
 
 unlock:
-	up_write(&policy->rwsem);
-
-	cpufreq_cpu_put(policy);
+	cpufreq_cpu_release(policy);
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 

