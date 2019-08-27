Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5930721881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vq6f5Mgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfH0TCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:02:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46750 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730972AbfH0TCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:02:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id q139so14675409pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:from:to:cc:subject:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52EK6rfbsq7VobrSZHmcWaacNY1VwE+wKKdzQGaeJmQ=;
        b=vq6f5MglKnqT62mSThQ/w/JQa8CM/RdJHfTZ9Tac3vS3vLL95wISvQbHokDLuFmaFy
         RADwOVqVDER25+bQ0dlC/unG/D3mOXZclpmYseEds4XydjPpQKn5Sa1OvMtOlMvTwNjc
         1NT7fuO/k3GgSobmPG2Mr1V+tjhrzS/nvbJOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52EK6rfbsq7VobrSZHmcWaacNY1VwE+wKKdzQGaeJmQ=;
        b=XNPaGjQvIHNrt8x5GOcS9JtrP9dwYPKEykOmLvDygar0RncPqtr/5c3/6LhsGaEyyu
         V7WQXrHZXCRpW227shknkVtFeiPUESAefaniRf7o7Q+NLF96rwQdEnyWTpK0L88JRpEi
         gDh/tCsOfEUpn25Y7D7tLeBC8ZnlklMprfLx2VjNCQhrL/Obw8aXehLLB9nmrPJ/vCF/
         9hK/e/WHNZ05Snn/8wKqioj+5JeVwKCe/ZwCwjyPjDx4pdlMec2We3ggwEoO2NNOxZnE
         bXtJETQq5p93nF++xVJ0xx0sf955jFCvWytiVxvoptFk+wU5ehV71dWL6dI9IaYMpike
         Oyyg==
X-Gm-Message-State: APjAAAVngjH+zjlklYp7xMoX8VG3CCFxEfYLwRyZISXFyzJ7Le9OIazW
        RVluZcvn8pANoFqyiT+Y+fT7JPr3408=
X-Google-Smtp-Source: APXvYqwFfJK0Bv7+ebFqvAJLuDGybi+9XbXAaWxMh0CqxLK8UMWSMEj+o57dGtYDClJ+Bm2nm7OuxQ==
X-Received: by 2002:a17:90a:5d12:: with SMTP id s18mr201806pji.112.1566932533839;
        Tue, 27 Aug 2019 12:02:13 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k14sm33196pfi.98.2019.08.27.12.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 12:02:13 -0700 (PDT)
Message-ID: <5d657e35.1c69fb81.54250.01de@mx.google.com>
X-Google-Original-Message-ID: 156693247271239@cam.corp.google.com
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        byungchul.park@lge.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: [PATCH 2/5] rcu/tree: Add multiple in-flight batches of kfree_rcu work
Date:   Tue, 27 Aug 2019 15:01:56 -0400
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: 156693247224727@cam.corp.google.com
References: 156693247224727@cam.corp.google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing, it was observed that amount of memory consumed due
kfree_rcu() batching is 300-400MB. Previously we had only a single
head_free pointer pointing to the list of rcu_head(s) that are to be
freed after a grace period. Until this list is drained, we cannot queue
any more objects on it since such objects may not be ready to be
reclaimed when the worker thread eventually gets to drainin g the
head_free list.

We can do better by maintaining multiple lists as done by this patch.
Testing shows that memory consumption came down by around 100-150MB with
just adding another list. Adding more than 1 additional list did not
show any improvement.

Suggested-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 64 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4f7c3096d786..9b9ae4db1c2d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2688,28 +2688,38 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_N_BATCHES 2
+
+struct kfree_rcu_work {
+	/* The rcu_work node for queuing work with queue_rcu_work(). The work
+	 * is done after a grace period.
+	 */
+	struct rcu_work rcu_work;
+
+	/* The list of objects that have now left ->head and are queued for
+	 * freeing after a grace period.
+	 */
+	struct rcu_head *head_free;
+
+	struct kfree_rcu_cpu *krcp;
+};
+static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES], krw);
 
 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
  * kfree(s) is queued for freeing after a grace period, right away.
  */
 struct kfree_rcu_cpu {
-	/* The rcu_work node for queuing work with queue_rcu_work(). The work
-	 * is done after a grace period.
-	 */
-	struct rcu_work rcu_work;
 
 	/* The list of objects being queued in a batch but are not yet
 	 * scheduled to be freed.
 	 */
 	struct rcu_head *head;
 
-	/* The list of objects that have now left ->head and are queued for
-	 * freeing after a grace period.
-	 */
-	struct rcu_head *head_free;
+	/* Pointer to the per-cpu array of kfree_rcu_work structures */
+	struct kfree_rcu_work *krwp;
 
-	/* Protect concurrent access to this structure. */
+	/* Protect concurrent access to this structure and kfree_rcu_work. */
 	spinlock_t lock;
 
 	/* The delayed work that flushes ->head to ->head_free incase ->head
@@ -2730,12 +2740,14 @@ static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
-					struct kfree_rcu_cpu, rcu_work);
+	struct kfree_rcu_work *krwp = container_of(to_rcu_work(work),
+					struct kfree_rcu_work, rcu_work);
+	struct kfree_rcu_cpu *krcp;
+
+	krcp = krwp->krcp;
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	head = krcp->head_free;
-	krcp->head_free = NULL;
+	head = xchg(&krwp->head_free, NULL);
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/*
@@ -2758,19 +2770,28 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	int i = 0;
+	struct kfree_rcu_work *krwp = NULL;
+
 	lockdep_assert_held(&krcp->lock);
+	while (i < KFREE_N_BATCHES) {
+		if (!krcp->krwp[i].head_free) {
+			krwp = &(krcp->krwp[i]);
+			break;
+		}
+		i++;
+	}
 
-	/* If a previous RCU batch work is already in progress, we cannot queue
+	/* If both RCU batches are already in progress, we cannot queue
 	 * another one, just refuse the optimization and it will be retried
 	 * again in KFREE_DRAIN_JIFFIES time.
 	 */
-	if (krcp->head_free)
+	if (!krwp)
 		return false;
 
-	krcp->head_free = krcp->head;
-	krcp->head = NULL;
-	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krcp->rcu_work);
+	krwp->head_free = xchg(&krcp->head, NULL);
+	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krwp->rcu_work);
 
 	return true;
 }
@@ -3736,8 +3757,13 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		struct kfree_rcu_work *krwp = &(per_cpu(krw, cpu)[0]);
+		int i = KFREE_N_BATCHES;
 
 		spin_lock_init(&krcp->lock);
+		krcp->krwp = krwp;
+		while (i--)
+			krwp[i].krcp = krcp;
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 	}
 }
-- 
2.23.0.187.g17f5b7556c-goog

