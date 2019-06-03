Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3883DC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB052803C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RrCV1Gym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFCJtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:49:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFCJtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=65d4Y+1Ap7Wq4oBfZo3msirKt5xkc5tCjlN63jde964=; b=RrCV1GymZsHV1Th3QTzbw2prm
        UjrJRPyT7kPJCk8yfzqL2iTr4w2Jg6krm9LEIrk3anCpSMFz+rM5pwqH5xWdG4v2Z+RsODytT7eZY
        JAZAmjg/0G2TtlUUOsbRD49rR2S42j31E6T6c7sa/TcULUGfel2EFK4VLb+o92Z2pG058OtDj9213
        siiC6ac3TYjJQhVrhBaWCX44+9bDHGtkqFavaidrm/gWywZ+y0xJ0r4pjyj4f/eFnnk2Aa6ZW6TAk
        XlY3q9GCYPKMLu6BaNMHvvFrIlsnj3I+AJqnvvpBm121IWjrfdHe3ihWplfn914C8sND1kMRSKWQB
        yWOqntmMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXjaV-0001GT-Mx; Mon, 03 Jun 2019 09:49:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94AC6202CD6A0; Mon,  3 Jun 2019 11:49:05 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:49:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        yun.wang@linux.alibaba.com, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com,
        "liangyan.ply" <liangyan.ply@linux.alibaba.com>,
        Ben Segall <bsegall@google.com>
Subject: Re: [PATCH] sched/fair: don't restart enqueued cfs quota slack timer
Message-ID: <20190603094905.GA3419@hirez.programming.kicks-ass.net>
References: <20190603044309.168065-1-liangyan.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603044309.168065-1-liangyan.peng@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:43:09PM +0800, Liangyan wrote:
> From: "liangyan.ply" <liangyan.ply@linux.alibaba.com>
> 
> start_cfs_slack_bandwidth() will restart the quota slack timer,
> if it is called frequently, this timer will be restarted continuously
> and may have no chance to expire to unthrottle cfs tasks.
> This will cause that the throttled tasks can't be unthrottled in time
> although they have remaining quota.

This looks very similar to the patch from Ben here:

  https://lkml.kernel.org/r/xm26blzlyr9d.fsf@bsegall-linux.svl.corp.google.com

> 
> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
> ---
>  kernel/sched/fair.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d90a64620072..fdb03c752f97 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4411,9 +4411,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
>  	if (runtime_refresh_within(cfs_b, min_left))
>  		return;
>  
> -	hrtimer_start(&cfs_b->slack_timer,
> +	if (!hrtimer_active(&cfs_b->slack_timer)) {
> +		hrtimer_start(&cfs_b->slack_timer,
>  			ns_to_ktime(cfs_bandwidth_slack_period),
>  			HRTIMER_MODE_REL);
> +	}
>  }
>  
>  /* we know any runtime found here is valid as update_curr() precedes return */
> -- 
> 2.14.4.44.g2045bb6
> 
