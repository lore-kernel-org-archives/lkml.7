Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B2D218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfCVOcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:32:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbfCVOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:32:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28355CEB0B4204BA1670;
        Fri, 22 Mar 2019 22:32:05 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:31:57 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched/core: Make some functions static
Date:   Fri, 22 Mar 2019 22:31:53 +0800
Message-ID: <20190322143153.14416-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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

kernel/sched/core.c:6576:11: warning: symbol 'max_cfs_quota_period' was not declared. Should it be static?
kernel/sched/core.c:6577:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
kernel/sched/core.c:6657:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
kernel/sched/core.c:6670:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
kernel/sched/core.c:6683:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
kernel/sched/core.c:6693:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48..5ddab2f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6573,8 +6573,8 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
-const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
-const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+static const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
+static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -6654,7 +6654,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	return ret;
 }
 
-int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
+static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
 	u64 quota, period;
 
@@ -6667,7 +6667,7 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_quota(struct task_group *tg)
+static long tg_get_cfs_quota(struct task_group *tg)
 {
 	u64 quota_us;
 
@@ -6680,7 +6680,7 @@ long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
-int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
+static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
@@ -6690,7 +6690,7 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_period(struct task_group *tg)
+static long tg_get_cfs_period(struct task_group *tg)
 {
 	u64 cfs_period_us;
 
-- 
2.7.0


