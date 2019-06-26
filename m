Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F048C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E824121726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSPFdwXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFZWxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:53:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:53:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMmbTt100137;
        Wed, 26 Jun 2019 22:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=qBZ7pNks6jwo/erAtSEGIYGdwoUp6z0ruzJGXHPePbc=;
 b=OSPFdwXkb8zzsDaUD7p/4rk/q8wqeFrWJluBr0no/A6YEF8DD+FgvoBt0agQagH0KCNI
 j3YW+MyVDcuMp8XF7EzVsoWDCJg16CNILBKVBTJ1J5XTj8P6ohgI5uPccWP0XSafPaVg
 /MELywSlXjEsxjgwk9VS1XzgYqPMSnXRyR9fKNDjHv92F6HK6btE8yflNW9YClSaR+TJ
 OIYccXufbcU0XbRIJqeUl/49zjxjRwnid/QH463+sJnyKRZuN8VOY3r3bkO0gpX+QkSH
 xuxyCwUAThkdOUxbv6TdOObPh8Yc9jcVJrqLSnl07JQg75cOPk3y2iNOAy+yeDkdBeFD IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtd1aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMpwXx075672;
        Wed, 26 Jun 2019 22:52:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t99f4q9x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5QMqQVF015930;
        Wed, 26 Jun 2019 22:52:26 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 15:52:26 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [RFC PATCH 3/3] sched: introduce tunables to control soft affinity
Date:   Wed, 26 Jun 2019 15:47:18 -0700
Message-Id: <20190626224718.21973-4-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=973
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For different workloads the optimal "softness" of soft affinity can be
different. Introduce tunables sched_allowed and sched_preferred that can
be tuned via /proc. This allows to chose at what utilization difference
the scheduler will chose cpus_allowed over cpus_preferred in the first
level of search. Depending on the extent of data sharing, cache coherency
overhead of the system etc. the optimal point may vary.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/fair.c          | 19 ++++++++++++++++++-
 kernel/sched/sched.h         |  2 ++
 kernel/sysctl.c              | 14 ++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99ce6d7..0e75602 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -41,6 +41,8 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+extern __read_mostly unsigned int sysctl_sched_preferred;
+extern __read_mostly unsigned int sysctl_sched_allowed;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53aa7f2..d222d78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -85,6 +85,8 @@ unsigned int sysctl_sched_wakeup_granularity			= 1000000UL;
 static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+const_debug unsigned int sysctl_sched_preferred		= 1UL;
+const_debug unsigned int sysctl_sched_allowed		= 100UL;
 
 #ifdef CONFIG_SMP
 /*
@@ -6739,7 +6741,22 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
-	struct cpumask *cpus = &p->cpus_preferred;
+	int cpux, cpuy;
+	struct cpumask *cpus;
+
+	if (!p->affinity_unequal) {
+		cpus = &p->cpus_allowed;
+	} else {
+		cpux = cpumask_any(&p->cpus_preferred);
+		cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+		cpumask_andnot(cpus, &p->cpus_allowed, &p->cpus_preferred);
+		cpuy = cpumask_any(cpus);
+		if (sysctl_sched_preferred * cpu_rq(cpux)->cfs.avg.util_avg >
+		    sysctl_sched_allowed * cpu_rq(cpuy)->cfs.avg.util_avg)
+			cpus = &p->cpus_allowed;
+		else
+			cpus = &p->cpus_preferred;
+	}
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..f856bdb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1863,6 +1863,8 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
+extern const_debug unsigned int sysctl_sched_preferred;
+extern const_debug unsigned int sysctl_sched_allowed;
 
 #ifdef CONFIG_SCHED_HRTICK
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7d1008b..bdffb48 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -383,6 +383,20 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "sched_preferred",
+		.data           = &sysctl_sched_preferred,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
+		.procname       = "sched_allowed",
+		.data           = &sysctl_sched_allowed,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
2.9.3

