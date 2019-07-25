Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77890C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFFE22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tN8yDbDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbfGYQVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:21:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390290AbfGYQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:21:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGKTjF1075936
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:20:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGKTjF1075936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071630;
        bh=OjJcIDsithbhnVAWVLbLzBAxy2b8U3Yjyyw230E+ApM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tN8yDbDdBGCrZnIadyvU+/LR/WcHyIc5Z5il+pPsKE1qxpTHY0Dm05EQcunT+Fzup
         vshOLKabFNYyV4WCJl9z71WTmXHZ3d2wVoBxBuDpRa5BNFU5p2wvb5U4bDwp/wvnB4
         lGdfn3C7dtYIjiM5XdVsthLQ5rLB5kjUIS07H0qr+GRZYdRpuLrKRalqGxLrXqc/5I
         ZUS3nSobcgn6YIfxEPvRXbGRgI3sn8y/CIyilz7BbBNUAQhQjuszbyfpO85raSZRy0
         Q8+wBWpdFlEqXvHyPUTiId1xp+DXC7qEQI1VPS6BjCJUK3c6UUhQyWllePEnBjuZzw
         EQ94OEFRwNdkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGKSWW1075933;
        Thu, 25 Jul 2019 09:20:28 -0700
Date:   Thu, 25 Jul 2019 09:20:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-4b211f2b129dd1f6a6956bbc76e2f232c1ec3ad8@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        rostedt@goodmis.org, hpa@zytor.com, tj@kernel.org
Reply-To: dietmar.eggemann@arm.com, mingo@kernel.org, peterz@infradead.org,
          tj@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
In-Reply-To: <20190719140000.31694-3-juri.lelli@redhat.com>
References: <20190719140000.31694-3-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Streamle calls to task_rq_unlock()
Git-Commit-ID: 4b211f2b129dd1f6a6956bbc76e2f232c1ec3ad8
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

Commit-ID:  4b211f2b129dd1f6a6956bbc76e2f232c1ec3ad8
Gitweb:     https://git.kernel.org/tip/4b211f2b129dd1f6a6956bbc76e2f232c1ec3ad8
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 19 Jul 2019 15:59:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:57 +0200

sched/core: Streamle calls to task_rq_unlock()

Calls to task_rq_unlock() are done several times in the
__sched_setscheduler() function.  This is fine when only the rq lock needs to be
handled but not so much when other locks come into play.

This patch streamlines the release of the rq lock so that only one
location need to be modified when dealing with more than one lock.

No change of functionality is introduced by this patch.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-3-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0b22e55cebe8..1af3d2dc6b29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4712,8 +4712,8 @@ recheck:
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4731,8 +4731,8 @@ recheck:
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4745,8 +4745,8 @@ change:
 		if (rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
 				!task_group_is_autogroup(task_group(p))) {
-			task_rq_unlock(rq, p, &rf);
-			return -EPERM;
+			retval = -EPERM;
+			goto unlock;
 		}
 #endif
 #ifdef CONFIG_SMP
@@ -4761,8 +4761,8 @@ change:
 			 */
 			if (!cpumask_subset(span, p->cpus_ptr) ||
 			    rq->rd->dl_bw.bw == 0) {
-				task_rq_unlock(rq, p, &rf);
-				return -EPERM;
+				retval = -EPERM;
+				goto unlock;
 			}
 		}
 #endif
@@ -4781,8 +4781,8 @@ change:
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4840,6 +4840,10 @@ change:
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
