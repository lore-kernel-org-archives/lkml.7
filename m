Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE8C217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2KbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:31:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:31:22 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iadYV-0002ws-2f; Fri, 29 Nov 2019 11:31:19 +0100
Date:   Fri, 29 Nov 2019 11:31:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Add SRCU annotation for pmus list walk
Message-ID: <20191129103119.oyybuwl53twh3qz6@linutronix.de>
References: <20191119121429.zhcubzdhm672zasg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191119121429.zhcubzdhm672zasg@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 13:14:29 [+0100], To linux-kernel@vger.kernel.org wrote:
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

ping.

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
>  		ret = perf_try_init_event(pmu, event);
>  		if (!ret)
>  			goto unlock;

Sebastian
