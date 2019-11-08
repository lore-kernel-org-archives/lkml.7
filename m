Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A1520865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifVALW6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfKHNVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:21:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfKHNVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/Vg+fuvXxL5vOt/UuiYkqPDOJfaG5+rXkuRhUYdrco=; b=ifVALW6Lu494H41EmeN/4UwljE
        WnVmfhefUeG7XOBBpkNF5/nJtZX2DnY7Et92aWUhTqFckal/A/+ydNB1c15R/1qHRqoNesQFzi9JK
        wYO29YB8hCNXdKNawc/AWAN2yHqxF4/uEmrnVRxrmIpQjiaahkkaJZ8+duuAqF4kEF9aYsC/05rZ9
        Lo0ntg6jJGrWTAQZfo6qhAVn2u8gteuNSJ1xwd+8FSiA23mDfU8Rksk0zeeBsePCaH+f5/KX7bC05
        Ujgz4EHzZLFSAmj3bJ9SpAyYwYriYxt7P3jYbfqhQhibi9wU8fFgOfwTvaOm+MatscpBs7U2nBfXT
        BwH9i98g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT4CZ-0003ZQ-Bf; Fri, 08 Nov 2019 13:21:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5733E301A79;
        Fri,  8 Nov 2019 14:20:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 481FB20C10EBA; Fri,  8 Nov 2019 14:21:20 +0100 (CET)
Message-Id: <20191108131909.545730862@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 14:15:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        ktkhai@virtuozzo.com, peterz@infradead.org
Subject: [PATCH 3/7] sched: Make pick_next_task_idle() more consistent
References: <20191108131553.027892369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only pick_next_task_fair() needs the @prev and @rf argument; these are
required to implement the cpu-cgroup optimization. None of the other
pick_next_task() methods need this. Make pick_next_task_idle() more
consistent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    6 ++++--
 kernel/sched/idle.c |    3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3922,8 +3922,10 @@ pick_next_task(struct rq *rq, struct tas
 			goto restart;
 
 		/* Assumes fair_sched_class->next == idle_sched_class */
-		if (unlikely(!p))
-			p = idle_sched_class.pick_next_task(rq, prev, rf);
+		if (unlikely(!p)) {
+			put_prev_task(rq, prev);
+			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
+		}
 
 		return p;
 	}
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -390,8 +390,7 @@ pick_next_task_idle(struct rq *rq, struc
 {
 	struct task_struct *next = rq->idle;
 
-	if (prev)
-		put_prev_task(rq, prev);
+	WARN_ON_ONCE(prev || rf);
 
 	set_next_task_idle(rq, next);
 


