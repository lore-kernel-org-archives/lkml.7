Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D31A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS+/wi/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfCOOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:35:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43610 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfCOOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:35:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so10274297qtc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D5xmUunrhiMu6OMLwAS1BC35Jk6ZJGGiZxIAuGXzco8=;
        b=kS+/wi/MIjKH1PmLikzL8O82v/0h2TBUi7lcXNrb9nQUizqctM1rtrlXQHTnvMZbFl
         dXaVIbDobj9kklcXHYNryU0apHyElI17szwGql9oFC3BzxmFrkcIgnseBubcmY6GcGnx
         tp8EzMTmNXWcBZN1OD/kbabE3jLRtrn48hDslw1eT0KMJBPfXAyt4gvv+h+gVb3CTDiB
         /BmQTQc0IbMjmVWmpOyDHDjtKNHiNpu31vQwr8SD9Ts9s0tqWrvE8DcNVIrj9imm6eE0
         srIai/gf8zX/MZivCtiqINoJrEmOYYO3L/dBOSogJ62TLta1JTyRE7w0rTo1ujum85Fe
         DznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D5xmUunrhiMu6OMLwAS1BC35Jk6ZJGGiZxIAuGXzco8=;
        b=V/OXsfbZWH/YiZh5L0jEph4dCY/IQwVwc9m+xcKnrWh85YQNgpsh98bQGoPeqxJsR6
         XvBhBmMr/W3b+CPaNNYO2fRWveWamGud/O/2QCC9SWJDp6GgbtcX3+cofFJBhq1jnxYj
         fV/A48WKD7YUMQSHVHKK5NKIGig/rJeyuu8pA27G7ssRgbfUg+aPMxM45PlyB8ibu/A3
         sWW7MNEnqpLtS/kHYWExVE1rg8bFCd2V2yE7ZWI6yZKn3VrvMt7gDOTUazB3+JwLDLZ+
         r0hwwrGhYHR+LYn2x067bS+pok4eiK3OWmimY7WgvdxGVx+MwbI8m8frbqWvFkrYeZ2q
         +bkg==
X-Gm-Message-State: APjAAAVDcbt73jolD4rlFFKg5+8aG4iId8TVHsECMb1atXD0cZ5vpM7s
        /VyJBfOcKpjPnULVHIxHpzzZKQyS
X-Google-Smtp-Source: APXvYqxaAm92rP0jPUOnzJ7sMbSCuVJEGwGYdU1gNSyPjJbQr57m1F/ylUXdW9cJOeEziUsP5DP/Dg==
X-Received: by 2002:a0c:ae64:: with SMTP id z33mr2843544qvc.210.1552660511008;
        Fri, 15 Mar 2019 07:35:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-202-11.3g.claro.net.br. [187.26.202.11])
        by smtp.gmail.com with ESMTPSA id e2sm1425843qkd.7.2019.03.15.07.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 07:35:09 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B34F4039C; Fri, 15 Mar 2019 11:35:04 -0300 (-03)
Date:   Fri, 15 Mar 2019 11:35:04 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf tools: Move precise_ip detection into
 perf_evsel__open
Message-ID: <20190315143504.GA24482@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
 <20190307153500.GC29474@krava>
 <20190307165123.GE7535@tassilo.jf.intel.com>
 <20190314140124.GE4406@krava>
 <20190314154911.GE24002@tassilo.jf.intel.com>
 <20190315121546.GB1400@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315121546.GB1400@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 15, 2019 at 01:15:46PM +0100, Jiri Olsa escreveu:
