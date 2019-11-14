Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A757F206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rEsbC0KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:26:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B8s1hUftJx6CL6q5qKFXFyG/6jmkf1vM/E8bdueQD1M=; b=rEsbC0KXl+GxqnjRpHRI1hA30
        ucNma1lt3v14AesMWin7ChWpa24gdBQkKLmMx8RWgGw/CB46Ds+glT1M/qaKmzg1CTUiFzDPl2+kd
        77qkNePVFbRZDAQGHO8AAFdexS9KlBAgT903tIaqOV8EaJouKVkVoCi9eP7WUHDuR5SdVA4+wImHO
        tcYpRKOISokaKvOUt9CuRxiJkq1A796CSmzZ87ZBvSyni9Av21EooMk0GlyzWPGO9fA/sccVejewB
        Qw7GBhx0m1JTlztHsJTVEH5hqoX+mVUVn0QtkxluuYdGBM8WAmaQDuQ7tQAmxU1nnDV5ybAHlh/sN
        JFI6/olaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVCJx-0002q3-DL; Thu, 14 Nov 2019 10:25:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54D9C3002B0;
        Thu, 14 Nov 2019 11:24:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCB4C29DF1247; Thu, 14 Nov 2019 11:25:44 +0100 (CET)
Date:   Thu, 14 Nov 2019 11:25:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 08/10] perf: cache perf_event_groups_first for cgroups
Message-ID: <20191114102544.GS4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-9-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114003042.85252-9-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:30:40PM -0800, Ian Rogers wrote:
> Add a per-CPU cache of the pinned and flexible perf_event_groups_first
> value for a cgroup avoiding an O(log(#perf events)) searches during
> sched_in.
> 
> Based-on-work-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/perf_event.h |  6 +++
>  kernel/events/core.c       | 79 +++++++++++++++++++++++++++-----------
>  2 files changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index b3580afbf358..cfd0b320418c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -877,6 +877,12 @@ struct perf_cgroup_info {
>  struct perf_cgroup {
>  	struct cgroup_subsys_state	css;
>  	struct perf_cgroup_info	__percpu *info;
> +	/* A cache of the first event with the perf_cpu_context's
> +	 * perf_event_context for the first event in pinned_groups or
> +	 * flexible_groups. Avoids an rbtree search during sched_in.
> +	 */

Broken comment style.

> +	struct perf_event * __percpu    *pinned_event;
> +	struct perf_event * __percpu    *flexible_event;

Where is the actual storage allocated? There is a conspicuous lack of
alloc_percpu() in this patch, see for example perf_cgroup_css_alloc()
which fills out the above @info field.

>  };
>  
>  /*
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 11594d8bbb2e..9f0febf51d97 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1638,6 +1638,25 @@ perf_event_groups_insert(struct perf_event_groups *groups,
>  
>  	rb_link_node(&event->group_node, parent, node);
>  	rb_insert_color(&event->group_node, &groups->tree);
> +#ifdef CONFIG_CGROUP_PERF
> +	if (is_cgroup_event(event)) {
> +		struct perf_event **cgrp_event;
> +
> +		if (event->attr.pinned)
> +			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
> +						event->cpu);
> +		else
> +			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
> +						event->cpu);

Codingstyle requires { } here (or just bust the line length a little).

> +		/*
> +		 * Cgroup events for the same cgroup on the same CPU will
> +		 * always be inserted at the right because of bigger
> +		 * @groups->index. Only need to set *cgrp_event when it's NULL.
> +		 */
> +		if (!*cgrp_event)
> +			*cgrp_event = event;

I would feel much better if you had some actual leftmost logic in the
insertion iteration.

> +	}
> +#endif
>  }
>  
>  /*
> @@ -1652,6 +1671,9 @@ add_event_to_groups(struct perf_event *event, struct perf_event_context *ctx)
>  	perf_event_groups_insert(groups, event);
>  }
>  
> +static struct perf_event *
> +perf_event_groups_next(struct perf_event *event);
> +
>  /*
>   * Delete a group from a tree.
>   */
> @@ -1662,6 +1684,22 @@ perf_event_groups_delete(struct perf_event_groups *groups,
>  	WARN_ON_ONCE(RB_EMPTY_NODE(&event->group_node) ||
>  		     RB_EMPTY_ROOT(&groups->tree));
>  
> +#ifdef CONFIG_CGROUP_PERF
> +	if (is_cgroup_event(event)) {
> +		struct perf_event **cgrp_event;
> +
> +		if (event->attr.pinned)
> +			cgrp_event = per_cpu_ptr(event->cgrp->pinned_event,
> +						event->cpu);
> +		else
> +			cgrp_event = per_cpu_ptr(event->cgrp->flexible_event,
> +						event->cpu);

Codingstyle again.

> +
> +		if (*cgrp_event == event)
> +			*cgrp_event = perf_event_groups_next(event);
> +	}
> +#endif
> +
>  	rb_erase(&event->group_node, &groups->tree);
>  	init_event_group(event);
>  }
> @@ -1679,20 +1717,14 @@ del_event_from_groups(struct perf_event *event, struct perf_event_context *ctx)
>  }
>  
>  /*
> - * Get the leftmost event in the cpu/cgroup subtree.
> + * Get the leftmost event in the cpu subtree without a cgroup (ie task or
> + * system-wide).
>   */
>  static struct perf_event *
> -perf_event_groups_first(struct perf_event_groups *groups, int cpu,
> -			struct cgroup *cgrp)
> +perf_event_groups_first_no_cgroup(struct perf_event_groups *groups, int cpu)

I'm going to impose a function name length limit soon :/ That's insane
(again).

>  {
>  	struct perf_event *node_event = NULL, *match = NULL;
>  	struct rb_node *node = groups->tree.rb_node;
> -#ifdef CONFIG_CGROUP_PERF
> -	int node_cgrp_id, cgrp_id = 0;
> -
> -	if (cgrp)
> -		cgrp_id = cgrp->id;
> -#endif
>  
>  	while (node) {
>  		node_event = container_of(node, struct perf_event, group_node);
> @@ -1706,18 +1738,10 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
>  			continue;
>  		}
>  #ifdef CONFIG_CGROUP_PERF
> -		node_cgrp_id = 0;
> -		if (node_event->cgrp && node_event->cgrp->css.cgroup)
> -			node_cgrp_id = node_event->cgrp->css.cgroup->id;
> -
> -		if (cgrp_id < node_cgrp_id) {
> +		if (node_event->cgrp) {
>  			node = node->rb_left;
>  			continue;
>  		}
> -		if (cgrp_id > node_cgrp_id) {
> -			node = node->rb_right;
> -			continue;
> -		}
>  #endif
>  		match = node_event;
>  		node = node->rb_left;

Also, just leave that in and let callers have: .cgrp = NULL. Then you
can forgo that monstrous name.

