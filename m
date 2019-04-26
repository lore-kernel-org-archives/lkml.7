Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BFC206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gu5Fj/YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfDZPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:03:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDZPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cgk38PTBlAhJuwkI7SNgwTmzleTjVi/UQnh/qUC4EKQ=; b=Gu5Fj/YV760jg1L4JnIZQ+Sa/
        Ap8YV6v/1r7jgaXulDAn6Hul4Q2D3an8f726VNxq69aQFmD6F/IhmRiHAN5UFwN7bViSCVpkTqWdF
        QniI3HFl04eOGZlnTNyjp0/cag9XFl5MCcRr3XzPS5MjnOaXEDCXz/vbsLWwaJG/w99/cnnmMMrOP
        9o4EmPf9g36HY/b9ZHsFimqt7qSvPLoiQ5r55Zl2wjBLgYrAh0W/Ni/pk28MUUOARdWMRxdiiuVwa
        n1dCYlfX5EsUYVetUK/wH6MLqB2oTaw2z7zaGQt9w0xJ22qYgNUHIsnajYXg+cPJkfT5OGCf10z6n
        gVcOVhtJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK2O3-00072x-9o; Fri, 26 Apr 2019 15:03:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA3B8286B7D82; Fri, 26 Apr 2019 17:03:37 +0200 (CEST)
Date:   Fri, 26 Apr 2019 17:03:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 16/17] sched: Wake up sibling if it has something
 to run
Message-ID: <20190426150337.GC2623@hirez.programming.kicks-ass.net>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <a0132b8ffb5b37a5f8e242a5ac9e3a0a5ecc5f8e.1556025155.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0132b8ffb5b37a5f8e242a5ac9e3a0a5ecc5f8e.1556025155.git.vpillai@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:18:21PM +0000, Vineeth Remanan Pillai wrote:

(you lost From: Julien)

> During core scheduling, it can happen that the current rq selects a
> non-tagged process while the sibling might be idling even though it
> had something to run (because the sibling selected idle to match the
> tagged process in previous tag matching iteration). We need to wake up
> the sibling if such a situation arise.
> 
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> ---
>  kernel/sched/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e8f5ec641d0a..0e3c51a1b54a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3775,6 +3775,21 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  			 */
>  			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
>  				next = p;
> +				rq->core_pick = NULL;
> + 
> +				/*
> +				 * If the sibling is idling, we might want to wake it
> +				 * so that it can check for any runnable tasks that did
> +				 * not get a chance to run due to previous task matching.
> +				 */
> +				for_each_cpu(j, smt_mask) {
> +					struct rq *rq_j = cpu_rq(j);
> +					rq_j->core_pick = NULL;
> +					if (j != cpu &&
> +					    is_idle_task(rq_j->curr) && rq_j->nr_running) {
> +						resched_curr(rq_j);
> +					}
> +				}
>  				goto done;
>  			}

Anyway, as written here:

  https://lkml.kernel.org/r/20190410150116.GI2490@worktop.programming.kicks-ass.net

I think this isn't quite right. Does the below patch (which actually
removes lines) also work?

As written before; the intent was to not allow that optimization if the
last pick had a cookie; thereby doing a (last) core wide selection when
we go to a 0-cookie, and this then includes kicking forced-idle cores.

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3574,18 +3574,7 @@ static struct task_struct *
 pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
 {
 	struct task_struct *class_pick, *cookie_pick;
-	unsigned long cookie = 0UL;
-
-	/*
-	 * We must not rely on rq->core->core_cookie here, because we fail to reset
-	 * rq->core->core_cookie on new picks, such that we can detect if we need
-	 * to do single vs multi rq task selection.
-	 */
-
-	if (max && max->core_cookie) {
-		WARN_ON_ONCE(rq->core->core_cookie != max->core_cookie);
-		cookie = max->core_cookie;
-	}
+	unsigned long cookie = rq->core->core_cookie;
 
 	class_pick = class->pick_task(rq);
 	if (!cookie)
@@ -3612,6 +3601,7 @@ pick_next_task(struct rq *rq, struct tas
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
+	unsigned long prev_cookie;
 	int i, j, cpu;
 
 	if (!sched_core_enabled(rq))
@@ -3653,7 +3643,10 @@ pick_next_task(struct rq *rq, struct tas
 	 */
 	rq->core->core_task_seq++;
 
+	prev_cookie = rq->core->core_cookie;
+
 	/* reset state */
+	rq->core->core_cookie = 0UL;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -3688,7 +3681,7 @@ pick_next_task(struct rq *rq, struct tas
 				 * If there weren't no cookies; we don't need
 				 * to bother with the other siblings.
 				 */
-				if (i == cpu && !rq->core->core_cookie)
+				if (i == cpu && !prev_cookie)
 					goto next_class;
 
 				continue;
@@ -3698,7 +3691,7 @@ pick_next_task(struct rq *rq, struct tas
 			 * Optimize the 'normal' case where there aren't any
 			 * cookies and we don't need to sync up.
 			 */
-			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
+			if (i == cpu && !prev_cookie && !p->core_cookie) {
 				next = p;
 				goto done;
 			}