> On Thu, Mar 14, 2019 at 08:49:11AM -0700, Andi Kleen wrote:
> > > > Still seems like a hack. Even though I don't know of a case that
> > > > would break now. But it would be better to have the precise probing
> > > > in the open retry loop, instead of trying to reinvent it here.
> > > 
> > > how about something like below?
> > 
> > Yes looks reasonable.
> 
> full patch attached,
> 
> jirka
> 
> 
> ---
> After discussion with Andi, moving the precise_ip detection
> for maximum precise config (via :P modifier or for default
> cycles event) into perf_evsel__open code.
> 
> The current detection code in perf_event_attr__set_max_precise_ip
> function is tricky, because precise_ip config is specific for
> given event and it currently checks only hw cycles.
> 
> We now check for valid precise_ip value right after failing
> sys_perf_event_open for specific event, before any of the
> perf_event_attr fallback code gets executed. This way we get
> the proper config in perf_event_attr together with allowed
> precise_ip settings.
> 
> We can see that code activity with -vv, like:
> 
>   $ perf record -vv ls
>   ...
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             112
>     { sample_period, sample_freq }   4000
>     ...
>     precise_ip                       3
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -95
>   decreasing precise_ip by one (2)
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             112
>     { sample_period, sample_freq }   4000
>     ...
>     precise_ip                       2
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8 = 4
>   ...
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Link: http://lkml.kernel.org/n/tip-dkvxxbeg7lu74155d4jhlmc9@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evlist.c | 29 ----------------
>  tools/perf/util/evlist.h |  2 --
>  tools/perf/util/evsel.c  | 72 ++++++++++++++++++++++++++++++++--------
>  3 files changed, 59 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index ed20f4379956..3a243c249c29 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -230,35 +230,6 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
>  	}
>  }
>  
> -void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
> -{
> -	struct perf_event_attr attr = {
> -		.type		= PERF_TYPE_HARDWARE,
> -		.config		= PERF_COUNT_HW_CPU_CYCLES,
> -		.exclude_kernel	= 1,
> -		.precise_ip	= 3,
> -	};
> -
> -	event_attr_init(&attr);
> -
> -	/*
> -	 * Unnamed union member, not supported as struct member named
> -	 * initializer in older compilers such as gcc 4.4.7
> -	 */
> -	attr.sample_period = 1;
> -
> -	while (attr.precise_ip != 0) {
> -		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> -		if (fd != -1) {
> -			close(fd);
> -			break;
> -		}
> -		--attr.precise_ip;
> -	}
> -
> -	pattr->precise_ip = attr.precise_ip;
> -}
> -
>  int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
>  {
>  	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 744906dd4887..cb15e3366eba 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -303,8 +303,6 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
>  void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
>  				     struct perf_evsel *tracking_evsel);
>  
> -void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr);
> -
>  struct perf_evsel *
>  perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3bbf73e979c0..f606e8a81f0e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -295,7 +295,6 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
>  	if (!precise)
>  		goto new_event;
>  
> -	perf_event_attr__set_max_precise_ip(&attr);
>  	/*
>  	 * Now let the usual logic to set up the perf_event_attr defaults
>  	 * to kick in when we return and before perf_evsel__open() is called.
> @@ -305,6 +304,8 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
>  	if (evsel == NULL)
>  		goto out;
>  
> +	evsel->precise_max = true;
> +
>  	/* use asprintf() because free(evsel) assumes name is allocated */
>  	if (asprintf(&evsel->name, "cycles%s%s%.*s",
>  		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
> @@ -1083,7 +1084,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	if (evsel->precise_max)
> -		perf_event_attr__set_max_precise_ip(attr);
> +		attr->precise_ip = 3;
>  
>  	if (opts->all_user) {
>  		attr->exclude_kernel = 1;
> @@ -1749,6 +1750,59 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
>  	return true;
>  }
>  
> +static void display_attr(struct perf_event_attr *attr)
> +{
> +	if (verbose >= 2) {
> +		fprintf(stderr, "%.60s\n", graph_dotted_line);
> +		fprintf(stderr, "perf_event_attr:\n");
> +		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
> +		fprintf(stderr, "%.60s\n", graph_dotted_line);
> +	}
> +}
> +
> +static int perf_event_open(struct perf_evsel *evsel,
> +			   pid_t pid, int cpu, int group_fd,
> +			   unsigned long flags)


The patch is ok, but I think the naming of this function is too generic,
so I'm renaming it to:

static int perf_evsel__open_adjust_precise_ip(struct perf_evsel *evsel,
					      pid_t pid, int cpu, int group_fd,
					      unsigned long flags)

Ok?

The perf_evsel__open() code is already complex with that fallback
mechanism, this is just one more way of fallbacking when asking the
kernel for something that may fail.

In fact what happens if the precise_ip that is being asked _is_
supported but sys_perf_event_open() fails because some other
perf_event_attr attribute that is set is not supported? 

I see, it gets it back restored to what the user asked so that the
standard fallback is tried, ok, I'll apply with just the rename for this
function,

Thanks,

- Arnaldo

> +{
> +	int precise_ip = evsel->attr.precise_ip;
> +	int fd;
> +
> +	while (1) {
> +		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> +			  pid, cpu, group_fd, flags);
> +
> +		fd = sys_perf_event_open(&evsel->attr, pid, cpu, group_fd, flags);
> +		if (fd >= 0)
> +			break;
> +
> +		/*
> +		 * Do quick precise_ip fallback if:
> +		 *  - there is precise_ip set in perf_event_attr
> +		 *  - maximum precise is requested
> +		 *  - sys_perf_event_open failed with ENOTSUP error,
> +		 *    which is associated with wrong precise_ip
> +		 */
> +		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
> +			break;
> +
> +		/*
> +		 * We tried all the precise_ip values, and it's
> +		 * still failing, so leave it to standard fallback.
> +		 */
> +		if (!evsel->attr.precise_ip) {
> +			evsel->attr.precise_ip = precise_ip;
> +			break;
> +		}
> +
> +		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
> +		evsel->attr.precise_ip--;
> +		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->attr.precise_ip);
> +		display_attr(&evsel->attr);
> +	}
> +
> +	return fd;
> +}
> +
>  int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  		     struct thread_map *threads)
>  {
> @@ -1824,12 +1878,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  	if (perf_missing_features.sample_id_all)
>  		evsel->attr.sample_id_all = 0;
>  
> -	if (verbose >= 2) {
> -		fprintf(stderr, "%.60s\n", graph_dotted_line);
> -		fprintf(stderr, "perf_event_attr:\n");
> -		perf_event_attr__fprintf(stderr, &evsel->attr, __open_attr__fprintf, NULL);
> -		fprintf(stderr, "%.60s\n", graph_dotted_line);
> -	}
> +	display_attr(&evsel->attr);
>  
>  	for (cpu = 0; cpu < cpus->nr; cpu++) {
>  
> @@ -1841,13 +1890,10 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
>  
>  			group_fd = get_group_fd(evsel, cpu, thread);
>  retry_open:
> -			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> -				  pid, cpus->map[cpu], group_fd, flags);
> -
>  			test_attr__ready();
>  
> -			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
> -						 group_fd, flags);
> +			fd = perf_event_open(evsel, pid, cpus->map[cpu],
> +					     group_fd, flags);
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> -- 
> 2.17.2

-- 

- Arnaldo
