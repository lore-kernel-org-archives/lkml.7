Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD62C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6165220B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfEGIv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfEGIv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 230853082E51;
        Tue,  7 May 2019 08:51:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1F54123;
        Tue,  7 May 2019 08:51:54 +0000 (UTC)
Date:   Tue, 7 May 2019 10:51:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        xiezhipeng1@huawei.com
Subject: Re: [PATCH] fix use-after-free in perf_sched__lat
Message-ID: <20190507085153.GC17416@krava>
References: <20190503023555.24736-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503023555.24736-1-liwei391@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 07 May 2019 08:51:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:35:55AM +0800, Wei Li wrote:
> After thread is added to machine->threads[i].dead in
> __machine__remove_thread, the machine->threads[i].dead is freed
> when calling free(session) in perf_session__delete(). So it get a
> Segmentation fault when accessing it in thread__put().
> 
> In this patch, we delay the perf_session__delete until all threads
> have been deleted.
> 
> This can be reproduced by following steps:
> 	ulimit -c unlimited
> 	export MALLOC_MMAP_THRESHOLD_=0

what's this for?

> 	perf sched record sleep 10
> 	perf sched latency --sort max
> 	Segmentation fault (core dumped)
> 
> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/builtin-sched.c | 44 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index cbf39dab19c1..17849ae2eb1e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3130,11 +3130,48 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
>  static int perf_sched__lat(struct perf_sched *sched)
>  {
>  	struct rb_node *next;
> +	const struct perf_evsel_str_handler handlers[] = {
> +		{ "sched:sched_switch",	      process_sched_switch_event, },
> +		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
> +		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
> +		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
> +		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
> +	};
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.file      = {
> +			.path = input_name,
> +		},

I can't compile this:

builtin-sched.c: In function ‘perf_sched__lat’:
builtin-sched.c:3144:12: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
    .path = input_name,


> +		.mode      = PERF_DATA_MODE_READ,
> +		.force     = sched->force,
> +	};
> +	int rc = -1;
>  
>  	setup_pager();
>  
> -	if (perf_sched__read_events(sched))

so it's basically perf_sched__read_events code in here now, right?

might be better to add __perf_sched__read_events function
that would take session argument, something like:

        session = perf_session__new(&data, false, &sched->tool);
	...
	__perf_sched__read_events(sched, session)
	...
	perf_session__delete(session);

to avoid the code ducplication

thanks,
jirka

> +	session = perf_session__new(&data, false, &sched->tool);
> +	if (session == NULL) {
> +		pr_debug("No Memory for session\n");
>  		return -1;
> +	}
> +
> +	symbol__init(&session->header.env);
> +
> +	if (perf_session__set_tracepoints_handlers(session, handlers))
> +		goto out_delete;
> +
> +	if (perf_session__has_traces(session, "record -R")) {
> +		int err = perf_session__process_events(session);
> +
> +		if (err) {
> +			pr_err("Failed to process events, error %d", err);
> +			goto out_delete;
> +		}
> +
> +		sched->nr_events      = session->evlist->stats.nr_events[0];
> +		sched->nr_lost_events = session->evlist->stats.total_lost;
> +		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
> +	}
>  
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
> @@ -3163,7 +3200,10 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	print_bad_events(sched);
>  	printf("\n");
>  
> -	return 0;
> +	rc = 0;
> +out_delete:
> +	perf_session__delete(session);
> +	return rc;
>  }
>  
>  static int setup_map_cpus(struct perf_sched *sched)
> -- 
> 2.17.1
> 
