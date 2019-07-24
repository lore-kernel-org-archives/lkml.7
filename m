Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACAFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772E321911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8RajLrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfGXROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:14:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36362 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfGXROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:14:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so46275288qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wh/FHqiA9FnEenxEjvA4E20b7ji/t2LKlpB3AXmqKw8=;
        b=a8RajLrGz5vDfPlmdSK1teCp0Wnh9bcMm/Cqjc0yabTGbZCgWCBk7oc/hz7/B9VMa9
         BjOX1c9esB8thNjT7SzxUk2J2IuacQMr0D1LQUHJ+liOjKLUre4FkaIY4AvUxrSc09to
         0nWyBPmhdNAlrKNWQntoKbTqkuBxEoVqb2DuT/bqNShfh04Idj0uZP/Cxk3YU2l6FJL0
         CqPbTcEmk08dqqYDEqPEP1P3Th+S2h2XpbxmRbHxFV8neiaKuqq4QjWVWrpzJNL/nil4
         1cJwJolPncTIaTCoY/7bpafxbmS84c+wyHQsvGuI/LJUwlI+x8YFi9GdC+DG+DWtPskk
         uNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wh/FHqiA9FnEenxEjvA4E20b7ji/t2LKlpB3AXmqKw8=;
        b=tSbdWOkmF/IEjzdMw0FKqT0nzDb2CWrd0XNp/N93AXrRh8EJijIAbie7qYWY3mKc5c
         bUXZH5utNEVPlFoMUbvC6l6ipULSKyqonBhuW6oYQM2uvHSTu5Y/+uam+HsWoaV3yuIq
         ISi2HxR9bG91gUttuE0GoIUO/D2ku28aB9WT2F13vMFmZboMyE4YWIj3x2TOGq+BlBFP
         Hye4CILiIQekcn7FHkDcRunBMTg1C62c+SMlM/L01XF6GDKDjbRHvx/4O5cGH8l1tOet
         TgJmH00qnqO3MnrJsVUKVbKCncEGIVEICI84tlD8RgVJ+jUEBfFf6zeRWadguJH/vLHG
         Dftw==
X-Gm-Message-State: APjAAAVyaut/L4O9RYf/TGKNaCUgwrazfc1r9jqcStDyEcgIEALLEhD2
        nfpL5LUXYEaK6W72VNuYwc6jWk6n
X-Google-Smtp-Source: APXvYqxq2kffVZu8vJJTwrr1Pdoi+X6UDLSnzW7NBQCHk5pnWimrlFOhxvTqArSvkqeq8YGya3EpLA==
X-Received: by 2002:ac8:60a:: with SMTP id d10mr57061832qth.31.1563988471210;
        Wed, 24 Jul 2019 10:14:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c14sm18587361qko.84.2019.07.24.10.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:14:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 04AFA40340; Wed, 24 Jul 2019 14:14:27 -0300 (-03)
Date:   Wed, 24 Jul 2019 14:14:27 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 56/79] libperf: Add perf_evlist__set_maps function
Message-ID: <20190724171427.GF5727@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-57-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-57-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:43PM +0200, Jiri Olsa escreveu:
> Moving evlist__set_maps function under libperf.

