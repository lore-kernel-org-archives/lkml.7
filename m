Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C955C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B4620663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3cIxn6Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfLLPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:44:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLLPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kt8RprEVvJ+Cu0AzYhiclSdRQFLHB8SctifaOR4JQpY=; b=3cIxn6KjHUF1w2JoTc+g36r+F
        2TKn1zAWmIBbzS7/c23n5lIIEXm57QAtQ3WOKpAa2GyOhLFS6T+0XHOB1gbBK9XPVKeF/IQL/p5W2
        APTPtUtJHqCylBtujwG/xAm6gmBX+vAoukghnIkjFT2Q6OTLDCs+k85yBKyZ7M56+48YUY6M373tU
        51UF0k4iNyLtD0Z8+Qta9EzWXRlSSMSL5xMXKykvXsGc8JFj0C+0c4nIY/cEuFGWXQb4z3v8CcOJ1
        5OaJVerO2krvT0W7rn0OeZILp+ArIOvpRP1kOu2a4zk6aDIDYiGwKngztjvL7g0ZY9dupQe7he7uU
        kRtRnXJsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQdq-0003Ed-CR; Thu, 12 Dec 2019 15:44:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C71C6305E21;
        Thu, 12 Dec 2019 16:43:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 288C02012196F; Thu, 12 Dec 2019 16:44:37 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:44:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Message-ID: <20191212154437.GC2827@hirez.programming.kicks-ass.net>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212134951.GX2844@hirez.programming.kicks-ass.net>
 <5D5BC3C8-427D-4983-AAEB-0E8001751BA0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D5BC3C8-427D-4983-AAEB-0E8001751BA0@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:37:05PM +0000, Song Liu wrote:
> 
> 
> > On Dec 12, 2019, at 5:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
> > 
> >> @@ -750,6 +752,16 @@ struct perf_event {
> >> 	void *security;
> >> #endif
> >> 	struct list_head		sb_list;
> >> +
> >> +	/* for PMU sharing */
> >> +	struct perf_event		*dup_master;
> >> +	/* check event_sync_dup_count() for the use of dup_base_* */
> >> +	u64				dup_base_count;
> >> +	u64				dup_base_child_count;
> >> +	/* when this event is master,  read from master*count */
> >> +	local64_t			master_count;
> >> +	atomic64_t			master_child_count;
> >> +	int				dup_active_count;
> >> #endif /* CONFIG_PERF_EVENTS */
> >> };
> > 
> >> +/* PMU sharing aware version of event->pmu->add() */
> >> +static int event_pmu_add(struct perf_event *event,
> >> +			 struct perf_event_context *ctx)
> >> +{
> >> +	struct perf_event *master;
> >> +	int ret;
> >> +
> >> +	/* no sharing, just do event->pmu->add() */
> >> +	if (!event->dup_master)
> >> +		return event->pmu->add(event, PERF_EF_START);
> > 
> > Possibly we should look at the location of perf_event::dup_master to be
> > in a hot cacheline. Because I'm thinking you just added a guaranteed
> > miss here.
> 
> I am not quite sure the best location for these. How about:
> 
> diff --git i/include/linux/perf_event.h w/include/linux/perf_event.h
> index 7d49f9251621..218cc7f75775 100644
> --- i/include/linux/perf_event.h
> +++ w/include/linux/perf_event.h
> @@ -643,6 +643,16 @@ struct perf_event {
>         local64_t                       count;
>         atomic64_t                      child_count;
> 
> +       /* for PMU sharing */
> +       struct perf_event               *dup_master;
> +       /* check event_sync_dup_count() for the use of dup_base_* */
> +       u64                             dup_base_count;
> +       u64                             dup_base_child_count;
> +       /* when this event is master,  read from master*count */
> +       local64_t                       master_count;
> +       atomic64_t                      master_child_count;
> +       int                             dup_active_count;
> +
>         /*
>          * These are the total time in nanoseconds that the event
>          * has been enabled (i.e. eligible to run, and the task has

Ah, no. Only put dup_master somewhere hot. The rest is not that
important. For instance, you can put it right next to event->pmu,
because that's going to be used right next to it, right?
