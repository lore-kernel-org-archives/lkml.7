Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD140C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71720643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RlpoV+7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCSMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:06:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Y8exXuCraOdypuZXLjyl3qoIRQhdAJlkVS81DoIM2Q=; b=RlpoV+7oNKEi1PWGhGmZKclNp
        yFNf1jNNFOQmToLctUfXK4v+t93zANB2c5V2C3O8K+sgVuIDhVEyf3vjJcqheXo+ppgmDLwWTBaID
        12cr4+T0mite8IMdtvMQ/pqfxICrAXpqG+jTYinNU9gcUwptFcAh3j+bI144HB8xqdvx9jjU4maay
        k7fUNJWH/iyWAxuBVhpSDWw6Lw97UjSiY9EAeUC4vuPKwIWvbTK1xbMfv9rp2AKOAwkA0FlPearIb
        v8mWRrAN65q1p7UcYG29jpV6SNhQXkeq5GRqGVib9sLHhpV9HhQEJZBDg/TWzgCDutKkj0ExDYFth
        q2fb9GXyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6DVT-0004iK-QX; Tue, 19 Mar 2019 12:06:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E436E203C06F3; Tue, 19 Mar 2019 13:06:09 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:06:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Do not re-read h_load_next during hierarchical
 load calculation
Message-ID: <20190319120609.GD5996@hirez.programming.kicks-ass.net>
References: <20190319091709.lqrtbn76sjx73hnv@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319091709.lqrtbn76sjx73hnv@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:35:18AM +0000, Mel Gorman wrote:
> A NULL pointer dereference bug was reported on a distribution kernel but
> the same issue should be present on mainline kernel. It occured on s390
> but should not be arch-specific.  A partial oops looks like
> 
> [775277.408564] Unable to handle kernel pointer dereference in virtual kernel address space
> ...
> [775277.408759] Call Trace:
> [775277.408763] ([<0002c11c56899c61>] 0x2c11c56899c61)
> [775277.408766]  [<0000000000177bb4>] try_to_wake_up+0xfc/0x450
> [775277.408773]  [<000003ff81ede872>] vhost_poll_wakeup+0x3a/0x50 [vhost]
> [775277.408777]  [<0000000000194ae4>] __wake_up_common+0xbc/0x178
> [775277.408779]  [<0000000000194f86>] __wake_up_common_lock+0x9e/0x160
> [775277.408780]  [<00000000001950de>] __wake_up_sync_key+0x4e/0x60
> [775277.408785]  [<00000000005d911e>] sock_def_readable+0x5e/0x98
> 
> The bug hits any time between 1 hour to 3 days. The dereference occurs
> in update_cfs_rq_h_load when accumulating h_load. The problem is that
> cfq_rq->h_load_next is not protected by any locking and can be updated
> by parallel calls to task_h_load.

Hurpmh, right.

> Depending on the compiler, code may be
> generated that re-reads cfq_rq->h_load_next after the check for NULL and
> then oops when reading se->avg.load_avg. The dissassembly showed that it
> was possible to reread h_load_next after the check for NULL.
> 
> While this does not appear to be an issue for later compilers, it's still
> an accident if the correct code is generated. Full locking in this path
> would have high overhead so this patch uses READ_ONCE to read h_load_next
> only once and check for NULL before dereferencing. It was confirmed that
> there were no further oops after 10 days of testing.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 310d0637fe4b..34aeb40e69d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7726,7 +7726,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
>  		cfs_rq->last_h_load_update = now;
>  	}
>  
> -	while ((se = cfs_rq->h_load_next) != NULL) {
> +	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
>  		load = cfs_rq->h_load;
>  		load = div64_ul(load * se->avg.load_avg,
>  			cfs_rq_load_avg(cfs_rq) + 1);

Where there is a READ_ONCE there should also be a corresponding
WRITE_ONCE(). Otherwise the compiler can still screw us over by doing
store-tearing.

So something like the below. But looking at this, we probably also want
ONCE treatment on cfs_rq->h_load itself, but that's another patch.

And I think we can do something with cfs_rq->last_h_load_update.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdab7eb6f351..40bd1e27b1b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7784,10 +7784,10 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	if (cfs_rq->last_h_load_update == now)
 		return;
 
-	cfs_rq->h_load_next = NULL;
+	WRITE_ONCE(cfs_rq->h_load_next, NULL);
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		cfs_rq->h_load_next = se;
+		WRITE_ONCE(cfs_rq->h_load_next, se);
 		if (cfs_rq->last_h_load_update == now)
 			break;
 	}
@@ -7797,7 +7797,7 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 		cfs_rq->last_h_load_update = now;
 	}
 
-	while ((se = cfs_rq->h_load_next) != NULL) {
+	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
 			cfs_rq_load_avg(cfs_rq) + 1);