Fixed up conflict due to the fix in the call order with
perf_evlist__init() in a previous patch, pushed out to acme/perf/core,
will continue later.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-y5d2tm0l5cw0q1ts301ukgtk@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c |  3 +-
>  tools/perf/builtin-script.c                  |  3 +-
>  tools/perf/builtin-stat.c                    |  3 +-
>  tools/perf/lib/evlist.c                      | 54 ++++++++++++++++++
>  tools/perf/lib/include/perf/evlist.h         |  6 ++
>  tools/perf/lib/libperf.map                   |  1 +
>  tools/perf/tests/code-reading.c              |  5 +-
>  tools/perf/tests/keep-tracking.c             |  3 +-
>  tools/perf/tests/mmap-basic.c                |  3 +-
>  tools/perf/tests/sw-clock.c                  |  3 +-
>  tools/perf/tests/switch-tracking.c           |  3 +-
>  tools/perf/tests/task-exit.c                 |  3 +-
>  tools/perf/util/evlist.c                     | 58 +-------------------
>  tools/perf/util/evlist.h                     |  2 -
>  14 files changed, 83 insertions(+), 67 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> index 261bdd680651..582182d98a7f 100644
> --- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> +++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include <sys/prctl.h>
>  #include <perf/cpumap.h>
> +#include <perf/evlist.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -72,7 +73,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  	evlist = evlist__new();
>  	CHECK_NOT_NULL__(evlist);
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	CHECK__(parse_events(evlist, "cycles:u", NULL));
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a787c5cb1331..46fadbbe1c3e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -48,6 +48,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <subcmd/pager.h>
> +#include <perf/evlist.h>
>  
>  #include <linux/ctype.h>
>  
> @@ -3264,7 +3265,7 @@ static int set_maps(struct perf_script *script)
>  	if (WARN_ONCE(script->allocated, "stats double allocation\n"))
>  		return -EINVAL;
>  
> -	perf_evlist__set_maps(evlist, script->cpus, script->threads);
> +	perf_evlist__set_maps(&evlist->core, script->cpus, script->threads);
>  
>  	if (perf_evlist__alloc_stats(evlist, true))
>  		return -ENOMEM;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4a94ca131d56..14e4c970d16a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -83,6 +83,7 @@
>  #include <sys/resource.h>
>  
>  #include <linux/ctype.h>
> +#include <perf/evlist.h>
>  
>  #define DEFAULT_SEPARATOR	" "
>  #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
> @@ -1517,7 +1518,7 @@ static int set_maps(struct perf_stat *st)
>  	if (WARN_ONCE(st->maps_allocated, "stats double allocation\n"))
>  		return -EINVAL;
>  
> -	perf_evlist__set_maps(evsel_list, st->cpus, st->threads);
> +	perf_evlist__set_maps(&evsel_list->core, st->cpus, st->threads);
>  
>  	if (perf_evlist__alloc_stats(evsel_list, true))
>  		return -ENOMEM;
> diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> index c14b535bd765..e01788092d8f 100644
> --- a/tools/perf/lib/evlist.c
> +++ b/tools/perf/lib/evlist.c
> @@ -5,6 +5,8 @@
>  #include <internal/evsel.h>
>  #include <linux/zalloc.h>
>  #include <stdlib.h>
> +#include <perf/cpumap.h>
> +#include <perf/threadmap.h>
>  
>  void perf_evlist__init(struct perf_evlist *evlist)
>  {
> @@ -12,11 +14,39 @@ void perf_evlist__init(struct perf_evlist *evlist)
>  	evlist->nr_entries = 0;
>  }
>  
> +static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> +					  struct perf_evsel *evsel)
> +{
> +	/*
> +	 * We already have cpus for evsel (via PMU sysfs) so
> +	 * keep it, if there's no target cpu list defined.
> +	 */
> +	if (!evsel->own_cpus || evlist->has_user_cpus) {
> +		perf_cpu_map__put(evsel->cpus);
> +		evsel->cpus = perf_cpu_map__get(evlist->cpus);
> +	} else if (evsel->cpus != evsel->own_cpus) {
> +		perf_cpu_map__put(evsel->cpus);
> +		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> +	}
> +
> +	perf_thread_map__put(evsel->threads);
> +	evsel->threads = perf_thread_map__get(evlist->threads);
> +}
> +
> +static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> +{
> +	struct perf_evsel *evsel;
> +
> +	perf_evlist__for_each_evsel(evlist, evsel)
> +		__perf_evlist__propagate_maps(evlist, evsel);
> +}
> +
>  void perf_evlist__add(struct perf_evlist *evlist,
>  		      struct perf_evsel *evsel)
>  {
>  	list_add_tail(&evsel->node, &evlist->entries);
>  	evlist->nr_entries += 1;
> +	__perf_evlist__propagate_maps(evlist, evsel);
>  }
>  
>  void perf_evlist__remove(struct perf_evlist *evlist,
> @@ -60,3 +90,27 @@ void perf_evlist__delete(struct perf_evlist *evlist)
>  {
>  	free(evlist);
>  }
> +
> +void perf_evlist__set_maps(struct perf_evlist *evlist,
> +			   struct perf_cpu_map *cpus,
> +			   struct perf_thread_map *threads)
> +{
> +	/*
> +	 * Allow for the possibility that one or another of the maps isn't being
> +	 * changed i.e. don't put it.  Note we are assuming the maps that are
> +	 * being applied are brand new and evlist is taking ownership of the
> +	 * original reference count of 1.  If that is not the case it is up to
> +	 * the caller to increase the reference count.
> +	 */
> +	if (cpus != evlist->cpus) {
> +		perf_cpu_map__put(evlist->cpus);
> +		evlist->cpus = perf_cpu_map__get(cpus);
> +	}
> +
> +	if (threads != evlist->threads) {
> +		perf_thread_map__put(evlist->threads);
> +		evlist->threads = perf_thread_map__get(threads);
> +	}
> +
> +	perf_evlist__propagate_maps(evlist);
> +}
> diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
> index 9a126fd0773c..b1d8dee018d6 100644
> --- a/tools/perf/lib/include/perf/evlist.h
> +++ b/tools/perf/lib/include/perf/evlist.h
> @@ -6,6 +6,8 @@
>  
>  struct perf_evlist;
>  struct perf_evsel;
> +struct perf_cpu_map;
> +struct perf_thread_map;
>  
>  LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
>  LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
> @@ -22,4 +24,8 @@ LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
>  	     (pos) != NULL;				\
>  	     (pos) = perf_evlist__next((evlist), (pos)))
>  
> +LIBPERF_API void perf_evlist__set_maps(struct perf_evlist *evlist,
> +				       struct perf_cpu_map *cpus,
> +				       struct perf_thread_map *threads);
> +
>  #endif /* __LIBPERF_EVLIST_H */
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 28ed04cbd223..9b6e8f165014 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -20,6 +20,7 @@ LIBPERF_0.0.1 {
>  		perf_evlist__add;
>  		perf_evlist__remove;
>  		perf_evlist__next;
> +		perf_evlist__set_maps;
>  	local:
>  		*;
>  };
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index bfaf22c2023c..e45df0736261 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -9,6 +9,7 @@
>  #include <string.h>
>  #include <sys/param.h>
>  #include <perf/cpumap.h>
> +#include <perf/evlist.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -629,7 +630,7 @@ static int do_test_code_reading(bool try_kcore)
>  			goto out_put;
>  		}
>  
> -		perf_evlist__set_maps(evlist, cpus, threads);
> +		perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  		str = do_determine_event(excl_kernel);
>  		pr_debug("Parsing event '%s'\n", str);
> @@ -658,7 +659,7 @@ static int do_test_code_reading(bool try_kcore)
>  				 */
>  				perf_cpu_map__get(cpus);
>  				perf_thread_map__get(threads);
> -				perf_evlist__set_maps(evlist, NULL, NULL);
> +				perf_evlist__set_maps(&evlist->core, NULL, NULL);
>  				evlist__delete(evlist);
>  				evlist = NULL;
>  				continue;
> diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> index 46478ba1ed16..0ce5ce33bac4 100644
> --- a/tools/perf/tests/keep-tracking.c
> +++ b/tools/perf/tests/keep-tracking.c
> @@ -3,6 +3,7 @@
>  #include <unistd.h>
>  #include <sys/prctl.h>
>  #include <perf/cpumap.h>
> +#include <perf/evlist.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -82,7 +83,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
>  	evlist = evlist__new();
>  	CHECK_NOT_NULL__(evlist);
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	CHECK__(parse_events(evlist, "dummy:u", NULL));
>  	CHECK__(parse_events(evlist, "cycles:u", NULL));
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index aa792aebd7f0..7327694fbde0 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -12,6 +12,7 @@
>  #include "tests.h"
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <perf/evlist.h>
>  
>  /*
>   * This test will generate random numbers of calls to some getpid syscalls,
> @@ -68,7 +69,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
>  		goto out_free_cpus;
>  	}
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	for (i = 0; i < nsyscalls; ++i) {
>  		char name[64];
> diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
> index 2decda2d4c17..c5f1a9f83380 100644
> --- a/tools/perf/tests/sw-clock.c
> +++ b/tools/perf/tests/sw-clock.c
> @@ -11,6 +11,7 @@
>  #include "util/evlist.h"
>  #include "util/cpumap.h"
>  #include "util/thread_map.h"
> +#include <perf/evlist.h>
>  
>  #define NR_LOOPS  10000000
>  
> @@ -64,7 +65,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
>  		goto out_free_maps;
>  	}
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	cpus	= NULL;
>  	threads = NULL;
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 9e0bbea15005..e3cee69f6ea2 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -6,6 +6,7 @@
>  #include <stdlib.h>
>  #include <linux/zalloc.h>
>  #include <perf/cpumap.h>
> +#include <perf/evlist.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -354,7 +355,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  		goto out_err;
>  	}
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	/* First event */
>  	err = parse_events(evlist, "cpu-clock:u", NULL);
> diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
> index b0192ea636a7..4ca38fd0379a 100644
> --- a/tools/perf/tests/task-exit.c
> +++ b/tools/perf/tests/task-exit.c
> @@ -7,6 +7,7 @@
>  
>  #include <errno.h>
>  #include <signal.h>
> +#include <perf/evlist.h>
>  
>  static int exited;
>  static int nr_exit;
> @@ -71,7 +72,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
>  		goto out_free_maps;
>  	}
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	cpus	= NULL;
>  	threads = NULL;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 53eb96d8355d..20e22596d4cf 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -50,7 +50,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  
>  	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
>  		INIT_HLIST_HEAD(&evlist->heads[i]);
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  	fdarray__init(&evlist->pollfd, 64);
>  	evlist->workload.pid = -1;
>  	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
> @@ -152,33 +152,6 @@ void evlist__delete(struct evlist *evlist)
>  	free(evlist);
>  }
>  
> -static void __perf_evlist__propagate_maps(struct evlist *evlist,
> -					  struct evsel *evsel)
> -{
> -	/*
> -	 * We already have cpus for evsel (via PMU sysfs) so
> -	 * keep it, if there's no target cpu list defined.
> -	 */
> -	if (!evsel->core.own_cpus || evlist->core.has_user_cpus) {
> -		perf_cpu_map__put(evsel->core.cpus);
> -		evsel->core.cpus = perf_cpu_map__get(evlist->core.cpus);
> -	} else if (evsel->core.cpus != evsel->core.own_cpus) {
> -		perf_cpu_map__put(evsel->core.cpus);
> -		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> -	}
> -
> -	perf_thread_map__put(evsel->core.threads);
> -	evsel->core.threads = perf_thread_map__get(evlist->core.threads);
> -}
> -
> -static void perf_evlist__propagate_maps(struct evlist *evlist)
> -{
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(evlist, evsel)
> -		__perf_evlist__propagate_maps(evlist, evsel);
> -}
> -
>  void evlist__add(struct evlist *evlist, struct evsel *entry)
>  {
>  	entry->evlist = evlist;
> @@ -189,8 +162,6 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
>  
>  	if (evlist->core.nr_entries == 1)
>  		perf_evlist__set_id_pos(evlist);
> -
> -	__perf_evlist__propagate_maps(evlist, entry);
>  }
>  
>  void evlist__remove(struct evlist *evlist, struct evsel *evsel)
> @@ -1097,7 +1068,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
>  
>  	evlist->core.has_user_cpus = !!target->cpu_list;
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  
>  	return 0;
>  
> @@ -1106,29 +1077,6 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
>  	return -1;
>  }
>  
> -void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
> -			   struct perf_thread_map *threads)
> -{
> -	/*
> -	 * Allow for the possibility that one or another of the maps isn't being
> -	 * changed i.e. don't put it.  Note we are assuming the maps that are
> -	 * being applied are brand new and evlist is taking ownership of the
> -	 * original reference count of 1.  If that is not the case it is up to
> -	 * the caller to increase the reference count.
> -	 */
> -	if (cpus != evlist->core.cpus) {
> -		perf_cpu_map__put(evlist->core.cpus);
> -		evlist->core.cpus = perf_cpu_map__get(cpus);
> -	}
> -
> -	if (threads != evlist->core.threads) {
> -		perf_thread_map__put(evlist->core.threads);
> -		evlist->core.threads = perf_thread_map__get(threads);
> -	}
> -
> -	perf_evlist__propagate_maps(evlist);
> -}
> -
>  void __perf_evlist__set_sample_bit(struct evlist *evlist,
>  				   enum perf_event_sample_format bit)
>  {
> @@ -1381,7 +1329,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
>  	if (!threads)
>  		goto out_put;
>  
> -	perf_evlist__set_maps(evlist, cpus, threads);
> +	perf_evlist__set_maps(&evlist->core, cpus, threads);
>  out:
>  	return err;
>  out_put:
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index de2025d198d4..e31ddcc058f2 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -191,8 +191,6 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
>  void perf_evlist__set_selected(struct evlist *evlist,
>  			       struct evsel *evsel);
>  
> -void perf_evlist__set_maps(struct evlist *evlist, struct perf_cpu_map *cpus,
> -			   struct perf_thread_map *threads);
>  int perf_evlist__create_maps(struct evlist *evlist, struct target *target);
>  int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
>  
> -- 
> 2.21.0

-- 

- Arnaldo
