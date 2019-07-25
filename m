Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA070C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F29C22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BLnRdG+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbfGYQWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:22:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbfGYQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:22:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGLxI01076400
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:21:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGLxI01076400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071719;
        bh=QXOXO9wq4aev/cbpwXbEdrVvuV4twTGcbRXaVH2AxoU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BLnRdG+ljfNmUt1LU427KJWCAwUEPuWWOY+7SapLihk2V4VKgkfKvCX8RM4feWfBG
         lailTTW8LquR4mXg62u4E3pu8hs+lCqa/5vXQOUufSaMYa6aHTd0834NRu2NmDy9dm
         muEFMB/9GM/ReZPiCZhoSKGCUjWu78NJqIvV3nxNV+UVGAQwC2eGY+Ir1v/MoLk4JY
         GhZ1kiVFSPmqARJPdhMtMUCoPyo9xdcI+FGnb749R2vFGwdUQKcD1gA6BQm515LwGq
         MO2mVxOW/zq5e0jgft3cc/HH3X5UMAFJFqkRG9DH4qSHwNMBKHwpiXv3YATME5dOwH
         FNFHZpglr10uw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGLw7l1076397;
        Thu, 25 Jul 2019 09:21:58 -0700
Date:   Thu, 25 Jul 2019 09:21:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-59d06cea1198d665ba11f7e8c5f45b00ff2e4812@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        juri.lelli@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, dietmar.eggemann@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, juri.lelli@redhat.com, mingo@kernel.org
In-Reply-To: <20190719140000.31694-5-juri.lelli@redhat.com>
References: <20190719140000.31694-5-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/deadline: Fix bandwidth accounting at all
 levels after offline migration
Git-Commit-ID: 59d06cea1198d665ba11f7e8c5f45b00ff2e4812
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  59d06cea1198d665ba11f7e8c5f45b00ff2e4812
Gitweb:     https://git.kernel.org/tip/59d06cea1198d665ba11f7e8c5f45b00ff2e4812
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 15:59:56 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:02 +0200

sched/deadline: Fix bandwidth accounting at all levels after offline migration

If a task happens to be throttled while the CPU it was running on gets
hotplugged off, the bandwidth associated with the task is not correctly
migrated with it when the replenishment timer fires (offline_migration).

Fix things up, for this_bw, running_bw and total_bw, when replenishment
timer fires and task is migrated (dl_task_offline_migration()).

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: mathieu.poirier@linaro.org
Cc: rostedt@goodmis.org
Cc: tj@kernel.org
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-5-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f9d2180be23..039dde2b1dac 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -529,6 +529,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq);
 static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p)
 {
 	struct rq *later_rq = NULL;
+	struct dl_bw *dl_b;
 
 	later_rq = find_lock_later_rq(p, rq);
 	if (!later_rq) {
@@ -557,6 +558,38 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 		double_lock_balance(rq, later_rq);
 	}
 
+	if (p->dl.dl_non_contending || p->dl.dl_throttled) {
+		/*
+		 * Inactive timer is armed (or callback is running, but
+		 * waiting for us to release rq locks). In any case, when it
+		 * will fire (or continue), it will see running_bw of this
+		 * task migrated to later_rq (and correctly handle it).
+		 */
+		sub_running_bw(&p->dl, &rq->dl);
+		sub_rq_bw(&p->dl, &rq->dl);
+
+		add_rq_bw(&p->dl, &later_rq->dl);
+		add_running_bw(&p->dl, &later_rq->dl);
+	} else {
+		sub_rq_bw(&p->dl, &rq->dl);
+		add_rq_bw(&p->dl, &later_rq->dl);
+	}
+
+	/*
+	 * And we finally need to fixup root_domain(s) bandwidth accounting,
+	 * since p is still hanging out in the old (now moved to default) root
+	 * domain.
+	 */
+	dl_b = &rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
+	dl_b = &later_rq->rd->dl_bw;
+	raw_spin_lock(&dl_b->lock);
+	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
+	raw_spin_unlock(&dl_b->lock);
+
 	set_task_cpu(p, later_rq->cpu);
 	double_unlock_balance(later_rq, rq);
 
