Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F25C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8720B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j6er723Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfHFLT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:19:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHFLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:19:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76BJLHk2142127
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 04:19:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76BJLHk2142127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565090363;
        bh=HLAXuMY+kBpz9A22miFP8B5VmGp1wETWEEUWh5quAYo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=j6er723ZjuBGiD/g1FAUnt5rE2bUvywBvwwPUpw4a+6ySA6DXLJcbmU9AFCJCjZGW
         rMn/qP+73topYWW8FQiMMqnr+6JFfpTNkL2aaWgjf1uRWuucex8sLk2Y2z3AVTiuh8
         ds8+HTX33IpU3Vz1dHi02HNQdgHxy8e3DQgdh0saEa0/3xI4Lns7YqIoasYdty+9uv
         5DVudD3KbqholdWcozteo7YHUmfh2Abm/BQTnqGvs7sq8bwoeyWGNy5FGguVIAtmOm
         pQ+/kLeW40UxArmVJvWU36jVTR+4kurP2V5tuyMGQshZa5D0yWEqA8NXZpii/+iUNe
         EgSrcKklzrWkQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76BJKFA2142116;
        Tue, 6 Aug 2019 04:19:20 -0700
Date:   Tue, 6 Aug 2019 04:19:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-f4904815f97a934258445a8f763f6b6c48f007e7@git.kernel.org>
Cc:     hpa@zytor.com, luca.abeni@santannapisa.it,
        valentin.schneider@arm.com, tglx@linutronix.de,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        juri.lelli@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org
Reply-To: dietmar.eggemann@arm.com, tglx@linutronix.de,
          qais.yousef@arm.com, luca.abeni@santannapisa.it, hpa@zytor.com,
          valentin.schneider@arm.com, peterz@infradead.org,
          mingo@kernel.org, bristot@redhat.com, juri.lelli@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190802145945.18702-2-dietmar.eggemann@arm.com>
References: <20190802145945.18702-2-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/deadline: Fix double accounting of
 rq/running bw in push & pull
Git-Commit-ID: f4904815f97a934258445a8f763f6b6c48f007e7
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

Commit-ID:  f4904815f97a934258445a8f763f6b6c48f007e7
Gitweb:     https://git.kernel.org/tip/f4904815f97a934258445a8f763f6b6c48f007e7
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Fri, 2 Aug 2019 15:59:43 +0100
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:18 +0200

sched/deadline: Fix double accounting of rq/running bw in push & pull

{push,pull}_dl_task() always calls {de,}activate_task() with .flags=0
which sets p->on_rq=TASK_ON_RQ_MIGRATING.

{push,pull}_dl_task()->{de,}activate_task()->{de,en}queue_task()->
{de,en}queue_task_dl() calls {sub,add}_{running,rq}_bw() since
p->on_rq==TASK_ON_RQ_MIGRATING.
So {sub,add}_{running,rq}_bw() in {push,pull}_dl_task() is
double-accounting for that task.

Fix it by removing rq/running bw accounting in [push/pull]_dl_task().

Fixes: 7dd778841164 ("sched/core: Unify p->on_rq updates")
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Link: https://lkml.kernel.org/r/20190802145945.18702-2-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b9f6b1d42..46122edd8552 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2088,17 +2088,13 @@ retry:
 	}
 
 	deactivate_task(rq, next_task, 0);
-	sub_running_bw(&next_task->dl, &rq->dl);
-	sub_rq_bw(&next_task->dl, &rq->dl);
 	set_task_cpu(next_task, later_rq->cpu);
-	add_rq_bw(&next_task->dl, &later_rq->dl);
 
 	/*
 	 * Update the later_rq clock here, because the clock is used
 	 * by the cpufreq_update_util() inside __add_running_bw().
 	 */
 	update_rq_clock(later_rq);
-	add_running_bw(&next_task->dl, &later_rq->dl);
 	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
 	ret = 1;
 
@@ -2186,11 +2182,7 @@ static void pull_dl_task(struct rq *this_rq)
 			resched = true;
 
 			deactivate_task(src_rq, p, 0);
-			sub_running_bw(&p->dl, &src_rq->dl);
-			sub_rq_bw(&p->dl, &src_rq->dl);
 			set_task_cpu(p, this_cpu);
-			add_rq_bw(&p->dl, &this_rq->dl);
-			add_running_bw(&p->dl, &this_rq->dl);
 			activate_task(this_rq, p, 0);
 			dmin = p->dl.deadline;
 
