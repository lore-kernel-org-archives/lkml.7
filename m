Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DA32087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xG7r1Kkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfG3In1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:43:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfG3In1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5dtvEs2ayMMPDWlDVD/VDsH5GdZ7NguoxBUGDu1v+1A=; b=xG7r1KkmYiasqjaGmGOz72Bvj
        0y27GNWNOy+MpQ4KS37k8JDOY7tYtI8IAqNjYPncukYi7M95ydimStrBb3IpiD/YIKOTorj5dlkW/
        diNd1zqx3gUgaRb8lc8nPTkVsTdY1frc9BUQxXbhADAYnqs+7K/9Caz0prQ0CRz8JZJJ5mQEMVfKU
        bs8EgdLviD8nLA9drj4K+9xd70p5QlYcvdecXAxq07ZZNDeVr1uxRx1RXpFCyLLLpXfug6MwlrklD
        CqSHOGDXKs21BZagSWGc1Ripc5vOQCTL/vcdsMEHwuIuAzFlAZlsmjFVItaBpT0hgmeYaUHpikALG
        94PhG1ZPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNj9-0005YZ-KW; Tue, 30 Jul 2019 08:43:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB84320AFFE9F; Tue, 30 Jul 2019 10:43:21 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:43:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190730084321.GL31381@hirez.programming.kicks-ass.net>
References: <20190729210728.21634-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729210728.21634-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:07:28PM -0400, Waiman Long wrote:
> It was found that a dying mm_struct where the owning task has exited
> can stay on as active_mm of kernel threads as long as no other user
> tasks run on those CPUs that use it as active_mm. This prolongs the
> life time of dying mm holding up some resources that cannot be freed
> on a mostly idle system.
> 
> Fix that by forcing the kernel threads to use init_mm as the active_mm
> during a kernel thread to kernel thread transition if the previous
> active_mm is dying (!mm_users). This will allows the freeing of resources
> associated with the dying mm ASAP.
> 
> The presence of a kernel-to-kernel thread transition indicates that
> the cpu is probably idling with no higher priority user task to run.
> So the overhead of loading the mm_users cacheline should not really
> matter in this case.
> 
> My testing on an x86 system showed that the mm_struct was freed within
> seconds after the task exited instead of staying alive for minutes or
> even longer on a mostly idle system before this patch.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/core.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 795077af4f1a..41997e676251 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3214,6 +3214,8 @@ static __always_inline struct rq *
>  context_switch(struct rq *rq, struct task_struct *prev,
>  	       struct task_struct *next, struct rq_flags *rf)
>  {
> +	struct mm_struct *next_mm = next->mm;
> +
>  	prepare_task_switch(rq, prev, next);
>  
>  	/*
> @@ -3229,8 +3231,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 *
>  	 * kernel ->   user   switch + mmdrop() active
>  	 *   user ->   user   switch
> +	 *
> +	 * kernel -> kernel and !prev->active_mm->mm_users:
> +	 *   switch to init_mm + mmgrab() + mmdrop()
>  	 */
> -	if (!next->mm) {                                // to kernel
> +	if (!next_mm) {					// to kernel
> +		/*
> +		 * Checking is only done on kernel -> kernel transition
> +		 * to avoid any performance overhead while user tasks
> +		 * are running.
> +		 */
> +		if (unlikely(!prev->mm &&
> +			     !atomic_read(&prev->active_mm->mm_users))) {
> +			next_mm = next->active_mm = &init_mm;
> +			mmgrab(next_mm);
> +			goto mm_switch;
> +		}
>  		enter_lazy_tlb(prev->active_mm, next);
>  
>  		next->active_mm = prev->active_mm;

So I _really_ hate this complication. I'm thinking if you really care
about this the time is much better spend getting rid of the active_mm
tracking for x86 entirely.

