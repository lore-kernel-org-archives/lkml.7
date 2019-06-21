Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F98C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378C4208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vSBoJuJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfFUIYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:24:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfFUIYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WDATsJm5QHSgoI0BXmnIgMn4hqXmdsiP6w1+JnWmjd8=; b=vSBoJuJZr0pPHaY0a1nj7rXkD
        ZE9iV1K6CUDGFVezmcYkO2/8ticfGSmE/qo5KLjloj8r4NKTamX7eEHE5pFQo1KnLkcviyY1dZbg9
        BxXps5ZbkIdkKPlYedqgBawggJ1uWUvKF0cv+H90Wr/ufEi/9cVYbraKxNJVBJPuGxH8POCKlZXIE
        zwO0OWYdUa77QKU85asjX/3Ee0vAhkkMjJlVjlxoyHJXM8fahF65CWnB8rtZo24BsojzIEygDeq/C
        aEskEiCaKWd9PkZaSSoCoxZ45gY+kZRChqK+G+0beBFYJ7G61NvxbIXjbhEtEIvFj5zPd4sleOhft
        a1URl3p/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heEqP-0007kn-9r; Fri, 21 Jun 2019 08:24:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54283203C06F5; Fri, 21 Jun 2019 10:24:22 +0200 (CEST)
Date:   Fri, 21 Jun 2019 10:24:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups
 unnecessarily
Message-ID: <20190621082422.GH3436@hirez.programming.kicks-ass.net>
References: <20190601082722.44543-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601082722.44543-1-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 01:27:22AM -0700, Ian Rogers wrote:
> @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
>  			sid->can_add_hw = 0;
>  	}
>  
> +	/*
> +	 * If the group wasn't scheduled then set that multiplexing is necessary
> +	 * for the context. Note, this won't be set if the event wasn't
> +	 * scheduled due to event_filter_match failing due to the earlier
> +	 * return.
> +	 */
> +	if (event->state == PERF_EVENT_STATE_INACTIVE)
> +		sid->ctx->rotate_necessary = 1;
> +
>  	return 0;
>  }

That looked odd; which had me look harder at this function which
resulted in the below. Should we not terminate the context interation
the moment one flexible thingy fails to schedule?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2314,12 +2314,8 @@ group_sched_in(struct perf_event *group_
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
-
-	if (event_sched_in(group_event, cpuctx, ctx)) {
-		pmu->cancel_txn(pmu);
-		perf_mux_hrtimer_restart(cpuctx);
-		return -EAGAIN;
-	}
+	if (event_sched_in(group_event, cpuctx, ctx))
+		goto cancel;
 
 	/*
 	 * Schedule in siblings as one group (if any):
@@ -2348,10 +2344,9 @@ group_sched_in(struct perf_event *group_
 	}
 	event_sched_out(group_event, cpuctx, ctx);
 
+cancel:
 	pmu->cancel_txn(pmu);
-
 	perf_mux_hrtimer_restart(cpuctx);
-
 	return -EAGAIN;
 }
 
@@ -3317,6 +3312,7 @@ static int pinned_sched_in(struct perf_e
 static int flexible_sched_in(struct perf_event *event, void *data)
 {
 	struct sched_in_data *sid = data;
+	int ret;
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
@@ -3325,21 +3321,15 @@ static int flexible_sched_in(struct perf
 		return 0;
 
 	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->flexible_active);
-		else
+		ret = group_sched_in(event, sid->cpuctx, sid->ctx);
+		if (ret) {
 			sid->can_add_hw = 0;
+			sid->ctx->rotate_necessary = 1;
+			return ret;
+		}
+		list_add_tail(&event->active_list, &sid->ctx->flexible_active);
 	}
 
-	/*
-	 * If the group wasn't scheduled then set that multiplexing is necessary
-	 * for the context. Note, this won't be set if the event wasn't
-	 * scheduled due to event_filter_match failing due to the earlier
-	 * return.
-	 */
-	if (event->state == PERF_EVENT_STATE_INACTIVE)
-		sid->ctx->rotate_necessary = 1;
-
 	return 0;
 }
 
