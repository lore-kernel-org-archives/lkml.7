Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E556CC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B560B218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OGIRQ+/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfHHH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:57:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N3npgdq5SN1ktCIc9MeTH4f2H1ZhWQU8PFljfN+O3jg=; b=OGIRQ+/uj2wXA2E7NLAKpgpnt
        bg3dW58UxYzYyl2ITn2Qj3W4nkir7/aegwaW7/5w5JsjdIiH7ZlLYyww2/aF5e7Wvar+qydRayC7+
        rl9RZssqcKtxHIDeBAEdG7Nka+BVAdgJzNHp4q+b+j487VEfiyFEA9hxIps4LR1n/ChXlCVsQ74B0
        FSG7KlGYgYENY49CcVblzsmx8Z+7UmWUZWP4g8SYQWfEe6WA1Un9rGyA6j2dIDNITGAKVJu28G2DM
        i+1dwnVA8Bix43UC87rhkWiUe7AxV4tM/fW9vniDRyDoI1+opVLA+5F0zokLNA8zBJ+8bnvMczw9Z
        D48QGZ2lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvdHq-0007iX-W8; Thu, 08 Aug 2019 07:56:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C50E49803CE; Thu,  8 Aug 2019 09:56:35 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:56:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808075635.GB17205@worktop.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 06:31:59PM +0200, Dietmar Eggemann wrote:
> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> > 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> [...]
> 
> > @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
> >  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> >  		cgroup_account_cputime(curtask, delta_exec);
> >  		account_group_exec_runtime(curtask, delta_exec);
> > +		if (curtask->server)
> > +			dl_server_update(curtask->server, delta_exec);
> >  	}
> 
> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
> when running the full stack.

That would seem to imply a stale curtask->server value; the hunk below:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas

        for_each_class(class) {
                p = class->pick_next_task(rq, NULL, NULL);
-               if (p)
+               if (p) {
+                       if (p->sched_class == class && p->server)
+                               p->server = NULL;
                        return p;
+               }
        }


Was supposed to clear p->server, but clearly something is going 'funny'.


