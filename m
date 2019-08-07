Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBAFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E88217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKqlEAh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbfHGVMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:12:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfHGVMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mjrrHZrSfKsYa+8uZouXNoh4pKm8BCq70Dh7kQvJcYo=; b=mKqlEAh/h5yQlexBHF1hWmoMK
        T9W9/IXJ0KCoWv/9EacXdAIlGKUy1fgRMMO4XiR/i0oSyZ2YXXGxE1VLjOQvYKiX016sGZpJmHd7N
        TaHQEg+/MW1InoskXhF6XT476X5sHP8BR3mpJryRm6IG2zChf8mM6XhAmd288QPaAigilB4y2hgFR
        6AhgU2htD2QUIBb3ea7UFmaQNobtmRlyGB2Hp3XIt7iKHxzhrdFSp1e8YBrkSG2+UTtpMVG/tYMv2
        FiUOTbqQzzH5xeCnKaP2bEVch3cFU8nZAqFr3gMMKJ5JQTuUK6cLktVNBiHMQVvZjmyzoQKtCpbll
        h+aDIBqCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvTDm-0002nR-BG; Wed, 07 Aug 2019 21:11:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86A689803B4; Wed,  7 Aug 2019 23:11:43 +0200 (CEST)
Date:   Wed, 7 Aug 2019 23:11:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/7] perf: avoid a bounded set of visit_groups_merge
 iterators
Message-ID: <20190807211143.GA15727@worktop.programming.kicks-ass.net>
References: <20190724223746.153620-1-irogers@google.com>
 <20190724223746.153620-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724223746.153620-5-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 03:37:43PM -0700, Ian Rogers wrote:

> @@ -2597,6 +2612,30 @@ static int  __perf_install_in_context(void *info)
>  		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
>  		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
>  					event->cgrp->css.cgroup);
> +
> +		/*
> +		 * Ensure space for visit_groups_merge iterator storage. With
> +		 * cgroup profiling we may have an event at each depth plus
> +		 * system wide events.
> +		 */
> +		max_iterators = perf_event_cgroup_depth(event) + 1;
> +		if (max_iterators >
> +		    cpuctx->visit_groups_merge_iterator_storage_size) {
> +			struct perf_event **storage =
> +			   krealloc(cpuctx->visit_groups_merge_iterator_storage,
> +				    sizeof(struct perf_event *) * max_iterators,
> +				    GFP_KERNEL);
> +			if (storage) {
> +				cpuctx->visit_groups_merge_iterator_storage
> +						= storage;
> +				cpuctx->visit_groups_merge_iterator_storage_size
> +						= max_iterators;
> +			} else {
> +				WARN_ONCE(1, "Unable to increase iterator "
> +					"storage for perf events with cgroups");
> +				ret = -ENOMEM;
> +			}
> +		}
>  	}
>  #endif

This is completely insane and broken. You do not allocate memory from
hardirq context while holding all sorts of locks.

Also, the patches are still an unreadable mess, and they do far too much
in a single patch.

Please have a look at the completely untested lot at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/cgroup


