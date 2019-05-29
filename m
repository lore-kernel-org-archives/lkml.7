Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DB324190
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="chgPMYtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfE2Uhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40316 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE2UhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:04 -0400
Received: by mail-it1-f194.google.com with SMTP id h11so5778885itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aFSNNDWzkb638IHM0IhrXX0+lOw0DYSxTRi3zczU78A=;
        b=chgPMYtQvm1wyoIdkeOAqXprVVVgRSpiIWpwXNTrAN4l9PFVSXZmZBiR4oAp29OzKJ
         9AX1hCr5GGdK8O37690ICzKNcXoVBar4CNG24w/vN8SocWg+LPMwvIDdAXYciD5jL4T5
         pUhlVdwjIAekGcexsq/UbOQxDDjeqzJvyXIOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aFSNNDWzkb638IHM0IhrXX0+lOw0DYSxTRi3zczU78A=;
        b=q/BzH9tMqSE+pP4gYwJEdoq0oSNRl52wi1dHz4wEEW5RHjsDUDzhFcwbBUTueE1uuI
         0ZwDlPJvV1PUg3mnsWAqTTgHkdyi01Z/7WkwtcuV6K1AitLH8d3D/cI55qYthXEZS2m/
         sye+PI8zFj4sO0WcNjRNM5d428Rl007MTEzxFLmmS51ld22ec89phZovEYCnwhYIx3lA
         Yo1rC9/z5oY2CfY+wzfux2bG9gWFpGxrvnxVkgTOasaCCP21BCjZhy/l6vLVJCMlRgd2
         U4HyqHFY8xwTOFMOHbO6khnThqS3RM37LDt59qhJrt/HXgOkDwVDJeYpXCkJUOAG1n0i
         MndQ==
X-Gm-Message-State: APjAAAUK6s9rj5h3KaoFkFRs9chFhyPX+tgjM2c/cqunIqKWgCqgruvr
        SFPbu+FllVZD4IVEaDjoe3Q5gA==
X-Google-Smtp-Source: APXvYqzPJYYD32AYLcD9DHGf45/qh2gOUeijQukVozrX+Ok7jnV3Gb101HP31FI4zD7N2TnqPx6Klg==
X-Received: by 2002:a24:7445:: with SMTP id o66mr159253itc.86.1559162223203;
        Wed, 29 May 2019 13:37:03 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id e5sm182108ioq.22.2019.05.29.13.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:02 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 06/16] sched/fair: Export newidle_balance()
Date:   Wed, 29 May 2019 20:36:42 +0000
Message-Id: <9e3eb1859b946f03d7e500453a885725b68957ba.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

For pick_next_task_fair() it is the newidle balance that requires
dropping the rq->lock; provided we do put_prev_task() early, we can
also detect the condition for doing newidle early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  | 18 ++++++++----------
 kernel/sched/sched.h |  4 ++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 56fc2a1aa261..49707b4797de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3615,8 +3615,6 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -7087,11 +7085,10 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	update_misfit_status(NULL, rq);
-	new_tasks = idle_balance(rq, rf);
+	new_tasks = newidle_balance(rq, rf);
 
 	/*
-	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -9286,10 +9283,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	ld_moved = 0;
 
 	/*
-	 * idle_balance() disregards balance intervals, so we could repeatedly
-	 * reach this code, which would lead to balance_interval skyrocketting
-	 * in a short amount of time. Skip the balance_interval increase logic
-	 * to avoid that.
+	 * newidle_balance() disregards balance intervals, so we could
+	 * repeatedly reach this code, which would lead to balance_interval
+	 * skyrocketting in a short amount of time. Skip the balance_interval
+	 * increase logic to avoid that.
 	 */
 	if (env.idle == CPU_NEWLY_IDLE)
 		goto out;
@@ -9996,7 +9993,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -10004,6 +10001,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
+	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fb01c77c16ff..bfcbcbb25646 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1414,10 +1414,14 @@ static inline void unregister_sched_domain_sysctl(void)
 }
 #endif
 
+extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 #else
 
 static inline void sched_ttwu_pending(void) { }
 
+static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
+
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
-- 
2.17.1

