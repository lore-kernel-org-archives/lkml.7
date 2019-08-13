Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2247C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4A520665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHjNqDdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfHMVcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:32:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43118 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfHMVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:32:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id b11so8172233qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ElE9rFnXPounrxWaiYkABSyTfvDdKZ7vkW1SnGNoz8E=;
        b=cHjNqDdpfK4ugSrQC4uB8WirNrYCBF9XUjzxxkAh1ks5v98Ct5SwYz/RrEg3j4nhe3
         dAqHMB5QKMPx0IKv8pvN1hsxGz+qala0xyePtd+25in+/olqvfXk7+/R2VaAVqKvVdsC
         ahtxp86jLILMSJio++3C+xCJip16aPcSnweC6XySi/dD5nAMNCnFGmcVQ1XcamoCc3AR
         4WBTjh8BdLfErJS3FrDWQnf/KrF2ejOA5SY8pEoTmqsIx3vVsdFpLX6XJ7+qpULbIbGJ
         RX4Yrxmwg8RCOOqkQo13Wwt1wwthSpV6eptysTPRCTkYQVfikyLUbFll4/n/pf4RpgR8
         J0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ElE9rFnXPounrxWaiYkABSyTfvDdKZ7vkW1SnGNoz8E=;
        b=T3ocmSSywLc4tD+GGt27TJt3pnWivo0Xt3DU0iwrWCbVl8sQor0TWWJhZEFoHtJO01
         GaQnHu6M0YXWBxlS7a5DiOBlNKGXb4AyEuiwUOrKqXk0lO2/C9s+ZSv0mywwHQ8T1omR
         ewTrxerC+XuawWAwpuB5+TsbhmY08HjsXYp+M53BwUdLC+N1wr5dFBjZdjijrO/fI2jg
         p/Cakzk/K8mJAmSoXbjKjVz+4IRLwUhPrBc1o5mAAClG0+1EIjeXSGdze57rg9zjqHPz
         mVXbxkSj/L6r+S34ozTH0MuRazLczkTxTqPk/vsGjaYldphi0oAjH/ooYqA78zhHtk65
         n2eg==
X-Gm-Message-State: APjAAAVIPLgskT8R/v55Ij3Birv16y4Z31RuaRdqz5CENxo/eFfpFZFO
        WU4M50ygKskMY0XNDMOp8xI=
X-Google-Smtp-Source: APXvYqxFX0+yjvGkxgBpwDd6CjNu2GzeGQAwLdjGKeNwFMM+JTSxMI3fRmyIZ7/ioR6iVXtS9Oua2w==
X-Received: by 2002:ac8:1a86:: with SMTP id x6mr20710930qtj.231.1565731931182;
        Tue, 13 Aug 2019 14:32:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.159.8.214])
        by smtp.gmail.com with ESMTPSA id 136sm8717465qkg.96.2019.08.13.14.32.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:32:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99D0144639; Tue, 13 Aug 2019 18:32:07 -0300 (-03)
Date:   Tue, 13 Aug 2019 18:32:07 -0300
To:     Kyle Meyer <meyerk@hpe.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH 2/2] perf: Replace MAX_NR_CPUS with dynamic alternatives
Message-ID: <20190813213207.GK9280@kernel.org>
References: <20190813210613.99361-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813210613.99361-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 13, 2019 at 04:06:13PM -0500, Kyle Meyer escreveu:
> Both cpu__max_cpu and env.nr_cpus_online are dynamic alternatives for
> MAX_NR_CPUS, a macro currently used throughout perf. The function cpu__max_cpu
> returns the possible number of CPUS as defined in the sysfs, whereas
> env.nr_cpus_online is the number of CPUs that were online during the recording
> session. MAX_NR_CPUS is still used by DECLARE_BITMAP at compile time, however,
> it's replaced elsewhere.
> 
> This patch was tested using "perf record -a -g" on both an eight socket 288 CPU
> system and a single socket 36 CPU system. Each system was then rebooted single
> socket and eight socket before "perf report" was used to read the perf.data out
> file. "perf report --header" was used to confirm that each perf.data file had
> information on the correct number of CPUs.

