Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5B9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BE1217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbfDROv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:51:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733192AbfDROv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:51:57 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7FD7968810277CDD1E9D;
        Thu, 18 Apr 2019 22:51:33 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 22:51:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 -next] sched/core: Make some functions static
Date:   Thu, 18 Apr 2019 22:47:13 +0800
Message-ID: <20190418144713.34332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190322143153.14416-1-yuehaibing@huawei.com>
References: <20190322143153.14416-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix these sparse warnings:

  kernel/sched/core.c:6577:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
  kernel/sched/core.c:6657:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
  kernel/sched/core.c:6670:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
  kernel/sched/core.c:6683:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
  kernel/sched/core.c:6693:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
  kernel/sched/fair.c:2596:6: warning: symbol 'task_tick_numa' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190322143153.14416-1-yuehaibing@huawei.com
---
v2: do not make max_cfs_quota_period static, which has be used in kernel/sched/fair.c
v3: fix commit log
---
 kernel/sched/core.c | 10 +++++-----
 kernel/sched/fair.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9e9117..226d68c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6521,7 +6521,7 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
-const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -6601,7 +6601,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	return ret;
 }
 
-int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
+static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
 	u64 quota, period;
 
@@ -6614,7 +6614,7 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_quota(struct task_group *tg)
+static long tg_get_cfs_quota(struct task_group *tg)
 {
 	u64 quota_us;
 
@@ -6627,7 +6627,7 @@ long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
-int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
+static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
@@ -6637,7 +6637,7 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_period(struct task_group *tg)
+static long tg_get_cfs_period(struct task_group *tg)
 {
 	u64 cfs_period_us;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 99731a5..4275eb0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2593,7 +2593,7 @@ void task_numa_work(struct callback_head *work)
 /*
  * Drive the periodic memory faults..
  */
-void task_tick_numa(struct rq *rq, struct task_struct *curr)
+static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
-- 
2.7.4


