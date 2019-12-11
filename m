Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D93C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07D324653
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfLKQor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:44:47 -0500
Received: from foss.arm.com ([217.140.110.172]:38676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbfLKQok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE490106F;
        Wed, 11 Dec 2019 08:44:39 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA1E83F52E;
        Wed, 11 Dec 2019 08:44:38 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH 5/7] sched/topology: Make {lowest/highest}_flag_domain() work with > 1 flags
Date:   Wed, 11 Dec 2019 16:43:59 +0000
Message-Id: <20191211164401.5013-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, select_task_rq_fair() ends up looking for the highest domain
with both SD_LOAD_BALANCE and one of SD_BALANCE_{WAKE, FORK, EXEC}.
This is pretty much a highest_flag_domain() call, but that latter
can only cope with a single flag.

Make the existing helpers cope with being passed more than one flag. While
at it, rename them to make their newfound powers explicit.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h    | 23 ++++++++++++++++-------
 kernel/sched/topology.c |  8 ++++----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62efc0443cac..233b3d41e347 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1340,20 +1340,20 @@ extern void sched_ttwu_pending(void);
 #define for_each_lower_domain(sd) for (; sd; sd = sd->child)
 
 /**
- * highest_flag_domain - Return highest sched_domain containing flag.
+ * highest_flags_domain - Return highest sched_domain containing flags.
  * @cpu:	The CPU whose highest level of sched domain is to
  *		be returned.
- * @flag:	The flag to check for the highest sched_domain
+ * @flags:	The flags to check for the highest sched_domain
  *		for the given CPU.
  *
- * Returns the highest sched_domain of a CPU which contains the given flag.
+ * Returns the highest sched_domain of a CPU which contains all given flags.
  */
-static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
+static inline struct sched_domain *highest_flags_domain(int cpu, int flags)
 {
 	struct sched_domain *sd, *hsd = NULL;
 
 	for_each_domain(cpu, sd) {
-		if (!(sd->flags & flag))
+		if (!((sd->flags & flags) == flags))
 			break;
 		hsd = sd;
 	}
@@ -1361,12 +1361,21 @@ static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
 	return hsd;
 }
 
-static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
+/**
+ * lowest_flags_domain - Return lowest sched_domain containing flags.
+ * @cpu:	The CPU whose lowest level of sched domain is to
+ *		be returned.
+ * @flags:	The flags to check for the lowest sched_domain
+ *		for the given CPU.
+ *
+ * Returns the lowest sched_domain of a CPU which contains all given flags.
+ */
+static inline struct sched_domain *lowest_flags_domain(int cpu, int flags)
 {
 	struct sched_domain *sd;
 
 	for_each_domain(cpu, sd) {
-		if (sd->flags & flag)
+		if ((sd->flags & flags) == flags)
 			break;
 	}
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..f0d2a15fd10b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -631,7 +631,7 @@ static void update_top_cache_domain(int cpu)
 	int id = cpu;
 	int size = 1;
 
-	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
+	sd = highest_flags_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
@@ -643,13 +643,13 @@ static void update_top_cache_domain(int cpu)
 	per_cpu(sd_llc_id, cpu) = id;
 	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
 
-	sd = lowest_flag_domain(cpu, SD_NUMA);
+	sd = lowest_flags_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
-	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
+	sd = highest_flags_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	sd = lowest_flags_domain(cpu, SD_ASYM_CPUCAPACITY);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
-- 
2.24.0

