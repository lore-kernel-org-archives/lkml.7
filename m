Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFCBC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79620693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkaE0H8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfGHQVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:21:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57146 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGHQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZwYfPk5d/Yy55T7nPWB9w4EAXddoKhF7sDVLRypzsWg=; b=LkaE0H8XqZ6iaM3BHzbgbkaYk
        ONscP2cE2Om1tnwVQtCK/Ktz5rj/oiCz3MXVt2KB/Qk89l3FWS9hcRxYdrACzOEHrvLZf8FkrOZYG
        O8TQsLUVsyVf3y/zO8MAqFrwekkrweFTbyEpe9QrpW0d50Wxs7QvcbMCYklkgoPRWvtyt1Oj51Iso
        ZxJV8rbTgO8DnAOAqyZ+ZrRylDWmu91AiltqimLr/a/rREICp474u/lfdCuIxmC5eCTgBUSy5+MRS
        LTIU+MPk2cb8qsFv17V0RQVYppgyFqUrG1SH8ba1wnRT0SyXqvzqmeKYZz0d1sxXEd6Ag4imHUUHE
        rJrpqvl4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkWOE-0000bG-Bp; Mon, 08 Jul 2019 16:21:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E461A20976D60; Mon,  8 Jul 2019 18:21:15 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:21:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/7] perf/cgroup: order events in RB tree by cgroup id
Message-ID: <20190708162115.GF3419@hirez.programming.kicks-ass.net>
References: <20190702065955.165738-1-irogers@google.com>
 <20190702065955.165738-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702065955.165738-3-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 11:59:50PM -0700, Ian Rogers wrote:
> +#ifndef CONFIG_CGROUP_PERF
> +	/*
> +	 * Without cgroups, with a task context, iterate over per-CPU and any
> +	 * CPU events.
> +	 */
> +	const int max_itrs = 2;
> +#else
> +	/*
> +	 * The depth of cgroups is limited by MAX_PATH. It is unlikely that this
> +	 * many parent-child related cgroups will have perf events
> +	 * monitored. Limit the number of cgroup iterators to 16.
> +	 */
> +	const int max_cgroups_with_events_depth = 16;
> +	/*
> +	 * With cgroups we either iterate for a task context (per-CPU or any CPU
> +	 * events) or for per CPU the global and per cgroup events.
> +	 */
> +	const int max_itrs = max(2, 1 + max_cgroups_with_events_depth);

That seems like a very complicated way to write 17.

> +#endif
> +	/* The number of iterators in use. */
> +	int num_itrs;
> +	/*
> +	 * A set of iterators, the iterator for the visit is chosen by the
> +	 * group_index.
> +	 */
> +	struct perf_event *itrs[max_itrs];

And that is 136 bytes of stack. Which I suppose is just about
acceptible.

But why not something like:

	struct perf_event *iters[IS_ENABLED(CONFIG_CGROUP_PERF) ? 17 : 2];

	iters[i++] = foo;
	WARN_ON_ONCE(i >= ARRAY_SIZE(iters));

?
