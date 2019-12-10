Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F449C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F120828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949370;
	bh=N05EpPtOSrQbn7yOfFXBkRpyGIkc4d3k4nuvgRfYoEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qRaycaeMIAiRDVNzpATNNu7IDB2Lk1QvUq90Qf4vbTyivDDgD0iB/JPwveTS+h2lG
	 4OtE2tHYmwR5c8B9nVY5gmAUxHWsLEPMBhgJr3PaJ4o8saPU9KCCZgtOJJM9m4sP6L
	 32HDmJlWfr8/Yl01JUcpO9JS2Ontn7h4s80MaCdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLJDmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfLJDm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:27 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D86324653;
        Tue, 10 Dec 2019 03:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949347;
        bh=N05EpPtOSrQbn7yOfFXBkRpyGIkc4d3k4nuvgRfYoEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYX5ME9vOZrQ+/TABwsJndz0ec0HVgdi5OlgvvD4dn5+r/fMYNfUj5jk7P+P9O+/W
         la4QMGcUaKxepqB/udVmOAI9EyxH5ILUYEBl9QgT8EXy6sUgM5HMmIli8V7GoE135+
         QpF1M1TtPcv1YCxjh80Zj5ZSMZs2EyiMvXjoWZ0g=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/12] rcutorture: Dynamically allocate rcu_fwds structure
Date:   Mon,  9 Dec 2019 19:42:15 -0800
Message-Id: <20191210034217.405-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit switches from static structure to dynamic allocation
for rcu_fwds as another step towards providing multiple call_rcu()
forward-progress kthreads.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 394baac..f77f4d8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1686,7 +1686,7 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd rcu_fwds;
+struct rcu_fwd *rcu_fwds;
 bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
@@ -1952,7 +1952,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
-	struct rcu_fwd *rfp = &rcu_fwds;
+	struct rcu_fwd *rfp = rcu_fwds;
 
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
@@ -2010,7 +2010,7 @@ static int rcu_torture_fwd_prog(void *args)
 /* If forward-progress checking is requested and feasible, spawn the thread. */
 static int __init rcu_torture_fwd_prog_init(void)
 {
-	struct rcu_fwd *rfp = &rcu_fwds;
+	struct rcu_fwd *rfp;
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
@@ -2026,12 +2026,15 @@ static int __init rcu_torture_fwd_prog_init(void)
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
 	}
-	spin_lock_init(&rfp->rcu_fwd_lock);
-	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
+	rfp = kzalloc(sizeof(*rfp), GFP_KERNEL);
+	if (!rfp)
+		return -ENOMEM;
+	spin_lock_init(&rfp->rcu_fwd_lock);
+	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
-- 
2.9.5

