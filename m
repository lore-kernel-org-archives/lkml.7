Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F2CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E222E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhA+b9MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfG2Iwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfG2Iwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pf+2UYjQfUCcdua9fj0MZ+S5GX0o3D3g2pJePzx5CR0=; b=DhA+b9MJh5Ib8+w6zn2x8quHB
        ZyZHgZxgg/XbKrTxiGtCQdpM3cFg4XGuYsMDAYnNrVczBl/2Nv7OFHSh+mcrrbRB3CsZUW9MHNNrt
        hxLc2PPXet0jIl6v/iEkqoNQGqGfjh2y6wIj0U9uL3tu+m+ytwxBJ6GUe3EncfUmZufDkAo9NBGTl
        tk1ndEyADAno6POFOsRX31WBYzBYNw8SnR0TvvLv5MI4xEuVt9ZdiwKIZep53qL6gP/2JyPineZHB
        7mr0SiV2fMHTMuyUrgACn2WQ2kRcORbE35cNGZ0PgwyTi6s5FaS5unCDnbS+bUNiukNg0Fm7iyQvt
        +9mKJQu6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs1OX-0008Ot-Ss; Mon, 29 Jul 2019 08:52:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ABA72025E7AD; Mon, 29 Jul 2019 10:52:35 +0200 (CEST)
Date:   Mon, 29 Jul 2019 10:52:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
Message-ID: <20190729085235.GT31381@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727171047.31610-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
> It was found that a dying mm_struct where the owning task has exited
> can stay on as active_mm of kernel threads as long as no other user
> tasks run on those CPUs that use it as active_mm. This prolongs the
> life time of dying mm holding up memory and other resources like swap
> space that cannot be freed.

Sure, but this has been so 'forever', why is it a problem now?

> Fix that by forcing the kernel threads to use init_mm as the active_mm
> if the previous active_mm is dying.
> 
> The determination of a dying mm is based on the absence of an owning
> task. The selection of the owning task only happens with the CONFIG_MEMCG
> option. Without that, there is no simple way to determine the life span
> of a given mm. So it falls back to the old behavior.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  kernel/sched/core.c      | 13 +++++++++++--
>  mm/init-mm.c             |  4 ++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3a37a89eb7a7..32712e78763c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -623,6 +623,21 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>  	return atomic_read(&mm->tlb_flush_pending) > 1;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +/*
> + * A mm is considered dying if there is no owning task.
> + */
> +static inline bool mm_dying(struct mm_struct *mm)
> +{
> +	return !mm->owner;
> +}
> +#else
> +static inline bool mm_dying(struct mm_struct *mm)
> +{
> +	return false;
> +}
> +#endif
> +
>  struct vm_fault;

Yuck. So people without memcg will still suffer the terrible 'whatever
it is this patch fixes'.

>  /**
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2b037f195473..923a63262dfd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3233,13 +3233,22 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 * Both of these contain the full memory barrier required by
>  	 * membarrier after storing to rq->curr, before returning to
>  	 * user-space.
> +	 *
> +	 * If mm is NULL and oldmm is dying (!owner), we switch to
> +	 * init_mm instead to make sure that oldmm can be freed ASAP.
>  	 */
> -	if (!mm) {
> +	if (!mm && !mm_dying(oldmm)) {
>  		next->active_mm = oldmm;
>  		mmgrab(oldmm);
>  		enter_lazy_tlb(oldmm, next);
> -	} else
> +	} else {
> +		if (!mm) {
> +			mm = &init_mm;
> +			next->active_mm = mm;
> +			mmgrab(mm);
> +		}
>  		switch_mm_irqs_off(oldmm, mm, next);
> +	}
>  
>  	if (!prev->mm) {
>  		prev->active_mm = NULL;

Bah, I see we _still_ haven't 'fixed' that code. And you're making an
even bigger mess of it.

Let me go find where that cleanup went.
