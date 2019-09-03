Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D440C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6400A23402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R15SjI+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfICOQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:16:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfICOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bZzsxHgBhfruo8NfOXSLVXf4HiHbSYZxKvfXaibsApY=; b=R15SjI+PFpJK2EUbvANcNuRtZ
        rnBJMG8lvaI9Thjaf95zfAgTxVjx7qLSW8XGrs9b2NP4lkiYsl6oG6FF3c56docyVkvyBCG7aFRxl
        KX+EDWVpEW1n8l+TvqMNnzNDSVYP03HWmyM9BujnX8WmehbpBiMC/krzMk3H4+gAXpGjzm0UxPAeC
        QNLZncyyj26Ap8jkVJTqvHlznaWoVbXNmrALiS1nw4CVVXp/EzTThK0mZIkV2ISnT+gDznJ+hgE/d
        j74LSA0URczYHGeW8mf+kLoxAzDLMX2SKmmPSH6jlwbEXOUc7+MA7ZP3djZdWoHERdYZmnZPu7Vjj
        aRi63ktJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i59bA-0008Kk-BL; Tue, 03 Sep 2019 14:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A47730116F;
        Tue,  3 Sep 2019 16:15:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D7342097776B; Tue,  3 Sep 2019 16:15:54 +0200 (CEST)
Date:   Tue, 3 Sep 2019 16:15:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        pauld@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable
 warnings
Message-ID: <20190903141554.GS2349@hirez.programming.kicks-ass.net>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
 <1567515806.5576.41.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567515806.5576.41.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:03:26AM -0400, Qian Cai wrote:
> Ingo or Peter, please take a look at this trivial patch. Still see the warning
> in linux-next every day.
> 
> On Tue, 2019-08-20 at 14:40 -0400, Qian Cai wrote:
> > The linux-next commit "sched/fair: Fix low cpu usage with high
> > throttling by removing expiration of cpu-local slices" [1] introduced a
> > few compilation warnings,
> > 
> > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> > [-Wunused-but-set-variable]
> > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> > [-Wunused-but-set-variable]
> > 
> > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> > expiration time, so fix the comments accordingly.
> > 
> > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux
> > @indeed.com/
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>

Rewrote the Changelog like so:

---
Subject: sched/fair: Fix -Wunused-but-set-variable warnings
From: Qian Cai <cai@lca.pw>
Date: Tue, 20 Aug 2019 14:40:55 -0400

Commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
throttling by removing expiration of cpu-local slices") introduced a
few compilation warnings:

  kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
  kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used [-Wunused-but-set-variable]
  kernel/sched/fair.c: In function 'start_cfs_bandwidth':
  kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used [-Wunused-but-set-variable]

Also, __refill_cfs_bandwidth_runtime() does no longer update the
expiration time, so fix the comments accordingly.

Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
Cc: mingo@redhat.com
Cc: pauld@redhat.com
Link: https://lkml.kernel.org/r/1566326455-8038-1-git-send-email-cai@lca.pw
---
 kernel/sched/fair.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4386,21 +4386,16 @@ static inline u64 sched_cfs_bandwidth_sl
 }
 
 /*
- * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
- * additional synchronization around rq->lock.
+ * Replenish runtime according to assigned quota. We use sched_clock_cpu
+ * directly instead of rq->clock to avoid adding additional synchronization
+ * around rq->lock.
  *
  * requires cfs_b->lock
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	u64 now;
-
-	if (cfs_b->quota == RUNTIME_INF)
-		return;
-
-	now = sched_clock_cpu(smp_processor_id());
-	cfs_b->runtime = cfs_b->quota;
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_b->runtime = cfs_b->quota;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -5021,15 +5016,13 @@ static void init_cfs_rq_runtime(struct c
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
-	u64 overrun;
-
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
