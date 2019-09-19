Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60794C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B2206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfISHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:20:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29782 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727435AbfISHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:20:31 -0400
X-UUID: fc7af5658cfe446e889f9502c20999bf-20190919
X-UUID: fc7af5658cfe446e889f9502c20999bf-20190919
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2040254327; Thu, 19 Sep 2019 15:20:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 19 Sep 2019 15:20:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 19 Sep 2019 15:20:21 +0800
From:   YT Chang <yt.chang@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        YT Chang <yt.chang@mediatek.com>
Subject: [PATCH 1/1] sched/eas: introduce system-wide overutil indicator
Date:   Thu, 19 Sep 2019 15:20:22 +0800
Message-ID: <1568877622-28073-1-git-send-email-yt.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is overutilization, the load-balance crossing
clusters will be triggered and scheduler will not use energy
aware scheduling to choose CPUs.

The overutilization means the loading of  ANY CPUs
exceeds threshold (80%).

However, only 1 heavy task or while-1 program will run on highest
capacity CPUs and it still result to trigger overutilization. So
the system will not use Energy Aware scheduling.

To avoid it, a system-wide over-utilization indicator to trigger
load-balance cross clusters.

The policy is:
	The loading of "ALL CPUs in the highest capacity"
						exceeds threshold(80%) or
	The loading of "Any CPUs not in the highest capacity"
						exceed threshold(80%)

Signed-off-by: YT Chang <yt.chang@mediatek.com>
---
 kernel/sched/fair.c | 76 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95..f4c3d70 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5182,10 +5182,71 @@ static inline bool cpu_overutilized(int cpu)
 static inline void update_overutilized_status(struct rq *rq)
 {
 	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
+		if (capacity_orig_of(cpu_of(rq)) < rq->rd->max_cpu_capacity) {
+			WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
+			trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
+		}
 	}
 }
+
+static
+void update_system_overutilized(struct sched_domain *sd, struct cpumask *cpus)
+{
+	unsigned long group_util;
+	bool intra_overutil = false;
+	unsigned long max_capacity;
+	struct sched_group *group = sd->groups;
+	struct root_domain *rd;
+	int this_cpu;
+	bool overutilized;
+	int i;
+
+	this_cpu = smp_processor_id();
+	rd = cpu_rq(this_cpu)->rd;
+	overutilized = READ_ONCE(rd->overutilized);
+	max_capacity = rd->max_cpu_capacity;
+
+	do {
+		group_util = 0;
+		for_each_cpu_and(i, sched_group_span(group), cpus) {
+			group_util += cpu_util(i);
+			if (cpu_overutilized(i)) {
+				if (capacity_orig_of(i) < max_capacity) {
+					intra_overutil = true;
+					break;
+				}
+			}
+		}
+
+		/*
+		 * A capacity base hint for over-utilization.
+		 * Not to trigger system overutiled if heavy tasks
+		 * in Big.cluster, so
+		 * add the free room(20%) of Big.cluster is impacted which means
+		 * system-wide over-utilization,
+		 * that considers whole cluster not single cpu
+		 */
+		if (group->group_weight > 1 && (group->sgc->capacity * 1024 <
+						group_util * capacity_margin)) {
+			intra_overutil = true;
+			break;
+		}
+
+		group = group->next;
+
+	} while (group != sd->groups && !intra_overutil);
+
+	if (overutilized != intra_overutil) {
+		if (intra_overutil == true) {
+			WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
+			trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		} else {
+			WRITE_ONCE(rd->overutilized, 0);
+			trace_sched_overutilized_tp(rd, 0);
+		}
+	}
+}
+
 #else
 static inline void update_overutilized_status(struct rq *rq) { }
 #endif
@@ -8242,15 +8303,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		/* update overload indicator if we are at root domain */
 		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
-
-		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
-	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
 	}
 }
 
@@ -8476,6 +8528,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 */
 	update_sd_lb_stats(env, &sds);
 
+	update_system_overutilized(env->sd, env->cpus);
+
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;
 
-- 
1.9.1

