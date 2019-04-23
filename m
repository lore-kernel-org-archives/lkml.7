Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67547C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361762175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="E+s8qWXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDWQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37092 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfDWQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:46 -0400
Received: by mail-io1-f66.google.com with SMTP id a23so9306027iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eBN5a01bLZKes4efXYfS0pvRc4X6R+2ccUMWguZAo9M=;
        b=E+s8qWXEWUdOECw48IEtK78sDN3pM3rOdHWwxKXRxQloQqNZiW4EvTJS5UZgnaxtY3
         BhnwYBFokav5FRrs+p4hJxjbWfk4ATxobDeEfx8CC/yFaT7/pyAlusFb6m25VtFXfwDx
         xab1uNkjwuoRpXSLpNnBffDU9Gjac2hlDCkjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eBN5a01bLZKes4efXYfS0pvRc4X6R+2ccUMWguZAo9M=;
        b=Ud2SnXCPjELHFxp+bNjKkkUJIdSctbMimKkG/ygKaETOCcnTNQ1M3IejMVIe/g+MPX
         tr+mbG2fXZ1zn1PF+77FSFW2CxSkc8bkGAEa/qj1D9xV48OSyhRMDXRNpZ5Krt6TtI7X
         vn/6QDqUfgyftxYBWyTpYLPiyTP/hU3dVMlGl7elkfJEWhFArmJT+UTn5mPbjpHdPUAh
         uTt0K9oy+SzgOtEiYPyjOu0TeIKq/KqoeYmSm24JOImEWQjbOJgVsZpNjjJL5OUCCA+o
         7seZ6lXVneL4mTPiYWmI44DAqHwj4Vf2CyeiiXlpdioKmevb/iqVZXPSwA+ghP1CkFhY
         Mujg==
X-Gm-Message-State: APjAAAVatoU+G5gi/ug+BgJO4EHJpzImEkMopwrNrdnTXWwU1QgROBUN
        5NGu5qpBULxW4aOyz1eqZ8mwJA==
X-Google-Smtp-Source: APXvYqwAOKn0mPp115+lZPJToRn5aulI2ZfFbIUHw3Cu1Io6j8a+qO2VsFSGC5fkc42q+BQF9CFyVQ==
X-Received: by 2002:a6b:f909:: with SMTP id j9mr15932806iog.272.1556036324741;
        Tue, 23 Apr 2019 09:18:44 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id s1sm5361179ioe.18.2019.04.23.09.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/17] sched/fair: Export newidle_balance()
Date:   Tue, 23 Apr 2019 16:18:11 +0000
Message-Id: <78a45b2c9077bc8f159e8c53f6d56d7445474d0e.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

For pick_next_task_fair() it is the newidle balance that requires
dropping the rq->lock; provided we do put_prev_task() early, we can
also detect the condition for doing newidle early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  | 18 ++++++++----------
 kernel/sched/sched.h |  4 ++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebad19a033eb..f7e631e692a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3611,8 +3611,6 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -7058,11 +7056,10 @@ done: __maybe_unused;
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
@@ -9257,10 +9254,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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
@@ -9967,7 +9964,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -9975,6 +9972,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
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