Can you please further break this into multiple patches,  one for the
svg code, another for the header and so on.

Thanks,

- Arnaldo
 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  tools/perf/util/header.c    |  6 +++---
>  tools/perf/util/machine.c   | 11 ++++++-----
>  tools/perf/util/session.c   |  6 +++---
>  tools/perf/util/stat.c      |  4 ++--
>  tools/perf/util/svghelper.c | 31 +++++++++++++++----------------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index b04c2b6b28b3..cf8ce839cb47 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1121,16 +1121,16 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
>  	return 0;
>  }
>  
> -#define MAX_CACHES (MAX_NR_CPUS * 4)
> +#define MAX_CACHE_LVL 4
>  
>  static int write_cache(struct feat_fd *ff,
>  		       struct evlist *evlist __maybe_unused)
>  {
> -	struct cpu_cache_level caches[MAX_CACHES];
> +	struct cpu_cache_level caches[(cpu__max_cpu() * MAX_CACHE_LVL)];
>  	u32 cnt = 0, i, version = 1;
>  	int ret;
>  
> -	ret = build_caches(caches, MAX_CACHES, &cnt);
> +	ret = build_caches(caches, (cpu__max_cpu() * MAX_CACHE_LVL), &cnt);
>  	if (ret)
>  		goto out;
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5734460fc89e..cf5f4b4eeea0 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2616,7 +2616,8 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
>  
>  pid_t machine__get_current_tid(struct machine *machine, int cpu)
>  {
> -	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
> +	int nr_cpus_online = machine->env->nr_cpus_online;
> +	if (cpu < 0 || cpu >= nr_cpus_online || !machine->current_tid)
>  		return -1;
>  
>  	return machine->current_tid[cpu];
> @@ -2626,6 +2627,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  			     pid_t tid)
>  {
>  	struct thread *thread;
> +	int nr_cpus_online = machine->env->nr_cpus_online;
>  
>  	if (cpu < 0)
>  		return -EINVAL;
> @@ -2633,16 +2635,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>  	if (!machine->current_tid) {
>  		int i;
>  
> -		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
> +		machine->current_tid = calloc(nr_cpus_online, sizeof(pid_t));
>  		if (!machine->current_tid)
>  			return -ENOMEM;
> -		for (i = 0; i < MAX_NR_CPUS; i++)
> +		for (i = 0; i < nr_cpus_online; i++)
>  			machine->current_tid[i] = -1;
>  	}
>  
> -	if (cpu >= MAX_NR_CPUS) {
> +	if (cpu >= nr_cpus_online) {
>  		pr_err("Requested CPU %d too large. ", cpu);
> -		pr_err("Consider raising MAX_NR_CPUS\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 11e6093c941b..a9d244a94e24 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2275,6 +2275,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
>  {
>  	int i, err = -1;
>  	struct perf_cpu_map *map;
> +	int nr_cpus_online = session->header.env.nr_cpus_online;
>  
>  	for (i = 0; i < PERF_TYPE_MAX; ++i) {
>  		struct evsel *evsel;
> @@ -2299,9 +2300,8 @@ int perf_session__cpu_bitmap(struct perf_session *session,
>  	for (i = 0; i < map->nr; i++) {
>  		int cpu = map->map[i];
>  
> -		if (cpu >= MAX_NR_CPUS) {
> -			pr_err("Requested CPU %d too large. "
> -			       "Consider raising MAX_NR_CPUS\n", cpu);
> +		if (cpu >= nr_cpus_online) {
> +			pr_err("Requested CPU %d too large\n", cpu);
>  			goto out_delete_map;
>  		}
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index e4e4e3bf8b2b..199008ce936d 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -208,7 +208,7 @@ void perf_evlist__reset_stats(struct evlist *evlist)
>  static void zero_per_pkg(struct evsel *counter)
>  {
>  	if (counter->per_pkg_mask)
> -		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
> +		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
>  }
>  
>  static int check_per_pkg(struct evsel *counter,
> @@ -227,7 +227,7 @@ static int check_per_pkg(struct evsel *counter,
>  		return 0;
>  
>  	if (!mask) {
> -		mask = zalloc(MAX_NR_CPUS);
> +		mask = zalloc(cpu__max_cpu());
>  		if (!mask)
>  			return -ENOMEM;
>  
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 1beeb7291361..6e8433e97f21 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -695,7 +695,8 @@ struct topology {
>  	int sib_thr_nr;
>  };
>  
> -static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos)
> +static void scan_thread_topology(int *map, struct topology *t, int cpu,
> +int *pos, int max_cpus)
>  {
>  	int i;
>  	int thr;
> @@ -704,28 +705,24 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
>  		if (!test_bit(cpu, cpumask_bits(&t->sib_thr[i])))
>  			continue;
>  
> -		for_each_set_bit(thr,
> -				 cpumask_bits(&t->sib_thr[i]),
> -				 MAX_NR_CPUS)
> +		for_each_set_bit(thr, cpumask_bits(&t->sib_thr[i]), max_cpus)
>  			if (map[thr] == -1)
>  				map[thr] = (*pos)++;
>  	}
>  }
>  
> -static void scan_core_topology(int *map, struct topology *t)
> +static void scan_core_topology(int *map, struct topology *t, int max_cpus)
>  {
>  	int pos = 0;
>  	int i;
>  	int cpu;
>  
>  	for (i = 0; i < t->sib_core_nr; i++)
> -		for_each_set_bit(cpu,
> -				 cpumask_bits(&t->sib_core[i]),
> -				 MAX_NR_CPUS)
> -			scan_thread_topology(map, t, cpu, &pos);
> +		for_each_set_bit(cpu, cpumask_bits(&t->sib_core[i]), max_cpus)
> +			scan_thread_topology(map, t, cpu, &pos, max_cpus);
>  }
>  
> -static int str_to_bitmap(char *s, cpumask_t *b)
> +static int str_to_bitmap(char *s, cpumask_t *b, int max_cpus)
>  {
>  	int i;
>  	int ret = 0;
> @@ -738,7 +735,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
>  
>  	for (i = 0; i < m->nr; i++) {
>  		c = m->map[i];
> -		if (c >= MAX_NR_CPUS) {
> +		if (c >= max_cpus) {
>  			ret = -1;
>  			break;
>  		}
> @@ -767,7 +764,8 @@ int svg_build_topology_map(struct perf_env *env)
>  	}
>  
>  	for (i = 0; i < env->nr_sibling_cores; i++) {
> -		if (str_to_bitmap(env->sibling_cores, &t.sib_core[i])) {
> +		if (str_to_bitmap(env->sibling_cores, &t.sib_core[i],
> +			env->nr_cpus_online)) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
>  			goto exit;
>  		}
> @@ -776,7 +774,8 @@ int svg_build_topology_map(struct perf_env *env)
>  	}
>  
>  	for (i = 0; i < env->nr_sibling_threads; i++) {
> -		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i])) {
> +		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i],
> +			env->nr_cpus_online)) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
>  			goto exit;
>  		}
> @@ -784,16 +783,16 @@ int svg_build_topology_map(struct perf_env *env)
>  		env->sibling_threads += strlen(env->sibling_threads) + 1;
>  	}
>  
> -	topology_map = malloc(sizeof(int) * MAX_NR_CPUS);
> +	topology_map = malloc(sizeof(int) * env->nr_cpus_online);
>  	if (!topology_map) {
>  		fprintf(stderr, "topology: no memory\n");
>  		goto exit;
>  	}
>  
> -	for (i = 0; i < MAX_NR_CPUS; i++)
> +	for (i = 0; i < env->nr_cpus_online; i++)
>  		topology_map[i] = -1;
>  
> -	scan_core_topology(topology_map, &t);
> +	scan_core_topology(topology_map, &t, env->nr_cpus_online);
>  
>  	return 0;
>  
> -- 
> 2.12.3

-- 

- Arnaldo
