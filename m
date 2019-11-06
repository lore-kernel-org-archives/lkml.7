Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F85C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7B2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GG/e9clQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfKFJX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:23:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKFJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dZAvUYDePFsqcqkjX6yNxgsmYiIMmUcwPOFdzrAXXu4=; b=GG/e9clQsUsKdrpSf3iPml1VC
        7JsEg1rFXmLJpheGRfp3a5aFxDX3xvWBVEdsOxjixgv3baBpShQPTo1XBy2bDUzS144dBcmfRUhse
        OOIFW8m7FkZHLzlFHL514g/oU88KsD5KN5R/WVbrv8n03Ua6YbXEZAmTCNpBkv0OxFctdhy+2Z+6i
        a52KD0IvC0w6PE8WOw3b53HNxplzezNOL+WxXFEvebzaj+iBojvBGn4OTibQH3Js8Mx4T1vAJYefI
        aYa3DwMH8lWj4B4/CHew3QDr2HDDqmMc5RuddVfWcDa6ydVib1pQMicA/ZgKnmMHYu2G/3QaMEXgy
        4sg1eyrYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSHXe-0005dK-BV; Wed, 06 Nov 2019 09:23:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C5BF301A79;
        Wed,  6 Nov 2019 10:22:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 981E229A4C2C7; Wed,  6 Nov 2019 10:23:52 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:23:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, andi@firstfloor.org, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf/core: fix unlock balance in perf_init_event
Message-ID: <20191106092352.GU4131@hirez.programming.kicks-ass.net>
References: <20191106052935.8352-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106052935.8352-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:29:35AM -0500, Qian Cai wrote:
> The -next commit "perf/core: Optimize perf_init_event()" [1] introduced
> an unlock imbalance in perf_init_event() where it calls "goto again" and
> then only repeat rcu_read_unlock().
> 
>   WARNING: bad unlock balance detected!
>   perf_event_open/6185 is trying to release lock (rcu_read_lock) at:
>   [<ffffffffb5eb4039>] perf_event_alloc+0xbb9/0x17f0
>   but there are no more locks to release!
>   other info that might help us debug this:
>   2 locks held by perf_event_open/6185:
>   #0: ffff888526780b50 (&sig->cred_guard_mutex){+.+.}, at: __do_sys_perf_event_open+0x6ee/0x1460
>   #1: ffffffffb866b4e8 (&pmus_srcu){....}, at: perf_event_alloc+0xab8/0x17f0
>   Call Trace:
>    dump_stack+0xa0/0xea
>    print_unlock_imbalance_bug.cold.40+0xb1/0xb6
>    lock_release+0x349/0x4b0
>    perf_event_alloc+0xbcf/0x17f0
>    __do_sys_perf_event_open+0x1e2/0x1460
>    __x64_sys_perf_event_open+0x62/0x70
>    do_syscall_64+0xcc/0xaec
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [1] https://lore.kernel.org/lkml/20191022092307.425783389@infradead.org/

You wanted to write:

Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")

instead, right? Fixed that for you.

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfd89b4a02d8..8226d6ecdb86 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10307,7 +10307,6 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  			goto unlock;
>  	}
>  
> -	rcu_read_lock();
>  	/*
>  	 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>  	 * are often aliases for PERF_TYPE_RAW.
> @@ -10317,6 +10316,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  		type = PERF_TYPE_RAW;
>  
>  again:
> +	rcu_read_lock();
>  	pmu = idr_find(&pmu_idr, type);
>  	rcu_read_unlock();
>  	if (pmu) {
> -- 
> 2.21.0 (Apple Git-122)
> 
