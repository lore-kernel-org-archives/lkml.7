Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB91820665
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfHEIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfHEIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:17:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47894B2DF5;
        Mon,  5 Aug 2019 08:17:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 702DF5D9C0;
        Mon,  5 Aug 2019 08:17:38 +0000 (UTC)
Date:   Mon, 5 Aug 2019 10:17:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Replace MAX_NR_CPUS with nr_cpus_onln
Message-ID: <20190805081737.GB7695@krava>
References: <20190802201642.124164-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802201642.124164-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 05 Aug 2019 08:17:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:16:42PM -0500, Kyle Meyer wrote:
> The variables nr_cpus_onln and max_caches are dynamic alternatives for
> MAX_NR_CPUS and MAX_CACHES as they are initialized at runtime. MAX_NR_CPUS
> is still used by DECLARE_BITMAP() at compile time, however, nr_cpus_onln
> replaces it elsewhere throughout perf.
> 
> This patch was tested using "perf record -a -g" on both an eight socket
> (288 CPUs) system and a single socket (36 CPUs) system. Each system was then
> rebooted single socket (36 CPUs) / eight socket (288 CPUs) and "perf
> report" used to read the perf.data file. "perf report --header" was used to
> confirm that each perf.data had information on 288 CPUs / 36 CPUs.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/lib/cpumap.c     |  6 +++---
>  tools/perf/perf.c           | 10 ++++++++++
>  tools/perf/perf.h           |  1 +
>  tools/perf/util/header.c    |  7 +++----
>  tools/perf/util/machine.c   | 11 +++++------
>  tools/perf/util/stat.c      |  4 ++--
>  tools/perf/util/svghelper.c | 10 +++++-----
>  7 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index 1ddb69e796e5..327a37c68e73 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -101,7 +101,7 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
>  			int new_max = nr_cpus + cpu - prev - 1;
>  
>  			if (new_max >= max_entries) {
> -				max_entries = new_max + MAX_NR_CPUS / 2;
> +				max_entries = new_max + nr_cpus_onln / 2;
>  				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
>  				if (tmp == NULL)
>  					goto out_free_tmp;
> @@ -112,7 +112,7 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
>  				tmp_cpus[nr_cpus++] = prev;
>  		}
>  		if (nr_cpus == max_entries) {
> -			max_entries += MAX_NR_CPUS;
> +			max_entries += nr_cpus_onln;
>  			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
>  			if (tmp == NULL)
>  				goto out_free_tmp;
> @@ -199,7 +199,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  					goto invalid;
>  
>  			if (nr_cpus == max_entries) {
> -				max_entries += MAX_NR_CPUS;
> +				max_entries += nr_cpus_onln;
>  				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
>  				if (tmp == NULL)
>  					goto invalid;

hi,
now we need to take care about the library,
that reminds me to add automaketed compile
test for this:

	[jolsa@krava perf]$ make -C lib
	make: Entering directory '/home/jolsa/kernel/linux-perf/tools/perf/lib'
	  CC       cpumap.o
	cpumap.c: In function ‘perf_cpu_map__read’:
	cpumap.c:104:29: error: ‘nr_cpus_onln’ undeclared (first use in this function)
	  104 |     max_entries = new_max + nr_cpus_onln / 2;
	      |                             ^~~~~~~~~~~~
	cpumap.c:104:29: note: each undeclared identifier is reported only once for each function it appears in
	cpumap.c: In function ‘perf_cpu_map__new’:
	cpumap.c:202:20: error: ‘nr_cpus_onln’ undeclared (first use in this function)
	  202 |     max_entries += nr_cpus_onln;
	      |                    ^~~~~~~~~~~~
	mv: cannot stat './.cpumap.o.tmp': No such file or directory
	make[2]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: cpumap.o] Error 1
	make[1]: *** [Makefile:92: libperf-in.o] Error 2
	make: *** [Makefile:107: all] Error 2
	make: Leaving directory '/home/jolsa/kernel/linux-perf/tools/perf/lib'


> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 97e2628ea5dd..658bf8501bb0 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -428,6 +428,16 @@ int main(int argc, const char **argv)
>  	const char *cmd;
>  	char sbuf[STRERR_BUFSIZE];
>  
> +	nr_cpus_onln = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (nr_cpus_onln < 0) {
> +		fprintf(stderr, "Cannot determine the number of CPUs currently online.\n");
> +		goto out;
> +	}
> +	if (nr_cpus_onln > MAX_NR_CPUS) {
> +		fprintf(stderr, "The number of CPUs currently online is too large, consider raising MAX_NR_CPUS.\n");
> +		nr_cpus_onln = MAX_NR_CPUS;
> +	}

so how about if cpu is added during the record session,
should we rather use 'possible' cpus, like in cpu__max_cpu?

also we could move cpu__max_cpu we could to libperf
so the library code would still work

> +	
>  	/* libsubcmd init */
>  	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
>  	pager_init(PERF_PAGER_ENVIRONMENT);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 74d0124d38f3..603391cac85b 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -29,6 +29,7 @@ static inline unsigned long long rdclock(void)
>  #define MAX_NR_CPUS			2048
>  #endif
>  
> +int nr_cpus_onln;
>  extern const char *input_name;
>  extern bool perf_host, perf_guest;
>  extern const char perf_version_string[];
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b04c2b6b28b3..7983d268eec1 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1121,16 +1121,15 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
>  	return 0;
>  }
>  
> -#define MAX_CACHES (MAX_NR_CPUS * 4)
> -
>  static int write_cache(struct feat_fd *ff,
>  		       struct evlist *evlist __maybe_unused)
>  {
> -	struct cpu_cache_level caches[MAX_CACHES];
> +	u32 max_caches = (nr_cpus_online * 4);
> +	struct cpu_cache_level caches[max_caches]
>  	u32 cnt = 0, i, version = 1;
>  	int ret;
>  
> -	ret = build_caches(caches, MAX_CACHES, &cnt);
> +	ret = build_caches(caches, max_caches, &cnt);
>  	if (ret)
>  		goto out;
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f6ee7fbad3e4..3ad77d5e8aab 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2615,7 +2615,7 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
>  
>  pid_t machine__get_current_tid(struct machine *machine, int cpu)
>  {
> -	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
> +	if (cpu < 0 || cpu >= nr_cpus_onln || !machine->current_tid)
>  		return -1;
>  

as I said earlier the problem here might be that you change
report path, that needs to check on either MAX_NR_CPUS,
(as it currently does) or the number of cpus of the server
where was perf.data recorded.. which is not necessarily
the one you are running report on..

the cpu info is in perf_session::header::env

machine__get_current_tid is used from intel_pt and
perf_session is part of 'struct intel_pt *pt' caller
argument, so it needs to be passed in here

ale the other changes needs to be check in the same way

thanks,
jirka

>  	return machine->current_tid[cpu];
> @@ -2632,16 +2632,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  	if (!machine->current_tid) {
>  		int i;
>  
> -		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
> +		machine->current_tid = calloc(nr_cpus_onln, sizeof(pid_t));
>  		if (!machine->current_tid)
>  			return -ENOMEM;
> -		for (i = 0; i < MAX_NR_CPUS; i++)
> +		for (i = 0; i < nr_cpus_onln; i++)
>  			machine->current_tid[i] = -1;
>  	}
>  
> -	if (cpu >= MAX_NR_CPUS) {
> -		pr_err("Requested CPU %d too large. ", cpu);
> -		pr_err("Consider raising MAX_NR_CPUS\n");
> +	if (cpu >= nr_cpus_onln) {
> +		pr_err("Requested CPU %d too large, there are %d CPUs currently online.\n", cpu, nr_cpus_onln);
>  		return -EINVAL;
>  	}
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index e4e4e3bf8b2b..42dddbd2f23c 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -208,7 +208,7 @@ void perf_evlist__reset_stats(struct evlist *evlist)
>  static void zero_per_pkg(struct evsel *counter)
>  {
>  	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
> +		memset(counter->per_pkg_mask, 0, nr_cpus_onln);
>  }
>  
>  static int check_per_pkg(struct evsel *counter,
> @@ -227,7 +227,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(MAX_NR_CPUS);
> +		mask = zalloc(nr_cpus_onln);
>  		if (!mask)
>  			return -ENOMEM;
>  
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index ae6a534a7a80..0404bd87812a 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -706,7 +706,7 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
>  
>  		for_each_set_bit(thr,
>  				 cpumask_bits(&t->sib_thr[i]),
> -				 MAX_NR_CPUS)
> +				 nr_cpus_onln)
>  			if (map[thr] == -1)
>  				map[thr] = (*pos)++;
>  	}
> @@ -721,7 +721,7 @@ static void scan_core_topology(int *map, struct topology *t)
>  	for (i = 0; i < t->sib_core_nr; i++)
>  		for_each_set_bit(cpu,
>  				 cpumask_bits(&t->sib_core[i]),
> -				 MAX_NR_CPUS)
> +				 nr_cpus_onln)
>  			scan_thread_topology(map, t, cpu, &pos);
>  }
>  
> @@ -738,7 +738,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
>  
>  	for (i = 0; i < m->nr; i++) {
>  		c = m->map[i];
> -		if (c >= MAX_NR_CPUS) {
> +		if (c >= nr_cpus_onln) {
>  			ret = -1;
>  			break;
>  		}
> @@ -785,13 +785,13 @@ int svg_build_topology_map(char *sib_core, int sib_core_nr,
>  		sib_thr += strlen(sib_thr) + 1;
>  	}
>  
> -	topology_map = malloc(sizeof(int) * MAX_NR_CPUS);
> +	topology_map = malloc(sizeof(int) * nr_cpus_onln);
>  	if (!topology_map) {
>  		fprintf(stderr, "topology: no memory\n");
>  		goto exit;
>  	}
>  
> -	for (i = 0; i < MAX_NR_CPUS; i++)
> +	for (i = 0; i < nr_cpus_onln; i++)
>  		topology_map[i] = -1;
>  
>  	scan_core_topology(topology_map, &t);
> -- 
> 2.12.3
> 
