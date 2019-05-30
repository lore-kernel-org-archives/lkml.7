Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B155C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466E3218CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wxvteZMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfE3IES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:04:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46660 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZNHljSo+xuO+rijXANsB4tJFe4vq/fcU3WZ/qW7T1K4=; b=wxvteZMtqs4EUcTAMJWHqixz6
        mFlqd2lJn4cAJwAR/hiRZrEL1HzdpfpSWviOKW76MazUqLmiCOX0GXm9QTDDGduA5qdqBmPAd1R7/
        gtqvGkRUITnXCQaDqEVvt5XPaHTg+ZT+AMGLgBcwFJMbrTOd+9sLivPTHl8mHadihGFP0gX7iwini
        Q8Pj3wSK1+yjR342xlFv6RVYcZ+uBZY/cOmdfazWIwbFvd8oxQeWoMEc04vYPX77/yQa648a+tnc3
        5OW0ffbHO3MaepHn+iCGQ4H+GGlo9+ea+OgZeFcCBAVm+/3fFP9eqtKq+q2nEJa3OQDIFlizD1mXZ
        w34kI7GWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWG2a-0004nX-GI; Thu, 30 May 2019 08:04:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D70FB201B3992; Thu, 30 May 2019 10:03:58 +0200 (CEST)
Date:   Thu, 30 May 2019 10:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     axboe@kernel.dk, akpm@linux-foundation.org, hch@lst.de,
        oleg@redhat.com, gkohli@codeaurora.org, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
Message-ID: <20190530080358.GG2623@hirez.programming.kicks-ass.net>
References: <1559161526-618-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559161526-618-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:25:26PM -0400, Qian Cai wrote:

> Fixes: 0619317ff8ba ("block: add polled wakeup task helper")

What is the purpose of that patch ?! The Changelog doesn't mention any
benefit or performance gain. So why not revert that?

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669bcc536..290eb7528f54 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1803,7 +1803,7 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
>  	 * that case, we don't need to signal a wakeup, it's enough to just
>  	 * mark us as RUNNING.
>  	 */
> -	if (waiter == current)
> +	if (waiter == current && in_task())
>  		__set_current_state(TASK_RUNNING);

NAK, No that's broken too.

The right fix is something like:

	if (waiter == current) {
		barrier();
		if (current->state & TASK_NORAL)
			__set_current_state(TASK_RUNNING);
	}

But even that is yuck to do outside of the scheduler code, as it looses
tracepoints and stats.

So can we please just revert that original patch and start over -- if
needed?

>  	else
>  		wake_up_process(waiter);
> -- 
> 1.8.3.1
> 
