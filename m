Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBB3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B472084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gNd+cUPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfDHVqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfDHVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38LWQak026789
        for <linux-kernel@vger.kernel.org>; Mon, 8 Apr 2019 14:46:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=L+rJS0SgXG+W7FCDQpKsebmkzZCRJJh5uOQMvLo7MzE=;
 b=gNd+cUPSgQXxXIhjvJseHkOL7XwB5XP+q3C9UVkwAkjEBv/UCphHt9nsq1/z40TIh1z2
 qSW7TovkGlfR6rMDTsyYno3vwc8WxOjE0KB4u3yMzLm50Ck3MbK4Ib5QPm5kzXRRhDo+
 mPao9/eHbGukPrYnRtlaw1H6CfF2ZlkBPVg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rrdhe87jp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:46:02 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 8 Apr 2019 14:45:59 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6D36862E1F66; Mon,  8 Apr 2019 14:45:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <tglx@linutronix.de>,
        <morten.rasmussen@arm.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 1/7] sched: refactor tg_set_cfs_bandwidth()
Date:   Mon, 8 Apr 2019 14:45:33 -0700
Message-ID: <20190408214539.2705660-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch factors tg_switch_cfs_runtime() out of tg_set_cfs_bandwidth(),
so that next patches can extend tg_switch_cfs_runtime() to support the new
target_idle_pct value.

This patch doesn't have any functionality changes.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/sched/core.c | 71 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ead464a0f2e5..b8f220860dc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6578,39 +6578,12 @@ const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+/* need get_online_cpus() and hold cfs_constraints_mutex */
+static void tg_switch_cfs_runtime(struct task_group *tg, u64 period, u64 quota)
 {
-	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-
-	if (tg == &root_task_group)
-		return -EINVAL;
-
-	/*
-	 * Ensure we have at some amount of bandwidth every period.  This is
-	 * to prevent reaching a state of large arrears when throttled via
-	 * entity_tick() resulting in prolonged exit starvation.
-	 */
-	if (quota < min_cfs_quota_period || period < min_cfs_quota_period)
-		return -EINVAL;
-
-	/*
-	 * Likewise, bound things on the otherside by preventing insane quota
-	 * periods.  This also allows us to normalize in computing quota
-	 * feasibility.
-	 */
-	if (period > max_cfs_quota_period)
-		return -EINVAL;
-
-	/*
-	 * Prevent race between setting of cfs_rq->runtime_enabled and
-	 * unthrottle_offline_cfs_rqs().
-	 */
-	get_online_cpus();
-	mutex_lock(&cfs_constraints_mutex);
-	ret = __cfs_schedulable(tg, period, quota);
-	if (ret)
-		goto out_unlock;
+	int runtime_enabled, runtime_was_enabled;
+	int i;
 
 	runtime_enabled = quota != RUNTIME_INF;
 	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
@@ -6647,7 +6620,41 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	}
 	if (runtime_was_enabled && !runtime_enabled)
 		cfs_bandwidth_usage_dec();
-out_unlock:
+}
+
+static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+{
+	int ret = 0;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	/*
+	 * Ensure we have at some amount of bandwidth every period.  This is
+	 * to prevent reaching a state of large arrears when throttled via
+	 * entity_tick() resulting in prolonged exit starvation.
+	 */
+	if (quota < min_cfs_quota_period || period < min_cfs_quota_period)
+		return -EINVAL;
+
+	/*
+	 * Likewise, bound things on the otherside by preventing insane quota
+	 * periods.  This also allows us to normalize in computing quota
+	 * feasibility.
+	 */
+	if (period > max_cfs_quota_period)
+		return -EINVAL;
+
+	/*
+	 * Prevent race between setting of cfs_rq->runtime_enabled and
+	 * unthrottle_offline_cfs_rqs().
+	 */
+	get_online_cpus();
+	mutex_lock(&cfs_constraints_mutex);
+	ret = __cfs_schedulable(tg, period, quota);
+	if (!ret)
+		tg_switch_cfs_runtime(tg, period, quota);
+
 	mutex_unlock(&cfs_constraints_mutex);
 	put_online_cpus();
 
-- 
2.17.1

