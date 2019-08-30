Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE7C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCC820659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c70EPeV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfH3Rzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:55:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfH3Rzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:55:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHt6R1088743;
        Fri, 30 Aug 2019 17:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Uiw8kLTHQwxH8dGS2dfqHcGpsWdogXJPScxnKcD/EgM=;
 b=c70EPeV1uOvaCjfvKoqlkwncy+7/Ff7aIbWIZKbPsI8Jf/qVhwgITnGZJM/bVX50znuE
 InKy2W2Y9h/IZKqwlRvKPBgqipb0FjtDtU2VVj2YJjnheqiek36hb+tVCIQLys5nmy5D
 m0qeTkqEBVz9ELY1LTOEVP9nitKlRpSL3keKsjQ7MXlT9c/KygeO9GEV65o5sdCFivwq
 d6lqB7rY0OU9+oIdpDrbltzDbQtgxjMG5xYapyUIkMLTCa5hMAaQVfItW81LofLkDOE4
 9Nj/T7VQ/OomInrfzghuzcUOr1/YRDF08h8a3Naazul9ogX+rMMb+3mHMj40PVdD6ACV aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uq8fsg212-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:55:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrW9A135784;
        Fri, 30 Aug 2019 17:54:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uphavh0h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHsW39014823;
        Fri, 30 Aug 2019 17:54:32 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:32 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Date:   Fri, 30 Aug 2019 10:49:36 -0700
Message-Id: <20190830174944.21741-2-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
"latency-nice" which is shared by all the threads in that Cgroup.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c   |  1 +
 kernel/sched/sched.h  |  8 ++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1183741..b4a79c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -631,6 +631,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	u64				latency_nice;
 
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427..47969bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5976,6 +5976,7 @@ void __init sched_init(void)
 		init_dl_rq(&rq->dl);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+		root_task_group.latency_nice = LATENCY_NICE_DEFAULT;
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
 		rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
 		/*
@@ -6345,6 +6346,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	 */
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
+	tsk->latency_nice = tg->latency_nice;
 	tg = autogroup_task_group(tsk, tg);
 	tsk->sched_task_group = tg;
 
@@ -6812,6 +6814,34 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+static u64 cpu_latency_nice_read_u64(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return tg->latency_nice;
+}
+
+static int cpu_latency_nice_write_u64(struct cgroup_subsys_state *css,
+				      struct cftype *cft, u64 latency_nice)
+{
+	struct task_group *tg = css_tg(css);
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	if (latency_nice < LATENCY_NICE_MIN || latency_nice > LATENCY_NICE_MAX)
+		return -ERANGE;
+
+	tg->latency_nice = latency_nice;
+
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		p->latency_nice = latency_nice;
+	css_task_iter_end(&it);
+
+	return 0;
+}
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -6848,6 +6878,11 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+	{
+		.name = "latency-nice",
+		.read_u64 = cpu_latency_nice_read_u64,
+		.write_u64 = cpu_latency_nice_write_u64,
+	},
 	{ }	/* Terminate */
 };
 
@@ -7015,6 +7050,11 @@ static struct cftype cpu_files[] = {
 		.write = cpu_max_write,
 	},
 #endif
+	{
+		.name = "latency-nice",
+		.read_u64 = cpu_latency_nice_read_u64,
+		.write_u64 = cpu_latency_nice_write_u64,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..b08d00c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10479,6 +10479,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_nice = LATENCY_NICE_DEFAULT;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..365c928 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -143,6 +143,13 @@ static inline void cpu_load_update_active(struct rq *this_rq) { }
 #define NICE_0_LOAD		(1L << NICE_0_LOAD_SHIFT)
 
 /*
+ * Latency-nice default value
+ */
+#define	LATENCY_NICE_DEFAULT	5
+#define	LATENCY_NICE_MIN	1
+#define	LATENCY_NICE_MAX	100
+
+/*
  * Single value that decides SCHED_DEADLINE internal math precision.
  * 10 -> just above 1us
  * 9  -> just above 0.5us
@@ -362,6 +369,7 @@ struct cfs_bandwidth {
 /* Task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
+	u64 latency_nice;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
-- 
2.9.3

