Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36979206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X1AHChLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfLQMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:22:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfLQMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N1JQnboObYcGyU2KHzFTvs4Z7NiQgmWjANexPDMj0po=; b=X1AHChLgCe51o7IT8s4OgQBIg
        jIC8YyPRjwjBFzVxm0DrV4UqidK+zCVv6+gwWWN+Q54JaBH+6pi6vHygdimesUQ8pujtCYQOAA0ZL
        PUiQzRCHI5S4M0LivWykaxg+Lz6NZPrp8XDDaa71KiI9AGcmcL+PQq4020/dk1w+2ieCZiIxZFZNh
        mQt8FIGi8iOAXmkQzFkSkoafeLiJ570gwm5+t27li7bzvJ9zi5Go3dR2TSzGMcqHilUXB1iwL7rEM
        v7p56EXCCv9PBzZln927KVYciSRpeQoJmjSPjGshCBpDEJ5o1AxR3f6r4vL5R766c4VAxCEg3TRck
        XM1XKo4cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihBrP-0002vq-8S; Tue, 17 Dec 2019 12:21:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32AAC3007F2;
        Tue, 17 Dec 2019 13:20:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C486420213E1A; Tue, 17 Dec 2019 13:21:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 13:21:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Add SRCU annotation for pmus list walk
Message-ID: <20191217122152.GE2844@hirez.programming.kicks-ass.net>
References: <20191119121429.zhcubzdhm672zasg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119121429.zhcubzdhm672zasg@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 01:14:29PM +0100, Sebastian Andrzej Siewior wrote:
> Since commit
>    28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")
> 
> there is an additional check to ensure that a RCU related lock is held
> while the RCU list is iterated.
> This section holds the SRCU reader lock instead.
> 
> Add annotation to list_for_each_entry_rcu() that pmus_srcu must be
> acquired during the list traversal.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> I see the warning in in v5.4-rc during boot. For some reason I don't see
> it in tip/master during boot but "perf stat w" triggers it again (among
> other things).
> 
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5224388872069..dbb3b26a55612 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10497,7 +10497,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  		goto unlock;
>  	}
>  
> -	list_for_each_entry_rcu(pmu, &pmus, entry) {
> +	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {

That's a bit obnoxious, but ok, I suppose.
