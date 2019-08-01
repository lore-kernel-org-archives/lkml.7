Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF12C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1D8214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3Y/TsIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfHALS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:18:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfHALSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RShUMMtmLWW/JRpvXQyg8jZ/IGVNtUn4GyYteFYWmvo=; b=o3Y/TsISOb8ysis9GPxh/tcqM+
        FHI/rH0evddZFY4BJtQhbwyqh3oo6LCDY7RjaJkVDAAdGpjCNufqG28L7iucmETyB2azGTfboLVD+
        VJ8APT9PnGBy+aiIjG0rJWjzhKF9RTA2FY8mU7MNU/jQeZuhkeA7BsRW3+dWrI0kSfopzAtRJvn+R
        tn7fYrcdcmov7RZeglA4dXEABU/XK3O8yd5EeFbcmX2OOic//NKH124kAqPRr8U34+INzYSguq5ZD
        zQBe1SXB3LSLQw8qs0v6ZhxaoVwWvv1YLwbyhGKuM6FXmVXvUSATtAWDHgo0tyhQWv72iHCpqozev
        bxjaVVeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht968-0005fd-GX; Thu, 01 Aug 2019 11:18:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 804FF20297646; Thu,  1 Aug 2019 13:18:12 +0200 (CEST)
Message-Id: <20190801111541.742613597@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 13:13:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juri Lelli <juri.lelli@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 2/5] rcu/tree: Fix SCHED_FIFO params
References: <20190801111348.530242235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A rather embarrasing mistake had us call sched_setscheduler() before
initializing the parameters passed to it.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Fixes: 1a763fd7c633 ("rcu/tree: Call setschedule() gp ktread to SCHED_FIFO outside of atomic region")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/rcu/tree.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3234,13 +3234,13 @@ static int __init rcu_spawn_gp_kthread(v
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
-	if (kthread_prio)
+	if (kthread_prio) {
+		sp.sched_priority = kthread_prio;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rcu_state.gp_kthread = t;
-	if (kthread_prio)
-		sp.sched_priority = kthread_prio;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();


