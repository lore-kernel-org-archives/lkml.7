Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B246CC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A42D218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EpQvMvIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGELwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:52:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34144 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbfGELwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6d4KHN3i4zXpEDjesjEyuvQqjM/+ziVHjS82Ev0bcAI=; b=EpQvMvIbfZTaXP1ube4rCEQrT
        NaO2RA66GKegqEQxIpC+saDSbZFKYAlrRsA3ozuyzG+JEGXQWANd0rAym6qjIg/fd7pOuLAMa7bdi
        TINN6LuTbp17kN8DlPy7FzCIa5QU/HsnO2Zbv42TCNJhbM+zG6DzQgyZk4AH9ZDI5ega/YvLtwqfD
        jLygNSIrQGsTXBnECgfMbWA+jZEp6qaZI6AuGp7jYrwkp8vSVsNQFzJgBkc3wpkuL+kaMlaWcNNnN
        eY5gUPOdcdS37PVvpdKWlY5dE01XUYN0S1KosAp/WDymMLcyVNJUu6oEN3s3fUrEbwWUqH3IMcBFQ
        FrFbRkkQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjMlD-0001SU-Aw; Fri, 05 Jul 2019 11:52:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 707A02026E806; Fri,  5 Jul 2019 13:52:12 +0200 (CEST)
Date:   Fri, 5 Jul 2019 13:52:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     skhan@linuxfoundation.org, Ingo Molnar <mingo@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Sched: Change type of 'overrun' from int to u64
Message-ID: <20190705115212.GT3402@hirez.programming.kicks-ass.net>
References: <20190705085609.24453-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705085609.24453-1-puranjay12@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 02:26:09PM +0530, Puranjay Mohan wrote:
> Callers of hrtimer_forward_now() should save the return value in u64.
> function sched_rt_period_timer() stores
> it in variable 'overrun' of type int
> change type of overrun from int to u64 to solve the issue.

Is there an actual issue? If we've missed _that_ many periods, something
is really buggered.

From a code consistency PoV this patch makes sense, but I don't think
there anything really wrong with the current code.

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 1e6b909dca36..f5d3893914f5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -19,7 +19,7 @@ static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
>  	struct rt_bandwidth *rt_b =
>  		container_of(timer, struct rt_bandwidth, rt_period_timer);
>  	int idle = 0;
> -	int overrun;
> +	u64 overrun;
>  
>  	raw_spin_lock(&rt_b->rt_runtime_lock);
>  	for (;;) {
> -- 
> 2.21.0
> 
