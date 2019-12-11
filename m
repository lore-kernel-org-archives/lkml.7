Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37661C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ADF21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A9gHP+61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfLKPlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:41:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57964 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfLKPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lO4lPUU3yozgRp45+WR5yZ6Lr7mr+pvaSnPUniJcXZg=; b=A9gHP+61nuGUbn7GlmdCVpH66
        KTe9R13efOXveVDz2gmC8VO9TzQAyn1P+YDBo+OxhinXeDa3LXczNqu3ye86chPS7skYtz7lO6Jmm
        IvLonYDhnxRLtU1DPz7JMYcInhttZ5qS4h1dwGauImiOlOdJsW42J1mitbFwu0QEeon3griwZwVCE
        O4HFOhs8LQVKiXUGcS896438TthZQllEpw4Y9huE+i/HLciiIjMWU7rwtKiQpH8q37A4y3SBcCJyx
        xibPRbLjA50GCrjX5xwSbLWW1WUxyVWPGvJZ5u5VGu9B/tgxAcRWlLqyDM76ZLB+6NpIq5pEZlHiS
        fzqZw08GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if46n-0007Jx-Cm; Wed, 11 Dec 2019 15:41:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C501E30798D;
        Wed, 11 Dec 2019 16:39:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B970D20137C8F; Wed, 11 Dec 2019 16:40:58 +0100 (CET)
Date:   Wed, 11 Dec 2019 16:40:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: Allow smp_call_function_single_async() to insert
 locked csd
Message-ID: <20191211154058.GO2827@hirez.programming.kicks-ass.net>
References: <20191204204823.1503-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204204823.1503-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:48:23PM -0500, Peter Xu wrote:
> Previously we will raise an warning if we want to insert a csd object
> which is with the LOCK flag set, and if it happens we'll also wait for
> the lock to be released.  However, this operation does not match
> perfectly with how the function is named - the name with "_async"
> suffix hints that this function should not block, while we will.
> 
> This patch changed this behavior by simply return -EBUSY instead of
> waiting, at the meantime we allow this operation to happen without
> warning the user to change this into a feature when the caller wants
> to "insert a csd object, if it's there, just wait for that one".
> 
> This is pretty safe because in flush_smp_call_function_queue() for
> async csd objects (where csd->flags&SYNC is zero) we'll first do the
> unlock then we call the csd->func().  So if we see the csd->flags&LOCK
> is true in smp_call_function_single_async(), then it's guaranteed that
> csd->func() will be called after this smp_call_function_single_async()
> returns -EBUSY.
> 
> Update the comment of the function too to refect this.
> 
> CC: Marcelo Tosatti <mtosatti@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Nadav Amit <namit@vmware.com>
> CC: Josh Poimboeuf <jpoimboe@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> The story starts from a test where we've encountered the WARN_ON() on
> a customized kernel and the csd_wait() took merely forever to
> complete (so we've got a WARN_ON plusing a hang host).  The current
> solution (which is downstream-only for now) is that from the caller's
> side we use a boolean to store whether the csd is executed, we do:
> 
>   if (atomic_cmpxchg(&in_progress, 0, 1))
>     smp_call_function_single_async(..);
> 
> While at the end of csd->func() we clear the bit.  However imho that's
> mostly what csd->flags&LOCK is doing.  So I'm thinking maybe it would
> worth it to raise this patch for upstream too so that it might help
> other users of smp_call_function_single_async() when they need the
> same semantic (and, I do think we shouldn't wait in _async()s...)

hrtick_start() seems to employ something similar.

> Signed-off-by: Peter Xu <peterx@redhat.com>

duplicate tag :-)

> ---
>  kernel/smp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 7dbcb402c2fc..dd31e8228218 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -329,6 +329,11 @@ EXPORT_SYMBOL(smp_call_function_single);
>   * (ie: embedded in an object) and is responsible for synchronizing it
>   * such that the IPIs performed on the @csd are strictly serialized.
>   *
> + * If the function is called with one csd which has not yet been
> + * processed by previous call to smp_call_function_single_async(), the
> + * function will return immediately with -EBUSY showing that the csd
> + * object is still in progress.
> + *
>   * NOTE: Be careful, there is unfortunately no current debugging facility to
>   * validate the correctness of this serialization.
>   */
> @@ -338,14 +343,17 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
>  
>  	preempt_disable();
>  
> -	/* We could deadlock if we have to wait here with interrupts disabled! */
> -	if (WARN_ON_ONCE(csd->flags & CSD_FLAG_LOCK))
> -		csd_lock_wait(csd);
> +	if (csd->flags & CSD_FLAG_LOCK) {
> +		err = -EBUSY;
> +		goto out;
> +	}
>  
>  	csd->flags = CSD_FLAG_LOCK;
>  	smp_wmb();
>  
>  	err = generic_exec_single(cpu, csd, csd->func, csd->info);
> +
> +out:
>  	preempt_enable();
>  
>  	return err;

Yes.. I think this will work.

I worry though; usage such as in __blk_mq_complete_request() /
raise_blk_irq(), which explicitly clears csd.flags before calling it
seems more dangerous than usual.

liquidio_napi_drv_callback() does that same.

