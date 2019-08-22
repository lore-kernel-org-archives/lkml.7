Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F29C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F552089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffZrK4ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfHVPS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:18:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37961 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbfHVPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:18:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so5484962qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIlK7/RNqH3LYFmTDy23WpoBQgwd5jDpaVZ42O+soU8=;
        b=ffZrK4ftakQO04vrzb2XXebXB3Fnm02e+zoEpv/z3mw+vmVhVmuz4rX6T9S1M114FK
         XOrOYBg1l1Kns2FNaS6TfFWcDZQndHRnLXZz2y73X7vjy4ATajGl3Kxq14ag8lA/LIh+
         ZwvNC2WXYllpzKDu2US/byTBXhpBnMoigWU9tvQP6QQjSK0xCPaDmooQRtltwUyE2Dq5
         xjkxl9/MMCfOrlHGenOdYLfxqrKIfEfrMsx6kSYP7ALV0rGS42wrOfXJhKdreFpcO8W7
         0PlqJr+Qx8aVv0dSCF8BtfVYoNTcO3Xyq+2UZglJEjn0xdSu3pzWkEtzyK/qkmy1GyIy
         GsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIlK7/RNqH3LYFmTDy23WpoBQgwd5jDpaVZ42O+soU8=;
        b=J4e8E44E5FXRuPnBXebtdCz6t2ZJtMHHVt1+Fp1BkQhmgxfr2J/pvp8nnBskDVGMvI
         futTXHSSTXzdePXHkcw5EU3XeyLRIvfve5rgTNFjdb0Ich1DFMPZySw0DM3YlOhEjpp4
         7ZKxwXyE4jLA/gf6FKkMbCrFKU2UKR6mBWhi6mj1W+HwH1Hh6WoQL3C0McmM+hNQTfml
         A7ECI+eCHeatRvE8drf0YBG4AjeNQf8pPZxkPkygqSvN/UyviAY0kcDIfo7RkE7BHdPZ
         39wgWzdINcic2Eo9Vp2hb7H7lzHIpRzc0fhy26/W+r8+rzXOLxqI+VWbNaCWAcHJP+Ky
         JTCw==
X-Gm-Message-State: APjAAAWW8KCSGH06u53TcLzuyjCgvdtuwQioYwaqoJSedvAccN6SkjDQ
        1i6coTo3YV/xVYdvAIazltU=
X-Google-Smtp-Source: APXvYqw7PYSijQqFpQYpI7o2uqGrR2q5e+Mnr1ozhdeDh2J4d4JVWai0QbF4iLDgVTfDNeixa8e7Yw==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr28796957qkg.193.1566487107507;
        Thu, 22 Aug 2019 08:18:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q9sm12194915qtj.48.2019.08.22.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 08:18:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6122440340; Thu, 22 Aug 2019 12:18:24 -0300 (-03)
Date:   Thu, 22 Aug 2019 12:18:24 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 5/5] libperf: Add
 perf_thread_map__nr/perf_thread_map__pid functions
Message-ID: <20190822151824.GB29569@kernel.org>
References: <20190822111141.25823-1-jolsa@kernel.org>
 <20190822111141.25823-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822111141.25823-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 01:11:41PM +0200, Jiri Olsa escreveu:
> So it's part of libperf library as basic functions
> over struct perf_thread_map object.

