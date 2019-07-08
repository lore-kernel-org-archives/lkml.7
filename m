Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2783FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA420651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R66ij/UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfGHPjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:39:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390680AbfGHPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sd5xZswn82hM4I4a2QGWA7E+FVpWZoE4wHH+4GtUsDY=; b=R66ij/UOIQSDxm7NY4L1BZH2H
        dD7Sn/QA8D1W+qg+4pfOien85BdI7rp/VVKl4fWrUylvwAeH6XyFxkl8m4jtt4Hn1aYDJGGFdZ/Ce
        d1eazRqcK5dTM/XAkg9YFRXrPRD2hmp0yStXRSgxOW1IFJ7i5tznv5KZxYbx9+t6oCH0bxkT9zJ+j
        ZE1jIZoCkCUyp+stkgq4oY0X8LfpUaNlfkDwTB0B4sLUU2SVBcLd+dnlK2mplxiWm4Pot1t9IzCKH
        8kUAAKnNU/e2tuD1vXPmaiKeJ5PT8u2s1UX4W46Dhep1aiYcTZmyR68hlPNioIe4QkuLUVaMOWqzX
        ktkHtnS1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkVjF-0007Hi-Gr; Mon, 08 Jul 2019 15:38:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DD5520976D60; Mon,  8 Jul 2019 17:38:55 +0200 (CEST)
Date:   Mon, 8 Jul 2019 17:38:55 +0200
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
Message-ID: <20190708153855.GC3419@hirez.programming.kicks-ass.net>
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
> @@ -1530,6 +1530,32 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
>  	if (left->cpu > right->cpu)
>  		return false;
>  
> +#ifdef CONFIG_CGROUP_PERF
> +	if (left->cgrp != right->cgrp) {
> +		if (!left->cgrp)
> +			/*
> +			 * Left has no cgroup but right does, no cgroups come
> +			 * first.
> +			 */
> +			return true;
> +		if (!right->cgrp)
> +			/*
> +			 * Right has no cgroup but left does, no cgroups come
> +			 * first.
> +			 */
> +			return false;

Per CodingStyle any multi-line statement (here due to comments) needs {
}.

> +		if (left->cgrp->css.cgroup != right->cgrp->css.cgroup) {
> +			if (!left->cgrp->css.cgroup)
> +				return true;
> +			if (!right->cgrp->css.cgroup)
> +				return false;
> +			/* Two dissimilar cgroups, order by id. */
> +			return left->cgrp->css.cgroup->id <
> +					right->cgrp->css.cgroup->id;
> +		}

This is dis-similar to the existing style ( < true, > false, ==
fall-through).

Can all this be written like:


	if (!left->cgrp || !left->cgrp.css.cgroup)
		return true;

	if (!right->cgrp || !right->cgrp.css.cgroup)
		return false;

	if (left->cgrp->css.cgroup->id < right->cgrp->css.cgroup->id)
		retun true;

	if (left->cgrp->css.cgroup->id > right->cgrp->css.cgroup->id)
		return false;


?

> +	}
> +#endif
> +
>  	if (left->group_index < right->group_index)
>  		return true;
>  	if (left->group_index > right->group_index)
