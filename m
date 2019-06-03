Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69EEC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC927FA6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hwp8GWSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFCNBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:01:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFCNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:01:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D1HDv601975
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:01:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D1HDv601975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559566877;
        bh=OWUJyhC9IA0iKKiWAf9/5/ilDDYEFmXnHRQGn8UTNKQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hwp8GWSacmbkLUejV5qt++lv/NReYe2Iqf2hIDrrpS6AaXGoR1Al7yhOtqNxWc9sg
         b6xqY+Ru9cLUEN6A8x9dqn6qPY8338Pvij2IgfhIlzYvxBg8avE1PCIJsDSlwXGuGs
         AYLa8ue4We8dZ77loMn7z445bOMaS0mrW8V57Llckeoa9Njc9JevgHUfcyeM6G8/O1
         BJNSjlC7vRMooAEtYc9dtMoIQXFitzjtN+A58h6ovCJqMcVZwmd4YY3vmStZJbcyjI
         /B7LD7txsgYC4mkRmcUbYuG3j8is70VEpr2T9k+vUqosHcNxWY8y2ctJQkwqs0p/t+
         DBpKL72MpxVvw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D1GS9601972;
        Mon, 3 Jun 2019 06:01:16 -0700
Date:   Mon, 3 Jun 2019 06:01:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-f2bedc4705659216bd60948029ad8dfedf923ad9@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        dietmar.eggemann@arm.com, peterz@infradead.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, dietmar.eggemann@arm.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190424084556.604-1-dietmar.eggemann@arm.com>
References: <20190424084556.604-1-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove rq->load
Git-Commit-ID: f2bedc4705659216bd60948029ad8dfedf923ad9
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

Commit-ID:  f2bedc4705659216bd60948029ad8dfedf923ad9
Gitweb:     https://git.kernel.org/tip/f2bedc4705659216bd60948029ad8dfedf923ad9
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Wed, 24 Apr 2019 09:45:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:37 +0200

sched/fair: Remove rq->load

The CFS class is the only one maintaining and using the CPU wide load
(rq->load(.weight)). The last use case of the CPU wide load in CFS's
set_next_entity() can be replaced by using the load of the CFS class
(rq->cfs.load(.weight)) instead.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190424084556.604-1-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 2 --
 kernel/sched/fair.c  | 7 ++-----
 kernel/sched/sched.h | 2 --
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 678bfb9bd87f..150043e1d716 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -656,8 +656,6 @@ do {									\
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rq->x))
 
 	P(nr_running);
-	SEQ_printf(m, "  .%-30s: %lu\n", "load",
-		   rq->load.weight);
 	P(nr_switches);
 	P(nr_load_updates);
 	P(nr_uninterruptible);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8691a8fffe40..08b1cb06f968 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2686,8 +2686,6 @@ static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_add(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_add(&rq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -2703,8 +2701,6 @@ static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	update_load_sub(&cfs_rq->load, se->load.weight);
-	if (!parent_entity(se))
-		update_load_sub(&rq_of(cfs_rq)->load, se->load.weight);
 #ifdef CONFIG_SMP
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
@@ -4100,7 +4096,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * least twice that of our own weight (i.e. dont track it
 	 * when there are only lesser-weight tasks around):
 	 */
-	if (schedstat_enabled() && rq_of(cfs_rq)->load.weight >= 2*se->load.weight) {
+	if (schedstat_enabled() &&
+	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
 		schedstat_set(se->statistics.slice_max,
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1ada0be..c308410675ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -830,8 +830,6 @@ struct rq {
 	atomic_t nohz_flags;
 #endif /* CONFIG_NO_HZ_COMMON */
 
-	/* capture load from *all* tasks on this CPU: */
-	struct load_weight	load;
 	unsigned long		nr_load_updates;
 	u64			nr_switches;
 
