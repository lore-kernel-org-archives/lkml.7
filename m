Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9039CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E21A20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="iWIrU6DE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfJ3SeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:13 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43418 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfJ3SeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:11 -0400
Received: by mail-yw1-f68.google.com with SMTP id g77so1179596ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=B2PW3rSV0Na4RNZZn44Mv1tEbVceFBA5wDKCvH+UBAg=;
        b=iWIrU6DEQUONIhviblC7RiPbGN6ZURTVov5lQ5Dv9YrHnX0iEgbAVECfBZKYeYf+So
         NPlaXcknnEgYUzxKAQy2mWD5WHBI5VMurSrJD1TB2zEosdeYbzbakKYQ7wdM+zNA9uG3
         RNeYYkrKGdNdgMLatex3RXF1361keufF7xxJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=B2PW3rSV0Na4RNZZn44Mv1tEbVceFBA5wDKCvH+UBAg=;
        b=jGzURW21vLJ8oslBh55q3/7ZDwFrpWr6KjgT2Fcmsov3GCVFVOV7VTjO8ZbWWWUZNh
         qfwL1rlIkpL+1jvHQuZuRseGzk9JE8IzkIwpVqjhFbEmRYpX/qjlKMnBrmF+hMPSuiDr
         ybFM3HIk/Lyhoba56okctl/XV9dfaPVVnTUM55t4ARFSEm6CMB7Qdi3aFwcxl5XwPaln
         Ela2eTrtGh5Qrnyzy2b6xFmttmrCtZRo8fqgGFXBUL9FjQnEmFTLRMAYaV3juY3CkZTG
         JJaejZyAJAmxv5T2Xz5ajwfu/cvNMvC8K61DHaisNfbQhLo+HXQcs37/Gw/jzZ/U50wU
         3ARw==
X-Gm-Message-State: APjAAAX90N1jSUuyoX6wAieBo5RpYK4iF3fhUtoK2tpeV3ZIGLuB7GBd
        CF+ffM01x9Q9IGi3VWWQHmpjMQ==
X-Google-Smtp-Source: APXvYqy9F85QCkC974IL+Ovkpl+9V6pH7XUJLtPgdUf6+dpWZ4n6T4GYu5aXvuYBh2NulTQ0/tZKNA==
X-Received: by 2002:a81:848b:: with SMTP id u133mr854466ywf.249.1572460450246;
        Wed, 30 Oct 2019 11:34:10 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id f127sm767334ywe.89.2019.10.30.11.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:09 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 06/19] sched/fair: Export newidle_balance()
Date:   Wed, 30 Oct 2019 18:33:19 +0000
Message-Id: <2223db874b45408cd159c897cb2dc6acd680e97c.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
index a58e5de1732d..c6b6835a5945 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3689,8 +3689,6 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -6907,11 +6905,10 @@ done: __maybe_unused;
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
@@ -9075,10 +9072,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
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
@@ -9788,7 +9785,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -9796,6 +9793,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
+	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 657831e26008..dc889af24efb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1453,10 +1453,14 @@ static inline void unregister_sched_domain_sysctl(void)
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

