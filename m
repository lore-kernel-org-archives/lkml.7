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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9E2C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A489B21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw2+ekWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfGXPdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:33:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42643 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfGXPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:33:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so34039260qkm.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9UncsUlyXdvUGlnwas+78I8uXVhZm+yDP7uPaQ6UY8=;
        b=cw2+ekWADBfXFXZEFbhYVc8LE8faqplCwK4kzGZaupB4C5KwJGVV+xJdAywi/eEGXf
         2KxrezXQIV2kwLkNc7g8mXdPICpEaNsX9k0BbeRFNep/CafQYjk4jjTDcF+UJIqvBJoI
         C4+4H6m1wI0w5h+pGsxewoXm7VDa5F1A4fs3/wJP3Zb0TveDYyczgITikz+503SFhso7
         rRtRDvG/QF0nZx5SOmdLPqT9yduRkav/FgejEkQmW3z+U0i4JhHo7R8inQc8YEdnc+nb
         WdvdeXcglBRHMLtH0Pv8tkoLe1DFepEBP2pdVg7CE04B0WQx1KBYrE12W39XGn2lSnqb
         LNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9UncsUlyXdvUGlnwas+78I8uXVhZm+yDP7uPaQ6UY8=;
        b=k8dyEeQHI/pYGIB22t/14CNKNBnvmEg3OF/sN6Li5vKm9+F6up8RwubE/KO4m9sTq0
         0TBFVGuiOpV6IfbRJB9zZc75YwD71mo75Xre3JUwTBJRoetABkgrHYZg7conW8jk91WN
         RfPBYfhQt8FrelrIIFtPAfHk157Ecqwj2DZsWp5UUKU29xG0KbtV/16mgn/aXisa34xd
         KbrHS2xXVitfS+oaKsKTPvqAIv1XIpeqARZHa93DIIDRZVDG4YB0iifaSUNm1I+Flk5x
         3t815lKgu//FUM89ZcLKOPZFVu5IYddTuCMooMlD2/6pHIAdp6+l55AgWUQF7IDgv8DM
         RbSQ==
X-Gm-Message-State: APjAAAV0Yz1Xc5QFz4S7srT+aNAFvYOUvEO0Zm+XY/2pVRBC1qtDuUNn
        i8+252qL8jVubDdy7Dp+Ka8=
X-Google-Smtp-Source: APXvYqy9NxLx4fQyWkEbWP6idZFxoLKTykzrJHYiI+HIYDOXfJ+dy+Frtdq4Y290o6ILM3fbsez76g==
X-Received: by 2002:a37:5fc6:: with SMTP id t189mr53789893qkb.483.1563982378231;
        Wed, 24 Jul 2019 08:32:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i17sm19627000qkl.71.2019.07.24.08.32.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:32:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DF5440340; Wed, 24 Jul 2019 12:32:55 -0300 (-03)
Date:   Wed, 24 Jul 2019 12:32:55 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 43/79] libperf: Add perf_cpu_map__new/perf_cpu_map__read
 functions
Message-ID: <20190724153255.GC5727@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-44-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-44-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:30PM +0200, Jiri Olsa escreveu:
> Moving following functions:
>   cpu_map__new
>   cpu_map__read
> 
> under libperf with following names:
>   perf_cpu_map__new
>   perf_cpu_map__read

Fixed up this one:

  tools/perf/arch/arm/util/cs-etm.c
 
