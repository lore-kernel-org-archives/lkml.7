Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52778ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318D9214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfJKNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:45:39 -0400
Received: from foss.arm.com ([217.140.110.172]:60890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfJKNph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB21337;
        Fri, 11 Oct 2019 06:45:36 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14AF73F68E;
        Fri, 11 Oct 2019 06:45:34 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 2/6] sched/cpufreq: Attach perf domain to sugov policy
Date:   Fri, 11 Oct 2019 14:44:56 +0100
Message-Id: <20191011134500.235736-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attach an Energy Model perf_domain to each sugov_policy to prepare the
ground for energy-aware schedutil.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ba9e8309eec7..9abda58827c0 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -42,6 +42,10 @@ struct sugov_policy {
 
 	bool			limits_changed;
 	bool			need_freq_update;
+
+#ifdef CONFIG_ENERGY_MODEL
+	struct em_perf_domain *pd;
+#endif
 };
 
 struct sugov_cpu {
@@ -66,6 +70,38 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
+#ifdef CONFIG_ENERGY_MODEL
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy)
+{
+	struct em_perf_domain *pd;
+	struct cpufreq_policy *policy = sg_policy->policy;
+
+	sg_policy->pd = NULL;
+	pd = em_cpu_get(policy->cpu);
+	if (!pd)
+		return;
+
+	if (cpumask_equal(policy->related_cpus, to_cpumask(pd->cpus)))
+		sg_policy->pd = pd;
+	else
+		pr_warn("%s: Not all CPUs in schedutil policy %u share the same perf domain, no perf domain for that policy will be registered\n",
+			__func__, policy->cpu);
+}
+
+static struct em_perf_domain *sugov_policy_get_pd(
+						struct sugov_policy *sg_policy)
+{
+	return sg_policy->pd;
+}
+#else /* CONFIG_ENERGY_MODEL */
+static void sugov_policy_attach_pd(struct sugov_policy *sg_policy) {}
+static struct em_perf_domain *sugov_policy_get_pd(
+						struct sugov_policy *sg_policy)
+{
+	return NULL;
+}
+#endif /* CONFIG_ENERGY_MODEL */
+
 static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 {
 	s64 delta_ns;
@@ -859,6 +895,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 							sugov_update_shared :
 							sugov_update_single);
 	}
+
+	sugov_policy_attach_pd(sg_policy);
+
 	return 0;
 }
 
-- 
2.23.0

