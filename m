Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDDCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AE7208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="gdzWXXbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfJ3Sef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45396 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfJ3Sea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:30 -0400
Received: by mail-yb1-f194.google.com with SMTP id q143so1290753ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bvG8yeMiWehpYWmsEhmZrRBzQ/KLeRP0kdYcoAuh+Ag=;
        b=gdzWXXbKeE5D6zaJ9uerEsRUOkxrxdmScqSaicrvmuj5TfYMrri0nid6IyseVMjHHy
         6sGskBkw0HIhghgDaWsygrIs3IQ++dvAQhdNg1mEELSls3VthJB+sNYfEkJgthlAe/vQ
         LXPwmhs8D1y/ThK+PFuHJ9M5VzI7VGU2s0ZDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bvG8yeMiWehpYWmsEhmZrRBzQ/KLeRP0kdYcoAuh+Ag=;
        b=KoTCU/AqdexkaDwOM4lmKVS3NVo/tbhdOrR1GjEPbcWslxooqFzaRX8gETLRSnEXmt
         yvdHmGO3cQrCsiyMwKcp8M3mq1OiO23PdanNjyAhaCA0g4uaGFln+Eb5fHRiqpbpO6sM
         j2ASxXhRIuZnt4z2S3fhxAhQQ8S/pqQn6MNCXzSc6SBvgwJx/mU8b1XJxE29gp3XkV6Z
         XZWboZU06I4yg3sY5OR/684skmhWx5nxjSvtUT2jyH2uYaySox4oa7Rmng4i3BTqFz/A
         lL4dD4+tN3cRtNTEAXwDtph3bhmntCAKzYAT1BA2Yhcq0Mhc/AC5svdnMIdehszWfOFm
         rFoA==
X-Gm-Message-State: APjAAAVXBMUyv6+7uY7WdlApd3H7qi191u/XyTPWuNdfUTgssQvdJbEy
        fCssnRpK1K7QCJXS6uPQiVoNCQ==
X-Google-Smtp-Source: APXvYqy2azq7Sa1Yjndq9VXjGDHF4OtrvPHzA2ymnfByDXYZao0SyrxB90oyimfX8fnEhCB1bwmZuA==
X-Received: by 2002:a25:c5c4:: with SMTP id v187mr656072ybe.32.1572460469281;
        Wed, 30 Oct 2019 11:34:29 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id s84sm818549yws.22.2019.10.30.11.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:28 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: [RFC PATCH v4 17/19] sched/fair: wrapper for cfs_rq->min_vruntime
Date:   Wed, 30 Oct 2019 18:33:30 +0000
Message-Id: <7b14ed09002916e6ccba1989b9beb2433be31dc2.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lu@linux.alibaba.com>

Add a wrapper function cfs_rq_min_vruntime(cfs_rq) to
return cfs_rq->min_vruntime.

It will be used in the following patch, no functionality
change.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/fair.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 840d27628d36..ab32b22b0574 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -450,6 +450,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime;
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -486,7 +491,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	if (curr) {
 		if (curr->on_rq)
@@ -506,7 +511,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -3816,7 +3821,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->vruntime - cfs_rq_min_vruntime(cfs_rq);
 
 	if (d < 0)
 		d = -d;
@@ -3829,7 +3834,7 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -3922,7 +3927,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	update_curr(cfs_rq);
 
@@ -3933,7 +3938,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -4046,7 +4051,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * can move min_vruntime forward still more.
 	 */
 	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -6542,7 +6547,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 			min_vruntime = cfs_rq->min_vruntime;
 		} while (min_vruntime != min_vruntime_copy);
 #else
-		min_vruntime = cfs_rq->min_vruntime;
+		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 #endif
 
 		se->vruntime -= min_vruntime;
@@ -10007,7 +10012,7 @@ static void task_fork_fair(struct task_struct *p)
 		resched_curr(rq);
 	}
 
-	se->vruntime -= cfs_rq->min_vruntime;
+	se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -10127,7 +10132,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 		 * cause 'unlimited' sleep bonus.
 		 */
 		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	}
 
 	detach_entity_cfs_rq(se);
@@ -10141,7 +10146,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 
 	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.17.1