Thanks, applied and the other ones as well. I thought this one wasn't
applying but it was just a thinko on my part,

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-mjksprk4yct9ouez3j9mq2az@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-ftrace.c                          |  2 +-
>  tools/perf/builtin-script.c                          |  4 ++--
>  tools/perf/builtin-stat.c                            |  4 ++--
>  tools/perf/builtin-trace.c                           |  4 ++--
>  tools/perf/lib/include/perf/threadmap.h              |  2 ++
>  tools/perf/lib/libperf.map                           |  2 ++
>  tools/perf/lib/threadmap.c                           | 10 ++++++++++
>  tools/perf/tests/thread-map.c                        |  6 +++---
>  tools/perf/util/auxtrace.c                           |  4 ++--
>  tools/perf/util/event.c                              |  8 ++++----
>  tools/perf/util/evlist.c                             | 12 ++++++------
>  tools/perf/util/evsel.c                              |  4 ++--
>  .../perf/util/scripting-engines/trace-event-python.c |  2 +-
>  tools/perf/util/stat-display.c                       |  4 ++--
>  tools/perf/util/stat.c                               |  4 ++--
>  tools/perf/util/thread_map.c                         |  4 ++--
>  tools/perf/util/thread_map.h                         | 10 ----------
>  17 files changed, 45 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 1367bb5046a7..565db782c1b9 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -158,7 +158,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
>  	if (target__has_cpu(&ftrace->target))
>  		return 0;
>  
> -	for (i = 0; i < thread_map__nr(ftrace->evlist->core.threads); i++) {
> +	for (i = 0; i < perf_thread_map__nr(ftrace->evlist->core.threads); i++) {
>  		scnprintf(buf, sizeof(buf), "%d",
>  			  ftrace->evlist->core.threads->map[i]);
>  		if (append_tracing_file("set_ftrace_pid", buf) < 0)
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1764efd16cd4..5d45be1d3885 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1905,7 +1905,7 @@ static struct scripting_ops	*scripting_ops;
>  
>  static void __process_stat(struct evsel *counter, u64 tstamp)
>  {
> -	int nthreads = thread_map__nr(counter->core.threads);
> +	int nthreads = perf_thread_map__nr(counter->core.threads);
>  	int ncpus = perf_evsel__nr_cpus(counter);
>  	int cpu, thread;
>  	static int header_printed;
> @@ -1927,7 +1927,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>  
>  			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
>  				counter->core.cpus->map[cpu],
> -				thread_map__pid(counter->core.threads, thread),
> +				perf_thread_map__pid(counter->core.threads, thread),
>  				counts->val,
>  				counts->ena,
>  				counts->run,
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 90636a811b36..8a4f1a7d0cba 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -264,7 +264,7 @@ static int read_single_counter(struct evsel *counter, int cpu,
>   */
>  static int read_counter(struct evsel *counter, struct timespec *rs)
>  {
> -	int nthreads = thread_map__nr(evsel_list->core.threads);
> +	int nthreads = perf_thread_map__nr(evsel_list->core.threads);
>  	int ncpus, cpu, thread;
>  
>  	if (target__has_cpu(&target) && !target__has_per_thread(&target))
> @@ -1893,7 +1893,7 @@ int cmd_stat(int argc, const char **argv)
>  		thread_map__read_comms(evsel_list->core.threads);
>  		if (target.system_wide) {
>  			if (runtime_stat_new(&stat_config,
> -				thread_map__nr(evsel_list->core.threads))) {
> +				perf_thread_map__nr(evsel_list->core.threads))) {
>  				goto out;
>  			}
>  		}
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index bc44ed29e05a..de126258ca10 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3188,7 +3188,7 @@ static int trace__set_filter_pids(struct trace *trace)
>  			err = bpf_map__set_filter_pids(trace->filter_pids.map, trace->filter_pids.nr,
>  						       trace->filter_pids.entries);
>  		}
> -	} else if (thread_map__pid(trace->evlist->core.threads, 0) == -1) {
> +	} else if (perf_thread_map__pid(trace->evlist->core.threads, 0) == -1) {
>  		err = trace__set_filter_loop_pids(trace);
>  	}
>  
> @@ -3417,7 +3417,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		evlist__enable(evlist);
>  	}
>  
> -	trace->multiple_threads = thread_map__pid(evlist->core.threads, 0) == -1 ||
> +	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
>  				  evlist->core.threads->nr > 1 ||
>  				  perf_evlist__first(evlist)->core.attr.inherit;
>  
> diff --git a/tools/perf/lib/include/perf/threadmap.h b/tools/perf/lib/include/perf/threadmap.h
> index 456295273daa..a7c50de8d010 100644
> --- a/tools/perf/lib/include/perf/threadmap.h
> +++ b/tools/perf/lib/include/perf/threadmap.h
> @@ -11,6 +11,8 @@ LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
>  
>  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
>  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> +LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
> +LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
>  
>  LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
>  LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 3373dd51fcda..dc4d66363bc4 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -12,6 +12,8 @@ LIBPERF_0.0.1 {
>  		perf_thread_map__new_dummy;
>  		perf_thread_map__set_pid;
>  		perf_thread_map__comm;
> +		perf_thread_map__nr;
> +		perf_thread_map__pid;
>  		perf_thread_map__get;
>  		perf_thread_map__put;
>  		perf_evsel__new;
> diff --git a/tools/perf/lib/threadmap.c b/tools/perf/lib/threadmap.c
> index 4865b73e2586..e92c368b0a6c 100644
> --- a/tools/perf/lib/threadmap.c
> +++ b/tools/perf/lib/threadmap.c
> @@ -79,3 +79,13 @@ void perf_thread_map__put(struct perf_thread_map *map)
>  	if (map && refcount_dec_and_test(&map->refcnt))
>  		perf_thread_map__delete(map);
>  }
> +
> +int perf_thread_map__nr(struct perf_thread_map *threads)
> +{
> +	return threads ? threads->nr : 1;
> +}
> +
> +pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread)
> +{
> +	return map->map[thread].pid;
> +}
> diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
> index d61773cacf0b..d803eafedc60 100644
> --- a/tools/perf/tests/thread-map.c
> +++ b/tools/perf/tests/thread-map.c
> @@ -26,7 +26,7 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
>  
>  	TEST_ASSERT_VAL("wrong nr", map->nr == 1);
>  	TEST_ASSERT_VAL("wrong pid",
> -			thread_map__pid(map, 0) == getpid());
> +			perf_thread_map__pid(map, 0) == getpid());
>  	TEST_ASSERT_VAL("wrong comm",
>  			perf_thread_map__comm(map, 0) &&
>  			!strcmp(perf_thread_map__comm(map, 0), NAME));
> @@ -41,7 +41,7 @@ int test__thread_map(struct test *test __maybe_unused, int subtest __maybe_unuse
>  	thread_map__read_comms(map);
>  
>  	TEST_ASSERT_VAL("wrong nr", map->nr == 1);
> -	TEST_ASSERT_VAL("wrong pid", thread_map__pid(map, 0) == -1);
> +	TEST_ASSERT_VAL("wrong pid", perf_thread_map__pid(map, 0) == -1);
>  	TEST_ASSERT_VAL("wrong comm",
>  			perf_thread_map__comm(map, 0) &&
>  			!strcmp(perf_thread_map__comm(map, 0), "dummy"));
> @@ -68,7 +68,7 @@ static int process_event(struct perf_tool *tool __maybe_unused,
>  
>  	TEST_ASSERT_VAL("wrong nr", threads->nr == 1);
>  	TEST_ASSERT_VAL("wrong pid",
> -			thread_map__pid(threads, 0) == getpid());
> +			perf_thread_map__pid(threads, 0) == getpid());
>  	TEST_ASSERT_VAL("wrong comm",
>  			perf_thread_map__comm(threads, 0) &&
>  			!strcmp(perf_thread_map__comm(threads, 0), NAME));
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 60428576426e..094e6ceb3cf2 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -132,12 +132,12 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>  	if (per_cpu) {
>  		mp->cpu = evlist->core.cpus->map[idx];
>  		if (evlist->core.threads)
> -			mp->tid = thread_map__pid(evlist->core.threads, 0);
> +			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
>  		else
>  			mp->tid = -1;
>  	} else {
>  		mp->cpu = -1;
> -		mp->tid = thread_map__pid(evlist->core.threads, idx);
> +		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);
>  	}
>  }
>  
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index f433da85c45e..332edef8d394 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -647,7 +647,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  	for (thread = 0; thread < threads->nr; ++thread) {
>  		if (__event__synthesize_thread(comm_event, mmap_event,
>  					       fork_event, namespaces_event,
> -					       thread_map__pid(threads, thread), 0,
> +					       perf_thread_map__pid(threads, thread), 0,
>  					       process, tool, machine,
>  					       mmap_data)) {
>  			err = -1;
> @@ -658,12 +658,12 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>  		 * comm.pid is set to thread group id by
>  		 * perf_event__synthesize_comm
>  		 */
> -		if ((int) comm_event->comm.pid != thread_map__pid(threads, thread)) {
> +		if ((int) comm_event->comm.pid != perf_thread_map__pid(threads, thread)) {
>  			bool need_leader = true;
>  
>  			/* is thread group leader in thread_map? */
>  			for (j = 0; j < threads->nr; ++j) {
> -				if ((int) comm_event->comm.pid == thread_map__pid(threads, j)) {
> +				if ((int) comm_event->comm.pid == perf_thread_map__pid(threads, j)) {
>  					need_leader = false;
>  					break;
>  				}
> @@ -997,7 +997,7 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
>  		if (!comm)
>  			comm = (char *) "";
>  
> -		entry->pid = thread_map__pid(threads, i);
> +		entry->pid = perf_thread_map__pid(threads, i);
>  		strncpy((char *) &entry->comm, comm, sizeof(entry->comm));
>  	}
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8582560b59af..23b56717d260 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -314,7 +314,7 @@ static int perf_evlist__nr_threads(struct evlist *evlist,
>  	if (evsel->system_wide)
>  		return 1;
>  	else
> -		return thread_map__nr(evlist->core.threads);
> +		return perf_thread_map__nr(evlist->core.threads);
>  }
>  
>  void evlist__disable(struct evlist *evlist)
> @@ -397,7 +397,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
>  int perf_evlist__alloc_pollfd(struct evlist *evlist)
>  {
>  	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
> -	int nr_threads = thread_map__nr(evlist->core.threads);
> +	int nr_threads = perf_thread_map__nr(evlist->core.threads);
>  	int nfds = 0;
>  	struct evsel *evsel;
>  
> @@ -529,7 +529,7 @@ static void perf_evlist__set_sid_idx(struct evlist *evlist,
>  	else
>  		sid->cpu = -1;
>  	if (!evsel->system_wide && evlist->core.threads && thread >= 0)
> -		sid->tid = thread_map__pid(evlist->core.threads, thread);
> +		sid->tid = perf_thread_map__pid(evlist->core.threads, thread);
>  	else
>  		sid->tid = -1;
>  }
> @@ -694,7 +694,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
>  
>  	evlist->nr_mmaps = perf_cpu_map__nr(evlist->core.cpus);
>  	if (perf_cpu_map__empty(evlist->core.cpus))
> -		evlist->nr_mmaps = thread_map__nr(evlist->core.threads);
> +		evlist->nr_mmaps = perf_thread_map__nr(evlist->core.threads);
>  	map = zalloc(evlist->nr_mmaps * sizeof(struct perf_mmap));
>  	if (!map)
>  		return NULL;
> @@ -808,7 +808,7 @@ static int perf_evlist__mmap_per_cpu(struct evlist *evlist,
>  {
>  	int cpu, thread;
>  	int nr_cpus = perf_cpu_map__nr(evlist->core.cpus);
> -	int nr_threads = thread_map__nr(evlist->core.threads);
> +	int nr_threads = perf_thread_map__nr(evlist->core.threads);
>  
>  	pr_debug2("perf event ring buffer mmapped per cpu\n");
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
> @@ -836,7 +836,7 @@ static int perf_evlist__mmap_per_thread(struct evlist *evlist,
>  					struct mmap_params *mp)
>  {
>  	int thread;
> -	int nr_threads = thread_map__nr(evlist->core.threads);
> +	int nr_threads = perf_thread_map__nr(evlist->core.threads);
>  
>  	pr_debug2("perf event ring buffer mmapped per thread\n");
>  	for (thread = 0; thread < nr_threads; thread++) {
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 0a33f7322ecc..45328a788e9f 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1651,7 +1651,7 @@ static bool ignore_missing_thread(struct evsel *evsel,
>  				  struct perf_thread_map *threads,
>  				  int thread, int err)
>  {
> -	pid_t ignore_pid = thread_map__pid(threads, thread);
> +	pid_t ignore_pid = perf_thread_map__pid(threads, thread);
>  
>  	if (!evsel->ignore_missing_thread)
>  		return false;
> @@ -1814,7 +1814,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			int fd, group_fd;
>  
>  			if (!evsel->cgrp && !evsel->system_wide)
> -				pid = thread_map__pid(threads, thread);
> +				pid = perf_thread_map__pid(threads, thread);
>  
>  			group_fd = get_group_fd(evsel, cpu, thread);
>  retry_open:
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 32c17a727450..6801afaa84c4 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1405,7 +1405,7 @@ static void python_process_stat(struct perf_stat_config *config,
>  	for (thread = 0; thread < threads->nr; thread++) {
>  		for (cpu = 0; cpu < cpus->nr; cpu++) {
>  			process_stat(counter, cpus->map[cpu],
> -				     thread_map__pid(threads, thread), tstamp,
> +				     perf_thread_map__pid(threads, thread), tstamp,
>  				     perf_counts(counter->counts, cpu, thread));
>  		}
>  	}
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 3df0e39ccd52..74e0f5ad1456 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -118,7 +118,7 @@ static void aggr_printout(struct perf_stat_config *config,
>  			config->csv_output ? 0 : 16,
>  			perf_thread_map__comm(evsel->core.threads, id),
>  			config->csv_output ? 0 : -8,
> -			thread_map__pid(evsel->core.threads, id),
> +			perf_thread_map__pid(evsel->core.threads, id),
>  			config->csv_sep);
>  		break;
>  	case AGGR_GLOBAL:
> @@ -744,7 +744,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
>  			      struct evsel *counter, char *prefix)
>  {
>  	FILE *output = config->output;
> -	int nthreads = thread_map__nr(counter->core.threads);
> +	int nthreads = perf_thread_map__nr(counter->core.threads);
>  	int ncpus = perf_cpu_map__nr(counter->core.cpus);
>  	int thread, sorted_threads, id;
>  	struct perf_aggr_thread_value *buf;
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 2715112290cf..7342389bc8e1 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -158,7 +158,7 @@ static void perf_evsel__free_prev_raw_counts(struct evsel *evsel)
>  static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
>  {
>  	int ncpus = perf_evsel__nr_cpus(evsel);
> -	int nthreads = thread_map__nr(evsel->core.threads);
> +	int nthreads = perf_thread_map__nr(evsel->core.threads);
>  
>  	if (perf_evsel__alloc_stat_priv(evsel) < 0 ||
>  	    perf_evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
> @@ -308,7 +308,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>  static int process_counter_maps(struct perf_stat_config *config,
>  				struct evsel *counter)
>  {
> -	int nthreads = thread_map__nr(counter->core.threads);
> +	int nthreads = perf_thread_map__nr(counter->core.threads);
>  	int ncpus = perf_evsel__nr_cpus(counter);
>  	int cpu, thread;
>  
> diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
> index c58385ea05be..3e64525bf604 100644
> --- a/tools/perf/util/thread_map.c
> +++ b/tools/perf/util/thread_map.c
> @@ -310,7 +310,7 @@ size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp)
>  	size_t printed = fprintf(fp, "%d thread%s: ",
>  				 threads->nr, threads->nr > 1 ? "s" : "");
>  	for (i = 0; i < threads->nr; ++i)
> -		printed += fprintf(fp, "%s%d", i ? ", " : "", thread_map__pid(threads, i));
> +		printed += fprintf(fp, "%s%d", i ? ", " : "", perf_thread_map__pid(threads, i));
>  
>  	return printed + fprintf(fp, "\n");
>  }
> @@ -341,7 +341,7 @@ static int get_comm(char **comm, pid_t pid)
>  
>  static void comm_init(struct perf_thread_map *map, int i)
>  {
> -	pid_t pid = thread_map__pid(map, i);
> +	pid_t pid = perf_thread_map__pid(map, i);
>  	char *comm = NULL;
>  
>  	/* dummy pid comm initialization */
> diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
> index ba45c760be72..ca165fdf6cb0 100644
> --- a/tools/perf/util/thread_map.h
> +++ b/tools/perf/util/thread_map.h
> @@ -25,16 +25,6 @@ struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str);
>  
>  size_t thread_map__fprintf(struct perf_thread_map *threads, FILE *fp);
>  
> -static inline int thread_map__nr(struct perf_thread_map *threads)
> -{
> -	return threads ? threads->nr : 1;
> -}
> -
> -static inline pid_t thread_map__pid(struct perf_thread_map *map, int thread)
> -{
> -	return map->map[thread].pid;
> -}
> -
>  void thread_map__read_comms(struct perf_thread_map *threads);
>  bool thread_map__has(struct perf_thread_map *threads, pid_t pid);
>  int thread_map__remove(struct perf_thread_map *threads, int idx);
> -- 
> 2.21.0

-- 

- Arnaldo
