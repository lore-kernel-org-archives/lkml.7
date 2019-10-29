Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37567CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0929920862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbAnLHGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfJ2Lec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:34:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39556 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfJ2Lec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxyEWJUAiuaMs0zYWJgOqWTTW1v3Wc4HjFhl8Cnx0CE=; b=fbAnLHGOoZHtWB7tWHcDckwaa
        IueguYuGIlenXLH2vB2mD7uFw5PGzYLAxerCx8FseJLcYpCwCG3cjVUBG6bIiIuO/zszlpPNoL1Gv
        AntWPQMlJE2ULnlSyyZTZDIROiR5Y2Cas+aYCBw56qfRGUs7P3CqAoYNiJ2gLHi0bG7DnD9lwXr9l
        YcdVDihhltIEEiOjQJGshPOvX2vvgA7+OL/T79Curetpemjitqys5G6lc8rCKWXFsrn4OX6oim/hl
        hQQzT4NBumjOMETHG1WNt9JtK+sYkGOBfMuLbefZtfpZBkAwcr2BDZHa0asnUevwtIziRRmU0wHoV
        KDbj9wM1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPPlO-00051A-7n; Tue, 29 Oct 2019 11:34:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66EBF980DCC; Tue, 29 Oct 2019 12:34:11 +0100 (CET)
Date:   Tue, 29 Oct 2019 12:34:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        valentin.schneider@arm.com, mingo@kernel.org, pauld@redhat.com,
        jdesfossez@digitalocean.com, naravamudan@digitalocean.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191029113411.GP4643@worktop.programming.kicks-ass.net>
References: <20191028174603.GA246917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028174603.GA246917@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:46:03PM +0000, Quentin Perret wrote:
> The issue is very transient and relatively hard to reproduce.
> 
> After digging a bit, the offending commit seems to be:
> 
>     67692435c411 ("sched: Rework pick_next_task() slow-path")
> 
> By 'offending' I mean that reverting it makes the issue go away. The
> issue comes from the fact that pick_next_entity() returns a NULL se in
> the 'simple' path of pick_next_task_fair(), which causes obvious
> problems in the subsequent call to set_next_entity().
> 
> I'll dig more, but if anybody understands the issue in the meatime feel
> free to send me a patch to try out :)

Can you please see if this makes any difference?

---
 kernel/sched/core.c | 6 ++++--
 kernel/sched/fair.c | 2 +-
 kernel/sched/idle.c | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..abd2d4f80381 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3922,8 +3922,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			goto restart;

 		/* Assumes fair_sched_class->next == idle_sched_class */
-		if (unlikely(!p))
-			p = idle_sched_class.pick_next_task(rq, prev, rf);
+		if (unlikely(!p)) {
+			prev->sched_class->put_prev_task(rq, prev, rf);
+			p = idle_sched_class.pick_next_task(rq, NULL, NULL);
+		}

 		return p;
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83ab35e2374f..2aad94bb7165 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6820,7 +6820,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 simple:
 #endif
 	if (prev)
-		put_prev_task(rq, prev);
+		prev->sched_class->put_prev_task(rq, prev, rf);

 	do {
 		se = pick_next_entity(cfs_rq, NULL);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..e8dfc84f375a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -390,8 +390,7 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 {
 	struct task_struct *next = rq->idle;

-	if (prev)
-		put_prev_task(rq, prev);
+	WARN_ON_ONCE(prev || rf);

 	set_next_task_idle(rq, next);