> Link: http://lkml.kernel.org/n/tip-0qht8kirnnrewttpwvh1ntz6@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/arch/x86/tests/perf-time-to-tsc.c |   3 +-
>  tools/perf/bench/epoll-ctl.c                 |   3 +-
>  tools/perf/bench/epoll-wait.c                |   3 +-
>  tools/perf/bench/futex-hash.c                |   3 +-
>  tools/perf/bench/futex-lock-pi.c             |   3 +-
>  tools/perf/bench/futex-requeue.c             |   3 +-
>  tools/perf/bench/futex-wake-parallel.c       |   2 +-
>  tools/perf/bench/futex-wake.c                |   3 +-
>  tools/perf/builtin-ftrace.c                  |   2 +-
>  tools/perf/builtin-sched.c                   |   4 +-
>  tools/perf/lib/cpumap.c                      | 184 +++++++++++++++++++
>  tools/perf/lib/include/internal/cpumap.h     |   4 +
>  tools/perf/lib/include/perf/cpumap.h         |   3 +
>  tools/perf/lib/libperf.map                   |   2 +
>  tools/perf/tests/bitmap.c                    |   3 +-
>  tools/perf/tests/code-reading.c              |   5 +-
>  tools/perf/tests/cpumap.c                    |   7 +-
>  tools/perf/tests/event-times.c               |   9 +-
>  tools/perf/tests/event_update.c              |   3 +-
>  tools/perf/tests/keep-tracking.c             |   3 +-
>  tools/perf/tests/mem2node.c                  |   3 +-
>  tools/perf/tests/mmap-basic.c                |   3 +-
>  tools/perf/tests/openat-syscall-all-cpus.c   |   2 +-
>  tools/perf/tests/switch-tracking.c           |   5 +-
>  tools/perf/tests/topology.c                  |   3 +-
>  tools/perf/util/cpumap.c                     | 181 +-----------------
>  tools/perf/util/cpumap.h                     |   2 -
>  tools/perf/util/cputopo.c                    |   5 +-
>  tools/perf/util/evlist.c                     |   5 +-
>  tools/perf/util/header.c                     |   3 +-
>  tools/perf/util/parse-events.c               |   3 +-
>  tools/perf/util/pmu.c                        |   3 +-
>  tools/perf/util/python.c                     |   3 +-
>  tools/perf/util/record.c                     |   7 +-
>  tools/perf/util/session.c                    |   3 +-
>  tools/perf/util/svghelper.c                  |   3 +-
>  36 files changed, 262 insertions(+), 224 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> index 07129e007eb0..261bdd680651 100644
> --- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> +++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
> @@ -5,6 +5,7 @@
>  #include <unistd.h>
>  #include <linux/types.h>
>  #include <sys/prctl.h>
> +#include <perf/cpumap.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -65,7 +66,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	CHECK_NOT_NULL__(cpus);
>  
>  	evlist = evlist__new();
> diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
> index 1fd724f1d48b..84658d45f349 100644
> --- a/tools/perf/bench/epoll-ctl.c
> +++ b/tools/perf/bench/epoll-ctl.c
> @@ -20,6 +20,7 @@
>  #include <sys/resource.h>
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
> +#include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
>  #include <subcmd/parse-options.h>
> @@ -315,7 +316,7 @@ int bench_epoll_ctl(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
> index 79a254fff2d1..c27a65639cfb 100644
> --- a/tools/perf/bench/epoll-wait.c
> +++ b/tools/perf/bench/epoll-wait.c
> @@ -75,6 +75,7 @@
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
>  #include <sys/types.h>
> +#include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
>  #include <subcmd/parse-options.h>
> @@ -429,7 +430,7 @@ int bench_epoll_wait(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
> index b4fea8e3a368..80e138904c66 100644
> --- a/tools/perf/bench/futex-hash.c
> +++ b/tools/perf/bench/futex-hash.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <sys/time.h>
> +#include <perf/cpumap.h>
>  
>  #include "../util/stat.h"
>  #include <subcmd/parse-options.h>
> @@ -132,7 +133,7 @@ int bench_futex_hash(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		goto errmem;
>  
> diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
> index 596769924709..c5d6d0abbaa9 100644
> --- a/tools/perf/bench/futex-lock-pi.c
> +++ b/tools/perf/bench/futex-lock-pi.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <errno.h>
> +#include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
>  #include "cpumap.h"
> @@ -156,7 +157,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
>  	if (argc)
>  		goto err;
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
> index 1fd32a4f9c14..75d3418c1a88 100644
> --- a/tools/perf/bench/futex-requeue.c
> +++ b/tools/perf/bench/futex-requeue.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
>  #include <errno.h>
> +#include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
>  #include "cpumap.h"
> @@ -123,7 +124,7 @@ int bench_futex_requeue(int argc, const char **argv)
>  	if (argc)
>  		goto err;
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		err(EXIT_FAILURE, "cpu_map__new");
>  
> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> index 884c73e5bd1b..163fe16c275a 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -237,7 +237,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
>  	act.sa_sigaction = toggle_done;
>  	sigaction(SIGINT, &act, NULL);
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
> index 2288fa8412ff..77dcdc13618a 100644
> --- a/tools/perf/bench/futex-wake.c
> +++ b/tools/perf/bench/futex-wake.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
>  #include <errno.h>
> +#include <perf/cpumap.h>
>  #include "bench.h"
>  #include "futex.h"
>  #include "cpumap.h"
> @@ -131,7 +132,7 @@ int bench_futex_wake(int argc, const char **argv)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	cpu = cpu_map__new(NULL);
> +	cpu = perf_cpu_map__new(NULL);
>  	if (!cpu)
>  		err(EXIT_FAILURE, "calloc");
>  
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6943352b8d94..77989254fdd8 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -202,7 +202,7 @@ static int set_tracing_cpu(struct perf_ftrace *ftrace)
>  
>  static int reset_tracing_cpu(void)
>  {
> -	struct perf_cpu_map *cpumap = cpu_map__new(NULL);
> +	struct perf_cpu_map *cpumap = perf_cpu_map__new(NULL);
>  	int ret;
>  
>  	ret = set_tracing_cpumask(cpumap);
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 897d11c8ca2e..0d6b4c3b1a51 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3183,7 +3183,7 @@ static int setup_map_cpus(struct perf_sched *sched)
>  	if (!sched->map.cpus_str)
>  		return 0;
>  
> -	map = cpu_map__new(sched->map.cpus_str);
> +	map = perf_cpu_map__new(sched->map.cpus_str);
>  	if (!map) {
>  		pr_err("failed to get cpus map from %s\n", sched->map.cpus_str);
>  		return -1;
> @@ -3217,7 +3217,7 @@ static int setup_color_cpus(struct perf_sched *sched)
>  	if (!sched->map.color_cpus_str)
>  		return 0;
>  
> -	map = cpu_map__new(sched->map.color_cpus_str);
> +	map = perf_cpu_map__new(sched->map.color_cpus_str);
>  	if (!map) {
>  		pr_err("failed to get thread map from %s\n", sched->map.color_cpus_str);
>  		return -1;
> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index f3cfb4c71106..a5d4f7ff7174 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -5,6 +5,10 @@
>  #include <internal/cpumap.h>
>  #include <asm/bug.h>
>  #include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +#include <limits.h>
>  
>  struct perf_cpu_map *perf_cpu_map__dummy_new(void)
>  {
> @@ -40,3 +44,183 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
>  	if (map && refcount_dec_and_test(&map->refcnt))
>  		cpu_map__delete(map);
>  }
> +
> +static struct perf_cpu_map *cpu_map__default_new(void)
> +{
> +	struct perf_cpu_map *cpus;
> +	int nr_cpus;
> +
> +	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (nr_cpus < 0)
> +		return NULL;
> +
> +	cpus = malloc(sizeof(*cpus) + nr_cpus * sizeof(int));
> +	if (cpus != NULL) {
> +		int i;
> +
> +		for (i = 0; i < nr_cpus; ++i)
> +			cpus->map[i] = i;
> +
> +		cpus->nr = nr_cpus;
> +		refcount_set(&cpus->refcnt, 1);
> +	}
> +
> +	return cpus;
> +}
> +
> +static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
> +{
> +	size_t payload_size = nr_cpus * sizeof(int);
> +	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
> +
> +	if (cpus != NULL) {
> +		cpus->nr = nr_cpus;
> +		memcpy(cpus->map, tmp_cpus, payload_size);
> +		refcount_set(&cpus->refcnt, 1);
> +	}
> +
> +	return cpus;
> +}
> +
> +struct perf_cpu_map *perf_cpu_map__read(FILE *file)
> +{
> +	struct perf_cpu_map *cpus = NULL;
> +	int nr_cpus = 0;
> +	int *tmp_cpus = NULL, *tmp;
> +	int max_entries = 0;
> +	int n, cpu, prev;
> +	char sep;
> +
> +	sep = 0;
> +	prev = -1;
> +	for (;;) {
> +		n = fscanf(file, "%u%c", &cpu, &sep);
> +		if (n <= 0)
> +			break;
> +		if (prev >= 0) {
> +			int new_max = nr_cpus + cpu - prev - 1;
> +
> +			if (new_max >= max_entries) {
> +				max_entries = new_max + MAX_NR_CPUS / 2;
> +				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> +				if (tmp == NULL)
> +					goto out_free_tmp;
> +				tmp_cpus = tmp;
> +			}
> +
> +			while (++prev < cpu)
> +				tmp_cpus[nr_cpus++] = prev;
> +		}
> +		if (nr_cpus == max_entries) {
> +			max_entries += MAX_NR_CPUS;
> +			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> +			if (tmp == NULL)
> +				goto out_free_tmp;
> +			tmp_cpus = tmp;
> +		}
> +
> +		tmp_cpus[nr_cpus++] = cpu;
> +		if (n == 2 && sep == '-')
> +			prev = cpu;
> +		else
> +			prev = -1;
> +		if (n == 1 || sep == '\n')
> +			break;
> +	}
> +
> +	if (nr_cpus > 0)
> +		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> +	else
> +		cpus = cpu_map__default_new();
> +out_free_tmp:
> +	free(tmp_cpus);
> +	return cpus;
> +}
> +
> +static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
> +{
> +	struct perf_cpu_map *cpus = NULL;
> +	FILE *onlnf;
> +
> +	onlnf = fopen("/sys/devices/system/cpu/online", "r");
> +	if (!onlnf)
> +		return cpu_map__default_new();
> +
> +	cpus = perf_cpu_map__read(onlnf);
> +	fclose(onlnf);
> +	return cpus;
> +}
> +
> +struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
> +{
> +	struct perf_cpu_map *cpus = NULL;
> +	unsigned long start_cpu, end_cpu = 0;
> +	char *p = NULL;
> +	int i, nr_cpus = 0;
> +	int *tmp_cpus = NULL, *tmp;
> +	int max_entries = 0;
> +
> +	if (!cpu_list)
> +		return cpu_map__read_all_cpu_map();
> +
> +	/*
> +	 * must handle the case of empty cpumap to cover
> +	 * TOPOLOGY header for NUMA nodes with no CPU
> +	 * ( e.g., because of CPU hotplug)
> +	 */
> +	if (!isdigit(*cpu_list) && *cpu_list != '\0')
> +		goto out;
> +
> +	while (isdigit(*cpu_list)) {
> +		p = NULL;
> +		start_cpu = strtoul(cpu_list, &p, 0);
> +		if (start_cpu >= INT_MAX
> +		    || (*p != '\0' && *p != ',' && *p != '-'))
> +			goto invalid;
> +
> +		if (*p == '-') {
> +			cpu_list = ++p;
> +			p = NULL;
> +			end_cpu = strtoul(cpu_list, &p, 0);
> +
> +			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
> +				goto invalid;
> +
> +			if (end_cpu < start_cpu)
> +				goto invalid;
> +		} else {
> +			end_cpu = start_cpu;
> +		}
> +
> +		for (; start_cpu <= end_cpu; start_cpu++) {
> +			/* check for duplicates */
> +			for (i = 0; i < nr_cpus; i++)
> +				if (tmp_cpus[i] == (int)start_cpu)
> +					goto invalid;
> +
> +			if (nr_cpus == max_entries) {
> +				max_entries += MAX_NR_CPUS;
> +				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> +				if (tmp == NULL)
> +					goto invalid;
> +				tmp_cpus = tmp;
> +			}
> +			tmp_cpus[nr_cpus++] = (int)start_cpu;
> +		}
> +		if (*p)
> +			++p;
> +
> +		cpu_list = p;
> +	}
> +
> +	if (nr_cpus > 0)
> +		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> +	else if (*cpu_list != '\0')
> +		cpus = cpu_map__default_new();
> +	else
> +		cpus = perf_cpu_map__dummy_new();
> +invalid:
> +	free(tmp_cpus);
> +out:
> +	return cpus;
> +}
> diff --git a/tools/perf/lib/include/internal/cpumap.h b/tools/perf/lib/include/internal/cpumap.h
> index 53ce95374b05..3306319f7df8 100644
> --- a/tools/perf/lib/include/internal/cpumap.h
> +++ b/tools/perf/lib/include/internal/cpumap.h
> @@ -10,4 +10,8 @@ struct perf_cpu_map {
>  	int		map[];
>  };
>  
> +#ifndef MAX_NR_CPUS
> +#define MAX_NR_CPUS	2048
> +#endif
> +
>  #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
> diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
> index e16c2515a499..b4a9283a5dfa 100644
> --- a/tools/perf/lib/include/perf/cpumap.h
> +++ b/tools/perf/lib/include/perf/cpumap.h
> @@ -3,10 +3,13 @@
>  #define __LIBPERF_CPUMAP_H
>  
>  #include <perf/core.h>
> +#include <stdio.h>
>  
>  struct perf_cpu_map;
>  
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
> +LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
> +LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
>  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
>  LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
>  
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 168339f89a2e..e38473a8f32f 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -4,6 +4,8 @@ LIBPERF_0.0.1 {
>  		perf_cpu_map__dummy_new;
>  		perf_cpu_map__get;
>  		perf_cpu_map__put;
> +		perf_cpu_map__new;
> +		perf_cpu_map__read;
>  		perf_thread_map__new_dummy;
>  		perf_thread_map__set_pid;
>  		perf_thread_map__comm;
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 95304d29092e..db2aadff3708 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/compiler.h>
>  #include <linux/bitmap.h>
> +#include <perf/cpumap.h>
>  #include "tests.h"
>  #include "cpumap.h"
>  #include "debug.h"
> @@ -9,7 +10,7 @@
>  
>  static unsigned long *get_bitmap(const char *str, int nbits)
>  {
> -	struct perf_cpu_map *map = cpu_map__new(str);
> +	struct perf_cpu_map *map = perf_cpu_map__new(str);
>  	unsigned long *bm = NULL;
>  	int i;
>  
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 131bbeec62d2..bfaf22c2023c 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -8,6 +8,7 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <sys/param.h>
> +#include <perf/cpumap.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -613,9 +614,9 @@ static int do_test_code_reading(bool try_kcore)
>  		goto out_put;
>  	}
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (!cpus) {
> -		pr_debug("cpu_map__new failed\n");
> +		pr_debug("perf_cpu_map__new failed\n");
>  		goto out_put;
>  	}
>  
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 6c921087b0fe..b71fe09a8087 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -5,6 +5,7 @@
>  #include "event.h"
>  #include <string.h>
>  #include <linux/bitops.h>
> +#include <perf/cpumap.h>
>  #include "debug.h"
>  
>  struct machine;
> @@ -78,7 +79,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
>  	struct perf_cpu_map *cpus;
>  
>  	/* This one is better stores in mask. */
> -	cpus = cpu_map__new("0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19");
> +	cpus = perf_cpu_map__new("0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19");
>  
>  	TEST_ASSERT_VAL("failed to synthesize map",
>  		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_mask, NULL));
> @@ -86,7 +87,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
>  	perf_cpu_map__put(cpus);
>  
>  	/* This one is better stores in cpu values. */
> -	cpus = cpu_map__new("1,256");
> +	cpus = perf_cpu_map__new("1,256");
>  
>  	TEST_ASSERT_VAL("failed to synthesize map",
>  		!perf_event__synthesize_cpu_map(NULL, cpus, process_event_cpus, NULL));
> @@ -97,7 +98,7 @@ int test__cpu_map_synthesize(struct test *test __maybe_unused, int subtest __may
>  
>  static int cpu_map_print(const char *str)
>  {
> -	struct perf_cpu_map *map = cpu_map__new(str);
> +	struct perf_cpu_map *map = perf_cpu_map__new(str);
>  	char buf[100];
>  
>  	if (!map)
> diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
> index 165534f62036..00adba86403b 100644
> --- a/tools/perf/tests/event-times.c
> +++ b/tools/perf/tests/event-times.c
> @@ -4,6 +4,7 @@
>  #include <inttypes.h>
>  #include <string.h>
>  #include <sys/wait.h>
> +#include <perf/cpumap.h>
>  #include "tests.h"
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -115,9 +116,9 @@ static int attach__cpu_disabled(struct evlist *evlist)
>  
>  	pr_debug("attaching to CPU 0 as enabled\n");
>  
> -	cpus = cpu_map__new("0");
> +	cpus = perf_cpu_map__new("0");
>  	if (cpus == NULL) {
> -		pr_debug("failed to call cpu_map__new\n");
> +		pr_debug("failed to call perf_cpu_map__new\n");
>  		return -1;
>  	}
>  
> @@ -144,9 +145,9 @@ static int attach__cpu_enabled(struct evlist *evlist)
>  
>  	pr_debug("attaching to CPU 0 as enabled\n");
>  
> -	cpus = cpu_map__new("0");
> +	cpus = perf_cpu_map__new("0");
>  	if (cpus == NULL) {
> -		pr_debug("failed to call cpu_map__new\n");
> +		pr_debug("failed to call perf_cpu_map__new\n");
>  		return -1;
>  	}
>  
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index 415d12e96834..2bc5145284c0 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/compiler.h>
> +#include <perf/cpumap.h>
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "machine.h"
> @@ -108,7 +109,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>  	TEST_ASSERT_VAL("failed to synthesize attr update name",
>  			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
>  
> -	evsel->own_cpus = cpu_map__new("1,2,3");
> +	evsel->own_cpus = perf_cpu_map__new("1,2,3");
>  
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
>  			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
> diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
> index 4fc7b3b4e153..46478ba1ed16 100644
> --- a/tools/perf/tests/keep-tracking.c
> +++ b/tools/perf/tests/keep-tracking.c
> @@ -2,6 +2,7 @@
>  #include <linux/types.h>
>  #include <unistd.h>
>  #include <sys/prctl.h>
> +#include <perf/cpumap.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -75,7 +76,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	CHECK_NOT_NULL__(cpus);
>  
>  	evlist = evlist__new();
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index 6fe2c1e7918b..5ec193f7968d 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -2,6 +2,7 @@
>  #include <linux/compiler.h>
>  #include <linux/bitmap.h>
>  #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>  #include "cpumap.h"
>  #include "mem2node.h"
>  #include "tests.h"
> @@ -19,7 +20,7 @@ static struct node {
>  
>  static unsigned long *get_bitmap(const char *str, int nbits)
>  {
> -	struct perf_cpu_map *map = cpu_map__new(str);
> +	struct perf_cpu_map *map = perf_cpu_map__new(str);
>  	unsigned long *bm = NULL;
>  	int i;
>  
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 9d8eb43b12cb..aa792aebd7f0 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -3,6 +3,7 @@
>  #include <inttypes.h>
>  /* For the CLR_() macros */
>  #include <pthread.h>
> +#include <perf/cpumap.h>
>  
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -46,7 +47,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
>  		return -1;
>  	}
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (cpus == NULL) {
>  		pr_debug("cpu_map__new\n");
>  		goto out_free_threads;
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index 674b0fa035ec..d161b1a78703 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -33,7 +33,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
>  		return -1;
>  	}
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (cpus == NULL) {
>  		pr_debug("cpu_map__new\n");
>  		goto out_thread_map_delete;
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index dd07acced4af..9e0bbea15005 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -5,6 +5,7 @@
>  #include <time.h>
>  #include <stdlib.h>
>  #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>  
>  #include "parse-events.h"
>  #include "evlist.h"
> @@ -341,9 +342,9 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>  		goto out_err;
>  	}
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (!cpus) {
> -		pr_debug("cpu_map__new failed!\n");
> +		pr_debug("perf_cpu_map__new failed!\n");
>  		goto out_err;
>  	}
>  
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 1b57ded58d59..a4f9f5182b47 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -2,6 +2,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <perf/cpumap.h>
>  #include "tests.h"
>  #include "util.h"
>  #include "session.h"
> @@ -126,7 +127,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
>  	if (session_write_header(path))
>  		goto free_path;
>  
> -	map = cpu_map__new(NULL);
> +	map = perf_cpu_map__new(NULL);
>  	if (map == NULL) {
>  		pr_debug("failed to get system cpumap\n");
>  		goto free_path;
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 44082e5eabde..71d4d7b35a57 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -17,185 +17,6 @@ static int max_present_cpu_num;
>  static int max_node_num;
>  static int *cpunode_map;
>  
> -static struct perf_cpu_map *cpu_map__default_new(void)
> -{
> -	struct perf_cpu_map *cpus;
> -	int nr_cpus;
> -
> -	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> -	if (nr_cpus < 0)
> -		return NULL;
> -
> -	cpus = malloc(sizeof(*cpus) + nr_cpus * sizeof(int));
> -	if (cpus != NULL) {
> -		int i;
> -		for (i = 0; i < nr_cpus; ++i)
> -			cpus->map[i] = i;
> -
> -		cpus->nr = nr_cpus;
> -		refcount_set(&cpus->refcnt, 1);
> -	}
> -
> -	return cpus;
> -}
> -
> -static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
> -{
> -	size_t payload_size = nr_cpus * sizeof(int);
> -	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
> -
> -	if (cpus != NULL) {
> -		cpus->nr = nr_cpus;
> -		memcpy(cpus->map, tmp_cpus, payload_size);
> -		refcount_set(&cpus->refcnt, 1);
> -	}
> -
> -	return cpus;
> -}
> -
> -struct perf_cpu_map *cpu_map__read(FILE *file)
> -{
> -	struct perf_cpu_map *cpus = NULL;
> -	int nr_cpus = 0;
> -	int *tmp_cpus = NULL, *tmp;
> -	int max_entries = 0;
> -	int n, cpu, prev;
> -	char sep;
> -
> -	sep = 0;
> -	prev = -1;
> -	for (;;) {
> -		n = fscanf(file, "%u%c", &cpu, &sep);
> -		if (n <= 0)
> -			break;
> -		if (prev >= 0) {
> -			int new_max = nr_cpus + cpu - prev - 1;
> -
> -			if (new_max >= max_entries) {
> -				max_entries = new_max + MAX_NR_CPUS / 2;
> -				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> -				if (tmp == NULL)
> -					goto out_free_tmp;
> -				tmp_cpus = tmp;
> -			}
> -
> -			while (++prev < cpu)
> -				tmp_cpus[nr_cpus++] = prev;
> -		}
> -		if (nr_cpus == max_entries) {
> -			max_entries += MAX_NR_CPUS;
> -			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> -			if (tmp == NULL)
> -				goto out_free_tmp;
> -			tmp_cpus = tmp;
> -		}
> -
> -		tmp_cpus[nr_cpus++] = cpu;
> -		if (n == 2 && sep == '-')
> -			prev = cpu;
> -		else
> -			prev = -1;
> -		if (n == 1 || sep == '\n')
> -			break;
> -	}
> -
> -	if (nr_cpus > 0)
> -		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> -	else
> -		cpus = cpu_map__default_new();
> -out_free_tmp:
> -	free(tmp_cpus);
> -	return cpus;
> -}
> -
> -static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
> -{
> -	struct perf_cpu_map *cpus = NULL;
> -	FILE *onlnf;
> -
> -	onlnf = fopen("/sys/devices/system/cpu/online", "r");
> -	if (!onlnf)
> -		return cpu_map__default_new();
> -
> -	cpus = cpu_map__read(onlnf);
> -	fclose(onlnf);
> -	return cpus;
> -}
> -
> -struct perf_cpu_map *cpu_map__new(const char *cpu_list)
> -{
> -	struct perf_cpu_map *cpus = NULL;
> -	unsigned long start_cpu, end_cpu = 0;
> -	char *p = NULL;
> -	int i, nr_cpus = 0;
> -	int *tmp_cpus = NULL, *tmp;
> -	int max_entries = 0;
> -
> -	if (!cpu_list)
> -		return cpu_map__read_all_cpu_map();
> -
> -	/*
> -	 * must handle the case of empty cpumap to cover
> -	 * TOPOLOGY header for NUMA nodes with no CPU
> -	 * ( e.g., because of CPU hotplug)
> -	 */
> -	if (!isdigit(*cpu_list) && *cpu_list != '\0')
> -		goto out;
> -
> -	while (isdigit(*cpu_list)) {
> -		p = NULL;
> -		start_cpu = strtoul(cpu_list, &p, 0);
> -		if (start_cpu >= INT_MAX
> -		    || (*p != '\0' && *p != ',' && *p != '-'))
> -			goto invalid;
> -
> -		if (*p == '-') {
> -			cpu_list = ++p;
> -			p = NULL;
> -			end_cpu = strtoul(cpu_list, &p, 0);
> -
> -			if (end_cpu >= INT_MAX || (*p != '\0' && *p != ','))
> -				goto invalid;
> -
> -			if (end_cpu < start_cpu)
> -				goto invalid;
> -		} else {
> -			end_cpu = start_cpu;
> -		}
> -
> -		for (; start_cpu <= end_cpu; start_cpu++) {
> -			/* check for duplicates */
> -			for (i = 0; i < nr_cpus; i++)
> -				if (tmp_cpus[i] == (int)start_cpu)
> -					goto invalid;
> -
> -			if (nr_cpus == max_entries) {
> -				max_entries += MAX_NR_CPUS;
> -				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
> -				if (tmp == NULL)
> -					goto invalid;
> -				tmp_cpus = tmp;
> -			}
> -			tmp_cpus[nr_cpus++] = (int)start_cpu;
> -		}
> -		if (*p)
> -			++p;
> -
> -		cpu_list = p;
> -	}
> -
> -	if (nr_cpus > 0)
> -		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
> -	else if (*cpu_list != '\0')
> -		cpus = cpu_map__default_new();
> -	else
> -		cpus = perf_cpu_map__dummy_new();
> -invalid:
> -	free(tmp_cpus);
> -out:
> -	return cpus;
> -}
> -
>  static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
>  {
>  	struct perf_cpu_map *map;
> @@ -751,7 +572,7 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
>  	static const struct perf_cpu_map *online = NULL;
>  
>  	if (!online)
> -		online = cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
> +		online = perf_cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
>  
>  	return online;
>  }
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index b7af2cb68c19..a3d27f4131be 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -11,10 +11,8 @@
>  #include "perf.h"
>  #include "util/debug.h"
>  
> -struct perf_cpu_map *cpu_map__new(const char *cpu_list);
>  struct perf_cpu_map *cpu_map__empty_new(int nr);
>  struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
> -struct perf_cpu_map *cpu_map__read(FILE *file);
>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 0cd99c460cd4..4f70155eaf83 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -5,6 +5,7 @@
>  #include <stdlib.h>
>  #include <api/fs/fs.h>
>  #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>  
>  #include "cputopo.h"
>  #include "cpumap.h"
> @@ -182,7 +183,7 @@ struct cpu_topology *cpu_topology__new(void)
>  	ncpus = cpu__max_present_cpu();
>  
>  	/* build online CPU map */
> -	map = cpu_map__new(NULL);
> +	map = perf_cpu_map__new(NULL);
>  	if (map == NULL) {
>  		pr_debug("failed to get system cpumap\n");
>  		return NULL;
> @@ -312,7 +313,7 @@ struct numa_topology *numa_topology__new(void)
>  	if (c)
>  		*c = '\0';
>  
> -	node_map = cpu_map__new(buf);
> +	node_map = perf_cpu_map__new(buf);
>  	if (!node_map)
>  		goto out;
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 882f5b396d63..fb5abd08e366 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -34,6 +34,7 @@
>  #include <linux/err.h>
>  #include <linux/zalloc.h>
>  #include <perf/evlist.h>
> +#include <perf/cpumap.h>
>  
>  #ifdef LACKS_SIGQUEUE_PROTOTYPE
>  int sigqueue(pid_t pid, int sig, const union sigval value);
> @@ -1089,7 +1090,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
>  	if (target__uses_dummy_map(target))
>  		cpus = perf_cpu_map__dummy_new();
>  	else
> -		cpus = cpu_map__new(target->cpu_list);
> +		cpus = perf_cpu_map__new(target->cpu_list);
>  
>  	if (!cpus)
>  		goto out_delete_threads;
> @@ -1372,7 +1373,7 @@ static int perf_evlist__create_syswide_maps(struct evlist *evlist)
>  	 * error, and we may not want to do that fallback to a
>  	 * default cpu identity map :-\
>  	 */
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (!cpus)
>  		goto out;
>  
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 8dc3b9947295..4fcf334470ac 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -20,6 +20,7 @@
>  #include <linux/time64.h>
>  #include <dirent.h>
>  #include <bpf/libbpf.h>
> +#include <perf/cpumap.h>
>  
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -2348,7 +2349,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
>  		if (!str)
>  			goto error;
>  
> -		n->map = cpu_map__new(str);
> +		n->map = perf_cpu_map__new(str);
>  		if (!n->map)
>  			goto error;
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index ec7ce18b999a..db2460d6b625 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -24,6 +24,7 @@
>  #include "bpf-loader.h"
>  #include "debug.h"
>  #include <api/fs/tracing_path.h>
> +#include <perf/cpumap.h>
>  #include "parse-events-bison.h"
>  #define YY_EXTRA_TYPE int
>  #include "parse-events-flex.h"
> @@ -323,7 +324,7 @@ __add_event(struct list_head *list, int *idx,
>  {
>  	struct evsel *evsel;
>  	struct perf_cpu_map *cpus = pmu ? pmu->cpus :
> -			       cpu_list ? cpu_map__new(cpu_list) : NULL;
> +			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>  
>  	event_attr_init(attr);
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d355f9506a1c..b7da21a7d627 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -15,6 +15,7 @@
>  #include <api/fs/fs.h>
>  #include <locale.h>
>  #include <regex.h>
> +#include <perf/cpumap.h>
>  #include "pmu.h"
>  #include "parse-events.h"
>  #include "cpumap.h"
> @@ -581,7 +582,7 @@ static struct perf_cpu_map *__pmu_cpumask(const char *path)
>  	if (!file)
>  		return NULL;
>  
> -	cpus = cpu_map__read(file);
> +	cpus = perf_cpu_map__read(file);
>  	fclose(file);
>  	return cpus;
>  }
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 23a4fa13b92d..75ecc32a4427 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -4,6 +4,7 @@
>  #include <inttypes.h>
>  #include <poll.h>
>  #include <linux/err.h>
> +#include <perf/cpumap.h>
>  #include "evlist.h"
>  #include "callchain.h"
>  #include "evsel.h"
> @@ -549,7 +550,7 @@ static int pyrf_cpu_map__init(struct pyrf_cpu_map *pcpus,
>  					 kwlist, &cpustr))
>  		return -1;
>  
> -	pcpus->cpus = cpu_map__new(cpustr);
> +	pcpus->cpus = perf_cpu_map__new(cpustr);
>  	if (pcpus->cpus == NULL)
>  		return -1;
>  	return 0;
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 445788819969..03dcdb3f33a7 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -6,6 +6,7 @@
>  #include <errno.h>
>  #include <api/fs/fs.h>
>  #include <subcmd/parse-options.h>
> +#include <perf/cpumap.h>
>  #include "util.h"
>  #include "cloexec.h"
>  
> @@ -63,7 +64,7 @@ static bool perf_probe_api(setup_probe_fn_t fn)
>  	struct perf_cpu_map *cpus;
>  	int cpu, ret, i = 0;
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (!cpus)
>  		return false;
>  	cpu = cpus->map[0];
> @@ -118,7 +119,7 @@ bool perf_can_record_cpu_wide(void)
>  	struct perf_cpu_map *cpus;
>  	int cpu, fd;
>  
> -	cpus = cpu_map__new(NULL);
> +	cpus = perf_cpu_map__new(NULL);
>  	if (!cpus)
>  		return false;
>  	cpu = cpus->map[0];
> @@ -275,7 +276,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
>  	evsel = perf_evlist__last(temp_evlist);
>  
>  	if (!evlist || cpu_map__empty(evlist->cpus)) {
> -		struct perf_cpu_map *cpus = cpu_map__new(NULL);
> +		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
>  
>  		cpu =  cpus ? cpus->map[0] : 0;
>  		perf_cpu_map__put(cpus);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1f3dc7a8cee6..11e6093c941b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/mman.h>
> +#include <perf/cpumap.h>
>  
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -2289,7 +2290,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
>  		}
>  	}
>  
> -	map = cpu_map__new(cpu_list);
> +	map = perf_cpu_map__new(cpu_list);
>  	if (map == NULL) {
>  		pr_err("Invalid cpu_list\n");
>  		return -1;
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index a9ca5c4fffee..ae6a534a7a80 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
> +#include <perf/cpumap.h>
>  
>  #include "perf.h"
>  #include "svghelper.h"
> @@ -731,7 +732,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
>  	struct perf_cpu_map *m;
>  	int c;
>  
> -	m = cpu_map__new(s);
> +	m = perf_cpu_map__new(s);
>  	if (!m)
>  		return -1;
>  
> -- 
> 2.21.0

-- 

- Arnaldo
