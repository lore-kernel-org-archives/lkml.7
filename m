Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E84C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC13C20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfDRNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:30:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388263AbfDRNaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:30:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 572B3CC30724AF69DA00;
        Thu, 18 Apr 2019 21:30:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 21:29:54 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] sched/core: Make some functions static
Date:   Thu, 18 Apr 2019 21:29:37 +0800
Message-ID: <20190418132937.36324-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

kernel/sched/core.c:6524:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
kernel/sched/core.c:6604:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
kernel/sched/core.c:6617:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
kernel/sched/core.c:6630:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
kernel/sched/core.c:6640:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: do not make max_cfs_quota_period static, which has be used in kernel/sched/fair.c
---
 kernel/sched/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
 
-- 
2.7.4


